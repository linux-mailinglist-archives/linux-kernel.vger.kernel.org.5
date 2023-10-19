Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5254F7CFE6C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346442AbjJSPmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346438AbjJSPm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:42:29 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A5A187
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:41:58 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53e751aeb3cso9473437a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697730116; x=1698334916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gk5bEq+X+FTECApYbrlsW2qodFro6QNK8c1z/2N3JMM=;
        b=SW8eiUvtXPRStjUnqOkw8cd1UDsdmk97uYzhLcfR3JIn+GtYnaVWT8GMQzT+6V8kVp
         58ooYRTnGd1AfUjJoSguLyIUdEssOtqmRr78/KkOohYaCkA2bIxafp9jk0x5iO8wsLRB
         ZCrm9YtiI6oiBOUbYHuLVkG+vF6PMpPGDvBUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697730116; x=1698334916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gk5bEq+X+FTECApYbrlsW2qodFro6QNK8c1z/2N3JMM=;
        b=HgfhzB6z6aUWHX5GM8iOm48OfepzzAjJJEglW5V6D3f7aQ9WbKiQ88r305htWWNPJH
         SiekkMWpg0yxPGuNhF99X0vLCeZMidrG45spL3pMz6PoMGdc1O9U2WHFZn+INO0kL8Vt
         Hy20Gv4Jf+Ng+jClDep6K3qhz4BoboQGeQedT24S4K/MUFJUhP0uH2l5lhB3GrH3i6aa
         4IcynS9IyvF3WVuHK43eOu2aDx7aQwIQIrkcf5QsaGmJBd2o1OX9EMtUr0ijC240Z+8K
         JLOlpG3LSiBX1L6jE7K201mkDPc4c+kEpKXb22y3HDYlzqgcgjMn/VqZGsa2fGitSCOu
         C4AA==
X-Gm-Message-State: AOJu0YxO4LJfMMt5l+eFiH2csNWW8GLOf+0nNMneqwbcrqn+MsJzaej9
        vJmHlQDPxFacvTdPDXGc4bL88ZI0cVDzVwc6EX28uw==
X-Google-Smtp-Source: AGHT+IHoNysTzyGgD+A/6dtR8SVG8+zQVybCDmjSsigW0nB8Mp/lqjwMhAMGatSVe14pR5ki01HWrg==
X-Received: by 2002:a50:d55c:0:b0:53e:6db7:ea63 with SMTP id f28-20020a50d55c000000b0053e6db7ea63mr1613266edj.14.1697730115790;
        Thu, 19 Oct 2023 08:41:55 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id k3-20020aa7c043000000b0053ecef8786asm4596646edo.75.2023.10.19.08.41.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 08:41:55 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4063bfc6c03so82475e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:41:55 -0700 (PDT)
X-Received: by 2002:a05:600c:c88:b0:407:7f21:878e with SMTP id
 fj8-20020a05600c0c8800b004077f21878emr110200wmb.1.1697730114684; Thu, 19 Oct
 2023 08:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231012192552.3900360-1-dianders@chromium.org>
 <20231012122458.v3.5.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid>
 <29f9a2ff1979406489213909b940184f@realtek.com> <CAD=FV=U4rGozXHoK8+ejPgRtyoACy1971ftoatQivqzk2tk5ng@mail.gmail.com>
 <052401da00fa$dacccd90$906668b0$@realtek.com> <CAD=FV=XQswgKZh-JQ6PuKGRmrDMfDmZwM+MUpAcOk1=7Ppjyiw@mail.gmail.com>
 <34d7d7c7b5914674b55a6dc21ced1190@realtek.com>
In-Reply-To: <34d7d7c7b5914674b55a6dc21ced1190@realtek.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 19 Oct 2023 08:41:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X9qMDtv7VTj=Vg7sx5Hqcu_WAexaaVtPOxnBTjizxPmg@mail.gmail.com>
Message-ID: <CAD=FV=X9qMDtv7VTj=Vg7sx5Hqcu_WAexaaVtPOxnBTjizxPmg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] r8152: Block future register access if register
 access fails
To:     Hayes Wang <hayeswang@realtek.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Simon Horman <horms@kernel.org>,
        Edward Hill <ecgh@chromium.org>,
        Laura Nao <laura.nao@collabora.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Grant Grundler <grundler@chromium.org>,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 18, 2023 at 4:41=E2=80=AFAM Hayes Wang <hayeswang@realtek.com> =
wrote:
>
> > In any case, we haven't actually seen hardware that fails like this.
> > We've seen failure rates that are much much lower and we can imagine
> > failure rates that are 100% if we're got really broken hardware. Do
> > you think cases where failure rates are middle-of-the-road are likely?
>
> That is my question, too.
> I don't know if something would cause the situation, either.
> This is out of my knowledge.
> I am waiting for the professional answers, too.
>
> A lot of reasons may cause the fail of the control transfer.
> I don't have all of the real situation to analyze them.
> Therefore, what I could do is to assume different situations.
> You could say my hypotheses are unreasonable.
> However, I have to tell you what I worry.

Of course! ...and I appreciate your thoughts on the topic. The more
eyes on a patch the more problems that are caught. Unless someone
disagrees, I think we at least have ideas for how this could be
addressed if it comes up. Also unless someone disagrees, I think that
if this does come up in some situation it won't be a catastrophe.

Given how things look now, I'm going to plan to send a new version of
the patch later today. Though the commit message is long, I'll add a
little more to talk about this case and point to ideas for how it
could be solved if it comes up.


> > I would also say that nothing we can do can perfectly handle faulty
> > hardware. If we're imagining theoretical hardware, we could imagine
> > theoretical hardware that de-enumerated itself and re-enumerated
> > itself every half second because the firmware on the device crashed or
> > some regulator kept dropping. This faulty hardware would also cause an
> > infinite loop of de-enumeration and re-enumeration, right?
> >
> > Presumably if we get into either case, the user will realize that the
> > hardware isn't working and will unplug it from the system. While the
>
> Some of our devices are onboard. That is, they couldn't be unplugged.
> That is why I have to consider a lot of situations.

Good point! I think even with onboard devices we could already have
preexisting conditions that could cause an unbind/rebind loop. This
would be a new condition, of course.


-Doug
