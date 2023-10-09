Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7007BEAD8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378478AbjJITu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378462AbjJITuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:50:23 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36F2AC;
        Mon,  9 Oct 2023 12:50:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aezdpJ0MWGL39KZ4ZhpMALBVLKp6NQUDKTyUBTJUTbdAD/rgguAs1sS4KaDT7ZcUUZ6tSltP+g28O4lQTf8XVcQjFS33A3y81lyu/gCFX0nUA9Yv6aZccB8PO0u2isewhD3ijrXa1yfCwE81safRz5nji/BTaAYUQUBHxdC8Zl3niRNBiEKWyQf9IcvcSosP0IVTEe542llHgg5iRltaIiB3g/GjYo6TltsLyOSv1+nEgWTTK1TIUZqZSIUSgML5VvNnVGp6MeC2HsEGCx62WImyrZMRfzRCpUm6U/KCz71h5AgrKWjl9cQ4FWGHQtdPIjfK4MUxceWP/3hOCk15jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/nC3cO+8x9b0toAQUfLU7dl0GmRa4UGdlWp7szAyjs=;
 b=Xh+Jw5iVoYw3eR0DoRzflPjs3kpJ7Az/V6Uds60aiput1tf1rt5NLuzGC9XBTHj0zzameB7stNqFKmoeIJJ0CzDZO0fRpj61ufWE9y197l+XE/duh22pQa9TQuIw/d8DVMTKcxnk//yRJFOHDL0qVZMTSR8Cfe0I9skZ25n0DMNWzjmfpGI0g4Nw0Q5Ss8ffjyUbK8ySMQ7C5mLmZO5YKU5bIRKR9NU7wrSGi3CT35Pi1uU1wK2pVlj2YJKN8yYdCDaa1wiSjcNg+fgjCQyWflgnTMNp9lyzavYycW6UGTxuVqBUYVdWZodO8sI3TB4aLTRPnUKyPcnFEDHDfCZmAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/nC3cO+8x9b0toAQUfLU7dl0GmRa4UGdlWp7szAyjs=;
 b=adWvnArGwCxsikXm7g+bkT80IZi0rd6VqzZA9fbDNksKqah+L+0+dWoo8/Uh7eRsmyXq1s/V2Q0YdoiQMHez+d6mSOJv0Shy/MDD9u6XILV15EodpPYXjqd+IpBZFgVCKkKV5tI3P/Gg4SY8UVw6MIAJGcuHnVilD/bG1ANX5fc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB8918.namprd12.prod.outlook.com (2603:10b6:806:386::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Mon, 9 Oct
 2023 19:50:18 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 19:50:17 +0000
Message-ID: <bdfa67bb-2553-4674-a615-e3bb2b49f133@amd.com>
Date:   Mon, 9 Oct 2023 14:50:12 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 05/10] x86/resctrl: Unwind the errors inside
 rdt_enable_ctx()
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
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
References: <20231003235430.1231238-1-babu.moger@amd.com>
 <20231003235430.1231238-6-babu.moger@amd.com>
 <20231009172517.GRZSQ3fT05LGgpcW35@fat_crate.local>
 <f9bd5402-0377-6d75-5782-8bef29759c90@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <f9bd5402-0377-6d75-5782-8bef29759c90@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:806:23::20) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: 26026062-2709-4641-3df4-08dbc900f68f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t4pUFrEqcsXlP739DpBvJ1aHP7Etj1YTF74pJNTXNRm/CM30grobP8FV3XGrNCXAdV09VnATXRlvKjWCFvDTjKCusYi6HJFe9xzTmS16Y7XWstClTgupNE3Tmlr3Lr+wFPlzbLfhfwoDMP+nv8GyxsMBD3/y4xxNe8LImkdRy5cnoIv4+wL4hI1cyiTcgNpvS96l5QfAWCSqMUeK/H0XNShkNJBzf8VCd/lSe9gtjrO37envdp0buCzStkX+RIU107RIqy9W8nQDu3S9GYrXtt7sJ5Qip7OpYrjd4guCJL9TzfceLYW191zUdbKA5heDH5aqiEXSaGTzkzzimRa5RHJfY9VxLs03PICoRKwgDGMSslZWdKM4X8gOIhWWT85dhlRinEMHWz60bBJCXJVqMGlk6QJnAFVH00nLwOrTYTHOBuJ9jk5q0G36xWbEBX3U5uaUcIY1uOmf9IO46jvUmQHpcMx0XFZTo/K2mTrx2eASrQpdBAgCMdj7G6oTKnxyHH2RemLTRe0n73lj8IFJ96LdexbT+Y4GUv7rSZeAryzVpH6lWvo9uSP31INVYeWCtVeDNMiKF8d7H0ZJNanPxsMOTJJizdZD888laivlhiATSlq5yQm9DyxZ5N/1CD+D1RYxIBiohhod4et8UQz0mA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6666004)(31686004)(53546011)(6512007)(38100700002)(86362001)(31696002)(36756003)(26005)(7416002)(7406005)(2906002)(3450700001)(83380400001)(8676002)(2616005)(6486002)(478600001)(6506007)(8936002)(4326008)(41300700001)(66476007)(316002)(110136005)(5660300002)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXlKZEdDU3lMcng5V05QRmlpYmFlbUI1VEtkMFF0Zk9vcVRxUHlkSjkxV2RQ?=
 =?utf-8?B?VTYraXF4N0s4OXZLaTkxVVRHVlpsRUhLZE5ONWI0TzlLeVJiNzdMbWJpRzhr?=
 =?utf-8?B?L0U4Q2JPc25xNUxDRlQ3SFhTNzlTdERVbTIvTkZFdmtnUFBnbEZza3lTcE1G?=
 =?utf-8?B?b1RZOHVZTXRjN05jQVlPVUdaRnpCczNOd0VtRTNjNlV0NnhaaVU5SjhNL2Vv?=
 =?utf-8?B?djBidGdPYXFQNTgwK3UvR0cyajZYWlVEQXVWaGRMaW52RTNFb3pVVlRURWd4?=
 =?utf-8?B?SHFjZjl0OXQwa3pucy9NOFBrN28yN2VOdk9zMlhiTFluNnJsNFh1bGIwWkFi?=
 =?utf-8?B?aVNyS1V3d2pYOURsVWlsSDZkRjU1dUlzcmhrczJNYmUvNlMvbHg1cGhLTjEz?=
 =?utf-8?B?QjdMUXk1VG85SlNwWVFxQSthUlplQnBlbGZjd3ljZVhWVlFUZ0ZDMWQ5WVd4?=
 =?utf-8?B?VEdrZFc4eWF5enB1RzNYQ0FGVjVwMEtta2d2QlRuT0ovdlpZWjU5L24zK3VS?=
 =?utf-8?B?Snk2RHpQR0xxNEVrY01tSFMrbGVoZm95RWRGQVFpby9FYktvNHlGbWN2S2ZQ?=
 =?utf-8?B?TThwcHJKbXRPR3NNVFl1bU5qQ0RjV0piNndTWk5MZnRobVpPWkczVGxXcC9a?=
 =?utf-8?B?U1pyU2FBYmlJbm81TzNOdHNLZG9RUHNGQ2dxRmRKcGRoOEh2ZUVzbTZlREdj?=
 =?utf-8?B?Wks5Wi9VVTNzaGRvV1l0N01ZMnlYV0RqVkx2ei9KeG10K0xORTNEcUhJMlRl?=
 =?utf-8?B?ek5oOE9mbG82NG0yRHdPUWlmd1JiQnNGajloRElkZG5WeG1rNk5kWm1UKzFv?=
 =?utf-8?B?eXRveWF0NmJQZFlZaG5LMTRVTHd4QlU1R0RkelJYaXlhY0hoY1Q5MmNabklW?=
 =?utf-8?B?SHV4S0h2QW1zS1puaVE4cHlvaThoeWEwYUhkZ2dNVGpRaDlqWE1vK2NaSHlI?=
 =?utf-8?B?RDVVb1VkQ2JZOTlkUCtOTjRoWHJ5dDVBNlZuZHdESVFEc1cxaTRTeDhNYVdk?=
 =?utf-8?B?STdyQ2UxNWZaTm1zSDVhNXlJTlV5NnNmak5kdjVHYkRBNUFOd0dzZ0dyYkY2?=
 =?utf-8?B?OUtQSmFFOUFZaXp0aUxkdHdZaVBlM09jRzEyeEF3ajJYOGFQbVlOSE5hWkNa?=
 =?utf-8?B?clpvK0pRS1BMNGhzQXVTcmVkemdialpKTFAwQlpXWmdhWUZLaGtYVmFTbzFz?=
 =?utf-8?B?QjFSU3ZSYnYvNDNKSHNveVk1TWl0aCtmK1RlcDVHd2x3YktyVzFNKytqS1Bk?=
 =?utf-8?B?Nmp1d25ZYWlMTWt1TjMvSEtnOTBCVE93QXZHWldKOUVCWmExaXFFTkFqREwy?=
 =?utf-8?B?T2NuUEQvQzZHVHBQKzRPc21sVGc5OUFYZ1BNQUhzZjc4djE3ZjJCRFV2ZU9H?=
 =?utf-8?B?RlRvdThVWGxHQkNVclRybTQwY1lITURRenJLWHVmVHRCUUwvQThYSmdpbW1w?=
 =?utf-8?B?d3lZalJCM0R1ZU1wRURIZG5YV1F6dVNCMGkyY0FRUFZIMDdKaVorNzFQUFA0?=
 =?utf-8?B?L0dUcGZKZEJzSitNVDY3OERINlF4czdLNDNjbWp5UnN3YmwvdU9aY1R2Q1l4?=
 =?utf-8?B?UGdyeXR2bTZyaGVoM0Nra2N0SnNDWVlRVUpPLzBPeGZwSnl1SGNkb2ViNXhZ?=
 =?utf-8?B?ZVRLOXN0eTJsRENwQWFQT1VvWkt1L3Y0Q3d4QXNFa21DZ3MzQnhpRDJqV3ho?=
 =?utf-8?B?bXR1a2RoRkQra1k0TkpENWFrd3dFRmg3a0RQVlFOMW14UHM4ZnNtWTVJNUt5?=
 =?utf-8?B?OE9CK3AzbnlmL2t4QUU5a25VN3ppTjFTaWNvdXJqN055U3V2TUQ5SU95WldT?=
 =?utf-8?B?eXo1ckdxQzd2Q3A4MDdHb0lsZ2MxM3h6L1ZTY2tqSno2TFhEWFRKc0FBSVBZ?=
 =?utf-8?B?WWI0Y3VyRG9nSEJqUGt4Q3M2b2FncnZkVVFEYXVldC9KSUlPVGN2dGdwZ3Vt?=
 =?utf-8?B?bFZDanR2aGpULzZOdW16U3pQNkxVMFhzclRkNEM4U0hkcVhWUkV3QzNpWTgy?=
 =?utf-8?B?T282Y09kM3RwanZRNFhnYWJlcE5ZdjBwYXZHcytLTHNPUzRDaGJBQVZ6eC9Z?=
 =?utf-8?B?a25tWFUyUFVzdFZjSlRxVjA0cXUxaUNZZnduRlIzTWlnbC9mcmt6aDRuRTB5?=
 =?utf-8?Q?QxIA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26026062-2709-4641-3df4-08dbc900f68f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 19:50:17.8154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivyJlc0wjh39BcJ7D7XD9OC8m2H9ND+ZgRA2DGSdHIwXGur4aOVuiWXMpDTcGflN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8918
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On 10/9/23 12:40, Fenghua Yu wrote:
> Hi, Babu,
> 
> On 10/9/23 10:25, Borislav Petkov wrote:
>> On Tue, Oct 03, 2023 at 06:54:25PM -0500, Babu Moger wrote:
>>> rdt_enable_ctx() enables the features provided during resctrl mount.
>>>
>>> Additions to rdt_enable_ctx() are required to also modify error paths
>>> of rdt_enable_ctx() callers to ensure correct unwinding if errors
>>> are encountered after calling rdt_enable_ctx(). This is error prone.
>>>
>>> Introduce rdt_disable_ctx() to refactor the error unwinding of
>>> rdt_enable_ctx() to simplify future additions. This also simplifies
>>> cleanup in rdt_kill_sb().
>>>
>>> Remove cdp_disable_all() as it is not used anymore after the refactor.
>>
>> Do not talk about *what* the patch is doing in the commit message - that
>> should be obvious from the diff itself. Rather, concentrate on the *why*
>> it needs to be done.
>>
>> Check your whole series.
> 
> When you send the next patch set, please add the change log in each patch
> after the "---" instead of in the cover patch only. So Boris and others
> clearly know what are changed in each patch.

Sure. Will do in future.
-- 
Thanks
Babu Moger
