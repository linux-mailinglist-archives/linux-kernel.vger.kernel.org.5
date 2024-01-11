Return-Path: <linux-kernel+bounces-22920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A333A82A57A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0391C1F24F18
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7716A7E4;
	Thu, 11 Jan 2024 01:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="JA8yFWT4"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2134.outbound.protection.outlook.com [40.107.96.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B19393
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 01:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1n4fvxH6AHX8130ennY0WcF+Y1rdGkSNmMQtA+6crd6Y+Wbc64mWacXt3wtuX33Sr8x1Jb6muuxZBm29uR9FtinbeKcEgqptCklpUCQJHkscWxKa4bGORPIBkbGsN4CbuVcrguNxfDR3TpQug3CkKbgZs7cPjBv4Y4bO+qPqwREfBVuO07HjVPGIjREDfnyKCzD3xAYU86SO73vRi4D8MZvhA2QpAvSmGTqLEiQXagBwb4pponQnGdqzxSOKLg/AWj0RDqm3KeGV01x2P1fhKLx6K+cy4HFuP0a5DaWMLsWY2whT65uDtgZum7ouAGzJ1GnR0EeUX9A/zCCH1aatA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uKEN5TLHypNmqMmuopf+oPQLkt5JJFMUZEYEJKxiug=;
 b=TfpsDP6V/xJXcF/oxzCuy0e3BTnhCnar0EcSZt/wVtu5xQSrxaksfyM6LLKTfv/VUpUewAVRkwvXf/AVx9C45jRbzD8dy4+YdhhKctPO4DYObK2PgeSjgSC9n+rJKiTAh/vwPJYps7YWqnKcNyxo+Q87UKvYXQRD9VEc8RSS0z0dH/Msneaxv8BPpT+z3NmTrubVUogdhd8PWwJG/1dlP3HoYq5h1jZRhgY+b4WaKTtKgheK8zqEw4LsSvJRA3WBgvPzEkOm14CjGB5TjlYv0wmGYIyryacwEBOSWwx0Fqvqw3HuCoCYQzl/s1DTiBEg9n+pbUZmbclogAm0nTi9Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uKEN5TLHypNmqMmuopf+oPQLkt5JJFMUZEYEJKxiug=;
 b=JA8yFWT41CTQrc2Y4jQqFCitRNjsxKPQkHQqMQ5OkIZyL5Ws5tP6Vmk+pZ9irvOJ822lChN8VYfkw/wlafSnW0MgE0mrXQ5su5JgrgJmPhsZnLfXzDgQ+aUty5aEoaUTcBBRbVfGtd7/7s2lwpxknmihSd4PeHaezpR1MHc46fs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CY4PR0101MB2886.prod.exchangelabs.com (2603:10b6:910:40::10) by
 DS7PR01MB7566.prod.exchangelabs.com (2603:10b6:8:71::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.23; Thu, 11 Jan 2024 01:17:14 +0000
Received: from CY4PR0101MB2886.prod.exchangelabs.com
 ([fe80::fd44:38c4:b5a9:a6b8]) by CY4PR0101MB2886.prod.exchangelabs.com
 ([fe80::fd44:38c4:b5a9:a6b8%4]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 01:17:13 +0000
From: D Scott Phillips <scott@os.amperecomputing.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Gavin
 Shan <gshan@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Raghavendra
 Rao Ananta <rananta@google.com>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] KVM: arm64: Workaround for Ampere AC03_CPU_36
 (exception taken to an incorrect EL)
In-Reply-To: <87sf3au0bu.wl-maz@kernel.org>
References: <20240105213251.4141-1-ilkka@os.amperecomputing.com>
 <ZZiWZkNP8Owytecw@linux.dev> <87sf3au0bu.wl-maz@kernel.org>
Date: Wed, 10 Jan 2024 17:17:14 -0800
Message-ID: <86jzogsm79.fsf@scott-ph-mail.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR17CA0030.namprd17.prod.outlook.com
 (2603:10b6:610:53::40) To CY4PR0101MB2886.prod.exchangelabs.com
 (2603:10b6:910:40::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR0101MB2886:EE_|DS7PR01MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: d58f4412-d0a1-4675-25fe-08dc12430afb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YuewiVwGlrC32/c70OGXGvdi1IibAtIQZA4VYKsruEU2WPcDvd0fHmaoQBSaiQ/gjWWJC3Hkin0PklpKTBsllFN2TPcppPvZNkvyHCYOMS8GrqhGg08Dm1YivRImrsx8tKcsgwxTPoegCIVG/KgwkOGYISC1AGOP6838bYSmBY3LsGu1LYWGBakO68H3cEm+9ug4ki2zn1f6ann6mIh287+UCjBsZ2u53i+9wKq9cAFnBAh4cn0r1JrCKw/sVrTB2klghn3P1/ySaizK5BMgkIb8+J3pGB1ADxQDaQpL/kJTjTgA5T2NYjWQHIo+ra0gbhivy/x/ak5Q5jNhbtF5T4PYMEwJtEWPiPgKiUjQg/UqIUe2NX2VOYj3/ysaLgRsL4hNjz2p0wH4o4Me/nqeaGuh7cgbXCzNszoRx8q9YjbxNTmE/xgHNYcT9Xj9CtddD2XPT8o9XDbUN7XxDsyb2T7ovjLnyOG2ucZHfWSUvmONTJD5WcJifZplm8ldJtytSMdVbN39hZbcF9HBMrhwvtgJCpURgyahxWwY29fzmzstW4+YRdYQbnrTcC7MmlIcJBT9+6KAVYMdXAVZ+1BuYuUnr7zrfupukzFZa9Y1xg8bxbUBBn8KmiAQtpIRxLTV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR0101MB2886.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39850400004)(376002)(366004)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(83380400001)(41300700001)(86362001)(110136005)(38350700005)(66946007)(38100700002)(9686003)(66476007)(66556008)(26005)(6506007)(6512007)(6486002)(54906003)(6636002)(316002)(478600001)(52116002)(2906002)(8936002)(4326008)(7416002)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SA2HshCNcgPRZYNcX6/OCRNHgPTYrT479zhGDMBvQ0EtVOYqKmlYGXPAYDwJ?=
 =?us-ascii?Q?VMF69NbjJcOoMRuFoB/x91Pjoa8Vgcgs5W1zUN/ADkVBpgAnI6IK9kC0Zeks?=
 =?us-ascii?Q?Z18aC3pxBGg1qYAMIG9POuQRMLPRqeyvuLOypOUVP8pE0U0PhlOoaviPQO22?=
 =?us-ascii?Q?v3xyXIpI5Kusso/1YIQDXMmZi42CqX0SQSpaMno0mR8wjW1qnqbSvHZ8uKFp?=
 =?us-ascii?Q?TiS22SokvAw9C21Z85uaVoUwrNO+8lTyu5IiJE1JtUxggAocTNEVUmgu1Aqd?=
 =?us-ascii?Q?OuIP/bPwC3kizpZamCSNL5GXlYLt/Raf9s2w75SHVF6Zz9nYwtOBMniPqhHE?=
 =?us-ascii?Q?f3Zl2eik+2iA7JezWFdlvjVHvlgUkpnQd/uj8lUw9ZgX4Y8xXLyi3KAC4YBu?=
 =?us-ascii?Q?itGb/X5cI6pDSXo6lQOrTKiTGdKNEBrlqBehW2DVWO17jVaumIPMT1rzDai6?=
 =?us-ascii?Q?fNMAQokj6BJJwfd7zv5tCEi83eW1jipIbuj+u5FT4MNp2oHOqcyWHQnagjnK?=
 =?us-ascii?Q?+Hj6Ef/neL0WAcL8QjqUmmLWxm76dw6c9HiI59rYwcIHEbKqyqDN84n4EVty?=
 =?us-ascii?Q?8+jx53KQM3lC0cPSFqPzWyAG+EZvUODcZUdev5+o3J5wPoQm1ejDR1EqeTSr?=
 =?us-ascii?Q?ObjOKQ9yn6Ix4UEp2yvamUcwhrVoTQlq31nPZ08Mh/a/zr6UxY2VVcgQHbWd?=
 =?us-ascii?Q?Ej+qfi9QK1MXGEYAhS7cBM5P3/26/Y1c1/lHlOBAgjn2v+w+UKWWd7sNgorb?=
 =?us-ascii?Q?J+0b5sGMaoR77Li9L9d3Nq/6DiX6MtxLtB0uQlWsmdNd4H6WcSRsmHVxYkmO?=
 =?us-ascii?Q?ZRKY+p98CfFMrFjgC86ahRGZ/IIQ5upP0/APS19iYBaZLM6UgNvgo57dN7aG?=
 =?us-ascii?Q?xRyW4QGPVBsgr2Za45RYQldJ0eRvJ1K3uw/eUj9tw1LfKdwp04Wlks7D7vD/?=
 =?us-ascii?Q?Ut9Y1VD7pdsWK+nbgYVHlWE5jI9nK1w4PzVPs8f9CCfnHcZ/0koDdCIAIl2P?=
 =?us-ascii?Q?BxXy6Yyv0XFION+Vj2yvu9X/H/V4YdmbjZuD6zwe7we7V9Hw6Twy20FinoV2?=
 =?us-ascii?Q?0Q2KBHlbuu2XAzvTGe5WoPLBAWHxdLY0XWJLMKHV6/gnPfCyXxjScIg5YQXi?=
 =?us-ascii?Q?8PGVLFFzn0Y4+kmTDxcEUrN55J1nslYvw75ILbzxvURIEwhsRIqZEy7gFq/e?=
 =?us-ascii?Q?87UGNw82Cq0OzbkFQAOfW35l2ECV3X/ryWTVTuEb/gsrVMYEMzq/sOSkNXma?=
 =?us-ascii?Q?ZyiaCE/XNimiKJXsT7THZ/SHASSIQaqEVQ920UfhmSZvMX1jZlLskS8Y+MX2?=
 =?us-ascii?Q?8z+6y9fVCI/aETp/qaZAzHWwUIe3YviXD8c5ZSTS5hTYwzGAdeYMjrKXmwMk?=
 =?us-ascii?Q?mbk5aFSA5CS+aVQdcrrp7J409S93spJFXdO86hbZVNSV5Y368TmVgHABKlOu?=
 =?us-ascii?Q?M6Cqhml0gPfI+LYipE5hCP2fO0AiGxfFmAuk9EdJBZt8ZITHQjEYTCMSq5CS?=
 =?us-ascii?Q?7mP51d816H5PxksAisFcu8LlN4d11SorW7APN+C0+BZdKyLtdcuo97TLnHde?=
 =?us-ascii?Q?ikhqxCSV94tVF2Xc9JN+YaVrQYzsq3PTJNWThv2haPbVTOsD5/7LMcXwVecT?=
 =?us-ascii?Q?9khjd86ta3q6aPvmowhuePQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58f4412-d0a1-4675-25fe-08dc12430afb
X-MS-Exchange-CrossTenant-AuthSource: CY4PR0101MB2886.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 01:17:13.8439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3CuBAqv+MNRmuUsC5jtJ9LnEpoT+NoXt/Cg21bdUUEwaKA+QzBvtj/Mqc/lW208UgSStX4enCfNTrXrnwRZvlLIS5mTjphNjNEULc2GTZedGn35YcFq0X0HJMUCwuzf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7566

Marc Zyngier <maz@kernel.org> writes:

> [reviewing both patches in one go, as it is way easier]
>
> On Fri, 05 Jan 2024 23:53:10 +0000,
> Oliver Upton <oliver.upton@linux.dev> wrote:
>> 
>> Hi Ilkka,
>> 
>> On Fri, Jan 05, 2024 at 01:32:51PM -0800, Ilkka Koskinen wrote:
>> > Due to erratum AC03_CPU_36 on AmpereOne, if an Asynchronous Exception
>> > (interrupts or SErrors) occurs to EL2, while EL2 software is modifying
>> > system register bits that control EL2 exception behavior, the processor
>> > may take an exception to an incorrect Exception Level.
>
> What needs to be described (both in the commit message and as part of
> the code) is under what circumstances this mis-routing happens.
>
> Is it that just clearing TGE while being at EL2 always results in the
> asynchronous exception being routed to the wrong exception level? Or
> is it a more subtle issue related to synchronisation?
>
> Also worth describing is to which other exception level is the
> exception delivered? EL1? EL3?

The mis-routing happens when the old value of HCR_EL2 allows IRQs in EL2
and the new value does not (a "C" entry in the target EL table), and
then an IRQ arrives. In that case the exception is routed to EL1.

>> > 
>> > The affected system registers are HCR_EL2 and SCTLR_EL2, which contain
>> > control bits for routing and enabling of EL2 exceptions.
>
> How does SCTLR_EL2 affects interrupt delivery? Is this related to
> FEAT_NMI and SCTLR_EL2.{NMI,SPINTMASK}? Because this is the only part
> of this register that has anything to do with interrupts.

It looks like sctlr isn't involved in the irq routing problem of
ac03_cpu_36. I'm working on pinning down whether there's some other
somewhat related bug with the sctlr bits, or if it's just a mistake that
it's listed in the write up at all.

>> > 
>> > The issue is triggered when HGE.TGE bit is cleared while having
>> > AMO/IMO/FMO bits cleared too. To avoid the exception getting taken
>> > at a wrong Exception Level, we set AMO/IMO/FMO.
>> 
>> We toggle HCR_EL2 for other things besides TLB invalidations, and the
>> changelog does not describe why they're apparently unaffected.
>> 
>> > Suggested-by: D Scott Phillips <scott@os.amperecomputing.com>
>> > Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> 
>> This isn't an acceptable way to go about errata mitigations. Besides
>> extremely unusual circumstances, the pattern is to use a cpucap &&
>> alternatives to only enable the workaround on affected designs. We then
>> document the errata in the expected places (Kconfig and kernel
>> documentation) such that the folks saddled with maintaining this stuff
>> know how to handle it years down the line.
>
> +1. This hack will have to live forever, while the lack of
> documentation makes it totally unmaintainable. The KVM code *will*
> change in ways that cannot be anticipated today, and without
> exhaustive documentation, we will not be able to do a good job at
> maintaining this system alive by correctly mitigating the erratum.

Point taken on the documentation. I'll work on getting it updated with
the info above and get ac03_cpu_39 updated with the problem encodings.

Scott

