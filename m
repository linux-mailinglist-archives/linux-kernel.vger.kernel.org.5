Return-Path: <linux-kernel+bounces-163227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E108B676B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E7F283296
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EDD20EB;
	Tue, 30 Apr 2024 01:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aMxUKY6V"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEACD1113;
	Tue, 30 Apr 2024 01:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714440411; cv=fail; b=SLJLVhunk8gGRR0H0ZiRVPa7MbdSn5tp6OFadRWbkJTEpF+brQjcbX0IpcIu8YJs8yIlZzfYiyjj3qaIXLTdyftliTr3T+pV+5AoVXst/L9IwPEG8I1t1IIikF0T6FRtMwpiOP6U0FXADmB9kiDeWFeyiQlHo6MaV16pBxpqcRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714440411; c=relaxed/simple;
	bh=iLCu7ViezsEsDN/s54TUA0P6f/gk+Fa3zUtU5lZcAaI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aIUbpVQrUZ0PrTdLyuPmZLRaypOTpOYqUMuqGGjfizTK9ERYVyNP/cgIQG2FgD71y3Md0E2FRZBSajS2LxLg03jzmeKJX+9T+y67ikq1spd4aNmH4/NOErXb1aUZles6OCrM6QpPa6rc60kggFqe7uHOXLTpNB+hw52A9yn/2Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aMxUKY6V; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714440409; x=1745976409;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iLCu7ViezsEsDN/s54TUA0P6f/gk+Fa3zUtU5lZcAaI=;
  b=aMxUKY6VicUayM2wMH0+lv1MN3vJJvvYet3NS524HEryp3PVX3Izg1iq
   20CPVH8U1BgG8ybYMS4tWX2WL3PIFYeYo09S/tL6ODTN5Fe98gqfD9QWb
   O+JNhho5iH1lYPy3lbAPtXuGfm5SOriHO+7mBjrTvSDwe8/rg7XoZ9Umv
   rHWxxSrjVEL0fLnfDBKp4Amum9Fs3ZrRX4L07yKWxapG6HA1oD/f7hAmc
   aH6NrKIDNMtYwZ7k0Ap39ovG4cO7T2WU/nix7Z2NCUYt6lMceoZyrhV94
   s/Bs5IOAJBIn42NIIRsJ+7qHhAF+2s+zd9bMOuxdOsqISZo0qGBR+15MU
   w==;
X-CSE-ConnectionGUID: zDCFVTbgRaePLKrRxb5/2g==
X-CSE-MsgGUID: LV2QONxQQ8eQZIdSybORlA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="35515101"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="35515101"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 18:26:48 -0700
X-CSE-ConnectionGUID: 6SDrUa+1Q3KtJaRsEj5zFw==
X-CSE-MsgGUID: +ywpmPhHRuWH46a9+gfHwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="30926179"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 18:26:49 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 18:26:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 18:26:47 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 18:26:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoEVE2ooP7aTewFXeaOCIpuh9Q+bS9V1c85DDsAWHlW/0gkGLnhTtYwlwYLL4d2EO8jprzlOQ0NPzvExEW88xtTubgY54DAcnzwlu2voFyCwUAeLyO0OPvEatDEJXWWLTHynUGJHZtxXVS5dYcUI1neoZTah9mH686MVVC0Sl+ywPHtmeFKxJWME9JSGW7lCWp7tx2HCWi9P6GEr1V++kYuDIV/4yr+f8cpwLkt3eIc7fvQbD+zM3mVimSR2Hf06UFeu2Dp0d9gpvZFIBLeAxiiBr0pPX+XTpoedcg0QTlQ+3GkuZ2ePhc7JVm32JefKJm4f4RsdTjkoQQg3Xx9N1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfqnjsqAo8gvcRV7+qw4a+pqoM4kFz8rp8c1RkTfr9o=;
 b=E/UO0sfGfVCS85ZG/ck9fC6KkYyBSPdZbTy5tz2c0UHoJtP0ZrF9cCuhgiNi4ysiyGRVH9QvWuwZb5x1g25OIzyAr+uokITxtc16cSpVzBLHU9WI+W/D4fIr2dJfFFI2m6ny04BY2eWptIeEBcoqT+7nBcfuXbFzms2Fem3XAWpvHg02QSrVqxu3guv1+TbMbwAmBTXBindn+bPdLJawfY80LEHC1vinrXgKZlWsb8cJ4MFKiyJxfu+06NokJNT71k1OKRcC2KlYuiD75mhk3RjHVGhkPyp89XwUwKdq+MikVpxi9JhIs3jEl4Irirnkh0YTumfNFhDQu7T1FMd44g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7351.namprd11.prod.outlook.com (2603:10b6:8:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 01:26:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 01:26:41 +0000
Date: Mon, 29 Apr 2024 18:26:38 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Vishal Verma <vishal.l.verma@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vishal Verma
	<vishal.l.verma@intel.com>
Subject: Re: [PATCH v2 4/4] dax/bus.c: Use the right locking mode (read vs
 write) in size_show
Message-ID: <663048ce71dab_14872949a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240416-vv-dax_abi_fixes-v2-0-d5f0c8ec162e@intel.com>
 <20240416-vv-dax_abi_fixes-v2-4-d5f0c8ec162e@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240416-vv-dax_abi_fixes-v2-4-d5f0c8ec162e@intel.com>
X-ClientProxiedBy: MW2PR2101CA0013.namprd21.prod.outlook.com
 (2603:10b6:302:1::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e3b3b4a-cdd0-4f2d-710c-08dc68b4968f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W7JFYwiGCnSQN/a1TAUgGodx/SJEzvpE+/7gnpFjaP+/6xDGtOD1Tdb76SlQ?=
 =?us-ascii?Q?NbBOuBVhbTQ7dKq3C9Yp2kBKZeezPuTCBUorhCG0ovIEMEAZwcQyf6w96m7W?=
 =?us-ascii?Q?IXgz4jrppmeIPDUwLgQyjmh6O/LzMBt+KYpoYG9/NdEt+qXqA1jkXfSYyRFV?=
 =?us-ascii?Q?h3KLoCAOO7SSZ6D3yZxrGD1Xhafn4Vm7HuAfRMNJACAM1U8j2/+iv8AL9hh9?=
 =?us-ascii?Q?QbFJ10WqvtYXA754Un00Q6SUKQZ0KNSg1ZxPmdI63EHP3zs1lb8VW1X9XYlg?=
 =?us-ascii?Q?HLdWpH9NeKX/0TAV79vQyRsL6VnUcPE56WopLQ6zm3UevR8ENPXwUdzYsJWq?=
 =?us-ascii?Q?qOS2C5TRRtCwP4jBoRN7VvzLb0rL0ITGNqJNaAqVmGmwPCi+Jot9FD0jE7ER?=
 =?us-ascii?Q?4hzL/QTxxeKrYLxMZBu2nCbRJyuL8Up7t1ClpWSXk2UbwoWyajjUFKYqhXl9?=
 =?us-ascii?Q?lKC0aZHv9UO8b0Sroihz2y0yk5MfHXAnrOlwEUFDVIxyZagRCcOLHFDiac/N?=
 =?us-ascii?Q?EbNTepYvh+JuqzuF2hz/XPqDvtk5TWTUWG2TTApVoz3GhFdCmmSD5m8EBCM7?=
 =?us-ascii?Q?6n4MjbrAhhjrnFbD4uxkoEd0liPy6rdEtvGTIwLQeXnraSffh6U9ctcjCtP4?=
 =?us-ascii?Q?R2GAlwqd8nBDQu1oPUkEEA8Lff1cgfJ17w3m3oOR0rP9l0YepGb0nU/AgbGm?=
 =?us-ascii?Q?2bdJ7ZuYqiF+9BavfLWxbxVkT7CtGk2X96I2gQ6w7Y9dk8Bou6V5u4UbDMaY?=
 =?us-ascii?Q?dAIPJmmb8TR9gGFo9BMSQ03SnjRjz5xW9AY3IiTejcpyqvgfFIsvMWt0/08H?=
 =?us-ascii?Q?flysTFgESPNEQpEczc0SfNHFnOu3JLJIXbKb2oCYvGqGOcx9v1dk6pslxLtp?=
 =?us-ascii?Q?B0wUsBPhyZwhF62J4/mNO1AH2xyYWwxiHcGHXdDNW+1NcmuibBMbTpQeXphW?=
 =?us-ascii?Q?qzkADw/h1T08/2mEr9mkemLrzpeQ5I6pbgsFq60/+fYC1QLbcLeLsbGhY2wb?=
 =?us-ascii?Q?V14W/zFK3qedURvBacnGHEnWjXtarfkCkVbX094X9YtTq+9kp4PtrHhwcuyS?=
 =?us-ascii?Q?lBjvwGfgYdHQ4Oh6ENZgPdhDdIJ4Y6oHOZoSA0jxaw+G4PwgSt/Pimj+awMS?=
 =?us-ascii?Q?wmUJCSIn9IZ3oTv0oDmfJG/nNHV4o26SWakH8xSy3/I0uIOCAJVXm+iXhG9A?=
 =?us-ascii?Q?cnL5T0awzvKrlKCm+FTufVxgc69DEO/7WejramKgYR5r0adJqjGtC8nBo6q3?=
 =?us-ascii?Q?7U/nuViQzSDhhLBi7cTAClzGQ3epZZjtosLEcG2fVQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hr4mx18uLMqPzpTAZALcrKMfUL+k6eliNR/ob0wfVTV/xMHeLx39EXrJ+Vel?=
 =?us-ascii?Q?VKMXXqGwRy4Um3jAMs6hdVSXw4YVYBdWAoonZe5YpQTaefr1/uwS1h5fV1in?=
 =?us-ascii?Q?lNvU04n1JKArmgyduPbIYZ9X+jys8KhtaDT51VdmPXP2BwfQNE++zSa/mK35?=
 =?us-ascii?Q?+9W9HNhezsIK5s0N6pYi0GIMa2BBbH1HiFsQc9dzYj3LXnPlamrkZNv6PfV/?=
 =?us-ascii?Q?4HEPsZcZ6XqLIoAoErh4O2nb1DxZiwT51Qqs0g5X/HzDREuxYFLK9LAWweHL?=
 =?us-ascii?Q?zYYSZ6oSny/mtlm46vI7YVkvLjnOcD01psGzRvQ2Ab2eEyajatXmNK7hNvMp?=
 =?us-ascii?Q?Z94yKfMWw3inIhe5FcJTsa1ua4pGK1rjvIEX/S9abl4w/ZNZTPUwDZ7Qf7G1?=
 =?us-ascii?Q?Z29+I/uLSsr5V9pTvzBn/Zjq3Ml0efcfPhFpj8nYEV7/1dAPdxEoPKu4S2Rh?=
 =?us-ascii?Q?dPvJhiSPHMvuPMSRACe84cT0zf29atu3YzuSVKZxJIueYVpvepNKcI0PGb9E?=
 =?us-ascii?Q?JdFQ6kUyCSIV8oFCRjIY4pVFLbJDGvUoXnqUJsjH4NkT5L/V2qCX80/d6u5c?=
 =?us-ascii?Q?3iQZ61Cp+XoYO6NiCQK5r4pRKAkbRUYi+g8BLKKSw4VKeKaCRhdXl2VLBewX?=
 =?us-ascii?Q?nBaX7WfFpBSizb/K9wmVx5GEPSh1q/DcO+SH0ca3YNrzeBUmvpE71x3/N1NG?=
 =?us-ascii?Q?MNIep/Ebz3QJq4r8+cqA/L7l/09ZgnSj1XLmusJicdENf4PQEziRFzjyd1zm?=
 =?us-ascii?Q?4gbkvMJJygmImsmCysm49bfnTT6SqJYhk5upZ5VYOdnEpOLEfBxisA+c459P?=
 =?us-ascii?Q?w0DlvbyNvVgPnCM2qF8jM90miEOa4TsAUxo31bXc/xrw9vxv00Qjl9iTJuQa?=
 =?us-ascii?Q?eE0LMZEdc5D7M/KsBxDrZ5dkC1X4s+nP9c8dbJ+dx8Sh/B3qe8BVUSaEzPD3?=
 =?us-ascii?Q?8rCYBQJ8ClDWk/ahNYFwnVf5CRfu3hEiD/r6Cq64KyO0CZTGUY1dHbFMzOEw?=
 =?us-ascii?Q?1+T6mX9bhGgUaV0OApL1oRjwzTg38x2KPxDiXrrSu5FlLVl4uAk7ciCekpGK?=
 =?us-ascii?Q?UB6QEuT+7NBMeMdjp0mawvp+c0cxbm/Lcppqd26QuzsoJ6NA9C4YMNeUEPYQ?=
 =?us-ascii?Q?A/5qiig3+/eAzX+Jd/Lnpx1h3Q1mPJnrXHYZha+UfPU1iirctFyC/9ieWVER?=
 =?us-ascii?Q?5xSdSiE4qB7j1mhbMqgLsXs3Y/2taVIuwEBXjxg06e3LFce0RvD92e4RHJZK?=
 =?us-ascii?Q?SOVYJmc4Iw3xK+IOzvdeCnHshE0eqvKzSCtSuJZc+q6TYSPrBXFUyKiBySIB?=
 =?us-ascii?Q?GSgfjMI28UoDJ9NRv2ql+/Qao+P+SgeE+a3V3aB4J73+i70c6xPBkUtf70S/?=
 =?us-ascii?Q?KFgsl3w8Q1jnnOXN8YSlKy08X7uph6FqEK9BWz9r54gyNhSkrxKNmPX/pfkf?=
 =?us-ascii?Q?6ShxlQf+P96UwFJSt4/YfjXknHOVFxjqDiC6qRSEf/++YjkFLP04H4InOFEX?=
 =?us-ascii?Q?buTpgZZFQzudYZ/ZKs89RoLFf8PWLIsldZGra5Vp2ocJKvpHYPowHBuLVKsA?=
 =?us-ascii?Q?3EhcVqtXXAQ3mm20cQyLePYXqeSrfbLQd0RaYAt6lzk+loWbBRet3TVIUafC?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3b3b4a-cdd0-4f2d-710c-08dc68b4968f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 01:26:41.0125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhiV4+ArRLzVYl12iWitOOtdC3da8WvcPyoXMK0OeNc3pqJ9BlPqNv3bN0Rm461Zsitp/zmlEGIbTJxnusrUd1mAGhDe7iJ96FmTsWNR0PA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7351
X-OriginatorOrg: intel.com

Vishal Verma wrote:
> In size_show(), the dax_dev_rwsem only needs a read lock, but was
> acquiring a write lock. Change it to down_read_interruptible() so it
> doesn't unnecessarily hold a write lock.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Fixes: c05ae9d85b47 ("dax/bus.c: replace driver-core lock usage by a local rwsem")
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/dax/bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

