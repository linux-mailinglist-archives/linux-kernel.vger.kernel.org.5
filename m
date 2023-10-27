Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF1D7D93CB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbjJ0Jfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjJ0Jff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:35:35 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2130.outbound.protection.outlook.com [40.107.255.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EF7AF;
        Fri, 27 Oct 2023 02:34:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnTYETFBAq6svaEmfkNyeVFU9GRZ7ciF8qq6JQ8IVcAiOGLxXCTassGDEk7sbf8Jx/oXJfac1pKl7M6ufgOYmIpAaf+VmfS7fvdRx6attzwygft3JTvJNopqABCBc5y+r5EW+pj36vXk/pgMH7vrZLVBRVC74T4bL1rMOExHuNVzBBMxyYYZRIvNC+3cp5i/JWmDxfC4EXq8J87IBe9l69DmHEfaCk6TA7YLAAOkewM7JlU3unssTFMpwem+wXvVb512H5Qv7DJL0Oe028+d8lgWscLtZs/bWcTUW6KRA491rVYffyYeETbVIQLbtciAXP/uYlkfKEDMZclO6c9INw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCKs9fSMXAADhVrAJ0AswCju7ZB7oRtLeG1Ob5ZtrNI=;
 b=dpuHuitGl3/admJ2ggcQeJH4H68yY7i9K/MdGVYo9w8icKSCy+lWn8ID/4atY8wrA6NyZ6nSwy+6wFMdv2vAvuwQkMaTXbsdug/5AO4CFmFWDIZ23qPItn+2r35dfTB7YFT7fXTh1kQtgHmAQKFFKjebeUMEQLwt5m0P5TGuwIuImlvenEnlCe/nWArdBF2fWDJs4BKRavZYP4PwTrynS5ihVgw2a+okTVLyzXtRUMzQrVP3AQ+Ncl+jPFCaoVEu20xQ2tNg7y9Gvj+I76pF+flztMX+S9SULcl/oSwvZBIFjVUOEofGt5g/6kn0eWAOolTsMOzzOqPQDNkhAczidw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCKs9fSMXAADhVrAJ0AswCju7ZB7oRtLeG1Ob5ZtrNI=;
 b=QdCTsjsRWk+JLYFz+VZzuMe35UGhPmRYhVaihVtETFbQsG1L3rWbe4OT945BIF1shwuMHu33wyxqG+oJ7cyckgGdU/5Ga5DpAULPZ14FSGGUn27BX430w0VCscVd304z2WmzXcWCwivj3ClmMrgmUpl9OkJlyWKhaDjMk/H8AWSIc5iX9B+CXEqVgWPLF709jBpqV/n7P+2zzQviFaY4F2a8krgnSTCl3A3Uao7KDPjI5rWieUQIEoAQ0PDYWFQsu5qxGxFQ1YSrerzH+e4r2MQF9+Ls6Dp58wtdmpLeFMhedn/YKQBgz8K4J4Kw3+Y90Rh3MtoC03hqrvX2CYRdLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5732.apcprd03.prod.outlook.com (2603:1096:820:70::7)
 by PSAPR03MB5336.apcprd03.prod.outlook.com (2603:1096:301:45::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Fri, 27 Oct
 2023 09:34:44 +0000
Received: from KL1PR03MB5732.apcprd03.prod.outlook.com
 ([fe80::639:64cb:4cd:d4c1]) by KL1PR03MB5732.apcprd03.prod.outlook.com
 ([fe80::639:64cb:4cd:d4c1%3]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 09:34:44 +0000
Message-ID: <5837e8e7-b7fe-48cb-bd82-c8e3f042e500@amlogic.com>
Date:   Fri, 27 Oct 2023 17:34:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 RESEND] pwm: meson: add pwm support for S4
Content-Language: en-GB
To:     George Stark <gnstark@salutedevices.com>, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231016052457.1191838-1-junyi.zhao@amlogic.com>
 <10dcc778-f165-407e-b765-760d277d5e35@salutedevices.com>
From:   Junyi Zhao <junyi.zhao@amlogic.com>
In-Reply-To: <10dcc778-f165-407e-b765-760d277d5e35@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0166.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::17) To KL1PR03MB5732.apcprd03.prod.outlook.com
 (2603:1096:820:70::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5732:EE_|PSAPR03MB5336:EE_
X-MS-Office365-Filtering-Correlation-Id: 74abafa0-fe84-4991-1425-08dbd6cff3e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EFwusN4GmbvG7KZQk49ZXR0FrdTnttz6z4KgVuIdCSgTc/o0U9CjQ4L6H/vpLFKABi87dsQf2FoUZ1446KPXNYqBfJHTxlzvzQWBeJ1LRC2/NMI7Kp5UIWvM7VRaD6V5MqbcLdSWHXXBfuQfX6MhiezyVpGIyRiU6WfW6i68HLN8ip+mqTNxVoDC/HtQ24o7uoLvRnYIQhqUWSYgsr+9s3A+UamJvyCKiPY4mfQxFPiyCW/nHly5/jwm5PERrh1dmQMdZtVDrX4wyLhQkGhUnkC99oziSW42z4KU0QiLgXyOL013RNTZRr70wHTrZg38p0Fnbfns+RDddgcmmIioPURe0hA44hD6+fRQaWGTyQAk5ONjyQEZXp8qzIaW+o33/2T055mESHSEVoqRRDfZxYIF2l0BJ+a6XD7qUQvmeyjMOz8AxPdaOfdeZgP8xkLMBBASgJW1ww3SH1Igkfcyvub4DaliwbY7PN28bu34oW/gaQLcbvZoltshQRy+A5TMcULb/14dm9zaNiYeVclpGcqpGNp8D/6Hh1Iu25sLeZTk4p/2TVgQK11oOGFQcYsZfYAMXeNpmqZMRf4GVDbnRS039sxRPOeSgInWZ5KDug/G6T//DvWvcH+BnOko0kKhZT4R0UNFa90Qiq3pwXZRp6pkeKmjWicVuZY/PNEIg/2LdG76NeATdevEumxNOg79E/BOrO+C5nAIo0UqLQ4ybI8wtfJnSMChGHPgGagd947SkvKl9BhN0mksq9H5qx9G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5732.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39850400004)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(451199024)(1800799009)(478600001)(316002)(66946007)(66556008)(66476007)(921008)(8936002)(8676002)(6486002)(31686004)(966005)(5660300002)(53546011)(6506007)(31696002)(86362001)(6512007)(38100700002)(26005)(6666004)(36756003)(44832011)(41300700001)(83380400001)(2906002)(7416002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlU3RjF6YitGNzhrNk1obVRmRXBTTVFpelhlZW1NWVU0ajdBRU1hT3lRam9Z?=
 =?utf-8?B?cE1nS2ZTNk44M1gxdkZCSkE5bmZhbkx6TWd2S2I0eUVDYWp5ZkM4TGMxY2lD?=
 =?utf-8?B?US9nci9kZ05xVm9xcWZRbzNMaVd3dklYY0tLOFd5NFljRkZOdU1SOFI5ZEZy?=
 =?utf-8?B?VVdkSE9SZ1JHdjB6eVUrSU1PYnNwUTJDdHZWSnd3cXZiMVY2TmwrQSszTXRI?=
 =?utf-8?B?WEZqVUt5NHMrMnpwMURZTWlQU3lFWkhrZWsyK1pVdmxNRSt5SVI0ZG1kdEVP?=
 =?utf-8?B?OTRWd0R3ekJwbnh3c21MbUZLV0dGNXFSN1VESytvQXozUm1DN3BMeWFoTVly?=
 =?utf-8?B?RjlsbUpRNXlhVlRIZVMwQnJyczhRN0dYL1o4ZDQxK2tkOWczckFVMEdwY2pi?=
 =?utf-8?B?QWFnTDgyZ1I5SmJpZzJ4TlhkSjRYS1pYYjIzbU1zQWZsOUhKczNDcTd6Um9z?=
 =?utf-8?B?UkZoZkZNaGg5QnlQYnA5K1dkbjdUNWYxSlF6U1VVdUx6cWExeFVFMjJOSW5z?=
 =?utf-8?B?MEo1bUtFR2tGYXJ0NVowVDFZM2xVZ0dRZGY4ck1jTEJmS0x4UWdJUzJKZGVk?=
 =?utf-8?B?NXdzUCtGSTAvMmNNN25XZXd2VysyRW1EQS95RGQ5MG1qVkJqcTRNNWtkTWJz?=
 =?utf-8?B?em9GY1M2U1NReEJNckozZFBPK3c0Y2x6czBoTTQ1VW1VUktsQVFlRVRadjF2?=
 =?utf-8?B?OU5OSUMwaTluNGxLVTFtdHYxeWh4OE9lNHFhK0h0UjV0REhTKytLTHNFcU5j?=
 =?utf-8?B?cFdBemYyQkc0V0pMbjNQMERzR2ZpcjJ5bHRIM1pEbFVaeEUrOHdQeVNhSUFw?=
 =?utf-8?B?TGptR1lkSDFBQ0RUVUwrK0RFbStvSnB2NDRlVVdZV2dab0trQUFraGpJcVBx?=
 =?utf-8?B?NU1OYUtyZ3pVWTlKdUVLeFRkMTRLNlZrOEwxNU5lUENiQldNbk10NkhsWTRn?=
 =?utf-8?B?S2FqVFZpQ1lPMU9SWVdUc3NEV3JmeG45R09TS1psN0tTb2kvREZENTk2ZnJw?=
 =?utf-8?B?ek9rcWg3aTVKd25VekhCQ2hwZy9TYVRKRnVCMTVzd3ZZVkVxaklndjljc0FR?=
 =?utf-8?B?M2x1RlBFMmRYL3IwMVBsTWhjTGRGOGtEa2R6VG1hdXlHSnhqMkNKVVcrenhW?=
 =?utf-8?B?RWd3Rlh4Nk00SlB4Vm5jUTFSQ2paR2ZSbGpRcmRmZDRVeUlXQkYvQlBFOU5r?=
 =?utf-8?B?TG1KQU16Y1EzeHZ3SStQS3h5Yk1IdGdYQXVWdWxhVGlnQkdEMFMzTXlob3I5?=
 =?utf-8?B?Umx3aWRCbVo1djBkdHd2T2tnQ3FNVW1zVTBtY1NtSW1MTHV3M0poRk9RRXA3?=
 =?utf-8?B?dVJ1ZGRIYXZYRlVLNVkxUWtIT1FYd3k0LytRNTJRNXU5cHYvWm4xem1DZHlL?=
 =?utf-8?B?ckhUWnpCVWRSdHhTcVRuYlNrSEdKMENncGEzZlNhVS8yN0JEUmlISlZwbDdw?=
 =?utf-8?B?ZlFsSmgzdXVOY3JXODRNZ0t3OTBORDVnYVd0c1VKbU54N2tIOGpVYmNkYlgr?=
 =?utf-8?B?ek1JSW1oNE5mWG0rQTRzc25iUHVOcG5LM3pydHBzUVBxZFhiWkF4UGNiTkJm?=
 =?utf-8?B?aTNhQ0tSOXVzVUcwQkxpZS9DanR1UFkybEgxdGVud3V6NXc3RG45TjU4Ynpm?=
 =?utf-8?B?NTNMYkZZdUpCV0hnTW96ZXc5SkZQbFY3RVk0aWRRUDZPL2txVWdoU0J3VHpP?=
 =?utf-8?B?eGp5Z1ZaQnpWZzF5bW9tK2ljcU8yZU5uZG5kQnVCcVRGME5uWVZUd0RhSGdS?=
 =?utf-8?B?SEZiN2s0K2p0S2d5WnBkR3Fjdm1tS2ozV2lOcUlCbENMb3M2Tit5VDdHTHVo?=
 =?utf-8?B?amlHMElueUZvZ2F1eDUvZS9UQzBTVG8rdmtPaVpzZzNlSUVtOWsxdUVISS9N?=
 =?utf-8?B?ZWtHTTJPZmJ1UmE3TlV4ZCtlNjFkcVpTYlZnWUxJNGY1T09CZnNsd01qYVd5?=
 =?utf-8?B?YUlXejZZRkJRRE1qY3ZVV1FOUGN6K1g5TitkZk5ZR2gvTEdDeFVneEJGS2RR?=
 =?utf-8?B?c2J6LzRNS2hVdDB6aEp5Y29jbVFVMThiNEowRXJGQ1hXMHdaR3RLNXdjS2hD?=
 =?utf-8?B?RHcwcmpZNnl4QkpVdjN4eEtyN0Q5ZWxnWWZEd3hBdFhrWjloWlZNWXNjQ3BQ?=
 =?utf-8?Q?KprHVm0hhj2ZADJ2uXdkbZKma?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74abafa0-fe84-4991-1425-08dbd6cff3e2
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5732.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 09:34:44.3251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9bUqcQflvRFJovt5KX/QC88uZV0tHABfiiGSSr6s8JPhTHq1FiGvBngT3RwmojMaPcTkD2Vp/Rsms9maJzl9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5336
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George, thank u for your review.
I will change it.

On 2023/10/24 4:07, George Stark wrote:
> [你通常不会收到来自 gnstark@salutedevices.com 的电子邮件。请访问 
> https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
> 
> [ EXTERNAL EMAIL ]
> 
> Hello JunYi Zhao
> 
> On 10/16/23 08:24, JunYi Zhao wrote:
>> From: "junyi.zhao" <junyi.zhao@amlogic.com>
>>
>> Support PWM for S4 soc.
>> Now the PWM clock input is done in independent CLKCTRL registers.
>> And no more in the PWM registers.
>> PWM needs to obtain an external clock source.
>>
>> Signed-off-by: junyi.zhao <junyi.zhao@amlogic.com>
>> ---
>> V2 -> V3:
>> Rebase and Review the latest upstream code again.
>> After reconstruction, stick to the previous code as much as possible.
>>   drivers/pwm/pwm-meson.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>> index 25519cddc2a9..fe9fd75747c4 100644
>> --- a/drivers/pwm/pwm-meson.c
>> +++ b/drivers/pwm/pwm-meson.c
>> @@ -99,6 +99,7 @@ struct meson_pwm_channel {
>>   struct meson_pwm_data {
>>       const char * const *parent_names;
>>       unsigned int num_parents;
>> +     unsigned int extern_clk;
> may be bool extern_clk;
>>   };
>>
>>   struct meson_pwm {
>> @@ -396,6 +397,10 @@ static const struct meson_pwm_data 
>> pwm_g12a_ao_cd_data = {
>>       .num_parents = ARRAY_SIZE(pwm_g12a_ao_cd_parent_names),
>>   };
>>
>> +static const struct meson_pwm_data pwm_s4_data = {
>> +     .extern_clk = true,
>> +};
>> +
>>   static const struct of_device_id meson_pwm_matches[] = {
>>       {
>>               .compatible = "amlogic,meson8b-pwm",
>> @@ -429,6 +434,10 @@ static const struct of_device_id 
>> meson_pwm_matches[] = {
>>               .compatible = "amlogic,meson-g12a-ao-pwm-cd",
>>               .data = &pwm_g12a_ao_cd_data
>>       },
>> +     {
>> +             .compatible = "amlogic,s4-pwm",
>> +             .data = &pwm_s4_data,
>> +     },
>>       {},
>>   };
>>   MODULE_DEVICE_TABLE(of, meson_pwm_matches);
>> @@ -451,6 +460,16 @@ static int meson_pwm_init_channels(struct 
>> meson_pwm *meson)
>>               struct clk_parent_data div_parent = {}, gate_parent = {};
>>               struct clk_init_data init = {};
>>
>> +             if (meson->data->extern_clk) {
>> +                     snprintf(name, sizeof(name), "clkin%u", i);
>> +                     channel->clk = devm_clk_get(dev, name);
>> +                     if (IS_ERR(channel->clk)) {
>> +                             dev_err(meson->chip.dev, "can't get 
>> device clock\n");
>> +                             return PTR_ERR(channel->clk);
>> +                     }
>> +                     continue;
>> +             }
>> +
>>               snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
>>
>>               init.name = name;
>>
>> base-commit: 4d2c646ac07cf4a35ef1c4a935a1a4fd6c6b1a36
> 
> -- 
> Best regards
> George
