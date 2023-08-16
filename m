Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22BF77E338
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244993AbjHPOIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244204AbjHPOHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:07:55 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BEC26B5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:07:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alsTJrqeSsRsGNoN/2qhPZ+krNOExJsY9L7JLdBuewAsCk3c1tABWi5LKA0F0RrhAGb5FaBV0X//7sZEaoo1PQbO4WrjRDMDQ0ZabMtKLZBUhRvrD7mdkuQxKuVgok1ln3HCHhDIsWAz5wO75wnjuRXS53Q8l/tUjwqLYkdedO+EUUU9vupl2aVyvBMEtUVWE4EEE6Yj9vtshYqc5XA48BJa3fpgjVLPC3NUs7YVz3Ac5Q/GY+pEMUVqxwnneZI5YNSexlftlf0pkhU0O0fOwPvfgESFe94sMRaXEqMt/M9wLRVW8S2gGU6VMuTJ1RRIp21JX89tHtinWOxQYidbyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xuvn4i45cvbcfisnvDoRqP4JjHw+tmZS3tHfQnk/s2E=;
 b=LEGdFUCsXnandyhpcV3+vcIkTiakEHk8Is0BSTu6y1oZWgsZ6jJtlg0Mw7woL/f/BJkKHuEAgNNSm3CLBY7BUXY3MuxeGXtyJ5F/8YObTYPmYknu9fpIDM5J+/R7YSSQdgrmoF7p09YcrMbHyeb/I/VIN99cg7ShAttBDGux+1BkLkmVfGXl42ILqZ0vlTE1MszAPJYGqCcF3Itha2pdSmPnBjdEh5O5Jz44SXk3Z/6Ktg+mPSZvcs1mcNR3C5IQ9HJqx+GuGszbfF0ukmJDNly4opJn6vFh/Unr71BLS2isSpUilqG74Yq8tgBS1y8ye6IyzqZpGLxoaFD0lG0hGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xuvn4i45cvbcfisnvDoRqP4JjHw+tmZS3tHfQnk/s2E=;
 b=nSRff++NwekPmZ7T7iYTVt6qhgogMAzq+Dn1Vb/7OUNDQ0ij1ZUDOcFm0LFRaJwPjuISmxRjiN/0KTyQrFzEtc4RYffoKZ+XdTi1wGinnGeUCj2rITUE3zQiTiy6l/VkUdroFvqtga3u8SPK2cQYWIiGi8KkUvG7sd09QSyMN8bn9MdtLFGipJCiXa90LkYUHveO/Osd24J0A10qKB60au04JxEfas+xN7Cf3MphZRZC2dY7tqcWh8v9Ym+9bsEuEk+mAjF1LEWKXFB46Amy3tmWkyHZZsTcX4FTbMuY3PjbDgVmy9uqU4+nNWa4bp+beV5R/WafOWHXyalaCE8kyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7230.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 14:07:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 14:07:48 +0000
Message-ID: <1fd4b729-3896-48b6-865e-85b4f1ba5ee9@siemens.com>
Date:   Wed, 16 Aug 2023 16:07:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] introduce tee-based EFI Runtime Variable Service
Content-Language: en-US
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
References: <20230807025343.1939-1-masahisa.kojima@linaro.org>
 <CAC_iWjLU+mVtG4uGVoEJSJwuE0=GVcfJgi=h3QX54=fh2P4EAg@mail.gmail.com>
 <660cec45-d0d1-433f-b58e-a22a07a289fb@siemens.com>
 <CADQ0-X_dJag7EuEEEgCZrnJNNH9Va77mxmGYA9vPFw9DkoB-AA@mail.gmail.com>
 <CAC_iWjLzaSBz3_j=rz73QLCBX_YouCL+KBvR7sXMFFMQA3pOPg@mail.gmail.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAC_iWjLzaSBz3_j=rz73QLCBX_YouCL+KBvR7sXMFFMQA3pOPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: ed547862-537f-4917-f7bd-08db9e622be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HoH/AYgX2czoA+S2MDkusMja5+R4r52oxo5DxM/Om/ESNMlTqrxf8ljvoAF15s30W+EVYVe1XgLsDzGtdqF13vHS1ccRveF7nSgSdhKorARyIPf/dUK5qdTOqud+XgxehZSjabroTR/ZJ+shAYSE+pY7lnpRvkPdOTOsdidVJzNTmmnoBYgAWLIAyxSwW8ULb76f/pcPvzOHSmhSyn5eP48z0pv0Hr6yuEtz+bbtNOAlzn3EWqv3ujvKMyPD5b6IttxmeAZA+m0Gv40BjKCCR+nXyoR1EbhhjFWEiUm++AWbhi4EnEcn1kHD5MvQ+4ndG9RY2W59vfVsGnwnZmURXhJ2mG8wxWl7FQGQgseiMIgOAEezHs8WFQqf4ay+vGckY5FnhwHq9WbMx5UUwU0gBNj7RHBdAB0ElgGy+o5H8D1qV4x6uey3khAEjjeh9eaQBKI5u7A2b3NxQ1PA7kxh+Y69l60mCSZRwmu3uoQpbLsEMJz25WIYj0mhoD20+VlYi786c7fTgtNdCBfrOdl30I7J0Z7GRX/wlhHfNUkXHarEoiHJsO8iZHBDDYOeeK6oSoZaPvw3U9Lp44v6p6HKqzsnuyVq7BQshSgI/0J4IEd9QrMIjiXk9/CxFLbKswCVEZ4ZFoNCT0jdYlLITUy7nQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(346002)(39860400002)(1800799009)(186009)(451199024)(2906002)(7416002)(2616005)(26005)(31696002)(86362001)(53546011)(36756003)(6512007)(6486002)(6506007)(82960400001)(38100700002)(83380400001)(478600001)(66476007)(54906003)(66946007)(66556008)(110136005)(44832011)(316002)(8936002)(4326008)(8676002)(31686004)(41300700001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SllJWkpHeXlQUDh4UzZ4SjZQekNNS2YvVGJxVnNzb045V0lmY2s2VG83QnVT?=
 =?utf-8?B?c3k4QjNnOTRQd2k1WWM4aFFvdFc1TWNQeFBLUjUxMWpmUTJmSnJkdFVyZ1dY?=
 =?utf-8?B?VDJTaTVuVkk1dWdmZkhWUHhodkhPQ29wMWhXYURSSXIzcTI0dm1pYURVSzRj?=
 =?utf-8?B?eG00Sy83aW9FOEN5WVFDRWhXRHdNdlBnZG9OMFZveWFQS1ViVXlibmFtVE9j?=
 =?utf-8?B?enpPYWlYazlIN2xEYW1rQzAyejBmbXZxYmR5SE5QU20veUtvdzVPcThKcTZp?=
 =?utf-8?B?QmpudDFxc2NhQUFiZUZySkpWVkJDZkl5MmVDbGJia1ZseHZ1YWFRT1p3clEz?=
 =?utf-8?B?clFCbVZBZU1Yb1h0VHFBaVZvd3djWFdlcFloMlA3ckRSN2tKYjN2RVhUMEpu?=
 =?utf-8?B?U0FFeERmb2NIYmNWUzVEUkduL0pJdGU2cXFiQlFueUVrWFprVGtPVVR5dnZX?=
 =?utf-8?B?L2M0NWNEcXpyTVFCNW40T3orY1RhZ0hYcGFRdkhaMHRmMjdPQm1SMFJIeCtl?=
 =?utf-8?B?S2dqVXFTdmUyWWFacFNhNTZBa0c0d2lSMXNsMUllMFlaYlY0SHR0MnBaTFVF?=
 =?utf-8?B?VkF2V2U3WUt0S3ZjeWNUR0RJeG5yaW5ER2hhQ21iSXcxR2QyUEFMOEcwODVz?=
 =?utf-8?B?Z1V5T2wvUU9iQmorL0FIY3Vmbk1DQXkzSXdoQldDc0tZYU1NTG43bVUzc25J?=
 =?utf-8?B?eldEMmFyRHpyOGpMUm1oYWxoM1RLUCszakNYTllDbFJIN3UzUXQ2YnBWV2VR?=
 =?utf-8?B?MjVGc1Rvb0dHMTMyVDByYStjcVpLL1NhcVk3YlQvb0xJRHcrMjhoOGVFa2VC?=
 =?utf-8?B?MTFudEViamVzYkx4OVBSV2hhM3hLa0ZreXJGcFVDMW5wcytZMk5UdE5BRk00?=
 =?utf-8?B?Q0UwdzVEMmpzNnF6NUpub1pqbHNSbzhyVzBXcUZSeTBDYjdEQlpoUnpLLzJO?=
 =?utf-8?B?cUtzTUtGM0lrU0dGdlVabi8rSGhYMWRxS0s2akR1c2J5dzZoOHhvcEplS2Fp?=
 =?utf-8?B?YVNidS9XcnpLN2tBckhJalBwTkExZlNNUk1kUDk3VVdxWFhVVEdES3RISEJm?=
 =?utf-8?B?NlJDK3owdlNiYi9iNXJaMUx3RjMzZ3k2UWNEQ29PNVlaSDNOV2tvMXVXSzlM?=
 =?utf-8?B?b3dXbjc5U2Y4Q3pyOFlIZlE4S2xFRmhNZ3YxaVV2WmI5UXVmSnhUUHEraWkw?=
 =?utf-8?B?UXdJbDdtUlVMckN4QldyWnRPZVA4Q2o1dEZFVHNMcHRUemJBQUdNQTBPa1VP?=
 =?utf-8?B?M3dRUEovMVhUQ2g1aWhTcGtsS2FWRE1Lb0VPVm9MRGFwU01UQUN1Rm1wUHhU?=
 =?utf-8?B?Mmd0c1BzWVlpaWlyaUE3Y3JtUVhYTGNoWGZMaUsyKzRNeWRIOHV6WVpKek40?=
 =?utf-8?B?SE1NQ1gzYWFLVy9JblVkMHhmZFBmbmpwMkpyVFM3OXNVbDd0NjVGMEpvRy9W?=
 =?utf-8?B?dDJxdnFqSktOMWEvbWZRVE9ycmN0YmVJcWkzaFhPaUx2aG5VQjZQS1Q5WjdJ?=
 =?utf-8?B?emI1Z3hpVlZINnJ0K0lOd0dHdmU2QUxGS2VMU0lNVGpjTlpXdURSVVFSNjZy?=
 =?utf-8?B?akpxYkpEMWlnQm5qVzhtblNBTHArejZPQzU0ZDZlb3JqL1ZLc3BnajBQS09z?=
 =?utf-8?B?UENUb1J0TFJ0QWd0a1FOTmZZUk1TdDREK01XaGsydnBiMzVTSW9PSWVBU3Rr?=
 =?utf-8?B?dnpRb0FELzB4TktGN3JYTEppSEZWekZxNWR1cWNrMjNWZGt6U3h6aGM5MklT?=
 =?utf-8?B?WVBhR0ZZeEhYOXpYUzRaYXJBdTdtT2lrdE1RZS9sdnl5NUdGWEhxaDBGcWZ6?=
 =?utf-8?B?VkF4dHhqdUpWYTEybzVGS21BTXZzUjNpbFRXUm5IZEQ3K3NBY3ArREN4Skk2?=
 =?utf-8?B?QVUzL0VINGNJQmQvWnErL3BCcldpQ0hqZkQ2bkgvM1paU1ZEc1NuWVgwZVQ4?=
 =?utf-8?B?RDBYa2t0SDllYkJoa2hkMEt0TjQzNk0rTGo3VHRnT2RIOVhOek15dGFObUJ4?=
 =?utf-8?B?L3lhRGZycy9oTW9SV3duQi9QTnI0a0plcDA0ZERMQnNReFdiZ1Z6QlBJZXlG?=
 =?utf-8?B?LzVHSlltVHZhSzUya1ZqcU12ZGYwZGR6N1MvTk00dmh1Q084ZEVLUmc4SDBu?=
 =?utf-8?B?K0pQSlRVckhkdkN3d0JpOW0zdnI1cE9oQVNtSmhBQ3dWZjN6U1VrRlJUdG5T?=
 =?utf-8?B?MEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed547862-537f-4917-f7bd-08db9e622be9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:07:48.5603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P97eVk9q+mGj59rK1m1Wf/rIDQZk00iHDu+XcqIH0bv4v/Qb2nz33THUIqn+cELPgNmbeUritCEfCOGImgPmCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7230
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.23 13:58, Ilias Apalodimas wrote:
> On Tue, 15 Aug 2023 at 05:41, Masahisa Kojima
> <masahisa.kojima@linaro.org> wrote:
>>
>> Hi Jan,
>>
>> 2023年8月15日(火) 2:23 Jan Kiszka <jan.kiszka@siemens.com>:
>>>
>>> On 14.08.23 11:24, Ilias Apalodimas wrote:
>>>> Hi Jan,
>>>>
>>>> On Mon, 7 Aug 2023 at 05:53, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
>>>>>
>>>>> This series introduces the tee based EFI Runtime Variable Service.
>>>>>
>>>>> The eMMC device is typically owned by the non-secure world(linux in
>>>>> this case). There is an existing solution utilizing eMMC RPMB partition
>>>>> for EFI Variables, it is implemented by interacting with
>>>>> OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
>>>>> and tee-supplicant. The last piece is the tee-based variable access
>>>>> driver to interact with OP-TEE and StandaloneMM.
>>>>>
>>>>> Changelog:
>>>>> v7 -> v8
>>>>> Only patch #3 "efi: Add tee-based EFI variable driver" is updated.
>>>>> - fix typos
>>>>> - refactor error handling, direct return if applicable
>>>>> - use devm_add_action_or_reset() for closing of tee context/session
>>>>> - remove obvious comment
>>>>
>>>> Any chance you can run this and see if it solves your issues?
>>>>
>>>
>>> I also need [1], and I still need a cleanup script before terminating
>>> the tee-supplicant, right?
>>
>>
>> Yes, we need patch[1] and a cleanup script.
>> Sorry, I should note in the cover letter.
>>
>>> And if need some service in the initrd
>>> already, I still need to start the supplicant there and transfer its
>>> ownership to systemd later on?
>>
>> Yes.
>>
>>> These patches here only make life easier
>>> if the supplicant is started by systemd, after efivarfs has been
>>> mounted, correct?
> 
> Not systemd specifically.  Any tool that can signal
> <dev>/driver/unbind would work.  Sumit is just reusing the default
> unbind notification mechanism
> 

I was referring to the boot ordering topic, not the shutdown issue.

The latter has now a nicer way to trigger the device shutdown prior to
killing tee-supplicant, but you still need to do that explicitly, no?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

