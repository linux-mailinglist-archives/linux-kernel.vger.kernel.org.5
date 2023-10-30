Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3837DC2F1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 00:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjJ3XCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 19:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJ3XCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 19:02:18 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C33D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:02:14 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso773504566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698706932; x=1699311732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luudkAssmNJ0bwZBMropQoV9NGSQLXNONdtiNSJDkQc=;
        b=lU9IJgniZ2sBw/lp6Rew5xWXmFlQQpbLnOHlTVqhy6mzuIMTVyEFwYqZ/Rce4cR3JH
         aj91UO8fxF7RKR8HLp0DTEp16GH3pT9o28i6IlQtSjKrHTCeskXoCKe4DBrG2P3fiODI
         97kbbw2TQkVlrwdgyLyAAFAW5TEyymsQvb4MM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698706932; x=1699311732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=luudkAssmNJ0bwZBMropQoV9NGSQLXNONdtiNSJDkQc=;
        b=WuGJACNqS9yKkkja37kY2SwfaMAADTyTu+gHks8eC/yYZEyjmkwCMgpXgWkhtt+Euv
         vuLeI0Ws2wDmBwz7PejjZDEsYiauaV9AuihAzezQtSVqXUzEMMAyG66Kh11ewuVKj9Zc
         IV/cN2hbtxOoFkCZpcI+yZ6hDVgpI+CqujmY4cAsT6mogL3HDZ3ML/V6Iok51TBrr18e
         DcWVk+6Q7MNHH2aBe2/dZxmbq/bXMKnU+tvXeI9G7IpyXws/tv9gj1x2cei20SYpO3Xp
         fXvLyzmeTxYKxLK4pwxWhkytHCUtCIavvJdBZBt5KkKG2dsYB1WKa/fONBjFCg5xKTnQ
         5X8Q==
X-Gm-Message-State: AOJu0YypiFUiem0e3WwC8k+TDms48PXehc2vI3mxvkI6bOPi00c6PbdZ
        fdmTmPaqCZPOgPnvRg+0DmSum95/jl4DUVccKajzqAy/
X-Google-Smtp-Source: AGHT+IELnPAQvCTHOqdd4vtX2RuUEU/iU5qqnAjKFySDPBDwxcXlYgloKTOb2o71zpsjVg0YcGZENw==
X-Received: by 2002:a17:907:786:b0:9c3:70d5:dc57 with SMTP id xd6-20020a170907078600b009c370d5dc57mr10642519ejb.40.1698706932183;
        Mon, 30 Oct 2023 16:02:12 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id s25-20020a170906bc5900b009b9977867fbsm10785ejv.109.2023.10.30.16.02.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 16:02:11 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so6227a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:02:11 -0700 (PDT)
X-Received: by 2002:a50:d741:0:b0:542:d8ec:5e9f with SMTP id
 i1-20020a50d741000000b00542d8ec5e9fmr9310edj.7.1698706931021; Mon, 30 Oct
 2023 16:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231006151547.1.Ide945748593cffd8ff0feb9ae22b795935b944d6@changeid>
 <20231006151547.3.Ie582d33cfe46f9ec2248e7f2dabdd6bbd66486a6@changeid> <ZS-8k22ZWgn5hcCd@FVFF77S0Q05N>
In-Reply-To: <ZS-8k22ZWgn5hcCd@FVFF77S0Q05N>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 30 Oct 2023 16:01:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UVkE9k=o3-3UT2L172hhAH-gtpe5ByELN8srC+a-7mJw@mail.gmail.com>
Message-ID: <CAD=FV=UVkE9k=o3-3UT2L172hhAH-gtpe5ByELN8srC+a-7mJw@mail.gmail.com>
Subject: Re: [PATCH 3/3] irqchip/gic-v3: Remove Mediatek pseudo-NMI firmware
 quirk handling
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 18, 2023 at 4:08=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Fri, Oct 06, 2023 at 03:15:53PM -0700, Douglas Anderson wrote:
> > This is a partial revert of commit 44bd78dd2b88 ("irqchip/gic-v3:
> > Disable pseudo NMIs on Mediatek devices w/ firmware issues"). In the
> > patch ("arm64: Disable GiC priorities on Mediatek devices w/ firmware
> > issues") we've moved the quirk handling to another place and so it's
> > not needed in the GiC driver.
> >
> > NOTE: this isn't a full revert because it leaves some of the changes
> > to the "quirks" structure around in case future code needs it.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
>
> I think it might make sense to fold this into the patch adding the cpucap
> detection. Otherwise, if you apply my suggestions to the first patch, the=
re's a
> 2-commit window where we'll have two places that log that NMI is being di=
sabled
> due to the FW issue. That's not a functional issue, so doesn't matter tha=
t
> much.
>
> Either way:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

I'm happy to go either way so I'd love some advice from maintainers
(Marc Zyngier, Catalin Marinas, Will Deacon) about what you'd prefer.

-Doug
