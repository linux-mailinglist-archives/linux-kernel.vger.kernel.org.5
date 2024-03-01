Return-Path: <linux-kernel+bounces-88850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3AA86E779
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265821C2522E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772F31171C;
	Fri,  1 Mar 2024 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GWR6kZ6s"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF828BED;
	Fri,  1 Mar 2024 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314786; cv=none; b=d91UVd5syLU1lUC5Tcy9Imf3sGatNGnp/q6bKpzrHqvlisheEEqyasjC+Bz0INPAPdUqXujud6pjbW4HpvU99qYJve++7/+X7TDIJcuKKIRFjKY3eVORprKkMhWA0uR5YU16mW/nE0+fLytwXFqS1lmJUiTy0IfZ8P2qTLHb5N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314786; c=relaxed/simple;
	bh=VE2uSRmbnrUTIwI0MsFFp9dkOgavVaKfIAsVt33kwLE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QViCiqY10P9rHlKvTxmM1eecHO1+jVUYQ3LCxE2QW4KHDW2xaNYktllspb73CYazu9tk45kAUujq1mdKd7L99PbeCuOpECBAtMAM52D8ZfE4yNwS6+7CKA8zInn//CHXpK8ZzFf6GavqX3oh9Kj43gtamZdkV5FchD9Y0qu+XqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GWR6kZ6s; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B7F1240003;
	Fri,  1 Mar 2024 17:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709314782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HPOP82Swf39Z+Oml/HNNIoo3JMbE10x1ALBHxRiVIp4=;
	b=GWR6kZ6sqnLHbD99ZA24rS7vAWtep94ya9NrWpvjdjoRU666FY23absUBejh5k+F1ZnjqS
	vmTZ6iMMzqD49O7v2Yh+QIbMT1KE1zy+Tdi98zGRiKtU26wJSIs9TWcWZA+VQsfiRxYzwE
	BAFH32DSCmJkBOMpqeHx96/SKusM3TlsbbTs3zo5dlNrr2aMoCdNhllZoYe3+wc2zFuogv
	4QpwqK264eg2jGDAYH5JEdEo+ONGAJVGkwb72LSQ13MtxNVWRAupfGJIZytBJ0s+FVm0a0
	MJYwRN0pi6J13FmpW2SUSbbHvHTLw+BO6oOD9USIHJPS9bsMOgtBWHmj+ml05Q==
Date: Fri, 1 Mar 2024 18:39:36 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-staging@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Hunter
 <jonathanh@nvidia.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sowjanya Komatineni <skomatineni@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: media: tegra-video: Use common error handling
 code in tegra_vi_graph_parse_one()
Message-ID: <20240301183936.505fcc72@booty>
In-Reply-To: <dbebaea7-289c-47d9-ba06-cd58a10ea662@web.de>
References: <dbebaea7-289c-47d9-ba06-cd58a10ea662@web.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Markus,

On Thu, 29 Feb 2024 19:55:46 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 29 Feb 2024 19:44:36 +0100
> 
> Add a jump target so that a bit of exception handling can be better reused
> at the end of this function implementation.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

