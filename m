Return-Path: <linux-kernel+bounces-92394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1C7871F88
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94F51F24908
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2C085924;
	Tue,  5 Mar 2024 12:52:58 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467B558AB6;
	Tue,  5 Mar 2024 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709643177; cv=none; b=eE9JxOWstlIkS/tDqIsZkk3Qp9g0jBoF9bjO3PRz/+tsrR34ut4Qb0iOd8S5+q+JBOt8Ep/yxZW9QMl8JUaPYNDu5XVqtz0uC5kNf6195cMRkgXQohBePbtaR7Ml0cagZqadHCgMASBxv1AG98xryCi0TD0mQzYyvOizEpaSv3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709643177; c=relaxed/simple;
	bh=PdbnMPyyYKG2TQSVFws5F7uJoRn6RFe91rvJx4Te/N0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dhQg6l6rm2cJNLvIXjp6hlq8wVrJKNX0sJl4eDjcxHS6sgpQuEXdg0inEjh0IHTOu2L8mboTxyolFI1aFqgRAIWawdCGvegTnIkH9yRaO6E203YVWIwMbuLXwdqpZu3+U6LywuFUR1KdQYOznjePGXZDTdl3e6OLYgJIR8Ji2fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TpwQc44CTz2Bf6c;
	Tue,  5 Mar 2024 20:50:32 +0800 (CST)
Received: from canpemm100004.china.huawei.com (unknown [7.192.105.92])
	by mail.maildlp.com (Postfix) with ESMTPS id DFD631402CE;
	Tue,  5 Mar 2024 20:52:52 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm100004.china.huawei.com (7.192.105.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 20:52:52 +0800
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 20:52:52 +0800
Subject: Re: [PATCH 2/6] scsi: pm8001: Use LIBSAS_SHT_BASE
To: John Garry <john.g.garry@oracle.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <chenxiang66@hisilicon.com>,
	<jinpu.wang@cloud.ionos.com>, <artur.paszkiewicz@intel.com>,
	<dlemoal@kernel.org>, <ipylypiv@google.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240305122452.340471-1-john.g.garry@oracle.com>
 <20240305122452.340471-3-john.g.garry@oracle.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <b867bd2f-37df-0674-ba5d-4b3adfa8ac67@huawei.com>
Date: Tue, 5 Mar 2024 20:52:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240305122452.340471-3-john.g.garry@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500004.china.huawei.com (7.192.104.92)

On 2024/3/5 20:24, John Garry wrote:
> Use standard template for scsi_host_template structure to reduce
> duplication.
> 
> Signed-off-by: John Garry<john.g.garry@oracle.com>
> ---
>   drivers/scsi/pm8001/pm8001_init.c | 20 +-------------------
>   1 file changed, 1 insertion(+), 19 deletions(-)

Reviewed-by: Jason Yan <yanaijie@huawei.com>

