Return-Path: <linux-kernel+bounces-47528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEAA844EF9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22B71F234C4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80CF101D2;
	Thu,  1 Feb 2024 02:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EML5+2Kh"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E839BFC14;
	Thu,  1 Feb 2024 02:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706753159; cv=none; b=g+6W/Hm5Y/dp4ogQOTPdO2zui37EaHy1e369WJgn3TplcnPax4DMbmCftA9nRdKi0hz/Bn8pZNqbtuKmpzT7f2yVk9cEXY0TOLa3G5H9RyFn8cTNUHP6Pr3W0+Zxw2Uqg3l/cT13WGnC4CRLy7m1yYalRDOgpfJIkMLuBU/kXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706753159; c=relaxed/simple;
	bh=WZKyyU3njHxkaPfTiuVOaKohUtAcLb9qZANIc0cHy6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaUGgsYQj3IERjm8Qfn+nyLQAGEuq4CPhXFaqloJffXKcE3KwtgpTEVb/08j6onD9yksDjqzKHBiXwPrVzFYFg7NkRUoixLp4ADe6YKuPb/C0K6UAqeu36RXr2fdN7OlKOhylROEDlVU702VITVuQotvvRr+3dJfh2nCcNbmo7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EML5+2Kh; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so388918a12.1;
        Wed, 31 Jan 2024 18:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706753157; x=1707357957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CabtX6HVlcsvD8Lc4Od57wI4l06g03/hrDUv1/sVAuA=;
        b=EML5+2Kh5g9Z1EK26kI3zprTTMkJP+Yjw4WiZAvPJvyhHHYgc1k+NE58c7KzJcFYIY
         aY+vYE+ubdI4/CtGoyd3heFPTAskiLzxKuAm1UN0+X+EDmR5B3Av6a80wxUXhoTlcrs5
         Dm76jRdWaoOH8BgFwG3z8JDvHOt4fbq6GP9fptwVNtPkj1SzGNzXjUaSeLENSBM2AhIf
         FvW52bAgiHu8+00iO6jjFtAj7QoAxky5kxd0pCuYoOhuSLx07mbOZqKpFQ2btAKZ2SSe
         zJJN1rTqPZKlIe/ALwlSxJHPHyO7FddgmxcAel6hkzgDbNK19dhoOVMWoBWvmR67wW78
         01nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706753157; x=1707357957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CabtX6HVlcsvD8Lc4Od57wI4l06g03/hrDUv1/sVAuA=;
        b=Yp1d+erA5pu5ah/ZK/cx4hEzQ/PcaB5xaVj0omnzZmOfQeY1J9tz8sxgM7/rFp/cEa
         /OMQVZnXbTJQR/spQtFj3Y6Ky6tXpETNGWkGE82yrsJ8a0Z4Becl056f/JQmmrXSWE32
         +h+T7i0sssGRWPizkY6LorDm6dwL5c8Bg3nE6ecuEiL2DvfJku5GdgYKvrbMv9I6xaW0
         cbJJRMATouYmy9FTaD0GQHuaZG9XcSK7KQjXA8GeiILLsI+Jg7p8PHcm82YtrAj7XPDl
         zGd5X2nTRhwVhw94kcernyScBdH8LHgR+sCn2uqvl2rz0KdjSpmjrlu0CqiArEwXjKVB
         5Jpg==
X-Gm-Message-State: AOJu0YxDkMBSB8LtUkZEvz2zyOhnNl4wCdXjhYi4P4uPiO/kELp+ZcFT
	LD5gG5w1tAz0hGn+CA36qBPDI6a/C3qLhbOE1qME6dFj39AeaQ9oa0YNwOngpECN6w==
X-Google-Smtp-Source: AGHT+IEAZdmadmtlqNJT0DdlQkBf4IfmFoc/IRSry9cgLFX6xq5IoETw0+TLgbp6VWQDYULteetUxQ==
X-Received: by 2002:a05:6a21:9214:b0:199:d9c9:2b65 with SMTP id tl20-20020a056a21921400b00199d9c92b65mr3518060pzb.55.1706753157208;
        Wed, 31 Jan 2024 18:05:57 -0800 (PST)
Received: from dragon (173.242.119.193.16clouds.com. [173.242.119.193])
        by smtp.gmail.com with ESMTPSA id h3-20020aa786c3000000b006ddc30172c7sm10512734pfo.30.2024.01.31.18.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 18:05:56 -0800 (PST)
Date: Thu, 1 Feb 2024 18:04:47 +0800
From: Shawn Guo <shawn.gsc@gmail.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: shawnguo@kernel.org, xiaolei.wang@windriver.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, festevam@gmail.com, imx@lists.linux.dev,
	kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, marcel.ziswiler@toradex.com,
	qiangqing.zhang@nxp.com, robh+dt@kernel.org, s.hauer@pengutronix.de
Subject: Re: [PATCH 1/2] arm64: dts: imx8qm: Align edma3 power-domains
 resources indentation
Message-ID: <20240201100447.GE463595@dragon>
References: <20231214194655.608902-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214194655.608902-1-Frank.Li@nxp.com>

On Thu, Dec 14, 2023 at 02:46:54PM -0500, Frank Li wrote:
> <&pd IMX_SC_R_DMA_1_CH*> is now properly aligned with the previous line
> for improved code readability.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied both, thanks!

