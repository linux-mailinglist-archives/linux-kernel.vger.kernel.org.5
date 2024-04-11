Return-Path: <linux-kernel+bounces-140202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC888A0CCD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4587B2124C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BD4145B05;
	Thu, 11 Apr 2024 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="darnnQxc"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A0313FD80
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712829006; cv=none; b=dOZFnRKLZKqp3tg19xlqFBtuZ+4Xy28of9LdkmJMSXINC5ZAB1GmbWAzgdTTHymVjOi3sRlPi1CO3lb4VeXQ4VPGiSVMF3U0mAOeTxw3NAZNi64ZjHy7jgrhY1UwOqrMz4Mxg6zeHmwNDaz3nIRkfsR91xmzDG9gd8Vsa30ceuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712829006; c=relaxed/simple;
	bh=6Rtgkt8tWqoIigwBFijC9Y1w00fEx3L8QiXMXAulxv4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FG9BsdwCazXFpQQ765A28hX6FgnPOa47NvJ3EqKnE1vXWnM/0SXRPZibLA8nRh2rCJSKSWowtcmoFBC4NFrIy7yL+5FbD7IDlTjw67GcAkFfB37egA9fvCQJboEFBA/cDx8rEHqzgXeEk3lqvTxJza2EN2X0fjnu6DKdK+Fr6xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=darnnQxc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-417d42dd5a4so3554445e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 02:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712829003; x=1713433803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPQJJp/mQ3ASEgmyqn/FrA7Op/MFUN8aZ0h3ZId51G8=;
        b=darnnQxcS1OSPODrAny+6gbRHAFmctMFG0/DbQ7FDl6y37FsJx3F3U/Jgzo2g8OZu0
         5UxSwDKsTNFahSXYX0MNIJMokg+dxUmip2zQ1i/jFb0xIPdElGhTUQ2fySWCYN9l6gxp
         J+PHym67dfj3+ojO1TgQru3Ju7p5kIVb0ODC/opgsETAB4u7FU4R0mAyhp25aRFd3PVy
         g++GSwBI8m6YjumH7iXilWH31i/JXaBIsYEjS6/2DsJeHBf74HakUKqg3pwkB9OdWH7h
         9HvNzSE+9QhuhgeXKZEJQj8VAMib6/Gcxd7hByCiJwwjTogihushFA06wAa/NWIzLFyE
         M0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712829003; x=1713433803;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPQJJp/mQ3ASEgmyqn/FrA7Op/MFUN8aZ0h3ZId51G8=;
        b=HPgqqAuv42o3Ocxk2GU94x+v0vI/nDBulo4miAyhR6AE8ArzsGJ5QwTNUv1MxGaQnG
         daEqHu7OKIRn/dmt4zR6HWnBrPPRn/9Cfm0+KyGw0I/qbv5Nnv8lEO2TzRP1xeykMOUe
         IFIna293tLvNRGK6hRVczst+CptzutlMRC+9XLdTvdGMaJS9Rnb9OvGNDRzPK4rZ1B7G
         zRx48TRZu0UYtz0fUbtBqAy20RXn/whz/YLUUHR1+uv0fMLBSA9zIXpUIghdgwpp/5mp
         r8ynO5+4x3OuXwVMJWRdBVLY+xfxQg4yMqfI8K2CRsI++jDEItejdtwZPbOLlyOjvaKj
         Kl5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEx1ANI1Er0YmrZcpg9Bomu/DAAV/NmUyb9MFS3ePNiXDqYv37yijTNApThNzDZ1DXpgufaQuFuUQe/q+2iVHQRJuIbLtdw/zCwjS3
X-Gm-Message-State: AOJu0Yxoq8zCopiIOitlyvO3DlOS8qQj1QASsK6e/9pJOTVrZ/EF2Xhl
	eCFSHCEzdMN/DpwpvZZz3zKlVME58HPLjQHVNcDbMM2CpIICfHUhbr8O4Rto6uY=
X-Google-Smtp-Source: AGHT+IH0e0UOosGzS21RgtNIpgSEjndqk/+zayFytBbkrbw/3YvQelBToR5Os8Vg8YpzKMjd2b3EiQ==
X-Received: by 2002:a05:600c:2494:b0:416:3478:658c with SMTP id 20-20020a05600c249400b004163478658cmr4416146wms.27.1712829003248;
        Thu, 11 Apr 2024 02:50:03 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c35c400b0041638a085d3sm5047666wmq.15.2024.04.11.02.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 02:50:02 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org, 
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20240410170129.248361-1-krzk@kernel.org>
References: <20240410170129.248361-1-krzk@kernel.org>
Subject: Re: [PATCH] slimbus: qcom-ctrl: fix module autoloading
Message-Id: <171282900257.158197.5427243198462918285.b4-ty@linaro.org>
Date: Thu, 11 Apr 2024 10:50:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Wed, 10 Apr 2024 19:01:29 +0200, Krzysztof Kozlowski wrote:
> Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
> based on the alias from of_device_id table.  Pin controllers are
> considered core components, so usually they are built-in, however these
> 
> 

Applied, thanks!

[1/1] slimbus: qcom-ctrl: fix module autoloading
      commit: 772be93c1c247d006bac1a7fe967864d90a34415

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


