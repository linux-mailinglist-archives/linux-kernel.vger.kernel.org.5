Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9ABE7AFA8D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjI0GAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjI0GA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:00:28 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2123.outbound.protection.outlook.com [40.107.215.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC43CCA;
        Tue, 26 Sep 2023 23:00:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7XPoSA/YIv8/1EE2EWEbF61nE9bmauPtAH1Aq2WZ+DgzrORi9nR38CWG8UtUXCCiR+2Td4MSq+2YUTTP2mbrTaD2MG6zkpqd5bOEWbgTx32Ng8iTlMdSz1rJGCtRwJTC7mWEIaQEdhxuGLnsws5BFivsAlhyfxfluIkK8m8HSZNoWIcqdFH7XFnri9/Y9EyjW/CPsgcQdGfXb+wvaIibSQ9j0yjSDiHmzAyFZjoU62eR8rahyIDd+aCyLvS5BnZVq2iMcgcg0d5iKD+DUIGsUSyA8d1bttEc9nfidpXysn+x6159NyZrZesdGTI5y+3jC0prkOKMqIL6ufQSjgdTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clz+ZILq1DBQP+Gl904P3WQM8/uYqSCpRBnRzZ5pahw=;
 b=FGC4sBbXc7ckw2JNMwGXIdjm3a6KK9lxJ7TIQSHRwMAq4As/XlzE+4xkd61gA4Ud4tFfi/3bpcz25L/s3ukJBzu/2E9VG3LPeMCpEqqy0S2/VmbW2WY4dXwNiiqUCC9Polg+Oq6YhC9mwJnq6Ti0H1psJqhBuCRT3BW16nCW24P/s+p0BOKlLZZvxMv6DGEceaNB546zS/FbFdKKp0liOlRSLp4Vz2/JaaPH03Vs6kEMAijbU7+D+OU4v8wz1HYhJr427sKrDI8w5TL2hHHjWW36egdVUqeFNbEqGfulji2GQw4/tyBt9jjPEPNcyF4kdfV22t6bkGzsr11nJHkL6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clz+ZILq1DBQP+Gl904P3WQM8/uYqSCpRBnRzZ5pahw=;
 b=Hmp23Gh8p9SyT/yC02FOT3F/qDUbAjQ6KaktiSl4r+sEdS8hVd3/aj3idWxVLYfjxLg6swzDp9VDB5EVv7+0HTBrVgQ72Q7tkUxg9M5V1mS57SaTLgCYih6w7RtNGJRjIvmkbeFU2ZXPMAuiij4i7BKgHEcx1OzHE42wYtT0o55kBGLlLJGAf6qygGwvyfe5sgjAAicA/vjrFxrrwoynfupjwtov8Q9Iwrnxyo3AppIPajWnIaEN1W+BnqdkIftIEfnoyCs0tVi/tFzK/EZLcu4fk1gRatxiF5ZjVpxliv/iLhdQTbZYVBdj4zIFkF7/pszBN3uozcxeaEu+4b7LOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SEZPR03MB7220.apcprd03.prod.outlook.com (2603:1096:101:ec::16)
 by SI2PR03MB6637.apcprd03.prod.outlook.com (2603:1096:4:1e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Wed, 27 Sep
 2023 06:00:11 +0000
Received: from SEZPR03MB7220.apcprd03.prod.outlook.com
 ([fe80::a6a7:387e:2f4:6e8c]) by SEZPR03MB7220.apcprd03.prod.outlook.com
 ([fe80::a6a7:387e:2f4:6e8c%6]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 06:00:11 +0000
Message-ID: <c0d93be1-4343-b48f-3474-cd1f2f5cfe9a@amlogic.com>
Date:   Wed, 27 Sep 2023 13:59:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 2/2] arm64: dts: Add watchdog node for Amlogic C3 SoCs
To:     Conor Dooley <conor@kernel.org>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230926055512.2355390-1-huqiang.qin@amlogic.com>
 <20230926055512.2355390-3-huqiang.qin@amlogic.com>
 <20230926-output-musket-a43dd5abd0b5@spud>
Content-Language: en-US
From:   Huqiang Qin <huqiang.qin@amlogic.com>
In-Reply-To: <20230926-output-musket-a43dd5abd0b5@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0013.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::20) To SEZPR03MB7220.apcprd03.prod.outlook.com
 (2603:1096:101:ec::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR03MB7220:EE_|SI2PR03MB6637:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ec15e8-b558-4301-b9df-08dbbf1eeb90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q6GDmF2B0nLdCeuZx1Va0LqaFa8JBDprC1coZ71AXq3AmGQ3PHxL5DV1/QCn3brXHd72HU+xiwAECXg0l1ioBG/Id/VywkNQ3g8WIqEnIT024pBeYaneFUzMbsox8I9twKm/sFzXqn7Zq1CYiDprEVnSqRY44eDW5NnvO9MkbjC3RG+OPlFQXp99vgqKzwdrXjII24MJDlQcnN0fw/8HJgiO3I+UoSRVwJmBZo34fjvTzhSR+uFlmgDAuwGjjtfR8H5ry6Js9z1l7ITQfg54RY2ByBoXDRmb0A9xfOQSNUHKXcM8gz07dsOVre/3+XQkcuuag/L3lphR1KW+fCJV+Lr1YcmaZnL419wSHfFIniCxgrmH2KbJhIFQewAQicLrpmHbovIJjn/OSadD+Sxa5bOGWzi/Tf/jaHdvmTEIyFn188leAm6m6XBzM3CYsWA1SGPQFZxOEWYEJnWyjLAkJAwiyNd6riDHsFVipYvXkM5IGlKxb4fbDhdNGqT8wS78ndaZOvkl1qFU8Khz89LG/4lWVkNippF1wixM+3x+z5FrSvYUTkYegNBpB75dSvwo/oGfkzMQOyIKJx7TGhSBh+XWa0UH59atT0qWzfHeNA+ucWkCbNvd4xQ+FCUIAd2oomOsoiEZm8SiFHzXFqYfe6F9/zt1avr74xc8xDxKlM3W0Nz5oagDClBHy6BZkXgtuFmcX0/wbh9iBSa5626E7vO/4mYmP2antHrCJuCdF24=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7220.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(39850400004)(376002)(346002)(136003)(366004)(396003)(230922051799003)(1800799009)(186009)(451199024)(53546011)(41300700001)(7416002)(2616005)(38350700002)(38100700002)(6666004)(52116002)(2906002)(478600001)(4744005)(31696002)(86362001)(36756003)(6486002)(6506007)(6512007)(316002)(66556008)(26005)(66476007)(6916009)(66946007)(44832011)(8676002)(4326008)(8936002)(31686004)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEkrYlJ5VWRqVGk3SHM2M2ZIdXJzeXloUlFPRTdxQ21UQ1FaWFZ0cklZT25B?=
 =?utf-8?B?c2F6SXp0VGFuZ01XUWhzUHFwNURhRStsU1p2bFFGRmE5aG1acXBpU1Z0MDJP?=
 =?utf-8?B?dVl4SzdOOUo1ZGF3Rm4wZFJweDFpak5vcVNYMXM1cUFkK1VidXh5dWkzR1pT?=
 =?utf-8?B?LzdVT3M2WDBMMzFONlRxQXhLUWFoQmxlVm9WeXlhbWNpYXA1QWpJOXpPQ1hW?=
 =?utf-8?B?VUdOMmYwQlhKWnR6MlA4SnZLaXR4UVcwS1JMUjZ2a1QvQnpjWW10SW45OERq?=
 =?utf-8?B?S0JZWHZHODF6MFlNeTFMc1J1NTh3d2dBUitRNkRnWi9iQlBIMEt4aG9HVXkr?=
 =?utf-8?B?UDZmWnBqSy9OcGpxZXVqNGpkaVNjRmpsK29FVjFFeCswUnBVNkhFVGxWSzZo?=
 =?utf-8?B?VHVNSExqYkZRSmY0VWp2aW9ZRTZvTFNEdERyWHBVR0kwSnRZQjFTRDdQdjUw?=
 =?utf-8?B?VzNSVjNwUW5teGdBL1Znd2NJYUtnMUdYV1NMeForTDFLS3hyYXZJZzJ0OVFW?=
 =?utf-8?B?SEczRUJTZGw2QWJzeS9NcHZYZDRvbDBuZFlNVUtRTVJka3JZUjFENyt4aUQ4?=
 =?utf-8?B?VFhML0Z5OEdWbE1yeDZieEhhRDRQLzRoam9WUkErcnM3WDNHakhMV3FWWmtQ?=
 =?utf-8?B?a0ZNQzFTcUdPbi9IdndmcGM1MGYrYURoV0hNVVdkOWwycUFjSGd5OXZsaTR5?=
 =?utf-8?B?RTlxWitBWVZKQTY1enJnV2w2TitzNDZzMHdSQk9uOUg4cWQxZWU2eUVMV1pt?=
 =?utf-8?B?dWh1SFUzYSt4K2JYOS9FckRFc3lzL1JLcDRIWDc5T1h2eFZoOXc0WEFRcWVo?=
 =?utf-8?B?WktRTGxpSy8ySFV3b05pOUIrQkkvbFlSTzBUdnkreExBV3NCSTlTNmp1SXEv?=
 =?utf-8?B?Vk85bW9mTEJRby80VFkxZ1dEa3lZMlJXMm1tcURXUmlZMFYzYlBzTVl5bGxj?=
 =?utf-8?B?WFNkd2Vpc2YxV2hiNUJmYnBFL2lxRGNFUTdOMVVPMjArRE9TbDZjd1FnYWZs?=
 =?utf-8?B?b3RFVkpIVE9GSlgrR1B0b0dNV2pwS2xvVnR2MlpGUUpBM1VZVVVUemZzd3pX?=
 =?utf-8?B?NFdDVmxBQ1BPamh2SmZrS3k1YnFjS0R1TjR2dVcxV3FFbHZSMUt2NFdwemFS?=
 =?utf-8?B?bU12S0U2Q3lYSHBUQUhNcXJRU3BJMzczL2daSTA3NmtOOFF1cDJRYnprTDhN?=
 =?utf-8?B?WER6UEN2T2ZtSTIvMEp5cnNQNmNLbnJHS3Q2SGhXUmJWMCthekJ4c1RGSUs3?=
 =?utf-8?B?U09yODBoUlBXS3h2NkxpcUduaURZc3JMaHpNS2tpU3ZZOHlTT0NuOFk3eXd2?=
 =?utf-8?B?bGNXMk9xd3h0MWF1emZZSlF2TjN6TjhEN08ySzdyamVEcTJ2MENCdGduK01L?=
 =?utf-8?B?QnhiRGZOazVKL09VdzZEdittQVVhR05GSmNFVWVubnlMSE5iaG56RW1SRW50?=
 =?utf-8?B?cXZTb0w2OSt6TGFzMkp4N09KVmdvM1VJUzUxMXFFaGNDc3Z5MFRTWktvY3Ja?=
 =?utf-8?B?b0R1RjlVMkdHRG85STdvck96dnJydW83Vnp0YWFGVzk4M1l4QWhBYi8rVjJP?=
 =?utf-8?B?RWFpWjNOMHdQamFQdldzZGhzelJrVUo4Y1JsSndkNXQ1L3VwNWprTW9OaFZQ?=
 =?utf-8?B?S0ZTd2NacklkUHRDeVlUbTRZWU41VURtM3VOc3ZrVnpmUmhJbXpWbXZyTTcx?=
 =?utf-8?B?bUVMc3BVTXg1R2tsMzNTWGQ0ZkQ0UjBpZUhEd3JSblA3QkJpZE1jdkZhRG10?=
 =?utf-8?B?eDNIVWdabFVBNGNDYkJ2a2pmQ0s3WEVrR0V3K25rbElxblNvbFYrbTl5MXRT?=
 =?utf-8?B?Q0pQakcxOFYzVGZXNXFBZXRTOFpBak9SWGFzcVZKNm9BV0E1YVB6YUVpOURX?=
 =?utf-8?B?YkplQjZXMEtHcU8xams0N0V0dlhYUXNFWDlKSTh3YlJ0YktZYUV6RWRiOXEr?=
 =?utf-8?B?YkhxVTZHdHo2KzUzVnJuK1VHUk1IcWFHcitLelVBZ0p5UDJzaUxWS2FseXFO?=
 =?utf-8?B?b3E0WFI5U2hHY05GVzVXamZkK3VIdWd3UG44ZEt4cUpZdE02TGorWFBEd1ph?=
 =?utf-8?B?alpVeExocm9Kem9udkl3VENuSDhoOC9NTHE3UXJRSlFlMFViM2trR2J0ejNs?=
 =?utf-8?B?M3BJOG1NcWZYM2NVNEZoWk1FNENTdVhKN3ZMZzZTSWtMMXl3M1Ewa0w1WG9W?=
 =?utf-8?B?MEE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ec15e8-b558-4301-b9df-08dbbf1eeb90
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7220.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 05:59:32.7329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4lsHkssNyFcc3DqmNIBHqscVh6L35wYcmsqh29G95S0Ej+WiWFFZ6iTMrAdbpwCjbNEBfMEUtw2n3H03UWu9zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6637
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/9/26 16:03, Conor Dooley wrote:
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
>> @@ -81,6 +81,12 @@ apb4: bus@fe000000 {
>>  			#size-cells = <2>;
>>  			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>>  
>> +			watchdog@2100 {
>> +				compatible = "amlogic,c3-wdt", "amlogic,t7-wdt";
> Does this pass dtbs_check?
> The binding patch doesn't seem to permit this combo..
> 

Ah... I ran dtbs_check again, and there is indeed
`watchdog@2100: compatible: ['amlogic,c3-wdt', 'amlogic,t7-wdt'] is too long`
in the output.

I'll correct it in the next version, thanks for pointing it out.


Best regards,
Huqiang Qin
