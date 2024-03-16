Return-Path: <linux-kernel+bounces-105136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3CF87D98B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1A41C210A9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C07A1429B;
	Sat, 16 Mar 2024 09:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="AAl02aKH"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C871A171BB;
	Sat, 16 Mar 2024 09:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710581006; cv=none; b=lzPBaGmAWs3kdKKvVaXOVfythE40Q6wGWfnd3jvxVe1FL82pVnEXOjHfXaG5Ka1sU+J1vc4ZqxaW7dqjMepGkdy0eRo4Yb6I5E9/59YlnvC1QREAmQkjzVplm4Ex1wiiT3jQfXyp0FdNZkGtTn53/jfqK0XLmDLppqYm6/1RfNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710581006; c=relaxed/simple;
	bh=RoCPPE20tpm4LDCc9HwQZeCoYFNoYTFNNACpfyz/HzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbMSHY9sTDVd5U/9wavcUmmzlUL4I5uSxRXj92/XU/+jTPVMbZxBmOCZLjDkQkrLw1rx/wy3xFfbTO1qEzgODCtvI4BkTc3f3Kpzk1clrbz2paSacwFq3T5pW2/aYxutTrVyT0Eb0ZriMaXkfEUgglFgVWYmceGS4YepAFeiqyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=AAl02aKH; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A5AC8240002;
	Sat, 16 Mar 2024 09:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710581003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=27T/6LoOxD+SSId39cxSdBuQJMI/qSZ8wO0ARmxDJMI=;
	b=AAl02aKHKwclgwoGfoJdq9Au8gBV7lbmGgUDwS0yGJi7TZWiQ5fSFHr67XkhQsopb0W50G
	aZxzgQu8vCv3/ItrIMHS8grA4BjcNdj1WI7mlFH1Qc5b3I3m3+1jg0Pp8d+mlbAwyFvDRz
	aZZCjVEnC7gwnycK8ljQub799NU4eUtWxqJsBcykbssglT3qnGjzCj+SPJdzkRU+9Mcump
	H3kQHvFWLRaf7qWtiLLXrXxR4dh7KOxQzxlnUUVkp0g6kHqb0l/thCdU0OKnygq2GIzlKd
	Upu3bkFSs0dabllZjwzMCFOIU98sIEOQBmd9Tls3aLxBSuz29RFh0sC+/dLBig==
Message-ID: <e4ed28f7-782f-4f1a-8c1a-a33fc490fcf5@arinc9.com>
Date: Sat, 16 Mar 2024 12:23:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] mips: dts: ralink: mt7621: reorder pcie node
 attributes and children
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
 <20240316045442.31469-13-justin.swartz@risingedge.co.za>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240316045442.31469-13-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 16.03.2024 07:54, Justin Swartz wrote:
> Reorder the attributes and child nodes of the PCIe Controller
> node to meet the DTS style guidelines.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç

