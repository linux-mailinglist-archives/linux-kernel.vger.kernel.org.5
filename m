Return-Path: <linux-kernel+bounces-105128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D7487D972
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7004B281D59
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15F412B75;
	Sat, 16 Mar 2024 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="oc4NeA7a"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D8410A2B;
	Sat, 16 Mar 2024 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710580904; cv=none; b=PT/ghWXeVxez38vfVcaN3wVkan+htOdayyshwDj00nkDe7YFQPQLf4FeUyAztNLEoIwfjb2PGOxQ8HsKe5a1SCL7EqvZw6P7qutCbq9GQ0DQPZhzP7N6J9oj6Vnm6TP7+zCZGgPqjebq1eMPDaMMyQQBLwf/5yEkDocs2rvFejQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710580904; c=relaxed/simple;
	bh=LPAGYnjbWmZmyQzhqu0sgNpOVxYZ0o5NMoAIZ403F/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJSgzeADj368E48jIr/MFpcxDhUiePNZFsixYmUMbtgw68t3hb6O8mavn3yOxFfDf7nqigLsa9HxeNcaVRra8k1vPsAzGFz91yeSujutxs4nzxGzgUeHW055d6puE3cy6vwVAiRdkR+GUK18ncrAFSfBvNybphdQf8YirQeOqJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=oc4NeA7a; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DACCB20003;
	Sat, 16 Mar 2024 09:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710580900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=blfyZg8sXChulnwgaeTe9ss5Hc8woFKCJ7YrVAvwAEs=;
	b=oc4NeA7a2lbUyLYbGfk3WoWDevbVZKqxLeQYY/AdPm3Akb3F3igDWV6MHgCNzhpfLdWZHg
	lDmMVgn5lKg+zRn8kotWZH6Yja1n4vCDSrBxZjWmPBNwjbKyDfkpFTVLczONgVRjPBzoDl
	lCHyHm9PZ1fYBJzhkWhfs/2vxeEMG09mJ8a5D6RfcVKwFKfp0oitdMHDldBG6uPryGbjxx
	2mV+9N/jdhYXg4NFhAwkb9YzEG5cKN5/lwCRJBZlO5/8dqNDG3njL0FRddi6ZZlEmI0Jns
	ZXL3GqTj/HEO5p/PvIOfMVsK3TCWfCONTVC7ySKrDU4rUZ+oRTKwD/1vD4Hgkw==
Message-ID: <97d0f9cb-1121-4be1-850e-cdf154bd03f7@arinc9.com>
Date: Sat, 16 Mar 2024 12:21:23 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] mips: dts: ralink: mt7621: reorder sysc node
 attributes
Content-Language: en-US
To: Justin Swartz <justin.swartz@risingedge.co.za>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
 <20240316045442.31469-5-justin.swartz@risingedge.co.za>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240316045442.31469-5-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 16.03.2024 07:54, Justin Swartz wrote:
> Reorder the attributes of the sysc node so that the
> ralink prefixed attribute is placed after those which lack
> prefixes.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç

