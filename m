Return-Path: <linux-kernel+bounces-19140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C41A382689B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688B3281C76
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBEB8C02;
	Mon,  8 Jan 2024 07:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jmQjQkEP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A1A8BED
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 07:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4083W4jo025153;
	Mon, 8 Jan 2024 07:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=pRwL7tB0nJKbdGk2WmSX08I3bGiRbyCJpV6DOrHHcdA=; b=jm
	QjQkEP2MycG3N/fOeBFYRABy7Ct5r4NaE22+DLl4DY/H1v75skDIJBM+uN/8XVIO
	UMJq4DMeh6RwSS+pt+rLmBf/D75Dk6qm4MBssqJljnxLYtUL+f48km8UldKq/abV
	B1ljXRLW+7AryX8Cwty/aJeNMi8/qo+nB6P+gpqqs2fGJt8olqKOf32JOMbWC1v6
	hKVz3ACCGtNN6N2PWpCUQ02NbCUIhrVMIqpdhMbhyfffD4m74qxE88MKFIJSRV/v
	DkmYeQgIpMGth47hKnPMh3BtxE3pXMyYFXuQy+wf0wKk2XuKrz5qGLczNZGTBm+5
	5NGISjWIbRjYfzyE28xg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vg97b0bqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 07:32:40 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4087WduE006648
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 07:32:39 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 7 Jan
 2024 23:32:32 -0800
Message-ID: <2e7ad0c9-ec5a-a65a-899d-a575b6201510@quicinc.com>
Date: Mon, 8 Jan 2024 13:02:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/7] [RFC PATCH 1/7] osdump: Add one new os minidump
 module
To: ruipeng qi <ruipengqi7@gmail.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <bhe@redhat.com>,
        <vgoyal@redhat.com>, <dyoung@redhat.com>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <zalbassam@google.com>, <dianders@chromium.org>,
        <mark.rutland@arm.com>, <lecopzer.chen@mediatek.com>, <maz@kernel.org>,
        <arnd@arndb.de>, <yury.norov@gmail.com>, <brauner@kernel.org>,
        <mcgrof@kernel.org>, <maninder1.s@samsung.com>,
        <michael.christie@oracle.com>, <samitolvanen@google.com>,
        <linux-arm-kernel@lists.infradead.org>, <qiruipeng@lixiang.com>
References: <20231221130930.32634-1-ruipengqi7@gmail.com>
 <e9aa311f-6f13-410e-bb35-20320275668c@linaro.org>
 <CADHLONGLZaZT4Ot56AnxOf=ROrTWvge5=NUx5uqKqJhpJibfOQ@mail.gmail.com>
 <6fe05804-da74-45cd-a6f1-df4644671d99@linaro.org>
 <CADHLONE2YnBJGJUp2-vn_XEpc7+quTMWF7y1zpV0ygeL2VpQxA@mail.gmail.com>
 <CADHLONHHZAeubePPfZbG1N0Nv3ZJM5OWaJWqchBUpiN5Q27UdQ@mail.gmail.com>
Content-Language: en-US
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <CADHLONHHZAeubePPfZbG1N0Nv3ZJM5OWaJWqchBUpiN5Q27UdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uw-DguUr1t_QwRl5eDO3byLAwgnp72FB
X-Proofpoint-ORIG-GUID: uw-DguUr1t_QwRl5eDO3byLAwgnp72FB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1011 mlxscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=854 suspectscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080062



On 12/23/2023 9:00 PM, ruipeng qi wrote:
> On Sat, Dec 23, 2023 at 11:13 PM ruipeng qi <ruipengqi7@gmail.com> wrote:
> 
>>> I don't see a problem why minidump cannot do it.
>> Qcom minidump allows one kernel client to register its region to dump, and then
>> driver will create and maintain one elf head for it.
>> But osdump will dump thousands of non-continuous regions. If you register one
>> by one, and add an elf head for each, it will cause heavy overhead. So it store
>> data in binary, and reassemble a standard elf format file offline for debug.
>>
> Osdump will only dump useful data, which may have been allocated before but
> freed now. In a word, useful data are changing all the time. I think this is not
> suitable for Qcom minidump's framework。


Hey @ruipeng,

I like the idea, However, as i already said here

https://lore.kernel.org/lkml/520e377d-e990-c185-4a20-07806873e506@quicinc.com/

This looks more close to pstore ramoops based on Ram backend, as your 
entire thing is based on RAM content to be preserved across boot and
that way it aligns to pstore ramoops concept.

Also most of the stuff like compression is already available in pstore.
So, let me know if you think that way, will be happy to collaborate and 
test this.

-Mukesh

> 
> Best Regards
> Ruipeng
> 

