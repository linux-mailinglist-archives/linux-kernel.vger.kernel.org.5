Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2937C5A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjJKRnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjJKRnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:43:39 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9DA98
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 10:43:37 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4053f24c900so4815e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 10:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697046215; x=1697651015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POLgW7vGVBgqnLcSHIyA8aTEXOElLRzKVX3eHJN8DXY=;
        b=hAmpXNdSaz28lqnQBkFSzH9ecccjTCq/JLqZhohzTZj7fWZ/bPX9wJpX2GK7HHntGR
         eejisLJc8MMvZjnXo2LpxQ2tvQLdS3kf4fyEUyW+KKTJpn8X4FRMTqfXL5NEVElx1bjW
         wYMlzZGg2ds4Q7h+eS/2luofulgFVkkraX2QRrNC9NgM/p3YPBSg2ZkvAl2kXfk5eufD
         q9kd/7SXV47ODXYfkZ6TBJbcMnWB56kuZamBk3NSHIo+ZOHYIcJVzYKSS39MP+hjIrUe
         6/5Cns/yEhdWfGI1WuRvHE8Kn4cxVxD71h/c+0NtEtoSkXXzo9bE3YXSofAW38rBDCuu
         DahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697046215; x=1697651015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POLgW7vGVBgqnLcSHIyA8aTEXOElLRzKVX3eHJN8DXY=;
        b=onFLhJNV0BDHgHlHT2+8x5xWPZVGZyd9cvFBKWceOTBSN8zUsjgNMi8wIjOktDf9kC
         oJ7Fsur6kGR0ckkly6exM+dwP4F2GW7n99KePDQoh0CGH0NRKbhQf+X7+9j1uiAFSV3y
         PcFVh+RevP2Z5ZJ5LmXDftyu1wkd7VFp+Ih2MvzO0v1zbBkpPv0TQhyz7rQgS/AGi0Pe
         Q2UayO/wkENYumEPehyYhdjklfXO16lOyTh+Sx2gFaWnGPzw/914XOrwKeRxhsDqIXO4
         pVr7jW5QUL3wItL5o9dG6729iJmdeKAk63AGYNVPHbV7McRDEsdNmpiGD14CCZPV+u3P
         XpBg==
X-Gm-Message-State: AOJu0Yzi2LwtI3ELJZqvyDp6m5d95PeyoUjC5TR5HJOpLrac1HM84qYz
        P3gSrR+BgEY0FOLqCB+itATz3Qsv1NkzC9SZYQiq2A==
X-Google-Smtp-Source: AGHT+IEF+mY6rg7imO16vhwcTa8BR4dYmyLxq+Ihn7VM5Sbft/PIxucsoX8vk+dLEu1yk5jdvUp9xRh+Tk2qO8x2Iuw=
X-Received: by 2002:a05:600c:4f81:b0:405:38d1:e146 with SMTP id
 n1-20020a05600c4f8100b0040538d1e146mr149083wmq.4.1697046215172; Wed, 11 Oct
 2023 10:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231010224630.238254-1-singhabhinav9051571833@gmail.com>
 <2023101136-irritate-shrine-cde6@gregkh> <3073e9a6-9f10-4326-9734-7e203d509888@gmail.com>
In-Reply-To: <3073e9a6-9f10-4326-9734-7e203d509888@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 11 Oct 2023 19:43:20 +0200
Message-ID: <CANn89i+hMbhLqXKCF2P=HVeeRSCxvgH_xY1b=T=udLFJjG3ZwA@mail.gmail.com>
Subject: Re: [PATCH] Remove extra unlock for the mutex
To:     Abhinav Singh <singhabhinav9051571833@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, davem@davemloft.net,
        dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 5:50=E2=80=AFPM Abhinav Singh
<singhabhinav9051571833@gmail.com> wrote:
>
> On 10/11/23 12:00, Greg KH wrote:
> > On Wed, Oct 11, 2023 at 04:16:30AM +0530, Abhinav Singh wrote:
> >> There is a double unlock on mutex. This can cause undefined behaviour.
> >>
> >> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
> >> ---
> >>   net/ipv4/inet_connection_sock.c | 1 -
> >>   1 file changed, 1 deletion(-)
> >>
> >> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connectio=
n_sock.c
> >> index aeebe8816689..f11fe8c727a4 100644
> >> --- a/net/ipv4/inet_connection_sock.c
> >> +++ b/net/ipv4/inet_connection_sock.c
> >> @@ -597,7 +597,6 @@ int inet_csk_get_port(struct sock *sk, unsigned sh=
ort snum)
> >>      }
> >>      if (head2_lock_acquired)
> >>              spin_unlock(&head2->lock);
> >> -    spin_unlock_bh(&head->lock);
> >
> > How was this tested?
> >
> > And where is the now-needed unlock of the head->lock?
> >
> > How was this change found?
> >
> > And your subject line needs a lot of work...
> >
> > thanks,
> >
> > greg k-h
> Hello, I used sparse tool and got it this warning message "warning:
> context imbalance in 'inet_csk_get_port' - unexpected unlock"
> Due to my over excitement of sending a good patch to kernel I didnt see
> correctly and misread `head` as `head2` and thought it was double
> unlocking the mutex. I m very sorry. But on a different note think we
> should do a check for `head->lock` as well before unlocking. Unlocking a
> non locked mutex can also trigger a undefined behaviour.
>

There is no undefined behavior, only sparse that might be confused a little=
.

I do not think we can express in sparse the fact that
inet_csk_find_open_port() acquires head->lock

(head being the return value of this function...)

The following does not help.

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_soc=
k.c
index aeebe881668996057d1495c84eee0f0b644b7ad0..ed7b3993316cd1ba0b2859b0bd3=
f447e066bd3b5
100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -323,6 +323,7 @@ static struct inet_bind_hashbucket *
 inet_csk_find_open_port(const struct sock *sk, struct
inet_bind_bucket **tb_ret,
                        struct inet_bind2_bucket **tb2_ret,
                        struct inet_bind_hashbucket **head2_ret, int *port_=
ret)
+       __acquires(head->lock)
 {
        struct inet_hashinfo *hinfo =3D tcp_or_dccp_get_hashinfo(sk);
        int i, low, high, attempt_half, port, l3mdev;
