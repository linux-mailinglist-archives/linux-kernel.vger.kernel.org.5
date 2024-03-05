Return-Path: <linux-kernel+bounces-93053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2D7872A26
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA1528A6FF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FFF12D202;
	Tue,  5 Mar 2024 22:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PlK6jfmr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B620F12B173
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 22:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677376; cv=none; b=SoRFiROrmtc4Wkebghqxxs0iVbtQcAE0P3JtJVNqdN1jHeMuncq67t4ctBfGpPSsYZrEuIFkIHmjkoPTB2QV0MjeMeNVLch1K6tYypGM38EN64EYSAU3C7V2LpAy4JE7tZBb3P/rZgRpcuEzqCp7dAThXgTOLEsushgWPWH9ISQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677376; c=relaxed/simple;
	bh=cb0U2hOzHVEMJCMJTBTizTB9MDbIyHEwe80vWx/HOAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLfLMwcHLi4cM4H/7dPBH+2rL423fqE2iQuIUPeS5xHeHuIyCZ35oiI8JVGdoQFz2n2Y9YCfLHACf6rQcCEol/LD+XTuTveCtMDhtvP2c69Ar1jrKquNP0jUY/hSnwbZodVBbdhEii6tC9otpZMZC6jFpw0wYM9bf1fMQBepFLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PlK6jfmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01E5C433C7;
	Tue,  5 Mar 2024 22:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709677376;
	bh=cb0U2hOzHVEMJCMJTBTizTB9MDbIyHEwe80vWx/HOAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PlK6jfmrFp5Te4pqyry9Rz78mLl5aFL88YEJFD2doRmmGTTHUkh2yKsJbEBn0AtQU
	 tcOqCuxC/rzQfU2SS69okkJbYEzmFKSjyOVKuc7nXR0mopbP+j6xI/9BEbh+rtu22W
	 4gtPBwt5Qvwnq1ntId6cHwMEXYBCpFVV3sdiBK1Y=
Date: Tue, 5 Mar 2024 22:22:52 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52521: bpf: Annotate bpf_long_memcpy with data_race
Message-ID: <2024030539-semester-handcuff-27d0@gregkh>
References: <2024030253-CVE-2023-52521-d847@gregkh>
 <ZedOVc9h_VTBjHLD@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZedOVc9h_VTBjHLD@tiehlicka>

On Tue, Mar 05, 2024 at 05:54:45PM +0100, Michal Hocko wrote:
> On Sat 02-03-24 22:53:05, Greg KH wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > bpf: Annotate bpf_long_memcpy with data_race
> > 
> > syzbot reported a data race splat between two processes trying to
> > update the same BPF map value via syscall on different CPUs:
> > 
> >   BUG: KCSAN: data-race in bpf_percpu_array_update / bpf_percpu_array_update
> 
> I would like to dispute this CVE. It adds data_race annotation which
> doesn't have any impact on the code generation.

Ah, my fault, I thought the "BUG: KCSAN:" line was a real BUG() call,
it's just a syslog dump, good catch.

I'll go revoke this now, thanks for the review!

greg k-h

