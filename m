Return-Path: <linux-kernel+bounces-23058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A23682A6F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 05:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41D11F234AF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77086184D;
	Thu, 11 Jan 2024 04:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lddoSxa1"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66E71110
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 04:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOjlb4urmneg7nAGab7gxPgkkbvQQhirinJgp981E5Bo+bUkaIFawpWNjffu7b9ATtEAFeNTCSoegKfgZhaLTFfTZ+Fz1QUdD3KtoB3hndjl793GrM+S1KZMQ/y/qE8+5LHqvgU/YlDdmHivm5La6arL7fKA2bLpWjrQxGb8Ta+QcMY5s+6js/X+kcLeOvit+GGojkpF5DXAA0V4T+9IFRKo3zbaLkgMVf3wQlCWDvYfZcvclYRIQV0WRaQrnMlas6vr+Mk5JMeyqNZOxwd5t8yhrkpKFZ4O1PgaNHd7Q2iDK9uSDk3TgbPW1R5lIX2xbaToN8A6BlD6Bn0ikbK8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8i9GvkTVqjEDGk+RrquTEtHE4BCFBvWC7y6ERq5CR0=;
 b=CKMrVxQWXqXRu51GwiNu1Bfxjm0rM0WSOeqBrtaXWQ56KCaXQsCrCAW8gXwTXodm4lerTU4M4KxG+qdvMJUTOByLF4zQUrz51Np4vjR8Zzpyi0Yxz/tl9joejDInbGA7+PqclVPrap8CjoVT7CCJOfIlcSw7tC16DLuF5aKju6EF/6pG7gxTlDFaHzosbHJs/eTH7RNErxthOqO0ZXeuS8rmk8iG426PsiBQ8UngDhZigEbeWOznMiOFq0lI24MuA104iygljIGt/ScHX24Hs4KctC8X/F/BS22plI2PQ9eqDnG3FiMqVCIJpmGqbeQiFwPm0+0BQQw47/cSY1gCgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=zytor.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8i9GvkTVqjEDGk+RrquTEtHE4BCFBvWC7y6ERq5CR0=;
 b=lddoSxa1v2fTvOMf0JWDGloBHjVTIXwu5k9ncJDHg62i3HGRSsXN7QAMVl7qttgIqs/sXlRdP1LxJqyGdbgOYwUtZ5F16EyJGl8yj548Gzj6zqSS5vApIgRouaiZ7HZO50PWF8sYI+3UIKoigQgvz4di325UNwYpFVfrasHsiYrWtDmuEJlRC9TH++2dgSQm0/bIM2IbOPNLuD6j/Ays7D2bRdNBuawT1ayEUMpvGeREDvWikKe3aPeM6Z1kdbMeqpvpJmvL0MBAAJ8QSCvu4ocrB6vj2pymT9S9553zJWL2LWEyi3MHOwxMREcNQ6YSefPGNuZw/YuXSscZm4lhcQ==
Received: from SN6PR2101CA0001.namprd21.prod.outlook.com
 (2603:10b6:805:106::11) by SA1PR12MB8162.namprd12.prod.outlook.com
 (2603:10b6:806:33a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 04:24:24 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:805:106:cafe::14) by SN6PR2101CA0001.outlook.office365.com
 (2603:10b6:805:106::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.12 via Frontend
 Transport; Thu, 11 Jan 2024 04:24:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Thu, 11 Jan 2024 04:24:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 10 Jan
 2024 20:24:11 -0800
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 10 Jan
 2024 20:24:10 -0800
Message-ID: <de221edb-6d12-4bef-97a7-4ab4c2381bfc@nvidia.com>
Date: Wed, 10 Jan 2024 20:24:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
Content-Language: en-US
To: "H. Peter Anvin" <hpa@zytor.com>, David Howells <dhowells@redhat.com>,
	<linux-kernel@vger.kernel.org>, <pinskia@gmail.com>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
 <3465e0c6-f5b2-4c42-95eb-29361481f805@zytor.com>
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <3465e0c6-f5b2-4c42-95eb-29361481f805@zytor.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|SA1PR12MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: b4ae17ee-6888-4efe-94c8-08dc125d3126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jqI8XKyi9l4TtzBPL2RwU5y4eqD/mcbtRev4e5zaKjtUtEN3qgAJbeOLtVdPTJmFhWR4X+tRmL8StPk5QZxq8i5E4O3gxyDDAgAERhqIvg2fDv7aDuQlh53BlOu5XQ+SK62nlrZFWXPjaEltwSM8r45asBItEpHnOf2t3tSVXL1ItVpPCk5ZKUOG4tjJEzNJETyFYHkd5FUp0jDeaxCcFuJg1W6I0MyLMxMZncUVSFgQ/l563Sawl/2vdbH2froQpQYN5115K3NA99lfLON8kOiYX0JMKNc06gXqyITYi0Kv7Y4lXTj1rqHLMqjVD6dcg7w/ODdA5fA0VTU555lv0DOVUX9TS6LQ53XF99+aYSIgiLuleEaacbvwEaCVyUZR+R0HMtce5wP9H0cUlax/pTdOR/C1uCWs/3u9tHTkY0wUKlj8jcaTOrd/AFUfOyuJItfLVFWHsWS94ZDeAJgTo3D8DHRn0ocdDCvd9wtVNnQEUqrU6UKPaezv92ZfaNvwkUmykppOQo17sy6JgwQlgjMKBHzoxNdjHujZNNzj57WrUdNPpaWDFry1yJV7YUGHkp0zRSzkawyAlurmrc65oweqEr96CbsTKfe1Ny3gnyX1IFOJTN0IY64iMz8mRR5Pn8Pl9uRaf8RqMwyrdQiVFSCRbX9lGXkHm6bOifqlMrtpNevfMrLDdeCfiALj3oigJJMBHwd4uvV/Vn4tyny5CHLWGT7F4Be1P/3MHXyVkpjYUfaOsESLGKAnFM5JHC5/D2DEaxXIgAhEdErnxwPqv8Of0BoeK9W0Tq7CUYybOOKRlk+0s5JqH7pMYxhKw7il
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(478600001)(16576012)(53546011)(8936002)(8676002)(70586007)(966005)(316002)(2616005)(110136005)(47076005)(36860700001)(70206006)(83380400001)(26005)(336012)(16526019)(5660300002)(2906002)(41300700001)(426003)(36756003)(82740400003)(7636003)(356005)(31696002)(86362001)(40480700001)(31686004)(40460700003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 04:24:24.4232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ae17ee-6888-4efe-94c8-08dc125d3126
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8162

On 1/9/24 11:57, H. Peter Anvin wrote:
> Hi all, I'm going to stir the hornet's nest and make what has become the ultimate sacrilege.
> 
> Andrew Pinski recently made aware of this thread. I realize it was released on April 1, 2018, and either was a joke or might have been taken as one. However, I think there is validity to it, and I'm going to try to motivate my opinion here.
> 

In 2018 it may have been taken as a joke, but in 2024 with Rust for Linux
upon us, C++ sounds just plain brilliant. Thank you so much for this proposal.

> Both C and C++ has had a lot of development since 1999, and C++ has in fact, in my personal opinion, finally "grown up" to be a better C for the kind of embedded programming that an OS kernel epitomizes. I'm saying that as the author of a very large number of macro and inline assembly hacks in the kernel.
> 
> What really makes me say that is that a lot of things we have recently asked for gcc-specific extensions are in fact relatively easy to implement in standard C++ and, in many cases, allows for infrastructure improvement *without* global code changes (see below.)
> 
> C++14 is in my option the "minimum" version that has reasonable metaprogramming support has most of it without the type hell of earlier versions (C++11 had most of it, but C++14 fills in some key missing pieces).
> 
> However C++20 is really the main game changer in my opinion; although earlier versions could play a lot of SFINAE hacks they also gave absolutely useless barf as error messages. C++20 adds concepts, which makes it possible to actually get reasonable errors.

I was writing a lot of C++ in the late 1990's and early 2000's, and personally
lived through the template error madness in particular. Verity Stob had a
wonderful riff on it in her 2001 "Double Plus Good?" article [1].

But one thing I do wonder about is the template linker bloat that was
endemic: multiple instantiations of templates were not de-duplicated
by the linkers of the day, and things were just huge. 20 years later,
perhaps it is all better I hope?

> 
> We do a lot of metaprogramming in the Linux kernel, implemented with some often truly hideous macro hacks. These are also virtually impossible to debug. Consider the uaccess.h type hacks, some of which I designed and wrote. In C++, the various casts and case statements can be unwound into separate template instances, and with some cleverness can also strictly enforce things like user space vs kernel space pointers as well as already-verified versus unverified user space pointers, not to mention easily handle the case of 32-bit user space types in a 64-bit kernel and make endianness conversion enforceable.
> 

This sounds glorious.

> Now, "why not Rust"? First of all, Rust uses a different (often, in my opinion, gratuitously so) syntax, and not only would all the kernel developers need to become intimately familiar to the level of getting the same kind of "feel" as we have for C, but converting C code to Rust isn't something that can be done piecemeal, whereas with some cleanups the existing C code can be compiled as C++.
> 

Beyond the syntax, which I'm trying to force myself not to focus on, the
compatibility layers are turning out to be quite extensive. This is just
another way of saying that Rust is a deeply, completely different language.
Whereas C++ is closer to a dialect, as far as building and linking anyway.

> However, I find that I disagree with some of David's conclusions; in fact I believe David is unnecessarily *pessimistic* at least given modern C++.
> 
> Note that no one in their sane mind would expect to use all the features of C++. Just like we have "kernel C" (currently a subset of C11 with a relatively large set of allowed compiler-specific extensions) we would have "kernel C++", which I would suggest to be a strictly defined subset of C++20 combined with a similar set of compiler extensions.) I realize C++20 compiler support is still very new for obvious reasons, so at least some of this is forward looking.

There was an effort to address this, and I remember we even tried to use
it: Embedded C++ [2]. This is very simplistic and completely out of date
compared to what is being considered here, but it does show that many
others have had the same reaction: the language is so large that it
wants to be constrained. We actually wrote to Bjarne Stroustrup around
that time and asked about both embedded C++ and coding standards, and
his reaction was, "don't limit the language, just use education instead".

However, in my experience since then, that fails, and you need at least
coding standards. Because people will use *everything* they have available,
unless they can't. :)

Tentatively, coding standards are a better way forward, as opposed to
actually constraining the language (and maybe finding out later that
you wish it was left unconstrained), IMHO.


[1] https://link.springer.com/chapter/10.1007/978-1-4302-0003-1_63
[2] https://en.wikipedia.org/wiki/Embedded_C%2B%2B


thanks,
-- 
John Hubbard
NVIDIA


