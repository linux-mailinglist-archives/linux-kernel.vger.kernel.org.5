Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC937E9554
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 04:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjKMDKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 22:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKMDKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 22:10:02 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2124.outbound.protection.outlook.com [40.107.215.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660AF1704
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 19:09:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ms4M6vL7dDAPKAU5PoNpw7ZpdjtOYgaETJ//433e5bOZ4DuWzZqBTahGoSuUPVVh10radKiVTKPv/FZFk5lxMi+CgUyPMS6LxQ4q3g+CI7Z9No8T/bZXrjHtZWkPhcPtyWEr69DPsBUcU63dNSXN6HR1dzzAAmeaPAiQYJijGNhQjWxHeyxbnAehDsUhZ4l5RX0B8HESaQmAywD8xba2tv0+A1ueNtlT23vL4BETVOnv3vLqGB1aYwhoCp4CaPyi4JQVR4GW0ofn+ai2diejBRBR5TN30ouc9UbH3zwuvh4Ox96f+n6G2bdVp8y/mu4c4HFGaUdWeVwWBccQ1SczYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtqVfOfP85piVbaiHYNCyl+B4ttRK0z8pLTBuP/N9n0=;
 b=jJG0eNsElAhxL5zaLrJOs3zRRYEA8OPiuX/H9+WyWyoPIwJI6zI5WjU8x7G4HHzIvRRT6GdEkyOYTmp2CFAeQp6YpmuUTK02Uhwkrt7ClnmspqilcLZbYdqmckiRzb/4KxdtXmRt1PphF56nzugGWvue6ZjiQ+NUqvSkkE3DlEfTfjJOZ7u0fpXQhdRaSqHDLreiuu8A6E1ViSue8VyFZtqT8gO9QAmW3iwWUuRan6mBL+XanwRZ8SwvT/2nYhKikPrezUTIILTp1lN3l1ZLzQyJDhP74hoXFmj/8Or71tfP2PvVJLoedQLUEMFPFPhS4WP4XQJ+Ri/t3CYHLRkE/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtqVfOfP85piVbaiHYNCyl+B4ttRK0z8pLTBuP/N9n0=;
 b=oDvL17biHPWyDz9pMI8s8fOjLNFayNuoFM6Fm6HMwcJSB1ruaMit7/qmvUHz7S9Ank0LtajtZYPt3A3eEevHfYZK1ByOMloYB2IU3lcg6TrPC1X2ARqf+DMblwl/3C1SC92a1JhF8gqks14o927KtlIhGhllVGmMdQL59c4egUB4CwRbPQY/xbRTHCY3HzDo4o2oxYZW1lIVfsRSgs4gZTJ1biTKkEQ8DSFnTLAYnu1dNKDP31UaWDd00u+K1faETSGG6i0UWS2yZ6DtXb6e9A1ILP6TkhrFC4NtUbEB5RVmJhucKR7n1eUTPcgR/hKcSZRwykK8v/FBgx4/Qa1Bdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TY0PR06MB5053.apcprd06.prod.outlook.com (2603:1096:400:1be::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.37; Mon, 13 Nov
 2023 03:09:50 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb%4]) with mapi id 15.20.6954.027; Mon, 13 Nov 2023
 03:09:50 +0000
Message-ID: <ca0eb68d-e9cb-4d07-a592-b9bb2d3f033c@vivo.com>
Date:   Mon, 13 Nov 2023 11:09:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm: ALLOC_HIGHATOMIC flag allocation issue
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        opensource.kernel@vivo.com
References: <20231109073133.792-1-justinjiang@vivo.com>
 <20231109073133.792-2-justinjiang@vivo.com>
 <20231109094954.dd4b2a5b1f5dfcc9a721edba@linux-foundation.org>
 <ZU8eRWQvk/Mm4VHO@casper.infradead.org>
 <4911abfc-081f-4d3f-aa15-73c617a81c36@vivo.com>
 <ZVF9h6M6dK5AZDg7@casper.infradead.org>
From:   zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <ZVF9h6M6dK5AZDg7@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TY0PR06MB5053:EE_
X-MS-Office365-Filtering-Correlation-Id: 66301273-dcb2-485a-1d2d-08dbe3f5ffe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xGIl6aJ4wmysbMiwYsHZSOAmG4LeVojItWbujTp0u0S5v4F8tX0X2k09jxc6SXIWZby/rRyq0DRq4//5t5SzZ7RxN0jR7vD/ykmErwJeLacJuL9fWitTTUN8CUIfO+mXji3UrT40iG+fTMP/p23WM6bKHuvfOtfWzgsmqyvGhZVI8M9TvYAmgG4Q103Hhpn4+gSLsZ250dfuTHKP9zzCkE3g85ruypREotot7C043c9kcW8JdkBTblR39TcxF9y/ap1hE6A8WdGUO3mR8XbB8kh3vkD9IWpPOejlCuKCTSMIHBimLxQMEy7nktCGytoTJkaOMX8zwKvCUsjOzbVkUNk+wG/USDQAmFe1cTmDKwb0V0y5szUAN5je3NO3+j7CpeRorip9ObcsgiAnR/3x6cY26aegPlA822BRBaGJG/HcxGO5S6TwxjiZFQsOvaN44BWqwvIFM/A6Yy9KUxOwvkt/LPgYwPVgDJ2WsXC8THSbJuw2oFyGBZogie9VqV8JXtgZ3PuG6K1aR/CetvSNb1lS1whttIIMh623AcYeR8w8wq0dNfczB6xP/IbVt/yBHEVILt6EdbWYyx12AsVdxA9kJmpy6lB9L6f0RMe4W6KPTP1MtTQVXrk7HbP3hbOH+qZfvhprq5vo4Sr+IHFXlXsGS+7ukiELbcJgIwcU046mke+bft8shEzDG+8RJpxc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(366004)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2906002)(83380400001)(38100700002)(38350700005)(86362001)(31696002)(36756003)(6666004)(4326008)(8676002)(8936002)(6486002)(966005)(478600001)(45080400002)(52116002)(6506007)(31686004)(41300700001)(66556008)(66946007)(66476007)(316002)(54906003)(6916009)(107886003)(5660300002)(2616005)(6512007)(26005)(43062005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?em52NllGUTBmZTNoemlMRmlEcGJzNlBuTzNZUWJUTTV4cXEray9PL1A1em5B?=
 =?utf-8?B?bFViVEh5M2dOTlJSZTlod2t5ZTVyWW9sNTdkbnNqZVowajhHUmpkQit2cnV6?=
 =?utf-8?B?SW5DblZzaVRvUEsvNFZEQ1FqbktYRXFJMG9hZU9mZlFoQm10STRxaFcxczJi?=
 =?utf-8?B?RzYvT2YrMG9kcTFIWTVxSlpEbmJUYW5EUG9KY016R3N6aFNNVFdRV29zSlJZ?=
 =?utf-8?B?QmxPY0FOd1J0K1VaYitoMjNBb1pLenpmOXQvOUU4WDIySUxydHdtMnVkL3Nx?=
 =?utf-8?B?UUpmWGRsM2kxN2hpWnJxYXlnaVpJL0k4YmJkdWFSN0dkNGtEZmZlVnpGWUNu?=
 =?utf-8?B?ejRWdDE1Y1NEa1FOV0JSTyt5dm41akFLa1krRkhLeVpVNHJYVmJBQkNDZXMx?=
 =?utf-8?B?THYyN2dkVGQyOEluaHczdjJPN0MwQzQvSGFmSmVpZ2RKaHJvTmtkWStLblRL?=
 =?utf-8?B?b1RKNW52SGxuMmY5T3VEVXdwdjlwL1Nnc0lqUHlYaSthYnZYd1RydWtrNmIw?=
 =?utf-8?B?NkVUeE05KzdtRnlsZjNZYmtmL0ZkbThOYXVPaDBJOExaRkZPOHdUMVdmKy9l?=
 =?utf-8?B?MkR0MTVYcDN6d0tabXBucnlsZ0RQbGdDN2lCbXV6TmoreC82enJ1QlNTMUZ5?=
 =?utf-8?B?WnFKRmV2UXhtT3JKNmFLdXdRM1drVlBFS1dGWGdjQWdmS1Y4ZkN5K1ZXMDRr?=
 =?utf-8?B?a3pzdmI1RWwvSVJYcVBFQk9NTGpIMUxUSVR4bktkMjVMdHA2TFR4SkExOUtl?=
 =?utf-8?B?d08rSjZ3VDlTWlhSaWJXQzlPQUVoS3gvTUFjT1N0Rlc2cTdReWh4b05TbnlO?=
 =?utf-8?B?Y3A1by9DOWVUSyszb0x2N1BUWW85d1MzQnV2cFA5UFFFSGpkYU4xTjlHeXp3?=
 =?utf-8?B?V3ExeStNV2FKaUFoTnUyaURCWTI2Tmx5ekI0RE1EOCtuRGczTjB0TG8wU3BQ?=
 =?utf-8?B?UGdKMVJsODVGUkRBRDZhQ0tLWEJQb05GQVVCS2xWM1BoVUxrdnZKSGZlYWJB?=
 =?utf-8?B?RWlhSWRyaVhpemZwbXRDTUNMY3M0cGRGYUdkK0J4eElOYUFuQjNsUGE1bmli?=
 =?utf-8?B?dkVyS1JwLzEzTUxtU0VDbjdLb2M5RFlQOXg1WWZYOUtYM2ZGVzI2U1ZiVjVu?=
 =?utf-8?B?WFJwRTBRVHNKZi92aW1BODEwMjl1VXdMbWZGdlN2NXlSa1ZwNVV1ZnNIYlA1?=
 =?utf-8?B?djB1VmhQSFlGbkdQekUzTW9qUkExQ282WFovUVMyd3NkWm5sSDlra2R4S21u?=
 =?utf-8?B?dWZzODhHa0diOENYbk5BSjl0cHZwQWFyY1p4eGYvTUlNekEyQ3VEUHhXSndV?=
 =?utf-8?B?WTRpcFNjOE1MZk4yZTdaSkJDcElwL1hLaTNhUVBoRE1iZHFPVlZ4ZDlINU1B?=
 =?utf-8?B?dXhmQ1FNMFNmak55UHJGTy8zOHhMTkRYakRjKzRydXh0Sk1mS0xhaFpQbmda?=
 =?utf-8?B?ZzBlYTg4TG5sdTNiQVN6WHNMUldUVHl4Tkl1T0hSRFh0NXhVODRYYUFYRWpx?=
 =?utf-8?B?RFhYZmtNT05NWmpOQkRaSi9jYlFEZDV6M0Z2cXZlQXBXK2JEdlJ3MWVUUkoy?=
 =?utf-8?B?aGFzbjFWRHd4K0FLQUI5cGtVQlBzc2lXZlpFWjRVT1JZZzZZYWNodHVQdDV1?=
 =?utf-8?B?YkthQkdNQ3h3SjFGelc4Vk9ia05RSC9nSE1DS2FPUUVrdHEyekc3MUZtYzF6?=
 =?utf-8?B?ZWkrV2EwTWlkL0VrYUdKU3E3NENUbEJxcTRNS2EwZy9rOTZ6Q1JySTVoR25B?=
 =?utf-8?B?WEpsSko3aUlLWDhOR0pnN1FQMW83b2hGMnVqZkQ4VjZlTk1aQnZEY1ZzZmRo?=
 =?utf-8?B?RXNXSGxaeG9hdHB4cXlkZ0VIQTRnZnV6cXZCeHpmcHZ0dzM2N3h3a2RBNXYr?=
 =?utf-8?B?NStlVCtvdDZhM2pxVlpTaWh4Mm9VQlJCMHgrUWt2ejJQWnlVTjFoUTU1WUJJ?=
 =?utf-8?B?aFJ2UCtlK3I1dTZTOHU1bFppMC9nQ0hDL0wvbFNCbkk4ZTZ2TFNOTGo5dVVJ?=
 =?utf-8?B?dWxRa1djWm9GR3oxL2psWGpkWlJuQUg1dks4czBPVnhwcXVES0VNVHRydWg1?=
 =?utf-8?B?N1Q5RXdRbkhBODMxa0MzMlE5cXhNRG91N3lVZ0N2NnZtSGFDQ25XUGoyUTJ1?=
 =?utf-8?Q?BOvujXp6uo15fVOKZkXX0itsm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66301273-dcb2-485a-1d2d-08dbe3f5ffe8
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 03:09:50.4133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8f2eDdxEJUbiRwl0VYatICVxxkEm0edF741g7LHm/3vHEaybm4etv+LN5Ujno3Zkn9XiB3F+wInTbrjCMqhh7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5053
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/11/13 9:36, Matthew Wilcox 写道:
> On Mon, Nov 13, 2023 at 09:04:49AM +0800, zhiguojiang wrote:
>>
>> 在 2023/11/11 14:25, Matthew Wilcox 写道:
>>> On Thu, Nov 09, 2023 at 09:49:54AM -0800, Andrew Morton wrote:
>>>> On Thu,  9 Nov 2023 15:31:33 +0800 Zhiguo Jiang <justinjiang@vivo.com> wrote:
>>>>
>>>>> Add a new bool* argument to pass return flag instead of *alloc_flags
>>>>> and add the related comments.
>>>> Please retain (and update) the changelog with each version of a patch.
>>>>
>>>> For reviewers (please), here's the v1 changelog:
>>> This patch isn't diffed against the current tree.  It can't be reviewed.
>> patch v1:
>> https://lore.kernel.org/all/20231108065408.1861-1-justinjiang@vivo.com/
>> patch v2:
>> https://lore.kernel.org/all/20231109073133.792-2-justinjiang@vivo.com/
>> patch v3:
>> https://lore.kernel.org/all/20231110020840.1031-1-justinjiang@vivo.com/
> None of those are diffed against the current tree.  You need to send a
> patch that applies cleanly to either linux-next or current Linus head.
> Not a patch on top of an earlier version of your patch.
Modification has been made based on today's latest patch from 
linux-next, thanks.
Patch:
https://lore.kernel.org/all/20231113030343.1984-1-justinjiang@vivo.com/

