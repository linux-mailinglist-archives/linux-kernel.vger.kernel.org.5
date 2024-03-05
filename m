Return-Path: <linux-kernel+bounces-92024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438548719EA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2ECE281A09
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A2D535D1;
	Tue,  5 Mar 2024 09:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lFsPXPEf"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDFA5025C;
	Tue,  5 Mar 2024 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709632141; cv=none; b=qWFRzjaNlx0C8LPIbv2V4igeERT1dNoEnqbTz+WOWnofQ6shNiZM3U8OP749OFVya0TO4QuKibsC2siiKqwTq/hD2JKG4OcM3PtNAtrHSFx3PtHzyssWC50WBTMUl40faiKtgjAFoQhKcDedkkGQSo9FnQR71SHB2bJ0qV017w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709632141; c=relaxed/simple;
	bh=urqg0xbTeQw3SaHu2oQpg2NmfCmTqZ8GoiV35udIfjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INJ+vUy2vyLZrEAoUWQsxGl8+9ww66Ki9WVR4tpFV8Z0qooscUPyypUhoXMbCYWTNgAe/42K/I8rgOKGyeL2R0mmdHyt2Opgp+CJBnKkFTxwZyHNTJNh1k7OlLegFUyr9IgbPqLykutokOqY3l5X475WXvl9mScw06NW6T9j0YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lFsPXPEf; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 472B91BF206;
	Tue,  5 Mar 2024 09:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709632137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aw8pUe0MID70y933FGi7D+L6M1sIf5ieS9mZ3leciLE=;
	b=lFsPXPEfA66AsRtfkm2k0eqMO8n1R78NnQCu16rwl0rxXnz1zd7Ic+aZQlxddbzIuTyf/Z
	Ievu/+b86nO9T9w2JTRIBH6c5r4NWv9f81PuuHn8L7qIYblvipiPu/xvJ6HcSdpHD4ynLT
	847BOix813JmNH1STAadsZNqxyNrLOF4IEvjnLvGZcHH5JQi1n5e9wEGQQZYRbF0Z54+Ci
	iz9i9HwLa8j19Ll+bHlEt0JJ1eRRjLabj5lad2uNs6msYLDYsqNHrBSwWxTlZOl2voOCar
	igBw08xlhiqKo4lNiZijWksSW9MsrTOmnYq/1+58thF/v47Jm406t0GV90eIPw==
Message-ID: <5c3acbaa-dc95-4f8a-87cf-c62b6ccc442c@bootlin.com>
Date: Tue, 5 Mar 2024 10:48:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] panel-simple: add support for Crystal Clear
 CMT430B19N00
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Yen-Mei Goh <yen-mei.goh@keysight.com>
References: <20240304160454.96977-1-jeremie.dautheribes@bootlin.com>
 <20240304-drivable-property-feaeba782880@spud>
From: =?UTF-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVz?=
 <jeremie.dautheribes@bootlin.com>
In-Reply-To: <20240304-drivable-property-feaeba782880@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeremie.dautheribes@bootlin.com

Hi Conor,

On 04/03/2024 20:29, Conor Dooley wrote:
> On Mon, Mar 04, 2024 at 05:04:51PM +0100, Jérémie Dautheribes wrote:
>> Hello everyone,
>>
>> This patch series add support for the Crystal Clear Technology
>> CMT430B19N00 4.3" 480x272 TFT-LCD panel.
>> It also adds Crystal Clear Technology to vendor-prefixes.yaml.
>>
>> Please note that unfortunately there is no public datasheet available
>> for this panel.
>>
>> Changes in v2:
>>    - add link to the Crystal Clear Technology website in commit message, as
>>    suggested by Conor Dooley and Neil Armstrong.
> 
> You forgot however to add the acks that I gave you for the two
> dt-binding patches.


Oops you are right, I'm sorry. Should I send a v3 containing these acks?

Best regards,

Jérémie

