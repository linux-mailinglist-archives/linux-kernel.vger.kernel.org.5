Return-Path: <linux-kernel+bounces-105135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C6A87D988
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72DEC281BA9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556E914F70;
	Sat, 16 Mar 2024 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="XgCKzDgT"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A18F18AF9;
	Sat, 16 Mar 2024 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710580990; cv=none; b=GBXLBECsofvEovKdJBa1pUz44sJ9/j2zpIl0Y3TEQhZ6Sf1girTvOUi9nMzCOJaWhZo1wlEiAmFPDZny2ciEcSLFIVxlST9hZuPi738NCzC6wTPORLZvNl5Vhgh3D+mo/11SCYDoxXVFfb3UXrchiPbCYDSsOMkKD9un0pG3B0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710580990; c=relaxed/simple;
	bh=svs/n+cDzGY6oPLLVKCrZ0FhX5FThz2m40Ovsr4UHAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DnGL1b47uX96G3BGJddSy2GwE9ipkPee3DMFzbMeqKm/9Hx8ffsyySqGEywz8vxURc6gN0Al3tQbxtQM4OL9aXifbT/A+hbX3q5lwUxnwmCRI/VNT4kElHyWPHA1bZTeV2dh/PRChDQZz8jhNt5yIANyo8URtHsVSNL57XTgY4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=XgCKzDgT; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 64886240003;
	Sat, 16 Mar 2024 09:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710580986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nSisC81XnyRtxg3gubWj67nRYu4zIsweXs6oT2yt8+c=;
	b=XgCKzDgTlrDz22uKynZg3z/1vDUNSzOWgio+LTGtc15lUTWM7kVQ9f9aNe/81dme+BeDnE
	ok8ZuJhXbxAlbBtCKwNkYoJvt/TdzWf/FhkXTZNwoLkjdNeIdCbPz6K8omckDkrcWcL2Xl
	vGOEG8dePnDQxMsFdFUQpRyoC5VxKPzBexBEVLnHQDqVpue/sB23lPmaewUogzpPQbTk8d
	2QofVJHjfmml9hvM5d8Q3jrY3VLgtT8nQemJ0EVJvbwk22oHI8BU00COsumOcW23Zn7yuk
	v5Kg6hZ5Nkf2aTkS+2nEB+Fcoi3Mpl4FkBp00Hb6mCwlJUmKue53IcfD0goLtw==
Message-ID: <5200c802-178a-420b-8dcc-c70e3bb2dbe0@arinc9.com>
Date: Sat, 16 Mar 2024 12:22:49 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] mips: dts: ralink: mt7621: reorder ethernet node
 attributes and kids
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
 <20240316045442.31469-12-justin.swartz@risingedge.co.za>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240316045442.31469-12-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 16.03.2024 07:54, Justin Swartz wrote:
> Rearrange attributes and descendents declared under the
> ethernet node, recursively, to follow the DTS style guide.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç

