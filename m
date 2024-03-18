Return-Path: <linux-kernel+bounces-105979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABED87E70C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205F31F223D5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663772D606;
	Mon, 18 Mar 2024 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="c6KH/pmW"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF7F2D042;
	Mon, 18 Mar 2024 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710757212; cv=none; b=WgrMWwKaKhUB0GBoh/nGSY/wrn2sDGfU1JwNg/jRDee/qNtXRlc4rffPNThsYnuwcmp+ykXcJ53/HfOmZaool+ee5oOKl+Yz6SOD8JaYJW3UP2hXzkA3tstZ5ueMcTKJkuwW3nxfn8KlS0cejoHXYimC8hYoBwb5RHSlkr6a19I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710757212; c=relaxed/simple;
	bh=Jv9+lrbEk7rDYbF+Jxgetn5HHZzzqMQUV/LX3UBjbbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RNnUWy0xgAREoDZW0NrXT/dv/U5PaT2Dk7d4uflzHxBBzmylHsdtUbxK4ZGdmrQKhM1o2UBbQHUXTMjIjgBFW2rM89dHY7NVQthWaIm/4iOLU32JteN1OjY2MKXx5d5dMLsCVHJ2+vutp06lhnuuDZ9owwtEL4MXnAENlaYSzlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=c6KH/pmW; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710757209;
	bh=Jv9+lrbEk7rDYbF+Jxgetn5HHZzzqMQUV/LX3UBjbbg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c6KH/pmWD4Fl6g00e9ccwC2RcvxYoK2hBd6K5dHPHkIaqeFQhKJZtyJIVDmXxXTS8
	 6LiFGi20dqWMzAoflHpybY9FVRr+QuwT1SxZXnZjETG7pqdPPajSFmwuT0aeamoJ2p
	 ko+O2rY5NlKP2hZR+OQt4A8rs+l+V/TLCJQDtYygU0WVWDtFeXX5pgVpSsxgTruYWG
	 5Bu+SIPE81K3XQGF7QapRt5t5Kyid86hj5CxUU2Yd+NAm343x2xUmssPVkqmrjb7Ml
	 iB8q8sIWNe1UgQ0wcz3LXrvGzipGBjYZkymc9PDi+wZPVpk7P2C19RuaXCeGZccUJk
	 dRiylF989/Zyg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8E3E8378107C;
	Mon, 18 Mar 2024 10:20:08 +0000 (UTC)
Message-ID: <dae156b3-55b7-4c5e-8c42-3dab63e96864@collabora.com>
Date: Mon, 18 Mar 2024 11:20:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] mips: dts: ralink: mt7621: reorder the attributes
 of the root node
Content-Language: en-US
To: Justin Swartz <justin.swartz@risingedge.co.za>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
 <20240316045442.31469-15-justin.swartz@risingedge.co.za>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240316045442.31469-15-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/03/24 05:54, Justin Swartz ha scritto:
> Move the compatible attribute of the DTS root node to first place.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



