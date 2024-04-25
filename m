Return-Path: <linux-kernel+bounces-158911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6D18B2694
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15F8E1F2150D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911271DFEF;
	Thu, 25 Apr 2024 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TCQNpQiF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E7911721;
	Thu, 25 Apr 2024 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062858; cv=fail; b=MSoUp5//rMX+N67OPJeZTpgpNc1hqLeRrb6g7KNuOyU2L3hgZbNh52IaV5WBuMJ8kfo7bVg9JGTXkonaWC13xiHh4RY3TYcmJlS5Rw4wjooDgijdqJpuZNGwLKtVA2/3jvD4n4fosbBkFidwE4Npy7BIQSVkubAHwb4mVx+MwiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062858; c=relaxed/simple;
	bh=Ze7kDQqskMB1DwNRKuUqKq93UCMP5x56w9ujks/LrlM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N3mi39QoNEZdFtk+c57fuWmFNOb7JCQVQ9Zfcd92IQW/th6iOme8sTgqph7bzRlKwPulB01Zu6rZptTzSSt5lalHITgflV6YOUtO+v5STTywFjWbPYOmcFJx3hVJB6LO4eZ6LB//Iv2doqmwcTnB4jr8LMh2PJnzfDCeepQUod0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TCQNpQiF; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714062857; x=1745598857;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ze7kDQqskMB1DwNRKuUqKq93UCMP5x56w9ujks/LrlM=;
  b=TCQNpQiF9Qx5IhnP8naqRMrds6NhSt5VjCdlSNSC1+0/ombnGMLJHYRG
   gt2eehhShmiPU+PC3bsxq/oM+vlJdb7I8XMSq7hWVS+uXZ1F6qQKvRWvY
   +R8mh7t6XWPfbyECUv61jjc1QWfVu2vZaRPooAJPDHtcnAa3Lx3qettmF
   sTmy8Z/8ySYkVbDsRUkRIPhzX0u6xMLUSaCQ6S5MxxUaIiUAsf1EY/oxd
   iKxFCu91XmWXj+0W0FyFDXjjcVPBcs7FOLzQt0foUVm23aW24jlucdY1x
   XSTALcB9Dk2fZFiaeGLtSbQXYO/EVRltAO/NpmOwT2FBDBCOTON2M9fUN
   A==;
X-CSE-ConnectionGUID: XsP6TItcQZC1s7JQ9bD6CA==
X-CSE-MsgGUID: 2ucGvVBRQ6GyLEvpT3FFkw==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="10300544"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="10300544"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 09:34:15 -0700
X-CSE-ConnectionGUID: iGfJxNfCQfyNYls+/nA4Rw==
X-CSE-MsgGUID: lFJdWY/fTSaCba3/f1C1Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="25126776"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Apr 2024 09:34:16 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 09:34:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 09:34:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 09:34:14 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 09:34:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLnjbyxAgJJNBixdx+Vi/8CAY6F/8k9oUP7tyvhKYNxlsHpweC3AqCpb2VMnarniFRmWsjhejxg0C9gbQE6h5NDbU0epQwOFwwezCOu0IBcAXNqIKN3vp80QFiC6q+/fS1RUsEr6S9qBL3dCxKZGiVuTdOGn52MdlX0GZ+GhIXb3R7n3vDTHvFUFdidQF6r1Wbn+WuXTXFT3qTfGvHP2jBMZq7V2/3x1WEUTbMg0vHhbPlFy5FQKvWlDLScf9LtuMm11K3rDL2x8SRKrqxXhLH2l4tO6lhiqVaHl8H8dyb5z735gnaUGaU7FXfK75FGsa4rm5EUIP6VPC48/k+z+Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ze7kDQqskMB1DwNRKuUqKq93UCMP5x56w9ujks/LrlM=;
 b=ZPvbTHh1vVSh+7TuHaOHHqAsfZLS5g1ZgJF5aywYcl1hLmWTAOAzVKvTM2hvTbHa1pPKKm7ReXv11Kj2MTpXk5VAs0zoyMDB0FU2KluV061FcBllIFQ67pAYClFOBh/Vurpr3Nj855JNEQr9ia8MZiEzz92FoGwcrE9Z7g3sOcmCipynKWOChSPlUSYIAWaWPwz48ZAKVDgFrtX+G4sL9ripE/yzdWIx+Ak6wo9ShGgEfngg3ATIwGISRaIfqgmattNIpzPV2ebSuo1crxs993vDHsUs6GXootO5TAddfQvWBlUUJCZWFModSgwiZX+ilYDyLDusFoKg2t/P60Gjwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH0PR11MB4775.namprd11.prod.outlook.com (2603:10b6:510:34::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Thu, 25 Apr
 2024 16:34:06 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7519.015; Thu, 25 Apr 2024
 16:34:06 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, Borislav Petkov
	<bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
CC: "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH v4 60/71] platform/x86: ISST: Switch to new Intel CPU
 model defines
Thread-Topic: [PATCH v4 60/71] platform/x86: ISST: Switch to new Intel CPU
 model defines
Thread-Index: AQHalnN1LjN3dqm9SkOQN48H8pXA3rF47HmAgABCwdA=
Date: Thu, 25 Apr 2024 16:34:06 +0000
Message-ID: <SJ1PR11MB6083FBA3B2830D14CD6FA76EFC172@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
	 <20240424181539.42311-1-tony.luck@intel.com>
 <eafd7f1dd4fd3c86ffd97cf7f5c8a0f1de87f214.camel@linux.intel.com>
In-Reply-To: <eafd7f1dd4fd3c86ffd97cf7f5c8a0f1de87f214.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH0PR11MB4775:EE_
x-ms-office365-filtering-correlation-id: 8a74e854-2a24-443f-651b-08dc654586ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?UTBhdUx1YzF4ZHpIMXVRemlUeG1kYW1UUU1lRVJVb2tqNXppNGs0NkVrNTVI?=
 =?utf-8?B?TER3WW4vOWY0aHcxWVV6K2lNcVZlNHZRWHRLOWdtWTFuTzdHN29Tc09ZLy9z?=
 =?utf-8?B?T0svVExNSEE0eDRRQ0YvZG9TWENidDU4ak9Zcm1kckUySmFScHVlZGo2NDA0?=
 =?utf-8?B?S21oMEhZaE1DTCtzWmthT0JqM0loTEx1VEEzeGVFS2VpanlXRzZHbkFibEtu?=
 =?utf-8?B?Y3dBWUhYVDErVGw5dkNzamEvenhaWkwxVnRNNzRlekMwbUhNQWdmYWdiOUpX?=
 =?utf-8?B?SFhNZm13VXYrNmNOUDVzN3BSV3paVzBaY2FFYW1HRWhaQW9RS3dmQ21BKy9J?=
 =?utf-8?B?U2VGNk1GbUtLNkwzYUhGdWxCYzNycEU5cHdkbnkxUVQzVGd5TTE5ZGhac2JS?=
 =?utf-8?B?bklKelEwTUNoYmhlQmVCT3VDaXFWRWM1aVR4MG9ZRUlXeGxUQkk3bENLQVJn?=
 =?utf-8?B?S1hZcE13RnVHMGZ4dDV3aVdwUnc2SkdSVDNtaEpoSnd4dDJzdEdGN1hBWVhM?=
 =?utf-8?B?Ull0SnZ1K21ISi8zRURnaS9FVW5IZlpIUG9kYXJYazI2a3E4NmRZWTB1Wjlx?=
 =?utf-8?B?T0k0cTFHdGYwak81dFVxQ0Y4a3k0Zll5aUx2Z1NLUDZTSDRSdGgwNFN1aVdY?=
 =?utf-8?B?Z2ozYmZHRG96RlRacnJ0S09zWG9MdDQwYUVHbndrZTBaa2I3N0cyaktESUQy?=
 =?utf-8?B?R3V1K1daQnFkNitCT3BBZ3dXVHlaL0VXalc2cGEzWG5IUE9nRkZ5aDBoZmZh?=
 =?utf-8?B?d2l1d2NqNWdXdkZUOXBENkx2TFhiVjU2dWU4TVhFWFV0WFEvVmJmYjRURnlI?=
 =?utf-8?B?aGpuWmsxcExQLzFDR25kS09Jcjh1dit0YTdwOUVFMFZMZlBxdExDNE84MVdR?=
 =?utf-8?B?dlhMS2ltNTlCU0dpaGR5WkoxbFJiMTlIWkJuRTJPN09BcGxtQWtqbVVSV0Jl?=
 =?utf-8?B?bWo5VDd5WlA2b2trUDljVk4yM045Qkt5SEF1S3R3eDFOSFF0V0NwQksySTE2?=
 =?utf-8?B?UWh0dzRYYkpBT20xWkRic2VzSXhyb1dKUUZySmdWakhKakRFaUcrNVUwU2Qr?=
 =?utf-8?B?Nk5Ed1BXWERBazNGVVA3cXl0bVVCaXptTTFHZjc2Z1N4S1lvY1NMQ0g4cHk0?=
 =?utf-8?B?ZTZtcjMwdFFoNWNkclVCS3NKeXNVeGlQa0s1RndSRlBTRWxUYUdmN0ZoL2hw?=
 =?utf-8?B?RDF4RVNzV0FjY2o0b09QT0M1MXFuKzlqRUJTVU16Umdlbzhuc1lKVnVPamtZ?=
 =?utf-8?B?UjBzdVpUM3ZXQnhkSUx1ZTMrMHcwVzNWNkRZY20zZkhhQjhOcFJkay8wTVUz?=
 =?utf-8?B?M1lFWlR4MWo5djh2ZEVKbU1IejFxdkVhcU5XaEdGRVQ2K3BxOERjd1lITmQ0?=
 =?utf-8?B?SHBYTHE1dzk5dVJkR2NiR1hqZkVPRFhzcFlxWlkrYWcyQWc3eW53T0dRVTcw?=
 =?utf-8?B?YU1VN2RyQWJPaGdOcmErM1grcFhkeWxia0dXMTF6YTRaR3NUUzBvbzM3ZElW?=
 =?utf-8?B?WitYVGZ6MWVRaHE0QkxEcG9qemIxSDZYd24xY0o0WUdUUi9ORURQVzBXalBR?=
 =?utf-8?B?MmE4K2VJOUNUTWRxeUw5dEJUTEc4Wjg2ZGdIN2U2M2RoR05jNkJVajE2ZWdw?=
 =?utf-8?B?dWErb3JKZyttZnpDeU5NbVJ4MUFiS0lxS3dIUGJ1clIyNnZSYTlRYUFOemtS?=
 =?utf-8?B?ckQyTmR1YXh2Q0NmN3RuQkFiQ0hEc2tBcGhMZGxuTDZpM0ltMmtoQytWMlNa?=
 =?utf-8?B?ZC9MN0FVVG1BOWZuZGpCUm5ZWmRzVHU3OE1oVGxQMVppMHQrMkF4WGdTRWFj?=
 =?utf-8?B?L25VTGRDbTZjQlhia0dGQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWRNNmladFczU08xejE4MWpGVVdvOC9mbUtHMUJEOUVWbDJxUWFlYVkxUUJu?=
 =?utf-8?B?T3NQT0JLd1NXT3NkQ0Y2RSt4OFYzZ2NSeklYY2FWQnJ2d2FnSlozODU3eWJP?=
 =?utf-8?B?N2tydlhuWG0yeVJvWFRMTmlqNWpveVAydUFWZUNFeDMxS2xURzkzVXVBUy9x?=
 =?utf-8?B?YVhSb3I3L2RnRWZkeUlzUFBHREppWHRiWkttc2s1ZDhENHdma3A5Y2M2VTJI?=
 =?utf-8?B?VngybFZ2cEo0MUFyT1NJSERtNDAyQmlhY3ZVNVA5R3lnbUtmUDdpTnFpeGU0?=
 =?utf-8?B?R0prdFoxU1JacWZMTHlNR1BCaU5mZVo5UUJDeE5vRHUvdVI3NVRVMUtrdmNJ?=
 =?utf-8?B?MnVvZGVUL2xjcUR5UTZZRjNaVWhvYmx6bjlselhiMTR0Wm9LUW1SVWJpSFRV?=
 =?utf-8?B?VmZaOU9pYTArb0I2MWN5K1Jpakw4TEdzQS92QjJnUXlReG1xSHVzbkFHajNm?=
 =?utf-8?B?U1hCdGhRd1Ayanh6K2o2ckJiUFJ0LytseE43ei8rZmp1THcrWW85WUZTNUtv?=
 =?utf-8?B?U2RrRzIrTTFabWd1WlJVWXVnc1RRYlc1N0tvWUIvd2Q4UlRqRkg4bEV4Sitt?=
 =?utf-8?B?bVAraVNnNjZNNE01TzB6U2lwWnpNVlRWS2JaOFdFRTd2OWt6WE4ya0g1L2hO?=
 =?utf-8?B?UnA0M2NkeUwzRXk5aE1CZXM4Ly9TSDBvRlQ4dVk1Mm92VFBpOWM2YTVwK1Va?=
 =?utf-8?B?VVIvU1VVMW5kaFVidlJWR2hpVDNvTkYrUkdOeXF5VkIwQkNpTGNXdGpqUTJE?=
 =?utf-8?B?ZVNhMTNhSVlMRnFzdTBxWmxHRm96R0E4cWptdVVZQmZPWjZEK0VPTVlBcFNU?=
 =?utf-8?B?UE5sVWhaWDZCT3M1QXA3Y3NOQlo4ODFwaVhaSU5LUElLY0I4Q2ZFZk1zcmF2?=
 =?utf-8?B?U2ZsVTFaMENwT096amRpRHdSNFZpaDdhaXZ6bmRmaDZJVHRqRDExK0gzYVlh?=
 =?utf-8?B?VTJYWGExWU5SdG5OZkh6WjNCNjMvemhhaGtPMDBUallIV1doYmphQnlWTVc4?=
 =?utf-8?B?bUxGcU9qY21nN2c1djR6LzIxS3REVmRrUHBPTjloR0tsSVEzNnpzMGkxYWg5?=
 =?utf-8?B?SW9Ia1B0U0J5UmlhN0d0enk5VFZnU2VWaWl6UnhaMUVSYWdhckNwQ0lETmxv?=
 =?utf-8?B?UkVnOEFvYW9EQXZxU1MvR3ZLQXZDQzdsSWpaMUZwd1BWSXdvejk2QkZxQS9J?=
 =?utf-8?B?dXc0L0o2Vm96dzVFT0dsa3lsMXdtK1FZbkV3OTVZbGdabTE3amh2bWc5d2sw?=
 =?utf-8?B?THVZQWV6SVFpQ2V1eUZjaDE5b2VtZ2hLY3Q3RHJNVWJNWG5Icjc1VWlsUHBK?=
 =?utf-8?B?czlHRDN0NVF6ekIyNm1EamozSnYxTW9qTWpmdmE4bFNhZHhEbE1kT05vZlFE?=
 =?utf-8?B?d243U0c1aUtIdmhQeFRFekVXamR1M1g1aU02N1hKQU05MktiVEtveDcrTEEx?=
 =?utf-8?B?WGR4WXJQSlZ0WVJKK2dzYUJsRWptcFBTZ1JLWEthVWdKT21GbU1ENGZsQTJD?=
 =?utf-8?B?eEVrd09SRFVuRjhKOVVxdWhIMThNc01zekthblAxZ2VnUEVpNGRERmpLbkdx?=
 =?utf-8?B?Mjk2R1pRWEpnMkdUMG53Q1E2NzlVTnY2SmNWYVV2VzdHcWxSNENsa2o2bDkv?=
 =?utf-8?B?MzdSaVpvZjZLL1hGK040NEFTNUZPMUMybktVbExFOXdybWo4MmRRMVAvTyta?=
 =?utf-8?B?NXdhUlZCSTdhbkRtYkpSTUpDQ0tPL2xBNjNPcThhczRaUTJsWjlNRzFaMEhJ?=
 =?utf-8?B?VXpKbjRINEpyZzUrSGI5VUVoZXVvdHlNVWl5M1dlOUJleXJ4QmpGQnZuZ0JW?=
 =?utf-8?B?S2pHd00vL1lJVUZmRnhPMzdNU0NMaHVCcFkyb2JSQ3VzeGVxVUZsYXRwK2tL?=
 =?utf-8?B?OSsxTGl3d1RuMFpxNkhkVXBhaUdERVUrRllLVlZNblhtY0xxWXlUME9EOVBo?=
 =?utf-8?B?QlV0RTVEZVBScVVrY0ZreEJGSE5zZTQ0K2hHOUt4VW5oL3JyaDhjbGxuc2FQ?=
 =?utf-8?B?U1JSUWYyVUZobTE3M3Z3NmNGcS9KQmFiWkNGVTFTM3dWZXFEZFZDOGo0OEhi?=
 =?utf-8?B?cXJJMTRWZ3VUTnAxU2YycXM1b2JCblhCclpUdHhDVDR5UXV6SDA5SXJHQVpR?=
 =?utf-8?Q?TesrUcfbzEqodImEVJIpfjyH5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a74e854-2a24-443f-651b-08dc654586ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 16:34:06.8478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rhL9289oVjxTiUPWGuOgTjX1bNfm3ZnZNDncLXA7lINm6YGzhRXVtdRoUTLh90pMCkoeG515HJOGzFVzmkwR0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4775
X-OriginatorOrg: intel.com

Pj4gTmV3IENQVSAjZGVmaW5lcyBlbmNvZGUgdmVuZG9yIGFuZCBmYW1pbHkgYXMgd2VsbCBhcyBt
b2RlbC4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwu
Y29tPg0KPg0KPiBBY2tlZC1ieTogU3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1
dmFkYUBsaW51eC5pbnRlbC5jb20+DQoNClRoYW5rcy4NCg0KPiBCdXQgd2UgYWRkZWQgbmV3IENQ
VSBtb2RlbCBoZXJlLCB3aGljaCBpcyB0YXJnZXRlZCBmb3IgNi4xMC1yYzEuIFNvDQo+IHRoZXJl
IHdpbGwgYmUgbWVyZ2UgaXNzdWVzLg0KDQpZdXAuIFRoaXMgaXMgdGhlIHNlY29uZCBwYXRjaCB0
aGF0IHdhcyBjcmVhdGVkIGJlZm9yZSBzb21lIG5ldyBDUFUgd2FzIGFkZGVkLg0KSSBleHBlY3Qg
dGhlcmUgd2lsbCBiZSBtb3JlIGJlZm9yZSB0aGlzIGlzIGFsbCBvdmVyLg0KDQpJJ2xsIGJlIG1v
cHBpbmcgdGhvc2UgdXAgcG9zdCA2LjEwLXJjMQ0KDQotVG9ueQ0KDQo=

