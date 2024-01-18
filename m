Return-Path: <linux-kernel+bounces-30239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C1E831C03
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF474284357
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA6A1E884;
	Thu, 18 Jan 2024 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dDasMuKO"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD851DA39;
	Thu, 18 Jan 2024 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705590508; cv=none; b=IgqfValUCofln7iMzQC3N3NjoKpAjKDJpdnHPNyWcI3C5KIDkIjISF0e6fP2cMUi1JcCHEsN2nU5T79i5z2iHjjxVJ1SOSKVkLBByAKZUsO0OsnpTYwjAxl/w3a/UVdbPaEssuLCm2FmDDMV6rVmhG6NvMWkco2/EO31vlmox6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705590508; c=relaxed/simple;
	bh=xG63ptXfgfpddL3ZDZjgviSVKaNelChLn9GLTViB+qQ=;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-GND-Sasl; b=L7+KKaiv3ZA9on6DdVoj3EFCjuCDobcsip7/inJ7yaO2x/GI2QgqcE/E6dTg0fKRVS6lpPrPXxemqgi1mnk+rLcO9VcbqK5t+WIS2BWxO3qch6NZo+uoBm0+uwNyxu2k9nfhD2Z1PynoBvOGpzUlqrHq9cgwrcTtnN2e3dPMT7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dDasMuKO; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8F2E21C000A;
	Thu, 18 Jan 2024 15:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705590498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iQAD/UZ9fh1/qpvfDjH4Pqz6jPjqTD3KaK9G915cbu4=;
	b=dDasMuKON9WYTKRaN0Tfbw+RYw3WU7gTWGUbz1JamL8FOStdmKWdb1E0dyTgiX/p8ByiFI
	tkgPTpqB/KUSOljb+sxj2B6FHCnS/ALJTpIAUa+YTlKu5GUNtCGj3ocG9EMqzU4mWOKbyL
	HkRcALFq4+k/n8r3xP5qegKKEDdhXY3KZvs5xWDx2EkedVbOiuFAwTz5yZLQrMfyzijMH9
	aOcNjlHPXKItvCmHLsSy/HZidCyP1vHrhFHslbVVcAADt6ajd4HTZoll5LIih0Q+UuzV1K
	rZ56PHHHhSHls5lAMpnF51Wba2nxxnPzws6yf0tECPrF0vDAU5M/3DT4bDE9zQ==
Message-ID: <000e823e-ede1-408b-b8e1-fd9c1c73fd6e@bootlin.com>
Date: Thu, 18 Jan 2024 16:08:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] wifi: wilc1000: set preamble size to auto as default
 in wilc_init_fw_config()
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 David Mosberger-Tang <davidm@egauge.net>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org
References: <20240115-wilc_1000_fixes-v1-1-54d29463a738@bootlin.com>
 <170557027237.2797779.2354857290141885659.kvalo@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <170557027237.2797779.2354857290141885659.kvalo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hi Kalle,

On 1/18/24 10:31, Kalle Valo wrote:
> Alexis Lothoré <alexis.lothore@bootlin.com> wrote:
> 
>> From: Ajay Singh <ajay.kathat@microchip.com>
>>
>> Changed the default value preamble to WILC_FW_PREAMBLE_AUTO in
>> wilc_init_fw_config().
>>
>> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
>> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
> 
> The commit message should always answer to the question "Why?". I can add that
> if you tell me what to add.

Yeah, sorry for the lack of description, I may have forgotten to update this
one. I suggest to update it with the following message:

"WILC driver currently applies some default configuration whenever the firmware
is initialized, and sets the default preamble size to short. However, despite
this passed option, firmware is also able to successfully connect to access
points only using long preamble, so this setting does not really enforce short
preambles and is misleading regarding applied configuration.

Update default configuration and make it match the firmware behavior by passing
the existing WILC_FW_PREAMBLE_AUTO value (2 instead of 0). The updated setting
does not really alter firmware behavior since it is still capable to connect to
both short preamble and long preamble access points, but at list the setting now
expresses for real the corresponding firmware behavior"

To give a bit of context around this one: I do not have access to the firmware
internals, I just took the patch from Ajay and I merely did some tests around it
with multiple APs (basically, making a WILC STA connect and ping the AP), and
ensured with wireshark to get at least one AP be really "locked" with long
preamble, with WILC managing to connect to it.

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


