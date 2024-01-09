Return-Path: <linux-kernel+bounces-21289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4A3828D1B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49043288326
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A11C3D3A5;
	Tue,  9 Jan 2024 19:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HLEmCHfN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Iqf0/MA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3EE3D386
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 19:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704827187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JdGPz4mTDft8sCj+fcRW3sdwRbr0YBOH8SMWZ+mJ7KA=;
	b=HLEmCHfNMgU7aHarvzSHMP+WYna24d6t5+TvcctUyetZ1KzvLh3xJqRSQpwkTmEAgqvIz3
	1BIGJxRCZXCnmCMDXsTpZDTScadyW8h3lJnEBty+WJasT72kFSh1nWuUtbgvEO40LDbnpC
	nrsTHKMVrGSXXt5M6SdyVwNhHviNsobvPIbZBt3oxHqB3MDclZRM3CPnzLiK6aC8j8tDQw
	XSIfw+ONJ0rDQG4ew21IIZUUyB2UhJmOVbffWJQvGnikrpgxcqL1Qgo1Al2s6ps4klmDKg
	HNA1KSziHZWvkvpy2doJpX1hhQEGzyCKwrgAC2J4+n5DJEcyjr4TwhWGYnQ6zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704827187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JdGPz4mTDft8sCj+fcRW3sdwRbr0YBOH8SMWZ+mJ7KA=;
	b=3Iqf0/MAsrJSbcgYeDZOnIoywP7x6q4kWsgXRcS8MIfZE0DYdHQInfKRiEbITJ6DsaCcZc
	/cr4IWgBj3/TqUAA==
To: Andi Kleen <ak@linux.intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mtrr: Check if fixed MTRRs exist before saving them
In-Reply-To: <20240105163711.9278-1-ak@linux.intel.com>
References: <20240105163711.9278-1-ak@linux.intel.com>
Date: Tue, 09 Jan 2024 20:06:26 +0100
Message-ID: <87plyajphp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jan 05 2024 at 08:37, Andi Kleen wrote:
> This one place forgot to check the fixed capability.

What's the consequence of that missing check and shouldn't this have a
Fixes tag?

Thanks,

        tglx



