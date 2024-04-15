Return-Path: <linux-kernel+bounces-145929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0AA8A5CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00849B21BD2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A39A156F53;
	Mon, 15 Apr 2024 21:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2Du+09d"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E41156236;
	Mon, 15 Apr 2024 21:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713216341; cv=none; b=g+kit+MfDcDj1AWxxjI+L0WEqCn6nkA77gZvnJDq1aKKFFLn9lSmgMg7CFTyCIaI3iSfSAbUPKMwinPrNCPbvUwTm0SGgeXFBlECrydKgfVttnpoh3ho1hjzgWlid7wSCatr2TAWLgo49CJn4zxMdj7uTmlKkRzXpp9v8MSaomY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713216341; c=relaxed/simple;
	bh=m2bnyXoPve6kFs+KbC7IXQMTZpUcBMgtxbv/xYm98h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gb+UcK/AUrLJ9y9KVmd2a2L6c1WHaWyI1IFOprPPNUPQeVti96weX8SdCQLnbi5KgTnsQTmu2hpi1Ka8KdMk3KKb09BkJXWW9cdr0UwZZUfQai823ZSwIYC4ZzKLBq9Vb1Fg2ZGz6IukOsoMEUuG0ddJa0pHNWoyq0ztnrhZ1C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2Du+09d; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-343c891bca5so2412173f8f.2;
        Mon, 15 Apr 2024 14:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713216338; x=1713821138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6Ar2yG1hipbO/wSAi/ZjpkXRjk4zWz8MUQpTTF6vT8=;
        b=O2Du+09dXNpJsUWjh3iFtMzAWPX5ne7+7MnCYAm9z7C1u5vfUzD3TVChhT80wEDBMn
         JAQCWBPEg9B7Fqjz/oG4qidmafIzXRmaT4OmGgRE7UQtzC3/Xpwh5s9pxHea3p1nQO4D
         /ZCHS13XxGc2OWlHKCL9vdOgAI3sxTLb5QspirwJtLEFi3SISwAJp5Yc8g9bS6K8y31E
         kKV7oiZhdVVFPLxLwSgNvyCR5mecW9mCATQ0IMDz/Bb05AzrFXL+ogRIIfhsCCVExBPF
         cpbrcJevZrrJAyoiop9k8ZavvFay9E2nMi9EjrwqVxc1W+4WBpW6cDMq6jFCdFrvXfPd
         vvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713216338; x=1713821138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6Ar2yG1hipbO/wSAi/ZjpkXRjk4zWz8MUQpTTF6vT8=;
        b=jsySIBO+/Z2+eDyw+LFerltOa2kQW8Gs7mML2M/hTUlo48/aQWOzxLeS27MI3lBqJ6
         aGT3bF3l58kXazvIQQdFDFtsQ6MAshPp9W0A0BT+iHF3XVBPVyhrE5JhWAjoabJ/3Cl+
         larJh47W9NFA9UR2I58Ww4dJuprQ+SE6EfnXotGh4L8V477fuQ0SwOSKVMRAD8e1lHeb
         UtP5mRxgQSKKqaxlGmu1r0j/gQxb05jsG/I905BOI5FKp3M8Mxyi4dzBC7oHERizDec4
         kfsGYVr6/IQUDRbTJ4/btWdP0C9S1J+pLHavZpS0+ogBOB9WlRq3+/YiKVMZFS+mHf03
         +RdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT1M1n33fBMqsRRQE3+1BosXL1n4fqHJe3B6ka31YDZxSlYrrpNLLRHq78ZlaDE7MA1UGzHu4K7X3+zsUfJzOT5Fmt8i4Q9oW4ebSiVd07cUohM0J0N893vQp/JquL11n7RlfLnDS92KfeXxHLNJPexTYcMc9ZgVLRhFtT5DyTN+tNYAlPPXHMTCYEOC7xCieh0XdtXUZroZ+ntg==
X-Gm-Message-State: AOJu0Yz6z1JTf25aKq7NcPmTzkQkr2bDlaTHhLifgnau7MmKod4dEBAL
	3MKA/D/JWxgjvfjDfCTEIJLvDLMEin4AR0/I6T6VM8Fy3xmje6b8
X-Google-Smtp-Source: AGHT+IHVDq4wHkTRDLnml3w8/vY76YStJGi0lNRDZ+kQK8Q3T8+RWX2Nxrxp2FGdXz1LeKjvjVxvOA==
X-Received: by 2002:adf:cc89:0:b0:348:b435:273e with SMTP id p9-20020adfcc89000000b00348b435273emr161943wrj.48.1713216337895;
        Mon, 15 Apr 2024 14:25:37 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id e3-20020a5d5943000000b00346c169362esm12606521wri.23.2024.04.15.14.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 14:25:37 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 Frank Oltmanns <frank@oltmanns.dev>
Cc: Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
 Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, stable@vger.kernel.org,
 Diego Roversi <diegor@tiscali.it>, Erico Nunes <nunes.erico@gmail.com>
Subject:
 Re: [PATCH v4 0/5] Pinephone video out fixes (flipping between two frames)
Date: Mon, 15 Apr 2024 23:25:35 +0200
Message-ID: <3799968.kQq0lBPeGt@jernej-laptop>
In-Reply-To: <87frw2a2e4.fsf@oltmanns.dev>
References:
 <20240310-pinephone-pll-fixes-v4-0-46fc80c83637@oltmanns.dev>
 <87frw2a2e4.fsf@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne sreda, 3. april 2024 ob 17:31:47 GMT +2 je Frank Oltmanns napisal(a):
> Dear clk and sunxi-ng maintainers,
> 
> Patches 1-4 have been reviewed and there are no pending issues. If there
> is something else you need me to do to get this applied, please let me
> know.

Sorry for late patch merge. Patch 1-2 are applied as a fix to 6.9, the rest
will go to 6.10.

Best regards,
Jernej

> 
> Thanks,
>   Frank
> 
> On 2024-03-10 at 14:21:10 +0100, Frank Oltmanns <frank@oltmanns.dev> wrote:
> > On some pinephones the video output sometimes freezes (flips between two
> > frames) [1]. It seems to be that the reason for this behaviour is that
> > PLL-MIPI is outside its limits, and the GPU is not running at a fixed
> > rate.
> >
> > In this patch series I propose the following changes:
> >   1. sunxi-ng: Adhere to the following constraints given in the
> >      Allwinner A64 Manual regarding PLL-MIPI:
> >       * M/N <= 3
> >       * (PLL_VIDEO0)/M >= 24MHz
> >       * 500MHz <= clockrate <= 1400MHz
> >
> >   2. Remove two operating points from the A64 DTS OPPs, so that the GPU
> >      runs at a fixed rate of 432 MHz.
> >
> > Note, that when pinning the GPU to 432 MHz the issue [1] completely
> > disappears for me. I've searched the BSP and could not find any
> > indication that supports the idea of having the three OPPs. The only
> > frequency I found in the BPSs for A64 is 432 MHz, which has also proven
> > stable for me.
> >
> > I very much appreciate your feedback!
> >
> > [1] https://gitlab.com/postmarketOS/pmaports/-/issues/805
> >
> > Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> > ---
> > Changes in v4:
> > - sunxi-ng: common: Address review comments.
> > - Link to v3: https://lore.kernel.org/r/20240304-pinephone-pll-fixes-v3-0-94ab828f269a@oltmanns.dev
> >
> > Changes in v3:
> > - dts: Pin GPU to 432 MHz.
> > - nkm and a64: Move minimum and maximum rate handling to the common part
> >   of the sunxi-ng driver.
> > - Removed st7703 patch from series.
> > - Link to v2: https://lore.kernel.org/r/20240205-pinephone-pll-fixes-v2-0-96a46a2d8c9b@oltmanns.dev
> >
> > Changes in v2:
> > - dts: Increase minimum GPU frequency to 192 MHz.
> > - nkm and a64: Add minimum and maximum rate for PLL-MIPI.
> > - nkm: Use the same approach for skipping invalid rates in
> >   ccu_nkm_find_best() as in ccu_nkm_find_best_with_parent_adj().
> > - nkm: Improve names for ratio struct members and hence get rid of
> >   describing comments.
> > - nkm and a64: Correct description in the commit messages: M/N <= 3
> > - Remove patches for nm as they were not needed.
> > - st7703: Rework the commit message to cover more background for the
> >   change.
> > - Link to v1: https://lore.kernel.org/r/20231218-pinephone-pll-fixes-v1-0-e238b6ed6dc1@oltmanns.dev
> >
> > ---
> > Frank Oltmanns (5):
> >       clk: sunxi-ng: common: Support minimum and maximum rate
> >       clk: sunxi-ng: a64: Set minimum and maximum rate for PLL-MIPI
> >       clk: sunxi-ng: nkm: Support constraints on m/n ratio and parent rate
> >       clk: sunxi-ng: a64: Add constraints on PLL-MIPI's n/m ratio and parent rate
> >       arm64: dts: allwinner: a64: Run GPU at 432 MHz
> >
> >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  8 --------
> >  drivers/clk/sunxi-ng/ccu-sun50i-a64.c         | 14 +++++++++-----
> >  drivers/clk/sunxi-ng/ccu_common.c             | 19 +++++++++++++++++++
> >  drivers/clk/sunxi-ng/ccu_common.h             |  3 +++
> >  drivers/clk/sunxi-ng/ccu_nkm.c                | 21 +++++++++++++++++++++
> >  drivers/clk/sunxi-ng/ccu_nkm.h                |  2 ++
> >  6 files changed, 54 insertions(+), 13 deletions(-)
> > ---
> > base-commit: dcb6c8ee6acc6c347caec1e73fb900c0f4ff9806
> > change-id: 20231218-pinephone-pll-fixes-0ccdfde273e4
> >
> > Best regards,
> 





