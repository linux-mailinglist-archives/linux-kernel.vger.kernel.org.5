Return-Path: <linux-kernel+bounces-124385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7E58916BC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10F71B21376
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590CA5466C;
	Fri, 29 Mar 2024 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dvdknBHB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D18052F61;
	Fri, 29 Mar 2024 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711707958; cv=none; b=bIFCeHGONLhiTd4mAopg1BoMqVxJeaI9cMJUw0eG6MaYNiTcQ5CaAgpIm+8YiGoXfqqiy5cwzQN/rem2mEchJbTvwSyYCcleiBKLuQMR9LCiCC8+9hF2soLCFsN9HHs/ouolxsVYfhJTlxbJ/VsijXYh8STm6elbeehrpqiXoVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711707958; c=relaxed/simple;
	bh=3MalgDy3HFA5HZM/zbui+LEPKnHzf7WcdyEXeFgOkLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDcElWnuo3UrBKVio1WHg5Gx+DrY18dXRrSiwmjm24WQlIbwfZBfXvUKR/+raH/grQLyhSdX2JIA8MRVneUaMVVCChRerICzAQyJnNdaVUzJNyLvyYrmpaCEf3Lu0N5rHqZbiWB1aWg2js4IAnfCqTK6q9VMDCre5MsKYjElFQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dvdknBHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50965C43399;
	Fri, 29 Mar 2024 10:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711707958;
	bh=3MalgDy3HFA5HZM/zbui+LEPKnHzf7WcdyEXeFgOkLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dvdknBHBa5i/b6LSvHuoYDxWxMQAYUeJhiTB4L7X2uyL4lZe/RrdauUGCeIglN6KH
	 Jp/ZBiNc7AhLOb6DWbhOWibzu34dg37QVNG6DMFdcZdbU98aifuysMCDOIHj+uWQB1
	 DFGlA8/zgpgN7I8MHsiguQC09UYljA7uoYXWi+zo=
Date: Fri, 29 Mar 2024 11:25:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	jarredwhite@linux.microsoft.com,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: FAILED: Patch "ACPI: CPPC: Use access_width over bit_width for
 system memory accesses" failed to apply to 5.15-stable tree
Message-ID: <2024032936-bootleg-debtless-1975@gregkh>
References: <20240327121738.2833692-1-sashal@kernel.org>
 <b34308af-ebc9-4a0e-a27b-90d6e176c526@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b34308af-ebc9-4a0e-a27b-90d6e176c526@linux.microsoft.com>

On Wed, Mar 27, 2024 at 08:48:17AM -0700, Easwar Hariharan wrote:
> Hi Sasha,
> 
> On 3/27/2024 5:17 AM, Sasha Levin wrote:
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > Thanks,
> > Sasha
> > 
> > ------------------ original commit in Linus's tree ------------------
> > 
> >>>From 2f4a4d63a193be6fd530d180bb13c3592052904c Mon Sep 17 00:00:00 2001
> > From: Jarred White <jarredwhite@linux.microsoft.com>
> > Date: Fri, 1 Mar 2024 11:25:59 -0800
> > Subject: [PATCH] ACPI: CPPC: Use access_width over bit_width for system memory
> >  accesses
> > 
> > To align with ACPI 6.3+, since bit_width can be any 8-bit value, it
> > cannot be depended on to be always on a clean 8b boundary. This was
> > uncovered on the Cobalt 100 platform.
> > 
> 
> Please see the backport for this patch I sent earlier: https://lore.kernel.org/stable/6df99ad6-0402-4dcf-9a1c-7259436768dd@linux.microsoft.com/T/#u

Got it, now queued up, thanks!

greg k-h

