Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5627AA641
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 02:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjIVA7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 20:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjIVA7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 20:59:45 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837FF122;
        Thu, 21 Sep 2023 17:59:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxyNs4ETdZAzyMXO4cd/Zsc1ZapvhqGhZyzVH5o/3pfUUC9vw1CrNDeu2ZTvm5MZXcLig7ZL4K3IwNBligw5ihmHqjHwlg2RkKWvGkLJx7Z4T0y4UnTwfeGCTpH/9pknGGf1dNxELlnQYsrlaCOAC7YwPstsp3XMrgYtlkCP7JVj/zRWqLf0Zp22STzLA0zSvle1/patu/7fHEYR3UNQRsxdGbyZ4A9bXRWpmtr/08QWHd9RJroNWZiYjXy2FSnxd4tAaGZDlJ7SOsxzV5ndSQPw2XTwD5BFcVctddm53i9IMvnNNf8Fi2VP6GySkcEUTxX9MERHRegjFkyNrSMiGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUNXSxC8DXjza6N5j2gV4sEimSAnirltAfdi6N8Gfig=;
 b=eRPmp3P1nrBZVyrfbxF1W/T7iyLUEQ/Mgs+YP3Zz+4TOrWnu/f3tbtNuUmpJ1TEfk73fQYfeV8yv0PtXD5OutczVEwHlublEdLIBCgrkF8szh3hMp/2Ca2pXcmQ/PCGYKvGcUad4Ixi4kbB8rERadEU9/SwgPeWgublgIDTRw4xrYO7/Kwghj0FGDIVQjzVkpYQ9eYKr5Lo0VpqU4L+PV2b/wb9gPFEufP7rdadPjzpHpfbqkxLtlivPYwM+Dnsla7+kupqssldxVqHVthYwfYE4lktny9OR6np+QUk4YgOitViLn54roUzzgui+SiJJLoQ1sDxtjzqtJ2s6oR2y7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUNXSxC8DXjza6N5j2gV4sEimSAnirltAfdi6N8Gfig=;
 b=iw5Z3SIj86Ah5MftYrMuyOxJt9f5A/1pYpdDdlrLTsHc/qBPeT84QpUcP2a8Ft3yPrA4czZYb/7vh9uFfjd+nngh/87EO7CFJeBeZspvffIG+MVT6KaDZ1IykOn9m2epezH3sjpd4EeBmnUT4IEpuUzbEVPlRJbrLRie9x9I8dA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20)
 by DM6PR12MB4942.namprd12.prod.outlook.com (2603:10b6:5:1be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Fri, 22 Sep
 2023 00:59:37 +0000
Received: from LV3PR12MB9213.namprd12.prod.outlook.com
 ([fe80::76c7:5892:d546:3880]) by LV3PR12MB9213.namprd12.prod.outlook.com
 ([fe80::76c7:5892:d546:3880%7]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 00:59:36 +0000
Message-ID: <1f9ca335-4d34-4871-856e-e6aa8e2bc16d@amd.com>
Date:   Fri, 22 Sep 2023 10:59:28 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kernel] kbuild: get rid of unwanted "+" when
 CONFIG_LOCALVERSION is set
Content-Language: en-US
From:   Alexey Kardashevskiy <aik@amd.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
References: <20230920015559.1877441-1-aik@amd.com>
 <CAK7LNARrb_NLpBL19LHEdg0WJKsncaUPQLk-wxhR+Rh8sps3jQ@mail.gmail.com>
 <a6a90c61-e884-4b18-83b7-ca3d2e0378e7@amd.com>
In-Reply-To: <a6a90c61-e884-4b18-83b7-ca3d2e0378e7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0157.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::24) To LV3PR12MB9213.namprd12.prod.outlook.com
 (2603:10b6:408:1a6::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9213:EE_|DM6PR12MB4942:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6b2ac0-d837-471f-9247-08dbbb073105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dYeuIHFbG6MufulRRGeO6KHrjLuicAMyQRJmdQvp7T2PXOL/MR7IhQmtEvhfS5mgFCsBe8UjHG7QawUstWd++IyJ1pkeXph1W7NUD0UBOkOBIK4c4V/vbtGJ2CZdUCZheJEoW+/rdzo2OECJejXMyH1cYwgZtXTm0RGMZ9e/h8EBybffVgv3YsbqyRtmB5cW6LTr9IyPQJbZO1bt9x5seDwB0uowOKUk0x9atI/tZ99TnBeK0T3Q/WMFA8YWsnkm4KyokPpn7J9BlqlHmUafIvsigfALT3L5UKmzixog+z/s0HqT9hZcX3Pj6yerLXExe2tiO38sMaBRdBUEsGYBn6KlbfkMQ0ksUZQ7/Vb0zcnUkkp3sjyCS7Bz62O7wbetp4VMk/5vo4xkng095H6aDNaf+KQRBcMyfq1KRW6hx5m6EanqJjgubM3aX/pt0aV/4p2+3yA2AWNjn8Cl40bXskRhayRW21lfCn4TZBrKhAmNqIetaTTK8FcZfH5PcRayuXidTpo6AWhC2x4Jtr2bryu3HQslLHcRFXn96lAyvO/J9XbenBVtkMEKKaKLtY4Vsopw7zrQWzxyBmyKZl8XncDTzAgtdvQ+btEkEUOKpcDICLjZ6fJ6BKKrcjgdqWv23B09uTb4opeQf4qd2DMdxFC452vjwG9P84rL8klzYTUNRhsvSevNZBoAee5jzWFS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9213.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199024)(186009)(1800799009)(2906002)(5660300002)(26005)(66946007)(41300700001)(54906003)(316002)(6916009)(66476007)(66556008)(478600001)(8676002)(31686004)(8936002)(4326008)(6506007)(6486002)(6512007)(53546011)(36756003)(2616005)(6666004)(38100700002)(31696002)(26583001)(26123001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uy8yaE16VEc2MG9yaE5EQjBoeXFXSFpBR0ZUTjR6bjFkV2YrZHBPVm45NzE3?=
 =?utf-8?B?VktMR3ArNlNWV2Y2TVVYdENnL0VqU00xMkpvWXhqSlRpVm1MZkhpWnJJUDcr?=
 =?utf-8?B?STh6WTJ2YlNGV0RSS0ZRVEJrTnZVbzVkZVZ3d2RzWVdtOVVkTHFIZDlkUzln?=
 =?utf-8?B?cjlFZTAyRzJla1lBL2pzekVSeFFYZ3Bybm5BRnlhNWUwa0dHRnhkdmRBbm50?=
 =?utf-8?B?bTRQQ2lMUE5OdmNMeXRZeDJxdEd4aWdldHdveWl6SVVMTGVRQXlKaXArUmQv?=
 =?utf-8?B?K2xXQnNPdlIyYVRKa3oyOFh5MjFIRExrWXBvcnFHNmdNT2FBREZ5WjZmZFMw?=
 =?utf-8?B?R3dBRUYrMzZUYWNpYk5xeTF6NzFsRUpZbnNCQTFuTm43c3phSjl3eUpJaGZV?=
 =?utf-8?B?aVZIaUNyNnpsOUZwWWQ0K2dGNmc0MGduY2xzeVoxT2RQQVlBOHVCcGUxM0pt?=
 =?utf-8?B?U25wRERSL0VOWExaMTN0VGZpeEpaS1VvSy9YU05ZV1VDYnhqb2RCNjFsZU5n?=
 =?utf-8?B?WXRBckNpeHNicWFTYXU2c3ZmR1VyOGZpUnZFU3lEallHRGMrQjg4M0RxVmhU?=
 =?utf-8?B?S3czN21sdmVvTGVucXJ1SENhMC9tYVQvbzVPYXBhTVBUdHF3bitvbHZKN3o3?=
 =?utf-8?B?ZmJmeC9EQVphUjJNVUNPZXJ0K2htMFpGUTNTZEFIbnR5NUhnTlc5cDF1a1hx?=
 =?utf-8?B?M0Q1RVNBUG5HL09Edm94QXdKdTRlV2E1ME9OTEphdnlVRDdnWXRnRTcrYmRq?=
 =?utf-8?B?U1NUek5TYlU3VHBzYjRXZEs5eHJFMFErcy9IVUZlakFkV0wwZGxaRXg4dnE0?=
 =?utf-8?B?ajdaTzFPZWFGQlZnOWttNTRLcDgzT2lVMkR2cU9scWtlZHRRZXpYTjA4N2pi?=
 =?utf-8?B?S2xLRlNDU1ZyRDByU0JqK0w0QnlJdmdCbEpJTU9lWlhkTDdhelZ0SkFuenVT?=
 =?utf-8?B?bUN6UnBzc2dtTWIyR2dXWVljcFBrYkx0WmVXckZqeTRqb3FRZ0ZIdzczKzYw?=
 =?utf-8?B?Z0R0ZnJRQXlPZmJuYmdodmRKNGRuOFdtc1lXdVQ0dC9uUERINGJWN0NpM2pI?=
 =?utf-8?B?Z21RVElVVHdRQVJlQnhQWkptS1VJZTU2dnZKdm1acmFNTW9iR0ZkdUFoK2hW?=
 =?utf-8?B?MHNjS1hyNzJvSmpKRFlQUkpudi8zMEN4QlhMVmdNZU4xVGx3dkxuVU1nVUlq?=
 =?utf-8?B?Ty9vM2pHU3lUS0dtL0RkYzFRZ0FtMlFKTTVNeFFBMmxza2NVUExZTG44ZVQr?=
 =?utf-8?B?eUJCNW9QeHQ1WGdzZVJpVUdPNVFRMndqZGpoWkRJdUNZcFgrN2luWUNLYVJu?=
 =?utf-8?B?Y0lka0Vydy9YeXlKVFc3SVl1aFZVWlEzNVJVTk5ROHd5UHlrZFcvUU5PMHVN?=
 =?utf-8?B?ZDZpZFcrUTNxOFA5cVV2MzFlWnlRcnkxVnhVeHowMnJvcHhCOCtoYmpJbFdn?=
 =?utf-8?B?Z04wUXEwb1IrS1NwUFQzZEJtVHJjU1NTVU40eHBiY1pCbHZaN25EdWFkLytS?=
 =?utf-8?B?QjYyNldmR3J6NWtEeW9ZaENrMHFCQWpXSmM2V3lmR0R3SUhxRUZIMGUvekZH?=
 =?utf-8?B?YWVOM1ZxRXQxcktZWGNpOGY0b0w3b29LZXFtYTV2cW9yamhpOGxWSklRTW05?=
 =?utf-8?B?SktTYlRQbnp6cEJ2YkJiYzB6eU5zMFBLVzdZTmNXVmxUMURWbDlybkdlaEVK?=
 =?utf-8?B?L2FONmVyTDZ6S3JoRzViL3BTdHoxS0RkdTRGcG9CNHBINnQ2OFAzT1JlWmlX?=
 =?utf-8?B?T0ZWNnZ5Sld2ZVdBc3BtWDNsTDJleS96cWFMVGkvdVNCY25ZS1VQQ0JPY2ZM?=
 =?utf-8?B?ZzF4NzFkSUxYNHVrY1ZUWU9tanhpUUVjS0UrV0wzdjI4SnRvcUlHUGttWjNS?=
 =?utf-8?B?cHNYZjJudk1RTFA0b0hteEh3Qjg1MWNJK2RvUkRoeTNMUDdqMlVpSDZuNXdS?=
 =?utf-8?B?b2EvSWxZMzlqSHh2WURqV2gzSEM1eFVzbThsVjZFcWxiaUhWNkRGL0R6QmVB?=
 =?utf-8?B?K25lTy9zQ3AzK0tUT0FLZ2s5N1J5d0RxdHZyazBpUHRPZmI1ZEFLWlQ0SlZI?=
 =?utf-8?B?M29UM3IyNlUwNE9GN1J2TG1GQldxSmowMHVKNno3MlQrMFlnM3dNQ2MrZUNU?=
 =?utf-8?Q?iGYxPJysDj+ejQG/PhO3jmIDP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6b2ac0-d837-471f-9247-08dbbb073105
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9213.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 00:59:36.5439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBsQkPPcGdxyDU64FuyKQeJ3BW2N9laRjLFsBiqvrnA56nutCd8taIRcAlIaBVOOxsySlTnDlRxfjjpj+5/gog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4942
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/9/23 23:30, Alexey Kardashevskiy wrote:
> 
> On 20/9/23 21:59, Masahiro Yamada wrote:
>> On Wed, Sep 20, 2023 at 10:56 AM Alexey Kardashevskiy <aik@amd.com> 
>> wrote:
>>>
>>> The scripts/setlocalversion script correctly tries not adding "+" when
>>> CONFIG_LOCALVERSION is defined.
>>
>> I am afraid you are misunderstanding the script.
> 
> Possibly :) I should have read of "+set"... sorry :-/ Thanks for 
> spending time looking at this.
> 
>> CONFIG_LOCALVERSION and the "+" sign is unrelated.
> 
> How come?
> 
> scripts/setlocalversion -> if [ "${LOCALVERSION+set}" != "set" ] -> 
> scm_version --short -> echo "+".
> 
> Where is that LOCALVERSION supposed to come from, and when? Is not 
> LOCALVERSION related to CONFIG_LOCALVERSION?
> 
>>> However, instead of grepping for it
>>> (as it is done for CONFIG_LOCALVERSION_AUTO=y), it relies on 
>>> LOCALVERSION
>>> set in the shell which is not.
>>>
>>> Export LOCALVERSION so scripts/setlocalversion could see it and not add
>>> unwanted "+" at the end of the kernelrelease.
>>>
>>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>>
>>
>> So, scripts/setlocalversion will always see
>> defined LOCALVERSION.
>>
>> With your patch, LOCALVERSION would be set to an empty value,
>> which would make the following condition always false.
>>
>> elif [ "${LOCALVERSION+set}" != "set" ]; then
>>
>>
>> Your patch is equivalent to deleting
>> line 175-183 of scripts/setlocalversion.
>>
>> Of course, that is wrong and unacceptable.
> 
> Ok. What is the right way of getting rid of the "+"? Thanks,


make LOCALVERSION="" ...
seems to be the only way, is that right? I thought CONFIG_LOCALVERSION 
is good enough for not having "+", hmm.


-- 
Alexey

