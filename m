Return-Path: <linux-kernel+bounces-105992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8B487E734
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F39EB20A47
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2846C3F9EA;
	Mon, 18 Mar 2024 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="N5FwsH0I"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C6C2E630;
	Mon, 18 Mar 2024 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710757232; cv=none; b=nWkw7P5/r5W+VoikySLmHw52maiOkPjkWgvhxin4kqKZpLnHT6TjXNf9U8S0vlwDZuXvpwyVE7jLTaevYATt6h5wkCrkrwBcxxqwj40Y5SkxLgnCTfQuC8m5+BZI7PWQB7ez54wFdelY+t6p5HbVDQy53+zhB38JrETHoVSw3dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710757232; c=relaxed/simple;
	bh=nhMi7Rz7KxM9Lznhuv/RbMZuGrKl6cfvADSdkTJ1Vjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJrAHNRlqcK3q/APUWwhBZkKreapGdGJszqvYMJaD28HoTjquBCDZy9hrxFnSVrcdmrgCPVrwfcMZm3QbCqgsVgOxioSxrFZ0j3pOxl0dAqzlTLBq3fAsTiK79OZSAxVvd89v1ND5sw/Ij3X5dXK8MMBNdA5UcOxvcXf1l8TZvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=N5FwsH0I; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710757229;
	bh=nhMi7Rz7KxM9Lznhuv/RbMZuGrKl6cfvADSdkTJ1Vjo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N5FwsH0IxersJzcBxGdrZ/dpEJ20F/kUFkgpkb54/Z4mp+8L7SO+1ZQXTSP95msUl
	 gwUqoeQzjM9hatAhIwjEtkghbIbQnW04uoYx/p5GcPPFv5yiyPURcSdS/f44SZHoXL
	 hlo2TFYnbJPqxtVcYn2H30lJqs/yj7hhQ/D/KTEe4DCCkPGy6VFbgxAY+WMvEVr5Qx
	 Q4l9Mftn1hb8WMwfb56WlJ6YPqtcBWyURef6y2Ku4WeFCjg9ExZxSK3NmLJHWGd+W8
	 CcowHR6vaAuzXudNt/PnKHJ7e9AbKO2OZMf8ZJM1RVeOoxgK3lMts8O25GR9M6fq0s
	 8sS2uRSFKjGtA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E38C3378205B;
	Mon, 18 Mar 2024 10:20:28 +0000 (UTC)
Message-ID: <bc3d8b24-fa84-48ad-8750-46ed714a1e28@collabora.com>
Date: Mon, 18 Mar 2024 11:20:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] mips: dts: ralink: mt7621: reorder gpio node
 attributes
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
 <20240316045442.31469-6-justin.swartz@risingedge.co.za>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240316045442.31469-6-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/03/24 05:54, Justin Swartz ha scritto:
> Shuffle the attributes of the gpio node to appease the DTS
> style guide.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



