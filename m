Return-Path: <linux-kernel+bounces-38660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED2C83C3C5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFBC81F26DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD4155C3E;
	Thu, 25 Jan 2024 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EveXoCaV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PQTGwAQR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6BA56B6B;
	Thu, 25 Jan 2024 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706189728; cv=none; b=obfSBng0cOwdtozF4BHiYL/bLaOYR8T+BbdbR6p5VbL97FrYt4rvmd3W2ip1UmMOjGIRDOu9p2emE6UN9mDgP0obgwTl8Pyh4SOAiQwKAWAQxTgiwOZUhdAXk9xs1Wo3hRDOGfjmEa1cNiQ5StZwkd4RYyPJC1vP4YcCIj7zfMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706189728; c=relaxed/simple;
	bh=fvn+bMBhFq4DGQCYdmmItxFzpZ4dLpUiVSBLUvy+Xqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Si0y0WkVvixUTCpvq3bV0NXZiwcSZkRbDQm4vGIr/BzOaDFk0Mqbs9ywGWPAnXuV6E8ywJKBV31WeO4afKQvqP/P9RuQdK69V6jyVUA77WPzdQs10AA38xlZwwx0xfYPqeHXguvnKpRm/KwJ9W+nId8y+2x5g+oy92OMieWevBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EveXoCaV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PQTGwAQR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 14:35:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706189725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F9UO/TwyZdEj3iKgu2t8LOSQIGAMLuKX9wZHWL1TwD8=;
	b=EveXoCaVPjB1/4K0mdWTh9NDiOdMTJleMucr6NgKSgbgC2399afEmy+ZEW40cCnhH51PdY
	+QE+IsM91122AOyYOCtk8MYz6t+X5nfg7ILPP4DZkQquAWR1my5xaEvi0Vczkp+9eaq/4m
	RKvfSoiff/CV/OSvBA+e4L4u+Q1sSIw7aaKapdsDiJ2287lOr2vtYF6WFtjnpF4XlmT/ZN
	tbJle9lLFLfrDv3lj9KFHg+yQZDxYbchvOArQaZj3rdqULeNVQhBVHf79cRhcnMQzFsHVl
	VGw4caYJZhzO9KJeMLVYzFzYxnFpba0JZY/Jo7kA0kVgeK4kfFEvsZtO2+SgXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706189725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F9UO/TwyZdEj3iKgu2t8LOSQIGAMLuKX9wZHWL1TwD8=;
	b=PQTGwAQRZ+rmvGxCERiEX0EX037zJJjnB0weA+PXdhNzvdUHYsjjwae7uRf0zZ5h4Izbkj
	ucUMPr/Mi82ZpMCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Chang, Junxiao" <junxiao.chang@intel.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Li, Hao3" <hao3.li@intel.com>, "Li, Lili" <lili.li@intel.com>,
	"Gao, Jianfeng" <jianfeng.gao@intel.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: RE: [PATCH 1/2] printk: nbcon: move locked_port flag to struct
 uart_port
Message-ID: <20240125133523.W7aDeBqt@linutronix.de>
References: <BN9PR11MB5370AED9C562F9DA75093557EC742@BN9PR11MB5370.namprd11.prod.outlook.com>
 <20240123054033.183114-1-junxiao.chang@intel.com>
 <20240123054033.183114-2-junxiao.chang@intel.com>
 <87le8f9i75.fsf@jogness.linutronix.de>
 <20240124100524.ZyAPfPU5@linutronix.de>
 <BN9PR11MB53701E5CF2737908FA9EB532EC7A2@BN9PR11MB5370.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <BN9PR11MB53701E5CF2737908FA9EB532EC7A2@BN9PR11MB5370.namprd11.prod.outlook.com>

On 2024-01-25 01:08:24 [+0000], Chang, Junxiao wrote:
>=20
> Issue could be reproduced with our hardware every time. My cmdline is:
> BOOT_IMAGE=3D(hd0,gpt2)/boot/bzImage-linux-intel-iot-lts-rt-6.6-kernel
> root=3DPARTLABEL=3Dprimary rootwait console=3DttyS0,115200 console=3Dtty0
> init=3D/sbin/preinit-env console=3DttyS4,115200n8 console=3DttyS5,115200n8
>=20
> If you would like to try any debug patch with my ADL hardware, please fee=
l free to let me know.
>=20
> For console pointer sharing issue, from code logic point of view, the cal=
l chain looks like:
> serial8250_register_8250_port -> uart_add_one_port -> serial_ctrl_registe=
r_port -> serial_core_register_port -> serial_core_add_one_port
>=20
> In API serial_core_add_one_port, uart_port's console pointer is assigned =
with driver's console pointer:
> 	uport->cons =3D drv->cons;
> Driver's console pointer points to static structure "univ8250_console" wh=
ich is defined in 8250_core.c
>=20
> That is, all 8250 serial devices' console pointer are same, they point to=
 univ8250_console.

Okay, So that I see this and the unbalanced acquire/ release part with
the attached patch. I leave it to John=E2=80=A6
Btw. You don't see kernel log output on ttyS4 + ttyS5, right? Just a
login prompt.
=E2=80=A6
> Thanks,
> Junxiao

Sebastian

