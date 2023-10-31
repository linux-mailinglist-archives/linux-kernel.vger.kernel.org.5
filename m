Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D45F7DC731
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343639AbjJaHYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343598AbjJaHYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:24:35 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD5B8F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 00:24:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZCwanBakF01aWLsS+26TM1NERYLEa4tSmbd+pt4XVugMNIZLJWAoEn3U20BDBe1vnlcSs0OyU4rhk4TXRXu2d5OPPPh5SXISfi14b9hHu9KJhNNXLWm0YgCFr+AN/uXiY3xgCELprunJCwCpcJ9C01adKyhSp1E3AjrRrZLULN6yrnZvrwZRHCToncOr4Z5uj7BodRNuKfolAT+5q9KDWv6AISmbHeIQF/Dqb7oMWZClrjBr9Tqb+6csohAEB5PtTitg17wJ6slUkwGrCkpipnoTJjQrQalrA5VJKKlAW/FMSXwd+Wd4YqgIefFQ7GWAErSASd837hk5N2cs/QjoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMoImlxa2rP4ZylcxJpCNZ1nkjVs1E7E+iqCazGYKhk=;
 b=K4hBrOHG83bJyhYuZjKjbhBjCMgJzHO/CrX7EGNfCLvSfJ1AoblNQOlZRcFvAhH1Jkn6XJqIUYzjU0Eg6dVLOh7M4AT0rVo4jzVPPoU/por6xL9OeaRZ6jorX9XKJekIYBCofjMvO2gH4CCS/cjy0NdAl7avUTpTGhyTOXTGzy4PD9tUIVpEGYhMPP2uDFMZl0SAH/qPUj0k5MnuZUzQHkPuQci5VfsA0KVO9nuPfXRlN6ByWlp9rbHQQ0MG2cujoqRf0bmGUFPhxS5soXFiBSNqOi8N64F48YveggHn3DmzMqn3rdpWRU5t/X/ELeIhJiOnxuz8iXzieeMQuhe2wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMoImlxa2rP4ZylcxJpCNZ1nkjVs1E7E+iqCazGYKhk=;
 b=MGSRaE9Z+tAiV4olgV4iUOfy/KraYQX872mE+2/1JKRY5+vvc1cvc4AabGeHi+Dca+aL1J7r/R1xWkZ2WK8hVuTt5mwuqMqVPBEstLUyXZy/UrJPYI9ZmZMcEsn7vRT1aqHnrOem+rdKh3tIZFA7DrTcRqBMAfm9xUjb6JrZ3OM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) by
 MW4PR12MB7192.namprd12.prod.outlook.com (2603:10b6:303:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Tue, 31 Oct
 2023 07:24:28 +0000
Received: from DS7PR12MB8249.namprd12.prod.outlook.com
 ([fe80::352f:a52:4008:441e]) by DS7PR12MB8249.namprd12.prod.outlook.com
 ([fe80::352f:a52:4008:441e%5]) with mapi id 15.20.6933.025; Tue, 31 Oct 2023
 07:24:27 +0000
Message-ID: <dbdafdf5-10cd-fd66-1691-e4ec600bead5@amd.com>
Date:   Tue, 31 Oct 2023 12:54:18 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: arch/microblaze/kernel/entry.S:945: Error: unknown opcode
 "suspend"
To:     Michal Simek <monstr@monstr.eu>, kernel test robot <lkp@intel.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
References: <202310310151.UhB396Qs-lkp@intel.com>
 <144951b1-b158-4591-ab88-a1c71af51bf2@monstr.eu>
Content-Language: en-US
From:   "Rao, Appana Durga Kedareswara" <appanad@amd.com>
In-Reply-To: <144951b1-b158-4591-ab88-a1c71af51bf2@monstr.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::34) To DS7PR12MB8249.namprd12.prod.outlook.com
 (2603:10b6:8:ea::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8249:EE_|MW4PR12MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b64e169-30dc-4b85-75e3-08dbd9e26a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R4cYwQTC4M+DF5DSF0tNSru5hUAv6hxjeSaELZF4Tx/m38WARC616sumRM6PCQrGRn+V1lzOHjZjN3w6E1qv7sx5Yd82Rnhj7rVeaLML3+NWXvT0qf+70c19bCqZGSS4IsQcs5dz5OVdhUjJYP1XwTnOrA6YdiHVN0ZwggJZwyZyzCjg37dVxYWmsrdW3GNHArHdhMv03nDv5W2gNWG5wbii7GZam/n4KsvdvWC8xrB2vjZkifwNNed9XenHmDGim827w24BV9qiWbk+KUgUn40NxsKZfr4X4NZBu0goRIjfQi/C53QCtEVPyKPM09stZhbLHIpCXz7GKxB7e+iIJor8wTaSzCeIS4UDJykHZ2M0Knb8UEfKW6yzV/6TUQIcsNaE6Tpo7HVMYTdlhWI+Cmf5FkVPL9AYTCQwh3+KqfnAU5Yq+Slk9XKZPDjEal/rDZcROF76OaM586ipWVUhlorCyQbAp6mw//YBafbGR+Jh5QjOgGms1R9wCM1RVf8xSR74LNI7hnfELwroZRugRPu8I26ueiOvKuRvpZXl3INbYpdxJnFx9kmP3xm9Xq+tTXsUzEs167mYWAHwoVYqWwp96zv3/gNGdtfhOD3txj49QdF/+vjn343LTsx2lDN950Ar9MV3dr0F2FKy3iIkW+bwLEHtoHQwHWfqgnzOxyNAmthwzLk+bO72fKp5Pv1lt7qCnc6ABksfvdE/1/liWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8249.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(366004)(396003)(376002)(230273577357003)(230922051799003)(230173577357003)(186009)(1800799009)(451199024)(64100799003)(8676002)(478600001)(6486002)(6506007)(5660300002)(6666004)(83380400001)(966005)(2616005)(26005)(41300700001)(15650500001)(2906002)(316002)(6512007)(15974865002)(66476007)(66556008)(110136005)(66946007)(8936002)(4326008)(36756003)(31696002)(38100700002)(31686004)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2tMMTloQ2MxaXM5RXpwM1FWOFNiOHZ1cUtYZWY4M1I5VmgxWXpXZmFRKzlL?=
 =?utf-8?B?RXBGYUpET3RHb1BtV1ZTTWcxQ0o5cDVFT2NGc0c3R1lnV2llb0VCcjhOcGQ2?=
 =?utf-8?B?UW03ODQ1c3BzdFN5V0ZUTjFKRUpHaGFxeWd2aUtzZ3loODlzZ29lR0JXTU94?=
 =?utf-8?B?ZzcvVjMrcWU1RXRkM1VHcjdzczRpT1dodG1KZ1ZRRkIvTjB0anNQVXpyNkZP?=
 =?utf-8?B?RGFIWDJST1ZhYTZhak5xdGpHbUpYT2lvNlVUN0FHRHdhdHQwc0oxV1Z5QlhD?=
 =?utf-8?B?b3l1T0l5ei9LNllyMTVnSTlMQmZlc1BiTU9SSDlsWDdwaU82M1B6akZ4am1m?=
 =?utf-8?B?QTVhaXREYkRDaFpJL21XOWY4a1lmRG15S0M0WEV5SnBQdXdLSWlEU0ZUdkRB?=
 =?utf-8?B?czUrNTJMcjlibkZaZHBFdlVIOVBFWDRsdHBHM1FMNHIxakRBTFRmRlVhS1Vn?=
 =?utf-8?B?TWFEWTZyMDN3amIxSEFWU1B4ZjZ2b0d5SjhmbmV0UDdTN2ErKzUydUZ5WVpS?=
 =?utf-8?B?SkpFdW9YeG9hSXlmaU9VUFovc1pVdkorUnJGTDhnY1VNY2FRVG1raUNDUHlI?=
 =?utf-8?B?a1FCb2sxOGFhaHdWNy9iemhmRDJGM3Z4VCsxYkJ4alpuZHVXM25OMGNGSmRY?=
 =?utf-8?B?Q0Vmbkh3dGwzenlCVVB5YmFFT3ZHeWV5VFFXWEw2U2xrNXFFeVowTWJHamNP?=
 =?utf-8?B?czBXWWRQZ2lmSDIvTEcwYXRRQSs2OTlhR3c1bzZlRUxVUHB1YW54cDJDYS9x?=
 =?utf-8?B?NGphd0VtZmNGK3ZvL3lZbm9VMnl1SU1rSnZ2KzZjZGxFbmd2aDZtUmhqTWNZ?=
 =?utf-8?B?Szd1cmQ1akpRd1hpOXMrREFQUDhLNklEU0d3L0dKbGc2SnlLL2V0L3Awb1Jy?=
 =?utf-8?B?ZTNCa3E5aE05MUUrSkR2MXdwZm1nanBIOXlwQk9EM3E3RUxJdnYwT0JJUnlM?=
 =?utf-8?B?dlZOWGhNWm9zSkZTMkF2Tm5pUVZaZU9paTZUWVNxQ3V0THJDa3RIYUxwWUdi?=
 =?utf-8?B?UkJIaU1Da1JVbi9JZjVOOUxjNjBvN0VRY2pIQ2NHRVlJWllCKzJ2b0NlcnZa?=
 =?utf-8?B?bmp4TDZ0QlpPNkpIVmluY1NhRVF4YVRZUjNIaEU2aVVaZng3aEk2WGNUTWpo?=
 =?utf-8?B?SlNNb1JONFBJdXZ5YmtmYm54eXJyT0xwamplTC9OUnlYMzlIWDBWTUZMTk8v?=
 =?utf-8?B?amhZNHU0RzRmNmdicGlNdDM2NkIvZHE4L05uQVA5YURSWFo2RWxuaUZiU0dt?=
 =?utf-8?B?dVovMHdXd1ZuL0dXN3l3RXEzRC8wSlNvY1V3WElNZmhpb2hreTQwYldjeWcv?=
 =?utf-8?B?ZDdScnE5UHRDVXNLNGxjVVJxbWNiMUxRdk9Lb1ZXSHNLcHI5WEcvbC9OaUVS?=
 =?utf-8?B?VW9saFUrLytKczM5U1Y2dnlUd2xBZGQrQVZmSzFsRGM3aFBIV1Q2K0xaS1g0?=
 =?utf-8?B?bzBKdXV1eGdXU05iUlBEZ2lCb09tcVVpSGF4UVh1WU53Z0l6VXBQbkNwTUo4?=
 =?utf-8?B?V0RibTF5SVVYK3dHTlBJbWhwTC80ZlRsNDh3b3J2RE1LZmJJOEpVa3VPWWUz?=
 =?utf-8?B?SzN6eGljOWNNcWFGOG9qdjl4c0NBRDdjVHR1VE51YzA1cXFJS3ZVTHZPVFZl?=
 =?utf-8?B?b2JzRFRvOW1SRHBQUVRXeEhneEUzV0VWZFRnYTFqV1d1c0FiQ1RXdTZSa21R?=
 =?utf-8?B?WjZXczl5dk13SW5sSlZWclV5WnZHR1p6bDJkV2pBUWpoSG9YbkVIN3BoYUpV?=
 =?utf-8?B?dndSU2w1Rkl3MEZsRzQyVmQyU2Q5KzBmSkNybkRTcXJJUUtZVmNVZUYzS1ZW?=
 =?utf-8?B?MkFOTWUxZEhvMDhrb3d2QTZRWEFLdmFtZXBudTNzNk45Z01kNUNOU1hFMlB3?=
 =?utf-8?B?RkxWQmV6cUZKMTdTOU9wSGUxbkZDNXZXbHRhYy9TNnFWOHVjRnNMbmcxVk1K?=
 =?utf-8?B?OHAxZFRvL25vQnQydmp2bFJ5bGNmN2tYZVdxNExtOUk0N1g0cmpQNXNwa3hl?=
 =?utf-8?B?bzkyaERXb2RnZ1BheWpuN213dFM5Y1RIVzhPQys5QVI5b2VXazA3bW9yeWtF?=
 =?utf-8?B?eGxLL2NvWnR5RjRWWUFwNC9OSUtXWjlVRG8zVHoxb3lrejBLazFnc200RHc2?=
 =?utf-8?Q?4XUxlKnkwxh+ooKKUlxrC+4ki?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b64e169-30dc-4b85-75e3-08dbd9e26a2e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8249.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 07:24:27.4206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SkhBeJ1QqCDbP5R26qgjFnKglSss/gOPYaf5rSOFNM6fG1VLNPGodSVW5tDCy05p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7192
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On 31/10/23 12:28 pm, Michal Simek wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or 
> responding to this email.
> 
> 
> Hi Kedar,
> 
> On 10/30/23 18:12, kernel test robot wrote:
>> Hi Appana,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   ffc253263a1375a65fa6c9f62a893e9767fbebfa
>> commit: 88707ebe77e23e856981e597f322cabbf6415662 microblaze: Add custom break vector handler for mb manager
>> date:   1 year, 1 month ago
>> config: microblaze-buildonly-randconfig-r003-20230509 (https://download.01.org/0day-ci/archive/20231031/202310310151.UhB396Qs-lkp@intel.com/config)
>> compiler: microblaze-linux-gcc (GCC) 13.2.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231031/202310310151.UhB396Qs-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202310310151.UhB396Qs-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>     arch/microblaze/kernel/entry.S: Assembler messages:
>>>> arch/microblaze/kernel/entry.S:945: Error: unknown opcode "suspend"
>>
>>
>> vim +/suspend +945 arch/microblaze/kernel/entry.S
>>
>>     825
>>     826               /* restore all the tlb's */
>>     827               addik   r3, r0, TOPHYS(tlb_skip)
>>     828               addik   r6, r0, PT_TLBL0
>>     829               addik   r7, r0, PT_TLBH0
>>     830       restore_tlb:
>>     831               add     r6, r6, r1
>>     832               add     r7, r7, r1
>>     833               lwi     r2, r6, 0
>>     834               mts     rtlblo, r2
>>     835               lwi     r2, r7, 0
>>     836               mts     rtlbhi, r2
>>     837               addik   r6, r6, 4
>>     838               addik   r7, r7, 4
>>     839               bgtid   r3, restore_tlb
>>     840               addik   r3, r3, -1
>>     841
>>     842               lwi     r5, r0, TOPHYS(xmb_manager_dev)
>>     843               lwi     r8, r0, TOPHYS(xmb_manager_reset_callback)
>>     844               set_vms
>>     845               /* return from reset need -8 to adjust for rtsd r15, 8 */
>>     846               addik   r15, r0, ret_from_reset - 8
>>     847               rtbd    r8, 0
>>     848               nop
>>     849
>>     850       ret_from_reset:
>>     851               set_bip /* Ints masked for state restore */
>>     852               VM_OFF
>>     853               /* MS: Restore all regs */
>>     854               RESTORE_REGS
>>     855               lwi     r14, r1, PT_R14
>>     856               lwi     r16, r1, PT_PC
>>     857               addik   r1, r1, PT_SIZE + 36
>>     858               rtbd    r16, 0
>>     859               nop
>>     860
>>     861       /*
>>     862        * Break handler for MB Manager. Enter to _xmb_manager_break by
>>     863        * injecting fault in one of the TMR Microblaze core.
>>     864        * FIXME: This break handler supports getting
>>     865        * called from kernel space only.
>>     866        */
>>     867       C_ENTRY(_xmb_manager_break):
>>     868               /*
>>     869                * Reserve memory in the stack for context store/restore
>>     870                * (which includes memory for storing tlbs (max two tlbs))
>>     871                */
>>     872               addik   r1, r1, -PT_SIZE - 36
>>     873               swi     r1, r0, xmb_manager_stackpointer
>>     874               SAVE_REGS
>>     875               swi     r14, r1, PT_R14 /* rewrite saved R14 value */
>>     876               swi     r16, r1, PT_PC; /* PC and r16 are the same */
>>     877
>>     878               lwi     r6, r0, TOPHYS(xmb_manager_baseaddr)
>>     879               lwi     r7, r0, TOPHYS(xmb_manager_crval)
>>     880               /*
>>     881                * When the break vector gets asserted because of error injection,
>>     882                * the break signal must be blocked before exiting from the
>>     883                * break handler, below code configures the tmr manager
>>     884                * control register to block break signal.
>>     885                */
>>     886               swi     r7, r6, 0
>>     887
>>     888               /* Save the special purpose registers  */
>>     889               mfs     r2, rpid
>>     890               swi     r2, r1, PT_PID
>>     891
>>     892               mfs     r2, rtlbx
>>     893               swi     r2, r1, PT_TLBI
>>     894
>>     895               mfs     r2, rzpr
>>     896               swi     r2, r1, PT_ZPR
>>     897
>>     898       #if CONFIG_XILINX_MICROBLAZE0_USE_FPU
>>     899               mfs     r2, rfsr
>>     900               swi     r2, r1, PT_FSR
>>     901       #endif
>>     902               mfs     r2, rmsr
>>     903               swi     r2, r1, PT_MSR
>>     904
>>     905               /* Save all the tlb's */
>>     906               addik   r3, r0, TOPHYS(tlb_skip)
>>     907               addik   r6, r0, PT_TLBL0
>>     908               addik   r7, r0, PT_TLBH0
>>     909       save_tlb:
>>     910               add     r6, r6, r1
>>     911               add     r7, r7, r1
>>     912               mfs     r2, rtlblo
>>     913               swi     r2, r6, 0
>>     914               mfs     r2, rtlbhi
>>     915               swi     r2, r7, 0
>>     916               addik   r6, r6, 4
>>     917               addik   r7, r7, 4
>>     918               bgtid   r3, save_tlb
>>     919               addik   r3, r3, -1
>>     920
>>     921               lwi     r5, r0, TOPHYS(xmb_manager_dev)
>>     922               lwi     r8, r0, TOPHYS(xmb_manager_callback)
>>     923               /* return from break need -8 to adjust for rtsd r15, 8 */
>>     924               addik   r15, r0, ret_from_break - 8
>>     925               rtbd    r8, 0
>>     926               nop
>>     927
>>     928       ret_from_break:
>>     929               /* flush the d-cache */
>>     930               bralid  r15, mb_flush_dcache
>>     931               nop
>>     932
>>     933               /*
>>     934                * To make sure microblaze i-cache is in a proper state
>>     935                * invalidate the i-cache.
>>     936                */
>>     937               bralid  r15, mb_invalidate_icache
>>     938               nop
>>     939
>>     940               set_bip; /* Ints masked for state restore */
>>     941               VM_OFF;
>>     942               mbar    1
>>     943               mbar    2
>>     944               bri     4
>>   > 945               suspend
> 
> Older toolchain don't need to have this pseudo code.
> What about to change it like this?
> 
> mbar 24 /* suspend */

Okay will test and post a patch...

Regards,
Kedar.

> 
> Thanks,
> Michal
> 
> -- 
> Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
> w: www.monstr.eu p: +42-0-721842854
> Maintainer of Linux kernel - Xilinx Microblaze
> Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
> U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
> TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
