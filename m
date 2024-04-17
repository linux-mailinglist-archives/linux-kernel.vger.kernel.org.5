Return-Path: <linux-kernel+bounces-148009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42948A7C90
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550222814EA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0EB6A029;
	Wed, 17 Apr 2024 06:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fgwdHmYU"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383CD69E00;
	Wed, 17 Apr 2024 06:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713336714; cv=none; b=eCuNlUR3oD5TKjIz+/PtuMGT26MWhbS2BkX3hsQ5ZyamHn4Sdqt/3qK0Y8L8cwxuOTIaE1mWIVyyCULtiHt05tcFE1nd2wrBS+vl6sFZZqRjt1+/yiGVaBOZCV1OTmz6ybAbcnvlf8JCYSC3yUfGjRwES7AMBOzZ/dxE4BEspVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713336714; c=relaxed/simple;
	bh=rHk0bgqJ6x0z2y6s+TbyoWZNyPlHWYZ3CY3YynDNxS4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tJcDrGOhiv8IdNZp5MHe40JeV7S83XnwloHzQkQivZ0lp+jZ1U2UrCrAGPyMqb47XEhm8lkDDbtBD7GW17BaXbmG4yUwl1BwRUpDjTiGE7OJl5v6XSXJaCX53jZ8ovFqN9UxmACuC3r5ZGViOCRyBJiwJQVLeNWkJuP4JB+MuSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fgwdHmYU; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6639560008;
	Wed, 17 Apr 2024 06:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713336710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnAkFwabSvQqJ5fy96uCIw7AemYXTiam1ydoNeKcxcg=;
	b=fgwdHmYU2Un1HbJPA78aRJGNUGreJ9Uq03yVEK3sNgS24BRwznN0Cr0GBg/8zTv6CgSIE4
	Pb58xOKXGMkeXlH1vCCD5u6z3r1nKtNnwg6qSyBcRwrljnZ5VzzpmvW2EQJ7F6JpiaOqg/
	n6hNl2ZhMRMPUVboSZtObUhg07MTM/WUy2tHqGJ6mb5hwqobqLP2Z75gBfycnLPa0vsES3
	RVD9NyFjmrGszIANPMr6Z1fc8CEbOdvo5HoEnWwo+4sbM+Rp6ZOrcLS2ZgfFgwCssjxGU+
	FdCJy38ulcX8Yrkcii+StgesUL/Av8M6+dhFMAUq3XXXrOQ0l8opLRphWEpSZA==
Message-ID: <46721dfb-904f-4f66-93f1-e12cb912fd2b@bootlin.com>
Date: Wed, 17 Apr 2024 08:51:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@bootlin.com, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] riscv: dts: sophgo: add initial Milk-V Duo S board
 support
To: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Chen Wang <unicorn_wang@outlook.com>,
 Inochi Amaoto <inochiama@outlook.com>
References: <20240417064626.3880187-1-michael.opdenacker@bootlin.com>
 <20240417064626.3880187-3-michael.opdenacker@bootlin.com>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <20240417064626.3880187-3-michael.opdenacker@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com


On 4/17/24 at 08:46, michael.opdenacker@bootlin.com wrote:
> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>
> This adds initial support for the Milk-V Duo S board
> (https://milkv.io/duo-s), enabling the serial port and
> SD card support, allowing to boot Linux to the command line.


Oops, this description is incorrect. The submitted DTS doesn't support MMC.
Sending an update. Apologies for the noise.
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


