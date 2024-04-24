Return-Path: <linux-kernel+bounces-157441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9688B11B5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DABBB287E1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F29016D9BD;
	Wed, 24 Apr 2024 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UOxoLPqo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B6E15F406;
	Wed, 24 Apr 2024 18:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982115; cv=fail; b=E/RCI6pQzWfHeDmoHjT6UjajD/WJgXeswwdf5Uka7U/wQsJGpPXNh8FYF9sfdUIRRyHeuj1WNku2eVN8QyqU3qgPMEmEe18JGMRj2z+8z5od/vEOl5bKXuVqi/iTT8hVsAZB+Y1vVof74nDAJPC+8yxvNOjCkAfLi68iacabhCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982115; c=relaxed/simple;
	bh=bSF8DZiDp7wbPEjo3SW2+ANJFU1P8Un9gRTjL+HasvU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oGApuzBLZEs9G6MN0I7Z9lPSer1YNzHVcQY4/Bv1knyc+tINX7pnGtKtGf+xOQIFB+S0pFCzRYJd8OKFrrC7YEM8fxBU+Lkt3Whi0DTvxSyUuhASKZ1V4ox/x7w1SdO6Xn4gO2ggtUo9wO6JyDGLE2SjgIKmpsovTWb6/uEAxPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UOxoLPqo; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982113; x=1745518113;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bSF8DZiDp7wbPEjo3SW2+ANJFU1P8Un9gRTjL+HasvU=;
  b=UOxoLPqo8+Vv9YDZBdD9tpOdkQqmLcMe7ZwojtxhWMBF96i+AFAxkRbZ
   PJntR411qZOWVhqlAeuErGDmmL5+ABP61hVNC3zzoDy2mDY6DDq94fGa8
   PN+hXgXgqIKqNpKeMnX86F0myFpQ8+AGRRDCHcE4EPuYsOjVayfiSH7JT
   uGF9FwDpgFZPnwiNOV1lee0a2u0osmsvZuAviOpKgDjBOpA0GDlXrmCSk
   zgW1D7Lgm7khnPsS0uxZ3U0SX/S1nvEoxG9/jZ3Pxk9j0Ra8UzAJlPzmQ
   XL8QhpHM8UEgCHEZyvqB5yNoYVlVPhZa4Wj5jH/7Ca0OYL9TpLSGWSAFN
   g==;
X-CSE-ConnectionGUID: vbRhYpeXRDOFGeukZr237w==
X-CSE-MsgGUID: UyXG6BokTlCxrW3HMNKBHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9499335"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9499335"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:08:31 -0700
X-CSE-ConnectionGUID: v7TXuhw4Rdq7tAYW1kZHMA==
X-CSE-MsgGUID: GWqqNi+MTfmrzidoiPKzwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29596202"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 11:08:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 11:08:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 11:08:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 11:08:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZ32fGu7QWe1yY3kSF7I36CnFjxhoa+hgaEL7AsHrQavLX2epTsbzeHMWrHG2fSTpJqPfRQ0fmbylSA2FVNdhOkkqKa0mhnzM20qlZi03UaZnTsfNk8Dnsqbcn7OYadmMENaprz84U45A0iQFeyZPp6qN7kMcjVSZgGK2rXJJvlk6rC5kIia1pcYyu17k9+aKhJrJjLCIHkNBVMeJBWbGiEjKesset3ZVVmVZpGB3bnaMfv3ZjvzUo0RbzogFqLVeG8UGBvhYpJb4mpxlRDk29eygjDGE1jL11CAAt74HFRXNw+WfqMFV2gFBW5ihsvnFnQCc96l+aQB546kz4xqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7KnH/W0Hyt+rsQK9h9/dwZjx+NQRq8Sv7XdKNBACHE=;
 b=bjiV2N5n7q8kHTyuMk4sS7v8lg8vOcnLc0RbB8lw6gQRojxC0X4EnjDlzdEoS/xGj6PPI2ATisDJWCl1K6V9ZNRcreQfP7cErX08ElcbZ8Ma2SZn0gXBC0mo5KXk/VQB06cDq0dqmHzdTfhUeK+aRB7VcCoDegcvo+FXi0qiFV1Nn1+tzlUu2tgK+Utb+uXWbXFa+9U7rqOoPtPDzr4Sj7zhDymyNVl46BJryPA2ufrWTafSLrJFTuSn1MAIu2ST0+sEfEeITczAKPVNdqoVuHLufvCRuwa2Ebapbsf3+pacc+8Uc1ItRyQANlXLN1DJEioTEDDR0XcNOTzFBUHDAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7428.namprd11.prod.outlook.com (2603:10b6:a03:4cf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Wed, 24 Apr
 2024 18:08:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Wed, 24 Apr 2024
 18:08:29 +0000
Date: Wed, 24 Apr 2024 11:08:26 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dongsheng Yang <dongsheng.yang@easystack.cn>, Dan Williams
	<dan.j.williams@intel.com>, <axboe@kernel.dk>, John Groves <John@groves.net>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Dongsheng Yang <dongsheng.yang.linux@gmail.com>
Subject: Re: [PATCH RFC 0/7] block: Introduce CBD (CXL Block Device)
Message-ID: <66294a9a8e9a8_b6e02947d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
 <66288ac38b770_a96f294c6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ef34808b-d25d-c953-3407-aa833ad58e61@easystack.cn>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef34808b-d25d-c953-3407-aa833ad58e61@easystack.cn>
X-ClientProxiedBy: MW4PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:303:8d::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 04d2bb8c-7e24-4b02-070e-08dc64898b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEVpZGRoR0R5cVZpQjlic05SMnRjeWovQXpWY2p4YXR0VDdMWHN2QkxxSGt4?=
 =?utf-8?B?ZTVMTnFkZW1kcGtlUG1BYVVMVG5qNVpNeFcrZjFlVXlqa05YUVZKeXdqVVlD?=
 =?utf-8?B?WE5iaDhyd0JkNWFZa1A2djd1aklxSTBrTzRhRGNNL3RGSXVDLzRnSFp1WE5o?=
 =?utf-8?B?TisrN3piN09kQnZMUkJoWmV6dTI5eVNmRHFLVG1YcjhDdVhkc1RodS9WblVr?=
 =?utf-8?B?WkoxWUpCamo3cWNDOTV6dytyVEcwaWpvenhIUGhtWFpHZ3Y3UjFqR0tldWhh?=
 =?utf-8?B?cnhDRVMxak5pb1AyZVN5WEtoYmloYzhNS25ZSGRTTUpuNHdwZnZoRTN1SlRi?=
 =?utf-8?B?dGp6Q0hYRnhxVUx2bjhVTGZoMFZnbjU5OU1mUWY4TTk2Z2ZYQ0w4bDBtdUcy?=
 =?utf-8?B?QnFSem5JZ2FISml4ZnpTTlMwTXFGYTMvZjdNbWViOVNHTzcxVnE4c25ibWZp?=
 =?utf-8?B?Yk5PZDZZTEt5enBuMjI0RTUyNlhZdFFsa2M5clRxTTZaTzcwS2xMOS8zekNo?=
 =?utf-8?B?Y1RLdzRGUXhEc2o4Z2lmNSswenN6Y0xvZFY3UUVvYkl5Qks5aVYrNU4rdVg5?=
 =?utf-8?B?aXYvaEZQQnYwL1h4L3hYOXJ6K1cxVWsyMnJ3ZVFrYWZzNEt1blNYb215dFli?=
 =?utf-8?B?eG9QYW54RDZ1eW5Ud1RFd1JGdzlKWWFzdFFVZXE2TGpiSDdsSWJkMGJoSElK?=
 =?utf-8?B?am9RYTFRc0NYdmRHRThpaEp5cFJmZmtLOVhJaFZUcWpJQ2liNk80Y3dEeVNR?=
 =?utf-8?B?K1BsbG1mbHIrd24rSktKZXFpTFlqc2g3bkFmMlQ1MjBuTThrL2NZc0JKY3lH?=
 =?utf-8?B?bnZGTWdISkJLMTNKcUhiY2RMUTl2NkY2N2JWS1ptK0xibi96cm9nQ3V3OVhw?=
 =?utf-8?B?R3FFbXUvSDZLbjJDbWgremlJcVc2UFBPYWVZSFlyS3VSZm9MTlJOSlc2SnlT?=
 =?utf-8?B?ZG5KOHlndGlZRGdxeWZ0MGJ1UnpEajFRZnRCU3AyQVZVeitKN0MxSnUyZGZp?=
 =?utf-8?B?VENoN25wKzNJemQxWS9YVlVrRWROWlgvdXpzYjRaY2R4eHBzdFEwUFRXU0d0?=
 =?utf-8?B?Mm1VRFVteGlWc2RuM0xlcTlwaEQ1RXQyekdVRy84eEIxTHZsMFRTSXFpTm9q?=
 =?utf-8?B?SExuWlBNVmd0dnpJaEpwcUc2L0VzcXlmUVR6TldGVGliYklpa0pUcGZlaE5x?=
 =?utf-8?B?aEVUQWtBYXRpRGdvYUs2bTEyby9BL1BmUWVvc2JmRW05N3lML2dUU1ZESkJ5?=
 =?utf-8?B?M3pmQmRQVlB2dExLN2FrMUNzRmd4emVxbUQ4c0J0QUtibHltVG1xcytUSklD?=
 =?utf-8?B?WVl1ek9LMXMxNnFnM3ZjclBPUE5rbTRCaXJYR3AyRzFIa3RKVHhjTVhQM2xh?=
 =?utf-8?B?RzlNS1owa0xpdSt2ci9mUDVpWjVSM0xKNkMxamlrbFlnd0ExdkRKai9rbUtP?=
 =?utf-8?B?YnhDTTFBMzJvOVRNN1NpamQrQnRieUtPSHR0UzhoMzFER1FOTjNwbWZ2aDZV?=
 =?utf-8?B?NjNTTzN1QjA2K0ZwZEcwYzRsbUZjKzRleFVKODdqVHo5U1p1b0YvR2RDby8w?=
 =?utf-8?B?eUxPeU41OWoxVUhmTUpBbjNEUXdGSm5LWkNuRFlBZGJvSEQ2RWxYWHgxZ1F6?=
 =?utf-8?B?ODhaZUhNN1ZmVEtsZVEvR3o2SjZtaVZyVHNwTmdVd1NUenhNb3BEb3U1aG9l?=
 =?utf-8?B?anRFcS9mNWlJaG5HQnl6bEQzM3hCaFd6REhmbWRKMFJjNlJveVkzWmNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW9MQjJzYlBuc3ZvK0RNSGFPcnprc3IwUTV0UTI4ckJYYUlGWmdoVXg0Vyto?=
 =?utf-8?B?djVSMDZ2MmVobGw2M0dWVDViWnIrTzZCL2ZBMkgwRkE3M1pQZWUrREVSbkNL?=
 =?utf-8?B?L2VxMWlTS2tBUnN2ZFdOZ050K1pNdHZLZGlka0Y2UWpuNXozZVFTeG12ZE9Y?=
 =?utf-8?B?dGM1cXZQSklycyt1L3M4M2JCK2dMZWd2MXFXenkwaFBFZ05VeVZjNnFUU2Vr?=
 =?utf-8?B?UmNsaWFsREVTUGJaZFp0aDVHM2pEZm9FZElkMVRTVEtia0VnNGF5bVhWUWRP?=
 =?utf-8?B?TVF1T0FPOVRjemZUNGZKdC9ScmFXdExTa3ExZEp4TmNvVDBSNUUzNmFTMkxO?=
 =?utf-8?B?WkdueFlMazRkZVR6dEIzOTc0a1ZHdEdyOXU5SjJTUnpkYnQyMmNhbU1HS3V1?=
 =?utf-8?B?MktyVG5WcTc1SVBEc1F6c3NnVlAycVpBMEgwMjdsTTVybnpZWFU3Z29vZ3RS?=
 =?utf-8?B?aTAzbGwva3h2WEhrU2s3WEFKM2tOc3liYjZkdDVJTE05U0RrMlBoUmNJakxR?=
 =?utf-8?B?TFJhMWtZWTBZcmF6S3U2cjZSR1RMemI5d1V3eEdRSkNJbjRpMTNLVlJ5eXhF?=
 =?utf-8?B?ZjBBUmo4clJrd2FXV2hsUjlhR1psWUFZZFBpazZYNmdORmdxVDF1amZiZCty?=
 =?utf-8?B?RHM3VjI4M2ZrMlRLbVBUWUV5M0RpeWlZSitrZGIxY2YyTmVSdnFSRDlMQUp4?=
 =?utf-8?B?Tmh2MEQ2TDM3Sm1iZDlUK29SVkJCeDY5bFRzOWJscTNEbXMvd2Vld2w0QUxC?=
 =?utf-8?B?a2w5aVB0b3VlVUUwaFFWRm4wZHRoRk9sVzRSd0kxS0VrMjNvUVNKd0Z4dGkw?=
 =?utf-8?B?SGZ6TEFsWS9oUlQrMHZaOC9lVzhPdTQxSlUyVkJDa2RMdmE1OGNXdnBscXBx?=
 =?utf-8?B?eDE4Y0JCVW8xayt2MDcyR0NuZHE0Q1I2OWNMMDBjWkhPcWdUb1gwVStJTVl1?=
 =?utf-8?B?TFVvUFNQb3Z3WUN3MGl3M0I4TzRQUHFkUUlEeEF1NXNWSjl5ZmxpQ29pbDNU?=
 =?utf-8?B?TVlMd1F5USt1TndLUWFaT1ZyVjYxWTlpNllZNUtDQjRaL1oxU0l0bEJIeHRV?=
 =?utf-8?B?Rm1PWkg0SlFmYklyOHRvM3cyaGxNSHk5MnRSaGhDNzJ3Q1hnNnhHazFFMTdn?=
 =?utf-8?B?eStyTjZnM0gycVZIL21tN3V3QjFubnZ5RzBMM1BtRXhxYjNjR1dQbnJDUFBi?=
 =?utf-8?B?L3d5Q0xTKzZSRVZ2cW9WU3dzZGtSN09sc3VYdzN0d2liOW02NFNYMG03Z3FB?=
 =?utf-8?B?bjFQUVFnc1ludWNhTllObm0veVMyTE9ZMTJySmg3YjBmZ0ZBV0VwZFB4djNO?=
 =?utf-8?B?dkl3OEU5MXA3b0NUQ0FUYjJSVGs4d0VyNi8wUFRGaU5VRjZ0K2VqT3VBaUFr?=
 =?utf-8?B?QyswcGt0emE4eElFczZITVl1Um12Y1ppWFJYdnRmbEJOZ295bnBkZXJqdDc4?=
 =?utf-8?B?TXV3ajRpT0k1dGNuUEVIbkxwK0JIL09RN0QyTzVzc1NqeUlpRTllSTR3bWVh?=
 =?utf-8?B?d2N1MVpQRVhrVVRSOFdPblcvTGQvZ1AzRmJ1eHJMSUtORDVnT3B6bXFldERs?=
 =?utf-8?B?VEZ5TGVqaTE3VlBQVStSY2Y5cmRYRjlwZ0VyR1F6UVZSRE5wRlFmQTFVZTJl?=
 =?utf-8?B?TTQwYzhjQ3l0R25tdmlhWU9SdWJqdDdlUzNlYkZLdGJmY2drTTg2R3JVS3BZ?=
 =?utf-8?B?MjYzckxpVURwc1NXa0gwMU1TclJGZlBJc1g2YjRKL215bVNuVnZxMFRGVkdO?=
 =?utf-8?B?WjFORWxjVklrKzBaVVBNakR0dlNRc3BTWHdTVzRyZVhiQWJBeTlGU2FOWVVu?=
 =?utf-8?B?QVF5ZzVQbUFIbkV6eDFHSWx2N0tXaU5RcDRlUHdoTTBSdFJTZS8wMXZ5TUVD?=
 =?utf-8?B?bEhWSSs1TlREUDhsSTZkMnRTaXh6TGhyditnSGhWVEZwc2pybVN1WDdPSVhV?=
 =?utf-8?B?VitVQWdEYXNWaS9jdS9jT1dtZWlkY0NqU29XL1BIWjVsTnRld1NsQUJPWGdV?=
 =?utf-8?B?QURZUzFkYXJvQ1hZV2xvdFZPajBaS2wrNmpXRXBoc1N5NFVXR1hQbDZMdk9l?=
 =?utf-8?B?dHdlMFZLajFOWXhjQ2J0TE1WcFUvdlNCT3dkOER3Tk8yYXBFSWhROEs2OGJt?=
 =?utf-8?B?eVNtVkdlb3hyNEp5dVpGbCtxNGFRR25Ibk15cW81QU5kOVc5VjZUUGtzM1o2?=
 =?utf-8?B?SGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d2bb8c-7e24-4b02-070e-08dc64898b38
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 18:08:29.0051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3meHLN5zRdagjfbRnsAszvJDhUcJRt4EBh0ZCxObPHfmCMuilDW9nSzyLO2ZvH+Zsu6oiv5Cv2bPOWH33xnTSgHEC0KZ/kfXvOX1hOxWAD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7428
X-OriginatorOrg: intel.com

Dongsheng Yang wrote:
> 
> 
> 在 2024/4/24 星期三 下午 12:29, Dan Williams 写道:
> > Dongsheng Yang wrote:
> >> From: Dongsheng Yang <dongsheng.yang.linux@gmail.com>
> >>
> >> Hi all,
> >> 	This patchset introduce cbd (CXL block device). It's based on linux 6.8, and available at:
> >> 	https://github.com/DataTravelGuide/linux
> >>
> > [..]
> >> (4) dax is not supported yet:
> >> 	same with famfs, dax device is not supported here, because dax device does not support
> >> dev_dax_iomap so far. Once dev_dax_iomap is supported, CBD can easily support DAX mode.
> > 
> > I am glad that famfs is mentioned here, it demonstrates you know about
> > it. However, unfortunately this cover letter does not offer any analysis
> > of *why* the Linux project should consider this additional approach to
> > the inter-host shared-memory enabling problem.
> > 
> > To be clear I am neutral at best on some of the initiatives around CXL
> > memory sharing vs pooling, but famfs at least jettisons block-devices
> > and gets closer to a purpose-built memory semantic.
> > 
> > So my primary question is why would Linux need both famfs and cbd? I am
> > sure famfs would love feedback and help vs developing competing efforts.
> 
> Hi,
> 	Thanks for your reply, IIUC about FAMfs, the data in famfs is stored in 
> shared memory, and related nodes can share the data inside this file 
> system; whereas cbd does not store data in shared memory, it uses shared 
> memory as a channel for data transmission, and the actual data is stored 
> in the backend block device of remote nodes. In cbd, shared memory works 
> more like network to connect different hosts.
> 
> That is to say, in my view, FAMfs and cbd do not conflict at all; they 
> meet different scenario requirements. cbd simply uses shared memory to 
> transmit data, shared memory plays the role of a data transmission 
> channel, while in FAMfs, shared memory serves as a data store role.

If shared memory is just a communication transport then a block-device
abstraction does not seem a proper fit. From the above description this
sounds similar to what CONFIG_NTB_TRANSPORT offers which is a way for
two hosts to communicate over a shared memory channel.

So, I am not really looking for an analysis of famfs vs CBD I am looking
for CBD to clarify why Linux should consider it, and why the
architecture is fit for purpose.

