Return-Path: <linux-kernel+bounces-154640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112048ADF07
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08C6286A97
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD63953373;
	Tue, 23 Apr 2024 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GNUhZvOZ"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810A04EB24;
	Tue, 23 Apr 2024 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713859085; cv=none; b=Ba3z4M0yb6MeC65aUDhaah1N/m3Bu81Mq4qKAuO6/xJH+bX9c6ACC0OCr5TILG3jmjen478QFg7nRwDtsVhMsqnCGYDZHgPC3i/46n2MLRt/nrhEUqMp8k1KHDN2/t6oMGo8xtf8shmf158uHOTmnqfGI3eLTi4fUigfZA0Qk6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713859085; c=relaxed/simple;
	bh=jSbUBylXG4hd4LbDLF8MnIltpuD5azHbmVuQFm2PB6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IpFBsnS348EfxqjvffB38p6cXnItHhC0hNtEWplwY9xG+hkAgVROxKMLwmsTMYebAgGRwzMAbF5pBM0d7zkDKv2uzS6GjMumt7BJpwOW6+2hQ+tEV6IY6wWD93sUONLSWwl5EzF4B5LqoMidASYPMJpdqc3E2R9nck+/3XyvMuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GNUhZvOZ; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 744B46000A;
	Tue, 23 Apr 2024 07:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713859080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZqHyozgK9yUpKZAcjflzI3qZ70gn2cG0mX8HWy0gz4=;
	b=GNUhZvOZOMxsc8HXr44gDKbrPOlq6PglAKkDaFbvZK8W993ghKQ4XrG9MQ4MgFK54LnZG6
	mVUiqbtBZTJwnk04pvzFYx6E+1/6pFVn0xd4stVyXZDHoyAPu5Bp8v01L2vXcIzrJNoW5p
	VTbtbo6ADq4hAR+/mV+cbykRCoGcg1ucE3JmUhKD2wg2nI8AelF+c/Uu3GEEaUAZtz56Zp
	YuzLaB/NbB1kxE59UIbzy8BluPB7c1AggjPgKX876j8NPA5wZXsqeiGn5IXUbi33WyfOwI
	6IhMYZSSc//Fj8wurj3iN1WygehsvIBTt2d8w/reNTjTuDVcG7diY7XskOGEyA==
Message-ID: <4b5657be-686b-460f-bc04-b023ffbe1910@bootlin.com>
Date: Tue, 23 Apr 2024 09:57:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] riscv: dts: sophgo: add initial Milk-V Duo S board
 support
To: Michael Opdenacker <michael.opdenacker@bootlin.com>,
 Inochi Amaoto <inochiama@outlook.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240417065311.3881023-1-michael.opdenacker@bootlin.com>
 <20240417065311.3881023-3-michael.opdenacker@bootlin.com>
 <IA1PR20MB49539A380E44459ACE19DEB6BB0F2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <e457d5f6-3289-4049-b663-2ebcfe78dce4@bootlin.com>
 <IA1PR20MB4953D0D45EB0EDB6E8046664BB132@IA1PR20MB4953.namprd20.prod.outlook.com>
 <fbdcc77e-eab4-41da-803c-d65405f37f02@bootlin.com>
Content-Language: en-US
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
In-Reply-To: <fbdcc77e-eab4-41da-803c-d65405f37f02@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.bonnefille@bootlin.com

Hello Michael,

> By the way, where's the best source of information about the Sophgo 
> sg2000 and sg2002 processors? Even the Sophgo website doesn't seem to 
> have them :-/ . It just mentions the CV18xx ones.

The best source of information I found for the Sophgo SG2002 and SG200 
is this Github repository from Sophgo :
https://github.com/sophgo/sophgo-doc
It contains the Technical Reference Manual for the Sophgo SG2000, SG2002 
and SG2042.

