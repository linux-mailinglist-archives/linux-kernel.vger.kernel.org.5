Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E587CB5D9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbjJPV7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjJPV7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:59:07 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73F19B;
        Mon, 16 Oct 2023 14:59:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ujn64hgf3SyI6zHBp3x0Mp34rHKMeAfQavatNo/QM08vIF8yDGL4J/Qtm9OaRevFLZjfvLYc/n7R/I60ubWnMtghForHOpXj0QJcrw9O1G8wt4BOV2MPl136aiWxtckmhA9bSOUybk+9b5MAmarTyyvlv3Alnk3PbfW5RZsAHe/+GEfbFzZLru5MOQWHUzcIbgmsnwowAmu7T28uOvYnVTiUAcZkgqpLZKxCM9KTqImj9fy3IWoF0+5Y4Pg2VfUGAH/FJpGcSR9auf+QBVWRLGwk7OidLqvAmIHMROqC1g+bCPaN6xOd9QaBrXjAwfws8hU4DgRtZU9FKDJ/Gh1S0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RS4OjCa9kUkPQVBTJRwzESq6mEiignBpMKPMaRhw6HE=;
 b=iIUrE30NFaUaNzYSA+Lb7uxAZjjY02Vzfv9uK42S2gVOvIOwY9RVkY1IHhR3n9xnk3JbbqWcRwpITTScvgQhNAuYrj3yGQvy6r4JZbWPaxXjnYYRX+o9kVifxtX67wOhHLDn48+hta5phZcKwCvlq8IJtEeoCt8Q4N84vP5Ib81Iv6iC4ajrL+v3+x77IP0lVlrZIxBVSBdi+5zVOJTCrDx3VyWLSSBHvpSM0M3X6YIKq8VTYbHTP7+UH1xHmCjZod4i3weY1Zhd81Lfx532rV4rf8n1go6bJHVezVgywxss6k5aZNbgpcKDcVtKnCsron7zBarW8gqxzHpkhrOVGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RS4OjCa9kUkPQVBTJRwzESq6mEiignBpMKPMaRhw6HE=;
 b=bhC5AhZjm+UBeVxPV5cge7jJ2uMOKF5Gvh7mfuc+oC4hx73VR0mzl143iaZSFVs9vKAkW7FS9LJGux6Sc+xedD+UcIckk5/vqF+EwFN3DT7U6kvGcGW4pHEsok6zh0od9HriZrVBT4MYBBw7LqFPPxhIAh0N5sAPdeXd+J1XvQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB8069.namprd12.prod.outlook.com (2603:10b6:8:f0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.35; Mon, 16 Oct 2023 21:59:02 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 21:59:02 +0000
Message-ID: <f2e6480a-ff75-72c3-8a92-3619dc5e8b6d@amd.com>
Date:   Mon, 16 Oct 2023 16:58:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v13 04/10] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com
Cc:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com,
        fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
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
References: <20231013202602.2492645-1-babu.moger@amd.com>
 <20231013202602.2492645-5-babu.moger@amd.com>
 <d4a33013-0448-4c36-a168-b3a953024962@intel.com>
 <0acbb031-a84e-1cbc-0857-f087b07a9056@amd.com>
 <299778a6-5ea0-c70d-54d6-1ecdc1b417d6@amd.com>
 <2c86957f-9705-4f24-aa43-60d89f636c31@intel.com>
 <20231016211017.GFZS2mufnu+hTADrEF@fat_crate.local>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <20231016211017.GFZS2mufnu+hTADrEF@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN1PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:408:e2::6) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: d44a8caf-8d5d-4887-cb65-08dbce931bb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tJOuFq/X87fyRci44a0Bww4CgY1aEtp58MpMar0S2T2S2w8QFBgjaXbkrhN0zJL6a6C7yII1RetNRw57AJcGQOJTS9nBMQrZsufe9Tr8iQPVok6DAZKLwc/xz+XPQlfpWA7+m7McTS/O1Xbbu99lkywdpGV0b/yWegq0RzD6pY5zLT59/w7P6gjdxnETl1WFAwXTEn3Y+dmCDevc/5/4dVCjigg+An3Piqj4HcGNlIyJlIEkfszRTyWRjKauzzUeI/xDgLwdDUIAYepJk1LzjUJ3VQUll3D5uf6ceTrs+mgreLPR8InqlPpDoBXZDprx0fgxbQektp+B+Z9FFFCmSZkNflcTbe5vIfUFLIFKr6I1YNAVTrTkUCRCiaOLeD1xf52h7MDn9khUfeXxrcz7o7FTZZMArXpgfz22UYiCF3wlV6af+fjnE7E/A34vFs5NjnC0doahwdspVdu3oZ/91nkvzOrJfDsrvpuARzr/17FGwaZ9AUOSfANCZk1VT8cBrv/96ox6kLAOrZXKtDD3d5Jfj0l+uHJCRwRypE9bYw9XfDslRlZkLOE3dXRul9vdVCwcCwGwpKHpny0VdVI9sD55M1K+4utyaEE5PtuoE8GutWXJysi9w6qXRJZlaY+skJIHVo4K3swwN7baug0QDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(366004)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6486002)(6636002)(478600001)(2616005)(66476007)(316002)(110136005)(7406005)(66556008)(66946007)(6512007)(26005)(6506007)(2906002)(5660300002)(8936002)(4326008)(8676002)(7416002)(4744005)(41300700001)(31696002)(36756003)(38100700002)(6666004)(53546011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2JrM0xuWkJacTdOYU1tb1lrckRTQmFWYnNXTG12TkdneXM0dmlId2Z6Ym5U?=
 =?utf-8?B?U05tQ3dtTS9aSjdHcW80eEoyVW11QWdKMHpOVEQ3TThGL2RvZ3BqQlcwVHM5?=
 =?utf-8?B?ckNQZGZUeURJcTRkVmxQbTJLdTB5dzZzVDMrZkxNNEtHM0JkV1h6bmh1bDRI?=
 =?utf-8?B?NXAzcnlCcUIwVEx3OWtFcGIwOW02dGxhRER1SXFuWWV1UTBhdHpsR05EUGFm?=
 =?utf-8?B?cUc2SThsWTdWMlJPRENHcGZKdXpuOVlybVZzODVhWG5OMnlWenpZY0srbnEx?=
 =?utf-8?B?clY3TUVPV2k3SHRyOXg2NlpYL3o3NVNUU01IbWhEMTN3OUN0K0dLUlNoRWh3?=
 =?utf-8?B?b0t6WXZzM0N2U3hkSThKY3dGK2dUUlQzdXd3MHVyZUlNRVl4UDl2Y0RqOTl2?=
 =?utf-8?B?bzFBcXFCb29zem5GaWRHcGs4dFgxcjZ5bkVLbnFyZ2tSeTlBZ3pSSDBwZlh1?=
 =?utf-8?B?bUJpRzk1ZC81WTJhQSs5bHNrVDh5S0NrUlByN3Fodk12NFhqSDBuUE5ieGho?=
 =?utf-8?B?RXBuNExDdkVLV1NwMit2UXVQM3RFVEZUU3FqcUd5M2x4N3lsYkRTeE5LUVZv?=
 =?utf-8?B?UVd5TTAxR1NzdUlqcnQ3ZUdFUUxrTkV6b285MHZkdENsQzBEVWpNcGdPOXA3?=
 =?utf-8?B?N1lydVRZVFhxUUY3bHFaclZ4cGF0OU8yenhNY1F5M21GM2ZWckhjeEE1aGdN?=
 =?utf-8?B?KzlBTlA1UVFzYzBRRU8xbEI3Mk84TGUwamxTbDNmWnk2b3ZYR0p4Wk1nNVZ6?=
 =?utf-8?B?UUEySTd0UGpmeU1Sa2xVR05uWmtkbHFrRTAxellWUWpUd3QzVGViK1FPU1Vv?=
 =?utf-8?B?TVk2SDlWU3Nubk1mSVl4RnNXYzQrcWUvMDVFcmpFWk00SGJkeUlMS3VTMHht?=
 =?utf-8?B?Z2RlQmxrL1lBZmV1VjQxRWdJb3UxNTlkN3dvKzQ5RWtHWVFFM3RVYitYQTBt?=
 =?utf-8?B?ZS9SMXJNdGhRRXgyaE9jY1llMjB6WUc2WDRIWExjTVZSZnBCSDZpRU9JL0py?=
 =?utf-8?B?SU5GRzM5WDRTTER2NkpOd2F3amFuSlRaWldGRi9Zd3pXSE1qekM2UGNFQjJv?=
 =?utf-8?B?T2dmMmZESVE1SCtZYnBCcVZVL3k1dTZuZFA2a2thVGNDOW1VZTBmZENiMDFV?=
 =?utf-8?B?d0VrWFhRZC9DV2kxRStFSzhvWVZjOWNiRjBldWVjZE42cUJldk4zZ05tcjhO?=
 =?utf-8?B?MjdxMVVmSEIyU0F1RVVuTWJJZWJzQWlqeFZxeTNpV1JWdWszTmxWcWlabTQr?=
 =?utf-8?B?UjFxL1FsOFBFRVRYSDNTeEpnZlU0RzVOV0o4NGhIbmNLc3dYbUt3S3Y5SWRS?=
 =?utf-8?B?Tk5EbUpNajgrUmY1bU1HenFlTFRCRVkwQ1NMRWY5UUVlVmZqWmRzS2JXZk5t?=
 =?utf-8?B?UE1zdmNuYUkwUGswTEYyT3k4eDZOalpZVm5jSSsrbGgra3hKckhHY1dmQUE2?=
 =?utf-8?B?QmtnSzJXYzdIVklOeW1TbndVMlVzNEpYMW9ldnRLV2hwdUZwMUIyUGVXUTBI?=
 =?utf-8?B?aVNHbmZNNjE0bnEwWm9pS1FOanJCbExPUW5lcllwUVl2ckZVSkh6d1B6UkNE?=
 =?utf-8?B?MzBnNmFRK1JydDUxM1BzU3hlSWhXcnN6OEk2SDhDV3B4SXp3eTRKTHFHUXQv?=
 =?utf-8?B?M3IzVC9xajNqOUhCd0c1MU80RkNTeHdwWlFQdFcvOEMxWGtMdmxBcXJQcjFZ?=
 =?utf-8?B?SjhpdjNWdm05NzNoaWdWSnR5dlByT01Gdjh5MkZXYTFWalp2bkZPSDh6eGxq?=
 =?utf-8?B?M05DYkYxWXY2WXAvcXhzdjBzVjVIb05JbGpTVHAxemlNTmtQZ2hqOWVxYUdV?=
 =?utf-8?B?V0xPVzNBNWNpNG5JRXNlN3lpSTRUQUdXVXZSNGpZQTM2MWcwMVU4YUJXMW5x?=
 =?utf-8?B?RzVJZFRGcHU0Y3YxQU52TFNJUUgwU1F2NzE5RkdiNXNoZTEzd2JOVGpOV3Vi?=
 =?utf-8?B?R3lGN0FzUSt0M0pBZlZlSldhck41dGpQODIrOFFiYjBXcnI4aDE0OUtuYjlw?=
 =?utf-8?B?dExnNi9haTQ2cUxqMkMzOGZqaU5iOFlxYmtrZEgzQ3IrVFVFMHl2bExPdjZP?=
 =?utf-8?B?V0VQZ0FHb1JzZlJmczg0bWxqYldnaTd3d2cwVys2UFhBaUEzeThLV1NzanF4?=
 =?utf-8?Q?G96w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44a8caf-8d5d-4887-cb65-08dbce931bb9
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 21:59:02.5981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9gSzNO2kylurLY4pSj9dXBsyMieGIOq24w0rgD1qPx+a5sg+kT+FIjbibDMA2bZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8069
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 10/16/2023 4:10 PM, Borislav Petkov wrote:
> On Mon, Oct 16, 2023 at 01:46:42PM -0700, Reinette Chatre wrote:
>> This still does not look as though you consider how the document
>> looks after the changes.
> Looking how this would take longer, Babu, you could leave out the
> documentation changes for now and send the rest of the pile which has
> been reviewed.
>
> And then you can take your time and do the documentation stuff after
> that.

Yes. Sure. Will send it  ASAP.

Thanks

Babu

