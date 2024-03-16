Return-Path: <linux-kernel+bounces-105134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CD387D985
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9CCDB217DC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A999E17BA6;
	Sat, 16 Mar 2024 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="YqukWb12"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85FA171BB;
	Sat, 16 Mar 2024 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710580980; cv=none; b=NckiByXLCb9t0QT++MW/cmB0O5rgNS3K2wy8hBrJnRV55F4KEUYv8ZYx6RPUyVDHh2XFsNUynA2F0MuGJhb7FZXSVKpnppz0OABmjZJuci91ZpeXftE3eYfUqaYDbtszS4C9F/aIrW/GGmLBZuyeYWrnT1U94PCORi3lzNTIEt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710580980; c=relaxed/simple;
	bh=ei1caCcQhpERFGQ3/s9uQAHI3siPZdxeDybAfzbw6rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EeHny3f6aAUHB2PF66MQYcKjHGAkahhxmyvnYuIa6H6mA2UprLVBqF2LQ8qA1aLiq09eNZ3nr0Jtl5jprEM+a8+xQMl01ExQNAbKvVGqlLCc45dtssOvNWwphIBlSFceDQMlBWp6ebzmoa5Z/1qykKDD1+y2O1UIWDhwoTWyi5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=YqukWb12; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A2C73240004;
	Sat, 16 Mar 2024 09:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710580976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hv+UwewAEKLX3sRoKbyFtr4qE0xFXncm9vTyaUOdRzI=;
	b=YqukWb12YnFeAGKUWMIudHEEZSYVNZI7THHp21YLt4YIg1c5WX0q0sqeyhtiy8yw61mzP4
	CE4dVws9FLgR5Uj7CJiSaqEsQiCd3czJARh/25PsBlm5I4MLaemSsvUhG3EXnseQpwWTHB
	+JX3YsfuW4gX+3XwZiYR3q2OuGJtIermSNgSQhlk+9ndCoAToW9VNlFM0KDC4C3dSb0RkY
	n70VO7nVqVUZg+rqZnf5WcBl7+s3KUsluwZjknVuJYECYp9NQQk6QAu3yABln0Yq49w31d
	PDEwy9UGQ4EBjY8+Mn4/q6KBT6Krgdjx7ukV2Irkzo9cE1Wkqrhvo4zWKK0A2Q==
Message-ID: <484b0699-2be4-4e0c-a60a-73d15702b6df@arinc9.com>
Date: Sat, 16 Mar 2024 12:22:38 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] mips: dts: ralink: mt7621: reorder gic node
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
 <20240316045442.31469-11-justin.swartz@risingedge.co.za>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240316045442.31469-11-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 16.03.2024 07:54, Justin Swartz wrote:
> Reorder the attributes of the Global Interrupt Controller
> node to fit DTS style guidelines.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç

