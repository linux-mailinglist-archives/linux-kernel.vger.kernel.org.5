Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C503785CC2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbjHWP5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbjHWP5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:57:00 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9558E74;
        Wed, 23 Aug 2023 08:56:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bm4CDJ554UgFL1qwKVZ0WHrFpUs+AUsPR3uWA1e1mIRvcdAbS7xqCW2dQAF/SRCyJyIGgcBs+5XJ4NqXhlmzbaeU2Vv403dH7w1Fwqu+7EwAToAPwThXxLW7M/5LySvND316TFFqgyJ5QJ1YO4uUZx3Wz8Hb1ZIXskOWClVubkAv95PyDwk1RoUqMtXc3xT8eqUsXe8WnnUPVsr1Aj7xywwSLkxtfw4sceJiFqSujI/EdDgsFaMKqmQcKFwYp6qFj4e7DwD6nwp9gq8TJUB+ErM6QnBgUPhauWY0z42jo+0ZnScHJrky1MvuBrvJ4mNxaBQJUF2+dxEArxmbtd+Siw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fWh9mUAqrxb7tUvfJd/sbaN9jSe+502qmZy4V9zVrw=;
 b=moAoAYPOb/307ZuWSKqaCPYfIldtUD+3eOVOlnnLl1k16u6MMFsv76fL33NozmPvkhZeIa8ToFujgfG1uSwls+eBwwuq3dFQkPVsCIwCmTTo2LC+45E/C8dFsMHVkakEuCo79aw70Q4Gh8PmwJhk8tWPJeB+bFZP6k6NrPSFdJnffy7C/yt+wuwXg7r0smjTH0lu/NeKRg1roQwkq7tBuyw0GfVh41Uxa4BO3G/ppi2yeDLHIIdt2KRJdnCOmnr98GWEX+P3wmpMQZ3QsL0Dbe1w29zrhrosp7e6dPFL/MenKKCUr3FraFrn4pI9w2CvlemfkGK1GwAQqo3ABCf+Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fWh9mUAqrxb7tUvfJd/sbaN9jSe+502qmZy4V9zVrw=;
 b=CJNwJLd1cB0ulIhQDMH9247MMM5Eo6aTZkXqppzFnkXYhTjbWuvS65Nf+7lMsMxqrmt0vHEyIvSWs19otCMJ21M/7LXEsmSSs7yEMZnOZxCYHdcldmI5RP35AKklxi7jo2euHNgKC6D6UXme3Kd9PXjuLyBTtAd2vsoTbFiEiQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 15:56:54 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 15:56:54 +0000
Message-ID: <afbaba07-bdce-97e9-e8fa-25ca4e22b9c8@amd.com>
Date:   Wed, 23 Aug 2023 10:56:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: RE: [PATCH v8 4/8] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
Content-Language: en-US
To:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        "'corbet@lwn.net'" <corbet@lwn.net>,
        "'reinette.chatre@intel.com'" <reinette.chatre@intel.com>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'mingo@redhat.com'" <mingo@redhat.com>,
        "'bp@alien8.de'" <bp@alien8.de>
Cc:     "'fenghua.yu@intel.com'" <fenghua.yu@intel.com>,
        "'dave.hansen@linux.intel.com'" <dave.hansen@linux.intel.com>,
        "'x86@kernel.org'" <x86@kernel.org>,
        "'hpa@zytor.com'" <hpa@zytor.com>,
        "'paulmck@kernel.org'" <paulmck@kernel.org>,
        "'akpm@linux-foundation.org'" <akpm@linux-foundation.org>,
        "'quic_neeraju@quicinc.com'" <quic_neeraju@quicinc.com>,
        "'rdunlap@infradead.org'" <rdunlap@infradead.org>,
        "'damien.lemoal@opensource.wdc.com'" 
        <damien.lemoal@opensource.wdc.com>,
        "'songmuchun@bytedance.com'" <songmuchun@bytedance.com>,
        "'peterz@infradead.org'" <peterz@infradead.org>,
        "'jpoimboe@kernel.org'" <jpoimboe@kernel.org>,
        "'pbonzini@redhat.com'" <pbonzini@redhat.com>,
        "'chang.seok.bae@intel.com'" <chang.seok.bae@intel.com>,
        "'pawan.kumar.gupta@linux.intel.com'" 
        <pawan.kumar.gupta@linux.intel.com>,
        "'jmattson@google.com'" <jmattson@google.com>,
        "'daniel.sneddon@linux.intel.com'" <daniel.sneddon@linux.intel.com>,
        "'sandipan.das@amd.com'" <sandipan.das@amd.com>,
        "'tony.luck@intel.com'" <tony.luck@intel.com>,
        "'james.morse@arm.com'" <james.morse@arm.com>,
        "'linux-doc@vger.kernel.org'" <linux-doc@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'bagasdotme@gmail.com'" <bagasdotme@gmail.com>,
        "'eranian@google.com'" <eranian@google.com>,
        "'christophe.leroy@csgroup.eu'" <christophe.leroy@csgroup.eu>,
        "'jarkko@kernel.org'" <jarkko@kernel.org>,
        "'adrian.hunter@intel.com'" <adrian.hunter@intel.com>,
        "'quic_jiles@quicinc.com'" <quic_jiles@quicinc.com>,
        "'peternewman@google.com'" <peternewman@google.com>
References: <20230821233048.434531-5-babu.moger@amd.com>
 <TYAPR01MB6330B653E1F66310E57ED38F8B1CA@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <TYAPR01MB6330B653E1F66310E57ED38F8B1CA@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::27) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN2PR12MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a480cc-b1c4-47bb-83df-08dba3f19222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJZCFuolVnEST9EF3WDhvG7FP4/Dk0WTP6uFjTe1Vz9WEyvm9RABPuj77VW7IfA7475pokuLhnIui5Xy7wxJH66tF5HkOyaXVZB7nw3TWTEU6hnVirjl7Cm4XepFle3gryJl76cfn82Fmd75BP8Jeryy7VFgDZq8L0nlWmVTi61jv8/CWT4mlEvSGjyykUFFTbV+BGyp/qb2dCcHnJAzV7xZJPWKtGEOrgxS+cln8RCuyBYVjtXaFsPUdwiRyTwvcADGNqW7U58k7e/JI4KR8IelK2nesDLbmjq2X+mkrpMm3TkjZAPXPZ5CE+v1q8Gaz4X2DcAef3JBPkLDsvJJNJYpwQB8FiZ6E7QVtFSadllK0Ai1FtE9aBjMbCG0lMQ9o7AuF19OWGVscO6ArXrQMqxPwafSExLutMoHYQdZJ6lk5G2sUtEvaNoq6yIq0jBhwgul6bZL0TkM8cbJu0BV7tZhnaZqJppOngYbTIO+bkG6MXdoDI1Pp1pZrInB0JwNdpNkDNX6DtUfOKrdTy6dtte+FNHE+CsEVXwiiqOzJ+V21v2vWtU1und8Goyvr4AWZJwreL2+p0GCcyKfium75wD+nFyjoqfbqtyOaTRAI6k/rPNa92qLngFmX+r3LsgRaI4BhM7V1tig+5eD4HjmWtyZ6jc4lQqfHREKb9vuT7Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(136003)(39860400002)(186009)(451199024)(1800799009)(2616005)(6506007)(6486002)(316002)(53546011)(4326008)(8676002)(8936002)(54906003)(66556008)(66946007)(66476007)(110136005)(41300700001)(6512007)(26005)(7416002)(7406005)(5660300002)(6666004)(478600001)(31686004)(3450700001)(86362001)(36756003)(31696002)(2906002)(38100700002)(491001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2dMQVArYXIwMzhJT1FiYlY2NnBna2ROOFV5Y1ZHM2ZDNTlxek1YcmRtY0Mv?=
 =?utf-8?B?NzJkY29HSzc0UEt0ZndjUFRJQUdmYVhsSmg5cmxJYWN5d1llOWF1ZXBXeGVB?=
 =?utf-8?B?MWJpbWhFb3VNemlkS29wWVZ3V0xRcEQ3Rm5sRFhUZ1dIc1dGYWNYbFk0U2dr?=
 =?utf-8?B?MmlxbXkvTnkxVEJBdmgyN3kyZ2NIbDBSTWFJMTU1blRhY2hjRVh4b0pxY01K?=
 =?utf-8?B?WmZWcmNPeUw1U0NER3NJWFBTNzNHQVV3MksxTWJQN0FOaXdzbWlZOHd6YktT?=
 =?utf-8?B?OWRSMHp2WVdOR3BkbkZ1WVQ2YzhqODVlOE9vT09hZFEwRUdLcHM0Y3RKL01p?=
 =?utf-8?B?QjNEblE3SzYyQkFSNU8waFN4QzVVT3NwUFZ6bEo5eFV3MUEvOFkySHFtdVhq?=
 =?utf-8?B?V3R0a2N1NFViRnRTMFpMU2VMck56M2JrQStnd2FqWUV4a0ZyYW11TkM1eTdW?=
 =?utf-8?B?VFQ0Q1VjSXNsZTBqb25aeGczSGthMEV0Q3BEalNBM25WSEpvTWRNZVdkOGwr?=
 =?utf-8?B?T3BLQlhUZmFEOGNXako1RTd4Z1Iwekh2TDZmc0FLWXc5NEF5QzRXMng5N2x4?=
 =?utf-8?B?NC9xRW53dk1GWUVFYndKMnA3dER6ZnRHMWhFRkFvSUc0WXVzeVptak9mdTll?=
 =?utf-8?B?NnhRWDFTdXBaRHR2czErTlpUVHN1c1pnVjlCcXE3clh0RGx3djF4VytqTEls?=
 =?utf-8?B?Qm10Ynd3a1E3bmJJVnZYOFFxOGtpS3JNVEJVMVduTDNsMXpKYXNLcmRHU0h3?=
 =?utf-8?B?RTNDcFpTeU9XRlphTWFVOGlaU29CdHB3d091bGtVWGc2M3lWVW9iTW9odHFV?=
 =?utf-8?B?R1dtMk9BUTBjN2NISXUreFczUzZGbFVTWmdTUU15MnE1TGtWeUhGUFZqNlVx?=
 =?utf-8?B?NC95WTc0RS9maVBlWE1Sc3NlczJ6a3JlMzR3VkRPemQ2RkZHS3VYL2YwKzZF?=
 =?utf-8?B?dzFIOVJZWEg5YTJZT2tCTXZCSXhESWEwQkkwaXlxZDdKWU9DMHVCMzc0cmFi?=
 =?utf-8?B?dG1sc1VMYk9aeTFOMU0yVjh3aVRwblZ6d1JwQVV4MDFQNERTNEpyYUZyVXZu?=
 =?utf-8?B?VjdhVy8yR0FQZ3ROVWFvTEJ5NU1JbGg0UE1uNTZrU0FGZS8wNk9pc0M4bnF3?=
 =?utf-8?B?Ui9MZGxZQVBaSDZLbWM2SG9Qb3EwcEF4cjV2VnFWNmQyR0pCNWJrVDY3aU8x?=
 =?utf-8?B?a1Jub3NoY1BGUTNFbjl4czUzdzZ6bkIxN0QzMTJEMGlrVFNLZS82aXZyR29E?=
 =?utf-8?B?N0U2OTdHQVpLTzhLVXMweFlad3UycnhIMFFLeW1HUVlaYXZBZmQ5b2duaURY?=
 =?utf-8?B?SlV2MVo1WEdCaUgvTXhydFl3Y2Z0eFlKMkt3WHI3KzdDTmtWMU1yMi90eWZH?=
 =?utf-8?B?OXdpcGtCTERSV2hYSUVUU0k1U2RJU21LcU9Yck9ZaUoyTWpid0hpK2s2NTZP?=
 =?utf-8?B?ZU9xUFJpdVdPSUxhS2xuaTl2NllBRms5cmkwcm1MTElrT3ZZTUk2Q05UWDJT?=
 =?utf-8?B?S1lDdjU5YlN5cUM1dGl4ZXdVUzk4emJTUHljQUk4UHdKTVdwSWJXSjRSczcr?=
 =?utf-8?B?TlZwUEEyOHlFVlpncERMTkhlWDZFQ0Rrb0h2Y3ZWQUpUZGpTcUNrVlp2RTQ2?=
 =?utf-8?B?YzYzOTJHcmpyTU1IbWhtaTRIL2M3UVhzeEhmVW1YeHhlWXQ1WnlxTzJmT29p?=
 =?utf-8?B?ZVRMR05XTzVjK0pPdzZSUDNkSHhwa0xVeDhlVU9ReDkySzdJV1ZjVGVlSGdP?=
 =?utf-8?B?YlVGK2lvUGFTaFR6ZUpWRTFHZ2dEdHZXUWpqQm8wU0dTWk9kYTlqZjVIc2Uz?=
 =?utf-8?B?Ry81WHdQSy9EZW1sbDdOK0V1OXZ3OUFuWlErc0wvbUVsU2tKbEppS3JIK1hZ?=
 =?utf-8?B?a1E0cmkvNnQxVmNWcXJva2dacmVRMzAzTkJZQlU5L3BMT21BZEdubjQ5Z0FV?=
 =?utf-8?B?QzUxeXAyMEtzNUFkak45cDEzNlArWi9QdlpBdHNCQ0ltcXJxeFBpb2E2Um9M?=
 =?utf-8?B?RzlucnVDTTFKWUNHcUx6WVNNUTc3dVd4S1lTL0ZZU2h4UU5aR3JGTXJpNFdU?=
 =?utf-8?B?V1BnbTFNbUg5ckhhWGdpcFhCQXQ3T0l6SU5xZWlZMDhZSnQxZWxGL0o4RHZW?=
 =?utf-8?Q?vFWg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a480cc-b1c4-47bb-83df-08dba3f19222
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:56:53.9414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrvoBr0a2GoLSUhrr7tO9tfX1zlYkZacaOrMYonjCtYhY220Z+/n6YqH3Zht4xb+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shaopeng,

On 8/23/23 02:03, Shaopeng Tan (Fujitsu) wrote:
> Hi Babu,
> 
> 
>> resctrl uses RFTYPE flags for creating resctrl directory structure.
>>
>> Definitions and directory structures are not documented. Add comments to
>> improve the readability and help future additions.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/internal.h | 58
>> ++++++++++++++++++++++++++
>>  1 file changed, 58 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 2051179a3b91..b09e7abd1299 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -240,6 +240,64 @@ struct rdtgroup {
>>
>>  /*
>>   * Define the file type flags for base and info directories.
>> + *
>> + * RESCTRL filesystem has two main components
>> + *	a. info
>> + *	b. base
>> + *
>> + * /sys/fs/resctrl/
>> + *	|
>> + *	--> info (Top level directory named "info". Contains files that
>> + *	|	  provide details on control and monitoring resources.)
>> + *	|
>> + *	--> base (Root directory associated with default resource group
>> + *		  as well as directories created by user for MON and CTRL
>> + *		  groups. Contains files to interact with MON and CTRL
>> + *		  groups.)
>> + *
>> + *	Note: resctrl uses flags for files, not for directories.
>> + *	      Directories are created based on the resource type. Added
>> + *	      directories below for better understanding.
>> + *
>> + *	info directory structure
>> + *	------------------------------------------------------------------
>> + *	--> RFTYPE_INFO
>> + *	    directory: info
> "directory" ->"Directory"

Sorry.. I missed that. Will fix.

> 
>> + *		--> RFTYPE_TOP (Files in top level of info directory)
>> + *		    File: last_cmd_status
>> + *
>> + *		--> RFTYPE_MON (Files for all monitoring resources)
>> + *		    Directory: L3_MON
>> + *		        Files: mon_features, num_rmids
>> + *
>> + *			--> RFTYPE_RES_CACHE (Files for cache monitoring
>> resources)
>> + *			    Directory: L3_MON
>> + *			        Files: max_threshold_occupancy,
>> + *			               mbm_total_bytes_config,
>> + *			               mbm_local_bytes_config
>> + *
>> + *		--> RFTYPE_CTRL (Files for all control resources)
>> + *		    Directories: L2, L3, MB, SMBA
>> + *		           File: num_closids
>> + *
>> + *			--> RFTYPE_RES_CACHE (Files for cache control
>> resources)
>> + *			    Directories: L2, L3
>> + *			          Files: bit_usage, cbm_mask,
>> min_cbm_bits,
>> + *			                 shareable_bits
>> + *
>> + *			--> RFTYPE_RES_MB (Files for memory control
>> resources)
>> + *			    Directories: MB, SMBA
>> + *			          Files: bandwidth_gran, delay_linear,
>> + *			                 min_bandwidth,
>> thread_throttle_mode
>> + *
>> + *	base directory structure
>> + *	------------------------------------------------------------------
>> + *	--> RFTYPE_BASE (Files common for both MON and CTRL groups)
>> + *	    Files: cpus, cpus_list, tasks
>> + *
>> + *		--> RFTYPE_CTRL (Files only for CTRL group)
>> + *		    Files: mode, schemata, size
> I think this is reinette's advice,
> but "		--> RFTYPE_CTRL (Files only for CTRL group)" looks like a subdirectory.
> Is this expected?

Yes. It is expected. We have two combinations here.
1. RFTYPE_BASE
2. RFTYPE_BASE | RFTYPE_CTRL

Because it is OR'd with two flags, I would say it is displayed as expected.

Thanks
Babu Moger
