Return-Path: <linux-kernel+bounces-142435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF228A2B82
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17D3D284928
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F14A524B4;
	Fri, 12 Apr 2024 09:47:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2149C54668;
	Fri, 12 Apr 2024 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915220; cv=none; b=LVb1v204V0fnsMGH8DpH31BVtwN0OeRhHxu+hCzzT6DAemgv1bJO5wVohsomRdph6XEdLCPvlYfRy21sZ2qLjqOdS4Y7Y4WbpC35CEFOjukvihcORx9RakpzEqu3ClcAttrjOVEwOk6krfpvTeDJ/fw1qzUIU69FCOgGVhinQ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915220; c=relaxed/simple;
	bh=h6f8y8w1EB4vmaYGFMXAt3NWwiMleFSkOdMtKqaPuSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzU3eABB7Cc2EgbF3AtZrBj0PxMdSq/2GFUnOMC4jXALtL9Z1A/3BTlCZ/yRjrLNilG/kBJcX3aHAp5Re4pU4vqTIIMWQ8PZiFGda8vhmzRcM+OIVQyURslQoDBDvambXWmtrRnSjQkquQ1fBbCm3mu+czbgvrLJXZwzZjUL5JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC7FA339;
	Fri, 12 Apr 2024 02:47:27 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 529A53F64C;
	Fri, 12 Apr 2024 02:46:57 -0700 (PDT)
Date: Fri, 12 Apr 2024 10:46:54 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org
Subject: Re: [External] Re: [PATCH 1/2] ACPI: PPTT: Populate cacheinfo
 entirely with PPTT
Message-ID: <ZhkDDnNvKiyStZZ2@bogus>
References: <20240407123829.36474-1-cuiyunhui@bytedance.com>
 <ZhetojJewygmTf6N@bogus>
 <CAEEQ3wkfHvH4jXNO5NRDf0Fc3xUkY64hp7BDBmgNVdcsmYy-kA@mail.gmail.com>
 <Zhj-4C7xlklG1m5B@bogus>
 <CAEEQ3wkO4WPaY+bPidg-fDqV5MrQwh8ESbSv-+q8Odhat9XDrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wkO4WPaY+bPidg-fDqV5MrQwh8ESbSv-+q8Odhat9XDrQ@mail.gmail.com>

On Fri, Apr 12, 2024 at 05:42:22PM +0800, yunhui cui wrote:
> Hi Sudeep,
> 
> On Fri, Apr 12, 2024 at 5:29 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Fri, Apr 12, 2024 at 10:10:05AM +0800, yunhui cui wrote:
> > > Hi Sudeep,
> > >
> > > On Thu, Apr 11, 2024 at 5:30 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > >
> > > > On Sun, Apr 07, 2024 at 08:38:28PM +0800, Yunhui Cui wrote:
> > > > > When the type and level information of this_leaf cannot be obtained
> > > > > from arch, cacheinfo is completely filled in with the content of PPTT.
> > > > >
> > > >
> > > > Which platform is this ? Is this arm64 based or something else like RISC-V
> > > > based ? That would help to understand some context here.
> > > >
> > >
> > > Thanks for your response, RISC-V currently has this requirement.
> > > Please see: https://patchwork.kernel.org/project/linux-riscv/patch/20240407123829.36474-2-cuiyunhui@bytedance.com/
> > >
> >
> > It would be helpful for the review if you have such information in the
> > commit message.
>
> Okay, I will update it in the commit message in v2. Do you have some
> comments on the content of the patch?
>

I will take a look at the patch later today or early next week now that
I understand the requirement better. Sorry for the delay.

--
Regards,
Sudeep

