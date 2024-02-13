Return-Path: <linux-kernel+bounces-63178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42836852BF4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7168B1C23080
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A84821A04;
	Tue, 13 Feb 2024 09:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AEYPxMwD"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13E4225A6;
	Tue, 13 Feb 2024 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707815298; cv=none; b=ZOnR+oFa8hbqoGRDSUKlWvI+/v+ZzExp+Z48hvMOai++Qi8lLGmlnu5Sle3EM0zNrnCL/BqsPwBMRADl5Vc5FISUs+NytfaCs40MdUNOJuydiSk+oMqUjzT5t0PM/KplroAkWeXAXAnsMFGPs9IfPhM8VbOgKJ6sy0Jn2ks7X1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707815298; c=relaxed/simple;
	bh=KRg1xX/ZhFt9GsTxQ689R1p2dpNbWJilhn7cTNUcGRU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oiLLxCbBzwsM4Iz2IvVzWt5aE4wmXCQhszWK7Csbh1Zjx7UfBaWb6py8dA4KwrBlCaeMa3VXaQJx7Ks/Pqb33rPy1wDlpkIQhM1A8TqzsRKq9hmVnk8sThpyQTYOp3tzOcipT8pfYPJ/aJF2SJadj5Vvk1FwqB8q2jF23i+61Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AEYPxMwD; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8E59B6000D;
	Tue, 13 Feb 2024 09:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707815287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiwqPqsnm3LpoS+WKO2QLQwANuxT6Dc/3qcFsOtPO1I=;
	b=AEYPxMwD4HD987JWbzWTWG6LBxpO+LZMTQwsqH7TVkD4wYO0LG7oCd5sk5c2jTWiOFiRji
	tnRXqH8mKHf78nNkdcadNt5WdKe6egrlD8scurmMhNHzQFgM43cLF1w1g/5w8s3EpKfHYA
	JPCRgc9emXIryVOu8YuGrjfGM1qjL0XyYfr4rLI+cHDxdwX8ag/3J50Z3QNyvwdV5mQ7Hg
	L9HHpNCmAJbhOVp1NxoWKZynDhn3FMcBFvdWQnOdHTLBlqG5IN1OepIvZFPeu0mpByrg1B
	DKkbyTBllTVW3u4xCM4Wy8Lhv8nYJyJMAV/rBwZhPz8kjEfTWyy3GJfMHD3ZiA==
Date: Tue, 13 Feb 2024 10:08:03 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>, Richard
 Cochran <richardcochran@gmail.com>, UNGLinuxDriver@microchip.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH net-next 1/3] net: phy: Add support for inband
 extensions
Message-ID: <20240213100803.6953ba45@device-28.home>
In-Reply-To: <20240212172511.42cd058d@kernel.org>
References: <20240212173307.1124120-1-maxime.chevallier@bootlin.com>
	<20240212173307.1124120-2-maxime.chevallier@bootlin.com>
	<20240212172511.42cd058d@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Jakub,

On Mon, 12 Feb 2024 17:25:11 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 12 Feb 2024 18:33:04 +0100 Maxime Chevallier wrote:
> > +/**
> > + * PHY modes in the USXGMII family can have extensions, with data transmitted
> > + * in the frame preamble.
> > + * For now, only QUSGMII is supported, but other variants like USGMII and
> > + * OUSGMII can be added in the future.
> > + */
> > +static inline bool phy_interface_has_inband_ext(phy_interface_t interface)  
> 
> 
> Spurious use of /**, it seems. You either need to use full kdoc format,
> or the normal /* comment start.

Ah sorry about that, I'll address it. Thanks for taking a look !

Maxime

