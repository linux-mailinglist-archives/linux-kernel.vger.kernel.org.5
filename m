Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BD777517D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 05:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjHIDnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 23:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjHIDnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 23:43:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32478172C;
        Tue,  8 Aug 2023 20:43:04 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3792Rmek028364;
        Wed, 9 Aug 2023 03:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EZwL1OZWKa7WNjLNNJztldfRpqKSawPucwF116OOY+g=;
 b=mHNCT6xBVY+wYftM0jc8a/Jrxa0NPb5W7BzAqAsuM+hnw7HOjSNy/eT+nXcluAYsiMXV
 lyJ+HlvravdfVLmL9sUpcsieUb0CAB1KV3Z0gNqqJz44VyHG38arPRsyI3ewPMgFVHzI
 gpm3yZaf8ltZ44p7XeSxqG8mxCHbMOHl/r8D7CQKW/cgD9GGX8h/9yGxBYpQsKCPGV9U
 wF4acKcqvF7OB8OrKli9jc/VMiQlSrMo79GSwaQggybCEnUVUWkyMNC/AMggkVBXu+PU
 h/JI7QBF5AIBmQULgeHUAPK3nStf981tGzXM4y80xgig6m29fYUGCI+6qQY3+G5uN1NX TA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sb6jbu8x2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 03:42:45 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3793giud024869
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Aug 2023 03:42:44 GMT
Received: from [10.253.13.91] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 8 Aug
 2023 20:42:42 -0700
Message-ID: <e3a206e7-f36b-d896-20f7-4e35b9743c1d@quicinc.com>
Date:   Wed, 9 Aug 2023 11:42:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] bus: mhi: host: pci_generic: Add SDX75 based modem
 support
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <quic_jhugo@quicinc.com>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_cang@quicinc.com>, <quic_mrana@quicinc.com>
References: <1691460215-45383-1-git-send-email-quic_qianyu@quicinc.com>
 <20230808075103.GD4990@thinkpad>
 <be205d43-b558-47eb-0250-b7415474b6e9@quicinc.com>
 <20230808105928.GF4990@thinkpad>
From:   Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <20230808105928.GF4990@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yjzTIR6LPHviAaIt0Z8-zrjXOtJvlddN
X-Proofpoint-GUID: yjzTIR6LPHviAaIt0Z8-zrjXOtJvlddN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_24,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090031
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/8/2023 6:59 PM, Manivannan Sadhasivam wrote:
> On Tue, Aug 08, 2023 at 04:53:32PM +0800, Qiang Yu wrote:
>> On 8/8/2023 3:51 PM, Manivannan Sadhasivam wrote:
>>> On Tue, Aug 08, 2023 at 10:03:35AM +0800, Qiang Yu wrote:
>>>> Add generic info for SDX75 based modems. SDX75 takes longer than expected
>>>> (default, 8 seconds) to set ready after reboot. Hence add optional ready
>>>> timeout parameter to wait enough for device ready as part of power up
>>>> sequence.
>>>>
>>>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>>>> ---
>>>>    drivers/bus/mhi/host/init.c        |  1 +
>>>>    drivers/bus/mhi/host/main.c        |  7 ++++++-
>>>>    drivers/bus/mhi/host/pci_generic.c | 22 ++++++++++++++++++++++
>>>>    drivers/bus/mhi/host/pm.c          |  6 +++++-
>>>>    include/linux/mhi.h                |  4 ++++
>>>>    5 files changed, 38 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
>>>> index f78aefd..65ceac1 100644
>>>> --- a/drivers/bus/mhi/host/init.c
>>>> +++ b/drivers/bus/mhi/host/init.c
>>>> @@ -881,6 +881,7 @@ static int parse_config(struct mhi_controller *mhi_cntrl,
>>>>    	if (!mhi_cntrl->timeout_ms)
>>>>    		mhi_cntrl->timeout_ms = MHI_TIMEOUT_MS;
>>>> +	mhi_cntrl->ready_timeout_ms = config->ready_timeout_ms;
>>>>    	mhi_cntrl->bounce_buf = config->use_bounce_buf;
>>>>    	mhi_cntrl->buffer_len = config->buf_len;
>>>>    	if (!mhi_cntrl->buffer_len)
>>>> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
>>>> index 74a7543..8590926 100644
>>>> --- a/drivers/bus/mhi/host/main.c
>>>> +++ b/drivers/bus/mhi/host/main.c
>>>> @@ -43,8 +43,13 @@ int __must_check mhi_poll_reg_field(struct mhi_controller *mhi_cntrl,
>>>>    				    u32 mask, u32 val, u32 delayus)
>>>>    {
>>>>    	int ret;
>>>> -	u32 out, retry = (mhi_cntrl->timeout_ms * 1000) / delayus;
>>>> +	u32 out, retry;
>>>> +	u32 timeout_ms = mhi_cntrl->timeout_ms;
>>>> +	if (mhi_cntrl->ready_timeout_ms && mask == MHISTATUS_READY_MASK)
>>>> +		timeout_ms = mhi_cntrl->ready_timeout_ms;
>>> Instead of handling the timeout inside mhi_poll_reg_field(), you should pass the
>>> appropriate timeout value to this function.
>> OK, will do.
>>>> +
>>>> +	retry = (timeout_ms * 1000) / delayus;
>>>>    	while (retry--) {
>>>>    		ret = mhi_read_reg_field(mhi_cntrl, base, offset, mask, &out);
>>>>    		if (ret)
>>>> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
>>>> index fcd80bc..9c601f0 100644
>>>> --- a/drivers/bus/mhi/host/pci_generic.c
>>>> +++ b/drivers/bus/mhi/host/pci_generic.c
>>>> @@ -269,6 +269,16 @@ static struct mhi_event_config modem_qcom_v1_mhi_events[] = {
>>>>    	MHI_EVENT_CONFIG_HW_DATA(5, 2048, 101)
>>>>    };
>>>> +static const struct mhi_controller_config modem_qcom_v2_mhiv_config = {
>>>> +	.max_channels = 128,
>>>> +	.timeout_ms = 8000,
>>>> +	.ready_timeout_ms = 50000,
>>>> +	.num_channels = ARRAY_SIZE(modem_qcom_v1_mhi_channels),
>>>> +	.ch_cfg = modem_qcom_v1_mhi_channels,
>>>> +	.num_events = ARRAY_SIZE(modem_qcom_v1_mhi_events),
>>>> +	.event_cfg = modem_qcom_v1_mhi_events,
>>>> +};
>>>> +
>>>>    static const struct mhi_controller_config modem_qcom_v1_mhiv_config = {
>>>>    	.max_channels = 128,
>>>>    	.timeout_ms = 8000,
>>>> @@ -278,6 +288,16 @@ static const struct mhi_controller_config modem_qcom_v1_mhiv_config = {
>>>>    	.event_cfg = modem_qcom_v1_mhi_events,
>>>>    };
>>>> +static const struct mhi_pci_dev_info mhi_qcom_sdx75_info = {
>>>> +	.name = "qcom-sdx75m",
>>>> +	.fw = "qcom/sdx75m/xbl.elf",
>>>> +	.edl = "qcom/sdx75m/edl.mbn",
>>>> +	.config = &modem_qcom_v2_mhiv_config,
>>>> +	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>>>> +	.dma_data_width = 32,
>>>> +	.sideband_wake = false,
>>>> +};
>>>> +
>>>>    static const struct mhi_pci_dev_info mhi_qcom_sdx65_info = {
>>>>    	.name = "qcom-sdx65m",
>>>>    	.fw = "qcom/sdx65m/xbl.elf",
>>>> @@ -597,6 +617,8 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>>>>    		.driver_data = (kernel_ulong_t) &mhi_telit_fn990_info },
>>>>    	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0308),
>>>>    		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx65_info },
>>>> +	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0309),
>>>> +		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx75_info },
>>>>    	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x1001), /* EM120R-GL (sdx24) */
>>>>    		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
>>>>    	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x1002), /* EM160R-GL (sdx24) */
>>>> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
>>>> index 8a4362d..6f049e0 100644
>>>> --- a/drivers/bus/mhi/host/pm.c
>>>> +++ b/drivers/bus/mhi/host/pm.c
>>>> @@ -1202,14 +1202,18 @@ EXPORT_SYMBOL_GPL(mhi_power_down);
>>>>    int mhi_sync_power_up(struct mhi_controller *mhi_cntrl)
>>>>    {
>>>>    	int ret = mhi_async_power_up(mhi_cntrl);
>>>> +	u32 timeout_ms;
>>>>    	if (ret)
>>>>    		return ret;
>>>> +	/* Some devices need more time to set ready during power up */
>>>> +	timeout_ms = mhi_cntrl->ready_timeout_ms ?
>>>> +		mhi_cntrl->ready_timeout_ms : mhi_cntrl->timeout_ms;
>>> Since you are using this extended timeout value in a couple of places (not just
>>> for checking READY_STATE), it is better to use the existing "timeout_ms"
>>> parameter.
>>>
>>> - Mani
>> We use ready_timeout_ms here is because READY_STATE is polled in a
>> workqueue,  in parallel with waiting valid EE.
>>
>> That means we start to wait valid EE and poll ready like at same time
>> instead of starting to wait EE after ready state.
>>
>> Thus the total time it takes to wait valid EE is about the time for polling
>> ready.
>>
> Yes, but why can't you still increase "timeout_ms" for SDX75 and use the same?
>
> Btw, please do not send another version while the discussion is going on for the
> current one.
>
> - Mani

SDX75 only needs 50 seconds when setting ready for the first time after 
power on. Other state transitions

is expected to wait only 8 seconds. If we use 50s for every state 
transition, it's OK but not friendly in some cases.


For example, host is resuming from suspend, but device has already 
crashed and tansferred to Sahara mode when

in suspended state. Thus host must wait M0 event timeout, and then 
reinit mhi and tranfer to SBL state in recovery

process. If we set mhi_cntrl->timeout_ms=50s, we have to wait 50s to 
collect crash dump after seeing resume fail log.

>
>>>>    	wait_event_timeout(mhi_cntrl->state_event,
>>>>    			   MHI_IN_MISSION_MODE(mhi_cntrl->ee) ||
>>>>    			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
>>>> -			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
>>>> +			   msecs_to_jiffies(timeout_ms));
>>>>    	ret = (MHI_IN_MISSION_MODE(mhi_cntrl->ee)) ? 0 : -ETIMEDOUT;
>>>>    	if (ret)
>>>> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
>>>> index f6de4b6..a43e5f8 100644
>>>> --- a/include/linux/mhi.h
>>>> +++ b/include/linux/mhi.h
>>>> @@ -266,6 +266,7 @@ struct mhi_event_config {
>>>>     * struct mhi_controller_config - Root MHI controller configuration
>>>>     * @max_channels: Maximum number of channels supported
>>>>     * @timeout_ms: Timeout value for operations. 0 means use default
>>>> + * @ready_timeout_ms: Timeout value for waiting device to be ready (optional)
>>>>     * @buf_len: Size of automatically allocated buffers. 0 means use default
>>>>     * @num_channels: Number of channels defined in @ch_cfg
>>>>     * @ch_cfg: Array of defined channels
>>>> @@ -277,6 +278,7 @@ struct mhi_event_config {
>>>>    struct mhi_controller_config {
>>>>    	u32 max_channels;
>>>>    	u32 timeout_ms;
>>>> +	u32 ready_timeout_ms;
>>>>    	u32 buf_len;
>>>>    	u32 num_channels;
>>>>    	const struct mhi_channel_config *ch_cfg;
>>>> @@ -326,6 +328,7 @@ struct mhi_controller_config {
>>>>     * @pm_mutex: Mutex for suspend/resume operation
>>>>     * @pm_lock: Lock for protecting MHI power management state
>>>>     * @timeout_ms: Timeout in ms for state transitions
>>>> + * @ready_timeout_ms: Timeout in ms for waiting device to be ready (optional)
>>>>     * @pm_state: MHI power management state
>>>>     * @db_access: DB access states
>>>>     * @ee: MHI device execution environment
>>>> @@ -413,6 +416,7 @@ struct mhi_controller {
>>>>    	struct mutex pm_mutex;
>>>>    	rwlock_t pm_lock;
>>>>    	u32 timeout_ms;
>>>> +	u32 ready_timeout_ms;
>>>>    	u32 pm_state;
>>>>    	u32 db_access;
>>>>    	enum mhi_ee_type ee;
>>>> -- 
>>>> 2.7.4
>>>>
