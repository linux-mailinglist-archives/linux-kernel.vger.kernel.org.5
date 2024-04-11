Return-Path: <linux-kernel+bounces-140573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D29E48A1655
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018FB1C216AF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1BC14D6F5;
	Thu, 11 Apr 2024 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Maiz5kGt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C28D1EB26
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712843625; cv=fail; b=DJbyB4poh7hiWIbcN2hCA4os6wHYrD1I4F8Q04hso4Em6x3C5QNMr859hRmRWpCCH4i6rCXFmm/oP0AuhTtO/tUnEvmLiTegY1+SDXQrl5hs87uvGWdf7zJzTG1ejzoYXVDUpJbn7ZxhLnA3OtrBqDb6MZQ4ylhvJxnaHCnb+PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712843625; c=relaxed/simple;
	bh=tnDb4J8yiCJBshpq9ge5MRw1Z68Y5BrZNPe+lpkMYYc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kbtnh5gK4I4bcjkuRe4jPVsMfqW1+EYzKtuA8VFPZQU8bQkzaTj+IvteeVNkfSMOKpH4E2AjNmhTI8dAZvOkYGEKCLOz6b8K9tzOyWtdqcAkojU/U3aPf5rysDSOvzyOFhFYvo3kSJzc4zyqNRErfAHefMQMBJCrg5lVpOMk2+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Maiz5kGt; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712843623; x=1744379623;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tnDb4J8yiCJBshpq9ge5MRw1Z68Y5BrZNPe+lpkMYYc=;
  b=Maiz5kGtXzURUzrTBUr4/ZHAEkkUc3oBfLfJtETlf9Izn3F6XVtW8tgO
   xAa/obl4x9HzHSOBeDWFaWFyROxExup+TF/ZsO3ES3KlcGO7cCaMWWGLa
   NEYI7h4vXKMO3EUbXHV5k3P9zM68PVmYeUb588KkiZR9kR8/EsNYjQKsq
   6VyykQ4vEQINCNty4F+UaYMStaC84SO/unz5TZaBzO128zhteSNdbOAzv
   KUORHu2uEQGBWUXs5mS5sCMsrOdjDImNDJQapDs8M6idqLTm3uvIy6e9N
   7OLq23nNVBj8J3rgsNburcyXynaSjDVT/zbcwjLX+vMpsJMgtbLfOh6RW
   g==;
X-CSE-ConnectionGUID: 50PWCc39Rv2Mjai5x+phBg==
X-CSE-MsgGUID: MnY+QvsMQA2DxOFZKaL83g==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="19644955"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="19644955"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 06:53:42 -0700
X-CSE-ConnectionGUID: 2kEq5IUyQ4O22/BfkbN8gQ==
X-CSE-MsgGUID: HajUQdacSeuCG68uggzLJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="21347975"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 06:53:43 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 06:53:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 06:53:41 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 06:53:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dve0ITOKIalbdNOCbzpmKIdZFrYuBzdSZ7XSZ149v+CuVGDQTvxG/5pI+/KkdOFJqmc8/fIVp1QD4G9ZpFD187BQXee0eux5T0UwJf0/f+UIVYEFXJGwYvUxtC5+R8ZSTQYHdtwIWnOsD53FWsy4AcUa6P3hmeWUBJmm/nZyiwo/KXsbf7afocjr5VT7YCy4lDzyTR0nk17YaUWpZYqlESVWO2rAyIK03gLgnffonbpKrG5XagLvp4eSZi9mzUNAZx9f2tB+a+lroUm+zpxN+h2Lyl/LiLry+AVePEVINk2zFOMig2w5WAF1dSNjCKcKeX/6tOIiq9V4cR6dVNaVIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnDb4J8yiCJBshpq9ge5MRw1Z68Y5BrZNPe+lpkMYYc=;
 b=G57TcEpM+bHHce0fFZ61/c1FU+jMksMLL75fXgx0tkjHPozHpQaBOr7Eorx65Ppo9XNvn+dp5JR7ktnROJfxm1b5pcjf6stfHli5dWbwXw6S0/+4irmcKK/9CtF10omtj9JR2lp5vTjJ49R5n1l/FUVhEvz2ztpXtXFiUjFQI/CdhgfMEZ5mXvK9loK1T8R1cGAfqklq1xqRqdxwZoUrcbZsN8DKwh68dtfgMA/3gM9LJI2Dt0G9Z0yCdwEEQCi4/mLslMintaIfTHu25g/LvOedeJdUZl6AbWobQCd95OH1CZbJ5kWjcBGCndYZDkblHsjU6x77ghhO6C+W4SpNfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB7987.namprd11.prod.outlook.com (2603:10b6:510:242::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 11 Apr
 2024 13:53:38 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 13:53:38 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "luto@kernel.org" <luto@kernel.org>, "ashish.kalra@amd.com"
	<ashish.kalra@amd.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"bhe@redhat.com" <bhe@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>, "Gao, Chao"
	<chao.gao@intel.com>, "bp@alien8.de" <bp@alien8.de>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 1/5] x86/kexec: do unconditional WBINVD for bare-metal
 in stop_this_cpu()
Thread-Topic: [PATCH v3 1/5] x86/kexec: do unconditional WBINVD for bare-metal
 in stop_this_cpu()
Thread-Index: AQHaiOmAK7Yb0g6URUSkHFV2mn5xE7FhkIKAgACA6oCAAQX3gIAABhWA
Date: Thu, 11 Apr 2024 13:53:38 +0000
Message-ID: <cdcae76739811b452d66e17554c9b324433a2f1e.camel@intel.com>
References: <cover.1712493366.git.kai.huang@intel.com>
	 <33b985a8f4346f4bcf0944eaf37193a906b11af3.1712493366.git.kai.huang@intel.com>
	 <a4o4wlaojm5am4hc5yhr2mpn7clm3sjy5vx3w76ahm52lhxvwr@msdcnkcj3i6k>
	 <4875349a-90e5-4a04-8a56-7d172b17e245@intel.com>
	 <bvtzoqizxzz5ltepttwxu7nlny3najrci6reuybdfwcxpcpqtd@ixovf5h32j62>
In-Reply-To: <bvtzoqizxzz5ltepttwxu7nlny3najrci6reuybdfwcxpcpqtd@ixovf5h32j62>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB7987:EE_
x-ms-office365-filtering-correlation-id: 239ce682-ebf4-4718-03f3-08dc5a2eca25
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UYLs7vfNSfKDXRRxtpQAzvhCuI+3jM/icBfzWec9vErG3CwBjaqdlCRu4zUtFQFrJyGJ1yaB9UG1jaN0Jgff7NxqruK/HvmsSey4PQRH5msHGoKsBU5OKmaj48IvkgqcL8NqphSt74QvL/2xEmDNbtehiFU9yea+VqaOhX+JJIYZizMI0vTI7zUCxmeakRy/eEHU1/uRts5QYAXKqNE31OiZarovg0DVgbq7nb+fufjgzo4erVNNrpm/Rk5vRbIpE5PYL8WX4NikeJRV6Jyum4CSmMrld7fqiVvuq5x0PSDh279UaldNmWB8pCkvM5jRJTKOuNNjArLj68NYo+EF3QLntwV+PmUTJkIArguoqPIjVsmlmmZrmlVbCCFhyY0ZvEWiwpnRMvy3y9OG+HXt48uJIyhU3O1PPr3Hf/8GysRCkDFjvyyTXyDj6rUVVA9GdLbXM7TTc3cCi/3e/chGBkKq1KF7sWexni5r9Q0QD6dW7pf3TcuXc5UkW/21fCR3ZrX5mQ/NBK4JiSlNAgQbdmqlnQOIMW6FDm6/9+16eHOk2SvdSPh7un4FXHIWgzlG1BVX2jVJnXBVjVdJSrAbC1A9G/aD0srh+BxGZIQAH0PLFSSJEyKhgQ1Ew3gzISDyYFgQuQOM7SeiJS84Rgjg4Xn2ErHv1OzYZOn0w4jjZx6zqrqXQOFycU4GEu5Q/vTJNHxfknXIYW9KsQcgsM5JzABGEoaBJC2x3H0yYInHgSo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUVNYW1zZVRvT1lxOHZSRFpyUlkzekV1K2IzSjI5VGc1VDFvLzU4K3ZZd3dH?=
 =?utf-8?B?ZXJWU3NhQkVVb29KTUpYZGJEUWRVZzJCSDlPOTllK1cwKzRhOEllSkJFU1hY?=
 =?utf-8?B?Q0VGbXpmY2g1SGRCVmQ4R1cxekJtVEVyNDBMam1TUWN6d1dGTFc0QkxzRVIr?=
 =?utf-8?B?Z0J2cVFnZVpJTnBSbFZEcnM5aWpPYkNnSGZQOXN2VGhLYUxkaU9VbXdzUE1p?=
 =?utf-8?B?UUVNVzFiRFdyYjhqZWhDNklkeVNTN2xGc2NDQytVUjIxUlYvN1FSWlVOMkc2?=
 =?utf-8?B?R1ZrNWd1SmZQc0l3YWhqQ29UZ1JXSW9ockF0SW9NdTNWcDVkN1lyQ0ZTU1JK?=
 =?utf-8?B?OGFDcXgwMFZVRTdMVzI5a0t0R01IN2tJcFdVNVhTSFJselNqK1dwY0tYMW4r?=
 =?utf-8?B?RUtMdlByc2lZZkRxSFh0UFZCVC9lSlJXd3FQTHh1WERhTytCU1lERFdQaTNI?=
 =?utf-8?B?NWhWbFNveHhReGNWN0hEOUlraFU2UE5nVTdTZTZvTnZsUldlRWNEbnQ1a1ZM?=
 =?utf-8?B?SmJxcXBnLzF1OVRTWC9DenFVbVFqc01rWXhHdVVEQzNYdmNuamF3RlZ0MHZH?=
 =?utf-8?B?dHA3emRsajJ3aHFyMDhPNUpuYkphOUFnNHhVVWJLREZIcHQzd0F6Y1JiY1A5?=
 =?utf-8?B?b1BuOU92TXJrVmdlS0E5cFRrNEhsZ3RrdWtjdTBZVDJXZ05USklBWFpxNG1B?=
 =?utf-8?B?ZStBUFZLNU9ZWCtCVlZNQ3o1L3BJdmR1eWE2WHJqanZVbVFpZU11blBUUzgv?=
 =?utf-8?B?OEFEcUdzcGNEZFhIWjk3ZUE4eFZvdU4zK29tQ3hpZTFkby8zWGFMSk9weU0w?=
 =?utf-8?B?bUlwSnpLdFJKM1k2cFNEREczUHIvb0VLZjZjQlFkYTdBc0hUNDJQZjNnTUJo?=
 =?utf-8?B?ZTlzTGM2Vktxak9VWjgwakFlbGhKdlhHOVVKQ3FXOFFWRXg0ODhYcGVxc2xN?=
 =?utf-8?B?bkVwVEgyb1NZbEhuUHhDV2tWVTBwdDRZSHJCYzlrVm5lTVcxVVI2eGJYTXp2?=
 =?utf-8?B?c0ZTR0ZxTEE0c0xJTFRpcWp4ZlJROXc3RFZMRElwZDBpNWxmekRvUVMzZEVB?=
 =?utf-8?B?TDVvUkdpQjh6cTVhMWNGa2RLV1VtYlBzTzBzRDhVL1drczc1OGkyT3FpSjBL?=
 =?utf-8?B?S3Ywc0dHTWxiQUZxVGdieE50eHMrNlNhazVta21VMjRtNmRwUXc4NFVBem5F?=
 =?utf-8?B?MUJFUDIvd01xZ0dZZ0VXWnJ1YlFhOFlTOHpDMnlwMmorWE5TQkQxL09lNEVu?=
 =?utf-8?B?TUdvVWVRL3JhUlYvUkpLZml6QXZvZWx3cXFtSHc4UTdQOEpaY09WeTdUTDVy?=
 =?utf-8?B?UWltVmNUTE9xaitEZXZvd2FTYlQ1UWJkZWJqVmlXaWJTaTJuelJ4ZmxTeDNr?=
 =?utf-8?B?SVlrTExOSjB3ZWNuS2JpVEF3Ty9TL0NIZmVtUWNHYmU3SmpQblpJTzcvWGY0?=
 =?utf-8?B?bW01TXpwWjVKU1E5OU1nc1c1RlU3UVVOMlpaU01QQzlUTnhna2hURUFvWW9p?=
 =?utf-8?B?ZU1MYVoyaHJFWFFGbGNIcEV2a0NMR0tnOFhwRWdwbldna3FRNkc1WS9lR0ln?=
 =?utf-8?B?VjZoQUtQcmU4VGZxblZ3NG0xQWMrNGQzUnY3U2hBREd6b2liUGNMWlErdFZN?=
 =?utf-8?B?bmZtZ2V0Mi9lZlFGTmMycy9yRnJEakYzcGtuVTdGVWFaUVh3cW1EQjd4ZHQx?=
 =?utf-8?B?SE5qTk1QdGhOUE8zTGFJVmRLeUpxcTZOdnNpU2VqbkVvOUlDa01uM3d3bXda?=
 =?utf-8?B?dTJrek9HTGFmNUwvd1dhV25rajZuaFNKcng0SmZRY0VGSVQ5c2drUVN1d3JW?=
 =?utf-8?B?K2lxWFhUZDJPbmdWUzhhSW9UelhVRzg2MVBlNEgzdEFiUXlPT2FYNTArc3pl?=
 =?utf-8?B?d2tyRm84b3Z2eFUrdmZqa2xrUWNhK2RPUHk2c0RySVFvRDZVSEl0VHovbzBr?=
 =?utf-8?B?ZkdSUHd1SWt1WXNhQTNIVTRLWG81Nkp6aTBQSUpzY1ozMjRVY1BkTi9QQi9C?=
 =?utf-8?B?ZGN5NHRkZ0NUaVVrUFBCQ2pNaG1nRWs3QldMMFdYK0RFSE9rRlp2bmVjeEd6?=
 =?utf-8?B?Q0pwaDMvWk5hMDZ1RHFHNmZSMGpyYTAvVTRRR2tTVzJkVW40SndQd1FqemRC?=
 =?utf-8?B?cFpOc01EWmRjUHV5Rnc0TG5iSmRPMGJISFF3QXc3Y3dkUi85ZWlNVUhidC85?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAE5775CD47F4A4C9538F6E2EA5A7AF3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 239ce682-ebf4-4718-03f3-08dc5a2eca25
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 13:53:38.5566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kSaUz0J+tFkVJENoCFEAYXBnSpD44auOmZwqRSYOarLEVFOY88VGnkCE3x47dhZkJyaI2N0IKdXbX3IxASw0FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7987
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA0LTExIGF0IDE2OjMxICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IE9uIFRodSwgQXByIDExLCAyMDI0IGF0IDA5OjU0OjEzQU0gKzEyMDAsIEh1YW5nLCBL
YWkgd3JvdGU6DQo+ID4gDQo+ID4gDQo+ID4gT24gMTEvMDQvMjAyNCAyOjEyIGFtLCBLaXJpbGwg
QS4gU2h1dGVtb3Ygd3JvdGU6DQo+ID4gPiBPbiBNb24sIEFwciAwOCwgMjAyNCBhdCAxMjo0NDo1
NEFNICsxMjAwLCBLYWkgSHVhbmcgd3JvdGU6DQo+ID4gPiA+IFRMO0RSOg0KPiA+ID4gDQo+ID4g
PiBUaGUgY29tbWl0IG1lc3NhZ2UgaXMgd2FhYXkgdG9vIHZlcmJvc2UgZm9yIG5vIGdvb2QgcmVh
c29uLiBZb3UgZG9uJ3QNCj4gPiA+IHJlYWxseSBuZWVkIHRvIHJlcGVhdCBhbGwgdGhlIGhpc3Rv
cnkgYXJvdW5kIHRoaXMgY29kZS4NCj4gPiANCj4gPiBDb3VsZCB5b3UgYmUgbW9yZSBzcGVjaWZp
Yz8NCj4gPiANCj4gPiBJIHdhcyBmb2xsb3dpbmcgQm9yaXMncyBzdWdnZXN0aW9uIHRvIHN1bW1l
cml6ZSBhbGwgdGhlIGRpc2N1c3Npb24gYXJvdW5kDQo+ID4gdGhlICJ1bmNvbmRpdGlvbmFsIFdC
SU5WRCIgaXNzdWUuDQo+ID4gDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgta2Vy
bmVsLzIwMjQwMjI4MTEwMjA3LkdDWmQ4U3I4bVhIQTJLVGlMekBmYXRfY3JhdGUubG9jYWwvDQo+
ID4gDQo+ID4gSSBjYW4gdHJ5IHRvIGltcHJvdmUgaWYgSSBjYW4ga25vdyBzcGVjaWZpY2FsbHkg
d2hhdCBzaG91bGQgYmUgdHJpbW1lZCBkb3duLg0KPiANCj4gV2hhdCBhYm91dCBzb21ldGhpbmcg
bGlrZSB0aGlzOg0KPiANCj4gICB4ODYvbW06IERvIHVuY29uZGl0aW9uYWwgV0JJTlZEIGluIHN0
b3BfdGhpc19jcHUoKSBmb3IgYmFyZSBtZXRhbA0KPiANCj4gICBCb3RoIEFNRCBTTUUgYW5kIElu
dGVsIFREWCBjYW4gbGVhdmUgY2FjaGVzIGluIGFuIGluY29oZXJlbnQgc3RhdGUgZHVlIHRvDQo+
ICAgbWVtb3J5IGVuY3J5cHRpb24sIHdoaWNoIGNhbiBsZWFkIHRvIHNpbGVudCBtZW1vcnkgY29y
cnVwdGlvbiBkdXJpbmcga2V4ZWMuIFRvDQo+ICAgYWRkcmVzcyB0aGlzIGlzc3VlLCBpdCBpcyBu
ZWNlc3NhcnkgdG8gZmx1c2ggdGhlIGNhY2hlcyBiZWZvcmUganVtcGluZyB0byB0aGUNCj4gICBz
ZWNvbmQga2VybmVsLg0KPiANCj4gICBQcmV2aW91c2x5LCB0aGUga2VybmVsIG9ubHkgcGVyZm9y
bWVkIFdCSU5WRCBpbiBzdG9wX3RoaXNfY3B1KCkgd2hlbiBTTUUNCj4gICBzdXBwb3J0IHdhcyBk
ZXRlY3RlZC4gVG8gc3VwcG9ydCBURFggYXMgd2VsbCwgaW5zdGVhZCBvZiBhZGRpbmcgdmVuZG9y
LXNwZWNpZmljDQo+ICAgY2hlY2tzLCBpdCBpcyBwcm9wb3NlZCB0byB1bmNvbmRpdGlvbmFsbHkg
cGVyZm9ybSBXQklOVkQuIEtleGVjKCkgaXMgYSBzbG93DQo+ICAgcGF0aCwgYW5kIHRoZSBhZGRp
dGlvbmFsIFdCSU5WRCBpcyBhY2NlcHRhYmxlIGZvciB0aGUgc2FrZSBvZiBzaW1wbGljaXR5IGFu
ZA0KPiAgIG1haW50YWluYWJpbGl0eS4NCj4gDQo+ICAgSXQgaXMgaW1wb3J0YW50IHRvIG5vdGUg
dGhhdCBXQklOVkQgc2hvdWxkIG9ubHkgYmUgZG9uZSBmb3IgYmFyZS1tZXRhbA0KPiAgIHNjZW5h
cmlvcywgYXMgVERYIGd1ZXN0cyBhbmQgU0VWLUVTL1NFVi1TTlAgZ3Vlc3RzIG1heSBub3QgaGFu
ZGxlIHVuZXhwZWN0ZWQNCj4gICBleGNlcHRpb25zICgjVkUgb3IgI1ZDKSBjYXVzZWQgYnkgV0JJ
TlZELg0KPiANCj4gICBIaXN0b3JpY2FsbHksIHRoZXJlIHdlcmUgaXNzdWVzIHdpdGggdW5jb25k
aXRpb25hbCBXQklOVkQsIGxlYWRpbmcgdG8gc3lzdGVtDQo+ICAgaGFuZ3Mgb3IgcmVzZXRzIG9u
IGRpZmZlcmVudCBJbnRlbCBzeXN0ZW1zLiBUaGVzZSBpc3N1ZXMgd2VyZSBhZGRyZXNzZWQgYnkg
YQ0KPiAgIHNlcmllcyBvZiBjb21taXRzLCBjdWxtaW5hdGluZyBpbiB0aGUgZml4IHByb3ZpZGVk
IGJ5IGNvbW1pdCAxZjVlN2ViNzg2OGUNCj4gICAoIng4Ni9zbXA6IE1ha2Ugc3RvcF9vdGhlcl9j
cHVzKCkgbW9yZSByb2J1c3QiKS4NCj4gDQo+ICAgRnVydGhlciB0ZXN0aW5nIG9uIHByb2JsZW1h
dGljIG1hY2hpbmVzIGNvbmZpcm1lZCB0aGF0IHRoZSBpc3N1ZXMgY291bGQgbm90IGJlDQo+ICAg
cmVwcm9kdWNlZCBhZnRlciBhcHBseWluZyB0aGUgZml4LiBUaGVyZWZvcmUsIGl0IGlzIG5vdyBz
YWZlIHRvIHVuY29uZGl0aW9uYWxseQ0KPiAgIHBlcmZvcm0gV0JJTlZEIGluIHN0b3BfdGhpc19j
cHUoKS4NCj4gDQo+IFlvdSBjYW4gYWxzbyBhZGQgbGlua3MgdG8gcmVsZXZhbnQgdGhyZWFkcyBh
cyBMaW5rOiB0YWdzLg0KPiANCg0KSG1tLi4gVGhlIGxhc3QgdHdvIHBhcmFncmFwaHMgZG9lc24n
dCB0ZWxsIHRoZSBiYWNrZ3JvdW5kIHRoYXQgdGhlDQoidW5jb25kaXRpb25hbCBXQklOVkQiIHdh
cyB0aGUgb3JpZ2luYWwgd2F5IHRvIGRvIGV0Yy4gIFRoZSBjaGFuZ2Vsb2cgb2YgY29tbWl0DQox
ZjVlN2ViNzg2OGUgKCJ4ODYvc21wOiBNYWtlIHN0b3Bfb3RoZXJfY3B1cygpIG1vcmUgcm9idXN0
IiAoYW5kIHRoZSBjb21taXQgSURzDQp0aGF0IGl0IG1lbnRpb25zKSBkb2Vzbid0IHRlbGwgdGhl
IGZ1bGwgc3RvcnkgZWl0aGVyLg0KDQpUaGF0IG1lYW5zIHBlb3BsZSB3aWxsIG5lZWQgdG8gb3Bl
biBhbGwgdGhlIExpbmtzIHRvIGdldCB0aGUgZnVsbCBpbmZvcm1hdGlvbi4gDQpJIHRoaW5rIGl0
IGlzIGFnYWluc3Qgd2hhdCBCb3JpcyBzdWdnZXN0ZWQuDQoNClllYWggSSBhZ3JlZSBoYXZpbmcg
YSBsZW5ndGh5IGNoYW5nZWxvZyBpcyBhbm5veWluZyBzb21ldGltZXMsIGJ1dCBmb3IgdGhpcw0K
cGFydGljdWxhciBjYXNlIHdlIGhhdmUgYSAiVEw7RFIiIHNvIGRvZXNuJ3Qgc2VlbSB0aGF0IGJh
ZCB0byBtZS4gOi0pDQoNClNvIGZvciBub3cgSSB3b3VsZCBsaWtlIHRvIGtlZXAgdGhlIHRleHQg
YWZ0ZXIgdGhlICJOb3RlOiIgaW4gbXkgb3JpZ2luYWwNCmNoYW5nZWxvZywgYnV0IEkgd2lsbCB1
c2UgeW91ciBmaXJzdCAzIHBhcmFncmFwaHMgYWJvdmUgdG8gcmVwbGFjZSBtaW5lLg0K

