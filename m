Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9967D5675
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343815AbjJXPay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343906AbjJXPaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:30:25 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081551BEB;
        Tue, 24 Oct 2023 08:30:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7eo+Jh9vBISboiQ6P3JDy/ZINnZ5W7HIi79Ql3Qj+yEfpkDM3it5FCvrXdz00MHrjT3hpnWdVyr+CEbR0ZT33B25lGWLyphO7vs6L6hJnSGiTz4GXYVNajJaWS4Bp3FBzlaWJeMyiY9ebXqEqXOBZ7jot7CjYP8bYYOnjchVDDxfMFzOVEj8qLu+HFcvNGCJWJLnZ3n87+q0FU3HHlwrLMd3FvlE9R0UzS83d/22nKPP9WMSjYcSIaS3cK7DiSQk3/IIBPi8dviQaFn/leQXoh0vhaSSc9ktzvcGd6JVgIs/BBm0bu07/dtYSZ7m9eRC4ee1MfSMaxVBi9+OUz/tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgLuGlhFYWvYd4akK7GqFyJpiXLTx31wM4UMZy9E6gU=;
 b=iNKScGn1Vf6WMg/UWX8AjgxdDCJ+e9ePPt25AKn4LSTa2wi3pmam/oDEruXU/QAnOXkKbDNb5TjWuDBbc0MNIvU9iJVlYnQOAwyCNQvEgQJDIphVvy1Dx1K72qe+6Pv1XvMV6l3pFhnbL+AeHbNGHObQ2p5JAOzgkw4W4O/CeIo2cLiDOPY8EofRZrqd/vv7Ot9HygCupyK8KJVgVO4a5o41sswxAqw4PoZUh3EQ82MCDa6U+MrJUued5TklQFHYb08jkpekioyQE99Mtpp2DuTSFw72NgDAgvOvmui0JjZw7bXOzSLztsngG/CiM4kXRmC8MOawQxFUB59j/Fz49A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgLuGlhFYWvYd4akK7GqFyJpiXLTx31wM4UMZy9E6gU=;
 b=dZDbxZx3x8gpHUgYkmF5JChJmFDoScEsb02HivlI0+ihKl8Y4i4+vwsKDO4Jghf1Uwa4jhRSPau9/W7Yz8kMwwX/1vAjqlNCMSvBvlanHSn5YgPI70q4GNglYoHqU9ec8fq/lN+TcFXYY2/WepHUxfS5B41TUcGZVlkmGURqEr8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by PH7PR12MB9254.namprd12.prod.outlook.com (2603:10b6:510:308::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Tue, 24 Oct
 2023 15:30:04 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9799:80fa:a7de:cbb1]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9799:80fa:a7de:cbb1%4]) with mapi id 15.20.6933.019; Tue, 24 Oct 2023
 15:30:04 +0000
Message-ID: <935d6e08-3754-4c06-ab25-69bda3fd8ea1@amd.com>
Date:   Tue, 24 Oct 2023 11:30:01 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
        john.allen@amd.com, william.roche@oracle.com
Subject: Re: [PATCH v2 1/2] RAS: Introduce AMD Address Translation Library
To:     kernel test robot <lkp@intel.com>, bp@alien8.de,
        linux-edac@vger.kernel.org, tony.luck@intel.com
References: <20231005173526.42831-2-yazen.ghannam@amd.com>
 <202310162015.fuitGuiJ-lkp@intel.com>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <202310162015.fuitGuiJ-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR15CA0064.namprd15.prod.outlook.com
 (2603:10b6:408:80::41) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|PH7PR12MB9254:EE_
X-MS-Office365-Filtering-Correlation-Id: 5085d3ff-78a1-419b-f107-08dbd4a617ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LUDxTyaLZDSdCSSl/ATsZjJd1Q0Q76RjEnvoIV03tnAEDv4mDLqChM7eFYos5EHNqLUxB72q7GU+XK4r2FRCSQWQ1Sho3BRjYc8hzFG3+RZ39OsSXyFH523SwCHKYEPVzcTUqK/DlkY4ybhwHlnm8sJaPYsSAX2uCOUxPCdvQmzObW2c1GqEQQfr15q3p2B8S+VeXUTANkBMK60u1xn0ogcEO+SP727BXD+IPui/rm9gT/50fFzUqm/sKikHRUcIa5sUN1jlWqr0q0mfs8aRFWPwDfwvwtxyHQ5Av3cN1VZBQri95j9gBUn28dvdfijIL+gZ3rFRIynVayp0Q+vKgTM3fUQtb61V+DMXmmvPACo9oXeO9vokmyhGjH0GsVX7CzUJmnCc937VLg4/0apehCWCmLVtzeiJuYYjXrhNFlNPfGjsYOBh5GhsUKu7iPXYotb2yyIQ2xUOOPiysXsBzqiCBZy1BEum9W8SKTD63SwU1pEGDdk8vTxf8v0SSSlYUMKxF5cbHI4x2ufWGw56C7jb2J1S0RQ9K9vH9KMXVsN53fEG9LotsPNTW9q22hgPvU17vh9g0GVCnbSFtIoG4ktmmQQU7at9KJ4bJ8AG7qfIxXMRYscj2iEkTeoeKeDbpPQbnxJYq22ahdPOeijoczm1ELRyQjAzBr0SNO/QdKQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2616005)(6666004)(8676002)(6506007)(53546011)(4326008)(6512007)(8936002)(6486002)(966005)(478600001)(31686004)(26005)(83380400001)(31696002)(66946007)(36756003)(86362001)(44832011)(66556008)(66476007)(316002)(2906002)(41300700001)(38100700002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2l6cmRIUWFhU0JDVnJKb2IvS2h3b0NYT1hwUnhFQlZuck9MRXpzREIzUGhv?=
 =?utf-8?B?TlczSWNEQUl3NWFaekpkMk5xS3lBQVBGSVNqQUxJMHZBdDdTSW5ieFQxdmNu?=
 =?utf-8?B?VWxUT3RIL2FKaDFWU0JXUjZacDFhNUNCMXphWUo2d2o0M3A2b1A3Sk85dmZE?=
 =?utf-8?B?bUxYWnhoSjBvU21MclkwOENSQ3NiV0ZZeFlTdk5wY0RIaWZ3cUd6enFSY09Q?=
 =?utf-8?B?ZThjRG9SQTNvS3ZSUmJudVp4aUNuTlNZNzU4MzQyNFhqanJlWXpqcjZaRmFE?=
 =?utf-8?B?Tk5tZ1pvbVB0ZUxTYXVranRQd29PcW5Jd2owK2RxK2dYRmw1cXJ2MDROZkIz?=
 =?utf-8?B?WG9rQi92cTV5YXR3SUk2L2FtYXhyc2c1MUdWVVl5ZzFJWElJcjFBRzZMMnZp?=
 =?utf-8?B?UUdLUlVCdmUvMFBoN2FIQ0hZVDhaOE5RR3lKVlRDRVRWeWJabjR3ZjdBKzZL?=
 =?utf-8?B?VVhtTTR2dG5JaHN1dVNPUThrRFlxWFNCSjFoWWtUcndXTnA3UVVrdnBOcXZl?=
 =?utf-8?B?N3Y2dURrYnhRczR6eDdpb3ZneVIzcXhTSjJrL0RuQkNmNVZ1bm5rMVBUYjdy?=
 =?utf-8?B?YVFaVDdjWjhJbVBpZEhaQmZPZjhuQmFaS3I0cHZ3OEtxQU94TjdEZnRFUXpL?=
 =?utf-8?B?cUFyc2Nuc0hVMDhDenRTMVBpRW9sYVV6QUo2aUxvZ0Zua0Ztd3RQK2ozY3h6?=
 =?utf-8?B?cXNCRDh6YnJlbWRCMGNHRWo1UVZRVXAvTDQyazRsSEFlVlJiWTBZQy9yNDFs?=
 =?utf-8?B?eDhKOWZYYllodiszTmpGM3EzU2RhVklRTFF2UUFNakdXeC90S2RoUEd6R3RQ?=
 =?utf-8?B?S3Q3cjZmNVZ0QjIrMXVzTEtGNHFRN3QvbWIxWTVhVDVuQmZzNUVnQkpxaTQw?=
 =?utf-8?B?ZU1yVHQvUXNETUxrVXN5aHFnM2NVaUJPVkkxeVM4VDFzdXRLQlozb1J4MVYw?=
 =?utf-8?B?QUp6TGlyaVpsRGFJV2grWnF1dEJMdVZ6cEd4K25RakFTRGZISUJJcm1VTnR5?=
 =?utf-8?B?MDNwcGRtbDdQem1NZy9YbEJyR2lJbnkxa0o3ZEd6b2FuRXVScVdWcVFiajFn?=
 =?utf-8?B?ZGRMeGE2T0JHbVNSTTZyc0NidkxGR2NUblcvOENEQzVzN2Fqczg2NHp2YWt0?=
 =?utf-8?B?MmVBaFl6ZjJPQ2tjT3BrSlZpaFlXSGpLbWt0MllGMGpsL1M5OWZOa3N3QlRk?=
 =?utf-8?B?VlpzeUdIMGFvZ2d0bEJNUXNkcnhibFJTUllLRno5VW0vc2V0Y0ZpQm5jVk5r?=
 =?utf-8?B?VE1uU25UOTRDSHJrTjVDSllYdzZnWkRxM01yK0lLODN0U01BNE5GVGwxTFhv?=
 =?utf-8?B?cTlhL3Y2RHRncEkrMHZyYXV5Wm9PUy9mdUFPWEtMcXg0Z1pQSllCeFpnR1RZ?=
 =?utf-8?B?b3k5aEJsQ0VqUEw4eVU3WDh5TCtCNzNEK3Jtc0lBOGJ5MStnc3U1S0hldnhP?=
 =?utf-8?B?R1pBVzF2b2VlMXpudnhxRGljWE1ReVVRVkN2MklhZ2dSZktrUWl4ZFZrZmFD?=
 =?utf-8?B?K1FUbUN3Mi9EWmFYbTh3aWhIWUhvV0RBRUFiLy9mcytIZEdxSExLL2ZOSzBm?=
 =?utf-8?B?ZTJOTzlTZ0tLYkkyM1N5NWk2L2hsNVBpa2hGQ3dCUHp5UFJrMEtVQy9pRzdY?=
 =?utf-8?B?N25jUWI2eXRIVllFR1JBdjJyMjY4dGNkV05UWm5VbmJ2bEVBSjlJcU1aR0dn?=
 =?utf-8?B?NW1uUHZUd1dJWU1zZThCbVd3a0YyTlhwVEY4M2lKNWkycHAybExYUmg0bnh1?=
 =?utf-8?B?MnVUQ3lGeGZxUG9xLzFTeUVWUGs2NWVWVGVzSy9ucWh1YWxvZDJBa1hlVGRN?=
 =?utf-8?B?ZXhlUExEM1ZZNlRqVkJzSXNjcDM3NENGc0pYc3lhWUxYMnkvNlMxQWFmVHZt?=
 =?utf-8?B?MmRYODNiSVRPeUhHdkdWNnpZVGJFM2VETnBURHRURXdoUEUxSGR0TVh2K0xW?=
 =?utf-8?B?Um5HRnVRRHJvNGNWKzZzVy9OcmwySmprVCtJMC9Edm45NllUZy9hb2M3RUpw?=
 =?utf-8?B?V09qeHQ2bUxCMUtPTEZNTjFuTXI5RUJTa3RWYVRUSUxkeHAvMkpmVGprUDNo?=
 =?utf-8?B?TWwwK1hEcVFPSjBWTm1XYWNLTm1leGI1Z1Jid3hUL1ZuWXM4ckIzblBoV1FE?=
 =?utf-8?Q?ybHZnyPzuVmULHRAApqHU4Gfe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5085d3ff-78a1-419b-f107-08dbd4a617ee
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 15:30:04.1682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtArCCiu0wBr5swwEUDabHAEF/MnLmJDIur1MHeaXFh4cXtRX5qVzqLmvpbDQEYFUtbx3hHvcYIf63on3ULXhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9254
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/2023 8:28 AM, kernel test robot wrote:
> Hi Yazen,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on ras/edac-for-next]
> [also build test ERROR on linus/master v6.6-rc6 next-20231016]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Yazen-Ghannam/RAS-Introduce-AMD-Address-Translation-Library/20231006-014458
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
> patch link:    https://lore.kernel.org/r/20231005173526.42831-2-yazen.ghannam%40amd.com
> patch subject: [PATCH v2 1/2] RAS: Introduce AMD Address Translation Library
> config: i386-buildonly-randconfig-002-20231016 (https://download.01.org/0day-ci/archive/20231016/202310162015.fuitGuiJ-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231016/202310162015.fuitGuiJ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310162015.fuitGuiJ-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     ld: drivers/ras/amd/atl/denormalize.o: in function `denormalize_address':
>>> denormalize.c:(.text+0x84f): undefined reference to `__umoddi3'
> 

This is the code of interest:
	addr_mod = temp_addr_b % 3;

"temp_addr_b" is a u64 value.

__umoddi3() takes "unsigned long" values as input. This works on x86_64 
where "unsigned long" is 64-bits, but will fail on i386 where "unsigned 
long" is 32-bits. I *think* __umodti3() should be used which takes 
"unsigned long long" values as input. This would work on both i386 and 
x86_64, since "unsigned long long" will be 64-bits.

I was able to reproduce the issue with GCC 9 and 10, and the issue is 
not present with GCC 11 and 12.

I'm assuming a compiler/linker issue at the moment. In particular, I 
wonder if gcc and ld need to be matched. I'm using a newer ld version 
(2.38), and this works with newer gcc versions (11 and 12) but fails 
with the older versions (9 and 10).

Any thoughts?

Thanks,
Yazen
