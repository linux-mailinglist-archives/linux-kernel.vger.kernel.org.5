Return-Path: <linux-kernel+bounces-28428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704EF82FE69
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8052D1C24152
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F7315B7;
	Wed, 17 Jan 2024 01:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="30n2s0uo"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2139.outbound.protection.outlook.com [40.107.220.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2218110E9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 01:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705455172; cv=fail; b=GAQ0St3T2DvnEM3y48cNCXOrZYaJlrAXjb8oITZ7x2OO0wslp/7sQJ2+A4ckra7aEallPCINAQxEBdfcsvwb4GN1xI/4TptgmisbC+lpvkkMCf87rDK4Qqa1jlXBdlodTi+vsv8t0H6GO2g6GXuoc8HaXLBnmnfXrRX+9IEU1kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705455172; c=relaxed/simple;
	bh=QaqHeGe9qeLfhxhEvUXUv6YdBLN9C73QPtcl1s42YOA=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=Uk0pSavgjsNLNvp/zW4hNjM6CBM/otl5mjQ6xL9Oi9H3XJaPJxD8kv7XWFJ3zyReGf5sCmgtaF0pWfn/YtDw2I2yqOE7wDEh4X/u90bziAdpIwhWGCk2jOGDyYkXv1JfFt997P++nOEO+tORUONattiZN4Igd+Ltoa8/ENad9Tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=30n2s0uo reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.220.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wiu160ebeNKMSucKnZ+D0lEEfbLgQdVp+nBdsZrj00LAKUqBbq1NeI9BwX4DAmDpYEn8b0v8VGLxU2ga+YOx0TluNXC2Ceu49xJmcyaxlFIVhCWAQSaFLioe2I3EEpjEmRhyFJDxqL2K3igzZNUh0HFeAF/RizqBr12eUm/Xve69DdMF1AnyiCACmUM96xE8wPycXzJN/0cBTudN0Qb2n8kHFdwe/NWQ56fT29IjOCcPjO3fYaYJ00v1qKIG8cFskV5NE0/d16o8dVRTfeouHN1WSOennADZyxwzfedd7FKeUN/6LqXvTeDqw54pVM7nl4nBKDiHW16TCiAE++rpug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tH0anJh1R879Ix+StffiSajUYE+k0JMPw4ZoNoc7ZCQ=;
 b=C/ajlvrbb1MzFbs9mKtiXfVgFzHVR3n0Lz2Wsv/nxArVTP5K9/5IUZRK6PhC6XNBlCQN76WJbzTwE7/ltE8aF7dyecddIgp6fVztUBxxCBJ2krsmxYL/MYmyGgwbmtDofBMNAVypgHlu7U2bRKSS+jlht1aTVFcoLCTpFiUA2yQaXdgAeY4BAdyA06rBRTPlGkvwW+/F1Tu8utmz3DiFANlvcUnz3P18A9QwiW4EK8qSlIEYDTOuI7Xnkm5bKiLMpuNm3bUO0Ss4j521L6Qcgj+SLVWAAdW7DL0n5cxltM0zMe+MN6I0sHOzIfzxa146Olx5S1g1cvRLOnGMotAz+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tH0anJh1R879Ix+StffiSajUYE+k0JMPw4ZoNoc7ZCQ=;
 b=30n2s0uo7f16Sk9TSsR6o+4A32JBBEa5Qd6umhXH4BzgcaYIvvR7qr3RdPtBoWH81FlLDrUwYMtufAyKY6Mk7y8HEQShC4h3/23mnoCA8M9m2B6XTpShQkdA2IIg0SzAe1frdj7bhxaAlXJD6hgjd2EhbRT3cKKxiNkbVrTwLVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 PH0PR01MB8045.prod.exchangelabs.com (2603:10b6:510:284::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.17; Wed, 17 Jan 2024 01:32:45 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com ([fe80::91c:92f:45a5:e68a])
 by PH0PR01MB7975.prod.exchangelabs.com ([fe80::91c:92f:45a5:e68a%6]) with
 mapi id 15.20.7159.020; Wed, 17 Jan 2024 01:32:45 +0000
Message-ID: <2414bcf0-d7d6-485e-ba68-8d13a28da8b5@amperemail.onmicrosoft.com>
Date: Wed, 17 Jan 2024 09:32:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crash_core: export vmemmap when CONFIG_SPARSEMEM_VMEMMAP
 is enabled
To: Baoquan He <bhe@redhat.com>, Huang Shijie
 <shijie@os.amperecomputing.com>, akpm@linux-foundation.org
Cc: vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, patches@amperecomputing.com
References: <20231127020727.25296-1-shijie@os.amperecomputing.com>
 <ZYO7MvpT9yWWfjO7@MiWiFi-R3L-srv>
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <ZYO7MvpT9yWWfjO7@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR05CA0002.namprd05.prod.outlook.com (2603:10b6:610::15)
 To PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|PH0PR01MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: a87b8ef0-84b1-4202-3c90-08dc16fc3497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g708WxKdPYpHSNPVbhBEPOdL3AdG45FHyIFIFPKQMm66vvgTstmSi4BRYzDtHc8LnlRoSopSBk0G8RNFcyIWvUYzeZJ6lzh71dZ5UvvumIvJDP2x8cMtXOkeW4SQ7EJh60GNB7lrT5En8+iTunkedihVvvEFsRarWv8kj0F9u+hweSuG19O/lQ1bNU7czwXHC4R2GEQij0qFxaEC/Q7kwCd+lM3sBPIYEIJQKUX9tiNsrt4VYa5GuP2xIdhhsBKN8sLxkvKyDhQivcS4txX+GjhzcE7bVgA1CAS+IvchoX0B0ufPEZ98LCh6IIxhRM9T4mUHKFQgIU89jtQcUg8+KCYFXcCd/7IdOUB9m2df/8gQ+811BBxBkaP1gO6vLaRcQiPsxwyD/0dZaFqAKb4mv49glVKiVOSiaZGCfjMfWu8knwfGTEUDEm0eZ3Uvd4VzK6QO2RH3zMLc/2IQk9a+WTgOWeu2eqHcvpp9VctUmBE6GMg3YqK2us9DbUhIPdJTpg1nbnIgasN3+3etIaoUL5boHxAsPm5IeZXf05EgAzSNebMOR9LJgOrditRn4V4lGS+KtULtHHgsJJYCceDg1bxKXE09X9T19YBePOXzQ0wtF/C9EfiUaQytAP9IeiZ4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39850400004)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(2906002)(6666004)(478600001)(5660300002)(8936002)(4744005)(6506007)(4326008)(2616005)(110136005)(26005)(6486002)(42882007)(66476007)(66556008)(31696002)(8676002)(6512007)(107886003)(38100700002)(41300700001)(66946007)(316002)(83170400001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnJmcTNXSEtwdW9SaFo1Nmkrbktud1RXakJiazBPL1dhTzdvT2ZULzZQZDdv?=
 =?utf-8?B?S0cxSkF0RVJVM1NjSVBNdzQyNDA0RGx6SjNWOHMrZ0V0TlZmWHRMT1loN2hR?=
 =?utf-8?B?aklzSEtLK0ZXNHdCT1JGV0xJS1RCblgrckR6dmpNYXVNeEQ1eE9jNm9vWFNt?=
 =?utf-8?B?THRiNTBlR1NoLzA0ek5keUt3U1VkZStsVitBdEpZUTF3dTI4TS9LRUg5REJK?=
 =?utf-8?B?THUyTHZINjNMRVllYWpIQVI2enlUdHYwblIvdUpaS1Fxbll1bVNkdTdXNGk1?=
 =?utf-8?B?NXFSRmszQ3Zna3MxMVZYUDk5YlBhZzNrSVMwN0RpVHRINTRSS1JJeDBLMUx5?=
 =?utf-8?B?THJLUUpFSHZ1VE8yOXhOTzVhR1ZqaENjZzI1dXduVDlFTWE3NWVVaUtIakd6?=
 =?utf-8?B?TVBYWVFoZzl3LzljZVl2WUZIZ3pTblJZMmh1aHJqaVR5RkNjc3FGRUd6STZ5?=
 =?utf-8?B?NnFMYlRJMmxlTTFsaVptMU5jYnEwaWlOcTYxdUsvUDlVY1MyYy9NWmtGdnNO?=
 =?utf-8?B?UmNvRzU3NCs5TGhYWGpOWnRrc2h1QnREZ3dxMHNQbkNOL0JYNVlMRWJqa0Iz?=
 =?utf-8?B?K0pISzVmNVUyVHkvRXdhZEVlNUlkNVkrN05CNUNmQUE5T1RZdy9HQzlHUlcv?=
 =?utf-8?B?VUQrVmFLSHBHVUZENGQvRTlxM25DWEFZN04vcFNKUmJVaXowa0dtN2Z5cW9v?=
 =?utf-8?B?VCtteXl6eTBoVXE2OGNpM3hYbXJvVVQvbU5hTzgrNWR6U1kzL29IZllNTFk5?=
 =?utf-8?B?OWNxRUZMTndwUi8vVCtxcDNhSlluUEt3Z0I3NFpuOWZJNlR6MEZiZ2sxYmpy?=
 =?utf-8?B?UFJQZVNFcyszKy9VRTNFOGR4WHdudFhrM216WjIxNERxek8vMms1VGhNQmhw?=
 =?utf-8?B?VHo3bmVJTGUyY3d4Vlk5NEJ3SVNtd3Azb0FzQXVCYmJBczRVcXR6NEpQTjk3?=
 =?utf-8?B?bTJxOWZzVy9JTjVJT2s1aG93WkZpL3dSN1FhQzh6YjErSU4xRGZFQmJjOE03?=
 =?utf-8?B?ZVNBS1pRODgvQ2swZWkwQUYxcEg3ZFlhUTh5NlhpK0t1bU5vdDR2czB2Y1R6?=
 =?utf-8?B?Y1B6NzlvbVdYbXJHblNXOU1iWUFkNWxITDByaDZBQmpVZzNDYkhJNTFLZkhw?=
 =?utf-8?B?UG1xQnZnWVRpaVV3d1d6RkVtQnlQL0llQ1JVcyt5Wm9Wbmw1VHlCcEVwZzFR?=
 =?utf-8?B?TWw5WC9jQk5FU0VLWmloYXNyRVZ3S2luWVdjUVFXc0x2ek5FOFViVUxlTDdF?=
 =?utf-8?B?eUJYa05Ka24zajc1cERsd0JDZzBtcCsxQVk2ckRaZGltOERvMEd6NTgzNlli?=
 =?utf-8?B?TVpsVjFzNmxGV0owTERVbXVzQUc0Q05ZMmNPR1Fqem1KN3NMUkl3WXBkb0JC?=
 =?utf-8?B?WXJ1WCtadzBUK0JOMldCc0xFVlR2YUZMNlJJSW5XdzR4WXU5bVlIek5wcTFZ?=
 =?utf-8?B?NVhTTFVjSmpsVzlQMlFzVXhGS3dVT0c4VUFYaEdmWUU5cE9WUFBTelc5b1hx?=
 =?utf-8?B?eG9XaG9ndTExREtPUk5HaWpqVm56Y3FOSFlBVjdQUDFEcUswWTc1eDBKVkNu?=
 =?utf-8?B?b2dXbldEYmhkVVVuZURENTdqNVEyd1V0ZGFVakptOW5vU01uTFpraG9lcW9Q?=
 =?utf-8?B?UDQ3UXJKWW1IQ2xHYUhuWXVwbUN5VzNxUXRWRzB0QTNrbEgwdS9yWnppaUQ4?=
 =?utf-8?B?YzFvU25xOGxUZzJBSmN1eFJrSVhWRlBPWUZMdFA2OFNPMCs2T3RqKzAyN0hO?=
 =?utf-8?B?WVYwRmg0dUN1TDVLdWdqMFduTGJHZ2IyNHhnTGJ3Q3pjcHFkZ2FjUnk4NkVY?=
 =?utf-8?B?K242N0Z2N2F4aWE4ZkFGMkhxQTQ0Wks3THdXUG5kOXZ3TVFRaCtOVjZGUThK?=
 =?utf-8?B?SHEzTFFUWi80M2tZZDhhSE9wV0lkd21wN0ozU1grVm9ldkx2ZTh2NUl1NjZY?=
 =?utf-8?B?VzlIMFNIbnl1ZGt0TEQzNGFZYk45NDZDUXd4S0YzVXBkOTZLVXpJR2ppa3Ja?=
 =?utf-8?B?eGJ2OTNjUG9CSUpGOFQwVVFxRXprZ3FEZXVKYmdOa01PblpYdGVPL2VPb09F?=
 =?utf-8?B?TUhmVFZVdGNPemlYRzUvYUhsZDlpaENya2lFa1ZzelZxTUQyVmxOeXlpaStB?=
 =?utf-8?B?UGVQK3JrOTNlVXpoTHlKbitVWlBZYzBqOTJRWkhGazFWVVZPQjcrN0wva01v?=
 =?utf-8?Q?zrlW/SX0qsbjbS6S9ViO1o0=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a87b8ef0-84b1-4202-3c90-08dc16fc3497
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 01:32:45.3653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +0/ikr0z0PWK78m/QhaPpFOA0XrSCrO2DbDL5ne3pnkh0HGNKyZl+VnivdLyHeigZ7wCz0U/vizeZS+zyOYS0CpVUwAeNV2g3zkp+Ev9eY4apqca1k8PSmdRRHoXnbL0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB8045

Hi Andrew,

在 2023/12/21 12:12, Baoquan He 写道:
> On 11/27/23 at 10:07am, Huang Shijie wrote:
>> In memory_model.h, if CONFIG_SPARSEMEM_VMEMMAP is configed,
>> kernel will use vmemmap to do the __pfn_to_page/page_to_pfn,
>> and kernel will not use the "classic sparse" to do the
>> __pfn_to_page/page_to_pfn.
>>
>> So export the vmemmap when CONFIG_SPARSEMEM_VMEMMAP is configed.
>> This makes the user applications (crash, etc) get faster
>> pfn_to_page/page_to_pfn operations too.
>>
>> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
>> ---
>>   kernel/crash_core.c | 3 +++
>>   1 file changed, 3 insertions(+)
> Ack this one as it's needed by crash utility patches.
>
> Acked-by: Baoquan He <bhe@redhat.com>

Could you please merge this patch?


Thanks

Huang Shijie


