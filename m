Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580D97EFD31
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 03:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjKRC1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 21:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjKRC1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 21:27:22 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F37E10CE;
        Fri, 17 Nov 2023 18:27:18 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AI1YfNf015220;
        Sat, 18 Nov 2023 02:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EBLwbQq9XUpnkFVoTrmt1IchJfwm5gg9Up4FkOyTlqQ=;
 b=b8PF+6ixskCD/a40fMj8rDGhEZMuaskDp1H4DqtEjooTITid1jPQlnvZhis5KFXBA5lR
 OMQ3+zxTSjvI6Av63WIKEd2vnnMleekXv9YF8MlCtBQoPx9JWEDFh4Bb/dy5ZbOnVXxn
 dIJX9m4V4BdcMnQTgwPSFrshdRdmZY8lk5zrSD3o/Z+7Cg2dxwbAKzfovGSKoOR9fXhp
 9fM+IkUbjnBq6+AjGSF+feM/j+JnzfU3wtmcq9OfdijeeN8MrcNj0wjydRkWJoQ5WEYd
 fz3A5ZjRz7LAT0evGjBabSIK+7+Gd/IpmlRKqLbhZyU0ClFIQYz9p4WAAFetOXDsMduH vQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udt8bu603-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Nov 2023 02:26:51 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AI2QoG1005961
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Nov 2023 02:26:50 GMT
Received: from [10.251.44.35] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 17 Nov
 2023 18:26:46 -0800
Message-ID: <c1d7922e-cc94-4773-8ca7-de33d937d41e@quicinc.com>
Date:   Sat, 18 Nov 2023 04:26:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] iommu/arm-smmu-qcom: Add Qualcomm TBU driver
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <devicetree@vger.kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_cgoldswo@quicinc.com>,
        <quic_sukadev@quicinc.com>, <quic_pdaly@quicinc.com>,
        <quic_sudaraja@quicinc.com>, <djakov@kernel.org>
References: <20231019021923.13939-1-quic_c_gdjako@quicinc.com>
 <20231019021923.13939-4-quic_c_gdjako@quicinc.com>
 <ljbzuewnsi52qyolombjowuouiqmv5ybwbqf2z6ok34yuiacjc@7hwfysvidjqm>
From:   Georgi Djakov <quic_c_gdjako@quicinc.com>
In-Reply-To: <ljbzuewnsi52qyolombjowuouiqmv5ybwbqf2z6ok34yuiacjc@7hwfysvidjqm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MlXcEeMHevVGwTZB6h-_0hknfY-tpv48
X-Proofpoint-GUID: MlXcEeMHevVGwTZB6h-_0hknfY-tpv48
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-18_01,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311180016
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/2023 12:05 AM, Bjorn Andersson wrote:
> On Wed, Oct 18, 2023 at 07:19:20PM -0700, Georgi Djakov wrote:
>> Add driver for the Qualcomm implementation of the ARM MMU-500 TBU.
>> The driver will enable the resources needed by the TBU and will
>> configure the registers for some debug features like checking if
>> there are any pending transactions, capturing transactions and
>> running ATOS (Address Translation Operations). ATOS/eCATS are used
>> to manually trigger an address translation of IOVA to physical
>> address by the SMMU hardware.
> 
> I still don't think this commit message clearly enough describe the
> problem you're trying to solve.
> 
> Not until I had read the Kconfig help text did I pay attention to the
> significance of the words "some debug features" in the middle of the
> paragraph.
> 
> 
> Please describe your changes in accordance with [1], i.e. clearly
> describe the problem you're trying to solve, then discuss the technical
> solution in the patch.

Thanks Bjorn, I'll try to improve it! 

> [1] https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
> 
> [..]
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> [..]
>> +#ifdef CONFIG_ARM_SMMU_QCOM_TBU
>> +
>> +struct qsmmuv500_tbu {
>> +	struct device *dev;
>> +	struct arm_smmu_device *smmu;
>> +	u32 sid_range[2];
>> +	struct list_head list;
>> +	struct clk *clk;
>> +	struct icc_path	*path;
>> +	void __iomem *base;
>> +	spinlock_t halt_lock; /* protects halt count */
> 
> But in particular it makes sure that multiple halt or resume can't
> execute concurrently.

Exactly. Will mention it. 

>> +	int halt_count;
>> +};
>> +
>> +static DEFINE_SPINLOCK(ecats_lock);
>> +
>> +static struct qsmmuv500_tbu *qsmmuv500_find_tbu(struct qcom_smmu *qsmmu, u32 sid)
>> +{
>> +	struct qsmmuv500_tbu *tbu = NULL;
>> +	u32 start, end;
>> +
>> +	mutex_lock(&qsmmu->tbu_list_lock);
>> +
>> +	list_for_each_entry(tbu, &qsmmu->tbu_list, list) {
>> +		start = tbu->sid_range[0];
>> +		end = start + tbu->sid_range[1];
>> +
>> +		if (start <= sid && sid < end)
>> +			break;
>> +	}
>> +
>> +	mutex_unlock(&qsmmu->tbu_list_lock);
>> +
>> +	return tbu;
>> +}
>> +
>> +static int qsmmuv500_tbu_halt(struct qsmmuv500_tbu *tbu, struct arm_smmu_domain *smmu_domain)
>> +{
>> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
>> +	int ret = 0, idx = smmu_domain->cfg.cbndx;
>> +	unsigned long flags;
>> +	u32 val, fsr, status;
>> +
>> +	spin_lock_irqsave(&tbu->halt_lock, flags);
> 
> Does this really need to run with interrupts disabled?

This is being executed in threaded irq context. 

>> +	if (tbu->halt_count) {
>> +		tbu->halt_count++;
>> +		goto out;
>> +	}
>> +
> [..]
>> +static phys_addr_t qsmmuv500_iova_to_phys(struct arm_smmu_domain *smmu_domain,
>> +					  dma_addr_t iova, u32 sid)
>> +{
> [..]
>> +	/* Only one concurrent atos operation */
>> +	spin_lock_irqsave(&ecats_lock, flags);
> 
> Does this require interrupts to be disabled?

This also runs in the irq handler during context fault.

>> +
>> +	/*
>> +	 * After a failed translation, the next successful translation will
>> +	 * incorrectly be reported as a failure.
> 
> "So if the ECATS translation fails, attempt the lookup more time."
> 
>> +	 */
>> +	do {
>> +		phys = qsmmuv500_tbu_trigger_atos(smmu_domain, tbu, iova, sid);
>> +
>> +		fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
>> +		if (fsr & ARM_SMMU_FSR_FAULT) {
>> +			/* Clear pending interrupts */
>> +			arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
>> +			/*
>> +			 * Barrier required to ensure that the FSR is cleared
>> +			 * before resuming SMMU operation.
>> +			 */
> 
> Better be clear on what this actually does, for future readers' sake:
> 
> 	 /* Ensure that FSR and RESUME operations aren't reordered. */
> 
> But is this really necessary, the two writes are for the same device,
> can they still be reordered?

Right, these are to the same endpoint. It can be dropped. 

>> +			wmb();
>> +
>> +			if (fsr & ARM_SMMU_FSR_SS)
>> +				arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_RESUME,
>> +						  ARM_SMMU_RESUME_TERMINATE);
>> +		}
>> +	} while (!phys && needs_redo++ < 2);
> 
> "needs_redo" sounds like a boolean to me. I think "attempt" would be a
> better fit here.
> 

Ok.

>> +
>> +	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, sctlr_orig);
>> +	spin_unlock_irqrestore(&ecats_lock, flags);
>> +	qsmmuv500_tbu_resume(tbu);
>> +
>> +	/* Read to complete prior write transcations */
>> +	readl_relaxed(tbu->base + DEBUG_SR_HALT_ACK_REG);
>> +
>> +	/* Wait for read to complete */
> 
> That's not what rmb() does. You don't need to do anything here,
> readl_relaxed() returns when the read is done.

Ack.

>> +	rmb();
>> +
>> +disable_clk:
>> +	clk_disable_unprepare(tbu->clk);
>> +disable_icc:
>> +	icc_set_bw(tbu->path, 0, 0);
>> +
>> +	return phys;
>> +}
>> +#endif
>> +
>>  static void qcom_smmu_tlb_sync(struct arm_smmu_device *smmu, int page,
>>  				int sync, int status)
>>  {
>> @@ -588,3 +895,80 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
>>  
>>  	return smmu;
>>  }
>> +
>> +#ifdef CONFIG_ARM_SMMU_QCOM_TBU
>> +
>> +static const struct of_device_id qsmmuv500_tbu_of_match[] = {
>> +	{ .compatible = "qcom,qsmmuv500-tbu" },
>> +	{ }
>> +};
> 
> Place this below the remove function, as most other drivers do.

Ack.

>> +
>> +static int qsmmuv500_tbu_probe(struct platform_device *pdev)
>> +{
> [..]
>> +	mutex_lock(&qsmmu->tbu_list_lock);
>> +	list_add_tail(&tbu->list, &qsmmu->tbu_list);
> 
> "tbu" is devres allocated, but you don't pull it off the list (or
> synchronize) during remove.

Right, but I'll just make this a builtin.

>> +	mutex_unlock(&qsmmu->tbu_list_lock);
>> +
>> +	dev_set_drvdata(dev, tbu);
>> +
>> +	return 0;
>> +}
>> +
>> +static void qsmmuv500_tbu_remove(struct platform_device *pdev)
>> +{
>> +	struct qsmmuv500_tbu *tbu = dev_get_drvdata(&pdev->dev);
>> +
>> +	clk_disable_unprepare(tbu->clk);
> 
> This isn't balanced.
> 
>> +	clk_put(tbu->clk);
>> +	icc_put(tbu->path);
>> +}
>> +
>> +static struct platform_driver qsmmuv500_tbu_driver = {
>> +	.driver = {
>> +		.name           = "qsmmuv500-tbu",
>> +		.of_match_table = of_match_ptr(qsmmuv500_tbu_of_match),
> 
> Won't of_match_ptr() result in a build warning if built without
> CONFIG_OF?

Will drop.

>> +	},
>> +	.probe  = qsmmuv500_tbu_probe,
>> +	.remove_new = qsmmuv500_tbu_remove,
>> +};
>> +module_platform_driver(qsmmuv500_tbu_driver);
> 
> This file acts as a library for the arm-smmu driver today, adding a
> platform_driver here makes it look like this is a separate driver.
> 
> Which makes me wonder, why is this a separate driver? Why not just
> loop over the subnodes and build the tbu_list in qcom_smmu_impl_init()?
> 

I am using the platform framework in order to get a more compact code
for this optional driver, but it adds some overhead.. I'll start with
moving all the TBU stuff into a separate file and will try meanwhile
your suggestion..

Thanks,
Georgi 
