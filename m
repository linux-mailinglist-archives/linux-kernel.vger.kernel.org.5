Return-Path: <linux-kernel+bounces-164756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 941538B821A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F7A1C2287A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5581C1BED8D;
	Tue, 30 Apr 2024 21:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgjgPb/M"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0F71A38DE;
	Tue, 30 Apr 2024 21:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714513754; cv=none; b=dFLs3pwH+baztwd4lbjvT0V5nS7Uhjii3Qtq20cDcveTQQJdjx1QzS7pAdnJsNfJf9sOTvGAqA5zRSzKhDITP6N0sBAwYZfsm/yldJ1WWOZiunmr6kcBrb9xXyJY29UrsYQt5Dx+wpUFRokjK8N+QtPlxzG1dgl2oZO0dgPgHDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714513754; c=relaxed/simple;
	bh=nLG06ZSGLg7o0L3KSTvOS9psqf8/FVd6f5zM+3fNwrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ncdj0n/zR1IUyAVcyNRCWvLpLuW9VI54IrQdXuVIT2r3OrS7OSC2NFu5N/UOgv/3JcYQdNWd2rYwjhC8jOuCx2ssRgTU5jhPulJZEamJyqkAT2Ok8HOEBOMpd3whATUrvYgZrkB+KW9yFZ2CRbAqeHiq8lYkAOxqyLtvzkz/2oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgjgPb/M; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f0aeee172dso226709b3a.1;
        Tue, 30 Apr 2024 14:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714513752; x=1715118552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gQ81DFkgmFb2qWSA0tT95p3yazTu3GOFFQ2uKG4zcqU=;
        b=FgjgPb/MFRNQ/eW2PubnFRztad6PWPoWg3X/NOF1JSKNqPMDF9RGIXb+JL+yiMjJ0n
         i+XJ9MRVMK7nUPdC44nBETGi+/tS3XACiM1kybi7cajYZ2RPsF5pgEeoXr8qA6AmOx6D
         shRoe+SKCxXL8u0RdLBFvvhU9gLY6h1TCz4A8sXTReI9QUl7ZAP214J2Tv05pWSLLC6Q
         Pdh9eWGdiIlFH08bmFRqBCJQFcLONJMIvQqvCDxxYprc4vKprQ9yG+axr4+WlvxCQhJu
         sIycF/cMzhlUPNCPooKDLFEcgOg55/zFkTmZKyJ9ScPI5AdvXcOTjRCdD4vm97U9Mk4n
         RT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714513752; x=1715118552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQ81DFkgmFb2qWSA0tT95p3yazTu3GOFFQ2uKG4zcqU=;
        b=SEdHm98xg2n79aR7S/P9eCHuUTAUbnYIBSk4pUiYcZeNLYjn4rapPcSgDX6C6fBlsF
         8CT+vI7ON1gLpTsvqceKjTvanLbR4zA8NzNTQtIxfr3AE/ZQjSGPAyalY6agWYmc5eFP
         05a2gjFKGGEDJMNGyzLQgM3SiamlLAab3h37EknmGOlAGjg6TWWKoMdrqMC0ioWYCPgE
         /hIYD6vGBbiOE1iJv+EFnEtBl2cjbJUaCXC8oyqWGcz5znvfob//zvHT14Kdn+x947dm
         QboKf7FtHOKc8jMM3swMeHKe4m+ssvlG0F/2MTwXKlM/h8iOvVBk17+z7tmxd1+MBlVn
         ZSUw==
X-Forwarded-Encrypted: i=1; AJvYcCXYLzIJcBD30v2uO8upCIZODgC+J92evz2J9pHYHkhX+/oKJt+d+G5s08EH+6iPVrnb+Lg65SpyeBWJITkks+huPfF5ovYf7G8Q2f76IMwO0eDjYVG5CNJ6ohll0oE3AjAHodEhNbfYnuAXH0/8+QXHNoJ9pFb/EEUaOGnzbY8O7SuSkK/skYPB+syvpaFzbE5ePXdA1KbX4fFZqF39AFGHRk4roA==
X-Gm-Message-State: AOJu0YxYjwdeX14yFIEGoWac7e61shalNwU8UK4UCy2Hfm3sskIEFYTp
	HG0rfO8i5wN3WUb0Jz8zvE1u1UssRqSmp8Z8RdEHC2+FCqmKSEcO
X-Google-Smtp-Source: AGHT+IHQGDfoheQSbpzkVLH56jhhZSeorElzvZNIjh/7FJfIYfrT1165Kn1yMHGcREJjEIUoAW8BJA==
X-Received: by 2002:a05:6a00:10c6:b0:6ea:f43b:b961 with SMTP id d6-20020a056a0010c600b006eaf43bb961mr5803046pfu.6.1714513752457;
        Tue, 30 Apr 2024 14:49:12 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id y5-20020a63fa05000000b005cf450e91d2sm21394224pgh.52.2024.04.30.14.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 14:49:11 -0700 (PDT)
Message-ID: <7d412e48-a58b-479d-9333-066359d52432@gmail.com>
Date: Tue, 30 Apr 2024 14:49:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: Add/fix /memory node unit-addresses
To: "Rob Herring (Arm)" <robh@kernel.org>, soc@kernel.org,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Khuong Dinh <khuong@os.amperecomputing.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Robert Richter <rric@kernel.org>,
 Chanho Min <chanho.min@lge.com>, Avi Fishman <avifishman70@gmail.com>,
 Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>,
 Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
 Benjamin Fair <benjaminfair@google.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20240430191856.874600-2-robh@kernel.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240430191856.874600-2-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 12:18, Rob Herring (Arm) wrote:
> '/memory' nodes always have a 'reg' property, and therefore should have
> a unit-address with just plain hex (i.e. no commas). Fix all the arm64
> '/memory' nodes.
> 
> It's possible that some bootloader depends on /memory (arm32 ATAG to DT
> code does for example). If so, the memory node should be commented with
> that requirement.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> SoC maintainers, please take this directly.
> 
> arm32 is much worse, but the platforms using ATAG to DT code can't be
> changed and I don't know which ones those are.
> 
>   arch/arm64/boot/dts/actions/s700-cubieboard7.dts       | 2 +-
>   arch/arm64/boot/dts/apm/apm-merlin.dts                 | 2 +-
>   arch/arm64/boot/dts/apm/apm-mustang.dts                | 2 +-
>   arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts    | 2 +-
>   arch/arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts    | 2 +-

For the above two:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


