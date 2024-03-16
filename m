Return-Path: <linux-kernel+bounces-105126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DC687D96B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13F52B21728
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473FB125BA;
	Sat, 16 Mar 2024 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="NHR0+/ow"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29237168BE;
	Sat, 16 Mar 2024 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710580853; cv=none; b=JPkwccfaHqcjH+KkAbOMzE00AgdaI58mFaPRBKOMReH743eCeudU4VcxlCGpkD7F/yhXzECU5QBaVcevVSOZPh3ATJHjp5SBXDKhBwGzTyPU+TWMsSHe3jpUiaD42PPknSRedsEl1Ka5xOwAoc+SabeVmGBJDy7X3ik4c0CRUnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710580853; c=relaxed/simple;
	bh=efp38J6oO8wJAttC5gM9QX9fw/+nJPMDS7yNMoYDFfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Avrk063T9m01uIUSr8RL05vfbPVzWnN5O66RtpU/bw1ASk3cGG80r1kAMRDvJiB8VarMK8sAWcEi3Xg7HX5rwHqBfkpJQzpFZelDqaCwOA+bGHPg+cR4vf6LKzL/E0LVo6qRH2EOU4WomXYPXsw7A/s6gUlUrduLmgs8sQs6y34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=NHR0+/ow; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A7B1520003;
	Sat, 16 Mar 2024 09:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710580849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iJvqEwG4BCgOwSG5jkCwsuNB3D7Qx69A0zVN4AWW+x4=;
	b=NHR0+/owB774mqHdvrUBgi38JgJO1jT/4V9TDoTNg4i2kRgq3y0UAKjZ0+cpkDKGZAT+B6
	qVJvw356V8aoRqNCXKkWPxbzL3v0jdfOXKPO9Hdtk6/UPctAkisvxSyAylKpnGIVJmuV0n
	RcBhHN2GSN+osYat23JB+fNQ95BGF8jvHBeCU0c6Lxs2rQOJsI9EQiYSN5XCltviFtg4fh
	Lnj1vNyoeFdFeo/gCBkg4kNFsXVceoPTaM3/zOlAmXE0H6dAySS3ruqFjFkn/zNY3rm2Yo
	QUDcE4UiH1Uk3Ol1zqeOWzFMXwHr2DPkqe+b9sCSqQwCpp5M+uerWWfIBHfPhw==
Message-ID: <e4d77218-191a-475e-8689-3bd5b00a82f8@arinc9.com>
Date: Sat, 16 Mar 2024 12:20:31 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] mips: dts: ralink: mt7621: reorder cpuintc node
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
 <20240316045442.31469-3-justin.swartz@risingedge.co.za>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240316045442.31469-3-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 16.03.2024 07:54, Justin Swartz wrote:
> Reorder the CPU Interrupt Controller node's attributes to follow
> what the DTS Coding Style dictates.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç

