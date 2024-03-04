Return-Path: <linux-kernel+bounces-91412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B8687112A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2038A2838AA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DC47D088;
	Mon,  4 Mar 2024 23:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IE5ELBQ/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F427CF37;
	Mon,  4 Mar 2024 23:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709595535; cv=none; b=CYpBqkje7Q0p4r0yEAOaQIQNaV3Rdr+FqMCJK4CMmS2zECU+IARlia42VZdlP5P74dKqkUius4RiSovoGzqM9Jwsk2bjjTDLU9FD6O93fXSZ8NSy5WrDK+BaYVavysrJkrZbRDCODFy5EV58cw6B5FE4l4l1P0hMOoNjfQKgGbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709595535; c=relaxed/simple;
	bh=qWunR2PHRPgc28nLi8EbAQUGH1RblUct3QxLOxF065I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGOvEyeQpaA/ZpfRiWFk73TyOy9zIYt9o8bUMMrMy5eMejsmZr74o4zxfgdp4FtYhyV6Nnuiaa0Dc3Oo1Qv9EoyewAKRK18W2d6aBieJsL+78qAWpoG4fAfeDk4jOOKh0Ps5tZaC5IazuJqkv7qAoZvcH9pZaJjuFNY0A2iUd14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IE5ELBQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37239C433F1;
	Mon,  4 Mar 2024 23:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709595534;
	bh=qWunR2PHRPgc28nLi8EbAQUGH1RblUct3QxLOxF065I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IE5ELBQ//KXm5sfEXelH6BI4YCqnzn46XjnfN9agHFBWH3/TaAc320nDmw9x7Hl1O
	 LgN5q70C5fXTDSpAqOik+jOQnr8oCRm2R8jJ9O74LzDWZW9206BfgZI/cn/fLc1gJw
	 e2zjybK+Oe3oMN6P8Jr8IlA+jp4ZlZQbb/tzQuykVkHfumw/BLiSaQicL7u7oc4UOY
	 H7U4EIMPpxXZZ7X8msZB5wtgpP9FwP2XmsMjF+EqRmd52q5FPTVQxcSIfm53LZ8+Jb
	 fkdIg47VRxErMKzI4Yo4nh38N6p+dwxkTw5IX4kVtOooyeuf6E5ZuNbV4KAaoF7qpS
	 B46ijG13lsVnA==
Message-ID: <b3fe6240-6a8c-4bd2-a618-28368ec30e74@kernel.org>
Date: Tue, 5 Mar 2024 08:38:51 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] scsi: mvsas: Add libsas SATA sysfs attributes
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
 <20240304220815.1766285-5-ipylypiv@google.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240304220815.1766285-5-ipylypiv@google.com>
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


