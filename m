Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513BF7C75D6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379664AbjJLS3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbjJLS3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:29:20 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67793D6;
        Thu, 12 Oct 2023 11:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cM55rXdmcH/Fda8TdrN8G1tVoRYYlhkjtnwQ2nmYxdu7DIHs0cX1gsz5hy5b1/wJLOXVqbjSEo5w9R8bCcI+nwXzHsux77h+nYimriuOX+mcmVpl0blQodyAA+cwhlnjux7fnUfoU0/5yrE4wFqZe1YcuBYmAMIigtI03L8KPrWv+dgsO7QneFRjqCBl5Q4YyChzV3igN2EHq+QEWeNDfXAufDVNhg5B+L70mCFyGNcqSzGwILxi/priXg51NzPWUXDU5m0yg1MQeWNVWmCobWp+oVZscj/5l7XyHm7nUx0ls7BBgz43oRPGzo1BxVORPYN5LxsX7zniVDBlWL0EmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVRiOyitTHYA/B08Jtqo7rkakEXGwMhfbBVU08O5+Ig=;
 b=COCchZt//uLzFy8AT5zT2pcsO2FsBsNqRkPgBcNUbPZuROMxMCJZ5LJw/1OeelnqeuNDnHxMiMj3ZMo5vRMhin/jKcwDgIZhal2bSL7IXFZR7bUOa1dT+Cq0dugNeJ1ZdzAo71JXHOXaGnlrgPS72Ca3Hi3izWRacMXjKe5AgxHmWss4QRIDROFUABgctp2aachnPwzQLc7Ua65tp2OQpWRudi286oxSZUykScYlBXMllg+C5OKk3vQHpAgQ5+se1uBdU7CCCCrsvMBZbc0AVXNtOX/u9y7yixaPgVsknhusd7nLWnC/5SLeFBwFNblgE0ltX7I86s2PWt15pLGeKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVRiOyitTHYA/B08Jtqo7rkakEXGwMhfbBVU08O5+Ig=;
 b=by2sCnr4OPDnUsN/u2/2bJnFUNVAUCQqBPXQl2lSqUHtpQCFGNwu3QyhIcpTuM4eFzpecflA9uIBGHIpYsN2VHYZU0NJ1zSSYIaLgGldQNadMI1qai3Wlv1JzaeN4fHNi130AXY84IyuntspsanX8bmKxTMzcFCuvBVQYJm1Cxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB8419.namprd12.prod.outlook.com (2603:10b6:8:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 18:29:15 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 18:29:15 +0000
Message-ID: <ffd40b3c-8f57-42ab-9fee-7475788f24ec@amd.com>
Date:   Thu, 12 Oct 2023 13:29:12 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v12 09/10] x86/resctrl: Add support for the files for MON
 groups only
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <20231010233335.998475-1-babu.moger@amd.com>
 <20231010233335.998475-10-babu.moger@amd.com>
 <28f089f4-992b-4331-81cb-100a1814fc56@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <28f089f4-992b-4331-81cb-100a1814fc56@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0097.namprd11.prod.outlook.com
 (2603:10b6:806:d1::12) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: c20d8527-2029-4608-6c7a-08dbcb512359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3bJXC95VjFx5fQQT1fcK5NDuahgsiB9XRjSa8reF4jCwIs7rEO+YMPQq+FfFK9VrQg/PaMsxFf1BN+m6iK5faFg0mIw+q4Q6u705fPpsNBY+V6pS0YBXD5WMTW3noJmqRuMdQ4qvyY1iy+pbPHOCR4MEZHuwRnv316qL255Z+H7AsuftFysGVCqWUNAt4F3qDQOSyaZTdTwb3yiw79JhylqKN9ACZuEVpl1XNQa6aNlUr9l0jS1Uiy1RyraXG4BPtemM3LHHoeim7cytCkUfCGZP3NGfLpssTGbFWNE7cg00hQpuwtFpf2vqcUGHMMQpbcbU7DIKUdfeHxSuE2MloaznArw+u0SZiOboo8bHZxeD5pc02trnVomcsT2HBEYQdEzMiiQlJ55kthY5jj4l4vG+PBVp9UjZgpvBRo1zR62wBhAYG3nKjcJ4eopEL9yt7+e2uoZLzKrdF1ABeYcCRC4j46510hxuC8HCTQDUyPfAWZMzjPKirlBKRQsjfWGHYLETROLNM6kdtK16bZtFqWYKMBuQhpEHygs0loCAQvRNDSuGogWcyjRMICNSR2xGmMx6UZ6eNVy6PqXoPUCqfayBgLf5sQhQdfSGw/Q9/RdmVP38Qsv7v/h5EpjpM/jQJ62b9d4d2DwJG49RCjTMkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(8676002)(4326008)(8936002)(26005)(31696002)(86362001)(7416002)(7406005)(38100700002)(2906002)(3450700001)(36756003)(5660300002)(41300700001)(6512007)(53546011)(6506007)(6486002)(478600001)(6666004)(31686004)(2616005)(66476007)(66556008)(66946007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkZXeElQVmFZVmVnbjgyclppQkhrb1RqYkFxUGdHZ3VzRVJQbGp2Wk1GNkdM?=
 =?utf-8?B?ZjljL0NWZ1hRSWd0bmdpYjBrTmoyMEtPclQzRGV2L1Bka293cW9DVlgvM1BY?=
 =?utf-8?B?S2l1elJkeTBxK2xXUGNlTXJBaHhRLzlabHo0S1hwdjlYNGN0K1NqaDBPN3Vw?=
 =?utf-8?B?d0ZJZ1VWd09rNGpMWGdON2NraUZST05RUnpObm9lT3Qrd1daM1B0NGlkM0Zn?=
 =?utf-8?B?dS9LaEd4MWdvcVlYYkdkVkVZZzI4TUl3NWFwN2NpemJyekVOdGNUSHg0U1ha?=
 =?utf-8?B?ZFBEVW1rVXhsWFZ5NE1sUUJUd3VXb1diVjJ5SU52bUs3UWNwNVZKWHFaNjlI?=
 =?utf-8?B?cjg1RFFDRSs5QjA1cnhuWkNEK3p3TEt4RW9sanRGT3orV3hKMHJRb0xocFVF?=
 =?utf-8?B?T1VqYi9aK3U3a1VyNEZtck9YK0NUbDBTdSswUW12N1lWR0NsaWtIaDBTcEh5?=
 =?utf-8?B?ZUpDaHNJQTYvU1pCdTdRYVJwVDU0SjNTYlpQUHcwb1diemJabjRlOU80MHJv?=
 =?utf-8?B?bllBbXlPOWpQbGpKSExja1gwczhnWjEwSXl3aUFyYWlLMjFqOFJWMjg3MzY2?=
 =?utf-8?B?dG5wOXpmRWN1M0liUzdWVG45UDNpbmNVTGVVMmZZdjBteW1yZVJGZmZZSTRH?=
 =?utf-8?B?aDFBNnE1L2pRM3RiUnA5YUNVdFhFa0RyNkNjd1RsWWZ4RnJTVEU5RjI1V2Yx?=
 =?utf-8?B?Qy85UXgrRWtEejAzSVM0WUlkWTBodVlEQllzbUgwWmNmN3dpUWlEQjhURUFX?=
 =?utf-8?B?Wjl1Z0xxUGRBa1AraVRMaHN2K0gxREJzcjdNR1c2blVsd3JwTnNDVXZFeVdS?=
 =?utf-8?B?RDVYdGdDaWJONDZDRXIvaDk5NnlmZU9TMVBXdFNQeDhLWmlrUVNRRWNMZi9P?=
 =?utf-8?B?SFJXVzVmT242SmFESElIOTg2cXd6b2wvSTZ5WHJpRDdwaDdIR1d3NitBeVdD?=
 =?utf-8?B?RnFwcGVjYkEya3pKbzViWk56Tk4xUzkxa3pkRjhpelFsV2ZHZFRBd0ZaU2lO?=
 =?utf-8?B?cCs1RHFHZEExOWlLd2FudGNKSjR0SVNlajZhUkU5akR5bTd4eXBFaDd4YlNv?=
 =?utf-8?B?Z2x1TGpxVnZXQUdxRUh4bXJRNktmeEQ4VmYvVlVvMHZwQi91ZXJaNjJJdWts?=
 =?utf-8?B?UG1Za0lSUG9paW81VWFYTFdKN0NkQVRmSmNPQjZJc0N4K2kyV1VOeGRGN084?=
 =?utf-8?B?UGlPaHVhL1g3UzFob2FCTU9wVG80aTdiNkpNbmtHdUE5QXVlazMwVml2NXJ1?=
 =?utf-8?B?RjYvbm5jUUdOc05oeThrdnZSTUIwQkMxV0pYSDd6ZXlXZXhFU3M1VHlrS005?=
 =?utf-8?B?RDh5OEVOOHVMN1NadXpJMTQ5ZE5ncDZlZTRuVW90TXZ1eUhxTXZaR0lLYUlu?=
 =?utf-8?B?Ym43Zno3a0tjN3lzNlVBa092aU1UWGJMbUxrVE96RzhOaHBORXRjME1NK1Yr?=
 =?utf-8?B?c2lwOTNNMlpjSFN6Rm9PR2h2VG1HcStoTnRjZlIrMUhZdk5NeEN3YWZodUxi?=
 =?utf-8?B?eU5HL1g5Q05uV2dBTXlJaTRmdjY2TEZDZVpaSmdlZThqRXBaKzZ0Vk96cTBx?=
 =?utf-8?B?U2MrYmdqSEQ0WFJwZjk1THdlMlYrMVBYNmZ5UFpvRWhaN0ZIamFzL1A4elZR?=
 =?utf-8?B?UnNOMTRPL2wzOFZaOGVxa0RacTdNOE12WFliM2JocFZEN1VPNDNjdjJDcDlu?=
 =?utf-8?B?K1pBakhUM2pSSWRFTU5VdWZ6cWtKaUpjLytpWWZsQUJWWU85SVpiSllJdENp?=
 =?utf-8?B?amRFdzJxZ25RcGtKWnFobHNhclZTbUlVVXdXVlFUeVBtbWRPM05pSHlqeDVs?=
 =?utf-8?B?VFJuYngyM1dkZlF3dmdkTEp1VXAxdXlEcW1IN0xSem5NdnJMZVNxZXFkaXVL?=
 =?utf-8?B?RUd6VVB3eVFraythOVBkM3pkRXQvUFVIdkJjSTJuL3JEK3hiTzNKOGw0cDha?=
 =?utf-8?B?Yy9WRlg1RE9hZEZpMjk3L2QvN1VCM3R4N0V1VEhrWTF6SFRHdnpZRlBsWUNM?=
 =?utf-8?B?aDFyL2JOMmlaaHlLdVdRUWJqRENZcGFCQWNoN0kvVGRtK0tWTXg4U1YydEYr?=
 =?utf-8?B?SHdyK1RackdudmlsWW0vazNVSmd3TDlQQnJJUUtEdWZwWTBrYkRkR0FDTWFT?=
 =?utf-8?Q?07bc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c20d8527-2029-4608-6c7a-08dbcb512359
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 18:29:15.0714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KO+Wr7AVhUAJucfiuMJlLB4zW3y9Yn2sNxyyiGfSnrd9mJ+TM+1V2/4VAJX0YhIK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8419
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 10/12/23 11:02, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/10/2023 4:33 PM, Babu Moger wrote:
>> Files unique to monitoring groups have the RFTYPE_MON flag. When a new
>> monitoring group is created the resctrl files with flags RFTYPE_BASE
>> (files common to all resource groups) and RFTYPE_MON (files unique to
>> monitoring groups) are created to support interacting with the new
>> monitoring group.
>>
>> A resource group can support both monitoring and control, also termed
>> a CTRL_MON resource group. CTRL_MON groups should get both monitoring
>> and control resctrl files but that is not the case. Only the
>> RFTYPE_BASE and RFTYPE_CTRL files are created for CTRL_MON groups.
> 
> There can be an empty line here to make this easier to read since that would
> separate the problem from the solution.

Sure.
> 
>> Ensure that files with the RFTYPE_MON flag are created for CTRL_MON groups.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Tested-by: Peter Newman <peternewman@google.com>
>> Reviewed-by: Peter Newman <peternewman@google.com>
>> Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
>> Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
>> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> --
> 
> Missing a "-" that will make the patch description not be as intended.

Sure.
-- 
Thanks
Babu Moger
