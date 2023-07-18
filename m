Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F47757687
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjGRIax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjGRIav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:30:51 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D33A10E;
        Tue, 18 Jul 2023 01:30:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/ZghBqi6+PQm9uRVQ0v1rxDkkes/z83zcqKX0R1mhMVcnKeaKMYKoCGeZMD7M6Rt/IuArSRsh8UTf3ekIeJIu1z+fRUCYNAzjNsx8ZWOh6JDRtu2bcT9BkvvjfhQ0TjmilDinq2RNTUy9hGf7puclFR9vFr1mNKjm9pGhIE1IZaczGuhlIpxcPL/GBTR1r/IS2MRG6vBrlV0n5+925lqiO8Jj0jS5NPIuwbar9RI7lYtUYiAsyJuTSJ2jNMFu/hJ3p/wQfubkmPwHTuLrOFSo+WCZiysLamUpg6MAUJJuWJ9tEbZbBrQxC39M3Bq5j7iGoePIifwKtWD/gHSKUztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2x54rjkk5qZCg9moZsZJJltH31B7lmf3N+a0omJr+eY=;
 b=Zi3nTO6wo9pJcB9+mF54uod2x7TW6iFbmBpVTzy240j1B7Wz8vyPu9hfdGKsM0XNQ5N+48TXg1ItmUJePZJ8OPpu0HrUe+MNEeJ6k1ErsqQw2iDDHcMRNh+/9juW48s9SqGrxBjN3yG0lmSIYcGlYg4zSYEY+yv4CEoWsWEnM/pfO7ozVsMiGQNeNBi9A4VhvhSKxNENsq8WWePm14Ma7T/Gw8TITt2aF2ubxG90MmxZS6Y06DT8fIwQonU5w/WHIERfumQW22ss0oqhw3+wWR/2VwT0gl8htkyxIBSuCopkUr95wpcu0CNqwepBV+EfHZlQKxuj/63EQmssbE4RNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2x54rjkk5qZCg9moZsZJJltH31B7lmf3N+a0omJr+eY=;
 b=TRHV/VD+IqKz6tycxQvUGwAh7UOUpsWgUpfyAN64ibk3IkYXPdMVL9ppYTN+/oYUMc9YrO8wG0szWlvRP9ZT3trI8xAi9Z/auBfZZxBMTf6u3saLCTWZbfrVLV1mdX4BbbEjw95aVKZMH5/U/H+ZpYf2hathEWA9bZNb34EZ/28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by AM9PR04MB8617.eurprd04.prod.outlook.com (2603:10a6:20b:438::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 08:30:46 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::f1e4:90a0:aabe:ac23]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::f1e4:90a0:aabe:ac23%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 08:30:46 +0000
Message-ID: <6fe5691f-67f4-ff70-8350-b4b6c08097b0@nxp.com>
Date:   Tue, 18 Jul 2023 11:30:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] remoteproc: imx_dsp_rproc: add module parameter to
 ignore ready flag from remote processor
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
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
 <ZLV7q9ipDaw4b1Hi@p14s>
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <ZLV7q9ipDaw4b1Hi@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0111.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::16) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|AM9PR04MB8617:EE_
X-MS-Office365-Filtering-Correlation-Id: 4af83cf7-93d1-41b5-3140-08db876948ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M6KvcNyh7mIhlMXRGkpj90ainsLKx8w2QKpgccIv7wyVyvXSKno1CC3xOKA6y/Yypz01B7TKkYpvUBRjZ/yySTpZ0Ha5cGJTbgxtwNzQcknlRRdBM3CnqHf8a3DLGBxjFySH//d1C63YLst3nURfHRO4tFOorOQ2T9yRBlUSy7MjnjGu1Q9OKVQCrKAp0W1S10ecCjGPDOg/wftnZzRNYHQsrxyKkOCSWINshs36GfiktAyTmk/C5zCJWuS40jYhcDAg7yToQ0eLuO/gmHCOqVyEh9R6iSkcB0+3IDJNRh9D7xR+0xMHWfJleXXedv9/6apvr26vVJpegY3ojZENWxtg0RV5vTNXMJLivLLxGu8Q+Gn4/sb9AYP20n3oUG0Te89spC+8hLr8gGdT5TPznwBU6G7oc58G3ksXczxIEpmQFmkxkkm6hmfRofKfFl8jjK09zT0zGAJqgPrAb6WDrDD3OuOTTWFIO/8WVZIFxvVqVd20DdWAFqF2J2N1upCPoRT91BpIg1V45Dd6+sBwhlmX2GXMNA14zwx3mtulloDFwKJq9azlm8q55HX+IQMLaNV3EWBKRpAlMMlgGNbUn8KSw/ii+pJT++2fxkzjGNt0JxirdUr0yT9oFtYldinO8TkNlD21oCKDYTNCtSJ8FA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199021)(54906003)(110136005)(31686004)(316002)(186003)(8676002)(44832011)(8936002)(478600001)(66556008)(66476007)(41300700001)(66946007)(4326008)(5660300002)(45080400002)(2906002)(966005)(83380400001)(6512007)(6486002)(6666004)(31696002)(86362001)(26005)(6506007)(36756003)(2616005)(53546011)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW8zTGxzdGRNYTNsYnhRc3VLNEJnOWVVODVyY1poY2grVWRnNFNsMEFZMndn?=
 =?utf-8?B?TmtONERRMFo3M2E0TUNkRzI5TWNZUGlhdWRZenpKOXBNV0dLc21rVnlvK1ZE?=
 =?utf-8?B?VFFqVlBRS3lIcU14Wi9QMTM3TFNXQjBjVGJTTWhGeG05NFczVEV6d2QrYjg1?=
 =?utf-8?B?U1BDYmk0VWNmMHhtTGxCUlkvNGtGUEh2ZzRzRFlNdm5iSFo4c0l0VEcvc0lR?=
 =?utf-8?B?WHk2M2VEaWM0YzZMZmMxNTRRYUl1WU9WVjY0Y05oalQwdkkzelNoTTV1K2ZE?=
 =?utf-8?B?b0Y1S0J5ZEtBZXRGUTF0N0Qwa1VnL3RpRDVyVUI4Qmc5UmFvdkd1bzFtdUZ6?=
 =?utf-8?B?K0pFMzVDNUtGQTFIc1BUcFAxaVgxYW9xendkUVdNRVV2aTRYaFcxbEhkQ3o5?=
 =?utf-8?B?djBEeFEwMEloaUJjc2lXOVZjTzZmNVVtT0JmdXRZSEIxMjJaVG8wYkNqQWlP?=
 =?utf-8?B?RjFmdElqZ1hML21pS3A4RWJLb0FKZW0rdVVrUmNqN0N6UWNYYm81SHN6b2Nw?=
 =?utf-8?B?WGNUUExINkZ2Ris0bUZLdW5XQ2hvUW5uWkpuVkZZUjlVdlR6eUhIQ3JHTDJG?=
 =?utf-8?B?YVo4S1ZQaGREdGJNSFdORUxWSUFnRFh2MWhacUozdHpHYTF1WDRHQmdsUENN?=
 =?utf-8?B?K0x6MzI3ZXFNNFJZTnliZ08zaUhCbFh1S2h6NHZYWXBQYkRNMUNYZnhYZWxZ?=
 =?utf-8?B?bmgvTFRJNFMzMHNpR2c1eGNIZ2RZRUE3MGtWNy9SUEtyQkVUbndXeXhUNU9p?=
 =?utf-8?B?VXlFT2xPbE5UVjFuVCtqaklKTXo4NHNqNTRJUHM3Z2hLQmZITFNZS1ZtVmpr?=
 =?utf-8?B?Tk5pTjlhaU1YQXA1TE1yTVFQOGx1UHZvaGZQTTlWcmF3UXg1VTNxZlFraUd1?=
 =?utf-8?B?Yy9NOGFVZW1zWkR1bGMvVmpVbTUvNFhzYlIxZHNCMWJzSmZoTVdKRWZqNWRi?=
 =?utf-8?B?NkZDbktIU0l6VFd4OW9tdmNyWVNnQ2w4ejJSMDdKWVFHNTZDZFZ1enZiT0ZS?=
 =?utf-8?B?Q1doUTlkcUJUZkFkYXh3Y2h5UFNybFZxNVc4L2xvVFMrYVN2cWVYQXNZOEYz?=
 =?utf-8?B?clRSOG1FY2dvSFVXczVMSW54VFF5ZTc4YTRlZVpOOVlDRTlLNU44cVFQQ3Nm?=
 =?utf-8?B?RXZrSUpVOVlpVFNmNlRSWCtTTUxtZGRJQUNaQmdoZzI4L2hmd3UyMDJObS8v?=
 =?utf-8?B?alNqdFh6ZzFLeng1bUxzRkplSGRSYzZLR0I4NHNvZUJMWjN4cVF2eGhqU2Vy?=
 =?utf-8?B?NmoweEtUWjNSWG9MSWJTRnNQay84SnFoYmZVVXNUbG14bXNLS1RTR2hWclZO?=
 =?utf-8?B?aXZIbGoyMWZQK0M5anRUdkxSd3hqdFcrTE9PZ0tiQS9Lcktnb3I0bkJGT09y?=
 =?utf-8?B?TEtvRGJVNlk3alZJSzhQbW5oMVVlVTFKSkhKeS9hN2MwQUtCdmw4eWNLbmlK?=
 =?utf-8?B?d2lzb2xUZDBSckRXeEt6bVUwTWgwS212RUpiVjJRUmxmWkJsSUc4K0I3L0xq?=
 =?utf-8?B?RGlKYktUdzJPcVBzejhBU0lRYjNFOHkrbDdwVk04N09uUTN3V0JGTDV4QSs3?=
 =?utf-8?B?M2F5cExJb1lNR2xkazhhRENyWHhwRVRyMDdRRW5Gb1IwMVpxUDhGV0w3Tzhv?=
 =?utf-8?B?dGErdlZqR3A3QmFPVTNPSmRZNzJKNzFzNDNDMGZNNlRVa0pYN1N1K3Q5RjNS?=
 =?utf-8?B?QzJPS2IwWEEwR0RJOVNwSlVaOE9IcDd2MjZMeGNKUWYrd3lLbUQ2WHExajR5?=
 =?utf-8?B?b2R6WVN1c3U2QXBZUllGSVdxd1FSZVlXZm9IbzhjdjU1aDZxSjl2eUU0aGN6?=
 =?utf-8?B?MnlXMHV2QUdxd1BGWVBweVNGNTFJVEYwUUdwdXhhR0d1ZHZWWVU3WUxXTzlU?=
 =?utf-8?B?ZnA3MnVDZlgwblk3RVUxS3lDbmdZajc1LzdaYXNsT2dKeFFNSDZrNktyblNN?=
 =?utf-8?B?NEJvNzUxd3oyZzduN25YcDdnRlZ2MHBSc2YveU4rRVdad1QwM2VWNllBa0dq?=
 =?utf-8?B?REhRbmo3RWhPaUxCUGNrVFY1NW5kUzBPeWdTMkxMWURmOHM3R3B2eVFDOVVC?=
 =?utf-8?B?MnFwOXlaekhTWEVYTVI2Y0pEcjhsTjVqNmEvS3FlSWxGd2hWTkhmdFMwVnVE?=
 =?utf-8?B?MVUwWW5HNmQxTHkwMDJHTDM5SUFaQjhBTDNzRkZLRWxTVnk2VGZkVW1Jdk1U?=
 =?utf-8?B?TkE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af83cf7-93d1-41b5-3140-08db876948ad
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 08:30:46.5067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTAAUnqm40qZLiWXpzFrVeia7lIG3PJI2pTwPAlEfYw/dy3NsBIGiI7gT4cgHRGFJnP3Vh+5j/FZZYcg5CdRUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8617
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 7/17/2023 8:34 PM, Mathieu Poirier wrote:
> Hi Iuliana,
>
> On Thu, Jul 13, 2023 at 01:42:51AM +0300, Iuliana Prodan (OSS) wrote:
>> From: Iuliana Prodan <iuliana.prodan@nxp.com>
>>
>> There are cases when we want to test samples that do not
>> reply with FW READY message, after fw is loaded and the
>> remote processor started.
> This seems like a bug to me - where is this FW comes from?
The firmware is a generic sample from Zephyr repo: 
https://github.com/zephyrproject-rtos/zephyr/tree/main/samples/subsys/ipc/openamp_rsc_table

There is no bug, this is how the application was written.

Rather than modifying a generic sample for i.MX usecase, I prefer doing 
an "insmod imx_dsp_rproc.ko ignore_dsp_ready=1" just for this sample.

Thanks,
Iulia

>> In these cases, do not wait for a confirmation from the remote processor
>> at start.
>>
>> Added "ignore_dsp_ready" flag while inserting the module to ignore
>> remote processor reply after start.
>> By default, this is off - do not ignore reply from rproc.
>>
>> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
>>
>> ---
>> This was discovered while testing openamp_rsc_table sample from Zephyr
>> repo (https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fzephyrproject-rtos%2Fzephyr%2Ftree%2Fmain%2Fsamples%2Fsubsys%2Fipc%2Fopenamp_rsc_table&data=05%7C01%7Ciuliana.prodan%40nxp.com%7C4779cb20393e4af08a9408db86ec191e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638252120814415013%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=iCjvv8wr3sQ4CEXFcXDsW0VSw5RXr1ASw7LN2J08SXE%3D&reserved=0).
>>
>> We have IPC, but the remote proc doesn't send a FW_READY reply.
>> ---
>>   drivers/remoteproc/imx_dsp_rproc.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
>> index b5634507d953..ed89de2f3b98 100644
>> --- a/drivers/remoteproc/imx_dsp_rproc.c
>> +++ b/drivers/remoteproc/imx_dsp_rproc.c
>> @@ -36,7 +36,13 @@ module_param_named(no_mailboxes, no_mailboxes, int, 0644);
>>   MODULE_PARM_DESC(no_mailboxes,
>>   		 "There is no mailbox between cores, so ignore remote proc reply after start, default is 0 (off).");
>>   
>> +static unsigned int imx_dsp_rproc_ignore_ready;
>> +module_param_named(ignore_dsp_ready, imx_dsp_rproc_ignore_ready, int, 0644);
>> +MODULE_PARM_DESC(ignore_dsp_ready,
>> +		 "Ignore remote proc reply after start, default is 0 (off).");
>> +
>>   #define REMOTE_IS_READY				BIT(0)
>> +#define REMOTE_IGNORE_READY_REPLY	BIT(1)
>>   #define REMOTE_READY_WAIT_MAX_RETRIES		500
>>   
>>   /* att flags */
>> @@ -296,6 +302,12 @@ static int imx_dsp_rproc_ready(struct rproc *rproc)
>>   	if (!priv->rxdb_ch)
>>   		return 0;
>>   
>> +	/*
>> +	 * FW_READY reply is optional/ignored, so don't wait for it.
>> +	 */
>> +	if (priv->flags & REMOTE_IGNORE_READY_REPLY)
>> +		return 0;
>> +
>>   	for (i = 0; i < REMOTE_READY_WAIT_MAX_RETRIES; i++) {
>>   		if (priv->flags & REMOTE_IS_READY)
>>   			return 0;
>> @@ -1119,6 +1131,9 @@ static int imx_dsp_rproc_probe(struct platform_device *pdev)
>>   	else
>>   		imx_dsp_rproc_mbox_init = imx_dsp_rproc_mbox_alloc;
>>   
>> +	if (imx_dsp_rproc_ignore_ready)
>> +		priv->flags |= REMOTE_IGNORE_READY_REPLY;
>> +
>>   	dev_set_drvdata(dev, rproc);
>>   
>>   	INIT_WORK(&priv->rproc_work, imx_dsp_rproc_vq_work);
>> -- 
>> 2.17.1
>>
