Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AE379CFE2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbjILL25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234646AbjILL2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:28:17 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3BD98;
        Tue, 12 Sep 2023 04:28:06 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38C88tMP001960;
        Tue, 12 Sep 2023 07:27:58 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3t164t5573-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 07:27:58 -0400 (EDT)
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.22/8.17.1.22) with ESMTP id 38CBRw6M029989;
        Tue, 12 Sep 2023 07:27:58 -0400
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3t164t556y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 07:27:58 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPKrs+X3ewr3XU4x1IAls+SoZ7oZH02o8666PeSdq0pQJw5f/48D25SIaNE8Ln5ftc1v7ikItp5h57zfNMQhQG7hIQ8xz3/BRh2C9NDUllOifQEbVTnCOTrK2pT/JKCgNO00532g6hx1eHtGvhcwe+g6mePj3XzoUTNkxDh6oLA2GLmHyq4T+9rTrD2QdwzcoLxIscOa5aycob/PuAHsy9SCJW0U11LjlG4rXYeG3Uz2yB/OMxUKeSHZRuuutSlWTtZY6tGT/egiH5eAttrz+HDJQzwZy/ryVpwBQwy2TxUK/9t1/Dc/gASgwiNR7lb6030jmiB4PHYtpgjcXvYXGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/y9aREe4N/dbqMmEWmULxZchmqGlZU0TA/aPHVv4Fis=;
 b=DL6S1eKYMRTSx8uiClN4ktebwt0IG/+8DiRPKHq6XdOM57Zow4Wgtigq+7j/ntQHTizafw8nzETCREB6Vsc/HUm69EVo1lIGuhN99AH++l7/psVzcJ4uJVwyMYgfJVcRMIHbwzVXTwxITMVsB3GMRCYcMvMtC1jyXwETx35VPoHee63HhNDTmG1pdwFR12wiVbnSW1zipA2gBiytKk5lxd/NVaIWHcimtjGbsfcAEUpU8FzCetH2WVoQR6PMQqfurvYcg9OeOzouVn33/4t3Fs9ptp6I4J4vQ6/VkQT+qQ7JA4UYpVjgICwce1L7k69PUgaaJAXTS+HaXsD3KQGuVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/y9aREe4N/dbqMmEWmULxZchmqGlZU0TA/aPHVv4Fis=;
 b=8Caagwe67ycxkf6MPr+I1I7wKDNTMPfELhqI+Na/ns1OI9gw/oIdkk7j0rqkz5vLwTGwjhpEYyQvVML1WUd/3LL7jJ+jfK36U14PjYKwJpd/i78Nk86DauDR+tx9jPOP+Gft/vCladdsSxXKZ+EXekGjPbmsJZTva/LODH8uqZw=
Received: from SN7PR03MB7132.namprd03.prod.outlook.com (2603:10b6:806:352::6)
 by BY5PR03MB5233.namprd03.prod.outlook.com (2603:10b6:a03:22c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 11:27:55 +0000
Received: from SN7PR03MB7132.namprd03.prod.outlook.com
 ([fe80::4a36:f52e:cc42:6fa4]) by SN7PR03MB7132.namprd03.prod.outlook.com
 ([fe80::4a36:f52e:cc42:6fa4%7]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 11:27:55 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Cusco, Ana-Maria" <Ana-Maria.Cusco@analog.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: RE: linux-next: Signed-off-by missing for commit in the iio tree
Thread-Topic: linux-next: Signed-off-by missing for commit in the iio tree
Thread-Index: AQHZ5QSJWvVFyqf+vEWjEGwmBdh9ILAWvOGggAAt0YCAACKoMA==
Date:   Tue, 12 Sep 2023 11:27:55 +0000
Message-ID: <SN7PR03MB713236E2643B5AD8356810338EF1A@SN7PR03MB7132.namprd03.prod.outlook.com>
References: <20230912090544.50add67a@canb.auug.org.au>
        <SN7PR03MB7132F1FD70D47658EC2AD7238EF1A@SN7PR03MB7132.namprd03.prod.outlook.com>
 <20230912102027.000047a9@Huawei.com>
In-Reply-To: <20230912102027.000047a9@Huawei.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWhlbm5lcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy02OTY5MTg3Zi01MTVmLTExZWUtYjgwYy1iY2Yx?=
 =?us-ascii?Q?NzFjNDc2MTlcYW1lLXRlc3RcNjk2OTE4ODEtNTE1Zi0xMWVlLWI4MGMtYmNm?=
 =?us-ascii?Q?MTcxYzQ3NjE5Ym9keS50eHQiIHN6PSI0NjQ0IiB0PSIxMzMzODk5MTY3Mzc1?=
 =?us-ascii?Q?MTY1NjEiIGg9InBBS3piVjE2ek5MNkFLSi9CUUh2VzhLekVITT0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?QVJOTUlyYk9YWkFjcGVyWThNNmRGRXlsNnRqd3pwMFVRREFBQUFBQUFBQUFB?=
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
x-ms-traffictypediagnostic: SN7PR03MB7132:EE_|BY5PR03MB5233:EE_
x-ms-office365-filtering-correlation-id: e346adaf-93a2-4765-5fed-08dbb3834f28
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OtgSTxM/juAltAs4NTEaInNQUPHzdGBNRwfx1YVh18wR9ajXT8sqG+NJ3uE9FYmXoGyQoBw/uHgITHjUs0iAHOPbLGr5BvjElQopbwAjBc8NjxyLPBy/qnKNz2QmD4MTvf+uCl3+Il3FFezQF0EsZeG7+8jaDAPF83xn7bFcDXaVx7X2jKV0Hqr4if0RpIpkVIXvq6CLLAGZH9sZoB0giON2G7pbpbccUmKnsmjbdMghFPloe66hI9WchR5/gBJ4dOfkPKKnmV0xZCPBfsxjQfkhQNiDwtTQ5Exw47pe0mHoZLCNwoSqnnsFprvE9BxeJQsIAMBZE67aSlH+fL6FH6YPExmmZGZvma+MtrqSM/gaJwYYsbKEv9HUDb3DuMbi2CbwX4glq2u+8iTagY3YITiypcHiYjIqxThYmi0W0gGCeaRlEq1YnCDqgXwgQ3uZSgXGDI/Vnz3QPnx6AEPFgaMVDeKzdq9O9qYQinx1F1meuOyp59dmKSsepVfNWHweUOtSTpVMp/5MYXXdokDMW5bZj5xgLm7DoqFJdPrABLe6aAWR+fA8j69cEp+b9RQmsfWy49BLhSM5ozaU6gPleg3GDyMiRs3C0DTBRuWd8RTRf0XsS8yYUG6Wlx8SyPHu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR03MB7132.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(366004)(39860400002)(186009)(451199024)(1800799009)(52536014)(5660300002)(8676002)(8936002)(4326008)(83380400001)(71200400001)(9686003)(6506007)(7696005)(26005)(53546011)(55016003)(478600001)(122000001)(6916009)(76116006)(66946007)(316002)(54906003)(66476007)(41300700001)(66556008)(66446008)(64756008)(86362001)(2906002)(33656002)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x11xrzr88jbH46Gqm+awLtZgLyylyh6mVFnZteqmsMHbVzZIIGK0QxJH0h1m?=
 =?us-ascii?Q?5imrKpCdNdZ0pqaPha4NCVGzT0g96Q0xKdS/2t0d/pUrvewnF3XIOs1kinM2?=
 =?us-ascii?Q?sLtmixbnU9Hr9cK0WiXYoj4TzDl7DC4YsMYDSnWqAqpT3+Gku8qehCCsIeP6?=
 =?us-ascii?Q?q8RhPWvSuSz0RarkgfZebwn/3xI+PViwcSxMShY/budPFKDWCg56Qxb1ofwS?=
 =?us-ascii?Q?mfvPMySWh9F99ihYbDUAqy50VYBklgc4YOUpiFH5k+vQPHuZw0tMlrnPmHGZ?=
 =?us-ascii?Q?jX4RHNk/ts9wlB0jYrqbJwNtJ9Osg7n4Pbqs0xP8MwdDgtsMv+lMbsxfHXxE?=
 =?us-ascii?Q?Z0+hKXXpcGaHfHVzYJU4PqhWCErEBq6WLj4OspVkJB90+5VeM3SB6efc09Nf?=
 =?us-ascii?Q?W38rVJ9NeOTGIAZ/N1QmrbYL1Pi41PmxxvZUGhFP8oCVjom9F2rvk2j+xfaS?=
 =?us-ascii?Q?/3xqR/1hXigWCfN5ec+zevocmkteK4khiweN6hAdZzp0RWR/H8Rdfj8Kk28/?=
 =?us-ascii?Q?V3EO6aNXZc8P7pMc2Qn46tKwZjTctLYymxfpkDFLKb22tjFt1diCVUj4FmiN?=
 =?us-ascii?Q?I9lz61ARBJ0DFDNiwOGgUuQ7eioPBWElBnqJ6bpGeZ287iiQVtjn4d4AEcZy?=
 =?us-ascii?Q?FQjm/KLeHqM0hxh8b5ZO57epE+e8/ODrkAxZpweQQdmjK7Aj7s0hEdbKsEJH?=
 =?us-ascii?Q?3sNZ6BXLmbu4vRsEIx07pWtjYKGGZW7VV/gy8dp6L27FnQO/iDJPxGhhqW+o?=
 =?us-ascii?Q?UKti8++Cm8DhYbTcj9L75KrGchjwyQDcarvicAS9JeuJ+LioNAxI90sEFd0Z?=
 =?us-ascii?Q?fkZ4KI4BcUKuRCIaCr6OVRu4qrukTt+/C6/Jtta5Yy9CeqXbZimJ8mNQg061?=
 =?us-ascii?Q?sGNTSqGkgTAUnnidIpWkSSci3RczM+8bolaEUgR3w71DopFZ9AzOHrcHj/ju?=
 =?us-ascii?Q?mD7JuwJlA87v8bNusOVg09i6WbDagSiZTsBpy05OGzNMHbe6V2A9CvVQRUL4?=
 =?us-ascii?Q?qWzQGmmB12lda1f510MgfVhjReSZMO4hk8m+WoYeS/k793oqeAW93Itd1eqh?=
 =?us-ascii?Q?I++hTxU8yjT+Yj9J1RJWIvyHdk8tpeM3yb0/fQ+sC7MONiV2j3GjndtHSXeD?=
 =?us-ascii?Q?DkMrwZLYjwFQiis//TUMdkegGxSdjE9ehcpTznPsI/X3RYcdFL1CtXvLGZhS?=
 =?us-ascii?Q?gSngq3/0Q/8dHtt0Lpr4pzkwl4A7V4nBDQFcqBo+fx+c8AwjEPGYfwtdFqsF?=
 =?us-ascii?Q?3jZ4oqFxkgoiyaAA7ncQOGBY76n8SaGelFKLGTOFaPy8xq9UXNGMJEL93BeU?=
 =?us-ascii?Q?SdxlB4BaL39ay93MuJ8S4QQWjLKJNtK+hWpDlmvGfnkXp4J1SVV0pXHhjfVX?=
 =?us-ascii?Q?vSW3h+ayXynHgaW6ohwiSfLyljFBnhBLyloKVDaaAtj44JJBNYDU2cZwGl7k?=
 =?us-ascii?Q?bX0LsNeNaDby6U5Q8SzPVg1F0yfpVgjzOUGUU/UuiFD8sO2TxqN+b1ZEdM9l?=
 =?us-ascii?Q?vLEGiv1BId0s3MV6xh4+wLUoJwc5uRN/WWuW/J7kCVByRrJJ+I53fX5YNuHC?=
 =?us-ascii?Q?lSa6GnQMgwN0qraunPB+DKIc3zr6Y4wEO5q/KnzYccUTRDJT9FjtS4FPbziY?=
 =?us-ascii?Q?kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR03MB7132.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e346adaf-93a2-4765-5fed-08dbb3834f28
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 11:27:55.3082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IucJjNmj9mUt5baLPTtJxegZiDE7w+akYP1YCKBUWwG54uLjSnLuAo4aHY5YW52T1Er7lGdRRZj0xAK6ts9nkeOanMAFU1c7b5EVmx+10DI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5233
X-Proofpoint-GUID: XqG_F7R02rONRwgdZdEepwGgmCbGJ9p3
X-Proofpoint-ORIG-GUID: 4SWZCK5ceX5_kn150ou63sxb8rNSECXG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_09,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 mlxlogscore=999 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309120094
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Dienstag, 12. September 2023 11:20
> To: Hennerich, Michael <Michael.Hennerich@analog.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>; Cusco, Ana-Maria <Ana-
> Maria.Cusco@analog.com>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; Linux Next Mailing List <linux-
> next@vger.kernel.org>; linux-iio@vger.kernel.org; Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>
> Subject: Re: linux-next: Signed-off-by missing for commit in the iio tree
>=20
> [External]
>=20
> On Tue, 12 Sep 2023 06:37:17 +0000
> "Hennerich, Michael" <Michael.Hennerich@analog.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Sent: Dienstag, 12. September 2023 01:06
> > > To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > > Cc: Hennerich, Michael <Michael.Hennerich@analog.com>; Cusco, Ana-
> > > Maria <Ana-Maria.Cusco@analog.com>; Linux Kernel Mailing List
> > > <linux- kernel@vger.kernel.org>; Linux Next Mailing List <linux-
> > > next@vger.kernel.org>
> > > Subject: linux-next: Signed-off-by missing for commit in the iio
> > > tree
> > >
> > >
> > > Hi all,
> > >
> > > Commit
> > >
> > >   6ed193ca529e ("iio: amplifiers: hmc425a: Add Support HMC540S 4-bit
> > > Attenuator")
> > >
> > > is missing a Signed-off-by from its author.
> >
> > Replied and added my Signed-off-by to the original patch.
> >
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>=20
> Hi Michael,
>=20
> You missed and replied to the DT binding patch that followed this one.
> I've taken above combined with that to be good enough confirmation that
> you meant this one and added the sign off.  Great if you could confirm th=
at
> for the record though!

Sorry - my fault.

The Signed-off-by tag should have been for patch "iio: amplifiers: hmc425a:=
 Add Support HMC540S 4-bit Attenuator"

Regards,
Michael

=20

>=20
> +CC linux-iio to keep the two discussions together.
> +CC Krzysztof who asked about that rather odd looking SoB as well.
>=20
> Jonathan
>=20
> >
> > >
> > > --
> > > Cheers,
> > > Stephen Rothwell

