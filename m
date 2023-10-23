Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A577D364E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjJWMUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjJWMUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:20:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B80FF;
        Mon, 23 Oct 2023 05:20:19 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NCKHwJ025522;
        Mon, 23 Oct 2023 12:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fPgWYWEgNTIr7MA08s0K4dAYRadYOZVIYvieHNWOzyU=;
 b=IbOcEkoQo+Wd7Q35/UVB5BHrrNK9NzWQ01Q7a6QJW3WZG2NfmaGo4udU7sUegDbVXLRD
 hvfSsMGzRpXKXYWT5QhJTOkKbhlY8/YwbbMFhn5x3B5fh0hw/UrxjmtvNTe3ybao61Re
 xi6GMQuqPlsol/iipx8e1K0M4kLNzGewC5bd8X1FsIoc22D0wiy7vI1mZ8MET/6GVF7D
 g0REs0ZqXRi4CBHv6WOIlO19T6iqI8deYIXV5zTayooJrWzfmBVx/VmwaTNso2stY8FX
 7GnRn3AKYT+5Je/NglVt2x+hWAgS/hnS+L6Xv/bU8rDU9tIEm0cXBnk71yrl9vRRPW9S dg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv7u3v9yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 12:20:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39NCJLPP020266
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 12:19:21 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 23 Oct
 2023 05:19:16 -0700
Message-ID: <1a5b2381-8987-2f92-d018-29fdbc23b826@quicinc.com>
Date:   Mon, 23 Oct 2023 20:19:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 3/5] soc: qcom: memory_dump: Add memory dump driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_tingweiz@quicinc.com>
References: <1698052857-6918-1-git-send-email-quic_zhenhuah@quicinc.com>
 <1698052857-6918-4-git-send-email-quic_zhenhuah@quicinc.com>
 <5bac8188-7d27-4efe-9493-dec4393fbeb0@linaro.org>
 <b455d4f7-0347-ac07-6d41-32b3f06c4f0a@quicinc.com>
 <454c4267-6bb7-456e-8dc1-cba83ffd1641@linaro.org>
From:   Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <454c4267-6bb7-456e-8dc1-cba83ffd1641@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XZ8igviXklMMmkRJPc5vafmYvsyioTI9
X-Proofpoint-ORIG-GUID: XZ8igviXklMMmkRJPc5vafmYvsyioTI9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=907
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230108
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/23 19:46, Krzysztof Kozlowski wrote:
> On 23/10/2023 13:43, Zhenhua Huang wrote:
>>>> +
>>>> +			mem_dump_apply_offset(&dump_vaddr, &phys_addr,
>>>> +					      size + QCOM_DUMP_DATA_SIZE);
>>>> +			if (phys_addr > phys_end_addr) {
>>>> +				dev_err_probe(dev, -ENOMEM, "Exceeding allocated region\n");
>>>
>>> ENOMEM? Does not look right then.
>>
>> ENOMEM means the memory allocated not enough? any suggestion? Thanks.
> 
> The error code is okay, but we rarely need to print error messages for
> memory allocation failures. Core prints it already.

It's not same as below case. Allocation is successful here, while the 
driver used more than allocated size.

> 
>>
>>>
>>>> +				return -ENOMEM;
>>>> +			}
>>>> +		} else {
>>>> +			continue;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int __init mem_dump_probe(struct platform_device *pdev)
>>>> +{
>>>> +	struct qcom_memory_dump *memdump;
>>>> +	struct device *dev = &pdev->dev;
>>>> +	struct page *page;
>>>> +	size_t total_size;
>>>> +	int ret = 0;
>>>> +
>>>> +	memdump = devm_kzalloc(dev, sizeof(struct qcom_memory_dump),
>>>> +			       GFP_KERNEL);
>>>> +	if (!memdump)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	dev_set_drvdata(dev, memdump);
>>>> +
>>>> +	/* check and initiate CMA region */
>>>> +	ret = mem_dump_reserve_mem(dev);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	/* allocate and populate */
>>>> +	page = mem_dump_alloc_mem(dev, &total_size);
>>>> +	if (IS_ERR(page)) {
>>>> +		ret = PTR_ERR(page);
>>>> +		dev_err_probe(dev, ret, "mem dump alloc failed\n");
>>>
>>> No, the syntax is:
>>> ret = dev_err_probe
>>>
>>> But why do you print messgaes for memory allocations?
>>
>> Do you think it's useless because mm codes should print error as well if
>> failure ?
> 
> We fixed this in kernel long, long, long time ago so we have even
> coccicheck scripts to find misuses.
> 

Thanks, yeah.. I know mm codes already have for example warn_alloc() to 
print error messages. Thanks for pointing out.

> 
> 
> Best regards,
> Krzysztof
> 

Thanks,
Zhenhua
