Return-Path: <linux-kernel+bounces-95058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E22E8748B6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2992828DF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF9563106;
	Thu,  7 Mar 2024 07:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YhCwdWI5"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43370CA6B;
	Thu,  7 Mar 2024 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709796674; cv=none; b=VXD22hhE9ENO/YKHNaCqHD9GclmOyN5h0lTKFC5FPvtReT2mugkST4Aps2ckxFwA8j7wHdtvpkBgb3CxPbbXlgCHvLA5ptrG0TsXg7dyd0icJ34NFmkBQnQCnDbfeqda0xFS7lTIHl4/Rb4/VvKQerHIETXA/VWGef97ztx7pEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709796674; c=relaxed/simple;
	bh=I6bIZUhwQKeG+UWXTr5lwelfRtaHwJTZkOk3YNZcbpI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EGM2YAqI5ucyUNXarwLUewshvhxCeP1iHJlkqgw2bZbKMDAAaNFtP4vxnexvK8jFfMeu/L+3+ideOGqVRSllNF5OFvbkamZk02AYccaoUlYJQl7/+4uC/Wytp6ibMZy49zlMtILQFxxo1bTjcidP5Sb+dFpxPJn6NKIMDCv0p1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YhCwdWI5; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C9D2560002;
	Thu,  7 Mar 2024 07:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709796670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E/G30HQxLWRoFZIvYSd3SRA2snV7wVPADu6RkLNz5Vc=;
	b=YhCwdWI5VgfWOlO+rdWF7RO2fwNn7lMLmJDNBX2NEAMPZO4OeQ1oh+5NminfFfM95kOzJ+
	++1G/8FL6lEB+7Kli0tiJSU0cJAP69njWF4/wWjm0GpZKhif+96kfl7Ma8PoekzT/p6JKr
	yD1kSC9Drw4GrHekHNrkfd0kbH05JYEjak3788Rlb/NuG/7kXO0zD54llmCWfhE2x8ePvP
	xjhHpIm6yhuub04Bw8n2umzSt8CHcRLlZ84recBGwmnvStlHWQHgyQahpzEtXtusV9D4+Z
	RO+Z/8frZyD1vM6m+QAggw4I0f0h5K6mOR5uXh8VzPfYP7bh9YMs9cXavpjp/Q==
Date: Thu, 7 Mar 2024 08:31:07 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>, Mark Brown
 <broonie@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 3/5] lib/bitmap: Introduce bitmap_scatter() and
 bitmap_gather() helpers
Message-ID: <20240307083107.0fcd940f@bootlin.com>
In-Reply-To: <Zehx-v7h38TPJWwe@smile.fi.intel.com>
References: <20240306080726.167338-1-herve.codina@bootlin.com>
	<20240306080726.167338-4-herve.codina@bootlin.com>
	<Zehrd/VgW5AnfJEu@yury-ThinkPad>
	<Zehx-v7h38TPJWwe@smile.fi.intel.com>
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

Hi Yury,

On Wed, 6 Mar 2024 15:39:06 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Mar 06, 2024 at 05:11:19AM -0800, Yury Norov wrote:
> > On Wed, Mar 06, 2024 at 09:07:19AM +0100, Herve Codina wrote:  
> 
> ...
> 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>  
> 
> Why? Shouldn't be Acked-by?
> 
> > Would you like to move this with the rest of the series? If so please
> > pull my Sof-by, otherwise I can move it with bitmap-for-next.  
> 

A new iteration of the series is planned.
Yury, may I add your Acked-by in the next iteration ?

Best regards,
Hervé

