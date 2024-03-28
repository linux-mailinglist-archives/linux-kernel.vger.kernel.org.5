Return-Path: <linux-kernel+bounces-123662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31924890C54
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC761C27B81
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C8513AD35;
	Thu, 28 Mar 2024 21:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="TtnrXRvD"
Received: from mail-108-mta62.mxroute.com (mail-108-mta62.mxroute.com [136.175.108.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1168781752
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660606; cv=none; b=IVtAkE+u4LPGGymD4N0xPYjYCQQSYH3MXyLU4VE7m1hxrFvQ8gYFZKN0CWaAscosRXnc6QXzm5JuVGu+XtsxgxvonP7vE/f64dfncVqmQ7dag0FGlc4JiH0sYwQhM2f+CWpBD0awQk4mnLr6/ywj0iuRJQ2lwsCr93yJgsjd4d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660606; c=relaxed/simple;
	bh=SmKe/yhbdoqPTkVgza3Z9zpPopSENs97/wuhoRbvMyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLqja551fbYEAeyLS1nqY17wNatTF6aGDgQJmTz7mal5VozVdwLGVaQCKmW6Hi4J/bcB00RH6vJki+ox6yGfLrtPmwjozXRjswTQeqqOI4znq84BMKjwDOV3SSyuwxukQdIqT0vQH/WzEE2Ld0hPKXvrvTgLmFE1nUN6KTUwL/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=TtnrXRvD; arc=none smtp.client-ip=136.175.108.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta62.mxroute.com (ZoneMTA) with ESMTPSA id 18e86e7622a0003bea.00f
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Thu, 28 Mar 2024 21:11:34 +0000
X-Zone-Loop: 14224bb77f06c886ee90ebcf697a8eb84cd67e2340d4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U3vA31p2lCcvrgxArhpPfKr/obl7YqxdRKOAsY1yIDU=; b=TtnrXRvDf5iKOq9md3gYBJgkd+
	50j/o9jDkhCu8YIyPGLZw7E8WigRPTOJ4G4Nrz0UCRzmgneGbOKLcrTJ04VfhTVa/2PLU/ijkI1G2
	ww+ltK+lO8BBfeUpQt/gsDb6UcypvcsIvwstVAEF58qAa4Lj+wffl5isvD+HbVFRsOlEBvtkPkqbp
	jS685hwqLYFwrghjaoXJwzVL5nVp3gsf9/Z/lR2OsKS74T3OIFF1Wik5emFkVsK7JMbVJcnTliM+H
	gqLdWV+Kfb24IjgwIP54HbSboM9aPHHavSSpL2ruScZxIHMi79z0E7fJ1Kmp7UKA3p8qcOMCNcg3Q
	kAi/Moww==;
Message-ID: <9cb0756c-466e-4e1c-8eb1-3a98bbfa0cac@luigi311.com>
Date: Thu, 28 Mar 2024 15:11:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/23] drivers: media: i2c: imx258: Add support for
 powerdown gpio
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
 jacopo.mondi@ideasonboard.com, mchehab@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 sakari.ailus@linux.intel.com, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ondrej Jirman <megi@xff.cz>
References: <20240327231710.53188-1-git@luigi311.com>
 <20240327231710.53188-23-git@luigi311.com>
 <20240328204841.GA318468-robh@kernel.org>
From: Luigi311 <git@luigi311.com>
In-Reply-To: <20240328204841.GA318468-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: git@luigi311.com

On 3/28/24 14:48, Rob Herring wrote:
> On Wed, Mar 27, 2024 at 05:17:08PM -0600, git@luigi311.com wrote:
>> From: Luigi311 <git@luigi311.com>
>>
>> On some boards powerdown signal needs to be deasserted for this
>> sensor to be enabled.
>>
>> Signed-off-by: Ondrej Jirman <megi@xff.cz>
>> ---
>>  .../devicetree/bindings/media/i2c/sony,imx258.yaml  |  4 ++++
> 
> Bindings should be a separate patch.
> 

Ok ill create separate patch for adding in the binding and then
a follow up patch with the other half that actually adds it to
the driver

>>  drivers/media/i2c/imx258.c                          | 13 +++++++++++++
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
>> index c7856de15ba3..0414085bf22f 100644
>> --- a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
>> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
>> @@ -35,6 +35,10 @@ properties:
>>    reg:
>>      maxItems: 1
>>  
>> +  powerdown-gpios:
>> +    description: |-
> 
> Don't need '|-' if no formatting> 

Done

>> +      Reference to the GPIO connected to the PWDN pin, if any.
>> +
>>    reset-gpios:
>>      description: |-
>>        Reference to the GPIO connected to the XCLR pin, if any.


