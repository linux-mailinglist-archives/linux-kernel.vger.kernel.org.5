Return-Path: <linux-kernel+bounces-3995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D21F81766F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79D71F2541B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D067D42373;
	Mon, 18 Dec 2023 15:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eG51vCU6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A54101DB;
	Mon, 18 Dec 2023 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmtBuTw4Sa+pe6c5I9bNHudtyaB8oaTJ3dFe84r78o62Uvpx1WPB9K6Z+zkt9yxxJ/3psaTed5A8nV83E++diNRcz5Xr3sUmeUABjoACuNLMkbnNsHwplLQ2d91SZtkfayJcAjLC42sC+qJzPOnB95fUOJJ28HoKvQVw6OAPwBUUEXJbEZik9F83QBUUh9By+YN6TRbP2PJ/rAe+nqNE7Yg0mtLvfMnW7v5U5hWPKuJmuoh26cEQm+XSdmB3fWzO4p/yVJ0dkVSswu7DAHKAwaDhTzoq4GsJ9giOHxtKQfhNYuOYuUXOVO3ThaZ5nmMkh3rI3dalfWnjV6i5V/eXyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McnK7Hose1C4Kg07vIt00sTZGIzZZt+HcmUgFnQ4lsY=;
 b=aaxr0ILRL/UUu9OhzhEdEnW02P6rMVvQlzA+MH2n1QbhI489eOo6ged9FBHzbKq2mHrYAWMMkTpJ+Fd5qi3lioWDRn979fstzRhAtRhShMyvt0qY/J0win3xNE6HpQALHmiv4DDstJTZ7UK/sDlVzgxbpLiMvTtAL75WgpGEfpY8N+LXhKtWr9/sXlvq/zTMxRRclPvVXejhcdfcXNHyYpXdPA3mPUMl6WbJtAJtqFiRMOCuPI/ypQoPSATT7V6brv3kc+Nza1v6yjC6Hy9wsYbFZI+sSxmh7K3XNab3z4YzfkxmbQG6j2/ZDK1Hy8uC8xjiPIT8mLOcb1fReJZlow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McnK7Hose1C4Kg07vIt00sTZGIzZZt+HcmUgFnQ4lsY=;
 b=eG51vCU6uenmbSxfxTVR1Jmq9jk7f14bTvMwQ96LuXZr2T7l9LsOusFWwWem8VVKpMIy+IU+m4lE/us0vUbPalQZH7HPWmn6T5hg8uX2/tRcgj0+Zzts4Wt5OYqzakJJSRh3oYtcUgEToUMJ34nq5Oz01m+hu0rI+q7g5JUf9N0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 15:57:11 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::6452:1eb:50fa:311d]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::6452:1eb:50fa:311d%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 15:57:10 +0000
Message-ID: <033f4d7f-2120-4744-a4cc-5def09092c7d@amd.com>
Date: Mon, 18 Dec 2023 09:57:08 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] docs: Include simplified link titles in main page's
 index
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, Carlos Bilbao <bilbao@vt.edu>,
 Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20231211005442.95457-1-bilbao@vt.edu>
 <87o7erqxhm.fsf@meer.lwn.net>
From: Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <87o7erqxhm.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::24) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|SA1PR12MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 3981eee6-a35a-41b1-b1b0-08dbffe1fe9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MFKvDcvHlEikGtRcyUj7mO59IsAli9yjqrAIBZfF/3UmyhVSCLmO59/9sSN1FJn3um2ZFKdH0/Qtk8WGOkhg7+6T54HsrjT7GWwX4LkmkjHlKuIPxih33PVy6SPYdu+PDhvt4zLChvyJyTc9EptV7QOwtz/FtaUQ1FtMuiH1ChJUeAqWCArISigrM9tEjo71ZAUM8z+3dD4baxvb4Pgf9l25tlSpsk6XMz0LKH6T5ivE/A/cDISVA0PYcsUNKuF1tC29p9QYX+sM9indgPsBFdqZDLUbL/QA5z8GFayd7N9OspW/2sADjGeyLrpa5ejj6b6aGl9Vw0PFPVXL49fa1wWqeIUPvMmuLm2pq92WTvlnvjNMWQuDOBMp49p7dc8O/s6wqoZm19wJoT3sUhJy4Rwwqg3ejME9w51Jjs/vtYp0G1BjlKM2RdOVz2j/D6llkFdyEdLVXuiD+/RYqeK7/PlmqN0dZVRdiR3vrkL1CHJc82h2YiYmNTBvEESg54wQJLQQZGUIWk5hMiwptGM+tO1Sbtgw5kdJ4A4gaE0tNaidx1jn/c5S1ZB2gMp4twOgzlifllntbp5k5LDK8upfwJK/cXXjOswepveY5H2ve1M5W2csdx0VyQyTdbiBpCI7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(366004)(136003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(31686004)(7416002)(36756003)(2906002)(5660300002)(83380400001)(6506007)(53546011)(38100700002)(26005)(2616005)(6512007)(478600001)(66476007)(66556008)(66946007)(54906003)(6486002)(966005)(41300700001)(86362001)(4326008)(8676002)(8936002)(110136005)(31696002)(316002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cE92RmRYZ0JaTlJndWFUd29ScnBEVW50Rk9PVnBmNlpVQ0hXRlRMTGJSVzB6?=
 =?utf-8?B?Rm5SaXhpRXU3SWYzOUVneFk2NnFYVWpuWHpsU000V1QxeXhnQXRqRkpMVG5p?=
 =?utf-8?B?aEtPWkZZY0p3aUFIaXNISHVaUGFZMU9MUnhGUnMzNGZjTmgrNlJjWk1TSDgr?=
 =?utf-8?B?Vk1kYUdZR09DSFV4MG1MYnkxOHZpU2tEUWhLWU41UnJBaE9HdC91ZXA1TTVC?=
 =?utf-8?B?STNmY3UxRnNKL2lQdXQyWVVtaHBreHFjS3BuVlpXRmxGZVUxSHRpM0pUZHVy?=
 =?utf-8?B?RDQ5N2YvRWloUFQrRmNCcHc5OExUZzZIZFFTOElrS01ncktxVmYzY0d0T1VX?=
 =?utf-8?B?NlJSZjVaYW55Uzcwd1o4TTR2N3Z4M214bGtZbmNxUWNFUnU0MDJtOCtDUHlZ?=
 =?utf-8?B?bnhhbG5Yb0UrUURWVmZFRGEwVmhzZXJkS2d6TCs1YUdnUlhKMmw0cTJ6WURZ?=
 =?utf-8?B?Skg1SlhseWUxYTB1enhLWXFpZnRHSmlnNCtwUTdqUVhsNTNDeGRPaFVncHJt?=
 =?utf-8?B?eTFua2NqYnY5R0dBdmlOVEd3eG8vWG5iRlRoUFhWVm5xU3k2WVN0cjk5ZXRZ?=
 =?utf-8?B?dWJIcmNNcUpyZnJ0UW83UGNrM1Q2YUlBWmZYU2pQdXNkc1NrY1Y4b1NEWUNt?=
 =?utf-8?B?dHE2LzhzbFk1TDRaMm5oaTBGM2JVWnVUbWpjekMrWEIxWXNUQTFhSUJLWVlr?=
 =?utf-8?B?VnEvWTZVeVlML2xNcWt1THlHQ2hMMGw3ZFlwQmJoMGtsYkpFQWkvVDB3eSti?=
 =?utf-8?B?V2tjY0JXWnNVeFlqekczeWM4NU5Xek0vc00xOHhkN0p5S1lXTUJVUUhlbFVR?=
 =?utf-8?B?eXNPdlFwbEhkNUYrUE9raXRZR0pOSEk1WXlkZnRaQUlkbHAzZHlhcGZ4eG53?=
 =?utf-8?B?RkdwenpQZWRlU0tvUmRmZ1lUM3hncjN6RU13T3ZHRUh4K0Q0R0VGQ0VxMFRD?=
 =?utf-8?B?Nkd1MWh1VGtWUnBvakp1WXc4UEQ3SDFmNEpSUGpoSWZtKzRCWjNnbW1VRW03?=
 =?utf-8?B?N2FsVm0vdmdTbEhjOXFYNElETks0c0dGZ0xHSnd2KzNYT0FJQUd3R1F0aFRS?=
 =?utf-8?B?VTVSSXdrZjlRa0xFaHNwenVldndMWFFQckpzaU1aV09FZFVYUG9wUHlKWEFI?=
 =?utf-8?B?b1ByMzlyQzE0eUMrclRaR3hVQkRLTGJwS0ltKzltQzVGZUd0WURMWm9vVTI4?=
 =?utf-8?B?TlZDMjYxSHlJYUFtczFxcVJjczMwRWcyWEU2RFY1M3hFYkZSaEVpTXBNV3o4?=
 =?utf-8?B?aWd6b2NybGZqT0JubGJ2YVZIUDFsYlBxcU53WUVzV1ZFMXNXTDd1d1VKbWdV?=
 =?utf-8?B?NW1vSGpXQUpaY242aXFxVWN5U1d2MkdLak1EcG40SUxIUThEOGZjWDJIK09u?=
 =?utf-8?B?dGxIY0MyTkpOZWxTMzhORlZTV0tNUlpEY1IrMlRPQnJTOFZOOTZKcTJpbmhi?=
 =?utf-8?B?Mm16RTl1RktlOHFSZ3VoNXFOenN0Z0pCTHVMVlE0YVY2ZjNtR2xabGFjelNO?=
 =?utf-8?B?b01oQjJIYkxVQjJ6L0pCTlJkV2pLcTM3MFhpNVVMbnc2YTlUV3NjaDZKQXY3?=
 =?utf-8?B?bmZxU3Z2cEZ0aHJGTDdQMzVTZS9oMysrellSQ2NxTUw1MDRaNkgvN3FXZG1R?=
 =?utf-8?B?UHZuSVVCK1BqOUlHL1Y0bEZJdXBFNlZuMVhVOVBoQTFxNFQxMkp0djA1QnBw?=
 =?utf-8?B?bGdMTUZOK05QL2g1NFNnVUtoTXRFdEZjOTZkK1RzSzBhblRraDhpYjJoMEd0?=
 =?utf-8?B?R21FVkp5K1pDQ2c2SklCcHdmZDFjWnVDdmV6K084eEEyNHV2NlAxQit2Q29E?=
 =?utf-8?B?MExtZVJRRU9yNk1RclMxUFJFalQrYm1MR01TN21TNnk5anN5VlRJYzZBMHIx?=
 =?utf-8?B?c1FXaGUyNkQrRisveUl2eXBBYTFLYSt0OHFPOTRtUVRrQk9RN21UTUFVbEdJ?=
 =?utf-8?B?UURWUkg4ZGh1SGIvbU8xZkIwTjlZVElXODc5TmxSVHhia1pIM0dUdXpLNWNs?=
 =?utf-8?B?Uzg4OVpOaXkzREFXY2J4RVRlVzNONVBCbmV6L09FaTRBZDgvb1RhZmh0Rlls?=
 =?utf-8?B?ejBFVUVXV3NwYVJHcVFFVEVFdC9BZXYzck9zbExnSGFRRjRTRzI4dVIrS1pJ?=
 =?utf-8?Q?6LPRme0I9Sb3+euLjNAsKC/Tr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3981eee6-a35a-41b1-b1b0-08dbffe1fe9d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 15:57:10.9161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0I9c9h827gwnFCHnvdKrGhYqMURwZh74kD+Qv1Ud+YdbvIMZAMOtj2DdQpqdEHMKl+KGR1zjeM/L6mLkDRdzZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6919

On 12/15/23 09:47, Jonathan Corbet wrote:
> Carlos Bilbao <bilbao@vt.edu> writes:
> 
>> The general consensus is that the documentation's website main entry point
>> and its sidebar leave room for improvement.
>>
>> Something we can easily fix is that there's too much duplicated text.
>>
>> To that point, consider the titles "The Linux kernel user's and
>> administrator's guide" and "The Linux kernel user-space API guide." We get
>> it, it's the Linux kernel. It's assumed that everything listed pertains to
>> the Linux kernel, given the overarching title, "The Linux Kernel
>> documentation." Constant repetition of "Linux" and "kernel" (45 times
>> each), "documentation" (21 times), and "guide" (18 times) are excessive and
>> affect UX.
>>
>> I propose simplifying without altering actual document titles, the text
>> linking to these documents on the main page ("link titles"). For example,
>> "The Linux kernel user's and administrator's guide" could become "User's
>> and Administrator's Guide," and "A guide to the Kernel Development Process"
>> could be "Development Process". This is what my patch does.
> 
> So I totally agree that the sidebar can use improvement, and I agree
> that this patch makes it better.
> 
> I'm less convinced about the changes to the page itself, which I
> consider to be somewhat more important.  There, I think, the more terse
> titles are likely to be less useful for readers.  (OTOH, I think the
> result is an improvement for those reading the RST files).
> 
> I spent some time a little while back understanding how the sidebar is
> generated, and feel that we can make it into what we want it to be.  But
> I don't think we've decided what we really want it to be.  I think there
> is simply too much stuff there in general; it's never going to be
> manageable that way.
> 
> There was a suggestion at the kernel-summit session to just put the
> top-level books there:
> 
> 	Kernel documentation
>          Development-process guide
>          Core API manual
>          Driver API manual
>          User-space API manual
>          Maintainer guide
>          Documentation guide
> 
> Then perhaps add one level for whichever book is open (if any) at the
> time.

I like this idea; as of today, we have too many duplicated links.

Regarding the addition of concise titles for the link titles, I'd argue
that the important part is not to lose information. For example, I
shortened "Submitting patches: the essential guide to getting your code
into the kernel" to "Submitting patches". But, if I had simply put
"Patches", it would have made it unclear what the document was actually
about.

> 
> I'm sure there are other, better ideas as well.
> 
> Meanwhile, I'm pondering on this patch, would like to know what others
> think.  Carlos nicely put up some comparison images for us:
> 
>    https://github.com/Zildj1an/linux-kernel-docs-compare/blob/main/comparison.png
> 
> ...so it's not necessary to build the docs to see the results.
> 
> Thanks,
> 
> jon
> 

Thanks,
Carlos

