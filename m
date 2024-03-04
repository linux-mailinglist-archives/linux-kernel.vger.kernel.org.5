Return-Path: <linux-kernel+bounces-91414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC64E871133
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53584B22628
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823197D062;
	Mon,  4 Mar 2024 23:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfk2Tdwv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07CF7D07C;
	Mon,  4 Mar 2024 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709595562; cv=none; b=KlibOggBZqPzmCMhShGZWVI0QnMAqhkCMDeFxhqcNztQYaXyQwDaXuUdjM+jb/OQ2dgvgNYLZhCQzq+/n9fAQkD7N31uD4OylVjL0F99IqCKF5sc1m8R3YQCicPvpotw21Da/PcSuzB4y+Qi82V7qmO0ol0YOcZp1MDJUWrx5Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709595562; c=relaxed/simple;
	bh=qWunR2PHRPgc28nLi8EbAQUGH1RblUct3QxLOxF065I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R58GHakg93akP4oWGYPJLQtOcpVLIO1eMHG8rrvKeF7lJ6NM6SgjtLD/BgPKJP54I+yQdCuxuv1OSMhKbKerSImAVxIJJB82wcued6qA5JWOFTKZmOIpd5yzCEAdAqsbgQc51F6Ebo0XuyhZzJVoljidfh9On61S4WhgkJoWRHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfk2Tdwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C83C433C7;
	Mon,  4 Mar 2024 23:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709595562;
	bh=qWunR2PHRPgc28nLi8EbAQUGH1RblUct3QxLOxF065I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nfk2TdwvzobRtBsvj7eRGt9eQgfxPtBvjeKobtk7aLNA3NALTgIkdJumu+0mquKxw
	 EbQ6i5iyWBzVBTDKd+M0KhTNtxd2f4QR8lhxUTsE/EMOVTUsH0LpXPTFNvg6YOXf6W
	 jBLbknVnV7AV16vbag5SlJ+h3FclORHfUPMP3sdt+BMseaIpz3ejd1SwhMjgzs97oE
	 +8Hhzms0kVWzHP8FtJTggo8AmFTLBWXhIC2cUuJrw9hES/NyHE1xpXkLDTdT0SVQPz
	 3OtCdZfBW/drOIxlRvEUZhtPTt6sKl9miZFKQmgPQ4tVFhDQSb5M0G4AQJ0HsR7c7+
	 vdmezfqec1Qwg==
Message-ID: <35a75b97-1938-49d2-b34e-f05d2f4f0662@kernel.org>
Date: Tue, 5 Mar 2024 08:39:18 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] scsi: hisi_sas: Add libsas SATA sysfs attributes
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
 <20240304220815.1766285-6-ipylypiv@google.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240304220815.1766285-6-ipylypiv@google.com>
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


