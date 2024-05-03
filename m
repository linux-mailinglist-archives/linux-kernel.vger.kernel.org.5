Return-Path: <linux-kernel+bounces-167839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E5D8BB022
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D07EB2239E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03861509A4;
	Fri,  3 May 2024 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XjPBgb8y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCFB155337
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750697; cv=fail; b=FaP7845TR0FgRujiwbtL91jIBYGek7fxrQj34ZOVejTelXp4fr2w3kQj4y5AtCFsXokFKXadkke4S4RsuMW2doYrLaNpzBQY1tP2WtoV8IqiuS2Q2+r1aqdt7TGWWIx3e1+l3qgRLon92ivHZDQiz0SrTqT1Yr/rv4mRkXDBzFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750697; c=relaxed/simple;
	bh=uPxYRNr92xBdXsB6MzUGKY3RRFOzC+Cc99DBdd+Trv8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tFJgr7YAnSdtcw26kPmevE7TNu9WQFiksTyV9qMSNMJ+z4JkzDWTxnkKJpcOgyYnxSizplzBbAiaTidTHcar9jxJZy6bx8A77J2nTL5ky1AJ2HxgfYk+MztuvppDESuvVB7Zjvg+Ddwo3j9BmtV5exlFXibEc3D3eO2M9yzlI8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XjPBgb8y; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714750696; x=1746286696;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uPxYRNr92xBdXsB6MzUGKY3RRFOzC+Cc99DBdd+Trv8=;
  b=XjPBgb8yT0CEezZ4S3C2SlJIq5Uav9bvVNMuMwqZCElsqRhp+WUAMagV
   pJzvB/ubJnWFhwn0r6AqfT8ikH6Mvyo58LiSH8QzRunFykDjnGG+TR+wU
   Ek+gQ92ADsUbw8p6447QMRnhcq09jDQnKzp00n+uhKY81HW21u3p/rmib
   R8VYx4FPr8fqjkAlqy0myIsCcpQhPgNZgy6d4xZOOb+vWCz3D5hmGjdz0
   QDrMTpLC6JdpsvoIec02yvVn+dZMfJX38taNI/nQMyARyquB+VZUveRfk
   GX2dbR2cE5NrC6TtLejnq9tnh8ECOKzhWgyvLCjsxhRNIM5MDyuVwHQTo
   Q==;
X-CSE-ConnectionGUID: wYgGhB+hQLO9ia7Y0REiEA==
X-CSE-MsgGUID: gz008CUbRb+ZVwV0p9H+tA==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10409494"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="10409494"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 08:38:14 -0700
X-CSE-ConnectionGUID: gg+dlRB9R9ebfFwW3ZBcdg==
X-CSE-MsgGUID: YSEbJsQGQNG3vavHiOdkcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27506922"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 08:38:14 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 08:38:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 08:38:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 08:38:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lq/VNX28rwsTwlJbvNxsZmynsbTbnqlOUtvCr2BsAs2utIyHneIapkF994zRkiWgBaK3YFir4ay2VUvz9MBnlbk9+NlSWqPdnDyZejhvYgU3Cw/20/Sb5uvyQyikPP/0dDEOW2cN37cAu9OheUZfLsB5AS646o7jA8xHQC5mK1vhVhEq+R1X2kZqaoNxBYp1OhGgHfhl2Sbx044u8QC9MLiVV53KEhfJPXa2HtGz50H8qYVrbi456h/objZzxk6JH6+3HoGDFvO0eZ+PpLubkhEGh/0VV1aR/dF47I8E+8pSxLQTgJPhBrbps4A4rKAIcucuhjKwLKuzwkcOhMCecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPxYRNr92xBdXsB6MzUGKY3RRFOzC+Cc99DBdd+Trv8=;
 b=lprbgqbEaFbPEmRGd/YtphxzQUM68m3k9w+m0ajiHmYBqmpwwmF/M3EjEy1T8/lHa4ZqPrj5bVUUKdbfIObrBhsIV8WIlqzODsCzgON4bxc4oLDDe9XG7eKeJSJ5MJExYJ3NWwSeQny1Crgcut5pBbw9/X3D8i9CNf9glryzYy5Sp7XxQ5ZNDmKPTjz/Ygx8ma8Cur+NAW/ik3/uLJDejt7nlna86wMl64FVgdCAoivwzcCBT2XCzrdjI5KXU+bOSWSr4pyW79Qqqd6jUKa0sqbE0k2mQYOlQ2ABEQvNKHxMupatyYdokACJy5lJTf16OELiBRvRADec2I4zTb++sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB6576.namprd11.prod.outlook.com (2603:10b6:a03:478::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 15:38:04 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7519.031; Fri, 3 May 2024
 15:38:04 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, "Yu, Fenghua"
	<fenghua.yu@intel.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>, Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>, "Drew
 Fustini" <dfustini@baylibre.com>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH 00/10] Add support for Sub-NUMA cluster (SNC) systems
Thread-Topic: [PATCH 00/10] Add support for Sub-NUMA cluster (SNC) systems
Thread-Index: AQHagIHxMU3ycOFrGUWPFhpOmgocgLGEY5AAgAF5hjA=
Date: Fri, 3 May 2024 15:38:04 +0000
Message-ID: <SJ1PR11MB60832FD4C0F1F0C63EA1629BFC1F2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240327200352.236835-1-tony.luck@intel.com>
 <306195e9-83e4-43b9-a441-9bc1681317f6@intel.com>
In-Reply-To: <306195e9-83e4-43b9-a441-9bc1681317f6@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB6576:EE_
x-ms-office365-filtering-correlation-id: ef8bd1fa-ddeb-409c-199f-08dc6b8705d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|921011|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NXdqUGdTSHZxREg2ZFV3MUZtNFZ4OUZTbS9DRDVjbGw1N21HWk9BdUFJQWhr?=
 =?utf-8?B?ZzVycEU0ck5DTWpDL2JZS1M0SSttbXJueEJDalNrOXpBcGEvZ0tDNnVNeTlX?=
 =?utf-8?B?VkNYNXF3dDdzZFQ2bE83bjM3Tkx3YW51ZGErUDNqVWVESVczcUVaTjRYcG9Q?=
 =?utf-8?B?ZlRPcFJDaUlrcm1FTFdvZlJFWm5DOGJ4V2lDVDJoTUtoSHgyUGxpbVQrUmda?=
 =?utf-8?B?OXlFWklKVlVyUzFBVFlxVTVYemxwTU5FZko3NGFoK2pTaDRMcmttM3QwTGFt?=
 =?utf-8?B?aVp1MW1UcytTMEFJYUQxMFdDczc4Q2hLSFFUT3MxaWpvQTUrSk1mbFB2VExq?=
 =?utf-8?B?eDdHWjNuMFRCVFN4UW1tUjhDdVJ3YkZzYzhmSlJnRWJCSjkrM1Z4Ull6SFVn?=
 =?utf-8?B?OXRvZGppcmRQWTRSNnZBaHlpdmJOUWlTTUlFQVRXeWxqclFZVklKajE3MHVz?=
 =?utf-8?B?T0pkQW53d25XbFk0Q3Q3Nm5jR0Rhd3VTengwZFZBamhxai9nVENEQmNLUDNo?=
 =?utf-8?B?Q25SZ0NDeklEUjBjVjBPK2FLdDJmbUd5S3NwRExITnF6azFCenNCZHR1d2hk?=
 =?utf-8?B?Q0ZnTTE4d0dPRWdyREZpRy80VDIxY2xqS2p4K29iNGUxMGpST2ZDYlZuMDkx?=
 =?utf-8?B?RDdnd3lMTmxlbC9KZERXcVcycGl3QWVidFV2dHB1dUJkd2djbVNQbDdDdjlq?=
 =?utf-8?B?c3VBVzE2RTZDblZrY1oxbi9uaXVhNE0yOHA2ZitQMG10MW13UVhYZXkrUWpQ?=
 =?utf-8?B?cDVqdzJBUHdaOEgwRHI1U0ZDdk1LUmxSeWNMMUZSdVprWjhjaDZiQXdwQVpv?=
 =?utf-8?B?ekZsUDNaSm5IUFIvUHlzMUZlTHNxRWppcGU3ZmV4MDUwMTgvQWhPeGRwVXFW?=
 =?utf-8?B?enY1emZUd2I3c0pJQW55SXhZK054L1EwR0NEdXU4eTltaWF6MmpTS3VDOGtp?=
 =?utf-8?B?ZGl0MXpxSitoZi85Q0J3T01QNVExcHVBYmZCaTZNL0F2d3IzQUZkRnBzQ2pw?=
 =?utf-8?B?aDhMSHhuK3BZSkdCV2VTbVZXU3Jka0hRWGI4dmJianF0YWE5ZmFZYmpIb2VO?=
 =?utf-8?B?RDFBSmxJb29YeEFBS2dKME5XNE9VSS9pZEN3Y1FINXF3RFkxUndnT2xWMUFk?=
 =?utf-8?B?UXV1ZERvdHU4VGE4Q1l3TzlkZWNrMXRRVmhhdVFEYWh1Q3ZZMHh1dndONVgv?=
 =?utf-8?B?UzFhbi9vSmU1bXNyNWQ5MENvUUlSaUtDaTFYRlcrZllkaXlMTEZmTlMxTXU2?=
 =?utf-8?B?bFFwS01jNzdHSFhRV3IwbWZGVmNoS0tHWkhwRG4xTThlVGNkN0hPY2JYWWtH?=
 =?utf-8?B?RXdMUXJBb1V3SWV3bSs0QW5EWW1ZcnN4NGpYSWdLeHRScnJlSFh5ZEkzNjIw?=
 =?utf-8?B?Z1FhN1pKanlPME1adU0vMnFiaVdjVUczSG9ycEpUYmJuZjF0SmQ4Ulo2WUNX?=
 =?utf-8?B?aHQ5ZFUzMXJ4NkpqNkNvTzVVTGM0OEtxVVR1UVZEZldnKzlCRUNHUFdsaDZa?=
 =?utf-8?B?bmE5S2o2QkxGOE0zN1Z4dktzOW5zU2JzY0tnLzdNTWdzc211WkNjZGZ1QytJ?=
 =?utf-8?B?TXNwRE1GeHVIS3NMVVROeHNBbXBYMTcrc09Mc21ja1Z3TS9zMWZrdlZDZW9Z?=
 =?utf-8?B?a0NZRHlIaEVpcWFtKzJxOEtyTDlqTXhicnNkZnUwcENsUi94UjRXVVBkVzBa?=
 =?utf-8?B?V0NkN3ZkN3R0OUxocXdPWWNtSzlwZFJPY1htZHNWSGY2WWlvQU5MNmVWMzJY?=
 =?utf-8?B?UVVwNzNLajhlV0JUM3JsYVUxNzRia0ZYNjNpNCs1TTlWUittRlFKTVV1Mjlr?=
 =?utf-8?Q?fAkgMKaJZbQQknFMp4h3/tOYECpXAlfbiqJls=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RllsTHFHcjc0TzJpMUoxYklqdXlJUGw2SXlUdUUwQTBQQVBTK0dIQjlYaDZH?=
 =?utf-8?B?aDR0cDZsTGJkUC85N2IySmNIbDJ3d3A3SDJSOS9Selp6NThVRFVIQWdzQ0Rj?=
 =?utf-8?B?eGwwSlhaMG9Scm9GRnl5cUtpVEtpb25oRXhKZDhKVmFSc013bmpkR3hJYzZm?=
 =?utf-8?B?aU1RTkVwTlYwQW1GSWZ3Wi9JRnN5b3FJSHNxL1N1NXlVWlc4ZUdyeVJLejNp?=
 =?utf-8?B?dnFFcGR5VnREMEFXbHJ0S0IwSjBBUEEzRTJ5VzRoNEZoQ0M0UGI5am9MUFU5?=
 =?utf-8?B?ZE5lRUtVOTNseEZFUGRCVnZKZ0VhYW53akxod1lENkdFNzFzY2I2YVdkK3Jk?=
 =?utf-8?B?SHZTVnljSVllL2pYdDhTSzFsSzRwQ0tyMkxUVkd0RHVNdnFCMHYxN21ycGNw?=
 =?utf-8?B?dGJYLzlnSFB1a2dGVkszUFJjanA1L05EZHJyckkvQndDZE1GanZ4eC9lUU0r?=
 =?utf-8?B?eHM0c3grN3ozY29CODRxN3RmR0xTcTNaT01vYWp6Z2RaNWN0YkYxc3lpVUpl?=
 =?utf-8?B?c2ZiNmoyeUp6eUM2WUZpcUprRnpnNmljemFDN0FyMVNNbmZxSHRPWmlzbFVH?=
 =?utf-8?B?d0FIVmhkNVB1Ykp0aUdKcEdYbmIwQ1FuRWpYOFc1UHRrMnFuLzhLQ0lrbDlV?=
 =?utf-8?B?TnFVdXk5ZWtpZklKbFBhUjJydzV0bEt2SkVMakNzNjZjYlpoL0U5OCtkTENF?=
 =?utf-8?B?aXcycHVCRHkrNDJGU2VHTEhoYXhnQzJlSlgwN1VZak9Bc3RKLzdJQlBQR0Rn?=
 =?utf-8?B?dEszeG5razFCOTljUHN0UDd1aENMNE1oMnJBODkrRlNnaEMxNzlzdmtYU2pw?=
 =?utf-8?B?cjVsL1ZmT3ZBTC9sWXQxWWtPdHpNeWRzNkpJTnJVeW9HSmhYcitqbkV5bk9T?=
 =?utf-8?B?eGVqMWFyWFAvQVNXTVNnaVpSelI2TEtyQmloOEEzTUkvRlNsaDcvRVZwaC94?=
 =?utf-8?B?TTFrSkdaNXVxN2lOaXhaYXNJUUtqTXAwNkZ0L0xaM3BORFNrWFQzNDNaVkVw?=
 =?utf-8?B?Q0gzYzY1QWYwNHBaUVFsMGZEUFMvTW1sWHd3bFdvanJja21ISUdHQTdBZkx2?=
 =?utf-8?B?N29jUUdiNndFOVdLWHhldHJsL3lCVXdKQXVJcFlDR3ZSbFozUlhvRmV2TTNw?=
 =?utf-8?B?Slg1SWFLdDltRUFBNzNheEhRam00clFUaTBMM2c3SWt6bTFQSEd0YmRNNFhm?=
 =?utf-8?B?QnNYaDJWTlUvdG8xZFloajhJeXhhTWZZSjQvTFJCcTIxY1lxd1BTZVFSMW1s?=
 =?utf-8?B?Ym4yMG5nUEw3eFlnRFpHejZBUGRmRFZZeDNDUy84Q2NmaG5jNmoyemlseHBG?=
 =?utf-8?B?c1NzZ09TNGVOTFovZVFicUREeTlKWmdTN3NySHBTK1hHR2VFZHRVNzVpeHlD?=
 =?utf-8?B?bVEwWGJ2T3VTSXhOVDZ6bE5PcXczTWxJa1pTYm5lNlBUQUZyQkR2SXNpNTlG?=
 =?utf-8?B?M0lJVWpPQVBtV2RVNzRFWHovTkthamhNZlFGanV5c1g4VlZCOUJVTkdqelps?=
 =?utf-8?B?c1pYZWZvM2Z3cG45SkY0a3QzNWlQL3htYzUxaXJNeDVrRnVQWWdJSjJYMXZN?=
 =?utf-8?B?NGpQMWM5OStydno0WUJsQWNJMEZOSEJ2cXlvTGJ2eXBCZ3I3V0ZINVRSQW1i?=
 =?utf-8?B?V0drci9obEN4dzRzaWFEM1VsVjNpamF1RjFjbG9jdlMzY3REUU81b2pQRWIr?=
 =?utf-8?B?SW1yUWpXekNjQlNsd2s3NldQcjBFUkFCMExKUllIN21NNHQxZ3FzWFlETUVD?=
 =?utf-8?B?ejNORVhaVmJZOTVPTU5MUW9telEyelNJaHFqdThzMmlFTERFTFA0bWtQOHVw?=
 =?utf-8?B?aW5GUFVyMHJhTml1aEg1RHE4Z1Q3QjB0TERMZzRsNHpJNVBXNjJDZDVQaC9K?=
 =?utf-8?B?Z24wRGxScWxRMURScitNUkc5Z0FlQlhCZndOOVdiYkpDaVRlbUtXQlpJbXAx?=
 =?utf-8?B?bzV6MUt6SDNHUUZFZm1PZzBvQW1sYjlXNE1URUlFazlSdExaRjBEOE5mcHp3?=
 =?utf-8?B?VzdIMXd3WERJTUpwOXJFamhyeGVGcHZ3a2w1Q0JNYlhGNXhJdFBGRk1leXEy?=
 =?utf-8?B?RS96L0ZuSlpQZ3l0cy83SkpTUTVvYlh3LzJ4U0xiTE5rMEdtK0E1RHZ5STBC?=
 =?utf-8?Q?J5p9un+uxQsAqOs1ijZNv7ZLM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8bd1fa-ddeb-409c-199f-08dc6b8705d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 15:38:04.1864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iGK3Xzp20WljcDz+5ZVzO2PefrqtjRppSSCqfxM6m4a57gTr59Dc5orPDMInWgy4sBw5GoiQIN/67mnCcD3x2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6576
X-OriginatorOrg: intel.com

PiBBcyBJIHVuZGVyc3RhbmQgdGhpcyByZXdyaXRlIGFpbXMgdG8gc3VwcG9ydCB0aGUgbmV3IGZp
bGUNCj4gaGllcmFyY2h5IGFuZCB0byBiZSBhYmxlIHRvIGhhdmUgaGlnaGVyIGxldmVsIGZpbGVz
IGNvbnRhaW4gdGhlIHN1bSBvZg0KPiB0aGUgZmlsZXMgYmVsb3cuIEkgZG8gbm90IHRoaW5rIGEg
cmV3cml0ZSBpcyBuZWNlc3NhcnkgdG8NCj4gc3VwcG9ydCB0aGlzLiBJIGRvIGNvbnRpbnVlIHRv
IGJlbGlldmUgdGhhdCB0aGUgcHJldmlvdXMgU05DIGVuYWJsaW5nDQo+IGlzIGFwcHJvcHJpYXRl
IGFuZCBhcyBJIHVuZGVyc3RhbmQgc3VwcG9ydCBmb3IgdGhpcyBuZXcgZGlzcGxheSB0byB1c2Vy
DQo+IHNwYWNlIGNhbiBiZSBhZGRlZCB0byBpdC4gRm9yIGV4YW1wbGUsIGNvdWxkIHRoaXMgbm90
IGJlIGFjY29tcGxpc2hlZA0KPiBieSBhZGRpbmcgb25lIG5ldyBtZW1iZXIgdG8gc3RydWN0IHJk
dF9yZXNvdXJjZSB0aGF0IHNwZWNpZmllcyB0aGUgc2NvcGUgYXQNCj4gd2hpY2ggdG8gZGlzcGxh
eSB0aGUgbW9uaXRvciBkYXRhIHRvIHVzZXIgc3BhY2U/IG1rZGlyX21vbmRhdGFfc3ViZGlyKCkg
Y2FuDQo+IHVzZSB0aGlzIGZpZWxkIHRvIGRlY2lkZSBob3cgdG8gY3JlYXRlIHRoZSBmaWxlcyAu
Li4gaWYgdGhlICJkaXNwbGF5Ig0KPiBzY29wZSBpcyB0aGUgc2FtZSBhcyB0aGUgbW9uaXRvcmlu
ZyBzY29wZSB0aGVuIGZpbGVzIGFyZSBjcmVhdGVkIGFzDQo+IGl0IGlzIG5vdywgaWYgdGhlICJk
aXNwbGF5IiBzY29wZSBpcyBkaWZmZXJlbnQgKHJlcXVpcmVkIHRvIGJlIGEgc3VwZXJzZXQpDQo+
IHRoZW4gdGhlIGZpbGVzIGFyZSBjcmVhdGVkIHdpdGhpbiBhIGRpcmVjdG9yeSB0aGF0IG1hdGNo
ZXMgdGhlICJkaXNwbGF5Ig0KPiBzY29wZS4gSSBkbyBub3Qgc2VlIHdoeSBpdCB3b3VsZCBiZSBy
ZXF1aXJlZCB0byBoYXZlIHRvIHdvcmsgZnJvbSBhDQo+IHN0b3JlZCBDUFUgbWFzayB0byBkZXRl
cm1pbmUgcmVsYXRpb25zaGlwcy4gSSBiZWxpZXZlIHRoZSBpZCBvZiB0aGUNCj4gImRpc3BsYXki
IHNjb3BlIHRvIGNyZWF0ZSBhIHN1Yi1kaXJlY3RvcnkgaW4gY2FuIGJlIGRldGVybWluZWQgZHlu
YW1pY2FsbHkNCj4gYXQgdGhpcyB0aW1lLiBTaW1pbGFybHksIHRoZSBtZXRhZGF0YSBvZiB0aGUg
ZmlsZXMgYXJlIHVzZWQgdG8gaW5kaWNhdGUNCj4gd2hlbiBhIHN1bSBpcyByZXF1aXJlZC4NCg0K
UmVpbmV0dGUsDQoNCkkgd2FzIGNvbmNlcm5lZCBhYm91dCBkeW5hbWljYWxseSBmaWd1cmluZyBv
dXQgdGhlIHJlbGF0aW9uc2hpcHMuIEluDQpwYXJ0aWN1bGFyIEkgdGhvdWdodCBpdCB3b3VsZCBi
ZSBtdWNoIGVhc2llciB0byB0cmFjayBhZGRpdGlvbi9yZW1vdmFsDQpvZiBkb21haW5zIGF0IGJv
dGggU05DIG5vZGUgYW5kIEwzIGNhY2hlIGxldmVsIGlmIEkgdXNlZCB0aGUgZXhpc3RpbmcNCmNw
dSBob3RwbHVnIHRyYWNraW5nIGZ1bmN0aW9ucy4gSGVuY2Ugc2VwYXJhdGUgcmR0X3Jlc291cmNl
cyBmb3IgZWFjaC4NCg0KQnV0IGFmdGVyIHJlYWRpbmcgeW91ciBzdWdnZXN0aW9ucyBhYm92ZSwg
SSBleHBlcmltZW50ZWQgd2l0aCBidWlsZGluZw0Kb24gdG9wIG9mIHRoZSB2MTcgc2VyaWVzLiBJ
dCBkb2Vzbid0IGxvb2sgYW55d2hlcmUgYXMgY29tcGxleCBhcyBJIGhhZA0KaW1hZ2luZWQuIEkn
bSBnb2luZyB0byBwdXJzdWUgdGhhdCB0b2RheS4NCg0KVGhhbmtzDQoNCi1Ub255DQo=

