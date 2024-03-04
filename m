Return-Path: <linux-kernel+bounces-91415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA54871139
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F51DB21621
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF257D3F1;
	Mon,  4 Mar 2024 23:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFli5yUZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DC37D077;
	Mon,  4 Mar 2024 23:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709595582; cv=none; b=Jpi8Y24Ruzo1vhVetLXZIbpdWn0e9A+ADqAU58P8659GxBrkvMdcjS7lxQvB0q1JBAn37IP1q/JCDLFidC7C43rcO7AFv416lawqhiCLCFb+yr6icYZO6s9Oew7LefKEntPzLTAvxejNI7wuAC2PVNfmEKRhGsbjwaJdyGDaQvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709595582; c=relaxed/simple;
	bh=qWunR2PHRPgc28nLi8EbAQUGH1RblUct3QxLOxF065I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=obGk1orOaDP/7rGaoIWZcMdyi5Ee0osdgXceVqUfyJrOoXBprxUsTYzA48Dx48THMK2sGPt/yyR1jpn7oggPLDxdw/4GjdFM1X25aiQbXZjfopN8r8EAp3QDsWdCRXpMq0htY2W4qIyTZQCT/nhAcL7oro46kaXCNgfyFMpSraQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFli5yUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A27C433C7;
	Mon,  4 Mar 2024 23:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709595582;
	bh=qWunR2PHRPgc28nLi8EbAQUGH1RblUct3QxLOxF065I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GFli5yUZrWbVYiRm0XFFhFrA0VwbLHKdeuVRyD97benQkukhW1azV4BOVeLrg6uia
	 UTscFv9dXeAc/ae0cksyW50diqcbz21PYXGkxZySDrdKMhn4ccr3pAIXD5GPnz5cdF
	 iSqS55ilheCE1Mi500inGqTneqwrD61R46iBv40CtUcU4O5fALKcTqoakELiIlsIj8
	 ReoW7b3++Nqsh3ip8GaI/JxFEe5n8UrViObqHv68V7yFPJMuGM44saS9lXxW3hEmdW
	 TaysFz9cL51hmF2VSj1oYYsHwkT9UZYOSB0H+BFLjtd0w/lmUnMzmcPHiiE5pKWEEt
	 k6BdmQkwITGkQ==
Message-ID: <ec20f7d5-90a3-47a7-a98e-2660ae0f2c08@kernel.org>
Date: Tue, 5 Mar 2024 08:39:39 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] scsi: aic94xx: Add libsas SATA sysfs attributes
 group
Content-Language: en-US
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>,
 John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>,
 Xiang Chen <chenxiang66@hisilicon.com>,
 Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
 Bart Van Assche <bvanassche@acm.org>
Cc: TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240304220815.1766285-1-ipylypiv@google.com>
 <20240304220815.1766285-7-ipylypiv@google.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240304220815.1766285-7-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/24 07:08, Igor Pylypiv wrote:
> The added sysfs attributes group enables the configuration of NCQ Priority
> feature for HBAs that rely on libsas to manage SATA devices.
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


