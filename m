Return-Path: <linux-kernel+bounces-20073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC348278F6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C900028452D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D7F5577D;
	Mon,  8 Jan 2024 20:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LKhezgAj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69B655771
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 20:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 408KCVga003096;
	Mon, 8 Jan 2024 20:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bOUKNttGfktqe7VE8ZoTU5OPnxZCVqzq7LfDcVymoE8=; b=LK
	hezgAjvBK7rWq12it0R3vj7GnsfzgVRI+PMwKa9QUmrpfTKio9114BT89Vh2/3nf
	GQaI135oiUlBTKkl0r8WbYhxGHAsWYX+XeDPjF+dKmmY6RN6qAbEzuPjOPwM4WG1
	6A8GqvFVKGRf9z5dAKylmle6g2rHOMj996Yxi+P47ahhIG3KX6/la58zGn3BIc9K
	Aj00y2kdasqsfjhwoLOrIzuWAeqh6HtrjTDC33tlcNBXETi7I8xDjw7uqVBVKqua
	rz+7R4eWRfoQqt3AExnSAQHm6FvbbeDHhko8gdixwbbbVhe1VJbOK3sxRg/DSB6u
	IlhRcL97W7i5QE070Nig==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgq2yr3x3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 20:15:08 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 408KF7xE010645
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 20:15:07 GMT
Received: from [10.110.48.152] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 8 Jan
 2024 12:15:06 -0800
Message-ID: <ca270573-5527-6df0-3fed-17e8c54b4f89@quicinc.com>
Date: Mon, 8 Jan 2024 12:15:05 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] mm,page_alloc,cma: configurable CMA utilization
Content-Language: en-US
To: Roman Gushchin <roman.gushchin@linux.dev>
CC: Minchan Kim <minchan@kernel.org>,
        Chris Goldsworthy
	<quic_cgoldswo@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rik
 van Riel" <riel@surriel.com>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka
	<vbabka@suse.cz>, Joonsoo Kim <js1304@gmail.com>,
        Georgi Djakov
	<quic_c_gdjako@quicinc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20230131071052.GB19285@hu-sbhattip-lv.qualcomm.com>
 <Y9lZoI89Nw4bjjOZ@P9FQF9L96D.corp.robot.car>
 <20230131201001.GA8585@hu-sbhattip-lv.qualcomm.com>
 <Y9mraBHucYdnHXiS@P9FQF9L96D.corp.robot.car>
 <20230201040628.GA3767@hu-cgoldswo-sd.qualcomm.com>
 <Y9r6LtMOPHfxr7UL@google.com>
 <b9b5b669-0318-93c8-c6a0-dbbb797320f2@quicinc.com>
 <ZZiZVnJpOpt1DAq1@P9FQF9L96D.corp.robot.car>
From: Sukadev Bhattiprolu <quic_sukadev@quicinc.com>
In-Reply-To: <ZZiZVnJpOpt1DAq1@P9FQF9L96D.corp.robot.car>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QpD1E0sTmcBht6Zd9wSEJMF_DFTKWM_j
X-Proofpoint-ORIG-GUID: QpD1E0sTmcBht6Zd9wSEJMF_DFTKWM_j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=793 clxscore=1015 priorityscore=1501 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080167


On 1/5/2024 4:05 PM, Roman Gushchin wrote:
> I'm not sure there is a "one size fits all" solution here. 
agree - that's why we are thinking a configurable cma utilization would be
useful.
> There are two distinctive cases:
> 1) A relatively small cma area used for a specific purpose. This is how cma
>    was used until recently. And it was barely used by the kernel for non-cma
>    allocations.
> 2) A relatively large cma area which is used to allocate gigantic hugepages
>    and as an anti-fragmentation mechanism in general (basically as a movable
>    zone). In this case it might be preferable to use cma for movable
>    allocations, because the space for non-movable allocations might be limited.
>
> I see two options here:
> 1) introduce per-cma area flags which will define the usage policy
Could you please elaborate on this - how would we use the per-cma flags
when allocating pages?
> 2) redesign the page allocator to better take care of fragmentation at 1Gb scale
>
> The latter is obviously not a small endeavour.
> The fundamentally missing piece is a notion of an anti-fragmentation cost.
> E.g. how much work does it makes sense to put into page migration
> before "polluting" a new large block of memory with an unmovable folio.

Stepping back, we are trying to solve for a situation where system:
        - has lot of movable allocs in zone normal
        - has lot of idle memory in CMA region
        - but is low on memory for unmovable allocs, leading to oom-kills

On devices where cma region is mostly idle, allocating movable pages from
the cma region would have lesser overhead?

IIUC, this redesign for smarter migration would be in addition to or in
parallel to the CMA utilization right?

Thanks,

Sukadev


>
> Thanks!

