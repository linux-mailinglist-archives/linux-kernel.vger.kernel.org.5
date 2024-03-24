Return-Path: <linux-kernel+bounces-112645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 106D8887C7D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 12:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1061C20A5F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 11:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B7617BAE;
	Sun, 24 Mar 2024 11:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aj1MMTKo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9076179A8;
	Sun, 24 Mar 2024 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711278885; cv=none; b=QjdUXQLneBLb/ybZTwhVHIz21E7dXpe3uQjPIOMT0C1Z+ZnPnKnOgLbI6l8zUAqA80CdvJKlLpo5JGGzbIN3lfhaNp5q6173YClcsFv4oXA4JmFLx88G6m47+6KNMh6mKfqsTE7dKXR6ODV4+eaaU8ufXW0xAEVvchFs/xMkgHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711278885; c=relaxed/simple;
	bh=SN6Pqc7k6bM04aXAtJr42bt2bfiL0qQ3d5U4DuQM+Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CwPDzWnuTi/c2KN5iPlf4wPpRE53bFK6qLpGhtaYKPZxVtXj4IV6v6BScDCaVvbwLqNLFRtnCLqfP01UT7Puwfn1lmhRLOXsl262BJisfsF9qqxXrEaRrH7dOhTnoq0WsJttyBDruPIC4Herk4/4NiPGAzXvV72/JKBieuKmELQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aj1MMTKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0891C433F1;
	Sun, 24 Mar 2024 11:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711278885;
	bh=SN6Pqc7k6bM04aXAtJr42bt2bfiL0qQ3d5U4DuQM+Gc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aj1MMTKoMUSCXnk6EnO5id6qBvQsvEyvWJ1tc6sNQNe32VrlTPVUp0ta2R4tDP2iw
	 MHtjKc4jFN+a0uGuWrCG17j/D+RLKkriNibeurmKQnPp3ec8FLzqG2hPTfdePRPzMA
	 k8Kd4EByxJJVL4LCN4vLBRpmPv0mu8hd4ruU95ztxg5YgcEYeMYMDQw/g7uVpWhd8S
	 CVAxaYd9N4UN9108WQ8TyVPS3mP3gJc/vPU7E1DH0WlW/6p8wvXrhH0w/wCEZBT0mA
	 5e3/fEkKw7Fu4hiUOsL9CAOJjTK7OuJxdJhaG4R0/IGv4TaVue+rsokE9DWybzL+gc
	 jEpJ2AdfDRDvQ==
Date: Sun, 24 Mar 2024 11:14:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] iio: pressure: BMP280 core driver headers
 sorting
Message-ID: <20240324111429.3d57683c@jic23-huawei>
In-Reply-To: <ZfrB2U2qUo_A1xye@smile.fi.intel.com>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
	<20240319002925.2121016-2-vassilisamir@gmail.com>
	<ZfrB2U2qUo_A1xye@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Mar 2024 13:00:41 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Mar 19, 2024 at 01:29:20AM +0100, Vasileios Amoiridis wrote:
> > Sort headers in alphabetical order.  
> 
> FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 

Hi Vasileios.

To reduce the number of patches we need to consider if this goes
to a v4, I'm going to pick up what seems to be definitely ready to
go now.

Applied this one to the togreg-normal branch of iio.git and pushed
out for 0-day to see if it can find any problems.

Jonathan

