Return-Path: <linux-kernel+bounces-92207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5870871CCD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB73E1C22D44
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9D754912;
	Tue,  5 Mar 2024 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="opIecpBf"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDD9566D;
	Tue,  5 Mar 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636553; cv=none; b=Q8dpReD7F3eA51xfeFh2WTzQyLBtFFGewhSU6j09jH6aaAmurwEy6+a9OSgmKBnWvV78XX435BpPX0zT+/JZmi1xnRkzyQYU0cVE9E/pljpHqopvMIm9/21P689wLTJZii/oIMsfIPs85M4GsOdIsy8gqvQHwGsEnH/yfPzzYK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636553; c=relaxed/simple;
	bh=nVV7EoAnX9/xTtj6Pid/56wBIHUiqHrmL9c5hzFc89g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCCKxTn1YwvllPN0EN07jvsUFMTOfM5htQ9PJDFhXl0ukv+iExeU6dEVp1xsgglkRYATpIB+NUP2hJpyAeT2cIQqy0kb5tHQ1SQlfMtFwcQF0SYKM/Z+gjDH37rTtC0Yu5z/WfUMaTsrZPEBp4m4mill8ZOAjljSZd74wY2B3N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=opIecpBf; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B66261BF20B;
	Tue,  5 Mar 2024 11:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709636549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4LVRqDAKoWY5kgiwdLKWwQAoyIirpSfzsC5mBFQI3NA=;
	b=opIecpBfJERWkETn/8djWi1vWsAznSKrHO2kz1tEPMGpi6juVNQu5EPhw3hKFu1TO6J32R
	cr4c34e6d+Sbt+TpNfcTqUoifskL0+s+rCzthMikNHZEDZhzatmvo+sVjwGOXvFA/5sPbo
	FoO461gz24lw+iKiOhkzELnP+95cNj97BgSxT1vQAhq+epdhbg48O0J41csnR4SzUGnprU
	MeNIjQtQbVXE5OixZSIUd/2hLFZ7X6GXe14Uke8EXhiyykBYCllQ1ygLsR+tv+gcaXf+VP
	4fwstIjNVDIvwhfbUXKo7jcKEWwZa7owmhCDTXMquoAUqPWHeLZBe5wq2K0o9w==
Date: Tue, 5 Mar 2024 12:02:26 +0100
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
Subject: Re: [PATCH v5 0/5] Add support for QMC HDLC
Message-ID: <20240305120226.791bfe9a@bootlin.com>
In-Reply-To: <ZeChdAsAhrC8a75t@smile.fi.intel.com>
References: <20240229141554.836867-1-herve.codina@bootlin.com>
	<ZeChdAsAhrC8a75t@smile.fi.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
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

On Thu, 29 Feb 2024 17:23:32 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

..

> 
> I think it's a good series and next version will be final. The only question is
> possible use of the returned values from bitmap_scatter()/bitmap_gather(), the
> rest are minors.

I replied about the reason why I didn't return any values from
bitmap_{scatter,gather}() in that patch 4 discussion.

Are you ok to keep them returning void in this series ?

Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

