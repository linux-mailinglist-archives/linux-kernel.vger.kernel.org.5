Return-Path: <linux-kernel+bounces-17736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13258251BE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7AE284296
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E907428DB7;
	Fri,  5 Jan 2024 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ileODqGg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF95D250E7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5e7467eb93aso12840877b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 02:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704449963; x=1705054763; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DcBbN+Mq35oT5z3RHrKJMc09S+De+lBk+2EIDhUF92c=;
        b=ileODqGgvUe0JL9qt5qKJbogTTZTRLWM/idByF8hNzs1pNP3NztWCPwlUDAoMuQGuZ
         7twuTdqUt2eooM7+nK32COLMM4jVBejImANldf+G/qG+JdMSxLIArGMVmVVCXg0Lcxmg
         /RjCzfsGgkKB46ZDCv9RJEtX8MtM6o8UEyscqLKILxEFNKW54X3FlXWiFx78zYaiRiDC
         arLZ84vBQh5LXfgWQLRiYEKfAsYzXVbc5OJDjnKhCSU0NjenY7n6Hx0Ra4DMdpZkcKeo
         KWUHk7LtgAlX3fghrC0QI8AvM56/5PliEaYM6KP7M1XuqPeBYkuwo6Htnu5bGGEhfmzR
         gYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704449963; x=1705054763;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DcBbN+Mq35oT5z3RHrKJMc09S+De+lBk+2EIDhUF92c=;
        b=C4S/P1xEYcKj8oqufzUyM+x0BdvoXNMcqBn4Na5GHPzx6Exg/t3jiHbzVaSAzyl/Gj
         lf3eqUrobcHEQoDIezwXXFXrTimlspL+2PtyrgCmMMVYoWqgOTVz8URFNiubkhGvOsSW
         0IYU32fpkQLA+n7cYZfpK6CxGVoZAj5ZZqgkabygX5bgq8gs0oKLImx5AmBTImX2EHg0
         /NFLVGoeoJexgP6iY+6wb8In0N3QzOic2TOILl4pOpbDbM9VCUqvPLZ9PM8WG/dtdbX1
         BFbY03Ia/sOLZkf7vD8ySoIX1xiXAts1q5n2clqUBO4Qq5L/va9NSLc2CpjL0FN00bgx
         Hcdw==
X-Gm-Message-State: AOJu0YzQna9J7OOuGddzEWKDJraznwSW9dB9zVBZV2kNu3eh3YvUiCYG
	vQ1I+v+vSiM6LGKpuWKKhQFtLCycr2P6M06WztI8+yBFcOXAhA==
X-Google-Smtp-Source: AGHT+IEdxaYbgIlzF6nI0vP2xnrliMWzCMCLzhxBtRbnhtmzVVOW6PbOrLD0BxcarhC84fhhGiJYZl3YyMfte8nwBWs=
X-Received: by 2002:a81:8905:0:b0:5ec:482b:b8f0 with SMTP id
 z5-20020a818905000000b005ec482bb8f0mr1635756ywf.14.1704449962938; Fri, 05 Jan
 2024 02:19:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103222338.31447-1-kamal.dasu@broadcom.com>
In-Reply-To: <20240103222338.31447-1-kamal.dasu@broadcom.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 5 Jan 2024 11:18:47 +0100
Message-ID: <CAPDyKFpx7u8iO4Dx-3oDOSbxcO1CcjoAYJfMtnrrAuSaKozodg@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] mmc: sdhci-brcmstb: add new sdhci reset sequence
 for brcm 74165b0
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: linux-kernel@vger.kernel.org, alcooperx@gmail.com, 
	linux-arm-kernel@lists.infradead.org, adrian.hunter@intel.com, 
	linux-mmc@vger.kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, f.fainelli@gmail.com, 
	bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 23:23, Kamal Dasu <kamal.dasu@broadcom.com> wrote:
>
> v8 changes
>  - Add  subject as "mmc: sdhci-brcmstb:" to PATCH 2/2
>  - Added Acked tag to PATCH 2/2 commit message
>
> v7 changes:
>  - Moved variable longer line to be first
>  - Used read_poll_timeout_atomic() and fixed break condition as per
>    review comments
>
> v6 changes:
>  - PATCH 1/2 Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>  - PATCH 2/2 replaced readb_poll_timeout() with readb_poll_timeout_atomic()
>    based on Review comments
>
> v5 changes:
>  - got rid of  'Reported by:' and 'Closes:' tags for all patches
>
> v4 changes:
>  - Fix for v3 changes that introduced dt schema errors
>  - Fix for v3 changes that introduced sdhci-brcmstb build warnings
>  - Added proper PATCH format and cleanup commit messages as per
>    review comments. Added proper 'Reported-by' and 'Closes' tags
>  - Added comments for 32-bit register access as per review comments
>  - Replaced wait loop polling with readb_poll_timeout() helper as per
>    review comments for the sdhci-brcmstb driver changes
>
> v3 changes:
>  - Removed extra emun arrayfor possible compatible strings
>  - shdci-brcmstb checkpatch warning fixes
>
> v2 changes:
>  - Fixed devicetree bindings for shdci-brcmstb and removed 74165 compatible
>    string as per review comments
>
>
> Kamal Dasu (2):
>   dt-bindings: mmc: brcm,sdhci-brcmstb: Add support for 74165b0
>   mmc: sdhci-brcmstb: add new sdhci reset sequence for brcm 74165b0
>
>  .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |  4 +-
>  drivers/mmc/host/sdhci-brcmstb.c              | 69 +++++++++++++++++--
>  2 files changed, 65 insertions(+), 8 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe

