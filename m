Return-Path: <linux-kernel+bounces-158200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019638B1CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C471C2331B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DB974416;
	Thu, 25 Apr 2024 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FC9+BkO7"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0668B14A82;
	Thu, 25 Apr 2024 08:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714034111; cv=fail; b=Zn/RwJ0OuYf4H0a28oD8RdqCRwMQqR1BS8kaE2xk82UCe/fQ6HnqGldJ/ldSSi32e7bjLDwdNpRNLqckcq30O3jf+krCZsIKYp0ttLTeZYkkpc34xELQk/11GAPwoWv0przum8RCMJkrxpdNFnbNYiAZ/2lO+kDIhGas00tbCLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714034111; c=relaxed/simple;
	bh=kZOuDNu89O+ai/i/8ubh4jXCWDHnl0UKo41wtk+Pfys=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pdlALiGLc3k5PdeOMPMC4JydRMnk42PuiJnokVpkJbwKKAiR8G5z3R809uiRun2bqc+JrxZ/jy1S/CZyarNGfpFPDvVV/WTRKVlD63XbwqGzyiHJY7VBV/4gWHtAXLf+gcjiUZncyjm+MCaVsvxh9GCsC8w/47mhnUO6mYTa8CA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=FC9+BkO7; arc=fail smtp.client-ip=40.107.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IttB7EN6NOrtlKzfB3w8u/5biFYrwFnUFrgJwBoA7BqrVP2BT+Cf3Ckb8h3NCqj2BbcmHWZOoAXwkUq308wka0OvyW6LhdFng/r9xc6kdgH7WIIdeGFyEXdPKJpnv57i0shrkHDgPkqE1iF+Qh+tG2pUhbFpGE7s56LlU8ZAd5WgOHPcTxNXuvhZx5B460cTQH+q7C2GldwtoxfGxi8TZ3zBb6gK4/T8lahZ/NEajVMzJxxSfO+CZgB5+xDcAk+tDCioCgK6fD70b5Sl24IneApZM7hqnlf+0surEZVN4hLcpNx8gmeR5R2wI5BQSqAc9v3aaOL6QSXFUhvzOPPDBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZOuDNu89O+ai/i/8ubh4jXCWDHnl0UKo41wtk+Pfys=;
 b=LRWH0N7+iCd5nzn7m3xZYx8b0sxSQ/jiI3PYPm0YXsaAM1ROSwYc4fs+49obOHGG4yD9M1tRz3spNH0FvFTw3klgfytRoX1g/dsWeZctiVmOoTF4ggu2kc5yR7N1ck6VPPSkbyOC0w6F/AVjTzHAc1EihbUogwpfgdLblYew0Ot8BiFS938pJZQJko0/XABYI4Rx7gboKsgoKe4EmeM+cjbkL8lNXcYgOENkNxpryCG7VPvCJTgEmS/TPQ33IzUqiorTdkYP3giygz+bR+6YsJ5wSXmaFmMtgSfBaTF2JtY1dwiaPRjKyv+CrBynnx2zIOdv9VBQh2uTfTj3BwAOhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZOuDNu89O+ai/i/8ubh4jXCWDHnl0UKo41wtk+Pfys=;
 b=FC9+BkO7rJVgFxHDuud1kpackCUEsA3txSO74Z6bT9tCWD+0cFQNCGerigi3z6peaiWE6Vdt7CgJKPDij7MDuiS+w2OboYC1RZ3I6iWtpZvhAQ5JV/tVr7qFmcePTZLp8utGBc9bBzohXXB/KNCN1NDRQSue42b9wkzKF4fieP8=
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com (2603:10a6:10:2dc::14)
 by PA1PR04MB10444.eurprd04.prod.outlook.com (2603:10a6:102:448::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 08:35:06 +0000
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::13a3:8937:4e42:19b9]) by DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::13a3:8937:4e42:19b9%4]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 08:35:06 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: "conor@kernel.org" <conor@kernel.org>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "kishon@kernel.org" <kishon@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	Frank Li <frank.li@nxp.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v3 1/3] dt-bindings: phy: phy-imx8-pcie: Add header file
 for i.MX8Q HSIO SerDes PHY
Thread-Topic: [PATCH v3 1/3] dt-bindings: phy: phy-imx8-pcie: Add header file
 for i.MX8Q HSIO SerDes PHY
Thread-Index: AQHalhIyTect89L16Ue6qqWnrGMUY7F3+LgAgACKBvA=
Date: Thu, 25 Apr 2024 08:35:06 +0000
Message-ID:
 <DU2PR04MB8677158A2D37BFEAB1F69DBC8C172@DU2PR04MB8677.eurprd04.prod.outlook.com>
References: <1713939683-15328-1-git-send-email-hongxing.zhu@nxp.com>
 <1713939683-15328-2-git-send-email-hongxing.zhu@nxp.com>
 <20240424215742.GB460126-robh@kernel.org>
In-Reply-To: <20240424215742.GB460126-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8677:EE_|PA1PR04MB10444:EE_
x-ms-office365-filtering-correlation-id: 4f3d056c-c97f-4e2c-dc66-08dc65029c19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?gb2312?B?dkxPNndzZ1VqQUlibE0wZ3d6akYyVGNCRkZqdmJEOWxnb1pvaXNtL05qWSsy?=
 =?gb2312?B?WWQ4U0xJNHMwSmMwU1pkZS9MWDhxUzNyRnR5emdIZHl1eTE0TXR5R0l0MzAx?=
 =?gb2312?B?VXJIZlAvN0dUZXJtZjFOUkJaRUVDcEN4NHZhcE1kUkVsM2VyVjVxUHpuT2Fl?=
 =?gb2312?B?bWtUOWVWYm1HaFBuSGhwRFpkUkV1czFnSCtFdExvQ1FPTy9sb2xNcDJjbjlu?=
 =?gb2312?B?SE5palhjcFJNbk00dTFvSUM3Qm05L1MyVnRiVDBwV3VCWkQ0WnBDYjNPYWZX?=
 =?gb2312?B?SllKZnFUQmdGc2EyRWlmcnBiZ3dxK3BBKzlYQ2diaUcxbDZBaS9aVnQ4ZE5P?=
 =?gb2312?B?ZU05eEdLRTBjcTlQbDZXRS9ERUhVOFo3UmNzYXZlSXNmNGdQaFdVV3dGVmRy?=
 =?gb2312?B?ZDNtUzRrcVVQcUZid2NRMnNLaitER3h5U1JKUHJzWWRGTkdJS3V2OEp2dEhw?=
 =?gb2312?B?d3hUR0VYWEdVM3pRc1ZaZW1wQmtraUwwMlprOWI4eGFTZVVSTFUxVVhSTnV6?=
 =?gb2312?B?eU9rblRXemxvUHNQQTZvTlBjUGtJSmU3WE5vcVZyUUFaaHRTTDZ6akpEOUdj?=
 =?gb2312?B?RTR1MnBSY1BSd0sxMXpjWXdwWnFDK1UzWFJjMjRFemIwOVF0TUZxWUVBUDA0?=
 =?gb2312?B?eFVqNTE5NUsrWGZtalNvSEtoTmdIT3NOWHFtVEthVzNPVUxhbVQ0K0ZoK1Jv?=
 =?gb2312?B?L2hEOGIrRWFKMkdmSUphTmltajRMZU13Q2FGbzdZYWhQTHVMZjdnbDE2NjBT?=
 =?gb2312?B?a1dDeTA0ZkhYUFg4b21pREE3a1o2SmxBc0JpU1BkdzAwZlFQby9jNy8zakpZ?=
 =?gb2312?B?RndqSmVhTDVCTzJ0bkNlL0Y1R3JJTHpwYUxNRFh3Mk5XVVR5MzAxTzltL296?=
 =?gb2312?B?dXgvTEVwbEtBdi84b1hTVTI0RDBkSnd1NjAwNUNjcXdZRFJjY28yZXBGaVdI?=
 =?gb2312?B?Q1ZFNlhSdlArRVhjMmhQTGp3eTdCRUk1ZUJvcmFIWVZaZDdGaU9xZkxwYk42?=
 =?gb2312?B?cGZxL3AyeW1ETkg1TjJDNTBYb1pDdkpCSUk0RWZMSHNSVWJkMXFmc3Q5MnYy?=
 =?gb2312?B?Zks5REUrQlVLV0R1cVkvQ3NaSis0bE05ckhiUjFaWDNWbElqMUo1bURlQnR2?=
 =?gb2312?B?WXltNEtSeU9QaW9ZWGgrd2hURVp1bVJrZE9VT1lKa21EWHV0bGxxRzMvNWFn?=
 =?gb2312?B?Z2tLZmhvOE1tUFpNbVBzaTMvREREWFRhZklkaEdZRzU2VUZWY08wRDh1WlI2?=
 =?gb2312?B?T09uckVqZ3BjWTlBRTB1c2RkMUxCLzZvTUo5bE5NblpLWkE2eE1MT1AxTm0v?=
 =?gb2312?B?b3ArZkhnZEo0TmU4djJFRXJTRk9YV2dBM0RVT3lGTlV4RXZ0bTlRM3JGb1Vp?=
 =?gb2312?B?dk5Dc0dXUnFhQ3AxQlZoTllJdnV5Q0VxM2V0MG9ZL0l5NFBiNmFBODFrc1NJ?=
 =?gb2312?B?WUgxcjRIaHR0Sy9NV09ZeTBoOWxHdjFGYk9zUGwxNEgyS295dGtnUDZOOXBK?=
 =?gb2312?B?Nm1OZ0hCU1MzR0ZaZUlBeThIZ1VNK2I5ZldTZk1VZy9nMmZTaDZrUmo3TEt1?=
 =?gb2312?B?RGVPNHNybnpLbk9EVmc4OG85bnRnSk83dmVtRXFDeTRSQm14SXdwL1hBMHZy?=
 =?gb2312?B?U3pxMjlWbnd3VjRGOE1VOUhReU1OQ2N4Z2xZbEkwTXgrbXJ3dkFzN1BSRGpP?=
 =?gb2312?B?d3FZQ0xMZ1ZuMUpKajVvNkp1TFFXZzlhczg4L0lPYmc0V2NHL3NyOGswRnR2?=
 =?gb2312?B?aEVIQXJYRVJvdU40OTFKc2ZoRXVPR0xndnFiZ0RGQ0puVFl4ODlXNmhwMXYz?=
 =?gb2312?B?cDVkNnd5aVZQa2tvSzFzUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8677.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?SHpQOXhMRXFDd1c1dWx5MGlkQzlQeHJ4MlpZMVl5ajRyWXFKcmNCWnYzbHBW?=
 =?gb2312?B?NUt6YXdNSVk0YzI1UFJQalBDOUFOclE4b1pxSkh1dkJNSUk3Y0Vrem1BMzht?=
 =?gb2312?B?ZERQMDZVVHFLTHJTVzNNYnBFQi9lR3FnV0pqaldHdzFXNldlWTZsZUxVUFFh?=
 =?gb2312?B?YjhsS3g1dVBQR1pORVpka0p3Z3NrV25jZS9hY1RPNW1vaU9JOFBmcjFrKzBC?=
 =?gb2312?B?Z3JEcmxEOHJkNzJINEpXUE03WHVWUS9MNmJ1TGxFTWVraHJSRWgxZFZqV2ky?=
 =?gb2312?B?SVh1UWJMSFo3bDcySjhQbEg3dExHdWlYTkYyUzJrcW1uakpsc0F6Y2NFS01Q?=
 =?gb2312?B?c2tsTmpnTHc1MjZXenlTUld2V0l4ZDVMRkQxTEdIdnlHNGdhVXBFQ0RxWWVH?=
 =?gb2312?B?Vjk5WVVpZ1BuTkhndVBYZXpQTG0zUElGTjFDQ0hVWWpwK0ZQQUJDdFpmYnNj?=
 =?gb2312?B?VWROWXNqWkwrbnRhTnBxcWJrSHVISWhrbGFDL1MwZzZPY2Q4a3FKM2hxc0pY?=
 =?gb2312?B?d0JkYVJNWUlWTVRZUTJ1WExhRGxoNEpHZDh5WXgwTDE2WisrRjR5dnQ3OHMv?=
 =?gb2312?B?SGo3cHlXMzZGRnpKMnBnK3pEK3VuSU9rYUdoTWdHSnR1YlkzamNYczcwczMw?=
 =?gb2312?B?cHhESFB3cGU1VG50TVVBTUNCMzVUTE42a0QvamNKUlgvejVaNk9iUGpRMVZI?=
 =?gb2312?B?aGN0VVV5WnhCRjM1YVdvWXFrZ210Ly8ydE04UDgzTmZXL2x5anlNMTFGRk5Z?=
 =?gb2312?B?WUNpZFNGV1NWVUxMRWxYc2tzV3ptQkw4cXFhQUE2VUtQS3M4THBkQ0dYbS9K?=
 =?gb2312?B?Q3NoeDdiMUptQTFuWWg2cW5wYms0OHk2bngvYWE5NE83TGNuS2F4cEd5Zmo5?=
 =?gb2312?B?b3BteVgvNXVQR2JCaWZ3UjhEVkM4SE9qSTAwUmh0c0FHTUFsa1ZQYUpQTm5k?=
 =?gb2312?B?aUlMTEc2b0ltYTgvbEpqaUkrc29LR2d2d3ZLMFpVWmZtSnVWc3ZLNjBUcWIw?=
 =?gb2312?B?ZktpU2NOcS96TVB6cFFBREhjV1dmbUVMbW5BOEQrMmkwQlRaWEhVMTkwZElq?=
 =?gb2312?B?T3JmbENodnNwdVJwT3N4VUdlQS9VaFJmQkl1b092TUdyNWpDK3lRc01JU0Jy?=
 =?gb2312?B?aCtrLzZMbHZPdjNKNXBqNEhMblQxcUkxeG9PekFxY3Bqd1BlSHZSZWVJZHRi?=
 =?gb2312?B?S1d6UC85UDNNd0EzRFZ0anBwdkI5bzlDZ01uT0ZvWDhmRFprbDgvMndZMU5k?=
 =?gb2312?B?cVprOWNTY3dWSmhpM1Q3SXlyckJaZUhtdTAzNy81eHBUMGVCOTlCQjl6MkhP?=
 =?gb2312?B?a29hWmRuT0MwOVo0Z2wzR1NTWGxCYkd2ZFBFYTV1SG9RUkZQY0VaYzMzTFJ0?=
 =?gb2312?B?Z0dwY3IydmpCKzRJNEVJblFJdlpQUjEyODVtVHl0YW1XMzlwNDBBTWt4LzN3?=
 =?gb2312?B?SC9FZG83QUVSSzViajhXdkcxbTRuQmdtU1NaSko3VGpwU0pZS3V2QkhxOFlT?=
 =?gb2312?B?cUI0MUd6YXBHR1l0bGJZS2E5SXZUY2VFUXNFYkloMUxxbHQzR0UxOGU0NjMr?=
 =?gb2312?B?QVVHSlUxLzlhQU5SYjdPQi9WL1g0YW1tcjBUdk96c0ZoQWdFdWdEOWVSRjNZ?=
 =?gb2312?B?eCtROFVSOE8vQW45bjVRVW42WnNEd2Zld2k5czdhYXYrTUVqVUZzdnU0VTFO?=
 =?gb2312?B?LzhmWWE2dnlrdUQ2VEZSTFZWUWFOMHBWa0VmbmRkZzlnLzJOcU9maTRjSk5Q?=
 =?gb2312?B?ZVRTV1ovS2RHQlJkZUQ5d0RVT2hqbkd4Z05Pd29zMm11WERSZDN4SGRWL2Fm?=
 =?gb2312?B?Ui9BZWc5eGNrN0VnajF2amdJMkFabWJWeFQ0R0VSVEVaMk0xN2s0VnNUZzEv?=
 =?gb2312?B?TFcvZFdQTFc0bitiUXdoUXJYYkllY2RYTlZuUEVIWlovK3JIRDdNby9TemVy?=
 =?gb2312?B?OFZlN3hmZVAvRnNLcHZNRVR6VG1oYVNsY1BhTlhIMm0xbDhWOGhtUzFyY2hB?=
 =?gb2312?B?dDVQN1JyNVhZR3JaMVRvdnpxWERIRElCeitjY0hSYVdIbzJSeHFsMCsxaDdQ?=
 =?gb2312?B?QU1wR2dMVWdtMDRoeDVCbEJuNU1vWlBxdmdzMUdXM3NPMkNzWCs4d0dUSXJ2?=
 =?gb2312?Q?Jq4RWQBm9B9oU7/g3WjwwK5Hg?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8677.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3d056c-c97f-4e2c-dc66-08dc65029c19
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 08:35:06.2982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zz1R8R2v16o1S67VV0/XePaeIbQoO5cEPu8WcY8PZGmGuV/FdtnTxo1j1Ekf24vRWPxmoDRov09vc5G+LzqCQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10444

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPg0KPiBTZW50OiAyMDI0xOo01MIyNcjVIDU6NTgNCj4gVG86IEhvbmd4aW5nIFpo
dSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBjb25vckBrZXJuZWwub3JnOyB2a291bEBr
ZXJuZWwub3JnOyBraXNob25Aa2VybmVsLm9yZzsNCj4ga3J6eXN6dG9mLmtvemxvd3NraStkdEBs
aW5hcm8ub3JnOyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47DQo+IGNvbm9yK2R0QGtlcm5l
bC5vcmc7IGxpbnV4LXBoeUBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGlteEBsaXN0
cy5saW51eC5kZXYNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzNdIGR0LWJpbmRpbmdzOiBw
aHk6IHBoeS1pbXg4LXBjaWU6IEFkZCBoZWFkZXIgZmlsZSBmb3INCj4gaS5NWDhRIEhTSU8gU2Vy
RGVzIFBIWQ0KPiANCj4gT24gV2VkLCBBcHIgMjQsIDIwMjQgYXQgMDI6MjE6MjFQTSArMDgwMCwg
UmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gQWRkIGxhbmUgaW5kZXggYW5kIEhTSU8gY29uZmlndXJh
dGlvbiBkZWZpbml0aW9ucyBvZiB0aGUgaS5NWDhRIEhTSU8NCj4gPiBTZXJEZXMgUEhZIGludG8g
aGVhZGVyIGZpbGUuDQo+IA0KPiBUaGlzIGJlbG9uZ3MgaW4gdGhlIGJpbmRpbmcgcGF0Y2guIEl0
IGlzIHBhcnQgb2YgdGhlIGJpbmRpbmcuDQpTaG91bGQgSSBtZXJnZSB0aGlzIHBhdGNoIGFuZCB0
aGUgc2Vjb25kIGludG8gb25lIGJpbmRpbmcgcGF0Y2g/DQoNCj4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBG
cmFuayBMaSA8RnJhbmsuTGlAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgaW5jbHVkZS9kdC1iaW5k
aW5ncy9waHkvcGh5LWlteDgtcGNpZS5oIHwgNjINCj4gPiArKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9waHkvcGh5LWlteDgtcGNpZS5oDQo+ID4gYi9p
bmNsdWRlL2R0LWJpbmRpbmdzL3BoeS9waHktaW14OC1wY2llLmgNCj4gPiBpbmRleCA4YmJlMmQ2
NTM4ZDguLjYwNDQ3Yjk1YTk1MiAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2R0LWJpbmRpbmdz
L3BoeS9waHktaW14OC1wY2llLmgNCj4gPiArKysgYi9pbmNsdWRlL2R0LWJpbmRpbmdzL3BoeS9w
aHktaW14OC1wY2llLmgNCj4gPiBAQCAtMTEsNCArMTEsNjYgQEANCj4gPiAgI2RlZmluZSBJTVg4
X1BDSUVfUkVGQ0xLX1BBRF9JTlBVVAkxDQo+ID4gICNkZWZpbmUgSU1YOF9QQ0lFX1JFRkNMS19Q
QURfT1VUUFVUCTINCj4gPg0KPiA+ICsvKg0KPiA+ICsgKiBpLk1YOFFNIEhTSU8gc3Vic3lzdGVt
IGhhcyB0aHJlZSBsYW5lIFBIWXMgYW5kIHRocmVlIGNvbnRyb2xsZXJzOg0KPiA+ICsgKiBQQ0lF
QSgyIGxhbmVzIGNhcGFibGUgUENJZSBjb250cm9sbGVyKSwgUENJRUIgKG9ubHkgc3VwcG9ydCBv
bmUNCj4gPiArICogbGFuZSkgYW5kIFNBVEEuDQo+ID4gKyAqDQo+ID4gKyAqIE1lYW53aGlsZSwg
aS5NWDhRWFAgSFNJTyBzdWJzeXN0ZW0gaGFzIG9uZSBsYW5lIFBIWSBhbmQgUENJRUIob25seQ0K
PiA+ICsgKiBzdXBwb3J0IG9uZSBsYW5lKSBjb250cm9sbGVyLg0KPiA+ICsgKg0KPiA+ICsgKiBJ
biB0aGUgZGlmZmVyZW50IHVzZSBjYXNlcy4gUENJRUEgY2FuIGJlIGJvdW5kIHRvIFBIWSBsYW5l
MCwgbGFuZTENCj4gPiArICogb3IgTGFuZTAgYW5kIGxhbmUxLiBQQ0lFQiBjYW4gYmUgYm91bmQg
dG8gbGFuZTEgb3IgbGFuZTIgUEhZLiBTQVRBDQo+ID4gKyAqIGNhbiBvbmx5IGJlIGJvdW5kIHRv
IGxhc3QgbGFuZTIgUEhZLg0KPiA+ICsgKg0KPiA+ICsgKiArLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0rDQo+ID4gKyAqIHwgaS5NWDhRTSAgICAgICAg
ICAgICAgICAgICAgICAgfCBpLk1YOFFYUCAgICAgICAgIHwNCj4gPiArICogfC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLS0tfA0KPiA+ICsgKiB8ICAgICAg
IHwgUENJRUEgfCBQQ0lFQiB8IFNBVEEgIHwgICAgICAgfCBQQ0lFQiAgICB8DQo+ID4gKyAqIHwt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS18LS0tLS0tLS0tLXwNCj4gPiAr
ICogfCBMQU4gMCB8IFggICAgIHwgICAgICAgfCAgICAgICB8IExBTiAwIHwgKiAgICAgICAgfA0K
PiANCj4gTEFOPyBMb2NhbCBBcmVhIE5ldHdvcms/IEp1c3QgdXNlICdMYW5lJy4NCj4gDQo+IERv
bid0IG5lZWQgdGhpcyBjb2x1bW4gICAgICAgICAgICAgICAgIF5eXl5eXl4NCj4gDQo+ID4gKyAq
IHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS18LS0tLS0tLS0tLXwNCj4g
PiArICogfCBMQU4gMSB8IFggICAgIHwgKiAgICAgfCAgICAgICB8ICAgICAgIHwgICAgICAgICAg
fA0KPiA+ICsgKiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tfC0tLS0t
LS0tLS18DQo+ID4gKyAqIHwgTEFOIDIgfCAgICAgICB8ICogICAgIHwgKiAgICAgfCAgICAgICB8
ICAgICAgICAgIHwNCj4gPiArICogKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0t
LS0tLS0tLS0tLS0tLS0tKw0KPiA+ICsgKiBOT1RFOg0KPiA+ICsgKiAqOiBDaG9vc2Ugb25lIG9u
bHkuDQo+ID4gKyAqIFg6IENob29zZSBhbnkgb2YgdGhlc2UuDQo+ID4gKyAqDQo+ID4gKyAqIERl
ZmluZSBpLk1YOFEgSFNJTyBQSFkgbGFuZSBpbmRleCBoZXJlIHRvIHNwZWNpZnkgdGhlIGxhbmUg
bWFzay4NCj4gPiArICovDQo+ID4gKyNkZWZpbmUgSU1YOFFfSFNJT19MQU5FMAkweDENCj4gPiAr
I2RlZmluZSBJTVg4UV9IU0lPX0xBTkUxCTB4Mg0KPiA+ICsjZGVmaW5lIElNWDhRX0hTSU9fTEFO
RTIJMHg0DQo+IA0KPiBUaGlua2luZyBhYm91dCB0aGlzIHNvbWUgbW9yZSwgaW4gbW9zdCBjYXNl
cyBvZiB0aGUgcGh5IGJpbmRpbmcgd2hlcmUgaW5kaXZpZHVhbA0KPiBsYW5lcyBjYW4gYmUgYXNz
aWduZWQsIGVhY2ggbGFuZSBpcyBhIHBoeXMgZW50cnkuDQo+IA0KPiBQQ0lFQToNCj4gcGh5cyA9
IDwmaHNpb19waHkgMCBQSFlfTU9ERV9QQ0lFPjsNCj4gb3I6DQo+IHBoeXMgPSA8JmhzaW9fcGh5
IDAgUEhZX01PREVfUENJRT4sIDwmaHNpb19waHkgMSBQSFlfTU9ERV9QQ0lFPjsNCj4gDQo+IFBD
SUVCOg0KPiBwaHlzID0gPCZoc2lvX3BoeSAxIFBIWV9NT0RFX1BDSUU+Ow0KPiBvcjoNCj4gcGh5
cyA9IDwmaHNpb19waHkgMiBQSFlfTU9ERV9QQ0lFPjsNCj4gDQo+IFNBVEE6DQo+IHBoeXMgPSA8
JmhzaW9fcGh5IDIgUEhZX01PREVfU0FUQT47DQo+IA0KPiA+ICsNCj4gPiArLyoNCj4gPiArICog
UmVnYXJkaW5nIHRoZSBkZXNpZ24gb2YgaS5NWDhRTSBIU0lPIHN1YnN5c3RlbSwgSFNJTyBtb2R1
bGUgY2FuIGJlDQo+ID4gKyAqIGNvbmZpdXJlZCBhcyBmb2xsb3dpbmcgdGhyZWUgdXNlIGNhc2Vz
Lg0KPiA+ICsgKg0KPiA+ICsgKiBEZWZpbmUgZGlmZmVyZW50IGNvbmZpZ3VyYXRpb25zIHJlZmVy
IHRvIHRoZSB1c2UgY2FzZXMsIHNpbmNlIGl0DQo+ID4gK2lzDQo+ID4gKyAqIG1hbmRhdG9yeSBy
ZXF1aXJlZCBpbiB0aGUgaW5pdGlhbGl6YXRpb24uDQo+ID4gKyAqDQo+ID4gKyAqIE9uIGkuTVg4
UVhQLCBIU0lPIG1vZHVsZSBvbmx5IGhhcyBQQ0lFQiBhbmQgb25lIGxhbmUgUEhZLg0KPiA+ICsg
KiBEZWZpbmUgIklNWDhRX0hTSU9fQ0ZHX1BDSUVCIiBmb3IgaS5NWDhRWFAgcGxhdGZvcm1zLg0K
PiA+ICsgKg0KPiA+ICsgKiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tKw0KPiA+ICsgKiB8ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgaS5NWDhRTSAgICAgICAgICAgIHwgaS5NWDhRWFAgfA0KPiA+ICsgKiB8LS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0t
LS0tfA0KPiA+ICsgKiB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgTEFOMCB8IExB
TjEgfCBMQU4yIHwgTEFOMCAgICAgfA0KPiANCj4gcy9MQU4vTGFuZS8NCj4gDQo+ID4gKyAqIHwt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLXwtLS0tLS18LS0tLS0tfC0tLS0t
LS0tLS18DQo+ID4gKyAqIHwgSU1YOFFfSFNJT19DRkdfUENJRUFYMlNBVEEgICAgfCBQQ0lFQXwg
UENJRUF8IFNBVEEgfCAgICAgICAgICB8DQo+ID4gKyAqIHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tfC0tLS0tLXwtLS0tLS18LS0tLS0tfC0tLS0tLS0tLS18DQo+ID4gKyAqIHwgSU1Y
OFFfSFNJT19DRkdfUENJRUFYMlBDSUVCICAgfCBQQ0lFQXwgUENJRUF8IFBDSUVCfCAgICAgICAg
ICB8DQo+ID4gKyAqIHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLXwtLS0t
LS18LS0tLS0tfC0tLS0tLS0tLS18DQo+ID4gKyAqIHwgSU1YOFFfSFNJT19DRkdfUENJRUFQQ0lF
QlNBVEEgfCBQQ0lFQXwgUENJRUJ8IFNBVEEgfCAgICAgICAgICB8DQo+ID4gKyAqIHwtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLXwtLS0tLS18LS0tLS0tfC0tLS0tLS0tLS18
DQo+ID4gKyAqIHwgSU1YOFFfSFNJT19DRkdfUENJRUIgICAgICAgICAgfCAtICAgIHwgLSAgICB8
IC0gICAgfCBQQ0lFQiAgICB8DQo+ID4gKyAqICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0rDQo+ID4gKyAqLw0KPiA+ICsjZGVm
aW5lIElNWDhRX0hTSU9fQ0ZHX1BDSUVBWDJTQVRBCTB4MQ0KPiA+ICsjZGVmaW5lIElNWDhRX0hT
SU9fQ0ZHX1BDSUVBWDJQQ0lFQgkweDINCj4gPiArI2RlZmluZSBJTVg4UV9IU0lPX0NGR19QQ0lF
QVBDSUVCU0FUQQ0KPiAJKElNWDhRX0hTSU9fQ0ZHX1BDSUVBWDJTQVRBIHwgSU1YOFFfSFNJT19D
RkdfUENJRUFYMlBDSUVCKQ0KPiA+ICsjZGVmaW5lIElNWDhRX0hTSU9fQ0ZHX1BDSUVCCQlJTVg4
UV9IU0lPX0NGR19QQ0lFQVgyUENJRUINCj4gDQo+IEFnYWluLCBJIGRvbid0IHNlZSB3aHkgeW91
IG5lZWQgYWxsIHRoaXMuIFlvdSBub3cgaGF2ZSBtb2RlIGFuZCBsYW5lcywgYW5kIHBlcg0KPiBT
b0MgZGF0YSBpbiB0aGUgZHJpdmVyLCBzbyB5b3Ugc2hvdWxkIGJlIGFibGUgdG8gZmlndXJlIG91
dCB3aGF0IHlvdSBuZWVkIGZyb20NCj4gdGhpcy4NClRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4N
Ckl0J3MgbXkgZmF1bHQgdGhhdCBJIGRpZG4ndCBkZXNjcmliZSBpdCBjbGVhci4NCg0KVGhlIEhT
SU8gY29uZmlndXJhdGlvbiAoZnNsLGhzaW8tY2ZnKSBpcyBvbmUgZ2xvYmFsIHN0YXRlIHRvbyBy
ZWZlciB0byB0aGUNCmRlc2lnbiBkb2N1bWVudC4NCkl0IHNob3VsZCBiZSBrbm93biBhbmQgdXNl
ZCB0byBzZXQgcGNpZV9hYl9zZWxlY3QgYW5kIHBoeV94MV9lcGNzX3NlbCBhdCB0aGUNCiBiZWdp
biBvZiBIU0lPIGluaXRpYWxpemF0aW9uIGxpa2UgdGhpcyBsaXN0ZWQgYmVsb3cuDQoNCistLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Kw0KfENSUihTWVMuQ1NSKSByZWdpc3RlcnxQQ0lBeDIgYW5kfFBDSUVBeDEsIFBDSUVCeDF8UENJ
RUF4MiBhbmR8DQp8ICAgICAgICAgICAgICAgICAgICAgfFNBVEEgICAgICB8U0FUQSAgICAgICAg
ICAgIHxQQ0lFQngxICAgIHwNCnwtLS0tLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLXwtLS0t
LS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tfA0KfFBDSUVfQUJfU0VMRUNUICAgICAgIHwgMCAgICAg
ICAgfCAxICAgICAgICAgICAgICB8IDEgICAgICAgICB8DQp8LS0tLS0tLS0tLS0tLS0tLS0tLS0t
fC0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLXwNCnxQSFlfWDFfRVBDU19T
RUwgICAgICB8IDEgICAgICAgIHwgMSAgICAgICAgICAgICAgfCAwICAgICAgICAgfA0KKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0r
DQpGb3IgZXhhbXBsZSwgaW4gdGhlIFBDSUVBeDIgYW5kIFNBVEEgdXNlIGNhc2UuIFRoZSBQSFlf
WDFfRVBDU19TRUwgc2hvdWxkIGJlDQoxYicxIGFuZCBQQ0lFX0FCX1NFTEVDVCBzaG91bGQgYmUg
MWInMCBhdCB0aGUgYmVnaW4gb2YgdGhlIGluaXRpYWxpemF0aW9uIG9mDQogdGhlIFBDSUVBIHN0
YW5jZS4NCkFuZCBpbiBQQ0lFQXgyIGFuZCBQQ0lFQngxIHVzZSBjYXNlLiBUaGUgUENJRV9BQl9T
RUxFQ1Qgc2hvdWxkIGJlIDFiJzEgYW5kDQpQSFlYMV9FUENTX1NFTCBzaG91bGQgYmUgMWInMC4N
Cg0KT3RoZXJ3aXNlLCB0aGUgUENJRUEgaW5zdGFuY2Ugd291bGRuJ3QgYmUgZnVuY3Rpb25hbCBp
biB0aGUgZW5kLg0KDQpVbmZvcnR1bmF0ZWx5LCBiYXNlZCBvbiBsYW5lIGluZGV4IGFuZCBwaHkg
bW9kZSBvZiBQQ0lFQSBpbnN0YW5jZSwgSQ0KIGRvbid0IGtub3cgaG93IHRvIHNldCBQQ0lFX0FC
X1NFTEVDVCBhbmQgUEhZX1gxX0VQQ0NfU0VMLg0KDQpTbywgb25lIHByb3BlcnR5IG5hbWVkICJm
c2wsaHNpby1jZmciIGhhcyB0byBiZSBpbnRyb2R1Y2VkIGhlcmUgdG8gc3BlY2lmeSB0aGUNCnNl
dHRpbmcgb2YgdGhlIFBDSUVfQUJfU0VMRUNUIGFuZCBQSFlfWDFfRVBDU19TRUwgb2YgSFNJTy4N
Cg0KVGhpcyBpcyB0aGUgcmVhc29uIHRoYXQgdGhlc2UgSU1YOFFfSFNJT19DRkdfIyBtYWNyb3Mg
YXJlIGRlZmluZWQgaGVyZS4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiANCj4gUm9i
DQo=

