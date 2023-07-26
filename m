Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C737E76336F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjGZKXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbjGZKXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:23:10 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAE9E7;
        Wed, 26 Jul 2023 03:23:09 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36QA7NkY013763;
        Wed, 26 Jul 2023 06:23:06 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3s0c15hp04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 06:23:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BB+ecg18HrgXp7dIffjUcvwMtYAFCR+nhLBeNAcwujSjYwrR7ZvUnlTrk5UQEQ4NJ0nTMGd+doxZB3FbyPS9eLikbho5IA530vG42Z0hjl5RfsT8MB6M4xyc197SZoqHPyg1InyPKqdwCCwGtSvJNHCVYlNlIpdZ4FKmFngMyLYk4WYuxrRkdxbOafT2vpNo+p+4RSF/LX3J9uTZXwGCCLDOqexZHoG0YeO84l5zFpX+ASUX76PUOuWE992q/gdVuM24KLmD8ukGWKEkEu0TytHZd0tpSxGCW4jwmGYrFlqoUdg/OpDoxqkIx6Heis2DBtL9PPqO4AwWFwdi0NlroQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8l+UQ+/w4yLbyPC/rb8DfFeGy2H00uJfJIzwDqn+gvE=;
 b=fQyYWobEvtqHepmomv6lpO7uk7YcpUzV6kXJKqW7I9jBy2He5fCEUySYFDQNjfBjLV2eOVVE1RxAE4aU05rNa2oU+LvThmCmjAi7Q37fAX1fTKrrSNEXpFYPj6WMe5Zbl1ZTDTuYxKgKdLOyHilYs+DKInn3uWH7kb0B9cQ8O1wZzpWx9bkMyBF7jVnRHmX8M1ZJZDadcz9Vhpk6PvQAkXWiwgPbH6bvsDWLie6cGuqj8yjy3JU/rUQs4wzitNAMQkJA6Rk9G3o1RiD4kEP163NuWHm0OKhP8wy4PHo9j5jQoCOGWeTD8jr7fu+RRIZV3IzClGahq7aRhuxqauy+Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8l+UQ+/w4yLbyPC/rb8DfFeGy2H00uJfJIzwDqn+gvE=;
 b=oqW9fMl2woVzz14tJcYA1Bd3lyVKNXNT44ezbB7EQkubyF2DzkupsNbY9fwnI4KXv73+tUUGowod/CD+lEJ3egK8waxmNTCr1DqqHNJICN5cs6RZ7+KGS19IE18WuS7RwgfhOAxxBgLYjwcMmMbaslpIwSgFFVJA3xU5SmUuthc=
Received: from BL1PR03MB5992.namprd03.prod.outlook.com (2603:10b6:208:30a::20)
 by CH2PR03MB5287.namprd03.prod.outlook.com (2603:10b6:610:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 10:23:03 +0000
Received: from BL1PR03MB5992.namprd03.prod.outlook.com
 ([fe80::bb05:7dd3:51e4:fdc5]) by BL1PR03MB5992.namprd03.prod.outlook.com
 ([fe80::bb05:7dd3:51e4:fdc5%5]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 10:23:03 +0000
From:   "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] iio: imu: adis16475.c: Add delta angle and delta
 velocity channels
Thread-Topic: [PATCH v2 3/3] iio: imu: adis16475.c: Add delta angle and delta
 velocity channels
Thread-Index: AQHZuj0NjLsYHngaGEm/6L/IYLaHeK/HUCkAgASKudA=
Date:   Wed, 26 Jul 2023 10:23:02 +0000
Message-ID: <BL1PR03MB59925DFDE7AE86BF3B78AD8D8000A@BL1PR03MB5992.namprd03.prod.outlook.com>
References: <20230719123152.309624-1-ramona.bolboaca@analog.com>
        <20230719123152.309624-4-ramona.bolboaca@analog.com>
 <20230723133636.4b8fc5f1@jic23-huawei>
In-Reply-To: <20230723133636.4b8fc5f1@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccmJvbGJvYWNc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy02NDNmZDEzMC0yYjllLTExZWUtYjcyNi00MTU2?=
 =?us-ascii?Q?NDUwMDAwMzBcYW1lLXRlc3RcNjQzZmQxMzEtMmI5ZS0xMWVlLWI3MjYtNDE1?=
 =?us-ascii?Q?NjQ1MDAwMDMwYm9keS50eHQiIHN6PSIzMzg2IiB0PSIxMzMzNDg0MDU3OTQ3?=
 =?us-ascii?Q?NTQyNjQiIGg9InpjbmY2VGdPZWxYbllqM3FDNFhPc3pucG1Hdz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?RFl6c0ltcTcvWkFRZUMzWG9RNU92bkI0TGRlaERrNitjREFBQUFBQUFBQUFB?=
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
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR03MB5992:EE_|CH2PR03MB5287:EE_
x-ms-office365-filtering-correlation-id: ea151498-3961-41d6-0cd9-08db8dc24b54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0qGFv6eHZIItXr/mN2s9zCJEMrev3jNPeib/CWavukrYH3qj97yzKLyz7xqsxwchCKz19FW6mdlPLxm/rAZQwb9AhgpSdSNQ9ZlILgNPePmua90ifG73vmMfccs7cHQxpLTNmfx4bFVPYbkcui+cjjXb069JwU6t3byw7+MqCbd5pw8JIh0VSg2UEY4prikSjcSDZpg07MhKEsnc+XvUc+rFe/nUX4IijvsCyfpeZ8k1LytT689NT+KJpWjeaOkLJm1FU0ZQMDQTK+cGHZBZWsXbOYO60DkSyntAD67NUXSQtNF+v6kkNLKsJ9xJ2LeL/fArN54Cb7PVTeN25T6ISv47iDPXgQ/PARSr66ymbwM9U85+LUQ/Ks2dD9eKFERi8Ay47vrEPysY1gpUI6demK9WiKiPV7wyJgav5HOFPTzwjNLVTQgQ9x7eQzxq5rIWo9PAU9ggkX16xZnY/qDI6JNnOUoMBRtT9yYoXuH62h1YJm4rm3YCtScDxbz50vJiS5H7ZvoiISQ/M/OC6rxskgavQtvzwAS674/yfQrNC2gakxomregbAOgLk2RdBFloY+c3CHEaC+9PIFyiNHcuVu9tUfiRik5npwdBJOHL4UU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB5992.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199021)(55016003)(54906003)(122000001)(38100700002)(478600001)(7696005)(9686003)(966005)(71200400001)(41300700001)(5660300002)(52536014)(316002)(8936002)(8676002)(66946007)(66556008)(66476007)(66446008)(64756008)(6916009)(4326008)(76116006)(186003)(83380400001)(6506007)(26005)(86362001)(33656002)(38070700005)(2906002)(66899021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2/YV6dPuGQ27K9nqPJAX9mNjao93kMJTReG3fTDHd9VWW/NIsk2WEyQOu3ny?=
 =?us-ascii?Q?dG2p8pGe6/7fGLpeXmnD5IgZ+80Gr5wJE0p+LxrpP6xW72/0ilceF9mquJo6?=
 =?us-ascii?Q?bXv5QUSwLm6BdxGH5JrdwNsKDobBB28KfkcpLCy++xwO09Gk6xrNuf0ZSRxn?=
 =?us-ascii?Q?hC4WCYi6NnS1pG+jblfOtjujSEhfzpwyK8oXorSVVmy8KggXwS/W6Ga+tHu4?=
 =?us-ascii?Q?5g3lQfM9fBtJ5hgl/LoBUJvp3rcezvOR1jKbtL6SsKqeQYhVG3He2+SZkK42?=
 =?us-ascii?Q?lbwQmtUVnwSEc6DLREVwRQ07ZFk6NJMT7JaCWLm1/YbU+Qf5GMzUX3W1c0Y5?=
 =?us-ascii?Q?LaeJESRHkQZBXvg6KNXo2DOaax/o9NvZWPTnlBLhFn88C81510vLOioYp7lb?=
 =?us-ascii?Q?LY3yy+Qxto5zYFjPVmgzx7yq+16soUq3iPTdhut5U9EA0LS36Mf8KBQcEDCy?=
 =?us-ascii?Q?qfH/tmsysw/guDnM04tQkzQh0BWd4uJ4fnyoKOlsB3eei47kodRux7uX28aQ?=
 =?us-ascii?Q?e1ytnKcvRG0U6F3GbAPEc7pOGrBMz7a6Xoe9SNsgXY651uGVu+H5qK4w7WNg?=
 =?us-ascii?Q?4dbwyUcDM/A6x6C3rj+KHHpZhTA2A3C9TAXxSN+9mvmW9hZXFezFPpbA//Pe?=
 =?us-ascii?Q?4Spa/PbzGNzSZvOCMXjUWbUvG47NQk32JlQwLrqCiOjErYbSSw/dbGf520C/?=
 =?us-ascii?Q?S/IDC/vRdDlB2c6UhEaIQErO1QzgXw1sEHboSGa3SG46jvKUGHsVBkVnqRd2?=
 =?us-ascii?Q?s5Bi9xkRnqYi8fkh09s/vSQus+4iz5JwjVeKQC0Ty7PaKQQ6mEaSL+80F8n3?=
 =?us-ascii?Q?bJYHqT91DvT8O2CCQNTQSU/NGZX3xjnczQ3H+aK5PlNq1XugJT3hhFTBT9aa?=
 =?us-ascii?Q?pL6yMMp1FLn6t0plcxzndH1KDSU6l4kXGpYMstLSrwPdCw0l+thMZGlglzCz?=
 =?us-ascii?Q?m8LivmYbHamTv7okxvc8WlYwFiARLccnUuoBHLTQrQspx9k6KP3VtkPJ36CI?=
 =?us-ascii?Q?tYLJtpZsdTs5KBPhZ7ORyLFpG0MIKBT2XehESnh29khwrRWuSCBGThz/ikcb?=
 =?us-ascii?Q?ePAxvRnPaI9OwCNtd4nCJxCMFvIURQK9lVkXLRpMyJE7TpT11rnRC6xpgA0i?=
 =?us-ascii?Q?ih0M6PRFf5OJtcWTUzdMnHAStO0UGiV17QvRqLHY1zuxCGI+eZM6KxuJkexL?=
 =?us-ascii?Q?JBNsaRTxQ0WoU/nRrnYmzDfx57oshAvgdnR1E6sBmvJ81ltnf5jAEozo/dnO?=
 =?us-ascii?Q?suRNi15SPR7N/r3UaA7EZ04cFr2EJHkkEGfwx/apHrqfYD/1n7I69oB+Q7DV?=
 =?us-ascii?Q?Fbvd/LwhacPV+zKRasBsO/gD5BzP7LBjj9uD1WIpM+7UwNHU2fnAd12NqcYb?=
 =?us-ascii?Q?qwAi+4J0bjK7dZJCD9G8o/yIM5tSAmM86Luz4+tfL4sv1ubMb2O2mmWl+yxh?=
 =?us-ascii?Q?FxVbaPXk1FxXnWAmmrBtQC8rk9Q8gubfCs+4qqFiNuFgIx4xIamrfowXzs3C?=
 =?us-ascii?Q?/Ftcfo93oqtjFiOTmQ3xSCEZb6crYh3F2YMoTatmoCgosthrz9beAk3y9RKR?=
 =?us-ascii?Q?Mx/javOBU8PEfhf6vsL+hO5vOlAmMkdcV1Zi9Ysa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB5992.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea151498-3961-41d6-0cd9-08db8dc24b54
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 10:23:02.9853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EyV5U/s59cyJtzisiwQgRpSyIwmprUgWoSIGfcR24ms2w5Gr5bT33nVgfLLOsuMgzVp0v2CxigxuIA3f/NXnGXSkolVmbmPVatGJd+Pggo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5287
X-Proofpoint-ORIG-GUID: P5z8Eh0Sxn9XmAy_zRaqm3VzK0mi5ELh
X-Proofpoint-GUID: P5z8Eh0Sxn9XmAy_zRaqm3VzK0mi5ELh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_04,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260092
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, 19 Jul 2023 15:31:52 +0300
> Ramona Bolboaca <ramona.bolboaca@analog.com> wrote:
>=20
> > Add support for delta angle and delta velocity raw and buffer
> > readings to adis16475 driver.
> >
> > Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
> As noted in my reply to Nuno's review, the question of channel type
> is still unresolved.
>=20

Hi Jonathan,

I think Nuno already offered the definition from the data-sheet, but let me
mention it here again for context:

Delta angle:
In addition to the angular rate of rotation (gyroscope) measurements around
each axis (x, y, and z), the ADIS16505 also provides delta angle measuremen=
ts
that represent a calculation of angular displacement between each sample up=
date.

Delta velocity:
In addition to the linear acceleration measurements along each axis (x, y, =
and
z), the ADIS16505 also provides delta velocity measurements that represent =
a
calculation of linear velocity change between each sample update.

Seeing how we cannot find something more suitable, do you think it would ma=
ke
sense to add these new channels to IIO: something like IIO_DELTA_VELOCITY a=
nd
IIO_DELTA_ANGLE and specify in ABI docs that these measurements are relativ=
e
to the previous sample? Or do you have something else in mind?

Thank you,
Ramona Bolboaca

> https://urldefense.com/v3/__https://lore.kernel.org/all/20230720193457.27
> 2f02a9@jic23-
> huawei/__;!!A3Ni8CS0y2Y!52Dhq_Yj9srV_lE8JgPysp2b3Lbg9U2w94VIGTMa8
> 3hepJgv-NCnFWomV83Ud5C3TGp3tMMI0IDVRYZV5N8$
>=20
> Thanks,
>=20
> Jonathan
