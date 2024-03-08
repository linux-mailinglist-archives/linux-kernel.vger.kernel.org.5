Return-Path: <linux-kernel+bounces-97280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D11876832
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D7F8B21D8E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4B631A6B;
	Fri,  8 Mar 2024 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="OHsI/YvN"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B1C25753;
	Fri,  8 Mar 2024 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914482; cv=none; b=WYLdcxZe0EUuPhI7XEWz5zhO4xiJRwZI6lfK1iJw1oI9qw3NLaVp4ygEYr6TAJ5sVXnsBM8J5lLo3n4cG1jrk49+WB8B/oaCfSwupOvxn7ZWxYwp/5fkXUugfWNxjAJrSkyO8dKsAoztpDTCyRRALqcOf5oa+F9FFZoyqfoQwf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914482; c=relaxed/simple;
	bh=SUhhEZz0sdEIfLB4Sv9ABBqxuOC+BHvPzsCIOKtZDxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umQtq/WX71AVE5T4z+jWl6KbI38CJvx5PcDRdirubjrcN8hudGBf8l2ONNG1oCPacI6tTStpl0Uk5ysS/fdmIyvuYddmfTTJld1g/3Zsyx6uQ+/djQLbiMVnzv299bjjeHbtXaFwTQ1452UmnDFZLE3bUo5AsPpD5ScwQd/JmHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=OHsI/YvN; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 332B140003;
	Fri,  8 Mar 2024 16:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1709914477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s9boYP/5tEQVN2T62hC7F0bllwTHzNcG33ukkaklSbI=;
	b=OHsI/YvN5hiSrUh+JkszMXQy+YjSD0Rojo3kF6fyCKx5Zzphn0M9IN7Tt9X5vm4y041UNn
	lAB2eLe0+JNyD+OfR94tOMaGUIh/a22OFfJ5l8091aLMxl3lU2UxrcMOJr1DfcEA8sN3Y6
	4wVXO7Mivc3b4lJsp2qC+eyMU5DVkAxP4LdaDmNkIuQeQmNPIYVv8GXFH+mU66uvZ3BSw8
	DNVYEh8CTvF+6HbUD7iAvF49EtMz73wfDbRHSHyMwAm3YZcqrKTbEYicnz+sedHM9lS+TO
	M/Gav5wOWDM7EWyiyPQA7bIiHdmSSih/4HZy3OQGKONnr8edA9o11YkWr+NB5w==
Message-ID: <70822db4-d642-4180-9db8-eb0aa5728ef1@arinc9.com>
Date: Fri, 8 Mar 2024 19:14:25 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] mips: dts: ralink: mt7621: associate uart1_pins
 with serial0
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
References: <20240308155616.11742-1-justin.swartz@risingedge.co.za>
 <20240308155616.11742-2-justin.swartz@risingedge.co.za>
Content-Language: en-GB
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240308155616.11742-2-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 08/03/2024 18:56, Justin Swartz wrote:
> Add missing pinctrl-name and pinctrl-0 properties to declare
> that the uart1_pins group is associated with serial0.
> 
> Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Please add the trailers from previous patch versions from now on.

Arınç

