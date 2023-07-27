Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BB8765BD2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 21:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjG0TEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 15:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjG0TEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:04:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E42AC;
        Thu, 27 Jul 2023 12:04:01 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RHF7qA024747;
        Thu, 27 Jul 2023 19:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=hENrxXQ7kBYfuBAhEpCjuy1wKVmAij1FEKLsu6EQPLg=;
 b=fJ+SJcvzW34JiJl9TgucPtz/qK6KRq/PzshvgXGSv+jei8xnvU/FTyrUn2TOtEh4x8Kb
 FImGX5jBhsyn29ThArLrsGK33GmOvuKz7jd1zbIo8HDkL3GtQWdvG27lFmR0O/+BDtZU
 IzS4WlB/mYxpil39siLhEft09wexTpDC8mbT1aN3rnSCBw7OLdt/lyNg93l3c1p5l/E8
 wsjGaSQjvBlgoSJxKmjxquPi+gXdag66nHev1m2bKo7lPL1a1jt0QljdAAICl4KLbck8
 U32JmJQOWXGlUmDxk7Fn38Th98ELWRgpcGtT2Qcy+6sjBjxKnnItf+9X18LHl2Re3G/u Gg== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3mpt1ma9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 19:03:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCe56CebzbWIH8Muq7FHa08j2Fn9zqLdblWoWWOGRlVOjJzxJ1NETXOtf1C/R1nxvbs+4f5HX3DqCoeIsO1W6qAbET5cvAJMk3JgIdFAfhLtcLPpf90Tzbf0qH6rRbwkE3GBbNzEaWhnAJG7qXALMcoUUoD5VQKbeOMO+deqJ4VMJpHGCuE8ljAHYqKBJpB1QJj3sdGJeW4YlHpmz8DTMXOBD50VwUb2wOK3pVsO13kFRM5G/C6/ImrLZuv1Tjplihm8/Y2iyfceTiHs15EoISYrDXt6TtjTS69BBi5rgmk+tmq1nkqJrdjP0KLPhxJ8A+qOZ+w3Z2hFKa9kdmIx5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hENrxXQ7kBYfuBAhEpCjuy1wKVmAij1FEKLsu6EQPLg=;
 b=gYeEOliEwT01fMKyD9Pc+ZrxWAltucRYhoeiB3sFdR9xZumuUvzAqbHlzOqyWH9pIAaFTqFsCkmp0h13RxmtDQDwysDM1/nkmTa0e8vwXW3CceVqfHzaJWx0wnS1zQss0HiJVdM+Omztws85jhGIT9pwoVYplojbD5Nv8G1hmzFJXDloztT0vl2CIsOehQOide6iJjzL/NnTSqzOLmmvwXGDDniXz/9+eNvzTX1kYDPGjTg5sB9Mzd9ccv8r6b7pjKKUwqRUSO60Vy8Z0WS+P0Cm73AvvBFdnUOEneekjadc6gvJ2+YjTxmkKjvIs4rE+c09YlUTCDkptv3cfaSy2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH0PR02MB8073.namprd02.prod.outlook.com (2603:10b6:610:106::20)
 by CO6PR02MB7828.namprd02.prod.outlook.com (2603:10b6:303:a8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Thu, 27 Jul
 2023 19:03:42 +0000
Received: from CH0PR02MB8073.namprd02.prod.outlook.com
 ([fe80::a49d:fb7f:4c28:a2ed]) by CH0PR02MB8073.namprd02.prod.outlook.com
 ([fe80::a49d:fb7f:4c28:a2ed%7]) with mapi id 15.20.6652.004; Thu, 27 Jul 2023
 19:03:42 +0000
From:   "Pawandeep Oza (QUIC)" <quic_poza@quicinc.com>
To:     'Sudeep Holla' <sudeep.holla@arm.com>,
        "Pawandeep Oza (QUIC)" <quic_poza@quicinc.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Jamie Iles <jiles@qti.qualcomm.com>
Subject: RE: [PATCH] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast
 timer
Thread-Topic: [PATCH] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast
 timer
Thread-Index: AQHZtOXPWJW8A9EhYUWJUYorSZkKy6+/jquAgA6BpPE=
Date:   Thu, 27 Jul 2023 19:03:42 +0000
Message-ID: <CH0PR02MB8073B417648AB9DE5D8E25B2F601A@CH0PR02MB8073.namprd02.prod.outlook.com>
References: <20230712172458.2507434-1-quic_poza@quicinc.com>
 <20230718133201.qsulwupte6l6bmdm@bogus>
In-Reply-To: <20230718133201.qsulwupte6l6bmdm@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8073:EE_|CO6PR02MB7828:EE_
x-ms-office365-filtering-correlation-id: bd68210a-9d8c-4b56-c0c8-08db8ed43207
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gBNuK65HiZVa23YMQo4FMubw+/ZMlplH6IawtuaufyhMIVyTifl+iqKYyXcU1AIji4WNn+24lK8VjtXY9xtPa8YuIkq00EEc4tjwQPjqbL1tSGq1fm9WHH9kIA1Irjpi2CibP0sW6h2pACLYW9kdToACTPKwGBM9S+xrYU8Y9/2JpKr9O+viSalMc8BC+CeyZE/67vdZiqJE9cK9QhaDuHEm5h4JNBAx+Ijj/wpYVeWxXQOHVwSH9W4A/2u/TukKQt0522Lcqt7V/RCUH3/SjIyIHb+M3nTKRq/6FKiR5nw0pUypygVyw+izQLrUx2ojQ0yU4ieHdN83n05jsTO658HKPIZ6e7bEQUYVEa3NXUdLeXKeMvHmgic+sat8m6ET84Br8DLYPImZwElm3mavCY0roGhfPyJZeHhVvtxO+lPsqfe6JUzk1jfQK4/PIe249DPePyzPwEHJyhx4Oh5QjlW2SqyXR/wdPjOuirG3KLmfKxZ4JQwIx7Gqw2t2l0CdPxfSbQNIeF15FS/2czMG+OwBZZwwAXbo39tMDCFKLbHxGceUCFK9imBVoGwHK8J6MtJpmjL5afBkxkdm+P8ywL4Aso7Dhg+fTlDl870MFWI+EthWhRqlZojakn+ImY5f
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8073.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199021)(2906002)(316002)(8936002)(8676002)(52536014)(5660300002)(38070700005)(41300700001)(33656002)(55016003)(86362001)(7696005)(71200400001)(122000001)(54906003)(478600001)(26005)(6506007)(107886003)(53546011)(186003)(110136005)(9686003)(83380400001)(66946007)(76116006)(38100700002)(66556008)(4326008)(66446008)(64756008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JmnH7m8mIzCn27RlwdFnXVGb3oHE5GxfGSkKpEFP6r2KBfYK4YWJFgryszHY?=
 =?us-ascii?Q?Sbsy9LQcScyQXvL4zveuI+0I+z3NkPtK4fdlK0UINIG2OwtLLkj7uLudpS+B?=
 =?us-ascii?Q?IuVCRGJH3f8MRxB5PMHpR65bxzKvmHrA22u15d2AJzM03nG99w72VYax3fx9?=
 =?us-ascii?Q?sXnlFIZwtXAcwtsdUln4/4krg88MhnRo0KnNYNXE75hU0yPtLYayOi7NbZGe?=
 =?us-ascii?Q?TujJuwsS6sNjLH+wyNb933BYJlq13qJrwucUX0KLwqUycmszFTzPyoFGEeMq?=
 =?us-ascii?Q?GmrG3D5yUdlyWTqpgbkyDMuGHVMZVU8VwvJcvwWgqRm2xatOoKV5E8fhFmAi?=
 =?us-ascii?Q?/ytef4Fo2zNOd5iyWhIiTFvLMHcZ4PArM8wY9N9ELYpgtYnOvT5qTJJ2c2eQ?=
 =?us-ascii?Q?JEouR3mhEriPqzIgUjbNeUy5POnI4Vz8w8m+vXCy0T1x2ERMJUhDDtw9zRLP?=
 =?us-ascii?Q?3+7amBEExDCQXQ2ZXqNmCnALLxLH3jgR+slGqgXXgteinB8s+wSo7NLVDRPq?=
 =?us-ascii?Q?jrKwU/B62OQjF6Z09EWt6LXB4j0hxT+yKfYmCNHvrBMZP1jSWdiwkSAed5cL?=
 =?us-ascii?Q?7r3Flfk+zSbA3lwAks0IYzi7THH0Umf/6HObxi7kJnccp4WwW8CsBCKbqDcX?=
 =?us-ascii?Q?xUTKnFDwT4T7W5ndjzrMMyvvzVZWha5Oi3ZvgvZVpsk9+QbI7Y0f5CflNtiv?=
 =?us-ascii?Q?xIGdBjFQ36A7z5MJqr8Ri7vZsplT1n1Oei6uEyC9+jnKPT2Tn+7LipYcnjio?=
 =?us-ascii?Q?0YoxHguelPjhghI1v/LH9dPmWyIYi9AzeBePYFc3JUZJRJooHn1Zh0ZoV5vm?=
 =?us-ascii?Q?NgfwICUEYfqm1yYsZBMJ7uGzeVtyNpp67dT25waG69hg9jw014dFh3d5eTOw?=
 =?us-ascii?Q?Jd8Ld8HlXEdhh1pegl3wGtLzS980oSO1zOx1/tB1B8G+ugu5AfIHDBn7Oecr?=
 =?us-ascii?Q?PEeb7f7EuDtByFb7gkiBMuDYMkmRPcMuPusildiultO0+dxx6d19T5IrHj2l?=
 =?us-ascii?Q?9rkygLGc0w0hUV5ALqyPR6z+93kJV+aG/018pchSnPc2PPWvnGdR4y+ylCIo?=
 =?us-ascii?Q?ldRa9mRJkiAf/px5rjVIEaBry1roXNLUnuWpIDjbidOjaIR3NxnWDalnAOvb?=
 =?us-ascii?Q?1JHuMMfTWDlRZJV6EGIlGcgYy1OmtTENyWyQkpISiOTmZI0RD4ftDlELvVPq?=
 =?us-ascii?Q?BazDWFmR8cwpqt+TF3eglPHuVK0SM1MWnR4I8OA36DWyhuyNzbdX6TI68iIp?=
 =?us-ascii?Q?qzaBGh6fLAc0qg3K0y7rIwTaH0HlFxcY8tFX9RfaLwD0Z6FNY/r9rfcTcpkE?=
 =?us-ascii?Q?0Iy1I14gTcv2+qfe1XJ+P/OorjBSzMYjZ2RkOaJhTxI5W+rrb3k6XSMlKt0b?=
 =?us-ascii?Q?Ara2l+oXtz1G1JZfDrpbui8zlzGgGfgr5KQf3CXDWz9RRCvYCHipVxWZ51N7?=
 =?us-ascii?Q?EMxXfVbgknE8SoSBtqsTchuketQEMaYplJg08GKNkxdOAJhwhnt4EuIFZme6?=
 =?us-ascii?Q?7QoqpVMmDd5Jv657WQyuU4dAz3qF7G38EW/isJuDU82RN8GD/ZumEZ7OifNB?=
 =?us-ascii?Q?qff7B/wnIjx4S7WTHbBB/9gWvPinrwM/QkXkiy9C?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: m6eGV98lQSyeQpyt9wqbplH383N7M1QNIZWBbXrkv3egIQrEJpauXZuGWBuD3AUrCf4OHB7UXJ4JMn2JaG+pvzIaLa8l2uhFl8viNCA7uzvyAjRy5pIlNQBebSgR3UqxIYjxyM90vEYB+g86rUw6+lrjWwA49v80LQWWDrkQW3EWkfykxqzmlM10+v5zkledILE3HyxguzDGfEtzDRoxRps7P5fn2yRy0jya3QSZmxlYk7VHL2U12bi56UkIhbBDUTntQQPLPIIjI+MpRRMAN6m9BMFE6iCxfjlZRcEg4SM5hxe6thJVc1QlxFLCFnFABWk054zEulEZSCWLAWeguifh7FB6alf+vXdu03g+Qndk259jlbLB44/DTVapMSK2c9nX4rwkDcqMR/WSGjQ8BfDfM1KB6EpTlaGH+b1zQ2V2ZxJYYGQ/4PoYvVLbAKlTJ2w6bdvMw2P24i0T303xMBbUF9k8TqPHJ+h2d55k5G1xkfLBb6GGh6snyTKmiV7EJp7+szgTP4ZL+T42pyoi4m3Hum9Gdqu+R5T41B51ypF6BX4tfCGkoL0W7Mx3pKf3ysH0t6/9ODxDObtPneLR/caZ10VEvCjf4UY1szGfJ8YQG7vIkVgZn4iNQJgvLQ5SQTZ4b7VkINw4joH0Dkeymi3RKo6+lOzVJFivZqH3WN9D+/0jJZdZJJieeHuLTXfo7grwdh10vDSTFLsOQA1X2Ab6SeJe57WNdg0Su2bkuk36qASfEuciaKICge035YRxGUS5SyCLBkA2ERfbFfU8E1/uDLDukXToRJ7oRiFL1qy1b+4HaJ/dfYYBJ4BE0M7P9FTYya+B0nNqIT/ZLuCRmNQEtf73wKoWnNenCZGXqDjXnSwz8yJmzUwEnj0A6lHv
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8073.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd68210a-9d8c-4b56-c0c8-08db8ed43207
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 19:03:42.6200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4hOocztFFjRx3/qip+tEvRYSQQfQo71N1iQOMS+Au9C3Ttp1RAy3enDgzo9R4BIqSbiPM0IfXg72Hb0qprvww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7828
X-Proofpoint-ORIG-GUID: yNMdiw8yW72Mm8ami4SomplHvUKBC3go
X-Proofpoint-GUID: yNMdiw8yW72Mm8ami4SomplHvUKBC3go
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_09,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 mlxlogscore=452
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307270172
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

Please find my comments inline.

Regards,
Oza.

-----Original Message-----
From: Sudeep Holla <sudeep.holla@arm.com>=20
Sent: Tuesday, July 18, 2023 6:32 AM
To: Pawandeep Oza (QUIC) <quic_poza@quicinc.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>; Will Deacon <will@kernel.org=
>; Sudeep Holla <sudeep.holla@arm.com>; Rafael J . Wysocki <rafael@kernel.o=
rg>; Len Brown <lenb@kernel.org>; linux-arm-kernel@lists.infradead.org; lin=
ux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org; Jamie Iles <jiles@qt=
i.qualcomm.com>
Subject: Re: [PATCH] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast t=
imer

On Wed, Jul 12, 2023 at 10:24:58AM -0700, Oza Pawandeep wrote:
> Arm(r) Functional Fixed Hardware Specification defines LPI states, which=
=20
> provides an architectural context loss flags field that can be used to=20
> describe the context that might be lost when an LPI state is entered.
>=20
> - Core context Lost
> 	- General purpose registers.
> 	- Floating point and SIMD registers.
> 	- System registers, include the System register based
> 	- generic timer for the core.
> 	- Debug register in the core power domain.
> 	- PMU registers in the core power domain.
> 	- Trace register in the core power domain.
> - Trace context loss
> - GICR
> - GICD
>=20
> Qualcomm's custom CPUs preserves the architectural state, including=20
> keeping the power domain for local timers active.
> when core is power gated, the local timers are sufficient to wake the=20
> core up without needing broadcast timer.
>=20
> The patch fixes the evaluation of cpuidle arch_flags, and moves only=20
> to broadcast timer if core context lost is defined in ACPI LPI.
>=20
> Signed-off-by: Oza Pawandeep <quic_poza@quicinc.com>
>=20
> diff --git a/arch/arm64/include/asm/acpi.h=20
> b/arch/arm64/include/asm/acpi.h index bd68e1b7f29f..9c335968316c=20
> 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -42,6 +42,24 @@
>  #define ACPI_MADT_GICC_SPE  (offsetof(struct acpi_madt_generic_interrupt=
, \
>  	spe_interrupt) + sizeof(u16))
> =20
> +/*
> + * Arm(r) Functional Fixed Hardware Specification Version 1.2.
> + * Table 2: Arm Architecture context loss flags  */
> +#define CPUIDLE_CORE_CTXT		BIT(0) /* Core context Lost */
> +
> +#ifndef arch_acpi_lpi_timer_stopped
> +static __always_inline bool arch_acpi_lpi_timer_stopped(u32=20
> +arch_flags)

As mentioned by you above, the core context is not just timer context, so c=
alling this function so is misleading.

 Oza: Will take care of you last 2 comments, probably this should be taken =
care as well with that.

> +{
> +  return arch_flags & CPUIDLE_CORE_CTXT; } #define=20
> +arch_acpi_lpi_timer_stopped arch_acpi_lpi_timer_stopped #endif
> +
> +#define CPUIDLE_TRACE_CTXT		BIT(1) /* Trace context loss */
> +#define CPUIDLE_GICR_CTXT		BIT(2) /* GICR */
> +#define CPUIDLE_GICD_CTXT		BIT(3) /* GICD */
> +

Do we really need to define these unused bitfields ? DO you have plans to u=
se them ?

Oza: this is basically defined in ARM FFH - I think no harm is having them =
here for sake of completeness.

>  /* Basic configuration for ACPI */
>  #ifdef	CONFIG_ACPI
>  pgprot_t __acpi_get_mem_attribute(phys_addr_t addr); diff --git=20
> a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c index=20
> 9718d07cc2a2..8ea1f2b3bf96 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1221,7 +1221,7 @@ static int acpi_processor_setup_lpi_states(struct a=
cpi_processor *pr)
>  		strscpy(state->desc, lpi->desc, CPUIDLE_DESC_LEN);
>  		state->exit_latency =3D lpi->wake_latency;
>  		state->target_residency =3D lpi->min_residency;
> -		if (lpi->arch_flags)
> +		if (arch_acpi_lpi_timer_stopped(lpi->arch_flags))

While setting CPUIDLE_FLAG_TIMER_STOP if any flags set is already questiona=
ble, checking for arch specific flag in the generic code is even more quest=
ionable now. I wonder if it makes more sense to have a arch specific helper=
 to update the state->flags based on how arch specific interpretation of lp=
i->arch_flags ?

>  			state->flags |=3D CPUIDLE_FLAG_TIMER_STOP;
>  		if (i !=3D 0 && lpi->entry_method =3D=3D ACPI_CSTATE_FFH)
>  			state->flags |=3D CPUIDLE_FLAG_RCU_IDLE; diff --git=20
> a/include/linux/acpi.h b/include/linux/acpi.h index=20
> d584f94409e1..b24f1cd1cebb 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1471,6 +1471,14 @@ static inline int=20
> lpit_read_residency_count_address(u64 *address)  }  #endif
> =20
> +#ifndef arch_acpi_lpi_timer_stopped
> +static __always_inline bool arch_acpi_lpi_timer_stopped(u32=20
> +arch_flags) {
> +  return (arch_flags !=3D 0);
> +}
> +#define arch_acpi_lpi_timer_stopped arch_acpi_lpi_timer_stopped=20
> +#endif
> +

This looks ugly and main reason for my above comment. I am thinking of arch=
_update_idle_state_flags(lpi->arch_flags, &state->flags) and make it do not=
hing on non arm platforms. I don't think we will be breaking anything(i.e. =
no need to check arch_flags !=3D 0. It is incorrect strictly speaking but t=
here are no non-arm users ATM, but that doesn't mean we can trickle the arc=
h specific LPI FFH details into the generic code.

Oza: Let me work on above 2 comments and post the new patch.

--
Regards,
Sudeep
