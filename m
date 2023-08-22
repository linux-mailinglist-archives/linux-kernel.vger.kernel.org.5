Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CD178408F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbjHVMRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbjHVMRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:17:15 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6E5CDA;
        Tue, 22 Aug 2023 05:17:07 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37M6nNZO003513;
        Tue, 22 Aug 2023 14:16:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=8ENWQxVlfQr3qVTiWllxpoMpJhThCEawgKlW0Xs1aHo=; b=FV
        k3OxfJT2GqTXmG4jDNDcDlucIRojpFKU0W4yTDnnhmsqaKTUhLYNVHkfsgvQF5Tl
        Vv1kPjnoQLfm0+FdmxPP5i47EWnBmK5caaNZvrmnV2SaF8JGogytMZbXMCZ71HQo
        B5AKbRW0csVo1bN2j+6kqMvEB9L4CZ/x0abU7i/P08zHzig0+jDbaYgzlrRXhY2S
        XwbIISurqwVYRDO9BSIKKwu3EuMbL5vpEkwtCE0J4uti0qAT548ZyBPkouU8iVHh
        TNjRAFP1Hhjrqju/ZMWqRU7fePRFXdvbPdEmfBqApJMzC+BMLcBdx7Ktn1x5MSl5
        OjMpTHivZbh4c+iHy2Iw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3smbvub7ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 14:16:42 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B3D8710004D;
        Tue, 22 Aug 2023 14:16:39 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9D98726A825;
        Tue, 22 Aug 2023 14:16:39 +0200 (CEST)
Received: from [10.201.22.206] (10.201.22.206) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 22 Aug
 2023 14:16:36 +0200
Message-ID: <a2de9e15-9640-9b72-9df4-7e1ee3054dd9@foss.st.com>
Date:   Tue, 22 Aug 2023 14:16:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] remoteproc: imx_dsp_rproc: add module parameter to
 ignore ready flag from remote processor
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
CC:     "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>, linux-imx <linux-imx@nxp.com>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
References: <20230712224251.26482-1-iuliana.prodan@oss.nxp.com>
 <ZLV7q9ipDaw4b1Hi@p14s> <6fe5691f-67f4-ff70-8350-b4b6c08097b0@nxp.com>
 <ZLa0MqKvg1W3mx/7@p14s> <86da3550-9711-6714-0857-2f7611dc9453@nxp.com>
 <ZLgFiW+IH3m4MWLw@p14s>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <ZLgFiW+IH3m4MWLw@p14s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.22.206]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_11,2023-08-22_01,2023-05-22_02
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juliana

On 7/19/23 17:47, Mathieu Poirier wrote:
> On Tue, Jul 18, 2023 at 07:44:49PM +0300, Iuliana Prodan wrote:
>> On 7/18/2023 6:48 PM, Mathieu Poirier wrote:
>>> On Tue, Jul 18, 2023 at 11:30:43AM +0300, Iuliana Prodan wrote:
>>>> Hi Mathieu,
>>>>
>>>> On 7/17/2023 8:34 PM, Mathieu Poirier wrote:
>>>>> Hi Iuliana,
>>>>>
>>>>> On Thu, Jul 13, 2023 at 01:42:51AM +0300, Iuliana Prodan (OSS) wrote:
>>>>>> From: Iuliana Prodan <iuliana.prodan@nxp.com>
>>>>>>
>>>>>> There are cases when we want to test samples that do not
>>>>>> reply with FW READY message, after fw is loaded and the
>>>>>> remote processor started.
>>>>> This seems like a bug to me - where is this FW comes from?
>>>> The firmware is a generic sample from Zephyr repo: https://github.com/zephyrproject-rtos/zephyr/tree/main/samples/subsys/ipc/openamp_rsc_table
>>>>
>>>> There is no bug, this is how the application was written.
>>> But how did it ever worked before?
>>
>> It never worked on this kind of samples (and it was never tested like this).
>> We used only applications written by us (NXP) with the
>> requirements/limitations we know we have.
>> Now, we want to use also generic firmware/samples (from Zephyr) and we face
>> other kind of limitations.

It makes sense to me to adapt the sample in Zephyr to add this synchronization
under a config flag (I am the author of this sample).

FYI, this sample is currently only running on the STM32MP15 boards for
communication with Linux. For these boards, there is no need for synchronization
before starting the IPC communication.
So extending the sample to support a second board will make it more generic :)

Regards,
Arnaud

>>
> 
> Right, we can't expect firmware written for a totally different OS to work out
> of the box on Linux, and vice versa.
> 
>>>   And how does having a module flag to
>>> characterize each FW implementation that springs up in the field can scale (and
>>> be maintainable)?
>>
>> I believe the FW_READY reply is a limitation introduced by imx_dsp_rproc.
>> We cannot expect all firmware to give a FW_READY reply.
>> So, to keep both usecases (internal firmware and generic sample) I added
>> this flag.
>>
> 
> What happens when a third, fourth and fifth protocol variation get introduced?
> Adding flags just doesn't scale.
> 
>>>> Rather than modifying a generic sample for i.MX usecase, I prefer doing an
>>>> "insmod imx_dsp_rproc.ko ignore_dsp_ready=1" just for this sample.
>>> We already have a "no_mailbox" flag for cases where the FW doesn't need to
>>> communicate with the main processor.
>> "no_mailbox" - no IPC between cores;
>> "ignore_dsp_ready" - we have IPC between cores, but the remote processor
>> doesn't send a fw_ready reply
>> These two can be combine, but for "no_mailbox" will do some useless memory
>> allocations.
>>
>> When I added the "no_mailbox" flag, the problem was still FW_READY.
>>>   What happens when some FW implementation
>>> requires a three-way handshake?  How many flags do we spin off?
>>>
>>> As I said above this approach is not sustainable.  I suggest to either fix the
>>> FW (it doesn't work with upstream in its present form anyway) or start using the
>>> config space as described here [1] to dynamically probe the characteristics of
>>> the FW being loaded.  Whichever option you chose, the FW needs to be updated and
>>> the former is a lot more simple.
>> I don't think I can modify a generic sample, used on other targets to send a
>> FW_READY reply.
>> How will it be handled on other platforms, if their *_rproc are not
>> expecting this kind of message?
>>
> 
> The only way forward is to come up with a standard specification to describe the
> protocol to use, the same way it is done for virtIO for example.
> 
>> Thanks,
>> Iulia
>>
>>> Thanks,
>>> Mathieu
>>>
>>> [1]. https://elixir.bootlin.com/linux/latest/source/include/linux/remoteproc.h#L298
>>>
>>>> Thanks,
>>>> Iulia
>>>>
>>>>>> In these cases, do not wait for a confirmation from the remote processor
>>>>>> at start.
>>>>>>
>>>>>> Added "ignore_dsp_ready" flag while inserting the module to ignore
>>>>>> remote processor reply after start.
>>>>>> By default, this is off - do not ignore reply from rproc.
>>>>>>
>>>>>> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
>>>>>>
>>>>>> ---
>>>>>> This was discovered while testing openamp_rsc_table sample from Zephyr
>>>>>> repo (https://github.com/zephyrproject-rtos/zephyr/tree/main/samples/subsys/ipc/openamp_rsc_table).
>>>>>>
>>>>>> We have IPC, but the remote proc doesn't send a FW_READY reply.
>>>>>> ---
>>>>>>    drivers/remoteproc/imx_dsp_rproc.c | 15 +++++++++++++++
>>>>>>    1 file changed, 15 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
>>>>>> index b5634507d953..ed89de2f3b98 100644
>>>>>> --- a/drivers/remoteproc/imx_dsp_rproc.c
>>>>>> +++ b/drivers/remoteproc/imx_dsp_rproc.c
>>>>>> @@ -36,7 +36,13 @@ module_param_named(no_mailboxes, no_mailboxes, int, 0644);
>>>>>>    MODULE_PARM_DESC(no_mailboxes,
>>>>>>    		 "There is no mailbox between cores, so ignore remote proc reply after start, default is 0 (off).");
>>>>>> +static unsigned int imx_dsp_rproc_ignore_ready;
>>>>>> +module_param_named(ignore_dsp_ready, imx_dsp_rproc_ignore_ready, int, 0644);
>>>>>> +MODULE_PARM_DESC(ignore_dsp_ready,
>>>>>> +		 "Ignore remote proc reply after start, default is 0 (off).");
>>>>>> +
>>>>>>    #define REMOTE_IS_READY				BIT(0)
>>>>>> +#define REMOTE_IGNORE_READY_REPLY	BIT(1)
>>>>>>    #define REMOTE_READY_WAIT_MAX_RETRIES		500
>>>>>>    /* att flags */
>>>>>> @@ -296,6 +302,12 @@ static int imx_dsp_rproc_ready(struct rproc *rproc)
>>>>>>    	if (!priv->rxdb_ch)
>>>>>>    		return 0;
>>>>>> +	/*
>>>>>> +	 * FW_READY reply is optional/ignored, so don't wait for it.
>>>>>> +	 */
>>>>>> +	if (priv->flags & REMOTE_IGNORE_READY_REPLY)
>>>>>> +		return 0;
>>>>>> +
>>>>>>    	for (i = 0; i < REMOTE_READY_WAIT_MAX_RETRIES; i++) {
>>>>>>    		if (priv->flags & REMOTE_IS_READY)
>>>>>>    			return 0;
>>>>>> @@ -1119,6 +1131,9 @@ static int imx_dsp_rproc_probe(struct platform_device *pdev)
>>>>>>    	else
>>>>>>    		imx_dsp_rproc_mbox_init = imx_dsp_rproc_mbox_alloc;
>>>>>> +	if (imx_dsp_rproc_ignore_ready)
>>>>>> +		priv->flags |= REMOTE_IGNORE_READY_REPLY;
>>>>>> +
>>>>>>    	dev_set_drvdata(dev, rproc);
>>>>>>    	INIT_WORK(&priv->rproc_work, imx_dsp_rproc_vq_work);
>>>>>> -- 
>>>>>> 2.17.1
>>>>>>
