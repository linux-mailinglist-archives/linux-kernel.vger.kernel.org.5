Return-Path: <linux-kernel+bounces-152896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4CF8AC5DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36454284083
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA174D59E;
	Mon, 22 Apr 2024 07:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dKEN8tYD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F124CDEC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771919; cv=fail; b=MNUOzYzVFC3b01zCXacEwAFCS1UNW1nC11qLZU6WPw0KXkjtTmGWNKTo3w79RKOynkf26wjQXpKnzSdx4LxOiPmij6j5PXPjaHCuDzTWmRtZ4rgySB5r32XMQTp6CR4klsDPFts6i5KqUB6CoZMzhyl+EanjS6Q5VbYDbZ2MV70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771919; c=relaxed/simple;
	bh=kJOIwCcSaDtPQXoc6iw0rU5AJiiUVIi+RtYL8b7fdpY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Wq2OsdFAvrkLTe9oiduQGt6tQpytnMuBDPuWzaEDHJktrJUwePiWMppUdY33rN2UEWKiXNcQa5dfDhuFPfvNA/k3BqTrPXRzZSkD3o3F1qlMtD3Uu53egBOP+IKR6dj3+en/swGE5jiggJXl8eEK3TiHb+3nz8nAhwNG6STJZ4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dKEN8tYD; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713771917; x=1745307917;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=kJOIwCcSaDtPQXoc6iw0rU5AJiiUVIi+RtYL8b7fdpY=;
  b=dKEN8tYDCsqJv+gs7FOLDtfrkueEW/V/zEs3wN3MDFtnDsKcPkR0KxAq
   AmtfkSgkwp9fAW1ws8w4lWOnBufOh/vNBWaV+E4cNeK4NXr5l/zijlRpJ
   OlbfEMS/sFws8C1YAtMLXzaunh4ruoC2KQPYAsqygVRaVnNMB8J3Ydrgw
   pNg+Lo8/a2LlXZ9vk0K5MWnhuc3kwFdRk+eHl2fbtZKh4VCzxRTSwqWc0
   N1UJ0XE6Qv2rfNF+vqAjSug3fZ5cDGv9erOEGgXAH46BsCL7C5Nz3z4M4
   bXfOcqn6TEIDJV/ekNhCxsl5I4uuXmP4jnClj9CvALue2W2LzzeYyEVSU
   w==;
X-CSE-ConnectionGUID: tdSclSQ7T/a7JgwNECJ8/w==
X-CSE-MsgGUID: ZYBDclVvQOC6vnJNODgoeg==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="13132613"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="13132613"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 00:45:16 -0700
X-CSE-ConnectionGUID: mf4Ao4ZlQ/i+M+pcDn5evA==
X-CSE-MsgGUID: OoooltTFT7O9mSRFDTedRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="23959314"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 00:45:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 00:45:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 00:45:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 00:45:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abCx6FwmXEnDgdZQSdF0ZKWOxzb1cADj7JI8+qOQ3M8IO4FhqLE7omm1u3pfX92F+bb9mTrKLLBFQA3EUY4RWiW0Z/L/YPrwBXPsRlyuBffpZZXjPMHGJ66d52WN/yHOiFVttIh4QQ2IQ2C/9gbpvwRTjSK9TR48q9SSH6htPO1whTTYKXSvh6vfjmuJy8zIGRcMdK7IbTOxpR/DByOjOeUVLJlJpgvzme1Ex6bU/2kOzCifgmJTKwDtDLVEbclWSoPBiou9fivonKyRysW96PBwRdU34e3bjLImyhBs6mpxVS86pWUy4S1kZNUx0zbKyUFjTf8yI/9pd6po1zedTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPtUsxqn0pfxrRkWnf7q2dVh/w0IxmwZ0zeAk278wGg=;
 b=TFUQ7e58Kd+QwmDroTUePRrffDUI7lR8A+rpXT5JpW9j3KUny25LZch3YOzWYTH9l1pcSik4lLxtKKUSNmDEU7jfl0k6DAHntcXDyBDxXM5E8wDBHWjZnSyRs8DafmWGTsJo6ywQ6aguJ5STCNg00tJpmUG/M+x1nXUpFe49Yl2lAhMO8D7pWn1MVlhxXg+EC4+U4TxqSF3jTN0o0uzl9c3rdIkzSIBA73XhoDvyNd5/C4QgGidjOD+26Uyu9tv82yHHnrx4vWPVJIEDPbAmUaSi5chE5R3BO8AMzQlbdOugdMUJ1TVlRa/Kyaz+0L3kPREFnIwNmS9jKJzBfQuFwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH0PR11MB8168.namprd11.prod.outlook.com (2603:10b6:610:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Mon, 22 Apr
 2024 07:45:13 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7519.020; Mon, 22 Apr 2024
 07:45:13 +0000
Date: Mon, 22 Apr 2024 15:45:00 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Nam Cao <namcao@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Mike Rapoport
	<rppt@kernel.org>, Andreas Dilger <adilger@dilger.ca>, Arnd Bergmann
	<arnd@arndb.de>, Changbin Du <changbin.du@huawei.com>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Ingo Molnar <mingo@kernel.org>, Krister Johansen <kjlx@templeofstupid.com>,
	Luis Chamberlain <mcgrof@kernel.org>, Nick Desaulniers
	<ndesaulniers@google.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Tejun Heo
	<tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [init]  b8de39bd1b:
 BUG:kernel_failed_in_early-boot_stage,last_printk:early_console_in_setup_code
Message-ID: <202404221524.4954a009-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SG2PR02CA0070.apcprd02.prod.outlook.com
 (2603:1096:4:54::34) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH0PR11MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e94417e-ae9d-4977-5eaf-08dc62a024c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xZuKjNb7DeViKbYdklOqFZgdMXH8jSmS8NSHw+2R2J7Tubqd9RUZT4V2nYCY?=
 =?us-ascii?Q?l85d12XUF6tGSI4/6XnUGSzFOCZPJ/ye/eW+KLEBYh41rkgsjv/QDf/v/LOX?=
 =?us-ascii?Q?/P2W1Cah/5rcE1JhuVTVhsI6zJ9MiWgWn1WCu7zmURM37WsOFoqYG8lzggKN?=
 =?us-ascii?Q?TmtVvbIg9jDsaJLw3CV+pMHblNTKvI9ydBIhs6uPkDm19NgAhPnB5i8EHcvF?=
 =?us-ascii?Q?1K8rPr5BeIQml9zq/xnPIIYJjkl3deWCPE2bZ3gpHkL+l5Us95m1J4X6KMri?=
 =?us-ascii?Q?jMsNBtLksnwZ69qOSMvcybwUIBQrRRn3JXDUhrf+Az5cSw0xFWdS1H/YstJM?=
 =?us-ascii?Q?KtoOZHXDPyTlBr6aTP/r4LkC9y6XUEnzhwlw9yJwbdT90QzHy6qM/W+XdQEE?=
 =?us-ascii?Q?K0TK1Mxyr2u4+Gviyh1sWqVZur/qW6z6uF9CWHAtExh7ykWS/xbkq0QHArsc?=
 =?us-ascii?Q?h9aO7VjmPVJB1KE8bbhc289Uz+n7lWZau4v1oQ8gulctlMxMHTULFRWz+qGQ?=
 =?us-ascii?Q?72P7FN5pbrwk2ljEcZjeEZ3obgPWcEMnrq6beTIpHbRGQrS0K5Z5+CIDh6fh?=
 =?us-ascii?Q?gMF9o551icLSsy+1mLixiOsWhSoRzUXhSkyH/x+7odHLbjBZALjshy8v627Q?=
 =?us-ascii?Q?R78Va2+fGVVHXPdh6BOcE0UZFdMlNm2vCan825U+Y3DkbKsb8T8Jb+lyql/+?=
 =?us-ascii?Q?gZYbam+NzlSznr21BFE6f44lpEao/BjW7laPN5poV0hLkECdG0h3M8Tpunu3?=
 =?us-ascii?Q?WgycRJsEk/EbE9BdElT/SaAnKMDCzy5H6L8bLyUb+sRw/0/43/tMsuy3v2Lq?=
 =?us-ascii?Q?k5o4/xgiIuUhJBAb+znEw3toRHcm0PdU0WG0ezI0Ur8INKZ2VG9bzX14wVgd?=
 =?us-ascii?Q?XJigFxGAO8CTFM+NHl5QGapGZhQaudFWoG1xZgOoL7hi+SuyDwkTgTfefn05?=
 =?us-ascii?Q?phSBf5h+9+Wkli75LjooU6RbhTFOb8h63xT9kE2xa0UvQgeiwS60yZyF8OO5?=
 =?us-ascii?Q?EjOrvX97klRTZXe0W5IbtQc39L2fdX1Yzhup32Mxmqv0oG3T2/JZ+AAOLxMc?=
 =?us-ascii?Q?dXEGCy+3yPJgCI6CHlfqCPH34wAk0ppKNv8tx7n8YaNNH7w2cSqNefc85rna?=
 =?us-ascii?Q?DizmYhWrZfGvR9ohmzERmXbFAMNoAi6i7sP1vz9Tg6lxXfkHO1YAlKdrd/dx?=
 =?us-ascii?Q?SnWApN0pfAaVTt4/ObQoiLyESKWLl+0siqy03aq1MJgwEzDjIVW6nM/C9UY?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rJDNYmxMuLABvHYxf+i7UOHADgGbJzRLhCP2NPz+azNO/jSbe7d7NVVcAe3q?=
 =?us-ascii?Q?mvuxE/6R1jJYaThX4C/4uMQ2oda6wN2lPJHYAfuUKLnYuLlLlCe9hKGUTuat?=
 =?us-ascii?Q?M3wU1IQKhitchbqGkmXGkzrW+2UiVQGkzwWAbZIfLv+LjDj1qRc86NIgQAQH?=
 =?us-ascii?Q?eIHPJL1T/6ZDwvby5UZCeLhb8JEcY+1rbwBuoN3wKVGyKzFZvQDaQI/cg1RG?=
 =?us-ascii?Q?12SwVmHAu5PtjwP5n091P1jy2CiHxiEfRPGEDfwIIag3m6esYinowRMm7QGa?=
 =?us-ascii?Q?umofGUlPoM38LUllMv+BQuo4dF6CAUwiKA3v65TYtRmaQt7Z6tEg1nvv7g/t?=
 =?us-ascii?Q?hWWufUnBFjwTfLYvUp9oQszSsTG1AlL0YqR+y0bENjLInjcY8VmGHAptC82r?=
 =?us-ascii?Q?YahJaqE4dn8DmZATbbRX/TKLFCMtPgK4hF+k5lHNaGHgMqosSpUdoYuTKjIQ?=
 =?us-ascii?Q?AO6zHQbu+f41u1BN6j5H1jITG/Mo9Wc8pC4CYK/B+bEE7AsinYwY3ZmgnlRQ?=
 =?us-ascii?Q?jT2iXN5Msy0ej/pwkG2YxeH2aii2VicRToUoOVZeLq+H8YLljV+2/nocgZxF?=
 =?us-ascii?Q?r8y5bvCt5OeHBauACUKSAJJUJH5XyKqq95E5xIRO/MZNgHRubiJnYuHZS/E3?=
 =?us-ascii?Q?0ESovjK9bbJrppNpwHjiQggzV6NA58SJKqlXADF2Ja1C0Szhbkdd4ZlpjQEN?=
 =?us-ascii?Q?EJvR3z5w6V+Ejv1B2lXqGWv4fhu+9l0MRwaTWONHbPnlVVpbr3o3l/d9GQDo?=
 =?us-ascii?Q?1J9DSG6TRN4ZFLKworZUVJhfcWGibOlCbQW1C4ffmjaVLhJL6hei+IE6hQOY?=
 =?us-ascii?Q?W2i8+fN9hgi1rUvZl9kehB+C4HfYUJLkSnYWA/0XhnT1qjzmqovAbtm/DXsW?=
 =?us-ascii?Q?s7IjnBYUEHK/sltPqtJFFK++1spbXQlQGKQg8zZieXb57mARZtX829WF3G8J?=
 =?us-ascii?Q?dF966vxcqi3iZklQtY6Q8v9KJ//92LAZx16awBotApGc0A7O9/0b7UDvxyIC?=
 =?us-ascii?Q?rmRtA0xzyHVG3rD6W5jgSZmXhwltMEtFFuz8pLj0JRdebqXTIijZue3COD7a?=
 =?us-ascii?Q?7GIWW94JToF64pl3s8uYBc9qMzTHzjkWhK63UdzDLmJJEmDYqtFqb161smyQ?=
 =?us-ascii?Q?uNQODoxJw9YKo/L2tHztPPN5CdMX/rtM4Og9EXzzeluE/OW0pzXqqVVVG0Q3?=
 =?us-ascii?Q?KuosXYMU1mGVdaI8G3JK0hLe39MyHkoVz47dB/Uajtmzft8a1zcLzDoOn0D7?=
 =?us-ascii?Q?VD+3g530zBGC4kLgqxs39v8lfMPHfYSfcowFz9fs3Xhrlao1q999THs3fc0e?=
 =?us-ascii?Q?gU6OkqhXo86WYauanB3V3JThwSPdgpNe3fna2NxQQcQPptKA2eWgZwdUBJV4?=
 =?us-ascii?Q?RR26rY4MnU5gWmQKE14S9oDBRGjVRcJl93SLuHNciFFvgDr2w9xpzTkJH9Ub?=
 =?us-ascii?Q?w+Y4qfKFpVK5OCxtDQIPXEqu2rw9ksD83Mr0yvHOwqp/JCWMlmMGhvNEIisU?=
 =?us-ascii?Q?ragUR4soCFsvZiDLMarN+ddIEbrHD4XBNRmrG6kcguP/IobZCcI2MizLFEne?=
 =?us-ascii?Q?fkH60fhq4uLJ4F4dekpd7C9Wl0j78x6v2VTeQgsMR4UVqsS/JXCnanxl/F4m?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e94417e-ae9d-4977-5eaf-08dc62a024c1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 07:45:13.1653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tH+3hF0PbJ3Ihq/PmfHxkl37j/SgLQ6MUMUIiassx/unKAKgdFUNA0FybdK60RCXqOTC/ngiYLkzJS2HV1WN+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8168
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_failed_in_early-boot_stage,last_print=
k:early_console_in_setup_code" on:

commit: b8de39bd1b76faffe7cd91e148a6d7d9bf4e38f7 ("init: fix allocated page=
 overlapping with PTR_ERR")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master a35e92ef04c07bd473404b9b73d489aea19a60a8]

in testcase: boot

compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------------------------=
-----+------------+------------+
|                                                                          =
     | fdb74eb6c7 | b8de39bd1b |
+--------------------------------------------------------------------------=
-----+------------+------------+
| boot_successes                                                           =
     | 12         | 0          |
| boot_failures                                                            =
     | 0          | 12         |
| BUG:kernel_failed_in_early-boot_stage,last_printk:early_console_in_setup_=
code | 0          | 12         |
+--------------------------------------------------------------------------=
-----+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404221524.4954a009-oliver.sang@=
intel.com


early console in setup code
convert early boot stage from hang to failed
BUG: kernel failed in early-boot stage, last printk: early console in setup=
 code
Linux version 6.9.0-rc4-00031-gb8de39bd1b76 #1
Command line: ip=3D::::vm-meta-21::dhcp root=3D/dev/ram0 RESULT_ROOT=3D/res=
ult/boot/1/vm-snb/yocto-i386-minimal-20190520.cgz/x86_64-randconfig-003-202=
40419/gcc-13/b8de39bd1b76faffe7cd91e148a6d7d9bf4e38f7/3 BOOT_IMAGE=3D/pkg/l=
inux/x86_64-randconfig-003-20240419/gcc-13/b8de39bd1b76faffe7cd91e148a6d7d9=
bf4e38f7/vmlinuz-6.9.0-rc4-00031-gb8de39bd1b76 branch=3Dlinux-next/master j=
ob=3D/lkp/jobs/scheduled/vm-meta-21/boot-1-yocto-i386-minimal-20190520.cgz-=
x86_64-randconfig-003-20240419-b8de39bd1b76-20240420-48196-3fymo-3.yaml use=
r=3Dlkp ARCH=3Dx86_64 kconfig=3Dx86_64-randconfig-003-20240419 commit=3Db8d=
e39bd1b76faffe7cd91e148a6d7d9bf4e38f7 nmi_watchdog=3D0 intremap=3Dposted_ms=
i vmalloc=3D256M initramfs_async=3D0 page_owner=3Don max_uptime=3D600 LKP_S=
ERVER=3Dinternal-lkp-server selinux=3D0 debug apic=3Ddebug sysrq_always_ena=
bled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3D=
on panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_r=
amdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr =
ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,1=
15200 vga=3Dnormal rw rcuperf.shutdown=3D0 watchdog_thresh=3D240 audit=3D0



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240422/202404221524.4954a009-oliv=
er.sang@intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


