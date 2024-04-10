Return-Path: <linux-kernel+bounces-137914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C08BE89E97D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364E91F23F12
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9125912E73;
	Wed, 10 Apr 2024 05:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="f3KoFpjh"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2132.outbound.protection.outlook.com [40.107.96.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C722D8F44;
	Wed, 10 Apr 2024 05:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712725922; cv=fail; b=AOvoWsvUxv5kl2P+i5P/MGrvfi4v6gS7z6NkwTNSNPD87Ov1Eg0WMhVzP2GQt9ao6Lz1wNqRMLmvw0CVNwXehgw39SkDHJtaHXWKfWOGQIQAeqjy9EzahqVLRMP+lX6C3RgNkCFwFJ1v6PmscW62KmjuY8BrywoQemCSoXud5VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712725922; c=relaxed/simple;
	bh=aeWS+xfszdKsRXrgMe/jx/Jl4WQiXyDVN3Bicx6PWDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fv+26y8Yy7vUNz6KyhaRFLf2rllfmk5jYADBC4fQZKr9aEK9wgqmUzy6yXobWWMEN1Wc3gwXhZFU+M5ubWfQ76l5yfAMHmjOH9G6wre6OgqCnSQ7aB+KqZJCVCMReVW4C9sR24ygDOaV5eY/+OfzFB2c8wRNCNlnHrvAdPTwH3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=fail (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=f3KoFpjh reason="signature verification failed"; arc=fail smtp.client-ip=40.107.96.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMFAhnBtnaD4F81lgyOrq9P0XxeHtYoHi0DtPO1WFvHxiN1QQBk6CiNpDbs1a1nIRQze5ib/dQJj2Bmo4TVNQswJhqi2LfC5TsuzVXyim9uZayV2li6z1vPtyQqecHuGT+D7avzd6S17hqP/QmE8sQB0NNCILIABdyp5xE21AhBo7tNu8l39YFojbASMgrvlkSLCrx5CSSmVZHOBZUseEt3WajU8WqHboLmuNCcLL4c0ijKlSCfEHlO3+ryMrYU2WH2ag4rdtYGC7TJ5Z6PCntdv0Ox8pFI/DgCprA6J6Qylp1sj4UjDuwfN4Wn3849B8wgXyJ5u85PFMF9YFq8kkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hm/1jY/VjPfKjkQgrdV3cPlrA3cMUjg80eVtwt9I7hU=;
 b=nv08xXIOVt2gA5MEwnj2vJCSZAeEnF+JWFzVtIArnIEwZ7lKZHEmKK4klAwYP/dhTfspDz5iW0LPjrfJ9Zim/Rz4dhztqZuToSMXAULqCx6Ar4EfTSBcrk1ZxhcgVCW9iP4vqVB7KHlsy/D/MfCrPmmLzxxkdEridU8uu9DzznTjNJfikeYwT5QUJS27pxECuURsz7k2rMCmNq6hwkJceqf6QdSiHndyfcZ28lfYfBuLFzN4CEux6GUkV1ZCdoum5UINbi0b2zxPVyzX0AcsQ9RI0kR2+Qlyqv7KaZBh2RI7Vf9JYTNF4/u3vnbesKFr9OVUrgn9YsVc7IVXRqzanA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hm/1jY/VjPfKjkQgrdV3cPlrA3cMUjg80eVtwt9I7hU=;
 b=f3KoFpjhqncc8GtnSE5BBR8GuT4aKlznN7gseTsjP+col3NLt/CPeNxzY2SPVhS7PgcnFEi8HKGle8Ji5w/akTzYGh8QFX8sZgEINJ7SsqSS9uB9orfSlLyUTaixGwAUk6ocvWZx9YE+CqAt4IQjxNKqof6P/u7KBcXVoWGa5KY=
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by PH0PR13MB4923.namprd13.prod.outlook.com (2603:10b6:510:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 05:11:56 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0%6]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 05:11:55 +0000
Date: Wed, 10 Apr 2024 07:10:43 +0200
From: Louis Peens <louis.peens@corigine.com>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yanguo Li <yanguo.li@corigine.com>,
	oss-drivers@corigine.com, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next 1/6] flow_offload: add
 flow_rule_no_unsupp_control_flags()
Message-ID: <ZhYfU/KUBHIAZffi@LouisNoVo>
References: <20240408130927.78594-1-ast@fiberby.net>
 <20240408130927.78594-2-ast@fiberby.net>
 <ZhT/E1qDsMmMxGwb@LouisNoVo>
 <2c7bc566-c975-4dd8-a17c-10c7b9ff3928@fiberby.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c7bc566-c975-4dd8-a17c-10c7b9ff3928@fiberby.net>
X-ClientProxiedBy: JNXP275CA0009.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::21)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|PH0PR13MB4923:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G96SosI1Rd2jHv8tn9iQWdmQXVzk8/rD/TjwpjkLWU8Yn1pFR3bs7pdAaMqb2OR5K8FV7s3+/wGuE45l8nkT3fv/PgGa8mS1EcywLeFbIdOo0YJwQhn+atq0H0UhtJEf+jMUp8O6wgB+uxTU9SNxamYCQU0Tvn1m5ukdwibjvpSGZw0S/MYjYCdQi3Nnb5/x10E+FBkgHiijcFYshRxUuBkhIDs7X8e7+kh0IfpqcKCPElfi9t+kgjucefy92e3E8d0j5kJcvLbduYCJVqzAhAoLYppzbIGCcUIKTuhp4u5VcGHbTAhDSc2pjSoT1hAi7dLX+2G6WSO6ZNfD4dOq1KaLNVTAIZGOwJDHstrVPh1gdurpWElfc5D5zbf4IrZbF/FuH8KkZ2sMLSLCO54DEm8mV9SKo519ZJpFmvDQrASHBoFQW9M01YbU0FU36S7Pv4BnQRLFwJ/1fEzs7K2rK4K5B2m68C730DMFUPKcqkT8DkKDbsoWDongKtkKWk4JNe+4AYAz8yleYhUuxYPCz0aWYpY1tXDNshmsfCX93JUzG0IixioRONSxKyxo/UTCXZ7MAbIyPHTIPykfO8gL2goLRehCbLp9GjKzlod02RWATKcR6tOvFOrpQDHAMwO25u/DUQwnVXqt9sIG9hEJpSPAPjorYrBaM8I4Hs+t7BM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?TScVoaT07VgkEfKIbwIWPefp4AHszer/OY/uYgJ05jDthY2s9V50SSNuvR?=
 =?iso-8859-1?Q?ZZOtOZvQ5fblPfxPh1E1P9EMx/v64wxKtdjkfP2sqE5HtMtMnD9Rg/6JbG?=
 =?iso-8859-1?Q?kqN9Lw7h4P/0+h845tXDXt/DjsZUPM9D4XA7c8iYwmqegdwQIc4CcfUuYn?=
 =?iso-8859-1?Q?BV3YT7Pi3jf2Zdmg3yaFpyyxSw72Y1CdDA6UIhD6umdq+VXwDlaznscTfK?=
 =?iso-8859-1?Q?51VuTlCaa/bucvmAIbQU5VnDDV5cgbxZkUn9y0NradB1096JL/l1sf3zhq?=
 =?iso-8859-1?Q?iuZKD5HOrTuK2eZLCplksLznwerkvgnt8XC2dgfugQS+zAeFJUVmBR/vGA?=
 =?iso-8859-1?Q?dI84MoSgiFg85AlRNh7RYr1IknI0ys76GEjw968KcvuG5u1pHvUcd5wvUZ?=
 =?iso-8859-1?Q?1nfqV9fMrm06Xpe/bVj2Yw3/CSbgnRYdN+JsH1SpSwRTlOmMyn1mAabI+F?=
 =?iso-8859-1?Q?tiu6dtVfGxyfWv6HWAIz/6mvj92gI2KfmLAb7cGP9KGuE6l4JcX13+afyD?=
 =?iso-8859-1?Q?tCQsXhv+t4kUBCBpHMsAmOoJuG8Y3D7w7FFVZu1qNL1prvxvclhWoium+6?=
 =?iso-8859-1?Q?U4S3HqqIws3ejDswpFBIsf36ZZOLJMGRdboO6br3BKsCpgBIfZda6k6M/w?=
 =?iso-8859-1?Q?0kp5RUMYPgYAjVdq7pFGHPaejlvlRjx3gyRcBacB+Avl48q6qFlQ+p26Hh?=
 =?iso-8859-1?Q?tH39iM30C5zDIPhRI+0FlddD4RLBzTdQG95xy9xJnfLnirEHTv5IkDVAWI?=
 =?iso-8859-1?Q?B7Vt3bhC1qtgyDJSIeYUoN0t5H5+Z3mxWAgSh4ohk4Py23rmZLF6B1PbX0?=
 =?iso-8859-1?Q?oSyWjRWN5+z05K7MGmmXagtGkHrkwS8Ht8Spok5dkMOz/Bfyh0KkcyMxrE?=
 =?iso-8859-1?Q?i+Ae6LgMC6AMozdF1/u2OJk0P/3Aq+fftayNXjGJGzWR6n0mJLro5Zh9sg?=
 =?iso-8859-1?Q?HQtqOLoFKCOw76tkSnL15eGiVmkq1VZ9p2NXJNWx1qtE2zaCZactuNmDMs?=
 =?iso-8859-1?Q?DLO5i/iHPVCqvK99+QQKjTT3olwzvPmTsA05T6EY9T9q9PDIFobHwS6RHC?=
 =?iso-8859-1?Q?BQ5/g7VxspaKi+/0iJZlD2V4NY1IjwOMFx7ne1y0H7pUPQKIDCPgaFNeDg?=
 =?iso-8859-1?Q?8VBogGZt3yf1y6vYMX0lc8pypFWjDCcD6XsvF3vzCiANlKFwLVpMlr7UXu?=
 =?iso-8859-1?Q?6fzrdkbx8QutLvIq/KWF1z4U3NMsF3dOAgkVI6iRLMGpDCccAkwAyA2tQk?=
 =?iso-8859-1?Q?Q23wJfOiarL23t5zFSFYcqsktOialjScAIqJExpMUHWwYxxk2sQoTFJMqF?=
 =?iso-8859-1?Q?HTeR6etUvaLsZYecqrG3kKL8s5i/fh3SoFcFkiU4+TwRlwLz/XrsZan8tA?=
 =?iso-8859-1?Q?dW+YCVsK3GblJ0+B79/nvJCSBOKw1q8Sg4odTIVAtmwNrKUGuj20L0on/O?=
 =?iso-8859-1?Q?c/40IGfqZrjQ5Fd5XPm92DwUoA7GmFYRbkQQaUmZ29gMvprB9DZqy2l0ki?=
 =?iso-8859-1?Q?93pf1K2gXNsEdIr8XV0QAmr3g91YH4VVXJVPNbtjdTFVZtj+X8YX9/POL2?=
 =?iso-8859-1?Q?p8ryY1UJlmxAnwpcOjc8yHN0GkpfcYiL/SWV3KbSSqpKSCQrAhUlwZ41w9?=
 =?iso-8859-1?Q?RMT3Od1+cfdjqap1M7/zZQvg0Q8E+U6tAduh4t1K/3aVK4KrDNHrdhpA?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca14c86c-3254-4396-57b7-08dc591cbda4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 05:11:55.6623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiJb3fUffX8vuJflxWYslf6M3UM6nuArGFHjkGqPuWWkteHl0bWVnrTa0pqL7Dpu3vFpViMR36ekouhg/x7VDHskr65Snd9p0GWesBi4nzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB4923

On Tue, Apr 09, 2024 at 11:13:22AM +0000, Asbjørn Sloth Tønnesen wrote:
> [Some people who received this message don't often get email from ast@fiberby.net. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > +static inline bool flow_rule_no_unsupp_control_flags(const u32 supp_flags,
> > > +                                                    const u32 flags,
> > > +                                                    struct netlink_ext_ack *extack)
> > Thanks for the change Asbjørn, I like the series in general. I do have
> > some nitpicking with the naming of this function, the double negative
> > makes it a bit hard to read. Especially where it gets used, where it
> > then reads as:
> >      'if not no unsupported'
> > 
> > I think something like:
> >      'if not supported'
> > or
> >      'if unsupported'
> > 
> > will read much better - personally I think the first option is the best,
> > otherwise you might end up with 'if not unsupported', which is also
> > weird.
> > 
> > Some possible suggestions I can think of:
> >      flow_rule_control_flags_is_supp()
> >      flow_rule_is_supp_control_flags()
> >      flow_rule_check_supp_control_flags()
> > 
> > or perhaps some even better variant of this. I hope it's not just me, if
> > that's the case please feel free to ignore.
> I agree, I will update the naming in v2:
> 
> flow_rule_no_unsupp_control_flags             => flow_rule_is_supp_control_flags
> flow_rule_no_control_flags        + s/no/has/ => flow_rule_has_control_flags
> flow_rule_match_no_control_flags  + s/no/has/ => flow_rule_match_has_control_flags
Hi Asbjørn. I like these, I think it will follow much easier, thanks.

Regards
Louis
> 
> --
> Best regards
> Asbjørn Sloth Tønnesen
> Network Engineer
> Fiberby - AS42541

