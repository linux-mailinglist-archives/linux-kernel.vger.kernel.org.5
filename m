Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450097B1F31
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjI1OFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjI1OFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:05:37 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C771B3;
        Thu, 28 Sep 2023 07:05:34 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38SD1Glg022932;
        Thu, 28 Sep 2023 10:05:23 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3tbx5y8bvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 10:05:23 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ir1aFQ1vGAmlaIPxSAuEO6cJXj2Vd5MuxEA/0r8Q80nGryV+CH1Dcdyt+BJxmzFuzLtXxakS1nvNDpH+qSyWY+Jel/7tQ0JbV/BiQFX3TDha7iyjJmgQeEF1R5g1TUnSOfnCc/5LzLbJ9gUyq56l5J+Uyzkd1Rq8UCMne4yWHivQt0+WL9/LqLCk9HSZyDVtmwH5D0mkLEIVwF2Mx4PjidVBTsO27c/r61tjS3WA0abxt2oIIcekkpSEzg8C8rSaXG627/Kc0tQtTawFp4EJJEd4FjMkSgAvHzjhoCdhkqfqYK/jQb7l35Hm/hY2JIMnmgyq7sESs+I5Q9xJ26VEfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAjxU/Jj7d3e3Aoja4FEZR1m1pQI9ucecMINwDx1KF8=;
 b=QbRhjGZq2T3BHEnm9nhS+Qs/pa9CZYyzzGfhKoSnrZXdMyGqmQCQjBfbEpZ1vo9+X7NsPrvTbsyYJfpZwoZatC7syci+KMF02grwaoUAv7RZ5MU9ellwAOIrz2rdTgNj8+kG24rYCvXsVW2r+04wWeHraEEmrecQNBaIf79tTacFZqdGD2jqbXHtQwKa6+0KRoHbmbv0JTlihwwKydPzU6qGjFT9YOqXJHvvUIN35gmjNa5ghj/MSQuOZgnayAWo+qrYqYcgDKaZRzglKGq4uZXMFPK0Be4Q01m9SCcNXNibVCA5QSeaUSGjSbnleJAWGEOzDYjRRD5XfMXoBorqWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAjxU/Jj7d3e3Aoja4FEZR1m1pQI9ucecMINwDx1KF8=;
 b=Ss+o34hnxEK3629iRo6BJh7Wu2pj9wo17kt+kG5JtK/D2TJKZse2MNK8wg2fLjLmhCtZAnXmcA3Z7aEq7b0p1qGLN/we4uAUkmVJacwPoTe9k4/s7qXLijEEiJVgrnVDeHFO+4OoJN3aGmprsUXozKt+E0Ungws3RqmyAcWwqSI=
Received: from BN7PR03MB4545.namprd03.prod.outlook.com (2603:10b6:408:e::31)
 by DM4PR03MB6910.namprd03.prod.outlook.com (2603:10b6:8:45::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Thu, 28 Sep 2023 14:05:21 +0000
Received: from BN7PR03MB4545.namprd03.prod.outlook.com
 ([fe80::e1d5:636a:bda7:1c81]) by BN7PR03MB4545.namprd03.prod.outlook.com
 ([fe80::e1d5:636a:bda7:1c81%2]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 14:05:20 +0000
From:   "Balas, Eliza" <Eliza.Balas@analog.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
Thread-Topic: [PATCH v2 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
Thread-Index: AQHZ8e7G+nmLWHb/Z0ShhzBMq3cwPrAwKTEAgAAaG1A=
Date:   Thu, 28 Sep 2023 14:05:20 +0000
Message-ID: <BN7PR03MB4545A3D034EADD59A3C66B0997C1A@BN7PR03MB4545.namprd03.prod.outlook.com>
References: <20230928092804.22612-1-eliza.balas@analog.com>
 <20230928092804.22612-3-eliza.balas@analog.com>
 <2023092835-educator-cardigan-1ae0@gregkh>
In-Reply-To: <2023092835-educator-cardigan-1ae0@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZWJhbGFzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctMGRmYmViYTAtNWUwOC0xMWVlLThkYjItNzQwNGYx?=
 =?us-ascii?Q?NTcwNWY3XGFtZS10ZXN0XDBkZmJlYmExLTVlMDgtMTFlZS04ZGIyLTc0MDRm?=
 =?us-ascii?Q?MTU3MDVmN2JvZHkudHh0IiBzej0iMzQzMCIgdD0iMTMzNDAzODM1MTkzODI3?=
 =?us-ascii?Q?ODUwIiBoPSIrZ2x2SU1ZaHpNS0hTdnJ5NEdETmx3RHhRTW89IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFFb0NBQUFL?=
 =?us-ascii?Q?SW1mUUZQTFpBVkZlR0theUdwdjVVVjRZcHJJYW0va0RBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQWxHVEdWZ0FBQUFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBYVFC?=
 =?us-ascii?Q?ZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQnpBRjhB?=
 =?us-ascii?Q?WmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0JsQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5?=
 =?us-ascii?Q?QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFERUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZB?=
 =?us-ascii?Q?R29BWlFCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRh?=
 =?us-ascii?Q?Pg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR03MB4545:EE_|DM4PR03MB6910:EE_
x-ms-office365-filtering-correlation-id: e76fb12e-aca8-4fc5-3fd8-08dbc02bf3c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e239Rv3F9vzRpagtH/E+X3qxhw4dXyKNtSTYPIlmBhE3sX/SlPDOtcDAspRWpSgwr6PU66WnLrtQEX1mxZ340z040xbTczkvZLcEkaAyR8TGqkr28jVmAtSFVNqRzhkl1ZetBEO1EOztZOIRL0/APEbGqlq/ftTToLXNz5ITl2xeU+UcMQLGbFsempTekSDJJZMwxyYloYK0CdVBHjtMYD2aK3u9qmaYMky/SKiPdjVmYWfglCcMECzUBABvo0df4O9JLlMq6zgL3vgRiAExyZtS0ncJPJTk3j1pcIuvTJG9wn45okiss6qGm7lXnfMr2/5Zp80j1Z8e7QCDbiqIP1zSeK+kiIR61Tqp2xNNscKyBfz+x6TelpCcIStx0CvXEsl1R3YmciQnWaLU2/R2twoAxWmJuvsFny9fn3uzGeVgT6YDuzCzWuC9Sncliqy5SbqZwZlvFixAdwfUDkzBWvaS/HXK6EZsor8xPdMPig7I5QHVoFwFa1ksYq00rCSOiJjoImdQLlToac6vbuc486zWUGubiV+nEHEhC/x/efhWXOX/95WsKrU4MLCZpt/ZMkILSpEcYmTsy1qkvWcrmeIXqee9tH8nFW1jtZgpouLq2BaiUgM0PyI4keYRx2wm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4545.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(346002)(136003)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38100700002)(478600001)(6506007)(26005)(71200400001)(122000001)(33656002)(9686003)(38070700005)(53546011)(7696005)(66446008)(66946007)(66476007)(76116006)(66556008)(83380400001)(6916009)(64756008)(41300700001)(55016003)(316002)(2906002)(86362001)(54906003)(52536014)(5660300002)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9FJ6xuIJIWzw4Kaaf5gvhLEUiedPZQaztxxviEtxShX8xj9xJfT4ld+pV3Ff?=
 =?us-ascii?Q?7ujWhUgQAq6JI+0VboQ2PCXC4Vu80WOqYWzkWKXGMEUQoYExBFniTuhxX1FL?=
 =?us-ascii?Q?alJhDChmoc6GcVcACBhOSGNANO5piXX7iLZkTRjUMl/mWhZM3Ka1TTcoS3B6?=
 =?us-ascii?Q?01pLm158GjhEcdrGaVee2X1oRvDOT6fRgPMB6KahOA6J4jakQBn45AkNFsZq?=
 =?us-ascii?Q?PGG9vxhUWDPEU96esw+MRZMmdzptw4R1JbKrzpADcCjI3c+5779Zv+GFSJbk?=
 =?us-ascii?Q?SyIZd1YXoZmTnwkgYgJRv5nfumdhEmes/bXi7R5DZPxHqwzn/YAuaHSVwTkm?=
 =?us-ascii?Q?LDBysVukPJ77+B83+cwym7daIemCR+fAA+kZ9MSD2EHRLuRNMpw0bMxdER9l?=
 =?us-ascii?Q?AWTRSWKXC18cG25Z2Pnr5ghcnuUtZ9TBQkyBB9EQtaI8SWUlaFu4Q5IdBJ2O?=
 =?us-ascii?Q?pKzbnWd5ak7UyGPyk6lFpb7oV7Wpx+lBycxJGwxUWGIf9wi5nBUNqvQCYT0q?=
 =?us-ascii?Q?BNIABPc70pLKpp3fdxNEtYrUbqTUaK8aSgAjAZGMk14BMg2OGswXHriNMZNS?=
 =?us-ascii?Q?0FQU3AKvfvoo1Rp2WzQthIguW+f+oCn3PwiGtGz2SfwQ3dFarGti5dfZCHN8?=
 =?us-ascii?Q?T/2XZ3SaJv1LOc2Dx66yg7E2JGrymLsx4WNtOFQUHoN8N0IVcwPWx1UER/V8?=
 =?us-ascii?Q?93uLG49Ji48nbZpzM/fljFdgZM0dKBVIl0jn5LKGu9n54/oHu/0LduB9hcy9?=
 =?us-ascii?Q?VI9XkE4wBuEV8WzVFkmUCRBY3isR15z/iUAlrhLckkJvFL+ZIne57Itq1GS+?=
 =?us-ascii?Q?OvM8bd4c9bE+osS5OgTwmtriH2Ug7XIjgbXlPWf/cpbHmg3z1zKoSGamxOgf?=
 =?us-ascii?Q?YoEEFh/MxdRAmZjT5qV1AGeoSX98UruqGPEeoQ+EAnli2z00x/BLf5+9hxoZ?=
 =?us-ascii?Q?MAUPbtK3uUEzX7OI1PN9YkiI1lHYJAUCSLWgwTLZ+zte+bSpIo5zWtPFZpXo?=
 =?us-ascii?Q?2gcYGyaaw1c2xWJdUMk/k8n9cZ5KbmqCUwdRTEq/9xMT7ZssspN7EpBL6AB+?=
 =?us-ascii?Q?/ZujNcp7uzfdbHLgYQ2zyJICKXuvxbZhQeKL6W9vyrQ8KNOXhoSW4EONPovs?=
 =?us-ascii?Q?eoJT3O0+wT8f1mMainPyOQr5xg8VRg8JbFUEDukaOd+ugu+Wg0emoip0nbVu?=
 =?us-ascii?Q?YnQWXftU5oq7mD0gFsXG7/5+f/+ZsjW9wN+3Cf0lGLg2TvAQdRlaPDtVNm9k?=
 =?us-ascii?Q?lx7pOY7PB0R+6HKbSLvyMSsKloNEqHwClN2YIrD4U1MGmLIU3pHR71CQPZs9?=
 =?us-ascii?Q?xG2QFvJpxAV9AJh34B/PSJQwhf/ds84Bsd5vXPN0ksIwW+OtUcv48lf4R6Q/?=
 =?us-ascii?Q?pmrbCP3SyZhucB9xNJx2LTRNc8dXHRdSQlrQG7pKV0K/x+SFNpY0gAVhx6Cp?=
 =?us-ascii?Q?ZPp+UnerCog6CgFVzk3ZwU96o+wEQQt6MFko/86x55GQPqC4kpdltFvBUKrJ?=
 =?us-ascii?Q?sq/J9RDznSwReVq92gOowWK8e1l4Wb6KhWkO2CkUu2qrG0xRTr9+CV1FS5Ac?=
 =?us-ascii?Q?CJRcuoaJkhqO8T3xcXKVM0jwtBaex0YJjyCz/7QR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4545.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76fb12e-aca8-4fc5-3fd8-08dbc02bf3c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 14:05:20.8786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 50qxmh/fao5h1mRYbxOT7j2/mkDdHItHJzher9s6xRepkjRAm8Udm22RHcIWudBMwruwIVoc5dnphYuiPvq5NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6910
X-Proofpoint-ORIG-GUID: NOueec4AFPzgZzXd3wvvzO5BEIOhm4EN
X-Proofpoint-GUID: NOueec4AFPzgZzXd3wvvzO5BEIOhm4EN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_13,2023-09-28_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2309280120
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Thursday, September 28, 2023 15:23
> To: Balas, Eliza <Eliza.Balas@analog.com>
> Cc: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski <krzysztof.kozl=
owski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; Derek Kiernan <derek.kiernan@amd.com>; Dragan Cvet=
ic <dragan.cvetic@amd.com>; Arnd Bergmann
> <arnd@arndb.de>; linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v2 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
>=20
> [External]
>=20
> On Thu, Sep 28, 2023 at 12:28:04PM +0300, Eliza Balas wrote:
> > --- /dev/null
> > +++ b/drivers/misc/adi-axi-tdd.c
> > @@ -0,0 +1,780 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
>=20
> License comment, why is this dual licensed?  You are calling
> gpl-only-marked functions in this driver so attempting to say it is also
> BSD is quite odd, how are you going to resolve that?
>=20
> Has a lawyer agreed with this licensing?
>=20
> Please get a lawyer to sign off on your next contribution of this with a
> dual license to ensure that they agree and that you all fully understand
> the legal issues and complexity of attempting to have dual-licensed
> Linux kernel code (hint, it's not as simple as you might think...)
>=20
> And document in the changelog _why_ you want this to be dual licensed so
> that we can all review that as well.
>=20
> thanks,
>=20
> greg k-h

Hello Greg,

Thank you for the review. I will make the changes to use GPL-2.0 license, a=
nd not dual license.

Best regards,
Eliza
