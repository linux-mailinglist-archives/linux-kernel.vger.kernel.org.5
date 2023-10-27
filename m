Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4228A7D9391
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjJ0JXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjJ0JXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:23:47 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2093.outbound.protection.outlook.com [40.107.215.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D300CC0;
        Fri, 27 Oct 2023 02:23:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9PowIqUOt90ZudbBnm81Qv8DIWxo8USQOFR5nIXtSkZ6NdSd4w9QFF+1bqWiR2xXlIdKG17Znvvvvm19lOUBf4+bOZhB42ZSXtM14TOs9i2ifeD+CG8qVFJ5Xhf4biMZxQ/8AasXr4WymPiwasckzYzMbijhBy740UgqsQmpY7lRJ3CFmaA5wl2V6xON1XSutYwnY6Y/CSiVY0dF8tnkqHos0Jc2OlnsqTnV2FBpetLr3CeN8dXNVakDbX85qIctsdez05Fq5dxuxgXPE9d5Ya/D/8gXqIGkt2W3uq6oIP/2M0zFSsARkHplebiu7hjK1oeRG5Wv696SEqBUTJQog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkZrpUUIDGXVEFfITlNgB7b7eQxTpVkVkWOFQn7/fGI=;
 b=UjPpeAfPxl5mzTImRYeAgc9hUZfMjHj1bKlTp8CLuc1+u2fVF9R3p+IbiLQo7IO/LAbP1hHRSGucmQQToWDIDV6THdYLwKwCwowgrXrXbkbBQ68f02qZQsJ/x8Jv1CmcVavJRYk42wl2gvOeDrTJ/Kfd5kURHnKAAEmtdtbHqg/g0H6dNdPFOIFA4CN9hWCcZmtEZ/eqzaWZEH1khB3yd1/GiBQXr5PcpcdXyOH3rpB+kwP/I6Pbf/GEyBJ+y2QF8G2HOF5vPmVwpt8+yvoh4ZLo13nehm6LW8KEeuOW60ca+2fgEotPUl+Dp54vtUg+Cbqswvxrjo2ATXHU+SG+2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkZrpUUIDGXVEFfITlNgB7b7eQxTpVkVkWOFQn7/fGI=;
 b=QTzG3w2M0xDSdhWr8kBO56XY7mFUdoec98k3+i+y10Ihx+UJZLMCKyOLu6yfYObXoCpdc5G2eJfYkZbHKd3GI86uttMJqyD3C87VZFUtnXUEBRsn1BNp+ooflxUCSY4wWMaJvbv/z9jBO2Ouh1amvAxq8n75Jz1ggTsz1Ilvl9d1+qLvRsl6Uuha3Tm+XQTzb4e18IzkXiomL3Iao2Tr7fvawCmoau3IjhSA02uG2Mw6AcOP2cxMhENF0SA/U9NnfPWWU1EqvTXgsZ+E8tjDTH9qU+/lbuLQffObYnGjAyBj+hI04zBBFM/RGJsPBaKjL1s8PFh3SafWHlneQ6jJfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5732.apcprd03.prod.outlook.com (2603:1096:820:70::7)
 by KL1PR03MB5729.apcprd03.prod.outlook.com (2603:1096:820:75::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Fri, 27 Oct
 2023 09:23:38 +0000
Received: from KL1PR03MB5732.apcprd03.prod.outlook.com
 ([fe80::639:64cb:4cd:d4c1]) by KL1PR03MB5732.apcprd03.prod.outlook.com
 ([fe80::639:64cb:4cd:d4c1%3]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 09:23:38 +0000
Message-ID: <62ab75f8-0e15-441a-b6b3-0b8cc138419b@amlogic.com>
Date:   Fri, 27 Oct 2023 17:22:21 +0800
User-Agent: Mozilla Thunderbird
From:   Junyi Zhao <junyi.zhao@amlogic.com>
Subject: Re: [PATCH V3 RESEND] pwm: meson: add pwm support for S4
To:     George Stark <gnstark@salutedevices.com>,
        Yixun Lan <dlan@gentoo.org>
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231016052457.1191838-1-junyi.zhao@amlogic.com>
 <20231016223749.GA7647@ofsar>
 <07f978ec-2f18-4079-afb1-4d37827806a3@salutedevices.com>
Content-Language: en-GB
In-Reply-To: <07f978ec-2f18-4079-afb1-4d37827806a3@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0335.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::13) To KL1PR03MB5732.apcprd03.prod.outlook.com
 (2603:1096:820:70::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5732:EE_|KL1PR03MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9f20dc-b1bc-4b5d-73f4-08dbd6ce6579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iQcTpG6d07e6t4PZ9qyDGGBxPEZMYzDUL+S90RDYcEYjnJKr13MEkRsyoo/u2b58nvl8LnWXWFhgMzJQSOyvrlQzCyt68rjOwsCggKtYWM4EW9hJs9PJBpAbQelJPjzj4xAsgvv+49aFs4v7XOpdaw7jTS2rJ6xpkvk6M1WdM27pLdPRLxczHb8AiTBpxcOEYpIAbgx+7lSt6Jr8ONHE01U1CA/f/mLmuhXBTxNJomSuqk86r5VLQ5GkTddrVHcKKPkkjoKDyCYEqii89bBijd4KzA6+HIUyjUm1lr3sUmpnbMLGoV1NcaSEBFIywG0eyM3wu+EfY1rYCYEEYbj1FSZ3t1XV7k9vt0ksQocCQvrMw03hv3keZFrpL3SN7wLb2S5QBY8WAuLy2/94YFe71jetzT2zyFUwQFrczOonTQ5g21b2hZNyYQnwtnRsWmxgfHtotf4mGYmQFpFDugcI6yFjJ12yt9yLK++hKMRqnDzIregsS0RV1PodLEopYqCKr67QLTiC1+CPpFaGSfLhZPMn2+qKAExL69LJ6GbZACAirt+rT5fezcnaK1rriX1PftWZ2U/sMYRZWdQ8hPS8UYyKn4Eb+Bc1IH6JtlvBws4z15scYU9YH45QW4Kr1DTpEOgxWh1hmHAShgjmMcs4WcTdBF9AmDBhpJEYcijvu8qRaIkw5ghg3/2SPGIuXl+mYOSSyYZyvAgtoTt9QYP+iATPPdKEee2+Gnp5Ei+Dp3M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5732.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(39850400004)(366004)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(1800799009)(186009)(83380400001)(53546011)(6512007)(6506007)(26005)(2616005)(6666004)(66476007)(66946007)(316002)(110136005)(31696002)(66556008)(5660300002)(8676002)(36756003)(4326008)(8936002)(86362001)(7416002)(2906002)(44832011)(41300700001)(31686004)(478600001)(966005)(38100700002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXNWRGZUS1lvdStGMFJsd1I2NzFORldrWWQvM0d0T1FneTh0ZldUcUtjU003?=
 =?utf-8?B?RjZNTlNMVFpyY0ozRXVKTlhjbVVWWmtUSHp3Nit4eEJHM1dBQ3dJQ3VDbHFK?=
 =?utf-8?B?WjRpOFVEOEhQL095VEZmV25QWkgyUFVnQXJYNHdqa2ZGaTd0Y3JVRjFNalhD?=
 =?utf-8?B?aTZtTm1qakpiOUpCYnJTYjNNQTRNUWhpRDVnRkhjekZFcjRHMTZYeE1Lckp0?=
 =?utf-8?B?RmQ1NTlnRXFGdS9KeVVMcnBvdFhZNTRhNDdYekZ3QjRpdzlOditCL2EwMkcx?=
 =?utf-8?B?K3NnZGErMHZTQ0IvUU5kNEFRaGlYb0tsYldMekI2cFlGREc2U2lhQjZINVhT?=
 =?utf-8?B?MlpUR3RNbFZzWTNzSHl3eVZtcXhqZFJBcTRZVnkzMk5sZWozdUZDODdMclow?=
 =?utf-8?B?N2ZKUGNFSHdKbUFBSHd3OTJkMmw2S2lKTEdZNXdOWGpvKzFaOGE2ZlI1MkF0?=
 =?utf-8?B?MHg0MTJUREphblFIa1pmRXJTcmhFUHRFN0Yrb2Q3djNvN0M1VkxMU3lPN0dT?=
 =?utf-8?B?bG5OdzZTbTlPQXpka2RiQkpTbnh5OFZxZnNPOXhvNVBhYko0OW9LUzFUYUdt?=
 =?utf-8?B?MnR6NmswWXdmVW9aYmdFOWFMcjFoVGNWb3hlSXl0Z0N1aGJXaHdqQ1hGdktj?=
 =?utf-8?B?MWMxSzdSYTJoZEZpQjNtZUhwb1NvdnlZQjNTMCt0bWl3a1dGK21nZFNscXIw?=
 =?utf-8?B?TFBNdmRsRGR5MTlJR1V3em5hUVpVOXB1VGtGMXFIK1pYWFF6bC9oeERtdXBo?=
 =?utf-8?B?QlkxT3pFa256TVB1VXdxYzlvaXp4QUFrU0ZHNElCZE5Kd2UvUCtSdDc5dzlW?=
 =?utf-8?B?ckFsTHoyUlJGbnlRNHBoY3BKWms2Vi9IZmZQclNLNk1UZWhzODEyYzlGSnow?=
 =?utf-8?B?K2dTb0VJenZsWW1pUFQvRHE3NHkvQnlkSTEzQTJpVHdVenlpamJjL0haU3pG?=
 =?utf-8?B?UXFmVXIwa1RvTkhtczVQOWxiL2VqV3lFS3NZUlBnQlVPcHJvaDdwNVdnUHMw?=
 =?utf-8?B?b29idGExZThvTVEvNitsdC9EWmthTGl5NmJOai9qQXBYRXVUZE45TkFpNEw0?=
 =?utf-8?B?aTd4OW5WR1J6akRyS3VlNWtpUGh1d1Z2RlA4WkpLS0hlcFROUHpFNXJWZUti?=
 =?utf-8?B?d3NIaWc3UjVwRjRJMGk5bVQwL2VVNVB5dWRWeWVsZGlQbWR1WXkzUnJZa2ZF?=
 =?utf-8?B?d2Y1UTV1ZlQwTmlaZGtHWEVPMzhodHBmVm9TTGVMaHRONDZ4UWJGeDBXcndR?=
 =?utf-8?B?MmJTUVhXY1V1K0UydWZteHNPSHlUZDBnZUF0YjZIdVNIYm1SYi9HSzVKSXo5?=
 =?utf-8?B?ME42bVh5MDRxWC93SnhSMUp0cTRvZm4yNGsvRFFpTGd0SmlkVTBpMHp4czJy?=
 =?utf-8?B?MUJLckEyc3E5OWFLajlwVmRtSXJDTTl3a1BvMmlHY3pqaFRNamFJcVE3c3lh?=
 =?utf-8?B?ZnNCVlpLb1cwWmdmaEN0Z2lJS29xQ0F1dG12YUV2REk2TE1JcDhWd0I4RDRx?=
 =?utf-8?B?S2UwRmhvMFR5bDV5WE1LbkVuWmttUjJYOGxNUGpZUWU5V3lCVGZBUFMydGtE?=
 =?utf-8?B?YWFXTk83cUR1R25vOTA3RVgvMjlXUW16b1ZlZXlpSmluSGtzbTlIaVVRZzM5?=
 =?utf-8?B?eHhKRld3MzBIdzJiR3cvYUpoaUE4cDNtSVNNRjBaOW1wTUphbjJqTHVIay9y?=
 =?utf-8?B?d0F5dUJUMW5sRTZ3YTFGeFEzVXBYaVQzQ3dOeFdIR1ladDQ4NUs4M0xHTE5q?=
 =?utf-8?B?RGFpOFJFTEdVeW9MQ3laTGd1cXN6RzVNdU1JYm1JV2dWODVQa0kyazhTU21Y?=
 =?utf-8?B?c2xJWXROY2EwTDVLSGlWNFZEcDQxNEFUcGMyVlcyeDVtMWozdGI0bEpLeHda?=
 =?utf-8?B?SFhYR3BlbHJEcHVNa09aWG1VYVVRSlBWMitEWDduci9lZ1UzTExBQVJHWTZW?=
 =?utf-8?B?andHNk9aV3pzeXNtZlhIRFQ5MHBPNERheDZVTlBQQVpWSkI5VnFsZHp1ZlVX?=
 =?utf-8?B?WEo0TEN4a2FPVGVCOG9aQU8vMnl5UmNTSmROa2RYZlMrUHg4eWwvYlN5NTN2?=
 =?utf-8?B?RVo5RUZVTVNvOTFCSTE1K09UUk9YMkhoV0pIM0xYa1Z5U1Nrdmw3U2tITW1P?=
 =?utf-8?Q?6LsjtV1EvatgYwFVRVsv5BZjp?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9f20dc-b1bc-4b5d-73f4-08dbd6ce6579
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5732.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 09:23:37.2252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Hx0owUTVc5wyOqlu8WmXp4IDsRsB9NrNx9ezC+C+b+Wbab6t3/ve551Dwiie5nkMUshUQuby+gVBClRXJv6kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5729
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello YiXun，
  CLK config has been separated on HW. No more in pwmchip.
And s4 datasheet about clk updated already.

On 2023/10/24 3:40, George Stark wrote:
> [你通常不会收到来自 gnstark@salutedevices.com 的电子邮件。请访问 
> https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
> 
> [ EXTERNAL EMAIL ]
> 
> Hello Yixun Lan
> 
> On 10/17/23 01:37, Yixun Lan wrote:
>> Hi JunYi
>>
>> On 13:24 Mon 16 Oct     , JunYi Zhao wrote:
>>> From: "junyi.zhao" <junyi.zhao@amlogic.com>
>>>
>>> Support PWM for S4 soc.
>>> Now the PWM clock input is done in independent CLKCTRL registers.
>>> And no more in the PWM registers.
>>> PWM needs to obtain an external clock source.
>>>
>>> Signed-off-by: junyi.zhao <junyi.zhao@amlogic.com>
>>> ---
>>> V2 -> V3:
>>> Rebase and Review the latest upstream code again.
>>> After reconstruction, stick to the previous code as much as possible.
>>>   drivers/pwm/pwm-meson.c | 19 +++++++++++++++++++
>>>   1 file changed, 19 insertions(+)
>>>
>>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>>> index 25519cddc2a9..fe9fd75747c4 100644
>>> --- a/drivers/pwm/pwm-meson.c
>>> +++ b/drivers/pwm/pwm-meson.c
>>> @@ -99,6 +99,7 @@ struct meson_pwm_channel {
>>>   struct meson_pwm_data {
>>>      const char * const *parent_names;
>>>      unsigned int num_parents;
>>> +    unsigned int extern_clk;
>>>   };
>>>
>>>   struct meson_pwm {
>>> @@ -396,6 +397,10 @@ static const struct meson_pwm_data 
>>> pwm_g12a_ao_cd_data = {
>>>      .num_parents = ARRAY_SIZE(pwm_g12a_ao_cd_parent_names),
>>>   };
>>>
>>> +static const struct meson_pwm_data pwm_s4_data = {
>>> +    .extern_clk = true,
>>> +};
>>> +
>>>   static const struct of_device_id meson_pwm_matches[] = {
>>>      {
>>>              .compatible = "amlogic,meson8b-pwm",
>>> @@ -429,6 +434,10 @@ static const struct of_device_id 
>>> meson_pwm_matches[] = {
>>>              .compatible = "amlogic,meson-g12a-ao-pwm-cd",
>>>              .data = &pwm_g12a_ao_cd_data
>>>      },
>>> +    {
>>> +            .compatible = "amlogic,s4-pwm",
>>> +            .data = &pwm_s4_data,
>>> +    },
>>>      {},
>>>   };
>>>   MODULE_DEVICE_TABLE(of, meson_pwm_matches);
>>> @@ -451,6 +460,16 @@ static int meson_pwm_init_channels(struct 
>>> meson_pwm *meson)
>>>              struct clk_parent_data div_parent = {}, gate_parent = {};
>>>              struct clk_init_data init = {};
>>>
>>> +            if (meson->data->extern_clk) {
>>> +                    snprintf(name, sizeof(name), "clkin%u", i);
>>> +                    channel->clk = devm_clk_get(dev, name);
>> use devm_clk_get_optional() which would save you from introducing
>> the 'extern_clk' variable
> 
> On S4 and other recent chips PWM clock resides in separate IP and it
> must be provided to driver in order to control PWM frequency. So this
> clock is not optional.
> 
>>
>>> +                    if (IS_ERR(channel->clk)) {
>>> +                            dev_err(meson->chip.dev, "can't get 
>>> device clock\n");
>>> +                            return PTR_ERR(channel->clk);
>>> +                    }
>>> +                    continue;
>>> +            }
>>> +
>>>              snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
>>>
>>>              init.name = name;
>>>
>>> base-commit: 4d2c646ac07cf4a35ef1c4a935a1a4fd6c6b1a36
>>> -- 
>>> 2.41.0
>>>
>>>
>>> _______________________________________________
>>> linux-amlogic mailing list
>>> linux-amlogic@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
>>
> 
> -- 
> Best regards
> George
