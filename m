Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7D77E32FA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 03:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjKGCdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 21:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjKGCc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 21:32:59 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2068.outbound.protection.outlook.com [40.107.117.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A7C10F;
        Mon,  6 Nov 2023 18:32:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeBze1FNxGEPIRjVIYm+XmlBa3B4VcsDJEp1pPjmcvPKi+qzQmsnyXo3GCTW3xh7/uJiO141an/5NOuZ201cCQx2n4Gt7zyZWJJ8rNJLd9d2+x6uvYS5LRsCVT5bDiFiuoZ8VbLvSoMAXdkM2Tcau9DjuepdSazmnwh5PeC6LKdhAuqCGio0LREEH5xGhSYFw32umyNTJLS3y9rnaVdvLgr+hyY1ZqLlmMcjLkktWhcPEhp8P5hrkZm9yCXPj6Bx34VPQo1qh5/QmQEd6NC33qXpBYXoIXtgRCACYb2S80cAMi+CJs5RbvEis6pHLmUoEjlgDN/t3ujIDY8ZEQT9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VH7MZMkC7l7hMIS1j8vw+n34SNG13UkLmvc6xTfbg3Y=;
 b=ADAbEdX9jpu5WsPVs8JxpZqBRnl5f9l4JHZrPhYkCpTK973jmt0SfUEMdJUI8K7JvWehTVbevgMSSzHW9k2K/eDwprXmjsR2Z7ZEQNo2dL6+X0+Sh6/Kw0ZkefDM/2HxhN5OLVCpDq4F9uE//MxgVfkIHZ/72SZZqqml8Z3rI48QgPDJbf41Zf4DVwVSZm+FkYaqW9NxQFq8DpSL1g+g6aCaugi7pHWR073mMOQIIYbXqMN0oVMy4TJh8B6n/AtAZkc2ipmWA1DgCPT1sJBVpVlaCnibcfKJyohCsZH5JSbQxEGCiqT88FAjqZuj8XcGub3R+tnS5Lepgvh3LBPOYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VH7MZMkC7l7hMIS1j8vw+n34SNG13UkLmvc6xTfbg3Y=;
 b=D9GDA0XGA+psvNfuIEpAZJP7/g2BapsZtn9ut72RbWWkj6qujB7ZNDDV5gZu86O1jzfavs1/fQSCsZV38nDL2I5eemhPXkn6+NK/nhbarrtNDZgVTRfltsVENAZIL6BlZcDekQOYRkZpMWlraX0acWg/ZzfKTsNsnTkWb4sB5c8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
Received: from SL2PR03MB4348.apcprd03.prod.outlook.com (2603:1096:100:5c::17)
 by TYZPR03MB7667.apcprd03.prod.outlook.com (2603:1096:400:428::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Tue, 7 Nov
 2023 02:32:52 +0000
Received: from SL2PR03MB4348.apcprd03.prod.outlook.com
 ([fe80::6e67:b9c9:aef3:6759]) by SL2PR03MB4348.apcprd03.prod.outlook.com
 ([fe80::6e67:b9c9:aef3:6759%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 02:32:52 +0000
Message-ID: <1f4666c4-ad5d-bdc1-1d86-ddf5fc824a12@nuvoton.com>
Date:   Tue, 7 Nov 2023 10:32:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: nau8821: Add DMIC slew rate
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        YHCHuang@nuvoton.com, KCHSU0@nuvoton.com, CTLIN0@nuvoton.com,
        SJLIN0@nuvoton.com, scott6986@gmail.com, supercraig0719@gmail.com,
        dardar923@gmail.com
References: <20231101063514.666754-1-wtli@nuvoton.com>
 <20231101063514.666754-2-wtli@nuvoton.com>
 <20231106144141.GA312869-robh@kernel.org>
From:   AS50 WTLi <WTLI@nuvoton.com>
In-Reply-To: <20231106144141.GA312869-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SI2P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::11) To SL2PR03MB4348.apcprd03.prod.outlook.com
 (2603:1096:100:5c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SL2PR03MB4348:EE_|TYZPR03MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc2e9f1-22e4-474e-05f4-08dbdf39d705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N4QKv+9xQmTS6YatpVT08//NgiJdciEBXrfye72kZIGAUnyYrjhdVTblg4aLQA/BailViBdCg2R+9sSANoy2tGJrnPSxDRR9jksHpZs4X2x+n/F/XgYViCWxYNB2C8Q/bIImiYJIdU9Kng41L5SG9csGdQi3NAjOGPaAgvYAVpqNnR+GWAE5yrfA2avvhTrwEKVXDQYapzK/Kzmh1SrixUafdeT9etJhluY5MsIQuW0XUawEyYoFokjBAKvK/NoCWwg2oWKWPWCgozVSxUzMS820qyUqMFTIoROBjB4xSw+u6wMLcJOjLv/f8myy9HxafF9xfpjakheIwRXB7UqzIOltD5gYU96cV5iX95y4L9yE+y1OEmqiVjdL0qG4jQBEOTbP2R6YTmbIqIMEo0zEO0MNtuHrxOTppJ9lgMpzlaEZVdWjDCHeVHf7fVd18tjt3JLMW8zOYfpL9hFfgHq1jo1TTHZoe/2Pwiqh5PWC1bNqi7MTWqQxonUzisKbhw7/RQ7/VN4xN21eYLpVgb8uCP7o5bNLqVRelrd8kCRNrTzTJ/bOPvUXQHTqv7hxHs4MdSrTShrJiUZuInOdm5X4qw7uO7sWgnzePZZX/DsMxpnhWQ/x7Vd5mFlcIhPVJ6skjGXbKYkPMss46vpWo9Xo2EIZzBt+2WYUCMdwqBp1cyjJ8BnpjTPSyOcvHuGSB3+HZswRdyGLzwH0LG/IaUD5HZjiT2BZZVdD7jJWPydaFBuugVnlta6+t/ud8UxYcQiG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4348.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(376002)(366004)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799009)(186009)(64100799003)(66556008)(7416002)(5660300002)(41300700001)(2906002)(38100700002)(36756003)(6916009)(66476007)(31696002)(86362001)(66946007)(6486002)(6512007)(2616005)(26005)(6666004)(6506007)(53546011)(478600001)(83380400001)(4326008)(316002)(8936002)(31686004)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0x1Qi82OWE3NjJSZ0RFei9CTm9NeXRkTTFoOG1meUlCaGtsWVFHVXFrSWVK?=
 =?utf-8?B?WkFFNkgwRDZRd3g1dzBEQkQ4Z2hzbGFBUnl3aTZIUHd3NW1LVEhsRzBXTzkz?=
 =?utf-8?B?b3hnVUhYMnk3WXpCUll6UFVFaWRURjUrMUpzbmxYbnlNQlVHZjI0TFJzQ0VL?=
 =?utf-8?B?WVo0Znl5cHVaMUNocExoM1JzeGZrTllNdVVJSGNsUTBFai9uUjlsR3NsS3pi?=
 =?utf-8?B?UjUrVi9TK3UrZTEvYnhmNEhYTGdiL3RYTXdMQXlvOHk0QmZzdkJiYitZRGZ2?=
 =?utf-8?B?REtXb3RTa1hEUGU1MTMwb2xiNDEzeDY1dlJwemNCUnBEMENwcUg5ang3aysx?=
 =?utf-8?B?eE5TdmtDNzQxSnlZemx6b1ZqVDBGYlNHcDB0bmJqUlBzeW5QcDcrVDc2SnpO?=
 =?utf-8?B?WjlZSDFXaElEK1BCaVI2Nm5rcForOWsyZDlhSVh2RjhteExjZ2xCZStXTnFx?=
 =?utf-8?B?bXpWR3h3dVVaQVVnNmtiWXlTSmRCc0xQM2ZWSFg1S1E4VTl6OTlqUHNISkM1?=
 =?utf-8?B?ZVdzRXYrQlFIYStJR0ZlT3ZaWnRPbTVIajl5cnZMUUNtSnhhUk5waEFRdFo3?=
 =?utf-8?B?dHcwREY1SjBIM29uZTNxVENLc1R1eU9lVE8yTjdSOGxYZnZXdUozRGk1S09i?=
 =?utf-8?B?aGFvOWNXdWdEZGFOZGZrT2FlY3lmT0RKUE02OUZ0R0JXZm85SFJCem1hRU13?=
 =?utf-8?B?YWQ2a3JaZFVUM1p6RHAzQ2Y2VVBzTTJwWkxFTGJjMDhic3pEM2ZLMEZTNzgy?=
 =?utf-8?B?aHJqMUdrOWNEUVc1Z242NVI1STF6WWtLbG9CYU1Md1NsSk5hRU1ZOExGemxX?=
 =?utf-8?B?YjNuQzVkekxHUC9sU1p2TzdtL2RXdnVwWVB0UG9OSnBUQXhUV05Odm54dERv?=
 =?utf-8?B?NWNuNTg5aVlyemM1bkhNcXdyQU01Rk9SaWFUQmt0Tjk0aXBvb25JYTA5Uy9w?=
 =?utf-8?B?QlliNEdZSzB0MVBwcjg3Zk02OXQ4YmVTbStYWWVYbXQ3bVV2K3ZGQzNpa0xO?=
 =?utf-8?B?SmhUczMwL1dUdmFMWktRbFpkMGdGWE1GQzRxSUxKeTcyZkw4eFVIM3F0S1Rm?=
 =?utf-8?B?cG02dzlQUnlYNVVNb2FQV2w5ZExDYVJPUmVJRWI5eHpzUzZ4Nm0veGJiZ09n?=
 =?utf-8?B?Y0J0SEppdTl3T0gyWmhxdGRBc2Z4SDdsRzJVUmVlcVJCbFhnOTJiRG9Mcy8v?=
 =?utf-8?B?UXVERmE3OEtlKzBndjQwbVJEazM1K0s5aDROTFh5aEQxZVhiYkh6TzkrT0I2?=
 =?utf-8?B?cGpiNWp3N1YxSUFXYlQ2cTlRL0ErRFVJcU1MNlN6TmtDNlROMWZPYzFERnV2?=
 =?utf-8?B?TnJHNlR1T0pOdjRBTi9ZZ0ZEY3dLL2V2RThweUJkMXhub2tEN0hHS1ZQeEQ0?=
 =?utf-8?B?YnNZaTlIcUlDbjNQdmMrR0cwRHY0SEgra1pqMHZOYnZGZVBuVmp6c3htVkhW?=
 =?utf-8?B?Z2VkeSswNkk2UWd2TjdwTDdFdFBaVnVnNTB5eDd0Wjd0VVo4dCs1K24raHdw?=
 =?utf-8?B?RFVDQXY5NzVubkF0alZWclovMWQwL0lLN2VEM0R6c3U5bGN5Wk5LQVp3dUlv?=
 =?utf-8?B?NXJ5OU8vRHk4ZXlsdm1sNXQyNGxSZzc0cUNNa3BQOHZEbGZYcXlaa0JsZkVT?=
 =?utf-8?B?d25IMTlKallLbnRUV3gvVUN2b1JDTHFkbTFjZ2FxeWV3dzVhOVdWa0lJcmFR?=
 =?utf-8?B?a0pIc1MrcFV2TnBjdnNqOE9nTzB5WDJwR0p1aUs1Um55ZkxKMDVCZlN0endj?=
 =?utf-8?B?eGFHM3Npb0VEeXd0dllycnNQTC9UTnVMeDhxakQ2eHFJMURwdFpBTXhObEl6?=
 =?utf-8?B?OWRzYmIrNU1KTjdlVWc4aDNMMW5kM25RUWMxdUp1VXNSNHB6MGhGdGRnRWZB?=
 =?utf-8?B?aldpTEdBcXRxTklxa1hDUE9EaUw0djU1SkxtLzI5ZnBxb3RIVzhDcEEvN1kw?=
 =?utf-8?B?bXlQYjY4cWxHeEZSdEF2OHB3dWhwenhTcXlEem9ZNmVnb0lZY0pEMktVdkVB?=
 =?utf-8?B?MmI1eUNtWGVJUTEydzVaQml5SzlqOHJwa3NlbDZsYWxSeXFqT3ppU2VjZEhW?=
 =?utf-8?B?MkdXbHgyTVJwNStCZFVoVGRQbVd1elpRTkdvSVRBdmFxZjc2ek5NeGVDNERB?=
 =?utf-8?Q?PhSOeNuL5wiBatfZYQ651uvYo?=
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc2e9f1-22e4-474e-05f4-08dbdf39d705
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4348.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 02:32:51.9278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2nu5Mr918mLHgYhUE8pGPOhuZxugKwkHU+jXY7v4z8el/ZyekkqIRPTn4saeo5cx2iBNahMcz7/GBUME/M3tHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7667
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/6/2023 10:41 PM, Rob Herring wrote:
> CAUTION - External Email: Do not click links or open attachments unless y=
ou acknowledge the sender and content.
>
>
> On Wed, Nov 01, 2023 at 02:35:13PM +0800, Seven Lee wrote:
>> Add input with DMIC slew rate controls
>>
>> Signed-off-by: Seven Lee <wtli@nuvoton.com>
>> ---
>>   .../devicetree/bindings/sound/nuvoton,nau8821.yaml        | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yam=
l b/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
>> index 3e54abd4ca74..48c389276a15 100644
>> --- a/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
>> +++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
>> @@ -89,6 +89,13 @@ properties:
>>       $ref: /schemas/types.yaml#/definitions/uint32
>>       default: 3072000
>>
>> +  nuvoton,dmic-slew-rate:
>> +    description: The range 0 to 7 represents the speed of DMIC slew rat=
e.
>> +        The lowest value 0 means the slowest rate and the highest value
>> +        7 means the fastest rate.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    default: 0
> Don't write constraints in prose:
>
> maximum: 7

okay, I will add maximum: 7 description. Thanks.

>
>> +
>>     nuvoton,left-input-single-end:
>>       description: Enable left input with single-ended settings if set.
>>           For the headset mic application, the single-ended control is
>> @@ -127,6 +134,7 @@ examples:
>>               nuvoton,jack-insert-debounce =3D <7>;
>>               nuvoton,jack-eject-debounce =3D <0>;
>>               nuvoton,dmic-clk-threshold =3D <3072000>;
>> +            nuvoton,dmic-slew-rate=3D <0>;
>>               #sound-dai-cells =3D <0>;
>>           };
>>       };
>> --
>> 2.25.1
>>
________________________________
________________________________
 The privileged confidential information contained in this email is intende=
d for use only by the addressees as indicated by the original sender of thi=
s email. If you are not the addressee indicated in this email or are not re=
sponsible for delivery of the email to such a person, please kindly reply t=
o the sender indicating this fact and delete all copies of it from your com=
puter and network server immediately. Your cooperation is highly appreciate=
d. It is advised that any unauthorized use of confidential information of N=
uvoton is strictly prohibited; and any information in this email irrelevant=
 to the official business of Nuvoton shall be deemed as neither given nor e=
ndorsed by Nuvoton.
