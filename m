Return-Path: <linux-kernel+bounces-128353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702098959BF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53888B2A75A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846AF14B086;
	Tue,  2 Apr 2024 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aRG/LnTX"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFBC14AD1D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712075228; cv=none; b=CRdM7JX44GBxYUJCzd55VUbUGV1lCoEekuKPbr+HumH3naBhDYP98hxR15ZivlprGmkxWY1llg0lz6K2eOy6OVg60CmHwwX0zjbUSFDLALu8sOnpB/aw72gLcT2bPhHw82qypFDtVGKqzPEee4bJGN4nn98PpLWU59BvLObi/yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712075228; c=relaxed/simple;
	bh=BJU4vfu+z3g053SHP40E2R36tloQfMq8RIZVnHrlbPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+P8XXpyKxN+fA3aOdaDyz16gYRhxAv5uI6aLOpRNMebwAhyTjIqDNWEDm25SkpGVgKjHfS7Ny4WfxyWqXAba15Wt/jUSvhWnuuVvPrUqXls/37vKAubnbqy6oScdc5aPUY1PN6pGDw7bP8XPicoW9UAZ+rLfDOFsy/j/StmkH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aRG/LnTX; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 2 Apr 2024 12:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712075223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eDo8nY8amEAPy/Db2ja1HXtkoOk/7gZIQYCUCHSI5mk=;
	b=aRG/LnTXOta4OCKZIg80NlaFhPIXWbKSBqOHnOKsSLsuMKqOpKYtRlnLbQyebX7DBqhWb3
	Z81zY4+CLQCIn7bvIpFbVAx4vQEzd8myj4JtbCX1g21tenw2YmCqi2tsW6MLE7V8IA+ryK
	oGcGug/4/a3Xlh2t14A47NdyqDBImR0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Daniel B . Hill" <daniel@gluo.nz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mean_and_variance: Drop always failing tests
Message-ID: <pcwt7qagelqmz6zmuyozr7xjpjd7hvtxstsg2ly7rcxieqqvsj@5lknkmhu62y6>
References: <20240225162925.1708462-1-linux@roeck-us.net>
 <57dee893-6ee5-4444-a706-2adec83e9356@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57dee893-6ee5-4444-a706-2adec83e9356@roeck-us.net>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 02, 2024 at 07:03:33AM -0700, Guenter Roeck wrote:
> On Sun, Feb 25, 2024 at 08:29:25AM -0800, Guenter Roeck wrote:
> > mean_and_variance_test_2 and mean_and_variance_test_4 always fail.
> > The input parameters to those tests are identical to the input parameters
> > to tests 1 and 3, yet the expected result for tests 2 and 4 is different
> > for the mean and stddev tests. That will always fail.
> > 
> >      Expected mean_and_variance_get_mean(mv) == mean[i], but
> >         mean_and_variance_get_mean(mv) == 22 (0x16)
> >         mean[i] == 10 (0xa)
> > 
> > Drop the bad tests.
> > 
> 
> I did not get any response ...  ping ....

Sorry, just been swamped - applying.

