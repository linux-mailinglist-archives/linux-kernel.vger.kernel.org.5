Return-Path: <linux-kernel+bounces-140177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D36728A0C6B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88FAC1F261E8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBB9144D31;
	Thu, 11 Apr 2024 09:30:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267932EAE5;
	Thu, 11 Apr 2024 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827815; cv=none; b=TR+qPeKp9mNgettW2yan8MaPSOyL336+T1bPDBVeB6J1mef3ro6FWEn6AIQNQntP2kgtmiVuoNNQKrb49wocUpcHxoM3rRKOSrFTeBYAVOKKzuBiVwFfuvBnECkrspEy5V3m+c3qhfctusA6Njbx6PHbE8nBR5GhkCD8b4EWyX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827815; c=relaxed/simple;
	bh=9tf6/NzSwfQ3Vi7lhIXSHNUGVKr3eLMrppEVO217UlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0u0h/TPcmcLckMPUhn1MuD3JthXQFSkYNrysO7c54ipFWsTrQ8Z5FAlhJe7jey4ExuFgqMHh8NjL6Xgda82GTfWb1rtljAUe09c+sJCAR+Wy72P+WHbOL9wYzHM3P4sfFMRE2P9PLdez6RNagVExagUu+4SJ1rVffqQI4xbhPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3789E113E;
	Thu, 11 Apr 2024 02:30:43 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7149F3F6C4;
	Thu, 11 Apr 2024 02:30:12 -0700 (PDT)
Date: Thu, 11 Apr 2024 10:30:10 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/2] ACPI: PPTT: Populate cacheinfo entirely with PPTT
Message-ID: <ZhetojJewygmTf6N@bogus>
References: <20240407123829.36474-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407123829.36474-1-cuiyunhui@bytedance.com>

On Sun, Apr 07, 2024 at 08:38:28PM +0800, Yunhui Cui wrote:
> When the type and level information of this_leaf cannot be obtained
> from arch, cacheinfo is completely filled in with the content of PPTT.
>

Which platform is this ? Is this arm64 based or something else like RISC-V
based ? That would help to understand some context here.

-- 
Regards,
Sudeep

