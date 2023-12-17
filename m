Return-Path: <linux-kernel+bounces-2693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8933E81609C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471B0282363
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E01544C9E;
	Sun, 17 Dec 2023 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LvqGtz/K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E0B46420;
	Sun, 17 Dec 2023 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BHGovfq007703;
	Sun, 17 Dec 2023 17:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5xfkxt1tTtX55og26Me4Y1UbjKI2CLMX4oDvwX0MEjc=; b=Lv
	qGtz/K5MopP7VH2jP3SF1BSKh2vLLtBfUDXlKJvoFuz9xnhLU7S3wZOnN5UFgD1o
	ciVZrKL/x0V7+u7+QrJMMfzQIdSzXlKcBOyPLnGWxxxtgmiC2JIbHl0oOx/oxbLw
	ybsqpd1QAB9Fe4GyG6i4xHG431oSOUsAv8/X9qvNAeWxIo0aahjTQBkvzoipP7NG
	jaXums8Zs1z0yaU4wG3WAsnmfGwxfrMBowja+EZ4tPCChJ1YqrFixJO8Ynz6EVjL
	kND/CydxDigKmIHPgvRFGjRF92Q1wEIq/HGgsOpj28qCY8RdHcX79zGcuNZnTxmt
	bykOjZZVEGyiKLon3t/A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v14yg2gu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 Dec 2023 17:03:29 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BHH3Sil002967
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 Dec 2023 17:03:28 GMT
Received: from [10.216.17.18] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 17 Dec
 2023 09:03:23 -0800
Message-ID: <0debdc71-2ee2-4a0d-9789-5aea4191a305@quicinc.com>
Date: Sun, 17 Dec 2023 22:33:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 0/2] Add CPU latency QoS support for ufs driver
To: Avri Altman <Avri.Altman@wdc.com>,
        "James E.J. Bottomley"
	<jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Peter Wang <peter.wang@mediatek.com>,
        Matthias Brugger
	<matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Alim Akhtar <alim.akhtar@samsung.com>,
        Bart Van Assche
	<bvanassche@acm.org>,
        Stanley Jhu <chu.stanley@gmail.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "quic_cang@quicinc.com"
	<quic_cang@quicinc.com>,
        "quic_nguyenb@quicinc.com"
	<quic_nguyenb@quicinc.com>
References: <20231213124353.16407-1-quic_mnaresh@quicinc.com>
 <DM6PR04MB657594F8BFE75A8F68855A2EFC93A@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Language: en-US
From: Naresh Maramaina <quic_mnaresh@quicinc.com>
In-Reply-To: <DM6PR04MB657594F8BFE75A8F68855A2EFC93A@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: chd14hn0oHDl8Z55uw2-yAAsp83Sp7Pe
X-Proofpoint-GUID: chd14hn0oHDl8Z55uw2-yAAsp83Sp7Pe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=709 suspectscore=0 adultscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312170127

On 12/15/2023 2:35 PM, Avri Altman wrote:
>> Add CPU latency QoS support for ufs driver. This improves random io
>> performance by 15% for ufs.
>>
>> tiotest benchmark tool io performance results on sm8550 platform:
> Will it possible to provide test results for non-ufs4.0 platforms?
> e.g. for SM8250, just to know if it would make sense to backport this to earlier releases.
> 

Hi Avri,

Performed tiotest benchmark tool io performance test on SM8450 platform 
and see good improvement there as well.

> Thanks,
> Avri

Thanks,
Naresh.

