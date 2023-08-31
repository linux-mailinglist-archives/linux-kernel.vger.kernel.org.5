Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED93278E5C9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 07:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346048AbjHaFea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 01:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242227AbjHaFe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 01:34:27 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B74EA;
        Wed, 30 Aug 2023 22:34:23 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-565e54cb93aso312003a12.3;
        Wed, 30 Aug 2023 22:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693460063; x=1694064863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Jp1GatRvSx1j5dMXHLzSPK88pnwTUhV9wWIcAF5NJs=;
        b=BSq81ss4oikaIzKkdNUgQkdOO6pEdYkvnhk+pmuEaCARv7QQuxtc13UqPjFL5sVe/w
         4JwrCQqKfYffMqKxWWSvna4fk60W6/vq4xApj3TBXh1XjEKfkLvaBXo8f/LF849y3M9o
         4l++O50vFVYazCieD4jARdnjQgqg8Q7liS8STaBgbJ2Zhh3f5QwQGeRZIirLK4BE/RHU
         72mvkKYIJ4lP+Om+cbNpYzBT5rtGwDtUFt5x2DN1XmQT3Vcn+/DSdLGxKsPzWJSUhqmC
         tp5ViLcm/w7OuRb54vjPtwvuN7KB5F9F01Hgyci84kiNznab6b0rfP2IjjrAcSbbB/w2
         RiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693460063; x=1694064863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Jp1GatRvSx1j5dMXHLzSPK88pnwTUhV9wWIcAF5NJs=;
        b=dzMZrmoG3dXIWRLRNd3xb+QgWqeSpwdy21XMOrvg7As1wTzhQnNi7vYq0C3qyaRrFV
         psIs4CzNqS8jMuCaERFkZ8qs2yhBeZ+ZlBBx0X0hy8PPw/fhXwCGyp8gHGfBcrCLpL1u
         v9xxnSpSruHuEtd/hdvyHfrH3xt0ss82r+c+cgYeVasSiPzl2BGXtp5gHHVERXIrDD9r
         QbLdpldp0brFgqbuGw7TjsSQAHUXkNPCfEbVuSpGqYXkYsmWcUzD0InFFGd1jhTT6Epf
         u0XBVDBSAl7Kp/A8ty9L61hjhQbLlm4p6ocOSrCCy0HRxyLLu9IxJ+f7kAAUpOa7FPEu
         LRGA==
X-Gm-Message-State: AOJu0YwJo15+Vp0H91STvp4nfyL7vBK0PLJAKLABeC+ErmjRy+nBsykG
        mGQFUS7CbJ+1AFksHwBlPNEe+21rbUnm398kbNVDqiWB3GhBmQ==
X-Google-Smtp-Source: AGHT+IF5wB3svjQf9nWw60DSNQ0IWUqWE6f7PiNfpAcagID37P3DVcd8CpPKm/KleKdno9fUA3gs2cMg82M34w4E25o=
X-Received: by 2002:a05:6a20:3956:b0:14e:62cd:1370 with SMTP id
 r22-20020a056a20395600b0014e62cd1370mr5066919pzg.14.1693460063192; Wed, 30
 Aug 2023 22:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <1692434183-2054-1-git-send-email-yangtiezhu@loongson.cn>
 <ZOxkt/6EkQIy+Jkt@alpha.franken.de> <ZO4Mdr9/XUkXDK9j@alpha.franken.de>
 <CAAhV-H4XDRGkFaqyOnTyDQo8M=nEUYf4B8kSiEWQpq6QB-yz5g@mail.gmail.com> <alpine.DEB.2.21.2308301619300.43104@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2308301619300.43104@angie.orcam.me.uk>
From:   YunQiang Su <wzssyqa@gmail.com>
Date:   Thu, 31 Aug 2023 13:34:11 +0800
Message-ID: <CAKcpw6X2wenGkROshareJjdT05xDTvgiJQDxvH03nTicD9X29Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Modify die() for MIPS
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki <macro@orcam.me.uk> =E4=BA=8E2023=E5=B9=B48=E6=9C=8831=E6=
=97=A5=E5=91=A8=E5=9B=9B 02:56=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 30 Aug 2023, Huacai Chen wrote:
>
> > > > series applied to mips-next.
> > >
> > > I've dropped the series again after feedback from Maciej, that this
> > > still needs more changes.
> > I feel a little surprised. This series has appeared for more than ten
> > days and received some R-b, and we haven't seen any objections from
> > Maciej. If there are really some bugs that need to be fixed, I think
> > the normal operation is making additional patches...
>
>  You haven't received any ack from me either, and I stopped reviewing the
> series as it was taking too much of my time and mental effort and yet
> changes were going in the wrong direction.  Silence never means an ack.
>

In my opinion, the position of `reviewer` normally means more
obligation instead of
power.
The world is always changing, I don't think that the world needs to
wait for anybody.

In the open source community, if a person has some position, if
they/he/she has little
time to play that position well, he should do something, for example, seek =
help
or transfer the position to somebody who can work well.

>  It's up to the submitter to get things right and not to expect from the
> reviewer to get issues pointed at by finger one by one, effectively
> demanding someone else's effort to get their own objectives complete even
> with the most obvious things.
>
>  And then for a hypothetical case only that the submitter is not able to
> verify.  For such cases the usual approach is to do nothing until an
> actual real case is found.
>

I think that it depends. If the patch can solve a part of this problem, and
won't leave some problem hard to solve in the future or serious
security problems.
I think that it is worth considering.

Yes, I agree with a sentence from you "Nobody's perfect", and the same goes=
 for
software, even Linux kernel.

PS: I never read the code of this thread, it is just common sense, I guess.

>  Very simple such a change that one can verify to an acceptable degree
> that it is correct by just proofreading might be accepted anyway, but it
> cannot be guaranteed.
>
>  The missed NMI case only proved the submitter didn't do their homework
> and didn't track down all the call sites as expected with such a change,
> and instead relied on reviewer's vigilance.
>
>  As to the changes, specifically:
>
> - 1/4 is bogus, the kernel must not BUG on user activities.  Most simply
>   die() should be told by the NMI caller that it must not return in this
>   case and then it should ignore the NOTIFY_STOP condition.
>
>   I realise we may not be able to just return from the NMI handler to the
>   location at CP0.ErrorEPC and continue, because owing to the privileged
>   ISA design we won't be able to make such an NMI handler reentrant, let
>   alone SMP-safe.  But it should have been given in the change descriptio=
n
>   as rationale for not handling the NOTIFY_STOP condition for the NMI.
>
>   I leave it as an exercise to the reader to figure out why a returning
>   NMI handler cannot be made reentrant.
>
> - 2/4 should be a one-liner to handle the NOTIFY_STOP condition just as
>   with the x86 port, which I already (!) communicated, and which was (!!!=
)
>   ignored.  There is no need to rewrite the rest of die() and make it mor=
e
>   complex too just because it can be done.
>
> - 3/4 is not needed if 2/4 was done properly.  And as it stands it should
>   have been folded into 2/4, because fixes to an own pending submission
>   mustn't be made with a separate patch: the original change has to be
>   corrected instead.
>
> - 4/4 is OK (and I believe the only one that actually got a Reviewed-by:
>   tag).
>
> Most of these issues would have been avoided if the submitter made
> themselves familiar with Documentation/process/submitting-patches.rst and
> followed the rules specified there.
>
>  Otherwise this takes valuable reviewer resources that would best be used
> elsewhere and it puts submitters of quality changes at a disadvantage,
> which is not fair.
>
>  It is not our policy to accept known-broken changes and then fix them up
> afterwards.  Changes are expected to be technically sound to the best of
> everyone's involved knowledge and it's up to the submitter to prove that
> it is the case and that a change is worth including.  You would have
> learnt it from the document referred.  Nobody's perfect and issues may
> slip through, but we need to make every effort so as to avoid it.
>
>  Mind that we're doing reviews as volunteers entirely in our free time we
> might instead want to spend with friends or in another enjoyable way.  It
> is not my day job to review random MIPS/Linux patches posted to a mailing
> list.  Even composing this reply took a considerable amount of time and
> effort, which would best be spent elsewhere, because I am talking obvious
> things here and repeating Documentation/process/submitting-patches.rst
> stuff.
>

I have noticed that in the note of this series of patches:
     v3:
        -- Make each patch can be built without errors and warnings.

I think that how to split the patches is a trade off, not a principle.
For me, the reasons to split patches are:
   1. Make the problem obviously.
   2. Show the problem one by one, and it is easy to understand.
   3. Make life easier for distributors.
   4. And maybe more

While if a splitting conflicts with these purposes, it will be another stor=
y.

>   Maciej



--=20
YunQiang Su
