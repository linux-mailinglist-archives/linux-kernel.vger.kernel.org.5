Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B3C8042A9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbjLDXkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjLDXkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:40:02 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2036.outbound.protection.outlook.com [40.92.102.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674C4101;
        Mon,  4 Dec 2023 15:40:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nL8RTXmLQTTz7Ke3gMn+NPwWOzakHM8JkWcfZfGUmdlhuR0pRHgcJUJibPld3Y3zoCT3mTogqwitQzHQOmW3LKvDqYPvH/fyIdeR5fj7KDgC6a/fTMralFAW03moZnglsCBP0nc4zsppDIzRcx33ARCDXx2RP6n4s1NaEJezHq+XOU0dnRUdGJJhLWC96JPJtRclCLCvbbAX/ylCpmF+QpwpPe3YU5cZLbTcCQ1XJc3X/+bP1T4muKLPFC8YUXEjB6ZP9TqT4GU/yToR1EJ5nzkIySEQ0xlAFsi+8lOudlLSIgqllKaWjBaATXCRrjPQQviUCyl++WTZyYfI2NzjkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMpgG9HJtLpab698JXscNMZ8z9hwZ2PgePNMTwldwTE=;
 b=P7/aoBZ0KEc4MjSFObUwlSk733Bng8wwjI2aB25SBdtCs0yaTzQ87xturmhgTqlo4kUefYzs+GlxtBMiJ/rJOCgZf+FTPA4wmfkkjEAJb9Iq6+xKao+3RMwTI9IDd93MnxfMnrCfeTDFv4/4KxB8iKSIYx6zKjL2k/lDnhpOlukbv4teEAG2euxcvaYbzw+S5jQtiOPRXFv4DVei8vS9nu7CwaxPM2zDAeIPS++SHXPFDhCrSY0QLIgKOrSySrvsXw3my4FrFl2J4S3MdxVbPHrzWxrf7BMBuwxVi01LhnxpF9/nt+8YF+SKZAvk5FSwQjWBh2ygsR+zRqMgfM0BEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMpgG9HJtLpab698JXscNMZ8z9hwZ2PgePNMTwldwTE=;
 b=ddDs7jL6Ba23SvZp8ac4z+gCaM/jenN3gFUK5Ss5TMovsQ9+eJ6UarKdYBnbzLbg9yNkoyoLT/+QzqaFwYNgmzI+BTUuwR37l7qhExWVQRy1PVKZr4/WQ0j2Do56qvAEIrLjRPh2/tox3vI6fZ/lwi1Rb3YKoRepmqwlE8LURP7kBBBGpEhoPE3HDu96Pg9JATKv1dXweX0rG3s5ZNCmwah7y23KevIHO0ZvpMj7vLVhZ1KVWmFvkwAyaGZwGDJ7+DBTRNhGsAqT6DM/vnSljswZCy3IeIoiLteOTqFQozS5xwwzQq8TJdF+rrwHXQGkSeu9dcn+7tpCiIaACflLNQ==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 MA0P287MB0156.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.34; Mon, 4 Dec 2023 23:39:59 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3%7]) with mapi id 15.20.7046.034; Mon, 4 Dec 2023
 23:39:59 +0000
Message-ID: <MA0P287MB033232CAFAC0C3D638C3AC57FE86A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Tue, 5 Dec 2023 07:39:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] dt-bindings: soc: sophgo: Add Sophgo system
 control module
To:     Rob Herring <robh@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc:     guoren@kernel.org, robh+dt@kernel.org, samuel.holland@sifive.com,
        jszhang@kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, richardcochran@gmail.com,
        paul.walmsley@sifive.com, conor@kernel.org, inochiama@outlook.com,
        linux-clk@vger.kernel.org, palmer@dabbelt.com, sboyd@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, xiaoguang.xing@sophgo.com,
        devicetree@vger.kernel.org, chao.wei@sophgo.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com
References: <cover.1701691923.git.unicorn_wang@outlook.com>
 <14616bce163d689a4e640ab7b372421ca8306a92.1701691923.git.unicorn_wang@outlook.com>
 <170169991797.1225669.8378193409195638634.robh@kernel.org>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <170169991797.1225669.8378193409195638634.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [rJUTWUrSpnc2ZrHtb+sIe9qY9tiK82Jp]
X-ClientProxiedBy: TYCP286CA0289.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::14) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <aeef653d-28b4-4bfa-b826-318872dbc058@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|MA0P287MB0156:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb2996e-2efc-403a-b7db-08dbf52252fa
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbENwF2LriIX8E9Gzhw7arC6I2Wd+5Swf5awQcX49/QmOCSVebweadU/IMYgeq31UPEh0qJkq7ZWljgRaycEzm5sbZJS+KoylCGrAK0GZYwaYSKLwYrWRd6hqYfp9zA67H8kz1YaRRqjDPtO3tCeIN0CqOyAQ5DMRMNe+uhiAbpDR4OvBPpL2Ta8surASExZiYzOb0mRVawHYeaN6+Z9LkanDbKJZ7f72lrqAbfkBOHdyRbAr7W2fwBStW9oRyXNfSIAzAb5DE9IEnkxlpJ+LTV+Yxmb1eAK/WWTw31kfvDIo8HDk1/8QWHvJr0t5nMvqGM9AREvfvsvn/qnsGqM4zJcseZwGYcvi/6/K6nZE4S5Sh4vas3vSFUarPSxCnvqZ+USBzItpDe1EIJReM3epaLFeWx7nv9YzQWYiO1VMzAOhzBhwZkvj3YMXqjoI0ENCFeqbhh6eLhAoa9hQnmR6d3EONzge4e3o2ibOWu1NJuBQOj5hYxsCY9yBU0gsCBoshoQHSF/CtIT1s7/K25c7FPJ3NedcJNhQD4aFOleQ62Lj8CBiIzWZqinBL2zxv/2iypa4jscuvDC32DsjSONnga68TqQokFz5YRmiv2o6qQ=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aldRMkcrRkRmckpGa0ZHTk01ZDgwRnpMM1ZvbHhDalNnUEp1SVBOUWdVenA5?=
 =?utf-8?B?RTRPMGRtZEdZNU9Ua20ycDNSQmQ1ZFBUTDRCZFJvQVRoelo1Sjd0VmJNVFNk?=
 =?utf-8?B?MTNmZHhHRkI3ZHZXV0M3MXlwV2tEU1Y2M0lSL1IrNkpoQjdQMVlzMDV5Ujhp?=
 =?utf-8?B?K1QrWktvYlFYdk9wYmY3NlY2VjU1SDRpNklzbnQyRFUxenhZdkFpNU5GMS91?=
 =?utf-8?B?SjNodi9KZi9SZ0dUamNidk53Z1JlVTRmY05ZWVdhRVF3MzlLZmxjdmRObVcv?=
 =?utf-8?B?dksvaGUwR2FSRFJvU2I3ZTVXNkJnTCtuN0ZLazJJOVQwZUMwaW9CZ1FGMGxQ?=
 =?utf-8?B?YUlsUWZvZWlMdm50YWh2MGo0S24wTGUzajlUL3N3Zzl5cmIvYXE1VE81cXRF?=
 =?utf-8?B?ek9GYTRUeHU2am8vOVRodnFHTEpxSmFxMERFSEdaS09ITW5iSlp1WDZ6VHFI?=
 =?utf-8?B?UjJhUjhCTG1oeE5ySFUwMTN5TDdFaEUrNTZaSlRwTHpjbzRtSXlnNkN4RHA5?=
 =?utf-8?B?YzlGZUh1clZHMUdId2NlRFNqOHBZZWMzcFhaUlc3M1Y5VGo1K3Z5UVRhemNB?=
 =?utf-8?B?VFlEN1FSaDlwd1BGR2RDYzJqdEpKVzdaajdMZW1VNGpoWmk2WHhtL1NhbDlx?=
 =?utf-8?B?MUd1K3J5OFE5eG9jbG5HekwxbG54OU1kSHAxNWxxbVh2enNpWGpYQUpqWlB1?=
 =?utf-8?B?UmlRdFFjK3NlVWxlSFlEMTlTcUZETXhzQytqUTlyRGxhSG9aM0ppRk1RY2ZS?=
 =?utf-8?B?d2hSRkNZUUJQdmlwcytETGZmSWsvb1BTY0ltbzl4dmxncUNGMjRnQWErenZK?=
 =?utf-8?B?TDFxeDF2d2N4by8wK1p0elU3QjZCNG9qYWhuQWVTZjJLOUhEakJqN0cxUVIw?=
 =?utf-8?B?blA2L1JPV2kvZC84RTNqa0h4MTNJMnlueXJxM2hQVDdHQVhEK1JrcnFpY1lQ?=
 =?utf-8?B?T0dCeG1pbHlYWk9tY082QUpqSmNwUElSZGFoM3BYZHpFZkZ2OUJHTmluQ25W?=
 =?utf-8?B?RkpLM2JobGZaWS9ZN29UN0Q1YzVoYmpBcDF2NStiUHNpQy8rbmNmOG1uRW8r?=
 =?utf-8?B?RGxoZ1lDNExKMHhUSUdwZ1Q1QWtjY3lUaGRxNHE5RFJsZmFKeW9rZXBXQ3pt?=
 =?utf-8?B?QVU1czVXVmY1ZDkrRjZFUmpaYXRMeHRUVE9saU40SFRIckg1R1NTdGxTUU8z?=
 =?utf-8?B?L1A0R1YvL2NQbmJQeE0wWVNEZU9WTjU0N2s4NU5mUTQ0cjhONTBjMDUxQ1JB?=
 =?utf-8?B?U0tjd3FPWTFEZFk3RkRSc2VRb0ZsM01pU0lDQ2ExSGxNdDJKWVNadXN4SSs1?=
 =?utf-8?B?dmJVdDhLYnl4M1VzYWErK3NFcCtYZ3pzdFNYZ3pyemVXblFwb0JoU1ZoN2JU?=
 =?utf-8?B?ay9KY0VXMi9Dbi9Idk5kbGlWTlQyaTV5NndxbVVDWVBTL1VzN1hCS0piWUJi?=
 =?utf-8?B?SVBTWlBwQ1l3OElyTWJ0aVVmTFR0UmZDZm1Ka25DTnNQQi91MHdYdFpybjNj?=
 =?utf-8?B?S1FESEp1ZW8va2NtQmNPUzAxamNYTGExRjBoc29jNFVxa1VkZjFxYmdXUFFp?=
 =?utf-8?B?T28vZUdFSDF3SHpoM2tQMzJ5QXpOWDZjSDFpR1A1RGRQUkhsRHMwZ3NZVWl5?=
 =?utf-8?Q?l750mBvFMBn9SyjWtjTYEHfS/orZ5PF4t6IyrKc8XtEY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb2996e-2efc-403a-b7db-08dbf52252fa
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 23:39:58.9183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0156
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/12/4 22:25, Rob Herring wrote:
> On Mon, 04 Dec 2023 20:54:53 +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add documentation to describe Sophgo System Controller for SG2042.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>>   .../soc/sophgo/sophgo,sg2042-sysctrl.yaml     | 35 +++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.example.dtb: /example-0/system-controller@30010000: failed to match any schema with compatible: ['sophgo,sg2042-sysctl']
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/14616bce163d689a4e640ab7b372421ca8306a92.1701691923.git.unicorn_wang@outlook.com
>
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.

Thanks, Rob.

My fault and I wrote the compatible string in example incorrectly.

"DT_CHECKER_FLAGS=-m" is very good and do help efficiently catching this 
misspell issue not easy to find. Learned and thanks again. I will 
correct this.

