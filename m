Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9FA758259
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjGRQpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGRQo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:44:58 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C256118;
        Tue, 18 Jul 2023 09:44:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZY68w0ogdgHNBLoaPy41PslsTQHJKSR/LLB2eUEHscAnQ0K63cxOL0D3Tbzstxuc2tphm7aUA0mQuQ3p71FqGy8IukTonbdAqPlujCOyZAs18hH1DXvS3Kbc4FUDwnpjLpykTfhsw3ctDD2V9be9/YSqrDSKXBf+bsZ3ZEVQGdIE/9lK5WKZa90zWTxtGzEIfl3594uHe27XSQhL4xAnxBNRkO9gFyZWQE+Jteie86z9wjKi02IHnpuj17Bz+A17URBgBgx80e5FL6b+Gi4cr1fZVNeBUbs1uCwjqfF8YSRJ4Da4Slp/1LE68ucgek9BGidk9Zy+bEp1j1W9JUUU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KL2pM7pCBhZEtEzosJAbL6WHiil1Hv7z9Qkt/aN8GGo=;
 b=nxXDDUpN8O6cmXAxuCBw/lMgOksPbwnLRfFeeFtzdcMDyNDRMTw8qc9+AYng/eW4DWyKwogLFIyLwkz9mJpzP//9I/P89sKw2eAwpmfc97rmQcIsSbDcngKxlra4yWiotIE2LJk71Opybm9RLdv60IwkXgE0pVBJlKbmbbisDpI2OlrZvltRmWE5K/LlE//UIvMAWENjXDxZeuQqI8EOfSOvtgRrx4wNFKmEabdCiRbuihmD8MnwmuxG53+B35Hi5VpYPfW8wqJ2XFvrUVP92TtRPmGk0KYrrtPUcdXOLF51ahtiwp4u0NU4eOZa+A+Ygowswq+Q/UbPp0/UGouX9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KL2pM7pCBhZEtEzosJAbL6WHiil1Hv7z9Qkt/aN8GGo=;
 b=U4ZHSh4Qqoi6sjPZ4p1aAR43cE5OE0mPEvxyu4bFdqLJ2tKJ5O2Vy0TqEqFwqhDCoZgrDEAO0WKmS+cjAmij9ZTNSVvx7airDkwGFyN1Zd1uOQpoTO0z0X47BZ4CVL33MZfactSEBsPjB6aWIOYT0daMgkaicXxf2C5ScHGZyek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by DBBPR04MB7851.eurprd04.prod.outlook.com (2603:10a6:10:1e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 16:44:51 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::f1e4:90a0:aabe:ac23]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::f1e4:90a0:aabe:ac23%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 16:44:51 +0000
Message-ID: <86da3550-9711-6714-0857-2f7611dc9453@nxp.com>
Date:   Tue, 18 Jul 2023 19:44:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] remoteproc: imx_dsp_rproc: add module parameter to
 ignore ready flag from remote processor
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>, linux-imx <linux-imx@nxp.com>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
References: <20230712224251.26482-1-iuliana.prodan@oss.nxp.com>
 <ZLV7q9ipDaw4b1Hi@p14s> <6fe5691f-67f4-ff70-8350-b4b6c08097b0@nxp.com>
 <ZLa0MqKvg1W3mx/7@p14s>
Content-Language: en-US
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <ZLa0MqKvg1W3mx/7@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: AM8P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::31) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|DBBPR04MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: c8198da2-fff0-4ae8-ad49-08db87ae4eaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IVDhYaFzPKaZz9EIshdHw8oLNmSQqJFmnqXARJK3sTjozzvSVIpdlQDT9SAbjxwTNKS3FrcoVO/tCzWeZeKqm1SEgP70zRrae5CeyCYuINGUhMJw6ulG+C0V/04KzwsJt9HULJAPy6bGjKeCnY6KncCyblhBRttj+O9lBV+pp0gCizl/3GPIEwMhoGqAjG1vo+HeGOHkIvjObzqcKbATQaKBykjIYxA/botElRwHlFLhfKo597MbJT9mRnVl+H8ZMcW5O/LW2W9iY2Y8T2E+1Ux+bsWmv3IVXV1s9Dgpa/4d2cJ8HPWzR0HzRtGrSID8hizAjmcsLbGt+FZOHH+f8Nu2QEjBPO0TOupnHba60YJlaLhnZKo7cjgLhNM8gC8n8odvM/iRb7vrTcpGZhNhirTrkWGqUM1Kh+EwY0ZtCbDD7u+G1MOAfDnD9HrniS65Kz6C/w6UGsv3BC6ULaaThO8jWfABH8f7w89cgoNvVY3Qzgu89k8H/d1wnJgKkyuLfdAVgL2DEWk1/tNQ4muIjJqhFd+8WZEw7Z6wwtWDROumxnGYFihErncgVffrFse3ryqkxV0pqQWncQpuBotzv+c+qLqUW9UrYfprS3G2GOoiraycXKzXqfFdJ0pjO3DHm6YWet5yUCN5SfSOipKWgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199021)(31686004)(86362001)(31696002)(2906002)(36756003)(44832011)(6506007)(2616005)(966005)(6512007)(186003)(83380400001)(26005)(53546011)(38100700002)(6486002)(54906003)(66946007)(66476007)(4326008)(66556008)(6916009)(5660300002)(316002)(478600001)(45080400002)(41300700001)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTZMY2xIK0VqUzBWbUlEcHNlM2VVK3pjcEhZbjJtUGphQUU1UlFveW0rcDgw?=
 =?utf-8?B?UWFkMlFuTy9SNHZhM3BuVHZCcTM3K2xoTGRvSmJ2MkNONmJZWjdYWFNPL0Ix?=
 =?utf-8?B?V0xyeG1yZCtYNWR4NXBLNlRNUytpdXRCTDNxVTZKclFUS2ZzOFY0UnFRTzZz?=
 =?utf-8?B?K1B1RjRQNWxkbWQ4SE1HODNpRm4zT29Dd0xRemI1dmswN09oeFZBN2QyUytF?=
 =?utf-8?B?ejIyd0s5THBIRThyM1RuOS9kalg1N1NYMGVxcDZ5M2FhdkdISjNKazJSeVhU?=
 =?utf-8?B?cTB1cjdseDh6R1JJZXMzUG9DR3dKazh5WE1xaiszV2J4RW9BNXdhNXlVdWtT?=
 =?utf-8?B?TTdKb09vd1BmdWg0SHgwUWNQMFg5aFhJNlFabmFDbDhqelNpUDdoSE9OWnVJ?=
 =?utf-8?B?SnA5Z0kwUVFXdU1QUzd2cHpYdjdXdnFDL1lKMUh2YXZXeVNnanBBb2I4NG9a?=
 =?utf-8?B?ZDUxUS9ob2UwQ1MybHdkOFlYYkNMM3REK0M2RWxCNk5ESjlTRExWVTlkSU4w?=
 =?utf-8?B?dU9Hd0QwWGxYaXF0NGNKV3NiK0pEZnpCYXNOWVlqc0duSjhPdVhaQWh6YnVD?=
 =?utf-8?B?UFhveGozKzdxZFZBUG5vdE44WEhqK0hGc2l0QnpBTlk0QkVOUi96dVhPck92?=
 =?utf-8?B?TEY2NmpuWmdNZTd3cVVQeG5veVhsNDVaNWFvWFFrL092ekRMV0NZY2R4Si9V?=
 =?utf-8?B?TTFnMlhFVEQrUjYzZURtQ2djQjBLWUpSeFNxcndaelZ3RnpyQUlnelhDQ0dK?=
 =?utf-8?B?NVRPc3RNdjVxeHJaRFUya1ZKTmVDWlcyZGE0OXdneTF5QVRSaXdBVERJalBW?=
 =?utf-8?B?M3pvcWxONytjZFVKWXdMTWU2UVZoeFUwckIxb3NJZTcvZlZIRnlnd1ltOUE5?=
 =?utf-8?B?dWNxOWR2dEowUklBS09YYlV1UVFEU0EzZUhsa1BFQ3ZSYVhhQlhuY0dtd1Mz?=
 =?utf-8?B?OG5WMTMwa1lvWk1ScTV4eGlUZHFqU0F5K0d6R3JwaEo5SFpma1BiZmJPWHRZ?=
 =?utf-8?B?LzRBZkZJVmRxYWk3UFVXUDlPNFNoWkFUUzZzTlNzcWhESVQvVWs1QUU4TFEw?=
 =?utf-8?B?OXMyd3VNNVM1RDZybG1DcFgzbWFxK05GSnEvd2EyU2VmTGpuZm4yL0svWDRO?=
 =?utf-8?B?N1c5UVlnOUxHbHNkc3c3c3BrZHF3V1k4NUIyMjhadWQ1czA5SVIrRExHeHpj?=
 =?utf-8?B?b3kyZ0Y0SHNHUS8yd0I4cjJXY0xGeEF0SWhPZmkwZTBNRExQSXJpVkFHNWVk?=
 =?utf-8?B?ZlBCL2d4S2VCbmRNeWFsNm95eWlsVTBKTTVEQ2k1ejdUTmtEazZTUUliYjFo?=
 =?utf-8?B?aWtCZi9HRHNSUG4xSmY4aGh6bkkya2UrdjhZUE9NK0ltMkxzdFo4Y1k4WHhm?=
 =?utf-8?B?cFZTeEdBNHI4Wk55VUtTZUdQUldSUUh6ZWZ5c0srUUxDMkoyRGljZFJTcXZM?=
 =?utf-8?B?a0RMbzR5amh6ekZlRG95R2lud1VBWDZ6dnlxVyttT0V0WnJhV1ltNXpWTk9y?=
 =?utf-8?B?TjZjcTlIZVdiaVhmaFMzT25ZaVp5UGRCRzlibWtNQXNJbkhmbkpwd0E4MzY2?=
 =?utf-8?B?b1dqWVZhWk9NdzFpSGlVWUVCZHZlM2htSHRrcHljcUduOUxlVDE4Wno0ejEv?=
 =?utf-8?B?TW5ObzZYRlVPMURRKzdtUUNkMkY2Qk5TRTNRUGdzeXpDbzA3N0wra3JlZE53?=
 =?utf-8?B?c3ZzS1Y0cUYxMmhHWDNTMklOVngxL0FQckFIYlZodHVNdDd4Ky9samQ2SDZQ?=
 =?utf-8?B?VlJTZGx1ZVZwaGNlbGhXRTJRRHh3bWMrc0k5MUZWVEJ1b01Za1diY2xOMkxP?=
 =?utf-8?B?RWVzOWV0enY0QlIrajZrMVpFcThqRkdtWXVpSkR3aS9tQ05FemxqNDBTeFlP?=
 =?utf-8?B?eXpzNCtVdWtBajhhWkQ3U0Y3V1RrWEFubXc3T1JzMnBSNWhsMFJROForVFow?=
 =?utf-8?B?SmJSd0hOQmZ6OCtYOG5qTzBYWmtjSWVsYkpwUkgrRkZwNGVxT01vaC9lN3pH?=
 =?utf-8?B?dHJ6TDFLdERhdVVSVStqSm5odEYyZ21ER0hXZE9lSFJNY0dzOG85eFFTZWlW?=
 =?utf-8?B?WTZNSVh4R21QeUVHUi93VXhHaEJJVXllOEFyazJ1Zkdvd3VWbTJIQ1BoUWpm?=
 =?utf-8?B?UXhOb0Fpc2xXZTF1NjRYdGFNM25PYnJaS2ZXcmJEc0s3bzIySk50QXJscVZI?=
 =?utf-8?B?c0E9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8198da2-fff0-4ae8-ad49-08db87ae4eaa
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 16:44:51.8345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnxDIpJFYGi9LHYveFC9CsJ2xgke88AlDCta73jH03FXR+jlMR9KAMCmvwiud6FXxyjEErEir/qlebtLoX6sEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7851
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/2023 6:48 PM, Mathieu Poirier wrote:
> On Tue, Jul 18, 2023 at 11:30:43AM +0300, Iuliana Prodan wrote:
>> Hi Mathieu,
>>
>> On 7/17/2023 8:34 PM, Mathieu Poirier wrote:
>>> Hi Iuliana,
>>>
>>> On Thu, Jul 13, 2023 at 01:42:51AM +0300, Iuliana Prodan (OSS) wrote:
>>>> From: Iuliana Prodan <iuliana.prodan@nxp.com>
>>>>
>>>> There are cases when we want to test samples that do not
>>>> reply with FW READY message, after fw is loaded and the
>>>> remote processor started.
>>> This seems like a bug to me - where is this FW comes from?
>> The firmware is a generic sample from Zephyr repo: https://github.com/zephyrproject-rtos/zephyr/tree/main/samples/subsys/ipc/openamp_rsc_table
>>
>> There is no bug, this is how the application was written.
> But how did it ever worked before?

It never worked on this kind of samples (and it was never tested like this).
We used only applications written by us (NXP) with the 
requirements/limitations we know we have.
Now, we want to use also generic firmware/samples (from Zephyr) and we 
face other kind of limitations.

>   And how does having a module flag to
> characterize each FW implementation that springs up in the field can scale (and
> be maintainable)?

I believe the FW_READY reply is a limitation introduced by imx_dsp_rproc.
We cannot expect all firmware to give a FW_READY reply.
So, to keep both usecases (internal firmware and generic sample) I added 
this flag.

>> Rather than modifying a generic sample for i.MX usecase, I prefer doing an
>> "insmod imx_dsp_rproc.ko ignore_dsp_ready=1" just for this sample.
> We already have a "no_mailbox" flag for cases where the FW doesn't need to
> communicate with the main processor.
"no_mailbox" - no IPC between cores;
"ignore_dsp_ready" - we have IPC between cores, but the remote processor 
doesn't send a fw_ready reply
These two can be combine, but for "no_mailbox" will do some useless 
memory allocations.

When I added the "no_mailbox" flag, the problem was still FW_READY.
>   What happens when some FW implementation
> requires a three-way handshake?  How many flags do we spin off?
>
> As I said above this approach is not sustainable.  I suggest to either fix the
> FW (it doesn't work with upstream in its present form anyway) or start using the
> config space as described here [1] to dynamically probe the characteristics of
> the FW being loaded.  Whichever option you chose, the FW needs to be updated and
> the former is a lot more simple.
I don't think I can modify a generic sample, used on other targets to 
send a FW_READY reply.
How will it be handled on other platforms, if their *_rproc are not 
expecting this kind of message?

Thanks,
Iulia

> Thanks,
> Mathieu
>
> [1]. https://elixir.bootlin.com/linux/latest/source/include/linux/remoteproc.h#L298
>
>> Thanks,
>> Iulia
>>
>>>> In these cases, do not wait for a confirmation from the remote processor
>>>> at start.
>>>>
>>>> Added "ignore_dsp_ready" flag while inserting the module to ignore
>>>> remote processor reply after start.
>>>> By default, this is off - do not ignore reply from rproc.
>>>>
>>>> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
>>>>
>>>> ---
>>>> This was discovered while testing openamp_rsc_table sample from Zephyr
>>>> repo (https://github.com/zephyrproject-rtos/zephyr/tree/main/samples/subsys/ipc/openamp_rsc_table).
>>>>
>>>> We have IPC, but the remote proc doesn't send a FW_READY reply.
>>>> ---
>>>>    drivers/remoteproc/imx_dsp_rproc.c | 15 +++++++++++++++
>>>>    1 file changed, 15 insertions(+)
>>>>
>>>> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
>>>> index b5634507d953..ed89de2f3b98 100644
>>>> --- a/drivers/remoteproc/imx_dsp_rproc.c
>>>> +++ b/drivers/remoteproc/imx_dsp_rproc.c
>>>> @@ -36,7 +36,13 @@ module_param_named(no_mailboxes, no_mailboxes, int, 0644);
>>>>    MODULE_PARM_DESC(no_mailboxes,
>>>>    		 "There is no mailbox between cores, so ignore remote proc reply after start, default is 0 (off).");
>>>> +static unsigned int imx_dsp_rproc_ignore_ready;
>>>> +module_param_named(ignore_dsp_ready, imx_dsp_rproc_ignore_ready, int, 0644);
>>>> +MODULE_PARM_DESC(ignore_dsp_ready,
>>>> +		 "Ignore remote proc reply after start, default is 0 (off).");
>>>> +
>>>>    #define REMOTE_IS_READY				BIT(0)
>>>> +#define REMOTE_IGNORE_READY_REPLY	BIT(1)
>>>>    #define REMOTE_READY_WAIT_MAX_RETRIES		500
>>>>    /* att flags */
>>>> @@ -296,6 +302,12 @@ static int imx_dsp_rproc_ready(struct rproc *rproc)
>>>>    	if (!priv->rxdb_ch)
>>>>    		return 0;
>>>> +	/*
>>>> +	 * FW_READY reply is optional/ignored, so don't wait for it.
>>>> +	 */
>>>> +	if (priv->flags & REMOTE_IGNORE_READY_REPLY)
>>>> +		return 0;
>>>> +
>>>>    	for (i = 0; i < REMOTE_READY_WAIT_MAX_RETRIES; i++) {
>>>>    		if (priv->flags & REMOTE_IS_READY)
>>>>    			return 0;
>>>> @@ -1119,6 +1131,9 @@ static int imx_dsp_rproc_probe(struct platform_device *pdev)
>>>>    	else
>>>>    		imx_dsp_rproc_mbox_init = imx_dsp_rproc_mbox_alloc;
>>>> +	if (imx_dsp_rproc_ignore_ready)
>>>> +		priv->flags |= REMOTE_IGNORE_READY_REPLY;
>>>> +
>>>>    	dev_set_drvdata(dev, rproc);
>>>>    	INIT_WORK(&priv->rproc_work, imx_dsp_rproc_vq_work);
>>>> -- 
>>>> 2.17.1
>>>>
