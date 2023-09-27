Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64937B0E24
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 23:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjI0VeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 17:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0VeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 17:34:10 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A91611D;
        Wed, 27 Sep 2023 14:34:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFemWmhMa98CEkWfnhsrpOjB+wuDPUCnnFAjphb6xdrruHAUqG360u+1YZDB1Ut/DqB9Gf/jvg5wWP0THlJBQh687poLIIDlbs+fzrtmDMFVp9OLR7Tuz0tDg4Qwk8MhxMnqrQ4jCXFljcLvQEGwhNn28f3AFcNyKu7rB6D1IDXhudbRQGz0Q2M76p5eyVqVpYVPqQvdiwFovit+qobRguBAe/s5CTYld3OM95gP/vAJact5hUtWN/YvsZzoe1pHx7+5a/dDN19kC0KzLPZrt19iD0zlOF6bWaMTbOkw49pIwH+Yx9V489hRuMJu3o/VhW56PaUOg77ALXXzAq55uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlsw6l2IcofbloruoymFgFFvKIxhaeUqfhusV5bK5Mw=;
 b=g5+BBn0Op8wAz2rzVmw7wMiAXXl/FZbYsO5PPCpzvJaRLq0Vi6/1CfnTNxJz0u+NmJuxz+zjeIz7ZRohhJmOHNDZtNNnTFeiiM5GApl1YVjNeQTgoqBtmD5V020wAdwbLPzbD7vS5E9oVX97zwc2mV+rHC+DUkhOKYY0mf+qN1DXoX5AWYVkjlzelPlnLPBVPC5c4CLaGn6cmNrKzroDzWrTgWweuHXPkLNCoPamoVXhdpq3cJwQhhr43vMQhKhGFLeR+KvAWEwVaF3bdwIWm31Dj/RH4dj36BzEAappn6Ax7nTFCA9/HBIGDy9xKf/eE/k5rqjfdb7Ue4tkcEc+tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlsw6l2IcofbloruoymFgFFvKIxhaeUqfhusV5bK5Mw=;
 b=JVHkErn5Hg8JcEVrt4RrdAbPoOG5dDyMQz2mRVRys4yYBBw7NdZpWzDZ3OCFFFhB+o9dxrJ7sfkIT96qME5mTxNUZdFT7ENOMDpY04esF7+5K+CGK9j+jLWDP4PckWQ/CZw1i7dzro0dqFqumLLSzul1VGgP5hnPp7ocgLnUGdg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Wed, 27 Sep
 2023 21:34:05 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 21:34:05 +0000
Message-ID: <7c6dcc06-0b6c-a346-c7ff-60da3fe59fbc@amd.com>
Date:   Wed, 27 Sep 2023 16:34:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v10 09/10] x86/resctrl: Add support for the files for MON
 groups only
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, corbet@lwn.net,
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
References: <20230915224227.1336967-1-babu.moger@amd.com>
 <20230915224227.1336967-10-babu.moger@amd.com>
 <031ef099-a7d2-37ce-eb97-c4f7d76a12c4@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <031ef099-a7d2-37ce-eb97-c4f7d76a12c4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0116.namprd13.prod.outlook.com
 (2603:10b6:806:24::31) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: 2101ec56-2e03-4540-3ea8-08dbbfa17980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fn1InUGgB+rl+rq+W5USxxOWB6QS8gMVIpsyHUqaYdu3gYKkz2i7vm31poJ6t17XBEoX0c3C07qnbJPE87vBZJ8X1fQizLP0GLudrJM0dO8JyB1JnwIb4d6vADcswJ2I87pZDvujH1mZgN1DiZwMI7n9fKMoCfOHs8pCvfhHuqeipRlDt2AkCBZ3I7CcTebeG9q9ouoACVBanbZUDt5RAVWJY/GpImuN4h6CT/o7rIV3udoHb8Wzy/iVDcqVgM1S5Ezxg+81bgPv3wtUI9XTgJBV60Vn1iyeYehD6JDE0gfEsIWJnu1c4qNcUpIQtSN3nUJB58sLSVln3m/44NBy8FrFJBvxByEAUFqYTA2hbg518je8WIRDVa/SbFQd2qnfFwaWjHgncCUNK8IDvnfJGVrnRTt7Tti2+LwS6OtMtlEI4Qw9G6JfDumg2vY+EnKq8ODD6RYYEjA8++jPjERN9UF2Xk/lQXmyP/PlQs1529/EayS1JXntqmUwJe+aeHfdGP/qobQkRlP5aiAwT+8H54rsOshK9clVbsLgLKDB1bdYY6efdkVEl9NynPvYT61WqwWcioexUmDEZALtQR4beifRq4OS0McKPk4WOn3nsCHKN0KAiCzP7bULWMljg7bCgNFYXo8+bi1pr9WeJkPiig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(136003)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6666004)(53546011)(6486002)(6506007)(478600001)(83380400001)(2616005)(26005)(6512007)(7406005)(7416002)(2906002)(41300700001)(316002)(110136005)(66476007)(66946007)(66556008)(5660300002)(4326008)(8676002)(8936002)(36756003)(38100700002)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDRJYm14Vm10ZXN3S2xJaTJ5V1ArdjdnNGxPUE1oY1RPb2srVXJ3Q2RnZWd2?=
 =?utf-8?B?ZVA3SlRYczRJZGladWhtU2FQc2lJQkc3RlREYXBPYUo5dmhLMkZ4LzdnemNu?=
 =?utf-8?B?TWhtRjJHMTFaclVXTlRhd1d2WllCcVZOcXBleUZ0TTBKOG9RVUxyUlg1RU9j?=
 =?utf-8?B?WWNRejBIODNLZi94a1pqWVVadHJqRDlSUk5tRVRMc1FJZlc5VTNCS2RPVzFR?=
 =?utf-8?B?MWxyY3o2aG1DOU5vamI3amw0QWJqWUwveHFxcUpqRVo5cjFOcWU2R1JJcklk?=
 =?utf-8?B?SGF4SmxkNTNKUkszRjhpc3BFeFlEMlZENEZPbG1STG1sYk1vWjFzTnhoRTJa?=
 =?utf-8?B?SnpMY05vdnlWVVRNOVljaTZvRXBkY0p0bHRLWnQxRXIxdlloZTdXc1NsZHdx?=
 =?utf-8?B?RFQ4Smc3RHRsQzVNTHZCenlMMzZ3M0U3dzh5MG5oeVV6QndVUE5ldmRObDZx?=
 =?utf-8?B?TUE3NlM0cy9sckowNGpPeTFhMjRidzZ5bFNrR3NpdjNuQXlCelRMV2JqTStE?=
 =?utf-8?B?Q0x0K3BhcUJiRUxKUmhkdUQ4RncrTlBkYnVrNFNFa3h0NFdBR3VGb0pPZ3dk?=
 =?utf-8?B?Snh3Q1YxMG9ZNFk5LzEzUVZzZGRPVjVZaDAvZm5LaVNHRk9KUGNlMGprWHNT?=
 =?utf-8?B?OEovaDVnbytJTEptcFNhTExxOGYwSk5VcHZmeFh6UkFkdXpNdmt1NWsvSURO?=
 =?utf-8?B?ZUxZYWhxQytkYUxsb2QyWGpaUy9kRVRneHAzbEhpOVB1ZTZKTkZ5RlFJcU92?=
 =?utf-8?B?L0dEZ1I0K3RxT0NqSTVTSitUSTUxNVNtT3VxWnVtL0tHdWNPZDQ2TE4yOEdQ?=
 =?utf-8?B?amNHOFhhNnYvVzZRRXBNbHViM1kzRmpIWjVqbWVJNGhqa1ZXZ09KQzNnMXhG?=
 =?utf-8?B?cjF6WW8yR3ZHR2pwRUFxTUVzbDFBTEFVOFhmV2xtL2RBdkpkdHU1eVNYWEtT?=
 =?utf-8?B?S2NkME53MTZvOWJ2SzRyWEZHNzJZLzMybWJKTFRoQ05ldzliUDJJNHlJWm1w?=
 =?utf-8?B?TkhjRy83U041ZWtMaU1SWjcrWEpRNG9jaDRMTnBlTHI2dkF5UTZsaHFsdVR2?=
 =?utf-8?B?VHlvNFB4NWxjL2VJRHFOQ2JqVVV0OUVXaUkvd3VsdVg3RXhIcjNYSHYxMGxR?=
 =?utf-8?B?b1FQRDZDUlRRVmNpRE1aQ2pKcjRHL3NDSzZic1JqZTBkK1h0LzRTNlJtdnJs?=
 =?utf-8?B?ZWorY3dGRDV5VXZxVGhOZ09iMm00cU5CN0ZGVzY2Zm5FdDYyNmpTRGk4RGRB?=
 =?utf-8?B?bHI2c3pUQzRyMlFFOE1QemkyTmIrZDZYSnhlMDZIL0IwN0cyMUpncnZsb2Jq?=
 =?utf-8?B?NWc3Ymp2d3N4a2N4ME9WbkFERFN3cW0xNDQyZC9ZQll3VUIyQ29XeDlhWFNW?=
 =?utf-8?B?ZWV6aXBOTmdrWVhveDg4VmhVRUs4SnFIZ1d2ZmJCU3RLN2ZjcVQxbmpHVjdG?=
 =?utf-8?B?Qk9hUXU1Y09VdjZOSDdWVklwU1BMZWFEQWJBb2tBU0wzRHViVHJhcGhKQnNM?=
 =?utf-8?B?UWJHalluYTZjaDBOWXJNTXpBY0UwNXpoVTF2c1BaTis4aEhvYWVsYkcvbzY2?=
 =?utf-8?B?VjFvQlpWMXpYSEdLNjg4cnpIMEJBam1jSG03aHhMUDFPTTlTY1RjeXJXVklM?=
 =?utf-8?B?cGFHRzkybm9WLzExZjRYdHNHRXYxQ3c4bmpJN2E4YmpXeFdMSUxhbFEyREw3?=
 =?utf-8?B?QXJkYUZYakRDZ2VXN0hlbmpnNUdOTzNLbzZaNCs3ZTg0SWNEckloREtObndi?=
 =?utf-8?B?MzdWNTBoeFBsaGRYU3U0dng5RVpHakJCS0pkMnUzR0cvTVJRZUpMbVFVWFVq?=
 =?utf-8?B?YWwrWEZaZ0d2MW05eU8wZEp2a21UUDNheStGZ2VBb3VMQ0YrNUYvRXByNkdE?=
 =?utf-8?B?MXJjbnJQOXd4K2dxYmJXTmh0czVDTHVvWGMrbElVZEdjUW1UaHFjTkswaEpv?=
 =?utf-8?B?emM5ZWVmSzZLeFNPOVRxRHM2TnRCRkpSYlhiaUhvUm90b04yVnZlMGVLUm9H?=
 =?utf-8?B?UE9LWWtUSGMyUVExODY4a1VPZkpPRzFJTGpnUkVrT3ZVWTV1VE9kakxKdTZQ?=
 =?utf-8?B?YS9lQmQzNDhHNis4S3J4RUtZN0xwYjJ4WDh1b0Q2NzJmWjZhNUlCMkZQTHpI?=
 =?utf-8?Q?/6BE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2101ec56-2e03-4540-3ea8-08dbbfa17980
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 21:34:05.3792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MKhTIRUBtKGtg4qmzWg8s5PJQzwGxnD5fZQ+w8QHktMyncRLmo4zzlk/kE1SRQLi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 9/27/2023 1:34 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 9/15/2023 3:42 PM, Babu Moger wrote:
>> There are 3 types resctrl root files.
> Considering patch #4, should this be "base"?
Sure.
>
>> 1. RFTYPE_BASE : Files common for both MON and CTRL groups
>> 2. RFTYPE_BASE | RFTYPE_CTRL : Files only for CTRL groups
> If (1) is accurate then I cannot see how (2) can be accurate.

How about ?

2. RFTYPE_BASE | RFTYPE_CTRL : Files for the CTRL groups

>
>> 3. RFTYPE_BASE | RFTYPE_MON : Files only for MON groups
> Same here.

How bout?

3. RFTYPE_BASE | RFTYPE_MON : Files for the MON groups

>
>> Files only for the MON groups are not supported now. Add the
>> support to create these files.
> This is not accurate. Files "only for the MON groups" are
> actually the only monitor files that *are* supported. The
> problem being fixed here is that monitor files are
> not supported for CTRL_MON groups.
>
> I made an attempt at rewriting this commit message but I am
> doing it quite quickly so please do improve it:
>
> 	Files unique to monitoring groups have the
> 	RFTYPE_MON flag. When a new monitoring group is created
> 	the resctrl files with flags RFTYPE_BASE (files common
> 	to all resource groups) and RFTYPE_MON (files unique
> 	to monitoring groups) are created to support interacting with
> 	the new monitoring group.
>
> 	A resource group can support both monitoring and control,
> 	also termed a CTRL_MON resource group. CTRL_MON groups should
> 	get both monitoring and control resctrl files but that
> 	is not the case. Only the RFTYPE_BASE and RFTYPE_CTRL files
> 	are created for	CTRL_MON groups. This is not a problem
> 	because there are no monitoring specific files with the
> 	RFTYPE_MON flag associated with resource groups.
>
> 	A later patch introduces the first RFTYPE_MON file for
> 	resource groups so fix resctrl file creation for CTRL_MON
> 	groups to ensure that monitoring files,	those with the
> 	RFTYPE_MON flag, are also created.

Looks good with slight change(only last para. Rest looks good). Just 
removed the "fix".

A later patch introduces the first RFTYPE_MON file for
resource groups. Add the changes to create the files for CTRL_MON
groups to ensure that monitoring files,	those with the RFTYPE_MON flag,
are also created.


>   
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> I only have feedback about the changelog. The patch looks good to me.

Thanks

Babu

