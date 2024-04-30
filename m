Return-Path: <linux-kernel+bounces-163964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8CF8B76A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70C89B2327E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A9E171660;
	Tue, 30 Apr 2024 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YwfS3Hs1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F55412D765
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714482735; cv=fail; b=Tp9hm1v+9kCapq1OKMw2cpNwq851z/1FAaQ1ayRGMQ9gyDo9uhlaUq8vHAfzSbU+ffw2Nl4vZ1lw0G78nNSJbF7Z3Ji+4H4ApGTQwKgJZzAxr8UVmaczMAmxP+eWIrGg84IHrwRpUIKJK4bCziG2hRqQh4/466o5hTZ3h5eC0SY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714482735; c=relaxed/simple;
	bh=lREzYi7jhzJ2nNzRmRAJwOuRatL4gv1P5s2r0eujP0I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MJHohF7XN7aD40F+ONbCgTZaeIVZEcunyrstEnadiTmH+bwAESei4Mxq3h6F42+kYse+2kAJssYYyArGXCMgQrDkjd5WoNeQD8Cf/v7f0vBJMVP6DuDETeLaVQ9gWzYJy86ST2TYRm2ywDj7ms7gbti0RE6UJuvR8FiY90T0GSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YwfS3Hs1; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714482734; x=1746018734;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lREzYi7jhzJ2nNzRmRAJwOuRatL4gv1P5s2r0eujP0I=;
  b=YwfS3Hs17hN2AqZPQMCCiIYAcvREuh6+iGqAHhKaBpyKSXZwcAJ10HJi
   2opvTR8Uh1IHX0n7qyJc/K8LBHxMe4+yOGHFe+JS2kNlPkC5yz2LHq2Vz
   r8EI9nmMFtY1CbO//Ya4dWyu6yw4xGSEa+OTcXnN7lWgd4AYQSAOgrcuJ
   82LTWhCgDIYFLirxiInTUhaZYKoGrw2k3GDNnzTEy6LhxaPTnAxWHeixm
   Zrrjo//sYByc0OdJIqPbeCcY6azfB/+HSWAn5+9E27yPvE5ONPZa0ZrOp
   7h+lTxU+qbG/036mRGl0nrIBJYQt2YtaiAACLTo3QGwzaFEK1DQRPS2l2
   A==;
X-CSE-ConnectionGUID: uUnCu87xSMeOzv4zNgZK9A==
X-CSE-MsgGUID: NBnAZlYeQD+rFzlF/LReCA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10350007"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10350007"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 06:12:13 -0700
X-CSE-ConnectionGUID: Pd4FNY5mS2+EY14QaUVciQ==
X-CSE-MsgGUID: ep9G/7pBQyquF18E5ZmAgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="49660567"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 06:12:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 06:12:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 06:12:12 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 06:12:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzOwmLX0qSZNJcBDhzYKKPsJTBvYeUjirXrLWnt2LqpdvQ2FkHfPIQC8FE4Z9/nJOLxwAUwVZOwqM7aHOENZunRj1caApS5A8FXmVeTd6zEWiof5+OCYwQ2uBfS27qO0k/u+h7EJ6ST6mKnRvzbhsdR/HcrDEkq29wnPCSPfjzvx079kPCBLsiS2yCW0DcHtqCR1JGDyw2jyfgIDICdvXNuQS9a0Od1OUEj7zRYw1v+aS4fYFLxGqnRisklPrSO44hcS4UHyHGutev5IMeMAdaEdEuZ0ekJ9oCEVCjab+TsItLSKoMh4ciby1TTElogh1HCFSrT9NVwyQNws7KX5vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tw3tRNAagUWd5k7rzFBK1pnPYdNSa0GXcsLFFYbKFSs=;
 b=D3HGa0PXhAjmWw7Smth0EDKt9VkCYvr4pn4Plhh0IUHLApnhP0bKswGYoPk9AyN3U1+AGcGHk5vv9wIZnyR0mMa62HarU7Oikp5lqeDDXHbUdMXao1aIDrNMR13gQvMXY7fUoc5YP+dcK1H65pxUFr3BHcsDhtB3133TWjuagTquIWs1vqf9x7JnaWZuEGwXEyWAdgcQgZve9QnQtVSu0Xt1EAEAkW6CZPBOQtOOurmgmZTyeQIK7cdEasJ8odAopRphgpl3TepXo1qOVCspcCjqfid864dtehWA5XQL72GfdUxn8frd4KSI1hIYrq4olB5E7M/IK3QbQSveGvJkNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3230.namprd11.prod.outlook.com (2603:10b6:805:b8::29)
 by SA1PR11MB8351.namprd11.prod.outlook.com (2603:10b6:806:384::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 13:12:10 +0000
Received: from SN6PR11MB3230.namprd11.prod.outlook.com
 ([fe80::35d6:c016:dbf5:478e]) by SN6PR11MB3230.namprd11.prod.outlook.com
 ([fe80::35d6:c016:dbf5:478e%7]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 13:12:10 +0000
Date: Tue, 30 Apr 2024 21:12:03 +0800
From: Philip Li <philip.li@intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
CC: Kent Gibson <warthog618@gmail.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: WARNING: modpost: vmlinux: section mismatch in reference:
 ip_md_tunnel_xmit+0x9e (section: .text) -> .LBB102 (section: .init.text)
Message-ID: <ZjDuI09Wg0HTUdJ/@rli9-mobl>
References: <202404270534.8VgyE2XE-lkp@intel.com>
 <20240427004819.GA24436@rigel>
 <CACMJSetLpWn5H+Dk9kip5oVu5gG8fKB=PPHDRz901-JeUV1LcQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACMJSetLpWn5H+Dk9kip5oVu5gG8fKB=PPHDRz901-JeUV1LcQ@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To SN6PR11MB3230.namprd11.prod.outlook.com (2603:10b6:805:b8::29)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3230:EE_|SA1PR11MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: 1815ac37-f6f8-435f-14cd-08dc691724c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3j9rbYRdz6cPeLmNmpTtIrg95intesk80xZkG6P6QxWUV2od1ADZ/Zt2cQhV?=
 =?us-ascii?Q?Ddlf/Jbni94mO3bA2vFE9Y9iRTQP+yEv2LcLCyHT9KjYvnmPIQN4TEZIUADi?=
 =?us-ascii?Q?W1/P5B/vQ7yjlNh3RWWNkHvj36RyR5FSFhWiRzQ9iJeNFbykhZ4ea3NZgUVB?=
 =?us-ascii?Q?80WCEgCC2WFK3rsyfbs6LMKLpoTaSbpWgJ6cti68kkMcolfPNGJRLFF7NhSo?=
 =?us-ascii?Q?51ah4LdGK5heShZV9O+gUJnYr7eXHngV/hcEsr2E5ODFOMp97VIMlD5vnaRV?=
 =?us-ascii?Q?agU2KAYMC/y2xVKbSliHKqIP16np5RwLafr4/f5Ao2ssSPTUJ5OlycGVp+C9?=
 =?us-ascii?Q?T8dQOV0aLg3zKdgAz6pAA4AQFOz6yLI1roYyOm1Bi+0A+k8gGOfpAK2i8eWt?=
 =?us-ascii?Q?ZuzwDa6i+N9euhfhEcdkQj9RGv2qhlP8iCBv2N149xnUxgsM+Vpmraxe4EEJ?=
 =?us-ascii?Q?GE6QFfYy6jkRhX0k9JDRaVz8iXB+QaW58PBdnTUYD7gZC1Hml7wZHY4OQtAZ?=
 =?us-ascii?Q?uJL1qKLKEy9omydjN0dWxrK4F77madZCadlSrTvRnwvmuVjRX+3Stl6Zwx4d?=
 =?us-ascii?Q?5twxLdxHKOYHF/9zeyIJuqMlQgVm88hFFbE+IlVfVdr9KoouGOjcwlDs1L2E?=
 =?us-ascii?Q?j0hb3/Vjv1wutAu/75iQuek9Nfl/8elZvuKZibqu28+jfSJOy6THdoGh1jiO?=
 =?us-ascii?Q?jfGeJcFk4HxO2fTE7Ex/u81I9+UOPJFZiMMOu+eaTKlU7zQyUEkSK138Kl3Y?=
 =?us-ascii?Q?VALiMVMaFAQGjuzKi/ru7DFf7jzpyg2tgS6O40bRLLIAETLOkDA9Wwf+8ZWq?=
 =?us-ascii?Q?jOO+EdttZtqPbcttbnhvyxReQwQOceUZuy5U795XqF9mQW4fiBaXQMm9NtWm?=
 =?us-ascii?Q?njiBqVMjfdWDtaZ2y7Z1VRHnk7X9M3NoSyEuiynWRQHvUHN8X8hHn5Ir2JUu?=
 =?us-ascii?Q?PsN/1cr2vDGaTITCFkmgLDznT1/7F7D1Bbms5qqKcZu7V1c8n4MNwsyWPQCz?=
 =?us-ascii?Q?GfCdvG+2F2kIb4Fwlc/yJSXB11/LAc1GmYHbkDhquceLPNSM5sWOwihfcdok?=
 =?us-ascii?Q?lTIYPafnkr3JvDoTj+XMIE7vbba/Kxtd/23YQ+TNPgnDMHPL83nSaojN8XRv?=
 =?us-ascii?Q?hWacr9mPh0/ycGgzXO0YuIMoDru4xD5Vmw08iC4eEe527dfK7+RaSrD3mOs6?=
 =?us-ascii?Q?fEyPaCYlMVtdDXHxDLocbxZG4fpiPprjXHlpafUFM1QRzVrIQ14BgHmwofI?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LGAnbJT/+GVr/Jm/e5A0M4AYbacHPamEpLxNb7v9kLtTvj2En5FPO5fL3L2Y?=
 =?us-ascii?Q?UmlHpY9xgMICK2CkMsts9aUQL84QqsI6LL4B2xS1NKNXGZjc3BK6O/XzkMQT?=
 =?us-ascii?Q?E2VPQcqp4cqWb0hSxXUzffbxxbCeaAymGS1eB9HKoz/0jRdauC1kP/On1d0U?=
 =?us-ascii?Q?lBoKhvrd323bq8X/KLQgOKwc6bU86bwXLWXM1Crb31FEHcS9+nFKl121MNLg?=
 =?us-ascii?Q?2mCPhFO7K+dx4cplpfsHV+KEc/4bT/oZZAKcx+7VXd6q5Zrj3K0AAINb17ec?=
 =?us-ascii?Q?VBQjFWGsBsh4kwlnkBoPJkU/oejjs/PwVrGCLo4To7nD75ZnEUxCgboPxqjY?=
 =?us-ascii?Q?gWSRQPsEp84bRfQcC53jNxU8Edquy9N497DLDCAxi1ehtroUApZiNdBH03/Q?=
 =?us-ascii?Q?NJWti6n4VojnixaVlAGD0XjA8UjBB/JEKRTDTw7NkyzIbhkOxgLaBVvQBjN/?=
 =?us-ascii?Q?HCxmFCVH5ZgZs3ynyIpcfRWPisKbimBHr0IqmGFKYwnb4RdJHzHKnavbCakM?=
 =?us-ascii?Q?S0k7om2lkoxKe5OdlEHODZGp0AufishKocI0lBc5K2Z0Y4U4tGY5qpFVxFpa?=
 =?us-ascii?Q?PZtSVGk4hgAfvwvf1F59D5tfE8OI77OSyViNKaAI7PU6CiVgKrsOTd0/BtyG?=
 =?us-ascii?Q?O4YJEKLPk6yEyDIDM4b+FxKi/jYwvRsdL2HGPDrRfrM/R7XCnqEzQA7OGkdR?=
 =?us-ascii?Q?JzY+0BRxJRA+j/UwFZdJ713cudLUZ0FxlFUOn36F+sukgk5l8lEJ/HfpZTpv?=
 =?us-ascii?Q?dqCm7sXah1MtWgzBPxVKxynA85Itk5retUQ5vHJXkk2vLwOtvftm1WhHGYyM?=
 =?us-ascii?Q?4451EjHzam+rYq1rkvuFlQRHOLHpruyAVLDyESK2uQWQAouKvBdUOHqvCzqc?=
 =?us-ascii?Q?r1ov7BmZZug7jqEsjx+sJCCv+PAWee/euJWlO0ovSLgZqzSVzLWs07uH4ebV?=
 =?us-ascii?Q?itJ2nIKTqeeht+k4R8tZyHICehR08ZxTE1Buxj+EXUZmWS9Ijyt4YBw0i/BU?=
 =?us-ascii?Q?h+73apW5UWY8dehSGtk5OLlohwB17L88xL6Q4ygOizK3BGQldlMXdOUglYkt?=
 =?us-ascii?Q?2cTjK+a4xGr+CGR4Q4jHG2wl+xagNeqXFnY6o0+XqFgXTcC2cWPoMK/qcfAN?=
 =?us-ascii?Q?Hjy/Dm0cf2eZDms6LUyvSetwJjbOaYf332MeeAH1rkUDM8uQZ3tBqY9/i316?=
 =?us-ascii?Q?xcqo9lWw/ifIRuDQpl6AU9Bjw9VZ6lg9oos1kqYPAwzN1NqFVdgkVM6twKBO?=
 =?us-ascii?Q?N+Q8zmbdBmjLM5HK5oe9YIJNti6NlFXDf6xVtbefl2K79uvN2jn0FAbmPo82?=
 =?us-ascii?Q?JAmSnIqhUxzLGnGGbUUI/ywTZTvWOJeaCx6UZr2gletm1m5+4DfWORbsim/g?=
 =?us-ascii?Q?xDXmKpBeOH9Q8D3bgPagxRV3VcEYuWhQB9Vrtby6mRz3Knm/d1Fp1Q3k39nM?=
 =?us-ascii?Q?4jcObllFH+OI4FZG873olUB57AiZE+jAD1RPnIxWE5WlWukn9H1ThGDOla0u?=
 =?us-ascii?Q?uIctYf7WfrSUKyqfFLcgE9QFlZfvRpAaae2BI7JQpqteQvsvg8skFsqYatLn?=
 =?us-ascii?Q?5Sqtl/d+i6eneMFxGtkNqn50/ed7jSK+4t+58Ose?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1815ac37-f6f8-435f-14cd-08dc691724c4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 13:12:10.4434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQBiRiSXyAIT0ZEDR23PZz2m6w9rVx1IvYS7sMsmysK9BRo++1R6rZ6OsX6zpDL4jTz43MRUM0ahTkqR5baoTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8351
X-OriginatorOrg: intel.com

On Sat, Apr 27, 2024 at 10:21:20AM +0200, Bartosz Golaszewski wrote:
> On Sat, 27 Apr 2024 at 02:48, Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Sat, Apr 27, 2024 at 05:29:42AM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   3022bf37da50ce0ee3ba443ec5f86fa8c28aacd0
> > > commit: 83092341e15d0dfee1caa8dc502f66c815ccd78a gpio: cdev: fix missed label sanitizing in debounce_setup()
> > > date:   3 weeks ago
> > > config: riscv-randconfig-r021-20230409 (https://download.01.org/0day-ci/archive/20240427/202404270534.8VgyE2XE-lkp@intel.com/config)
> > > compiler: riscv32-linux-gcc (GCC) 13.2.0
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240427/202404270534.8VgyE2XE-lkp@intel.com/reproduce)
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202404270534.8VgyE2XE-lkp@intel.com/
> > >
> > > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > >
> >
> > Bart,
> >
> > does this make any sense to you, cos I'm not seeing any connection
> > between that commit and these warnings?
> >
> > Cheers,
> > Kent.
> >
> 
> I think this is a false positive.

Hi all, sorry for this false positive. We will check and fix the bot when bisecting
this kind of warning.

> 
> Bart
> 

