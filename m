Return-Path: <linux-kernel+bounces-78192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFE3860FFD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14CA1C2311E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868A463110;
	Fri, 23 Feb 2024 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnOztFFx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBBF22067;
	Fri, 23 Feb 2024 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708686111; cv=none; b=moXIUGEJwDVR8jEUd7W3q8P5x2RNaPCPcU2n4ZtjJ/KUP1rwJe5kYtYLapKXHBmm7i81f9D2XdCGDUErow/Sxz7apVzpgVYHLgAH+GQOX35mWs9Mx5pcSAgUCT1S4o11NebaHOP9dmIZ9umifhMDCGPzt1WQF9hT0MkHCAhCBwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708686111; c=relaxed/simple;
	bh=2wPi7tVov++EwHSBSYcPIxajIvKxESE+Wf+/xZ0glfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxvozFiz4mur05mOMH/5KLYIGb/IQ8jcL0OJPxIEDVIKdj+5na/m0J7ZiZeBHhRRQGkLNv4fVZDVwFgVKCVuPlNHPcGTQKdvQlvxWdepeRzgLnIyqpwn/L2TrYPhYqdESBjl64DMDozeyEVJRIaxk16S5/38oZsoPYi6yHxKDxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnOztFFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8D8C433F1;
	Fri, 23 Feb 2024 11:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708686111;
	bh=2wPi7tVov++EwHSBSYcPIxajIvKxESE+Wf+/xZ0glfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XnOztFFxOk7u9hifZnMNcODFeK3RHDGByqdt3YctKPvlCQ2D4lQP/Ah9i8YzcpYsy
	 uFgAdjYuiHpQtobYaI0ciFZR+y67RytWOCXtCUnMPtksDwnjgIju2RTT+c2Glvqyjh
	 O4qVVchAxue8WUQuBixYfdocl80U32dQx1UWHEBRN6aDdTaAWEkgzoiNEuiYR7QGRc
	 CMwYkpNGOAK/qZGD3BPbE3hugFaUyukJlrb4mWimtxSIaaCXi2gLtVM6Z/rWj4YC3U
	 Vs+JkEdz7w6Fb1NnnFlB78GWuefrAZL8CeHHaRRqZ4Rd3XncvOxK+6arp/7z6zu8eW
	 IqCRYyDCqwHzw==
Date: Fri, 23 Feb 2024 11:01:47 +0000
From: Lee Jones <lee@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Vadim Pasternak <vadimp@nvidia.com>,
	Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org
Subject: Re: [PATCH] leds: mlxreg: fix a kernel-doc warning
Message-ID: <20240223110147.GV10170@google.com>
References: <20240221060153.3924-1-rdunlap@infradead.org>
 <20240223110100.GU10170@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240223110100.GU10170@google.com>

On Fri, 23 Feb 2024, Lee Jones wrote:

> On Tue, 20 Feb 2024, Randy Dunlap wrote:
> 
> Would you mind being more descriptive in your subject lines please?
> 
> It's common for people (me included) to find subject lines a reliable
> way to search through Git history and these types of descriptions are
> likely to cause duplication.

Also if you push them in a set, they're easier to apply.

-- 
Lee Jones [李琼斯]

