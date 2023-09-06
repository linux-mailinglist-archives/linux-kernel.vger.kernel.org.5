Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6201B793BB3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbjIFLs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjIFLs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:48:27 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2061.outbound.protection.outlook.com [40.107.241.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3570A137;
        Wed,  6 Sep 2023 04:48:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWyKIYPcG1K7tm13ISThuhP/f0chFud2LKqvuSFarU4i6DCL8+PftVaKiIN7rRBNq+TLEEo9eoe8nLPPul3/ACgMIpmf1Qn5cMhN1hhfjp4c1e1Pl2u6wmrEYic4N2o0ffgR872sr5FFZCn62RluzCBznUn3NbtjSzml9IIkirQJ5NSsw7CjS1Da3i62E1hG5wC1NlPra/Mda+e9XXuEj5Gt5uxo3ablmDd0aXzp5d4Ny4Nt/b86ulkLbd7ZB4QOsaXQcnGX1lZj4oIdhdMLjKsrFRPS3OhUC4H+StFS3WRnBhz8fnn9AOx9GiygK+lSdYxRojhdVAV+bgqin1dNKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5g4RRswJcNFFt2i3KcuO+F4o8/AKYRu6peQzi2olbkg=;
 b=JUYtT/nu6CGRI3BeDKXpjVzXQv7FiNBWV0nk9K/soq3yQwH8eHZiwIM/2wUNCzqnB2QkcketThqLaJI56tJ2FANGwKIrZaOhScfLunwT5oZ+Vskt0xeAVeynGXp03IWM/wcDIFolaukHyvPX03QZViuMZJrbPuNFBg8RhfzTP0fWPYUv4ZXxysAvoD2oeWBk1Bitop4C/UXIQosNRIqD00pm0RQ5qZtBN6v+0ckmHswJR/DQmj402Yrj8zaRKmvZp4KUVMy3hnvxQqGGO/Itw0xxRUba+M09kYEg/nSAAQ1CzBVC0yXAavpJuf/nbyjZh1gkIx9aboNCaJoZfFeEgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5g4RRswJcNFFt2i3KcuO+F4o8/AKYRu6peQzi2olbkg=;
 b=V2Rcs0GsuRUOtWAPb6GgtDu0fDTBqNkVC9krGduGxgdin3avqfBpYbfk0JZkdhCAIixERgVM+pmHuafVdSPRaetySIqvaQfbF9p1a3UbQJCf3dM87PGty3DB1bd/ByE2qrpUgVyHulEFjjdGLqqGfvMIlGFrsU+iKS/QVBd3ing=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DBBPR08MB5993.eurprd08.prod.outlook.com (2603:10a6:10:1f4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 11:48:20 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63%5]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 11:48:19 +0000
Message-ID: <808e0a07-9bba-0499-564f-83872101a19a@wolfvision.net>
Date:   Wed, 6 Sep 2023 13:48:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] dt-bindings: rtc: mcp795: convert to YAML
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Bartczak <emilbart@gmail.com>,
        Josef Gajdusek <atx@atx.name>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230906-topic-rtc_mcp795_yaml-v1-1-de75c377b5b0@gmail.com>
 <bb0548ed-e88c-bd21-caeb-1b767259b0ad@linaro.org>
Content-Language: en-US
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <bb0548ed-e88c-bd21-caeb-1b767259b0ad@linaro.org>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: VI1PR08CA0228.eurprd08.prod.outlook.com
 (2603:10a6:802:15::37) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DBBPR08MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e4c1d1-4029-4af3-1018-08dbaecf2a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ayXPKEwIirfZgBjsBxSv3WdkcM9Psp05LOBTJnl4QiTPhkxZAYeQqYBZTaj83zXO02BQuxVOVOvJjnBggVPUKxKQo/MP3+qCv4WuZO2xFDnpAoDD+4Zfgx9xedjV9+CzURjyAD8y8aABi0r1oEg4vxwNihHy2O1CeRKelxLMmNJI7Ny5DtJyWcqboa/4wVVzlaU0UGF0enbk9mF6fwJGw6n7KheKyttdbEqmqtI0ModX8ul33iPgfnWOBVmYMmZFoswMWz6+Xb7CzEiCG5ztTiXrUgu82nCOo+JVoGJ5uoap7rpzkqA+gxyQN6yoaKxTs8CTzUIEizn9gT5h/eU0g6vm00LYTd+74S8bybAU6Jgpvuo47mJ1PGfL5hZ6gGSUMsBkZhRtdGwLyFdrXc3oDfYNS9C9P5BzS1LLh29nGWsCtEfb+cQy6Hndt8oR9nDQKi6ZoooL8MjVsPMbjJIIS24Zxg0yfJN8oyM5hyhIUOgKEIuYOxaNgGFoxDgv+9fhaEv2WwOn1vk1PgRsE20RLEPPdAM1xZ7AssP7CfVimhTchEPSq1EHDkZKvdGj0cln2VvUnPiubSU7Urp71Umo/hqQiQ4yi+HVa8eaZx+suFetfq4fGubNTwQL1wMijdlajL2kGvv0YsgmwCiEtbrEyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(346002)(396003)(376002)(136003)(186009)(1800799009)(451199024)(6666004)(6506007)(6486002)(53546011)(6512007)(45080400002)(478600001)(966005)(83380400001)(2616005)(2906002)(7416002)(66476007)(316002)(44832011)(66946007)(66556008)(110136005)(41300700001)(36756003)(4326008)(5660300002)(8676002)(8936002)(38100700002)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEo1aE5OUkxwWW54Ym5NNjFaTzBxaWtKZjNGSmV6bVlOc0k2RGQ2ajNBRTQ1?=
 =?utf-8?B?d2lUZWsyby83Szc5cU1BdDNpejJjTUt3ckpRT0h0WWp1b1FzaU11eWRVa1NC?=
 =?utf-8?B?TDRXemloeHhXRU11YXVhbkhHbVl0QVFNbEREdlRPMmpXSnE1WS9OTEhKR0h1?=
 =?utf-8?B?TzRUS1Q3Q2Q2TEFxbHM4Wk8xb2hJRmlyMGE3bzVDVUpid3dqVkdRZitvMG9O?=
 =?utf-8?B?L3piSkFWWWFHRmdVa3Q3eXJHNmx6VUYxd3crcWZrWWI3dTRwaDRhUi9GS2NU?=
 =?utf-8?B?UFpDcnVBTmE4ZkJBNjk5WC9CNlZnWVdJK2VOYjU3L09wLzJlblZoTDFsU0dP?=
 =?utf-8?B?cXJFTDRQcWFOd0NsaXZsNFlHN0lHeHQvQWVrT2gyVGlYZ2hlQ0I5VXFRVm1u?=
 =?utf-8?B?dHA4MmcybFBDMk1lOVBPc2dDbUV3OS9uNzhwS1BnNWJwUGhrVXBoM2hGczlH?=
 =?utf-8?B?WGt4NXZ2NFVpSi9GdlNwdzE3UXlla3VjWXlRcVg5aVpFVFdtQ1FSMUtORUFW?=
 =?utf-8?B?ajdaQUliT3JxQWFodDllZy94NjQwTW0waDJlcUxETTlkQmdpRVlidGR1WDd3?=
 =?utf-8?B?d2lCQmxvbkNRL056ZXVibnluM2lvUElncE91cHRINkpjY2N6SUNzS0o3ZVJz?=
 =?utf-8?B?UWVNWWl5WDUvUE5JSmdZczdOK3ZlazhCRHo3WGt2dm5wYXVCWjVvK0JiZjlB?=
 =?utf-8?B?U1RQbWtudklITFFXT29va1Q0YzZaSnlCMkR2QzFEQWd2NDhRUWZzQ2Q5WjB4?=
 =?utf-8?B?QWhVcmpMTkt3bklvS05kOGg0Qjl3bnJBSS8xaldlK2hMMmpRYkhQSDErVGpp?=
 =?utf-8?B?bFBlM21ldjNJVnZHMi9IUEZydGVIbzh1ejA1a2JpQ1BveDFncURoc05BalE2?=
 =?utf-8?B?ZlRiQ0xHODRYYlJCUFpZaFhXWDNYMHNWWXNXemlUR0lDcXg4M3RPSDlEdnRv?=
 =?utf-8?B?a04rcEU1WUxnY0ZmMy9sak8vb2R2YkV2dXVTUUcyWjF5WUd2UE0ya3hRaGZa?=
 =?utf-8?B?UVdJYVJIRysvNCtwRDNCQVFqU3pwYVh1V21yb0tERGQ2WFVvbmlOSzFKNEhY?=
 =?utf-8?B?eHlmNGtleDNXeFBTVzJGSXdNcEJ2elc4UWJEb1FNRW5RZmpVanJPUjZhY1cr?=
 =?utf-8?B?Z2VqeDVmd0VVQmN5TllHb0xNTno0ejAzQWxFQUcwZXFZZkpmUTNUS3NGeGxt?=
 =?utf-8?B?OVpjWGlZdng1d3RNYnFNT3JYcE13dTNnaVNqalhITjFIL1VvdklHQ1Z3RGhx?=
 =?utf-8?B?dWV4ZU55TTVwRFFiQTc1TndZaGFDaXpLb2RXaXU5S2JseXRxcm40SzdyRHgy?=
 =?utf-8?B?a1Z6QnFJRGkwUENIMHluSnNSUjd1dXc3ajN1anJNRXpPYnlnUFBpL05CUFlq?=
 =?utf-8?B?STljYVo4SXJsektmbnRGQkprbVpIMUxuTHVMeTZIbURTL0ZVNTdtMCtyN0Z4?=
 =?utf-8?B?Y3hYY3ErTmRMc3lEQ3RyZ3VlQ3lscDFxVkpoRm1rclBKREtBb2tYYUpKOXk3?=
 =?utf-8?B?cmNLczkwUDdOaU9kL3BHajNvRkpMVWdsd3UrWk9YbU9DM1IydVZ3YSs5SXRX?=
 =?utf-8?B?TkZQTVpwellWU3lDWGhURjJMdjl4SFRlQ3BJTkx2aHJDZW82ZVI1UFVxZlZ6?=
 =?utf-8?B?Y0FqcFBHNE90N1RrZVpNN1JrWm9PYXJQbTFQNEhjNTY1ZG1QeWpaRzA1RlF3?=
 =?utf-8?B?a213Z0VqMDRIQk9iYnZqdmhJQTJTRGZWUjVmRnh6dEpGd2RFSFBPTjZ2R1Zh?=
 =?utf-8?B?S3g5UlVScm5PeGthcnp2NHVsZWt4dDB1L2VWNk1LTy9VR0RGa1EvSlF5L2N2?=
 =?utf-8?B?T1U0dVhHbFVDMlYyVTVkNy8yNnpLZVQrSHorNUthTmswWW5mOUtTU1BoRUNr?=
 =?utf-8?B?ZHNNKzVvcDRWMjRlc1FUUWttQUZvSWJmeGZtdmR3QjE2cXU2UGp6RDlYVkhN?=
 =?utf-8?B?VUJXeThCNmxoWkVHTjFRRFl6N2oyTUxnSE5DQjlhWVNhQ1F3c3ZTT1pqOW01?=
 =?utf-8?B?RllRNWQrbXJ1N2xJNWR3akQrOGMyN3ZXVVNSaHpjcE81dTJITWE0eFhKcWRP?=
 =?utf-8?B?eWJpWmEwbi9uTlNIRXlrNFFmYi9WNmwvcFQydXdYNEoydzFzTXBlN20yNjRp?=
 =?utf-8?B?bDdtNm9IZFF6c0xzMk1JTjgwYWZDZ1ovcmlaZmlsTTJsU003b2g1ZEl0WHZq?=
 =?utf-8?B?cG5xTW9zZDBDNzZaN1Z3K01oYVR5TGsya2xOU2w2RUMvNjhyMGpyMHVSTCsz?=
 =?utf-8?Q?hfTRaLvdwnVaxCvgNue0I/MzT2vzG1uvRI4M6nzQio=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e4c1d1-4029-4af3-1018-08dbaecf2a4d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 11:48:19.5857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+YtAx0oH1gJWl+1G80dLUv94Ifd6trQYBNd34l2wTVVox1ErrlaM6SVlP7rLlXrENlCaMciI2JVlDMbneIOonme1jM3TokNKdUR9EFTR9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5993
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 06.09.23 12:42, Krzysztof Kozlowski wrote:
> On 06/09/2023 12:23, Javier Carrasco wrote:
>> Convert the MCP795 bindings from text to YAML format to support bindings
>> validation.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>> YAML is the preferred format for dt-bindings, which allows validation.
>> ---
>>  .../devicetree/bindings/rtc/maxim,mcp795.txt       | 11 -------
>>  .../devicetree/bindings/rtc/maxim,mcp795.yaml      | 35 ++++++++++++++++++++++
>>  2 files changed, 35 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/rtc/maxim,mcp795.txt b/Documentation/devicetree/bindings/rtc/maxim,mcp795.txt
>> deleted file mode 100644
>> index a59fdd8c236d..000000000000
>> --- a/Documentation/devicetree/bindings/rtc/maxim,mcp795.txt
>> +++ /dev/null
>> @@ -1,11 +0,0 @@
>> -* Maxim MCP795		SPI Serial Real-Time Clock
>> -
>> -Required properties:
>> -- compatible: Should contain "maxim,mcp795".
>> -- reg: SPI address for chip
>> -
>> -Example:
>> -	mcp795: rtc@0 {
>> -		compatible = "maxim,mcp795";
>> -		reg = <0>;
>> -	};
>> diff --git a/Documentation/devicetree/bindings/rtc/maxim,mcp795.yaml b/Documentation/devicetree/bindings/rtc/maxim,mcp795.yaml
>> new file mode 100644
>> index 000000000000..77e465747d43
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/rtc/maxim,mcp795.yaml
>> @@ -0,0 +1,35 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/rtc/maxim,mcp795.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Maxim MCP795 SPI Serial Real Time Clock
>> +
>> +allOf:
>> +  - $ref: rtc.yaml#
> 
> Nit: By convention, this goes after maintainers/description.
> 
>> +
>> +maintainers:
>> +  - Josef Gajdusek <atx@atx.name>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - maxim,mcp795
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
> 
> This should be unevaluatedProperties:false, so you allow other common
> RTC properties. But then, it is even smaller than trivial RTC devices, so:
> 1. What about interrupts? No interrupt line?
> 2. If there is interrupt line, just add it to trivial-rtc. Otherwise,
> it's fine here with changes above.
> 
> Best regards,
> Krzysztof
> 
The RTC has indeed an interrupt line and I just checked that the driver
supports it. Apparently the functionality was added later but never
documented.
The interrupt is optional and therefore it is a perfect candidate to get
into trivial-rtc in v2.

Thanks and best regards,
Javier Carrasco
