Return-Path: <linux-kernel+bounces-151330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9088AAD02
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 132ECB213F1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B34E7F48C;
	Fri, 19 Apr 2024 10:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="qHtzCoGi"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7937F478
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713523442; cv=fail; b=WejYlsFXPA0aIAJYxqAneH+TIe2L4Q2dh4h8Eq59UF2dl5pLJtliK7wyWDzpd0ctiXp5z1PjyXLWDs03Ad0Y5odFBhON+ctVk4Lp1y1PByb0PRrdwLZiQFeWK3TlVLCgPvV2ltKmpnnsiTIwj/3Vv5XlIfwOpNbLxYa1d3RIQhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713523442; c=relaxed/simple;
	bh=u4U35V7sErY1gVXKBU+A+WfN8iw07PgvYihBTuY/1v4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d3TaFJPdHpep9Jm6mZsOxc4IhKGfjGzNx8DSiaTmuyIA/1WFr1XPD0C0eD2n6JvmdBt5ui1Yc0melUn+RXIX1vEDT7IR97HRiN+JDcT0HWwJR/N44k+Z1hPLess3tXZuW2op5J6FzwtW+D4lzxUcBcvRRM6c1QRLX/b7awdgM90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=qHtzCoGi; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43J9dFW7004898;
	Fri, 19 Apr 2024 03:43:36 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xkp5h85fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 03:43:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvWusaHbhmachxH/5kaaACP34r/X5F3W5EsMoeQZBCQW+FFceaMzUfjsay56RdLxlxWjCTii1kDUnM6x0yVyH9t7VRemkvEVIJSmXGl6OTCZfWSRG/vAoOax3aShFK2l2kuQywJStsfgGqK9EYhTzbuaBVWhKWBNYUBxKCFX2IE42x1RkiQTbqu6LgX+Mmx8qbtN7AWV6Qd2ckfMZL6qXuxn9lcOpmSzWMvS16cce0QOTi5eoa+8sLbd8j4mP1rLngKrhpNUvQ7GnMeiQbglr604HHtqbBfZTk4FTFi3WRNRnAeFsdkHoHbAsuocX/uNsu9GtSmv4RI2+AhoNv7LMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juH0v5cFWSgeuXJLpHOEaf3Kjs2lzOAGgi3P8QYZPl4=;
 b=NgF5oZty8q3SgSBI/c6RYaoXwquOq3I2Ka87iYEL0tsQW7xLlKOReaerJWv4PRGBAzfK8CiauskHwgdvngY5xwexAKjtWv5/pq9V4pFWyjbUKQ11BvJP3rsiPwK25jcz38sfDCd8g272RdMNnKBTk1VPGKtg8QfFtKpORklm3Esnpf+QWrCfnivcTdg63zMfFCK8ex5CYMotVdNq7sRUWRazGvQYjLlZ3OZ4q8tsaYhDnqs7a6Xxv+oQjhVgrvIsffewtIjC6t440yEHSKmIfzkum+1PaYAydHdtRr5sZfJVdLRlJfR5OuEn04LGzQA9L5KzFJhxDXv719l4lm5q3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juH0v5cFWSgeuXJLpHOEaf3Kjs2lzOAGgi3P8QYZPl4=;
 b=qHtzCoGib2C+E3dke5gTTdfY1PIqsawcI3HmgW25SlU27Yt7uJGvPVeOuQuDtbdM5HAKxXQG2qxg8ukEuvBC2c8oo7XVVAmGb17uzQaXbnTtygtV+Gs6m+P3aBt4Hwwyu+LL9suHAeSuC1klO/70kH/bORYxHNVIJRxlAbf5cSE=
Received: from SN1PR18MB2126.namprd18.prod.outlook.com (2603:10b6:802:29::29)
 by MN0PR18MB5846.namprd18.prod.outlook.com (2603:10b6:208:4c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Fri, 19 Apr
 2024 10:43:33 +0000
Received: from SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::2223:ad2f:9414:135e]) by SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::2223:ad2f:9414:135e%7]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 10:43:33 +0000
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com"
	<mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Bharat Bhushan
	<bbhushan2@marvell.com>,
        George Cherian <gcherian@marvell.com>
Subject: RE: [RESEND PATCH v4 1/3] perf/marvell: Refactor to extract platform
 data 
Thread-Topic: [RESEND PATCH v4 1/3] perf/marvell: Refactor to extract platform
 data 
Thread-Index: AQHagBcH5Q4hHsyAdUWC8BSulz5eE7FviJTA
Date: Fri, 19 Apr 2024 10:43:33 +0000
Message-ID: 
 <SN1PR18MB2126CF59BEA756157DFB3AD0DB0D2@SN1PR18MB2126.namprd18.prod.outlook.com>
References: <20240327071832.1556576-1-gthiagarajan@marvell.com>
 <20240327071832.1556576-2-gthiagarajan@marvell.com>
In-Reply-To: <20240327071832.1556576-2-gthiagarajan@marvell.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN1PR18MB2126:EE_|MN0PR18MB5846:EE_
x-ms-office365-filtering-correlation-id: 74e2917b-0a29-47a7-d800-08dc605d8f97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?VpXu4Xd6cJ1qxh6oGFh6LWR9ak4Zq2AoBah2DaGc/COxSaUNusdQue4WWrfB?=
 =?us-ascii?Q?MByejU07rEI5f3KmJ5QO2BlP3l1wy+xeDEfkA08RWWazYEZAAYVzZhIfcZZr?=
 =?us-ascii?Q?WNJy8Y8mUzvBA7O4Yn3cPiA56OQMMtRo8Arg/GZgs0z0zAXsV8aZOCgIuTtB?=
 =?us-ascii?Q?+AP215ljnc7mGIdxmwM6I+D72SqbEv8suRrZNqf/WyCBzdRnR9NF6jzU86F6?=
 =?us-ascii?Q?t5BlWKyQHbi3RPwfHv/tlKk255D8pargmo1YnIJUaWuKfyAf3RKjsngKsMSW?=
 =?us-ascii?Q?rIivUP4cuM5I2liy3gr0Z3QwXm/b/TjtgKitajRDXEZJzbavJJRT0VROImWF?=
 =?us-ascii?Q?n8hXQ23J5n5OQKwcd7ojTCzKwCdNQK/ZA4LKnZEl6I2P5sDVPw0Q51qBsxZj?=
 =?us-ascii?Q?4x7TvJaKp8wmbh9YcbRcQisetOKOktKnTTdKnEcl4cxutxkb2C3hpQAkxkWX?=
 =?us-ascii?Q?LmZRQItlNXghiKWq9TPdStSwuMx4XUmAe5mKLZKSZJDulp9XarmQmlESxwwQ?=
 =?us-ascii?Q?vRCppNPupqPVyl32/VFAvcbRh/UTO0ZuvcfRTFxHe0pfdMTvzktHn1vN87Lk?=
 =?us-ascii?Q?0X9HHYdB7S4itKshTaP7c9lFUr6WF0/DXmmpNAvc3MsiTx2zkUm6Spgk7hyi?=
 =?us-ascii?Q?cMIqUvCjLuES9ejQZtCpFRrZ38KlZBX1OpBBAvyssi+gJlkxQOVK1zInCZks?=
 =?us-ascii?Q?hZ9O7NTgQy0G7Ggk7vwOQ01zkueuYwtZIxyb0f/8LnVC2U8S9NVPSZOKC/i4?=
 =?us-ascii?Q?AFqzTRdWogPHiWkhD7yk4CDV6El9d7CKr135bFJNeoFep+UcuDGGs0/TJMVx?=
 =?us-ascii?Q?JJUfgMbkyMp7yEDbQcJlrKhfyp5m/ZyLwu9AIBJy5/80reipVb3Pcs4H0WvQ?=
 =?us-ascii?Q?64FOPF93ehC8r8wSPXN4JZpbl4VbKlPv9XtHu4icRZY6y686ZrgJrhbWsKE8?=
 =?us-ascii?Q?Qn5YtSGiciE8GOmFemDsUgjLuJp6GxpvJc4DrOlNw8SCLXkTqdwfoH3fWOWj?=
 =?us-ascii?Q?HeATZBf4hsVkLvZ9SumRPrZVODRi/1ebFCBajyehLo1/qPzQZ2WFtNy5sE+U?=
 =?us-ascii?Q?rZTKgnwtSylj+x9ZXhUVxhdd2on7q+D7EIOAhLGdonqVfQ3j2KzSleO05vcY?=
 =?us-ascii?Q?0rqX69OL3Kbi15YdAgiMubUZxD/TUlxAquRnkHHwSVvJMKy9TIPSdiDpyx4h?=
 =?us-ascii?Q?/6mwZc7qGGUhYowJDGgSi0JXNRZFFzQrVFFt97olJhuYjVUm5y06wijgepua?=
 =?us-ascii?Q?z+9QXlY/3/R4qDuH6BvmpeqBSZC1Rc3zrhAmOKUMJW6aSEx8CqOMDqZGYhrR?=
 =?us-ascii?Q?2/JvO8PN33vkeK+4siPR/etfC3o4waqXNf4ALBqdYU9Y+w=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR18MB2126.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?mJOOyUytAkdMeLr/ocbigLTtMcKOG6SqFbm+a3XaGlfg2Y2fz523rt4vOEiZ?=
 =?us-ascii?Q?SFKoxsMu44iD39QJcCm6pqfVQR0TU+Lq3P5Zqs6ElfT38xUcLWLTdQPQB66d?=
 =?us-ascii?Q?eSMOe8NH3bLVqEb2IRf8/7SqBPAplsq98T/uYQsqda/69crdspajbN8eK9tU?=
 =?us-ascii?Q?40rafYubPUOMsgMp1E/cztVwiaRGEydSpUfvNxADW1ToCC+4tY9Dw9Wg6Zv0?=
 =?us-ascii?Q?wHN0/Pl5odlKiEXZcOYx/3cH2T/yFhsLKybKseRs9AZRJNeMADxWnqkxr2av?=
 =?us-ascii?Q?qW1HtZXeT/0+4J7nDNBlmshwGHvMHu1XMSe84hUWg9qYazWjcUCbSJi/XX6r?=
 =?us-ascii?Q?+AWHQtesMGIiI+I8uQzR4h5UKXmx3+l6jR11mdP44j5LCDmqm18zvwcTnbFk?=
 =?us-ascii?Q?XkBGIPQw8jXtVguEKgHm8fjhs4zA6Yozos3gjXlF67VBZqiZ1Uk8wYx7M5Mv?=
 =?us-ascii?Q?QZSGJ7QY6pRqTRGaBmaxGRA1Wog5TCkn9QWYb+oK7scDCT8E1nUEUeVkudj5?=
 =?us-ascii?Q?kT5gbvMEOmoTSodEdSN6PYeQFru/f9ZYpDfPhow/yWW9OweTpdiVzUsTlhif?=
 =?us-ascii?Q?MTyUdM5j9hoHxaDy42D8DMoD7ZyxTfNxRPLmTu5WJMk6TJKIv10TUpX0keGo?=
 =?us-ascii?Q?pEa0ptLdy9OOwxHPF7IcskL4UpzIak8yquoRoB6Ve/O4AOAVdwgfVScPApC4?=
 =?us-ascii?Q?/NAIDL1r/7TndMjmVNjqHezlx8Z4y6pCD9IALvjVFYMS9mZiGqQmv8AB0djN?=
 =?us-ascii?Q?cVwXznSLK8ZNy90RB3aUtbIas+lz7hzz67rSuwV+iwxydPZMxXaksoEgmbH9?=
 =?us-ascii?Q?typrK4uoFOoQhu8mxVw3sXuudSbA2jOFGyzpLM2IV1fZVMQDCgztPFdOOyiZ?=
 =?us-ascii?Q?wu6iCZ6kvKgb56WLlQJ7TGeezo21GSSQ3A3Mw3IyrdJr5hlAMCsm9yFkrMm7?=
 =?us-ascii?Q?/Be287tcHZfoqXtxwEqpNZ2vOkMFuXfXldKyYCwKe8eLCYSKMyIJi009zUe6?=
 =?us-ascii?Q?REhwnRG10QQjK3FW4xFJE7jq5BHyKP5GdttVCLOtO8ngrQlJlsm5xPSb+GpE?=
 =?us-ascii?Q?+/OMcmvXUh7qMG76XNTDUwBvCoehpNYknWjBXPmrCVroKyWnwGFVNZGTbstG?=
 =?us-ascii?Q?/w8MNkVQUAAAVJWvPfta69XABovtsqfBGoBlKyfgcvwVMQfNKnBwXFdP4Sx7?=
 =?us-ascii?Q?3o7CRPjh7MAECGTqsa9HErEtUggmx0sHecUFTiPbFLaBwX1UwLlhNkWA7Oa/?=
 =?us-ascii?Q?2AFIn4BjM5cHAiWQ+TPHQAWLdGxHT7hq4T3GGUD5WO7B4/w836LMgUAcCoZe?=
 =?us-ascii?Q?7gZoDou/VWc7c9ptXPviswXhFBq1Sp0Gw2Vj2+aFkYv3SHdMpPsq3bafL24n?=
 =?us-ascii?Q?rTviD6G+4zdol5RZeWvBg1kBWbv1oA8OWnn8xCRyepTyrE7ENFL42LAF4DI1?=
 =?us-ascii?Q?eyrrpemGqjgfeBrXiZDL+1SmykL8N0wi7c5aQETQwANg0reCx5TSA7LX46k0?=
 =?us-ascii?Q?K2KSDnZE5EICtVtiF8VkGMS9deRKLvm1mXQtHshupZD4qt5p5VEuikSoG5rz?=
 =?us-ascii?Q?j9W03Mlt/UiQCKbj3hTDDTQt0U1FjbGUfxxGL/UP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR18MB2126.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e2917b-0a29-47a7-d800-08dc605d8f97
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 10:43:33.7013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iTV9UkiknxmJ19M35xeX4Xm4Kprid6KuujCqOejSN4CdYZgm4V/VGljaUXgxRHrbR0IdC/37tQFyaSlOgX9yL3XnkqvC1NdYgd9UksvpXSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR18MB5846
X-Proofpoint-GUID: SIXShvKAZW2hrjXa0fPSJeQrwOdMrsv-
X-Proofpoint-ORIG-GUID: SIXShvKAZW2hrjXa0fPSJeQrwOdMrsv-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_08,2024-04-17_01,2023-05-22_02

Hi,

The patches are updated as per the comments received. Do you have any feedb=
ack on this version?

Thanks,
Gowthami

> -----Original Message-----
> From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> Sent: Wednesday, March 27, 2024 12:49 PM
> To: will@kernel.org; mark.rutland@arm.com; linux-arm-kernel@lists.infrade=
ad.org; linux-
> kernel@vger.kernel.org
> Cc: Sunil Kovvuri Goutham <sgoutham@marvell.com>; Bharat Bhushan <bbhusha=
n2@marvell.com>; George
> Cherian <gcherian@marvell.com>; Gowthami Thiagarajan <gthiagarajan@marvel=
l.com>
> Subject: [RESEND PATCH v4 1/3] perf/marvell: Refactor to extract platform=
 data
>=20
> This commit introduces a refactor to the Marvell driver
> code, specifically targeting the extraction of platform data
> (referred to as "pdata") from the existing driver. The purpose of
> this refactor is to prepare for the upcoming support of the next
> version of the Performance Monitoring Unit (PMU) in this
> driver.
>=20
> No functional changes are introduced in this refactor. Its sole
> purpose is to improve code organization and pave the way for
> future enhancements to the driver.
>=20
> Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> ---
>  drivers/perf/marvell_cn10k_ddr_pmu.c | 282 ++++++++++++++++++++-------
>  1 file changed, 210 insertions(+), 72 deletions(-)
>=20
> diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_=
cn10k_ddr_pmu.c
> index 524ba82bfce2..d6485c4cf30f 100644
> --- a/drivers/perf/marvell_cn10k_ddr_pmu.c
> +++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
> @@ -1,7 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/* Marvell CN10K DRAM Subsystem (DSS) Performance Monitor Driver
> +/*
> + * Marvell CN10K DRAM Subsystem (DSS) Performance Monitor Driver
>   *
> - * Copyright (C) 2021 Marvell.
> + * Copyright (C) 2024 Marvell.
>   */
>=20
>  #include <linux/init.h>
> @@ -14,24 +15,24 @@
>  #include <linux/platform_device.h>
>=20
>  /* Performance Counters Operating Mode Control Registers */
> -#define DDRC_PERF_CNT_OP_MODE_CTRL	0x8020
> -#define OP_MODE_CTRL_VAL_MANNUAL	0x1
> +#define CN10K_DDRC_PERF_CNT_OP_MODE_CTRL	0x8020
> +#define OP_MODE_CTRL_VAL_MANUAL	0x1
>=20
>  /* Performance Counters Start Operation Control Registers */
> -#define DDRC_PERF_CNT_START_OP_CTRL	0x8028
> +#define CN10K_DDRC_PERF_CNT_START_OP_CTRL	0x8028
>  #define START_OP_CTRL_VAL_START		0x1ULL
>  #define START_OP_CTRL_VAL_ACTIVE	0x2
>=20
>  /* Performance Counters End Operation Control Registers */
> -#define DDRC_PERF_CNT_END_OP_CTRL	0x8030
> +#define CN10K_DDRC_PERF_CNT_END_OP_CTRL	0x8030
>  #define END_OP_CTRL_VAL_END		0x1ULL
>=20
>  /* Performance Counters End Status Registers */
> -#define DDRC_PERF_CNT_END_STATUS		0x8038
> +#define CN10K_DDRC_PERF_CNT_END_STATUS		0x8038
>  #define END_STATUS_VAL_END_TIMER_MODE_END	0x1
>=20
>  /* Performance Counters Configuration Registers */
> -#define DDRC_PERF_CFG_BASE		0x8040
> +#define CN10K_DDRC_PERF_CFG_BASE		0x8040
>=20
>  /* 8 Generic event counter + 2 fixed event counters */
>  #define DDRC_PERF_NUM_GEN_COUNTERS	8
> @@ -42,17 +43,19 @@
>  					 DDRC_PERF_NUM_FIX_COUNTERS)
>=20
>  /* Generic event counter registers */
> -#define DDRC_PERF_CFG(n)		(DDRC_PERF_CFG_BASE + 8 * (n))
> +#define DDRC_PERF_CFG(base, n)		((base) + 8 * (n))
>  #define EVENT_ENABLE			BIT_ULL(63)
>=20
>  /* Two dedicated event counters for DDR reads and writes */
>  #define EVENT_DDR_READS			101
>  #define EVENT_DDR_WRITES		100
>=20
> +#define DDRC_PERF_REG(base, n)		((base) + 8 * (n))
>  /*
>   * programmable events IDs in programmable event counters.
>   * DO NOT change these event-id numbers, they are used to
>   * program event bitmap in h/w.
> + *
>   */
>  #define EVENT_OP_IS_ZQLATCH			55
>  #define EVENT_OP_IS_ZQSTART			54
> @@ -63,8 +66,8 @@
>  #define EVENT_VISIBLE_WIN_LIMIT_REACHED_RD	49
>  #define EVENT_BSM_STARVATION			48
>  #define EVENT_BSM_ALLOC				47
> -#define EVENT_LPR_REQ_WITH_NOCREDIT		46
> -#define EVENT_HPR_REQ_WITH_NOCREDIT		45
> +#define EVENT_RETRY_FIFO_FULL_OR_LPR_REQ_NOCRED	46
> +#define EVENT_DFI_OR_HPR_REQ_NOCRED		45
>  #define EVENT_OP_IS_ZQCS			44
>  #define EVENT_OP_IS_ZQCL			43
>  #define EVENT_OP_IS_LOAD_MODE			42
> @@ -102,28 +105,38 @@
>  #define EVENT_HIF_RD_OR_WR			1
>=20
>  /* Event counter value registers */
> -#define DDRC_PERF_CNT_VALUE_BASE		0x8080
> -#define DDRC_PERF_CNT_VALUE(n)	(DDRC_PERF_CNT_VALUE_BASE + 8 * (n))
> +#define CN10K_DDRC_PERF_CNT_VALUE_BASE	0x8080
>=20
>  /* Fixed event counter enable/disable register */
> -#define DDRC_PERF_CNT_FREERUN_EN	0x80C0
> +#define CN10K_DDRC_PERF_CNT_FREERUN_EN		0x80C0
>  #define DDRC_PERF_FREERUN_WRITE_EN	0x1
>  #define DDRC_PERF_FREERUN_READ_EN	0x2
>=20
>  /* Fixed event counter control register */
> -#define DDRC_PERF_CNT_FREERUN_CTRL	0x80C8
> +#define CN10K_DDRC_PERF_CNT_FREERUN_CTRL	0x80C8
>  #define DDRC_FREERUN_WRITE_CNT_CLR	0x1
>  #define DDRC_FREERUN_READ_CNT_CLR	0x2
>=20
> -/* Fixed event counter value register */
> -#define DDRC_PERF_CNT_VALUE_WR_OP	0x80D0
> -#define DDRC_PERF_CNT_VALUE_RD_OP	0x80D8
>  #define DDRC_PERF_CNT_VALUE_OVERFLOW	BIT_ULL(48)
>  #define DDRC_PERF_CNT_MAX_VALUE		GENMASK_ULL(48, 0)
>=20
> +/* Fixed event counter value register */
> +#define CN10K_DDRC_PERF_CNT_VALUE_WR_OP		0x80D0
> +#define CN10K_DDRC_PERF_CNT_VALUE_RD_OP		0x80D8
> +
> +enum mrvl_ddr_pmu_version {
> +	DDR_PMU_V1 =3D 1,
> +};
> +
> +struct ddr_pmu_data {
> +	int id;
> +};
> +
>  struct cn10k_ddr_pmu {
>  	struct pmu pmu;
>  	void __iomem *base;
> +	const struct ddr_pmu_platform_data *p_data;
> +	int version;
>  	unsigned int cpu;
>  	struct	device *dev;
>  	int active_events;
> @@ -132,8 +145,35 @@ struct cn10k_ddr_pmu {
>  	struct hlist_node node;
>  };
>=20
> +struct ddr_pmu_ops {
> +	void (*enable_read_freerun_counter)(struct cn10k_ddr_pmu *pmu,
> +					    bool enable);
> +	void (*enable_write_freerun_counter)(struct cn10k_ddr_pmu *pmu,
> +					     bool enable);
> +	void (*clear_read_freerun_counter)(struct cn10k_ddr_pmu *pmu);
> +	void (*clear_write_freerun_counter)(struct cn10k_ddr_pmu *pmu);
> +	void (*pmu_overflow_handler)(struct cn10k_ddr_pmu *pmu, int evt_idx);
> +};
> +
>  #define to_cn10k_ddr_pmu(p)	container_of(p, struct cn10k_ddr_pmu, pmu)
>=20
> +struct ddr_pmu_platform_data {
> +	u64 counter_overflow_val;
> +	u64 counter_max_val;
> +	u64 ddrc_perf_cnt_base;
> +	u64 ddrc_perf_cfg_base;
> +	u64 ddrc_perf_cnt_op_mode_ctrl;
> +	u64 ddrc_perf_cnt_start_op_ctrl;
> +	u64 ddrc_perf_cnt_end_op_ctrl;
> +	u64 ddrc_perf_cnt_end_status;
> +	u64 ddrc_perf_cnt_freerun_en;
> +	u64 ddrc_perf_cnt_freerun_ctrl;
> +	u64 ddrc_perf_cnt_freerun_clr;
> +	u64 ddrc_perf_cnt_value_wr_op;
> +	u64 ddrc_perf_cnt_value_rd_op;
> +	const struct ddr_pmu_ops *ops;
> +};
> +
>  static ssize_t cn10k_ddr_pmu_event_show(struct device *dev,
>  					struct device_attribute *attr,
>  					char *page)
> @@ -189,9 +229,9 @@ static struct attribute *cn10k_ddr_perf_events_attrs[=
] =3D {
>  	CN10K_DDR_PMU_EVENT_ATTR(ddr_zqcl, EVENT_OP_IS_ZQCL),
>  	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_wr_access, EVENT_OP_IS_ZQCS),
>  	CN10K_DDR_PMU_EVENT_ATTR(ddr_hpr_req_with_nocredit,
> -					EVENT_HPR_REQ_WITH_NOCREDIT),
> +				 EVENT_DFI_OR_HPR_REQ_NOCRED),
>  	CN10K_DDR_PMU_EVENT_ATTR(ddr_lpr_req_with_nocredit,
> -					EVENT_LPR_REQ_WITH_NOCREDIT),
> +				 EVENT_RETRY_FIFO_FULL_OR_LPR_REQ_NOCRED),
>  	CN10K_DDR_PMU_EVENT_ATTR(ddr_bsm_alloc, EVENT_BSM_ALLOC),
>  	CN10K_DDR_PMU_EVENT_ATTR(ddr_bsm_starvation, EVENT_BSM_STARVATION),
>  	CN10K_DDR_PMU_EVENT_ATTR(ddr_win_limit_reached_rd,
> @@ -266,7 +306,8 @@ static ktime_t cn10k_ddr_pmu_timer_period(void)
>  	return ms_to_ktime((u64)cn10k_ddr_pmu_poll_period_sec * USEC_PER_SEC);
>  }
>=20
> -static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap)
> +static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap,
> +				     struct cn10k_ddr_pmu *ddr_pmu)
>  {
>  	switch (eventid) {
>  	case EVENT_HIF_RD_OR_WR ... EVENT_WAW_HAZARD:
> @@ -354,6 +395,8 @@ static int cn10k_ddr_perf_event_init(struct perf_even=
t *event)
>  static void cn10k_ddr_perf_counter_enable(struct cn10k_ddr_pmu *pmu,
>  					  int counter, bool enable)
>  {
> +	const struct ddr_pmu_platform_data *p_data =3D pmu->p_data;
> +	const struct ddr_pmu_ops *ops =3D p_data->ops;
>  	u32 reg;
>  	u64 val;
>=20
> @@ -363,7 +406,7 @@ static void cn10k_ddr_perf_counter_enable(struct cn10=
k_ddr_pmu *pmu,
>  	}
>=20
>  	if (counter < DDRC_PERF_NUM_GEN_COUNTERS) {
> -		reg =3D DDRC_PERF_CFG(counter);
> +		reg =3D DDRC_PERF_CFG(p_data->ddrc_perf_cfg_base, counter);
>  		val =3D readq_relaxed(pmu->base + reg);
>=20
>  		if (enable)
> @@ -373,19 +416,10 @@ static void cn10k_ddr_perf_counter_enable(struct cn=
10k_ddr_pmu *pmu,
>=20
>  		writeq_relaxed(val, pmu->base + reg);
>  	} else {
> -		val =3D readq_relaxed(pmu->base + DDRC_PERF_CNT_FREERUN_EN);
> -		if (enable) {
> -			if (counter =3D=3D DDRC_PERF_READ_COUNTER_IDX)
> -				val |=3D DDRC_PERF_FREERUN_READ_EN;
> -			else
> -				val |=3D DDRC_PERF_FREERUN_WRITE_EN;
> -		} else {
> -			if (counter =3D=3D DDRC_PERF_READ_COUNTER_IDX)
> -				val &=3D ~DDRC_PERF_FREERUN_READ_EN;
> -			else
> -				val &=3D ~DDRC_PERF_FREERUN_WRITE_EN;
> -		}
> -		writeq_relaxed(val, pmu->base + DDRC_PERF_CNT_FREERUN_EN);
> +		if (counter =3D=3D DDRC_PERF_READ_COUNTER_IDX)
> +			ops->enable_read_freerun_counter(pmu, enable);
> +		else
> +			ops->enable_write_freerun_counter(pmu, enable);
>  	}
>  }
>=20
> @@ -393,13 +427,18 @@ static u64 cn10k_ddr_perf_read_counter(struct cn10k=
_ddr_pmu *pmu, int counter)
>  {
>  	u64 val;
>=20
> +	const struct ddr_pmu_platform_data *p_data =3D pmu->p_data;
> +
>  	if (counter =3D=3D DDRC_PERF_READ_COUNTER_IDX)
> -		return readq_relaxed(pmu->base + DDRC_PERF_CNT_VALUE_RD_OP);
> +		return readq_relaxed(pmu->base +
> +				     p_data->ddrc_perf_cnt_value_rd_op);
>=20
>  	if (counter =3D=3D DDRC_PERF_WRITE_COUNTER_IDX)
> -		return readq_relaxed(pmu->base + DDRC_PERF_CNT_VALUE_WR_OP);
> +		return readq_relaxed(pmu->base +
> +				     p_data->ddrc_perf_cnt_value_wr_op);
>=20
> -	val =3D readq_relaxed(pmu->base + DDRC_PERF_CNT_VALUE(counter));
> +	val =3D readq_relaxed(pmu->base +
> +			    DDRC_PERF_REG(p_data->ddrc_perf_cnt_base, counter));
>  	return val;
>  }
>=20
> @@ -407,6 +446,7 @@ static void cn10k_ddr_perf_event_update(struct perf_e=
vent *event)
>  {
>  	struct cn10k_ddr_pmu *pmu =3D to_cn10k_ddr_pmu(event->pmu);
>  	struct hw_perf_event *hwc =3D &event->hw;
> +	const struct ddr_pmu_platform_data *p_data =3D pmu->p_data;
>  	u64 prev_count, new_count, mask;
>=20
>  	do {
> @@ -414,7 +454,7 @@ static void cn10k_ddr_perf_event_update(struct perf_e=
vent *event)
>  		new_count =3D cn10k_ddr_perf_read_counter(pmu, hwc->idx);
>  	} while (local64_xchg(&hwc->prev_count, new_count) !=3D prev_count);
>=20
> -	mask =3D DDRC_PERF_CNT_MAX_VALUE;
> +	mask =3D p_data->counter_max_val;
>=20
>  	local64_add((new_count - prev_count) & mask, &event->count);
>  }
> @@ -435,6 +475,8 @@ static void cn10k_ddr_perf_event_start(struct perf_ev=
ent *event, int flags)
>  static int cn10k_ddr_perf_event_add(struct perf_event *event, int flags)
>  {
>  	struct cn10k_ddr_pmu *pmu =3D to_cn10k_ddr_pmu(event->pmu);
> +	const struct ddr_pmu_platform_data *p_data =3D pmu->p_data;
> +	const struct ddr_pmu_ops *ops =3D p_data->ops;
>  	struct hw_perf_event *hwc =3D &event->hw;
>  	u8 config =3D event->attr.config;
>  	int counter, ret;
> @@ -454,8 +496,8 @@ static int cn10k_ddr_perf_event_add(struct perf_event=
 *event, int flags)
>=20
>  	if (counter < DDRC_PERF_NUM_GEN_COUNTERS) {
>  		/* Generic counters, configure event id */
> -		reg_offset =3D DDRC_PERF_CFG(counter);
> -		ret =3D ddr_perf_get_event_bitmap(config, &val);
> +		reg_offset =3D DDRC_PERF_CFG(p_data->ddrc_perf_cfg_base, counter);
> +		ret =3D ddr_perf_get_event_bitmap(config, &val, pmu);
>  		if (ret)
>  			return ret;
>=20
> @@ -463,11 +505,9 @@ static int cn10k_ddr_perf_event_add(struct perf_even=
t *event, int flags)
>  	} else {
>  		/* fixed event counter, clear counter value */
>  		if (counter =3D=3D DDRC_PERF_READ_COUNTER_IDX)
> -			val =3D DDRC_FREERUN_READ_CNT_CLR;
> +			ops->clear_read_freerun_counter(pmu);
>  		else
> -			val =3D DDRC_FREERUN_WRITE_CNT_CLR;
> -
> -		writeq_relaxed(val, pmu->base + DDRC_PERF_CNT_FREERUN_CTRL);
> +			ops->clear_write_freerun_counter(pmu);
>  	}
>=20
>  	hwc->state |=3D PERF_HES_STOPPED;
> @@ -512,17 +552,19 @@ static void cn10k_ddr_perf_event_del(struct perf_ev=
ent *event, int flags)
>  static void cn10k_ddr_perf_pmu_enable(struct pmu *pmu)
>  {
>  	struct cn10k_ddr_pmu *ddr_pmu =3D to_cn10k_ddr_pmu(pmu);
> +	const struct ddr_pmu_platform_data *p_data =3D ddr_pmu->p_data;
>=20
>  	writeq_relaxed(START_OP_CTRL_VAL_START, ddr_pmu->base +
> -		       DDRC_PERF_CNT_START_OP_CTRL);
> +		       p_data->ddrc_perf_cnt_start_op_ctrl);
>  }
>=20
>  static void cn10k_ddr_perf_pmu_disable(struct pmu *pmu)
>  {
>  	struct cn10k_ddr_pmu *ddr_pmu =3D to_cn10k_ddr_pmu(pmu);
> +	const struct ddr_pmu_platform_data *p_data =3D ddr_pmu->p_data;
>=20
>  	writeq_relaxed(END_OP_CTRL_VAL_END, ddr_pmu->base +
> -		       DDRC_PERF_CNT_END_OP_CTRL);
> +		       p_data->ddrc_perf_cnt_end_op_ctrl);
>  }
>=20
>  static void cn10k_ddr_perf_event_update_all(struct cn10k_ddr_pmu *pmu)
> @@ -547,8 +589,63 @@ static void cn10k_ddr_perf_event_update_all(struct c=
n10k_ddr_pmu *pmu)
>  	}
>  }
>=20
> +static void ddr_pmu_enable_read_freerun(struct cn10k_ddr_pmu *pmu, bool =
enable)
> +{
> +	const struct ddr_pmu_platform_data *p_data =3D pmu->p_data;
> +	u64 val;
> +
> +	val =3D readq_relaxed(pmu->base + p_data->ddrc_perf_cnt_freerun_en);
> +	if (enable)
> +		val |=3D DDRC_PERF_FREERUN_READ_EN;
> +	else
> +		val &=3D ~DDRC_PERF_FREERUN_READ_EN;
> +
> +	writeq_relaxed(val, pmu->base +	p_data->ddrc_perf_cnt_freerun_en);
> +}
> +
> +static void ddr_pmu_enable_write_freerun(struct cn10k_ddr_pmu *pmu, bool=
 enable)
> +{
> +	const struct ddr_pmu_platform_data *p_data =3D pmu->p_data;
> +	u64 val;
> +
> +	val =3D readq_relaxed(pmu->base + p_data->ddrc_perf_cnt_freerun_en);
> +	if (enable)
> +		val |=3D DDRC_PERF_FREERUN_WRITE_EN;
> +	else
> +		val &=3D ~DDRC_PERF_FREERUN_WRITE_EN;
> +
> +	writeq_relaxed(val, pmu->base +	p_data->ddrc_perf_cnt_freerun_en);
> +}
> +
> +static void ddr_pmu_read_clear_freerun(struct cn10k_ddr_pmu *pmu)
> +{
> +	const struct ddr_pmu_platform_data *p_data =3D pmu->p_data;
> +	u64 val;
> +
> +	val =3D DDRC_FREERUN_READ_CNT_CLR;
> +	writeq_relaxed(val, pmu->base + p_data->ddrc_perf_cnt_freerun_ctrl);
> +}
> +
> +static void ddr_pmu_write_clear_freerun(struct cn10k_ddr_pmu *pmu)
> +{
> +	const struct ddr_pmu_platform_data *p_data =3D pmu->p_data;
> +	u64 val;
> +
> +	val =3D DDRC_FREERUN_WRITE_CNT_CLR;
> +	writeq_relaxed(val, pmu->base + p_data->ddrc_perf_cnt_freerun_ctrl);
> +}
> +
> +static void ddr_pmu_overflow_hander(struct cn10k_ddr_pmu *pmu, int evt_i=
dx)
> +{
> +	cn10k_ddr_perf_event_update_all(pmu);
> +	cn10k_ddr_perf_pmu_disable(&pmu->pmu);
> +	cn10k_ddr_perf_pmu_enable(&pmu->pmu);
> +}
> +
>  static irqreturn_t cn10k_ddr_pmu_overflow_handler(struct cn10k_ddr_pmu *=
pmu)
>  {
> +	const struct ddr_pmu_platform_data *p_data =3D pmu->p_data;
> +	const struct ddr_pmu_ops *ops =3D p_data->ops;
>  	struct perf_event *event;
>  	struct hw_perf_event *hwc;
>  	u64 prev_count, new_count;
> @@ -586,11 +683,9 @@ static irqreturn_t cn10k_ddr_pmu_overflow_handler(st=
ruct cn10k_ddr_pmu *pmu)
>  			continue;
>=20
>  		value =3D cn10k_ddr_perf_read_counter(pmu, i);
> -		if (value =3D=3D DDRC_PERF_CNT_MAX_VALUE) {
> +		if (value =3D=3D p_data->counter_max_val) {
>  			pr_info("Counter-(%d) reached max value\n", i);
> -			cn10k_ddr_perf_event_update_all(pmu);
> -			cn10k_ddr_perf_pmu_disable(&pmu->pmu);
> -			cn10k_ddr_perf_pmu_enable(&pmu->pmu);
> +			ops->pmu_overflow_handler(pmu, i);
>  		}
>  	}
>=20
> @@ -629,13 +724,44 @@ static int cn10k_ddr_pmu_offline_cpu(unsigned int c=
pu, struct hlist_node *node)
>  	return 0;
>  }
>=20
> +static const struct ddr_pmu_ops ddr_pmu_ops =3D {
> +	.enable_read_freerun_counter =3D ddr_pmu_enable_read_freerun,
> +	.enable_write_freerun_counter =3D ddr_pmu_enable_write_freerun,
> +	.clear_read_freerun_counter =3D ddr_pmu_read_clear_freerun,
> +	.clear_write_freerun_counter =3D ddr_pmu_write_clear_freerun,
> +	.pmu_overflow_handler =3D ddr_pmu_overflow_hander,
> +};
> +
> +static const struct ddr_pmu_platform_data cn10k_ddr_pmu_pdata =3D {
> +	.counter_overflow_val =3D  BIT_ULL(48),
> +	.counter_max_val =3D GENMASK_ULL(48, 0),
> +	.ddrc_perf_cnt_base =3D CN10K_DDRC_PERF_CNT_VALUE_BASE,
> +	.ddrc_perf_cfg_base =3D CN10K_DDRC_PERF_CFG_BASE,
> +	.ddrc_perf_cnt_op_mode_ctrl =3D CN10K_DDRC_PERF_CNT_OP_MODE_CTRL,
> +	.ddrc_perf_cnt_start_op_ctrl =3D CN10K_DDRC_PERF_CNT_START_OP_CTRL,
> +	.ddrc_perf_cnt_end_op_ctrl =3D CN10K_DDRC_PERF_CNT_END_OP_CTRL,
> +	.ddrc_perf_cnt_end_status =3D CN10K_DDRC_PERF_CNT_END_STATUS,
> +	.ddrc_perf_cnt_freerun_en =3D CN10K_DDRC_PERF_CNT_FREERUN_EN,
> +	.ddrc_perf_cnt_freerun_ctrl =3D CN10K_DDRC_PERF_CNT_FREERUN_CTRL,
> +	.ddrc_perf_cnt_freerun_clr =3D 0,
> +	.ddrc_perf_cnt_value_wr_op =3D CN10K_DDRC_PERF_CNT_VALUE_WR_OP,
> +	.ddrc_perf_cnt_value_rd_op =3D CN10K_DDRC_PERF_CNT_VALUE_RD_OP,
> +	.ops =3D &ddr_pmu_ops,
> +};
> +
> +static const struct ddr_pmu_data ddr_pmu_data =3D {
> +	.id   =3D DDR_PMU_V1,
> +};
> +
>  static int cn10k_ddr_perf_probe(struct platform_device *pdev)
>  {
> +	const struct ddr_pmu_data *dev_data;
>  	struct cn10k_ddr_pmu *ddr_pmu;
>  	struct resource *res;
>  	void __iomem *base;
>  	char *name;
>  	int ret;
> +	int version;
>=20
>  	ddr_pmu =3D devm_kzalloc(&pdev->dev, sizeof(*ddr_pmu), GFP_KERNEL);
>  	if (!ddr_pmu)
> @@ -644,30 +770,42 @@ static int cn10k_ddr_perf_probe(struct platform_dev=
ice *pdev)
>  	ddr_pmu->dev =3D &pdev->dev;
>  	platform_set_drvdata(pdev, ddr_pmu);
>=20
> +	dev_data =3D device_get_match_data(&pdev->dev);
> +	if (!dev_data) {
> +		dev_err(&pdev->dev, "Error: No device match data found\n");
> +		return -ENODEV;
> +	}
> +	version =3D dev_data->id;
> +	ddr_pmu->version =3D version;
> +
>  	base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>=20
>  	ddr_pmu->base =3D base;
>=20
> -	/* Setup the PMU counter to work in manual mode */
> -	writeq_relaxed(OP_MODE_CTRL_VAL_MANNUAL, ddr_pmu->base +
> -		       DDRC_PERF_CNT_OP_MODE_CTRL);
> -
> -	ddr_pmu->pmu =3D (struct pmu) {
> -		.module	      =3D THIS_MODULE,
> -		.capabilities =3D PERF_PMU_CAP_NO_EXCLUDE,
> -		.task_ctx_nr =3D perf_invalid_context,
> -		.attr_groups =3D cn10k_attr_groups,
> -		.event_init  =3D cn10k_ddr_perf_event_init,
> -		.add	     =3D cn10k_ddr_perf_event_add,
> -		.del	     =3D cn10k_ddr_perf_event_del,
> -		.start	     =3D cn10k_ddr_perf_event_start,
> -		.stop	     =3D cn10k_ddr_perf_event_stop,
> -		.read	     =3D cn10k_ddr_perf_event_update,
> -		.pmu_enable  =3D cn10k_ddr_perf_pmu_enable,
> -		.pmu_disable =3D cn10k_ddr_perf_pmu_disable,
> -	};
> +	if (version =3D=3D DDR_PMU_V1) {
> +		/* Setup the PMU counter to work in manual mode */
> +		writeq_relaxed(OP_MODE_CTRL_VAL_MANUAL, ddr_pmu->base +
> +			       (ddr_pmu->p_data->ddrc_perf_cnt_op_mode_ctrl));
> +
> +		ddr_pmu->pmu =3D (struct pmu) {
> +			.module       =3D THIS_MODULE,
> +			.capabilities =3D PERF_PMU_CAP_NO_EXCLUDE,
> +			.task_ctx_nr =3D perf_invalid_context,
> +			.attr_groups =3D cn10k_attr_groups,
> +			.event_init  =3D cn10k_ddr_perf_event_init,
> +			.add         =3D cn10k_ddr_perf_event_add,
> +			.del         =3D cn10k_ddr_perf_event_del,
> +			.start       =3D cn10k_ddr_perf_event_start,
> +			.stop        =3D cn10k_ddr_perf_event_stop,
> +			.read        =3D cn10k_ddr_perf_event_update,
> +			.pmu_enable  =3D cn10k_ddr_perf_pmu_enable,
> +			.pmu_disable =3D cn10k_ddr_perf_pmu_disable,
> +		};
> +
> +		ddr_pmu->p_data =3D &cn10k_ddr_pmu_pdata;
> +	}
>=20
>  	/* Choose this cpu to collect perf data */
>  	ddr_pmu->cpu =3D raw_smp_processor_id();
> @@ -688,7 +826,7 @@ static int cn10k_ddr_perf_probe(struct platform_devic=
e *pdev)
>  	if (ret)
>  		goto error;
>=20
> -	pr_info("CN10K DDR PMU Driver for ddrc@%llx\n", res->start);
> +	pr_info("DDR PMU Driver for ddrc@%llx\n", res->start);
>  	return 0;
>  error:
>  	cpuhp_state_remove_instance_nocalls(
> @@ -711,7 +849,7 @@ static int cn10k_ddr_perf_remove(struct platform_devi=
ce *pdev)
>=20
>  #ifdef CONFIG_OF
>  static const struct of_device_id cn10k_ddr_pmu_of_match[] =3D {
> -	{ .compatible =3D "marvell,cn10k-ddr-pmu", },
> +	{ .compatible =3D "marvell,cn10k-ddr-pmu", .data =3D &ddr_pmu_data},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, cn10k_ddr_pmu_of_match);
> @@ -719,7 +857,7 @@ MODULE_DEVICE_TABLE(of, cn10k_ddr_pmu_of_match);
>=20
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id cn10k_ddr_pmu_acpi_match[] =3D {
> -	{"MRVL000A", 0},
> +	{"MRVL000A", (kernel_ulong_t)&ddr_pmu_data},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(acpi, cn10k_ddr_pmu_acpi_match);
> --
> 2.25.1


