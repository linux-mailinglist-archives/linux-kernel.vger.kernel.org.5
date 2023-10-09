Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4BC7BEE15
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378878AbjJIWJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378867AbjJIWI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:08:56 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C8799;
        Mon,  9 Oct 2023 15:08:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JX6xFqLFSwxTf0jqlxZ6aCFSyPDsM8t/eFOcouU8DbLfdq2nxbhNvMRb7/lq18d8caXdp91mIjQHoSUfQc3ITuXs68FZLGUE5msJ1DPcWvBkNbC25jI/2Vm197IBgT1OHLp+UjjUykqzuZyuHvmya2xxdj7VjKIsByTlrexRfIaJqNID5s7bP2bxgvmLmJZyjhUCXirE0mLPSh0YqUoo0X5wZI9EQ2n7Scz8zg4yFTKhLfPGzp/sHk6wI4XW198PaPXglZnNYZg+mwurQhQzlLnqliwugptAbOgs/hjMEkEAFsZ3X7JBihgsuMxN6HRwhg5peZgMFm3ySpJC2rAlCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCV5hzDJ+bpaZnAxvxsgRbZAjDJLJxrwiZ6rDNCUKOI=;
 b=T4NyE91Z939Ni4Il5ueVYgtIbzA+4JgqKzoppz/9ufKPp3+kfZAaTSjfFrBUzggi77Mqe7jWCKj3PLP4QKBZdPgSrs2C7cLOvhrn8QKgoufkr5maR5XJMSiTr87DXXWN57hm2InsxCML/Kboxn2O2MyBuJXsUN2TDGMWyn2xwSIa/bYITOLUu5FLUmrkIjvY+AYl9usoKfH41UrFcJgN/BB2NLuROi0/F3baG3iv6AWiknIvl+9pd24aSctsRqNSCaJzCeXZRkxHODs2+jwXJ8rUadt9sIJ7bD6XqaalzhIJL9mpo8yoxfUCXxjd9PAdydbHo/5fzauVSAUsG9TPog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCV5hzDJ+bpaZnAxvxsgRbZAjDJLJxrwiZ6rDNCUKOI=;
 b=KM963YD1cbLzD4qOlcGWjYZITA1a1noPuhBdZ3Kst6KjnLX4YJ4IMDHZToiO065SiUCwd7p6ULE2HUdxZPTecnpmh7uKChHdHPPz9RNmtT2y7sKDXs/gdaVuqi4KeNcIxWvUCabsQ5lfufu1o2GNL91XBa6j4bELUdWMQYXsz1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ1PR12MB6146.namprd12.prod.outlook.com (2603:10b6:a03:45b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 22:08:51 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 22:08:51 +0000
Message-ID: <6102a5e9-ffec-5499-c27a-3c0a3443f792@amd.com>
Date:   Mon, 9 Oct 2023 17:08:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 09/10] x86/resctrl: Add support for the files for MON
 groups only
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Babu Moger <babu.moger@amd.com>
Cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, fenghua.yu@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
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
References: <20231003235430.1231238-1-babu.moger@amd.com>
 <20231003235430.1231238-10-babu.moger@amd.com>
 <20231009180017.GSZSQ/sWAwfaFr/G3w@fat_crate.local>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <20231009180017.GSZSQ/sWAwfaFr/G3w@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::11) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ1PR12MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 11171f39-8f58-4773-6ba9-08dbc91451a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gp1qjLsjNFuIIuGPV2gjOyGIxfv5Dsb4L0VBbHBNxz7uEPVvkTW7Uhm/O2D9mhPnaAraFtJArhyUyNHemy8hrjEob7Mu272eeFIvKFCg6nBSzIMVP/tMTkpIq+DLrMYofofHB5t2wECHxJr88Ja4PuzKmQjPbrb/91szBJhj3rwUeBr/ctUigYoU+ZrDwhqKW+QgIszqFF1wcZRilveXALxw6pyWhQDl9rvcTR824bYI0YPmYnVK+bjjrAOjI3x1xEHc0WBpv9+NWuEuGwfbD16sE7InzH0pfIiPIqZxVO7Hl42zs5KEVrjOyZIWC9fcJTuOhdG91sZkHUeXIK4SD864v4wH5kZtRei2bv0VAc156D7X282gPN4sJkrtgRlE9s67TVLet4uiwHKCk/J43pRsl9qKgnyUkVuzojpO38KbkpsSS+6jD36fyVHzpUKaMEUeDTDqqG3PBwc//ymlkczcWSE8Yw93YDYJSsTY4GxUX/jDMYcjV4oDs0a9FkpuEpQLRXE2BTn/HdcoKHz7VdllceqLu1QMfigxyVQX+WsPGVlXVH5XUqN0MYDd1c0R8v2io9EwVXY0bvUEAiCVgiyev4zBkjAPdferTiVI7LnqE4RkGK0kE/K5atwVQwsGxRVxDRBV6iFVpbII+zMe+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(36756003)(31696002)(31686004)(4744005)(41300700001)(2616005)(5660300002)(6512007)(7406005)(2906002)(53546011)(66476007)(66946007)(478600001)(6636002)(316002)(7416002)(66556008)(110136005)(6506007)(6666004)(6486002)(4326008)(8676002)(8936002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmVyMWdBS1NkQUpZNWRRZmZJZDIyQU50UVRDc1NmM3FPWS9BM29XK01kV0tS?=
 =?utf-8?B?M1dxQjlpa0JSZVRjdU11cTlmcHF6dlFZc3Z4ZUsxVVNRTC9mck1sYWVnYkZn?=
 =?utf-8?B?VDVHVStBaEpvamwremdIczFUNHMrV3IyUW9Qb2lCajJ0TytmSXU5bkZHdmtI?=
 =?utf-8?B?YTNYUEVVNnRDS05Ia0d1N3RhTVVUQllkSTVZV09vWmQ5b1BJeDhYVkhqZ1JE?=
 =?utf-8?B?WkxldkVBSEtTZXdlbXlRallFOHg5NkhUMm9yaWdYdXFnYkU1S0huQjVDR2hi?=
 =?utf-8?B?ZVdsSUVXVGJzeGlSWWg4djdUNGZ1YUdmaG4ycXR3YXEydXg1NGRmTHU4VTUv?=
 =?utf-8?B?eDZDbDdkUnoyN1d1bUMvV1JUU1ZwVnc5UUNNaWNPZTdpV0VNSUlOZjN0aDg1?=
 =?utf-8?B?bUc4U01pcU5GeW5wVCtjWXZTUFRiZ0sxc1JCZmFCWXlmREtoenFpdlJvVkVo?=
 =?utf-8?B?NG9TL0p3L0xWTVk3V1VCZHRSd1pNaVZpczE0T1MyelNhdml2cDh2cTczM1Yw?=
 =?utf-8?B?UVJOYmdXQ0ppOXpnOWZkVjlVZEFsZi9XeDRtcm93ZCtJcUo5NUwwS3VRbWp3?=
 =?utf-8?B?YWl0QWZodkV0bldpbFVDb0pRQ3Nzcm1VdnpXaTFFczFPRFdsbVVyUi90TnJp?=
 =?utf-8?B?VWhTNDlDN3FrUTljQ1BBV3ZVUEZWQlZjOVFpQUVMTk5PanRiR2Rna1lJQm5J?=
 =?utf-8?B?MnZqRVJ3Umc1M3dYS3AxQ3p6Y21kZ0hHSnlRUGJPRzh5aWljM3BPR1ZoSzdX?=
 =?utf-8?B?Y3htR1g5Q3N1bTZIa1B4a042WnZvaEY3NkxhanlhNFJocnU5VHhxRnpWSlRq?=
 =?utf-8?B?OU9UTmhreWxJSExUOWZ4eGQ0em9sU3FuMm9xYUhpR09pU01mdjFsYy8zQm9Q?=
 =?utf-8?B?SmpBQjl5VExxWDBnWTc0QllLSVY0ZUtMNTlZWWVxOFYvZk5hRXNCdkEyaHhx?=
 =?utf-8?B?dzByTjZSNTZDeVlselVwTmdGZFI2OG1SUEg5d0FDQWRPRkN4dFNFRVF4bnVn?=
 =?utf-8?B?MkJ2RXF5Tkl2Rnl6bjE0UXJnTXhQM3hVZi93SVRyQkhvSGdlWHg4K0ZMNmo4?=
 =?utf-8?B?NWJONmQrSU9tcDhkQ2M3VmFCSW5nd2NORXlyUVY2SGhwbko4L3JZYkpRa2VF?=
 =?utf-8?B?RTE3c0FLazM5SVZiMjBmQlo2Q0ZKWDh3UWtDU2FMMzRxZjdQL0lETlpDV2F3?=
 =?utf-8?B?K3NZOG82WDBsVGkreU41Q2J3UTgwb0tqY3JTZ3B6RGNhaWhKTmYwRlp6SHFQ?=
 =?utf-8?B?bjR4OXFWVGJxd0VRZzVSbGZGZGpDWkhXeU9HNVlkNCtvaHBQOWIxeU5wY3Yx?=
 =?utf-8?B?bFpkb3dDL0VoRktLWkYyd0JGMGJPbFhvRGF3aUZvTGJBVFhCaWU4Skh4aWFI?=
 =?utf-8?B?aHNiNHNMdi8wUzZ6eE9ma0dFRGJQUUFxS3NXM0hLU2o5RjlGK2ZMa0dLMkFH?=
 =?utf-8?B?MEYrQlplVkUrUUIxelpST20zSWlncHZIakVJY0IzazQzZDRiN0lLZU1PYlVs?=
 =?utf-8?B?VlpiWnR3NXlNeDBzRmlXbHBNSkRvM3dXTnM1SlIwU2JmM2lqcFBheHBCdElL?=
 =?utf-8?B?cnRsZlNhSS83Ni9sdzlBZE8vSVBnS0wxZC8vUHBSOEtycWQ4VGxSaXBOWVha?=
 =?utf-8?B?TkJFYVI3bWZxUUE0dERYUHBrWU1RSEVuVm9QS2hZT1FsZjJDa2V1YzlmRndn?=
 =?utf-8?B?NUpYLzFKc29QMW1OYUxsREZkYzBjbkc0U2QzUWprYktSVFo2QjZyUVd4NWNp?=
 =?utf-8?B?V2djSnlQdzRnd0FPbHFVTzhkWXFoWUNqUmxvdm1McE5UVXJZbUd4cm50NCtU?=
 =?utf-8?B?ZGVKSHBFZXpGUGFPNW1jYXZ3SU9UdXZZN0l0aVFRTkpKMGl2eEgxa25kN0ZG?=
 =?utf-8?B?R3B6SUNLMkVhMDRDTGhTQ3hJUUgxYktzUWpXYzNFZHZrZzQ0Y29TaFBKL1dm?=
 =?utf-8?B?Q2Y4S0djVWl5UEJyYmgzQk03bDIzMGVIM3VQU2hIb2w4eW9jMUtseFJNV01U?=
 =?utf-8?B?U2o0Skx0K2tpWXg5RlFXN0ZoRktOVlltRFBYQzZIK0lwM28xUzlnaVhQVHdO?=
 =?utf-8?B?LzhaWjlIUElwOW1BcU44Q1N3N1BqT2RoaklNbFZmZjdlOXd1QlNvaTM0M0Rt?=
 =?utf-8?B?TWVBaUExdmszMU84L0lONklYNGZOdkFJRUpUSWQyekY5Nko4cWlIT1d0RjZ1?=
 =?utf-8?Q?3OW4pbAkmvH5DokHiyzJLfM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11171f39-8f58-4773-6ba9-08dbc91451a1
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 22:08:51.4251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Do6MXpe8iFpHBy+bKJKftofkXB3ccGZWrMgf30thWfC0rKc9a3NnBQMKJS4OcR9g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 10/9/2023 1:00 PM, Borislav Petkov wrote:
> On Tue, Oct 03, 2023 at 06:54:29PM -0500, Babu Moger wrote:
>> A later patch introduces the first monitoring specific (RFTYPE_MON)
>> file for resource groups. Ensure that files with the RFTYPE_MON
>> flag are created for CTRL_MON groups.
> You don't need that paragraph here. The "later patch" can talk about it.

Sure. Will do.

Thanks

Babu


