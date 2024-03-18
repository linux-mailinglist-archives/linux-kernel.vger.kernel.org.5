Return-Path: <linux-kernel+bounces-105989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A869D87E72B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D894C1C21910
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ED63BBC2;
	Mon, 18 Mar 2024 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="f+sylgeu"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3871F383BB;
	Mon, 18 Mar 2024 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710757227; cv=none; b=ntfMDCn5LuOFBCdQH8+Xn7zBn0T6DUCJlIkM3stjt0ano/yLS1deM9r2V4nRDeiYYESJm1f7nPwRMJuAkRhZviS0FKSqvXNVscPj4JUtx8WGjdGSBhBdZfO3xe1iOlq1CHXC535Fe9+hb2BwBLcmfH4Igm+I04XrdbswpGadSFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710757227; c=relaxed/simple;
	bh=ex7N//6EfIYPxp81DGSU0Wzyl2Drhx/VSQDeDw8KBAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WlkW/xsDPyWqx4bJJBi8d0vuCvOMj+xjkAmRzQUS72f4fv3hcy4vQ+8PCdidy60T2GhHRzLZswIDrHwLf5pNEtamjJ2t2s4Pdgq5rV6zCRUI1TG49eXx0JRDZbsiERkgSkCCtc3CQ+y/izRLvNVRk4688ZnrFtxdiV+CHG4h4dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=f+sylgeu; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710757224;
	bh=ex7N//6EfIYPxp81DGSU0Wzyl2Drhx/VSQDeDw8KBAs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f+sylgeu+V/918HgiCgwjuvbMOf9e3bnNE8Gy5C+FHOCsks2nchgam5tJobSkcxxc
	 YjxEDYY6zrIRg/q0oEk2Fbn3zZ9/LKgZRKt99fYPQ2kraRBiG8CRILMsmXHmNZ1UbI
	 DGO1+UZA+01twwYFcixdQGAmfGrxwVngO7e2Me7OCrE4lpErENzQyF7Btsst4uU2uT
	 qnGTRuEZTdSc2ruUSz3m1sgDShUqjUciwAmEjEFQoRjvIzVMhn+7elDJaJLLePbiur
	 hMNnYRudvbYHlVgk4dg2wgfBAkWQQiXkDizDxdmbI0kI2oZ43Bnk2/nhDum5WOmOWD
	 qoAWaov3nSL0A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CBCA137820A0;
	Mon, 18 Mar 2024 10:20:23 +0000 (UTC)
Message-ID: <a6356a3a-6998-4ccd-8031-6a98478cefa5@collabora.com>
Date: Mon, 18 Mar 2024 11:20:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] mips: dts: ralink: mt7621: reorder cpu node
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
 <20240316045442.31469-2-justin.swartz@risingedge.co.za>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240316045442.31469-2-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/03/24 05:54, Justin Swartz ha scritto:
> Reorder cpu node attributes to fit the DTS Coding Style.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



