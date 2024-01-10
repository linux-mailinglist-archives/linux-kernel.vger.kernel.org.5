Return-Path: <linux-kernel+bounces-22581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCF5829FFD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE381C22101
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D4D4D131;
	Wed, 10 Jan 2024 17:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Y4jDqD9u"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0774CB3F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-122-95.bstnma.fios.verizon.net [173.48.122.95])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 40AHvtIZ003037
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 12:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1704909479; bh=nqWp1AlnbuwZfJoqzj4xQjy815p073VnxMNvr20+I7M=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Y4jDqD9uXbdLRKZsbpQvfv7Aj1Nz8irUOHs/iscGs8Oxsl1EBceZSPIaLMf/jnm77
	 OILETpJr8r5E6GMHekO8yZoOfjuSnYP/zWxQvVVnxJgV0fJaU2YJ2En1BtQMsPjBQF
	 jyYEZ/nrzcV960fMdtUrIVSHmnooOuffKwlYxi6SwjrHPmgeEBz9nqyHVcZeeSu0fu
	 DSOhV8EShOzBfRTf8sUnCdnxQFyVX+Hu1mpyuOEslFDYGUkx7RgM8f245LiGDaoYex
	 ZJm7KyMNGNVTjvMXXHCl8GU18JPYVHt6pYeMEybssU0FGPcRLyVfPK1J5cAiROynvw
	 I/t+shh/j1+rg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id BF11B15C0276; Wed, 10 Jan 2024 12:57:55 -0500 (EST)
Date: Wed, 10 Jan 2024 12:57:55 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Neal Gompa <neal@gompa.dev>
Cc: Jason Gunthorpe <jgg@nvidia.com>, jirislaby@kernel.org,
        dhowells@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        pinskia@gmail.com, kent.overstreet@linux.dev
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
Message-ID: <20240110175755.GC1006537@mit.edu>
References: <938ebce3-74c5-4fcf-9de3-849271d3581d@kernel.org>
 <20240110130456.142763-1-neal@gompa.dev>
 <20240110155233.GA623732@nvidia.com>
 <CAEg-Je_P6-3PWNxM4HCzcgM=H4Y1vmywaM3gbwK0gAe0UVoZGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEg-Je_P6-3PWNxM4HCzcgM=H4Y1vmywaM3gbwK0gAe0UVoZGw@mail.gmail.com>

On Wed, Jan 10, 2024 at 11:25:29AM -0500, Neal Gompa wrote:
> 
> For what it's worth, I'm totally in favor of C++20 as well. I've
> mostly written C++17 as of late and it is really nice to me, but I'm
> genuinely excited about C++20 and newer revisions.
> 
> I also think that Linux adopting C++ and intentionally adopting safety
> features that exist and are being added to C++ over time would also
> further encourage the ecosystem to use them as well as make the Linux
> codebase much easier to work with.

Can someone speak to whether the C++ standards committee and C++
compiler implementations are more or less unreasonable compared to
their C counterparts regarding compilers being able to arbitrary
statement reordering, or other random futzing all in the name of
better benchmarks, but which make life a living nightmware for honest
kernel developers?

						- Ted
       	      		     	    	   

