Return-Path: <linux-kernel+bounces-157416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 493A68B1160
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE29028B8CE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D6C16D4E5;
	Wed, 24 Apr 2024 17:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E5T2D4jO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742B216D4D5;
	Wed, 24 Apr 2024 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980615; cv=fail; b=TzZsTyY6Ssoy8yTRJQsU1ERZmTtzebIgdQlcFKDeJXF2LZNgoYZVEhWBrUsg29GivOtrjVSTyaGs6aYNHAfpe1GZTtM1S0BVqYaSLYK3cNyHzpp/N6O4GUDFkenaKWIdtm180p09zkrfZUchuHmBnFxJB1kA3GjkZSoMdvZKvkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980615; c=relaxed/simple;
	bh=4bbDihqxqBoyYCmGW6YwaQN3J4/ju+XH1JTl94/+Lco=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KEdy8zZzBbca5oUwJgU0NeaMsc7HtZE6Rc6oodjkCZmdDfd1pOJl5c30lwuFEHHAmND30bICHlFiTRFTX+bzS5VOzVzR3I9CF7vFa5SmanzUIfLZoLvkTWc09EEJFcSvB704ES0kSRz2wLZ1e51gWWVGP5aBh89ngYvBf84nKBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E5T2D4jO; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713980615; x=1745516615;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4bbDihqxqBoyYCmGW6YwaQN3J4/ju+XH1JTl94/+Lco=;
  b=E5T2D4jOKnA+5rXvNOfyprDwSZoEvyzKps1ZNKcQOO2qZ9Ds/oyLjAUE
   ml4x8Ci9Nmp/hWiSeccFzARkBQUTZsORYQCGoeXbaX52HTx+hwZ7b50Is
   cGt5we/Zu/glQe8v3gc5wzwwIo3pOzIBOHYmIq/+Nx8m8NDma7X6YIUsS
   d3u1PCYUZfDgCa8do77JfLLnM8fj+0fiybqZnoXjkfTtCv+FUueuht7X2
   K3ppFGAngtBAVkd46ifA0HH0OAioHqXPsaV+RDWMiVD4+NpaJ9BBW0xRP
   zUSgZtyheBRtDI1WVeLuk88lpSUNoNFZLWLlsOaUoIAOMkJ0EQ0MHu8bn
   g==;
X-CSE-ConnectionGUID: BFeCuxQbTLCj43FGQKGwmw==
X-CSE-MsgGUID: jyhHpvhAR9m57pFns3aKNg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9749951"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9749951"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 10:43:33 -0700
X-CSE-ConnectionGUID: xQQ+5eRVRRuVW0snbXvYwA==
X-CSE-MsgGUID: RBNPnd6qQd2xar9jysgjSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="24674909"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 10:43:33 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:43:32 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:43:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 10:43:32 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 10:43:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nm6CeH5EQvSQgt7QH9ObxZeQs2o/yL6nGdwgZoRFcWf3I500Jcqc0nfiod9WuJpMsIkwL4uwqS/8okFCsqvuqehEACxQvKlY4MCAfDpOjpJMlG3pVLGXCckwgdTVU57MGg4K8TspLrylhJAocjJxhneeW6llRJU5YmVgkbCIF4I8hOmTjwN1F77H5gB3MoIFyuTgmoXbcO1ZBAqkK9fVdp5t/wLXxzeKFxVrml5zKJ5kDZ9mfGWppuF/M0GnEAPSfjgbxyEflTTvdB+IEDHRBOpqHat6Qgaw7BbJKkoUdMXVgZUjc+YXfB1OSdDWvCCp/rc6tftg1VqEUgkoypwbVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bbDihqxqBoyYCmGW6YwaQN3J4/ju+XH1JTl94/+Lco=;
 b=DstMXJ977tCY/ruDWKIYIEs5+qHBzw63VGdm5IyP9xNKOlCN9Qp54rLUhGuTQ2MDr+P2MvFu0Qd843kNLaZxN7X9Yq4HEYyqJJ0cR6vsumdJA2EUq4/W0aXTYsacsBrs2AA9R5uA8xLnYtdyEQg3f+LzKnaB3/Zd579XbQ5KBbFSEni85qNYFjXeB2s4yTLv+ROIxotypLNDSWpkngr9B3JWRkxpb8/cV7I8iFC49AECLCLukNxktwAzO2ePyOXN76LM6D2rOCwLAF076CsZlhqvYYDAgLSdADJO1Z7dwcywxAhS1xwut24BHMpvXNYrPMrW+HHbqS3VKUw1+3PcpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB8599.namprd11.prod.outlook.com (2603:10b6:510:2ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Wed, 24 Apr
 2024 17:43:30 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7519.015; Wed, 24 Apr 2024
 17:43:30 +0000
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
Thread-Index: AQHakEQwBnh1fvUg7kmXRylMjbAVKLFrfA0AgAABsLCAAA+0gIAAAzKggAJ4e4CAAAXEgIAAEDgAgAZleUCAAGCP0IACkhcAgABFj0A=
Date: Wed, 24 Apr 2024 17:43:30 +0000
Message-ID: <SJ1PR11MB60839D2F878F98085F8F26E1FC102@SJ1PR11MB6083.namprd11.prod.outlook.com>
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
	 <SJ1PR11MB60832358E2E243784A57DDFDFC122@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <c0c4d40546e77f6c4428ed3df1530e74e38ed5ab.camel@intel.com>
In-Reply-To: <c0c4d40546e77f6c4428ed3df1530e74e38ed5ab.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB8599:EE_
x-ms-office365-filtering-correlation-id: 16612817-9cc0-4789-faee-08dc64860e25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?bGtlZ1JtNm5FNTJpTk85SUIvdndCOVhVWDNpcC83SVAzTk1tWm5Zek9QMDFC?=
 =?utf-8?B?S2l6UnpKNFBOb1IzQmk0cW9ZcjBiVitkdzFZT0dUMS91aHFFaEtLZkpVczd2?=
 =?utf-8?B?VzdHdzYxZk1aWmpHcG5RSTRGZDZkSnU2c1JybGtMbVBNT0NRR2k5NS9pYjRQ?=
 =?utf-8?B?K3BCeTdCNWRzZkNWcU90MTVPU1ZIbTNTUlU4VStCRTk2YlJPcEpxUEJseUgv?=
 =?utf-8?B?L2cxMGcyTUVyQVNJUWlrTmlwbE95RG0rUFZJYktJTVkxb08xdjFXR1E1eHJj?=
 =?utf-8?B?TXk2cElRWGdyZE1GRzkyNTZSOXEvdjBqdEJnWXBKdTYzaEtuZXpvaEFTLzh3?=
 =?utf-8?B?blowTThkMDF0dC85YjZLS2FKUFgyV092VGxGSWRFQlJPS25EVVArWkYzV2NI?=
 =?utf-8?B?S3E1SGV4YW1pdE9Kc3EyVkl5RFc4UEsvYlh4MTM0RS9SekNlZGtkc0tkajJs?=
 =?utf-8?B?VUliWTFkS1FaOUhJMW54NE5TNjZJbXJVSFZqdnRlTzhQa244Y0xZUHZhUCth?=
 =?utf-8?B?TTF5M1VxWmhmalVlRG5yUVEyREsxV3VzSzZ3VDY0aDdrQnNkb2ZKYzZWWWhi?=
 =?utf-8?B?VlJseFhkdzZEMmcycVpRMm80dFFpYkUzMWowWUgxR3pYTWhnRW54Umh0Q3hP?=
 =?utf-8?B?RWtPQ3hJclZ4VHdKVmtBUVR1d0ljdEdBOEFyaXBtTlFSVVVISzMraUpiTnlp?=
 =?utf-8?B?WkUxb2pGOFFvNDN4THdrYXJYNnRWOUpDUkJ3VXluVjNEUGI5ZkI5ZkVaaEhH?=
 =?utf-8?B?ZkkzYk85SUl6K2JNU05aZVFKNXQzc0RhYlJ0MXR3OHZ2Sm94WkVQaXIwYzg4?=
 =?utf-8?B?dFJNUUtyYUlmdzIvNXk5Unl5c2NhWnBIZk1IbE9sZFpSTFUvNVE1NnpyUVFt?=
 =?utf-8?B?U2dsYjZkZnMzQUZPY1lVa0dVWC9UOFJNdmdSVW15TlBQRDJJN3pHQkQ1eTgz?=
 =?utf-8?B?QWVZUUNITFpGWnRIeUpuQVhlNWpsYTZTdGRZTUo4SW5yM1hkVEMvOGFUZVB5?=
 =?utf-8?B?K1NLL2QzOTNkSHhVem84bTh1QUgzSS9Zb0lCSFRlbG5SNXhlOG9VTURRcTA0?=
 =?utf-8?B?VWxKL0U4ZVlqU0ROZ3lWMFQ1UmxvNGQxZEdxaHA1YXFUeXBDbkFWT2M3QTZZ?=
 =?utf-8?B?bEwxVC85L0hUUlAxT3k2MXBSQkd3UzlETFlaR3dubitpMmhuZ1cySTMvZlZ1?=
 =?utf-8?B?SUhLc1hpMnpwbHQ5SmlvZjc4RVN6bldVMlNRa1lpVUhjcW9EUGwxbEFCSFFV?=
 =?utf-8?B?bUdOSS93TElKZlpRWU9RNjBpZzMvL01VakthTGUvRnJIek5UcDFxOU5qeUZ3?=
 =?utf-8?B?R0hlWTN0S3E3SVFDbTBZbUdtNDNOOW5XekQza2dSaWNMbEZ1V2xJMTJCSzg3?=
 =?utf-8?B?NjMxUXRUUmNBZ21FT2RZZ0xNbFppaUdXbW9iZy9aZ3FTQU1IK3U5a3owM1F1?=
 =?utf-8?B?UkJTWWFBVWxaS1QzT0ZXM2YyNWdTejlRZC9zbEtvR21lbXF3Ly85SVV4ZHBi?=
 =?utf-8?B?YmQzczlsTUNHNEZsaEhoVFV5dERGb1ZaMFBMRGt1ak93aTZWVFFPUHdrOXhU?=
 =?utf-8?B?VTlsUEVRYXp6Y3Y5L2ZDZW8wbVM0QUxwUVRCSGFJbVFDalFKNjc0ejdXVGVu?=
 =?utf-8?B?QzA3RGhXTzdyVi9GSE80SXR0blduT1lVOW1Nb2U2NHJLUmpodE9jeHZnNExJ?=
 =?utf-8?B?c0phQmN6N2pzM0QwQmx1WGtMdmtqNE1CZTdMcElqNzk2MytaV1ZCNlZzdTdu?=
 =?utf-8?B?MHowbUZWa0Jwbkc2eUc3aEpwc3Y3S1EzNnE0Nk5lUUdkYzQrVFNOQzE5ZmhJ?=
 =?utf-8?B?S1VjK3MrTEp0UzVrdy9IUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlRJU3cwMkl3bXphOHVQMlRqWWVkVGdCOHBRQ2VpRXVIaTc5OGJWcXNwSktM?=
 =?utf-8?B?bFZ3ZFRSMEFBSEJyUzhzbVJiQTQrUmxFWlhsZFhWTXNoNEYzU3NrbUhsWkZj?=
 =?utf-8?B?WFVGcTIwRDRmMXVmZEdWZFZOZUxWbFh6dTlsc1U3L3BNUklUcDFFb3ZOREZp?=
 =?utf-8?B?ai9Yd1JremhtZUI3ek5KZTVVaUxNNnpPN2N5RmNLaXJ5bzZJZGJVMXNwYVpV?=
 =?utf-8?B?bmpSMzNIamRXaFZGaGlKVURPZWJGMUp4Yi9xM3Q0Y3Z6QThSVmRVTWtwc05H?=
 =?utf-8?B?SmVLM0pFYkVnTVcya0t4S0xoeHE1b1JKcTBGT2lNbWVMTG9WcnlsL3hWelJ3?=
 =?utf-8?B?NEpqRkdyQXhCYnludlN6MWcvbERhd3pBN3YyS2tZUVFOaFc1UGUxY3RRSExl?=
 =?utf-8?B?azlaaWcraU50bGVmZXFLdzJCQVYweVJkOGErQUcwTnMwNk92R0ErUFBMM2du?=
 =?utf-8?B?S1FFT3EvM2c2cHduNkJZS2grWDBuWm1VTDZJcDVQN1gydXl5akJjVkRvSzNM?=
 =?utf-8?B?YXJnMDVub2wycUZuVHFFM0QxdDZWeDRIOTQ5YjdjclRUWEVaOHNPQmJFNUp5?=
 =?utf-8?B?WU1aUzZvTjZtcGxUM1ZPRldqcWw3d3EzOHJSN1lkMnhJR0lDMWFQem16bzRT?=
 =?utf-8?B?Q1RGOStvekJadGVtMzhOeUdCNy9CcVFTdzJWTlc2aXdmMUs4VUVQZ1l4VGJt?=
 =?utf-8?B?LzA5Nk94UUVkRmtKRjg1MmRzek82TUh4QWljUm41NTBINCtiSWxRTnBuL3RR?=
 =?utf-8?B?K1E0bHRYN0VydmE3TUFiMnlHdk93M1JhVE93cnVLdlRSWVp1VDZWWEt3YkE0?=
 =?utf-8?B?MURHd092RVpSZ3ZPVnJBWEs1ZWpSTXg5ZTAvSEY0ajh0TlJXR2lLTmFFRlhL?=
 =?utf-8?B?OFE5TkI0YXI3TnFBRUM5Rnh1SlFRYjBja2JmOVo3Rlo3aUE4ZXVaNVQ1V2p4?=
 =?utf-8?B?RjIzd2p3T2F3WGFFSm12b0QxTzc0VnVYR2JTRktZWVJGYy9xUVFoRi9IMW1a?=
 =?utf-8?B?OU1HYXZ6clREUzdidWNUdUgvODk4SXdVaGgzcE04cTRYMGFqaTF0TFlDMTNl?=
 =?utf-8?B?KzNlSmJ2TmQ2aWRROWRuM1cvWFRCbk5OTlpFQ1ZXRzN6L016Z2Z4elF4bVlU?=
 =?utf-8?B?dGtqWjFvZm52cUpLYlVLNEJiV1NlZVc5ckFoeHQ5UW9CQXJuNjkxSVJ0VDVt?=
 =?utf-8?B?OVVYc243ZWRWT2NLTDVxUHd1eHozTXBFeE1sWGxLanhLMnVJS2dDUzh3emJX?=
 =?utf-8?B?VzVtSXJ4aU9YT3A5ZENPRG84ODluOWx4L3NzMk1SdWZ6dVFpcEpYelFPYWJ0?=
 =?utf-8?B?R3pMdzQ2Q3BvbUlpR2RUZm1ScTNwbjlvMjZtaEF4dll3ZXhlUzhpdENDaFpw?=
 =?utf-8?B?SzJvOWhZUWwvcXBCVVdoMGtYSFcyaUJJM0EyVkdVQ1NYVGpOVHRnYUJONTA0?=
 =?utf-8?B?cnpVTUsvR1gxbjhVWEF4VTJVVlRkM2RlZ3ZGbWt6ZTgrOEZiWWwwZFdocHhz?=
 =?utf-8?B?ak52eVZJWFNDMDFFRlUwcEZISDRIOU5yOVo2MTR3bXRjRjJNR3dTRlFhRDZq?=
 =?utf-8?B?WlBCS3UvUkg3QVB3OXJYUkhya2JneW9KM1ZPM2RqTE1FVXp2clFQN1VQbUgr?=
 =?utf-8?B?cjZHd1B3SmZQVFFPRmNsY09oNjhBZTVYZGQ3MWIvVEZOb3Npb0E5M0ZzbnFB?=
 =?utf-8?B?MjVqUXlQaTd6WFhKdCt6Tmk2ZHVvaDlabnBFSTdHdm9kV1Z0VktzV25OeFBo?=
 =?utf-8?B?MXpDVGRXSmR3VzFJUkhkZWlWWjJLNll4MnltSVRXLzgrQk5QdmtoQSt1bTlN?=
 =?utf-8?B?Unh5SzlNQkE1Um9SU2RNcHRYd0lwSk1JZFhtU0Z3UktxckFsMUtGZG91WmUz?=
 =?utf-8?B?M1FENjZrTUR2RktJaHVYQjhhaTFjY1lvbm4vb0hQQlgrb0pBOUtMTFV4RVA4?=
 =?utf-8?B?bUxwcEpvdjJMbXlVejhDTzYxMndHdEc1ZkRscnZVV0hqc3ZGSDkyVWIyM0tq?=
 =?utf-8?B?M0VNZXdPWkxrVVlDNGNyNXNRM3oxenR1K1M4c1pESTZFVmdnbjFJK0k5aWR2?=
 =?utf-8?B?dFgyQUxrcnJsSkFsREtkTU81TlR6U1diRGhJNlBFR1daOHFLTnM5VFRMeDdu?=
 =?utf-8?Q?XeRq9VzgvzhAuRUoy+T64R5nB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 16612817-9cc0-4789-faee-08dc64860e25
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 17:43:30.5107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6KMlaQ8kay5w52Xqw0cdsueAuCZLELYYhjJjfAvz9xLNC71YYjGTvXrxWrWtiijGY8s8S9VaInzkDziyglxLmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8599
X-OriginatorOrg: intel.com

Pj4gSWYgeW91IGhhdmUgYSBtb21lbnQsIGNvdWxkIHlvdSBwbGVhc2UgY2hlY2sgd2hldGhlciB0
aGUgcGVjaSBiaXRzIGJ1aWxkIG9uDQo+PiBhIG5vbi14ODYgc3lzdGVtLg0KPg0KPiBJdCBzdGls
bCBkb2Vzbid0IGNvbXBpbGUgYmVjYXVzZSBYODZfVkVORE9SX0lOVEVMIGlzIG1pc3NpbmcgaW4N
Cj4gaW5jbHVkZS9saW51eC9wZWNpLWNwdS5oOg0KDQpJd29uYTogVGhhbmtzIGZvciB0ZXN0aW5n
Lg0KDQo+IFdlIG5lZWQgc29tZXRoaW5nIGxpa2U6DQoNCj4gKy8qIENvcGllZCBmcm9tIHg4NiA8
YXNtL3Byb2Nlc3Nvci5oPiAqLw0KPiArI2RlZmluZSBYODZfVkVORE9SX0lOVEVMICAgICAgIDAN
Cj4gKw0KDQpBZ3JlZWQuIEkndmUgYWRkZWQgdGhhdC4NCg0KLVRvbnkNCg==

