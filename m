Return-Path: <linux-kernel+bounces-7061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9633281A11E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1741F22CD4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4C738F9A;
	Wed, 20 Dec 2023 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RT4mppbm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B1E38F82;
	Wed, 20 Dec 2023 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 146D81BF204;
	Wed, 20 Dec 2023 14:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703082515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nC9eF10X2lqjXUL6MHDbsTgCI+eRXF8SsKwjlAptjRE=;
	b=RT4mppbm2rdD1gnbuOzoHcU5HifXFlcTA5K/KZtHQyKfty1O17bAxM/TsE0zMA50u3m/+J
	S5p+eq4fA5BAzX32zGX9fOOZqX3uIp6gcWa+EceDeXjbLFUxouXPvSOzuxx8wcM1Wnu+AC
	GLnJkB1U5/RTCzr14lpOZIstS7ekMe6+Nmhh5uptn9GsN1ReL/aPG9BPfHlKPmcp+VIcQ3
	HbjZ18wOTqpbGyA3OnG3J8bKajGpakUvka/cJLtXgZsnqopxDUZhx36NDJJqCKOhlXy/gX
	w7ah9HhqVScaydaf10sHJzH1ACX0LT+27zjy4AZa1MirlkgTbizc2gtQDdeG0A==
Message-ID: <52b10a61-ee3e-4166-a9e6-f417f2f5ea5d@bootlin.com>
Date: Wed, 20 Dec 2023 15:28:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] rtc: tps6594: Add driver for TPS6594 RTC
To: Esteban Blanc <eblanc@baylibre.com>, a.zummo@towertech.it,
 alexandre.belloni@bootlin.com
Cc: andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org,
 linux-rtc@vger.kernel.org, jpanis@baylibre.com, jneanne@baylibre.com,
 u-kumar1@ti.com
References: <20231107094701.2223486-1-eblanc@baylibre.com>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20231107094701.2223486-1-eblanc@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com

On 11/7/23 10:47, Esteban Blanc wrote:
> TPS6594 PMIC is a MFD. This patch adds support for
> the RTC found inside TPS6594 family of PMIC.
> 
> Alarm is also supported.
> 
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Tested-by: Thomas Richard <thomas.richard@bootlin.com>

-- 
Thomas Richard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


