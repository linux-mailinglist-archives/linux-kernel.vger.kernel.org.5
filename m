Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528197E6501
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjKIIPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjKIIPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:15:00 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BAD2737;
        Thu,  9 Nov 2023 00:14:58 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A96QRgK032615;
        Thu, 9 Nov 2023 08:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yvBLW3P9xd0RA563uJc8jhTJgxz+l6MiOI03IVC555I=;
 b=K/izZWa8f48/W+yck8BqsfaWasnnOLT81hxQoaVXN+VR5FqXTqjCR4Zv9iD1sPddm4WN
 N9UnRSWuU4d8HsB2tEgcxkvXRGHRcF4MtA9lrHYVzFWSmJIhnlmE7nKVAR4oENCsD1kt
 oqQ/y21M9m2gCeVL9DMyw3G9svhP6VzMoZ1dvy8O2z+PpRohvQr1p0mUPxk2SD01NkH2
 c5+yA/xZGuVt4XsuZIlLawvy/vJBXuhvY2Ts15PUVlrSvCtmQvZkl0Ydq7UzOHI/YHNu
 LYpfzK2A+DkuQmUlAymkKqW/w8QV1WfyRKzSCELHds4XuQLjWKiIgVwiK101/CLwHEWs Cg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u8nhd13av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 08:14:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A98EdnL026455
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Nov 2023 08:14:39 GMT
Received: from [10.50.57.76] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 9 Nov
 2023 00:14:34 -0800
Message-ID: <105168e9-8b1a-9e94-c183-4cecf1d6d009@quicinc.com>
Date:   Thu, 9 Nov 2023 13:44:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V8 2/5] scsi: ufs: qcom: Add multiple frequency support
 for MAX_CORE_CLK_1US_CYCLES
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <mani@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Naveen Kumar Goud Arepalli" <quic_narepall@quicinc.com>
References: <20230905052400.13935-1-quic_nitirawa@quicinc.com>
 <20230905052400.13935-3-quic_nitirawa@quicinc.com>
 <CAA8EJpr1RE5wDxM939vec8c7aaFYozXc1SxU-tT2dg4Gx4PqEg@mail.gmail.com>
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <CAA8EJpr1RE5wDxM939vec8c7aaFYozXc1SxU-tT2dg4Gx4PqEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: i_0w20_iM3T-Fs8hsGNBwvKOtuQPKJTl
X-Proofpoint-ORIG-GUID: i_0w20_iM3T-Fs8hsGNBwvKOtuQPKJTl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_06,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090066
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

As per the log, I see unipro max freq is set to 300Mhz. But as per Qcom 
HPG requirement for APQ8096, max freq should be 150Mhz.

In Earlier code, driver was hardcoded to configure 1US and 40ns unipro 
param for 150Mhz hence it was working. Now as per new code we read it 
from Device tree instead of hardcoding to 150 to support multiple targets.

PLease can try by updating unipro min and max freq in DT to 75000000 and 
150000000 respectively. CUrrently it is set to 150000000 and 300000000
respectively.


Regards,
Nitin

On 11/8/2023 10:00 PM, Dmitry Baryshkov wrote:
> On Tue, 5 Sept 2023 at 19:20, Nitin Rawat <quic_nitirawa@quicinc.com> wrote:
>>
>> Qualcomm UFS Controller V4 and above supports multiple unipro frequencies
>> like 403MHz, 300MHz, 202MHz, 150 MHz, 75Mhz, 37.5 MHz. Current code
>> supports only 150MHz and 75MHz which have performance impact due to low
>> UFS controller frequencies.
>>
>> For targets which supports frequencies other than 150 MHz and 75 Mhz,
>> needs an update of MAX_CORE_CLK_1US_CYCLES to match the configured
>> frequency to avoid functionality issues. Add multiple frequency support
>> for MAX_CORE_CLK_1US_CYCLES based on the frequency configured.
>>
>> Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
>> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
>> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> 
> This patch breaks UFS support on the APQ8096. Now the boot process
> breaks with the following messages.
> 
> 
> [    4.885592] ufshcd-qcom 624000.ufshc: uic cmd 0x16 with arg3 0x0
> completion timeout
> [    4.890996] ufshcd-qcom 624000.ufshc: ufs_qcom_host_reset: reset
> control not set
> [    5.424864] ufshcd-qcom 624000.ufshc: uic cmd 0x16 with arg3 0x0
> completion timeout
> [    5.425020] ufshcd-qcom 624000.ufshc: ufs_qcom_host_reset: reset
> control not set
> [    5.936918] ufshcd-qcom 624000.ufshc: uic cmd 0x16 with arg3 0x0
> completion timeout
> [    5.937136] ufshcd-qcom 624000.ufshc: link startup failed -110
> [    5.943584] ufshcd-qcom 624000.ufshc: UFS Host state=0
> [    5.949463] ufshcd-qcom 624000.ufshc: outstanding reqs=0x0 tasks=0x0
> [    5.954594] ufshcd-qcom 624000.ufshc: saved_err=0x0, saved_uic_err=0x0
> [    5.961106] ufshcd-qcom 624000.ufshc: Device power mode=1, UIC link state=0
> [    5.967479] ufshcd-qcom 624000.ufshc: PM in progress=0, sys. suspended=0
> [    5.974310] ufshcd-qcom 624000.ufshc: Auto BKOPS=0, Host self-block=0
> [    5.981271] ufshcd-qcom 624000.ufshc: Clk gate=1
> [    5.987541] ufshcd-qcom 624000.ufshc: last_hibern8_exit_tstamp at 0
> us, hibern8_exit_cnt=0
> [    5.992330] ufshcd-qcom 624000.ufshc: last intr at 5432791 us, last
> intr status=0x400
> [    6.000300] ufshcd-qcom 624000.ufshc: error handling flags=0x0,
> req. abort count=0
> [    6.008236] ufshcd-qcom 624000.ufshc: hba->ufs_version=0x200, Host
> capabilities=0x107001f, caps=0x12cf
> [    6.015804] ufshcd-qcom 624000.ufshc: quirks=0x20, dev. quirks=0x0
> [    6.024942] ufshcd-qcom 624000.ufshc: clk: core_clk_src, rate: 200000000
> [    6.031064] ufshcd-qcom 624000.ufshc: clk: core_clk_unipro_src,
> rate: 300000000
> [    6.037960] host_regs: 00000000: 0107001f 00000000 00010100 00000000
> [    6.044956] host_regs: 00000010: 01000000 00010217 00000000 00000000
> [    6.051547] host_regs: 00000020: 00000000 00000470 00000000 00000000
> [    6.057899] host_regs: 00000030: 00000000 00000001 00000000 00000000
> [    6.064277] host_regs: 00000040: 00000000 00000000 00000000 00000000
> [    6.070673] host_regs: 00000050: 00000000 00000000 00000000 00000000
> [    6.076894] host_regs: 00000060: 00000000 00000000 00000000 00000000
> [    6.083237] host_regs: 00000070: 00000000 00000000 00000000 00000000
> [    6.089586] host_regs: 00000080: 00000000 00000000 00000000 00000000
> [    6.095906] host_regs: 00000090: 00000016 00000000 00000000 00000000
> [    6.102258] ufshcd-qcom 624000.ufshc: No record of pa_err
> [    6.108571] ufshcd-qcom 624000.ufshc: No record of dl_err
> [    6.113865] ufshcd-qcom 624000.ufshc: No record of nl_err
> [    6.119246] ufshcd-qcom 624000.ufshc: No record of tl_err
> [    6.124627] ufshcd-qcom 624000.ufshc: No record of dme_err
> [    6.130010] ufshcd-qcom 624000.ufshc: No record of auto_hibern8_err
> [    6.135396] ufshcd-qcom 624000.ufshc: No record of fatal_err
> [    6.141558] ufshcd-qcom 624000.ufshc: link_startup_fail[0] =
> 0xffffff92 at 5937130 us
> [    6.147473] ufshcd-qcom 624000.ufshc: link_startup_fail: total cnt=1
> [    6.155187] ufshcd-qcom 624000.ufshc: No record of resume_fail
> [    6.161608] ufshcd-qcom 624000.ufshc: No record of suspend_fail
> [    6.167252] ufshcd-qcom 624000.ufshc: No record of wlun resume_fail
> [    6.173070] ufshcd-qcom 624000.ufshc: No record of wlun suspend_fail
> [    6.179322] ufshcd-qcom 624000.ufshc: No record of dev_reset
> [    6.185915] ufshcd-qcom 624000.ufshc: No record of host_reset
> [    6.191557] ufshcd-qcom 624000.ufshc: No record of task_abort
> [    6.197222] HCI Vendor Specific Registers 00000000: 000000c8
> 00000000 00000000 00000000
> [    6.202944] HCI Vendor Specific Registers 00000010: 00000000
> 00000000 00000000 5c5c052c
> [    6.210755] HCI Vendor Specific Registers 00000020: 3f0113ff
> 20020000 00000007 00000000
> [    6.218743] HCI Vendor Specific Registers 00000030: 00000000
> 00000000 02500000 00000000
> [    6.226748] UFS_UFS_DBG_RD_REG_OCSC 00000000: 00000000 00000000
> 00000000 00000000
> [    6.234712] UFS_UFS_DBG_RD_REG_OCSC 00000010: 00000000 00000000
> 00000000 00000000
> [    6.242349] UFS_UFS_DBG_RD_REG_OCSC 00000020: 00000000 00000000
> 00000000 00000000
> [    6.249815] UFS_UFS_DBG_RD_REG_OCSC 00000030: 00000000 00000000
> 00000000 00000000
> [    6.257282] UFS_UFS_DBG_RD_REG_OCSC 00000040: 00000000 00000000
> 00000000 00000000
> [    6.264746] UFS_UFS_DBG_RD_REG_OCSC 00000050: 00000000 00000000
> 00000000 00000000
> [    6.272228] UFS_UFS_DBG_RD_REG_OCSC 00000060: 00000000 00000000
> 00000000 00000000
> [    6.279675] UFS_UFS_DBG_RD_REG_OCSC 00000070: 00000000 00000000
> 00000000 00000000
> [    6.287141] UFS_UFS_DBG_RD_REG_OCSC 00000080: 00000000 00000000
> 00000000 00000000
> [    6.294608] UFS_UFS_DBG_RD_REG_OCSC 00000090: 00000000 00000000
> 00000000 00000000
> [    6.302069] UFS_UFS_DBG_RD_REG_OCSC 000000a0: 00000000 00000000
> 00000000 00000000
> [    6.309557] UFS_UFS_DBG_RD_EDTL_RAM 00000000: 00000000 a4491e48
> fcf4caf8 46ff663f
> [    6.317002] UFS_UFS_DBG_RD_EDTL_RAM 00000010: 3495a3c2 7be92e99
> 2334e629 a9f5cf7a
> [    6.324478] UFS_UFS_DBG_RD_EDTL_RAM 00000020: e0edb246 e551c5b7
> d060df83 c84da5e6
> [    6.331935] UFS_UFS_DBG_RD_EDTL_RAM 00000030: 59e307b2 f6855da2
> 3d0484ee 33b4d9d9
> [    6.339410] UFS_UFS_DBG_RD_EDTL_RAM 00000040: 4de326b3 5ba15f50
> 50c13d42 ca1e97e5
> [    6.346863] UFS_UFS_DBG_RD_EDTL_RAM 00000050: 4cf00e3d b54c986e
> 0755044b e235db57
> [    6.354346] UFS_UFS_DBG_RD_EDTL_RAM 00000060: b92c1aeb 281dc88f
> 76ff1877 3307093a
> [    6.361795] UFS_UFS_DBG_RD_EDTL_RAM 00000070: f8193d0a 222e4061
> d2cc6207 1fa596f9
> [    6.369341] UFS_UFS_DBG_RD_DESC_RAM 00000000: 00000fff 000245b9
> 40000fff 000245d7
> [    6.376725] UFS_UFS_DBG_RD_DESC_RAM 00000010: ad10cc60 00368847
> 151c412f 0038a520
> [    6.384223] UFS_UFS_DBG_RD_DESC_RAM 00000020: 0c0d244a 0036774c
> 027721d1 00145503
> [    6.391659] UFS_UFS_DBG_RD_DESC_RAM 00000030: ec11c082 00357203
> 74e1d006 000d8511
> [    6.399122] UFS_UFS_DBG_RD_DESC_RAM 00000040: c54067b1 0029bc16
> e7e164f6 00053070
> [    6.406588] UFS_UFS_DBG_RD_DESC_RAM 00000050: a0c0bff6 002a0367
> 4a35b6ca 0021a240
> [    6.414051] UFS_UFS_DBG_RD_DESC_RAM 00000060: 085b1f23 002c64ef
> 73820a12 0010ef31
> [    6.421515] UFS_UFS_DBG_RD_DESC_RAM 00000070: 69029047 00190510
> 6046fb03 0026f328
> [    6.428981] UFS_UFS_DBG_RD_DESC_RAM 00000080: 329031b4 0010e6fa
> 17914504 00109484
> [    6.436447] UFS_UFS_DBG_RD_DESC_RAM 00000090: 26d10045 001c14dc
> 5503fb3d 00040c95
> [    6.443913] UFS_UFS_DBG_RD_DESC_RAM 000000a0: 90445642 003122f0
> f74a51e5 002c0765
> [    6.451384] UFS_UFS_DBG_RD_DESC_RAM 000000b0: c1581085 00124fc2
> 79137305 0024c227
> [    6.458844] UFS_UFS_DBG_RD_DESC_RAM 000000c0: 65b22114 003b9a58
> 61d01770 000ab182
> [    6.466308] UFS_UFS_DBG_RD_DESC_RAM 000000d0: d4096375 00169e4c
> 1a0477b6 00064615
> [    6.473773] UFS_UFS_DBG_RD_DESC_RAM 000000e0: 232840aa 001c5490
> 14cd840d 000a2944
> [    6.481240] UFS_UFS_DBG_RD_DESC_RAM 000000f0: 8a228d09 00041b11
> d0241490 00064e1b
> [    6.488704] UFS_UFS_DBG_RD_DESC_RAM 00000100: 1a0f6846 000282d1
> 06118e46 00102644
> [    6.496169] UFS_UFS_DBG_RD_DESC_RAM 00000110: b6669e01 00052b38
> 1720792c 000c3156
> [    6.503634] UFS_UFS_DBG_RD_DESC_RAM 00000120: 0641cf61 000997fd
> 7c900815 0004ad50
> [    6.511099] UFS_UFS_DBG_RD_DESC_RAM 00000130: 1ef37280 00244c4d
> 3bb119d0 00286f65
> [    6.518565] UFS_UFS_DBG_RD_DESC_RAM 00000140: db9c09e5 0028c2e7
> 5b5d1df6 0031d8dd
> [    6.526029] UFS_UFS_DBG_RD_DESC_RAM 00000150: ca1d1166 00036152
> d8641112 001ac503
> [    6.533494] UFS_UFS_DBG_RD_DESC_RAM 00000160: 8d429104 0038dc61
> cb6e324b 00311563
> [    6.540960] UFS_UFS_DBG_RD_DESC_RAM 00000170: 4438455a 003d4061
> 68596183 001749bf
> [    6.548426] UFS_UFS_DBG_RD_DESC_RAM 00000180: 781e7129 00249c1f
> 10192822 0002c85c
> [    6.555891] UFS_UFS_DBG_RD_DESC_RAM 00000190: 16c0c0fb 000296c5
> 3126c8d6 00345830
> [    6.563357] UFS_UFS_DBG_RD_DESC_RAM 000001a0: 1461e741 00384181
> 46a04712 00113eee
> [    6.570822] UFS_UFS_DBG_RD_DESC_RAM 000001b0: 2b8332c4 00070e4e
> 3c00b95f 002afa6c
> [    6.578296] UFS_UFS_DBG_RD_DESC_RAM 000001c0: bc8c71c9 002b0d96
> 0d1b0097 00061d0c
> [    6.585752] UFS_UFS_DBG_RD_DESC_RAM 000001d0: 5da4850f 002aa5dd
> 7cea0d59 0000bf25
> [    6.593218] UFS_UFS_DBG_RD_DESC_RAM 000001e0: 400040a0 00080408
> 66249825 002106cb
> [    6.600682] UFS_UFS_DBG_RD_DESC_RAM 000001f0: e6831b0d 0010a590
> 646e0397 00042a16
> [    6.608198] UFS_UFS_DBG_RD_PRDT_RAM 00000000: b6500000 0000916c
> cd401d62 00043550
> [    6.615614] UFS_UFS_DBG_RD_PRDT_RAM 00000010: 3037914c 0005a31f
> f5469fe9 00093259
> [    6.623079] UFS_UFS_DBG_RD_PRDT_RAM 00000020: 00040000 00000010
> 49470e15 000c2784
> [    6.630543] UFS_UFS_DBG_RD_PRDT_RAM 00000030: 3e63f4c4 000c5d99
> ff34178f 0009ebef
> [    6.638020] UFS_UFS_DBG_RD_PRDT_RAM 00000040: e6c207f6 0002ad55
> 58618cab 00049e17
> [    6.645473] UFS_UFS_DBG_RD_PRDT_RAM 00000050: e175022b 000cfcfb
> d98e1281 000dc9b2
> [    6.652941] UFS_UFS_DBG_RD_PRDT_RAM 00000060: 10000001 00000000
> 711494d2 000fe80b
> [    6.660405] UFS_UFS_DBG_RD_PRDT_RAM 00000070: 4814b1d8 000a0ca1
> 6dc32ecd 00000e54
> [    6.667870] UFS_UFS_DBG_RD_PRDT_RAM 00000080: 00000041 00000004
> e910c009 00018567
> [    6.675336] UFS_UFS_DBG_RD_PRDT_RAM 00000090: 62508d4d 0004eaa8
> 892dfb22 000cd259
> [    6.682803] UFS_UFS_DBG_RD_PRDT_RAM 000000a0: cd20c8e2 000a55a0
> 01816101 000f88ef
> [    6.690267] UFS_UFS_DBG_RD_PRDT_RAM 000000b0: c811a2b7 00050746
> 73310333 000b5b59
> [    6.697732] UFS_UFS_DBG_RD_PRDT_RAM 000000c0: 2c4841ec 000a3517
> b55c4bdf 00008308
> [    6.705205] UFS_UFS_DBG_RD_PRDT_RAM 000000d0: f16cc22f 0006193d
> f810d7ef 0005a2ef
> [    6.712662] UFS_UFS_DBG_RD_PRDT_RAM 000000e0: 48140178 0005912e
> 713db144 0000925e
> [    6.720128] UFS_UFS_DBG_RD_PRDT_RAM 000000f0: 1cd0a405 000ac1a0
> 60518a6b 000d3a4c
> [    6.727598] UFS_DBG_RD_REG_UAWM 00000000: 00000000 00000062 00000000 0001fec0
> [    6.735060] UFS_DBG_RD_REG_UARM 00000000: 00000000 00000001 00000011 00000001
> [    6.742196] UFS_DBG_RD_REG_TXUC 00000000: 00000000 00000000 00000000 00000000
> [    6.749291] UFS_DBG_RD_REG_TXUC 00000010: 00000000 00000000 00000000 00000000
> [    6.756410] UFS_DBG_RD_REG_TXUC 00000020: 00000000 00000000 00000000 00000000
> [    6.763527] UFS_DBG_RD_REG_TXUC 00000030: 00000000 00000000 00000000 00000000
> [    6.770644] UFS_DBG_RD_REG_TXUC 00000040: 00000000 00000000 00000000 00000000
> [    6.777762] UFS_DBG_RD_REG_TXUC 00000050: 00000000 00000000 00000000 00000000
> [    6.784880] UFS_DBG_RD_REG_TXUC 00000060: 00000000 00000000 00000000 00000000
> [    6.791998] UFS_DBG_RD_REG_TXUC 00000070: 00000000 00000000 00000000 00000000
> [    6.799117] UFS_DBG_RD_REG_TXUC 00000080: 00000000 00000000 00000000 00000000
> [    6.806234] UFS_DBG_RD_REG_TXUC 00000090: 00000000 00000000 00000000 00000000
> [    6.813353] UFS_DBG_RD_REG_TXUC 000000a0: 00000000 00000000 00000000 00000000
> [    6.820471] UFS_DBG_RD_REG_TXUC 000000b0: 00000001 00000040 00000000 00000004
> [    6.827604] UFS_DBG_RD_REG_RXUC 00000000: 00000000 00000001 00000000 00000004
> [    6.834716] UFS_DBG_RD_REG_RXUC 00000010: 00000000 00000000 00000000 00000000
> [    6.841825] UFS_DBG_RD_REG_RXUC 00000020: 00000000 00000000 00000000 00000000
> [    6.848943] UFS_DBG_RD_REG_RXUC 00000030: 00000000 00000000 00000000 00000000
> [    6.856060] UFS_DBG_RD_REG_RXUC 00000040: 00000000 00000000 00000000 00000000
> [    6.863178] UFS_DBG_RD_REG_RXUC 00000050: 00000000 00000000 00000000 00000001
> [    6.870347] UFS_DBG_RD_REG_RXUC 00000060: 00000040 00000000 00000004
> [    6.877424] UFS_DBG_RD_REG_DFC 00000000: 00000000 00000000 00000000 00000000
> [    6.883838] UFS_DBG_RD_REG_DFC 00000010: 00000000 00000000 00000000 00000000
> [    6.890869] UFS_DBG_RD_REG_DFC 00000020: 00000000 00000000 00000000 00000000
> [    6.897921] UFS_DBG_RD_REG_DFC 00000030: 00000000 00000000 00000000 00000000
> [    6.904934] UFS_DBG_RD_REG_DFC 00000040: ffffffff 00000000 00000000
> [    6.911978] UFS_DBG_RD_REG_TRLUT 00000000: 00000000 00000001
> 00000000 00000000
> [    6.917955] UFS_DBG_RD_REG_TRLUT 00000010: 00000000 00000000
> 00000000 00000000
> [    6.925246] UFS_DBG_RD_REG_TRLUT 00000020: 00000000 00000000
> 00000000 00000000
> [    6.932454] UFS_DBG_RD_REG_TRLUT 00000030: 00000000 00000000
> 00000000 00000000
> [    6.939668] UFS_DBG_RD_REG_TRLUT 00000040: 00000000 00000000
> 00000000 00000000
> [    6.946861] UFS_DBG_RD_REG_TRLUT 00000050: 00000000 00000000
> 00000000 00000000
> [    6.954067] UFS_DBG_RD_REG_TRLUT 00000060: 00000000 00000000
> 00000000 00000000
> [    6.961280] UFS_DBG_RD_REG_TRLUT 00000070: 00000000 00000000
> 00000000 00000000
> [    6.968477] UFS_DBG_RD_REG_TRLUT 00000080: 00000000 00000000
> [    6.975678] UFS_DBG_RD_REG_TMRLUT 00000000: 00000000 00000001
> 00000000 00000000
> [    6.981497] UFS_DBG_RD_REG_TMRLUT 00000010: 00000000 00000000
> 00000000 00000000
> [    6.988527] UFS_DBG_RD_REG_TMRLUT 00000020: 00000000
> [    7.003383] ------------[ cut here ]------------
> [    7.003439] gcc_ufs_axi_clk status stuck at 'off'
> [    7.003466] WARNING: CPU: 3 PID: 60 at
> drivers/clk/qcom/clk-branch.c:86 clk_branch_wait+0x140/0x158
> [    7.011712] Modules linked in:
> [    7.020537] CPU: 3 PID: 60 Comm: kworker/u11:0 Tainted: G     U
>          6.6.0-rc1-00002-gb4e13e1ae95e #1257
> [    7.023703] Hardware name: Qualcomm Technologies, Inc. DB820c (DT)
> [    7.033652] Workqueue: ufs_clk_gating_0 ufshcd_ungate_work
> [    7.039898] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    7.045371] pc : clk_branch_wait+0x140/0x158
> [    7.052223] lr : clk_branch_wait+0x140/0x158
> [    7.056738] sp : ffff8000833f3c30
> [    7.060984] x29: ffff8000833f3c30 x28: ffff800081d0b200 x27: 0000000000000000
> [    7.064218] x26: 0000000000000001 x25: ffff000081b318e8 x24: 000000019c366bfc
> [    7.071337] x23: ffff800081611c10 x22: 0000000000000001 x21: ffff800080624180
> [    7.078455] x20: 0000000000000000 x19: ffff800081e49738 x18: fffffffffffed120
> [    7.085572] x17: 3030303030203030 x16: 3030303030302030 x15: 0000000000000030
> [    7.092691] x14: 0000000000000000 x13: ffff800081d2b9f8 x12: 00000000000008e8
> [    7.099809] x11: 00000000000002f8 x10: ffff800081d88138 x9 : ffff800081d2b9f8
> [    7.106928] x8 : 00000000ffffefff x7 : ffff800081d839f8 x6 : 00000000000002f8
> [    7.114046] x5 : 000000000000bff4 x4 : 40000000fffff2f8 x3 : 0000000000000000
> [    7.121163] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000080db3200
> [    7.128282] Call trace:
> [    7.135372]  clk_branch_wait+0x140/0x158
> [    7.137637]  clk_branch2_enable+0x30/0x40
> [    7.141806]  clk_core_enable+0xd0/0x264
> [    7.145709]  clk_enable+0x2c/0x4c
> [    7.149353]  ufshcd_setup_clocks+0x248/0x3cc
> [    7.152832]  ufshcd_ungate_work+0xc0/0x134
> [    7.157170]  process_one_work+0x1ec/0x51c
> [    7.161075]  worker_thread+0x1ec/0x3e4
> [    7.165154]  kthread+0x120/0x124
> [    7.168797]  ret_from_fork+0x10/0x20
> [    7.172186] irq event stamp: 1144
> [    7.175742] hardirqs last  enabled at (1143): [<ffff800080fa05c0>]
> _raw_spin_unlock_irq+0x30/0x64
> [    7.178987] hardirqs last disabled at (1144): [<ffff800080f96e08>]
> __schedule+0x7b0/0xc00
> [    7.187837] softirqs last  enabled at (1138): [<ffff800080090630>]
> __do_softirq+0x430/0x4e4
> [    7.195999] softirqs last disabled at (1133): [<ffff800080096154>]
> ____do_softirq+0x10/0x1c
> [    7.204158] ---[ end trace 0000000000000000 ]---
> [    7.212642] ufshcd-qcom 624000.ufshc: ufshcd_setup_clocks: core_clk
> prepare enable failed, -16
> 
> 
>> ---
>>   drivers/ufs/host/ufs-qcom.c | 51 ++++++++++++++++++++++---------------
>>   drivers/ufs/host/ufs-qcom.h |  1 +
>>   2 files changed, 31 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>> index d846e68a5734..b2be9ff272a4 100644
>> --- a/drivers/ufs/host/ufs-qcom.c
>> +++ b/drivers/ufs/host/ufs-qcom.c
>> @@ -93,8 +93,7 @@ static const struct __ufs_qcom_bw_table {
>>   static struct ufs_qcom_host *ufs_qcom_hosts[MAX_UFS_QCOM_HOSTS];
>>
>>   static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
>> -static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
>> -                                                      u32 clk_cycles);
>> +static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba, bool is_scale_up);
>>
>>   static struct ufs_qcom_host *rcdev_to_ufs_host(struct reset_controller_dev *rcd)
>>   {
>> @@ -685,14 +684,11 @@ static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
>>                          return -EINVAL;
>>                  }
>>
>> -               if (ufs_qcom_cap_qunipro(host))
>> -                       /*
>> -                        * set unipro core clock cycles to 150 & clear clock
>> -                        * divider
>> -                        */
>> -                       err = ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(hba,
>> -                                                                         150);
>> -
>> +               if (ufs_qcom_cap_qunipro(host)) {
>> +                       err = ufs_qcom_set_core_clk_ctrl(hba, true);
>> +                       if (err)
>> +                               dev_err(hba->dev, "cfg core clk ctrl failed\n");
>> +               }
>>                  /*
>>                   * Some UFS devices (and may be host) have issues if LCC is
>>                   * enabled. So we are setting PA_Local_TX_LCC_Enable to 0
>> @@ -1296,12 +1292,25 @@ static void ufs_qcom_exit(struct ufs_hba *hba)
>>          phy_exit(host->generic_phy);
>>   }
>>
>> -static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
>> -                                                      u32 clk_cycles)
>> +static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba, bool is_scale_up)
>>   {
>>          struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>> -       int err;
>> +       struct list_head *head = &hba->clk_list_head;
>> +       struct ufs_clk_info *clki;
>> +       u32 cycles_in_1us;
>>          u32 core_clk_ctrl_reg;
>> +       int err;
>> +
>> +       list_for_each_entry(clki, head, list) {
>> +               if (!IS_ERR_OR_NULL(clki->clk) &&
>> +                       !strcmp(clki->name, "core_clk_unipro")) {
>> +                       if (is_scale_up)
>> +                               cycles_in_1us = ceil(clki->max_freq, (1000 * 1000));
>> +                       else
>> +                               cycles_in_1us = ceil(clk_get_rate(clki->clk), (1000 * 1000));
>> +                       break;
>> +               }
>> +       }
>>
>>          err = ufshcd_dme_get(hba,
>>                              UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
>> @@ -1311,15 +1320,15 @@ static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
>>
>>          /* Bit mask is different for UFS host controller V4.0.0 onwards */
>>          if (host->hw_ver.major >= 4) {
>> -               if (!FIELD_FIT(CLK_1US_CYCLES_MASK_V4, clk_cycles))
>> +               if (!FIELD_FIT(CLK_1US_CYCLES_MASK_V4, cycles_in_1us))
>>                          return -ERANGE;
>>                  core_clk_ctrl_reg &= ~CLK_1US_CYCLES_MASK_V4;
>> -               core_clk_ctrl_reg |= FIELD_PREP(CLK_1US_CYCLES_MASK_V4, clk_cycles);
>> +               core_clk_ctrl_reg |= FIELD_PREP(CLK_1US_CYCLES_MASK_V4, cycles_in_1us);
>>          } else {
>> -               if (!FIELD_FIT(CLK_1US_CYCLES_MASK, clk_cycles))
>> +               if (!FIELD_FIT(CLK_1US_CYCLES_MASK, cycles_in_1us))
>>                          return -ERANGE;
>>                  core_clk_ctrl_reg &= ~CLK_1US_CYCLES_MASK;
>> -               core_clk_ctrl_reg |= FIELD_PREP(CLK_1US_CYCLES_MASK, clk_cycles);
>> +               core_clk_ctrl_reg |= FIELD_PREP(CLK_1US_CYCLES_MASK, cycles_in_1us);
>>          }
>>
>>          /* Clear CORE_CLK_DIV_EN */
>> @@ -1343,8 +1352,8 @@ static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
>>          if (!ufs_qcom_cap_qunipro(host))
>>                  return 0;
>>
>> -       /* set unipro core clock cycles to 150 and clear clock divider */
>> -       return ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(hba, 150);
>> +       /* set unipro core clock attributes and clear clock divider */
>> +       return ufs_qcom_set_core_clk_ctrl(hba, true);
>>   }
>>
>>   static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
>> @@ -1379,8 +1388,8 @@ static int ufs_qcom_clk_scale_down_post_change(struct ufs_hba *hba)
>>          if (!ufs_qcom_cap_qunipro(host))
>>                  return 0;
>>
>> -       /* set unipro core clock cycles to 75 and clear clock divider */
>> -       return ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(hba, 75);
>> +       /* set unipro core clock attributes and clear clock divider */
>> +       return ufs_qcom_set_core_clk_ctrl(hba, false);
>>   }
>>
>>   static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
>> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
>> index 8a9d3dbec297..3c6ef1259af3 100644
>> --- a/drivers/ufs/host/ufs-qcom.h
>> +++ b/drivers/ufs/host/ufs-qcom.h
>> @@ -245,6 +245,7 @@ ufs_qcom_get_debug_reg_offset(struct ufs_qcom_host *host, u32 reg)
>>   #define ufs_qcom_is_link_off(hba) ufshcd_is_link_off(hba)
>>   #define ufs_qcom_is_link_active(hba) ufshcd_is_link_active(hba)
>>   #define ufs_qcom_is_link_hibern8(hba) ufshcd_is_link_hibern8(hba)
>> +#define ceil(freq, div) ((freq) % (div) == 0 ? ((freq)/(div)) : ((freq)/(div) + 1))
>>
>>   int ufs_qcom_testbus_config(struct ufs_qcom_host *host);
>>
>> --
>> 2.17.1
>>
> 
> 
