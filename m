Return-Path: <linux-kernel+bounces-128999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B02F88962F4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B84C286FFD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9A42E636;
	Wed,  3 Apr 2024 03:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="WM/sePX4"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBAF3D76;
	Wed,  3 Apr 2024 03:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712114973; cv=none; b=av5MQo4B4vGaKYcFZazsNltCygsJZLf6oQ6ZAedzrrHz/Crdqi8Z0YJIJQAPFR3KCgwXFFBVPNEtG0tTQ2ZecfTd7kX8R6OSAgPmMNSzhVaaYEKZDmVyKVamx4L6oppRaVb99MOMWml8NQKqpwvgD4YHQ/9gA/DCGc/uKFWZHmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712114973; c=relaxed/simple;
	bh=1EIgt9ACWXed19+CaCKn14yKWR326KDE1bbmos0k4nQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ET1N4XHnchDQM+bYcA3hAMryAfdkBiiTqBFiTv4N/LDGpdJ9KytQvMfjkspyGt0ZMWdVW3QtJzNh3mcR2i7dSOk/EPUBPq+FdVMoVeLllLj4RfObDytIRRVCfLkpeR2PA5xjK8WP1AH/JCKvmWCnu5ZR7FRYNgCjwr2NmCNRNRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=WM/sePX4; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-182-70.adl-adc-lon-bras34.tpg.internode.on.net [118.210.182.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id BF8CF20075;
	Wed,  3 Apr 2024 11:29:18 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1712114969;
	bh=1EIgt9ACWXed19+CaCKn14yKWR326KDE1bbmos0k4nQ=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=WM/sePX4JC/BBusJTYbStdbfybWmQb6z2+R9oPr1BMeNxlNrdw5bi0fYd8PdI7ycT
	 6H8szIlqqZs8NWFXbe+6ZCHY0l1gcQwuzTnIja7f46/h26kG7rDSwKcDIp3dJvODGg
	 XXO9GKtObUHJCX4YPJXN5FllsBTKhoiVzBbfJcL8lM3JUW6x69IEjM8tuqrUDXYCd8
	 7OCM/5BxRwaaEsLPMsoamm8Qd1pQi92Vl/aMhPujUv/rXA3+u67j+pQLEwofxC66w6
	 /pDKlcOnnUDt9pR+0w94bfUgsOXdlCnLHazyMvuNUIoCl/SAL7OJghdsC8Kd1pDjko
	 lHGvD8/TY40/Q==
Message-ID: <42e91dc2bccdcac96abd729def8a05b2612488a7.camel@codeconstruct.com.au>
Subject: Re: [PATCH 2/3] ARM: dts: Disable unused ADC channels for Asrock
 X570D4U BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Renze Nicolai <renze@rnplus.nl>, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aspeed@lists.ozlabs.org, arnd@arndb.de, olof@lixom.net,
 soc@kernel.org,  robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 joel@jms.id.au,  andrew@aj.id.au
Date: Wed, 03 Apr 2024 13:59:17 +1030
In-Reply-To: <20240329130152.878944-3-renze@rnplus.nl>
References: <20240329130152.878944-1-renze@rnplus.nl>
	 <20240329130152.878944-3-renze@rnplus.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Renze,

On Fri, 2024-03-29 at 14:01 +0100, Renze Nicolai wrote:
> This commit disables unused ADC channels and labels the ADC channels used=
 with their function.

Please run this through checkpatch and address the warnings.

Also, the submitting patches documentation[1] suggests using the
imperative mood - instead of "This commit disables ...", use "Disable
..". The change subject is phrased the expected way.

[1]: https://docs.kernel.org/process/submitting-patches.html

Taking the subject and the description together, the description feels
a little redundant. Maybe it could be trimmed back to

> Also, label the ADC channels used with their function.

Andrew


