Return-Path: <linux-kernel+bounces-104801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A94C787D3D9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA301F2173E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485BC4F613;
	Fri, 15 Mar 2024 18:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G9Ye7ffm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JH/jj0uP"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEF04CE1B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528262; cv=fail; b=F+WcCdga5VmbQLGst9ZFHGDq5YnZvY6oiUSF9Eu5zTfn/zqjhaHBhrqTzrgLXWjCSbrrzvRc5+pkv3V0k7k+aGrP1+FEyCgDTXFSG5/mgrY0l4d0WS8MyWD9u99PypFN5G5F0JLIkOk8VxqKms08abyHqvrKIV6Ze5kTT3/9V58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528262; c=relaxed/simple;
	bh=7z3D1JQPCwadNSxSgod31GVU8NYZ3ZQr+RB08msUGDc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b5dnKBGpHOVYa9JU0nXD256qPa0QQKLwlqF5cgYtmSCcZ5fQYSB+Ab9FDB4A0kLpj1qRgpMYS0UHBAKF+jAdTGA+NmyeeTMaqHcTTzDGC2IZNB0sT9/8nZer6NzvCiUEQT7nyb1/Kn09G2kHUPQkGu8NxU5TKqFahDiOLa8EEQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G9Ye7ffm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JH/jj0uP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42FH8xjq030186;
	Fri, 15 Mar 2024 18:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=7z3D1JQPCwadNSxSgod31GVU8NYZ3ZQr+RB08msUGDc=;
 b=G9Ye7ffmYvFHhCHuDL2tgSjaxd7hbOeQSzaMpkvhW5rk5nahVzz9zXqIQnXwcZV0bd1e
 UE0BI08awnfCYRPievskuS7I1cqGEeGogAT3lvKhh9Q3L9+G7KUtfMl8kcCaalQktSTw
 sKbKXrcw4F0j5neGnYXvuPabZa9mxCQdUuis8MOZ2VIk3MHwoP5F9T8R1zl8IlEACF42
 PyE52XmIBhyX7eol4RvCQTQnAmT4r6kvASjWEAm3LwDx+tvKH7BZzy5Cq3j3yWYBe6/i
 eVm/3YRFSNu5RAQbCsA7FB8VX/AosGnpGr8nReWdJrTyuqYxfBZu8yQpd6CRnTFFHXRe mQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wvt340852-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 18:44:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42FHKmSn020302;
	Fri, 15 Mar 2024 18:44:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wvtnbu2tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 18:44:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j58O5Pm7FeUajA632l2S2kH1v1NRIQ/FU85ErTVwH6tXtghLqRnoyMZCz9LyAg8YYFRq3oGp0BGmPEybsmxzGC4djfQzAj9FxU4D8NUrM7PzcVkS0+HKrrd0Lf7CvUK7nzPsCZPPtpy9+avB0VsokzDB3Qe2sVIbYqQ/v+DCmzzCRXFqj+XI3gFor/aOBrfpa2s4SB44tBXt5skqmCzvnTvgiD6T7syPSYZF1UcHcuu7m8Q74ikOnVih/AP8LWivZNaFFdTstuyZljZbOiWPsc1eo1yBruYhzjyRPIDfJhmf5mGkqRIY/4dtTGuSuNfJ087sh3HUpcWfT9qKzBp9TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7z3D1JQPCwadNSxSgod31GVU8NYZ3ZQr+RB08msUGDc=;
 b=SaImEHn5Wqj/VUlsh6gMVJuiVfv0r83iKZOv5XJQN54+rumS97G1v2VhV0fO9fIftUQMZv3uRdWzdEs/nM0RHKpm29UC40Mu2BH48ckCUKY+jJbOu4YrMB1Zs6xA+zufXB0GwftglsNuHvfwtb/iwr9uCLhMbft24g5tWD1ZSKPbsk5EZwkPc3aQRXAMu4jOMlNBwlA0FZN7VtcpH9N8pOXrIYCjLuiANcpaW0yJRqEYtZujhcLwkCSAxS9//1xK3R/Ep5jGW3fPXJQct9+GNfL4FfE0wQJUVaymE2XVZNHVhrkFJPXQAk0WWEXxgdFC8Df5ovlPPrhzTXW2OUfmRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7z3D1JQPCwadNSxSgod31GVU8NYZ3ZQr+RB08msUGDc=;
 b=JH/jj0uPy2phixhXEqMdXMxdFaimz3mmKqN9JL3XcTYk2pZOZyWzzPY3F6se+N5BFI9CkRr85CaIbD0c8nMTw5qrUH3VehWqJDSorDqwquHI8fsMN/gGYwIFwXfAFeeLxpdqnX1VB9CTeYlRgIWQDs4kkCNQNJxORpxJPosd6gQ=
Received: from SJ0PR10MB4478.namprd10.prod.outlook.com (2603:10b6:a03:2d4::19)
 by PH7PR10MB5855.namprd10.prod.outlook.com (2603:10b6:510:13f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22; Fri, 15 Mar
 2024 18:43:58 +0000
Received: from SJ0PR10MB4478.namprd10.prod.outlook.com
 ([fe80::ab66:bf7a:660f:4890]) by SJ0PR10MB4478.namprd10.prod.outlook.com
 ([fe80::ab66:bf7a:660f:4890%4]) with mapi id 15.20.7362.035; Fri, 15 Mar 2024
 18:43:58 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: Dave Hansen <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [RFC PATCH] x86/pkeys: update PKRU to enable pkey 0 before XSAVE
Thread-Topic: [RFC PATCH] x86/pkeys: update PKRU to enable pkey 0 before XSAVE
Thread-Index: AQHadjilIjzOVMIJj0qYATgIHVicxLE3ioOAgAGHjQCAABLsgA==
Date: Fri, 15 Mar 2024 18:43:58 +0000
Message-ID: <66A5A2E7-3B29-4596-9B26-E1B0031BB74D@oracle.com>
References: <20240314172920.2708810-1-aruna.ramakrishna@oracle.com>
 <4bd2aea0-3cea-4ef8-9607-40447cd531e5@intel.com>
 <349322E5-5E6C-48D5-BA12-1CF47CE82930@oracle.com> <871q8bl7nf.ffs@tglx>
In-Reply-To: <871q8bl7nf.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4478:EE_|PH7PR10MB5855:EE_
x-ms-office365-filtering-correlation-id: 8dc05095-c3d1-4dd1-aae8-08dc451fdfd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 T/IW23OjNrh2N99rgs8KJWgIqE3EsO/LVzoC7YMtoUbtdXWUjP/8ZUPSh5bSempajQel7+aZCDW6yWps7ifiJmYJgkhDlF0bP0tOQpGq/aGv56rGPQ6zTiXsokPrAOGQTxy0X7QE8bRX3bEYigCmn1u5hrUfPYjNW+5NfuMUBpnTct48ciiHFRfoZM0wAKmIKbf8/UJ7+yhewlSXWXiBckfvIdaQmdlFxjr2FIgu5wTrewCCuwpEt6JUzM+gBn9XzAL06J5ExKiBSbzFzGhC0bVIGgYUyKQFmZ/n8I34T7kyHcYrZjF64bv5FJJjnvcc8fLahRPnleFNUUFrKPUvEi4Au6XBTIH7/lYbhqiH2tP8w4Il8UGIHO3Av3UWJ0H+ie3JyfM9bWfZgOGOPVCSUZY+Ude2C+CM0UZYFyK51sGLYyTCHMspOUTRW02PnSArAuKxh83wLXhaXO4QglDekWiS7YVydP3FCQNJzUEJtBiiBLoLE9sJb7HzyBcmAzyh0TeuQqCSDXjpCU2Vx3qwvfsmBmHLv6Wg+cO8UTnWHjLT8FCMb2jn9ed6t914sNpRQ7XWgKQXS+31n1lleJTf/91at05Zv0iYRQibfc32GsoG8xK9eK5YOf8tDCsFGrHl23SJDgWo5uE9hBGXFcbDK4xSDzYt64N0mdZR89ddByI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4478.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SlVuaHpNSFpQR213cWVJNGlITnJ4RUI3TExUSXVyME96VTVLclREemxVY1NM?=
 =?utf-8?B?VklXUkZJYVQ1RlRDZjcyaks0QTloemx0Tm13bTJ5T0lXMnhFeHhmYUY3Wms0?=
 =?utf-8?B?OUhQRkpyWVByZjM5aE1uSlBHRThuR3U3OXVtT0ZreEJEd3g0Q3gvNUs5Mjlr?=
 =?utf-8?B?bDl4SU9FMnYwMmo0d3crSzdJVEI4NDg5SDhjNExUYzkzbmRJZWR1VE52VkIv?=
 =?utf-8?B?ejMvQ2xyTXF1VVJvWTlwM053U3dYMGord3dtdUNiV2QyZ0ROMmdFcnlTclVY?=
 =?utf-8?B?OXduMjBURXVIbEVja2dnZ0N3QVY4aDJtcDYxN25LSXdLaHJpdWFlOWpwSE0y?=
 =?utf-8?B?aGlXblF4RXllK216WWpib093RmtuZVViSEFuNTRkbXpFSWFneUR6L1lBOTFP?=
 =?utf-8?B?aU1NQUpKZTFDbytFU2lxTmUrMkhVTHdRVG9GU25ia3dJVzhmTVBpVWFKL1NH?=
 =?utf-8?B?OHJnVFZtRUl0UThRRjUyMi91T1FDeDl5U1RZUW5wWDIyYWZjdUR0bWw3di9p?=
 =?utf-8?B?dkFQNWZrTHQxSXZwZlZaR28vODRXWXN2VGFqNjFtczhxUVZ5RjJ2MGYrNXdK?=
 =?utf-8?B?eGJsYWNVMlJtZVplSHUxSXd2bUE0ejhST2plUW14ZG0vc0xBT1E1Tjg1OU43?=
 =?utf-8?B?b2RUdC8vc1ZvWVhEWVJVMXYxYXZEZnN4Sk9WekxMZngrTFFMUElseDNxYnE1?=
 =?utf-8?B?TmxUOE1QNENtVUQ2QVVENGFtajdXM0JtVkUxbkUxUFF4WEN6NExxU2NSSnRq?=
 =?utf-8?B?WS9TV2RWWm1FK3A2b3h0RVIyNUdzdW5aT3F3T2RaaDJVYWZzdDQ0ZUI0Q2tw?=
 =?utf-8?B?VkNMbjE0SWdTTi9MMVc1RXorc0EwZzA5RjkzLzZXZ29ZUldlenBLVi9ad2tY?=
 =?utf-8?B?MUx6RVFCeWJLS2pKMFJsL3lVRy9JRDNML1hoMnpYczJqWTRiV25POW9HV3V6?=
 =?utf-8?B?dWNqSTZkMUFxT2U3Zkd3djFxOThSU1hjVjFrM2R3WGxLQzFyVzRoY05EQjZ2?=
 =?utf-8?B?Z2Iva2kwMUdkb0kySVl5c3hOUmVLNjhHeGdyYkF0LzRmTU4zaTh0QzZETkNZ?=
 =?utf-8?B?dktwN3ZUQTBvY0FCSGltRlRYVm1QSklsNTJiWmxNazhWV1VHUFJIaUlySllr?=
 =?utf-8?B?NURXUnZ6bnIxT0x3M1Nwb2lzcVhBRkNxeDlBQURLM2Y0ZnB4SlQ3ZXFNdEFN?=
 =?utf-8?B?K1ptdllwVmtCSHU4d3ZzUzNkUmttblJ6ZkxHMEdndHA1ekMzR1J0Mm44dU9N?=
 =?utf-8?B?U2RNVHR0MVBqTjBFcWtTamNsUjhMTzkwck9KTlREYWg5eDBmaVBhcFZwNXAv?=
 =?utf-8?B?Q0NZZ2xmUy9UdzYvbnRqUmIxYk8xRXduZllJMkdoRTNNNmJBK0JqWVVDekhV?=
 =?utf-8?B?eXZuM0k0RXlnRVREdVNQK3ZrVnZ3UUpkSlk0TXBuVGx1V3BPYzlsWG1DSzZB?=
 =?utf-8?B?N2RwUnE5d2YwQkJjUXNjZFJ2U0EvUVpBem1GL1FmUzg5NDIrbFBndm84ZWdO?=
 =?utf-8?B?T25tUVVuNmUyVmM0RWNNQWRPUXRHOEFIMXo0NWtkcHQ2Z1ROYk56cWk2UU9I?=
 =?utf-8?B?N3l2Tkh5d0lSay9kN3gzVGRUcVdyYU9TSWV3Z3d5T0tmNFI4SXdvUTVqNXla?=
 =?utf-8?B?TGVhN0NZa1paQ0J4bmM2dllodEErZnBuMWhBMThjUWJ1NHlCWEpSYXFUbi9I?=
 =?utf-8?B?K2Ivd1MwbmxEdkxCZ2w2Y2pjV2JMa3h0dGsvNEhtbHpBOFJUdUwxY1Q0emRO?=
 =?utf-8?B?NTMyWEhkT0h0WTBydm5nMmFTSEkvRXNZZmsxMFFVa0dEbzhJUHVUMVBnOVpR?=
 =?utf-8?B?NmxqRmtMb0pmaE1CQnU0WitBV1RBNWJ5K1BzSHkrNXdyODJMRVdJempKblgw?=
 =?utf-8?B?czFBZFF0Y1J2MTdXRGhCc1VGWXV2TkRuZTI0UWVkaFUzcG13YmQzQ1NqYjBG?=
 =?utf-8?B?NVpJZmFVRmd3a0VMMFJ3OWdPbnlPSXlyOVhCYnMza1FJVk1JeDhBR3MrbTdF?=
 =?utf-8?B?TlVNUnA1cGZXZXpERzF6L0hFTDgzY3g4TW9uR0pjRFczQnlzTno1RFNGUXUy?=
 =?utf-8?B?aDBNM3VsMHB0Mk9aYkFGbWU2ak0zVGxUbm94US9XZ0d6MFRlclBBZjFENFRs?=
 =?utf-8?B?bkdjV21nWmt2RnpoS3hrTS9uV0U2VlVOdU5MVEF3MzFRWTlDaEE2QzkzQitx?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9C7BB1CD94E7147A6CD7A54EFF4D9A1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pjZj58t2SPBI6gSqPqUEVqRA5UO6x3K4nE2DmX6L+Q6drK3LBcDy9pSuxYWRv5bAmoqBGIXJOZd8ZKGS8A5p9UVYlIcc6CcTt1OaSh2MPq8PBG/3oIP6eB+xsHAghs2GLdEDiqSn9RrUinXLMsi/t1OcwgtgK9MMmuyKZ8pVz8zEX9yJ3xHpboOJxbDt/1BUjKc1CrTnirwxNBnUZGrBE+gGeWvin4GJo/42gzerDT3zBZiIjHBL17tkGw71iPrRgYICy3aX3dWeccFVFIWvzdfjEcikl8KXyfQv7OPelCh7y1ErMs91NPH8MCjCjJqJzbvIXjz7yl4hUKlQNVQcfceFXbRlH0JOjtTr3IE8tjWo7xsDQH/FakndVllhEPLpYjSEARtQWrOSPVwXLFEBoO/58et8iMUHsWhM1B7GxtGP/hIblh2jB16JID8dLhP+obC0TmPgxBfeBNYpkp73EuJu5Y1U2YzndCARAvKCMRSoe6BGAtpFGRVDjdRQhSeSlG+o4kw4MlHpnDZeiI6cni1dAzx6esd09hC8Go6xt6IYeMXMAFsujLhI/gdp9JrDcW3Cfb3t4tCePOoYmq5WFYFzDlLCba32b003KPNkR9I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4478.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc05095-c3d1-4dd1-aae8-08dc451fdfd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 18:43:58.1344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 59UR62In4s01FVvXJWTyH4j+Iqwi0QqZeqvXZfcylnHLXF75cjiJwolbOPqSUyqQMVd0/V3HGqOc6DToNQXVMeYQ75fxOjSkCr7OuHud/Ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5855
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_05,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403150152
X-Proofpoint-GUID: bqZooCBSqE6DsmahJLTk2ejsh1Z0t2B-
X-Proofpoint-ORIG-GUID: bqZooCBSqE6DsmahJLTk2ejsh1Z0t2B-

DQoNCj4gT24gTWFyIDE1LCAyMDI0LCBhdCAxMDozNuKAr0FNLCBUaG9tYXMgR2xlaXhuZXIgPHRn
bHhAbGludXRyb25peC5kZT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIE1hciAxNCAyMDI0IGF0IDE4
OjE0LCBBcnVuYSBSYW1ha3Jpc2huYSB3cm90ZToNCj4+PiBPbiBNYXIgMTQsIDIwMjQsIGF0IDEw
OjU04oCvQU0sIERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+IHdyb3RlOg0KPj4+
IFRoZSBuZWVkIGZvciB0aGlzIG5ldyBmZWF0dXJlIGlzIGhpZ2hseSBkZXBlbmRlbnQgb24gdGhl
IHRocmVhdCBtb2RlbA0KPj4+IHRoYXQgaXQgc3VwcG9ydHMuICBJJ20gaGlnaGx5IGR1YmlvdXMg
dGhhdCB0aGVyZSdzIGEgdHJ1ZSBuZWVkIHRvDQo+Pj4gcHJvdGVjdCBhZ2FpbnN0IGFuIGF0dGFj
a2VyIHdpdGggYXJiaXRyYXJ5IHdyaXRlIGFjY2VzcyBpbiB0aGUgc2FtZQ0KPj4+IGFkZHJlc3Mg
c3BhY2UuICBXZSBuZWVkIHRvIGhhdmUgYSBsb3QgbW9yZSBpbmZvcm1hdGlvbiB0aGVyZS4NCj4+
IA0KPj4gSSB0aG91Z2h0IHRoZSBQS1JVIHZhbHVlIGJlaW5nIHJlc2V0IGluIHRoZSBzaWduYWwg
aGFuZGxlciB3YXMNCj4+IHN1cHBvc2VkIHRvIGJlIHRoZSBkZWZhdWx0IGJlaGF2aW9yLiBJbiB3
aGljaCBjYXNlLCB0aGlzIGlzIGEgYnVnLg0KPj4gDQo+PiAiU2lnbmFsIEhhbmRsZXIgQmVoYXZp
b3INCj4+IEVhY2ggdGltZSBhIHNpZ25hbCBoYW5kbGVyIGlzIGludm9rZWQgKGluY2x1ZGluZyBu
ZXN0ZWQgc2lnbmFscyksDQo+PiB0aGUgdGhyZWFkIGlzIHRlbXBvcmFyaWx5IGdpdmVuIGEgbmV3
LCBkZWZhdWx0IHNldCBvZiBwcm90ZWN0aW9uDQo+PiBrZXkgcmlnaHRzIHRoYXQgb3ZlcnJpZGUg
dGhlIHJpZ2h0cyBmcm9tIHRoZSBpbnRlcnJ1cHRlZCBjb250ZXh0LuKAnQ0KPj4gDQo+PiAoUmVm
OiBodHRwczovL21hbjcub3JnL2xpbnV4L21hbi1wYWdlcy9tYW43L3BrZXlzLjcuaHRtbCkNCj4+
IA0KPj4gSSdtIG5vdCB2ZXJ5IGZhbWlsaWFyIHdpdGggcHJvdGVjdGlvbiBrZXlzIChiZWZvcmUg
SSBzdGFydGVkIGxvb2tpbmcNCj4+IGludG8gdGhpcyBpc3N1ZSksIHNvIEkgYXBvbG9naXplIGZv
ciBtaXN1bmRlcnN0YW5kaW5nLg0KPj4gDQo+PiBmcHVfX2NsZWFyX3VzZXJfc3RhdGVzKCkgZG9l
cyByZXNldCBQS1JVLCBidXQgdGhhdCBoYXBwZW5zIG11Y2ggbGF0ZXINCj4+IGluIHRoZSBmbG93
LiBCZWZvcmUgdGhhdCwgdGhlIGtlcm5lbCB0cmllcyB0byBzYXZlIHJlZ2lzdGVycyBvbiB0byB0
aGUNCj4+IGFsdGVybmF0ZSBzaWduYWwgc3RhY2sgaW4gc2V0dXBfcnRfZnJhbWUoKSwgYW5kIHRo
YXQgZmFpbHMgaWYgdGhlDQo+PiBhcHBsaWNhdGlvbiBoYXMgZXhwbGljaXRseSBkaXNhYmxlZCBw
a2V5IDAgKGFuZCB0aGUgYWx0IHN0YWNrIGlzDQo+PiBwcm90ZWN0ZWQgYnkgcGtleSAwKS4gVGhp
cyBwYXRjaCBhdHRlbXB0cyB0byBtb3ZlIHRoYXQgcmVzZXQgYSBsaXR0bGUNCj4+IGVhcmxpZXIg
aW4gdGhlIGZsb3csIHNvIHRoYXQgc2V0dXBfcnRfZnJhbWUoKSBjYW4gc3VjY2VlZC4NCj4+IA0K
Pj4+IEkgaGF2ZW4ndCBldmVuIG1vcmUgdGhhbiBnbGFuY2VkIGF0IHRoZSBjb2RlLiAgSXQgbG9v
a3MgcHJldHR5DQo+Pj4gdW5zcGVha2FibHkgdWdseSBldmVuIGF0IGEgZ2xhbmNlLg0KPj4gDQo+
PiBJIGFncmVlIHdpdGggeW91IC0gbm8gYXJndW1lbnQgdGhlcmUuDQo+IA0KPiBJdCdzIGEgaG9y
cmlibGUgaGFjay4NCj4gDQo+PiBCdXQgSeKAmW0gbm90IHN1cmUgdGhlcmUgaXMgYSDigJxjbGVh
buKAnSB3YXkgdG8gZG8gdGhpcy4gSWYgdGhlcmUgaXMsIEnigJltDQo+PiBoYXBweSB0byByZWRv
IHRoZSBwYXRjaC4NCj4gDQo+IElmIGl0IHR1cm5zIG91dCB0byBiZSByZXF1aXJlZCwgZGVzaXJl
ZCB3aGF0ZXZlciB0aGVuIHRoZSBvYnZpb3VzIGNsZWFuDQo+IHNvbHV0aW9uIGlzIHRvIGhhbmQg
dGhlIFBLUlUgdmFsdWUgZG93bjoNCj4gDQo+ICAgICAgICAgc2V0dXBfcnRfZnJhbWUoKQ0KPiAg
ICAgICAgICAgeHh4X3NldHVwX3J0X2ZyYW1lKCkNCj4gICAgICAgICAgICAgZ2V0X3NpZ2ZyYW1l
KCkNCj4gICAgICAgICAgICAgICBjb3B5X2Zwc3RhdGVfdG9fc2lnZnJhbWUoKQ0KPiANCj4gY29w
eV9mcHN0YXRlX3RvX3NpZ2ZyYW1lKCkgaGFzIHRoZSB1c2VyIGZwc3RhdGUgcG9pbnRlciBhbHJl
YWR5IHNvIG5vbmUNCj4gb2YgdGhlIF9fdXBkYXRlX3BrcnVfaW5fc2lnZnJhbWUoKSBtb25zdHJv
c2l0aWVzIGFyZSByZXF1aXJlZC4gTm8/DQo+IA0KDQooUmVzZW5kaW5nIHdpdGggc29tZSBlZGl0
czsgSeKAmW0gbm90IHN1cmUgd2h5IG15IHByZXZpb3VzIG1lc3NhZ2UgZGlkIG5vdCBtYWtlIGl0
IHRvIHRoZSBtYWlsaW5nIGxpc3QuKQ0KDQpJ4oCZbSBub3Qgc3VyZSBJIGZ1bGx5IHVuZGVyc3Rh
bmQuDQoNCkFyZSB5b3Ugc3VnZ2VzdGluZyBtb2RpZnlpbmcgYWxsIHRoZXNlIGZ1bmN0aW9ucyBk
b3duIHRoZSBjaGFpbiBmcm9tIGhhbmRsZV9zaWduYWwoKSB0byB0YWtlIGluIGFuIGFkZGl0aW9u
YWwgcGFyYW1ldGVyPyBXb3VsZG7igJl0IHRoYXQgYnJlYWsga0FCST8NCg0KSW4gdGhpcyBhcHBy
b2FjaCB0b28sIHRoZSBzbmlwcGV0IHdoZXJlIHRoZSB2YWx1ZSBpcyBtb2RpZmllZCBvbiB0aGUg
c2lnZnJhbWUgYWZ0ZXIgeHNhdmUgd2lsbCByZW1haW4gdW5jaGFuZ2VkLCBiZWNhdXNlIHdlIG5l
ZWQgdGhlIHZhbHVlIGJlZm9yZSB4c2F2ZSB0byBtYXRjaCB0aGUgcmVnaXN0ZXIgY29udGVudHMu
DQoNCkkgZ3Vlc3Mgd2hhdCBJ4oCZbSBzYXlpbmcgaXMsIGhhbGYgb2YgX191cGRhdGVfcGtydV9p
bl9zaWdmcmFtZSgpIHdpbGwgcmVtYWluIHVuY2hhbmdlZCAtIGl0IHdvdWxkIGp1c3QgYmUgaW52
b2tlZCBmcm9tIGNvcHlfZnBzdGF0ZV90b19zaWdmcmFtZSgpIGluc3RlYWQgb2YgaGFuZGxlX3Np
Z25hbCgpLg0KDQogICAgICAgcGsgPSBnZXRfeHNhdmVfc3RhbmRhcmRfYWRkcigoc3RydWN0IHhy
ZWdzX3N0YXRlIF9fdXNlciAqKSBidWYsDQogICAgICAgICAgICAgICAgICAgICAgIFhGRUFUVVJF
X1BLUlUpOw0KICAgICAgIGlmICghcGsgfHwgIXVzZXJfd3JpdGVfYWNjZXNzX2JlZ2luKChzdHJ1
Y3QgeHJlZ3Nfc3RhdGUgX191c2VyICopIGJ1ZiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzaXplb2Yoc3RydWN0IHhyZWdzX3N0YXRlKSkpDQogICAgICAgICAgICAgICBnb3RvIG91
dDsNCiAgICAgICB1bnNhZmVfcHV0X3VzZXIobmV3X3BrcnUsICh1bnNpZ25lZCBpbnQgX191c2Vy
ICopIHBrLCB1YWNjZXNzX2VuZCk7DQoNClJpZ2h0Pw0KDQpJZiBJ4oCZdmUgbWlzdW5kZXJzdG9v
ZCBzb21ldGhpbmcsIEkgYXBvbG9naXplLiBJZiB0aGVyZeKAmXMgYSB3YXkgdG8gZG8gdGhpcyB3
aXRob3V0IG92ZXJ3cml0aW5nIFBLUlUgb24gdGhlIHNpZ2ZyYW1lIGFmdGVyIHhzYXZlLCBJJ2Qg
bGlrZSB0byB1bmRlcnN0YW5kIHRoYXQgZmxvdy4gT3IgaWYgaXTigJlzIGp1c3QgYSBtYXR0ZXIg
b2Ygbm90IG5lZWRpbmcgdG8gZXh0cmFjdCBmcHN0YXRlIHBvaW50ZXIgaW4gaGFuZGxlX3NpZ25h
bCgpLCBJIGNhbiByZXN0cnVjdHVyZSBpdCB0aGF0IHdheSB0b28uDQoNClRoYW5rcywNCkFydW5h
DQoNCj4gVGhhbmtzLA0KPiANCj4gICAgICAgIHRnbHgNCg0K

