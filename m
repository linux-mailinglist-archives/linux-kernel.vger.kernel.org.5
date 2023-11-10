Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E957E8176
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346141AbjKJS2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345983AbjKJSZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:25:55 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4D29EDB;
        Fri, 10 Nov 2023 00:29:46 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA7g9Tk031914;
        Fri, 10 Nov 2023 08:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=o/s3EjNezJkdXkm22u9E3o/s6+c0B+nKKcTpqa0GIBM=;
 b=XqGP30K94f5RN9Q6nHlvH1VV5THyGkFAI/blCLDNB1lWRIFqTNknHYV2T7rbem73Mg42
 r0FamySTTUeirMTrFlS1bYyWiK2m85Bow2kFv1YpbRvtcov4YHepZSB/Bm+IEP1P4fru
 sDi8AotKiG2tVPGSjvWalSp12KGV8AJhM4/LNz+ZbyTxCBNQ9y45UyU6W6a+9dI/ipFW
 6XPq6GJs3RMOeUTR/ni0yiuuLgsAlRRK4e5/+rK3axeEt2xiHklKY1hTSgAS5lZ7STQR
 Vbky9RMwethB3gOqWcQnGC2h4wlpveLyIXhYVtooomSWdrQHw/wcOKDH4p0DeDcDIkXf jA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u9f3k0aq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 08:29:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AA8TWov011741
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 08:29:32 GMT
Received: from [10.217.216.47] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 10 Nov
 2023 00:29:25 -0800
Message-ID: <dfc56206-6e8d-d932-6493-e74162855298@quicinc.com>
Date:   Fri, 10 Nov 2023 13:59:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RESEND v3 4/5] clk: qcom: Use HW_CTRL_TRIGGER flag to
 switch video GDSC to HW mode
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Taniya Das <tdas@qti.qualcomm.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-media@vger.kernel.org>
References: <20231101-gdsc-hwctrl-v3-0-0740ae6b2b04@linaro.org>
 <20231101-gdsc-hwctrl-v3-4-0740ae6b2b04@linaro.org>
 <835a6add-81e9-42e4-abbe-91632aaa6bc9@linaro.org>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <835a6add-81e9-42e4-abbe-91632aaa6bc9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: y-N3N2JGn_CwPfpScRTGPg7PPPUosQNE
X-Proofpoint-GUID: y-N3N2JGn_CwPfpScRTGPg7PPPUosQNE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_04,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311100071
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/2023 6:35 PM, Bryan O'Donoghue wrote:
> On 01/11/2023 09:04, Abel Vesa wrote:
>> From: Jagadeesh Kona <quic_jkona@quicinc.com>
>>
>> The current HW_CTRL flag switches the video GDSC to HW control mode as
>> part of GDSC enable itself, instead of that use HW_CTRL_TRIGGER flag to
>> give consumer drivers more control and switch the GDSC mode as and when
>> required.
>>
>> HW_CTRL_TRIGGER flag allows consumer drivers to switch the video GDSC to
>> HW/SW control modes at runtime using dev_pm_genpd_set_hwmode API.
>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>> ---
>>   drivers/clk/qcom/videocc-sc7180.c | 2 +-
>>   drivers/clk/qcom/videocc-sc7280.c | 2 +-
>>   drivers/clk/qcom/videocc-sdm845.c | 4 ++--
>>   drivers/clk/qcom/videocc-sm8250.c | 4 ++--
>>   drivers/clk/qcom/videocc-sm8550.c | 4 ++--
>>   5 files changed, 8 insertions(+), 8 deletions(-)
> 
> So.
> 
> I'm assuming the rest of this series works however for sc8250 at least 
> this is a NAK, breaks venus on rb5.
> 
> Reproduction:
> 
> - Debian trixie rb5
> - Linux 6.6-rc3 + this patch
> - Attached defconfig
> - This file:
>    https://download.samplelib.com/mp4/sample-30s.mp4
> - This command:
>    ffplay -loglevel debug -code:video h264_v4l2m2m -i sample-30s.mp4
> 
> Second play of file shows stuck gdsc as below
> 
> I didn't try on rb3, I'd expect similar results. Does this work on 8550 ?
> 
> [ 1601.581204] ------------[ cut here ]------------
> [ 1601.585983] mvs0_gdsc status stuck at 'off'
> [ 1601.586015] WARNING: CPU: 1 PID: 13372 at drivers/clk/qcom/gdsc.c:178 
> gdsc_toggle_logic+0x16c/0x174
> [ 1601.599627] Modules linked in: nf_tables libcrc32c nfnetlink 
> snd_soc_hdmi_codec q6asm_dai q6routing q6afe_dai q6asm q6adm 
> q6afe_clocks snd_q6dsp_common q6afe q6core apr pdr_interface venus_enc 
> venus_dec qcom_camss videobuf2_dma_contig mcp251xfd imx412 
> videobuf2_dma_sg venus_core xhci_plat_hcd v4l2_fwnode fastrpc xhci_hcd 
> can_dev qrtr_smd lontium_lt9611uxc msm v4l2_async v4l2_mem2mem 
> qcom_spmi_adc_tm5 rtc_pm8xxx qcom_spmi_adc5 qcom_pon videobuf2_memops 
> crct10dif_ce qcom_spmi_temp_alarm videobuf2_v4l2 qcom_vadc_common 
> gpu_sched drm_dp_aux_bus videodev snd_soc_sm8250 drm_display_helper 
> snd_soc_qcom_sdw videobuf2_common snd_soc_qcom_common qrtr i2c_qcom_cci 
> soundwire_qcom mc i2c_qcom_geni spi_geni_qcom phy_qcom_qmp_combo 
> qcom_q6v5_pas qcom_rng soundwire_bus qcom_pil_info 
> snd_soc_lpass_va_macro qcom_q6v5 slimbus snd_soc_lpass_macro_common 
> qcom_sysmon snd_soc_lpass_wsa_macro display_connector qcom_common 
> socinfo qcom_glink_smem qmi_helpers drm_kms_helper mdt_loader qcom_wdt 
> icc_osm_l3 qnoc_sm8250 fuse drm backlight dm_mod
> [ 1601.599859]  ip_tables x_tables
> [ 1601.695314] CPU: 1 PID: 13372 Comm: video_decoder Not tainted 
> 6.6.0-rc3-00396-gdbc0d9fa7641-dirty #1
> [ 1601.704694] Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
> [ 1601.711582] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS 
> BTYPE=--)
> [ 1601.718740] pc : gdsc_toggle_logic+0x16c/0x174
> [ 1601.723317] lr : gdsc_toggle_logic+0x16c/0x174
> [ 1601.727888] sp : ffff80008adab800
> [ 1601.731296] x29: ffff80008adab800 x28: ffffb661e8596210 x27: 
> ffffb661e855ad88
> [ 1601.738629] x26: 0000000000000000 x25: ffff100c0b5a0d28 x24: 
> ffffb6620fd92118
> [ 1601.745960] x23: ffffb6620fe1d3d8 x22: 0000000000000000 x21: 
> 0000000000000001
> [ 1601.753292] x20: 00000000ffffff92 x19: ffffb6620fd92118 x18: 
> ffffffffffc0d3e8
> [ 1601.760631] x17: 0000000000000000 x16: ffffb6620e269e14 x15: 
> 0000000000000028
> [ 1601.767973] x14: 0000000000000000 x13: ffff100d75c00000 x12: 
> 0000000000000894
> [ 1601.775304] x11: 00000000000002dc x10: ffff100d767044a0 x9 : 
> ffff100d75c00000
> [ 1601.782636] x8 : 00000000fffdffff x7 : ffff100d76700000 x6 : 
> 00000000000002dc
> [ 1601.789976] x5 : ffff100d7ef40d48 x4 : 40000000fffe02dc x3 : 
> ffff59ab6fa21000
> [ 1601.797306] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 
> ffff100cdacdec80
> [ 1601.804638] Call trace:
> [ 1601.807161]  gdsc_toggle_logic+0x16c/0x174
> [ 1601.811383]  gdsc_enable+0x60/0x27c
> [ 1601.814982]  _genpd_power_on+0x94/0x184
> [ 1601.818931]  genpd_power_on+0xa8/0x16c
> [ 1601.822791]  genpd_runtime_resume+0xd4/0x2a4
> [ 1601.827184]  __rpm_callback+0x48/0x1dc
> [ 1601.831045]  rpm_callback+0x6c/0x78
> [ 1601.834638]  rpm_resume+0x45c/0x6c8
> [ 1601.838231]  __pm_runtime_resume+0x4c/0x90
> [ 1601.842443]  coreid_power_v4+0x378/0x58c [venus_core]
> [ 1601.847695]  vdec_start_streaming+0xc0/0x4e8 [venus_dec]
> [ 1601.853169]  vb2_start_streaming+0x68/0x15c [videobuf2_common]
> [ 1601.859199]  vb2_core_streamon+0xf8/0x1bc [videobuf2_common]
> [ 1601.865032]  vb2_streamon+0x18/0x64 [videobuf2_v4l2]
> [ 1601.870174]  v4l2_m2m_ioctl_streamon+0x38/0x98 [v4l2_mem2mem]
> [ 1601.876134]  v4l_streamon+0x24/0x30 [videodev]
> [ 1601.880759]  __video_do_ioctl+0x15c/0x3c0 [videodev]
> [ 1601.885905]  video_usercopy+0x1f0/0x658 [videodev]
> [ 1601.890868]  video_ioctl2+0x18/0x28 [videodev]
> [ 1601.895481]  v4l2_ioctl+0x40/0x60 [videodev]
> [ 1601.899911]  __arm64_sys_ioctl+0xac/0xf0
> [ 1601.903958]  invoke_syscall+0x48/0x114
> [ 1601.907829]  el0_svc_common.constprop.0+0x40/0xe0
> [ 1601.912672]  do_el0_svc+0x1c/0x28
> [ 1601.916085]  el0_svc+0x40/0xe8
> [ 1601.919243]  el0t_64_sync_handler+0x100/0x12c
> [ 1601.923730]  el0t_64_sync+0x190/0x194
> [ 1601.927505] ---[ end trace 0000000000000000 ]---
> [ 1608.121533] ------------[ cut here ]------------
> 
> And just reverting the one patch - yields
> 
> [  157.083287] qcom-venus aa00000.video-codec: Failed to switch 
> power-domain:1 to SW mode
> [  162.004630] qcom-venus aa00000.video-codec: Failed to switch 
> power-domain:1 to SW mode
> 
> I'll leave the testing here. Please fix !
> 

Thanks Bryan for reporting this, this could be happening since GDSC 
might be left in HW control mode during power off sequence, so the 
subsequent GDSC enable is failing since GDSC is still in HW mode. I am 
checking internally on this and will get back.

Thanks,
Jagadeesh

> ---
> bod
