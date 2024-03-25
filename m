Return-Path: <linux-kernel+bounces-117135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A2288AD01
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E324FBA2D95
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DDE1741FF;
	Mon, 25 Mar 2024 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQyCNJ30"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F571741F8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372788; cv=none; b=FUMpzdxLoWQc1E8+SiXQEqL/DfZT6eSEq+S/CAMwlZFSJwG2ql9brPEUsGcB3ZGwJX7qKQ0di6P5gjcRyZhS4Jf89BGdONl5V+4bJkYRLVoF5B0cqIMChdVWKGquzJUdoyR7/5tqp3hBPBZ3/Tta6FvqZj2krOWGfSLGdqovB3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372788; c=relaxed/simple;
	bh=i/F7ZUQC2WibdKQHGCsevnCdGMSfUeGxIYrzHXFi104=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bO1S18amo2vapF/WtGzlfpcrx/L5ao+lTtCSNnhfgjv6nArXPTmdczNCapwbZxwY3gfibuhrAZcSGm8XLKYaodP6aTijvuZWQIVFvCVi6gtaNIt8tjrOIWwn4sTRge3ZVyL+15b9OqfpxEH5dqGUyC31KAlH5heP7VRQ0zLYRA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bQyCNJ30; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc236729a2bso4128044276.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 06:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711372785; x=1711977585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=an1XrIb9VvljrFF0I+tmW7F3KNLXCqH0DCXayAqvq4U=;
        b=bQyCNJ30DbOcHRPpFOr9+TM6deHbOpyirsnMnTG8zx8g2SzQo+LNiczsFp9PCWL54F
         yRifp/qlG0XULwkWiLeO8FCNxwpkAyJ6dYxJWmPENqPp4poM9rYzF3Mxhp43XnU5ULkY
         tjjyjh3nBE2wxvYDoaoBaUYAeOvSZQOusoAjXkVRUfm1QSN/VanxtOb+2vR0KDgiNA/9
         LctGeVPCyP8Q6vLFlBGsJPcz15sAZSNhogHJqUl7+FrKI6/QuI5Ol/0f5IQX1UwHTEDx
         7ZY6o4+96CdHvop62icyxMVPNvXvqtg7e9aSdBk6EY5xERrvyqYLiCiaqFDmdRbLoo3z
         OdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372785; x=1711977585;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=an1XrIb9VvljrFF0I+tmW7F3KNLXCqH0DCXayAqvq4U=;
        b=K1pOkjPURmWgYyAOVlQRZV3k77syvJNqN43jaGM/N3/FyJox065RZm5H3qg3it9osG
         62ZZtzbxsjILxt3HTdKq68bh8KfwAnW4YEPH4iI2nlZ4M3SdN3X2JXflpTEvRmGJ6r50
         rto/X4y5NKh/1NLEVpS+S4pJ4VJ520oh9Yc53j3fkHsBRb4dHSwgDRVCbswD4vkZQxFk
         vHp4UsCd0mQHpGdyGnnYcuvvMMr45LcbM8ZBs3c7ueYAY1p4+4XgHUuUmhmji4REq4jM
         JKBuPTOg2l5H0E1/hVLBv+OJOwtUQWPWNpvcAcrKQyyIShafVWcDjJbDTCChAClIoWU3
         aFkg==
X-Gm-Message-State: AOJu0YxF4i5f7eAY+RJ3ixoGICJ+lc+cieT6oX81XPNBe9rOFo354deo
	I5ViBlUN0C8HgESu1kGk/2RTSz95VfvEOmywQeQLwdiq7RmLDGPzMbxlIGnv9J7nSzh/RrwVgTT
	INa4xeLmYixj4Zd+XJaWuYIb+qZcG6LADllxvGQ==
X-Google-Smtp-Source: AGHT+IFUMyHdn2LPn/q2Dnx5oB+SnXCwPU31SA3monsIPijGID18Z+XiqEWgW7vMhOAi9lK0th7DKjTMyHLHReWKyCk=
X-Received: by 2002:a25:2d11:0:b0:dc6:cd76:5ddf with SMTP id
 t17-20020a252d11000000b00dc6cd765ddfmr5281307ybt.39.1711372785586; Mon, 25
 Mar 2024 06:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319115932.4108904-1-serghox@gmail.com>
In-Reply-To: <20240319115932.4108904-1-serghox@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Mar 2024 14:19:10 +0100
Message-ID: <CAPDyKFokNLX8zAr=Cai58UZivt_c63aQXjaLyuPKnzAmQcQhzg@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] mmc: sdhci-of-dwcmshc: Add CQE support
To: Sergey Khimich <serghox@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Jyan Chou <jyanchou@realtek.com>, Asutosh Das <quic_asutoshd@quicinc.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 12:59, Sergey Khimich <serghox@gmail.com> wrote:
>
> Hello!
>
> This is implementation of SDHCI CQE support for sdhci-of-dwcmshc driver.
> For enabling CQE support just set 'supports-cqe' in your DevTree file
> for appropriate mmc node.
>
> Also, while implementing CQE support for the driver, I faced with a problem
> which I will describe below.
> According to the IP block documentation CQE works only with "AMDA-2 only"
> mode which is activated only with v4 mode enabled. I see in dwcmshc_probe()
> function that v4 mode gets enabled only for 'sdhci_dwcmshc_bf3_pdata'
> platform data.
>
> So my question is: is it correct to enable v4 mode for all platform data
> if 'SDHCI_CAN_64BIT_V4' bit is set in hw?
>
> Because I`m afraid that enabling v4 mode for some platforms could break
> them down. On the other hand, if host controller says that it can do v4
> (caps & SDHCI_CAN_64BIT_V4), lets do v4 or disable it manualy by some
> quirk. Anyway - RFC.
>
>
> v2:
>  - Added dwcmshc specific cqe_disable hook to prevent losing
>    in-flight cmd when an ioctl is issued and cqe_disable is called;
>
>  - Added processing 128Mb boundary for the host memory data buffer size
>    and the data buffer. For implementing this processing an extra
>    callback is added to the struct 'sdhci_ops'.
>
>  - Fixed typo.
>
> v3:
>  - Fix warning reported by kernel test robot:
>         | Reported-by: kernel test robot <lkp@intel.com>
>         | Closes: https://lore.kernel.org/oe-kbuild-all/202309270807.VoVn81m6-lkp@intel.com/
>         | Closes: https://lore.kernel.org/oe-kbuild-all/202309300806.dcR19kcE-lkp@intel.com/
>
> v4:
>  - Data reset moved to custom driver tuning hook.
>  - Removed unnecessary dwcmshc_sdhci_cqe_disable() func
>  - Removed unnecessary dwcmshc_cqhci_set_tran_desc. Export and use
>    cqhci_set_tran_desc() instead.
>  - Provide a hook for cqhci_set_tran_desc() instead of cqhci_prep_tran_desc().
>  - Fix typo: int_clok_disable --> int_clock_disable
>
> v5:
>  - Fix warning reported by kernel test robot:
>         | Reported-by: kernel test robot <lkp@intel.com>
>         | Closes: https://lore.kernel.org/oe-kbuild-all/202312301130.itEZhhI5-lkp@intel.com/
>
> v6:
>  - Rebase to master branch
>  - Fix typo;
>  - Fix double blank line;
>  - Add cqhci_suspend() and cqhci_resume() functions
>    to support mmc suspend-to-ram (s2r);
>  - Move reading DWCMSHC_P_VENDOR_AREA2 register under "supports-cqe"
>    condition as not all IPs have that register;
>  - Remove sdhci V4 mode from the list of prerequisites to init cqhci.
>
> v7:
>  - Add disabling MMC_CAP2_CQE and MMC_CAP2_CQE_DCMD caps
>    in case of CQE init fails to prevent problems in suspend/resume
>    functions.
>
> Sergey Khimich (2):
>   mmc: cqhci: Add cqhci set_tran_desc() callback
>   mmc: sdhci-of-dwcmshc: Implement SDHCI CQE support
>
>  drivers/mmc/host/Kconfig            |   1 +
>  drivers/mmc/host/cqhci-core.c       |  11 +-
>  drivers/mmc/host/cqhci.h            |   4 +
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 191 +++++++++++++++++++++++++++-
>  4 files changed, 202 insertions(+), 5 deletions(-)
>

Applied for next and by fixing a minor conflict when applying, thanks!

Kind regards
Uffe

