Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852A678C987
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbjH2QU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 12:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237470AbjH2QUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:20:18 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A29D2;
        Tue, 29 Aug 2023 09:20:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jC7WeizngwUJbVZWyCiXai3hKENwAk0e76XM40+x9yPyO2cwvesg9WbEQuze1UZ5zCiSzyKbcaTBWNDMWPX6oRoi0dYuj6p5dCzgiykUMmONH3nT9m4NyzlTuGyG/4OKbJYC/UhbW5ZZ69OCOcPs9+dxewSzyQeIEzQQ379yMgNHxbOWrWZ0wTmoxQ3DlN2cjkR+4ecCUPvMZw5jouhxCvwE+fMPMsV4YATIpWIBHUTTsirgrh2nVTEdzBmnfMUJvU48y/SLWv6iwNrFu0susdt+alG4gOV4ALtEGTK+j1es54P0DbsKFc6tHK5poFg8ECUchih+v1obB8w5sV36XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zbh9KnnFHFGUzdAfiwKjtX8CyHa0knWM2/kg2WI5cnk=;
 b=buwPa3dSYNWoEMDQXBt9ykTJ4C3RiBSpWJD8TKK4w4f1ze0fLi7UGG291MA3KNs6QMwDxBufTZBv1AHwuSrW/Ry8j2eZ46c0IDWUQTf9PpqW+Mm9U6EniORuzLj8AG9JEfvY5+i1ljYyVgYk9g7FQhrt0xCZxHwE9UunrGwnYoFyF1d9M0TKUz+WznH4//fAkhr6lR1sm0Gdr9Z7KR9c1qhvDw/tWSsAs1Hc4FBjCDt+SCoByCNPT/tmfsBX1saOLZ0ZQwYjbIeS6RYVd+fuOspSjdkhivJ1QRj1AOhXN+zNlDpVRcmeKb0eF3zma81KUCrw1nEORGLgbHVXStrynA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zbh9KnnFHFGUzdAfiwKjtX8CyHa0knWM2/kg2WI5cnk=;
 b=ldSO9K1lSyl7zqbvvfTnKou9yEShR/Y8QzdSxj4xJ68aJ6HxoEC4/t2NYwpS1cW8qqG20LtdNIvuHWKjNlJmHgjy2bgzxk0zg7di8RSHP/LuVspK2gnQ+W+vyJ+wHoYNkn6TOsv4+0Wak7Q6IVQbGycSn2Q7EHxkLjjjCZ5/9gI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA1PR01MB8062.prod.exchangelabs.com (2603:10b6:806:335::13) by
 BY3PR01MB6722.prod.exchangelabs.com (2603:10b6:a03:367::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20; Tue, 29 Aug 2023 16:20:08 +0000
Received: from SA1PR01MB8062.prod.exchangelabs.com
 ([fe80::ecb8:39f9:1677:39c5]) by SA1PR01MB8062.prod.exchangelabs.com
 ([fe80::ecb8:39f9:1677:39c5%5]) with mapi id 15.20.6699.027; Tue, 29 Aug 2023
 16:20:08 +0000
Message-ID: <e9d328f0-8201-a2cc-41db-9b472b541824@os.amperecomputing.com>
Date:   Tue, 29 Aug 2023 09:20:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Reply-To: scclevenger@os.amperecomputing.com
Subject: Re: About ARM64 Kernel Instruction Trace
Content-Language: en-US
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     yang@os.amperecomputing.com
References: <ed8cea4c-a261-60ca-f4e1-333ec73cca8f@os.amperecomputing.com>
 <15c1cc81-c131-7abf-1680-0bbc968e638b@arm.com>
From:   Steve Clevenger <scclevenger@os.amperecomputing.com>
Organization: Ampere Computing
In-Reply-To: <15c1cc81-c131-7abf-1680-0bbc968e638b@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:610:53::24) To SA1PR01MB8062.prod.exchangelabs.com
 (2603:10b6:806:335::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB8062:EE_|BY3PR01MB6722:EE_
X-MS-Office365-Filtering-Correlation-Id: 707d8021-b45e-455b-f3df-08dba8abcff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JuvNJ9lzbxMmoXX6LfxUWGVuFYp3taB0BMbPS3FBvza3p/Ur78uYavtUI9tg3HdUuaki7FZYuFnDofZ+/AK1jDOPWqm4/3bS7xjPvzM26792dS0CEsZ2JNik4Q02ubtBjpl5sxyBx/WWEAXQ5vbILedhQNYpWJjclM1GGc8MCO9ynKeR1r/WMPLBrZTuC4fJUMqQZ8h7NLs8B7Gu8Mw5VdIIUjPkGgjXEQ2OqzVuyHekTdPveKOpBZQXVJbgqovOVwvvkHQVCZKwgqjtDZVxI0Uy9YaMTMywHk4vnG2vRO5LecYKjOFPION77Dsp3vq2stY9bWsrpR09mdS6Fs8E0tvc0yOhXIk2hFK6mCxkNzy54mzYxP7HmxPPLrfXe8QYwlBNCdZnq4HeMhWv8h4kBjnP0GGN2klytpDo1pDwPeH5GoNZNBUs6IiBsRr2w+Ml3yvYURq9BMuELFvDK2TjBNfF410HDzUv6HrpR6WvFBqmgkcFN/c7Lt9FyOs2SYVZZet5bntVwVlXdU8OUYe7FWJgpUwmzUf3ecwaUiL2x3NWpFDIwlCiH46+9Dd7n2ypJD0RWniP8t4sOFyz/kyZt+NMuZVlK0gTfE7FdI8LUMOxUYLGD1DTUq0WtYshWozI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB8062.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39850400004)(396003)(1800799009)(451199024)(186009)(6512007)(38100700002)(316002)(41300700001)(66899024)(4326008)(2906002)(83380400001)(31696002)(3450700001)(30864003)(86362001)(107886003)(2616005)(26005)(5660300002)(8676002)(8936002)(6666004)(6506007)(36916002)(6486002)(66556008)(66476007)(66946007)(53546011)(478600001)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXhrWGV5V1lpVmdpRnVwY2M0TzlhZjQyZ1pKWUovZzJuTERrTlE1TmFQamJi?=
 =?utf-8?B?ZVVjWUdxQTIyVFUrSHY4YXRGeWppUnQ1MEdnTXdiUy94MHVMcG14S3BxZUVj?=
 =?utf-8?B?dnZvc1Q1ekVVdllHQitzTExxTEptaW5yd0srQ2Y0TGpzd2RZVU1KVlcvcUNG?=
 =?utf-8?B?Q3lSc3BjREM0eUFYZmJidG9JdC9CMDdTUVByQkFSMTN1ckUwdnFLMG90MS9j?=
 =?utf-8?B?U0djc1ZoTVB6SnpZeWp2aVJyd01HVzFCMldTYVFtbHJ0dEhzSnpma25yWldQ?=
 =?utf-8?B?ZWhjUXVXcnh6Zjg2a0hqcUZQZzRZQVllQlJ2VHk2RnBIcWU3QkgyMWdFNVFD?=
 =?utf-8?B?WmJkNVUxR0FRM1J1bzE0UmxscWdhcHF0eWh4UXFvY1JyNTlsbFdHcXFCVzVI?=
 =?utf-8?B?eEJCRnFZNDZjQ2hLQ0RmYWYyMGhmdGdjczEwNFpvbUV2NkdNYU1udjdmS3Uz?=
 =?utf-8?B?Q1pjTjZ0TTQ5UU0vUWc1a3VhM2ZaQU5leGh3eXByM2dXdjhWYU9kaVJMK1Uz?=
 =?utf-8?B?WEZKRExCd3E5TTd4TFJVRmpkQXRkbm1YdHZZZG8vZW1UQjF1M2RTajBQV1dY?=
 =?utf-8?B?dUFzaFlZWGxZaDhuUGxpV2V3UHhpRm1EdGxXbUFwbVpFTCtqLzJKQnAyOVFQ?=
 =?utf-8?B?OUJ2MFB5Y044a1hBb2ppajIxc25rTXBQSTJvcWZpZmtwNkh4UU4zZk5WTG8x?=
 =?utf-8?B?LzdCRFdpK3dBVUsxTzFlUVdzQ1haL2JNOWdiT05tWlM3MkxuQ2ZQZXUyRllM?=
 =?utf-8?B?dE5pdDc5MDZPbkFXOVp1YkFBc0sydXFxVEZxSVFESFg3ajRWTUpVaytNdGpO?=
 =?utf-8?B?Y0ZMQm9PVmN0RWlEenNCTGxMYkJYak1jTHoxbHNXbUNPaTBFOFR2K2cyYXN1?=
 =?utf-8?B?d3p6cm9EanZiTmoxSjhkelB4U1J3Uk5pYVdmaEZ2U0JqRXdscFNZOVU2bDg5?=
 =?utf-8?B?WnZnVXZSTFoxYkRJcXU0ZjQ2bzBDSVpOL0t6TWtzYlFYQ2ZOeWJScUlYMk5j?=
 =?utf-8?B?SmlVWVAxeEkwdGhIcXUzK0dhWG1IVEUxQStFZzViYVd4dDV4VzdzL0tDbmZy?=
 =?utf-8?B?U2I2MW81ZEtsMkRkNno4OElvaXNOWVl2Ri9OTjFaRm1vMG1HOXp1VVB4MFA3?=
 =?utf-8?B?YWVEc3pGYkw3ZVVyQzUxZTFqNyt3b21WTFp3WWNlemF1N2NtSHd6L3JPRExY?=
 =?utf-8?B?THpZeWVCNDl1VURRMUFFZXh6V1FGb20vVEcxUnRVZGJGUUhyNXJPY3Flakpm?=
 =?utf-8?B?M29SSTJjMElHQ2xLbzgyWXBpZG9VWnB1d3FTcXNpTTEycUZ1R2RMWWN3ZVRM?=
 =?utf-8?B?ZFdzTWNyMWxTa3hSNGdPWW42TkVBQW94dmxPNjlSRCt0NDRIUFkrUkdxVm1O?=
 =?utf-8?B?ZGtEZTBWWTZuLzB6dkRLend5MGZqRDV0cE1YWWpJVHlsZjZoMlpkajZKYjV3?=
 =?utf-8?B?eVRFRlhaWHROclA3Z3NpTkpqblgybDhaeUF1NGhqVTQvVThkZDJ1K045cEMr?=
 =?utf-8?B?WDFvM1pjZHlWbHNnQ1VQOUVYZDgrcjZPTVpWMlNITHJSSUg5MU5UMjF6ZG8x?=
 =?utf-8?B?TEg4bThTc3BMKzY0cXBKRS9ReFpoYXJDRVB3RXFrUGF3ZVdMc0pIWHAvUlVq?=
 =?utf-8?B?eTk4bWQ2Sk5QblplNEVISXcrdnFQVk5nMVozRmpmTGRWVVFaa0JUS0Q0bTBj?=
 =?utf-8?B?Tk9yRDZKMHE0VHYwZ2VKL2ZESVU3WFNmOStpYWVGdlQyMVZrSkU1c2FydmlC?=
 =?utf-8?B?RkdmR3RVOWtVOGRHbnl2RkpXalVKNitLN25ENGtWT3dKN3lZM29nWHM5bk5o?=
 =?utf-8?B?R2JWS0xNallOWmlSa3lwQXRONlBwa01yRFhTbG56YjJOYmVYdjNFWjI3ZDhY?=
 =?utf-8?B?ZzRKTyt2Z1ZhejIxZnZHSDMrcmZLdWsydGlNZjhPSFJyK09iRW40bXV1WDZW?=
 =?utf-8?B?ZTM4bFo2K1pxc2RNWFdoQVBQaXhiUHgxTGtYaExWSUEwTEl4aXJ4K2d2SHlE?=
 =?utf-8?B?SUZNSWZBRzVwSXBkT3R4U0F5dDIvNW9INVBmVFRjaFEwekRKZWZuNnVCT3Qy?=
 =?utf-8?B?bTdCdzdFZWlQWkV0Yno0eXZIOHJYSnpRbFNoOVpnWURUK1p3RnF6Z0JkR25v?=
 =?utf-8?B?MXJuT1RmbkRjZmF3eWZidFdBWGR3QzJsbXlIYmZ3SytocGtwUHNSczg0OFFG?=
 =?utf-8?Q?g6cE8J87HrlkUVEL7CImdkE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707d8021-b45e-455b-f3df-08dba8abcff9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB8062.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 16:20:08.7013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XE0NbVpy1RSFe6s45DYaZmTtnGb5yi7t4A7UxoQEVj+hIcAacyZQbITc7aHyBxaUi9P1fojIARZ6aw2kwXh0OS3Y6YEN8B9wIm0VZHogbjgKX1SiD0KOXk0eeBaFOYxk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6722
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi James,

On 8/29/2023 5:55 AM, James Clark wrote:
> 
> 
> On 29/08/2023 05:44, Steve Clevenger wrote:
>>
>> Ampere has been using the following command sequence to generate a 'perf
>> record' kernel instruction trace on an AmpereOne AARCH64 based systems
>> using a 6.3.0 Fedora distribution with CoreSight related patches.
>>
>>
>> [root@sut01sys-b212 kernel]# uname -a
>> Linux sut01sys-b212.scc-lab.amperecomputing.com 6.3.0-coresight-enabled+
>> #9 SMP PREEMPT_DYNAMIC Fri Jun 30 12:54:14 PDT 2023 aarch64 aarch64
>> aarch64 GNU/Linux
>> [root@sut01sys-b212 kernel]#
>> [root@sut01sys-b212 kernel]# timeout 45s perf record --kcore -o kcore -e
>> cs_etm/@tmc_etr63/k --per-thread taskset --cpu-list 15 dd if=/dev/zero
>> of=/dev/null
>> [ perf record: Woken up 41 times to write data ]
>> [ perf record: Captured and wrote 144.056 MB kcore ]
>> [root@sut01sys-b212 kernel]#
>> [root@sut01sys-b212 kernel]# ls -l ~/linux/vmlinux
>> -rwxr-xr-x. 1 root root 390426912 Jun 30 12:54 /home/stevec/linux/vmlinux*
>> [root@sut01sys-b212 kernel]#
>> [root@sut01sys-b212 kernel]# timeout 45s perf script --input
>> ./kcore/data -s ../../scripts/arm-cs-trace-disasm.py -F
>> cpu,event,ip,addr,sym – -d objdump -k ~/linux/vmlinux > ./perf.itrace
>> [root@sut01sys-b212 kernel]#
>> [root@sut01sys-b212 kernel]# ls -l perf.itrace
>> -rw-r--r--. 1 root root  485834744 Jul 17 14:18 perf.itrace
>>
>>
>> The executive summary is the code sections in vmlinux do not match the
>> actual code executing on the target due to self-modifying code
>> (alternate code sequences) in the kernel image. These sequences are
>> typically applied over nop place-holder instructions. This was verified
>> by comparing a location in the ./drivers/char/mem.c read_zero objdump
>> instruction stream to the memory resident instructions captured with the
>> TRACE32 ETM instruction trace feature. This particular instruction trace
>> example shows a disconnect. It displays a ‘b    ffff800008ab8a70
>> <read_zero+0x168>’ instruction at address 0xffff800008ab89e8 which did
>> not branch. The actual instruction present at 0xffff800008ab89e8 is a ‘nop’.
>>         .
>>         .
>>         ffff800008ab89a8:       1400000d        b       ffff800008ab89dc
>> <read_zero+0xd4>
>>               dd  8774/8774  [0015]         0.000000000  read_zero+0xa0
>>         ffff800008ab89dc <read_zero+0xd4>:
>>         ffff800008ab89dc:       9248f840        and     x0, x2,
>> #0xff7fffffffffffff
>>         ffff800008ab89e0:       aa1403e1        mov     x1, x20
>>         ffff800008ab89e4:       9418b6fb        bl      ffff8000090e65d0
>> <__arch_clear_user>
>>               dd  8774/8774  [0015]         0.000000000  read_zero+0xdc
>> ffff8000090e65d0 <__arch_clear_user>:
>>         ffff8000090e65d0:       d503245f        bti     c
>>         ffff8000090e65d4:       8b010002        add     x2, x0, x1
>>         ffff8000090e65d8:       f1002021        subs    x1, x1, #0x8
>>         ffff8000090e65dc:       54000104        b.mi    ffff8000090e65fc
>> <__arch_clear_user+0x2c>  // b.first
>>         ffff8000090e65e0:       f800081f        sttr    xzr, [x0]
>>         ffff8000090e65e4:       91002000        add     x0, x0, #0x8
>>         ffff8000090e65e8:       f1002021        subs    x1, x1, #0x8
>>         ffff8000090e65ec:       54ffffa8        b.hi    ffff8000090e65e0
>> <__arch_clear_user+0x10>  // b.pmore
>>               dd  8774/8774  [0015]         0.000000000
>> __arch_clear_user+0x1c
>> ...vec/linux/arch/arm64/lib/clear_user.S   31         b.hi    1b
>>         ffff8000090e65e0 <__arch_clear_user+0x10>:
>>         ffff8000090e65e0:       f800081f        sttr    xzr, [x0]
>>         ffff8000090e65e4:       91002000        add     x0, x0, #0x8
>>         ffff8000090e65e8:       f1002021        subs    x1, x1, #0x8
>>         ffff8000090e65ec:       54ffffa8        b.hi    ffff8000090e65e0
>> <__arch_clear_user+0x10>  // b.pmore
>>         .
>>         .
>>         ffff8000090e65f0:       f81f885f        sttr    xzr, [x2, #-8]
>>         ffff8000090e65f4:       d2800000        mov     x0, #0x0
>>                // #0
>>         ffff8000090e65f8:       d65f03c0        ret
>>               dd  8774/8774  [0015]         0.000000000
>> __arch_clear_user+0x28
>> ...vec/linux/arch/arm64/lib/clear_user.S   34         ret
>>         ffff800008ab89e8 <read_zero+0xe0>:
>>         ffff800008ab89e8:       14000022        b       ffff800008ab8a70
>> <read_zero+0x168>
>>         ffff800008ab89ec:       d503201f        nop
>>              dd  8774/8774  [0015]         0.000000000  read_zero+0xe4
>>                         /home/stevec/linux/drivers/char/mem.c     521
>>              left = clear_user(buf + cleared, chunk);
>>         ffff800008ab8a18 <read_zero+0x110>:
>>         ffff800008ab8a18:       8b14035a        add     x26, x26, x20
>>         ffff800008ab8a1c:       b5000360        cbnz    x0,
>> ffff800008ab8a88 <read_zero+0x180>
>>         ffff800008ab8a20:       f9400320        ldr     x0, [x25]
>>         ffff800008ab8a24:       cb140273        sub     x19, x19, x20
>>         .
>>         .
>>
>> Ostensibly, the ‘perf record –kcore’ option produces a representative
>> image of the kernel. But this option does not produce suitable output to
>> generate ARM64 kernel instruction trace. perf doesn’t disassemble ARM64,
>> so the arm-cs-trace-disasm.py python script is used with the native
>> objdump utility to provide ARM64 disassembly from CoreSight trace
>> capture. objdump itself requires an ELF/DWARF file image + symbols to
>> generate the symbolic (+ line information for mixed source) disassembly.
>> The linux vmlinux image + symbols file is typically used for this
>> purpose. The kallsyms file is not formatted for objdump use. As an
>> experiment, I patched the executable code sections in a local copy of
>> vmlinux with the corresponding executable code segments extracted from
>> the kcore image using an Ampere internal ELF patch utility.
>>
>> This patch utility leverages the (MIT Licensed) ELFIO open source
>> library API. These were the commands.
>>
>>
>> [root@sut01sys-b212 kernel]# timeout 30s perf record --kcore -o kcore -e
>> cs_etm/@tmc_etr63/k --per-thread taskset --cpu-list 15 dd if=/dev/zero
>> of=/dev/null
>> [ perf record: Woken up 25 times to write data ]
>> [ perf record: Captured and wrote 88.053 MB kcore ]
>> [root@sut01sys-b212 kernel]#
>> [root@sut01sys-b212 kernel]# ls -l ~/linux/vmlinux
>> -rwxr-xr-x. 1 root root 390426912 Jun 30 12:54 /home/stevec/linux/vmlinux*
>> [root@sut01sys-b212 kernel]# cp ~/linux/vmlinux .
>> [root@sut01sys-b212 kernel]# patch-elf --help
>>
>> patch-elf overlays the kernel image from a local copy of
>> '/proc/kcore' to the  corresponding (by address) ELF sections
>> in a local copy of the vmlinux ELF file.
>> A local '/proc/kcore' is created by:
>>     'perf report --kcore -e cs_etm/@tmc_etr1/k ...'
>> The local (patched) vmlinux copy is used by:
>>     'perf script -s arm-cs-trace-disasm.py ...'
>> See the CoreSight Hardware-Assisted Trace Application Note for
>> use of the 'perf report' and 'perf script' commands.
>>
>> Usage: patch-elf <--verbose> kcore_file vmlinux_file
>> [root@sut01sys-b212 kernel]#
>> [root@sut01sys-b212 kernel]# patch-elf kcore/kcore_dir/kcore ./vmlinux
>> ELF File kcore Properties
>> ELF file class:     ELF64
>> ELF file encoding:  Little endian
>> Machine:            ARM AArch64
>> Type:               Core file
>> Number of segments: 3
>> Number of sections: 0
>>
>> ELF File vmlinux Properties
>> ELF file class:     ELF64
>> ELF file encoding:  Little endian
>> Machine:            ARM AArch64
>> Type:               Shared object file
>> Number of segments: 3
>> Number of sections: 43
>>
>> Patching section[ 2] ffff800008010000  17997936 bytes
>>
>> Patching section[15] ffff800009a31000  20480 bytes
>>
>> Patching section[16] ffff800009a40000  612372 bytes
>>
>> Patching section[17] ffff800009ad5818  24752 bytes
>>
>> [root@sut01sys-b212 kernel]# ls -l ./vmlinux
>> -rwxr-xr-x. 1 root root 390426908 Jul 19 11:14 ./vmlinux*
>> [root@sut01sys-b212 kernel]#
>> [root@sut01sys-b212 kernel]# timeout 45s perf script --input
>> ./kcore/data -s ../../scripts/arm-cs-trace-disasm.py -F
>> cpu,event,ip,addr,sym – -d objdump -k ./vmlinux > ./perf.itrace
>> [root@sut01sys-b212 kernel]#
>> [root@sut01sys-b212 kernel]# ls -l perf.itrace
>> -rw-r--r--. 1 root root  32142060 Jul 19 11:18 perf.itrace
>>
>> Here is the representative kernel instruction trace using a patched vmlinux.
>>
>>         .
>>         .
>>         ffff800008ab89a8:       1400000d        b       ffff800008ab89dc
>> <read_zero+0xd4>
>>               dd  8774/8774  [0015]         0.000000000  read_zero+0xa0
>>         ffff800008ab89dc <read_zero+0xd4>:
>>         ffff800008ab89dc:       9248f840        and     x0, x2,
>> #0xff7fffffffffffff
>>         ffff800008ab89e0:       aa1403e1        mov     x1, x20
>>         ffff800008ab89e4:       9418b6fb        bl      ffff8000090e65d0
>> <__arch_clear_user>
>>               dd  8774/8774  [0015]         0.000000000  read_zero+0xdc
>> ffff8000090e65d0 <__arch_clear_user>:
>>         ffff8000090e65d0:       d503245f        bti     c
>>         ffff8000090e65d4:       8b010002        add     x2, x0, x1
>>         ffff8000090e65d8:       f1002021        subs    x1, x1, #0x8
>>         ffff8000090e65dc:       54000104        b.mi    ffff8000090e65fc
>> <__arch_clear_user+0x2c>  // b.first
>>         ffff8000090e65e0:       f800081f        sttr    xzr, [x0]
>>         ffff8000090e65e4:       91002000        add     x0, x0, #0x8
>>         ffff8000090e65e8:       f1002021        subs    x1, x1, #0x8
>>         ffff8000090e65ec:       54ffffa8        b.hi    ffff8000090e65e0
>> <__arch_clear_user+0x10>  // b.pmore
>>               dd  8774/8774  [0015]         0.000000000
>> __arch_clear_user+0x1c
>>         ffff8000090e65e0 <__arch_clear_user+0x10>:
>>         ffff8000090e65e0:       f800081f        sttr    xzr, [x0]
>>         ffff8000090e65e4:       91002000        add     x0, x0, #0x8
>>         ffff8000090e65e8:       f1002021        subs    x1, x1, #0x8
>>         ffff8000090e65ec:       54ffffa8        b.hi    ffff8000090e65e0
>> <__arch_clear_user+0x10>  // b.pmore
>>         .
>>         .
>>         ffff8000090e65f0:       f81f885f        sttr    xzr, [x2, #-8]
>>         ffff8000090e65f4:       d2800000        mov     x0, #0x0
>>                // #0
>>         ffff8000090e65f8:       d65f03c0        ret
>>               dd  8774/8774  [0015]         0.000000000
>> __arch_clear_user+0x28
>> ...vec/linux/arch/arm64/lib/clear_user.S   34         ret
>>         ffff800008ab89e8 <read_zero+0xe0>:
>>         ffff800008ab89e8:       d503201f        nop
>>         ffff800008ab89ec:       1400000b        b       ffff800008ab8a18
>> <read_zero+0x110>
>>               dd  8774/8774  [0015]         0.000000000  read_zero+0xe4
>>                          /home/stevec/linux/drivers/char/mem.c     521
>>               left = clear_user(buf + cleared, chunk);
>>         ffff800008ab8a18 <read_zero+0x110>:
>>         ffff800008ab8a18:       8b14035a        add     x26, x26, x20
>>         ffff800008ab8a1c:       b5000360        cbnz    x0,
>> ffff800008ab8a88 <read_zero+0x180>
>>         ffff800008ab8a20:       f9400320        ldr     x0, [x25]
>>         ffff800008ab8a24:       cb140273        sub     x19, x19, x20
>>         .
>>         .
>>         .
>>
>> This begs the question what perf enhancements could be added to make
>> ARM64 kernel instruction trace easier to use? The process I’ve followed
>> is cumbersome, but could be done behind the scenes by perf. The caveat
>> is it requires a vmlinux which might not be available to an end user.
>> Here are 2 options.
>>
>> 1.	'perf report -kcore'could use the process I’ve used here
>> transparently in the background. The plus side is the objdump feature of
>> mixed disassembly is available based on the current vmlinux.
>>
> 
> Hi Steve,
> 
> What you're saying makes sense to me. I think #1 sounds best, I'm not
> sure of the use-case where you wanted to make actionable decisions from
> the trace but wouldn't have vmlinux available? Maybe an end-user could
> be missing it, but I can only imagine use cases where you are actively
> building and developing the kernel.

I agree the primary use case is for a kernel developer who will have a
vmlinux. There's a non-zero chance of complaints from a fringe element,
hence the second option. In my opinion the vmlinux solution makes better
sense and offers the best function.

> 
>> 2.	'perf report -kcore' generates an ELF + symbols file based on
>> kallsyms (and/or System.map). No vmlinux patching, so intermixed source
>> and disassembly wouldn’t be available. It’s a reasonable alternative
>> without relying on vmlinux.
>>
>> It makes sense performance-wise to use an ARM64 disassembler directly
>> through perf. perf-script use of the arm-cs-trace-disasm.py python
>> script can be slow. I’m unfamiliar with the Intel implementation, but
>> perf-annotate uses objdump. Unfortunately, I can't seem to get annotate
>> to work for me. A patch operation is still required if vmlinux is used.
>>
> 
> We have had other reports about arm-cs-trace-disasm.py being slow. I had
> a plan to make it work with disassembly directly from Perf as that is
> available in other modes. For example the annotate mode in perf already
> works on Arm. What error are you getting with it exactly? It might
> require installation of the aarch64 objdump tool if you are running on
> x86, or provide the --objdump option?

My self-hosted trace tests are done natively on Ampere systems. I don't
know if it's the case here, but python performance is compromised for
cases where the runtime is repeatedly loaded during use.

Nothing seems out-of-order with the 'perf annotate' command line, but I
admit I've not used it much. The complaint is a missing DSO (text below).

$ perf annotate --input=kcore/data -k ./vmlinux --itrace=iybxwpe

CS ETM Trace: Missing DSO. Use 'perf archive' or debuginfod to export
data from the traced system. Enable CONFIG_PROC_KCORE or use option -k
/path/to/vmlinux for kernel symbols.

> 
>> I suspect the CoreSight/perf communities are aware of these issues.
>> Is there any ongoing work not known to the outside world?
>>
>> Thanks and regards,
>> Steve C.
