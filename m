Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A39A7D3503
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjJWLop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbjJWLoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:44:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1950BF9;
        Mon, 23 Oct 2023 04:44:29 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NAKPLu004391;
        Mon, 23 Oct 2023 11:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DydnY/1bND/vHTw/7GcsW79QLp0pXT7WEV16gaMzq9Q=;
 b=DCTAd0/lQ0PQ7GQYT5h3vqepKxpvl98SzmLzlwgwF8VBG6YOZgileZiO8MyYNXYxbesx
 u8YjSeif0bDS4YC2Hf2X2DuBcTBOe8uKTndkIOUy8J58QYD5B8ryDJ7mmHW+j3WFqShL
 hcvS9JAwWeYj9xdtRjqBCiYHlSZvKBtMn8iQuvE3AAxF9+O0y5Ql5C7hyWl00DjATAW4
 kTU2C2nXgMu6vBUqKbKFX1tS/Cd8vNmYyBBXjDMhQfZuCGGIpxL8JNNit79n1YG1TGWc
 2B+hR5gp7wbGfsQqLBBj56zS0qpVhXbRHSep+6ViOgme869vNDocATqODQfJKegjJqS7 mQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv6v8vbyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 11:44:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39NBi2rq025817
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 11:44:02 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 23 Oct
 2023 04:43:57 -0700
Message-ID: <b455d4f7-0347-ac07-6d41-32b3f06c4f0a@quicinc.com>
Date:   Mon, 23 Oct 2023 19:43:54 +0800
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
From:   Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <5bac8188-7d27-4efe-9493-dec4393fbeb0@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2aaXe-070YYRnxxEayI_v7ceoQqqnn4S
X-Proofpoint-ORIG-GUID: 2aaXe-070YYRnxxEayI_v7ceoQqqnn4S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310230102
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/23 17:31, Krzysztof Kozlowski wrote:
> On 23/10/2023 11:20, Zhenhua Huang wrote:
>> Qualcomm memory dump driver initializes system memory dump table.
>> Firmware dumps system cache, internal memory, peripheral registers
>> to DDR as per this table after system crashes and warm resets. The
>> driver reserves memory, populates ids and sizes for firmware dumping
>> according to the configuration.
>>
>> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
>> ---
> 
> ...
> 
>> +
>> +/* populate allocated region */
>> +static int __init mem_dump_populate_mem(struct device *dev,
>> +					struct page *start_page,
>> +					size_t total_size)
>> +{
>> +	struct qcom_memory_dump *memdump = dev_get_drvdata(dev);
>> +	struct qcom_dump_entry dump_entry;
>> +	struct qcom_dump_data *dump_data;
>> +	struct xbc_node *linked_list;
>> +	phys_addr_t phys_end_addr;
>> +	phys_addr_t phys_addr;
>> +	const char *size_p;
>> +	void *dump_vaddr;
>> +	const char *id_p;
>> +	int ret = 0;
>> +	int size;
>> +	int id;
>> +
>> +	phys_addr = page_to_phys(start_page);
>> +	phys_end_addr = phys_addr + total_size;
>> +	dump_vaddr = page_to_virt(start_page);
>> +
>> +	ret = mem_dump_register_data_table(dev, dump_vaddr, phys_addr);
>> +	if (ret) {
>> +		dev_err_probe(dev, ret, "Mem Dump table set up is failed\n");
>> +		return ret;
> 
> That's not the syntax. Syntax is return dev_err_probe
> 

Got it, Thanks.

>> +	}
>> +
>> +	ret = qcom_init_memdump_imem_area(dev, total_size);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Apply two tables: QCOM_DUMP_TYPE_TABLE and QCOM_DUMP_TYPE_DATA */
>> +	mem_dump_apply_offset(&dump_vaddr, &phys_addr,
>> +			      sizeof(struct qcom_dump_table) * 2);
>> +
>> +	/* Both "id" and "size" must be present */
>> +	xbc_node_for_each_subkey(memdump->mem_dump_node, linked_list) {
>> +		const char *name = xbc_node_get_data(linked_list);
>> +
>> +		if (!name)
>> +			continue;
>> +
>> +		id_p = xbc_node_find_value(linked_list, "id", NULL);
>> +		size_p = xbc_node_find_value(linked_list, "size", NULL);
>> +
>> +		if (id_p && size_p) {
>> +			ret = kstrtoint(id_p, 0, &id);
>> +			if (ret)
>> +				continue;
>> +
>> +			ret = kstrtoint(size_p, 0, &size);
>> +
>> +			if (ret)
>> +				continue;
>> +
>> +		/*
>> +		 * Physical layout: starting from two qcom_dump_data.
>> +		 * Following are respective dump meta data and reserved regions.
>> +		 * Qcom_dump_data is populated by the driver, fw parse it
>> +		 * and dump respective info into dump mem.
>> +		 * Illustrate the layout:
>> +		 *
>> +		 *   +------------------------+------------------------+
>> +		 *   | qcom_dump_table(TABLE) | qcom_dump_table(DATA)  |
>> +		 *   +------------------------+------------------------+
>> +		 *   +-------------+----------+-------------+----------+
>> +		 *   |qcom_dump_data| dump mem|qcom_dump_data| dump mem |
>> +		 *   +-------------+----------+-------------+----------+
>> +		 *   +-------------+----------+-------------+----------+
>> +		 *   |qcom_dump_data| dump mem|qcom_dump_data| dump mem |
>> +		 *   +-------------+----------+-------------+----------+
>> +		 *   ...
>> +		 */
> 
> You have wrong indentation here.

Thanks for catching.

> 
>> +			dump_data = dump_vaddr;
>> +			dump_data->addr = phys_addr + QCOM_DUMP_DATA_SIZE;
>> +			dump_data->len = size;
>> +			dump_entry.id = id;
>> +			strscpy(dump_data->name, name,
>> +				sizeof(dump_data->name));
>> +			dump_entry.addr = phys_addr;
>> +			ret = mem_dump_data_register(dev, QCOM_DUMP_TABLE_LINUX,
>> +						     &dump_entry);
>> +			if (ret) {
>> +				dev_err_probe(dev, ret, "Dump data setup failed, id = %d\n",
>> +					      id);
> 
> Syntax is return dev_err_probe
> 
>> +				return ret;
>> +			}
>> +
>> +			mem_dump_apply_offset(&dump_vaddr, &phys_addr,
>> +					      size + QCOM_DUMP_DATA_SIZE);
>> +			if (phys_addr > phys_end_addr) {
>> +				dev_err_probe(dev, -ENOMEM, "Exceeding allocated region\n");
> 
> ENOMEM? Does not look right then.

ENOMEM means the memory allocated not enough? any suggestion? Thanks.

> 
>> +				return -ENOMEM;
>> +			}
>> +		} else {
>> +			continue;
>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int __init mem_dump_probe(struct platform_device *pdev)
>> +{
>> +	struct qcom_memory_dump *memdump;
>> +	struct device *dev = &pdev->dev;
>> +	struct page *page;
>> +	size_t total_size;
>> +	int ret = 0;
>> +
>> +	memdump = devm_kzalloc(dev, sizeof(struct qcom_memory_dump),
>> +			       GFP_KERNEL);
>> +	if (!memdump)
>> +		return -ENOMEM;
>> +
>> +	dev_set_drvdata(dev, memdump);
>> +
>> +	/* check and initiate CMA region */
>> +	ret = mem_dump_reserve_mem(dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* allocate and populate */
>> +	page = mem_dump_alloc_mem(dev, &total_size);
>> +	if (IS_ERR(page)) {
>> +		ret = PTR_ERR(page);
>> +		dev_err_probe(dev, ret, "mem dump alloc failed\n");
> 
> No, the syntax is:
> ret = dev_err_probe
> 
> But why do you print messgaes for memory allocations?

Do you think it's useless because mm codes should print error as well if 
failure ?

> 
>> +		goto release;
>> +	}
>> +
>> +	ret = mem_dump_populate_mem(dev, page, total_size);
>> +	if (!ret)
>> +		dev_info(dev, "Mem dump region populated successfully\n");
> 
> Drop simple probe success messages. Not needed.

OK

> 
>> +	else
>> +		goto free;
>> +
>> +	return 0;
>> +
>> +free:
>> +	cma_release(dev_get_cma_area(dev), page, (total_size / PAGE_SIZE));
>> +
>> +release:
>> +	of_reserved_mem_device_release(dev);
> 
> Where is cleanup on unbind?
> 

Will add, Thanks for pointing out.

>> +	return ret;
>> +}
>> +
>> +static const struct of_device_id mem_dump_match_table[] = {
>> +	{.compatible = "qcom,mem-dump",},
>> +	{}
>> +};
>> +
> Best regards,
> Krzysztof
> 

Thanks,
Zhenhua
