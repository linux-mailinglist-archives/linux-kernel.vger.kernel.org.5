Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FEC792938
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351391AbjIEQZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353701AbjIEHUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:20:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3D3A8;
        Tue,  5 Sep 2023 00:20:41 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3855Jlpu003707;
        Tue, 5 Sep 2023 07:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XixQLjt/a4hSSFcOZqSVyKlIfoT9lWBXUSxeDg07nNw=;
 b=fQbIi5IRRIAMjdglemaaQjXtPViSZWtU1ooiYhGv5jMYOFdF7nRTaLmVQb/KjaaNdeok
 5FQl3Mm01VAf2eW7WS/OjIWprWPZT6a0WXSO6rYLEm8Gz7essMuovQU6TvXmfBMQIIJ/
 dP5iOXXRsowMsJr2K67py50xeEDQuYf3BsMT597RF1V11/6LW3U0HfvZX4HPXxtIPHpA
 3VN5zbpWAeLLm38TZMFGlD2Vq4FqOXIg0ym/dOrF7AIWLHSVqWeB35V6jIqAlJhimgm9
 /EpYFLZcXIrD6/qYCtbC7F436y2jrZCmvZiGIQKe0HkqG/oxYifPBtnJc++9ksuN79Gw 2A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3swvj60bwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 07:20:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3857KYgd026147
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Sep 2023 07:20:34 GMT
Received: from [10.216.59.199] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 5 Sep
 2023 00:20:27 -0700
Message-ID: <0e64f0f4-75ad-201b-452b-2cf2e7194df8@quicinc.com>
Date:   Tue, 5 Sep 2023 12:50:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 2/2] interconnect: qcom: Add SDX75 interconnect provider
 driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>
References: <1693889975-19122-1-git-send-email-quic_rohiagar@quicinc.com>
 <1693889975-19122-3-git-send-email-quic_rohiagar@quicinc.com>
 <4388cb18-ada2-656b-ff1d-e75bf1e8b82d@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <4388cb18-ada2-656b-ff1d-e75bf1e8b82d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m3R1I7EysQ2RRiuuzk954oapPNTPaxUS
X-Proofpoint-ORIG-GUID: m3R1I7EysQ2RRiuuzk954oapPNTPaxUS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_05,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050065
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/5/2023 12:32 PM, Krzysztof Kozlowski wrote:
> On 05/09/2023 06:59, Rohit Agarwal wrote:
>> Add driver for the Qualcomm interconnect buses found in SDX75.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ...
>
>> +
>> +static struct qcom_icc_bcm *system_noc_bcms[] = {
> Please do not copy your code from downstream, but work on upstream. We
> changed this long time ago, so you clearly used some old or obsolete
> file as template.
Sure will check the sm8550 as template and work on it again.
Thank you for your time.

Thanks,
Rohit.
>> +	&bcm_ce0,
>> +	&bcm_cn0,
>> +	&bcm_sn0,
>> +	&bcm_sn1,
>> +	&bcm_sn2,
>> +};
>> +
>> +static struct qcom_icc_node *system_noc_nodes[] = {
>> +	[MASTER_AUDIO] = &qhm_audio,
>> +	[MASTER_GIC_AHB] = &qhm_gic,
>> +	[MASTER_PCIE_RSCC] = &qhm_pcie_rscc,
>> +	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
>> +	[MASTER_QPIC] = &qhm_qpic,
>> +	[MASTER_QUP_0] = &qhm_qup0,
>> +	[MASTER_ANOC_SNOC] = &qnm_aggre_noc,
>> +	[MASTER_GEM_NOC_CNOC] = &qnm_gemnoc_cnoc,
>> +	[MASTER_GEM_NOC_PCIE_SNOC] = &qnm_gemnoc_pcie,
>> +	[MASTER_SNOC_CFG] = &qnm_system_noc_cfg,
>> +	[MASTER_PCIE_ANOC_CFG] = &qnm_system_noc_pcie_cfg,
>> +	[MASTER_CRYPTO] = &qxm_crypto,
>> +	[MASTER_IPA] = &qxm_ipa,
>> +	[MASTER_MVMSS] = &qxm_mvmss,
>> +	[MASTER_EMAC_0] = &xm_emac_0,
>> +	[MASTER_EMAC_1] = &xm_emac_1,
>> +	[MASTER_QDSS_ETR] = &xm_qdss_etr0,
>> +	[MASTER_QDSS_ETR_1] = &xm_qdss_etr1,
>> +	[MASTER_SDCC_1] = &xm_sdc1,
>> +	[MASTER_SDCC_4] = &xm_sdc4,
>> +	[MASTER_USB3_0] = &xm_usb3,
>> +	[SLAVE_ETH0_CFG] = &ps_eth0_cfg,
>> +	[SLAVE_ETH1_CFG] = &ps_eth1_cfg,
>> +	[SLAVE_AUDIO] = &qhs_audio,
>> +	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
>> +	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto_cfg,
>> +	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
>> +	[SLAVE_IPA_CFG] = &qhs_ipa,
>> +	[SLAVE_IPC_ROUTER_CFG] = &qhs_ipc_router,
>> +	[SLAVE_CNOC_MSS] = &qhs_mss_cfg,
>> +	[SLAVE_ICBDI_MVMSS_CFG] = &qhs_mvmss_cfg,
>> +	[SLAVE_PCIE_0_CFG] = &qhs_pcie0_cfg,
>> +	[SLAVE_PCIE_1_CFG] = &qhs_pcie1_cfg,
>> +	[SLAVE_PCIE_2_CFG] = &qhs_pcie2_cfg,
>> +	[SLAVE_PCIE_RSC_CFG] = &qhs_pcie_rscc,
>> +	[SLAVE_PDM] = &qhs_pdm,
>> +	[SLAVE_PRNG] = &qhs_prng,
>> +	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
>> +	[SLAVE_QPIC] = &qhs_qpic,
>> +	[SLAVE_QUP_0] = &qhs_qup0,
>> +	[SLAVE_SDCC_1] = &qhs_sdc1,
>> +	[SLAVE_SDCC_4] = &qhs_sdc4,
>> +	[SLAVE_SPMI_VGI_COEX] = &qhs_spmi_vgi_coex,
>> +	[SLAVE_TCSR] = &qhs_tcsr,
>> +	[SLAVE_TLMM] = &qhs_tlmm,
>> +	[SLAVE_USB3] = &qhs_usb3,
>> +	[SLAVE_USB3_PHY_CFG] = &qhs_usb3_phy,
>> +	[SLAVE_A1NOC_CFG] = &qns_a1noc,
>> +	[SLAVE_DDRSS_CFG] = &qns_ddrss_cfg,
>> +	[SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
>> +	[SLAVE_SNOC_CFG] = &qns_system_noc_cfg,
>> +	[SLAVE_PCIE_ANOC_CFG] = &qns_system_noc_pcie_cfg,
>> +	[SLAVE_IMEM] = &qxs_imem,
>> +	[SLAVE_SERVICE_PCIE_ANOC] = &srvc_pcie_system_noc,
>> +	[SLAVE_SERVICE_SNOC] = &srvc_system_noc,
>> +	[SLAVE_PCIE_0] = &xs_pcie_0,
>> +	[SLAVE_PCIE_1] = &xs_pcie_1,
>> +	[SLAVE_PCIE_2] = &xs_pcie_2,
>> +	[SLAVE_QDSS_STM] = &xs_qdss_stm,
>> +	[SLAVE_TCU] = &xs_sys_tcu_cfg,
>> +};
>> +
>> +static struct qcom_icc_desc sdx75_system_noc = {
> Come on... we fixed it.
>
> There could be more issues because you used old file as template. Start
> from scratch from new file.
>
> Best regards,
> Krzysztof
>
