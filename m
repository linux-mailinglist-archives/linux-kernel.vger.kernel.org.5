Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5DE7B18A7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 12:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjI1Kys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 06:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjI1Kyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 06:54:45 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE39194;
        Thu, 28 Sep 2023 03:54:43 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38S7DEI4013239;
        Thu, 28 Sep 2023 06:54:28 -0400
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3tcda5153f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 06:54:27 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDgwvfXbs/vu1tlGN23uSgldmAYtJYkSvJZ+3/fJaENUFfBu50eQCuIZBDNco8NJPUXI8ZS9lscODF8V/8UhDNyhTjKZuuD9Z7rWoFC/qfv4szOy/XZBsLtFzVUw/+4w0HRPfcU7qcnu/Vce2fsjNDjdWBsvXwXFapzcTnhAHe14ZqIEYzW3u9JJ3MfMSZddHXj2Xv3pJEu3CMTiLMQr3xwiA/d1/Yhgl8qkjXzYCzhAOG/zJJHgGfxpKbmd6M+el5EETVhk5NP8RiELwMbXeve2Zu0DTVDxIEBAAq90Cayn6sHJR7DRw56+QTInfPMP7vwbSePYHBzM4l0coI9wXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyXRXn/k4qp7hb+ryjAvuAjbnJzGCleE9MhENv54shs=;
 b=HI6kCD95FddKrLyA6Sm9KFeFqlN9d+fxf8ZMPJmZ6gKOCBQ3d+zcCpwXYzf9BJ6a9YdaMIOuKl9J0WulTA+K94+CjuJ5NTzvpbonopx/Dc4m/p0hL9KPKj1zoHcEkohQMlUoTSguwvaZbLF23u2AhTkPbly+ZmNvJap3L4rtxkuRnUFevpIuqlI+FIPbnXNPu6+73Q8BBuP6pI5u7CcDrtP0bo8GadfoWID39CbxiArsFrbf2IDyD6116QzBA1uZNhMdzm2w00UETmRPSW5/PUolmHSILByXRIvjaYs5G3ZWHWFfyFRh1rwMRpwgRoBCaUiGZpyGPXDJWZ/gcNUNNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyXRXn/k4qp7hb+ryjAvuAjbnJzGCleE9MhENv54shs=;
 b=5NAQJGQ66IjNwReoTcLfxIOaaVo09Dz6y5RPlAB/JjQyfGk2T0v7KmsKNbp5IDA9gwlVYnn2qP/q3pSZJcN2eY82xZIub2VQ6HZczeiLp1X083k/B3Nn88Q8RtLTYAT66Wtjbw2dle1mRkQYU5/9PJnOEd/ghTuXbMHO8SsmNeE=
Received: from BN7PR03MB4545.namprd03.prod.outlook.com (2603:10b6:408:e::31)
 by CH3PR03MB7435.namprd03.prod.outlook.com (2603:10b6:610:195::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 10:54:25 +0000
Received: from BN7PR03MB4545.namprd03.prod.outlook.com
 ([fe80::e1d5:636a:bda7:1c81]) by BN7PR03MB4545.namprd03.prod.outlook.com
 ([fe80::e1d5:636a:bda7:1c81%2]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 10:54:25 +0000
From:   "Balas, Eliza" <Eliza.Balas@analog.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "derek.kiernan@amd.com" <derek.kiernan@amd.com>,
        "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
Thread-Topic: [PATCH v2 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
Thread-Index: AQHZ8e7G+nmLWHb/Z0ShhzBMq3cwPrAwA0wAgAAEH8A=
Date:   Thu, 28 Sep 2023 10:54:24 +0000
Message-ID: <BN7PR03MB4545DC903A0D62639085591697C1A@BN7PR03MB4545.namprd03.prod.outlook.com>
References: <20230928092804.22612-1-eliza.balas@analog.com>
 <20230928092804.22612-3-eliza.balas@analog.com>
 <839638d2-7502-4925-8b7f-6b15779a6840@app.fastmail.com>
In-Reply-To: <839638d2-7502-4925-8b7f-6b15779a6840@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZWJhbGFzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctNjEzNDBhNTEtNWRlZC0xMWVlLThkYjItNzQwNGYx?=
 =?us-ascii?Q?NTcwNWY3XGFtZS10ZXN0XDYxMzQwYTUyLTVkZWQtMTFlZS04ZGIyLTc0MDRm?=
 =?us-ascii?Q?MTU3MDVmN2JvZHkudHh0IiBzej0iNzY1OCIgdD0iMTMzNDAzNzIwNjI2ODM5?=
 =?us-ascii?Q?Nzc0IiBoPSJrU2ZER0NJQWpHN0JBTFlsVGR3NExVZTBKWFE9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFFb0NBQURl?=
 =?us-ascii?Q?b0swait2SFpBU2U4TDlGNVlyOHpKN3d2MFhsaXZ6TURBQUFBQUFBQUFBQUFB?=
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
x-ms-traffictypediagnostic: BN7PR03MB4545:EE_|CH3PR03MB7435:EE_
x-ms-office365-filtering-correlation-id: f8368558-dd27-4b0e-aae1-08dbc0114737
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m21B6xWNCxtEAG/zswuwYyq96GMdNpm0ndMixvgmoQbxSWkKYSDyFIc89XqAjdOx6mtz92EEIFIdTZ121WIeAZWzk/wMjci3+zT6Ap/6aWbt2Fs8TXwEPbCACB3eySfMzQucnIOeM+bLjUVW4vcVEnGwn/TS5zSRMWVOg7APBb4BmZLFo07NRrKJBgxTboVnEZ0QJpMDYdAv3artrBEJ9bcMONBdQGPcTxxvh5sTayQMu6flWc9BWN9ZaajGbo5O3NrX6ssZi9VKPj9RhtezWedMJCBByBBUTzeBAFRwnC7LfC+YyK5MMgwtFcA8pCkYgbiCD5GWNDw+LZdzC0b089QDNG+aaxGdRc/wc4FWVu5S9QgRStVYSmW0Quu1GKzWLNMyWfxKCBYuVyCc+ugWzSi8jDcMh3ZZGdlUgO3hX/wu2xI4sSN3qRCGkFfPyVonjFFHeoNw4b5M/NPzV6CwQyI9fIYH8l8mw9HDX6j547TgyoTFzxuySub5SW7en3GouQop1NpKYVuosWw1cmquX+4TxafimANyENGf1o3b8MetBGKLkQtpkTbWh7Vfp8cVlqtlhur7mH+W+ocUrGZKEiRjAWNAGnuzpdkWerXETPY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4545.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2906002)(38100700002)(478600001)(71200400001)(83380400001)(122000001)(38070700005)(26005)(7696005)(9686003)(53546011)(86362001)(33656002)(55016003)(6506007)(966005)(8936002)(41300700001)(8676002)(4326008)(316002)(5660300002)(52536014)(76116006)(66946007)(66556008)(66446008)(54906003)(66476007)(6916009)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RZqI1lSkpQSmgk4SQP2Fic5YeFUBtszvsi0/iOUuvLOUg+9cudV/r9SfLhKo?=
 =?us-ascii?Q?rKwBPpqZxLukAO+sMbxLpN3hIEVizW71+QByJwE8k2Lt0j4INp6t7NbIcKB4?=
 =?us-ascii?Q?skNZIdgDgAHHjUsMjAzXr/XHfV+WejZqb308N1r+Wxailch+CebFykHxDoRB?=
 =?us-ascii?Q?cCCuTCM5pwPuPeE9JOVj/yFFSOf4FjlsvclZYWe4Tq7lg6tL4KPu07AyGWXD?=
 =?us-ascii?Q?hf6bZQoOqnyD8S20ZzYrdjt+1CugCns0eTjr7O1qNFI1A+vidmYnEkon+h6k?=
 =?us-ascii?Q?3UzpvPsE541VXuSQcYeftQv4NO1ClmC4jt5FcK47ioOmDChfxJjqrnp05F8/?=
 =?us-ascii?Q?XnSXlmvpbtsRpwTxHde8IFFuumgCMJrZYPYOLy5riOoo6t4UGkOHZm/3TJy4?=
 =?us-ascii?Q?McIRxCgo+2lIPAcLuWrGuCxFa3r3ihcYHpAmKecPHkHIAE4Qmmb2OdV87MwG?=
 =?us-ascii?Q?W33xzdAQ5WNdmTOths46Z2n4W9DrwzXIdZiBtj32ifw+wdXWEBov8EQ/8/08?=
 =?us-ascii?Q?4yWclFlGS+0QK0XUAGNAcf28wAJNqqVrxMvz+jd9Rycew44EXPtMzPrqldRH?=
 =?us-ascii?Q?ojFStfF4MxviIBOqv09ovy0k/OiDFyNXqOPSLpwSB77a98DMnecvlXWtxORU?=
 =?us-ascii?Q?HIAL/3pulUcbIJDJa7Mm6m6NC88YubWuoItNMczt6XHU+EUglCk+kUHPqkMP?=
 =?us-ascii?Q?K3j48FADQ0bXteEtqD8+IWSpR3DSHfACSZuY6+YYLb1PNv+4yGeKFC5EyzO3?=
 =?us-ascii?Q?GLJ1XSdENrRsV8USyEJYA9yNy0+iZGEiIW5u4IcmGI3wUvOO/zzJbBdq/g8I?=
 =?us-ascii?Q?MyU9V3EAswvwxz22c0+0k3hADKkXOao0H2FUk6wsIPeb0b7706AezQf+wAcu?=
 =?us-ascii?Q?9Q9GW5yLp3gGXzs66lFA5s3vRwiY7P6ysBziD6+/gPZECZHPLjkSbow1C76O?=
 =?us-ascii?Q?iER/quYvZA/9YvLbbB1dABGVec/BpWaFGSgnMHwnvYZjvaO8v5SzRwBgu7jp?=
 =?us-ascii?Q?WLvmLfOcUxe/jZnSbE6e/w44Hv7DTm2+DeXIWqJDAPKM5/+Vd67i+4j/q6OY?=
 =?us-ascii?Q?lJitEZq9rwwzjWIv62arAm0H0xkGUoGh7cpUiJ+mPkV0iZ7BsWm1b9UfZle5?=
 =?us-ascii?Q?9gjmgmiBD/1e5xq6Xgily40ASDPdcuikpavCGD8uLwy97hBVIPGTDbnuj2sg?=
 =?us-ascii?Q?Z83fQEUoDRF4dXQGPwC/jmQs3UHZ8VlODN0KRsGW2bDfxLHoNlUb+pnOkk+A?=
 =?us-ascii?Q?GWUFDVUkvswnMWaWAyXdmVGAHAUNx8puU7YNYGBBcB0YQpKMA9vVSP78f7j5?=
 =?us-ascii?Q?sWIjk36r4noiyhBTFUDAhYPJIONYjLRA83VkvDQpx7F5SbCxLtlDvkHKmaVL?=
 =?us-ascii?Q?YZp7k8MXYeu1ZdhkkWuBD+z2jn8gDXOQ4bqtwwFfTv0mf3L7AKM17DsTiDYH?=
 =?us-ascii?Q?8eMVeaL8uuYy7xdzyblOsFK7KLYduHqjQ0MzZwp+Czw2+A6oQkGQvn1RbFKK?=
 =?us-ascii?Q?K33LihsnH8QcC9ZrWG+wTmNJLINMJ+7PYihaKOzxYAGxOa0WfwmTFDJAUB5R?=
 =?us-ascii?Q?l2EL/F0RLdd6+irBpus8DcU8fh9/KadlvDKUrfoU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4545.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8368558-dd27-4b0e-aae1-08dbc0114737
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 10:54:24.4851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a66I5hpYgMpdfU3h6i1xn3sOaDytZwwgFhHQ7Z6r6tTAI4w2qqhDAhPrsTMXB9vvdJsHp3Ny45tWVxrXKpGdTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7435
X-Proofpoint-GUID: MjuCwA6f4XQKY_agNoDASm-BJOmzbAEc
X-Proofpoint-ORIG-GUID: MjuCwA6f4XQKY_agNoDASm-BJOmzbAEc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_08,2023-09-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 impostorscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2309280091
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Arnd Bergmann <arnd@arndb.de>
> Sent: Thursday, September 28, 2023 13:07
> To: Balas, Eliza <Eliza.Balas@analog.com>
> Cc: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski <krzysztof.kozl=
owski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; derek.kiernan@amd.com; dragan.cvetic@amd.com; Greg=
 Kroah-Hartman <gregkh@linuxfoundation.org>;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v2 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
>=20
> [External]
>=20
> On Thu, Sep 28, 2023, at 11:28, Eliza Balas wrote:
> > This patch introduces the driver for the new ADI TDD engine HDL.
> > The generic TDD controller is in essence a waveform generator
> > capable of addressing RF applications which require Time Division
> > Duplexing, as well as controlling other modules of general
> > applications through its dedicated 32 channel outputs.
> >
> > The reason of creating the generic TDD controller was to reduce
> > the naming confusion around the existing repurposed TDD core
> > built for AD9361, as well as expanding its number of output
> > channels for systems which require more than six controlling signals.
> >
> > Signed-off-by: Eliza Balas <eliza.balas@analog.com>
>=20
> Thanks for your submission, I've had a first look at the driver
> and the implementation of the interface you have chosen looks
> all good to me, so I have no detailed comments on that.
>=20
> It would however help to explain the ideas you had for the
> user-space interface design and summarize them in the changelog
> text.
>=20
> You have chosen a low-level interface that wraps the individual
> device registers and gives user space direct control over them.
> The risk here is to lock yourself into the first design,
> giving you less flexibility for future extensions, so it would
> help to understand what the usage model is here.
>=20
> One risk is that there may be an in-kernel user in the future
> when the TDD engine interacts with another device, so you
> need a driver level interface, which would in turn break
> if any user pokes the registers directly.
>=20
> Another possible problem I see is that an application written
> for this driver would be incompatible with similar hardware
> that has the same functionality but a different register-level
> interface, or even a minor revision of the device that ends up
> breaking one of the assumptions about the hardware design.
>=20
> In both cases, the likely answer is to have a higher-level
> interface of some sort, but the downside of that would be
> that it is much harder to come up with a good interface that
> covers all possible use cases.
>=20
> Another question is whether you could fit into some
> existing subsystem instead of creating a single-driver
> interface. drivers/iio/ might be a good choice, as
> it already handles both in-kernel and userspace users,
> and provides a common abstraction for multiple classes
> of devices that (without any domain knowledge in my case)
> look similar enough that this could be added there.
>=20
>      Arnd

Hello Arnd,

We are using this driver with an iio-fake device https://github.com/analogd=
evicesinc/linux/blob/master/Documentation/devicetree/bindings/iio/jesd204/a=
di%2Ciio-fakedev.yaml  so we can take advantage of the iio user-space inter=
face.

We talked in the previous v1 patch emails about adding this driver to an ex=
isting subsystem, and I raised the question if we should add it to the iio =
subsystem, but the driver is not registered into the IIO device tree, and d=
oes not rely on IIO kernel APIs, so I concluded that misc is a better choic=
e.
What do you think?

Thank you,
Eliza

