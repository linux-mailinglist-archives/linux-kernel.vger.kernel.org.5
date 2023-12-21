Return-Path: <linux-kernel+bounces-8939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EAB81BE56
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49EC1F24FE2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1379864A80;
	Thu, 21 Dec 2023 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vWpR4kQl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268478F48
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 21 Dec 2023 18:36:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703183793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ntjNZRxY+sNLAY7Gfj8g5oJSH4SLb+KMnhjlpLs20Fk=;
	b=vWpR4kQlrr055FH3eNdAxYUB1ugsuSoT9QU3WsoGp+IGv2dkkJ2yMCuZsFShj88F+LPjuv
	Qyln/8YIwjH/zYjbsoO/ZwlYZdsn30Xf/OQfy2Ruj1oMsZ3HBVnQQClY1I5FuTXSuq2vCt
	ZEJ49MOg5KV6ZElGOiLU4GfbwMmyz2E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sebastian Ene <sebastianene@google.com>
Cc: will@kernel.org, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, catalin.marinas@arm.com,
	mark.rutland@arm.com, akpm@linux-foundation.org, maz@kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	vdonnefort@google.com, qperret@google.com, smostafa@google.com
Subject: Re: [PATCH v4 00/10] arm64: ptdump: View the second stage page-tables
Message-ID: <ZYSFrFDHKo_ZTkxM@linux.dev>
References: <20231218135859.2513568-2-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218135859.2513568-2-sebastianene@google.com>
X-Migadu-Flow: FLOW_OUT

Hi Sebastian,

I'm going to try and review the series a bit more after the holidays,
but in general this is unecessarily complex. Furthermore, building out
the feature for pKVM *first* rather than 'normal' VMs makes it all very
challenging to follow.

I would strongly prefer that this series be split in two, adding support
for 'normal' VMs with a follow-up series for getting the pKVM plumbing
in place for host stage-2.

-- 
Thanks,
Oliver

