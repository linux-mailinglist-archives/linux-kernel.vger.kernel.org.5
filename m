Return-Path: <linux-kernel+bounces-156871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 130308B09A5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B761F255AB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED18315B151;
	Wed, 24 Apr 2024 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="hSZsyrnd"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B7715ADBD;
	Wed, 24 Apr 2024 12:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961779; cv=none; b=kfxheOP16JghlJc94o9ND1kqBZUFLK5ZzVBvkWEj36HBP1LFQNSpoIcLs57CGu5Ehiu44FOlOHNf3+dTjfbSG6HNkt7wf8sX6am4Tr1oO5/JoHe3e72/DXm18sRQ/bF7Eo86VbKWVze8izJ2F4+7ReWVs5FvurOtSq+0SkfbgNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961779; c=relaxed/simple;
	bh=2r0Zx60Kk3Gcfn/lsAiAKkp21jd937boMLMyrUqiaVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fCy5jKY5k3G8y/yBaGBR1GFO9Rf+d+p3HFwl23A6HHimG10ckXfb8wJrNrNKOh/Vm89sOAAbmsP+/Kxu9GcCaUUxVFplnA/a8KMqKlqiokg6L2hafTYwkoAE0IXriwpJvQ59Qgh8mQDfXFUk1Yh53Xyhk3sjq2mlXIB7ICYsP4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=hSZsyrnd; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O7hW5Z021471;
	Wed, 24 Apr 2024 14:29:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=0v8FucOCV2cy2eAkTUXe4t7/ZIX5yYmmCfK23IcasIw=; b=hS
	ZsyrndC4U2fgo4zzlDapMaxl7bK7/cG5yCTy/vJO2LIoguD1oLcuE/Tzt1BNaw2R
	k9CRLhbMWInadGCcw8Fh6OReDMcfzbZ7CsbwperoAFdWqSGw4Q0b1T3CBXj57LDO
	UOOZqEg0H+esLKV9BgRCOq8gmWTWX8k40jed1yQb26BI4sgmKqrF5dSQ1WSK3sCa
	Kj4YEorLTiVjVx3Sm/nzYd+JT7IujXOZ4DnRHLpmKJCldZ7tcKruk91PEUtd5ZaU
	PB0pAdrwu4L9ujun8D0u72CGlqBMG6GKtEOPjkBc1GlfWQJsSao2UBvtXfwULRS9
	6x206l5br2uOfxQkSgVg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm51w8c6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 14:29:15 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9D3F940044;
	Wed, 24 Apr 2024 14:29:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4BE4A21B51B;
	Wed, 24 Apr 2024 14:28:23 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 14:28:22 +0200
Message-ID: <9baaed82-c118-4a60-beff-2be9dbe2a6c3@foss.st.com>
Date: Wed, 24 Apr 2024 14:28:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the devicetree tree with the
 net-next, stm32 trees
To: Stephen Rothwell <sfr@canb.auug.org.au>, Rob Herring <robh@kernel.org>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        "Paolo
 Abeni" <pabeni@redhat.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "Arnd
 Bergmann" <arnd@arndb.de>
CC: Networking <netdev@vger.kernel.org>,
        Gatien Chevallier
	<gatien.chevallier@foss.st.com>,
        "Kory Maincent (Dent Project)"
	<kory.maincent@bootlin.com>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        Linux Next Mailing List
	<linux-next@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>
References: <20240424134038.28532f2f@canb.auug.org.au>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240424134038.28532f2f@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_10,2024-04-23_02,2023-05-22_02

Hi Stephen

On 4/24/24 05:40, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the devicetree tree got a conflict in:
> 
>    drivers/of/property.c
> 
> between commits:
> 
>    6a15368c1c6d ("of: property: fw_devlink: Add support for "access-controller"")
>    93c0d8c0ac30 ("of: property: Add fw_devlink support for pse parent")
> 
> from the net-next, stm32 trees and commit:
> 
>    669430b183fc ("of: property: fw_devlink: Add support for "power-supplies" binding")
> 
> from the devicetree tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 

After remark from Saravana I just updated the stm32-next branch which 
impact part of code mentioned above. I think you should get a merge 
conflict on the next stm32-next merge into linux-next.

I will warn Arnd B. about those conflicts in my next PR.

regards
Alex

