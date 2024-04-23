Return-Path: <linux-kernel+bounces-155836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F95D8AF7C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE922284791
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B31A142640;
	Tue, 23 Apr 2024 20:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="un+zBBTN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7A1422BB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713902869; cv=none; b=oa6YETUfHfTxTD15GgrYbdVrRAO4KJeA4cNDZUhAdoZ6Fgihggac9t4r1NqnFXAvwBc4awBcDT3U8TAxsa1iQ7NE8jTkoUhjWukaxSXd2rn3nOt3vi2CMfeHsMWyLmEL8KKYmgooEHzuDiMGO9Pegp8SNTw7TP/4CiHbvKJ1Nv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713902869; c=relaxed/simple;
	bh=JOx2IlpV2RVCi9C1wxvCwugZvnMEUALYhbRJEjRIV4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBk09N8O/yXaMgH6ePQy2OV3wAYfQOxCg8ieWEKmZn+3oZNf9SI0XtNZKubLwe8d5c8sDAHcP2BY23ULD0x9QIG7vXhLSUPpWXR9rYt/aUnXfuGwu6nAznPl6Zs25k/2RJqMm5yE1ggapipd0rqiHSW0X6XgZ6Coa3UwJUDKFrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=un+zBBTN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58066C116B1;
	Tue, 23 Apr 2024 20:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713902868;
	bh=JOx2IlpV2RVCi9C1wxvCwugZvnMEUALYhbRJEjRIV4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=un+zBBTNHVE60Y0f7g2c0LW4mp3s1H2PbT4U5mrxuOC64cK/4QUnk5TusO5y1TdUm
	 oFaDhlKOhIhBAqlvRKIT4fGq9vukCLmupqFCoz77HIVt5fCwcjiC007RRX7UkAQ9JH
	 JV8aA/jXzD7E1ye4ESwI4qMuAoUAUenrFqkLdcFXhzSVjSQd5GJ8HHS18UQqX0sAbd
	 7tBeQGL3BYoeIPddJq+ncO9vPDO/Al4RNZCEnRpBaMl2xBr3IMKpoZ5TlyXIuJw40O
	 psdMVLBFqM391tmIgCXDxHWEtaVehzW7dSiXUmWs4hYD6ssWz9VL0emdh3mHjOr6HA
	 ifkQRQGW3/ZbA==
Date: Tue, 23 Apr 2024 17:07:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: limits.h in tools/
Message-ID: <ZigVEdYKyYw36NoM@x1>
References: <ZigEvxn0-70og0H1@smile.fi.intel.com>
 <ZigKWZKY6kq-w0Tp@x1>
 <ZigMG8ZsBryO57zz@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZigMG8ZsBryO57zz@smile.fi.intel.com>

On Tue, Apr 23, 2024 at 10:29:31PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 23, 2024 at 04:22:01PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Apr 23, 2024 at 09:58:07PM +0300, Andy Shevchenko wrote:
> > > It seems tons of the code in tools include linux/limits.h. But I haven't found
> > > where do we copy it. Any pointers?

> > > Based on the discussion 20220603183231.15159C385A9@smtp.kernel.org.

<SNIP>

> > But then is for building tools/, not the kernel, right? The discussion
> > you said this question was based on is about changing
> > include/linux/xarray.h, a kernel file, so should really be including
> > just kernel headers, files in the kernel source tree, outside tools/, I
> > don't see where what tools/ uses to build is relevant here? Can you
> > please elaborate?
> 
> I believe the tool in question is tools/testing/radix-tree/xarray.c.

And it is including stuff from the kernel directly, something we stopped
doing long ago in tools/ to avoid breakage when a kernel developer
changes kernel code:

⬢[acme@toolbox perf-tools-next]$ cd tools/testing/radix-tree/
⬢[acme@toolbox radix-tree]$ grep -A1 -- -I Makefile 
# SPDX-License-Identifier: GPL-2.0

CFLAGS += -I. -I../../include -I../../../lib -g -Og -Wall \
	  -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined
⬢[acme@toolbox radix-tree]$ realpath ../../include
/home/acme/git/perf-tools-next/tools/include

So far so good, no kernel files included, only tools/ stuff, but then:

⬢[acme@toolbox radix-tree]$ grep xarray *.c | grep include
xarray.c:#include "../../../lib/xarray.c"
xarray.c:#include "../../../lib/test_xarray.c"
⬢[acme@toolbox radix-tree]$ realpath ../../../lib/xarray.c
/home/acme/git/perf-tools-next/lib/xarray.c
⬢[acme@toolbox radix-tree]$

And this in turn will:

⬢[acme@toolbox radix-tree]$ grep ^#include  ../../../lib/xarray.c
#include <linux/bitmap.h>
#include <linux/export.h>
#include <linux/list.h>
#include <linux/slab.h>
#include <linux/xarray.h>
#include "radix-tree.h"
⬢[acme@toolbox radix-tree]$

Includes kernel headers, as it _is_ kernel code.

Perhaps since it does that we need to add -I../../../include to the
include path to really include kernel headers?

⬢[acme@toolbox radix-tree]$ pwd
/home/acme/git/perf-tools-next/tools/testing/radix-tree
⬢[acme@toolbox radix-tree]$ realpath ../../../include
/home/acme/git/perf-tools-next/include
⬢[acme@toolbox radix-tree]$

- Arnaldo

