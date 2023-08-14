Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873C277BEDC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjHNRYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjHNRXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:23:35 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2048.outbound.protection.outlook.com [40.107.7.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B34BE7D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zuuoaev8dghrvWd8PomKhK/LOeVnA+m4iKzPMKwbryGEHcZk+0aAag/Mvso2j1bEtq+rDT3yVr96shBPl500ZsQmooV8lZ5RrXSs+WcdT+b61FcZ3aqO3PhoyU7PiQ3hvlmUHomZgAc0Iv6ovhnLdSe1pCPw39HT+BOZq8KGNM/H2DtOqlMcK6F6rS/IgdXQIQ2tcj9XHZdzSIpMmwx49jlZBHA3Ucl8SmwysPJYnK+Pnuv3lP5f1hWG4FuVLBrsR+xeL7il78UEzlFdApUVB1jtVcihcW2vQij4MhUYCOk9O79piC0TC+JHLZXZjS69y7JFnkhT+SAWJcKrWxE8lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7tWsNoGX9NPC51qmfDQYTrKjnK8W84XYwVl3/ICWhw=;
 b=cMUFmSUeaoMnM/KcRIKnMuD89JixwRYVRjQ5NcKfsOGBdQlJDGZTFBgN9S0MemID0VFqYBIwGx1uLeT+vVi72sFBDzilSVwGs9HRd8oYUdyOvozrB2CvUbuATPxCr0yN7s7cEix+VnUEjZTtt1AhY8p/EtMlbEEfhFyUMP8RXLgqGXi3UCwsJ5090oKQYWJD2FDsZi0XS/Yd/FUBk6VUoas2i0yBrlmWUB4wkg+3gxVZvXoOdvtkc+MU7s3txZw6ACeTCoHv2OntsVr6iqxb9UW/S1JPwTLQzZFPQrERK96QQzWay5gk30jbF4CRD/ZVdM4Sw5a0YT92W3Do5EIlEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7tWsNoGX9NPC51qmfDQYTrKjnK8W84XYwVl3/ICWhw=;
 b=x4CCxWTQ/bk7ge9b12pnf27PylCJYnl0TWe1NJXqQE9oQ25HcWKFmyTjzo270T63iRRl5B5fiTYpf3f8XmEzrQmb+o/R7rBPNVRnFXsmShFMLSWYqSD/c09aQkjUC+OUJrVHCOJjyhDiNPCwK3gAE8Rk4N+T9ZjbB0xSUqAkLKfgJlazkePhyRH/xX+RnBTmJeFiCN1UDJHIcEy/e6VQum7UXgXT0I0Eh54H+d3VAuUbgo/MfSwkecTFj+lqh2KYAWj9BnuQ5hiwnoou9V/y8y+nT3ILAEWpKnpcVlOJ/8W4tsV4xdKW1QiCPIgo8PPnz3AihlWhdIMl1/oApc4c0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3900.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.22; Mon, 14 Aug
 2023 17:23:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 17:23:31 +0000
Message-ID: <660cec45-d0d1-433f-b58e-a22a07a289fb@siemens.com>
Date:   Mon, 14 Aug 2023 19:23:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] introduce tee-based EFI Runtime Variable Service
Content-Language: en-US
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20230807025343.1939-1-masahisa.kojima@linaro.org>
 <CAC_iWjLU+mVtG4uGVoEJSJwuE0=GVcfJgi=h3QX54=fh2P4EAg@mail.gmail.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAC_iWjLU+mVtG4uGVoEJSJwuE0=GVcfJgi=h3QX54=fh2P4EAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3900:EE_
X-MS-Office365-Filtering-Correlation-Id: 13618e33-ef11-4141-cdb2-08db9ceb2e63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 25x5ecNvRYmFGOQbczTZoxT4dAyRjRTsgQAv5Ga9chBi6u8ssOiQau4FfmHA9j491RVwrge3LJWWazndBf59W8LZ2k/kBvY8Ive3mspN8hyhVPc/1WBkISR28Suobkczhw9APV19XpyZWYmpxwC4/6Gxk2xa2kLPZPQJvFzCgyV87AXgGOAW3aNp2EIc9cTeHDEg07JaLxgfZDr8e4RZtUNjSgc8EsGDwNPdpJNd4JxOxVO/3dLnAW7A+cjhfdDIokYD7dUpJQ1tzH1u8QvjjHr3Av+uiwuUzp0kY2thz9LCvaqhYnrsvr2yIBKdA71VH4FHlcGquNq3JOtmDvbeTQ7qTvw2KEUuw85N0nijD61WW9ulF7fQYBu1Buz+gghpMm6uXRXUicKUFtrKpdF6wE7kOZma4qzyAhiTKlGSxdqiX+BuOVazwSmRtg8+jl3Z7qO7Luz+LDWVBrD9H//tdeagmOsaJD7o/7yExEbw9ZPzbL2pwXr2/2MC+fWi1t0Sxb7lPLJUWdgQHK/b3mn1CA9n9eu66S7hGyDZw7SKWBJkIfJBGgGBiso+lScPU69iA5NYsnU/vb8+JyqOclhezMgg0fL4ui9yL3veqlfRCWukg6zRrxQZ6/orlEPI9Uxfehk/vptY4/2hsB8reCL9Ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(396003)(346002)(39860400002)(186006)(1800799006)(451199021)(31686004)(6486002)(6512007)(6666004)(966005)(66556008)(86362001)(31696002)(36756003)(38100700002)(83380400001)(82960400001)(6506007)(53546011)(2906002)(44832011)(110136005)(54906003)(478600001)(26005)(2616005)(8936002)(8676002)(7416002)(41300700001)(66946007)(5660300002)(4326008)(66476007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVl6RnlhYnM4cnZ4UlBBbHQrbWVJQXdKT3J3YVgwRjBXRFk3bFN3WlFkcWpY?=
 =?utf-8?B?SlFhTXY1ekhDYjdnU28xenM4aVNQMGlWZjdZRWRvWjdpbGh5M1UyVUpLRmx0?=
 =?utf-8?B?Vmo3ZnpYYUNWS05weTNMUzZ3eFh6MHppbUwyQ1dnMGEwM2h1OE5iVUpyWFgv?=
 =?utf-8?B?bDFMVGM3R1FtRDBJQWlydThJZG9CeGVNVVVzaUJkOXBPL1ZIdEN2QmZNNDdG?=
 =?utf-8?B?M0VXYXc4WFhrYTFNOWVRQzN3bFA3ZHd1TkZhMEZLSzM5ZXhDTC9Pd21ucEdK?=
 =?utf-8?B?d1d6ZlduamszazNlVUNRdVFrQ0N5YXlSZ0FEdkdsN0JrV2h6aWtZNDRWcVBw?=
 =?utf-8?B?bVRGKzZCakVsQklmTVROejFYQ2ZBS3FoVHVYU1ovNFNGOHp3d05NKzVSWFla?=
 =?utf-8?B?WURiUUlNbTlwTW9XYmNDa3YvbTlxWWhCRUZCS3VjbnZncXlQK2lmV0lMSStI?=
 =?utf-8?B?bVEzMkZnV3B3azd1N1JCaDVRaTBnNkJENU00Q29TVnpLN25yTTdPcVJjZ1pY?=
 =?utf-8?B?N3lBTUl1SXBDZG1EU2UzQTRRKzBsTHdQQnMydVJWOXM0SXBYWXdMSWhFK3Rx?=
 =?utf-8?B?ZXZiYVFxd2ZGcTA3WkdqNGlFRG8vSC83UmMzZ1pWUkZSbXhFUThuZU1waTlx?=
 =?utf-8?B?bEFRcjRsU2ZWNUNzUzlWL0VscUp0VFpSUFZwZnBBWHplakdaU1FJeCtrbEFw?=
 =?utf-8?B?c0lobzQ3ZkFzaXE0ZzdHd3hSd082cWk5d3lHSlpEQkg5b25YQXVuTUgyUThJ?=
 =?utf-8?B?Q1FjMUpDb3FySzRrczV4NVVGc2tmbWVSc0R3WW9ycWgxQjVaT0x2Q2o1eEJC?=
 =?utf-8?B?b21HaHhneFVDWnMyZlFubnIrL1J1T0RYNlVQejlBbklLMExVd0c1SlRkUUpR?=
 =?utf-8?B?MG5KM2FpUW5pZ053ejk4aWhqODg2a05uTHVxdnhLTmV5YVk4M1NPTkxGaE5Y?=
 =?utf-8?B?UG5RYUZSRmNYT2drZXFaYzVUOHhETE5RS3kxVVMyZ3VtbEpRQ1NHLzZ4QmN3?=
 =?utf-8?B?ODZTWEFGNVd5R1dBVzdmWDhJaFdMay8wek5YVUI2MW5RU011VzF6RWRVTTdo?=
 =?utf-8?B?MlJneVNCVEduSm9ia1AvdUExd1JiUlZUeEhtZnpUVlJYbkM4SUlBSXh5Q0w4?=
 =?utf-8?B?SFNIQnlVNWxpazZ3NWJEWTlzcFFaRjR0NGsxUWlMQjhET01WYk1qLysvNm5q?=
 =?utf-8?B?Y0liR2lSTzdnOEQzdTZ2NHFKZ2o4QXVRZ2Q0Z2JoOVNrdjRlU3RsVFJyWHJG?=
 =?utf-8?B?d2M0c0xXeGNYb3ZHTHM3UXVhY08rVVlvckRPL2pKWldXWkY2anVKQVlyVWFj?=
 =?utf-8?B?SFhzU3ZZRHlUVXFTdy9IYkp4QVBXdmtOL09pOWk4TmNhcHh4Q29aSXBmYzcw?=
 =?utf-8?B?cmtwTTZ0Z09SdHRrVHBQcFJjRTlJWXNpUFV5RTVYU3JMMWFjOUt1TEpnbEYx?=
 =?utf-8?B?cVhJYit5OGl2dG5OTFpPM3NHMGlMcHlsQmxnd2VjK2FFQWhSVFpEOUdTMDFu?=
 =?utf-8?B?QmIvOVFodWdKSnlSYmU3bHo0NitDYTZlVUc2TXA3NzBzSStwclhuV2hCT2Zu?=
 =?utf-8?B?a21QZzlTSTVwRzRZa294bVZMNzAyMjhmdWJsWnF6dDZTNEo2VGJQZkNheDBY?=
 =?utf-8?B?WXZJV1R6bEdyNnVxUW0vUjQxOUhRTzNpbGtCUnBhMHBQR2QxeVFrTGxpWnJQ?=
 =?utf-8?B?MmR3a3ZhSGhOSmRsYzRLd1FkZGhRWHZNVG9SMWVyTE90L1hWOHFHSk0yQ0pT?=
 =?utf-8?B?ZXBBeG1LNUlMOUc0UXpORklCY0FUN0tkalBVZGlPM2JGVmhNYWlhVVd3R3Rn?=
 =?utf-8?B?Ty90MVBhWUtmQUtsRWZTTHlBT29kWkhpM0NDLytDb1Qvd1paK25raTF2NWpp?=
 =?utf-8?B?MkVUZU0yNGY1d3RWU2E2d0xQQ1A3RTIyejZwMkNOdUl0Ky8yKzlxUmNCRWln?=
 =?utf-8?B?bTdyMFNxZUxvSFhKU0pCMVdGNVhKcUhnVUVXcWxXZXNPQ2krQm1SUTZjTWR2?=
 =?utf-8?B?elVZckppUUZQaU1ZYkFET0pEUXp2Y0k5MVFzeFJFbkNzM05tSE8rNnVXVnRU?=
 =?utf-8?B?WEw1UkZtNTRSZ1kwSmdta2kzSk9LVkRpL2c1eEhObi8vK3hKd0FMaWIxbFRl?=
 =?utf-8?B?UkI4bXowbm9WbUluOW0xSUIxZmZmSXNmWjF4ODJFTGVhMi82WWJmczRCVVcw?=
 =?utf-8?B?dmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13618e33-ef11-4141-cdb2-08db9ceb2e63
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 17:23:31.5482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5p6CrdHnAVAkmneYK4cxtwhC1tW6MkmIzjn16Oc+jZNB9I405/hu14K0HD1dDsftlBOf0Hp6tI2Ri1Q+zBXUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3900
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.08.23 11:24, Ilias Apalodimas wrote:
> Hi Jan,
> 
> On Mon, 7 Aug 2023 at 05:53, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
>>
>> This series introduces the tee based EFI Runtime Variable Service.
>>
>> The eMMC device is typically owned by the non-secure world(linux in
>> this case). There is an existing solution utilizing eMMC RPMB partition
>> for EFI Variables, it is implemented by interacting with
>> OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
>> and tee-supplicant. The last piece is the tee-based variable access
>> driver to interact with OP-TEE and StandaloneMM.
>>
>> Changelog:
>> v7 -> v8
>> Only patch #3 "efi: Add tee-based EFI variable driver" is updated.
>> - fix typos
>> - refactor error handling, direct return if applicable
>> - use devm_add_action_or_reset() for closing of tee context/session
>> - remove obvious comment
> 
> Any chance you can run this and see if it solves your issues?
> 

I also need [1], and I still need a cleanup script before terminating
the tee-supplicant, right? And if need some service in the initrd
already, I still need to start the supplicant there and transfer its
ownership to systemd later on? These patches here only make life easier
if the supplicant is started by systemd, after efivarfs has been
mounted, correct?

Jan

[1] https://lkml.org/lkml/2023/7/28/853

-- 
Siemens AG, Technology
Linux Expert Center

