Return-Path: <linux-kernel+bounces-164416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4A38B7D65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DF1F1C2345A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662E517BB20;
	Tue, 30 Apr 2024 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a8IZPujo"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ABD17B512
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495579; cv=none; b=FZhLzs/sUQxHccWUIAEMxPEimPFkQHIX9PZLEf7aRELN444D9sx/IHnV/GmP2Co0080Elpfhg4MMaScYNR3FFa+i3NQOmfQhqoCC35TrdpVJYFyNmwkdoEwmybX4M/EA7g7BoFS8dukEJNju4xpoEOcvPkVWXJneFe5uUD3OQMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495579; c=relaxed/simple;
	bh=qzU4VbzUFeRv/W7BTSCws6gfXSQSS7oC0XCRshZUgAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9BdRpg1kHhFiS5gE+OzWbX/YytNx73qZwTNrR50kzncesVkr9ull6PhYK9EonZ4ZABnpRijO19zfpceeBSJkYtLEJmGJggcr8I88fY3yGFq0LLt/Ob0MLLQGBJKFEEP5FIW3sumHsliFTWKW/q8RE+rk6ftu/ihutdogK0Qetc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a8IZPujo; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6ed3587b93bso3543591a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714495576; x=1715100376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zCeSwrp/mNlBdqA3TllWYVD3pWNYe1arwo8/uJ5j/aA=;
        b=a8IZPujoT8PWPVsnoC+6V8FQmnBjw2oP/JIabogN8yiTfvMDrTthxyIP8BbPet1tlK
         xmoBfKjs3vHFE7hwfgMu5BRZefSBf1hIQTpNZXB9k6wohCQAY6mCzi8UeEgciND8N1ls
         xCIQifgDDFf/CYpMGHhRRAauo65ZJfl3w8cHzaB9G1mI1zSJCuJr3IUs8YIce3dp/fRV
         vVfHpMKyfpoqCxBeMUeUSvxVu0l1ONM501E3W2AfgehzEqij27xvq86Uy9IMkFPOG9Pr
         kVmzPdihzyovvDB3QBxigHR4yonjgzo38lO3cxh/x3kJpwrJ7V4joQWq43ZlJVtsnF/C
         srpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714495576; x=1715100376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCeSwrp/mNlBdqA3TllWYVD3pWNYe1arwo8/uJ5j/aA=;
        b=N9Be4DbJ/dxjc5x6sI4g6Z/f7RQ92fx0IQJFJPGc9XIwYtJvjhA62JbJcr20AhHizp
         zzqyA/iW+T4TjE+NwLXQ1D/GFcHLj1l729lRtKWyCsu5l7grxK11BcSue3znzJgJbwE0
         k8xi15X9fNUlxLU2C906X/JzarSRsxg3KOsF6axoWhd3591z7qNGOiX0Fyk1sHugUjJx
         aR5APNWglVNVQk2f+ljbkgdFaBzp427F/+lfum6dAGjQJFRy42ySaVU4SXx1Q7svvYZ5
         0QpFDhz1506yCu3kcWcrphXtqHV1emff7sMEsVkVc/upjYLqy3QwdM8gpibhrDbHDmKu
         Iv5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOVvRGeUNN8fPdQUu1F43beLqwMJF7VrqZzlkuW0H3IMQfz6C4IzPkp5gfwlLoLNbZk/8HhoPPqwkgvJrWqEJ5fDc2xJgrLRC7Xhad
X-Gm-Message-State: AOJu0YzS6PXuyE4Szo6tbnSVmEWotFgKy+Hfr7Dlumh0ex6ySsrZi/ut
	UozUUAFvIuTdLzItomcrDb2KSbWcZbzyZkHtSQCjayklZzsIiqcIyyz+/2gtF94=
X-Google-Smtp-Source: AGHT+IH8F1std92hvf4fXAZ5Hsa2XfNZ5XXJItRDYaUPxJEOGBg3MYvwiNgKSUGo270d1I21pwkKsA==
X-Received: by 2002:a05:6358:52c7:b0:183:b7a0:8aa with SMTP id z7-20020a05635852c700b00183b7a008aamr432390rwz.13.1714495575942;
        Tue, 30 Apr 2024 09:46:15 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:2e09:6862:d789:2631])
        by smtp.gmail.com with ESMTPSA id t15-20020a6564cf000000b006148e35166fsm2898855pgv.87.2024.04.30.09.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 09:46:15 -0700 (PDT)
Date: Tue, 30 Apr 2024 10:46:12 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Olivia Wen <olivia.wen@mediatek.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Tinghan Shen <tinghan.shen@mediatek.com>,
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	jason-ch.chen@mediatek.com, yaya.chang@mediatek.com,
	teddy.chen@mediatek.com
Subject: Re: [PATCH v4 0/4] Support MT8188 SCP core 1
Message-ID: <ZjEgVMj5s62pd3Db@p14s>
References: <20240430011534.9587-1-olivia.wen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430011534.9587-1-olivia.wen@mediatek.com>

On Tue, Apr 30, 2024 at 09:15:30AM +0800, Olivia Wen wrote:
> Change in v4:
> Updating the description of PATCH v4 4/4.
> 
> Olivia Wen (4):
>   dt-bindings: remoteproc: mediatek: Support MT8188 dual-core SCP
>   remoteproc: mediatek: Support MT8188 SCP core 1
>   remoteproc: mediatek: Support setting DRAM and IPI shared buffer sizes
>   remoteproc: mediatek: Add IMGSYS IPI command
> 
>  .../devicetree/bindings/remoteproc/mtk,scp.yaml    |   2 +
>  drivers/remoteproc/mtk_common.h                    |  11 +-
>  drivers/remoteproc/mtk_scp.c                       | 230 +++++++++++++++++++--
>  drivers/remoteproc/mtk_scp_ipi.c                   |   7 +-
>  include/linux/remoteproc/mtk_scp.h                 |   1 +
>  5 files changed, 225 insertions(+), 26 deletions(-)

I have applied this set.

Thanks,
Mathieu

> 
> -- 
> 2.6.4
> 

