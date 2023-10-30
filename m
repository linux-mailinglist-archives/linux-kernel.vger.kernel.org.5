Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E097DBCE3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjJ3Pt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjJ3Pt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:49:26 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6970BF4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 08:49:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54357417e81so4269a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 08:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698680960; x=1699285760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkWEvSpj4EOzW1FIq48dR5K6zMnw3n6lBUOqN6Xvf9E=;
        b=nghZKH6b+lS1Z/EVQwhZix/byx/bJu0xcffRkCRaH4PS5oTTjZEixMhrDfleD9/iPX
         9we+bOgD8C3gPZ9m7ApXONgBa0ZSfZSCFcqx8tXYxTVq2gwCrcFCi3Xezqee6bqISoUO
         66Jb/7nKcdSkbm6vtRuCw9uFeEubg2j983J6jH8UwXNbIhAr+kadSsSz9hYXRUG42Es8
         dhWhEekCTaAFdkXeVSrOF0UX78VvXt1HUXhIUP7bgRv6MlGdtVo4BSQlMurJE40NNPfs
         ZukJzHa+5E+wu7xCt5rKXi92NczazCtzyOQDfSWbFsbHrgG5++cUKPAKg1VXh1dTYoCN
         j9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698680960; x=1699285760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkWEvSpj4EOzW1FIq48dR5K6zMnw3n6lBUOqN6Xvf9E=;
        b=h8hQmP/4ZaQyFbLSdaIMJx5oeAjPd7Y+vwE7G2KoSZxplbf0Wm7L6V12OXA9iHla/j
         SqpjBKTBVLqUIfqmGBUkjAf7ODqqcH//eAPlNwThCqJBXi46bXggffIX6g5BnkKzUYFX
         GLzriMiUmXeblE7r0JcOcc5482Z/ewHtOjFuYChgvpIHMWXdrtM6SOP+2tGZ4w5qDPRb
         6wQxyYXsVXKtBpUHhy0RmYKQjZEoPFs8B8bI7ZJuBgoFK2bKGSAewJMVoWZAfTJclaXD
         HZyS+hbbZ3cwByk9D/7Qw5Ye6WfuOahot5Rjmo5Q7CpoYIAipRzpm1pwTjS/Wy0Xilhy
         5wcA==
X-Gm-Message-State: AOJu0YxtmF+Ihz/qzT+Z8r7+VJ1zDFQZkwciBA+hWGbjbJjNp2CKQwe9
        IHc+vHBasy+pjzOhUlZ3g7E5MtzxB9MtzFa8QcMRWA==
X-Google-Smtp-Source: AGHT+IHmnsYDLOCh0X2FX2ePeYR5kt25POJ/6EJ5OuyPzDSCNjm9Kly3q4T57cyTmD//emtw3QSiA7mgey1mzsGEqjw=
X-Received: by 2002:a50:baee:0:b0:540:e63d:3cfb with SMTP id
 x101-20020a50baee000000b00540e63d3cfbmr130594ede.3.1698680960030; Mon, 30 Oct
 2023 08:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231028144136.3462-1-bragathemanick0908@gmail.com>
 <CANn89iJyLWy6WEa_1p+jKpGBfq=h=TX=_7p_-_i4j6mHcMXbgA@mail.gmail.com> <e38353e7-ea99-434b-9700-151ab2de6f85@gmail.com>
In-Reply-To: <e38353e7-ea99-434b-9700-151ab2de6f85@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 30 Oct 2023 16:49:06 +0100
Message-ID: <CANn89iKPTdE+oAB30gp4koC7ddnga20R8H6V3qismvvEP80aqg@mail.gmail.com>
Subject: Re: [PATCH net] dccp: check for ccid in ccid_hc_tx_send_packet
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        dccp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 4:40=E2=80=AFPM Bragatheswaran Manickavel
<bragathemanick0908@gmail.com> wrote:
>
>
> On 30/10/23 14:29, Eric Dumazet wrote:
> > On Sat, Oct 28, 2023 at 4:41=E2=80=AFPM Bragatheswaran Manickavel
> > <bragathemanick0908@gmail.com> wrote:
> >> ccid_hc_tx_send_packet might be called with a NULL ccid pointer
> >> leading to a NULL pointer dereference
> >>
> >> Below mentioned commit has similarly changes
> >> commit 276bdb82dedb ("dccp: check ccid before dereferencing")
> >>
> >> Reported-by: syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com
> >> Closes: https://syzkaller.appspot.com/bug?extid=3Dc71bc336c5061153b502
> >> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com=
>
> >> ---
> >>   net/dccp/ccid.h | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/net/dccp/ccid.h b/net/dccp/ccid.h
> >> index 105f3734dadb..1015dc2b9392 100644
> >> --- a/net/dccp/ccid.h
> >> +++ b/net/dccp/ccid.h
> >> @@ -163,7 +163,7 @@ static inline int ccid_packet_dequeue_eval(const i=
nt return_code)
> >>   static inline int ccid_hc_tx_send_packet(struct ccid *ccid, struct s=
ock *sk,
> >>                                           struct sk_buff *skb)
> >>   {
> >> -       if (ccid->ccid_ops->ccid_hc_tx_send_packet !=3D NULL)
> >> +       if (ccid !=3D NULL && ccid->ccid_ops->ccid_hc_tx_send_packet !=
=3D NULL)
> >>                  return ccid->ccid_ops->ccid_hc_tx_send_packet(sk, skb=
);
> >>          return CCID_PACKET_SEND_AT_ONCE;
> >>   }
> >> --
> >> 2.34.1
> >>
> > If you are willing to fix dccp, I would make sure that some of
> > lockless accesses to dccps_hc_tx_ccid
> > are also double checked and fixed.
> >
> > do_dccp_getsockopt() and dccp_get_info()
>
>
> Hi Eric,
>
> In both do_dccp_getsockopt() and dccp_get_info(), dccps_hc_rx_ccid are
> checked properly before access.
>

Not really, because another thread can change the value at the same time.

Adding checks is not solving races.
