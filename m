Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B5D75FB6E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjGXQEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGXQEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:04:50 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2081.outbound.protection.outlook.com [40.107.247.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A849B10DC;
        Mon, 24 Jul 2023 09:04:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWBSqDyRDiHoXTCrga4Qw6S6CJLwC91TJeadxPc5in0UCyp6kExkO8rOERWlh7KsT7CKk8lfAWSZEvg/IPKx0oIQXmIng1tA2VJZR45h1iXb3sV7Aw2b/BCxN2jkrYxQpyGKVi/pUEoNjiKJD5xxqpp6hd1ixhXUSV50fR5nftyonZ3IXyd2zI8OqeKrwnsBd7ysoBk3jqD6SV9vQ7f6fCAOOEsHOBdY2J70FI1onVPjKmp1X/HpR26XGFXH/Qs+R3/UlB0oUB56esfiHT/Ei4iIWhXvIdBt+rGg3aBV1lMGM+O/k0W+vPiyngQKql9n+QoYtoJnhbE+spoSGzsIxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gk9mh55Sl9sbldBM7gaz6MkYbcORqhg+mCpDBDqrFkA=;
 b=kG8pxFYm6P08t1sDHUvsS/nFofeeIiM9UPlYguK3mDJz4XRNCIKliw3gtAP+anQYS5hEpaNvE+lyJBmSyRN+uRHp85OrtsjV4nXom+kRy9eetWE0gSekhOlXqj8+PBK/925bsB/IUG9IgDOednG5Ezjjrn1Ak7dzTcOO+KLeg2d1r8cK7Spf2hTPbA3FUcg//1BnqdiscYjeeTImed35JxmKH64FrYXep5HpAlcq8WoqllnbtALZj7eH8B7j4vsYxUnpCjWvlYcpkGHkLmU2ZKksK2MO0+8AKwNoqPrzRgf+V6rxyAwcXAzY++HSnaKy06pAUXl41ho9h9ZT1diThA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gk9mh55Sl9sbldBM7gaz6MkYbcORqhg+mCpDBDqrFkA=;
 b=iCoTLidwJkWLsvek22tyRbOe/SsoePzN8DeEcoBHnJqSIVAE1VZH5ovjyx0IDMUT3Vu+i3a5JfRj8ljWcVerVwHVUmUrpT8PLBnhX+FJ3tamlUapQCx2FGYsu8uFX4bjCGbhVOWV80kK8V7XQmI29cKkolUHwu5tFiqywQInWDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by DB9PR04MB8266.eurprd04.prod.outlook.com (2603:10a6:10:248::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 16:04:44 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::d2eb:93a4:639a:99cf]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::d2eb:93a4:639a:99cf%4]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 16:04:44 +0000
Message-ID: <c675a73c-4fa0-976f-9fe9-6a66bf5620c3@nxp.com>
Date:   Mon, 24 Jul 2023 19:04:41 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] remoteproc: imx_dsp_rproc: add module parameter to
 ignore ready flag from remote processor
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "S.J. Wang" <shengjiu.wang@nxp.com>
Cc:     "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>, linux-imx <linux-imx@nxp.com>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
References: <20230712224251.26482-1-iuliana.prodan@oss.nxp.com>
 <ZLV7q9ipDaw4b1Hi@p14s> <6fe5691f-67f4-ff70-8350-b4b6c08097b0@nxp.com>
 <ZLa0MqKvg1W3mx/7@p14s> <86da3550-9711-6714-0857-2f7611dc9453@nxp.com>
 <ZLgFiW+IH3m4MWLw@p14s>
Content-Language: en-US
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <ZLgFiW+IH3m4MWLw@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::6) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|DB9PR04MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f6195df-782d-42a7-791c-08db8c5fb1fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vhhF+Ga3TPpgdM3sms2enARPeStFur/Xq8Bdh/QxOHFczAHFglaFSLWy1pv9KYZpfnFRnHurhSQ5Ci87kiMJ4XAXeZLlD4DYDTvFC6kL52cL2e206SJOhVB3aHQ1mn4/2Pj4lWGMx1ZniD8fxQ0ag4zdQDLt5aA7kVLvasp9ZYzhMJKBBnCLJCLvK8TiR17vRfNA5k41Af8h9MCL+0m9Gu6s3SJGzWur8fWZXCucQrFdMKTF5aoubIGMnTtEzc10M2WtHZEdVI9YtF9QGYiUcf8bD8bfgdx7f460oL9lwUEAr0pSXREBzcHb318PujKU9SDo2nrgo/GVOHJAuAqFkXbbnjvFkaGPXu1IoBAoySIx8FTn64szRsqOeCPnqIUW5wPp9BIkFjv0aTi0gjUJBS+DDyf57yo2wKCI0N8v0TcHQsbR3yCV6EKYKk+5kp+hgKFqPPOjGDyYZ4WGB380hGqcJxGP/cxIMGU37ZUZNQXgw8FciPVEnr7T9u9MN04xzso55zV0LrxX0y3jCWC6D47DLzDUzrrl02r8lA/Ldj3yltC5lgZAoChxswn5G55KgvJnJe1SyWM139sHW756kw8oHlMjccnjI8gkTP6v+AHzzYi/aF+5euXULBl7QGkhgn1i6jzP80PDppeSrIwiOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199021)(38100700002)(36756003)(53546011)(2616005)(83380400001)(44832011)(8676002)(8936002)(5660300002)(110136005)(478600001)(54906003)(6636002)(66556008)(316002)(4326008)(66946007)(41300700001)(26005)(186003)(6506007)(45080400002)(966005)(6486002)(6666004)(6512007)(66476007)(2906002)(31686004)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFd6QWJFcS9EMktpOEkxVkx0azNRM0VITjNDTWJzeWZIbFk5WjNsU1o3L3pk?=
 =?utf-8?B?UnlMQXdzK3gxbllxNjZxanVkdVVKMkNwVFA4ZG9YaFljTVUyQ3JLTTI1NVBG?=
 =?utf-8?B?SlF0c3pVY3VqbTI2NCtQdkw1YVI4TDJrZ2JRSnFmQ2NDS1U2QVczSkhERHRO?=
 =?utf-8?B?LzhKNTJTTUpqMjFIV05BM2RPZE9CcW84ME4wQldQblBMNmRvbWJNU0NSRDc3?=
 =?utf-8?B?YllVb1I5SEIwcDkwb1NTVGFkRVErVWlTMWZxMHdFOWZ2Tzh1WUZMUFQ5UWtE?=
 =?utf-8?B?azJJVXRkQUF5N0hPSFRsbFptWks4UmIwUHJ4bFA1alpTc1F6MWF6em02TWJY?=
 =?utf-8?B?MTJtUXQvcjlBRzF1a1cvaHVzQnhUMXFMQXdJeU1FZXIwaURidkVESmxwZ1Ft?=
 =?utf-8?B?RXBhalo0OXF5YVIxYlE0dS80bS81cFRrOHdBMk9HYXZaV0xhTldwd2ZhNi9q?=
 =?utf-8?B?czdYTGhBMmZvS1YvKzA2eWl2SlVDc0hhaTBkSC8rdHNsOW40RE9qa0x0ZUVP?=
 =?utf-8?B?aHYxeXBDbk9zTVZEbXRGeDN6S0kvWkRMNDg0NlJCNVBFR1psMFk1MzBxQ1NG?=
 =?utf-8?B?QkpZQnRWVU05cVV2N2U0SnpnZThrcHlNdisrN1djOVJNNmhFVENQaHhBVzNo?=
 =?utf-8?B?c1hDOStNMk1aYVJwM1lnTkRLM3k4c3RpbWFlanVTc0lscklGNW1PS01DMitR?=
 =?utf-8?B?bTR6MHdzOXhJbTZVb05lZHJ4eWpqTVRKZHVYSXhVdGN3ditkdERVUXJwejht?=
 =?utf-8?B?WTVBRGd4VEFTam9BYzdmbUVFVVlNRVZXUTlGRGQwaWh0VUdUMmtGWTl4bXBi?=
 =?utf-8?B?dlRmZUdEMmp3L0FUKy9ZQ1JCL1JjNXEwMzNsVktRN3dyck1WbVNJMm9HWk5O?=
 =?utf-8?B?K3JnRFZqOWpUZWpTOEtpYXR1N0QyaWtBUTY0cVVaTEFqZFFVY3RvYnFIbFJH?=
 =?utf-8?B?ZVYrRTVTelR6R3loM0FwbTdqYjRaVjdSNzA4WWFWNGxXWGVMV1NLVkIzWHhT?=
 =?utf-8?B?NEYwZk5ydElQK3l3Z3RKcDFza0dhUkZtWjZ2Mk1tb20rQjFmdEU2YnhQRk1j?=
 =?utf-8?B?QlFZak05NFlKd29ZRmhTMGlyWHNmMEYwUWd5MzBTNlRpdlY0dm54Z2FoMlpT?=
 =?utf-8?B?WHFCeE96R0EyVmtnRTk5QjcxSmxXK3o1ekU4R045TTNoMzJTNk0vdDR5SGdk?=
 =?utf-8?B?WFMybFFpUXAzdkc1UWxudExTN0l2TVFDL2F3R2pPOTEwMVNXTHlweml6Y3R0?=
 =?utf-8?B?bmNjUTYwamVLNkM1T29laXUzUEVlTHVqQzNMK29mNHpPQ0hlYkRYRjRnSUgv?=
 =?utf-8?B?U1owSC93OW5CVE9UamJ1bU1zblRCMk01MjBhZGdDZzk2bEZxY2hpRnlPT1JY?=
 =?utf-8?B?ZC9uOGc4QzlhczF3U3poQ211NUR6aFBFSldlU0xQT1RLT0srZGhvRnpkcmZO?=
 =?utf-8?B?eDFzOFhPeHY1QnRxY1JPM1RWTXBBVWUzOEhsZC9XUmJ0Rk5WRWhoOUo0WDNo?=
 =?utf-8?B?VnRRb2F1NjllakNWOGFTbUZROVQxWG1ETjBOSnVMS0FqUlZRak40MmN5ZDB2?=
 =?utf-8?B?aUxEUVc1a2V2Z0xuQldhZXdwR3UzY1BXang4K2V3ZW95MUMrbEVxYkNEdXVS?=
 =?utf-8?B?cFFCRkFjdmtGZ2VDRkdocGQwNExmU0FhUndFVmdJaWsrV080RHlkTXZLV3ZQ?=
 =?utf-8?B?VjI5QkV6VEdpQWFsdWs4UGpKQ0tnZXBZZmxQamRnMzVaRy9mOE9WYmNTZlAw?=
 =?utf-8?B?NFN6QTVLUnJORWxBTERNMjlPZUlZd0toajZBRjEvcHBFVVlQeStwMjNCQk5t?=
 =?utf-8?B?eG5PU29rWUYzWnE2azU2bkR2WUY3cjJmK0daWnNhbDhYRnFXV3FHK1ExUG9z?=
 =?utf-8?B?WCtHQ0lVZktweFJETjNyZG1XOWk1VHRzRnM2djh2N0FjRldqRStlREJoSU1y?=
 =?utf-8?B?MktlMUZ4NWwvUXE2ejVjR2NYb0xFMDhXZmZ2ajJPRUhySEc0YnhDR2hlbUho?=
 =?utf-8?B?WWJ4Ynp1V0FuQktpTm1TTWdvZVJRR3NwdXZwZkFkaitjaHNwbHNCMFRoQnNx?=
 =?utf-8?B?M1JNRTg2eHUrcHUyMTJWVDlTWlZsOWRuTTZHNkY3ZEFBWkpVc21uZ3JtTmlt?=
 =?utf-8?Q?QIuv/cixpNAIf0RWjDEsV0twM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6195df-782d-42a7-791c-08db8c5fb1fe
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 16:04:44.1834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8X+06AReyHX4rdcYH6KFB1bIlmEyTugwz3ITMogZX0ZICQQdpeP4WDSh35oo6z12L29XGNguKh2/VdcI4nXj8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8266
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/2023 6:47 PM, Mathieu Poirier wrote:
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
>> It never worked on this kind of samples (and it was never tested like this).
>> We used only applications written by us (NXP) with the
>> requirements/limitations we know we have.
>> Now, we want to use also generic firmware/samples (from Zephyr) and we face
>> other kind of limitations.
>>
> Right, we can't expect firmware written for a totally different OS to work out
> of the box on Linux, and vice versa.
>
>>>    And how does having a module flag to
>>> characterize each FW implementation that springs up in the field can scale (and
>>> be maintainable)?
>> I believe the FW_READY reply is a limitation introduced by imx_dsp_rproc.
>> We cannot expect all firmware to give a FW_READY reply.
>> So, to keep both usecases (internal firmware and generic sample) I added
>> this flag.
>>
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
>>>    What happens when some FW implementation
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
> The only way forward is to come up with a standard specification to describe the
> protocol to use, the same way it is done for virtIO for example.

But why was this FW_READY added in the first place?
@S.J, can you, please, help here?
What is the use case for this custom message?

My proposal is to remove this reply.
This was added for a custom firmware/sample, that is not publicly 
accessible  - S.J, please correct me if I'm wrong.
Also, for imx_rproc (used for M4 or M7 secondary core) we don't have 
this FW_READY reply.


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
>>>>>>     drivers/remoteproc/imx_dsp_rproc.c | 15 +++++++++++++++
>>>>>>     1 file changed, 15 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
>>>>>> index b5634507d953..ed89de2f3b98 100644
>>>>>> --- a/drivers/remoteproc/imx_dsp_rproc.c
>>>>>> +++ b/drivers/remoteproc/imx_dsp_rproc.c
>>>>>> @@ -36,7 +36,13 @@ module_param_named(no_mailboxes, no_mailboxes, int, 0644);
>>>>>>     MODULE_PARM_DESC(no_mailboxes,
>>>>>>     		 "There is no mailbox between cores, so ignore remote proc reply after start, default is 0 (off).");
>>>>>> +static unsigned int imx_dsp_rproc_ignore_ready;
>>>>>> +module_param_named(ignore_dsp_ready, imx_dsp_rproc_ignore_ready, int, 0644);
>>>>>> +MODULE_PARM_DESC(ignore_dsp_ready,
>>>>>> +		 "Ignore remote proc reply after start, default is 0 (off).");
>>>>>> +
>>>>>>     #define REMOTE_IS_READY				BIT(0)
>>>>>> +#define REMOTE_IGNORE_READY_REPLY	BIT(1)
>>>>>>     #define REMOTE_READY_WAIT_MAX_RETRIES		500
>>>>>>     /* att flags */
>>>>>> @@ -296,6 +302,12 @@ static int imx_dsp_rproc_ready(struct rproc *rproc)
>>>>>>     	if (!priv->rxdb_ch)
>>>>>>     		return 0;
>>>>>> +	/*
>>>>>> +	 * FW_READY reply is optional/ignored, so don't wait for it.
>>>>>> +	 */
>>>>>> +	if (priv->flags & REMOTE_IGNORE_READY_REPLY)
>>>>>> +		return 0;
>>>>>> +
>>>>>>     	for (i = 0; i < REMOTE_READY_WAIT_MAX_RETRIES; i++) {
>>>>>>     		if (priv->flags & REMOTE_IS_READY)
>>>>>>     			return 0;
>>>>>> @@ -1119,6 +1131,9 @@ static int imx_dsp_rproc_probe(struct platform_device *pdev)
>>>>>>     	else
>>>>>>     		imx_dsp_rproc_mbox_init = imx_dsp_rproc_mbox_alloc;
>>>>>> +	if (imx_dsp_rproc_ignore_ready)
>>>>>> +		priv->flags |= REMOTE_IGNORE_READY_REPLY;
>>>>>> +
>>>>>>     	dev_set_drvdata(dev, rproc);
>>>>>>     	INIT_WORK(&priv->rproc_work, imx_dsp_rproc_vq_work);
>>>>>> -- 
>>>>>> 2.17.1
>>>>>>
