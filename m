Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38ED37C4FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345729AbjJKKOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjJKKOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:14:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B67A9D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697019210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RLI+gNG/Ik5TmE6Ss6b86D5IYiR1FClxUP9y17ZJqCA=;
        b=V1F8h9+9Q6CPPxjyE7J+5ve2zno6g8TNyl8YleUxGNcSh8TKxrKWuAT+UViBYBPjEzGPy4
        Gd1xjnQqUWXY5EnzKp9j8qHHEN/Y8vwFl0la4juFrwgKkdkxMmEKsSPbcIf5ClCk64DeWQ
        x9N2pV2WaHrXQncyVnCk5DnezvOT5/I=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-9MxLMbTXNsCjfrvh1CugUw-1; Wed, 11 Oct 2023 06:13:19 -0400
X-MC-Unique: 9MxLMbTXNsCjfrvh1CugUw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b6ff15946fso58391651fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697019197; x=1697623997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLI+gNG/Ik5TmE6Ss6b86D5IYiR1FClxUP9y17ZJqCA=;
        b=rJawSERIUDCbw/rObcCFyBCbWdRjbSE3Ktw2zUufn8vXGUot7qjK1rA0I/pDbFOJxj
         OnXhTpX5tm3MXW+Fh+BBocbhP8bV/VIG4EClH1dvx94hpG2H7wR9FoujWTWbh+dujtDq
         JpRowC2JnIiVrdCyIvnouhhaMgKlJENAvHURnSMaEk+BOSrGi+rZiI4ZZj4Mz6EV8VBC
         bm0uHqG5aCuM/cYKpYB0i9oGMAiOwc4+Z27P2QzKLcxsnJ3rEF7RCwE+Ifchn1BRqlSC
         38C2aJp+Ux67SuVJxi/akGz7WQhSmj/umff58gP62SKv0zjF7udDDaBqACjWQSiK5REm
         snzA==
X-Gm-Message-State: AOJu0YyK6RCT4b8ENud69oSQywGe+UvQElr+ptwMmBV1QCZGn4GANxPl
        aNzVix+IofFDKqbYJHS0Es1F2YL5r3nQQiSHmxL/3geiA/3OjgY0/hXM9HAmempcfN1rAPv21b/
        eG4t+f4dG492WoVp9GJUgjPnRNMDDNtNsGLduQ2cTAeybQovx
X-Received: by 2002:a2e:9001:0:b0:2c1:7df1:14a6 with SMTP id h1-20020a2e9001000000b002c17df114a6mr18885594ljg.9.1697019197157;
        Wed, 11 Oct 2023 03:13:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzgFBh7dpGZLMqhPmRhYZgbEoyXO+JEnPZeVd6y4j9UPTWyTctRlSWKtNno+D+4ydHwjWMyyV7Txz55onCUho=
X-Received: by 2002:a2e:9001:0:b0:2c1:7df1:14a6 with SMTP id
 h1-20020a2e9001000000b002c17df114a6mr18885577ljg.9.1697019196839; Wed, 11 Oct
 2023 03:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231010-upstream-net-next-20231006-mptcp-ynl-v1-0-18dd117e8f50@kernel.org>
 <20231010-upstream-net-next-20231006-mptcp-ynl-v1-3-18dd117e8f50@kernel.org> <20231010180839.0617d61d@kernel.org>
In-Reply-To: <20231010180839.0617d61d@kernel.org>
From:   Davide Caratti <dcaratti@redhat.com>
Date:   Wed, 11 Oct 2023 12:13:04 +0200
Message-ID: <CAKa-r6sT=WaTFqumYOEzOKWZoUi0KQ8EYpQ753+C5JjjsUb3wA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/6] Documentation: netlink: add a YAML spec for mptcp
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Mat Martineau <martineau@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello, Jakub, thanks for looking at this!

On Wed, Oct 11, 2023 at 3:08=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 10 Oct 2023 21:21:44 +0200 Matthieu Baerts wrote:
> > +definitions:
> > +  -
> > +    type: enum
> > +    name: event-type
> > +    enum-name: mptcp_event_type
> > +    name-prefix: mptcp_event_
>
> I think you can use - instead of _ here.
> For consistency with other families?

right, I will convert the whole spec.

>
> > +    entries:
> > +     -
> > +      name: unspec
> > +      value: 0
>
> 90% sure enums still start at 0, only attrs and msgs now default to 1.

Just checked, value:0 is not needed for enums: I will remove it

> > +     -
> > +      name: announced
> > +      value: 6
> > +      doc:
> > +        token, rem_id, family, daddr4 | daddr6 [, dport]
> > +        A new address has been announced by the peer.
> > +     -
> > +      name: removed
> > +      value: 7
>
> Follows 6 so no need for value?

correct, will fix this too

> > +      -
> > +        name: addr6
> > +        type: binary
> > +        checks:
> > +          min-len: 16
>
> Do you not want the exact length for this?
> If YNL doesn't support something just LMK, we add stuff as needed..

ohh yes, we had NLA_POLICY_EXACT_LEN before but ynl doesn't seem to
support it. I can try to add the support and include another patch at
the beginning of the series, is that ok?

--=20
davide

