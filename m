Return-Path: <linux-kernel+bounces-21115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2614828A1E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DCFD28656A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A323A1DC;
	Tue,  9 Jan 2024 16:37:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C2B38F9A;
	Tue,  9 Jan 2024 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AEE1DA7;
	Tue,  9 Jan 2024 08:38:08 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.28.161])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A7253F5A1;
	Tue,  9 Jan 2024 08:37:21 -0800 (PST)
Date: Tue, 9 Jan 2024 16:37:18 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf test hybrid failing on 14700K
Message-ID: <ZZ12PhUfA_wPAaRR@FVFF77S0Q05N.cambridge.arm.com>
References: <ZYbm5L7tw7bdpDpE@kernel.org>
 <4d86f3b6-eaee-4673-bdf5-3b97c1c1ad17@linux.intel.com>
 <CAP-5=fUfJ-VBGS1D2+WM_eBu4uPGvxJ2KyD4WXzgKRCfGKHTQQ@mail.gmail.com>
 <ZZfwjG-HL5yOEh6z@FVFF77S0Q05N>
 <CAP-5=fUK+t1p0g3dKtgyP0g3oixM1G7Xm4BFneY5EMzRW_urdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUK+t1p0g3dKtgyP0g3oixM1G7Xm4BFneY5EMzRW_urdw@mail.gmail.com>

On Fri, Jan 05, 2024 at 09:21:21AM -0800, Ian Rogers wrote:
> While much has been done in the perf tool to work around latent issues
> with ARM's PMU drivers and the behavior changes they have instigated,
> except for 5c816728651a ("arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE
> capability") where I wrote the original version, there doesn't seem to
> have been progress made on the ARM PMU driver nor on ARM testing -
> which was why such an issue could exist for so long, across numerous
> Linux releases and ultimately break Hector and Martin.

Ian, which latent issues in the PMU drivers are you referring to?

I already pointed out that one of the problems you have claimed to be a driver
bug is actually due to userspace incorrectly detecting support for the extended
HW type, and I suggested some options which you have so far ignored:

  https://lore.kernel.org/lkml/ZV-CUlQhlkdOzfFZ@FVFF77S0Q05N.cambridge.arm.com/
  https://lore.kernel.org/lkml/ZV-ItX1eMeIdo_00@FVFF77S0Q05N.cambridge.arm.com/

I agree that testing is a problem, and we need to do better from the arm side.

Thanks,
Mark.

