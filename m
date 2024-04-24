Return-Path: <linux-kernel+bounces-156338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 229968B0174
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8217284052
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0371B156895;
	Wed, 24 Apr 2024 05:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DIG7xAYc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2WUanWV1"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C145915687D;
	Wed, 24 Apr 2024 05:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713938348; cv=fail; b=HUg63tYZdw7NS6JtQjAYhWyR8qSyo8qSA8eOHnw2BzupbF+PvjuQhzrJy8NqQGtc6MXwTjRHLbq1PWAMs1NKFSzR6NaexR5hrgF/4m4Nw+gmxnheW4jE1HoJm1M4YyV9WCUw1JpeEIAmwVaBIvuyPIhHF7CT38kiRJmod9D0YHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713938348; c=relaxed/simple;
	bh=uJE4XH1Dw7A7Yjhr3QLWOnU1raqKsIPv6/bKS7ztK2I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RNuFrclQXIEl0PCxJ3ok1WSiLFTmVbJ1pofGVppKvtlJ92rd95mAsVBh/Sar8fd38raWyFXQLwkJX1k7APSjoN9xgr79ZHRVHin+W3WawSim5IT1vLpDMXCIcAT3zw+fq0wZBQXShjxSx5QrAuULbZ7vV6IEHA6h7gfNyMmLdV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DIG7xAYc; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2WUanWV1; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713938346; x=1745474346;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uJE4XH1Dw7A7Yjhr3QLWOnU1raqKsIPv6/bKS7ztK2I=;
  b=DIG7xAYcGacqDuPzw+hDkDmgqzjUCIO5RyajPpUX4Ue4WwBeF1zvucsj
   FKjOZAlu+aUsZbA/jj52A0KI3kI/7nEb7BDz7b92NeTAOBVmcZe1J1Hpa
   +u5vvRZmCtDqdoQms4S0lWFeQNAhyxyJOqWXYz/stDeeen3eZGpWG6NTv
   Uz8NZDxiJNoEzQUGghP7ZUpNfADTyeiKwb1YE4TstTXe+Op/SDUSl2iPt
   LCICOhvcJxkwsD8YG7PBkWFbQwqgLVhmLTR5btMCrD+/2HRvhmzKkYvVU
   9pvhlvLo055tofbN/rBM/n8yN0gMGtA4PCAXBYUhBJC4PoEx6Z/4Po0ko
   A==;
X-CSE-ConnectionGUID: DrX6BcHWTLGIFlyHyfIk2w==
X-CSE-MsgGUID: ZZ6KWvGERoyHhjipQvbRBg==
X-IronPort-AV: E=Sophos;i="6.07,225,1708412400"; 
   d="scan'208";a="22979923"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Apr 2024 22:59:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 22:58:57 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 22:58:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4oYxI+lDugLU0MzxhzwgoEUdTjp3B9o1Cid2v2ThpB+uPLX2I/h8+pZuNHVuvGOxgQsd3iClRbk0c0Atqaq+LUuEBI9hoBrmnP2m45mZ133LThuJ8uIbFpKLHEtTqeioCWhUyV8mn4L+tUljhaHD4uDAt+N2kBdqWE7CtS7qlHhwISUyFPa7wrqz0eduM2BmZCd8F4KMaUzGQkrGeKh1VhTuQ7FP5UpXa5YuDa0hd9iiwl1GZx9lXQmvqsBtnGUpQ7Lsqot2nhMSXEQ+tXIGfCWIykgaUi5Bx8+9tMK3/ZKoPnbe11C/dHNvtSjxGTdaCv0usRjr9yd7gHukKrolQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIDCl2Jg6a362UTAUQSniTBd1fluT938EqV1ngONfWM=;
 b=UeLVqPuoukg6PS8BmONpI6z0Y++YV5z2KJlxNvpKjdEKKNp+59lbtgy1Ur9XCV8g8P6qkr1CucnkqY96oArTtpQak/fvlUIFtO+8VzyG7sr2KhH8m5SPHB7mFOsLMWK8u6imR0TrVSz4l2i5to/WQw7Xg5DMmUscfzFRR9gD9/BtH8uXlSs1ZzxzQNnzk19PI5qELSPbKtTvvJz4CF1QVXZigNuwefFpYwqzXz/AIcX9U3mHeQ70HIVGeLrn8JqjH4KgGyDsltPwqNUP5knpw7lYlZtXVp8/zQwDjB7OgQXa0T2SEUmtA253wpjxq9zIEqianYLiIs8XuA6SthFvCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIDCl2Jg6a362UTAUQSniTBd1fluT938EqV1ngONfWM=;
 b=2WUanWV1ZZauA1+tiyfiNKNhT6N+rGtmZ0+UCVn2gAJ57/4S6afYX3iILIqrOSw/7LKcBbJYR3iz+rKhX1OVML5csAINIypLp7sQoTwoL1v5iXZwiR8MR0yr6yGw9G7xU1/73hWQKa4DFMNPlUjEpw4FmiBd9GtBIE/D9ZjGvSW+IGqyQlB5Hq3syPCdbfuXUJcVMBgo/2Ws/GlCeuv6sRt8+aK6EWce84wIQQ5n3Qa+a6U7I4wUVTpHnTztloJVo8k+L5KyJH81cayp6nTtTSPeAxfZZxsLXPwiSM3lrVzTBgR11tV9bPMTAtQktfvXMctbBiUSZiVQEiudyOMazg==
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by DM4PR11MB5996.namprd11.prod.outlook.com (2603:10b6:8:5f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 05:58:54 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::1a3a:422d:1406:cd7]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::1a3a:422d:1406:cd7%5]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 05:58:53 +0000
From: <Ronnie.Kunin@microchip.com>
To: <andrew@lunn.ch>, <Raju.Lakkaraju@microchip.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <linux-kernel@vger.kernel.org>,
	<Bryan.Whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even when PHY
 does not
Thread-Topic: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even when
 PHY does not
Thread-Index: AQHaen5pYcVCYAnMVEe2BSZT37paArFBPcYAgBgwmwCAAJVnAIAb45oAgACHioCAAKyXUA==
Date: Wed, 24 Apr 2024 05:58:53 +0000
Message-ID: <PH8PR11MB7965211413E7295D537BF53095102@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20240320042107.903051-1-Raju.Lakkaraju@microchip.com>
 <20240320042107.903051-3-Raju.Lakkaraju@microchip.com>
 <22089299-a3e2-4cbd-942a-65ea070657b8@lunn.ch>
 <LV8PR11MB87003ABBCA98F00F3EEA9AB09F032@LV8PR11MB8700.namprd11.prod.outlook.com>
 <fb5a6f19-ae4c-443e-babb-cbbcf6ba5fc6@lunn.ch>
 <LV8PR11MB8700A34520EA2521BC5F59EF9F112@LV8PR11MB8700.namprd11.prod.outlook.com>
 <9c4f8fcd-ae95-4874-b829-d381928c5f13@lunn.ch>
In-Reply-To: <9c4f8fcd-ae95-4874-b829-d381928c5f13@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|DM4PR11MB5996:EE_
x-ms-office365-filtering-correlation-id: 352f431b-3f82-4f64-8a26-08dc64239f49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?6o8+/CJHevilmI/ErGsRBC6C8MZRmbInCcbt2ycEspw+6Esg/Mr4Nr0YaaNq?=
 =?us-ascii?Q?2/hJiphWDuUCKAAeh6h+99BtrF+P9SduOLKippmfdPd0eqokleQKjy9kWjbV?=
 =?us-ascii?Q?OoR41mPh6jw28dsJ3SFKISwp1kk91Zx3vR3PR5MVZv0CGuyPShDzYAL4FVJH?=
 =?us-ascii?Q?4oTElubFheAoJ32pqb5cSszUrcG9GGOd/7jo15ScPm7qCX2JrRAPI227mAMK?=
 =?us-ascii?Q?FvwvP+VyhraJIwskkdXSV+7Vp3bD8bAnhjjT2ZcaKhXC1oL1z1YJI2nxRtub?=
 =?us-ascii?Q?bsb3Pt6cr+WtCHoFYcre7ZzRo9YLDnodSqUbdFDAgTINhIqwGgb3bUo3iQjv?=
 =?us-ascii?Q?2IDrFRXicFzVs1uIyYgRnurV1P1nw6TAmlhO972MvL8PWFFvL733RcL9/tmd?=
 =?us-ascii?Q?MxcffKMzMbz1cxJ2nNgBIa90E2EB938VzhJSibyhAXVUKzEhJ6xy+cNjkalb?=
 =?us-ascii?Q?+V+ciLbit+pYWll7OB6UhlI97LXi96Vd0VTjNC5TjQfBBqKgznQYRfgF+Y9Y?=
 =?us-ascii?Q?9yKPgPWCNprpvk9ncWmgvdVRnf+ZaUWumbdoTqUhm/m+8pKNwKlGLyNg2g6/?=
 =?us-ascii?Q?jrjt7SSnJf/nbJM3TeBMIE+n3bu1PqVKNw33Mk9dap6MuLUuFiSp124l7qlY?=
 =?us-ascii?Q?uDJx7dYJBvNv1pPiPEvvYtpvoALDs4aF6qoH08p6kPZe89958dGk11pi3c2c?=
 =?us-ascii?Q?2NFv04cIOPRTggHG5kC5366wyFS7Gq//+fiyohysVUwGZgLgxbK/ZahjidKG?=
 =?us-ascii?Q?C1nki6l128Mpeys7Mthn7Z8vNUj970lHXfKgfSbdYX/DamGK/GKJYwfr6d6e?=
 =?us-ascii?Q?2rEHeAE/fdYtujHYDhSR9a/Kl3ESVgfcUsnKtETF9Hk7IfrAnHlHKUBE2Pnj?=
 =?us-ascii?Q?A60fgCQcV466ydNvWgKH8/SS9hOSDJ21fC37QWbvF4Et5tKYZ2aLYgIiX6/t?=
 =?us-ascii?Q?h2JUwKY0pGvJbwkPKBVvnv8dndi+rNOtoow8WUzUI96sVyA49drC+vX8JGo0?=
 =?us-ascii?Q?LnEBv8eGK+Z3IlUnrG/27feJ/BFPyFfhePL8Pxa5XTCF/9Guq+j8gCrUIcAM?=
 =?us-ascii?Q?cX9nSVOWZNjoMe+T1iHMhX0p2GR/2k/8mZ+c/PYKzNb+08KT+atdIvgr1Dl4?=
 =?us-ascii?Q?lJ40LEIMpDCJliEzSCnq0xrtntXD8fB3PSs4rd4Mjg/uxvfrOcvA4o5AGXi4?=
 =?us-ascii?Q?oeQEIeTt6XrxDFyn0jf4HGLXdIgeo7TX5sTqGCwhPHPWmKUJd9a62WsBPSYl?=
 =?us-ascii?Q?jIY9dIWJQefxCKiprfpvqDejjzQneB4wPQPApJ63E1KbtZYUySd1G32Wlb0e?=
 =?us-ascii?Q?3kcbLeCpuVpx5/4iLFh84Bjl+F9OoTCJSoFch9w0N08PhQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4qI8sGGPXCHwknKTzuwqr147yQHtLomdTYs+yKB5Aw9R0FH/hovt97Wz5yW2?=
 =?us-ascii?Q?cRfN9JEYoKAVgprEIRf6b89Fy14KggQzqv2SO5n/w+pPmWMdXf3F6qe7Fr60?=
 =?us-ascii?Q?tmIhmaMK9ju1Q+6VpqjkCpFyVermbCbGrIQFuYUpItyQTy9cMii3SgXrZ4yt?=
 =?us-ascii?Q?dkR/9DWjQhCzpoXj1kDICA+0fTXK3bKag+1YHEnNcDOHOb5t5NS56xm1sGF4?=
 =?us-ascii?Q?5I9UiUlYrNXryaHkUGcYn+JQBxaNEBQeiWBPM9jcMpC1OEZB+CrmjmAhSNRG?=
 =?us-ascii?Q?eoPsbN2WSoJWMAKwU0aQuQAjmHEPARwR7L7xs3gMnNkEN7NLfuyj1McA+6ey?=
 =?us-ascii?Q?kH0YcYiCwJfjRsC+HBKAKWnIeUqhxv+xAPCwC5ZxeQuOU7VUc+04tCiNMakS?=
 =?us-ascii?Q?//4FhNkbAr8U9RE8HDmpt/x4dLNVtn6pd+Lj+O1YfYImvTdTjhXQS/9vQjJL?=
 =?us-ascii?Q?Bp6ppBXKFLSXhyU1PepsvP5nmxTyB4nPgFM7tIRAZtXjd43/fMe7AtW1aabV?=
 =?us-ascii?Q?oYoahFKTCpQ2rOGqELQxwdOZhSHAIyJm6vvgJ7IhQcEfiiuY8O4F7iPxGNij?=
 =?us-ascii?Q?gww/uUDJvn4jmgMC2qkTP9C9Z8zbcP4ml+kIy3m6ntQlLy7VQwVOkv6KjQEX?=
 =?us-ascii?Q?C5eHTlio0NLZruhhIKGPvmxgGCKN9DTcRwVp3hdiwlAGObWgnwSDSs1Ej23a?=
 =?us-ascii?Q?BV9rDB5cLECIHxlYjFsXFQNgqwV3NWeWL0v6m0WWHGaRP0X08AJMPU+flXQ9?=
 =?us-ascii?Q?Fwt1iJXCHTWt71u2n7GFdXWoG82kePmNEYEX1/6PvA4Ed0ET/Jjw15GEVvWC?=
 =?us-ascii?Q?CguJE6Bd8y6Uxv2npYplArGZfLSJ7UsScU7sM+R6IOYaNlMwhHVI/z0Q/R3r?=
 =?us-ascii?Q?ALHEVHeuDLKvu3rDlKHQTCt3cLwoLvXnHh5Tqny/B11vflQX+pZ5PLUZ5hO/?=
 =?us-ascii?Q?x2aez613Yyy/igxHmbYSFz+0DIoV5VpWDlY5MpgdbJH4bYGqWGBGf1Yy/Y/H?=
 =?us-ascii?Q?FrW2tkIygWCMvQ9Vba5mOMBdG9m9Jv7hb6Kyg6YsnC6bf06eJyYtWTTRPcSW?=
 =?us-ascii?Q?KzGogMTGIZzEQSdleKEqxTWgOUFl3ivN6s9YNZ0YfEDouBqkRyVp1MI0uq+h?=
 =?us-ascii?Q?hFfJfM/G42NrTdctgF8rBhxWeEwoZuAIhc/YDq6Xhw9q1H4v+9HN5waRZhhW?=
 =?us-ascii?Q?gzwVFXP6JSX8941yc4MNlINLCRi3UFCdfdGT7kB3N0i3vT1y/W/XcwmLaPKw?=
 =?us-ascii?Q?tBwpaJS+ljdLvHP5Eu9y3rXGEEnNWcktVmf4ebpSLhnaoGoj22+GM1RwTlXn?=
 =?us-ascii?Q?pqhbkj9nUqq5Bwd/6/uL3OjfhFNY3Ri21GwBj2Jqku2vpzrlyC46bINxFXHr?=
 =?us-ascii?Q?Bq0kAKmW9nWpeiYy7uqy8ashPtx7Uwux5i0d4h/13ijZVAVF+nznVvl56n0j?=
 =?us-ascii?Q?fhBaY5g4m8H10Y2jdC99No774+ZmDvQhv9f2DXp1SUhnNxatOW6D5ruGLFX8?=
 =?us-ascii?Q?HRTr/3g/6Oh6Z9Bw8PbetNS/hSJhd2OxQ65YSIZ9mRmcyDyn0XdC4l6WbDAk?=
 =?us-ascii?Q?DbpKH3v5lChv9y34h4GtD4nPwH2vd5iSmOxCBV6hGrDmvKd2YCWV5w1A/U0M?=
 =?us-ascii?Q?jA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352f431b-3f82-4f64-8a26-08dc64239f49
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 05:58:53.8657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tswyVlKXxvqMdvLdj/4mW7n/L3lFqVN+yrZSebg2fzUFxHnvnKKxN4M61amiOUjknTTooxPVn/gTwZ+EXRvgb/IFFZeTdcpXN2Ys/HhJ1rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5996

Thanks very much for your feedback and suggestions Andrew, some comments an=
d clarifications below.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Tuesday, April 23, 2024 3:11 PM
> To: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>
> Cc: netdev@vger.kernel.org; davem@davemloft.net; kuba@kernel.org; pabeni@=
redhat.com;
> edumazet@google.com; linux-kernel@vger.kernel.org; Bryan Whitehead - C219=
58
> <Bryan.Whitehead@microchip.com>; UNGLinuxDriver <UNGLinuxDriver@microchip=
com>
> Subject: Re: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even whe=
n PHY does not
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> > If we don't enable/register the PCI11x1x's ethernet device in wake
> > list by calling " device_set_wakeup_enable( )" function, device power
> > state shows as disable.
>=20
> > PHY (GPY211C)'s interrupt pin (MDINT) connect to PCI11x1x's ethernet de=
vice.
>=20
> > When I configure the WAKE_PHY or WAKE_MAGIC on GPY211C PHY, Interrupt
> > generation observed when magic packet or link activity (link down or
> > link up).  If wakeup enable in PCI11x1x's ethernet device, System
> > resumes from sleep.
>=20
> This is the bit that is missing from your commit message, and maybe it sh=
ould be in a comment. The
> interrupt controller is part of the MAC. So you need to leave MAC burning=
 power, maybe even
> processing packets, because you cannot disable the MAC but leave the inte=
rrupt controller functioning,
> so that it can trigger a wake up via PCIe.

I think there is a terminology problem here. Within MCHP we sometimes call =
"the MAC" to the whole ethernet controller chip that has everything (i.e. a=
ctual MAC, FIFOs, filtering engines, offloads, interrupt controller, bus in=
terface, etc) except the PHY.
That is what Raju probably means when he says that the interrupt is handled=
 by "the MAC". While the registers that control enabling/disabling processi=
ng of the phy interrupt do reside within the MAC block's register set in th=
e ethernet controller, it neither means that the extensive parts of the act=
ual MAC block need to be kept enabled nor that processing packets has to oc=
cur in the MAC in order for the PCI11x1x chip to detect an event coming fro=
m the PHY that should be processed as a wake event over PCIe =20

>=20
> There are a few things you should consider:
>=20
> Call phy_speed_down().  This will renegotiate the link, dropping it to th=
e slowest speed both link
> partners support. So hopefully down to 10Mbps. Your MAC will then only ne=
ed to pointlessly process
> 10Mbps of packets, rather than 1Gbps.p

I am Windows driver expert, not Linux so I may be wrong for Linux, but with=
 the advent of dynamic PM in modern OSs (connected and then modern standby =
in Windows, I remember also autosuspend - at least in USB, maybe not applic=
able to PCIe  - in Linux ) we have stayed away from renegotiating the link =
to down speed during suspend - resume events since those interfere with / d=
elay connectivity significantly.

>=20
> See if you can disable parts of the MAC, in particularly the receive engi=
ne, in order to save power.

This is already supported by the hardware and I had told Raju to do it as s=
oon as he successfully got the host to wake over PCIe from events signaled =
from the PHY=20

>=20
> Talk to your hardware engineer and see if the next generation of the hard=
ware can separate the
> interrupt controller from the MAC, so you can disable the MAC and leave t=
he interrupt controller
> functioning.

As mentioned above, for all intents and purposes, that is already the case.

>=20
> > Please find the attached prototype code change (Temporary patch)for ref=
erence.
> > I will submit this patch separately.
>=20
> Please just submit it in the normal way for review.
>=20
>        Andrew

