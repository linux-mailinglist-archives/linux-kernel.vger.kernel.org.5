Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BC27E0227
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346315AbjKCLVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKCLVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:21:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B134134;
        Fri,  3 Nov 2023 04:21:47 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3AeZlM026437;
        Fri, 3 Nov 2023 11:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=K/2UxAYCtKuzSZFP+fH2NhbmOwxBW6Zit195L5A9CXA=;
 b=b3zQ3p6aMNNqStH7R/EWZY5GVmtl0uz9Jd66PanlwDGOLQWKbJi7v+Xlj0GjR02MlAnC
 MIyZrxy4DfVVB5ym69IUzaqqJsXQ6as7p6eWToiLO61pwlxV7o7mXnffA7KTV1l63FrV
 M6CIXN9lv+pscollYKQ6vPHHQdSmBoE36Gd9JnZyBjXGhrySFG1XvQqMa5zDc9o5ML2D
 SPOyjQvAUiAp+rcFEo3ud22gRzpJEiOczmeyShg0XVsOj5avMIuqgRtABo7RmqHZd7Hj
 qCi7TRB8H/LQlMR5tYlnf5D/1J1Zg1J1vG/3g/GyiG1Qdm4n2YbWqou+hndg43BBtrt6 sg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u4v8mrenw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 11:21:23 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A3BL3AJ009110
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Nov 2023 11:21:03 GMT
Received: from [10.216.26.1] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 3 Nov
 2023 04:20:57 -0700
Message-ID: <2b9e943a-198e-7999-b898-e7b2498a9ffa@quicinc.com>
Date:   Fri, 3 Nov 2023 16:50:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH 4/5] spi: qpic: Add support for qpic spi nand driver
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <quic_srichara@quicinc.com>,
        <qpic_varada@quicinc.com>
References: <20231031120307.1600689-1-quic_mdalam@quicinc.com>
 <20231031120307.1600689-5-quic_mdalam@quicinc.com>
 <a1270a88-49a9-4bdb-89a9-ce6929f2294d@sirena.org.uk>
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <a1270a88-49a9-4bdb-89a9-ce6929f2294d@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2wlQn1H9NHky1Amy3XFnWxUhp4JxxpWt
X-Proofpoint-ORIG-GUID: 2wlQn1H9NHky1Amy3XFnWxUhp4JxxpWt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_11,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030095
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/2023 7:53 PM, Mark Brown wrote:
> On Tue, Oct 31, 2023 at 05:33:06PM +0530, Md Sadre Alam wrote:
> 
>> +config SPI_QPIC_SNAND
>> +	tristate "QPIC SNAND controller"
>> +	default y
>> +	depends on ARCH_QCOM
>> +	help
>> +	  QPIC_SNAND(Quad SPI) driver for Qualcomm QPIC_SNAND controller.
>> +
> 
> I don't see any build dependencies on anything QC specific so please add
> an || COMPILE_TEST here, this makes it much easier to do generic changes
> without having to build some specific config.

Ok

> 
>> +++ b/drivers/spi/Makefile
>> @@ -153,6 +153,7 @@ obj-$(CONFIG_SPI_XTENSA_XTFPGA)		+= spi-xtensa-xtfpga.o
>>   obj-$(CONFIG_SPI_ZYNQ_QSPI)		+= spi-zynq-qspi.o
>>   obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+= spi-zynqmp-gqspi.o
>>   obj-$(CONFIG_SPI_AMD)			+= spi-amd.o
>> +obj-$(CONFIG_SPI_QPIC_SNAND)            += spi-qpic-snand.o
> 
> Please keep this alphabetically sorted (there are some mistakes there
> but no need to add to them).

Ok

> 
>> + * 	Sricharan R <quic_srichara@quicinc.com>
>> + */
>> +
>> +#include <linux/mtd/spinand.h>
>> +#include <linux/mtd/nand-qpic-common.h>
>> +
> 
> This should be including the SPI API, and other API headers that are
> used directly like the platform and clock APIs.
>

Ok

>> +static int qcom_snand_init(struct qcom_nand_controller *snandc)
>> +{
>> +	u32 snand_cfg_val = 0x0;
>> +	int ret;
> 
> ...
> 
>> +	ret = submit_descs(snandc);
>> +	if (ret)
>> +		dev_err(snandc->dev, "failure in sbumitting spiinit descriptor\n");
>> +
>> +	free_descs(snandc);
> 
> This seems to be doing a bit more than I would expect an init function
> to, and it's very surprising to see the descriptors freed immediately
> after something called a submit (which suggests that the descriptors are
> still in flight).
>

Our controller supports only bam mode , that means for writing/reading even
single register we have to use bam.
submit_descs() is synchronous so I/O is complete when it returns.
Hence freeing the descriptor after it.


>> +static int qpic_snand_read_page(struct qcom_nand_controller *snandc,
>> +				const struct spi_mem_op *op)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int qpic_snand_write_page(struct qcom_nand_controller *snandc,
>> +				const struct spi_mem_op *op)
>> +{
>> +	return 0;
>> +}
> 
> ...
> 
>> +static int qpic_snand_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>> +{
>> +	struct qcom_nand_controller *snandc = spi_controller_get_devdata(mem->spi->master);
>> +	dev_dbg(snandc->dev, "OP %02x ADDR %08llX@%d:%u DATA %d:%u", op->cmd.opcode,
>> +		op->addr.val, op->addr.buswidth, op->addr.nbytes,
>> +		op->data.buswidth, op->data.nbytes);
>> +
>> +	/*
>> +	 * Check for page ops or normal ops
>> +	 */
>> +	if (qpic_snand_is_page_op(op)) {
>> +		if (op->data.dir == SPI_MEM_DATA_IN)
>> +			return qpic_snand_read_page(snandc, op);
>> +		else
>> +			return qpic_snand_write_page(snandc, op);
> 
> So does the device actually support page operations?  The above looks
> like the driver will silently noop them.

Sorry It was to do item and I missed to mention that in commit log.
Will add in V1.

> 
>> +	snandc->base_phys = res->start;
>> +	snandc->base_dma = dma_map_resource(dev, res->start,
>> +					   resource_size(res),
>> +					   DMA_BIDIRECTIONAL, 0);
>> +	if (dma_mapping_error(dev, snandc->base_dma))
>> +		return -ENXIO;
>> +
>> +	ret = clk_prepare_enable(snandc->core_clk);
>> +	if (ret)
>> +		goto err_core_clk;
> 
> The DMA mapping and clock enables only get undone in error handling,
> they're not undone in the normal device release path.

Will fix in V1


