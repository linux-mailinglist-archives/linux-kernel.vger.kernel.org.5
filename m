Return-Path: <linux-kernel+bounces-144791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7477D8A4AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD931F25ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C61339FE4;
	Mon, 15 Apr 2024 08:47:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7B53FE2A;
	Mon, 15 Apr 2024 08:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170832; cv=none; b=k3Sjab84lC7nc97l3EAr4L6Awjee8EGEqjzSAU92VjTGNcdj5u6tPsn0s4QlH/mZU+vshH/tkY6z/Y8fzl8vz4VryHFGxTglAWVEBsL4+lyYK5VE5hOznP7cdiHUgYXjVUaq6o6z0g2hqskVwRtD7fX6SCwNzol+uMqV0VbSKrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170832; c=relaxed/simple;
	bh=K1Izgm9M9NYPkvpelnhwjfrFMBk3G5O77eZS6YtM65M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaFBB4vO2E+GeJ5aKfXUqBsy8XSFBDkRF/F8J3I1h65AlgUFNlCQuV/p0BvCeSBFsxOx/EQXO7FQ2XDD0emphAbsPAqBWWAZWAEt1ZfW6rp3h0izCXDHmgc6od156yGcXknXOclUf5MdBglLvFLWfO2dr4HxBWq3CBzdA1ECrmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 528D7DA7;
	Mon, 15 Apr 2024 01:47:38 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDE163F64C;
	Mon, 15 Apr 2024 01:47:07 -0700 (PDT)
Date: Mon, 15 Apr 2024 09:47:05 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, bhelgaas@google.com,
	james.morse@arm.com, jhugo@codeaurora.org, jeremy.linton@arm.com,
	john.garry@huawei.com, Jonathan.Cameron@huawei.com,
	pierre.gondois@arm.com, tiantao6@huawei.com
Subject: Re: [PATCH v2 1/3] riscv: cacheinfo: remove the useless parameter
 (node) of ci_leaf_init()
Message-ID: <ZhzpiWFCSvWWTqxx@bogus>
References: <20240414025826.64025-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414025826.64025-1-cuiyunhui@bytedance.com>

On Sun, Apr 14, 2024 at 10:58:24AM +0800, Yunhui Cui wrote:
> The implementation of the ci_leaf_init() function body and the caller
> do not use the input parameter (struct device_node *node), so remove it.
> 
> Fixes: 6a24915145c9 ("Revert "riscv: Set more data to cacheinfo"")

Not sure if this can be tagged as fix, but I leave that to RISC-V maintainers.

With the comment in PATCH 2/3 fixed based on your experiment, feel free
to add to the whole series,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

