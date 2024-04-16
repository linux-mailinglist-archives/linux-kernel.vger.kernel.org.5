Return-Path: <linux-kernel+bounces-146318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18468A6375
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106E21C209A4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81493C08A;
	Tue, 16 Apr 2024 06:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a78/m42U"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D066339A0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 06:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713247792; cv=fail; b=Tql1cuIMa0Lu9HA6ta1XG2xqsbNoVzrpGqqY2YaE6sE3YN5mAbh2uDTUE+J88OJ6UZnCbHt6/v5SPpNnt7PrTHfpBVt5ecmqoUSmCG/XMDO1e3A74GewZbOPpIxSsL9PgmLpFMZGg/uF0kaIELGp7TKgkOeKFfxD9ARtw4CD2Rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713247792; c=relaxed/simple;
	bh=L+HPnGKiIsW2w+3stdhxWs3gx+UhDpnL1blpDqHShpE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WY37W++MUPCtsSUtMT6qjnxYiVDh1fg5DaVdj+gBO2QeugVotu5dSqu19nHVYwz+aAjtYL7Jargpz7uXiXMrUKhxrFaBhFuLMfeTpUFhzIX4NT40xlY+Gs6ASsxZhPP6lb0BD28EZnd9s0YZMiT++BxFAg1yDBzFzHxWihQtIoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a78/m42U; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713247791; x=1744783791;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=L+HPnGKiIsW2w+3stdhxWs3gx+UhDpnL1blpDqHShpE=;
  b=a78/m42U6VMz9zyVLWPKZ6hZHjxVks4VVBS5ZN+xkLHxForWVThFQXho
   +MDfcbxC4wAC1jpQTbjQa279C1t2ByUHKgchR9Mu2enO498GKNPilAuTo
   WhYhw7krERQN2XjKcjyzOE9weTZ8SJn2r22H92ptyyrZRKEMcS8oWNvd2
   RFNiPzhQlEswdA0Xd7nFQE4j7usExrQISMeCulebhGNuOx1rbbJWYPBE/
   +XKjmOifEq/IUWxZJUpXo/CoAMRwwL5+Sae+6yZd5xbzNgKWGx1paYk5p
   fu9uz4UZWQeQamt4q73P5YadHKilWeGAdS3WtfO+hZrvsxAiinPO32NAQ
   A==;
X-CSE-ConnectionGUID: /v5CVv6QRsGz8NPdC24ZpQ==
X-CSE-MsgGUID: TwUrPI2+TLm1DaIv44TSMQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8886011"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8886011"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 23:09:41 -0700
X-CSE-ConnectionGUID: jx7IlWdrSJyOTWEypt+ggQ==
X-CSE-MsgGUID: 7RqaRfu2QVu+JsdllXn8ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="22217830"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 23:09:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 23:09:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 23:09:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 23:09:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 23:09:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StC+LygvouzmqZshmCNVZTTyuYwVIx/TQ5mUy+NBiC8rgGCYqS3tQr3VsPM31uMfgYhjZoCV1QkisxgkJsPa/YqddqE0uuk+5bvUs/NjikGzhp/sokkyEJUtKKVtnlOwjnlogp1Clh7YvUpAZugmOWP/V20DWoDHbtY3asAppdGJx/uVsA6nWuL0Vz0rqXHM+dJdshyP1UDd8GuArBug9H7tM2GqVgyvlQEcwLiWKm2g05V+6nn2QWYAwrNEypD0LUNCxD/QIj/6aK0Rq7EeRHoSaYd9UTioQ7WFaHYC4Wt/hkFV+dO16i1M7vPISkmNddviA7q44BUZKT8D1WC2VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpG3wrLmlp4VH15EIWZOc2juzw7/RxFIrPdz/gFNo58=;
 b=bgBbxDfJ7GHu2/nJbK5F5I6R4VHM+s7RYC4VgG0jy8SVOwnNHJN3eLYOnZIfaY5W04l0FF8VrQUl+eryUHh4A6tfbWktbwcVf8qoz0HKV58BemoLowOwCmKqsTzdYjfHRrvacwrsa9dXUM6RXYlx5ZkohYES4Hgy5vkss7JSl4Kp3brv09dUDFoGegLLu1DdGb8p948oZGId7wCzI1BlUqLEJaACFikGbPPWv5TENEMlUdqtpuzMmAnTw7Af6yq6D3V5BZan3Wsaygubtp2f2dVVCHTAtSntiKAunCO+xtbWSJ5nmGqP9/l3FMsgD5QGrcEgK4PhuDaIG0ykQ+O58w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5029.namprd11.prod.outlook.com (2603:10b6:510:30::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Tue, 16 Apr
 2024 06:09:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 16 Apr 2024
 06:09:38 +0000
Date: Mon, 15 Apr 2024 23:09:33 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 13/14] x86/sev: Hide SVSM attestation entries if not
 running under an SVSM
Message-ID: <661e161db9034_4d56129418@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <67893f352bc54de61160bfe251cba0bdf0431f37.1711405593.git.thomas.lendacky@amd.com>
 <1f6f4477-0f2a-434a-8c89-3b5d51d61581@linux.intel.com>
 <19d69960-e548-a2e6-87d9-c463f2851613@amd.com>
 <e286883d-40ef-d749-26a8-7ec6fbd81eae@amd.com>
 <81d05bd9-ef8f-4a3a-a5df-384a82be49f5@linux.intel.com>
 <490a6a10-47d0-0689-432a-cbf22de11ad6@amd.com>
 <7e138229-24bf-447b-b8dd-5340eaa939fe@linux.intel.com>
 <eb745e16-b3eb-0e9c-59c8-45aa01244386@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb745e16-b3eb-0e9c-59c8-45aa01244386@amd.com>
X-ClientProxiedBy: MW2PR16CA0066.namprd16.prod.outlook.com
 (2603:10b6:907:1::43) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5029:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a3a271-d6d3-45b9-d17b-08dc5ddbcbd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tfMiuBAFTgtev/Z3yPt7eD5x8mlRNIMM9zubgf8MqJCXbHK2OAn5focUJXNZnfgQMeliOLdvYH+fio2T1/Kd04I+dRz6BK9foZX71Ui0k7F48s6j/muCbwIXEDH5Jsu3EIOgKlpdDA8J5wUmhnf0YRJIh0vfB3K6Z/E79g1TCbJ1X+vMnX6a65bvHw7YW51SiD59J1/l9Jcao96Mpt+whT3ARqWz7xfp8eL8k4DycpQQu2nPyii0mozVd2Q8oCo9MkC+PQChlAcsyg+jhN+aG3nHjksp1RtzgmGqfxiRUQtVg9oUGS13IQpXThC35HzSdnvRgHCxVMFEKAEyMqrhr8N+Qspxp+tqShWxn0tSKfqHXD/WUa/h2IdHSvGJiVe2vp7abY/yHAwpzZlnRcX3A94hcXqb3EsRrGIwwlq88EOGSsWEaz+Bi4/IskbIc0QjIzdzmTRhXX7JuLsNYMXNl/6wO4i/3DPAmahftWGrGC8ubEdxnzgxFweoCyZS7+s13C/tyVxe+LGO9m1vW87aMaLpo+Y1Z0dSY1F6T6MVqGcvwlaTrpREigh1fKHyhOfvwapeXZudY/To015avSYkZXutIprE24ozjHoIGNvKGI30apasAqqF18JPwitTsuIVxtpbT467wyUGuPLs55d9LFHBwwvU3CzsAHKmnEZr9l0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?yq04rwhRxmHFO+jHsxV19GycjUyb3NmuIAHmd+5kPgphUn0ixD6XjLVPy/?=
 =?iso-8859-1?Q?4D8bl7MA0EnoCnxIlgW0XwPXKnmTy5QGE7f4c26u8Yx68WWeKpIS5OBJYc?=
 =?iso-8859-1?Q?voulioqk/TyAaZtLIrUGy7mdDF84jhM+rSnHjYd4wEUkp/1bU+GXhBnhtq?=
 =?iso-8859-1?Q?30K8WfoEjiysdqz11NQvMBYrQmHsy9s3qgL3y4p+6VTyGmJndXD5GPiQ46?=
 =?iso-8859-1?Q?9om4c7WSGchVYRcpjinTi8M1XIQVZtxTGZKnwtRnETSwv+6lJnEoqnPrxN?=
 =?iso-8859-1?Q?oLOvzN6UOT9Vd6RKTY6f2jPPbG7BdfquYAZdSRG+7t3G4PdZhHwlAbYEai?=
 =?iso-8859-1?Q?UjlnK+1ofwZZwaA2WAyxYcMFqpWRPSJiPslabwNB8VCI1eIffX8gPyBM3p?=
 =?iso-8859-1?Q?USwSIHMw3gN/tSNYj6TLuR+NX1GBtIMUXKm9iYazveg/U+XG779IpsCuXX?=
 =?iso-8859-1?Q?khIt3WVEHNLOk3WGLKfopqEAdwdHeVondy+99Gt7KF+5baeewb/NXMOdon?=
 =?iso-8859-1?Q?+0bAM1MxF9ck7wPJCwsI6vU/AxqCQnUrB1YUAOJZFmHZ2G6eCy4VdrW1CH?=
 =?iso-8859-1?Q?ePGExTfDM/nyFSdfCbpS9UzodnEfa1X8j3VB0QrpoMaOUcEK+lLJ/444Wy?=
 =?iso-8859-1?Q?2SAVZ1Y12mA0vh6+PrcUTlcopFixskplJccWmbkXw1vgeD84AbATmTpMGh?=
 =?iso-8859-1?Q?w0/inpTMgdtnuCtqu3qRmpywj6+bFctLPLRvtkrJb1yPlu0kfhzl3p9QR8?=
 =?iso-8859-1?Q?m7DlPdHoUOSsascrrVHZLoRO0S53lULz/5pEptiF22fFPIoWX5RUHP+N+d?=
 =?iso-8859-1?Q?xg1gZqrThZcksQfVZcGqxHJi7UWm3yHRbIo965EeCGfsI5wL0K/0XacPG6?=
 =?iso-8859-1?Q?Xw3/ApiQ2oPMTDlhw87eXvleU7ZjxRDDIEicb3SROJkz4hX15O0Erq78Ye?=
 =?iso-8859-1?Q?TJLNBZLaWxDEVIjaYU+H1VmKAKLOLdT+JhKH9GQySBh+s4IE4rmZeag8dx?=
 =?iso-8859-1?Q?Rr8NdPr8TUH8aZRbMnSfLZkh49BsW3FFbeOXAJ+vOmePh/SSjMDbE0Whv/?=
 =?iso-8859-1?Q?sYq57f0KueUWGTQlWtDmfJ/l1vy66RMfKg7CM5X0UJxHndcp615ACQKHK5?=
 =?iso-8859-1?Q?TUGNAiq+U2D3shtFAh+fdN/WrJCRAC7gMLOq2GUr5CZDF3MjwzsH+JDSxh?=
 =?iso-8859-1?Q?DluJKMjKV53CBPthcJlbvU/PzK/I9WvcJwWCoeB7zcBbXE9xBmDEm154RT?=
 =?iso-8859-1?Q?7oILTWsZ14UCIBSDVufu9A86E8Hhmuv+mO8EgUVCYc8bXb9jjgLRtAAIIt?=
 =?iso-8859-1?Q?bc82TwXObRtxK0uhUbkupsE7PbHNxKwiCABISrDsXsD3/RZj38ulxjE8GK?=
 =?iso-8859-1?Q?Qvu5+ofv1XgKuinL/eaeIsv38BmsNBptM7lXJeLlUwqu4sIjFTnovfv6+X?=
 =?iso-8859-1?Q?J+s8R9Xsr3lyLmo73QCnQ5px6DpNIprA8o0/hASrHnIRmsVPYb2BtcKcd3?=
 =?iso-8859-1?Q?rwiU3vllJXZ6RrhjCglbu/KS4oRt1l93RzK9/Tg5bVehad0Ch7wcg0ihaQ?=
 =?iso-8859-1?Q?1Vw8O8AfLKvF2911+BLfg7rV3PaccjpS86vZQTx1tIpa+4dp9OQkR7BpY+?=
 =?iso-8859-1?Q?TiIYwa3U/q2ihmeMP0Ni1a2Z2b2QlQYCQ87GrEDk5oj/xWMC9bWtWKFA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a3a271-d6d3-45b9-d17b-08dc5ddbcbd2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 06:09:38.0563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdHu+ZIr8dZZ/prQKN4do5fyNVHdxIVUWRgcHNPkTbBs5t6rcVVNuHfchOzApiDLHV6Jf20t8qPz/PmFggScBZpVMU7dN5slZoQ5k6x97QA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5029
X-OriginatorOrg: intel.com

Tom Lendacky wrote:
> On 4/15/24 16:50, Kuppuswamy Sathyanarayanan wrote:
> > 
> > On 4/15/24 1:13 PM, Tom Lendacky wrote:
> >> On 4/15/24 14:48, Kuppuswamy Sathyanarayanan wrote:
> >>> Hi,
> >>>
> >>> On 4/15/24 12:16 PM, Tom Lendacky wrote:
> >>>> On 4/12/24 10:52, Tom Lendacky wrote:
> >>>>> On 4/9/24 13:12, Kuppuswamy Sathyanarayanan wrote:
> >>>>>> On 3/25/24 3:26 PM, Tom Lendacky wrote:
> >>>>>>> Config-fs provides support to hide individual attribute entries. Using
> >>>>>>> this support, base the display of the SVSM related entries on the presence
> >>>>>>> of an SVSM.
> >>>>>>>
> >>>>>>> Cc: Joel Becker <jlbec@evilplan.org>
> >>>>>>> Cc: Christoph Hellwig <hch@lst.de>
> >>>>>>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> >>>>>>> ---
> >>>>>>>     arch/x86/coco/core.c        |  4 ++++
> >>>>>>>     drivers/virt/coco/tsm.c     | 14 ++++++++++----
> >>>>>>>     include/linux/cc_platform.h |  8 ++++++++
> >>>>>>>     3 files changed, 22 insertions(+), 4 deletions(-)
> >>>>>>>
> >>>>
> >>>>>>
> >>>>>> Any comment about the following query? I think introducing a CC flag for this use
> >>>>>> case is over kill.
> >>>>>>
> >>>>>> https://lore.kernel.org/lkml/6b90b223-46e0-4e6d-a17c-5caf72e3c949@linux.intel.com/
> >>>>>
> >>>>> If you don't think TDX will be able to make use of the SVSM attribute I can look at adding a callback. But I was waiting to see if anyone else had comments, for or against, before re-doing it all.
> >>>>>
> >>>>
> >>>> What about something like this (applied on top of patch 13):
> >>>>
> >>
> >>>> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> >>>> index 27cc97fe8dcd..5aaf626d178d 100644
> >>>> --- a/include/linux/tsm.h
> >>>> +++ b/include/linux/tsm.h
> >>>> @@ -74,7 +74,20 @@ extern const struct config_item_type tsm_report_default_type;
> >>>>    /* publish @privlevel, @privlevel_floor, and @auxblob attributes */
> >>>>    extern const struct config_item_type tsm_report_extra_type;
> >>>>    +/*
> >>>> + * Used to indicate the attribute group type to the visibility callback to
> >>>> + * avoid the callback having to examine the attribute name.
> >>>
> >>> Checking the attribute name will give more flexibility, right? Since it is one time
> >>> check, it should not be costly, right?
> >>
> >> I thought about checking the name(s), but what if in the future another attribute is added, then you have to remember to update multiple places. This way you have an enum that represents the related attributes. Is there a
> > 
> > I think it depends on how you implement the visibility function. If the vendor driver allows all attributes by default and denies few selected ones, you don't have to update the vendor driver for all new attributes. Letting the vendor driver decide whether to support any new attributes makes sense to me.
> > 
> >> scenario where you would want to not hide all attributes that are related? String comparisons just seem awkward to me.
> >>
> >> I suppose the config_item and configfs_attr could also be supplied on the callback if that's a requirement.
> > 
> > 
> > I am ok with enum based checks. But lets see what others think. Personally I think checking config attr name is more flexible.
> 
> I think we can do both. Supply the enum, config_item and configfs_attr 
> and then the callback can decide using the enum and/or the attribute name.
> 
> It could be extended to the current extra attributes, too. The enum 
> could have a TSM_TYPE_EXTRA (for the privlevel, privlevel_floor and 
> auxblob) and allow those to be hidden as appropriate, too.
> 

I guess I should have read all feedback before supplying my own, but
looks like you arrived at the same result.

