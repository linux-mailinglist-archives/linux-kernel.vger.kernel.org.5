Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536337D787A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 01:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjJYXXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 19:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJYXXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 19:23:30 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2088.outbound.protection.outlook.com [40.107.8.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C80EDE;
        Wed, 25 Oct 2023 16:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSWAEowkZ3sWJutIDHThrIwz2ZSEUpkzQS7ND6jb22n64f4lnE2qvoBHLC2SbO5xatJKf/Yl+BP9aP+159D0VprNu3k+g9rsXiDU8w3GkuotNH8cRWRdOo+SfcT/Jp3QB5B8tUwYkWn6hWMhUx0I25mW9CvjrEXrPPCPXYH6Tp7LXJf9Gxu7UYR09TOTNCyE7ueUElDZ76ZyB2BCsVoBMNGJA9nd3EItwfZARRUaYL7x54MvLHYjwUDFBDl4YfPefpFLYaf0H6P0OcMSKVvDx3aJgMSOq5jiRI2rAPUloZoFiup9ys9K4OVb97RfXZA5y4n11RO7aEyJlFloHE/b0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bc3/NXvbiTSvDWfHsO5MBpvxp+ls5Je/W5znP1QKeuA=;
 b=H+UZ5BtUYWEq0D/MecGJiePInzWSkm1hupSEsADnyIsyaPzAHAKv3oJB5StcB98cr/6qlOCRK6/gCt1iWU4bTdVk1ejYNbEQU+Hk+HDdjHaMXJ/rZ15hyRex2bS4GpIw95DUjo++ZF+7zI+ROlvZai6G496SahcECmDcX6ml0V8UMlRB6vC6fbRygvhv/ngYCzc4Vu/w3mtvlv7is4UR/h+wtTrPcGuLEkR6RkXf7i7hnHBkVdjFyvpWO9ameV+PKvdqYryYX3lPoHhHZa5smcSa7I1XyM4f09UOSYgVQLMx6ytKYfpcEVZs7ItRxxvi3WwRGQsBov9ZE4Y9XNpYgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bc3/NXvbiTSvDWfHsO5MBpvxp+ls5Je/W5znP1QKeuA=;
 b=JGwFVM/a5OQBS0PM2m46jUSauL3aG9iUBqspx5f8PcKhhcQUq3vBAL49RNd2XaYJ5Kir9kGI34K8BrS1swakUYga2kuPyBmefKSb+yaoF7qpDeCHs6tEUNiw3W6Y3PQtDNwGr0g7+JLqYOgRuiws5sWkAEysQC66yXN10L09djU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AM9PR08MB6098.eurprd08.prod.outlook.com (2603:10a6:20b:2d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 23:23:24 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a309:1d65:f5fb:436b]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a309:1d65:f5fb:436b%6]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 23:23:24 +0000
Message-ID: <1c4a6185-fe09-45d1-900a-10abf48e3fc9@wolfvision.net>
Date:   Thu, 26 Oct 2023 01:23:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: rtc: nxp,pcf8563: add hiz-output
 property
Content-Language: en-US
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20231024-topic-pcf85363_hiz_output-v1-0-50908aff0e52@wolfvision.net>
 <20231024-topic-pcf85363_hiz_output-v1-2-50908aff0e52@wolfvision.net>
 <20231025222327c0b5d460@mail.local>
 <2f17c031-30f6-4242-b2a1-1628402b3091@wolfvision.net>
In-Reply-To: <2f17c031-30f6-4242-b2a1-1628402b3091@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0168.eurprd09.prod.outlook.com
 (2603:10a6:800:120::22) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AM9PR08MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b3d493-28e6-4743-ab03-08dbd5b16221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NYGeocQrcAPckuDkgMwgsWVCZiR+5bSWFeqSB+NbxtG60WfYCP0jkiK7fBN5fR0+juc0XcrkYMne4dgLEtJ26/p3L6Hs98ZTwkwzp76HQ/gGGq5UqH46EcnVb5skGFwumPzCdrTKNdafgIVVXXj9ey90X0xdCmUpKkyqpGHuBUJ/+YTzj9cZlKCov5TVNo55yUEwpnylyPfMn2OdPDGa5Z7cKMpNARwlL2tTJ2HGYN4ukW4UDQTHVgqKT+fPGgDWvqkNOKjO7gWh5ajvqdGS3lZLNTg39WRt0Iro2ssnRIdn/wmiy/0tF6U9flFaTMOsKIadzG0MsXGtEkn2s4NcVWcVM4g2JI6hUX43mjejuRlfgzPIj6NewgRFrIgtOZM3T0t+p1/mba00l+MQCF6olZljQQ34hXhntsdtqVyU2CIOPWpJiKcXGPtAwqblQz/TKqh0MWwPanX6S1NLYELDC+ImwFw6q3LLZSQDyC2/j5cv9yhqWFPgiQBJ5w2cYpp85ijcNII+8ekSSggUriUdj1v+j3DeU4Jbc4MvcnZRAsEy+MqHbAvdSOkcKoQThVcVYpITh+mtMvirRWu+BGXHwkcNguYfkhljdcxhzDu4QY8Mhqx2QpS8Ht43y45j3urh7vedMhnNCwlB8dKv2T6B9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39850400004)(346002)(136003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6512007)(2616005)(31696002)(38100700002)(36756003)(83380400001)(86362001)(66946007)(66556008)(66476007)(54906003)(316002)(6916009)(8676002)(4326008)(8936002)(44832011)(41300700001)(5660300002)(6506007)(31686004)(2906002)(6666004)(53546011)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a01QSTB0L1N3TC9PTFJaRWV3UHViWXRHTEtrYU1VOHNhWUFkeE10VG1sWG1H?=
 =?utf-8?B?c05UMllMSVpQb3pWZkRnZVJnb3grZExsWUgzdTBza1N4RVdKajlUL3JTeWJq?=
 =?utf-8?B?OHpLdXYzSWt3Vm1MOXRiT3A3dnc2MDF3aWpOY2ZFdDA4YktpbCtxSGlaYUlB?=
 =?utf-8?B?STFmdXgvZWNzUWc4RWV0NFBVMDBOc1JIV2FGUWR2OUloWGdEdjZVY2lraUtx?=
 =?utf-8?B?cTdEbFZKZnlIQ0NZVmYza0NQV25UWWVjZkkvckhkYkpzQUVjUnplc2JIUFNy?=
 =?utf-8?B?TmsrMnZ1VENaUFNtc2grWDF6VXYzUHc1T0FvWjNveFlSZ1llTnl4UXJoeVds?=
 =?utf-8?B?a1E1ZDlUdk1yejVhUjBVRStOeEpQMlZNVHV6Y1ltbjZzZ3V2ZmNBcGVnbjV2?=
 =?utf-8?B?OUZjWi9kazdXNmlZR3UrcndqdmhldWIwWCtrblZHYWo4MGJCNEZhWHFFZ3pF?=
 =?utf-8?B?MlJwTCthZVdHdVZUaXVHQlpsc1RJaXErY3dpYXg3VUgzWVdkaFMzSHZGcTF0?=
 =?utf-8?B?QW02V3ZMTEwveitTcHZpcldBZlhsWE1qaGVMUHhNYlpuVFA5RWlleVJYdkts?=
 =?utf-8?B?MDhXbWdVcWVQRCt5QlMyYjBjS01JNW4xWTJFSmZabFpRZzljd3ZOcUM1ZVZQ?=
 =?utf-8?B?YUFQY3VTK0ZwVExlSndpRWYrSGs3UTBkajFqTDlwL0pGeTBaMjBWVURYdm1i?=
 =?utf-8?B?WTIrZWdONm5PaXMxT2w3US8zcDBsMWNDUGQ1aGNtSThJOWZyTGFWcTZ3WTNR?=
 =?utf-8?B?aXpZekNMTkZjd2xDbmkvR0pZcUxCTkovWGQ1cDVVYjg1Nk9UbUMzVEtyN3dl?=
 =?utf-8?B?aFV3a0ZJREN2YVhFRXQxVS9nQkdpQ2xyMjZwcmVFS1BFQVJMUm9BTS9DTmtF?=
 =?utf-8?B?cGpQQjNXU2c0UlR5ejZLZ3cxRTRQQUdBNk9ERUJvZVVXVXVEaVpQZ1grQVFq?=
 =?utf-8?B?NEhhdi9EeG82VHhOT0J3c0xwVHRXeXoxVUNCc2Nrelh0Tks2VTdnNm5EZ3U0?=
 =?utf-8?B?cnN2NWZGZnVyRUVtdElMblZLT01pMkx2THA5UEM4dXpsYlRtS01DRC9COUFW?=
 =?utf-8?B?cW42QkpRbGllWmVwMStmMHJGVlg0RFE5N1hDUEZZUjFBUWhqYXlUUzdtTEhB?=
 =?utf-8?B?dzR4S0VobHpQTmpMSDhWWGcyQ0h4T2Q0OTkyL09pTDROQkhIVDBiQ00rM2tV?=
 =?utf-8?B?QkYrbnhWNzg1UFdaYjlUVm9QWSsydmRHMUNrZXl1VEFXeithUGxXNTdKMjVD?=
 =?utf-8?B?dnpFR1FySGllRFRyMnZFYTMwb212QWJoUTRpZ0xSeW1jaTVuRXVzeWJGQ05o?=
 =?utf-8?B?dEZrUU9JdTFUVm9qMGNMMzE0NC9PUEpLSGtuMk5xNHhXVjJXRksxTWx2MDNN?=
 =?utf-8?B?aEFtS1hSelQ0L1ZFRmVXd25pY3RGK1pHV3RHNlN2Q2FxRWM0aDVvRXZYeTV6?=
 =?utf-8?B?Y3pRSVdhUlVFUFl5VHpjRDJuN0tKR1RvTmFaQThQMTQxZmdDTVFrNXYrUlM4?=
 =?utf-8?B?NHQ5L2xCUy9CSkVRcURza0pZTlpLbHVyMWkyWERrMllaTnhYc29oOFdaNUVm?=
 =?utf-8?B?M045bU5LQWxKMlN1VEZkZ09MbTAwazlrZ0FPRWNuRkkzQnN1czlSOFBKRzRG?=
 =?utf-8?B?RnpZQU9OTUs0NlY0SWNUNU5tcXBxUTNmSy84YVpSZHZiclV5NzhZQSsvdEVX?=
 =?utf-8?B?emVtMGQ1emRzZW05dU5KQkZlRm5yY25VbGpaQ3lDUmZGa3owVHRFOURYd0R0?=
 =?utf-8?B?c25QOG5xQzJzUjh3SlQzQmVXSGlhSDcyN0VJYkZnVmpVcFE2c3QwK0g3QStj?=
 =?utf-8?B?Rkd1TXdXMGs3d2lxQkhNZlhqcDJHcm5WRFZlVEpYOHJXYWZKYjJEbHEzMnla?=
 =?utf-8?B?Y2pvUGtGZ0pFVEhnT1U1ZTJSTGpKOVB2OXh4WWYzMXVCNzNHZXVzczI4Z0lE?=
 =?utf-8?B?N21XTU9BY2RtdDZyUVRaSjZ1SStpc0ZFTWNxRkN6OWVKcUQ1MHRLc1lRRjE3?=
 =?utf-8?B?aE9jTzdYUmdpeFBaQVhyblV2dHhSb2R5VWRVeUtRbGFBMkU4WWQ2MjZLUWNU?=
 =?utf-8?B?eXBvT1hXSkJNV2hyVWJnQTJkbFQwSklrTVp6ai9aY0M4UW9tZUR4ZCtuVVoy?=
 =?utf-8?B?YkpTYjBEaDhFWm1tSk5majlsb3JOY250OXFQaVB5cFBoQVMvN1NYcmpSMUNV?=
 =?utf-8?B?YkxVd3R0ZjFtdTRiWHRrMzhaY3VkYWJXeWdDWjlldkdSdGloN1dkSEtCQzhl?=
 =?utf-8?Q?yZTC6ARRaUOx/K/flL3BY42biJ6xxB1UFY7XEzDf8M=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b3d493-28e6-4743-ab03-08dbd5b16221
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 23:23:23.9063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgBg/ZkYr4KmhleK0+fSnR53RZC7DxuKwk8cocVKY8nBtU2txcErFfX2uZhnRiYVyG9I58nRbpFFm3iBylULMdmNbuWK4dy5nB/c+Fh9Mcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26.10.23 00:30, Javier Carrasco wrote:
> Hi Alexandre,
> 
> On 26.10.23 00:23, Alexandre Belloni wrote:
>> Hello,
>>
>> I'm sorry I never replied to your previous thread...
>>
>> On 25/10/2023 18:21:55+0200, Javier Carrasco wrote:
>>> The "hiz-output" property models the RTC output as a high-impedance
>>> (hi-Z) output.
>>>
>>> This property is optional and if it is not defined, the output will
>>> either act as an output clock (default mode) or as an interrupt
>>> depending on the configuration set by other properties.
>>>
>>> Two modes are defined in case the high-impedance is used: "enabled" and
>>> "sleep". The former disables the RTC output completely while the latter
>>> keeps the RTC output disabled until the system enters in sleep mode.
>>> This option is especially relevant if the output clock is used to feed a
>>> PMU, a PMIC or any other device required to run when the rest of the
>>> system is down. For the sake of completeness, a "disabled" mode has been
>>> added, which acts as if the property was not defined.
>>>
>>> Document "hiz-output" as a non-required property.
>>>
>>> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
>>> ---
>>>  Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml | 14 ++++++++++++++
>>>  1 file changed, 14 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml
>>> index 52aa3e2091e9..4b27a9154191 100644
>>> --- a/Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml
>>> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml
>>> @@ -36,6 +36,19 @@ properties:
>>>      enum: [6000, 7000, 12500]
>>>      default: 7000
>>>  
>>> +  hiz-output:
>>> +    description:
>>> +      Use enabled if the output should stay in high-impedance. This
>>> +      mode will mask the output as an interrupt source.
>>> +      Use sleep if the otuput should be only active in sleep mode.
>>> +      This mode is compatible with any other output configuration.
>>> +      The disabled value acts as if the property was not defined.
>>> +    enum:
>>> +      - enabled
>>> +      - sleep
>>> +      - disabled
>>> +    default: disabled
>>> +
>>
>> If instead of using a custom property, you consider this as what it
>> actually is: pinmuxing, then everything else comes for free. With
>> pinctrl, you can define different states for runtime and sleep and they
>> will get applied automatically instead of open coding in the driver.

I am not sure if your solution would cover all my needs:

1.- With pinctrl I can model the SoC pins, right? That would not stop
the RTC output though, so the 32 kHz signal would be generated anyways
even though the SoC would ignore it. That is one of the things I want to
avoid.

2.- What happens if the RTC output is a clock for an external device
that is only required when the SoC is in sleep mode? In that case I
would like the RTC driver to control the output with the modes it provides.
>>
>> Also, how you define this property means that everyone currently using
>> this RTC is going to have a new warning that they should just ignore.
>>
>>
> Thanks for your reply. The warning can only be triggered if the property
> is defined, so in principle no one could have that warning yet. Only the
> ones who actually define it and use an invalid value would get the warning.
> 
> On the other hand I did not consider your approach, which might make
> this patch irrelevant. So I will have a look at it to make sure that it
> achieves the same results.
> 
> Thanks again and best regards,
> Javier Carrasco
> 
