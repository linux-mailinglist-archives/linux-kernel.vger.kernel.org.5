Return-Path: <linux-kernel+bounces-62540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDE185228E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C288DB24CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499B851C42;
	Mon, 12 Feb 2024 23:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhI2faZP"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B4151C3D;
	Mon, 12 Feb 2024 23:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780578; cv=none; b=ctXo8mPO0FAZpTPaZt/SIaDR9w4dlGct93gi7QqphBcywcniEJV8imNOB8l0eHQOCpx9Wt6DYZmVSjMjkY7aE6+AqhRNTK1r/vfPc2ngcqwHl8FKqCXmgIFUZPY2CSfMNnHtXtLnrkEGSyxvedcBLLCSbp1wznp5msxvmfaLq+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780578; c=relaxed/simple;
	bh=CnA2E5hw/1uMDVrWGtZ4T3I504hsK6nWudi2M5cK/nY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jw9Jewusm1+hImU927+hEfUQcOQ7lX9OTWQlyJ6RqbP22dwd9r/T7GwWFtNDdJjdCmCQSIeZ9HuMRnvxmAt1EwKQrqPAnMZsoPfKhNDb4kIVuXnqK25el7nnWH3fHm+weE8IMeu9wgigcXVc0I/qJtqeF8u4OK3WAOUCNU/xo2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhI2faZP; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-511976c126dso277257e87.1;
        Mon, 12 Feb 2024 15:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707780574; x=1708385374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zcaRkfO0BdPvUQLLboOBrKpY6S4NVSBrCTABHk+Uq6w=;
        b=nhI2faZPE8tj/YRYG3wfyy7qdrY3lT0zhmuhAvzIvyJmaUrIcpM2TDzU2Yfl/aQlBe
         1eZ6iRxNBOpD4NZrBbaIUV1QwlHKzrLUuImcOVJGIEGJp/3oOvxnyli8jlc+lbBXP60V
         Is6nDisstou+5APuhsaf+8dE7Fj3JE78F8WeIQbqaZ25J9yW/MFNPb15Vqq5LMRJ8jEP
         r1R54tAOVQPuJ2QakQFVtep6mtrpghNr6DBTeLQ60LgFxe/1P45ngqiMV9FwxebhaVwG
         TF/WGF7fHv+mXyNgkGGGzsntsWHaZ+Xw2Nc0MCf0v/67ZrVJ9tvH44TNZrs6VZ3YYQA6
         ql7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707780574; x=1708385374;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zcaRkfO0BdPvUQLLboOBrKpY6S4NVSBrCTABHk+Uq6w=;
        b=JM2x3wl08LeGX6oO91XMGoFAy+QlNTgbZl7Jr9U3YkeZDyyQQCN5Ch3mCeHIoowLoW
         a9Js4GyMeWtJ3TXP6wtVXvNk6fHvB6IjRFCjiiaU/4HtqrbgUMpaYgc06RYkBEhFsf/W
         snLkk4MTPYoCSS4+wF1v7SSrI6IepeLxsH0/hr0uA1FeN5/LOMdsrQsCooAVbDWfFYef
         Q4/6+SfBwx7zyMucg7Thsxx8vP0ffQtvtIms7wH6PkOjOcyhjxxPic9fir7Uy7Q7QPDJ
         UudnUDRhIa4GzdgEk86wc7zDiKgJvcoWDgAQD9SyQ9uIq6tZgeDmWPVf0z2tAr6szVjo
         zUYw==
X-Gm-Message-State: AOJu0YyhLMGCksK//uOAWUoujyJanvHQl8cKanAzMqGGvqc8ZpfTTJiZ
	I95UKBX716Ww2Nc+nKiud+xJ1Iu/XOiKF1aIqMYzBdI7jYGN2Taf
X-Google-Smtp-Source: AGHT+IFIWtldyJx1XYMEJchXHZMIFVD3PXrL77dt6iWgw83HTQ4i7gIgiIvPexderAlEhkw5ifbIoA==
X-Received: by 2002:a05:6512:328b:b0:511:5c98:ad2d with SMTP id p11-20020a056512328b00b005115c98ad2dmr4693198lfe.2.1707780574106;
        Mon, 12 Feb 2024 15:29:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXrPlPj5K670alAYmGzlZyfWqvPH3kwwjcqPP1g1Krm6r9bTOGE92Lmo1q6S1bExz5OJqz78F7Qm1SyGIeWMeydbDjOFCL7MW/1SCQkC1dy9/ArQ1bhSuvoQRfr+j1zUSHknPaFyNv4cNjRYbJADAQtICkElxN4PwaIHQqyLm1SsPGxhZrQJwoe4qjbHyZKctGZMBKkRzP/9CnbNJBhqD7BT/ymKWnJHyUqicfHtKG3M6CR0+2PeGY+iER3DibEhbyYN4jyWmjGfoO0Hs+n1iabvRgW7AQOefxaVcW1K5EVq2ATHOesYtdMIcsIzXR7+2ZQh5OxfiJkoBlyNDKwHJo7DpsmXxW7NYvKHMEvEMUa9FhG9jUWc1fweMjGsFS6bFu7y549eon9JUlZU5CmhGZnMegJPwnU52hDb4W5gqVoJ2jLlLaWj05aUOYpU+wiBHclQF2GmVjIn0zNuyA0CJc4NAucxk7v95lBrcYaGvH3gtLFAewbjPd0lqDRN9zaVMI1MrOeGRHrZqMkJ/L2bxQx+RAggjBtyUdJU9AQfXBfpX1+eSOo71EVtFHuh2h7MVhWqdU+Gnf0fM9P03/QP9PULseUpJlMZoBb+KrbsbxPm0=
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id ca20-20020a170906a3d400b00a3c49c5aa85sm668989ejb.126.2024.02.12.15.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 15:29:33 -0800 (PST)
Message-ID: <b89552bf-cb04-42b1-94ac-5529205b3be1@gmail.com>
Date: Tue, 13 Feb 2024 00:29:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] phy: rockchip: Add Samsung HDMI/eDP Combo PHY
 driver
Content-Language: en-US
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Andy Yan <andy.yan@rock-chips.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Algea Cao <algea.cao@rock-chips.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, kernel@collabora.com
References: <20240212-phy-hdptx-v3-0-2cde680cd024@collabora.com>
 <20240212-phy-hdptx-v3-2-2cde680cd024@collabora.com>
From: Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20240212-phy-hdptx-v3-2-2cde680cd024@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/12/24 19:52, Cristian Ciocaltea wrote:
> Add driver for the HDMI/eDP TX Combo PHY found on Rockchip RK3588 SoC.
> 
> The PHY is based on a Samsung IP block and supports HDMI 2.1 TMDS, FRL
> and eDP links.  The maximum data rate is 12Gbps (FRL), while the minimum
> is 250Mbps (TMDS).
> 
> Only the TMDS link is currently supported.
> 
> Co-developed-by: Algea Cao <algea.cao@rock-chips.com>
> Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---

For Linux FTRACE filters it is needed that all functions in a driver start with the same function prefix.
Currently there's a mix of hdtpx_* and rockchip_*
Maybe use rk_hdtpx_* ??? similar to for example rk_nfc_* in rockchip-nand-controller.c

Johan


