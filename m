Return-Path: <linux-kernel+bounces-105687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A562B87E2A4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 04:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3572EB20C3A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEA21F951;
	Mon, 18 Mar 2024 03:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Rtap6GhU"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568081E86A;
	Mon, 18 Mar 2024 03:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710733076; cv=none; b=Qw3pTTX9okvHNRwNv7BbnqtTdEUWQ/QFPD+PzgTHEwu/VnRAW2CvMT4XzeW6mu4sdoPUZ0FaNzHKVcLPVm2emD7ImslZPn5tDc7b/0o4lvPzqut9+qS54PKy/IGHOJBp5W0amkQdIkMxSNWqYLPQOEbfWttI+lU/GoRAIeMdHUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710733076; c=relaxed/simple;
	bh=Z0/gdV4cCBOh4vllNLfzHr1A+MKLPraA8SnzR3S6xJ4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ruo88fRmwyJ5qmwujd9Ymig+Xj13vZatx05MRN5Cseyymx1eNwd3SZ72fKKR8SGnjpPFL7AfLwFG5DDkw2eLhjgXojcq3dAEUF+32DI24ejS5MFIuD7Sr6v4hpHtzatbNx3kuPSgCHMXC09/BOeBbNY4JnyLqXF8ufaDR9fs7BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Rtap6GhU; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42HKwTdS030284;
	Sun, 17 Mar 2024 20:15:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pfpt0220; bh=5PHteGiApJD0KUkkw4/qyw
	UQZ26T+OOJg48LpixAtFg=; b=Rtap6GhU6GXV2oh5Gu7SJGCbR2fWjlJ1/dKgaO
	gaYCcaEAVpuUqSwGtTM7Rx7vz8Yyh8WBsh6WPyuVRtvHPKVv5uI9w/9XlI9/ARgK
	97TXEaUaT+Xy5oPnw/6mb6NzMpH6b5iDrFZkqTr2M5v28553OA7yzp0RpP9rl0RA
	etlTdT9Zf9SGwjqkHGTyBR73CN7CNpd6OQkTYIm0494+Tu2KDVnM+I3zITds6z9+
	M8ywX/jq2T8mceQmF7F+vxQ9IG4jXPuVMUEYvlPM7NGBW3tZD24f+SeTZ40qH2mS
	dAH3kpnsjn+1l9EpivwddoeT4WTKIchsDLz8TYuJHJW3sg+A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wwaxgbder-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 Mar 2024 20:15:04 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Sun, 17 Mar 2024 20:15:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Sun, 17 Mar 2024 20:15:02 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 8482C3F7065;
	Sun, 17 Mar 2024 20:14:58 -0700 (PDT)
Date: Mon, 18 Mar 2024 08:44:57 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jijie Shao <shaojijie@huawei.com>
CC: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <michal.kubiak@intel.com>, <shenjian15@huawei.com>,
        <wangjie125@huawei.com>, <liuyonglong@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 net 1/3] net: hns3: fix index limit to support all
 queue stats
Message-ID: <20240318031457.GA1312724@maili.marvell.com>
References: <20240316111057.277591-1-shaojijie@huawei.com>
 <20240316111057.277591-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240316111057.277591-2-shaojijie@huawei.com>
X-Proofpoint-GUID: tcY-9LN2-udleDWftkZ1_pn0UqaAua_S
X-Proofpoint-ORIG-GUID: tcY-9LN2-udleDWftkZ1_pn0UqaAua_S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-15_01,2023-05-22_02

On 2024-03-16 at 16:40:55, Jijie Shao (shaojijie@huawei.com) wrote:
> From: Jie Wang <wangjie125@huawei.com>
>
> Currently, hns hardware supports more than 512 queues and the index limit
> in hclge_comm_tqps_update_stats is useless. So this patch removes it.
s/useless/wrong
>
> Fixes: 287db5c40d15 ("net: hns3: create new set of common tqp stats APIs for PF and VF reuse")
> Signed-off-by: Jie Wang <wangjie125@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  .../ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c
> index f3c9395d8351..618f66d9586b 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c
> @@ -85,7 +85,7 @@ int hclge_comm_tqps_update_stats(struct hnae3_handle *handle,
>  		hclge_comm_cmd_setup_basic_desc(&desc, HCLGE_OPC_QUERY_TX_STATS,
>  						true);
>
> -		desc.data[0] = cpu_to_le32(tqp->index & 0x1ff);
> +		desc.data[0] = cpu_to_le32(tqp->index);
>  		ret = hclge_comm_cmd_send(hw, &desc, 1);
>  		if (ret) {
>  			dev_err(&hw->cmq.csq.pdev->dev,
> --
> 2.30.0
>

