Return-Path: <linux-kernel+bounces-21292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D46B828D25
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44A3B1C246B2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55F13D0BE;
	Tue,  9 Jan 2024 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YOuUA7H+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147A339AEA;
	Tue,  9 Jan 2024 19:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220C3C433C7;
	Tue,  9 Jan 2024 19:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704827427;
	bh=k998Z5RtsfkgnkecMuNj+GOW0Y8q5yrUfmschoqQDwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YOuUA7H+7Rt/pMd1KfgEZAOrIrep6AiS0DR0zFDyWd368U13CSz4Xy+OFaOtanAe6
	 YtT49SfzlXf8c4uKgMVCou1TNCdA2r0aey8IZvT7JN3k8cd8mxAv0v2CeYTIYB32YL
	 luKTNVcABIAnVuSHyUewbo1tZYhReOmVhKp+XHM0=
Date: Tue, 9 Jan 2024 20:10:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthias Yee <mgyee9@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: fixed check alignment of open
 parenthesis in card.c
Message-ID: <2024010920-flatworm-storage-5690@gregkh>
References: <20240109063618.2810-1-mgyee9@gmail.com>
 <cea37e85-cc21-498a-a09e-cfdaf7921844@moroto.mountain>
 <ZZ2W85ap2aMBDi8F@mgyee-VirtualBox>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ2W85ap2aMBDi8F@mgyee-VirtualBox>

On Tue, Jan 09, 2024 at 10:56:51AM -0800, Matthias Yee wrote:
> On Tue, Jan 09, 2024 at 11:22:42AM +0300, Dan Carpenter wrote:
> > On Mon, Jan 08, 2024 at 10:36:19PM -0800, Matthias Yee wrote:
> > > This patch adjusts whitespace to fix the checkpatch warning Alignment Should Match Open Parenthesis.
> > > 
> > 
> > Line wrap your commit message at 75 characters, and also run checkpatch.pl
> > on your patches.  Otherwise it's okay by me.
> > 
> 
> Sounds good, will do. However, checkpatch.pl gives an avoid CamelCase
> warning. Is it okay to ignore if I am only focusing on the parenthesis
> alignment warning in this patch?

Yes.

