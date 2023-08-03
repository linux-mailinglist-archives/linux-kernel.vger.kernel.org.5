Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBCA76E6F8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbjHCLeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjHCLeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:34:08 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C7A1982;
        Thu,  3 Aug 2023 04:34:07 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3737nH8R012620;
        Thu, 3 Aug 2023 07:33:54 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3s84q1t3cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 07:33:54 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEEhzKO6eiF261fgQv1oydPszFvoQi2aSScgLbgI0k/ca5A3pFBQdVwnRJ4ptzo5AeBVUiP174hjrLL/4YvinGrTBtgDO+GS1plvCi0E/GlqS8urG3CbukkSEfNWgNnaiFuhngZaaQCKv1KbSQud+ddjbCwSSBsn4kU6G1X3Fyi6wcVLyPuZxY5d02uSa7KSBMG/vDq7BacAIjon287rLjGG0Hz8btDgu0aI7Ea1hE091PyfKzntC4ARqeNeCgqKxHDGWzwjqokoMyAGveNulDE0Esh2eG6ZniaO/anyBBhayh7bXjaweKBm0fjSOuju7Jxv0qSYoCDs5dYNAkbvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3hSuKyodCJBzm7sjAjr1yoQnwV5De2mL/2VvMKXOy4=;
 b=SBRFgN2bAR+ze656bZQLsZW51udiiBAsfeIcPQg0PoIp0M7UivStYV80kjvlUcOOG562FrCPCEyvMOxyRfKn2c8XJbNmGkxL3YLIvdzJS2aEgjxqGhM4+EvuwCakqdzKzvhzeTXMgcABVGNw692kXfND3w5bbMr0F+1yuwx8yNe1HyMWsdhqREXRDBQmWf7kpxvsiC4+Cw8tr+mC+kfZoqvwDGsKV+6JkMbt5UQuX2K14moermM0Jrj0+D2llJIGwY967hD3JszG8aqSHPjmSOLTll1nFQHx898ZrRfrpBX65GsXKe138XwyARLE7TGyITaecslt5jDXSOGcEXgNqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3hSuKyodCJBzm7sjAjr1yoQnwV5De2mL/2VvMKXOy4=;
 b=n1b+uU7NOjU2WkHbmxx1pBgz6tc4sEhtOxXf0l86CJDH1dLBLkKOMcxOcbrEpWx1hfAFgcAqT1TGNfIN1Gfng3mF1DD4kxiEuDbc0VsgeGj17Lx3E1G0Ht9RZf3zL+YDvvYHaeUFWrvUB68vl8spdtgnWYWWq8mVmkNaStLABGU=
Received: from PH7PR03MB7391.namprd03.prod.outlook.com (2603:10b6:510:2e6::5)
 by SA0PR03MB5578.namprd03.prod.outlook.com (2603:10b6:806:bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 11:33:52 +0000
Received: from PH7PR03MB7391.namprd03.prod.outlook.com
 ([fe80::200d:e2:3bae:2a5b]) by PH7PR03MB7391.namprd03.prod.outlook.com
 ([fe80::200d:e2:3bae:2a5b%4]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 11:33:51 +0000
From:   "Sahin, Okan" <Okan.Sahin@analog.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "zzzzTilki, zzzzIbrahim" <Ibrahim.Tilki@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux@leemhuis.info" <linux@leemhuis.info>
Subject: RE: [PATCH v3 2/2] regulator: max77857: Add ADI MAX77857/59/MAX77831
 Regulator Support
Thread-Topic: [PATCH v3 2/2] regulator: max77857: Add ADI MAX77857/59/MAX77831
 Regulator Support
Thread-Index: AQHZuGy8mN9TLCcuJkyLQ19F8fkBDa+/r5IAgAyW/YCAARHLsIAAaoOAgAn0bACAAAK6AIAAAIEAgAAAvwCAAKY8YIAAJSuAgAAE01A=
Date:   Thu, 3 Aug 2023 11:33:51 +0000
Message-ID: <PH7PR03MB73913EC7C2F254BFCC465557E708A@PH7PR03MB7391.namprd03.prod.outlook.com>
References: <20230717050736.10075-3-okan.sahin@analog.com>
 <20230718155502.GA3542993@dev-arch.thelio-3990X>
 <20230726161033.GA1102409@dev-arch.thelio-3990X>
 <PH7PR03MB739122A373964651D995EA5AE701A@PH7PR03MB7391.namprd03.prod.outlook.com>
 <20230727145143.GB2013261@dev-arch.thelio-3990X>
 <CAKwvOdnPQEdbTGBO0hBn7CC4d0xtRV2zmfrYDfAhH0stfDYeJA@mail.gmail.com>
 <32af6891-8246-46de-ba1d-ae1999f6eb10@sirena.org.uk>
 <20230802230426.GA3027248@dev-arch.thelio-3990X>
 <ae431bb5-d132-4737-b4bb-58a323f877a6@sirena.org.uk>
 <PH7PR03MB7391287FA2CF2C1982724952E708A@PH7PR03MB7391.namprd03.prod.outlook.com>
 <4ad70585-fc34-4c65-9de8-09892a6a5c2e@sirena.org.uk>
In-Reply-To: <4ad70585-fc34-4c65-9de8-09892a6a5c2e@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcb2thbi5zYWhp?=
 =?us-ascii?Q?blxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?us-ascii?Q?NGJhMjllMzViXG1zZ3NcbXNnLTljNTg1ZDkwLTMxZjEtMTFlZS1iZjAxLTU4?=
 =?us-ascii?Q?NmMyNWQzYzNlNFxhbWUtdGVzdFw5YzU4NWQ5Mi0zMWYxLTExZWUtYmYwMS01?=
 =?us-ascii?Q?ODZjMjVkM2MzZTRib2R5LnR4dCIgc3o9IjExMDQiIHQ9IjEzMzM1NTM2MDI5?=
 =?us-ascii?Q?MTI1NDk4NSIgaD0iSDZWb3dMbTVsdFhaSkt4UlVSbVVwQjhSSEN3PSIgaWQ9?=
 =?us-ascii?Q?IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBRW9D?=
 =?us-ascii?Q?QUFESjhnMWYvc1haQWRCU2FWK0FxbCtiMEZKcFg0Q3FYNXNEQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQVFBQkFBQUF2ZGhreGdBQUFBQUFBQUFBQUFBQUFKNEFBQUJoQUdR?=
 =?us-ascii?Q?QWFRQmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJ6?=
 =?us-ascii?Q?QUY4QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBBR2tBZGdCbEFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFaQUJwQUY4QWN3QmxBR01B?=
 =?us-ascii?Q?ZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlB?=
 =?us-ascii?Q?REVBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBWVFCa0FHa0FYd0J6QUdVQVl3QjFBSElBWlFCZkFIQUFj?=
 =?us-ascii?Q?Z0J2QUdvQVpRQmpBSFFBY3dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIvPjwv?=
 =?us-ascii?Q?bWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB7391:EE_|SA0PR03MB5578:EE_
x-ms-office365-filtering-correlation-id: 9435e3ea-4057-4521-35fc-08db941582fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wVhH9Wp4MrX5KMLCpeqTwwy8nWpTY8hzfYrQ5E+N/ZPbVf9BP+IA10owhN8cD2dkZc65GGY870kKW3oXdcVNfEZQkgglB/CeyWIWCRlCbAq0tl2+GQSa1WPa2EyCwUN5u18tndScZjVphcx1cCzTUvlOJEAsJcgg6vd7aNlLwxpiAzVSEYOQ3jOhlbzVz8VZxb9B94Pht2B++uz5sUPW5q46aPtsCzN1f8gQQkADvJnEH6QLNRs1ZTRtP3xyfxGbElPlu2aVEjXtvF5tXGxw+62OSibuIRMX6dsFuLaI7CLtO9hfqHwRq591w3MTGDs1F0x18tWSQ9Dq8V+GiIz/ghgxWd/AeHLFSWrX4/ZQFtbHoAFRiQaXVID1IcyOeExVKXHDSWk6F1ZGSuzCibwxUQlNr5QW5VOhl+brVo47fnHs891dvjYVU70eHTmuyd4yJqfXKayNvB1PnYfsAOK86k3Kro7YWSHlelI9kg/IGEyOBTKayU/NpfIrUpVdzoSy0+SQFRSm8Ye0rFKnoVnGg8p41nVQTHl000JwQ1ThZ/3zbMqs9phQbEreuvdHe24am8XfeHM3vXwYr7WuMLc+DeMT2ZEg/2Dcy1P6EY5PLBi47kZZV6ifmBHsHjI7y3CU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR03MB7391.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199021)(4326008)(6916009)(316002)(64756008)(66946007)(76116006)(66556008)(66476007)(66446008)(122000001)(52536014)(5660300002)(41300700001)(186003)(26005)(6506007)(55016003)(8676002)(8936002)(7416002)(86362001)(54906003)(9686003)(7696005)(478600001)(38100700002)(38070700005)(2906002)(4744005)(71200400001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZYekM+JjOP4WmPxVKkUz2e6JcBoZhkKR1IGHNdoAfZZMpOweVFkrQCLjqoSc?=
 =?us-ascii?Q?8puUUQBt91t70XUs0wDXMAf/IeTukPLF8JkaF53UDNynrZrl3ypOb9yCmgOk?=
 =?us-ascii?Q?DpZenIwfbJPblO2WQL1CJ7GUd3KQu/QAGemPHYyELINVrNz69EOhx/mgTg8K?=
 =?us-ascii?Q?0U6Q9uOZcM2RnbKLGQwt1UFqXSMMcj6xtn8sggER0wT9FwMvoRM5CaKcCt4x?=
 =?us-ascii?Q?eqtftuFEpeDQhco1fAHXY/2T77j3YDLmRWwc79wv/fm5kmWm1uZcSxwDhtB6?=
 =?us-ascii?Q?na8pYI2UfAv2mfYeIlBFd79HcFbV/FOTuM6M1CG9L1KKs5VkyOQQPKp7wlgT?=
 =?us-ascii?Q?1mpytXuBYs0GKhaiJ/1O30ey/8N5wDPi4GMZf0uQLJBYoU3qqmG+Z9Z3+mvL?=
 =?us-ascii?Q?vHJRI2XlMXuxWK7ywuF7IJJpAC7snfKs6ll6FyK0rYdBSHphXhLiLCCC8Bnw?=
 =?us-ascii?Q?g1sIQZmeiz0LIjP/CC0XpY83p+LvsdhLYALX2k9yWXuSZJHzHBZzq7Hl/pTa?=
 =?us-ascii?Q?BfA94h5U+czFMneQPSlYgxcITqRj5ho2E1QS2XPqP+0adcf8ElbAIOYY3pNc?=
 =?us-ascii?Q?JXskz0GpXjeocXnmBWBhw0WXE5x1p++UtIMnk91pw5I5i76IUVDx1oGZy+iR?=
 =?us-ascii?Q?6Y2zb/ykkgvxG8wIZuwsNAGVy5JMf28HUDdlNo9/Y0AgWgft5yEP8EqskmtP?=
 =?us-ascii?Q?e+tU7h1yy+PuybIfg3hKbJmUu3PfqsjSZSoSw7v/7ItihO4B7o8Jm1zVjZwE?=
 =?us-ascii?Q?rYWD/3s/aNIozacAYxPQEG6XkwQJ5U2o8d7kLKVL/Bb06PyCOVlk32zXbBkj?=
 =?us-ascii?Q?Z8Lq/fqgfVNubtr2T4Gd6fIBdEmW5+rqr7V2WJ1lfk22lD53eCb+Z+38+hy3?=
 =?us-ascii?Q?bEKekB/6XU65Xi9OI3SWbk/4M/7ydKFDPistLP1jK0+u5/mBBUfkhzs6vzTF?=
 =?us-ascii?Q?AGqMdoSZmEQHzt4jhh5NbH/kQNTPIzGXfXr0ttyzw8Gx+UtI13Raf6yk3ydv?=
 =?us-ascii?Q?w7mLO/MUeYllmCfzec4uqYLB6vnACTJ+QGIAMPVa8C+lVLMqv1R/5Mgz45oM?=
 =?us-ascii?Q?24RnrVDO9ed8Og0G7At3Vqm6ecGs6yfHhhspof+pk/tfvOYCRcAxkQKfFVrd?=
 =?us-ascii?Q?1Shux2yTniRlLRH2pLDYLWnNJ1f626GUvBtCnfaX3Pfirh4Ez5d13Uf77dgz?=
 =?us-ascii?Q?uh8A2m0eqo6m9M9rDANO+RdI14+O1mFJZgCA1J5zEqDVfCSDu2MEt7w7gbP0?=
 =?us-ascii?Q?1ogu6EBEzr+MQ+DBDAjq3CkR438erOehJgcib/sonEfYfpHhA7QrfLqPx+9y?=
 =?us-ascii?Q?AzSYsmOcczBeILTw0tQ84ntSXjXrnyDp5tuUOMjqsTcC949SdvjgLqYYjKUJ?=
 =?us-ascii?Q?6YNpCqyAECqvAg3iy1y0gEgc9KEILxdEWz1djfjc8rVmP26cRsDB30dUoMU6?=
 =?us-ascii?Q?uPdh36MqNVvBdJU9NnMi/s99JHTDlx4Uv2WoA34x6xGlMg/LRm6NRwhnuw22?=
 =?us-ascii?Q?3UfHE/MTi0zA560IUmbuCx5bqjHcrdQXGC+a8t2e6iUK0UOHeaf0Sii9mxM2?=
 =?us-ascii?Q?DZhs00unUUpls2xDbOOSVnJuh9qId0upwf+B2qBA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7391.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9435e3ea-4057-4521-35fc-08db941582fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 11:33:51.5371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sF86/SxZncMJgpEL2Cz/EmNgxI2weMVbZnmgJFpdSmIBtm6koWGuAr8aYzpmhUK1Tu1P6c9b6ku/bK5xrSzYCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5578
X-Proofpoint-ORIG-GUID: fFANkbTY2QNxCm8xIMO1VuVMS1X8h9Qf
X-Proofpoint-GUID: fFANkbTY2QNxCm8xIMO1VuVMS1X8h9Qf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_10,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 spamscore=0 mlxlogscore=617 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308030103
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On Thu, Aug 03, 2023 at 09:10:26AM +0000, Sahin, Okan wrote:
>> 02, 2023 at 04:04:26PM -0700, Nathan Chancellor wrote:
>
>> >Oh, they didn't actuallly send it to the list :(
>
>> Actually, I have received email about fix before I send new patch. As
>> far as I understand, it was not sent to correct list, right?
>
>It wasn't sent to any list.

I see. Let me clone your regulator repository, and send you a new patch.
