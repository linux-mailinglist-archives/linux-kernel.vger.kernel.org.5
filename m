Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B9A7692E0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjGaKQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjGaKQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:16:43 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C439E3;
        Mon, 31 Jul 2023 03:16:42 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36V9reDW028717;
        Mon, 31 Jul 2023 06:16:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3s66dwj13j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 06:16:38 -0400 (EDT)
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.22/8.17.1.22) with ESMTP id 36VAGbpE003350;
        Mon, 31 Jul 2023 06:16:37 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3s66dwj13f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 06:16:37 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTRTSU5XHL7N+tEm2g1jyUpkjcg1ywO8cGwoWhuENIW9DQCMpMEeuGk4ysWmbFMCZMponODQ2QuDkWGme3DgRsNRZ6nnVjGl5BxhzbTkw5tudIN2p/J/k0Pblk1s+E301HGGOPirqdqTj95m0tUqDs2BFhCCZyiq+q1nL1YosIKyNg+LLFQk99wxHURS/yyeJWTOhHYDb4kFsyHNUbp28Ak8ItuzIsQ0tDD4KeA2zizVE9xwE2cyX19u0EGD5Fo/EaWbdS4ULTAaBlHRQB+f4Phf2CFdsee5v7BrN5eO3KvJQmmmMlvlnBC04I/DXiUQsQKfM+dozvl0MxsCB0dXxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4NuRSzneophvAHQnrvIAvJWJFDbAXhr1b1ZLHtQy98=;
 b=d3XMZTqPV2Lp/l6ZetEK93hanTT59yUDt7fqdZguz+FW+I9VTk2hU8Uqheby98kHPkQv+wnsy8CUg+RNWPXOpBqBov4dc44fgodb8pDE7CiSJNnVmQOiGyHNMRh7D4BMva+vU7CXdR9qHuTdcMzh8skaQITOKu1NNv4j33Skee4yjsDtOQuXusdp7ZNoXkH2C+HPhA5hRFNP2LFAgG+Jvj450Zgeath1ca2HYrGoYWHDZCc5omuvP9I8m7oz8+C7E3ZJ0ORq5OBSRQiQMk28O+oGEGofpAVb/4WBYvgmFtV7u18jtxtx8Qu1xJgfmGpjjKnOG3vQYQPyr5cJOCYtMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4NuRSzneophvAHQnrvIAvJWJFDbAXhr1b1ZLHtQy98=;
 b=ymV55I8I6mUzKFnWN5tUynaldnxmJRYvo6jBtGAACyGQDsENSACxXkd7oDN4eBDr2CvaBJ2xMOJQEUX0Rn0hNf2g4X6q5v8iSvq6XgHdE8ITL89/ehONHMyzuiMcLCCl5z1Z3H6qrQ63nun7Z0Qo1hPFDD9666OVA03R6HJb+sQ=
Received: from DM5PR03MB3404.namprd03.prod.outlook.com (2603:10b6:4:46::12) by
 SA2PR03MB5707.namprd03.prod.outlook.com (2603:10b6:806:11f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 10:16:35 +0000
Received: from DM5PR03MB3404.namprd03.prod.outlook.com
 ([fe80::34:ff9f:15f7:2d39]) by DM5PR03MB3404.namprd03.prod.outlook.com
 ([fe80::34:ff9f:15f7:2d39%3]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 10:16:34 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: iio: admv1014: make all regs required
Thread-Topic: [PATCH] dt-bindings: iio: admv1014: make all regs required
Thread-Index: AQHZwH4RV2JH17iyYkyP+nPY8DJsEq/NfymAgAABKCCAAyXGAIAC23WQgAAsqgCAAADHYA==
Date:   Mon, 31 Jul 2023 10:16:34 +0000
Message-ID: <DM5PR03MB34043E68760E67F82C2770A59B05A@DM5PR03MB3404.namprd03.prod.outlook.com>
References: <20230727113136.98037-1-antoniu.miclaus@analog.com>
        <7f7d1c90-9969-66bd-fd71-defffe0e05d6@linaro.org>
        <BN6PR03MB3395F9139A225AA97A100B829B01A@BN6PR03MB3395.namprd03.prod.outlook.com>
        <20230729125516.68a29852@jic23-huawei>
        <BN6PR03MB339557689BCCF795B18C68319B05A@BN6PR03MB3395.namprd03.prod.outlook.com>
 <20230731111306.000036da@Huawei.com>
In-Reply-To: <20230731111306.000036da@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdXNc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy01MWEzMWVmOC0yZjhiLTExZWUtYWUyZC1kNDgx?=
 =?us-ascii?Q?ZDc1MDZkZGVcYW1lLXRlc3RcNTFhMzFlZmEtMmY4Yi0xMWVlLWFlMmQtZDQ4?=
 =?us-ascii?Q?MWQ3NTA2ZGRlYm9keS50eHQiIHN6PSI0Nzc1IiB0PSIxMzMzNTI3MjE5MjE5?=
 =?us-ascii?Q?MzMyNzkiIGg9InZrMHVjUWMvMEdyalA3UFhSZXJKZzhUNmw4ST0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?RGYvL3dUbU1QWkFjSkx1L3FNZEY0TndrdTcrb3gwWGcwREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBcWV4MVZRQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
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
x-dg-rorf: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR03MB3404:EE_|SA2PR03MB5707:EE_
x-ms-office365-filtering-correlation-id: cec49a9c-e07d-4ee2-d357-08db91af37d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hjZewS5bSq0jd60cR5ZFJUDhw4S+p+cDCt/A0YYF0/XRded1qqeqSc7gUhs7hBoF6ISjHcxtAt3Z/7I/k7ZZuLohCO9toDYuT9yRo/sdwwxCBQGSbOBY4nYJhHFpHuf2HOFLlbVEJ1HfMPo+TMYB2TCF5SiqETAUxgxOTQeoy17i1o2Ir7m2wlTImxcsWqLkKwXvedUftwu5VLlPqj++/HQ3adN4letvLPUAECR+Br9kRvJXqK9GknFbZ3iAAo0xqZoeGAICiHkh72+LgCxwpsB6ecVPq0yh/jTMwnImcpWylS2H1HzVTe/F3wMHQCkhgqcjYG+3uWnI+JVSDic+mXhgEgbAniwnCJoTfpyCrFRV53PYLDdeVkQQyccWHWeIm4O/91WWBoifIGj/lhFMJuv7UFxfjkpzOW2R6XUNiAXdtjx0WBqyAXKBgSYscJDm+Xqe/OJdmUflFZReQIELuSj1fRXjzcEi8mj4fAojF1PZTPDngUVB9acTefqD++8A70WdYAbfKPvtGR5JICK4XuARJ5vWj2a2DrJlAK1EBlp05DpdlgitiDr6I5Uen2LGSs8BJIqf5fTbhSLxtUNtpQt79VKCAhJb1lz8J04v+SM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR03MB3404.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(9686003)(966005)(7696005)(55016003)(53546011)(6506007)(26005)(83380400001)(186003)(33656002)(76116006)(66946007)(66556008)(52536014)(38070700005)(122000001)(54906003)(86362001)(66476007)(316002)(4326008)(64756008)(66446008)(5660300002)(6916009)(8676002)(8936002)(41300700001)(38100700002)(2906002)(71200400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zf8FXfsOkVt3DQEn8YsLOX0nWONpS26e55E7Y0YLZAjkFQZsL0Gsfwd1F4UZ?=
 =?us-ascii?Q?cx6NhgiNUXTjSaVAuNo+UBtfNjUQgclNYGNTaGgEZhjQOjdrVQQE83X0P7Zw?=
 =?us-ascii?Q?HnaLlVZXCk9NeiX0ipsmUI6wv12Rqk2Z8ZxYwIaqB+Wbtl17/zkKHc/DhnFF?=
 =?us-ascii?Q?HS3iBDNBp/xRHM6K4MyPKwgD713PYvmYZeYuKE4t2kjkR+H/r4odhMcmfDaC?=
 =?us-ascii?Q?Hpa3ohma6bmXkV9c7Ud943YdSlk7n3EegwpNnP1eO9gBzduCogXfXzeJV6+K?=
 =?us-ascii?Q?VKs7RGqKtosPTmK34LTp+gvKbDpntocUQWlq9DgVtpgDiuNkt/zMTG4nppuO?=
 =?us-ascii?Q?YsJasVBCSbeWBz7kKfao3SMW7GpCgM1PIGXS2ttqr5qQcauGXPyDYj1vy3RX?=
 =?us-ascii?Q?5khyHGzMwLaAQ0ghyn9yyAfRDqEW/47qIQnGpShLl6/AeCqw1/WYXXTMMWOW?=
 =?us-ascii?Q?B0/oYNJ1B3fcrpGfWUHV3KW+dbmXrIZRkzRylFsKJUD9TfG9gqVXn6e9WbKw?=
 =?us-ascii?Q?ebtyjAcF7oWh28B+zN9buuvdnIGMYRBp6U/PaeZ5ln/NYYqtrmbnf6y9kZO5?=
 =?us-ascii?Q?rKY9Sv81Lm3+qekF3N0J5tshXFxMEUVRI+jLKmopZ7BuObmdlVtYx011dWT1?=
 =?us-ascii?Q?hA+8RXGAULV+WVzrULNkNVpVM5dJFjNtEW+YpukTMW1Z9behgYxKwCv7nN09?=
 =?us-ascii?Q?F3oh9yfoY3pcsMzYuoDFGN5PnLgYXpOHLA1hFYDyLUmEG60GpxPhAzJBuGm9?=
 =?us-ascii?Q?uaOa8/c4hKfGRa8qhqr/BFbVPFDT9o2Rny3e4yyLg3zPsawNRNdEvP1Z5i0H?=
 =?us-ascii?Q?DL4SQu4cWdHMOpuoPPe1ZqjDdT/bWfslLGHczHVxJxlqpwve9uG1SXtrryil?=
 =?us-ascii?Q?l/TGJ99Lv/Oz1MietKqL0UHEMb5ksgUmC4M74uROFEnXBCdVEJN3bRr61Dgs?=
 =?us-ascii?Q?fTUDd7lOwtUajO5Y7fQNES4yZv52vZkuilbtuDU/xpPapECfVyThIRVUEV7G?=
 =?us-ascii?Q?EpROh+b31Y/R2+xg1svr2KkMmad2Wl0MQiyuiB0mKk8C85GJPkzeEDMAUx7C?=
 =?us-ascii?Q?eLVuQrzrTIIHQI4fT2ZLJZzEvCeCKN6joZP4iNwoRRHtW+ltGsQ1kHWlfERl?=
 =?us-ascii?Q?TqKavMClb3dvowGG1nZJzXZNuJ12kKWtllIgWnLGkHeBE1gN3tGnaHCIuAB+?=
 =?us-ascii?Q?risLG/GZGHPjowuSutYfeHVxOG82SKTob+qEWmyuKnswksp1yF7rBw/um62F?=
 =?us-ascii?Q?XXHk4ldoQTsOwqnyNYbqJD/TsUVk7ocpAyDlO1xlbYRoLntlHSIwPybCbhAc?=
 =?us-ascii?Q?CnOhK98VwDu19O96+ey9qVJGrZ1ljyHhZEP+VuraCXHhe47d6tqsIbhYFWvK?=
 =?us-ascii?Q?7RHdYdegj9esoNpg7KmueDpPaOqyJHs4wXOYmVWGZuCnZ30CPi7sem5z1Nbe?=
 =?us-ascii?Q?2cbxs0vdBCBdNratmRX46tRlnDwqjndKOYjNtvy2BmyCnP/Ai+2TwlZlgVvi?=
 =?us-ascii?Q?YTFwN8jtCLHVgRhwl6g64+JaC+HRcOt4E44lejr/m9y7QT9jij+IV5agkX52?=
 =?us-ascii?Q?2H3aNQ8hdesagAcP1jaiHIesetCnB+VbAPa7xvFd15dYuCfePFD2qy1iXCtX?=
 =?us-ascii?Q?nQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR03MB3404.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec49a9c-e07d-4ee2-d357-08db91af37d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 10:16:34.4515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q6ZkaiAZ7hc3WGtwKuxrIe+IbKFr4YnyBOcHC77Wse1akeUb+PwE2nU2LcFXp85dChqGC4ZBy5rGLKYdVc63CvVEMTvZ6K+hXfApF7rNPvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5707
X-Proofpoint-ORIG-GUID: sZerLnuTlXCv2AcuJuzsKBXzgD_gDURe
X-Proofpoint-GUID: fwdnFtXkaM84LHLY5rltMxqv-aBECFlj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_03,2023-07-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 bulkscore=0 spamscore=0 mlxlogscore=864 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2306200000
 definitions=main-2307310092
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Monday, July 31, 2023 1:13 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org; linux-
> iio@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] dt-bindings: iio: admv1014: make all regs required
>=20
> [External]
>=20
> On Mon, 31 Jul 2023 07:40:14 +0000
> "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Jonathan Cameron <jic23@kernel.org>
> > > Sent: Saturday, July 29, 2023 2:55 PM
> > > To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> > > Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>;
> > > robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > > conor+dt@kernel.org; linux-iio@vger.kernel.org;
> > > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH] dt-bindings: iio: admv1014: make all regs requir=
ed
> > >
> > > [External]
> > >
> > > On Thu, 27 Jul 2023 12:02:04 +0000
> > > "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:
> > >
> > > > > -----Original Message-----
> > > > > From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > > Sent: Thursday, July 27, 2023 2:47 PM
> > > > > To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>;
> jic23@kernel.org;
> > > > > robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > > > > conor+dt@kernel.org; linux-iio@vger.kernel.org;
> > > > > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > > > > Subject: Re: [PATCH] dt-bindings: iio: admv1014: make all regs
> required
> > > > >
> > > > > [External]
> > > > >
> > > > > On 27/07/2023 13:31, Antoniu Miclaus wrote:
> > > > > > Since the regulators are required in the driver implementation,
> make
> > > > > > them required also in the bindings.
> > >
> > > This bit is probably not strictly true.  Try no providing them and yo=
u will
> > > probably find stub regulators created on assumption they are fixed re=
gs
> > > that we aren't interested in controlling.
> > >
> > > > > >
> > > > >
> > > > > The true reason should be whether the hardware requires them.
> > > Because if
> > > > > hardware does not need some, the driver should be fixed.
> > > > The datasheet is not very explicit on this topic, but all the speci=
fications
> of
> > > the
> > > > part are built around these pins being supplied.
> > > > Moreover, the evaluation board or the part comes with all VCC pins
> > > connected
> > > > to fixed supplies.
> > >
> > > Agreed - these should be required in the binding.
> > >
> > Hello Jonathan,
> >
> > Not sure if I fully understand. Should I drop this patch?
>=20
> Patch is good.  The binding should state these are required - it doesn't
> mean that the driver will fail to probe on systems that doesn't provide
> them.  It does encourage any new DTS files to incorporate them which is
> good to have.
>=20
> Only thing that needs changing is the patch should not justify the
> addition of these to the binding because they 'are required in the
> driver implementation'.  Just drop that statement and the patch is
> fine.
Great, thanks a lot for the clarification.
>=20
>=20
>=20
> > And also drop the "required" of the regulators in the admv1013 patch?
> > https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-
> iio/patch/20230727110121.93546-1-
> antoniu.miclaus@analog.com/__;!!A3Ni8CS0y2Y!8dQigVuPYwGwS53vsq2RO
> CJx3RgfeZW4GZks5EFWhfUlJZTdAvsCr5MGlrWUVHXwqRKoASc4UBEFE8h6N
> KO6jrfSQ-oKjKtS$
>=20
> As long as the patch doesn't say anything about what the driver does
> then it is fine.  Note DT bindings and patch descriptions for them should
> never mention the driver.
>=20
> Jonathan
>=20
> >
> > Thanks,
> > > There was an old disagreement on this in which it they were not marke=
d
> > > required in some bindings because the regulator subsystem would
> assume
> > > they
> > > were fixed supplies that were just missing in the DT and so provides =
stub
> > > regulators.
> > > My understanding at least has changed and now we mark the required
> even
> > > if
> > > the driver works fine on some boards without them being supplied.
> > >
> > > Note though that this means the whole of trivial-devices.yaml is garb=
age
> > > as very few devices actually work without any power :)
> > >
> > > Jonathan
> > >
> > >
> > >
> > > > > Best regards,
> > > > > Krzysztof
> > > >
> >

