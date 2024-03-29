Return-Path: <linux-kernel+bounces-125062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21846891F6B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5AE31F30DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D711553B4;
	Fri, 29 Mar 2024 13:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N8cvRHyP"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CA425777;
	Fri, 29 Mar 2024 13:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711718653; cv=none; b=J9sSjPE/PIWueRrf3mc0Gz+doWHXM23cwayy/7d7ofclr+k6fYRInM6THrGQq7UDfE1Z0zaJrE9flVcLU1KcVxY77kramIb1cmwm4v0erc/MrJM97rfZ+8goNCRYtUWDMKCArHFQT+Ay3/mJVdmXWFQegfT8KHUHuVFPDWpLv38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711718653; c=relaxed/simple;
	bh=v8mIn4wI6Nk8yWeAoiTyvSclm6AdbmqShOByjQ1EiZc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FG/cnH8YZZ1I2yrbos280NLbVVeD+xqcLXGlfKGVSEos1i/dqAuIdY8SYO7NzFSwgabwrXi9lgtMXRCDvn6hxLUyTpz5EGbQVENJNgUrewl7pJzOnBHD8Ks7k2DFCP6b6OdLup0ouQUP6D4B+mgyTBbtkuIOqflgds38If3mjB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N8cvRHyP; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DFE1FE0008;
	Fri, 29 Mar 2024 13:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711718648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8zwe634gu5wQNCVCxvtpKe0aX4n7o17eGhcQXcT/N4=;
	b=N8cvRHyPJgw5j5LKkih7d26o4xz2NIuPQNXKFj8uupd470/nXWH0scfZaHHEl3j9CKrBex
	Pbskzy//s8gOQPW0Q9RyQ6c6e6pf+5HxiHLme7pdkxLnOW5BEkSDlSNai8dTMispVpfws/
	hLchxIIMJdRL9lZzAYWvm3+M0LJCFePBNb3hgl4yEe6YKKbSw+vwZuovy5Yywy4bpJw4mb
	KIdJHjIhBxrWkPrLV2Q9PnSYK7cgJP063BauaJRtBMkA4rsytPkNKxJG5OQUu7EsZeBmQ5
	XyV61Cs61Per8cmpSkvlDdInL17uL9nbTK8mu1ED+Jqje3CvdwTG/6T7JXVqIA==
Message-ID: <106a9957-cf7f-4789-8edc-fdc641cd854a@bootlin.com>
Date: Fri, 29 Mar 2024 14:24:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] ASoC: ti: davinci-i2s: Opitonally drive DX pin
 during capture streams
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, herve.codina@bootlin.com,
 christophercordahi@nanometrics.ca
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
 <20240315112745.63230-14-bastien.curutchet@bootlin.com>
 <00182d1d-ef29-457f-9e3e-6e9b57592118@gmail.com>
 <0bb26153-8bcb-475f-8892-5eb925fec538@bootlin.com>
 <7925bbe5-17e8-42cb-a5f0-4f3e06810a90@gmail.com>
 <d20dc37c-13fa-43d1-af52-dce8d8dcdd75@gmail.com>
 <5467add6-0099-4e54-a4f7-12aa149d03c7@bootlin.com>
 <e6994ff1-6c32-4dac-846a-5f4f18b2f996@gmail.com>
 <16e6cded-33c1-408c-9bfc-b0b9a8da4cbf@bootlin.com>
Content-Language: en-US
In-Reply-To: <16e6cded-33c1-408c-9bfc-b0b9a8da4cbf@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Péter,

>> Can you use aplay /dev/zero and a DT property to select T1 framing for
>> the playback? Or that would be too coarse for timing the start of
>> playback and capture?
>>
> 
> That's a good idea, thank you. I'll try this and come back to you.
> 
>

I tried it and it works fine, thank you.

We still need to run some performance tests before fully adopting it but
anyway I'll send a new iteration of the patch series that drops the
drive-dx part and just keeps a DT property to select T1 framing.

Best regards,
Bastien

