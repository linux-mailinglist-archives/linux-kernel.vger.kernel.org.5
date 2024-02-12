Return-Path: <linux-kernel+bounces-61714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C07585159E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6EC2877BA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2067140BE0;
	Mon, 12 Feb 2024 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ie6b3+Dg"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2501848E;
	Mon, 12 Feb 2024 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745086; cv=none; b=cvAp4QTkYnouKaWRXKb/UmgeZ20YmrSaJlSiruDngr8HKfsyf8i5WFRg3IQM8+TlzszJBU0DNO+A5jEcWqoZjxyEJusGKkk1doDA3y+NcYHL8oSG5umdB1OK6PTYRzzBkJ2SA2iZxnJmUxy9gIzONDlfUQyw3pVQLV0w9tz4dxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745086; c=relaxed/simple;
	bh=lPAGNQ9qyBXFTL/v/7+iOjDr1xFtXIIoVf3l+u9WEdk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3cvPROwWC4TKi2DKPa+l+lyuNrCRDxWkVkA0/YdEgYUEDmWZWNEKhiTUKNp09zcB6eJI++F8nrEy2hc07E6Qr3oCUToUllujY7eOztp8/NFsjjXLJJz9RswqrvMWr2KvGLYvZ6WYqydUoS+RxiTV879hzjNr8HPNjdT4WMG73U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ie6b3+Dg; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 481B41BF206;
	Mon, 12 Feb 2024 13:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707745076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7rOVuLO0xilSDJ3N64aVRj6PnVPEco4AT9htw6H2H4=;
	b=ie6b3+Dgxjr4F12aR7ja00IGv0kDHrgLsQfBeM4e67NBLH5C7IMRKZgVpnnOexMji6OOXm
	YFOjZoH+AQnY9lFkGeIKeR244NpvpPsUchrtXSmUnev77+bqCNmWQ/Y7QpV2zwuTlhOhJq
	znASmRBLlLlIlj8Vu34bvXPlOhI9sPJlm+8fAjkhjNijvebyiJSJmvsicnWq7mCUKnmDvU
	0yEDZ0+wk/qOPBcxUl3sbnGmw8k6o7WjETQeI/Vvy1VXz/9szFs7UaBDdTcPbsRJJt/t4E
	s2lm9xx4yoXjyh8H0nmscBy17KOVTso2Ebadt7atZAarYpr2naLuRahLuo4spA==
Date: Mon, 12 Feb 2024 14:37:53 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>, Mark Brown
 <broonie@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 RESEND 3/6] bitmap: Make bitmap_onto() available to
 users
Message-ID: <20240212143753.620ddd6e@bootlin.com>
In-Reply-To: <ZcoOpPb9HfXOYmAr@smile.fi.intel.com>
References: <20240212075646.19114-1-herve.codina@bootlin.com>
	<20240212075646.19114-4-herve.codina@bootlin.com>
	<ZcoOpPb9HfXOYmAr@smile.fi.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Andy,

On Mon, 12 Feb 2024 14:27:16 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Feb 12, 2024 at 08:56:31AM +0100, Herve Codina wrote:
> > Currently the bitmap_onto() is available only for CONFIG_NUMA=y case,
> > while some users may benefit out of it and being independent to NUMA
> > code.
> > 
> > Make it available to users by moving out of ifdeffery and exporting for
> > modules.  
> 
> Wondering if you are trying to have something like
> https://lore.kernel.org/lkml/20230926052007.3917389-1-andriy.shevchenko@linux.intel.com/
> 

Yes, it looks like.
Can you confirm that your bitmap_scatter() do the same operations as the
existing bitmap_onto() ?

If so, your bitmap_gather() will match my bitmap_off() (patch 4 in this series).

Thanks,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

