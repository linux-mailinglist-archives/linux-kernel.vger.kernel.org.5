Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D259D768B06
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 07:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjGaFXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 01:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjGaFXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 01:23:52 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7E6E5B;
        Sun, 30 Jul 2023 22:23:50 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36V509a0028722;
        Mon, 31 Jul 2023 01:23:49 -0400
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3s66dwg447-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 01:23:36 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UT1LSsfy8/0GZR1QoLUyQToDmL0I94Vdd3OPovOUcyYdO0mh7VvM7QJEk17dEVYV1FM9jbZVwoYTUC5HiV9j/2pCNErxOTj4hHH+jysKbHvNZImOSUjCCquw/nyagUuePvI3lSge5XgZHwpZ00QfuaQcYE8cG8BXKtS5S9wFMur+2JGjB/SLwgAa6Whfc0pYBBYxELuXk9s17utbSl+Nj5m/3gnfI9W9aXqcyfUZHnMlVv+xYguv/aebJjxmxzuEIq2Odbz7S/xMA9NpWL3ejODjfmHgD83c1+snwVBFVcY86KbiGxOxCQKBEt4u7tXEQxO37d+J+StDAQnmHUfxow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kxyWimORzjxLxYZxvGE8amNWOQZjyZ7mZyV/f5uS/M=;
 b=dHggVpSbmxt1PSuzhvP4LWcQAVQIngXIOaYk5xNE0ZnWPmo9l9K0eLUdOuFVp2ph/E9fS5VvYj8V6UTB2kCY4SgLzUMKhP8K0sbe7AkeTabew5VsHlH6bAkzGguWI8kDv3uXlnXYvBvIFPbbp8x8l4VKoRdzLpnDRUped3rmKzWHAzYJeLqEH8PNLG+B5r9mDeAer7wJ7Zf06xXhxYmXVLAwKtdw85xP5rqxHnowJ8f4pIjvMl/qm6iXpcCSOBofOWjy4BYOY7U1abE1xR9odhUdSiSnMLeBwsmGfgFSmWwxAorkaLrI00+n9lcT1JGn2C4XDf7q0BIAugEkCc1Ycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kxyWimORzjxLxYZxvGE8amNWOQZjyZ7mZyV/f5uS/M=;
 b=on8+Een3egNk1y6tot3zvPouqnab0Y0o64VbpbCu1QqvCivFaoaavaRl60PwiqAMIxbmfGwAf8uukXFxTSg0lbaXYqWYa8IAscEMubHTBYn2tT0+JyRSgIErDBEm7MFIr7HKr1q7iy8n07kXBCN8xfA4sbBjKOgLYH2EsNruMIs=
Received: from SN7PR03MB7132.namprd03.prod.outlook.com (2603:10b6:806:352::6)
 by PH0PR03MB5943.namprd03.prod.outlook.com (2603:10b6:510:30::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 05:23:01 +0000
Received: from SN7PR03MB7132.namprd03.prod.outlook.com
 ([fe80::4a36:f52e:cc42:6fa4]) by SN7PR03MB7132.namprd03.prod.outlook.com
 ([fe80::4a36:f52e:cc42:6fa4%7]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 05:23:01 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 05/22] Input: ad7877 - use device core to create
 driver-specific device attributes
Thread-Topic: [PATCH 05/22] Input: ad7877 - use device core to create
 driver-specific device attributes
Thread-Index: AQHZwbbZ0LP3R7KOoEKEGNapcnAve6/TWqiQ
Date:   Mon, 31 Jul 2023 05:23:01 +0000
Message-ID: <SN7PR03MB71321062471405BBF3F9C5188E05A@SN7PR03MB7132.namprd03.prod.outlook.com>
References: <20230729005133.1095051-1-dmitry.torokhov@gmail.com>
 <20230729005133.1095051-5-dmitry.torokhov@gmail.com>
In-Reply-To: <20230729005133.1095051-5-dmitry.torokhov@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWhlbm5lcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy00ZmIyOGJjYS0yZjYyLTExZWUtYjdmNy1iY2Yx?=
 =?us-ascii?Q?NzFjNDc2MTZcYW1lLXRlc3RcNGZiMjhiY2MtMmY2Mi0xMWVlLWI3ZjctYmNm?=
 =?us-ascii?Q?MTcxYzQ3NjE2Ym9keS50eHQiIHN6PSI0NjQ0IiB0PSIxMzMzNTI1NDU3OTU2?=
 =?us-ascii?Q?Mjg1MzAiIGg9Im44ZzE0K1BZelEvUnd0dFdRd2Q1M3pZaG1Icz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?RHkzUW9TYjhQWkFWNjJyb1ZVNUdOeFhyYXVoVlRrWTNFREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBdmRoa3hnQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
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
x-ms-traffictypediagnostic: SN7PR03MB7132:EE_|PH0PR03MB5943:EE_
x-ms-office365-filtering-correlation-id: 3052ab4a-c097-49d0-2f23-08db91863575
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: smohRy7WgH+mp9SXhQB+4ryv8qNB+fIGq8JdAOjS+LKFTdCm1kngWkfjes/ccUq/yCdBRdseDP6J6T3E2/gTs0tA4pTv51MwCc8QfNqzU61Ym6RBvOCY3SgA4FQOU1zwvSFPOSZhuEKygSAT9J1E6tgo/kYOTrDO26a6aXpB+M/0dfN0+CS5AMqXYNaBRpHpTDDcYdU021aI9/AY91KfmTXZPFuCL3GOMgDc3wgmJMP1zxFCNOfL1MY4h1TjsvxmSqgj7pqDkHpfyI2H3fy2Ua6xK+meskhPhARGrAXINoBlyCmFqWufyLSP+MpPx7/CurWf23tY5mYxdBlN+Srv2OpLqS6v/FtrGoMI8bIQDFUdgxF6MHLoQ20srA+dSJmoXPc8TBi2+37GRKdoMqhebwcWW1OC5S0xJKmL4BP+oo9Myjw4ORtBcos5kSNkbant3kkam7MJJd/zj2HI+pHRnknIRW/6ut73gCJjLUYc/8bxGXqB7VOdc7OX9GPIO68Vo7YzVgvsYg58X4V/J8eQq4gUoA66tlqi6zzx16XYjVass/PEFH2KMVmSSZX7sFzcYuQIOGc9wLxNwuQMgP8kOVdesKlJkmF/57wtrewxlLV1YOLBfYLCVSc4icStWqTJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR03MB7132.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(9686003)(7696005)(55016003)(53546011)(6506007)(26005)(83380400001)(186003)(33656002)(76116006)(66946007)(66556008)(52536014)(38070700005)(122000001)(54906003)(110136005)(41300700001)(86362001)(66476007)(316002)(64756008)(66446008)(4326008)(5660300002)(8936002)(8676002)(38100700002)(2906002)(71200400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?guTYpJDRUdBeiQLHDIGwRTcmBw3JHBdn73MVo6TFKNExEZMgiS6REhuCMsDz?=
 =?us-ascii?Q?pur5rBwnnmdt/vxrNCrco+cKBZmnz+rXW42QWRQcJwIZdxfm3d3j/m8EPa8l?=
 =?us-ascii?Q?FDQqNjdmYzGkYampEImLBLUmniluU8UbZm1b+YGTu06Ld+FIcZz5dEVFTXg3?=
 =?us-ascii?Q?FIflULgxVMVXjiUPv8W/7cd689+M9ywmbA6MswgdmVA4sCroaIhaPDnawQFR?=
 =?us-ascii?Q?xEsXrslYyHJd7a4FslMDQ7a4D+2mUgQGrujfuis8jvFyT3yy9An39yQetzMq?=
 =?us-ascii?Q?Z3aQOUEutoQvoKWCEuGV5MBbrIxrzEWJ5g8riC3TgaTPJf3xgpzHgyvtrE68?=
 =?us-ascii?Q?0ZyRqMowoGzKhTluhTevynik2izDwG4TxzxaMdPAOoP4eZ4VyLM+pHE/54zP?=
 =?us-ascii?Q?EjYN0wSSSfJFsAH0zoSum7xjcR/HFrotYliryXvaK/8nC/41P+mjFFJP3Blz?=
 =?us-ascii?Q?7nrAhPiKyXfAbrzF0uoLMNRd+dsJQgFceCdFj23KnusJNiuxaYzpv+M1PRuZ?=
 =?us-ascii?Q?U0rnbA/IkKV0s5rxjI0cxsQpqWqYbjZ+LOyaTaAtViZWatb5JcGJs4z/gEOm?=
 =?us-ascii?Q?3Kxm9C6yUCCvBsoj2HCZ0D4U2DDuaOJLpcEKdOnbk0IbMhTVlHXAcy3WKA9u?=
 =?us-ascii?Q?1XdgaoF69owOOW+2OEtKpoWmga4K3bTsaiTsxQ1Pt86mB8k9iFng/5bUGWI7?=
 =?us-ascii?Q?ezO0XgbQV3DZ+sjRZuQ7UTI9Wk06rvdNS/Vek2+gYBF26CuuvBhB/2dD/y4+?=
 =?us-ascii?Q?I4k0g8X+D8kYqE0vyGYXVxwg2CReOhVuPuqOFZORhnoN/pDs/1U3p0LCnOfc?=
 =?us-ascii?Q?pNB6+dMqOCdebavP2A3+M+2cuo68ArIwV0jLU/yalJ2u6AdBsWSBovgP2DsB?=
 =?us-ascii?Q?de3WXx6RQhilrz6dxTC/MvHirNr7RLvkmAqKWrwVbszUVxN2xYvdTjkYgB8F?=
 =?us-ascii?Q?k2dj6wgwysHfefN9y+iQrsxJshn5uRzHIy4Wnze8r+P+YUzudtlLzc6yIoTn?=
 =?us-ascii?Q?KJqdehRhTwC5shrq+Bw9BGOoXErgKZdOsaiDV97/w2OE3BA29S3XPMp009pP?=
 =?us-ascii?Q?ulCVO62qoRen0DYNlK9GjY55thJG+HAqfTd75Aiw8wj/Mb454IxsYDZdjiut?=
 =?us-ascii?Q?Xw0CymleOoBI4gn7LN10T+LuGT23ryn0Ne7DKsHhNdxYOSY5FGg+f2YXbWVi?=
 =?us-ascii?Q?pztUFtXzl5WlkC2B+NNkpwKW7UXeQe6kQlsaKpPhOOqHguBCekM1eazPkCfR?=
 =?us-ascii?Q?XqBd43JzwvN6WfUQEOu+UzTr9vffUcBNd2EIAizq1sJvOpWkHigSpm5HTsPC?=
 =?us-ascii?Q?iodVZWUPBzEA1+9RqV9QjA/m3Gyy9OhgX6mIGL9xWI7n5NMbIIGmDys3qi3z?=
 =?us-ascii?Q?K0/H89EO1w6v9k/n+XU6oo8/Md8kbXnLonG67ckoJ/rl008Y3nFDv2v+ZbiR?=
 =?us-ascii?Q?KnuPIr/eJxc1Gt4pU8EAX5t9xKqcSx/GFi2bk77YPboQB0yt7uNySKHECPN3?=
 =?us-ascii?Q?YtWPxc9kXLtzyva0X/AljbwNtK0sDbIG34vEkep2eZSLCv9GzeEIGhNy3HEL?=
 =?us-ascii?Q?RXzEo1KJmwVQva8P4grTFijRdWR5NGD1nZE+GRqVyU7i5SpYVkRPhzuh3S4n?=
 =?us-ascii?Q?fQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR03MB7132.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3052ab4a-c097-49d0-2f23-08db91863575
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 05:23:01.1114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +eQ0s6U1r12YVOCQ3iXm+F8fiKEzNDQDI/1YCdyPhvVRoGmxiUNUHh0i5esZ7KSEV1wio9Vp24Bz4RlugXcJDExfLmbKIVDdeCQwMbBE4hA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5943
X-Proofpoint-ORIG-GUID: aY_Myg7Wv2cY_k2mIrzPPQc_IXW7IYM2
X-Proofpoint-GUID: aY_Myg7Wv2cY_k2mIrzPPQc_IXW7IYM2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2306200000
 definitions=main-2307310048
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Sent: Samstag, 29. Juli 2023 02:51
> To: linux-input@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Hennerich, Michael
> <Michael.Hennerich@analog.com>
> Subject: [PATCH 05/22] Input: ad7877 - use device core to create driver-
> specific device attributes
>=20
> Instead of creating driver-specific device attributes with
> devm_device_add_group() have device core do this by setting up dev_groups
> pointer in the driver structure.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/input/touchscreen/ad7877.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/input/touchscreen/ad7877.c
> b/drivers/input/touchscreen/ad7877.c
> index edb36d663f22..a0598e9c7aff 100644
> --- a/drivers/input/touchscreen/ad7877.c
> +++ b/drivers/input/touchscreen/ad7877.c
> @@ -612,10 +612,11 @@ static umode_t ad7877_attr_is_visible(struct
> kobject *kobj,
>  	return mode;
>  }
>=20
> -static const struct attribute_group ad7877_attr_group =3D {
> +static const struct attribute_group ad7877_group =3D {
>  	.is_visible	=3D ad7877_attr_is_visible,
>  	.attrs		=3D ad7877_attributes,
>  };
> +__ATTRIBUTE_GROUPS(ad7877);
>=20
>  static void ad7877_setup_ts_def_msg(struct spi_device *spi, struct ad787=
7
> *ts)  { @@ -777,10 +778,6 @@ static int ad7877_probe(struct spi_device
> *spi)
>  		return err;
>  	}
>=20
> -	err =3D devm_device_add_group(&spi->dev, &ad7877_attr_group);
> -	if (err)
> -		return err;
> -
>  	err =3D input_register_device(input_dev);
>  	if (err)
>  		return err;
> @@ -810,8 +807,9 @@ static DEFINE_SIMPLE_DEV_PM_OPS(ad7877_pm,
> ad7877_suspend, ad7877_resume);
>=20
>  static struct spi_driver ad7877_driver =3D {
>  	.driver =3D {
> -		.name	=3D "ad7877",
> -		.pm	=3D pm_sleep_ptr(&ad7877_pm),
> +		.name		=3D "ad7877",
> +		.dev_groups	=3D ad7877_groups,
> +		.pm		=3D pm_sleep_ptr(&ad7877_pm),
>  	},
>  	.probe		=3D ad7877_probe,
>  };
> --
> 2.41.0.487.g6d72f3e995-goog

