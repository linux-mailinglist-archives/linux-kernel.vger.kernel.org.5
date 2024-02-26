Return-Path: <linux-kernel+bounces-81229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5F686724C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4041F2D843
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A118B3D971;
	Mon, 26 Feb 2024 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="wlTuwqC0"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC33C2206B;
	Mon, 26 Feb 2024 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944892; cv=none; b=A9fe1DbRJuvi1r3VGfXUv8or0yE2OV8Ipl2H+mi3+xoq51AX71WY3RlObegSm2AmOWr9NPhfdtkad2DAbQz3v8rtFPVu5xct2lMHT3zK/3tAIBlOHrP4aLyFppOil8NroRW88GTersjXXWN0xGaNVIspsh3J5RCNjMUCRPDyK/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944892; c=relaxed/simple;
	bh=YIwSNAafJiqNweT7ikfqNMKQNYGFU3GBRMLIFdVHe9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ix9hUXGHxaBzWkAvr3LP6m5UZeEODVUTsnQS3pdj0gS7B3Jcaq9/uY2IbbjNX5rGkYipOo6vkgyxiaDoW7CREqHrXwDm0ywNPdx7T+BPLHsfAZC7J6tHKof+1CzndZECecpJDAVxBwfScQAPrcJH2H7vNa0uvMqu0GdaX8rCy9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=wlTuwqC0; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 213CF1FA1B;
	Mon, 26 Feb 2024 11:54:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1708944880;
	bh=q3t+9DN4ngdFtdrD/shw1T/iqqp+imBFrdQtbCvoMSk=; h=From:To:Subject;
	b=wlTuwqC0H1O/peAc9lJ9z0cg3MH3qww3bF5PPCHKa/gsvJoHlJh6BeX6Yh1F/8JWN
	 Gqy2TGXS7OigX0xx5ZjAZh8CUmLp1FRsV5HfS9g7FbYxQ4yUsdWO9eX58ccXUwu54G
	 vhbbUewQ4cICT9YHsOUnSUZynO5pMgPkz2PNolQ9DoeEm6GnMZuIK4n2Nh58Gif3eK
	 r3FSAz42CvOntdJVqU7Lb1htcNWEula22vbsU/EsgAF+PC611jRL6WQ1aQ4IlXOTLv
	 yAtSDYjdIQ8/XTQ1WVQFDO8bTlnK99k8jVsYcHBGTYaDfHeGcmjWIxV7ixiWCNMMc9
	 oHvte4g8izPFg==
Date: Mon, 26 Feb 2024 11:54:35 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, kristo@kernel.org, ssantosh@kernel.org, chandru@ti.com,
	rishabh@ti.com, kamlesh@ti.com, francesco@dolcini.it,
	vigneshr@ti.com, mturquette@baylibre.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v4] clk: keystone: sci-clk: Adding support for non
 contiguous clocks
Message-ID: <20240226105435.GA11908@francesco-nb>
References: <20240213082640.457316-1-u-kumar1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213082640.457316-1-u-kumar1@ti.com>

On Tue, Feb 13, 2024 at 01:56:40PM +0530, Udit Kumar wrote:
> Most of clocks and their parents are defined in contiguous range,
> But in few cases, there is gap in clock numbers[0].
> Driver assumes clocks to be in contiguous range, and add their clock
> ids incrementally.
> 
> New firmware started returning error while calling get_freq and is_on
> API for non-available clock ids.

Is this the kind of errors I should expect in such situation?

ti-sci-clk 44043000.system-controller:clock-controller: recalc-rate failed for dev=13, clk=7, ret=-19

If this is the case, I feel like this patch should be back-ported to
stable kernels.

Any malfunction because of these errors or just some noise in the logs?

Francesco


