Return-Path: <linux-kernel+bounces-147883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB078A7AEA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D126283F9E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603FD79C8;
	Wed, 17 Apr 2024 03:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nmde2R3t"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733B079D8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 03:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713323538; cv=fail; b=Zd2OGGnU0fxrzQ/DplncUJ4gLSf7HkomKFfbtYY5ASjcYWjJerc1JyBEDQQd8NmzHjsT2OIgpWPpZNLzHGeSkDK3+I04ALqw8h0wdHfa4+yDFAy+hh0g5ZdaV0EhlxBIJS3VLwAaIZ6MB1syg8NDEAsVNVrMXXqLSwhGZyAeteM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713323538; c=relaxed/simple;
	bh=DtXECkapG113dHsNyM5tIDdQ2rBCkC5CoeDPbKl8BDc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=q1ENPazVcQVi+ORnlleFwnKr6H9QJxkKK6S7uEXmCRjZjIxeUkheDI5As9YYnBwXPcBe7+67iQAFpCqsOMisYcZXpBomfLLuZNcuDdiWY0ZIA1NMo1oK2foJEvTvLoQqmHb4eCvEFwWazprHD+zcaNiCxP+gQeIm39gNmAgr3/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nmde2R3t; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713323537; x=1744859537;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DtXECkapG113dHsNyM5tIDdQ2rBCkC5CoeDPbKl8BDc=;
  b=Nmde2R3tmsjK8H2Jh43n3oEBk0LOr87WqEi16eukmWMUoezeLLhtZsy3
   MYKYu5tuzbiq0fNtVLFBCa4ddvB6urbpa1uDKgUkDORvyIVmeJnu4Olw9
   MTOH6JmGoQQqkeF32IobFmo2YXKSFOhMGWCialg02CUy8qJY+UlE0ghvc
   XqKK8zpoZGC5TdQTapO6OrknIyo8CNcSE1BGaIg1sUJ8LX2wELHurTPEd
   SVX/bSw02doj3yYJzoFPYn+OqAqiYDHG69KwZk1VNWcf9NrEeTm657hRW
   gM7SM4uGe4UUiyofq1oqeKjJG31GxbbmizjZ96GQ4RigPaecg0jur/ZLf
   w==;
X-CSE-ConnectionGUID: wCHSwlTUThaOkT7ZLa/lJQ==
X-CSE-MsgGUID: LEvvaOf6Q6ii1BiBz47dTQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8722052"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="8722052"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 20:12:16 -0700
X-CSE-ConnectionGUID: DPrBaV4rTSWCzpN6FLm8Wg==
X-CSE-MsgGUID: 34EYDxegQ/CzbQ1Ronq/hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="22551009"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 20:12:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 20:12:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 20:12:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 20:12:12 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 20:12:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Os48y33SkmvJiw0p6Ogdk9g1wNaS7t0qg2njOh7Bgtxl3KP0Sn7lVn+W0wV0zNzcPAlhS81Xtdd1HbThCuGpNkCDJ1XwItKCgK3mB4VJtm8xgIHEmaeEbUd9atNQxqyaMYQoFwtcsIyhhQrhtujOKazBj/576ZLpr/0h9MtPFCDNWL7n8rHTDQkbcy1iYxPNJ+GhdKAMOt7yA7g2jij+m8QE+61sEVlbpqsIvlN7Nj+e1woW2pLOTIiRLDuiuN7DVHAtMPfBat/8QNxsaA9HzQjKk1Fflimgi1jPKKlf2wO6t8HBoz+e6Q2RyBZD5HcmEqdrt0MPTDifij3rfyIg6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCuocoTZ+PdSRWB4flsB4DO4BYFoAl3to3s+q76aKy4=;
 b=njwXwQoSkRDW3pKL9u4lHUcKC2uNXLm2OjetK5oikd6zVYRUH6IbHJ2+9NdWOn9/9+SCIKz7EXlE9oGBdM6D11PcRoZ4iSCrn2aXrpPibO1ZOne8mvgt6XPoO7VM7X/pbVuVCnc5V+VD0mD9V6GTaAPlhZNz0l1WeLCylD5oRPEbW1/ROa5QfK26NSNBytwsxod7t6EvNiCYqS+i8rJz2uzdI5un6g3Y1BwJoWbkD1m+tQRpBWk5CwVYYqHScYjNTe9bXr897n/eBdi01Nftpw6x17AYXaesa/bc3FiqL54IfPvXhkjLkKylqfUMi/qCIKzqIKZRQq8WeGjiMnrzHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by PH0PR11MB7445.namprd11.prod.outlook.com (2603:10b6:510:26e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Wed, 17 Apr
 2024 03:12:10 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd%6]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 03:12:10 +0000
Date: Wed, 17 Apr 2024 11:05:34 +0800
From: kernel test robot <yujie.liu@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Kees Cook
	<keescook@chromium.org>
Subject: ./../kselftest_harness.h:1152:30: error: format string is empty
Message-ID: <202404170611.Kkkdkvdy-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To SA1PR11MB8393.namprd11.prod.outlook.com
 (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|PH0PR11MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 4758f520-1f2e-4693-80fd-08dc5e8c2b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EbU+LLgt0s7tqXIUHEcI+KdnDuHjPSjNXUn1+of3dEqPQdfWU8FsH2IlT9KJ+ejOC4GBHqgDgaT7O6xDmIrGtvZZ/s9EQvqfHmvn1nMFVxoRlJgeGVnsKajX+ZzWquCAMHAC9ans5fXazmbbjE0vErTOv5tHTywsd4AngfPAX199sVR/cr4oWNSegus0CJMXtZtGHWwdgFBSsld4lfiMdN/ievvZHNuBFk5QStT3HffDmcwglIS2jt2CjF+5lF+hCll0exM9bjJTWzknf5Yy2bPAmJfjFwbfZIfL8Ab3NZ2INtiWdEeqXQsDtgXrOPhqb7TYsBspUVbiwp6J+pdvPezexgDVWQYgJKPN579n1BB79M3JY36+atwW16F6GxdX4j5Bv+8O65YqxRZ4FF1LM7sgmpsQEctzlr+FI5cbPNR2TzmGlfVfp6h58ExxKbnhmGArbj2XazQBf15LJSXUooCEZL9wrk57nmdWtpO/SQCZvbhblayiRPIEioHykPuqOQ72XyD+QMlCGTrSwJZHZ2r89iQ8wS/mWaNm9xN8lQFL8MGYnQ10tnOAs4GpLkXlss6gkyqudQoKKfNNtgBBJeR1OkE+0tlXBTZfxJjKroSB+PssG9qBH6RCRiT81BB+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wU+fOozWZoUDVWOEIRc2eGzNVYtd5Fof5VSjjFj34vConXOKffYFlKO2WdkN?=
 =?us-ascii?Q?Z++png0+J8vTXYKyyl0pMFigzvZXMCgtf00K4DQ1VyraFMAdySUEFrV+qt/Y?=
 =?us-ascii?Q?2cBFGJq5Kwqac/nQVFlU/isIVTbBX6ZPDuz0HFwzLnV+C5n7ygZ1s4zLEr2d?=
 =?us-ascii?Q?ONTOogU8ZD3WcOKOBeCrZcIjdMLTvA8akiyGPOrxWl4pl7cqDnu8119uWpLq?=
 =?us-ascii?Q?xN4AzF1v2bsbAzL76tswIpw5OBkK3bYdL1XAVTe71dIPhR/7U1y4LBEZazrB?=
 =?us-ascii?Q?GDgxtr7kZ3/2kIz1aq/8OEQOS2OZESYf5ITzXLtNRzqjjzWT6vZSQxDIKw06?=
 =?us-ascii?Q?E5+TgncU+zyAQINU4P+ku8+fvPc05/EhhQjI00JXqAIY1EQ82oYKyYUbjh29?=
 =?us-ascii?Q?dBW0pTacOGIiz8SKzWGUpJoLhw6ZMjwNQWYK6sGE57Gb8Ow3jELEHT2BpziW?=
 =?us-ascii?Q?O17vkEYDRvxHHPXh7JXI/QynnVIjEIvFEcMjDn6EglbQumT+raKqXCVo6wYq?=
 =?us-ascii?Q?xmqv8YYrhBYF5kD/RvXQwfan/YKsPDyORKe1SvIegiS1YjwBZ8vPD45jRYR7?=
 =?us-ascii?Q?F765esGGC2BVHn+DeUI1X9PLhyvegJojgsaqp/bOEp4k1ZTZca+KYJtPVpUh?=
 =?us-ascii?Q?3G1zNwLyPVqyIXNAGbuDO+PGdvYDND9GW7IeqW5mxOKiwpmrBzr5y7A40qrC?=
 =?us-ascii?Q?drV03OpLASlH3wV9U5t5c8arVoqxaIiI1Tm2Imj8n5xubxa9vyRWRCcKtBS/?=
 =?us-ascii?Q?TubObOFJrxrRgI5g2KzIkt0rk8pmLNNGYYPsCszdgUdwcbJahECSdnakvPxz?=
 =?us-ascii?Q?CEh3/GFIQ+aFHUznqediPXV3KyuZRnxWDci/TDW+B3yzGsabJvHw9P3V7bXR?=
 =?us-ascii?Q?E8EaIk330f5hizT+lceu0TFh1/H3e2B3kBvqHAKEzKDZahptZi+Nr5xRddcQ?=
 =?us-ascii?Q?wsWYFQPTM6wP4yTlI4rcJ2VWqMc8Tz8zECMtByeHiSDCARJLeJRYy97gHJvd?=
 =?us-ascii?Q?2fnNLE0ZmHglMuKZDh3UdMld2fm1VF4r+477UuNz+bwWDCY9hck5KBt0ZkRt?=
 =?us-ascii?Q?9FEP1eewYN5uncp1HIQBCJldP8pQMNKiQLzf+aGvzno89dZij12+tq5xZ8HQ?=
 =?us-ascii?Q?jRd/qpSz+zK/fxbT+jwr9kFyTH3nmZ7sJZmvRZXLOe+Gi1dMkOysQifEJLwe?=
 =?us-ascii?Q?3NB7Dp891udmo3+ynEmnXKMjGlcc5BD3bJB7JGxgCdX/UCR8SV6INFnygPB0?=
 =?us-ascii?Q?AZpJj5vNS4VZvxP2e/5J+boC+HvPLJ4z/3mKK0/Z33IVZ0O33rVm0iPiulx5?=
 =?us-ascii?Q?WfVAP32FVaT3vRKc8I3nEhTLxB/olQqBrBcydNSkaXHeBqzr/9O2u8yxPiCp?=
 =?us-ascii?Q?fABxsVZo8cuzFhbThePug8FIPwAupRZSJhB/1EXVkXVu46gPqSIW7BQZSAU1?=
 =?us-ascii?Q?/tXfPSfJPKX4JOQ5jH5/iUkgLQnhpaIlFdr6r2iVWufdwCyIkuXvWbxhkDyM?=
 =?us-ascii?Q?orK0phyTWUoxLLkmRv0gMz7cAK0r99aN/JrovCSq4lrWl0Qy7VOcBdqjcXec?=
 =?us-ascii?Q?vv56pkW983WkIclwvuWbUPbilNPTcFY4Ja5z/nsY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4758f520-1f2e-4693-80fd-08dc5e8c2b59
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 03:12:09.8081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1AmDZajfAQ1bdT+024X8k6Vj+GC7BBWuj7azQYX7cVbxzYiwiAYaV0a0fh4sK0TJn7AMhPWdMYnaKFEqPDhVcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7445
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   96fca68c4fbf77a8185eb10f7557e23352732ea2
commit: 378193eff3399acb8529d0b553709e8f91d34fe3 selftests: kselftest_harness: let PASS / FAIL provide diagnostic
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240417/202404170611.Kkkdkvdy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202404170611.Kkkdkvdy-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from hid_bpf.c:5:
>> ./../kselftest_harness.h:1152:30: error: format string is empty [-Werror,-Wformat-zero-length]
    1152 |                               diagnostic ? "%s" : "", diagnostic);
         |                                                   ^~
   1 error generated.


vim +1152 tools/testing/selftests/hid/./../kselftest_harness.h

65177e47d3035c tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2023-01-25  1108  
142aca6b388c8a tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2020-04-27  1109  void __run_test(struct __fixture_metadata *f,
74bc7c97fa88ae tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2020-04-27  1110  		struct __fixture_variant_metadata *variant,
142aca6b388c8a tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2020-04-27  1111  		struct __test_metadata *t)
f46f576280595f tools/testing/selftests/kselftest_harness.h    Kees Cook        2020-03-13  1112  {
38c957f0703827 tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2024-02-28  1113  	char test_name[LINE_MAX];
fa1a53d83674b3 tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2024-02-28  1114  	const char *diagnostic;
38c957f0703827 tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2024-02-28  1115  
74bc7c97fa88ae tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2020-04-27  1116  	/* reset test struct */
69fe8ec4f673b5 tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2024-02-28  1117  	t->exit_code = KSFT_PASS;
f46f576280595f tools/testing/selftests/kselftest_harness.h    Kees Cook        2020-03-13  1118  	t->trigger = 0;
0ef67a888375b0 tools/testing/selftests/kselftest_harness.h    Kees Cook        2020-06-22  1119  	memset(t->results->reason, 0, sizeof(t->results->reason));
74bc7c97fa88ae tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2020-04-27  1120  
38c957f0703827 tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2024-02-28  1121  	snprintf(test_name, sizeof(test_name), "%s%s%s.%s",
74bc7c97fa88ae tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2020-04-27  1122  		 f->name, variant->name[0] ? "." : "", variant->name, t->name);
c8bd596f9388bc tools/testing/selftests/kselftest_harness.h    Michael Ellerman 2020-09-17  1123  
38c957f0703827 tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2024-02-28  1124  	ksft_print_msg(" RUN           %s ...\n", test_name);
38c957f0703827 tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2024-02-28  1125  
c8bd596f9388bc tools/testing/selftests/kselftest_harness.h    Michael Ellerman 2020-09-17  1126  	/* Make sure output buffers are flushed before fork */
c8bd596f9388bc tools/testing/selftests/kselftest_harness.h    Michael Ellerman 2020-09-17  1127  	fflush(stdout);
c8bd596f9388bc tools/testing/selftests/kselftest_harness.h    Michael Ellerman 2020-09-17  1128  	fflush(stderr);
c8bd596f9388bc tools/testing/selftests/kselftest_harness.h    Michael Ellerman 2020-09-17  1129  
f46f576280595f tools/testing/selftests/kselftest_harness.h    Kees Cook        2020-03-13  1130  	t->pid = fork();
f46f576280595f tools/testing/selftests/kselftest_harness.h    Kees Cook        2020-03-13  1131  	if (t->pid < 0) {
e80068be21824e tools/testing/selftests/kselftest_harness.h    Kees Cook        2020-06-22  1132  		ksft_print_msg("ERROR SPAWNING TEST CHILD\n");
69fe8ec4f673b5 tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2024-02-28  1133  		t->exit_code = KSFT_FAIL;
f46f576280595f tools/testing/selftests/kselftest_harness.h    Kees Cook        2020-03-13  1134  	} else if (t->pid == 0) {
92d25637a3a459 tools/testing/selftests/kselftest_harness.h    Li Zhijian       2021-12-17  1135  		setpgrp();
74bc7c97fa88ae tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2020-04-27  1136  		t->fn(t, variant);
796a344fa4315f tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2024-02-28  1137  		_exit(t->exit_code);
f46f576280595f tools/testing/selftests/kselftest_harness.h    Kees Cook        2020-03-13  1138  	} else {
f46f576280595f tools/testing/selftests/kselftest_harness.h    Kees Cook        2020-03-13  1139  		__wait_for_test(t);
f46f576280595f tools/testing/selftests/kselftest_harness.h    Kees Cook        2020-03-13  1140  	}
38c957f0703827 tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2024-02-28  1141  	ksft_print_msg("         %4s  %s\n",
69fe8ec4f673b5 tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2024-02-28  1142  		       __test_passed(t) ? "OK" : "FAIL", test_name);
9847d24af95c7f tools/testing/selftests/kselftest_harness.h    Kees Cook        2020-06-22  1143  
fa1a53d83674b3 tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2024-02-28  1144  	if (t->results->reason[0])
fa1a53d83674b3 tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2024-02-28  1145  		diagnostic = t->results->reason;
378193eff3399a tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2024-02-28  1146  	else if (t->exit_code == KSFT_PASS || t->exit_code == KSFT_FAIL)
378193eff3399a tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2024-02-28  1147  		diagnostic = NULL;
fa1a53d83674b3 tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2024-02-28  1148  	else
fa1a53d83674b3 tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2024-02-28  1149  		diagnostic = "unknown";
fa1a53d83674b3 tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2024-02-28  1150  
732e2035280bf4 tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2024-02-28  1151  	ksft_test_result_code(t->exit_code, test_name,
378193eff3399a tools/testing/selftests/kselftest_harness.h    Jakub Kicinski   2024-02-28 @1152  			      diagnostic ? "%s" : "", diagnostic);
c99ee51a9d9716 tools/testing/selftests/seccomp/test_harness.h Kees Cook        2015-06-16  1153  }
c99ee51a9d9716 tools/testing/selftests/seccomp/test_harness.h Kees Cook        2015-06-16  1154  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


