Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCA179A538
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 10:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbjIKIAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 04:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjIKIAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:00:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61A3BB;
        Mon, 11 Sep 2023 00:59:57 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38B6JXTn018071;
        Mon, 11 Sep 2023 07:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=j4P0iwKezHc+FaJKHNn7RJ5R8SdPoiUvrT3JIUc3ZIA=;
 b=l8a9IpdojD2+5RiZ1IcIYDZhFCQ3OpZplNSmZimlmnObkbMIf7fjFRjXTZMZMphZ2gEN
 1Blku+OSFS0FM3mwxZPK3X5GbsCtSSAnSS8BJVeDftGGyDYxQrx4fNKlnTEc0f1S74NI
 KepQv6v43udG3wD+5dvcQd8n97w26GncMhSg4h4y1KLDhiSNhhu+EjVbQHX59errn2tz
 xaiYEm2Ddue0ld6/242FjTOBfYyela6k4PRh/s3Y7KoQekILXiTtO3XX/zdT/QPe0b8L
 3XByQnVMCyQQfdCVwA52ZsCRc/7KpId7sISQZ4suX1LDdKek2vjAK3Pf8YsjMftQ93WL jg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t0hfqk0xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 07:59:19 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38B7xI2W027340
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 07:59:18 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 11 Sep
 2023 00:59:07 -0700
Message-ID: <0f7a24a6-bcc5-54d5-0b6a-884f8a0fe8d7@quicinc.com>
Date:   Mon, 11 Sep 2023 13:28:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 11/17] qcom_minidump: Register ramoops region with
 minidump
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <matthias.bgg@gmail.com>,
        <kgene@kernel.org>, <alim.akhtar@samsung.com>,
        <bmasney@redhat.com>, <quic_tsoni@quicinc.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@quicinc.com>
References: <1694290578-17733-1-git-send-email-quic_mojha@quicinc.com>
 <1694290578-17733-12-git-send-email-quic_mojha@quicinc.com>
 <3119f3f6-92a5-4db1-85cf-bd16e31ae5a0@quicinc.com>
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <3119f3f6-92a5-4db1-85cf-bd16e31ae5a0@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vr9xvYvA760iWL4_izSZwApqXxVLD0G_
X-Proofpoint-GUID: vr9xvYvA760iWL4_izSZwApqXxVLD0G_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_05,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0 mlxlogscore=822 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110072
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/2023 11:31 AM, Pavan Kondeti wrote:
> On Sun, Sep 10, 2023 at 01:46:12AM +0530, Mukesh Ojha wrote:
>> Register all the pstore frontend with minidump, so that they can
>> be dumped as default Linux minidump region to be collected on
>> SoC where minidump is enabled.
>>
>> Helper functions is written in separate file and built along with
>> the minidump driver, since it is client of minidump and also call
>> it at appropriate place from minidump probe so that they always
>> get registered.
>>
>> While at it also rename the out minidump module object name during
>> build as qcom_apss_minidump which basically depicts as Qualcomm
>> Application processor subsystem minidump.
>>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>>   drivers/soc/qcom/Kconfig                 |  1 +
>>   drivers/soc/qcom/Makefile                |  3 +-
>>   drivers/soc/qcom/qcom_minidump.c         |  4 ++
>>   drivers/soc/qcom/qcom_ramoops_minidump.c | 88 ++++++++++++++++++++++++++++++++
>>   drivers/soc/qcom/qcom_ramoops_minidump.h | 10 ++++
>>   5 files changed, 105 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/soc/qcom/qcom_ramoops_minidump.c
>>   create mode 100644 drivers/soc/qcom/qcom_ramoops_minidump.h
>>
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index 4b36d46807bc..b3977f1687d8 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -305,6 +305,7 @@ config QCOM_MINIDUMP
>>   	tristate "QCOM APSS Minidump driver"
>>   	depends on ARCH_QCOM || COMPILE_TEST
>>   	depends on QCOM_SMEM
>> +	depends on PSTORE
> 
> Can't we make QC minidump available without PSTORE? PSTORE is another
> cllient for minidump, so other clients can still use minidump right?
> Where is this hard dependency coming from?

Thanks for asking this question, this was intentionally put here to
continue the discussion forward about minidump existence in kernel tree
and how community want to see it in kernel tree.

Actually, there is no hard dependency of minidump on pstore and  as i 
have said in cover-letter about minidump is going to collect what 
ramoops is offering now or going to offer in future as a default
regions.

So, main minidump driver does not depends on pstore since, i have 
integrated even the minidump client with this
qcom_ramoops_minidump_{register|unregister}()

I may guard this entire qcom_ramoops_minidump_{register|unregister}()
function under CONFIG_PSTORE_RAM, if everyone agree ?

-Mukesh
> 
> Thanks,
> Pavan
