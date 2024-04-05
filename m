Return-Path: <linux-kernel+bounces-133287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D7889A1BE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F581C20CC3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C0E16FF44;
	Fri,  5 Apr 2024 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S6ZkYqrl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC48016EC0B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712332095; cv=fail; b=lVUMbiZ/S2q67gAVlDWfyaCb2Cjnw6m4itzxFGIagxAz4H/lSTDUb4ZI6JQPqNppGlKyIm69t+ohmu/1StjoBwcMzEybTpRPOxIWoyzqt+Q1uGQo4pKPgnptWZ+eAEy73hFdGJm0eDKfxvCrSSo9p7Cvxtl85rrcyF9OnIflIKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712332095; c=relaxed/simple;
	bh=LkifIQHsuPELQ0S6C0Nmk3KniuGNjvxt05lYIOsPaac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BRGcJpS6F6dsKVQtcdgQQ5jWTee0arTEIfAvo/jtSTNmI/Fq7wUwFaWshGMvZdt8jt1RaWI00wuYg132wdysZLDRtgAb8xDiV7Jk0XdPQ0EbmWPC/z9vXZfbnIB9swTb1SgCJrHB8FViYi0lBNdmFrksfgpxBoMkPhV5ELeCbtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S6ZkYqrl; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712332094; x=1743868094;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LkifIQHsuPELQ0S6C0Nmk3KniuGNjvxt05lYIOsPaac=;
  b=S6ZkYqrlhsecmAR8S5pqA/rVmttRHHq90PsEbPPtLXOIvtiDmC5aTiwM
   I+/yj2VD/CFqzQUBVGgH9ZCjVqjM3CTEhL4vsXDTG7zweMS16rjaiEBIy
   UZ94v6dyGlkNwgDrAdtrcNmgD5bZi+M9X7jwBkeYxfvElclMwPMfq3JTZ
   RIuPy+tQ2n5TLucnSKP5AiGcySWG9SnqBIx0XBTrKPBbCPOfrpiBnKhg3
   wp2Q1X+eqyT7KvaQnRaOVhGIdvloYXA0hBiNY9DYdOKgwXlo3DtUOHkVj
   2qEgZrm9a8hfSgxR2WZ17dd+gAd5Xa2lCBMN3cFmZHy71DQkhQHJ9F2GE
   g==;
X-CSE-ConnectionGUID: Jvc6qQWVRNmBFjZ3R4wQ8A==
X-CSE-MsgGUID: H30Jqf4xTrmhhVRTDXkw7w==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="25108320"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="25108320"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:47:10 -0700
X-CSE-ConnectionGUID: Il0DXe1PS/yPKPwj03G9bA==
X-CSE-MsgGUID: zVUwyydTR9iz7LXMpr5Yow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="23681570"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Apr 2024 08:47:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 08:47:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 08:47:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Apr 2024 08:47:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQ0Ugq+kEnAjNxS+Tgr3T4dyla1nyoyiJxIJpZxtCVH8jQjDAGEbBefbj/jWI/DRSX7cI0EfW9w9ItC2Z2QhLcuIJCJiUp0BAMqfoaSATcMrSywPx8VpUnjA7D9oS2CO+k6CRRXXJls9w1zPZdRJrFICFhPJn7PNneCK6f38fk4SnaQju7cE7RWdIKRhjgyli1x3DusSYuqM8upZma/tBpstBbDNo9PUKXfPbA718gCGJadzd6PPbIgkrbqkGtkPFoqvj0hmn/2rEX7DjoojvIPZm852m8yC4OrCmRaAXmLCpC7viW+DFssvK7Kxaxkm0GB7CW+XgcaSGEngVS2iYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkifIQHsuPELQ0S6C0Nmk3KniuGNjvxt05lYIOsPaac=;
 b=GskeT+901VMM4xCE3h9aq8zpymml+/f7p4sBq9iqgzLge2AKq+qqETTKUY3awe+dNrkqVTuauUwyFHfvJlWCvRX37AX8jsY/v2/exF92a/Za0c2sXs9RN7g7x3YSay/HB9vaewQ4J3HzdkyPQ+PM7iwFoaFJFdGeDPWOkTyQ65TmJD9/2feE87FbMZ0jYDP3JgmnAci6DbQZ6dh7ByMQbryHL6zJm1LQvzTMmJf0eG+/gSpeETfbVr2DLCt/atnvdU5prMpsWtb+cUzvQCpROTnOvuvgSpZHdXZmd1lHIco5Nqu3W8VbYNZmOizoAKFmSgxX52XsORZ1g4u+emKSKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22)
 by PH0PR11MB4775.namprd11.prod.outlook.com (2603:10b6:510:34::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Fri, 5 Apr
 2024 15:47:07 +0000
Received: from DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::c563:8fb8:d95:71ac]) by DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::c563:8fb8:d95:71ac%5]) with mapi id 15.20.7409.031; Fri, 5 Apr 2024
 15:47:06 +0000
From: "Souza, Jose" <jose.souza@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "quic_mojha@quicinc.com"
	<quic_mojha@quicinc.com>, "Cavitt, Jonathan" <jonathan.cavitt@intel.com>
Subject: Re: [PATCH v3 1/4] devcoredump: Add dev_coredump_put()
Thread-Topic: [PATCH v3 1/4] devcoredump: Add dev_coredump_put()
Thread-Index: AQHabkHCwrYydZ1LA0ergAesrf2yc7FIy+uAgAAeTwCAERpEgA==
Date: Fri, 5 Apr 2024 15:47:06 +0000
Message-ID: <0fd0315bad912675b6ee45ceb9f2beaf50bd7189.camel@intel.com>
References: <20240304143905.52740-1-jose.souza@intel.com>
	 <4aa1f6ae3ac72a5eb3303740242d53d46a338d6b.camel@sipsolutions.net>
	 <2bab25ec4edd587442a3c14505760d47fa649636.camel@intel.com>
In-Reply-To: <2bab25ec4edd587442a3c14505760d47fa649636.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB8179:EE_|PH0PR11MB4775:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9DPX8DXaTyKZqMHBXmsls/ysSPqrI9yQJD4zGQYbPsYAlFcg0aVWLPDvw++ddZ9F52lLinUo9hloSqwsCc9mHnnFnVxqaVmJ6t/w3fJXeCyOAVPWCky9eP8qt0R4jAIVmbdNaiCQBAi9HZJc1ppk3uVuRE3mriNgE2GtTjICciG+8oyjrHQscIpY9CnS8/WEC3K/LJAMWeMFPoH0y6JgsahO1x2ktDcUTQQZQJJ6m4BCJZZH+nUGB5N6L3/MV5BXj40T12tRCZctIe/DarTa8a8E53jz+K6hAlg0exsbBjgbUuMGwHLPUKi84yb5L0y6B/ier/poWUScBf2Z+ARU6ucKTkE+QF3e6iy7YuQv6QNCSrW05yDMMVG7vH5VlSLZ4haXi9HjBiwCeV2EU20ILvnPdTrvWAQ9p3pfI83e0B3LCIJbzV2d5tOk866KpSz/2NrP1rhNcubnLvdaPwonbabIwMzUBQQILjJpU4c1aWYKDMj+btDhg5Ly9yG3iRluUBMU0TChT6F42Vjuu9dyf+SylT8E4Bi8vDMA6nlvprU5GKRncDdKjY792hyQ7nhMxJww0Chbp5dDVEsYPbNfsCLZG0n0YB5cdAHYRCKlkjCyNRy1Doxc7xammy9CtdxQTVxKg9plorUVurCDTkiib0fNQgoZVhnqErk+wpQxyug=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8179.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWFyRGdNd0EyeE5sTC9KbExQUHBvOWlzWGxkL0w5MExaNjR3NG00NHlET3Vp?=
 =?utf-8?B?VXF0S21jNmhqVDYrK0lrdmYyUittYUhrWUk4bG1qeVo3bnVhRVBqRmI1RVJT?=
 =?utf-8?B?MG8wcks4YzRFdGJjdWdqb0NYVFQ0Z1k2a3FFdGU4czkzUGFYZ1VQcW9GaUJE?=
 =?utf-8?B?TU11SFFhM2xocXN6b1NPZDZzOG85eGlucnI2aUdNY1Nsb3I2V2xPNllLMThz?=
 =?utf-8?B?SnFBZXlnUHBlNFhORTNyaW9NU1VJbFRWUHpIRjkwSDE5UjFPQkhpbjl3ZlRY?=
 =?utf-8?B?ZWFJMkEwbXBrc00zUzc2Y0ZNbGhSKzFIYS9DOHo4MTVPL01FTlZqYkNpeDhk?=
 =?utf-8?B?TVdJbXhIS2JxUXljVm82bVBLSDd3NjYyVW1STkRBUEF5c3dhSW8wMDlicXE1?=
 =?utf-8?B?dXlNMjN1NTNvY3g4VzhGZ3ZoQjIvNXZJU2x3eG90alpXQy8xTlpIZlBvbWVJ?=
 =?utf-8?B?dy9oSGNZKytXTHAzbDI3TStZWkdrTmpaVmd6QTI4bmlpeGl6OXY2V2ZKSkE4?=
 =?utf-8?B?amZsd0lLZTI3enJvUXVEd24wU1pMd1QzR1Z5encxNE5xdGdsY0VkOURlQjVG?=
 =?utf-8?B?RjEwUEQ3a2xiOFZxd0Z2NVQ1TWJ6T0R4b3Mwa1E0UmVtaThuT09VNnNlOXhj?=
 =?utf-8?B?NmlwbWRTcFJsd1U5bmNVTnptUEZDS3VFb3VIM0VLdkwyeU5GYmkxNW1nb0Fy?=
 =?utf-8?B?L0lMMUxmbzkxSlNqWlhTNE1VQVBjc0d3VTBVdjRFWGNKdUlJZDlBSjJXMm9L?=
 =?utf-8?B?bzl0S3ZvL3NIM21jY0t2cUhjMUFTYU1jTnluUjNod1FFSWxnNmJRL1FvTlhQ?=
 =?utf-8?B?K2NNcjRWaXV3bzJCZWVrR3RHMTNrTFpGWUpLcGl6ZGhMbEROVjFuR2VyNzQz?=
 =?utf-8?B?Qi81WGJ1c0JUTUhKNjAwTGdCVk1TOExLcjFXTGdwQmU4U0YwZGlJVHh3WHdt?=
 =?utf-8?B?b1d1cXk2aTZLblhUd29YeUVLaFVPRnlRcFc2bWpGZXppUFY1NHIvRnh1MjVU?=
 =?utf-8?B?MUFOQndRcWFKZm5Jc3h3cXlnU214T1podTUzKzAxNGlaOGZHN09ZZWMyTk5l?=
 =?utf-8?B?b256eGQyU0pxTmRsckZPU3EvUjBERlBDOXIzTWdCZTFpamhwUCtRUkRsdi93?=
 =?utf-8?B?bDlueVh2eFpTUWR0Q05LUGJvdjJmS3FwclZBa1hxcVpxR2o2cnV2REpCSkFn?=
 =?utf-8?B?azVmdytVYnNzUXpHM0F4UjJ2UEl2TXBpQmt6RjBSbjJ6d2FaZ3BydWtFbGpC?=
 =?utf-8?B?MHpzTUFBWG5lYmhaZ0gyVk82eHZic3hmZmRBZUdqY2dnNm1HWm1LLzN3d0h5?=
 =?utf-8?B?WnZWV1B4YnZmcG9POHZPUDZEcU4rVGF6anRXNXRhUVNQRVdJNkdra1o0TTRx?=
 =?utf-8?B?VnVSQklkTS9oWCtrdktua1R1bzROeHFtTjhjT1hkYmpIS3dEN2tGV05FY3Bx?=
 =?utf-8?B?MlcvM3dhcUVkdnA3WHFqQ2RsUWpyeGZLdDVtYWMzdzVNWVpaY0phT0ZiWEY3?=
 =?utf-8?B?ZXVqT3dwUEFGSjlxckh0ZFZ1RUVzYkZ1ZUoyMng5R0lYV21KYWRzdVkvakJs?=
 =?utf-8?B?cy9JZUplTkdxS01hQ2QwelZ0OFVwR0JtbFd5a1djbkRjMUFtZDBVYzZlK09S?=
 =?utf-8?B?dVA1TnA5OVkra0VBOUs2RUU5WUYySHVZOUFpclZyWG52d2lxQ0hobTNDQ0lX?=
 =?utf-8?B?SmFJWStwRFM0RURwelhVSHgzSDcyZ1JReDd0K05GRkNnQitaaERrMXNwdU5R?=
 =?utf-8?B?U1ErZkpjTkdoTUYxalRobGtVSWt6OERiNTIrVDhDUmVVTzEwTGVOelZlbVdK?=
 =?utf-8?B?S051QVhENW50elNhbDNpd0hrZGpod2thcGpUYUg3NzFtbmZDUmJFbVFjNHFH?=
 =?utf-8?B?MXdadzVvTXhJQ0JxTHdFZ2JSd2xzMkNSRlpTRnhic0FzOHJMR0FOenFkQWls?=
 =?utf-8?B?djUwall0MEdiaHZZWDQ2c3BlcFl1Rm0rVE1aUWh5ZHRUOUR0cG5IU0xJbWVE?=
 =?utf-8?B?UnAwNnoxOVdlT0EzZ211b1Zrd21rNXRVaXpzdkEyY3hOcDdIL3UwUzZXRFpx?=
 =?utf-8?B?ekl4NkRDc0JEYVQrN2xPVGNPd0N1NVFSMjlseWRXUm9sVTdDaWoxRU5ZZWt1?=
 =?utf-8?Q?G3RSj9e9kXBsHtW4NucZeue/Y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82E9592FFC0A9B4F90A75B49DA769184@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1905cca-5dd4-4eca-ecb5-08dc5587a5b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 15:47:06.8025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TNcHqtOi38rqgg3VwB2GLaiojPBasapvmZ9bPL8fVc7Dg2HlSdhnNk+AK7T8JZQ52vjOZjg/e+MxX+Z5dJLFzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4775
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTAzLTI1IGF0IDExOjM2IC0wNzAwLCBKb3PDqSBSb2JlcnRvIGRlIFNvdXph
IHdyb3RlOg0KPiBPbiBNb24sIDIwMjQtMDMtMjUgYXQgMTc6NDggKzAxMDAsIEpvaGFubmVzIEJl
cmcgd3JvdGU6DQo+ID4gT24gTW9uLCAyMDI0LTAzLTA0IGF0IDA2OjM5IC0wODAwLCBKb3PDqSBS
b2JlcnRvIGRlIFNvdXphIHdyb3RlOg0KPiA+ID4gSXQgaXMgdXNlZnVsIGZvciBtb2R1bGVzIHRo
YXQgZG8gbm90IHdhbnQgdG8ga2VlcCBjb3JlZHVtcCBhdmFpbGFibGUNCj4gPiA+IGFmdGVyIGl0
cyB1bmxvYWQuDQo+ID4gDQo+ID4gV2h5IG5vdCB0aG91Z2g/IE1heWJlIGlmIHRoaXMgaXMgYSBj
b21tb24gY2FzZSB3ZSBzaG91bGQgaGF2ZSBkZXZtXy4uLg0KPiA+IGNvcmVkdW1wIGZ1bmN0aW9u
cz8gRHVubm8uDQo+ID4gDQo+ID4gQW55d2F5LCBJJ20gZmluZSB3aXRoIHRoaXMsIGV2ZW4gdGhv
dWdoIEknZCBsaWtlIHRvIHNlZSBhIGJpdCBtb3JlDQo+ID4gZGlzY3Vzc2lvbiB0aGFuICJkbyBu
b3Qgd2FudCIuIENvZGUgbG9va3MgZ29vZC4NCj4gPiANCj4gPiBSZXZpZXdlZC1ieTogSm9oYW5u
ZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4NCj4gDQo+IFRoYW5rIHlvdSwgY2Fu
IHlvdSBwbGVhc2UgYWRkIHRoaXMgcGF0Y2ggdG8geW91ciBuZXh0IHB1bGwgcmVxdWVzdD8gT3Ig
c2hvdWxkIHVzIGFkZCBpdCB0byB0aGUgbmV4dCBkcm0vaW50ZWwtZHJtIHB1bGwgcmVxdWVzdD8N
Cg0KcGluZw0KDQo+IA0KPiBBZ2FpbiB0aGFuayB5b3UsIGp1c3QgdGhpcyBwYXRjaCB3aWxsIGFs
cmVhZHkgdW5ibG9jayBzb21lIHdvcmsgZm9yIHVzLg0KPiANCj4gPiANCj4gPiBqb2hhbm5lcw0K
PiANCg0K

