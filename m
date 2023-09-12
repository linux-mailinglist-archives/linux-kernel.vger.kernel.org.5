Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C89B79C709
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjILGhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjILGhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:37:38 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A704AE75;
        Mon, 11 Sep 2023 23:37:34 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38C4498f001960;
        Tue, 12 Sep 2023 02:37:21 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3t164t3n7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 02:37:20 -0400 (EDT)
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.22/8.17.1.22) with ESMTP id 38C6MTdC018326;
        Tue, 12 Sep 2023 02:37:20 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3t164t3n7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 02:37:20 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2AEAZ2zYJV/mNNQ+ieTsZt9nj3Wom2WW7lf9I/fnSon80DICWmuWHvRHpKFm8pNeN9ctv/QFx1bGcZ/qy3Mru3zBpYLrr3X+BoNWPKYx86o8FtVYKe7mrL2tMKF5nibi7y+h4ML/WsMp9kI70qid6smEOFbor8XzN5YzcQjGNt5Np0JXDtYZw8IlWlW6zys+5TCTMtzrr5Olc9quLb5FR8y4y63lzAKKx72ZUo5hk1bqf82R+NQeZlVryc6I7sVGMM0TGj7RXhuBp/ZHNpTrzd/uOsuav4T9SdeVUUWrl9yismJaHCvj7eSmtEeh+DwbMfAQNcGgvTBF5I3dyuDbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NXJ59fRzy43YJjOWmo8NZ3GsGix0fROiwd+6JN6Dq8=;
 b=WMVTARJAH4Kl/8AMDJNQ4H/u1irUmlU3R4Jd5ZeVx2+MhEt1b6gdM2fS/2N+1bf5IT9fqbbQp8foAcbWhnKSKC8/QI3gLartGeEzP45SL82E18d/oRx5qJJ5c9n1EvXJlQRSZ8t7YlMlzm5x3quLMer3fFZPIPWgBBB3nQSIAKT32PaV5A7j62EN+msihjbZHIbfglbY/2LYuyhba/Qpg/dHPsy3I/Dgh/mnlG0fNSbdnQ5e+51REKfvLUyCIG9vS5/W5vfaAOOTGZtp1JvI63yYYYuTEcKX4Q1NCybmFyQ2D219NLQZD+5g44AOYfGzN0y5MKVm2lZaxTHWTww+8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NXJ59fRzy43YJjOWmo8NZ3GsGix0fROiwd+6JN6Dq8=;
 b=rLHnh01NNPtHn45JmJNsJDuYgxgOumHC/uaa9MfTdqvtwbqgJ7Z7Kivc1fUBfFgzPRTKa6kxFphoH0AInNcX3r1yTSxpcdjrhNZw5ZlZuzMUpCKnEcgWBOQ5Wg5LNlkmFxsbWYeIDswOPrQMR8ud/hhID23M0PMsnT9g9jNFKrc=
Received: from SN7PR03MB7132.namprd03.prod.outlook.com (2603:10b6:806:352::6)
 by DM6PR03MB5369.namprd03.prod.outlook.com (2603:10b6:5:22b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 06:37:17 +0000
Received: from SN7PR03MB7132.namprd03.prod.outlook.com
 ([fe80::4a36:f52e:cc42:6fa4]) by SN7PR03MB7132.namprd03.prod.outlook.com
 ([fe80::4a36:f52e:cc42:6fa4%7]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 06:37:17 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "Cusco, Ana-Maria" <Ana-Maria.Cusco@analog.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: RE: linux-next: Signed-off-by missing for commit in the iio tree
Thread-Topic: linux-next: Signed-off-by missing for commit in the iio tree
Thread-Index: AQHZ5QSJWvVFyqf+vEWjEGwmBdh9ILAWvOGg
Date:   Tue, 12 Sep 2023 06:37:17 +0000
Message-ID: <SN7PR03MB7132F1FD70D47658EC2AD7238EF1A@SN7PR03MB7132.namprd03.prod.outlook.com>
References: <20230912090544.50add67a@canb.auug.org.au>
In-Reply-To: <20230912090544.50add67a@canb.auug.org.au>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWhlbm5lcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1jZmE4OWQ4Zi01MTM2LTExZWUtYjgwYy1iY2Yx?=
 =?us-ascii?Q?NzFjNDc2MTlcYW1lLXRlc3RcY2ZhODlkOTEtNTEzNi0xMWVlLWI4MGMtYmNm?=
 =?us-ascii?Q?MTcxYzQ3NjE5Ym9keS50eHQiIHN6PSIxODU0IiB0PSIxMzMzODk3NDIzNTkz?=
 =?us-ascii?Q?MDgwOTEiIGg9IjhXV3BZSVltMFdpWEd4VEVnTVM0UFF1cnQvYz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?QTc1d0dTUStYWkFmaUJCWXJTU2t0NytJRUZpdEpLUzNzREFBQUFBQUFBQUFB?=
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
x-ms-traffictypediagnostic: SN7PR03MB7132:EE_|DM6PR03MB5369:EE_
x-ms-office365-filtering-correlation-id: 35eb3cdd-24ef-4072-2c44-08dbb35ab554
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dD+/TtwUdmV7AipOHNWJPGTJt3k52iD0jMZEp3+f3aqw5jhm3pHuwfprLkMKXJzm7VynLk6ug8Zy2R07wSf16/gCQhmJuv/yT+Jc8XBc6KlmgVe1AKbj65ehRnkkSrw+JZhoLAM30J/sYpFEg7w7DZaCUUCfs9T93QVmXDrSszPoIrJz6rtrfTQTr6qf1TYEA1+uE2FcgoLJ1Pgpr1JinYhF1XmtoP9jk7bIC+sR/mCM2Ecdbjn/WHg5k9jDY9sSBBMo0ngRj5+01tYgq2H61AY2e/TDijHXgHESjCOGMi+HaC9DO1GyGCLq/Mqm9fpOSBBgd+5QZ8XoPBgIvft84JcHavuZ/0NiOfp6DGJoLYJZSMaGuGsUwg4qCDO5BVD5nEOEQKn+i6UP0d03tONc6nyMAMXlo5DhQfoVNb6eeKFnMYyfmWfoEvjlpAJntm351z/N6Q1sl70KrzrSNMrelNjsEb/8X6/S75lSmdp+gGG3vzkuTlkRDDBA3psCQbnHBzu23elOwBaBF1HvuHXJbwgS0xbTPPReZv+EsuegxGhTFgsU+5JJhiO5H7JhJUuw0Fe1V/cKFdOxQ1JRJUJVuxr21z+dBqBr9qQsjC51m7A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR03MB7132.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199024)(1800799009)(186009)(83380400001)(66476007)(52536014)(110136005)(38070700005)(122000001)(38100700002)(54906003)(64756008)(76116006)(316002)(86362001)(66556008)(66446008)(33656002)(8676002)(4326008)(8936002)(66946007)(41300700001)(5660300002)(55016003)(6506007)(7696005)(9686003)(53546011)(71200400001)(2906002)(4744005)(478600001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CvA5ku8WeT/gBkTCwc63BuDMvrg2FH3+JJE4eyejxxfR+J3W/6NjC03Vs3A4?=
 =?us-ascii?Q?eYgZbU/pzbthP3EzjGmCv0ZKRatn61AkIxlL7kK/PkcRoowvjCUYFhNdgIrm?=
 =?us-ascii?Q?/yF1j/2dAa4WVX6C38J9KZWEUXdEA3qNmBp/9+SIl1+AVNz6IH1rxyz5KESS?=
 =?us-ascii?Q?CfnWT4XhqBhkt+1NEyfHA1kvHJeQ1zOGCft+kkdiAF3Zi7VA6RqFee+M/XV8?=
 =?us-ascii?Q?lrm0tZmKr4xUJmAPba1CIGlbLTQFlu0KAMcPxouVqCBi+1P7hCYAPriSTlqK?=
 =?us-ascii?Q?CwUvtfAvw1PpPHELHxM1qiKaUlW2oG4RsnRbAvEtNjf5THWzPZs/EvMeOr+n?=
 =?us-ascii?Q?vUS/mnM2ri6zgIS14UHm8ykcdYt3Hj18MXBRhUTCfUngfVzGgMqkXODn7KRu?=
 =?us-ascii?Q?yNo5nD3Uwby5xbGVc9cUS2kvPwRGfZ57qyTtVsL73fKFJHfJzF8x2tBiyQcc?=
 =?us-ascii?Q?W1unFG8rffCCS7r0GzIDSTeYbSErVTelh6tCzl3tVmTo7caLHLzflwyefVTi?=
 =?us-ascii?Q?LaplEVYsCJ03G6JfauH0mH8cr454iWVKCMt6oRdsfYKvrNAs+X8Q8fbiVSLo?=
 =?us-ascii?Q?q+67xf+xxgFy6S38ydlsv5ci7LUTa/SaDrKsiefVT/t57UnYg3aQpCV4IJW9?=
 =?us-ascii?Q?W+tg3Sv4IJzzjnvPD8WhJXQ/4bWcRxQVFRcHRWTgSzL+E9X/xmp1BR/R2OlE?=
 =?us-ascii?Q?umWgIINm6rTmzgIQMBy3kFp2EcIb2UTWnQ+wZi2jq0UM8pJPHhh4dVGTUKWD?=
 =?us-ascii?Q?03/tnwOFBNTS0lgU5D9ZnFjcPZDTS4qIVBSnhfHgTLnpihvylPRQy2w+JxOr?=
 =?us-ascii?Q?qUpkSu7Ezdy9qUhGtn2opKAwSDCdq6lMbh7e/ixvqxQNbs8YEv/VdEqxAlDr?=
 =?us-ascii?Q?Z3V6gt+zabTjMMuB0w3n1esFwxhSG2ecuS/8Iqv4WQzGYKrIRRWWthCGhosU?=
 =?us-ascii?Q?M30TQUsSLoJiFOgaOXqQCSdTxXnaQrdJg66JiYkRIn1KfB1heFdd8o0u/hkJ?=
 =?us-ascii?Q?YkkOkLi2gSG0wUzLSq7u6BaApDK7HZeVDTbDQCZEYlpr65Qz+zU/I0IKO+pT?=
 =?us-ascii?Q?tv0wRvPBOL1TYV412DrU22c3gg8b8HMP3j/fApCi3AO4VU5ge4m/qwdEKLiP?=
 =?us-ascii?Q?ddH+by/ofJSrLfsHjdELAtIx4PhtAN19bueQyoIEJ9iV8A9WUlZ4CEzgKLPX?=
 =?us-ascii?Q?B2G2W49ZwBiaO7JqSi3kW8pDec6zV9FMm0f6LU7ba1g5f0RcPJSSlYIOrL8e?=
 =?us-ascii?Q?gn48Uih4jIaw+nRAaUJP1z6kLJRmU2GvlF+OjaN/52gDhb5ixZfketbaQFS+?=
 =?us-ascii?Q?v40GEy13WYjvSdwREFQWwDl5RJeIA4BWzqibPSyXDJJ2vbRVF8ihbQ4vCN6n?=
 =?us-ascii?Q?vFEIMcyM7jESrnXXFLdqGK4DyfCl9DZF2mVoxRuGNgS8099woQCvZP0j13Op?=
 =?us-ascii?Q?c2FwzlDpgu1YeV5IivloS9+rS0WeP9B14fE5J4pOZwEcyGgd1Luncg023mXj?=
 =?us-ascii?Q?BhRb7lo2SKZwcrF4Z9cRTzQjRGff/nufmoU+zxOlGHpOCnaO3LC4xQGsr1u4?=
 =?us-ascii?Q?QFgqe0JvSjn9u26ehX+Tkl4vNaTMosZDZjtvhQVfv5Wwu1PublBDR3YNV+2R?=
 =?us-ascii?Q?DA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR03MB7132.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35eb3cdd-24ef-4072-2c44-08dbb35ab554
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 06:37:17.3611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pUPxJtFKETVq5UaDblN1rFDqctnyGSZ8Zr13Bf4Jli/mWDjJ4K8S6T+EyK/FkvuWSLCrUrMCoqklErWpGIvFhjs/3/w+Ey+lOVRZOEpUK7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5369
X-Proofpoint-GUID: VbShe01g5rvp_BxbwZLF0mmYemhP1gs7
X-Proofpoint-ORIG-GUID: enJDKqcNQeulsVX6FCIQ3RyRqHV8XZXy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 mlxlogscore=999 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309120055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Sent: Dienstag, 12. September 2023 01:06
> To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Cc: Hennerich, Michael <Michael.Hennerich@analog.com>; Cusco, Ana-
> Maria <Ana-Maria.Cusco@analog.com>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; Linux Next Mailing List <linux-
> next@vger.kernel.org>
> Subject: linux-next: Signed-off-by missing for commit in the iio tree
>=20
>=20
> Hi all,
>=20
> Commit
>=20
>   6ed193ca529e ("iio: amplifiers: hmc425a: Add Support HMC540S 4-bit
> Attenuator")
>=20
> is missing a Signed-off-by from its author.

Replied and added my Signed-off-by to the original patch.
=20
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>

>=20
> --
> Cheers,
> Stephen Rothwell
