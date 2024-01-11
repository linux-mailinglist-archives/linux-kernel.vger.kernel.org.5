Return-Path: <linux-kernel+bounces-23080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F76082A76D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784D41F22795
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CDB23CD;
	Thu, 11 Jan 2024 06:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LVobSU4f"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE54E2105;
	Thu, 11 Jan 2024 06:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40B5e1kf022118;
	Thu, 11 Jan 2024 06:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/6QUE+JTKVJzsM5DjhsgngB9QhhyX2fGpNdXNdgcBSc=; b=LV
	obSU4fQxCfixukwig4w/EowuyZfFWyhvGAbfNEOEY0mfcbu2+7Xesp98l4fdCWaq
	Mcj3HDPadDMISsFnlEZZvd4d5tRsfdA5ciZfwpfa+DtKcDBUYMBWxHHuN5u5M95m
	zdnpCNV5GvKPDJATdBtyzIBG1MLrKP4IJ7SoCLsO6gU995zpnpm/uJilWdxOzKXa
	PhfUyMUtFrupTeBZ5WPQx0Zcip51hN3OdBrw6Nd55QDP5VrRZzpQGoUxmY/TUDyZ
	Zr8C6rV48lF/y5KSO41QVPtVGqEo51hIqEPp/s9camoOlqpqJU9dg39DNI4jCt/l
	/D6WeLqNmpcSGhizyRsA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhuak23g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 06:08:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40B68PaD016302
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 06:08:25 GMT
Received: from [10.239.133.49] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 10 Jan
 2024 22:08:22 -0800
Message-ID: <1ae3c5a4-97d9-415e-8dd5-520e00c5e94f@quicinc.com>
Date: Thu, 11 Jan 2024 14:08:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: Add coresight name support
Content-Language: en-US
To: Rob Herring <robh@kernel.org>, Mike Leach <mike.leach@linaro.org>
CC: James Clark <james.clark@arm.com>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang
	<quic_taozha@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>
References: <20231228093321.5522-1-quic_jinlmao@quicinc.com>
 <12ce6e5d-6e4d-fb99-eb82-dece97423bfb@arm.com>
 <CAJ9a7Vgi=ELOhXNF97KrBtV5ef8khwWqzWKevrYW2RtBBtsppw@mail.gmail.com>
 <CAL_JsqKYuqKxokDzs3xVWqYZoFfyMwMrLd17DpfCO_x7CXvRZw@mail.gmail.com>
From: Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <CAL_JsqKYuqKxokDzs3xVWqYZoFfyMwMrLd17DpfCO_x7CXvRZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aDXdIDVa0rJXl0VcJ7YVHUHWWCD7Xl8w
X-Proofpoint-ORIG-GUID: aDXdIDVa0rJXl0VcJ7YVHUHWWCD7Xl8w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=676
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110047



On 1/3/2024 11:32 PM, Rob Herring wrote:
> On Tue, Jan 2, 2024 at 5:05 AM Mike Leach <mike.leach@linaro.org> wrote:
>>
>> As James mentions this is clearly a V2 of a previous patch - please
>> mark as such in future.
>>
>> Adding to what James has already said:-
>>
>> 1) Mapping between the canonical names used in the drivers and the
>> information as to the precise device is as easy as running 'ls' on
>> /sys/bus/coresight/devices:-
>>
>> root@linaro-developer:/home/linaro/cs-mods# ls -al /sys/bus/coresight/devices/
>> total 0
>> drwxr-xr-x 2 root root 0 Jan  2 11:27 .
>> drwxr-xr-x 4 root root 0 Jan  2 11:27 ..
>> lrwxrwxrwx 1 root root 0 Jan  2 11:27 cti_cpu0 ->
>> ../../../devices/platform/soc@0/858000.cti/cti_cpu0
>> lrwxrwxrwx 1 root root 0 Jan  2 11:27 cti_cpu1 ->
>> ../../../devices/platform/soc@0/859000.cti/cti_cpu1
>> lrwxrwxrwx 1 root root 0 Jan  2 11:27 cti_cpu2 ->
>> ../../../devices/platform/soc@0/85a000.cti/cti_cpu2
>> lrwxrwxrwx 1 root root 0 Jan  2 11:27 cti_cpu3 ->
>> ../../../devices/platform/soc@0/85b000.cti/cti_cpu3
>> lrwxrwxrwx 1 root root 0 Jan  2 11:27 cti_sys0 ->
>> ../../../devices/platform/soc@0/810000.cti/cti_sys0
>> lrwxrwxrwx 1 root root 0 Jan  2 11:27 cti_sys1 ->
>> ../../../devices/platform/soc@0/811000.cti/cti_sys1
>> lrwxrwxrwx 1 root root 0 Jan  2 11:27 etm0 ->
>> ../../../devices/platform/soc@0/85c000.etm/etm0
>> lrwxrwxrwx 1 root root 0 Jan  2 11:27 etm1 ->
>> ../../../devices/platform/soc@0/85d000.etm/etm1
>> lrwxrwxrwx 1 root root 0 Jan  2 11:27 etm2 ->
>> ../../../devices/platform/soc@0/85e000.etm/etm2
>> lrwxrwxrwx 1 root root 0 Jan  2 11:27 etm3 ->
>> ../../../devices/platform/soc@0/85f000.etm/etm3
>> lrwxrwxrwx 1 root root 0 Jan  2 11:42 funnel0 ->
>> ../../../devices/platform/soc@0/821000.funnel/funnel0
>> lrwxrwxrwx 1 root root 0 Jan  2 11:42 funnel1 ->
>> ../../../devices/platform/soc@0/841000.funnel/funnel1
>> lrwxrwxrwx 1 root root 0 Jan  2 11:42 replicator0 ->
>> ../../../devices/platform/soc@0/824000.replicator/replicator0
>> lrwxrwxrwx 1 root root 0 Jan  2 11:42 tmc_etf0 ->
>> ../../../devices/platform/soc@0/825000.etf/tmc_etf0
>> lrwxrwxrwx 1 root root 0 Jan  2 11:42 tmc_etr0 ->
>> ../../../devices/platform/soc@0/826000.etr/tmc_etr0
>>
>>
>> 2) The patch set must contain the usage and specification in the .yaml
>>   file(s) of the property used.
> 
> For the record, I don't like "coresight-name". I don't have another
> suggestion because "easy" is not sufficient reasoning for why this is
> needed.

For example, if we want to configure the trigger and HW events for 
modem, we can't know which cti or TPDM is for modem from current names.

lrwxrwxrwx    1 root     0                0 Jan  1 00:01 cti_sys0 -> 
./../../devices/platform/soc@0/138f0000.cti/cti_sys0
lrwxrwxrwx    1 root     0                0 Jan  1 00:01 cti_sys1 -> 
./../../devices/platform/soc@0/13900000.cti/cti_sys1
lrwxrwxrwx    1 root     0                0 Jan  1 00:01 tpdm0 -> 
./../../devices/platform/soc@0/10b0d000.tpdm/tpdm0
lrwxrwxrwx    1 root     0                0 Jan  1 00:01 tpdm1 -> 
./../../devices/platform/soc@0/10c28000.tpdm/tpdm1
lrwxrwxrwx    1 root     0                0 Jan  1 00:01 tpdm2 -> 
./../../devices/platform/soc@0/10c29000.tpdm/tpdm2

Thanks
Jinlong Mao
> 
>> However, there was a standard property called 'name' which is
>> deprecated - see
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html
>> section 2.3.11. I do not believe that adding another 'name' property
>> would be accepted by the DT maintainers.
> 
> "name" is just the node name for anything in the last 15 years. They
> used to be separate, but would still mostly be the same. The only case
> I found with them different was old PowerPC Macs.
> 
>> 3) the 'device_node' structure has a 'name' field that contains the
>> node name in the DT approved "node-name@unit-address" format.
> 
> Actually, it is without the unit-address. full_name is with the unit-address.
> 
>> This
>> contains whatever node names you used in the dt.  Why not use this if
>> a change has to be made and find some conditional to activate it.
> 
> Don't go accessing "name" or "full_name" directly. I intend to get rid
> of "name" and generate it from full_name. So use the accessors and
> printk specifiers if you need node names.
> 
> Rob

