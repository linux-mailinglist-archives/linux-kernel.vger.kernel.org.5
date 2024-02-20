Return-Path: <linux-kernel+bounces-72954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2759A85BB0E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81109B265D9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058A167C50;
	Tue, 20 Feb 2024 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AeLczDid"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E3D67A13;
	Tue, 20 Feb 2024 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430107; cv=none; b=BdwkkC9q7gUhZsridbUHu1IC7ZVHOY3E1UBT4VHtaeYOrBtSRj95lrp9nnnIDS7jK+XH2A/mYHDklOBdxsmBHlB3bE4Kz3e6USMvvpl4ByXRE+8RYISmD39BRjVTq4HeT/oxW9d0fCuebmyFD6pkN5Ytw8ql4xOR431u9NViSo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430107; c=relaxed/simple;
	bh=G37dnvbF3A8K2ThbCOcd4qdlsHi5owKBhUKt88TBtUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sRkqoUiMqX1KBkGras7/ttnfYqwSE13d6oGXoxvavOPYhXo/bz3toZ17CpH3bM5oJx5OqdwDnqhY6A3Bu8kULXUfB17lUWmw7n3Urdbx/cHnBg9DfotnEk2PSZ+ytcY0Lox7pyL/qj78YxKEVTU0YS661g7nFX+1y3iGx7SMA48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AeLczDid; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41KB3LSR014481;
	Tue, 20 Feb 2024 11:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DoDxy0mwU9u7YJbq/jRMZE3kTAuFfBIV4Uu1fx3QBto=; b=Ae
	LczDidqK02hsO+ZXLGCx4Zu9aZK32vwkAFLbvNWNb424jbe2ik60Jmdi8wYWV/Br
	TVn+0BG5+seVesZVVJN+2/GPoo0BPOypeg93gSG5a2eaVe2/zKef4u5A1KWVZlJL
	3cRj08NNpUjZLD/hMUTn+9E2HfZK98n3H1FyZ5UAUtg0kioLmwJN9dM1+gWqZ2Ok
	iL8C0BKbAjv4L9c2t1lcMtdUUjJ9lJFIe4nSafrZRYWm3nHhD7/VKcTy5TXQuqn9
	GqrLRSJxgxEv8745VBJTEpKgFuKlgpRAr4aDFuJAJNtsb8sMpFPBaJI66DIFTI4u
	+Hoz6X6ibYHWjHqxyGUg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wcrc08esy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 11:54:54 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41KBsqDO031043
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 11:54:52 GMT
Received: from [10.216.16.129] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 03:54:46 -0800
Message-ID: <4a0e51cf-d29a-5843-9c61-1d31a9721a3d@quicinc.com>
Date: Tue, 20 Feb 2024 17:24:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/5] spi: spi-qpic: Add qpic spi nand driver support
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
 <20240215134856.1313239-4-quic_mdalam@quicinc.com>
 <21dde665-54b4-48e4-b963-1008ac890df3@sirena.org.uk>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <21dde665-54b4-48e4-b963-1008ac890df3@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 621AKJ1ATbueRox6g6okjqSiiIRi4_5x
X-Proofpoint-GUID: 621AKJ1ATbueRox6g6okjqSiiIRi4_5x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402200085



On 2/15/2024 7:44 PM, Mark Brown wrote:
> On Thu, Feb 15, 2024 at 07:18:54PM +0530, Md Sadre Alam wrote:
> 
>> +config SPI_QPIC_SNAND
>> +	tristate "QPIC SNAND controller"
>> +	default y
> 
> Why is this driver so special it should be enabled by default?
   Sorry by mistake I kept this enabled by default, will change in next
   patch.
> 
>> +	depends on ARCH_QCOM
> 
> Please add an || COMPILE_TEST so this gets some build coverage.
  Ok
> 
>> +	help
>> +	  QPIC_SNAND (QPIC SPI NAND) driver for Qualcomm QPIC controller.
>> +	  QPIC controller supports both parallel nand and serial nand.
>> +	  This config will enable serial nand driver for QPIC controller.
>> +
>>   config SPI_QUP
>>   	tristate "Qualcomm SPI controller with QUP interface"
>>   	depends on ARCH_QCOM || COMPILE_TEST
>> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
>> index 4ff8d725ba5e..1ac3bac35007 100644
>> --- a/drivers/spi/Makefile
>> +++ b/drivers/spi/Makefile
>> @@ -153,6 +153,7 @@ obj-$(CONFIG_SPI_XTENSA_XTFPGA)		+= spi-xtensa-xtfpga.o
>>   obj-$(CONFIG_SPI_ZYNQ_QSPI)		+= spi-zynq-qspi.o
>>   obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+= spi-zynqmp-gqspi.o
>>   obj-$(CONFIG_SPI_AMD)			+= spi-amd.o
>> +obj-$(CONFIG_SPI_QPIC_SNAND)            += spi-qpic-snand.o
> 
> Please keep this sorted.
Ok
> 
>> --- /dev/null
>> +++ b/drivers/spi/spi-qpic-snand.c
>> @@ -0,0 +1,1025 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> 
> Please make the entire comment a C++ one so things look more
> intentional.
Ok
> 
>> +#define snandc_set_read_loc_first(snandc, reg, cw_offset, read_size, is_last_read_loc)	\
>> +snandc_set_reg(snandc, reg,			\
>> +	      ((cw_offset) << READ_LOCATION_OFFSET) |		\
>> +	      ((read_size) << READ_LOCATION_SIZE) |			\
>> +	      ((is_last_read_loc) << READ_LOCATION_LAST))
>> +
>> +#define snandc_set_read_loc_last(snandc, reg, cw_offset, read_size, is_last_read_loc)	\
>> +snandc_set_reg(snandc, reg,			\
>> +	      ((cw_offset) << READ_LOCATION_OFFSET) |		\
>> +	      ((read_size) << READ_LOCATION_SIZE) |			\
>> +	      ((is_last_read_loc) << READ_LOCATION_LAST))
> 
> For type safety and legibility please write these as functions, mark
> them as static inline if needed.
Ok
> 
>> +void snandc_set_reg(struct qcom_nand_controller *snandc, int offset, u32 val)
>> +{
>> +	struct nandc_regs *regs = snandc->regs;
>> +	__le32 *reg;
>> +
>> +	reg = offset_to_nandc_reg(regs, offset);
>> +
>> +	if (reg)
>> +		*reg = cpu_to_le32(val);
>> +}
> 
> This silently ignores writes to invalid registers, that doesn't seem
> great.
Ok
> 
>> +	return snandc->ecc_stats.failed ? -EBADMSG : snandc->ecc_stats.bitflips;
> 
> For legibility please just write normal conditional statements.
Ok
> 
>> +static int qpic_snand_program_execute(struct qcom_nand_controller *snandc,
>> +				      const struct spi_mem_op *op)
>> +{
> 
>> +       int num_cw = 4;
> 
>> +	data_buf = (u8 *)snandc->wbuf;
> 
> Why the cast?  If it's needed that smells like it's masking a bug, it
> looks like it's casting from a u8 * to a u8 *.
Ok Will fix in next patch.
> 
>> +	for (i = 0; i < num_cw; i++) {
>> +		int data_size;
> 
> All these functions appear to hard code "num_cw" to 4.  What is "num_cw"
> and why are we doing this per function?
QPIC controller internally works on code word size not on page and each
code word size is 512-bytes so if page size is 2K then num_cw = 4, if page
size is 4K then num_cw = 8.
Will not hard code this value to 4 or 8 , will fix this in next patch.
> 
>> +static int qpic_snand_program_execute(struct qcom_nand_controller *snandc,
>> +                                     const struct spi_mem_op *op)
> 
>> +	if (op->cmd.opcode == SPINAND_READID) {
>> +		snandc->buf_count = 4;
>> +		read_reg_dma(snandc, NAND_READ_ID, 1, NAND_BAM_NEXT_SGL);
>> +
>> +		ret = submit_descs(snandc);
>> +		if (ret)
>> +			dev_err(snandc->dev, "failure in submitting descriptor for readid\n");
>> +
>> +		nandc_read_buffer_sync(snandc, true);
>> +		memcpy(op->data.buf.in, snandc->reg_read_buf, snandc->buf_count);
> 
> These memcpy()s don't seem great, why aren't we just reading directly
> into the output buffer?
   This reg_read_buf is being used in common API so that it will be used by both
   serial nand as well raw nand, so I can't directly use the output buffer since
   internally CW mechanism I have to maintain in common API.
> 
>> +	if (op->cmd.opcode == SPINAND_GET_FEATURE) {
> 
> This function looks like it should be a switch statement.
Ok
> 
>> +static bool qpic_snand_is_page_op(const struct spi_mem_op *op)
>> +{
> 
>> +	if (op->data.dir == SPI_MEM_DATA_IN) {
>> +		if (op->addr.buswidth == 4 && op->data.buswidth == 4)
>> +			return true;
>> +
>> +		if (op->addr.nbytes == 2 && op->addr.buswidth == 1)
>> +			return true;
>> +
>> +	} else if (op->data.dir == SPI_MEM_DATA_OUT) {
>> +		if (op->data.buswidth == 4)
>> +			return true;
>> +		if (op->addr.nbytes == 2 && op->addr.buswidth == 1)
>> +			return true;
>> +	}
> 
> Again looks like a switch statement.
Ok
> 
>> +	ctlr = devm_spi_alloc_master(dev, sizeof(*snandc));
>> +	if (!ctlr)
>> +		return -ENOMEM;
> 
> Please use _alloc_controller.
Ok
> 
>> +static int qcom_snand_remove(struct platform_device *pdev)
>> +{
>> +	struct spi_controller *ctlr = platform_get_drvdata(pdev);
>> +
>> +	spi_unregister_controller(ctlr);
>> +
>> +	return 0;
>> +}
> 
> We don't disable any of the clocks in the remove path.
OK will fix in next patch.

Thanks for reviewing, will address all your comments in the next patch.

Regards,
Alam.

