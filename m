Return-Path: <linux-kernel+bounces-155344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22728AE92B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA74DB26127
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45041139582;
	Tue, 23 Apr 2024 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b="UehHM7sW";
	dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b="KpxAGmau"
Received: from mx0b-0068d901.pphosted.com (mx0b-0068d901.pphosted.com [205.220.180.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC62613AA36;
	Tue, 23 Apr 2024 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.180.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881367; cv=fail; b=Mw+ZUmmrdFYbDAGEMutuGt49P3Wlcgvhtm//BwfdOGgprtPdJ2inZFMKfQlA1cND4w7/yO6M14+8O74B9OSKBJ9EBm2dc5T2eSQZixSeqJAP/2YLwT+RZLhv9Tao+A96tc91cSVLqR8Mc64q2PWXb1Ve4WUwZQi4H6+ELBlHoCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881367; c=relaxed/simple;
	bh=lT08faEU1pVJb/OL0xptd2pAyNkNwPK4UGbhPvzyq7E=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nc9s4OV9RKLRLg2rvgYsHiwa7PwTUsN/ILhY37TMb+MU4abAqEqbNr1aMD+8Opou/+KFuk1m5RAXlr4l/Zn9qJFkxM4fB85P1BEnIKv0+PgW5h0sHJYSjKPa78NyC0DygjPszJLiGZK2y1/2Yr10IdVXFmouJuTKXh+Fpv+qB1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=biamp.com; spf=pass smtp.mailfrom=biamp.com; dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b=UehHM7sW; dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b=KpxAGmau; arc=fail smtp.client-ip=205.220.180.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=biamp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=biamp.com
Received: from pps.filterd (m0278265.ppops.net [127.0.0.1])
	by mx0b-0068d901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NAP1Tl018143;
	Tue, 23 Apr 2024 07:09:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com; h=
	from:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=proofpoint; bh=NQrGSb
	MA9RUPuqGbUVb8CT1KVSZDtPX3Hbw+ju4fmig=; b=UehHM7sWt6s62+hLRmSIAG
	fczROXftzluqIcsikZhRsLdaFcaSIUxrpgma/unoiDYqRq5Kl0DR6Wi8xUii8Ce8
	BQbyjI49PyJYN5WABfgr1++VoTzuqlq6FbT02Xu4IZmecjzlHVNmzHRwjuAe3oyS
	zTpYG8OugXIcJ7vyqpMJPeSqHzyvbygkHk0nxplPXR4zpDmwfavOJeqCBfdQRjfz
	qXfAjbWcynIcW16uZNTwU00hRM/TPgCOUopkBHVqJWwrI6K3T7Ge4vzyc4sUQBYB
	Z6oXEt6Gb/z8IME8SciTs9itJwN3UtLPpfh5OxHmAly3Bv0sRCImeIUvRsFF85Xg
	==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0b-0068d901.pphosted.com (PPS) with ESMTPS id 3xmadvj0ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 07:09:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6adfJ/m8LkXi3ElsWkDsXwz3PL+oPL0c2AcFje1o6gHUiCwdQmFfJoV2ZHFrPzvCBk20swRdIMbYGepyk64DbAd6u3YKE/XeQ7J8TqrQ1bgnB8tzlqQ+Y1s4O3Iy82hgtQ/8hp+ZIcFujZYfrntldbPuAgzYo5ygWSC6YhGiP1EkfPBLcG24WLpE0R0ZM0eMqkudOd65n5hLlbxuZlEimMOGlC48ifh6y0cqQZp13deY8xU/wuWnx9DLG/+VnGLL+5RYiKDi73y9oUGs/D9s0tGRmWoLH2QnwBgklbmGJ49+vUyKm7EZiXvKlAtjWapFdpNz0aL9Tjn4IM1C2xBpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQrGSbMA9RUPuqGbUVb8CT1KVSZDtPX3Hbw+ju4fmig=;
 b=ISd8VwZ5VYpFx784ll7sAwOssY01JPecIPzZoJ1bJ0wUR7KYI3Yw2ji89JJoV+P1W10twFraRqT/q+rBty7gF9sZ68iJ5q57R5AHui4JpyavPOxgYnI5kEVdAFL4Eprp1jBIAr63p0S/jl0phlkglZP4RxTMWJRlA+RS94yHxVM5fGpPT1sJWLrx+sEvzYWTzwQpaUQVRXelfPV/n8ctPrEeB1mmcIQ96Fa5Hfc5UAPtMcsbu7k8qUnfLJXvpuL/QrHcqrtWvRWV11q+usG5iy+g17WnQHXcfVGcpEuhWDrwxGUFguOXPO04pwlvlESKvQtdp21O/DaVmNC5pybbog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQrGSbMA9RUPuqGbUVb8CT1KVSZDtPX3Hbw+ju4fmig=;
 b=KpxAGmauWJyfoCYa2ZbR2PCClzn3rtPgotufL9j18zRlHQrQKmfmPQ0cQuMzUBG5uHvDYXyHq95/3kWjzBbLFRPvEt0rycsQGSkE8tYtDSNNl/ex9MqBpWmlx+utCZ2k79+4wl1tqwNJ18OO/JoqvKQ074cB2tI4mrYXNBsGvKHQQQbE6a/ykxeCuRRk9bir2/38gNOvTxG3K1AystXm2+X25VQotFDxI/vkkQJIqlGSfXSN21pQ1bwV1OtCiZAx2kN6MjXe2/SG/Z8nBskw+rPUfVIzjDc8iqFtPuoUmiORv18J2kUxybOESTERszBaAgRUbnypo3aAufiqsWT1gg==
Received: from CO1PR17MB5419.namprd17.prod.outlook.com (2603:10b6:303:ec::17)
 by CO6PR17MB4945.namprd17.prod.outlook.com (2603:10b6:5:35a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 14:09:04 +0000
Received: from CO1PR17MB5419.namprd17.prod.outlook.com
 ([fe80::f48:ee61:a81b:d555]) by CO1PR17MB5419.namprd17.prod.outlook.com
 ([fe80::f48:ee61:a81b:d555%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 14:09:04 +0000
From: Chris Wulff <Chris.Wulff@biamp.com>
To: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Perr Zhang
	<perr@usb7.net>, Lee Jones <lee@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>,
        Chris Wulff <chris.wulff@biamp.com>
Subject: [PATCH v2] usb: gadget: f_uac1: Expose all string descriptors through
 configfs.
Thread-Topic: [PATCH v2] usb: gadget: f_uac1: Expose all string descriptors
 through configfs.
Thread-Index: AQHalYZyQqE3aI5pnkG1tqR3dQtakQ==
Date: Tue, 23 Apr 2024 14:09:04 +0000
Message-ID: 
 <CO1PR17MB541911B0C80D21E4B575E48CE1112@CO1PR17MB5419.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR17MB5419:EE_|CO6PR17MB4945:EE_
x-ms-office365-filtering-correlation-id: 9d1d1696-c3a2-4586-1c56-08dc639eef0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?GTsQmalXBs13moCB9+mCkEyS85+MutSFsjHMwgdR3nLKqrtc2BawwOGLTc?=
 =?iso-8859-1?Q?tJtnfRVeFHok6USgjo15p8XczYwS/GVuPrRlFk+fFfZVRqYO2MRwO1qpVV?=
 =?iso-8859-1?Q?liOLK6juIcBDbY+4EqdU48P2dW44drKxfk1c2thEj3HKiBpCimsMeo8IPT?=
 =?iso-8859-1?Q?SIsGnL0yMPDFekw1Mj4WUGF+tcOLk0JN4+wfkxr+LLHt2ZdmNsoip5HSxq?=
 =?iso-8859-1?Q?Jt/mdAntz97hjce97pC3KzhYnE7OgZsSqJIizk0HmNP/aND5WrejzVVs9m?=
 =?iso-8859-1?Q?2rVliH3YXQ4WxUeSlwmdDWOm/tn/eiENnMw7I1mBVz0ZfK8xhS+J8l48C4?=
 =?iso-8859-1?Q?G+9FVibgJbfB4wo2cfdNuC5VCMbMDELb17ihfWdBXo7YtzwF2VeI36c1QA?=
 =?iso-8859-1?Q?PfWgvpQer53VmSH3TAWdh63jqOX0RntpJILrZ/sbx+l2tlqHAXvzVKHRlY?=
 =?iso-8859-1?Q?o98DTrXow0wgaekLzk2CXLezmnN+m5vVbs3EccOj71tuF5ZdTZWEJydwHD?=
 =?iso-8859-1?Q?3So7jtONTxT/yv1qRtlmCafKDUNeSx2bBjx5QSqZ2JqMAavImk88tkcsKH?=
 =?iso-8859-1?Q?fCVDvw3xFDmcej2vKP/9ubdKuSWE7sw+jVUOeikmXcu8pZvaRtTWgQKUPr?=
 =?iso-8859-1?Q?pgoXFozc71CUAuOPBzNgJEtwIl1l+1bJ7URBMM3LcRPTkKrIbRjukVOAEw?=
 =?iso-8859-1?Q?VaQU7OPtmAUwSe5Lk8LOUolFymcs4g7QnJvqvL3oZmFMYe/FdmyDXKXr3h?=
 =?iso-8859-1?Q?znUu/tID/DERLMv+2KiAY+OloAtoCTnkZKRXgBCqlsai0tV6feppDWWD9E?=
 =?iso-8859-1?Q?DLK1ALkEQ8Zq1qXTCZC9V/e+mZFQuqsxCM+IOf2AJVTT815Nm6oSMyOqmC?=
 =?iso-8859-1?Q?tstRsll0a4PT744MEPHoNHmACHNv3onitzdMxYw+IQzi/Tw9xMafx0bZ8y?=
 =?iso-8859-1?Q?z2H3h+Qno/QkpQQjVWWtBIaWWHbKlVKOhw58sBOQIyrTPhpzll6KkP+42s?=
 =?iso-8859-1?Q?72uaGsr7+m9acFNs6j/cslG5yqx/OPSV18lBIlB3WaBElBURV09lqJMlbR?=
 =?iso-8859-1?Q?66zjMACmL06Mwwlje+naD0WgQqfknMqjkLbrC+E+DJ3uxwhE312rBmQzlS?=
 =?iso-8859-1?Q?Cr4YzwiWjIQhK9NiS17CEmgjJYJlxkKIBn8dl6uttwD/9Sxy9I+ChifyN5?=
 =?iso-8859-1?Q?zV8nybl/UcG7NFbxhak0qYt6zpk0/V+AwX5HJp1XOtbHCxi5Ck3NvCRcXL?=
 =?iso-8859-1?Q?S9ep4fxwytbfEG0HUg1Zlk4j20Y4f72XSGdLBEuolcHTghRkfxOe9Ou/kB?=
 =?iso-8859-1?Q?02f9ppzcUFXEu40RyMgcHJY1oZNejxOucRDBjszZv3jEuWyUmd8sZ+kUf/?=
 =?iso-8859-1?Q?IUUEu6PQXVQB37QKpcTyI8fmoKo/k3sA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR17MB5419.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?h2aRjOXWXfHSOfKG4AA0If0S4vasg2iJj8lujkseXLBootcgzhIupsxJ4l?=
 =?iso-8859-1?Q?545e8ZU7Wk9moa5GwM7716XQq+SLiRP7sZZ++twSg6ywBPO3ybUiaZrXjV?=
 =?iso-8859-1?Q?3CJYfiDT6BvpRoIdESEp1IjOgoIqk6w+/4mRIj4eA2Lme1uuMQ7Xjj3i0m?=
 =?iso-8859-1?Q?FM1wh24JJedYu1/WmrpaoP7FxicmCZcgXo7Eptwm62R6n+uYHV7VXaKoVE?=
 =?iso-8859-1?Q?sgtb9BTB8KNfXc+jW10E3ybiBpKOafaJfovTAqImyaQwVcFq4qn5BNC35Z?=
 =?iso-8859-1?Q?jWk1isUYUkUB9zgGUmJ6wKDtBUfoWwO3Pf3PKga8b+0lTp+M1hIwfxjzWI?=
 =?iso-8859-1?Q?FxMY/+/n2vn/bQ7Y0DIFRBLtBntYrAzOMH+9z6G8yxT7PXQVKeeDPKGJyY?=
 =?iso-8859-1?Q?c4dvADcE9oiP629/rDRiKkT5pXmVJG9/BsdhiwUs8oa1cXvXiU7LReug4R?=
 =?iso-8859-1?Q?MlxoTb8qhCy6S3/uorfahPkLNz1b7hjT14nCKZF66qiBIDJcOOn1v+0IqN?=
 =?iso-8859-1?Q?2HZYUzH7yNzEu38aZuMhK38PUMZ7gItfiabEiFV3FdNOoQ5NFjkavPw5fb?=
 =?iso-8859-1?Q?BEpEghogmRdORl0BPQDCNyKFTQDJ11sV9qH6tYnF5P0wMsBJN8Ji1ODO/e?=
 =?iso-8859-1?Q?QINNoLRaxTWPqUKBcMn27h5NXMxwLTSeR9aLZceuLfZz4Uq9142e4z6yHP?=
 =?iso-8859-1?Q?veIu4KyXP8vEuOiQDZ9/0hu83h19eS4ObigA/6Whl0rXvixq1PO+WzQgI0?=
 =?iso-8859-1?Q?0zTzE6si8DloF7quX+6q8PUWZJNOA8jj6Q5Ea3+F+37thDEMHbUBGpUUcH?=
 =?iso-8859-1?Q?VtejayThRMSWjwUSi6BipUd1HtHMtXvpBlwKq4ScDCnhfMnaEj8XQ6+N5C?=
 =?iso-8859-1?Q?ncGkvArF5v8aSGdMkAiwCxJKfYiyYNaVIxpdxEYmIDeBfGrEt7FLSWHTKt?=
 =?iso-8859-1?Q?vFyjigb+8ECagEQd+NOzr+QSTBMly2mmmZEPY0twaHkcZL1bmx478javOo?=
 =?iso-8859-1?Q?Ly5ShWLfw+YGcuxMNybasOZk4PkQ0Q0cb2VXsOmWQmXXwKfkdsZmR9Znoo?=
 =?iso-8859-1?Q?ToCtYCOxv9Vqs84qwd5FPP+ehwK8ud4OWmTCwbe41X6l1ss3v+c+h45SV3?=
 =?iso-8859-1?Q?FYxd4L5hzo9DX4w37FbF4CybNa016h/maKYvZ3njXgX3qow+Jy5q6by6XU?=
 =?iso-8859-1?Q?Nqrk/kkzFRhm30PflqRdBi7mQ+5lgXvEBP0iXBmTFac/5KjPLfiaDuNNzj?=
 =?iso-8859-1?Q?DzNO8MDuMB1TsGTvguWkvAP7P/GCEYnfUMwPmymSG+KV4C0RK6SlZBrj1g?=
 =?iso-8859-1?Q?/Ppn5kF1Xa4TONZG18HgpMn8EbuKY3DcbuIaFxryT4g3bC8DCfC9mWbD4T?=
 =?iso-8859-1?Q?nXw77PKYYmLJUy0GqygsbzwpWiCEb0X1lIsYQvdy7E3EgqisvNO6YakLb+?=
 =?iso-8859-1?Q?X7oUq3/pNsp04wQ1IFl/ubM/46s17cjhIB7dnW7Z15mXo9LPTI7IfwMQC+?=
 =?iso-8859-1?Q?96isYTttOAo7DRXcYDAK61oksvFzMxV1C6wxVodDx2oxspg1RMLctIb+HA?=
 =?iso-8859-1?Q?0J4v5ATSIqH6w7wqkoCb8TgBuYYOsrxFZb+IzyfU1Uee5O064abCKgzWV3?=
 =?iso-8859-1?Q?AOcnflpYSv+Q0I18xDNtx3mnUiXPm/WCcS?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: biamp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR17MB5419.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1d1696-c3a2-4586-1c56-08dc639eef0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 14:09:04.5927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4JGpO/AKVvD1nRV+WvbyaK26y2J1srjUZ8fOlmzvcpWbNzCwUweSCFikblMDb3Zh3l+8Ma5PPbRQzOUfPTo9mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR17MB4945
X-Proofpoint-GUID: cAl9Qxof-MytdD6K0dddTJA2by58X8Oa
X-Proofpoint-ORIG-GUID: cAl9Qxof-MytdD6K0dddTJA2by58X8Oa

This makes all string descriptors configurable for the UAC1 gadget=0A=
so the user can configure names of terminals/controls/alt modes.=0A=
=0A=
Signed-off-by: Chris Wulff <chris.wulff@biamp.com>=0A=
---=0A=
v2: Improved naming of parameters to be mode user friendly. Added documenta=
tion.=0A=
v1: https://lore.kernel.org/linux-usb/CO1PR17MB54198F836C3ED1B4FA5F14A9E10D=
2@CO1PR17MB5419.namprd17.prod.outlook.com/=0A=
 =0A=
 .../ABI/testing/configfs-usb-gadget-uac1      | 12 +++=0A=
 Documentation/usb/gadget-testing.rst          | 12 +++=0A=
 drivers/usb/gadget/function/f_uac1.c          | 75 +++++++++++++++----=0A=
 drivers/usb/gadget/function/u_uac1.h          | 16 +++-=0A=
 4 files changed, 98 insertions(+), 17 deletions(-)=0A=
=0A=
diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uac1 b/Documenta=
tion/ABI/testing/configfs-usb-gadget-uac1=0A=
index c4ba92f004c3..cf93b98b274d 100644=0A=
--- a/Documentation/ABI/testing/configfs-usb-gadget-uac1=0A=
+++ b/Documentation/ABI/testing/configfs-usb-gadget-uac1=0A=
@@ -30,4 +30,16 @@ Description:=0A=
 		req_number		the number of pre-allocated requests=0A=
 					for both capture and playback=0A=
 		function_name		name of the interface=0A=
+		p_it_name		playback input terminal name=0A=
+		p_it_ch_name		playback channels name=0A=
+		p_ot_name		playback output terminal name=0A=
+		p_fu_name		playback functional unit name=0A=
+		p_alt0_name		playback alt mode 0 name=0A=
+		p_alt1_name		playback alt mode 1 name=0A=
+		c_it_name		capture input terminal name=0A=
+		c_it_ch_name		capture channels name=0A=
+		c_ot_name		capture output terminal name=0A=
+		c_fu_name		capture functional unit name=0A=
+		c_alt0_name		capture alt mode 0 name=0A=
+		c_alt1_name		capture alt mode 1 name=0A=
 		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadge=
t-testing.rst=0A=
index b086c7ab72f0..a89b49e639c3 100644=0A=
--- a/Documentation/usb/gadget-testing.rst=0A=
+++ b/Documentation/usb/gadget-testing.rst=0A=
@@ -957,6 +957,18 @@ The uac1 function provides these attributes in its fun=
ction directory:=0A=
 	req_number       the number of pre-allocated requests for both capture=0A=
 	                 and playback=0A=
 	function_name    name of the interface=0A=
+	p_it_name        playback input terminal name=0A=
+	p_it_ch_name     playback channels name=0A=
+	p_ot_name        playback output terminal name=0A=
+	p_fu_name        playback functional unit name=0A=
+	p_alt0_name      playback alt mode 0 name=0A=
+	p_alt1_name      playback alt mode 1 name=0A=
+	c_it_name        capture input terminal name=0A=
+	c_it_ch_name     capture channels name=0A=
+	c_ot_name        capture output terminal name=0A=
+	c_fu_name        capture functional unit name=0A=
+	c_alt0_name      capture alt mode 0 name=0A=
+	c_alt1_name      capture alt mode 1 name=0A=
 	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
 =0A=
 The attributes have sane default values.=0A=
diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/func=
tion/f_uac1.c=0A=
index 7de74a3dd392..f7dd6a2466b0 100644=0A=
--- a/drivers/usb/gadget/function/f_uac1.c=0A=
+++ b/drivers/usb/gadget/function/f_uac1.c=0A=
@@ -377,24 +377,10 @@ enum {=0A=
 	STR_AS_OUT_IF_ALT1,=0A=
 	STR_AS_IN_IF_ALT0,=0A=
 	STR_AS_IN_IF_ALT1,=0A=
+	NUM_STR_DESCRIPTORS,=0A=
 };=0A=
 =0A=
-static struct usb_string strings_uac1[] =3D {=0A=
-	/* [STR_AC_IF].s =3D DYNAMIC, */=0A=
-	[STR_USB_OUT_IT].s =3D "Playback Input terminal",=0A=
-	[STR_USB_OUT_IT_CH_NAMES].s =3D "Playback Channels",=0A=
-	[STR_IO_OUT_OT].s =3D "Playback Output terminal",=0A=
-	[STR_IO_IN_IT].s =3D "Capture Input terminal",=0A=
-	[STR_IO_IN_IT_CH_NAMES].s =3D "Capture Channels",=0A=
-	[STR_USB_IN_OT].s =3D "Capture Output terminal",=0A=
-	[STR_FU_IN].s =3D "Capture Volume",=0A=
-	[STR_FU_OUT].s =3D "Playback Volume",=0A=
-	[STR_AS_OUT_IF_ALT0].s =3D "Playback Inactive",=0A=
-	[STR_AS_OUT_IF_ALT1].s =3D "Playback Active",=0A=
-	[STR_AS_IN_IF_ALT0].s =3D "Capture Inactive",=0A=
-	[STR_AS_IN_IF_ALT1].s =3D "Capture Active",=0A=
-	{ },=0A=
-};=0A=
+static struct usb_string strings_uac1[NUM_STR_DESCRIPTORS + 1] =3D {};=0A=
 =0A=
 static struct usb_gadget_strings str_uac1 =3D {=0A=
 	.language =3D 0x0409,	/* en-us */=0A=
@@ -1265,6 +1251,20 @@ static int f_audio_bind(struct usb_configuration *c,=
 struct usb_function *f)=0A=
 =0A=
 	strings_uac1[STR_AC_IF].s =3D audio_opts->function_name;=0A=
 =0A=
+	strings_uac1[STR_USB_OUT_IT].s =3D audio_opts->p_it_name;=0A=
+	strings_uac1[STR_USB_OUT_IT_CH_NAMES].s =3D audio_opts->p_it_ch_name;=0A=
+	strings_uac1[STR_IO_OUT_OT].s =3D audio_opts->p_ot_name;=0A=
+	strings_uac1[STR_FU_OUT].s =3D audio_opts->p_fu_name;=0A=
+	strings_uac1[STR_AS_OUT_IF_ALT0].s =3D audio_opts->p_alt0_name;=0A=
+	strings_uac1[STR_AS_OUT_IF_ALT1].s =3D audio_opts->p_alt1_name;=0A=
+=0A=
+	strings_uac1[STR_IO_IN_IT].s =3D audio_opts->c_it_name;=0A=
+	strings_uac1[STR_IO_IN_IT_CH_NAMES].s =3D audio_opts->c_it_ch_name;=0A=
+	strings_uac1[STR_USB_IN_OT].s =3D audio_opts->c_ot_name;=0A=
+	strings_uac1[STR_FU_IN].s =3D audio_opts->c_fu_name;=0A=
+	strings_uac1[STR_AS_IN_IF_ALT0].s =3D audio_opts->c_alt0_name;=0A=
+	strings_uac1[STR_AS_IN_IF_ALT1].s =3D audio_opts->c_alt1_name;=0A=
+=0A=
 	us =3D usb_gstrings_attach(cdev, uac1_strings, ARRAY_SIZE(strings_uac1));=
=0A=
 	if (IS_ERR(us))=0A=
 		return PTR_ERR(us);=0A=
@@ -1681,8 +1681,23 @@ UAC1_ATTRIBUTE(bool, c_volume_present);=0A=
 UAC1_ATTRIBUTE(s16, c_volume_min);=0A=
 UAC1_ATTRIBUTE(s16, c_volume_max);=0A=
 UAC1_ATTRIBUTE(s16, c_volume_res);=0A=
+=0A=
 UAC1_ATTRIBUTE_STRING(function_name);=0A=
 =0A=
+UAC1_ATTRIBUTE_STRING(p_it_name);=0A=
+UAC1_ATTRIBUTE_STRING(p_it_ch_name);=0A=
+UAC1_ATTRIBUTE_STRING(p_ot_name);=0A=
+UAC1_ATTRIBUTE_STRING(p_fu_name);=0A=
+UAC1_ATTRIBUTE_STRING(p_alt0_name);=0A=
+UAC1_ATTRIBUTE_STRING(p_alt1_name);=0A=
+=0A=
+UAC1_ATTRIBUTE_STRING(c_it_name);=0A=
+UAC1_ATTRIBUTE_STRING(c_it_ch_name);=0A=
+UAC1_ATTRIBUTE_STRING(c_ot_name);=0A=
+UAC1_ATTRIBUTE_STRING(c_fu_name);=0A=
+UAC1_ATTRIBUTE_STRING(c_alt0_name);=0A=
+UAC1_ATTRIBUTE_STRING(c_alt1_name);=0A=
+=0A=
 static struct configfs_attribute *f_uac1_attrs[] =3D {=0A=
 	&f_uac1_opts_attr_c_chmask,=0A=
 	&f_uac1_opts_attr_c_srate,=0A=
@@ -1706,6 +1721,20 @@ static struct configfs_attribute *f_uac1_attrs[] =3D=
 {=0A=
 =0A=
 	&f_uac1_opts_attr_function_name,=0A=
 =0A=
+	&f_uac1_opts_attr_p_it_name,=0A=
+	&f_uac1_opts_attr_p_it_ch_name,=0A=
+	&f_uac1_opts_attr_p_ot_name,=0A=
+	&f_uac1_opts_attr_p_fu_name,=0A=
+	&f_uac1_opts_attr_p_alt0_name,=0A=
+	&f_uac1_opts_attr_p_alt1_name,=0A=
+=0A=
+	&f_uac1_opts_attr_c_it_name,=0A=
+	&f_uac1_opts_attr_c_it_ch_name,=0A=
+	&f_uac1_opts_attr_c_ot_name,=0A=
+	&f_uac1_opts_attr_c_fu_name,=0A=
+	&f_uac1_opts_attr_c_alt0_name,=0A=
+	&f_uac1_opts_attr_c_alt1_name,=0A=
+=0A=
 	NULL,=0A=
 };=0A=
 =0A=
@@ -1760,6 +1789,20 @@ static struct usb_function_instance *f_audio_alloc_i=
nst(void)=0A=
 =0A=
 	scnprintf(opts->function_name, sizeof(opts->function_name), "AC Interface=
");=0A=
 =0A=
+	scnprintf(opts->p_it_name, sizeof(opts->p_it_name), "Playback Input termi=
nal");=0A=
+	scnprintf(opts->p_it_ch_name, sizeof(opts->p_it_ch_name), "Playback Chann=
els");=0A=
+	scnprintf(opts->p_ot_name, sizeof(opts->p_ot_name), "Playback Output term=
inal");=0A=
+	scnprintf(opts->p_fu_name, sizeof(opts->p_fu_name), "Playback Volume");=
=0A=
+	scnprintf(opts->p_alt0_name, sizeof(opts->p_alt0_name), "Playback Inactiv=
e");=0A=
+	scnprintf(opts->p_alt1_name, sizeof(opts->p_alt1_name), "Playback Active"=
);=0A=
+=0A=
+	scnprintf(opts->c_it_name, sizeof(opts->c_it_name), "Capture Input termin=
al");=0A=
+	scnprintf(opts->c_it_ch_name, sizeof(opts->c_it_ch_name), "Capture Channe=
ls");=0A=
+	scnprintf(opts->c_ot_name, sizeof(opts->c_ot_name), "Capture Output termi=
nal");=0A=
+	scnprintf(opts->c_fu_name, sizeof(opts->c_fu_name), "Capture Volume");=0A=
+	scnprintf(opts->c_alt0_name, sizeof(opts->c_alt0_name), "Capture Inactive=
");=0A=
+	scnprintf(opts->c_alt1_name, sizeof(opts->c_alt1_name), "Capture Active")=
;=0A=
+=0A=
 	return &opts->func_inst;=0A=
 }=0A=
 =0A=
diff --git a/drivers/usb/gadget/function/u_uac1.h b/drivers/usb/gadget/func=
tion/u_uac1.h=0A=
index f7a616760e31..67784de9782b 100644=0A=
--- a/drivers/usb/gadget/function/u_uac1.h=0A=
+++ b/drivers/usb/gadget/function/u_uac1.h=0A=
@@ -52,7 +52,21 @@ struct f_uac1_opts {=0A=
 	int				req_number;=0A=
 	unsigned			bound:1;=0A=
 =0A=
-	char			function_name[32];=0A=
+	char			function_name[USB_MAX_STRING_LEN];=0A=
+=0A=
+	char			p_it_name[USB_MAX_STRING_LEN];=0A=
+	char			p_it_ch_name[USB_MAX_STRING_LEN];=0A=
+	char			p_ot_name[USB_MAX_STRING_LEN];=0A=
+	char			p_fu_name[USB_MAX_STRING_LEN];=0A=
+	char			p_alt0_name[USB_MAX_STRING_LEN];=0A=
+	char			p_alt1_name[USB_MAX_STRING_LEN];=0A=
+=0A=
+	char			c_it_name[USB_MAX_STRING_LEN];=0A=
+	char			c_it_ch_name[USB_MAX_STRING_LEN];=0A=
+	char			c_ot_name[USB_MAX_STRING_LEN];=0A=
+	char			c_fu_name[USB_MAX_STRING_LEN];=0A=
+	char			c_alt0_name[USB_MAX_STRING_LEN];=0A=
+	char			c_alt1_name[USB_MAX_STRING_LEN];=0A=
 =0A=
 	struct mutex			lock;=0A=
 	int				refcnt;=0A=
-- =0A=
2.34.1=0A=
=0A=

