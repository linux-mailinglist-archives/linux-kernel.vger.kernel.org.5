Return-Path: <linux-kernel+bounces-103648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D37787C271
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E324FB212A2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C51474BFE;
	Thu, 14 Mar 2024 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vv+9G1Rd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gRMWyWjx"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AD57443A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440103; cv=fail; b=nqda3BlDEV57XkUnX1tpiW82hRmnRQS1JtX4kWrftQG9uq4EN5n92m3L6oh1XXJAWaTvsJ4lxeYm9qlDzY0t1/aJEKW5THnaBAnb9KZLz5oEvmF50CPqAFU1EXb0yH3hronRu32te6eXwWElP68hEvwdmUpk0c3bOKXbHZGyvwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440103; c=relaxed/simple;
	bh=iIyOpP1KnS2daH45kCYluRaQPyT3udIpIB4XvBXTDAY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bj5SG39in4TOcz/ucv01dy0n9JrVZM4EDjwiFcJ77JCDA/f1D1EDRhUxECCasCKMSwD9lwktg15ecjo6i1vwwHN5Y8cwwcJTT5nhRXoZ8b+PCs2oT6STey6OZXLqYkJChPnyzEIphIkmiVocoIaOkrFDeiKMj7vj6/tYkEI753Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vv+9G1Rd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gRMWyWjx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42ECLbiU020282;
	Thu, 14 Mar 2024 18:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=iIyOpP1KnS2daH45kCYluRaQPyT3udIpIB4XvBXTDAY=;
 b=Vv+9G1Rd3f6NOGi5EDAMrhS3Y40aBZw2R6VrRCgfbVRkV4uMCRf0W4Oppihkr+LnBl5c
 DEhnVNjfWBKeET22Whik64n/6wU+L4FdSfpzuJtt3P5oaXQjTmBk3thCNAJeCb71rbJr
 o8DSq4ZMtqyIH5JgD2ivhvQpEr6W7bq9mTVJRS1VPBz6fUDzpgmhiM8xkOdAfN+OwhaZ
 EgljLKE1Ow2fC8wGn2YAeELu86L2thnMPQg2NzIUXvj049uXEk9V1Qy8khvM9/Ep8wKZ
 6nz6TgXUpoXOoilK4870x0J+1A7+e5QWMRFwX2D4dHpLSsBBIwpGCREsvY0YLheDMtaS iQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wv0abgxm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 18:14:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42EHZWbA028539;
	Thu, 14 Mar 2024 18:14:51 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7atj6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 18:14:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWKDHxsZMxG3bwRGkaER8yAM9xJ/3C5kx45rXOXkO1SIsYCfgNy3xndFQNjPD4ua8Ezmtb/+o45dxdn8+WNwsdU5W5wVCzBtWPdvtwwPYXKLxD3kzF+hUhg3i0nVg4Cc7wI/uuTquZrXJR2yZ/A1b4WGTRAhmhaH9N7zj30vSSK0I6HwOoSC+oo6ZlU4+3AbeCqgDQPL74J7cMffL2vTeGeFXgYfuWxZKTV/pTzWdl+z6Zm/5fG2obX7RntCnVaUwdz7gKJv+X9vhJyOV+tEk31+vhsJhLrz1o3OhRmqyHlZSA9rpFr7TMWi1jxhzJP5oWjRNyx7j7XsnQXGoCWmOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIyOpP1KnS2daH45kCYluRaQPyT3udIpIB4XvBXTDAY=;
 b=kfKIb9WOAKC3HsuCcPeBIDuD18JhC6tHe6rLNDkCee+F7W2ovgutIK8XfWDwhYdMTSI1I4I9lkePizrcwMyWU2hM7wYQoClTgyOchs485rXT7GLv38iaCsVB6P0T3asE961cskG7jYbju9NuSPa1M+WohpaQgoqEeDt1KD+VpUNqHHq5/LGQJB/g9gZxGWWqL/z4R4RUEO8h94rztmWjwUmed96W7yQ0JZJI2NGF286SiDuJG0fiaECNlog2xAMoxutq4mqtFBNbXHnTE9dfPwUdqu4Z4jQvDSpoZ9p1j+HaNsb7el06vXThP1agZexEDtr/sQyZUy9PvAugZ9KALw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIyOpP1KnS2daH45kCYluRaQPyT3udIpIB4XvBXTDAY=;
 b=gRMWyWjxENV+/fl/bfrIkje73uaabZ31qfSa9ug40sqnSKfpmtBRrkMdnPwAD9qoeSP3ck31CDzA+I4wWH7smZpz9JGLk5JireaVK0oLN1eji3lsFLHMywMiIkudMEQBq5ZgBtnqoLt27zOo+w/30xqzyF313726pcMtOuQIi7Q=
Received: from SJ0PR10MB4478.namprd10.prod.outlook.com (2603:10b6:a03:2d4::19)
 by PH8PR10MB6477.namprd10.prod.outlook.com (2603:10b6:510:22f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Thu, 14 Mar
 2024 18:14:49 +0000
Received: from SJ0PR10MB4478.namprd10.prod.outlook.com
 ([fe80::ab66:bf7a:660f:4890]) by SJ0PR10MB4478.namprd10.prod.outlook.com
 ([fe80::ab66:bf7a:660f:4890%4]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 18:14:49 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [RFC PATCH] x86/pkeys: update PKRU to enable pkey 0 before XSAVE
Thread-Topic: [RFC PATCH] x86/pkeys: update PKRU to enable pkey 0 before XSAVE
Thread-Index: AQHadjilIjzOVMIJj0qYATgIHVicxLE3ioOA
Date: Thu, 14 Mar 2024 18:14:49 +0000
Message-ID: <349322E5-5E6C-48D5-BA12-1CF47CE82930@oracle.com>
References: <20240314172920.2708810-1-aruna.ramakrishna@oracle.com>
 <4bd2aea0-3cea-4ef8-9607-40447cd531e5@intel.com>
In-Reply-To: <4bd2aea0-3cea-4ef8-9607-40447cd531e5@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4478:EE_|PH8PR10MB6477:EE_
x-ms-office365-filtering-correlation-id: e306d9b1-9bc8-4cd8-5cb3-08dc4452a32e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 LWrCnBOQlMhI6vJP2YgySfvPToA74CMMpDQr+cNACsD/SLg2eKnTwRQB6hDRvtxS7OLykck0P7/GizxXYXM1C1MCJ+DBfTQGFFfIjZQQKKXSXoa9L7TGn69QFN7x2og4EvKH5sMPXS1bJe+brmMe3skI41STe8Xjt1HBxYu323iYaL+W1sKKQxpQAsSLMAbCxF2KdlD0TSko9EcwNqTbGEbd1OVsAq91gCscoEixI6VdTWrogRS1gpEwnI5n74PWnRUQst8fuCzBr1z9NpnfJ3kNHDRpnzu0eXKCa27ZcjTwDk4fu4mb2iuzONrKkFaUGuQKVVDFIdOYDJGADlynN3XR76Wcfz8Yq7B/Q4jkGbuLQvegF/ytAvf6rujdEEqe+nlDxbKfezOaxhBL02Bdme5OB8ZIOB05xFFmllQ4L8PV6ppxsxTub3TTgB5SP6w2YVFb0FV40tcxzgKQ9XMmgNP19EWHJ5GLN92H9pNYmztHHn3xyfcgfhxGAyvj0qfIH+Y7ErdRYph1AkJ1VtH7lATDSeeobMIoiHXHAN8jZGryauvjyd5WJjAE+HUBXJWR5PCKJL6BXG8Wn6IWAly+mMG+iHgsOuLwFzx6wP+FD5LjU7/h9t7IHKXlGVPpRdLT3gcnW3NkzvexsAQFh104nr22lUEn55SWqj3yOTlu+zs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4478.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eWZjUFRqQXM5d3pGbnNiYjFjcFZaYTdROHZQYXJWYU1ROERYWFZpVWwwVUJV?=
 =?utf-8?B?ank3ZFlQUU5VamJuZWwzMEpVd1ZLUUhiSGRsUTRKazQrNnpseUdobGlHdWxk?=
 =?utf-8?B?VThxY3pMUjJKU3Nib3cwQUdKM1Y1T2J0UVdxck15YzU3MkhnN3huZ040Um9q?=
 =?utf-8?B?b2s4ZStTdGtVVXFsTFl0OWs5N3FFRkNkdW1pVEdhYWs4QS9NRlFUOTJWSjZ1?=
 =?utf-8?B?Ym5DK3E2OUJ3cXdabnhWSXAzWExEWmg0V2laS044M3U3V0xyTnpna2dsaWZa?=
 =?utf-8?B?Y0RMaUs1S05SOFEvQnVFT1gyckNRZWoxWmpwZXpDdk1QQmNJaFl3dlBCSjc2?=
 =?utf-8?B?MVh1R3JoR3BQUHFaVGpxMXlQd2t1TnFSWER6TXpZb3c0dHQ3SHgzTEVwWnVV?=
 =?utf-8?B?R2hlRDJKSGVzUGRTSVduWEVnTWZpZ1pCZW5lQVZMZ3A3eXNYWVBreXZRTVlP?=
 =?utf-8?B?SlI0blpaWENMcEFoOW40ck9DR2NjY3F5b1BudDhsR2pYWU1IdWNyM3oxZ2U1?=
 =?utf-8?B?aFI3V3EvQTJCTzVZSWwvNkQxUDFKYkx2TytPU2VpTEtnNDgwdVhEczl3Sk9v?=
 =?utf-8?B?WGFwREhaRVRWdFRyQ2lRQmZrNU9lMml0WDdkYXAzVE9CY0x6NG0yT3ZMbE1W?=
 =?utf-8?B?aWl5NWdoTTNzZ1dJbWVYL0d0QUZHSDB4a0VCcm5lTUF4WGhoYVNwY0ZTVzFr?=
 =?utf-8?B?c2x2NCszaFdQeGJTZEc3d2tJRDNzdFJPZU85dHNoSXBMdVVRZXI2enYxRXRa?=
 =?utf-8?B?Qm16YUdxcVI4MGhxdVVacFZmTTJtT3daU3Q4YzdOWTA0OXZ3MS9sYmFLa3Jp?=
 =?utf-8?B?ZlVBTmZRaUVudERwME5pblM5VjhkbkwyWlQ5TnZnUTRiY2hDNTk1Lzg2d3ho?=
 =?utf-8?B?R0NKVzRTNTBHN3AzcGMwemF3VE1lUDlOYmZYd0pwTG9PYUhIZXlJSDhNSkpn?=
 =?utf-8?B?cFBQdnBsWGYxUU1hNitTS01OSll3dkVtSlBpZmI3SzFTRDZPNFA4WEU0V0Jr?=
 =?utf-8?B?R1R3NjNCRGpEWlBPbFFBSzc2TWdIdFBKWmVGaHI5TG4zM3ZNRDhiVGxsUXUv?=
 =?utf-8?B?R0pxRGJTN3dMeTNJRXlRdmFvVjllek9tQXorSHdIeWpBaTRteVROZ2gwMU9a?=
 =?utf-8?B?eWZaQ1E5d3d1TGtZZmV5TDdwbWFBS1F5dWJZeHRBaU1DM3Y3dGFPT29jbW9k?=
 =?utf-8?B?ci9CMVA5V1czbXdUcUxGNmVScWNteG02ZlpETkphZG92VVUxM2lXUHR5eGdj?=
 =?utf-8?B?RWFMWGY5TVBJaHVLVmszUWJKVXJ3Mjg5TS9ud05FOThDZjVWR01aNy9zSWtM?=
 =?utf-8?B?c0doa0xRTDBvVGxZYTk1UEorU3NoWUxHN0JzaXR6WkNDODU1dlhwNXJya2tL?=
 =?utf-8?B?MUEzVlRNT2x4SkZZNlFLWGhpSGxVcWZiRm04S0ZzWGJMbXVyN3oxMlhEQ3di?=
 =?utf-8?B?T0RyTjV0RWF5ekhRN3lRWDJpVnBVR1ZST0oxKzJ3eENzTmhtTk1KRFpJTVo4?=
 =?utf-8?B?T1dEUGs1V0JESHZPQUhaMFJuUHU1YlhXTURwTFp2Mlp5RDUyRFhQays3dTZK?=
 =?utf-8?B?Q3NZZGxqaUpGK2g1M251Mk9hWEpnWjlJcHozL1BxcnpSdnA2L0lVQTR4MDRV?=
 =?utf-8?B?aXJlRXZ0MmNHYk8wcS9yeUdyeFJqS0E4djhKVHAvdU51SC9ESTN2VGxPNkpF?=
 =?utf-8?B?M0M0cWxmOHlBN0NEMEZtaSszcUMzdDBxd2xIcVBpdCs5MWxMTGhyVStZMUM3?=
 =?utf-8?B?eFFFZTh1aHdHbjFjVjVtbEpacVAzME5uSXdpVDhoRkgyemEvQnhzMlFieXQv?=
 =?utf-8?B?WnlyV0NSUTNCL0ZSaUpnTGRFYXZhTDRodmlKOTdyeHNDdEM0UThicFg2aFlM?=
 =?utf-8?B?ZkpTY0NUc0ZkMmdIczV3bDRzcmx3ZkZDMG5LczhQb29rb1BHdXhGeEE0NHpi?=
 =?utf-8?B?V01hZ1M1M2hCMlo5ZTNydGQzNlo4QUU4eU53RXk3SnpnblRKdUovQnE4d2Y1?=
 =?utf-8?B?VGREcUw2NEdPbDV0NWJzcWhYdXIvdVZWcURSc3NwRDNPV3NxVWNVRldWTURE?=
 =?utf-8?B?b2NxQWtzTW4ySk1OMTljZ3A4VVpGSkhjbUc2cHVRbXQxakZXYVFJbFdQN1NN?=
 =?utf-8?B?LzU4MVduZ29yN0thU3NneTVKTCt0cVh0TW1MYzlGb0ZRcVg5bHpoSlNZZFht?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A44C064EAE1894F9427C40B30E27DD2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aZm3NrN/Xs/E8hgghfwIVPWXHx83mf9a9+oYcTD7E5lNOdhvInD2x4uKNBK0LNMrV3y0D0AUpxbiJB5MTaznXvpPwZ+UuKzJL6Gmkf7a2OwhoD9kqk8skKwuBg9btg+sJuK6BcSjK3jteS5zfeT/ddwPbB6Zyv+uSGeiWp3F8QOQWoGemD52M72yM2AbgRCNS25DRfDHlgLGKHKFGXFB4xUISKEh80FXD1uG5ddsZU4+WLGd6+VHHTNTpbTDQrayUgXWwj0lEO7+6Ea7rkP9ngYN/sN5edeLgpuydMiX+t72t9EVAstPdEl3up4hwmXs4yo+5DXXH60bg4RiAcd5IWCKiun8ZfsA6kwBV+gGYHJhaIj6TloVYOV48j7lUcROf8gwVK/ENmh8iW/wzcMBekxb18v0D9emDZPioxU9rBEyOiOvy2LrFPDltm7MBn/R0P8LFatElkpwRN6s3XITH63HIgEqKb4+PY3QGFIGJo5bpr+/Y6jqZxEEQeeXzZN18Hpuw0g/BcuPsZ/O+U4qu/mj9TaK7G9wKhrwZ4p55enx6rSIr80eFwGnuxy2RBPR2nifpnntqIyKzI98D3r9+Q54RFq/89ZWCep4m8VoYFM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4478.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e306d9b1-9bc8-4cd8-5cb3-08dc4452a32e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 18:14:49.5475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /VMgEA0OVRJItsNcOsNpMkGvwPENkk5vHtotYRuOzWXVDPOrq6IQ+zDCBskefm8jmL0N5RcJr0578Mc0YzQjpcGSegYUB2Udx4CWiZJa9hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6477
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403140139
X-Proofpoint-GUID: Lml3PMEZ1lZLaDdo45naUCXeMiimZibn
X-Proofpoint-ORIG-GUID: Lml3PMEZ1lZLaDdo45naUCXeMiimZibn

DQo+IE9uIE1hciAxNCwgMjAyNCwgYXQgMTA6NTTigK9BTSwgRGF2ZSBIYW5zZW4gPGRhdmUuaGFu
c2VuQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAzLzE0LzI0IDEwOjI5LCBBcnVuYSBSYW1h
a3Jpc2huYSB3cm90ZToNCj4+IFRoaXMgcGF0Y2ggaXMgYSB3b3JrYXJvdW5kIGZvciBhIGJ1ZyB3
aGVyZSB0aGUgUEtSVSB2YWx1ZSBpcyBub3QNCj4+IHJlc3RvcmVkIHRvIHRoZSBpbml0IHZhbHVl
IGJlZm9yZSB0aGUgc2lnbmFsIGhhbmRsZXIgaXMgaW52b2tlZC4NCj4gDQo+IEkgZG9uJ3QgdGhp
bmsgd2Ugc2hvdWxkIHRvdWNoIHRoaXMgd2l0aCBhIHRlbiBmb290IHBvbGUgd2l0aG91dCBhIHRl
c3QNCj4gZm9yIGl0IGluIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21tL3Byb3RlY3Rpb25fa2V5
cy5jLg0KDQpJ4oCZbGwgYWRkIGEgdGVzdCBjYXNlIGhlcmUuDQoNCj4gDQo+IEknbSBub3Qgc3Vy
ZSB0aGlzIGlzIHdvcnRoIHRoZSB0cm91YmxlLiAgUHJvdGVjdGlvbiBrZXlzIGlzIG5vdCBhDQo+
IHNlY3VyaXR5IGZlYXR1cmUuICBUaGlzIGlzbid0IGEgcmVncmVzc2lvbi4gIEl0J3MgYmVlbiB0
aGUgYmVoYXZpb3INCj4gc2luY2UgZGF5IG9uZS4gIFRoaXMgcmVhbGx5IGlzIGEgZmVhdHVyZSBy
ZXF1ZXN0IGZvciBhIGJlaGF2aW9yYWwNCj4gaW1wcm92ZW1lbnQsIG5vdCBhIGJ1ZyBmaXguDQo+
IA0KPiBUaGUgbmVlZCBmb3IgdGhpcyBuZXcgZmVhdHVyZSBpcyBoaWdobHkgZGVwZW5kZW50IG9u
IHRoZSB0aHJlYXQgbW9kZWwNCj4gdGhhdCBpdCBzdXBwb3J0cy4gIEknbSBoaWdobHkgZHViaW91
cyB0aGF0IHRoZXJlJ3MgYSB0cnVlIG5lZWQgdG8NCj4gcHJvdGVjdCBhZ2FpbnN0IGFuIGF0dGFj
a2VyIHdpdGggYXJiaXRyYXJ5IHdyaXRlIGFjY2VzcyBpbiB0aGUgc2FtZQ0KPiBhZGRyZXNzIHNw
YWNlLiAgV2UgbmVlZCB0byBoYXZlIGEgbG90IG1vcmUgaW5mb3JtYXRpb24gdGhlcmUuDQoNCkkg
dGhvdWdodCB0aGUgUEtSVSB2YWx1ZSBiZWluZyByZXNldCBpbiB0aGUgc2lnbmFsIGhhbmRsZXIg
d2FzIHN1cHBvc2VkIHRvIGJlIHRoZSBkZWZhdWx0IGJlaGF2aW9yLiBJbiB3aGljaCBjYXNlLCB0
aGlzIGlzIGEgYnVnLg0KDQoiU2lnbmFsIEhhbmRsZXIgQmVoYXZpb3INCkVhY2ggdGltZSBhIHNp
Z25hbCBoYW5kbGVyIGlzIGludm9rZWQgKGluY2x1ZGluZyBuZXN0ZWQgc2lnbmFscyksDQp0aGUg
dGhyZWFkIGlzIHRlbXBvcmFyaWx5IGdpdmVuIGEgbmV3LCBkZWZhdWx0IHNldCBvZiBwcm90ZWN0
aW9uDQprZXkgcmlnaHRzIHRoYXQgb3ZlcnJpZGUgdGhlIHJpZ2h0cyBmcm9tIHRoZSBpbnRlcnJ1
cHRlZCBjb250ZXh0LuKAnQ0KDQooUmVmOiBodHRwczovL21hbjcub3JnL2xpbnV4L21hbi1wYWdl
cy9tYW43L3BrZXlzLjcuaHRtbCkNCg0KSSdtIG5vdCB2ZXJ5IGZhbWlsaWFyIHdpdGggcHJvdGVj
dGlvbiBrZXlzIChiZWZvcmUgSSBzdGFydGVkIGxvb2tpbmcgaW50byB0aGlzIGlzc3VlKSwgc28g
SSBhcG9sb2dpemUgZm9yIG1pc3VuZGVyc3RhbmRpbmcuDQoNCmZwdV9fY2xlYXJfdXNlcl9zdGF0
ZXMoKSBkb2VzIHJlc2V0IFBLUlUsIGJ1dCB0aGF0IGhhcHBlbnMgbXVjaCBsYXRlciBpbiB0aGUg
Zmxvdy4gQmVmb3JlIHRoYXQsIHRoZSBrZXJuZWwgdHJpZXMgdG8gc2F2ZSByZWdpc3RlcnMgb24g
dG8gdGhlIGFsdGVybmF0ZSBzaWduYWwgc3RhY2sgaW4gc2V0dXBfcnRfZnJhbWUoKSwgYW5kIHRo
YXQgZmFpbHMgaWYgdGhlIGFwcGxpY2F0aW9uIGhhcyBleHBsaWNpdGx5IGRpc2FibGVkIHBrZXkg
MCAoYW5kIHRoZSBhbHQgc3RhY2sgaXMgcHJvdGVjdGVkIGJ5IHBrZXkgMCkuIFRoaXMgcGF0Y2gg
YXR0ZW1wdHMgdG8gbW92ZSB0aGF0IHJlc2V0IGEgbGl0dGxlIGVhcmxpZXIgaW4gdGhlIGZsb3cs
IHNvIHRoYXQgc2V0dXBfcnRfZnJhbWUoKSBjYW4gc3VjY2VlZC4NCg0KPiANCj4gSSBoYXZlbid0
IGV2ZW4gbW9yZSB0aGFuIGdsYW5jZWQgYXQgdGhlIGNvZGUuICBJdCBsb29rcyBwcmV0dHkNCj4g
dW5zcGVha2FibHkgdWdseSBldmVuIGF0IGEgZ2xhbmNlLg0KDQpJIGFncmVlIHdpdGggeW91IC0g
bm8gYXJndW1lbnQgdGhlcmUuDQoNCkJ1dCBJ4oCZbSBub3Qgc3VyZSB0aGVyZSBpcyBhIOKAnGNs
ZWFu4oCdIHdheSB0byBkbyB0aGlzLiBJZiB0aGVyZSBpcywgSeKAmW0gaGFwcHkgdG8gcmVkbyB0
aGUgcGF0Y2guDQoNClRoYW5rcywNCkFydW5h

