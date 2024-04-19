Return-Path: <linux-kernel+bounces-151100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7F48AA919
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4EC1C20E01
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4529405EC;
	Fri, 19 Apr 2024 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="UgP8Nrlo"
Received: from smtpdh16-2.aruba.it (smtpdh16-2.aruba.it [62.149.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82BA3FBAF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713511420; cv=none; b=QTpecPUJMVnv7u4hLhH/IwSyjY+GyLl7rQiyhs0Ru+A0DprTyhUlEOEc5+mTPY+C+RIG9zIlgBFri0BQVY6zblZ0DCcuVwAq3laGb9NMTCivupMOgwNBZeo5k/4k8iQsSF3ABYAJXBuhK/uKfiKfgZQlbEYRKGJivJQAGDztnpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713511420; c=relaxed/simple;
	bh=MsoeGdQjfbrInj5eTOqBiVvaSFeUUPab3XbLCWt+Adc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhsutng9X3Kmrj2Hrm57L2scVTHHwBMgBM82UFVK8U+8Id1E56TB4+CU1C4ObYprbtMjMuIhlOfcMsWavoGlrPgbzSw2eZEVi2h8Uy6SOOWgOByTlx++jGA2GD3VHecHYAc0pX0prIg9sCJNdEcBXhTePaR/eYvZF8lHp5YAr/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=UgP8Nrlo; arc=none smtp.client-ip=62.149.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam ([146.241.22.218])
	by Aruba Outgoing Smtp  with ESMTPSA
	id xiXqrzu5tYt7axiXrr9Pl2; Fri, 19 Apr 2024 09:20:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1713511227; bh=MsoeGdQjfbrInj5eTOqBiVvaSFeUUPab3XbLCWt+Adc=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=UgP8Nrlo2yIRiWy8UpwVIHQ2OA2X4glZI0I882a3VUGuPyt4WWNjRCK4cFvUtz+x3
	 qvE9OJhGN2LSoDE05Ioh5xuP3YTtGS9gVa+vHZndXJKYRz2oCyGtCIY3PrtMdehV2y
	 0u1q7KxldT6RNRw6WXAnlfHEvi1r+mqrLXLDANySVEeIjFX7G2dErSit9L8uJsPZC3
	 TuNKaBI3W8PvYS254DQKbctuESytQxMQ35zrMVLvd5ZYQ633BBrZZOA2UCGLIRb2bE
	 lGeXrDA58IYsAj/H0PuguZVbOMYFN5Yol4SbMh0jBVoOakRv3m0F1XrjGQ1pzSkvqx
	 WCVQdcu5b5LJg==
Date: Fri, 19 Apr 2024 09:20:26 +0200
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Conor Dooley <conor@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: fsl: add Engicam i.Core MX93
 EDIMM 2.0 Starter Kit
Message-ID: <ZiIbOvH1hY0UKW2A@engicam>
References: <20240418133923.3705-1-fabio.aiuto@engicam.com>
 <20240418133923.3705-2-fabio.aiuto@engicam.com>
 <20240418-lapel-monstrous-5774610c7405@spud>
 <20240418-distort-dial-c56ca175d8b0@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418-distort-dial-c56ca175d8b0@spud>
X-CMAE-Envelope: MS4xfLAlsPnftFFvbX/IYDRgo9zZ3Ssv4KAUoDvHbqsQCssjDv0qDcDkq8+N3kxJE8/g2dnBLkAvnxkgxRlAZEnR0uE67f2ClYmnaJAE+lkwGGijyLbSJRMY
 vW0C/XXVTOZYfCdov8Q5YGXB6nT2+lWBG52QSuataOeDAYMTTU3nUS7O/IhrbLtSwsxB/in55jAxbc5Rd2569aDS5tnJk7nFfRNuK4/0qY/h1zdSERFfWrfx
 RrCGpcK8qTdtC0l4/e2oAWKpxTaJXMk27VlF5q+7As+s2kdrqAo8FhyCkX3CEaQIy6ZEQQtHQyObxn/26a2ERDZ1EkPc0Za+0AheN0YyuD6LXxsICal+a2Xi
 N+JQxLvfyheOcrNkp5uzvOy+MhXlZ+Ry/Pr02l6aIC1ztWGStWgoW8sELgtkrj19BYV91yCtOJeMX3iL0aWd1n5smqnrv2gzCIOpnqDrvi/rUUj8qoPz2nGM
 aC/lTdu1Hdqv+N3B1ZokH9D2CnKjDfMVA6vTwm7nuO2lwXI+9P7/ZL6IVfTqT12H0NLdsytXWh36BZBoRS0YC+Nk/SjQkQDnWdQynbBm84OdFJ8TgrvU++QA
 69w=

Dear Conor,

Il Thu, Apr 18, 2024 at 05:34:07PM +0100, Conor Dooley ha scritto:
> On Thu, Apr 18, 2024 at 04:33:21PM +0100, Conor Dooley wrote:
> > On Thu, Apr 18, 2024 at 03:39:21PM +0200, Fabio Aiuto wrote:
> > > i.Core MX93 is a NXP i.MX93 based EDIMM SoM by Engicam.
> > > 
> > > EDIMM 2.0 Starter Kit is an EDIMM 2.0 Form Factor Capacitive
> > > Evaluation Board by Engicam.
> > > 
> > > i.Core MX93 needs to be mounted on top of EDIMM 2.0 Starter Kit
> > > to get the full i.Core MX93 EDIMM 2.0 Starter Kit board.
> > > 
> > > Add bindings for this board.
> > > 
> > > Cc: Matteo Lisi <matteo.lisi@engicam.com>
> > > Cc: Mirko Ardinghi <mirko.ardinghi@engicam.com>
> > > Signed-off-by: Fabio Aiuto <fabio.aiuto@engicam.com>
> > 
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Looks like you might've already got an Ack from Krzysztof on a previous
> version. Please make sure to pick up acks etc when you post new
> versions.

thanks for your Ack, will send a v3 including both your Ack and Krzysztof's
one.

kr,

fabio

> 
> Thanks,
> Conor.



