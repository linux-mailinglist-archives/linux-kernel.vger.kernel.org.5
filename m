Return-Path: <linux-kernel+bounces-106444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8565B87EEBC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66BD1C21291
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9B45577F;
	Mon, 18 Mar 2024 17:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BfqoeLyM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tb5fYEDm"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABA655766
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 17:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710782724; cv=fail; b=cHQ9pxAgHG1jZfx9/VmCcyArTF8wwEEjwFhUO2Hv11qg6usXD/Sa2fZ1bvX7QwGyA/RcgX+TlWnob+Ap9vW/oBhywOB/IbSCJZt5z244lhQ1Q34jnuIhJb6iouNT9E44UxReN4A2GaZOGSdisJmv4X/inGGfAmEEGJg/V+MSCy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710782724; c=relaxed/simple;
	bh=fyHuhZj6TzfakpvMhH8W+smpZnmnfATjZO6WoveW3Ag=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QCZ0ajsYV8HkcY7qKv+O2B1RoHai4KsqIo/ysvH+QjilZXZlF+hvMmZwdOvbVgZt2/pJC4oyUt1CrLEgES9KnyC2cIsVLU314L4+EApQTFX0x+plNy2j1sziaoIs3q8/efVw7coxD24HNUvaf6P6m/RCRFWJgpMj2ZSn1Nxtcxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BfqoeLyM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tb5fYEDm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42IDNswY023844;
	Mon, 18 Mar 2024 17:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=fyHuhZj6TzfakpvMhH8W+smpZnmnfATjZO6WoveW3Ag=;
 b=BfqoeLyMvNYMqk4WPpwEhX7jeAspBzDg2hrwBNrRzURul2klt7/B9jcrz9OleyetwcYy
 ohqZfVPnc72dIcmf7qDEMajT1v8b808emNzi7Y+D4plzLB+oWZIsPPQvl7jFfYHHKucR
 PNnNFsaf9tOeINAxYuc44ujYvvIGAw/ozk9r9KsxAQy7P39Kw5KDlABrh86G0hdqsLkY
 4v9Nvb/yNgKI3z7QtDin+jHkkjSkRs8YqVKKCEdyXTE+Uc+du6dPa2jLaVl/LzaNtT5u
 0Qi+h9UFCCcJt97Mw8CY2ghTiftOedghKYnHqagX4mXztUIBw/Ja0gzbNfak8hPmRB2j yw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww272un69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 17:25:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42IGk45Q024148;
	Mon, 18 Mar 2024 17:25:06 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v5dksb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 17:25:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzhuAb/KdQs5RLq6Q1LasyRvTMu9s53hfis3D2bDjeCPKxBNsl9jTjH3TIXCDuSpS68r2uqSo25JFkiN2VkNYYZIdduEP7d6ZlJZZOcmw6J4mIo0AuIu2CWg0fSDKc0JXRDzGBKjhJ5AbrdtC/D5PgVaExlT5wrOgDYtWPo9D//aWBaFxpqg9E1kwuz/Bk9tjWbjcOCcNWMFln91C66Buf4n3YsnKlX/r2CgEgLKkKqCEMZGUccpKvmgoZPl34HhfJb/Dm3IRP1qcV6BXQ6lVxib667K71ra2G8yixNx50YXTfIe+YAwhOrKECEfK17SawrR5IbY0HkLCc0QNSCUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyHuhZj6TzfakpvMhH8W+smpZnmnfATjZO6WoveW3Ag=;
 b=Aotl2FjIPB/XY9IZe4fyLAJqKyrf7Q+BErhtCgzk5hM5ZrqTs97mgf4DuYL27TG+AtB9EBP6sDZsIrH07hRazRoTW2eDn1EkD9cuAfFmzuMhv4WtQa4uR4OJwu+untAbIrPEzzjAbHC9YoO7lhEXj2lYrHFj7HweLJAucFdSgpQnZshYNs4mg8j2Al3aODPXezuhOQU0FI78p0mAHRM2brZNyxfGGAibEHYMaM4GaNjDwrTW3EbTHp5G07naWNnW9VW21mNmyyvpv/+/eLBxJxIAMRokxK/R3Urw4iedh6ybpRxjB6xjH7FaC0NI3UKmPbhseOGaoDAg4Q3xIeO/5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyHuhZj6TzfakpvMhH8W+smpZnmnfATjZO6WoveW3Ag=;
 b=tb5fYEDmXzA1Gz9YpQFW4Ze6qVqGOxfOHTSM5lW+WJDzBsszNa7uQLvHkBVTAZTLkZTMo2YTa5tPl5rCp6dVNs5Ss7UjGaqIKEgr6vjoWUBH7xyEDlhC6EONtVCcgYprVtdFtT/qNCOK8qvtNXPf2/y/OEVt2ay6gmOkP1aA5x8=
Received: from SJ0PR10MB4478.namprd10.prod.outlook.com (2603:10b6:a03:2d4::19)
 by DM4PR10MB6110.namprd10.prod.outlook.com (2603:10b6:8:8b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 17:25:03 +0000
Received: from SJ0PR10MB4478.namprd10.prod.outlook.com
 ([fe80::2c16:18f6:a8e2:4caa]) by SJ0PR10MB4478.namprd10.prod.outlook.com
 ([fe80::2c16:18f6:a8e2:4caa%7]) with mapi id 15.20.7386.022; Mon, 18 Mar 2024
 17:25:00 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: Dave Hansen <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [RFC PATCH] x86/pkeys: update PKRU to enable pkey 0 before XSAVE
Thread-Topic: [RFC PATCH] x86/pkeys: update PKRU to enable pkey 0 before XSAVE
Thread-Index: AQHadjilIjzOVMIJj0qYATgIHVicxLE3ioOAgAGHjQCAABLsgIAASSYAgARXyQA=
Date: Mon, 18 Mar 2024 17:25:00 +0000
Message-ID: <662B5C8F-660C-4E49-A3CB-59C5D50DD0E7@oracle.com>
References: <87msqzjdtr.ffs@tglx>
In-Reply-To: <87msqzjdtr.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4478:EE_|DM4PR10MB6110:EE_
x-ms-office365-filtering-correlation-id: b20216ea-64b6-4d5e-962e-08dc47705744
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 d67gGtry1yBLFC8BylpdoCDFbnwKLsU/GpYSkcYSOBhTaH5QgW+xiD48IW4hr5eStf0qrIoGUhzC0IGominfJv8ryxkUpr1nc/TWWgeQ0OqvgJkYYBr62NJ8ZQfH2qurGFHFnmlOxAIG4NW5Oj/lmGZ2elK7f9Uqb31uBAuogAm9sH2JLa0+r+XqJGO6ohBxXF0irkXMEU97PKy6zAGdi97h5QExrs/JYKBG8E/ehwyUGo7voBdp4okPK1RL6SBNdYG9NhurlrnLtDB9xR3hkp6ga0JRCMGf66SAPhWo32o74M7nIefZygfJKhwEAZx5uXA7sIpYLOzwrasyC7ZtLFA+B52QMlQyz0f7nIoXLq34HBd8G7Lono5CbeO1gflxzuWXYCTXCDmq0+onHyUiDZkpkINWwm6s52pdtfOBlRYWHlrKLO+5Ioyr8PPQnADVH+mGI1HzaOt0L8H1YmOwAy0c8ybxfujPqDmraInZMm2BQwQbU46hZtI5kS3P89gxhmukrKhMKUT52Wcv5WJ/3w1qKQ8Yg5dsiqpoWCaONc4irecYFTFtIhpzklGdKfO3x/e/khwAdkDW5STyZRmlPIz0heqSZh+/ta/NwY++UgrE6Tww95IveAY4Va26jiRluo/Ce4XHFzR4APzmKVwXfgVV0SmMsZjWVYyQhlEpaUEV/Of6XufzrscwGpy9HRdNwtQ7fOvJ8HLBSSBtlaHtvqGTjkvFECeV7qDf0Pww5QA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4478.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dTgrZm1McERYc08rNUVneCszek05TDMyQnYxYmxuOENGUHJPQmhLME1Qb2Ns?=
 =?utf-8?B?dGloSkI1QzVZVjExU29xZjZsVTg1ZHpEK2pQM2Z0eHRWOENZdWRWa1V6Snhv?=
 =?utf-8?B?R2xCWGREWlp2QWI1SUIxTEdRUWxSSUgwbnNMVElRb1FIVFk1Sm0yRXdDdXVD?=
 =?utf-8?B?MXNiM2dHODQwaXJuVFJlaFUzdWxlR0RpUUxSamZ4TGlaTW1jSWh3ZmZiOFBm?=
 =?utf-8?B?c3lhUHVxZGxxMEFiL3A1d3pLbityMk42dG5DaXg5Wjh3WXNadGdaVEVpVUUy?=
 =?utf-8?B?bi9NbjVHT0hBdjdzWDBzbmZXNkZqUHJNZUJySDhpSGlYU1BMaEE2KzMyUm1r?=
 =?utf-8?B?bm13dlJ3eTdvWmpLSDVmejN3b3Y3eWFuSm53VUVPS3YycVlZVnBVUEhQWUt0?=
 =?utf-8?B?VUdxZnFOVStvY3J5d2pqcVdqanB0dENjVkFHenhGYUEwRElOUElVRS83cUpq?=
 =?utf-8?B?NUllL1c3VVozc3dnci94S3lBL0czcmhEdDJIS29hYW03dWIvS3lOb1YyVlFR?=
 =?utf-8?B?YTQ2alcvTmlWb2xpTTdnWkFWRzYyNTVnU0s3M29FTkFCUzYxNjBEUmZZTC9R?=
 =?utf-8?B?eVFnZGQzbVdieW9OMUs0WGNFTDloYjhvendLdmhSWXBJbGZlOUdMVmJSdGNo?=
 =?utf-8?B?eml0bS9WaTdCSlhFM0NNeWRLa2NyL0VZVjVGTmhja1lzYkcyN2tGSUluT3hr?=
 =?utf-8?B?M2J6OVBNMWtjQnZlNHdobUIyM3BuWmNkOFI4SlJEVWNOam9YVk5Na3FXa0Uw?=
 =?utf-8?B?SW1KTUNwVHRkQWRNc2FwTGRsODZxdU9CbHV0ZUFTeS9tOHV3NGJ2ZytwWlpV?=
 =?utf-8?B?TTFvNW85c0ZXK2JVRTMxWnI3SmpnRnNRdXp0bDIxQldNUjN1bkdTalhxejNW?=
 =?utf-8?B?Y3dvcm9vYzBsaHNrSkM3dzR5WjRyczJCSnB6RFVsVUVzbklEbnJCUVAxZFdB?=
 =?utf-8?B?VHNscVJzUEM4WHNhNHliMnUxelhDc2FlOWZuM2RaTDJxekt1cEpmMTl6ME9H?=
 =?utf-8?B?N2NFRjFhdmJIcE15eTMzOUVpMWs0Uk9QZldzaVNTRzNqbnMxbzVKY280QnZx?=
 =?utf-8?B?Tkp5Rmo2R3RhYVRlOXM1UlhNdk5ZQThPNFNyYjhaUnRrZ3Avc3QrVlNieFIx?=
 =?utf-8?B?SnJRbThGZWZETTk4NGhiekx1aEpMSjhESVJ0Y3hoOUprL0RvOXVZNnZNL090?=
 =?utf-8?B?a3paQzJKejk1dzhWYk90NWRVQmtodVNqOGF0WWtLQTRMcC9JY3ltSFdISzFv?=
 =?utf-8?B?UWNLNnozckhHa2g2UU5aNUJUOFg3SXFDNEVDekt3a1FWbGNyb1E5STd2c0Z4?=
 =?utf-8?B?L2pweVRKM3pqN1VpVWZOUFF4dEZHREtNaFEvaW5mQnI1ZHhSRjlsbGI1UXJT?=
 =?utf-8?B?SWljeEMvaDhlTUtPOHh4T2IyVUhQcFR0WS9KR3dEUEFFdXhUdUxpNzV1aW9B?=
 =?utf-8?B?dmx5UkFtbDJ1UjE4UUlVb3FUbUxKbWtiVE1aU0tldzJ1L0F2UzJlRGU4YUlF?=
 =?utf-8?B?V3dIbFhMZ0xaY1BiR2xUVHpna0Zqby9jLzNpRnJNM0FIcldGakRHL0NhSnZG?=
 =?utf-8?B?c2dDcGZIV3ZhcEJqSVMrd2xtem9jcFh6bHJGUnFiZ1RvU3dpL21oclJLYzBr?=
 =?utf-8?B?VjBXaFgvb2NZeDc5VjU3dGpybjlKeU04dVVOOUxudi9rRzA3RWkyWGZ1VldZ?=
 =?utf-8?B?RzAvZHpzU3E1MkpqYURDZkVvNVhuakx2cjVUSmxVdVRPVnkybnN3R2RQQldl?=
 =?utf-8?B?TDRaZnJWaUs5WmcxUUJjdHdqczY3Zktkc1U0WkVRTXRiemtrSG4rR3JiTFlp?=
 =?utf-8?B?NUx4cnBWclYxOXBCbkZ4bFN0R0RLeEdETGpMc3F5d0tnd3llWThYb2VneDBj?=
 =?utf-8?B?b1Rab0d5aGkybFMxMmVTQkozQzdiOXVydi9ZVmgzZTN4QW95NUxXUTM3cHV0?=
 =?utf-8?B?VjcwRW13ajB5bjM4ajdhMWlVaFJOcm9TcEovaXptK2lLUm5TeFIxbTdqOXQ0?=
 =?utf-8?B?LzRCdEJacng4ZkZZTjFGdU55dHM1Q0Q1Z0ZKd3V5NktKUzViS2I4SjQrd201?=
 =?utf-8?B?dnIrU0ozQytaZjdIWkdNWnNCTjdIVWxxaTJBWlJXUGR3UVpoazdxMFlCTHlj?=
 =?utf-8?B?SVYvTDlxcm05RStrMjF6cG9yVHRYRWkwU1NSZjVnbENJWkdJS0k4Sml4YWgw?=
 =?utf-8?B?L1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C6C4217742C764D91A30785526672AB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LnxIIyLemthbEWJPwYWU4C6WO+EifvjD4RAXiFetq/gDTqXEM7V9lUwreEktX6CI8s4/RbkaNSBMSqy7CZ24dPeaTSKZQNEDHBg3WTMSsNbt4NbafLmAmWy2BCowGZpF8AILhXltZVYra8rbI8odNqcr+cugj7/PLvOxskt7VaPBYuJ/YZMfi7YwnGC7QdaHTCssNmdemHwrBd6c5aDZovB4AMYvgE0J6RqbKdXrYWIPdMUggYLy0SAw0teb7sD+B6hh+hi2r2ThQLA2/a6RZNlqeV6io5ZEQt6nQoi+TssoO96Xeub9TDQLfvenmIBL7cen73/U+o9aqUXwE2gY7GiUnCaKOEccqCpzufuT39e4qC03Gg1ejK5vy3lV3R8oHnV7F14foHCmPUPQTgI2pbCqjCt+vgItoUpPQILX08FBtKAEsJderAwqly2YfTLrjPMzRN+Q+D6L2QABviaiKBUG1YmOhyIu/295q56vCywoIFB1IeaKoX3yJfLSj8ECOkHQZytQn/glIw0bjdIHCeRv5L6HBicIQzvtjL1m1dwPLjcg3Wcn9OdhI30yAdu5k3Wq8HO08pI3jqjGjxGwrKVr36oVsXUI161pgrPcrUI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4478.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20216ea-64b6-4d5e-962e-08dc47705744
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 17:25:00.5747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SKWWV5SKmq/1/lHLmuPwLLrsvs/4LjKv1TK190NI6s/NYFHxkfoP9HIMqdd/jQD6ClbLc8Bz/gNxmcUbs6rd7QqRCxQYSTuqq2L6QwJ5TJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6110
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403180131
X-Proofpoint-GUID: RNgEHopT9gtPAwme4IN2gSjS7hsyRl8g
X-Proofpoint-ORIG-GUID: RNgEHopT9gtPAwme4IN2gSjS7hsyRl8g

DQo+IE9uIE1hciAxNSwgMjAyNCwgYXQgNDowNeKAr1BNLCBUaG9tYXMgR2xlaXhuZXIgPHRnbHhA
bGludXRyb25peC5kZT4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIE1hciAxNSAyMDI0IGF0IDE4OjQz
LCBBcnVuYSBSYW1ha3Jpc2huYSB3cm90ZToNCj4+PiBPbiBNYXIgMTUsIDIwMjQsIGF0IDEwOjM2
4oCvQU0sIFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPiB3cm90ZToNCj4+Pj4g
QnV0IEnigJltIG5vdCBzdXJlIHRoZXJlIGlzIGEg4oCcY2xlYW7igJ0gd2F5IHRvIGRvIHRoaXMu
IElmIHRoZXJlIGlzLCBJ4oCZbQ0KPj4+PiBoYXBweSB0byByZWRvIHRoZSBwYXRjaC4NCj4+PiAN
Cj4+PiBJZiBpdCB0dXJucyBvdXQgdG8gYmUgcmVxdWlyZWQsIGRlc2lyZWQgd2hhdGV2ZXIgdGhl
biB0aGUgb2J2aW91cyBjbGVhbg0KPj4+IHNvbHV0aW9uIGlzIHRvIGhhbmQgdGhlIFBLUlUgdmFs
dWUgZG93bjoNCj4+PiANCj4+PiAgICAgICAgc2V0dXBfcnRfZnJhbWUoKQ0KPj4+ICAgICAgICAg
IHh4eF9zZXR1cF9ydF9mcmFtZSgpDQo+Pj4gICAgICAgICAgICBnZXRfc2lnZnJhbWUoKQ0KPj4+
ICAgICAgICAgICAgICBjb3B5X2Zwc3RhdGVfdG9fc2lnZnJhbWUoKQ0KPj4+IA0KPj4+IGNvcHlf
ZnBzdGF0ZV90b19zaWdmcmFtZSgpIGhhcyB0aGUgdXNlciBmcHN0YXRlIHBvaW50ZXIgYWxyZWFk
eSBzbyBub25lDQo+Pj4gb2YgdGhlIF9fdXBkYXRlX3BrcnVfaW5fc2lnZnJhbWUoKSBtb25zdHJv
c2l0aWVzIGFyZSByZXF1aXJlZC4gTm8/DQo+Pj4gDQo+PiANCj4+IEFyZSB5b3Ugc3VnZ2VzdGlu
ZyBtb2RpZnlpbmcgYWxsIHRoZXNlIGZ1bmN0aW9ucyBkb3duIHRoZSBjaGFpbiBmcm9tDQo+PiBo
YW5kbGVfc2lnbmFsKCkgdG8gdGFrZSBpbiBhbiBhZGRpdGlvbmFsIHBhcmFtZXRlcj8NCj4gDQo+
IFllcy4NCj4gDQo+PiBXb3VsZG7igJl0IHRoYXQgYnJlYWsga0FCST8NCj4gDQo+IElmIHNvIHdo
byBjYXJlcz8NCj4gDQo+IGtBQkkgaXMgYW4gb3V0IG9mIHRyZWUgbWFkbmVzcyBtYWludGFpbmVk
IGJ5IGRpc3Ryb3MsIGJ1dCB1cHN0cmVhbSBoYXMNCj4gbmV2ZXIgc3VwcG9ydGVkIGl0IGFuZCBu
ZXZlciB3aWxsLiBBc2lkZSBvZiB0aGF0IGtBQkkgaXMgYSBkcml2ZXINCj4gaW50ZXJmYWNlIHdo
aWNoIGhhcmRseSBoYXMgYW55dGhpbmcgdG8gZG8gd2l0aCB0aGUgbG93IGxldmVsDQo+IGFyY2hp
dGVjdHVyZSBzcGVjaWZpYyBzaWduYWwgZGVsaXZlcnkgY29kZS4NCj4gDQo+IFRoZSBrZXJuZWwg
aGFzIG5vIHN0YWJsZSBBQkksIG5ldmVyIGhhZCBhbmQgbmV2ZXIgd2lsbCBoYXZlIG9uZSwgdW5s
ZXNzDQo+IGhlbGwgZnJlZXplcyBvdmVyLg0KPiANCj4+IEluIHRoaXMgYXBwcm9hY2ggdG9vLCB0
aGUgc25pcHBldCB3aGVyZSB0aGUgdmFsdWUgaXMgbW9kaWZpZWQgb24gdGhlDQo+PiBzaWdmcmFt
ZSBhZnRlciB4c2F2ZSB3aWxsIHJlbWFpbiB1bmNoYW5nZWQsIGJlY2F1c2Ugd2UgbmVlZCB0aGUg
dmFsdWUNCj4+IGJlZm9yZSB4c2F2ZSB0byBtYXRjaCB0aGUgcmVnaXN0ZXIgY29udGVudHMuDQo+
PiANCj4+IEkgZ3Vlc3Mgd2hhdCBJ4oCZbSBzYXlpbmcgaXMsIGhhbGYgb2YgX191cGRhdGVfcGty
dV9pbl9zaWdmcmFtZSgpIHdpbGwNCj4+IHJlbWFpbiB1bmNoYW5nZWQgLSBpdCB3b3VsZCBqdXN0
IGJlIGludm9rZWQgZnJvbQ0KPj4gY29weV9mcHN0YXRlX3RvX3NpZ2ZyYW1lKCkgaW5zdGVhZCBv
ZiBoYW5kbGVfc2lnbmFsKCkuDQo+IA0KPiBZZXMsIGJ1dCB0aGF0J3MgdGhlIG5lY2Vzc2FyeSBh
bmQgc2FuZSBwYXJ0IG9mIGl0Lg0KPiANCj4+IElmIHRoZXJl4oCZcyBhIHdheSB0byBkbyB0aGlz
IHdpdGhvdXQgb3ZlcndyaXRpbmcgUEtSVSBvbiB0aGUgc2lnZnJhbWUNCj4+IGFmdGVyIHhzYXZl
LCBJJ2QgbGlrZSB0byB1bmRlcnN0YW5kIHRoYXQgZmxvdy4NCj4gDQo+IFRoZXJlIGlzIG5vbmUg
Zm9yIG9idmlvdXMgcmVhc29ucyB1bmxlc3MgeW91IGZpZ3VyZSBvdXQgaG93IHRvIHJlc29sdmUg
YQ0KPiBkb3VibGUgY2lyY3VsYXIgaGVuIGFuZCBlZ2cgcHJvYmxlbS4NCj4gDQo+PiBPciBpZiBp
dOKAmXMganVzdCBhIG1hdHRlciBvZiBub3QgbmVlZGluZyB0byBleHRyYWN0IGZwc3RhdGUgcG9p
bnRlciBpbg0KPj4gaGFuZGxlX3NpZ25hbCgpLCBJIGNhbiByZXN0cnVjdHVyZSBpdCB0aGF0IHdh
eSB0b28uDQo+IA0KPiBJdCdzIG5vdCBvbmx5IHRoZSBwb2ludGVyIHJldHJpZXZhbC4gVXBkYXRp
bmcgeHN0YXRlIGlzIG9idmlvdXNseSBhIEZQVQ0KPiBzcGVjaWZpYyBwcm9ibGVtIGFuZCB0aGUg
Z2VuZXJhbCBzaWduYWwgaGFuZGxpbmcgY29kZSBzaW1wbHkgc2hvdWxkIG5vdA0KPiBjYXJlLiBD
IGRvZXMgbm90IHByb3ZpZGUgZW5jYXBzdWxhdGlvbiwgYnV0IGl0IGRvZXMgbm90IHByZXZlbnQN
Cj4gcmVzcGVjdGluZyBpdCBlaXRoZXIuDQo+IA0KPiBJZGVhbGx5IHdlJ2QgaGlkZSBhbGwgb2Yg
dGhpcyBpbiB0aGUgRlBVIGNvZGUsIHdoaWNoIGlzIGFueXdheSB0aGUgZmlyc3QNCj4gb25lIHdy
aXRpbmcgdG8gdGhlIHNpZ25hbCBzdGFjay4gVGhlIHByb2JsZW0gaXMgdGhlIGVycm9yIGNhc2Ug
d2hlbiBhbnkNCj4gb2YgdGhlIHdyaXRlcyBhZnRlciBzYXZpbmcgdGhlIEZQVSBmcmFtZSB0ZXJt
aW5hbHkgZmF1bHRzIG9yIGFueSBvdGhlcg0KPiBjb25kaXRpb24gbWFrZXMgdGhlIHNpZ25hbCBk
ZWxpdmVyeSBmYWlsLg0KPiANCj4gU28gaGFuZGxlX3NpZ25hbCgpIHNob3VsZCBsb29rIGxpa2Ug
dGhpczoNCj4gDQo+IC8qIEVuc3VyZSB0aGF0IHRoZSBzaWduYWwgc3RhY2sgaXMgd3JpdGVhYmxl
ICovDQo+ICAgICAgICBwa3J1ID0gc2lnX3ByZXBhcmVfcGtydSgpOw0KPiANCj4gZmFpbGVkID0g
c2V0dXBfcnRfZnJhbWUoa3NpZywgcmVncywgcGtydSk7DQo+IGlmICghZmFpbGVkKSB7DQo+IC8q
DQo+ICogQ2xlYXIgdGhlIGRpcmVjdGlvbiBmbGFnIGFzIHBlciB0aGUgQUJJIGZvciBmdW5jdGlv
biBlbnRyeS4NCj4gKg0KPiAqIENsZWFyIFJGIHdoZW4gZW50ZXJpbmcgdGhlIHNpZ25hbCBoYW5k
bGVyLCBiZWNhdXNlDQo+ICogaXQgbWlnaHQgZGlzYWJsZSBwb3NzaWJsZSBkZWJ1ZyBleGNlcHRp
b24gZnJvbSB0aGUNCj4gKiBzaWduYWwgaGFuZGxlci4NCj4gKg0KPiAqIENsZWFyIFRGIGZvciB0
aGUgY2FzZSB3aGVuIGl0IHdhc24ndCBzZXQgYnkgZGVidWdnZXIgdG8NCj4gKiBhdm9pZCB0aGUg
cmVjdXJzaXZlIHNlbmRfc2lndHJhcCgpIGluIFNJR1RSQVAgaGFuZGxlci4NCj4gKi8NCj4gcmVn
cy0+ZmxhZ3MgJj0gfihYODZfRUZMQUdTX0RGfFg4Nl9FRkxBR1NfUkZ8WDg2X0VGTEFHU19URik7
DQo+IC8qDQo+ICogRW5zdXJlIHRoZSBzaWduYWwgaGFuZGxlciBzdGFydHMgd2l0aCB0aGUgbmV3
IGZwdSBzdGF0ZS4NCj4gKiBUaGlzIGFsc28gZW5zdXJlcyB0aGF0IHRoZSBQS1JVIHN0YXRlIGlz
IHNldCB0byB0aGUNCj4gKiBpbml0aWFsIHN0YXRlLg0KPiAqLw0KPiBmcHVfX2NsZWFyX3VzZXJf
c3RhdGVzKGZwdSk7DQo+IH0gZWxzZSB7DQo+ICAgICAgICAgLyogUmVzdG9yZSB0aGUgcHJldmlv
dXMgUEtSVSBzdGF0ZSAqLw0KPiAgICAgICAgICAgICAgICBzaWdfcmVzdG9yZV9wa3J1KHBrcnUp
Ow0KPiAgICAgICAgfQ0KPiANCj4gYW5kIHRoZW4geW91J2QgaGF2ZToNCj4gDQo+IHN0YXRpYyBp
bmxpbmUgYm9vbCBjb3B5X2ZwcmVnc190b19zaWdmcmFtZShzdHJ1Y3QgeHJlZ3Nfc3RhdGUgX191
c2VyICpidWYsIHUzMiBwa3J1KQ0KPiB7DQo+IGlmICh1c2VfeHNhdmUoKSkgew0KPiBpZiAoIXhz
YXZlX3RvX3VzZXJfc2lnZnJhbWUoYnVmKSkNCj4gICAgICAgICAgICAgICAgIHJldHVybiBmYWxz
ZTsNCj4gICAgICAgICAgICAgICAgaWYgKGNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVf
T1NQS0UpKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuICFfX3B1dF91c2VyKHBrcnVfYWRkcmVz
cyhidWYpLCBwa3J1KTsNCj4gICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+ICAgICAgICB9
DQo+IGlmICh1c2VfZnhzcigpKQ0KPiByZXR1cm4gZnhzYXZlX3RvX3VzZXJfc2lnZnJhbWUoKHN0
cnVjdCBmeHJlZ3Nfc3RhdGUgX191c2VyICopIGJ1Zik7DQo+IGVsc2UNCj4gcmV0dXJuIGZuc2F2
ZV90b191c2VyX3NpZ2ZyYW1lKChzdHJ1Y3QgZnJlZ3Nfc3RhdGUgX191c2VyICopIGJ1Zik7DQo+
IH0NCj4gDQo+IEFuZCB5ZXMsIEkgZGVsaWJlcmF0ZWx5IGNoYW5nZWQgdGhlIHJldHVybiB2YWx1
ZSBvZiBzZXR1cF9ydF9mcmFtZSgpIHRvDQo+IGJvb2wgaW4gdGhpcyBtb2NrdXAgYmVjYXVzZSBu
b3RoaW5nIGNhcmVzIGFib3V0IGl0LiBUaGUgb25seSByZWxldmFudA0KPiBpbmZvcm1hdGlvbiBp
cyB3aGV0aGVyIGlmIGZhaWxlZCBvciBub3QuIFRoYXQgd2FudCdzIHRvIGJlIGEgc2VwYXJhdGUN
Cj4gcGF0Y2ggb2Jpdm91c2x5Lg0KPiANCj4gVGhhbmtzLA0KPiANCj4gICAgICAgIHRnbHgNCj4g
DQo+IA0KPiANCg0KSeKAmWxsIHVwZGF0ZSB0aGUgcGF0Y2ggYmFzZWQgb24geW91ciBmZWVkYmFj
ayBhbmQgc2VuZCBvdXQgYSB2Mi4NCg0KVGhhbmsgeW91IHRvIGJvdGggb2YgeW91IGZvciB5b3Vy
IHRpbWUgLSBhcHByZWNpYXRlIGl0IQ0KDQpUaGFua3MsDQpBcnVuYSA=

