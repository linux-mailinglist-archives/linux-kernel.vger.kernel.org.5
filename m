Return-Path: <linux-kernel+bounces-163185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9AB8B66EA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 031F9B2296C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B18220EB;
	Tue, 30 Apr 2024 00:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BhjQu7Q1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79711C33;
	Tue, 30 Apr 2024 00:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714437284; cv=fail; b=iMqeRSB7PS9ZD4hejFHcVkodeA28l/CnlibmVgtMkaqUIKNHmoR052k3D625rQUcjctcX8ZaFWSZnNzeKmNUFOoAqLswvH8QTlIh+2nwnsHS1wTeeUYGweE5HYFlxtvODgMGXCvc7lxJHKxQspY989RtmjBK5ImjzCS1bvZ84YU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714437284; c=relaxed/simple;
	bh=RCVngZl3wcPWqeA3N0BRAwZl8eFObbZN3GkGxpor64U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ncM5q8ff/taw9LHk5Tq+2KMi0tggFRWEmoLNM502MD5ZkjKl7id1Wg4QwMhjb2tbmeOr6ACJM406Oz7NcJeulrdHxwQ5Cek4/qZGdaq2bqYAxWvV/t1ehtM8joA4J4fYQZhLarVoim32AN+V248A7xCJuTyhweaybXKRnCBWWwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BhjQu7Q1; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714437283; x=1745973283;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=RCVngZl3wcPWqeA3N0BRAwZl8eFObbZN3GkGxpor64U=;
  b=BhjQu7Q1aJqlW7cIe4AQs4ExqKHASG/m3GQrVdr6k5UPQJA7wOWc5TTD
   xzh5tUgScx0FZH5xxAW2AcaA+zEx7UdVGo8PxX/bpQsRd4xp4ZPB0ceWV
   L3yg9Wm968nvsOkYTNZbFsdCKZy0tjpAdH+7jqvduGjRPV7S4ssLDFF5q
   PPN2DIeT50RAc6iLmujJuabGJXEV7TrYJNjqs9vAzk/pd7b+g8E8NGry4
   UcPFFzzlBBYcDUj32CjrgQhz3/M5AxAUGZ/rqos/9OxPznpmUfZED17wp
   Dl43WgWlqJ6iebpWoW6x9GNXcA2r5Odz8drH+In+6WjADm8xzZBuUjBiO
   Q==;
X-CSE-ConnectionGUID: v3YQ+SSkSvuoluj3xSubhA==
X-CSE-MsgGUID: qZ1Z4bVVQcS49AG5xrXDiQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="13948069"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="13948069"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 17:34:42 -0700
X-CSE-ConnectionGUID: dgM4FVfyS3KU4iXAata+eA==
X-CSE-MsgGUID: jpCGm0ZaTWW3RLLYJynGZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26687525"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 17:34:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 17:34:41 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 17:34:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 17:34:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 17:34:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUxuORr+YjmPe/vSGfa+DBTIrnfQaF7iltRBfpA2Rch+PV5Xlg13c6mLqxNjaTY0df5yUaVtSTFWkQYIKGbtPeQy3ID5eGayoeHnWiymJJ5ZsTFE4uAz0o7aZQzY5+GJ8D0mUDBioDDJwBKrEXza3DmFjw6l/RWkCgScd6h4iI/M5v51Et8THhNifYHksSwPEUXn76fzQ4laErfGnMGkCej3C2V+0XgGmy5bH35oB362F6B2zr00pDIuznwNM2BdVCU35TLPol3IS8g6me5ML2BzJanyEnu4ai0clc50xqqNu4A5RLb02pEeyCYl0fAeZU6GV2tDan4qgHERBWySyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bNTddf0XimqVm8VGiOdV2j8u51Xs4yFPbWZ64S71QQ=;
 b=OSHrQrxrnSeDiI2oM8kinYgpLXUCvj/ewj0zRmRcHtmzP+dPtOC8CXASIl5iFWz5bcKENq9yDSWDDxA8/owCgawyxStlAoZLSJyyz+UjRpxEGqzLCm3i3L29leVnOkqZYEHlhXee4R2tpZtGahqCl1UK6R4ztZiFbBb2RGAj53rkcFN4VBFkzYdKbEK1t6XK6UWGBTBI0Ed/73GaAOq0syinS7Z1fd88lrBjzVgbvIyhirML2h3ToxgppLMrG6cDbwz1YNt277dZB2DWhZ7N87jxdMqXK93wZakLbokLv886awBM+qH03UrEMVbW3uy8yQ2XUYDFy1EwbWgGduMeTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5127.namprd11.prod.outlook.com (2603:10b6:510:3c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 00:34:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 00:34:39 +0000
Date: Mon, 29 Apr 2024 17:34:36 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dongsheng Yang <dongsheng.yang@easystack.cn>, Gregory Price
	<gregory.price@memverge.com>, Dan Williams <dan.j.williams@intel.com>, "John
 Groves" <John@groves.net>
CC: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<nvdimm@lists.linux.dev>
Subject: Re: [PATCH RFC 0/7] block: Introduce CBD (CXL Block Device)
Message-ID: <66303c9c98f2_148729450@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
 <66288ac38b770_a96f294c6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ef34808b-d25d-c953-3407-aa833ad58e61@easystack.cn>
 <ZikhwAAIGFG0UU23@memverge.com>
 <bbf692ec-2109-baf2-aaae-7859a8315025@easystack.cn>
 <ZiuwyIVaKJq8aC6g@memverge.com>
 <98ae27ff-b01a-761d-c1c6-39911a000268@easystack.cn>
 <ZivS86BrfPHopkru@memverge.com>
 <8f373165-dd2b-906f-96da-41be9f27c208@easystack.cn>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f373165-dd2b-906f-96da-41be9f27c208@easystack.cn>
X-ClientProxiedBy: SA0PR11CA0004.namprd11.prod.outlook.com
 (2603:10b6:806:d3::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5127:EE_
X-MS-Office365-Filtering-Correlation-Id: b325a2ea-1001-4579-cb78-08dc68ad51e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cy9JT1RIUHdlb1JZM2wraFhqVWQzVVhmb3AxdHJaL3VidForQ24xMmQ0ODJt?=
 =?utf-8?B?WnVPRHpSalJ1bVdodldRdldjYWlWVlg5dkN2NGVvOVR1a1FKZkVYQUlDb2hR?=
 =?utf-8?B?TjBuUitYbzVDMml5U053My9haW9ZQVVISkdQekxnbiszQlhxZEIrQm5GaWFD?=
 =?utf-8?B?ZGZDMzBrQnpYb1YzY1p0TlhFZG5jOHdTOWdoRks2UnRNWDE4N1lZN0p4cDRy?=
 =?utf-8?B?MDZqajFuNE0zRTRDREl5THhaK3ExTUFlUnRDODBkTENQc05oRHg0N2JVN0JE?=
 =?utf-8?B?U2s5czNDS3gyWVdTR3lHTWNGY1dsY3JEeEZ0dzZaaWpPUEwwNUlMZFppMFRG?=
 =?utf-8?B?dWc1bkVOQmY2LzVPbjk1MTM1OXdBbFExTkpXNDF1TlB5cEpLd0ZubGpmRXpy?=
 =?utf-8?B?WSsxQlJhVmZOMkxlYVAzc3lXREc2ajYrazlxR0VIM0ZwLzR4d1dFSG1tM3V5?=
 =?utf-8?B?UTBmai9Za09ORldrTENIUCs2UGQ2d1JaeS9kYzVyVTAwOTVnNTZRd1JjMlFU?=
 =?utf-8?B?WUpnams0OHZobUZVdDdpNVRabHlzM2J6aDJCbm5qeWxIMSthTW5HNlF3akNI?=
 =?utf-8?B?V016MXZDOTFRT1BLNXVjSmt6WVJKRG53cEZqbjRGSm93c1BaTkZBUVJHcnJw?=
 =?utf-8?B?dTFwaGR6dnpnMUxiY1dlRnVLTkFpZjBDVW0zQjUzcm9PeldEeDlabmF4TlpT?=
 =?utf-8?B?RDRSK3hlenJ5SnhUcjVuUkkyUU1uNEVSMGc4WmFUalVRbGVjbWo5N3RWaGdE?=
 =?utf-8?B?VVJYT0NxT093YlU4SE8yUVQvL3VnVTFzbG9rZEZHN3h3UnBZc2gwUE40c1Vn?=
 =?utf-8?B?QzAzaHJLOE9XZXNzYkZtd3ZGR2RFbHpDRlJKa1NpNnhVdnBTR0hBNTZDWW5s?=
 =?utf-8?B?bXFHSVNYT1Fpd0s0T2R2Mk1oZGJObFo0TnE2NnlKc2VsK1pxamlOMEx1eVJm?=
 =?utf-8?B?UTM2TGl4QTFReWdHWVJrV0dVbFZmM0s2UGFCcWtkQjJrVTZHVDkxeGdYcWRw?=
 =?utf-8?B?dmlBNGxKUWVYRmlTa0dQUlpMYW8yME4xL2c0UU0vMUs4WnJjL0o0VElTRytW?=
 =?utf-8?B?VHN5dm5yWTZYeTcvdnQxcGk4azlKcXRVdUZJSER4ajkwUzlHeGp2a0pUeW0x?=
 =?utf-8?B?YU1DaC9UY1A5eU1lU1JiazBXNVhsd25yUjQ1UW9JKzNHSTRwTVErajd0alZw?=
 =?utf-8?B?d1VUSmJEdmZmVFBHVXAxK3RHNjdHVUJlNkJwNk90RHlxeXB1QjRjT0RUa2tP?=
 =?utf-8?B?c09IV1QwL2EwQW12cDg4eHhpRWxzMml6ZmlFc2lnUWtoaUxXcnp6UVRFK2Zi?=
 =?utf-8?B?TXprZTN3aVBPS1JCUGIxalBoRWVZSnpYd2hjMFZBUVgvTHRwUUFleFh1NzdJ?=
 =?utf-8?B?cmg1OUJKUW5qZ3MwL0lmZ1JzOTI5WUFqNURuMnVDUEJ6VlJJeEZtWWZNM1Fj?=
 =?utf-8?B?VlJtZmJlTVRJMU1UMmxPU01NQnBZaTFRaGNZa1grcU9DWTdWMFU4Y0orWldH?=
 =?utf-8?B?OGRXWWFQY1J2NHdDbVJ6alFXcGpLVnVQNkpQT0lNalZOc20rMitoUkNiSito?=
 =?utf-8?B?YWhKalpxdW93WDhCbWgrenQ3RkFpOWFWOHVaTGFIeWZ2Z1R0Q1NZcXU4NGRz?=
 =?utf-8?B?ckdwYS95TEx4M0U0MkJPVHlUbXUweHI3VmhiODlORWM3L1lsajMwM2JVUnU4?=
 =?utf-8?B?ai8vUlZlOWZWZS9GZm9teUR2cGJaT0MvUEI4WWptc1N0ays4aElZSHNnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE5hODVBOUFKVjJZeXB5WUwveXBxUTF4aTBzbnhDa0NHOGdDd2JFTVVGNVdK?=
 =?utf-8?B?UTVpUnpMN0JxdUtMRlpYWER6U3NhVkJUREJqcG5GR1hyWlN2NFVtTkFBTVhu?=
 =?utf-8?B?MkpNS0pxeThXc1VCVXhKUFdCMnpmcS80ZG9pVHNDa1dwdzFOS2M3NUlKc0hk?=
 =?utf-8?B?MVgxcTlSTEpqNlc0TnZVNHlsR0svN0lvTzBFV0tTN0V3dUNmSjVDZWVLbGkv?=
 =?utf-8?B?R2lzSzRFYTA5YlQyMklvRC9ZWDlsZHoyakgwWldlaElpNnZFQ3RaTlFtbWQ3?=
 =?utf-8?B?ZXYvSG4ySDlMOEZTYXFtMG9yTGsvdGlydFE1RUpmejFEenhMSi91RGxNaFRx?=
 =?utf-8?B?QTFpOHZZNkRtbWhXUEZVdXF0VXp5QmJtK2M0T1Vtd0Joa2w4QlA4cTVEVUhL?=
 =?utf-8?B?aTZYZTlFbGs4TEZGWmRYeENpOFFNMkpoL1F5eENVWXQyUkRrYlZuZG1CTEVl?=
 =?utf-8?B?OWlLS05aclNzZVBIODNydkRiNnlwRzNhYllxMVljNmdUMXV4djU3dHVRVkVH?=
 =?utf-8?B?eWpJNHpLa2xCSk9ZZHNBeG1FRHBjOEFXUlNuMHBnRXJkSG8yZnV0Qm5uU20w?=
 =?utf-8?B?VkhlMkRKOWlsZURtZkJTWEVBYk5OczdJaG90NjV5eEo2N2JLdU5XeWJENFFs?=
 =?utf-8?B?MHY4OEVKNUZuRjU1eFRYNkoyOHdiN1BhZUN2K1JOZ3pZWllud2VyVnV2ejha?=
 =?utf-8?B?Y1pIU2tzcEttbTN4bXdsV1BEMS9PZUxERHljVVNQNWpXRFRWdS9rU1IzOXYv?=
 =?utf-8?B?QSt2bzhVTzJkYURaWElHTEZObWdxYnhPYjRINm5aTTI0MFROeXUvM0FVVC9q?=
 =?utf-8?B?WDNqK2o3TGp0Z2svVmtOV2pVMmVJWHhtU0pzOUZweXFyU3V4Y2ZhWlM5dk1X?=
 =?utf-8?B?ZG5SSUkyRnZ5MzdlM3BNVHdhcXpTMWFGSWRTR29QcE5aYVlRN2duMDBOMmtz?=
 =?utf-8?B?djhrRzhGSTFuczFXWEdZMXdDQTdIa2pEVFZsRWRqczIxc29wK2NSNGNiK3da?=
 =?utf-8?B?cEtnSGhRemc0N3ptYlJOM20xQXVldjQ2clBDcWg3UkFLY1NEWjZsTm5wUzl2?=
 =?utf-8?B?bkVtVE5UV2kxQWVwOTdFRzBpMi85cnRIZzM4akJRVTAyUFJQdE5xUjVPS09S?=
 =?utf-8?B?UzNHQ1EwRWM5Z3pnVWFBVXlhWFpjVE0vdklFQzlwQThMTmtXQXRrM01aVGZz?=
 =?utf-8?B?dlRaZlczVi83Z2t4VUlSczFHSzBhUHpMOERDK3g5d01HeHpNQnpUNlRGWHk3?=
 =?utf-8?B?QzZZT2U0Vkw3SHRuUTloYjhFRnZYRmtyQ0VTMnB6eDU5RTk1Vkh5Y0UzRlgw?=
 =?utf-8?B?bnlNYlZyeFNtaUF2ai8yM3lEb1c5a2tXY1hoMFFpWVhmM0k2M3FPaDl6dWRu?=
 =?utf-8?B?TERUOCswd1JHSkpQQnFGditlN1RWaEptTm51SWh1RnZISlRUTXNwbW1ONHRp?=
 =?utf-8?B?VExpYXgvbERDWlZieTFXT1FFaU5BbkJxNW0wMFhpbjV5WW5xSkpnTUFKeG9Y?=
 =?utf-8?B?OTh6NTVtQ2p6MTVOb1Bsek5TSXQ0VnR2VDE3ZzdSbmx0anQwRUI5N3ZEVjFz?=
 =?utf-8?B?WXhnZk9HUERLWElMaEZxVm5aNk5nMW9Qam9XSHpSbjlTZjJDTEo3NVY4aHlw?=
 =?utf-8?B?TWlVQmJtQ1hMejgrbm4zVjM5OGc4azloVC9ZQkRQQ1VMM3owZ0tJdzVPNTVO?=
 =?utf-8?B?UmFRQ1ZnSHdld3lsdzJIeHNtQ2ZFV1FpdlBRd0RxQ2g1YVNEZUJZcDZqRXpw?=
 =?utf-8?B?ZUpRNlNncjUzOGIrcjBxWHh2SWQ0bVRUbmJSMVVtVm9FTU5KcVVRallOWDVO?=
 =?utf-8?B?VWhDZWFTSUx0S05WWDd1cTVWMDk2R0poTElkaWRLNkxwa2txMEhuZ2xxdDMz?=
 =?utf-8?B?VnFrR2lTOFVlT3pZSXZhTnJIYmpiUHU2TG1MOURtWXRlOWIrRnhzT1Q4RUo5?=
 =?utf-8?B?d290QiszdmpKNVdMT3RIY3l0LzQ2aEN4RC8rYlp2cDRXb3BhL0lVWGJmSUZ5?=
 =?utf-8?B?YjdXWEZ1RnlYcGszdCs2Myt3R1pLRkdBT3pDY1NtcHFKdi9EZ1VmMUlSWEZT?=
 =?utf-8?B?eWtGdForWWVVdXJBRnlocW1SZEUxVzl2SDdGZ1dvQ3drYVZETzg3Yk9HMXlo?=
 =?utf-8?B?bXRQV0JHUnI0dHJ3UmxneHpNNzEySWZyelJGdXRuUDNkRkV5NlB0ZEh0OUtQ?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b325a2ea-1001-4579-cb78-08dc68ad51e0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 00:34:39.2915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0568Q0h1mUvWZkjfsSPppXKxCXqzTGY5qaHMNGprPmkt2ouorL9kDwedrAOKPMbvGNrBexuuM8hNumFVY3KncXKF2MQHnUUlhKZs8D3iew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5127
X-OriginatorOrg: intel.com

Dongsheng Yang wrote:
> 
> 
> 在 2024/4/27 星期六 上午 12:14, Gregory Price 写道:
> > On Fri, Apr 26, 2024 at 10:53:43PM +0800, Dongsheng Yang wrote:
> >>
> >>
> >> 在 2024/4/26 星期五 下午 9:48, Gregory Price 写道:
> >>>
> >>
> >> In (5) of the cover letter, I mentioned that cbd addresses cache coherence
> >> at the software level:
> >>
> >> (5) How do blkdev and backend interact through the channel?
> >> 	a) For reader side, before reading the data, if the data in this channel
> >> may be modified by the other party, then I need to flush the cache before
> >> reading to ensure that I get the latest data. For example, the blkdev needs
> >> to flush the cache before obtaining compr_head because compr_head will be
> >> updated by the backend handler.
> >> 	b) For writter side, if the written information will be read by others,
> >> then after writing, I need to flush the cache to let the other party see it
> >> immediately. For example, after blkdev submits cbd_se, it needs to update
> >> cmd_head to let the handler have a new cbd_se. Therefore, after updating
> >> cmd_head, I need to flush the cache to let the backend see it.
> >>
> > 
> > Flushing the cache is insufficient.  All that cache flushing guarantees
> > is that the memory has left the writer's CPU cache.  There are potentially
> > many write buffers between the CPU and the actual backing media that the
> > CPU has no visibility of and cannot pierce through to force a full
> > guaranteed flush back to the media.
> > 
> > for example:
> > 
> > memcpy(some_cacheline, data, 64);
> > mfence();
> > 
> > Will not guarantee that after mfence() completes that the remote host
> > will have visibility of the data.  mfence() does not guarantee a full
> > flush back down to the device, it only guarantees it has been pushed out
> > of the CPU's cache.
> > 
> > similarly:
> > 
> > memcpy(some_cacheline, data, 64);
> > mfence();
> > memcpy(some_other_cacheline, data, 64);
> > mfence()
> > 
> > Will not guarantee that some_cacheline reaches the backing media prior
> > to some_other_cacheline, as there is no guarantee of write-ordering in
> > CXL controllers (with the exception of writes to the same cacheline).
> > 
> > So this statement:
> > 
> >> I need to flush the cache to let the other party see it immediately.
> > 
> > Is misleading.  They will not see is "immediately", they will see it
> > "eventually at some completely unknowable time in the future".
> 
> This is indeed one of the issues I wanted to discuss at the RFC stage. 
> Thank you for pointing it out.
> 
> In my opinion, using "nvdimm_flush" might be one way to address this 
> issue, but it seems to flush the entire nd_region, which might be too 
> heavy. Moreover, it only applies to non-volatile memory.
> 
> This should be a general problem for cxl shared memory. In theory, FAMFS 
> should also encounter this issue.
> 
> Gregory, John, and Dan, Any suggestion about it?

The CXL equivalent is GPF (Global Persistence Flush), not be confused
with "General Protection Fault" which is likely what will happen if
software needs to manage cache coherency for this solution. CXL GPF was
not designed to be triggered by software. It is hardware response to a
power supply indicating loss of input power.

I do not think you want to spend community resources reviewing software
cache coherency considerations, and instead "just" mandate that this
solution requires inter-host hardware cache coherence. I understand that
is a difficult requirement to mandate, but it is likely less difficult
than getting Linux to carry a software cache coherence mitigation.

In some ways this reminds me of SMR drives and the problems those posed
to software where ultimately the programming difficulties needed to be
solved in hardware, not exported to the Linux kernel to solve.

