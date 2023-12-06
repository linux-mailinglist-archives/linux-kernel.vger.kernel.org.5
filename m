Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1425C806E32
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377735AbjLFLj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377692AbjLFLjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:39:23 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D060112;
        Wed,  6 Dec 2023 03:39:29 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B69NALq005138;
        Wed, 6 Dec 2023 11:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=lznMPLlQXuHC6QqF1xj/Bm4pxkXQNtJyh7qYp4nNzkw=;
 b=Xfcn0oqck9I+TifLQGVuOCZ5YNPGDm38J/F0qiZVZCdofheBHCrqBYOKGw3tPR7pK1rF
 FMqyMNzhX/FuMxnSak1G+KbXVfYMLZ0CFP7Wf7g747Hc3Xjr6O1V8OR6JwXV514Wj7g9
 jvaf7dHE6builV+vApUPCqeYRGlPLtGQylpkHMM4M+HD4N9fibt459INFJMOghpDmp7p
 p/Qk+GKg62wEBahUxIOp6MrPXqPbxmZadRjF1SCJDSmyMF/JkNybCk6fGIMcBmf7FXMz
 Gn1JxoF7jDqul5dUNmv6WeAeqH5mACuj7XZbro39hN4T2E8DxeZjI17pKVj0U/gSVfI2 vg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utdmd1ehw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Dec 2023 11:39:24 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B6BdN4g008206
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Dec 2023 11:39:23 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Dec 2023 03:38:08 -0800
Date:   Wed, 6 Dec 2023 17:08:05 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: ipq9574: Fix USB
 'vdda-pll-supply'
Message-ID: <ZXBdHQpJYBmZbd76@hu-varada-blr.qualcomm.com>
References: <cover.1701160842.git.varada@hu-varada-blr.qualcomm.com>
 <f98bbf0a515236709d999010f08c8f2470a31209.1701160842.git.varada@hu-varada-blr.qualcomm.com>
 <832a6d4f-f561-4cf5-b1cb-7e4b2d4d50b4@linaro.org>
 <ZWW9oF24YUGfev+2@hu-varada-blr.qualcomm.com>
 <0acdc122-b7fa-4bb4-b838-6420cd43d0e0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0acdc122-b7fa-4bb4-b838-6420cd43d0e0@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ws1jWjDn5Y3mhcCKC-u1wb6yeh3sKe9F
X-Proofpoint-ORIG-GUID: ws1jWjDn5Y3mhcCKC-u1wb6yeh3sKe9F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_09,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=419 spamscore=0
 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 03:01:12PM +0100, Krzysztof Kozlowski wrote:
> On 28/11/2023 11:14, Varadarajan Narayanan wrote:
> > On Tue, Nov 28, 2023 at 09:51:50AM +0100, Krzysztof Kozlowski wrote:
> >> On 28/11/2023 09:46, Varadarajan Narayanan wrote:
> >>> From: Varadarajan Narayanan <quic_varada@quicinc.com>
> >>>
> >>> The earlier patch ec4f047679d5, incorrectly used 'l2'
> >>> as the vdda-pll-supply. However, 'l5' is the correct
> >>> ldo that supplies power to the USB PHY.
> >>>
> >>> Fixes: ec4f047679d5 ("arm64: dts: qcom: ipq9574: Enable USB")
> >>
> >> Doesn't this depend on the driver change?
> >
> > Yes, will mention in the cover letter.
>
> This commit should have it in its changelog ---
>
> >
> >> It affects both existing
> >> kernel and backports which you claim here should happen.
> >
> > Ok. Will include stable@vger.kernel.org in the next revision.
>
> I wasn't speaking about Cc. You indicated this should be backported.
> Then please backport it, without previous commit, and check the result.
> Is stable tree working correctly or not?

Without the previous commit, it would fail in both the latest
and stable tree. (Please see below for the error messages and
stack dump)

The previous commit is necessary for this commit to work.

Thanks
Varada

Linux version 6.7.0-rc3-next-20231128-00002-gf98bbf0a5152
---------------------------------------------------------
	[    1.073091] l5: Bringing 0uV into 1800000-1800000uV
	[    1.095184] l5: failed to enable: -ENXIO
	[    1.100751] clk: Disabling unused clocks
	[    1.105428] ------------[ cut here ]------------
	[    1.120170] WARNING: CPU: 2 PID: 58 at drivers/regulator/core.c:2397 _regulator_put.part.36+0x154/0x15c
	[    1.124774] Modules▒ $HL▒137014] Hardware name: Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7 (DT)
	[    1.137033] Workqueue: events_unbound async_run_entry_fn
	[    1.143111] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
	[    1.148579] pc : _regulator_put.part.36+0x154/0x15c
	[    1.155261] lr : regulator_put+0x34/0x4c
	[    1.160122] sp : ffff80008136ba10
	[    1.164288] x29: ffff80008136ba10 x28: ffff80008136bba8 x27: 0000000000000000
	[    1.167504] x26: ffff000002b76810 x25: fffffffffffffffa x24: ffff800080902000
	[    1.174622] x23: ffff00000039f800 x22: ffff0000009dfa80 x21: ffff0000009df898
	[    1.181740] x20: ffff00000256f840 x19: ffff00000256f840 x18: ffffffffffffffff
	[    1.188858] x17: 7571657266206c61 x16: 6974696e69206465 x15: ffff800080901480
	[    1.195976] x14: 0000000000000000 x13: 307475706e692f74 x12: 75706e692f737965
	[    1.203094] x11: 6b2d6f6970672f6d x10: 000000000000000d x9 : 0000000000000000
	[    1.210212] x8 : ffff800081035000 x7 : 000000000000000a x6 : 0000000000000000
	[    1.217330] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
	[    1.224449] x2 : ffff000000286a00 x1 : 0000000000000000 x0 : 0000000000000001
	[    1.231567] Call trace:
	[    1.238681]  _regulator_put.part.36+0x154/0x15c
	[    1.241633]  regulator_put+0x34/0x4c
	[    1.245886]  regulator_register+0x420/0x9e8
	[    1.249707]  devm_regulator_register+0x58/0xb4
	[    1.253613]  rpm_reg_probe+0x12c/0x238
	[    1.258126]  platform_probe+0x4c/0xa8
	[    1.261859]  really_probe+0x144/0x298
	[    1.265591]  __driver_probe_device+0xc4/0xe8
	[    1.269238]  driver_probe_device+0x38/0x114
	[    1.273578]  __device_attach_driver+0xac/0xe8
	[    1.277484]  bus_for_each_drv+0x6c/0xd8
	[    1.281997]  __device_attach_async_helper+0xac/0xb4
	[    1.285643]  async_run_entry_fn+0x2c/0xdc
	[    1.290505]  process_scheduled_works+0x16c/0x288
	[    1.294672]  worker_thread+0x160/0x33c
	[    1.299358]  kthread+0x100/0x10c
	[    1.302917]  ret_from_fork+0x10/0x20
	[    1.306303] ---[ end trace 0000000000000000 ]---
	[    1.309902] qcom_rpm_smd_regulator remoteproc:glink-edge:rpm-requests:regulators: l5: devm_regulator_register() failed, ret=-6

Linux version 6.6.4-dirty
-------------------------
	[    1.028110] qcom_rpm_smd_regulator remoteproc:glink-edge:rpm-requests:regulators: Unknown regulator l5
	[    1.036839] clk: Disabling unused clocks
	[    1.039163] mmc0: Failed to initialize a non-removable card
	[    1.046249] qcom_rpm_smd_regulator: probe of remoteproc:glink-edge:rpm-requests:regulators failed with error -22
	[    1.046329] ------------[ cut here ]------------
	[    1.075147] WARNING: CPU: 3 PID: 56 at drivers/regulator/core.c:5760 regulator_unregister+0xd0/0xd8
	[    1.079750] Modulesm▒▒r▒ʊ▒▒▒▒        *▒.YW,▒Y▒name: Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7 (DT)
	[    1.091661] Workqueue: events_unbound async_run_entry_fn
	[    1.097738] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
	[    1.103207] pc : regulator_unregister+0xd0/0xd8
	[    1.109889] lr : regulator_unregister+0x4c/0xd8
	[    1.114402] sp : ffff8000813bbb30
	[    1.118915] x29: ffff8000813bbb30 x28: ffff00000000e205 x27: ffff00000009c6e0
	[    1.122912] x26: ffff00000083be00 x25: 61c8864680b583eb x24: ffff0000002321a4
	[    1.129944] x23: ffff0000002321a8 x22: ffff000000232010 x21: ffff8000813bbbd8
	[    1.137062] x20: ffff800080f45000 x19: ffff000000911c00 x18: ffff000000030310
	[    1.144180] x17: 65757165722d6d70 x16: 723a656764652d6b x15: ffff0000004a46a0
	[    1.151298] x14: 0000000000000000 x13: ffff000000030310 x12: ffff0000004a4490
	[    1.158415] x11: 0001ffffffffffff x10: ffff000000030318 x9 : ffff000000030310
	[    1.165534] x8 : ffff0000004a44b8 x7 : 0000000000000000 x6 : ffff0000008f5cc0
	[    1.172652] x5 : ffff00000039c0f8 x4 : 0000000000000000 x3 : 0000000000000000
	[    1.179770] x2 : ffff0000008f5cc0 x1 : 0000000000000000 x0 : 0000000000000001
	[    1.186888] Call trace:
	[    1.194002]  regulator_unregister+0xd0/0xd8
	[    1.196260]  devm_rdev_release+0x10/0x18
	[    1.200426]  release_nodes+0x38/0x60
	[    1.204593]  devres_release_all+0x90/0xd8
	[    1.208153]  device_unbind_cleanup+0x14/0x50
	[    1.212059]  really_probe+0xdc/0x298
	[    1.216399]  __driver_probe_device+0xc4/0xe8
	[    1.219958]  driver_probe_device+0x34/0x10c
	[    1.224211]  __device_attach_driver+0xac/0xe8
	[    1.228118]  bus_for_each_drv+0x6c/0xd8
	[    1.232632]  __device_attach_async_helper+0xac/0xb4
	[    1.236277]  async_run_entry_fn+0x2c/0xdc
	[    1.241139]  process_scheduled_works+0x16c/0x288
	[    1.245305]  worker_thread+0x15c/0x338
	[    1.249992]  kthread+0x100/0x10c
	[    1.253551]  ret_from_fork+0x10/0x20
	[    1.256937] ---[ end trace 0000000000000000 ]---
