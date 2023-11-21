Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E207F2C43
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbjKUL4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbjKUL4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:56:24 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DC710F9;
        Tue, 21 Nov 2023 03:56:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lg//Tnh1EizOQd6MoMwr9Nv/lbiOarMWz97gO23TMhEMunGWEtvHfuEz3bAIvGLYECC8Kg0CRdN7lRLn1KjoohHHj1nb1To0Huqg0Pd98UUVTwZA9k1ufMYTPF1405xzJmanyvsECNOlyg0BD/1PkwD7H3q5DBiow7NoGPQwJYUVoJuybGFPROBY30aO3kI5NdnVVdr6Agw/LO4UyMmNb70U34rkl3g+ribhewexR6CU8ViInKFeF03EnJZXPaJbOJn5Xkl1W8k4dSpVKbUrdtLgVXUk00e6GSYcSGupbjXY94uNiT6UtjWpxSuSZZBgTWabGTm38tIuznznX9f6kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZRlSME+QBGPrb5NqwslcXfCpqfYObjope25DcU/PTQ=;
 b=W6zzHzj+BD7Q/wHl3O92wbrdgdhmPxnXO/kYyXKw9jpDLa+G0RbJuovmmxx6JkRMfXmqMj6IpoTZmnRlzN47RalmhcIEvv0GS2HfXWdMoBxZl7vibRxHW4Bb8aJKn0wb+NNHMnqkrvyZrvJ4KN6ZsHrkDCG4X/Zbm9CawkKBX1663Sa0urqWqoOmhxtNiSNmDWOdCPAEDwR+jCJWU4tF00xl5W7VVhzl24IAoNdTaLdiOdlPjW0Rt9xxIG2GVDJUjIBu2ekS+0dDb2VLkpf7oVO/ZbX0tGt3hcwumR6i9ovOqJg1N7fYIev0sHljw13Om8QoEAAsC8z4HYCPTm2xgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZRlSME+QBGPrb5NqwslcXfCpqfYObjope25DcU/PTQ=;
 b=SXcbsdC0wfZrkZT2ysKjk6lLzos1F183QqULNh8yaSagi0Ajylm+YCHc5xNKSnIehfftQX5uIHUH8aUS24G4vLfCYVydy88SbvL09JC304nWz4mSzZxJ+kMyNU1aYZ0gPQja3LFNOLli9ssnQgpu4+/OmIl0qzPIPY3DR2o55dU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by BL1PR12MB5047.namprd12.prod.outlook.com (2603:10b6:208:31a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 11:56:13 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 11:56:13 +0000
Message-ID: <6c80a285-27fc-4d61-9eef-af4744a9decc@amd.com>
Date:   Tue, 21 Nov 2023 12:55:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: dt-bindings: add DTS Coding Style document
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Andrew Davis <afd@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20231120084044.23838-1-krzysztof.kozlowski@linaro.org>
 <19358871-009d-4498-9c13-90d5338b1e9f@amd.com>
 <76fa8f61-fe31-4040-a38d-cc05be3f4f17@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <76fa8f61-fe31-4040-a38d-cc05be3f4f17@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0177.eurprd09.prod.outlook.com
 (2603:10a6:800:120::31) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|BL1PR12MB5047:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eb2a737-5b5a-4c56-d5ac-08dbea88dc08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vycOCg2PFVzSFV6swQjhifjx+X41B4i8z7RMXfmvn9Y17LBNB11kLiE6fPWlBHu1WxsoxIrcuY6R3nuwgHLMGmJ+QzuOBpAi1BdqMCYANWPy73QR9mOT0m9hYDVFp45R6iXfUunTzC41t0sv9WedxNMbvBlEuTorvS0aatN2baZDizySe+/IUXECjwZ3JEvU0he16NymrQre5Aj/7cfaUGc4J23DjV7AUulAwQuSrw49uO3+0j/0wQUc1pqUWhnXbmb+LRTs+cHhLBhxy19F++wPfFrEJgGZVxJ61YanaysNjFzYKqczevtBKDeNCmo6N0AWSxhVsG/gIQjo/oD9n2Znn3DjwCbwCIPeIqbGdm2KKOaSZO4dmFRKIrcphbj2vGbTUyIHaxAeDg+jN9BgB0yngD0iHs3poMyampR2CJCOL0BPxKRe1atfEtaXh7Lhv+GoLWs0OAFvCNR0kyle9QvwnfD+JUIyB7hDSTaSt5iEvdVJgl7wMUlOUq9XtP/uPLsQH19zjuEwkGg0iGTdNWjF3YdabS6hkKi4ApjSZDakrxi84njCacvz/ncVV7I9Pm0wLwUessTZ4F0zTZ7GfzXa80jM0ia0T/LUFx1CqdBk/8neJGsmf5aYI5Q3bYjQGVTDZFw/56o+uqRbGplCqm0hyHNPcmjkbAdzMJdyvDo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2616005)(86362001)(31696002)(31686004)(110136005)(6486002)(6666004)(6506007)(66476007)(66556008)(66946007)(316002)(54906003)(36756003)(921008)(6512007)(53546011)(26005)(83380400001)(7416002)(2906002)(44832011)(478600001)(41300700001)(5660300002)(38100700002)(8936002)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2lPd1lTSGdweVNjQ3NMV1hoZCszVVNvTUtlTm8vS2dDVzdvMVVMOWo4cGI5?=
 =?utf-8?B?Tjc3bm5EVXVvMEMwakNoMnRDVmpJYVdHU0ZjRzZtMGc2K3NacTVFNTNuVCtC?=
 =?utf-8?B?NmxucERDajllNTRTRXgxSVlLODRCK3EybWRGVVNueG8vRElqQzU2NlZMdldl?=
 =?utf-8?B?djBCOGdGQ1lSOTlOeXd4N0pkZWdYbS83alpTNzdEbzRTUHpmU1UxN2dHeHFN?=
 =?utf-8?B?WjhGc0puekNlNUFOUnNuNG1ZYjJaVDlGMGE2OVBaRDNmNW8wdGJnWnFweWN1?=
 =?utf-8?B?Y0Q1ZWNWcVZSdUR2TVN3ZHc4UC8ybysraDQ2cExVUE13MUZNU3dGQ0x1cU9F?=
 =?utf-8?B?TkZPRlpyUFFzNlVOZEZ0YkpUZkJYNU5lckpWYkNabUFFcms2Vm56Y3c4MG03?=
 =?utf-8?B?cjkxYXFFZElxKzRMVk9mYmtTdk5MWkpxenp6Tm5OVmI5cUVjelpSNmJxZ3Fh?=
 =?utf-8?B?ZzlwcEJrNXdCcjh1V1Urc1ZlVzdSdFZFbWZBQ0p1YkliOFBRenA2MlFOUzJ4?=
 =?utf-8?B?bk1VUWEzZ093aUlCalFMK2tiK1crekVOWVNCVkNscGdOaGFGTDYrUkNlSng5?=
 =?utf-8?B?a21LWWtVamV4ZDJ1MFR6cmd2dUIxVEU2NDRUSzNtK2xZT2UxV1g2S2xaRUww?=
 =?utf-8?B?QjJvc05vTldVa3lqZnBCempYZFdmS1dDUEF1dFhuakZad3ArdkxKYUlCMEtu?=
 =?utf-8?B?N2R6OGRMUW5xRVQ4bzhscDJEUTZIZEFlaUhMKzVuVWVHcll0TDRneS85MFNB?=
 =?utf-8?B?Skc1c2piSFhTWHlOQzcwbXFiNHlhL1VTQjBVWEpDSjBzWVkyWnl2Z3RvUnF2?=
 =?utf-8?B?VGhiSGcvTTJzdUU5RzJFY2gvTkZ1czVSU3lDTlhBM1p5U2xoNE5KNDZrMnVT?=
 =?utf-8?B?Ly8rRUlUa3pmZUEwcEtpeUhzdHl6SnVLMTRYQ3Y1NVBncWpNSnJhZ0hIWHNu?=
 =?utf-8?B?dnRVK2owZCtpU0Y0MTl4dGIyR1kxNVgrb1h1djRndkNReE42WjZYYXhIZitW?=
 =?utf-8?B?VlNQVjJ5ajI2K3lta0YxTmtGN2xKT1ptRUpNalU0SXhvdERWWGYyalBVbXlh?=
 =?utf-8?B?bUI2ak9STjA4Slk4OUE4Wm1ZcFdEK2dBc21MSUNnSWpvNDlsQk1vdzFPcG92?=
 =?utf-8?B?YnJ1ejlhdjZjT1kwMzRqU1U1QWpJU0l2eVFDaGU5WThNbWV4aWp6ejN5WnVq?=
 =?utf-8?B?cnh2aUdCMndtb2wwVlhCWGVoUEkzdEJlNitCNTY5Q1BTcW1tejBnYWRqcExF?=
 =?utf-8?B?MnpwOTN4L0lQQ0V2OHMxSytBN1JvWEU1OU4vbjhja2R3VHVLSkdPSUxLdGN2?=
 =?utf-8?B?NzIxcXpzNE1WUVdPakQ2OTZWdzUyT1RlbnZ2Mk41M3VZbjhCYXZNMCtOeWp6?=
 =?utf-8?B?MXlHMXJVdFZOZ1VLSXpkQXFudGZneVhXK1EweFBDSDBIN09zMDA3NkNCZDdp?=
 =?utf-8?B?ZmNoR1F4RjNHQTVLRUZpblpxajRyNnZlSk5KbVVPejZFOEdpSEdSKzVHZjMz?=
 =?utf-8?B?aFNlRDdvcGpSYmNrbEVUVjhrclU4ZXJ3OGZaamlsaEdKU0J3YlY5OWJrVC9R?=
 =?utf-8?B?NGQ4MVlKVVRQWFhGR2pNOWgwdzN2WC85RkFHT2tmYkpnNFZuMFpLcDlJU2lN?=
 =?utf-8?B?cW5DcDZ5M3ltTnhLTndYYnVXbUVzcDB4ZUtqQUdJVndtRGNFODFWN3dJbzBL?=
 =?utf-8?B?R1dwSUZoNEttVi84TDNGMnJmcmNwWEFGdStDaSs2Qk5INU85ZnlxYUF2S2pu?=
 =?utf-8?B?YURaRTJUc1hVQk1laFFHc0k4RVM4Sk5jOS9pWG9oQ1p4dk1jUWI4NVdOTGpl?=
 =?utf-8?B?akhTMnF5ZkQzenk3b3pIamVxVXdIVE11Nkkra0VJWmNhS293ZGpUTWk5dFJL?=
 =?utf-8?B?TUVnSG5FdUxZUHRhNFR5SjZMbTVxRlNBZFRhTUJFRkszRjFueks1U2RRcFNE?=
 =?utf-8?B?RGM5am5lU3J5OGdteFRlVjR0NEtTbytaOU94cUlNYUFITDhXTmVhNGhmbWRt?=
 =?utf-8?B?S1J3STFXRXJEN09RKzV1NWVwK1RYSG9waWRQNzVnSWs1L05pR3ROT1l1eVRh?=
 =?utf-8?B?TytjK0hDMUZrSkdBazNJMktwYjZrUjQyM3RPb2ppRFYzdWpGM3FPMS84RjRP?=
 =?utf-8?Q?jQxoNZNMmhqGADxQYiO4K3ckz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb2a737-5b5a-4c56-d5ac-08dbea88dc08
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 11:56:13.3718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2w4Hh1GOKZiNrFU2BX5B0ZjZ1ZqRz5CFq81X8ZN6itO62LJf4YtIV9fHiThEmXlf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5047
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/23 15:53, Krzysztof Kozlowski wrote:
> On 20/11/2023 15:01, Michal Simek wrote:
>>
>>
>> On 11/20/23 09:40, Krzysztof Kozlowski wrote:
>>> Document preferred coding style for Devicetree sources (DTS and DTSI),
>>> to bring consistency among all (sub)architectures and ease in reviews.
>>>
>>> Cc: Andrew Davis <afd@ti.com>
>>> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Bjorn Andersson <andersson@kernel.org>
>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Cc: Heiko Stuebner <heiko@sntech.de>
>>> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> Cc: Matthias Brugger <matthias.bgg@gmail.com>
>>> Cc: Michal Simek <michal.simek@amd.com>
>>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>>> Cc: Nishanth Menon <nm@ti.com>
>>> Cc: Olof Johansson <olof@lixom.net>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> ---
>>>
>>> Merging idea: Rob/DT bindings
>>>
>>> Changes in v2
>>> =============
>>> 1. Hopefully incorporate entire feedback from comments:
>>> a. Fix \ { => / { (Rob)
>>> b. Name: dts-coding-style (Rob)
>>> c. Exceptions for ordering nodes by name for Renesas and pinctrl (Geert,
>>>      Konrad)
>>> d. Ordering properties by common/vendor (Rob)
>>> e. Array entries in <> (Rob)
>>>
>>> 2. New chapter: Organizing DTSI and DTS
>>>
>>> 3. Several grammar fixes (missing articles)
>>>
>>> Cc: linux-rockchip@lists.infradead.org
>>> Cc: linux-mediatek@lists.infradead.org
>>> Cc: linux-samsung-soc@vger.kernel.org
>>> Cc: linux-amlogic@lists.infradead.org
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-arm-msm@vger.kernel.org
>>> ---
>>>    .../devicetree/bindings/dts-coding-style.rst  | 163 ++++++++++++++++++
>>>    Documentation/devicetree/bindings/index.rst   |   1 +
>>>    2 files changed, 164 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/dts-coding-style.rst
>>>
>>> diff --git a/Documentation/devicetree/bindings/dts-coding-style.rst b/Documentation/devicetree/bindings/dts-coding-style.rst
>>> new file mode 100644
>>> index 000000000000..cc7e3b4d1b92
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/dts-coding-style.rst
>>> @@ -0,0 +1,163 @@
>>> +.. SPDX-License-Identifier: GPL-2.0
>>> +.. _dtscodingstyle:
>>> +
>>> +=====================================
>>> +Devicetree Sources (DTS) Coding Style
>>> +=====================================
>>> +
>>> +When writing Devicetree Sources (DTS) please observe below guidelines.  They
>>> +should be considered complementary to any rules expressed already in Devicetree
>>> +Specification and dtc compiler (including W=1 and W=2 builds).
>>> +
>>> +Individual architectures and sub-architectures can add additional rules, making
>>> +the style stricter.
>>> +
>>> +Naming and Valid Characters
>>> +---------------------------
>>> +
>>> +1. Node and property names are allowed to use only:
>>> +
>>> +   * lowercase characters: [a-z]
>>> +   * digits: [0-9]
>>> +   * dash: -
>>
>> device-tree specification v0.4. Chapter 2.2.1/Table 2.1 is describing much more
>> valid characters for node names.
>> It means above description is not accurate or DT spec should be updated.
> 
> Spec allows way to much. dtc doesn't. 
> One thing is the spec, second
> thing is coding style.

 From my point of view spec is primary source of truth. If spec is saying name 
can use upper case then I can use it. If upper case is not 
recommended/deprecated because of whatever reason spec should be updated to 
reflect it.
I know that DTC is reporting other issues but isn't it the right way to reflect 
it back to the spec?

No doubt that it is nice to see to have guide like this.

Thanks,
Michal
