Return-Path: <linux-kernel+bounces-154081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F40118AD731
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29DD1C20D97
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7101F945;
	Mon, 22 Apr 2024 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nitZdQai"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702C01E4A0;
	Mon, 22 Apr 2024 22:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713824400; cv=fail; b=MPEl4VPG+pqHXHhgCpfoneoGjz1TtkjiMOMNfhzQvzDaFd/oNfV+SUjZStIulK1yGkaAKH+xV76Ere5WskPE27T4L7X/aWrVmYvom1lJFLlxh6wJ1Zotyy48OYw4dqU3OVLajgqtgL8q/4oyVALun4Y7yGFIP96ydJVkfETBvRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713824400; c=relaxed/simple;
	bh=A8sonWcetWjaaoJPj7ngBYiUgM1SwFZT/nmVhvI2V4E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KbzHeAdDL6GHoxSYnLzgjUgeMu4C9MjTgnmOnTtk1dTuqxjVXLszc7YlSzwHMxg6fTWLX5Jt542CyKdn5Zl6SBUZ4++2bjF0CG+AbNYCYdtIHeKngtUu3ha6Kc1ZlLRqX7B8+TPEztIDBJLRkdb0zGC66iGvJTBHIi/5XoaOUi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nitZdQai; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713824398; x=1745360398;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A8sonWcetWjaaoJPj7ngBYiUgM1SwFZT/nmVhvI2V4E=;
  b=nitZdQaivDbl0xRisLElKY7E9UkmS969LOGZ2M5NeEcK4RodyHAlW5LF
   4VxRzMu5Aw5pGB0oCBFFGe9HgxZihsblvqCnlGTXRJhtY/WwKAfm3V/U1
   10SFnDUEPU40xwODj97gmmjcuWi8sAuHyUdw7B6RYEY60Dy9FvI0jFkED
   /NkyqUf14JTJqY7jozhXbpuLavtCF4TrcIXzCGw8WCz0nUxDyPeylpoQ1
   6F72vM2zRn+jDFv3v1ayufp/WHgjxJZqXIaSfQHhErThosaGxLkfYin1/
   5AtoSdfg67xa9KAVeudhs/vBblhzZRRmFlPOLr0bC0KMkKLF4HKbB/Ypz
   w==;
X-CSE-ConnectionGUID: 7DVRq5zkSmO5viYrcd4aSg==
X-CSE-MsgGUID: jMYl36wQQhu0SmWn/WmnSQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="19997010"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="19997010"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 15:19:56 -0700
X-CSE-ConnectionGUID: i4ObMmCtSKyM5kAe7Y5yPw==
X-CSE-MsgGUID: b7YNCOG0TBaNJq12e0+BDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="55093512"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 15:19:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 15:19:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 15:19:55 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 15:19:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8aDE85QuRhpsqTtC8iH8Y2lsf3kUnodsxD21Vlf6iatJJveUjW9BUOz44DpnspLc4W5b65U9HY2e0DQ2fUHSahJbdKD/ewu+XsPceJApZLTx0u8A4cbxfGDYuftelmjBAB2n5OPtnp45FIj4eKMXBbGT+yhfkoaSVR4a/CiLyfddGxbGJA9QrJw47dUg8HwkyhN+MOL0VRMs/lMXSybN7yt652g4EZUnQhb2XlIapkz7MfGFPDnQhjy6rtSknPs2bJwQZgNTrUStknl3GJeTdD5z/U1fBsZBsgQ1v3yL0EE5kN3TGTT2o978hTFG3aFXN0IexPYgjQsno6tFgnwZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8sonWcetWjaaoJPj7ngBYiUgM1SwFZT/nmVhvI2V4E=;
 b=W4RYapSQqQzPYu0WeCP4vBNewL97GkI1Lf0kfAlgMvrYMR5IGFAcAO09uKVD96GK91NAhu+xRvoC3Sk/e+xRAJbHwjfmRIha7nxqHHOwwZkdsBYdrs7KF8Y3D/Kw3bX1JVB4KA6v5IEEOghEZobCHVCFbJJ+m5sKRtCoTWtBNwPYzPE8CPfItTZMBPdPQhYo4uXfN158UscnzVGLjl2oS1URrhF3Ht5BG8T3VS5lU2iRFKcG4nQum7Rc+iuhUEfP3lW9Ypa1Qh4dXi4XwdEHIFzpzTpLoiw38qrWjJ3TB7PIP/p688xidkaaqtZfLOg6bm9dN1I0Xac/w5fEoeyaRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA1PR11MB7197.namprd11.prod.outlook.com (2603:10b6:208:41a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.19; Mon, 22 Apr
 2024 22:19:52 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7519.015; Mon, 22 Apr 2024
 22:19:52 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Winiarska, Iwona" <iwona.winiarska@intel.com>, "linux@roeck-us.net"
	<linux@roeck-us.net>
CC: "patches@lists.linux.dev" <patches@lists.linux.dev>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jdelvare@suse.com" <jdelvare@suse.com>
Subject: RE: [PATCH v3 50/74] x86/cpu/vfm: Update drivers/hwmon/peci/cputemp.c
Thread-Topic: [PATCH v3 50/74] x86/cpu/vfm: Update
 drivers/hwmon/peci/cputemp.c
Thread-Index: AQHakEQwBnh1fvUg7kmXRylMjbAVKLFrfA0AgAABsLCAAA+0gIAAAzKggAJ4e4CAAAXEgIAAEDgAgAZleUCAAGCP0A==
Date: Mon, 22 Apr 2024 22:19:52 +0000
Message-ID: <SJ1PR11MB60832358E2E243784A57DDFDFC122@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240416211941.9369-1-tony.luck@intel.com>
	 <20240416212216.9605-1-tony.luck@intel.com>
	 <5869d164-25c4-42e5-bf87-c4aeeac57388@roeck-us.net>
	 <SJ1PR11MB6083D0DFBC7DE286F986A453FC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
	 <8690bcea-3ff4-49f1-a671-16583b8d241e@roeck-us.net>
	 <SJ1PR11MB6083C8D12885057BF3A0A6AAFC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
	 <7cb09d67409c94284928243d8ffb1f8a3128d849.camel@intel.com>
	 <f1d02e4f-a947-4af1-a7c0-9f7c12c57b3e@roeck-us.net>
 <f0b67e10b79e7e57846f792a0671434ce20c878a.camel@intel.com>
 <SJ1PR11MB60834BB7EF162E36DE58D29BFC122@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB60834BB7EF162E36DE58D29BFC122@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA1PR11MB7197:EE_
x-ms-office365-filtering-correlation-id: d8591465-abe5-4201-1aa5-08dc631a54bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?N2hxcDJkYnZwYllLa3lzTW90RDh5MkhROUdCOU44ZXdqQmVKa1ZuSnVKcHZn?=
 =?utf-8?B?TFNlOHhjclNRQzUrckw2MkhhQ01zbG5XdGFlbUUwTy9qSWhBd2drdVJvVEdM?=
 =?utf-8?B?d1lTaUl4eVNwVktHNEc5V1lES29RMVVJV2QzU3VSNi8zckhTcnFvaGEzNjAv?=
 =?utf-8?B?bzY5NEVpUzhXZmljTWNtL3h1VXY2dlc0N1FmQlIrWWtySmFEUWdUYWZhaEx1?=
 =?utf-8?B?SlJaZGt1Z0M1b09tV0ltYmFwVndxSnNaWTZhWVh6dGhmdlVEcDB4amZnWk5F?=
 =?utf-8?B?UnE2bGVubUphcHVVbmRrRU5zRXVkMWw4S1haR1QyVWZ6eHlFYm9XVkZycXNx?=
 =?utf-8?B?SEdwdHk0eEkxYXR6RVU1UGFPd1I4WHBzYmt5MUM2UDZjcENwVzdVbzBML2M4?=
 =?utf-8?B?RTBaSjBkQkd6NkpOajM4V0JqOXBuUktOYlFLQW52OFRqV3d2bUlYWE9kMWQ0?=
 =?utf-8?B?bWZiTWRzRzV6VmZCK2Q4MUJRdUxiYWgwb1hDUzFrb3JYcFNvVjQxQTMwWHBO?=
 =?utf-8?B?VytKTm9leGlWdm1UODhHa09pSjM4UDVBZVRvcUhCbGR5L3pOeFBRejdPQ2FV?=
 =?utf-8?B?MFgrMTA3bEhGWkNwSWF5aUdEK3VTVE5seCs1NGZ0NlRhWlI4QlRpMWVNZGRD?=
 =?utf-8?B?NzNyTlNlMVBhMGZmT2pFYy83QUVqTUVMOVRRdG50bmRROHZVelFFM0lIVDJV?=
 =?utf-8?B?VCtiMFZMODVIRVBpaW9oV3FibXB0NUsvb2VBdXB2UlJqMzllakNTNzlQTGFh?=
 =?utf-8?B?RGc2YkJqYkYrSUxiWlpNUm9rc1NtMVg0VmJEOU0xcGxSdU9HWnFNaGtmZUJh?=
 =?utf-8?B?TWNXdWd2a2hRbjlrRHV6SnN6UW90UFViOGY3Wmd4d1BoM3MzOTZsaENaaWgy?=
 =?utf-8?B?bTR6S01aRlpBY0kyRlUzd3IvcTBRcTIyN1NDZEJ6eGZqMWR6ajdKbFYwUWt6?=
 =?utf-8?B?MS9IVEJMTTgva2FBZ25pVmN5d1ZKYnB3M2VPeEM0VlhCb0sxQnY3ajl4MkdS?=
 =?utf-8?B?VGVCNk9lalpmRW8yZnBKN0c3QlVRWGhQOGVRQUE5YlBwZVFsckc0TzJBb2Q2?=
 =?utf-8?B?UTZ1ZHJERTh3UHo4bHJBemYvd242OEFNUmhGVENQcE92SFRBKzFEY3dHVk1K?=
 =?utf-8?B?ZEVveVJtN0JpTjRTN3RQQmJyT2lvU0VuVWNXQ2M5V0ExK1RwSHN6SFVUMkhJ?=
 =?utf-8?B?VllzNWRITENCZERHRzBzQ3JuZ3l6U2NhODlDYVdSWU9tOGZLVGhqSWM2NDdV?=
 =?utf-8?B?eGtCK041RlVJSm8vdkVvVUszS2t4a2lkRjEzNzJmbmgzUkdqRGtqbGxBdHNY?=
 =?utf-8?B?TlFJL2pqam53WGsvTy9IdHZxYTVCK2xXaFJDQzNUa21uL3VMay9rY3ArNjNE?=
 =?utf-8?B?RHRXWHNMNXIvNUZPSDRpdUl6SVJYeEFRZVA1YmhtQmxJRUtvK1NvaU9kN2s0?=
 =?utf-8?B?UWgwUTdyb0d3YXo3SGJwb0VnVTNCQVBaZS9KaXFub0ltdXJocDUxdmJaUG1V?=
 =?utf-8?B?YzFQODEvcndKcmhURGo5a3V3N1BUR1dacTNYQXpCc0JXN1NUcWNzbDl2RmJo?=
 =?utf-8?B?dHF4TkVCYXBUU09WSXp4R3VVdFA4YzVPMjl1R2lZcXlnd1ZKSmh6WGxlYm5D?=
 =?utf-8?B?Q3IyY0hPVk0zaGFlWHgzYWtwRzBld09iQTk2RG5DYVpqcE9Fd0t0Njhka25l?=
 =?utf-8?B?OE9zeHJmbE1HYmZWNXlEdXd3VWVJOE9EOXk3RzM5WnpKWHcvZTdWem9jK05l?=
 =?utf-8?B?eU13S0pwNUM3cDVtODN1TVZFb2FTSlRpVkh1TFNwaU9qQVVGaGJGbEVnaWo1?=
 =?utf-8?B?d1NyUUtXY3pLRzZqQXJ1QT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1VpQTlXbGRMbTd2eExCNXZSSElZTmxPQkNCdDIxVExPKzQ3ODk1bUdkQkl1?=
 =?utf-8?B?MWlaTUNRVUVQc1doV2pqU2s4RTBoN05sQ3owNTdsVWFvSy9POE90ajRIKzg0?=
 =?utf-8?B?dzNMR05vVXkvcCtYMGdOWUNWNmsxU0c3a1NRYnlpVEc3WDVnZ05SeEVmQndG?=
 =?utf-8?B?WXVqczZpR2ErYmx6K2JqSzJHSm94b2hsbFZxekJTRkt6V1BGTlMyMUk2MkF2?=
 =?utf-8?B?RWxHd1NrN1p6Ni9CN0Y1aTZLSURHVG85L2szZk4zck5YVndNbzV3Vkl2MFRt?=
 =?utf-8?B?aUFwTU5RT3JTNG5Wamd6eFBacHNKc2xEbUFBd2Q4djFvN1U1Qk5HeWFhZzUw?=
 =?utf-8?B?SEdpYlo1T0taTnZQdmdmWk42MDdYZm1wazdUM05BL0QxamhwdnZoTDlUa0FJ?=
 =?utf-8?B?aWp3R3FmTjdWTS9sOVRvTkhJS1BNakVCcGNiTGFtd1ZLTTNhYjlhcytoK3JV?=
 =?utf-8?B?a1JsOWcrQWtFVUpMQUYwanc4VGtNelA1K1JadVJKMFVqUHlOazBIYkZEQjNU?=
 =?utf-8?B?R3dIYnEwUHhZM1lib2puQjVCOHgzcXJjcXA4bUtVbWxjMkUvWEo0YkNxdlJo?=
 =?utf-8?B?ZEVnTlJuczExWFYyNEpWOG1kTHlWYTd3VGVxNXZPTC9jUXV3Uy9vOWlETlhU?=
 =?utf-8?B?ZXhWeGtLeTdudVFxYks4QTIxYkVZNTR5bEduQ3IyY3h0Q0FSTWhTNjVPN1ph?=
 =?utf-8?B?OFdSY1V1b20yOGdZM1J4N3FYZUdUVmlqZUZ4RTlwN0VWOGdlMThRbnFoM1Fl?=
 =?utf-8?B?NCtFbGNPM0U5WlRURi9ZQmJka3kwRWE1QzdjYUZhV3NVell5K3RtelRXN2p1?=
 =?utf-8?B?UFh4RkovRlZaOHpsQjNMYTR5YWpKcUNqQ21aOHhleU9JVU9tY0xXaGpWbmgx?=
 =?utf-8?B?Z2d4N3VjQkJnQ2FHTjZuQUliUDh2a3Z6UTJNaStIVHkrRzV3cGFnNDBZeHdi?=
 =?utf-8?B?NnczL2NuM1VTVlc4Wnhnayt1UUJjSXZEWjA4S3VRVkRsL2hVNktHVnp2ZC9u?=
 =?utf-8?B?U1RrUHpWTnloTUhmcVZ5dldpR0JZWFRBQTVyYlo0MjBqSXloVW1MazFUUGI0?=
 =?utf-8?B?bmJ6UlRZQ3RYVUd4L3IzZlJTNVgvUFZpSHViMHVIVG5SREhLQ0s5bFhQTG9q?=
 =?utf-8?B?aDNFTWN3eXlNcG1BMCs1b3YwYjJ4L01NY01WVklzeDRybFVhT3lPdGlsSFll?=
 =?utf-8?B?eXFOL3BuR0hva043NExySjFQcnZwWjRHckJFQVZMakV0cXlCYkF2TytwZzFi?=
 =?utf-8?B?WitnM2ZncDJHaThkUlFyODc1cllaZFhJZ01kVkhlM0o1ZUF5TG1INmNEN1NC?=
 =?utf-8?B?cVY4WTlLekZGWXk5M1NLaDlHSW8wbHpiZHpvVHhBdldhL2tyYTNEQzVLQlcr?=
 =?utf-8?B?OUQ1VkppYjUxVXNDT1VPQlZwS2ErR3cwcFl3UXlsUEgzbUg4WFEzRGR4dmFw?=
 =?utf-8?B?TWM3K1pYWDZ2L2o4d3A0L01vSngycTVpQTA3M0lrR2JURHFDeDdnNUcyYWN5?=
 =?utf-8?B?Sk1yMm9TdE56U2F1RlFnOVYzNVlDdUsvODhkMzQyMUxPMFRXSHVwV0dlL0hz?=
 =?utf-8?B?VTNVYTY5ZURmcVhEMnhEcytsdXZXM1RtNkYrcC83dVgvTGJuVk1uU2tDOUQr?=
 =?utf-8?B?clMwUjFzTTUvS3NFMklyNXR5YmIvbzh4bCtpQTF3OEdBN0ZPTVh1K2U2SXdP?=
 =?utf-8?B?eGplMG9oWWgwZTcvNllMMmt3Y0lENWJIWUcrc3lxOHczdFRIS1dETTM5ZVdF?=
 =?utf-8?B?ei9MeHc1ZFBMa05icE4wTVBnVllkSUd5Zzhzcnk0NWJzMkxQUUJaUnJxOGRV?=
 =?utf-8?B?TjcvUk1HdEN0bWtkS3dEU0ZDTTFsM2lnWXRUNERLanB2VWE5eXAvWTdwaWZT?=
 =?utf-8?B?QVpDVEhwVTVUdkswa3ErWDhFalBTd0R1Vmw5dzEyREIwSlNwV2hNSElqRy9I?=
 =?utf-8?B?T0xBWWhVWjhrU0g3WHV0N2prL05odnF3RzBFVDBKcDdiZkpMaGw4UkpSMkVi?=
 =?utf-8?B?K3g5dHRxb3hJZW5nVm5zcHQ3NnZuSEFDUGZQU0pBMnF2VExMZkt5enRRNGZH?=
 =?utf-8?B?VHAxWjVwWm4vK0FINHEvdmZlRFcveWpYWTkwU2hzS01sTkZzdWVEdEl4MDBS?=
 =?utf-8?Q?gmactN1W6xz8e92pKbR6l2vib?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d8591465-abe5-4201-1aa5-08dc631a54bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 22:19:52.1353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +jhSvpSSlAuA7HjipfadVDZv7g5KbXVFGqMhjWciawYZAxqnQPBu5KOAUsQIVucYxN/KVoEbkqVH3Utg8hVOlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7197
X-OriginatorOrg: intel.com

Pj4gVW5mb3J0dW5hdGVseSwgaXQgZW5kZWQgdXAgYmVpbmcgc2ltcGxpZmllZCB0byBqdXN0IGlu
Y2x1ZGUgYXJjaC94ODYgZGlyZWN0bHkuDQo+DQo+IFJlYWRpbmcgdGhyb3VnaCB0aGF0IG90aGVy
IHRocmVhZCAoSXdvbmE6IHRoYW5rcyBmb3IgdGhlIGxpbmspIGl0IHNlZW1zIHRoYXQgbW92aW5n
DQo+IHRoZSB4ODYgaW5jbHVkZSBmaWxlcyBvdXQgb2YgYXJjaC94ODYvaW5jbHVkZS9hc20gaGFz
IGJlZW4gc291bmRseSByZWplY3RlZC4NCj4NCj4gSSdtIGdvaW5nIHRvIHRha2UgSXdvbmEncyBh
ZHZpY2UgYWJvdmUgYW5kIGNvcHkgdGhlIFZGTV8qIG1hY3Jvcy4NCg0KSXdvbmEsDQoNCkkganVz
dCBwdXNoZWQgd2hhdCBtaWdodCBiZWNvbWUgdjQgb2YgdGhpcyBzZXJpZXMgdG86DQoNCglnaXQ6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYWVnbC9saW51eC5naXQg
bmV3X2ZhbWlsaWVzX3Y0DQoNCklmIHlvdSBoYXZlIGEgbW9tZW50LCBjb3VsZCB5b3UgcGxlYXNl
IGNoZWNrIHdoZXRoZXIgdGhlIHBlY2kgYml0cyBidWlsZCBvbg0KYSBub24teDg2IHN5c3RlbS4N
Cg0KVGhhbmtzDQoNCi1Ub255DQo=

