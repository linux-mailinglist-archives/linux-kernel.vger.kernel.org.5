Return-Path: <linux-kernel+bounces-156994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D255A8B0B5B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023CF1C2359E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C758F15E801;
	Wed, 24 Apr 2024 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="cx9rkXbG"
Received: from mx07-0063e101.pphosted.com (mx07-0063e101.pphosted.com [205.220.184.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2690915AABA;
	Wed, 24 Apr 2024 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966099; cv=fail; b=gYkTDojNk1RIy44B0aQ6M5ivYThHTxqCB2u/ha8vDC3w2muF4xqCkWcACzs7RlZlGxdlhM4Mj7qHiLKt+BA6VlnUKB9es1UL7ux+zY+2oXg5u5eXBzDKrH4JchmZwGGSozeRZYE+isqCNNrlKPLcwExO+84rzE9n73IFrcqzACw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966099; c=relaxed/simple;
	bh=2vXApT6bXF5J4WcQzvCQFH06FMqljZYj8ut7yVGnWTY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AS+wTWu/N54vLLmE8y4Gi1POWGZLu3qBIkz0Q4Dp1okklRg1Mn0ZkDmKi/2qyCV2Gs6Scd7GvcD+ZW0Z9Um7OkIcf3AlmAKX05A2X7k3MtlwobYnVVL2WU5BDcjl+2UIdc62VrzjVqR3k846RsJu3B1xUURi53NTSWrHEWGmh3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=cx9rkXbG; arc=fail smtp.client-ip=205.220.184.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247495.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43ODU2k0025893;
	Wed, 24 Apr 2024 14:31:22 +0100
Received: from pnzpr01cu001.outbound.protection.outlook.com (mail-centralindiaazlp17011004.outbound.protection.outlook.com [40.93.132.4])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 3xny4n8uxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 14:31:22 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPD6oKfiUPhmR64Vt7pXZJ44nRiy1xFKvc+ZcxIlzeOTLn/ujJAruVeM+kcSph7zc5zkeLUX+S1+TuwO98PL33w5UNTRiK+CXo4l5TJS3y7pAGACxQfp9NqzMDzzs/CGJ3oW0uhceGQ0OMRgmmOg4Mo4bQpNiGmOBAsx/cV26qSwoM+l5ymnSAeyumcJRJNq102Xfxb8LmKiWk2aaajt9rTQtxaD69wLBg92EK2SpUtutjsKNjo+w/AHF0xY7kAH3VH1Q3h0O2GrFNokOy4i/EI8Mh69MsmuKD+IHEGDDhmma24InaAu7dD/Q3EsEqi6QffS1hVXpX/dy+jJ2b8xrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucwKQ5VE5ntXGjpks6Z+kaDXGLo6SUjZUxLOfyguQ7U=;
 b=JvdyGHriOuEnEjm5ZOKGgBcZDexE00oDxTmDEEK5SlqmDAEBm8oHV9raJb0b38R0PUXxw0rMEFSl9PkqZZP2CwGLbvRC+sWWo9kepmZ61MBZHMjgb3pwpFA4V4E4+sd6E4I9a/q2y9Wl3/0H44+la07EPt6IBVKk5ax6+L+r2A9JVhBEVMpUDs4pKSzm01xfOCn8PHDoQCkHh+ri4dNUfV09Bka5h5UK/IqfWVmaX4l+gzb4/a1RelQ4dlKGpEGB92W+/uqmTE3RCODnUdR3W2llIRsn0qYvtZAxTOTGphDyLmM9bCOASJImAeQDnh0XMJ2JYSCKu9tAt8nmer6BlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucwKQ5VE5ntXGjpks6Z+kaDXGLo6SUjZUxLOfyguQ7U=;
 b=cx9rkXbGuViP2+003dF2hbpTRAy552PRW8QtWJM3ZcSDBiGU1GsXgCMK4nnZXiPq91tYxP/vHzrj6bQ/8Lfrr0gAiuOU0v0VcLtWmWd3ENlWCT6t3hor1O/q13XzMEcATz6TOGrw0swSdadgKHhd3mI2zPNPpbuMJOVbGGvqkGA=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by MA0PR01MB6106.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 13:31:16 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%3]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 13:31:16 +0000
From: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>
To: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "olof@lixom.net"
	<olof@lixom.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "sboyd@kernel.org"
	<sboyd@kernel.org>,
        Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>
Subject: [PATCH v2 0/7] Add support for Blaize BLZP1600 SoC
Thread-Topic: [PATCH v2 0/7] Add support for Blaize BLZP1600 SoC
Thread-Index: AQHalkuv7F4NWtOj/EiPWHrSWEetvw==
Date: Wed, 24 Apr 2024 13:31:16 +0000
Message-ID: <20240424133032.19056-1-nikolaos.pasaloukos@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB10184:EE_|MA0PR01MB6106:EE_
x-ms-office365-filtering-correlation-id: 854b313a-937f-4885-1af0-08dc6462d190
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?meF1L8uPEURnGA7nxaZxK7g0Ruw1/SOpMVbCbpOIoMQ0ssW4M6N2aOhA53?=
 =?iso-8859-1?Q?AA/elBPrgFJ6ohCwy9RjBX22K31dg3lsHTuYJXAmxJzHReONFWvZqg3FCs?=
 =?iso-8859-1?Q?YXq4ldnXkp0IqROiIibitrxtb0EPq1SENRCKnNpoqpKUBysmAs9jJ60S7T?=
 =?iso-8859-1?Q?3OFzgfMwIhpvOiep01WzRLUCCfLkwE5ZEi8AlqVm05R0lwAIyXxinhHONy?=
 =?iso-8859-1?Q?AXd0+7XoPUhQUsgd0SeTHF4aMGEb59fsPy16bLVKUAZGhKuW33V060h4cO?=
 =?iso-8859-1?Q?Zh0VaPZDoZYiUnel0Xstr6jlNFQk1SvNSRYtwEjXN2oym0a6wpZPPli2bC?=
 =?iso-8859-1?Q?1Gl8VUrEMUTvcWYlsJynR/xM4zsGFydHDpcli1p3tD0NRh7t4S0twLe3X/?=
 =?iso-8859-1?Q?60b38OfakHFPBRO9SvqhsfzM6UsSH+nadaFaRcaJlmc1FpcJY2QIfObpR1?=
 =?iso-8859-1?Q?11uIq9PUL9aet+bEKrFV1QQzy2nnzapI0TBGF1s/S/NcrgoaVqivQHHwT+?=
 =?iso-8859-1?Q?cDE0fj8upSBPJctriwr4jWwB6ay7znGYxmn+DE9242oyRlzA1wMPiul6pt?=
 =?iso-8859-1?Q?qxGtFAgMXX6lRaTHUZEk5ceRrQhb3gw7xiHF51nS4F+9hgIeY9rwqKODz+?=
 =?iso-8859-1?Q?pIdeiayWAqAI8vXGMhL+RqXiLTuRmiYYsmPWkR2V6Zj7J6KWydy+1JbIIs?=
 =?iso-8859-1?Q?sEbjQhx/I/kkqhmEi6tJz8Nq5E0yiGs3V9D/hUBmvJgVXbFuJUY7SekTlU?=
 =?iso-8859-1?Q?ATOmBuOAzjntoPcOUHHYFHbkZTTrLXoCA4pu5InoFbzXpLFRaNi9C3dDBY?=
 =?iso-8859-1?Q?jKq52pSeCRYRrxCwi+eWtXZ6wkQ1dJNAYxVF1u73NyMvH7/N0e6WPETDkl?=
 =?iso-8859-1?Q?xi7/eXVT8O/hLxs54xviKXS5mmr9C3SDACKh45NGptZ+b1IdR6KZEYaILA?=
 =?iso-8859-1?Q?xfYpZ1afgVkb11VxmK3LX5Pk202oCXYxpit6jBEs5NS3u975Kxe1vQn3QL?=
 =?iso-8859-1?Q?e+4K8LtVwLgrNbRQzvE448wdLnofQNjqRhX536jv7J/4MO2N3ehzL4KMnx?=
 =?iso-8859-1?Q?icZ9dP6cN5u8wIsirVmgo54puspLdmqHw0gBGUCkLDfXEQmKJB8hzIVg/o?=
 =?iso-8859-1?Q?E4dO1Ij/20c553TSqxcwkLUi/JswXQpEJiHB79oOqQgKsTMDtDbUWS59Jc?=
 =?iso-8859-1?Q?rVNhpNx+MT3/OftegZTSDGa6yufP71ebgRs0wz6L6NgN48yhYJIc/ctvuC?=
 =?iso-8859-1?Q?xWJDLvejSN4yYg4Z8N6mLfGAyfQbDAX2fV1IgLvc0uY57kOQ0gnLsuEDvo?=
 =?iso-8859-1?Q?+zwIu53g58CtRfddJlfh4PioLx8VCzMwzd3WbdfgxrNyyQzk0IUW32GXyG?=
 =?iso-8859-1?Q?u+qrgZuaoigrwux4ykjwuq+fZ3yeQVMA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?lkwGL7NJi3VgOyi9/rvSFbY3b7URSXv+xAl6DWzELmM9wUYyuZLZKM3MxU?=
 =?iso-8859-1?Q?1Jo8SzhcCL6koNgPjRGrQ+FDy6ZYscb+dJHj6pi9vD7549rbe2JVgY5eQ3?=
 =?iso-8859-1?Q?oV6rBSzV6YL/kBu4pOxFlFffGXAxn8zA8Jzus2xuny27bbLqC3MwIjsmcJ?=
 =?iso-8859-1?Q?OmL+8GJMJhB2bFfSkTjEhpQwevxJJhYsmjg0ajOZJyzkB5TH/Wn/RHqf3r?=
 =?iso-8859-1?Q?R8VRIHRSSFPFYikl+NU1l6lw0+zQX6Q14rN0+FbQNjtxyKz0YxoDBF0Rkr?=
 =?iso-8859-1?Q?CrA9K2qhlg9nl1qDOClRjlhSBRyniFh0GqyxIXhx2g4jHSfTc1zssslg4z?=
 =?iso-8859-1?Q?BupEiMlCVft7FZ28lvLReXBTk3L8sFHO4SIoZVjYhXsPueLb2xLBT+TsHY?=
 =?iso-8859-1?Q?+Lc60d3mxntIBCSiAznhQkdjgwozh3TiaexszzqudSDtrlVEXlyBMWqbl2?=
 =?iso-8859-1?Q?dxFVqqUcFGmCup50A84YaPb4Hdfbhj/sfgT7m+7hjdfXN/h7hINnW/yoJI?=
 =?iso-8859-1?Q?omrtrRazdeiRXjk84gBkRd8gBnnfOjakV8vOqyuQMLkUuHwt6nomz/4NkK?=
 =?iso-8859-1?Q?Ohb1bTq6/zYxkSds4KjIONn9t9hcEt2FfAq+XaB0eGSY8FZbmIkM3CJ+SF?=
 =?iso-8859-1?Q?XveIVpWdVes4x9+IvS7VQhkgd4zLoIkVyS77PADm5u+Q999n+WDC0ZJCFZ?=
 =?iso-8859-1?Q?fsQD3RBJJ3onzGzXG6bn/7h/N2lUdmWP+E3pI5V5d2L48pGIZ/uXR4AQgD?=
 =?iso-8859-1?Q?3rcWSLNB6719yRRgdbtB2lmj/MReOEuTGSA67G86FzM8PyTZ6vFcEUVSQt?=
 =?iso-8859-1?Q?K0ZpXGLZAXedH4fazLLowaS/LLV5Ku1ExxoVQc5jXxyRa6mZsfyoGV9Erf?=
 =?iso-8859-1?Q?JYm1umuA0qWM6GjSRjOvmFZFjL1fTxHzU9vR8XdyYZ/Bq8B6toUjZbHJQ1?=
 =?iso-8859-1?Q?Ziuipm1byAsHoCH3/wDACKCHrXmub2yBPgLukUpynj+XqnCVF/d+RtOOTu?=
 =?iso-8859-1?Q?RF1TpCCE1ts0/hoUItFFuYn+dkNWWQHQrNgy80ylkGyCtf60sjx41el3JI?=
 =?iso-8859-1?Q?5jYKrMW04H71CyQrg+dKlMIcHbFAEMcqrvYgrBMPC6opnTxk8bdQM4uDnC?=
 =?iso-8859-1?Q?3jUxLCfK/qz5EHHGDTo201obZ70FDRojzVSqPYYp/C58Wk6DQHUAzD3WWK?=
 =?iso-8859-1?Q?sjXu2mUtDaFH2KmSY01mfENGSdT3vsagLOMSKX++1iFbrtydOPIO95Vnl5?=
 =?iso-8859-1?Q?zk95ADMGpO7+6d0cqW/4KZcqISY0lhyphM1gS+lmnBSqxlViNZH4tAYNX3?=
 =?iso-8859-1?Q?qOEW0TeuPjSeVSI0XIyiU2iJQ3eVNa8CEhthXhO/vMQqI++y3WCfgpcWOy?=
 =?iso-8859-1?Q?z0ykBVZvX82iyM2WnX85V4c8HFU2VwIY4c+ZnqC5UDk+lmhE5RdLzoY1VS?=
 =?iso-8859-1?Q?h6ByfV3qO5B4S8J/SsjMtC9kLsHXJcmXqWwZL+YolBDifpBhcnCNwdZMxk?=
 =?iso-8859-1?Q?Nb8IKkn1b5SgOLC2zIdR3/siJkZMVsZXAT4HdGSmNyHlT2sVTbjx45JdpM?=
 =?iso-8859-1?Q?+BkvrKzTw9LSY/QRa2g437dHcy0Xf9zWajaQBHXi2L8k0DP8Ar3KWGxNzf?=
 =?iso-8859-1?Q?cjf3+sTV92xE06G5KIbLodZk5l3hoyr1ct1Gw2UHeIaWut4rcFUefNJQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 854b313a-937f-4885-1af0-08dc6462d190
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 13:31:16.5169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4RYkQjsVmIxzyljxTwVuvau1hBZQdyWrpu5q+4wxKzirv3bG43IGasWSXzW72wqNDX0R2iq+7oLC4N3XO8sQy0iWTbuU5cix/lRvj6Pz3As=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6106
X-Proofpoint-GUID: GGOfK2NLbf-7D9boibhH1zoeNbTpdYX-
X-Proofpoint-ORIG-GUID: GGOfK2NLbf-7D9boibhH1zoeNbTpdYX-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_11,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=583 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2404010002
 definitions=main-2404240046

Adds basic support for the Blaize BLZP1600 SoC.
This SoC contains two cores of Cortex-A53 CPUs, one Blaize
Graph Streaming Processor (GSP) and several other IPs.

V2 changes:
 * Update SoBs.
 * `make dtbs_check` has no warnings.
 * Fix dts names and removed dead code.
 * DTS is separated from anything else.

Nikolaos Pasaloukos (7):
  dt-bindings: Add Blaize vendor prefix
  dt-bindings: arm: blaize: Add Blaize BLZP1600 SoC
  dt-bindings: reset: Add binding constants for BLZP1600
  dt-bindings: clock: Add binding constants for BLZP1600
  arm64: Add Blaize BLZP1600 SoC family
  arm64: Add initial support for Blaize BLZP1600 CB2
  arm64: defconfig: Enable ARCH_BLAIZE_BLZP1600

 .../devicetree/bindings/arm/blaize.yaml       |  40 ++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/Kconfig.platforms                  |   5 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/blaize/Makefile           |   2 +
 .../boot/dts/blaize/blaize-blzp1600-cb2.dts   |  84 +++++++
 .../boot/dts/blaize/blaize-blzp1600-som.dtsi  |  23 ++
 .../boot/dts/blaize/blaize-blzp1600.dtsi      | 211 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 .../dt-bindings/clock/blaize,blzp1600-clk.h   |  77 +++++++
 .../dt-bindings/reset/blaize,blzp1600-reset.h |  84 +++++++
 11 files changed, 530 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/blaize.yaml
 create mode 100644 arch/arm64/boot/dts/blaize/Makefile
 create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts
 create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi
 create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi
 create mode 100644 include/dt-bindings/clock/blaize,blzp1600-clk.h
 create mode 100644 include/dt-bindings/reset/blaize,blzp1600-reset.h

--=20
2.34.1


