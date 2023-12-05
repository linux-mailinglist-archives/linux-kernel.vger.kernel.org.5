Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1858056EE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345657AbjLEOPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345617AbjLEOPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:15:11 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2071.outbound.protection.outlook.com [40.92.102.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB9590;
        Tue,  5 Dec 2023 06:15:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hx3sGq8IPwkydSA2FdSe7I3h3v+JsmiR5MFNHCE0i8qa8ALc3Pbk7QDpICLtYzx3UOszGPMatu+RYquKTXe6WP18pIR1DmL08wsyIDixCoRXfJ6LOXa3gBjYmmT1kOD/zFXjyTCBB8Agy2u1hAGJLOsPHmbt4HV0FuQfxYNsK6O2zY5DkCyKaqfKO6hgaved6GrQWT7WW1Q+VvSvFlk5yjCns56gqWmnhcXwFRr/tDPfVMihyvqO5JeVIAB6vOVdG+RkVlg6tVn/+ZrEtSRJtVM0PBcO5dLDCDpJRNit4rzWMKYpG8fYfBZy1Huj3aA2s9EKOdRn/UjuxZgsGFdtZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNRZ+ELRXVW3NXJAzYcXU6HnhsRjgq9NamXsBvgMYPo=;
 b=KgG8I7w8hf2XsylQ+8lxw8w3Hs0LvRWhyDKhZoPMupZetpguxcbHIDdB81OslG/5A3FbmC6pEZLEmv9pNDrODl0PS9oQFw7Tif2p5o5EbA+WKEvDPaFFAFyalOzX0l2qHSEXZ64fwwKSUe9Mxbhs59wE5jc4mlXCGg4ftNzEl/KfFZkirrrQoIur2jzDFfhcErgrNWcMoDaS9ib/z/2/rGK6N71fLlA4quPfnSFPYHyQzLoSChSsLJWZNaFmqinmmCfC4iNmak3YczpOjfvWchTJbKpBrBz3jeZedLTKv6D8DvNtnAO0q4H61PWkWRGmC0Yk0v8KAD5lyYA+gHhXcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNRZ+ELRXVW3NXJAzYcXU6HnhsRjgq9NamXsBvgMYPo=;
 b=nXag0CwyMSi44TsQCw96KSRzJXNHGGFDHmY9jSJMiAA1EL9jAgUqxB6YwxPVnNsvJI4dp+5Io7L7yWYl/q4gyJGTtBMcwwnztCjMG0F3NlRB6GL4o8PddBiiameq8tMKwjqMeOBEK7AtJ/BEokWBXxGyNvqcgV6OC+RzhyJ9FtEdpdn1SQ/P3VzZDfKNaajJSP0+BFyBT9L6sazHvginj9saRlWPgxqJIpWhO4yo94ClLunPXrsaJCzJqH2nNagRbbmHbJxKcAHrOViwX86xUOfvqiK6JkURy+gkdas7KjL4CqhhqeuVJcA2Pf77J0mDcSwLQTPTKis+cJj/qPA+/g==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN0P287MB0426.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:11b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.34; Tue, 5 Dec 2023 14:15:08 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3%7]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 14:15:08 +0000
Message-ID: <MA0P287MB0332E148B9F8922E01758A5CFE85A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Tue, 5 Dec 2023 22:15:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] dt-bindings: clock: sophgo: Add SG2042 bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, conor@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        guoren@kernel.org, jszhang@kernel.org, inochiama@outlook.com,
        samuel.holland@sifive.com
References: <cover.1701734442.git.unicorn_wang@outlook.com>
 <188cd5e99394f358c0d103b8b95377f32c010161.1701734442.git.unicorn_wang@outlook.com>
 <5412a9a2-38cd-4321-9ee6-b50dd060a08f@linaro.org>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <5412a9a2-38cd-4321-9ee6-b50dd060a08f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [e3bAgTdJYd4P/oTmavykzuHWwXkkq8tn]
X-ClientProxiedBy: TYCP286CA0098.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::19) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <9c5deb44-5c48-45ce-af9b-951678cb3056@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN0P287MB0426:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b0a493-7290-41e5-8ad4-08dbf59c95e1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yqFA0yiry2JvJHOctcRXBxSv4x+B2Nsl25342Ar3i/4pq7RWmnIvC/0mkqXp5bXGx8Kt4+igLdSnqTMTExm83gik9KhaXvcgosJ20Mb9qV3jWZ3YS8g6Qi0DtCGjHO7LB3srD5IrClRAIN9ISpSCLG32fovkdHkhmcY2DUV8BHxaciFH59qGPm3j2sJPOtMEKDg1TDXL1YPV1nP2rK00S1SVEr7eoQqweRwu2qTcnXTVITERUZ0TNMcYOXF0l4Qro880y/BTRA/0HHE3viVnTyGH63HLSkz06rBrODKm5L9w7YmpPbkIHFQHjpkrLxGm7Mz4hKMrEN12J+adp2esY64ssSNANTgCtf/CVTDwrI6Q03NIKyect4tsSr8pJQtZM5cjaYz7W+zIEvS1Idc2bxZF/vSuTkVb4PBtlZ45jiLH1cpYSMWnZ9aBe7I4aO+Lkwwh7ei7iG6FHlJUBF/zlDakkiFRuewdiCAqly+4BaeomJRtXwJf0qlbWU7SiwezAvNndHmbyS8cQp9u3Nq8/Igf+m/Cs/8X85HQgmfvSEMy5BaHGVY/Yo7DbVWPlgop
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVJCVHgrbXJjQVhmQk9pTnZHcSs3d255ODNLWDV6SHFDc2toNkkvNUEvSEJi?=
 =?utf-8?B?dGdDNThydm1wWHJUMTdGa0VOdWRabTlJNzA0NmFOSWlGVEhLd0NxbHBHa2R6?=
 =?utf-8?B?VnoyYVhjUlN2a3g2OUw3YnN1WnQrK21KL2Z2NTVNTG5OS2hmbWYvOEYxbFV1?=
 =?utf-8?B?TDE5N0EzUWR3MVoveHZDSjNpdWFrbEh1aGZKVEh6YkxqQ3BWU0dtdnZVb2Fa?=
 =?utf-8?B?S0hhM0wvYzAxa3JPMlU3L3c5WENEaGljS0w3VWV0MFJhUHRodmhIaFlVUWRC?=
 =?utf-8?B?WTEya21GTU1wbTVObXcvR1gxZEJkc1h5Z1hzNWFHNE5BKzBVaFY1aVJ3bU5K?=
 =?utf-8?B?R0FWQXpLVUJhbzY0Zk1BcXBRQXNIeFdMVUwvSFpQMkRyTjM1WmQ4ekdDZ3pL?=
 =?utf-8?B?QVZVdTZCS1BIOENZTmlUZ01JKzYyRk9iZFNVRHlzVVZaemlBbVFtdlpzaWhB?=
 =?utf-8?B?MVRpZkFoTzVIVHJaRFhLc1pMZXd0QWg3OFpqdUZDeWtlcEFUeTB1TVpUdDd0?=
 =?utf-8?B?WVVLSk1qcEhoS2dyNEwwTVA3TEx4T1FmNkZwcUx6N0ZCVEh6UWJ6L21BTWQr?=
 =?utf-8?B?VmhJUlFxbTZ2dzR5SWZQU1NxaEI0ck1kbVV3cTVoY2dybk0zZTg0ck9FYXZh?=
 =?utf-8?B?dGtZcFVMQmV5QnRFbi9lWlR5L3I3QkkyQ1NYbXJ5VWVaRWdOUDNLa0ZFN1NQ?=
 =?utf-8?B?SkRVWStrRkxORUtJRGtoL21xWCs4eTJDb05BRWRWL0VweEl1c2FQSFZmb3M5?=
 =?utf-8?B?akxoejByLzlYbEg1cUNjRHJBS281Rm1RVldtOVJLUjlITjVEeGovNU11NjZz?=
 =?utf-8?B?K0FQQ2lTNUlLOVB4YTNkRHBNNHBuRnliaVJBYzVZSDFCRWpNZ2JTNTZwWDN3?=
 =?utf-8?B?bEUwemlzWFpjK3Z0eWxTOTBVQzNIYVJ2bWJHakF2L2NtYXdUdlhpdGNNUjdB?=
 =?utf-8?B?Slc4MWM0ZE5BYk85S05iOTMyTFg1M0R4Nk5nc3lrK0dsTEtNcDhON1RtS3Rr?=
 =?utf-8?B?ODdrTzRvVjNNKzRrSEpzTG5zSlhjTzFpNENSaEVYUzlEYkp6c096ajlad3k2?=
 =?utf-8?B?MWpIQ0JyUmV1eUgxbTBzN2JYa0ZLL2RLYnIyOXVHQXVZYlRNd3B5cXZwSnZl?=
 =?utf-8?B?c1I4VkZHM00yMHVOeFFrWVVQeHVIRGJ1aGkyU2VyWkl4WGNKWTQ2T1dNNWl0?=
 =?utf-8?B?N2Q3d2FyWDdCR0hQWVRlSVlMVytBM0VPT2JJaVM3OHdLbjgrcGt1M20waVBL?=
 =?utf-8?B?RmZlTnYxQmxrRUVBU3gyVVJmc3I1TDQ4d3RYVkhhbkthTSsxWklycEgxdFo0?=
 =?utf-8?B?ZzZKN0lCclNlT2Y5NEkxT1o0OXBia2pHZnp4OUZzT0tqTDNoM01EZ0c2cDRh?=
 =?utf-8?B?Y0poY1BtK3dFWXVFc20vRlFyajZncFBoKy9qcDF5Smh3eDJIUUJOTFZSVFVI?=
 =?utf-8?B?Y3cyV2s0NEZyY0EvSkV3TFQ3c0ljWDZtd3NSRllBRmtQVXVpVGl4cTIwajNO?=
 =?utf-8?B?ZzhkV3V5SllVcm5QeUFjNUpkeWl5WG5MMVJhSXdVN3B2MzJXVlcrT1lhZEJ4?=
 =?utf-8?B?OHU2cWNWaDJjUkxXK3d3YXo4OUZwWUtDS3Z5aWQyRFJPclpSVlBDM3BNRVJB?=
 =?utf-8?Q?OtDfrlevNBU5fjXt3bEAJORYHAYIuij5wFmXRa+LwdQs=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b0a493-7290-41e5-8ad4-08dbf59c95e1
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 14:15:08.6041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0426
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/12/5 16:08, Krzysztof Kozlowski wrote:
> On 05/12/2023 01:23, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add bindings for the clock generator on the SG2042 RISC-V SoC.
> ......
>> +      - const: sophgo,sg2042-clkgen
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  system-ctrl:
> Missing vendor prefix.

hi, Krzysztof,

One question: under what circumstances is it necessary to add the vendor 
prefix when defining a property?

Thanks,

Chen

