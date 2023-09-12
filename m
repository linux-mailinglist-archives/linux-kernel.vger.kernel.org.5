Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E6779C704
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjILGgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjILGgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:36:44 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A9CE75;
        Mon, 11 Sep 2023 23:36:40 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38C2Ekin032077;
        Tue, 12 Sep 2023 02:36:16 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3t15uen3hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 02:36:15 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6xClgStPgZG77tlVAtLVrZ/Q9nYtdRHM/pjZH1kWbc6ZY6bSI+EV16Ofa+x54e6n+eKct4yMcqIMdejCUtHo9aLC8O0AkCqXpdZQ60Hjanp5nJRURQxM/QitPEPIn680Ep4mcNHbpC6wiaadPknVWUcPDQS6+ZH7OEYd7RlXBeMbr0E2CLNBtwj/9Ad1LDqfEnHgkZBe3hVKOOLXLkbS4pTyKI891OIVJ5AVlKoEQnhKgI4VtiFkPpZaziphl65juqBMMY504umkwf6q6urMOi4FaqjgpGo0+jwEkPMVVUmBtCRoHvlUJDFWevmVIkllWYHA2sbf5ZSveKIuWe8iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzC8GVeeXGvdjV+XI9+NLp+OIgP346t7vYtOeyN9jU0=;
 b=ZT4AAxHNNI5B4FhLUABdiRyChyldMTCbKts7+FgjEnTs+FdCvfgPAYfD1zHsEzot4xuURcpp4I4OT5bUiiz1uFvHwRJ2T2KJ4s4DOaPapY6xfpH3Lx+NvNyFkUrfr1QeYKZap9LOnXDaahgf8vqZwwbb8R0PgEzgGs6pfQ9WuUsmBBLjPrXO+LxBtL+Sb/4mm4dhuLvU0GL6TlD8CxLpWfo7VmwfN9OhBty38YwJ0Ui/W8erzTyo+0OBV+5qkZmTTCE5QYQv2h1y+WtU6aiz8A1+ee2UkJxvWo1dR2y1qokPeg6fUy2q90qmr1FkEpzBjbcpwO7fmeYq02IXc+f+kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzC8GVeeXGvdjV+XI9+NLp+OIgP346t7vYtOeyN9jU0=;
 b=KlmGykMEbdZ96OLptuX0F6NTm8fGG9vKo+5XKxg63eXa+w5+xcm53QI8HR910PEgaKlGW5jIF6DaHf0bWKOtgfXWnxushNi7/xmOvRptE8gXT1SZ4lx4O4pTNHnZ3PbM4ZE290DUnTTn9hRvHjTEebpyFHW6Ov0D43hKGA7krjk=
Received: from SN7PR03MB7132.namprd03.prod.outlook.com (2603:10b6:806:352::6)
 by DM6PR03MB5340.namprd03.prod.outlook.com (2603:10b6:5:24d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 06:36:11 +0000
Received: from SN7PR03MB7132.namprd03.prod.outlook.com
 ([fe80::4a36:f52e:cc42:6fa4]) by SN7PR03MB7132.namprd03.prod.outlook.com
 ([fe80::4a36:f52e:cc42:6fa4%7]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 06:36:11 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Conor Dooley <conor@kernel.org>,
        "Cusco, Ana-Maria" <Ana-Maria.Cusco@analog.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2]  dt-bindings: iio: hmc425a: add entry for HMC540S
Thread-Topic: [PATCH 2/2]  dt-bindings: iio: hmc425a: add entry for HMC540S
Thread-Index: AQHZ0DIjP0cvfmpXrkurCac6jJgdRa/s/boAgCnoftA=
Date:   Tue, 12 Sep 2023 06:36:11 +0000
Message-ID: <SN7PR03MB7132732C9DB517378897DADA8EF1A@SN7PR03MB7132.namprd03.prod.outlook.com>
References: <20230816110906.144540-1-ana-maria.cusco@analog.com>
 <20230816110906.144540-2-ana-maria.cusco@analog.com>
 <20230816-stoop-exonerate-148c7bdc01c2@spud>
In-Reply-To: <20230816-stoop-exonerate-148c7bdc01c2@spud>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWhlbm5lcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1hODY2OGY2My01MTM2LTExZWUtYjgwYy1iY2Yx?=
 =?us-ascii?Q?NzFjNDc2MTlcYW1lLXRlc3RcYTg2NjhmNjUtNTEzNi0xMWVlLWI4MGMtYmNm?=
 =?us-ascii?Q?MTcxYzQ3NjE5Ym9keS50eHQiIHN6PSI2MDM0IiB0PSIxMzMzODk3NDE3MDA2?=
 =?us-ascii?Q?NTMxODciIGg9Imp3d2ZGS0NFYWFWengwM1FFcUlySW54aVU3dz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?Q0RvTDlxUStYWkFjNWVsUlJMUjcwdXpsNlZGRXRIdlM0REFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBbEdUR1ZnQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR03MB7132:EE_|DM6PR03MB5340:EE_
x-ms-office365-filtering-correlation-id: e4988632-cb38-4152-7835-08dbb35a8e19
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xXFplynLwdfEe2BjFI7+b0eiCxy0huW9Sh/lV7GWIVsXy0j/oX7X6s6YrLjiPYJ529ydZ8PiCU3OYxmDxjHNWcZNpUwG5fChulMdBHm2/wseAL2I3jV9YWbLiRXc/H8KoqDBcHTbMyC8nUL5oT116r93dQC3fdkndqfG7gUbSfTShYljUgYPfB+0HgWRTdcUTOrZUnBnXTNWvHf+Fdq7pGeayK4U4DRSv/7FarXbQIBbx7G/rUVKFQGFsF64u5Nu7uazoABQQgiSD7NzO9YkyuDPAh0B5FRxd0L43ZVySDY0KGS+URyl1zam77h97QT/db19OFtDy7MyFYSjBhNFr7TpHRQsNQ0q8yC47OognzDSS42K+Zg/RYe/0bQl4U0xhthWruBn7KvvApbV2wq0ski+ZaqZoii96ZG+gtWo5TwXlaeJjpbr7mCQt9vn4pYPxr55HClbbD6hWX3Ujl2TQUfUo85kki76Cuy5XwAm3mSLltN4Ko6WypsK/v/W/EvuBnbMUGwjQoKEjVpirrt+XAjeC2phkLXO51KHQ0HJd7HzLJrPw1uGretsW6Dz5c2y3CF30YBlEQLIXbNGj02n8bd15f7xseRpeFFKhylb5Xs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR03MB7132.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(1800799009)(186009)(451199024)(66899024)(9686003)(55016003)(7696005)(6506007)(53546011)(33656002)(2906002)(64756008)(26005)(38070700005)(38100700002)(66446008)(41300700001)(110136005)(52536014)(4326008)(54906003)(8676002)(66556008)(76116006)(6636002)(316002)(66476007)(8936002)(66946007)(5660300002)(71200400001)(478600001)(966005)(122000001)(83380400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZZlqsIBb9DC3I0SoC4oN1A0AV0JV4u7iP4ppOKWPu2x6nG4m036msuJEjfzv?=
 =?us-ascii?Q?F3Od5RRDjhE6/ttnvUkkKjRnVVu8k3bIgCiG3UXyjwsf5RubvXqJj3KIKDQw?=
 =?us-ascii?Q?mxTt8D1uBGqHW7j7y9nKmq/uNiimJKoRhn8JLpQbeq2EgrbQVfPc3iFbv+aq?=
 =?us-ascii?Q?QYyhFbp7zTaca/lAGdGEMOiiKCGbKobsBabfcoTHOSD1me80HMMkTEVfnCeE?=
 =?us-ascii?Q?QNAqxqpdTkYn4FbGJe6fsctlI6zYgGhsrqtQFAdLJ//g6kSaPYeZWyoMHtTS?=
 =?us-ascii?Q?2ZyqVlZlbsoGJ5UsDB7JvJUKJn5+AaNL1LlDNM3dGjueldLUk1M4GGYMfhIr?=
 =?us-ascii?Q?XFql+TeYe/k3t+cmKojvZ3bGetJ61VTmRBcqv2aWbEgJEt2BNdgXxBqU+7sU?=
 =?us-ascii?Q?aPboqGtX1yCyAPHmwtwYPjEgCkK2MN0AF7V5i8GAbLjFXSZBvJ2mO6BDjCb7?=
 =?us-ascii?Q?AnsPu1efWQKwcnUTFgpSO8Mn2sMjgncg7rb/KPvUX0fXWnIkYqQskV0sZs4Y?=
 =?us-ascii?Q?C5XymNtQOY3ttMCSyZe/a5U+89WixPjH0gCmyeVOU5pn6UCX1X2ol4wuXvxp?=
 =?us-ascii?Q?MSG45KgROeRfluKruP+1XBNvxe3Dfb7RQKtLZd7PeyXl83s3lfXroEtdzFnl?=
 =?us-ascii?Q?M5We2RYSk8+t97Bt1/Xw5jsIvmwyOFlqcd6+zPJHDQHjOxlKnPDsymkrltwx?=
 =?us-ascii?Q?i1st4YQFADNA6fTKymqhfFpsEUr2FV8IMUuFbB0Hc1IPfBojS/Hi0KZP7aHC?=
 =?us-ascii?Q?QclWcC8gkUJIbcuHXIL7Xc4Uzdrmw0NmjOJAS8etGGVTD3BIe+Zh24DAASCP?=
 =?us-ascii?Q?rFPiVWceX/2sdfX94ntDj6cYDxgfJ/TXf8v10kxgm8IsoXaMXcvzib/Zns4o?=
 =?us-ascii?Q?gs/LjWRhILpwavtXWJtaqwvx7vXa2NmvpWB+Uz09t1ZFeU8UpkGCfzXjr4+0?=
 =?us-ascii?Q?SsXBg4QX/a8TGKGn01ngfHviInn4Kl3LpFQ33FzPL5KIYEZbnkjKDYu70dO1?=
 =?us-ascii?Q?DNpG4HjOafd84hpbiKgRVz4aAEmpknJqKICsHXOw2WU6Y6V8IgpsWZWLOWp9?=
 =?us-ascii?Q?r2Y7D6exLa0J4EWrKnxc1kbh5ziqq8AIxxPe4rpPn019bWnBGsacTcYaQSIu?=
 =?us-ascii?Q?c82bPwMGiGLWl5MJkie45WaMyg3LOcnkJ0xOorLWCVmt+FsadjCYXArHax/9?=
 =?us-ascii?Q?jQWQIBQb0u6FpyzgOtwOxXNuine1L5OV0T6lT09BM+D5BNz8d/nT1vTpLhOL?=
 =?us-ascii?Q?Qwya3+XJGopedv2vJvm4wyGFW1HqzGF9WhtY6d16ITkeQke101m9+I1xz6OI?=
 =?us-ascii?Q?TmOAbYjnVsdE4VNQiliWoYBaK/VBFD1Ur1LxViisXuEu8PML09SHSNsemcpo?=
 =?us-ascii?Q?2K+hJAt0xTOFfUdm9W8N5lLo46dyRjCHxwd6Gf7Ff3DqaVHVMg6S+nRwXE2Z?=
 =?us-ascii?Q?6e0LX1d4EAu9fgFZnjQwIL1EPRzhWiwDLIYATVChhGHpML4q0/TSgf8x+MEV?=
 =?us-ascii?Q?OTMf2bZXD1Cd0gGcg+ebwsoRMjEgS99aG1/B4Stq73SZdU2qZ6b/tQOyBU55?=
 =?us-ascii?Q?CWGZtg35Cw1BWlpQgC6OwEW3Uck6Ab169sgpnSDfUzXQG4iG06ZcUpg7zi0K?=
 =?us-ascii?Q?7Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR03MB7132.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4988632-cb38-4152-7835-08dbb35a8e19
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 06:36:11.5003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7+j5w5I6oSTFuDFn0IxB9DbaEFScQUROqPsvZQbpZtCDdA5Ti3kkM0hymdGFapeXdM2twW5O2xg9uozqTv7zQ8tMAb9AqRq/aZGWBkGkMMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5340
X-Proofpoint-ORIG-GUID: o4QjovV1vCFWT0f7Z3az2Ok6wgWPX4aB
X-Proofpoint-GUID: o4QjovV1vCFWT0f7Z3az2Ok6wgWPX4aB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 clxscore=1011 bulkscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309120055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Mittwoch, 16. August 2023 16:37
> To: Cusco, Ana-Maria <Ana-Maria.Cusco@analog.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Jonathan Cameron <jic23@kernel.org>;
> Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/2] dt-bindings: iio: hmc425a: add entry for HMC540S
>=20
> [External]
>=20
> On Wed, Aug 16, 2023 at 02:09:06PM +0300, Ana-Maria Cusco wrote:
> > Added support for HMC540SLP3E broadband 4-bit Silicon IC digital
> > attenuator with a 15 dB control range and wide frequency coverage
> > (0.1 to 8 GHz).
> >
> > Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Adding missing Signed-off-by tag

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>

>=20
> Thanks,
> Conor.
>=20
> > ---
> >  .../bindings/iio/amplifiers/adi,hmc425a.yaml         | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> > b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> > index 9fda56fa49c3..2ee6080deac7 100644
> > ---
> > a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> > +++
> b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yam
> > +++ l
> > @@ -4,20 +4,26 @@
> >  $id: http://devicetree.org/schemas/iio/amplifiers/adi,hmc425a.yaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >
> > -title: HMC425A 6-bit Digital Step Attenuator
> > +title: Analog Devices HMC425A and similar Digital Step Attenuators
> >
> >  maintainers:
> >    - Michael Hennerich <michael.hennerich@analog.com>
> >
> >  description: |
> > -  Digital Step Attenuator IIO device with gpio interface.
> > +  Digital Step Attenuator IIO devices with gpio interface.
> > +  Offer various frequency and attenuation ranges.
> >    HMC425A 0.5 dB LSB GaAs MMIC 6-BIT DIGITAL POSITIVE CONTROL
> > ATTENUATOR, 2.2 - 8.0 GHz
> > -
> > https://www.analog.com/media/en/technical-documentation/data-
> sheets/hm
> > c425A.pdf
> > +
> > + https://www.analog.com/media/en/technical-documentation/data-
> sheets/
> > + hmc425A.pdf
> > +
> > +  HMC540S 1 dB LSB Silicon MMIC 4-Bit Digital Positive Control
> Attenuator, 0.1 - 8 GHz
> > +
> > + https://www.analog.com/media/en/technical-documentation/data-
> sheets/
> > + hmc540s.pdf
> > +
> >
> >  properties:
> >    compatible:
> >      enum:
> >        - adi,hmc425a
> > +      - adi,hmc540s
> >
> >    vcc-supply: true
> >
> > --
> > 2.34.1
> >
