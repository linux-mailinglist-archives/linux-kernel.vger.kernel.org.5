Return-Path: <linux-kernel+bounces-6250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 457A7819659
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F2C9281BB9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ACA8489;
	Wed, 20 Dec 2023 01:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qwr4nrh2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E20168A4;
	Wed, 20 Dec 2023 01:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7AhqBw1D4QX60NfLBBF96rjXjZiabPXfvUO6n/0dckE0JF9RwoSQotCnUXa4VC0L2XFHtf/54dazPKeEOM0Bgy8S56Y2bIUv5flc/zOvXWfDSbcpU3kyT6UrZmvt1NWTlZ/TbHp678SdpgPjnB5OY/pbFaXJt3eOar6fqOh5/BZuKvCznzOkOH++1UQemXvbu8+2xyH6w+R/8/01Xhw23YK2WdCdkO7iMziQRhRy6lz4S4/1QAeMwFbx/OLE6FpRbn3T2oCIJaSDdLk98m6UhPRepwuuUu8NFTKTK6ljVBfmDFMtE1Br36B7gNhRf3xzh/3C1FdQoLiAuAQVt6E6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vViIh5bjIKqZD50p6AVZQFctzXPODrrL9f0mOg+GB8U=;
 b=llGJN50DDMWjzWNuLH4oPBHZXh55h+Z+sO1dqDVoCTe0wemvu9/9sz1MDTnb4X0PnDXmmH/mMLA26yvafPHf/i0piGyV4e+fiXxSYm7IU9ESJSPF7ePdt4Ufhs4GP1TdfE8oVhSNWljpMzRlZ48Ha2EbBOez+9g3sTZ+wSHd7HWQcArrrNCX6A7/EOvIodvo7jzF2ilC1+bXVzKoPp37gnRXO0gtnl3BclQbUA+SKNkfWzmi7Id/e2zYkwiWu+SjbTU9GvbJLhrq/anxuA7CO7P0BranoZPh6VZMrkJvT+6FbiCZJ9Jt+uDILtVAKHYH3rrY/p+9fpI0zy79SCUVCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vViIh5bjIKqZD50p6AVZQFctzXPODrrL9f0mOg+GB8U=;
 b=qwr4nrh2gihCbel3wEUQsF8qgsAibaL8vqEIRrmKdZ40tIY9XpSfs9DfIyG+nPz0uieI2YDg7oFCvOppZ7dTUs7cTIRpPQ2WlpMQ8WjvFyVqASiWNsx423+vWKTnLlz10JL7EsmX7KIzbG4wnVfVZ/sly2ah1SnzrxZuT+B9Zuk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SJ0PR12MB6832.namprd12.prod.outlook.com (2603:10b6:a03:47e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Wed, 20 Dec
 2023 01:32:22 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c%2]) with mapi id 15.20.7091.028; Wed, 20 Dec 2023
 01:32:22 +0000
Message-ID: <bd95de9e-1dcc-4fbd-ba47-9d33c8bdc6fa@amd.com>
Date: Tue, 19 Dec 2023 17:32:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v5 iwl-next] i40e: Use correct buffer
 size in i40e_dbg_command_read
Content-Language: en-US
To: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>,
 Kunwu Chan <chentao@kylinos.cn>,
 "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>,
 "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>
Cc: Kunwu Chan <kunwu.chan@hotmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 Simon Horman <horms@kernel.org>
References: <20231208031950.47410-1-chentao@kylinos.cn>
 <BL0PR11MB31226B042632413AB8C12D63BD90A@BL0PR11MB3122.namprd11.prod.outlook.com>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <BL0PR11MB31226B042632413AB8C12D63BD90A@BL0PR11MB3122.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::21) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SJ0PR12MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 3da65ac9-26b2-4bb1-5750-08dc00fb832d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NdwGdWlBI975jjGG+kmirrucUWrQQFFj78y3yl7PTxTuyKitcGQrfquv9YSW9n18v5jJdXOxwH4+2fpIpBYOS11n7HcLTqW+o5573JTmkkg/Q+m9kST5SBmARtEk2cXwj8/tqSWq9CprzT7sKaEjLTKolzGzAGHiUSbII1yf0gdx9gY6VJO+kkJ+L80V8Y6CAUmV1CogFJdrp1fPVoHy/0s6nLoP5WWxkbqsijPSxPq+PCSjndFkugTy6LGjUI19K0iZn85L89MyJQFBT+vACYS1hK6Pq+SXE+LQCAXwQ6SkkLAYfsesMm4epxTAaJr/FqErDBv6ZmcBi79gO+4MopdzXmAxXVOUSy/OKLYwqxduAeVpmw8+UvhtGdTWrKK1EPtUqnzUOoDv2OqkuRm09QFdxIeJV4cBiSC8/7t9x/3A6/D9YDXyRi/hkX8VHX/cbdwYTzcwz6owJOJk5vtneqTHkxkIQ+AY0JF72J5EmskMed61ZYQNm11Zc73NnJOVMzQxdhe8oG6+R58XxwbZFQx70+Uw0n4W7SLMBVwzZl8FMxbqtO3AT5hJbPQd9iO9ZVM55ghtuYxt4SKaxGvP0+POm+gE1jGY2f1P7Ie3IW7ZGPR5nZ6U5GgAdbPcDhvnyyQ5EzhVVUuE/8ZN3SPlE4jjAQfqshjV7s7oRyPfrqo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(396003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(5660300002)(4326008)(8676002)(8936002)(2906002)(38100700002)(53546011)(6666004)(45080400002)(54906003)(316002)(66556008)(83380400001)(6512007)(110136005)(66476007)(7416002)(66946007)(478600001)(26005)(41300700001)(6506007)(31686004)(6486002)(86362001)(2616005)(31696002)(921008)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlFKSjY2ZVhIZVExSVQ3T2ozdTFnVWppKzVPU3Y2VERrNU92UDh5OXJCNmdY?=
 =?utf-8?B?VTkzRUhweU54Sm9XcEF5eUhoNnVUc1pES0x6VWhaQWZhSTd5MEJ1OGlVZFdK?=
 =?utf-8?B?anJpN2Npd3BUbDJITm52YkpOMm5xSXdYOWdtNzdTL0U1MmsvZS9ncmdqWC9h?=
 =?utf-8?B?OFVKOGx6ZlF5ejk5M1Q2Wi93UTh0MDFDNEVyeVd1MzBjd0JTVGpZOGJjM0dn?=
 =?utf-8?B?RkMzUzdmZDlvK09haThTTGxKRXgyNWZsbTh6Ykh4ZFdMZ0pNYnFVTGFkc2hu?=
 =?utf-8?B?NTcvdkU1eUtaT1doeDlOY0kzZ1pFdHo4NkxnQzV1UXJUeS8vTXg5WGR3YVg4?=
 =?utf-8?B?UmZCUGs5U2xwRTZTZERuWTJ3a1VBY3cyRGNManVQbUxCV3h1R3ZyNWVUUW02?=
 =?utf-8?B?enN4R2RhZE51eERmMFdtcVdvS2srakR4b3psVis2VmRpSU5sVXZRbFlqSlg5?=
 =?utf-8?B?dkdTczZSODNKZEh3dDl3UTV1TEFBb2djTTVwL2JhUzQ1a0h6T3VoM1BXamRG?=
 =?utf-8?B?TXEvbkF5N2pzbEJ3T3hRSnpGa0x3dEhPc2ltMldwayt5ME83VWg0Rk12VmNo?=
 =?utf-8?B?MEloSjdUcjRoaWNVcnVqaEdsZk5WYU9rT2g2T3dacHlCSHdQYWViOFgxMVAw?=
 =?utf-8?B?Vm8vdldtNkxaNGI1Ui9CcHl2Q3d2QUhUT1E5SWJDVzJMWThZdEpNOUZ3QmJP?=
 =?utf-8?B?OUJNZzFpN056NmZoalFEcE9ZbW1UWkFmVHByVUVLazNVekVXVnZzT1h0UWh3?=
 =?utf-8?B?aUU4RUJ4MXNwRXFBSzFxODVNVjI2TDNaQnh2ZXV3aEM4SmhabnZ2YkI1V0d3?=
 =?utf-8?B?aDA4alB5a21LWVdkbDJLbi9YeFZJdjVpaStqay96TnJuam5YeFk1WldldVhG?=
 =?utf-8?B?bkNRb01tMkttanB6RjFvNXg3Nnk5OU9XbG5iYVRnMnlJeWg1L28xSEVrZ0My?=
 =?utf-8?B?YmJtR0lkc3lrbjdTQW5rdGZtamE5dms2elBULzFkc0o5V3JuazZXRjA1VDFS?=
 =?utf-8?B?eVRnMDRQSUtCRzZBaUZKMWdlN2VLOEpORE9BdDBvTVBvUTFtbGxXMXFwc2ZP?=
 =?utf-8?B?cGZZME5FandQZUhOVjRXVG0zN1N0MVZ4bDhENmdTK2M4aGRLQVhUZzVpVUk4?=
 =?utf-8?B?ODV0dTIvbVZlQTZJQW1wc2k4QmJBU0pidFl4T3lJZ2dIK3BkbDBqWUZOejhj?=
 =?utf-8?B?OGU3cm9HNVZRbFpyVjJzRnRxVFZVR2o3UG9DQVplb2E1ZW52czhzSzlHMS9r?=
 =?utf-8?B?SC9NM0w0L1VwWUhaUTJTVEVQcWVkSFBsMFFjeHZuQnNjT0M4OTNzcXhqT09J?=
 =?utf-8?B?THNoRlBvcVMrcHJqUnNoMGtONXlNdVlWYk5DUjc0UFdXWG9iRmpDSzExRW1N?=
 =?utf-8?B?aXJFRWMwV2hEM010NmNjNm5iWDI4RCt6YUdNZmVrMkM5d0JGUkxwUDJKdzho?=
 =?utf-8?B?UUZsVCtIdnZnMFRxaUU4cUxtaXZNQlY1cDM0Z1grcTRPR1B2UUc0bXhKOSsw?=
 =?utf-8?B?V1puTXBmUzI3a3o5Tk1CcldFR09aYzJZTUFkZmZQcXlHbXFrWE9waUJkUCts?=
 =?utf-8?B?WFJXUHFmN3ZZRis0SFY3bU5JeHI1SHdxQzFvR2J4VVY2SHFnQ1FzRHJwYnNH?=
 =?utf-8?B?S0ZQSzUxMHowaWFpdW9FRmVrVmtad2k4Q3gwNHZmRHcrcmFhSVJJUFlJWS9B?=
 =?utf-8?B?a09aRWJicCtJeCtZSVFzdS9Bdzd0R2dMT29iZ1lBZVlnSHArUWFTbEVucDFv?=
 =?utf-8?B?VTNkM1BxekhvV3hKKzZSR1VhZTdHRkMwcHh0YzhMZkZJbXZFR0lXNWVvSjhu?=
 =?utf-8?B?MXp5V1o0cnJ3aEdYY1JlMDFRbGpLZndWSTZxc1BBLzRCdWlSeTNMTVR2clNt?=
 =?utf-8?B?bm1XanVCbzdqaklrbExkMGZyU2RaMitiSzNyQklndlpWNUZSVzRiSzFkR1Fa?=
 =?utf-8?B?anV3dWczc0hoeXhacG02Z2ovaVBrTFVGaE95djhHMnNTQ05vNnhuODRwYUlU?=
 =?utf-8?B?SU9oYzZTRkZFcSswSUxpL3FpeXlwdERlcExxSGhBZlc5Qkt1Ym5lWGdVMzUx?=
 =?utf-8?B?Yk82SG9UQWdWdUhQSVhKZlBuRWFhZXB3Y21mektuL3JtZnhHTUVrWGE5NnpP?=
 =?utf-8?Q?B1p9iFYl5jCGgNlubrEETxDxe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da65ac9-26b2-4bb1-5750-08dc00fb832d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 01:32:21.8727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1urudOeTZ5tT+7EtehcTqQjeZbe7FUQtQTRmaqU7uc1Ru+Zw25TkksLqs5iuJubY0+IkdfZ9f4TE1Pdp/6/E5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6832

On 12/17/2023 9:54 PM, Pucha, HimasekharX Reddy wrote:
> 
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Kunwu Chan
>> Sent: Friday, December 8, 2023 8:50 AM
>> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; davem@davemloft.net; edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; jeffrey.t.kirsher@intel.com; shannon.nelson@amd.com
>> Cc: Kunwu Chan <chentao@kylinos.cn>; Kunwu Chan <kunwu.chan@hotmail.com>; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Lobakin, Aleksander <aleksander.lobakin@intel.com>; intel-wired-lan@lists.osuosl.org; Simon Horman <horms@kernel.org>
>> Subject: [Intel-wired-lan] [PATCH v5 iwl-next] i40e: Use correct buffer size in i40e_dbg_command_read
>>
>> The size of "i40e_dbg_command_buf" is 256, the size of "name"
>> depends on "IFNAMSIZ", plus a null character and format size,
>> the total size is more than 256.
>>
>> Improve readability and maintainability by replacing a hardcoded string
>> allocation and formatting by the use of the kasprintf() helper.
>>
>> Fixes: 02e9c290814c ("i40e: debugfs interface")
>> Suggested-by: Simon Horman <horms@kernel.org>
>> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Suggested-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>> Cc: Kunwu Chan <kunwu.chan@hotmail.com>
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> ---
>> v2
>>     - Update the size calculation with IFNAMSIZ and sizeof(i40e_dbg_command_buf)
>> v3
>>     - Use kasprintf to improve readability and maintainability
>> v4
>>     - Fix memory leak in error path
>> v5
>>     - Change the order of labels
>> ---
>>   .../net/ethernet/intel/i40e/i40e_debugfs.c    | 20 ++++++++++---------
>>   1 file changed, 11 insertions(+), 9 deletions(-)
>>
> 
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> 

Much of this debugfs command code was an early driver hack that probably 
never should have gone upstream in the form that it did.  The 
i40e_dbg_command_buf itself was originally meant as a scratchpad to put 
the 'last command processed', which was not really very useful, and as a 
static global that might be written by any number of instances of i40e 
devices, was problematic from the beginning.  Now, unless I'm mistaken, 
it looks like nothing is writing to the buffer at all anymore, so the 
buffer and the i40e_dbg_command_read() callback probably should just all 
go away rather than trying to pretty up some useless code.

sln

