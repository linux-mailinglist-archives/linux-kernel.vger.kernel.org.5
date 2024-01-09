Return-Path: <linux-kernel+bounces-20587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A45C68281EA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A141F274B4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90493714C;
	Tue,  9 Jan 2024 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BJfda8C1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E33D29423;
	Tue,  9 Jan 2024 08:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4098Aatk030120;
	Tue, 9 Jan 2024 08:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=XCLdJ0e/Bd3E8o6EOrKg5ZcKtjQ7aRyzG5ZKf+9ziCU=; b=BJ
	fda8C1lqJRjmxN28FUYHnf1uc6atqJmo7U2bJE8k8mOsCaqKthZxrKuqUHtJteiR
	A7wY0ilF9P3pORVsE3IY0mk8iSBgWnckL6lxGGZ+s/fsisZSSmmK2Vf9jyWKhLND
	0P34E9D6zHlYIb9iGlORDujP3upOkrUeCGJ8N0yiSQB/eyPmjZuZ0YnLiPm8pqDe
	8RjwSjzWNAsaqhriN9ukzS4HUxx3+OvPhDb+PfzCUQFQvdUkpJ9ETTcy2PYdEUmq
	Ftf3iHYcOiCUx7AR+30n2xN+0a4nKA1pXPzV1/kojucPesoD0mE6gP0R3x5sSQOk
	X6sOlF/KGep5at/ejnCQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgwsjrhp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 08:29:10 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4098T8PB002926
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 08:29:08 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 9 Jan
 2024 00:27:12 -0800
Message-ID: <209abe99-734d-f571-d930-4493437983bf@quicinc.com>
Date: Tue, 9 Jan 2024 13:57:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: RESEND: Re: [Patch v6 03/12] docs: qcom: Add qualcomm minidump
 guide
Content-Language: en-US
To: Ruipeng Qi <ruipengqi7@gmail.com>
CC: <agross@kernel.org>, <alim.akhtar@samsung.com>, <andersson@kernel.org>,
        <bmasney@redhat.com>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <gpiccoli@igalia.com>, <keescook@chromium.org>, <kernel@quicinc.com>,
        <kgene@kernel.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>, <mathieu.poirier@linaro.org>,
        <matthias.bgg@gmail.com>, <nm@ti.com>, <robh+dt@kernel.org>,
        <tony.luck@intel.com>, <vigneshr@ti.com>, <qiruipeng@lixiang.com>
References: <1700864395-1479-4-git-send-email-quic_mojha@quicinc.com>
 <20231225135542.1789-1-ruipengqi7@gmail.com>
 <520e377d-e990-c185-4a20-07806873e506@quicinc.com>
 <CADHLONEn4oyRFrNWEbt2mxMczyc8FrDLMzaZ7fsijzm9Y8VTBA@mail.gmail.com>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <CADHLONEn4oyRFrNWEbt2mxMczyc8FrDLMzaZ7fsijzm9Y8VTBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mmGVKHzYwm-iQH9vrziQjsvmW2EMUnvr
X-Proofpoint-ORIG-GUID: mmGVKHzYwm-iQH9vrziQjsvmW2EMUnvr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090065



On 1/8/2024 9:04 PM, Ruipeng Qi wrote:
> On Wed, Jan 3, 2024 at 11:27 PM Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>>
>>
>> One more thing, kernel part of minidump, we are calling it APSS Minidump
>> has limitation of no of entries so it will be difficult to dump
>> non-continuous regions after a certain number of registration ~200. However,
>> we do have a solution in downstream kernel for it like to create a big
>> CMA buffer and register this buffer with Minidump so that whatever gets
>> dumped in that buffer gets captured during crash and fill up this buffer
>> and create elf during panic. I think, similar thing you are also doing
>> with your OS-minidump.
>>
>> I have just glanced into your implementation of OS-minidump, it
>> more of relying on basic concept of RAM content preserved
>> across boot and later reading it through procfs but this basic
>> stuff is common to pstore(ram) as well and pstore has file system
>> support why don't you make your driver as one of pstore record and that
>> way Qualcomm minidump also gets benefited where entire OS-minidump
>> record gets registered with Qualcomm minidump and we get this on panic
>> and you get this via pstorefs.
>>
> Thanks Mukesh！It is a good suggestion to move OS-minidump forward!
> By the way, I have some questions here for which I need your assistance.
> 
> Firstly,I can reimplement OS-minidump as one of the pstore records to
> dump data. The resulting dump file would contain thousands of
> non-contiguous memory regions, each with only the virtual address and
> size recorded. As far as I know, Qualcomm's minidump can handle
> several memory regions, each with a physical address and size.
> This seems to be a difference, and I'm curious as to how you deal with
> data dumped by OS-minidump. I would really appreciate it if you could
> provide more details on your approach.

What my thought was to think your OS-minidump to be one of pstore record 
similar to existing records like console, ftrace, pmsg, dmesg etc.,
If you follow this series patch 11/12 and 12/12 is trying to get the
pstore(ram) record information and registering with minidump and here
the physical address are of the ramoops record addresses.

So, once you are capturing everything inside in a record, all minidump
has to do is get your Os-minidump record physical address and size
and register with minidump.
> 
> Secondly, what tools do you use to analyze the dump data, and does it
> support crash tool?

Currently, we are trying to capture only pstore ramoops region in text
format and not been using any tool.

Since, Qualcomm minidump is controlled from boot firmware and it can
not be used on non-Qualcomm SoCs so here minidump driver and its usecase
is limited to capture only pstore (ram)records for targets where RAM
content is not guaranteed to be preserved across boots.

So, you can think minidump as one of ramoops backend which will be
dumping all the ramoops regions/records/zones.

+---------+     +---------+   +--------+      +---------+
  | console |     | pmsg    |   | ftrace |     | dmesg   | ...Os-minidump
  +---------+     +---------+   +--------+     +---------+
        |             |             |              |
        |             |             |              |
        +------------------------------------------+
                           |
                          \ /
                   +----------------+
             (1)   |pstore frontends|
                   +----------------+
                           |
                          \ /
                  +------------------- +
             (2)  | pstore backend(ram)|
                  +--------------------+
                           |
                          \ /

                    +---------------+
             (3)    | qcom_minidump |
                    +---------------+


> 
> Lastly, is Qualcomm minidump compatible with non-Qualcomm SoCs,
> and if so, how can one use it?

I already replied it above.

-Mukesh

> 
> Best Regards
> Ruipeng Qi

