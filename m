Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A0279EC88
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbjIMPV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjIMPV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:21:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671A0C1;
        Wed, 13 Sep 2023 08:21:53 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DEv7D2000527;
        Wed, 13 Sep 2023 15:21:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Hhvs/8xK+JuOLpQApokzSBRuLPc6gpd16QdQyq90tXo=;
 b=inpRhqRQ9iyqoDLb+SCeLj3L80j0aaxA65DOSL7deucsFrMyWVH6lBgERO3aaUWgcYQT
 2112QHLgeuGawvyqX+Js7tdyjT7BWofiU0vCQdw/Vnk/pmwQx0p7scH6qqpdv1m60g7Q
 K1ddfsd7ApfcSXfvWhMLMEgZMEywsAXFDpVQ1E7ldVmrMdQz+F5OqYF+agVOUT+yjYrR
 XTytpQcjhOwrUEfYAf0PaFgk/CDf2twRg7CfIG/lmmHXs1vIIlRvf9Njbdw9e5l/7FvR
 fp4z0UxPfifYXOCrFhroXwvlKnBQVUhqltoHKkqlw4+lruXoRAXvlIZvhfjRwi5o1ikL Rg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2y7qa59j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 15:21:03 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38DFL2bc031246
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 15:21:02 GMT
Received: from [10.216.62.56] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 13 Sep
 2023 08:20:49 -0700
Message-ID: <56c0328c-9744-4c69-b0a3-c36cc497fe31@quicinc.com>
Date:   Wed, 13 Sep 2023 20:50:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [REBASE PATCH v5 01/17] docs: qcom: Add qualcomm minidump guide
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, <corbet@lwn.net>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <matthias.bgg@gmail.com>,
        <kgene@kernel.org>, <alim.akhtar@samsung.com>,
        <bmasney@redhat.com>, <quic_tsoni@quicinc.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@quicinc.com>
References: <1694429639-21484-1-git-send-email-quic_mojha@quicinc.com>
 <1694429639-21484-2-git-send-email-quic_mojha@quicinc.com>
 <ZQF_9-nX47QUCycO@debian.me>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <ZQF_9-nX47QUCycO@debian.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2gAwxDuhuJ3-P7vtmlbV-ftKdk4OelF4
X-Proofpoint-ORIG-GUID: 2gAwxDuhuJ3-P7vtmlbV-ftKdk4OelF4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_09,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 spamscore=0 priorityscore=1501
 mlxlogscore=977 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130126
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/2023 2:55 PM, Bagas Sanjaya wrote:
> On Mon, Sep 11, 2023 at 04:23:43PM +0530, Mukesh Ojha wrote:
>> +Qualcomm APSS Minidump kernel driver concept
>> +--------------------------------------------
>> +::
>> +
>> <snipped>...
>> +Dump collection
>> +---------------
>> +
>> +	+-----------+
>> +	|           |
>> +	|           |         +------+
>> +	|           |         |      |
>> +	|           |         +--+---+ Product(Qualcomm SoC)
>> +	+-----------+             |
>> +	|+++++++++++|<------------+
>> +	|+++++++++++|    usb cable
>> +	+-----------+
>> +            x86_64 PC
>> +
> 
> Sphinx reports htmldocs warnings:
> 
> /home/bagas/repo/linux-kernel/Documentation/admin-guide/qcom_minidump.rst:100: WARNING: Literal block expected; none found.
> /home/bagas/repo/linux-kernel/Documentation/admin-guide/qcom_minidump.rst:243: WARNING: Unexpected indentation.
> /home/bagas/repo/linux-kernel/Documentation/admin-guide/qcom_minidump.rst:234: WARNING: Malformed table.
> 
> +-----------+
> |           |
> |           |         +------+
> |           |         |      |
> |           |         +--+---+ Product(Qualcomm SoC)
> +-----------+             |
> |+++++++++++|<------------+
> |+++++++++++|    usb cable
> +-----------+
> /home/bagas/repo/linux-kernel/Documentation/admin-guide/qcom_minidump.rst:243: WARNING: Blank line required after table.
> 
> I have to apply the fixup:
> 
> ---- >8 ----
> diff --git a/Documentation/admin-guide/qcom_minidump.rst b/Documentation/admin-guide/qcom_minidump.rst
> index 20202da8ca40b9..5709a3853ae7ea 100644
> --- a/Documentation/admin-guide/qcom_minidump.rst
> +++ b/Documentation/admin-guide/qcom_minidump.rst
> @@ -95,7 +95,6 @@ could be anywhere scattered in the DDR.
>   
>   Qualcomm APSS Minidump kernel driver concept
>   --------------------------------------------
> -::
>   
>   Qualcomm APSS minidump kernel driver adds the capability to add Linux
>   region to be dumped as part of RAM dump collection. At the moment,
> @@ -231,6 +230,8 @@ respective dump as per set download mode.
>   Dump collection
>   ---------------
>   
> +::
> +
>   	+-----------+
>   	|           |
>   	|           |         +------+
> 

Thanks, will take care.


> Thanks.
> 
