Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8401E7A4C92
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjIRPgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjIRPgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:36:38 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20631.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4049E10D9;
        Mon, 18 Sep 2023 08:34:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DADmlp4QWUDjdlGMb4WQ7P6LT0KwJbL/xEwVOjTRia7UCjORWrkA9L4neV5Fjc6pz2oLz3u9hkbt9yh+US+8nsmUjokBeg+zNh7LBf6CjFyLFuogbfjPiAiUJQMr0phyPy/BOunnajFKq9AIlTwFZMLjVUluSZ1sfSRk46N9PP0MBPsVZ1bSGWb0lR924aUBx0Tjv6mpKoWz4TzZ0FidiexAWAN5pdIeZEjSrb7/JKtxHrd491mpX0UEOcA4IjOEmsh6Nyl5GxigO2hzs6uSDtfahdGjzkDZOvJ2/8pnhQAWkrYEt+660Q1MSDlZXMcxVqpKthHF2gqWv827HkP4Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tMvqXsI6J1PdytcQcUyQDhF4FXjOTOMYIJivD1317Q=;
 b=i5dVjnuCZXxEkm37ehL8xy5xhbZSdrcrPEVbw49I2YGhn0iJ171zrau2WME33Qb0L0rJ3DoMd9onLwoMh1seXOoC2IBuwxtqrSE3eBQe1qgKsXzXH/30QSkln/X7mhuejwqE0cg0D4pOoPj44gi5Mjf3xoHU6fzFKgTDcO+35msvQAXcy2ABW8/tLMy4WXXiqgbwXN8puL5GUWc3QmiRZlSf4UOsZxOH9HsrIl+b0QL+bX6d8iMcSWnVaVeU3Iuagbr7f1Jp2EtrGOYVR3+6VO0sEe8a2cuM9SKVwKSDjCfY4BueDMGiXLXiAdj+QMVJtFkt8DJh0Ph9+VlPjgX1aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tMvqXsI6J1PdytcQcUyQDhF4FXjOTOMYIJivD1317Q=;
 b=qqlLr0SQVLivjsbtkY4UqEYmj9x7BWQ61RqmYXt3gV8zSzReEY3txfnheTkr/aLIyquZHZnp1I0HwVu9615PErSLfnvd+u/Hoz3THYH0YSKYt8oQ1mlDQ1mJ1na/CEc8PJkLfhDlVvU036wD2ldnjFgtzsJjoEfTO8lmi2/CSJBFMYod5iz913GPb0bi8H36PmzcWeWLZsqfUz/eQSakBlEN0qDud3ttTRzb2M9fgpia1oDrGwknbWvHnWn2QTm4KuQc1XxZtCYVh0ViLb/736rgaYlRAkvsajRQm7Uz8czer0O6LisOTz6meJMaQXKNBCQR/DzGIovbVwD+QkPLew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.26; Mon, 18 Sep 2023 14:31:26 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1d1b:2ca4:1600:a865]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1d1b:2ca4:1600:a865%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 14:31:26 +0000
Message-ID: <8d192ce9-80fb-db87-f1e0-39baac00098c@nvidia.com>
Date:   Mon, 18 Sep 2023 15:31:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6.5 000/285] 6.5.4-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Sameer Pujar <spujar@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20230917191051.639202302@linuxfoundation.org>
 <dfe78c1a-8322-413b-f1b7-3a6a307a831c@nvidia.com>
 <2023091846-cabbage-imagines-3fde@gregkh>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <2023091846-cabbage-imagines-3fde@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0359.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::22) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 7298ecb3-9fff-4b76-2639-08dbb853f0ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZfNxpYKoChjuNSJ7M8iVrjJ4u9METSReQGlsHqWEMzeWi4EW/pftHKvJRcrho/SITRxUOknEQkix4YQOtt5uQ1njZhX91MMPx94Yq9M8uv3p+oxqGfJOsUjDraiR0CXfsFLrpWjupFWJIcjKaEMbVs5M9RLbTUKveVBwNkKu7gtVcQHhuAbjIJd6H2yGpFLMAN2yhzZXCB6T4uVdD86ZR77smVoFlE+aS0qXdv1yiwfEYBHUjBoL4aeHhEX11U/iAEFaRjFkwekiue47FSNpgp8ROaxruUhwaCnNmxfYH645WyRCnoflNydPR0JMjs10BEFGgEEJN3jorwMQp3j6enOPGZ7XECttTRO5iVlzK/CtpsVLZwCWn7KLHtQCTGMR4gGHd8/6TihHH7TUGEiZCuKF65ow9rCmp8dYr/4kIB9IfPCB6AEtlquo+TXnR1IZwv0zNAVVMy6wZyBHbE3zQXaX/SQvL+JJ5BQeHcY8NmX5RxamjJRppy6WuvsAraej5U6Ee2fVwTXCj+y8WUzB21sh2+EL814PktJXJNdZzC5PBUYczgiqPE+2tLYPf+zcZwSKz3hz6Dy1Hmbsgiz8a+iFhZ6FBLP7Gs9v1DzP9PeeGD7OJHkOWsrOBsGGIwnTqZFz6Dv3LW9/Y+s1z88p6dqR0Yna8B7zuJovi54/aT9N1enP2Zz+z6BX9O+4Biij
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199024)(186009)(1800799009)(31686004)(6506007)(6486002)(6666004)(53546011)(36756003)(38100700002)(86362001)(31696002)(2906002)(966005)(6512007)(2616005)(478600001)(83380400001)(5660300002)(8676002)(4326008)(8936002)(41300700001)(7416002)(316002)(54906003)(66946007)(66476007)(66556008)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE41Um12WmJwd01JWVRMVExTSXRaTjBsZVFuSDRtVXVoM0hPSzFXUHBHSlht?=
 =?utf-8?B?TVZNZEg2ZGtHZm1PcHd2cHdZdjdqWTVIc1FHczBEVFhZTFpHRlVEUmVHWGhh?=
 =?utf-8?B?eE5KK0xKenY4S1dEZ3FOUzJjQXlNOVZhbFB6L0hnS01TTE9ReGhldjRucW9F?=
 =?utf-8?B?SURabCthY2ZVM255T01IaWNVQUk2NHhsaGxnWi91N3A4bjRCREpVaEI1Y1ZY?=
 =?utf-8?B?YVM5OTRpeXRmK245Nzc2czkvbS9qMUNJblRuRWs4L05oMjNIVU1QUndDTmZZ?=
 =?utf-8?B?UjcwMkZ3K2FXOHRYblF1eWFqb2lRQVh4L0IzcEtkMjNTUE9Qd0VHbUhvOWRK?=
 =?utf-8?B?OHpWWkROaW9BTndBdzdJRTUwUS9MT1Q2bDB6SlJKSXIzcGoxcXh6ZENiQ2hz?=
 =?utf-8?B?clpyTGhYcll5YVRGNzQzaUltaUpST3p0L2hqeTJEZ3pNdkttOEpWKyt2Mngv?=
 =?utf-8?B?Qnk1YmQvaE5kUVpaWklUMERBdTFBVSsySHdGM29JdXQ3N0dqQU5tOGxUUkx1?=
 =?utf-8?B?TUxKTVpXcU9Ed2Q0cVBqd3l4V1BVaU9DUE1kZXNJd2FYRURVeXlLYVdjWDVL?=
 =?utf-8?B?ZTY5YUEvR25zaldHb3dwWkg3N1VFZ3BVNGlQV0xsV2dhZnN0YzNpNXRxcHhj?=
 =?utf-8?B?cDR3cTdsUEwzQ3JVcEJyWnl0dXlMaDlKMlRvQXcvM1A5R3hvQ2NVeVVqMVZW?=
 =?utf-8?B?RWE0Y0xNMWRaNUltdnBkZlpKc1lQQStLemRsZ0FpbnhRSzNNc2FXVkdRSEd5?=
 =?utf-8?B?M0hQTEQxbmZiVEhqbXNPTE9JNXZqeFRKVy8zd0FvS2pnU2NKMTZlUXRDdTZl?=
 =?utf-8?B?SXpqajZCejRObDBJTmx0dnNsUmVJVFI1bzMyU2hiblFHb2lNelNxR1daeFlz?=
 =?utf-8?B?b0NzQzBiWDQ2Zk5tT2JIck9UYXRuanFnTlhVZE44Q0ZkVXJYZkJKUkdJY05l?=
 =?utf-8?B?U01OMW1JTE91UEhkS2pGc0k0RUg4cmFwYzA3MUtxaEhBRGFyeStCcTdCQ25S?=
 =?utf-8?B?QmM3UCs2dnYxZEdBRkg4dnM3OHJJaEZhRTN3WjRvTkpEQVlmTjFETzdaTkp4?=
 =?utf-8?B?UENJaDNsNjR2ZDlTQmk0K0JTT3YzeTFiWS9uY0ozY0NqMlF0Q1JiN2NyYzJY?=
 =?utf-8?B?eWJadmpHZ0lHbFJma3ZpWVl1ZDhxcjJ3dWRSUW5BanVnNEl3cnM0VkdwZzVs?=
 =?utf-8?B?RzdTOEhCeldmYUw0aVp0WDI0RktoMlBRQjlUbzV1cnI0VFh4aXJ0bElFa21G?=
 =?utf-8?B?VXRSRGo1U0dGbDJTMno0WDlVOFR4YUJra0pvQndaMjhtMGJObnNwMnpzQ0Jx?=
 =?utf-8?B?eWc1Kys1K2ZqYVBtcEI1OFl3RlJyRnRKMkFINEIzSllEenAyS1dseVY3WDh5?=
 =?utf-8?B?b3hJM1hCWGJyaEVGMzlvVmhnMzR6OXZkVGZXbVJsVHNGQVI1bFRHdUdmQWpS?=
 =?utf-8?B?K2M3dXN6U2Z1Y1FGcTkyUWVhZ3VyaHBsSHRWMDdITGZkeTNNbE9LdVJEK1NF?=
 =?utf-8?B?VDRzWFlHZ3dsRmpGdGRSSXFDemlRUElWN3ZKSWlLZkhZVjdhWjl6b0lZcFor?=
 =?utf-8?B?QlFRaS9kcFBkS0hCL09ZM1F2RWw1RG5RMUpZSUFOY2l5eG9yWmRTcWZtamZu?=
 =?utf-8?B?QTR4Nm9YejhzdW03K3QyMXYwTlFaOEdnSlN1OXB5WEtuY294QzRyOTlXeGV1?=
 =?utf-8?B?ZFl3aXArVHZSckk1azB2dFVXZmpKSUhKMW1Yc0k3UytLeENKbGYycG04UEtZ?=
 =?utf-8?B?MHZYcmFyNjRWcjBhbW1mV2o5ak4rMVFuVkJTekVkaXR2cjBvVlZ2alBVd1dB?=
 =?utf-8?B?NUYyajhDdWVOM09YUnVzeDNVNkNORzQ5ODBJeVJBaVlreDRGSFY4KzFKdUdw?=
 =?utf-8?B?cU9CdThYWFF3ajlIeGlWbmc5VElFcDMyRTUyR0pGMmtkMlRvSmRaNFBlT2xM?=
 =?utf-8?B?Nmx4UnFIaFJjS25yLzBxRGtWWm9wcmdFT3ZtaUZKbTVEajNXZHRlcFJDcFpw?=
 =?utf-8?B?ZDVyeEN4RW9xbjJWZitmOHpLSURpNlFFckhhL2NOZEpLQzlESVNxeUptQWNL?=
 =?utf-8?B?L3hOdGI2T3Z1SlJTTjlTVzZZWmdoSHBrUzZJUmRRa3U5YjFSaE9IVXk3VnV2?=
 =?utf-8?B?OTRtdmowY2RSY2EreXFlSVQ4aTBKemtKT2phL2NTZG1UeHJFbjZZQVJYU1Bm?=
 =?utf-8?B?RXdZcU5FaTNCK0FYNnVwY0Rka1FaVlA5UjFNM0tqckFuR1pQUWU0UW9qYzdl?=
 =?utf-8?B?YnQ1N2RpOVNwOU5mNUVVaTVid0JnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7298ecb3-9fff-4b76-2639-08dbb853f0ba
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 14:31:26.6040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27edbuBVbnbHnssbwWhaI4RTKGv3krisAaojbYo6A/9ZbnviigHPRMswhLSdlaNxxNVG0dYya+hAYm4/nZ4fyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/09/2023 13:56, Greg Kroah-Hartman wrote:
> On Mon, Sep 18, 2023 at 01:52:10PM +0100, Jon Hunter wrote:
>> Hi Greg,
>>
>> On 17/09/2023 20:10, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 6.5.4 release.
>>> There are 285 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.4-rc1.gz
>>> or in the git tree and branch at:
>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
>>> and the diffstat can be found below.
>>>
>>> thanks,
>>>
>>> greg k-h
>>>
>>> -------------
>>> Pseudo-Shortlog of commits:
>>
>> ...
>>
>>> Sameer Pujar <spujar@nvidia.com>
>>>       arm64: tegra: Update AHUB clock parent and rate
>>
>>
>> Unfortunately, the above change is causing a regression in one of our audio
>> tests and we are looking into why this is.
>>
>> Can we drop this from stable for now?
> 
> Is it also a problem in Linus's tree?  Keeping bug-compatible is always
> good :)


Yes this is also seen in Linus' tree, so we are compatible :-)

Jon

-- 
nvpublic
