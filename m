Return-Path: <linux-kernel+bounces-98409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDC98779B4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 02:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D42F7B21383
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 01:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8391710F1;
	Mon, 11 Mar 2024 01:57:31 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797737EC;
	Mon, 11 Mar 2024 01:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710122251; cv=none; b=sH7Ofdz6ttJ7yWnuYtvGGlZ0CZF+lGDYOxhh0xQpwoxszTvf9BWM1ZgxfX5+DTgZsYmWndUADjsQRbcx34UWkOWVISDXqbRaEhcKkQ6FdrwBwNFt2ViBzA5m0Ct2FY2xcE6izpmNhYV5Xi/FXpsZPPtYuYIVkjBmN296m8fvGCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710122251; c=relaxed/simple;
	bh=z8MyjMzJL1ARGJIc3kquQRdhTjM6fo2ijLMakMNt/JE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mJsWoTAOQ3yMvBDYrHrKVST9Aym2J1fKDjHauehKFErUBdeZ8p+CgW0X42pFnJ6AV3Wi7sF38APcTqNC5wVITc1jyq1/G14NuimqUvP2xaW2cFcDwrA1FWKV7xxqZOzLsVXdgAFvzEQVdz9fsmMG819JWJu3bI8OPwVgEUMaY9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TtKbL0KtLz1Z1j5;
	Mon, 11 Mar 2024 09:54:54 +0800 (CST)
Received: from canpemm100007.china.huawei.com (unknown [7.192.105.181])
	by mail.maildlp.com (Postfix) with ESMTPS id 8FF1C1A0178;
	Mon, 11 Mar 2024 09:57:19 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm100007.china.huawei.com (7.192.105.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 09:57:19 +0800
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 09:57:18 +0800
Subject: Re: [PATCH v2 2/6] scsi: pm8001: Use LIBSAS_SHT_BASE
To: John Garry <john.g.garry@oracle.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <chenxiang66@hisilicon.com>,
	<jinpu.wang@cloud.ionos.com>, <artur.paszkiewicz@intel.com>,
	<dlemoal@kernel.org>, <ipylypiv@google.com>, <cassel@kernel.org>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240308114339.1340549-1-john.g.garry@oracle.com>
 <20240308114339.1340549-3-john.g.garry@oracle.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <1974cf11-787d-ebe8-853f-56e83e98a925@huawei.com>
Date: Mon, 11 Mar 2024 09:57:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240308114339.1340549-3-john.g.garry@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500004.china.huawei.com (7.192.104.92)


On 2024/3/8 19:43, John Garry wrote:
> Use standard template for scsi_host_template structure to reduce
> duplication.
> 
> Signed-off-by: John Garry<john.g.garry@oracle.com>
> ---
>   drivers/scsi/pm8001/pm8001_init.c | 20 +-------------------
>   1 file changed, 1 insertion(+), 19 deletions(-)

Reviewed-by: Jason Yan <yanaijie@huawei.com>

