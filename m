Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4CA7B4EA0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbjJBJE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbjJBJE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:04:26 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C90A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 02:04:22 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50308217223so24737039e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 02:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696237461; x=1696842261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50/2hsvbLrIvggaR30aYtR9Jo6d9ZOr+OHp/3txBaD0=;
        b=lPBXkBFzpV7djjZjxp+Up3Eq+FAXlcZZUlpBcZeLtWPbKAScrCFn9sSOKw6VtjrZLM
         p1adbQMEgc5+FW+nyiOg512pBUhlSgc6s7A8qPcWqAOJTZ/MgddKZCc9NfN398jYXtZ+
         UF1wcPlHXAYVphgYol8iiGVck6kkAxWO5yNEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696237461; x=1696842261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50/2hsvbLrIvggaR30aYtR9Jo6d9ZOr+OHp/3txBaD0=;
        b=EKzmipb0xaZ1XWGVJutolWQnksBMym1AlbBLwYnpBFNwHpNyiA6IVFzgTraP/30UvW
         RDVFgVZgUw+rY0De4+MBf/iBS4lc4EHBFpJODry0oVU26XewPTii2jURsx1/6npSFJJt
         WXnOKAha9nju4ZlMHUlS1U7vaeSwiDE6YHddVprNZaupDmcGCB24s+log4b44wP98+fv
         6nkLjgoZP2xzP1dl2MA8wDkk0Z2QKNS5x0fAzpZqd4G0PS62zGsJtmr+8yJs3VKuIByS
         QnqWIZ83plI5gc0xJB9Xytdto33+0RP57+XyHT5CQyJJJrSjHnmxoUYrLWTdjPl2gaYp
         0nfg==
X-Gm-Message-State: AOJu0YxDl03Ilt+/oYOYCWT3c3DQkghqWFQLnGaANe8T8pycPco7uArs
        6UNoCAuKMfFgP0jaBDjUuhP9p9qm2sYE49X6DRQDbA==
X-Google-Smtp-Source: AGHT+IGneJ9FgkMSGDGOIASBqdEuFAnrvX8yuv1YB2NtaOm9WDOAb/vk+og0O6KbRm7uTPH/Pc2L428eZfb3dwnSB9I=
X-Received: by 2002:a19:6509:0:b0:503:970:4dbf with SMTP id
 z9-20020a196509000000b0050309704dbfmr7689708lfb.15.1696237460859; Mon, 02 Oct
 2023 02:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230929082009.71843-1-angelogioacchino.delregno@collabora.com>
 <84b2de54-8337-42a3-a25c-a95cf2f3349f@app.fastmail.com> <CAGXv+5FtBcHwEhQEoEUBx24Zf4ABrDeSaWo_mDbM7OvmBLF5nA@mail.gmail.com>
 <660c5c93-4a02-0f6b-4640-ddf67a477490@collabora.com>
In-Reply-To: <660c5c93-4a02-0f6b-4640-ddf67a477490@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 2 Oct 2023 17:04:09 +0800
Message-ID: <CAGXv+5H0jFRj-79XXp+LSE=kD=p1we5Vem4+9AYk2-tS-bHT0A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Angelo as MediaTek SoC co-maintainer
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, amergnat@baylibre.com,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 4:27=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 02/10/23 05:30, Chen-Yu Tsai ha scritto:
> > On Sat, Sep 30, 2023 at 3:37=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> w=
rote:
> >>
> >> On Fri, Sep 29, 2023, at 04:20, AngeloGioacchino Del Regno wrote:
> >>> I am a top reviewer mainly for MediaTek SoC related patches in most
> >>> subsystems and I've also been upstreaming both improvements, fixes
> >>> and new drivers and devicetrees when required.
> >>>
> >>> The MediaTek scene saw a generous increase in number of patches that
> >>> are sent to the lists every week, increasing the amount of required
> >>> efforts to maintain the MTK bits overall, and we will possibly see
> >>> even more of that.
> >>>
> >>> For this reason, and also because of suggestions and encouragement
> >>> coming from the community, I'm stepping up to be a co-maintainer of
> >>> MediaTek SoCs support.
> >>>
> >>> Signed-off-by: AngeloGioacchino Del Regno
> >>> <angelogioacchino.delregno@collabora.com>
> >>> ---
> >>>
> >>> P.S.: I tried to reach to Matthias for almost two months, but I could=
n't
> >>> find any way to talk to him and he has been unresponsive on the maili=
ng
> >>> lists as well.
> >>>
> >>> P.P.S.: This also comes after Rob Herring's suggestion to have myself=
 as
> >>> a MediaTek SoC co-maintainer [1] and support from other people.
> >>>
> >>> [1]: https://lore.kernel.org/all/20230804225813.12493-1-robh@kernel.o=
rg/
> >>
> >> Thanks for volunteering for this!
> >>
> >> I have no information on what Mattias is doing, but I see that he
> >> has not merged any patches since June, and that he never sent a
> >> pull request for your patches that are still in his for-next
> >> branch.
> >>
> >> I hope he's going to be ok, but let's plan for you to take over
> >> for the moment, at least until Matthias is again able to keep
> >> maintaining the platform in the near future.
> >>
> >> Here is my suggestion for how to continue from here:
> >>
> >> - Please send your MAINTAINERS file update to soc@kernel.org
> >>    along  with any urgent bugfixes you may have, so I can forward
> >>    them for 6.7. I'm wrapping up the current set of fixes at
> >>    the moment, so this would be for next week's rc
> >>
> >> - Create a git tree with the ususal branches (drivers, soc, dt,
> >>    fixes, for-next) and ask Stephen Rothwell (on Cc) to add
> >>    the combined for-next branch  to linux-next for integration testing
> >
> > I suggest creating a shared git tree from the start. That way when
> > Mattias comes back and does agree to co-maintainership, or if anyone
> > else joins in, you don't have to change the git tree URL in a lot of
> > places.
> >
>
> I agree with creating a shared git tree from the start... I currently don=
't have
> a kernel.org account yet, as I'm waiting for helpdesk to grant my account=
 request.
>
> They asked me to send a patch adding myself to MAINTAINERS as they would =
use that
> as a basis to grant the account request... so I guess it's happening soon=
; seen
> the urgency, I would do anything in my power to speed up the process, but=
 probably
> there's "nothing to do" about it.

If you do end up not getting an account in time, I can do all the patch
queuing and sending out PR work using my account for this cycle, if that's
OK with the soc maintainers.

That said, we have a long weekend (Oct. 7 to Oct. 10) during which I will b=
e
travelling. I might also be travelling during parts of the remaining three
work days, but the whole thing is still up in the air.

> I am guessing that the right thing to do right now is to just send the mo=
stly
> critical fixes to soc@kernel.org, along with this patch, and wait until a=
 shared
> tree is created to keep things clean?

+1 Sounds good to me.


> >> - Start each branch on 6.6-rc2 (usually we use rc1, but this time
> >>    rc2 is a better candidate because of the last-minute
> >>    drivers/pmdomain rename), and merge the corresponding branches
> >>    from git://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/lin=
ux.git
> >>    into those to avoids conflicts with his tree
> >>
> >> - Add any further patches you want in 6.7 on top
> >>
> >> - Send a first set of pull requests to soc@kernel.org for whatever
> >>    you have merged as soon as you are confident about them,
> >>    ideally by the end of next week.
> >>
> >> - Send additional pull requests for fixups or late features in
> >>    the weeks after that as you see fit.
> >>
> >> See Documentation/process/maintainer-soc.rst for more details
> >> on the above. When Mattias comes back, you can work out a new
> >> process together with him.
> >
> > I can also answer any questions you might have about the process.
> >
>
> Many thanks for your support, I greatly appreciate that.
>
> Cheers,
> Angelo
>
