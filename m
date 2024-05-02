Return-Path: <linux-kernel+bounces-166377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5599C8B99C8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86C931C21FB9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF12657AE;
	Thu,  2 May 2024 11:10:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881B45C8EF;
	Thu,  2 May 2024 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714648211; cv=none; b=g/0bu0jDLTBwMQCCg8PNAJ3+yieyWhvTDZvcuzhf/seD52Fwm4kkuvbohSZsE8G3hHo2DtpKW6UkS52zRHlebSOtNrCC4VHBns+q/I+coUtNDIjIB3+mrUtO1vPQZdnM0deYWvxC3r+PKafbxm9kVDX2gaRYsa6HbGHFSeXyb9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714648211; c=relaxed/simple;
	bh=eRD7S5ev4HwAFKwLfJ4FGx6RKatqYxUYAdjtfKK0Ekk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B3++t2tSnhZHyeAPrejk6CKYyF7dyI/QBOUUTH/TX+vascNSLkLOsm4XJ/ALUSdTwmFgMHWrtRcX2geSMBmE03rsqyt/PwlbagvPxx+pLRrS4LPY2hmFUXO7PygTLyCLlK5xy1X/ZJhO4ifC9GoKUafLZp/4E0X+EnPTZDWlA5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 235272F4;
	Thu,  2 May 2024 04:10:29 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 241AA3F793;
	Thu,  2 May 2024 04:10:00 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Ingo Molnar <mingo@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Will Deacon <will@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Liang Kan <kan.liang@linux.intel.com>,
	Tom Rix <trix@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Atish Patra <atishp@atishpatra.org>,
	Frank Li <Frank.li@nxp.com>,
	linuxarm@huawei.com,
	Fenghua Yu <fenghua.yu@intel.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Jiucheng Xu <jiucheng.xu@amlogic.com>,
	Anup Patel <anup@brainfault.org>,
	Wu Hao <hao.wu@intel.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Shaokun Zhang <zhangshaokun@hisilicon.com>,
	linux-fpga@vger.kernel.org,
	Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH v2 00/30] (subset) Add parents to struct pmu -> dev
Date: Thu,  2 May 2024 12:09:52 +0100
Message-Id: <171464809867.45069.16014660164973351494.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412161057.14099-1-Jonathan.Cameron@huawei.com>
References: <20240412161057.14099-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 12 Apr 2024 17:10:27 +0100, Jonathan Cameron wrote:
> Robin posted a patch for the cmn and that reminded me that I never
> sent a v2.
> 
> v2: Drop first patch that added a parent to struct pmu as that has been
>     upstream for a year.
>     Drop the arm-cmn change as Robin has dealt with that one.
>     Gathered tags.
> 
> [...]

Applied, subset of patches to coresight/next. thanks!

[29/30] Documentation: ABI + trace: hisi_ptt: update paths to bus/event_source
        https://git.kernel.org/coresight/c/1f82d58ddbe21ed75c04d04403d8268a95e0190a
[30/30] hwtracing: hisi_ptt: Assign parent for event_source device
        https://git.kernel.org/coresight/c/9b47d9982d1de5adf0abcb8f1a400e51d68cca1f

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

