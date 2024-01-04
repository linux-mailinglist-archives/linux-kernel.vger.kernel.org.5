Return-Path: <linux-kernel+bounces-17226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6742B824A02
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155AE284F0E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD202C698;
	Thu,  4 Jan 2024 21:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8qTJxD7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6422C84C;
	Thu,  4 Jan 2024 21:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA521C433C7;
	Thu,  4 Jan 2024 21:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704402552;
	bh=ObH3DlocG48BYzArBAyMEYR9Rz30FGvO+EmCKp+LRmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8qTJxD7LoQ0ryKDG/LxO7Wbn58Atrdr4SP0nyhcm7KmKSFCR0dQDvwt11ljEe9Y7
	 kJ0hr0tSZc66cSbCBG0sNbC768N/xPUGu3/SSql5rBdap4FZwkcHVwzPbhB5aSTerl
	 dwr9mRExPKuc8HYffcg01B7tcDybbupnbZj0CacF+BtoLzm7UEU5wtA0I/NsIMn+u0
	 u1aAMzpEjZDc8kpImPFRsIJeuFkYGsYeV/vEo3gzr4nlA9lVqSyH4Tx1WtVPERg7pb
	 01kW/nJst1GgKPwsz3W9mGhXE3BRk38lEr10VbJdvTlBw6f72y1KtHCgTYaJ/LIeYs
	 cj96y6Ernm35Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 5BCFB403EF; Thu,  4 Jan 2024 18:09:09 -0300 (-03)
Date: Thu, 4 Jan 2024 18:09:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ben Gainey <Ben.Gainey@arm.com>
Cc: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"namhyung@kernel.org" <namhyung@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"irogers@google.com" <irogers@google.com>
Subject: Re: [PATCH v1] perf tests: Add perf script test
Message-ID: <ZZcedb1ScQ45LrT9@kernel.org>
References: <20231207174057.1482161-1-irogers@google.com>
 <1ba595108f13fbe9e062b92e2c717f37e6a5ca93.camel@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ba595108f13fbe9e062b92e2c717f37e6a5ca93.camel@arm.com>
X-Url: http://acmel.wordpress.com

Em Mon, Dec 11, 2023 at 05:46:20PM +0000, Ben Gainey escreveu:
> On Thu, 2023-12-07 at 09:40 -0800, Ian Rogers wrote:
> > Start a new set of shell tests for testing perf script. The initial
> > contribution is checking that some perf db-export functionality works
> > as reported in this regression by Ben Gainey <ben.gainey@arm.com>:
> > https://lore.kernel.org/lkml/20231207140911.3240408-1-ben.gainey@arm.com/
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> 
> Thanks Ian. I've run the test script before and after my patch. Looks
> good to me. Please feel free to:
> 
> Tested-By: Ben Gainey <ben.gainey@arm.com>

Thanks, applied this patch, then Ben's and ran 'perf test "perf script
tests"' before/after, with the expected results.

Thanks everybody!

- Arnaldo

