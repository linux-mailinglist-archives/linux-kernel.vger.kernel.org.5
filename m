Return-Path: <linux-kernel+bounces-92690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE18E872464
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69D891F25CC3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AEF944E;
	Tue,  5 Mar 2024 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="olxVbnHB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OctZV/fi"
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F79B8BF6;
	Tue,  5 Mar 2024 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709656441; cv=fail; b=Ko0i8OsmvmNtpU+hYKQaaXaszsRcO42Vs/DYd4GJL8eNEidkqK20TBnvbOB7wRUMPZpxpoyvcGQcTHlWm5v3BH0AdZfKPPCQ7HdF+fsokrmQurH7xh4QSyXGS5zgF9tCtObrsMwJXv6d5fh7DlBeEY0Bxpd0Olq4ysbo8sqiBPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709656441; c=relaxed/simple;
	bh=4Ox9hoR+7wHztkEh2IIp2kd3mkg0SpSiv8Vqyp5pf4E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B7+yuMx44F8gO0/ANf3Y59xPxosxBDh0elIg0xmn6NvUsr3s7Wjd38MuiWnk2EvSNlFloGraY+OCtVbcUqNzjjITPriD/ReBLF06Xfztcizb/3Q6rMaldg5NksjbfBCd4T0ULuP/IA+XMcX8pnXaDVFIywx5qs4/CZnR/wRyQ+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=olxVbnHB; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=OctZV/fi; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709656439; x=1741192439;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4Ox9hoR+7wHztkEh2IIp2kd3mkg0SpSiv8Vqyp5pf4E=;
  b=olxVbnHBLGtYoYhJV6FBJ8Rk71MwbFmsnBMdynWWPax7nqBuaivW+KHZ
   JYihOMg5hVeFCtBrZgqVYojKg2h39NID33YABpTNj6/+EFX4ETBO+QmW/
   Ss123M7+YZsTKkSijUC/eQZJpeomnpwdEb6n2laFg3GrCEheaoaFW9xin
   h8w2nK8NaU67pfXVkTNQW3S9DGKNBODq06Ilw4eGgHOpgqgTuY8SHmTLR
   Ghxk4cPfjAzjRbLujvEF32BwVfb6d3/MhtHc/Dx/ry6T4d1KoI9K/Ss63
   u2I6lN4ucDIzFD08P9q0/lzqNRqqH2PXdEPxK2MmVShUPZaHOA9i79nEf
   w==;
X-CSE-ConnectionGUID: 83xw4oW9RTWAV6++m0MI6g==
X-CSE-MsgGUID: lKP748liSc+nNOQgkXYGwg==
X-IronPort-AV: E=Sophos;i="6.06,205,1705334400"; 
   d="scan'208";a="10836317"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2024 00:33:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQ/7fe62/B04v2gP3OsZxU1vgwr1q0bJdsrA50QGzB1uFnI3HqxggxvbSMe0I8UTsZzumfzTuJARj8+ktu/3YspYIwh6u/UUT3BlBaMmtqI0uNkBfBKSZzDuJrZkfEsCn9SNWqHR9L4tCs9VOIeAEXupODSwNQPOnGN8y2lrAry2Zk3wfAr42w4onxMaII8Jo/Sf8u1CkUhvvfEbKPYvjbQtiAozn+5Q+T8eRS0z2tY88t79pAmTxFPy0KLrQen4vHnDn+DB/1YF+d1kNeqDGoxQlcEVf/Xu9jy99T/n0Z1sx9bkjWfiHqwjE/b5VoajP0zK/h7W0aawjQ4++QkFIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ox9hoR+7wHztkEh2IIp2kd3mkg0SpSiv8Vqyp5pf4E=;
 b=ldrjX4K16x7bHXo2U3hdPr/buBY3ACnDFcTPoBmxMVDvJkZAvr29jxypGETAWkEmXVcml4iTfVOVaaKwEvXhAv3hkwWG4bRPFk5HlxD5Ct/9+Eu4xzgoftL5oSSMaADEuDwk3XY9QYDaMkGGhdlPcdY6Z1Jvr9VI1mD9HUUvUd5pFkfHHzh5wV4t6eAC19THTeQWvBjHT3QeL7Nx8GW6HjanY2DXwjFRdtD9w7ikXmKp1zcWR2P01EVt3/+W25e9VQF6XY6zkUY6LXAY2iMdclVOQZW5XajWETl1/SisEbpPqR7NYGVrv5i0SDkczAYz2zKwo+1GqKZ89Nx0Ng930g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ox9hoR+7wHztkEh2IIp2kd3mkg0SpSiv8Vqyp5pf4E=;
 b=OctZV/fiUPbqvtGSEv8oaPmFCDdyUMnh4RB7GmB03DUDlZAANmPcHIU1k4v0tnolkUGVqxwdNfTlou4GsRo0KX13zhy1kosKXFYDeT2CQW38q/09d/qDLeUcOZkUOIw5DgqS8No8e8LJYbgSn8kvw4LyMloPV8xuNPEKOY1plWU=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BY5PR04MB6392.namprd04.prod.outlook.com (2603:10b6:a03:1ed::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 16:33:48 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 16:33:48 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Linus Walleij <linus.walleij@linaro.org>, Jens Wiklander
	<jens.wiklander@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, Shyam
 Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg
	<sumit.garg@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart
 Van Assche <bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, Ard
 Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler
	<tomas.winkler@intel.com>, =?utf-8?B?QWxleCBCZW5uw6ll?=
	<alex.bennee@linaro.org>
Subject: RE: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Thread-Topic: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Thread-Index: AQHabvgRHYnDBx+cqkmeMEfcmLAlb7EpVJaQ
Date: Tue, 5 Mar 2024 16:33:48 +0000
Message-ID:
 <DM6PR04MB65759DF9CAF6ECB5BA78E138FC222@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240227153132.2611499-1-jens.wiklander@linaro.org>
 <20240227153132.2611499-2-jens.wiklander@linaro.org>
 <CACRpkdZBWBio8kvKuVzj2CknCb4eS=VB2EqUsAK-vf4e328icg@mail.gmail.com>
In-Reply-To:
 <CACRpkdZBWBio8kvKuVzj2CknCb4eS=VB2EqUsAK-vf4e328icg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BY5PR04MB6392:EE_
x-ms-office365-filtering-correlation-id: 98b1b010-149f-4838-e085-08dc3d3208ed
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /J3Ikz4305G1OQIoLIUexCs6UO8K38pt1sm1WteadKM1VRVW79hGJhms+Gz8ACVnL2a3RL5sVVg/ssf0mh5x/MSE/kXKFzufYgHcqRGuwobAR4E99p6BIBapDMPQwH1oN6yFgNKhf4Zv/szcg/RnMXvSlXZd+gf1tWr9vN4nYxZaTuAfJnGGVOXALa3+J7nOp/RNdYBHG1ushOk01uRVBdqTrS1ctVQ7GhEZkf0N8F5gGeGVkiiGGhw5kXDq1xGK+6wxZRoAzDeTrbuy1c6PiREaZLbpOZZUecYi/TTso5J7jQno8UchIm96ySKWIQn0AGn0PXWc4b6ElLRm/v/L1XGryhuvOQuW+kSUDlyAW1N+1B79JnppjHEcN7Odf3fYK3EmZ4aPO/L70TeoMQXuHDT/yJzUF086+SyvGpyC5vxqBXbaVRZZCvlJw8hMO+KAUlSE9KqaqfndXTRffLkyUpGcthvV5/xMXNnkAmvcXevgsx2RnLX1F2WSo0Y0G+GqcCPGX+hUODT/OdE0sT7rKl++NwKybwZ4I1VE7tFsM1Od1QgBm66bcg9e7dNWuz6THF66rw0JHy83fBPyuvEmFj0RN5sSPTZOUKpQH5+3R8jxr5qKSrY7xfKHhGi8soqOjFET5QGdDYn0cmyKHnWYt0ni8rtU0yIn97gLrm+7qp8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c1k3dUtxRm5mUHpVSnRRQXROaXZ5K1FpRzdXNllpWXlZS2lKVEtLbWVOemZn?=
 =?utf-8?B?VVc0aGtmbnVRaTR1YjJKQUVNWk1hZHdDV2NDdWdKYXlER28vUTg3Yks2TGZy?=
 =?utf-8?B?V0JBc2hLVDdHMDU5Z2pnYzNPNkdOM3pRMEMyeTJQR0hVa1FyZmlLZjE1U0l1?=
 =?utf-8?B?aVBXZlZCQ1FxdzVUZm9vUXlnb0dxVXFaczViWjZSUFc1c1RrZkh0YjBuR2wz?=
 =?utf-8?B?SHpUZDZvaUxyLzI5ckFWU3dyY0RxbXBVRDhPMldpaGtReDFlZGNtL2RSSThK?=
 =?utf-8?B?cVF2Y2tZYWg0dGVad1hEL21nLzcxYnVmOTZ2Z09KRllkejA4ekJlczJMQnVN?=
 =?utf-8?B?MlJHN2lia2Z4Tm5Tc0NLWmRSdW1lS3pWajlZS1drT0I3WWtKQm1rejcvdEJy?=
 =?utf-8?B?dmtVSVVHT3BKODhkdXYxS1FnbXJYR0tXUG5BYitmQlZXVkpuQWtNbm5CZVBy?=
 =?utf-8?B?a1NNd1I4bVZwbjR1ZmNCRXA5Q0FaaFZmbWMycWtxd1BINk81ZjhTb1hPcC9t?=
 =?utf-8?B?YjNNTVpSWUl2bWtJYXVJTlhNYnd1SlVBdk5JY3J2cXQycVpUd0VIOEp1a3NJ?=
 =?utf-8?B?N0NobmlFTDJJenNCdDNZNnBZK3hhZmJkRUtsUmJscUFUY0ZJTk40c21TVG01?=
 =?utf-8?B?NDU4c2RwRlBxZzk0MFpvOG9CVXc2VmJHdis2RHk3UmpqNUFyU2kzUUlWT3M5?=
 =?utf-8?B?cVJnNk5BbHl5ZlhQaGRhYmZhbndPQzROdy9QU0RRSXk4aWtDT0EvTnFQMWZ5?=
 =?utf-8?B?QXF3UXJMSVJCQUU1Vlcra1lEaTdLZjl2NEEvVTVQUnpKenJJV3NXRnVnN1hi?=
 =?utf-8?B?c2psOVpaanhnMHEzUnptTTN2cHo0ZmFQRmhkeW5Tc01PZkpxNm92dGNRYzFM?=
 =?utf-8?B?V0FlMkh6c3pTK3lqNmdOTnM5dDdLU3cwMURSVTF1V0pCalg1dVpuNDRTR1lI?=
 =?utf-8?B?d3JJUkdOeGpGNEZuRnkyRDFFVmRUR2tFdEZrQmk0eTZSaURHQUJIUEkrU0Vh?=
 =?utf-8?B?c2UrVHZMOTZCUGZISWJlRENpR05wNXl5bnlDTDkzMVB4UlhVZkkvRngzRElo?=
 =?utf-8?B?ODYwaWVaMm5qQW10SXhCaFhNVXIwTjg5U2sybzIzMEZEVUZvNzlWRml3NTU4?=
 =?utf-8?B?QkNFeDBtaklwMUtsb0R2bjEvcWJlK0tjcmpiNWlITGM4K1h1WUNNTnZNZ25K?=
 =?utf-8?B?aTUxRWVJeDMxV2lReCs5N2hVS2dya2xyTmFXQXZtRzBxTjdVbmV6M3VybnQr?=
 =?utf-8?B?bmxabzc1VnBRRVYreWw3enNsRzFBMnlQQWVkNktMOTVGNlhyYTN1VHhObUQx?=
 =?utf-8?B?bjlNLytCRUNpTnNiVkxGakliTCtIVithRDFqMjB4WGpWOXd5aVdDelU3SDN5?=
 =?utf-8?B?ZTF4TWg1MjcvaXB2ZzFTbmlvWUs3Rkk0c2JnNUlCbHdBamZzZFFBWFIxQXl5?=
 =?utf-8?B?aEQ3djgvWUFkdStoelQ3dkYxa3YzRm9uSUtlSm9sNFdVUTU0cXpUM0M3dTVj?=
 =?utf-8?B?NEJKb2xtcDdVQTBYdzMxRWloc1JTL21mK3FtdXE5bWplWXFHTEdOYVg0K1pk?=
 =?utf-8?B?OUp6SjE1VUY0UTBveFpXcEVLMG5MZGZzNXJ5L3UvbnRpSXJjWWJjbVo5ckFh?=
 =?utf-8?B?ZHZCdlo2ZnFzRXRRNHhZNFVRRjJydlJZMmd3VWxHU1k4V2JuaVNCbnlBSmNQ?=
 =?utf-8?B?YTBSQlY0UTk5Q09zV0locjV1SndYbGQzUVRqaTEveEgwQ1dhVVVxZld0cVRQ?=
 =?utf-8?B?c05McDZSNUlDVGcwTXZCdEtBWEVheVNxaEtvZWliZjZxYzVKL0lGTlJjckhy?=
 =?utf-8?B?MnQ1b1VlZStBM1dac0VhRU80dGxsbWVvYTBidE5qVDBndDMyL0tNQTBZbE9m?=
 =?utf-8?B?QzFZaWtoU1diM05mYURLeGFUNUY5UVJ4YWxOQVByWi9JcGF2dTVQeWlsbitn?=
 =?utf-8?B?UGxxbFE3aDFldGNtcE1hZkd4cjlQc1YvZkRYS0dIR0RPcEtRRmJmdk1EWkFK?=
 =?utf-8?B?dnVhV1JXZ0hIYzBiVzdtSnFrbTRyVDJlTzVMMDhrWThiTllnbVVtRzFZYlMy?=
 =?utf-8?B?TW8yUEM1WXVRYXhnNitoU0dZY2gzdWhTOG81RCtITmNKQUJIWmk2UTN6TThG?=
 =?utf-8?Q?+kMo8BU+6wmIphBqb39PPDqwL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cu2Uy5I6gLg1jFfg5ENt5DeDSTvz7Hmybmz+X8GQjgljXhzDZXFysYq+R1zdPpnf1TlKZC4JIQV3UnulRFwF3f+wuly/2qcJMy1Y0B3/9ccQraqYB6AcOX+XQkN7zBLKXZyuVaOZOTuXgBbBGeKV1mO0QucJxQvqInbK6fcoEz54aR3VxliH3yJn45WjETJyOfpGcQGrhB6fzob90iK6dvZI8BtqX6bOT2XjsFDyT7Tm2Fi4BqKjVnupbIuChyVJCq3L76hOjs6FJiUM25W1o+HSQ/uZLDMg7yeV1VhPivnGYuQAfptvVcNm7P1WZ+wi/Jm/2EdObVdzWh3mGzC/FKVtJs8eSD46N63Fxzu/kcgtZBbvynoB89r5CEnJufIJTx8ry/svI0FAdEjIk5eKv1XNsOz9GZVtUTYsGNG8fCql3ixV+xAPjCwSPguGNseUqkYDT6n359EYtzO3/hdyQWd97DadMl1O0Gl0QPxreZrB3uoHXWFTXp1BwbNW+J3/0ptaKYF8sNoGKMzvwc4RkO+qDi8Jas4tO/C4PmM68HEFNyTNCWv+7S7sOY9BDoCC/bMMErfj/2LFHfx6y2ky927fyM1iq+/7BON/kEdjt4VvbnorxyqIzZ/XHWG0ggkh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b1b010-149f-4838-e085-08dc3d3208ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 16:33:48.6936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DIgL6rsJOr4M8twBN310rwdvfvVq6WBtmhzKCFc9NZGouLcE8ekZaqAc4yrQavY9xXiJEFeyd4/6fs8y48T9YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6392

PiBIaSBKZW5zLA0KPiANCj4gdGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiANCj4gT24gVHVlLCBG
ZWIgMjcsIDIwMjQgYXQgNDozMeKAr1BNIEplbnMgV2lrbGFuZGVyIDxqZW5zLndpa2xhbmRlckBs
aW5hcm8ub3JnPg0KPiB3cm90ZToNCj4gDQo+ID4gQSBudW1iZXIgb2Ygc3RvcmFnZSB0ZWNobm9s
b2dpZXMgc3VwcG9ydCBhIHNwZWNpYWxpc2VkIGhhcmR3YXJlDQo+ID4gcGFydGl0aW9uIGRlc2ln
bmVkIHRvIGJlIHJlc2lzdGFudCB0byByZXBsYXkgYXR0YWNrcy4gVGhlIHVuZGVybHlpbmcNCj4g
PiBIVyBwcm90b2NvbHMgZGlmZmVyIGJ1dCB0aGUgb3BlcmF0aW9ucyBhcmUgY29tbW9uLiBUaGUg
UlBNQiBwYXJ0aXRpb24NCj4gPiBjYW5ub3QgYmUgYWNjZXNzZWQgdmlhIHN0YW5kYXJkIGJsb2Nr
IGxheWVyLCBidXQgYnkgYSBzZXQgb2Ygc3BlY2lmaWMNCj4gPiBSUE1CIGNvbW1hbmRzOiBXUklU
RSwgUkVBRCwgR0VUX1dSSVRFX0NPVU5URVIsIGFuZCBQUk9HUkFNX0tFWS4NCj4gU3VjaCBhDQo+
ID4gcGFydGl0aW9uIHByb3ZpZGVzIGF1dGhlbnRpY2F0ZWQgYW5kIHJlcGxheSBwcm90ZWN0ZWQg
YWNjZXNzLCBoZW5jZQ0KPiA+IHN1aXRhYmxlIGFzIGEgc2VjdXJlIHN0b3JhZ2UuDQo+ID4NCj4g
PiBUaGUgaW5pdGlhbCBhaW0gb2YgdGhpcyBwYXRjaCBpcyB0byBwcm92aWRlIGEgc2ltcGxlIFJQ
TUIgZHJpdmVyDQo+ID4gaW50ZXJmYWNlIHdoaWNoIGNhbiBiZSBhY2Nlc3NlZCBieSB0aGUgb3B0
ZWUgZHJpdmVyIHRvIGZhY2lsaXRhdGUNCj4gPiBlYXJseSBSUE1CIGFjY2VzcyB0byBPUC1URUUg
T1MgKHNlY3VyZSBPUykgZHVyaW5nIHRoZSBib290IHRpbWUuDQo+ID4NCj4gPiBBIFRFRSBkZXZp
Y2UgZHJpdmVyIGNhbiBjbGFpbSB0aGUgUlBNQiBpbnRlcmZhY2UsIGZvciBleGFtcGxlLCB2aWEN
Cj4gPiBycG1iX2ludGVyZmFjZV9yZWdpc3RlcigpIG9yIHJwbWJfZGV2X2ZpbmRfZGV2aWNlKCku
IFRoZSBSUE1CIGRyaXZlcg0KPiA+IHByb3ZpZGVzIGEgY2FsbGJhY2sgdG8gcm91dGUgUlBNQiBm
cmFtZXMgdG8gdGhlIFJQTUIgZGV2aWNlIGFjY2Vzc2libGUNCj4gPiB2aWEgcnBtYl9yb3V0ZV9m
cmFtZXMoKS4NCj4gPg0KPiA+IFRoZSBkZXRhaWxlZCBvcGVyYXRpb24gb2YgaW1wbGVtZW50aW5n
IHRoZSBhY2Nlc3MgaXMgbGVmdCB0byB0aGUgVEVFDQo+ID4gZGV2aWNlIGRyaXZlciBpdHNlbGYu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUb21hcyBXaW5rbGVyIDx0b21hcy53aW5rbGVyQGlu
dGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxp
bmFyby5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2h5YW0gU2FpbmkgPHNoeWFtc2FpbmlAbGlu
dXgubWljcm9zb2Z0LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKZW5zIFdpa2xhbmRlciA8amVu
cy53aWtsYW5kZXJAbGluYXJvLm9yZz4NCj4gDQo+IEkgd291bGQgbWVudGlvbiBpbiB0aGUgY29t
bWl0IHRoYXQgdGhlIHN1YnN5c3RlbSBpcyBjdXJyZW50bHkgb25seSB1c2VkIHdpdGgNCj4gZU1N
QyBidXQgaXMgZGVzaWduZWQgdG8gYmUgdXNlZCBhbHNvIGJ5IFVGUyBhbmQgTlZNRS4gTmV2ZXJ0
aGVsZXNzLCBubyBiaWcNCj4gZGVhbCBzbzoNCk1vcmVvdmVyLCBhcyB0aGUgeWVhcnMgd2VudCBi
eSwgdGhlIGRpZmZlcmVuY2VzIGJldHdlZW4gbW1jIGFuZCB1ZnMgZ3JldzoNCkluIG1tYyB0aGVy
ZSBhcmUgNyBycG1iIG9wZXJhdGlvbnMsIGluIHVmcyA5Lg0KSW4gbW1jIHRoZSBycG1iIGZyYW1l
IGlzIDUxMkJ5dGVzLCBhbHNvIGluIGxlZ2FjeSB1ZnMgKHVwIHRvIGluY2x1ZGluZyB1ZnMzLjEp
LCBidXQgaW4gdWZzNC4wIG9ud2FyZCBpdCBjYW4gYmUgNGsgd2l0aCBleHRlbmRlZCBoZWFkZXIu
DQpTZWUgZS5nLiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtc2Nz
aS9wYXRjaC8yMDIyMTEwNzEzMTAzOC4yMDE3MjQtMy1iZWFuaHVvQGlva3BwLmRlLw0KSW4gbW1j
IHRoZSBycG1iIHNlcXVlbmNlIGlzIGF0b21pYywgaW4gdWZzIG5vdC4NCkluIHVmcyBycG1iIGlz
IGEgd2x1biBpbiBtbWMgYSBwYXJ0aXRpb24uDQpCb3RoIHByb3RvY29scyBzdXBwb3J0IGluIG11
bHRpLXJlZ2lvbiBycG1iLCBidXQgdGhlcmUgYXJlIHNvbWUgZGlmZmVyZW5jZXMgdGhlcmUuDQpF
dGMuDQoNClRoYW5rcywNCkF2cmkNCg0KDQo+IFJldmlld2VkLWJ5OiBMaW51cyBXYWxsZWlqIDxs
aW51cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+IA0KPiA+ICtjb25maWcgUlBNQg0KPiA+ICsgICAg
ICAgdHJpc3RhdGUgIlJQTUIgcGFydGl0aW9uIGludGVyZmFjZSINCj4gPiArICAgICAgIGRlcGVu
ZHMgb24gTU1DDQo+IA0KPiBkZXBlbmRzIG9uIE1NQyB8fCBTQ1NJX1VGU0hDRCB8fCBOVk1FX0NP
UkUgPw0KPiANCj4gT3IgZG8gd2Ugd2FudCB0byBob2xkIGl0IG9mZiB1bnRpbCB3ZSBpbXBsZW1l
bnQgdGhlIGJhY2tlbmRzPw0KPiANCj4gWW91cnMsDQo+IExpbnVzIFdhbGxlaWoNCg0K

