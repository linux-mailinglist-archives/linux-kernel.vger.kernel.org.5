Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C1E801DDA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 17:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjLBQr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 11:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBQrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 11:47:24 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F42115;
        Sat,  2 Dec 2023 08:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701535650; x=1733071650;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X5Q+GEs34wD/FSBP7Ntfw9NIYhyYepr8hcgfW3JlRLY=;
  b=h8UtkVOlI5jcY0qfqIpCtVSQdL6Tz2jFtgef0qiJ28HiJ0V6RMnoab8E
   J97/bwn5zNnnQxJ8ZmoosAiRr6vaZ7eBy7HodNIYDuXbzAPHR8Rys4g4D
   LSO0Hl6z5WzaSrZUU8BzELxIVbXKArrSWo2Ox1rcXgYMptZLI0TGi6p5H
   5MhzE83rAsSVA++lK3GavsYlfvYtQIjua7lAqvrOR0N7rfBf3d8xN9Qab
   9yA9IEvMFAFQLy4B5plpdnFtec5P99a9tMDr1Y+OPP2/0HRnw8s8GTHQm
   CG5OfxHtH0UIO3f7XtX5vP7OuQivUkRk6nmGrueDIdnKt086pa09bH4ei
   Q==;
X-CSE-ConnectionGUID: LKS20XGORdes9m8nX0UpkQ==
X-CSE-MsgGUID: RTkApBZKQSKLKRGxznJgCw==
X-IronPort-AV: E=Sophos;i="6.04,246,1695657600"; 
   d="scan'208";a="3714797"
Received: from mail-dm6nam04lp2040.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.40])
  by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2023 00:47:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxAYUd5Cmy69QHGKtUJcnPIWJjeT74I7Wg1ZgHsfyzLTvtj7iD8+edn2qYXHoz4/7LWQBof2eKbArsCO5gHcez15IDsD5YIvAQJia3hxZnPHxrl/sd7hlQIW+jzStFuJRMbksfo+WUa1F6XbjPstnwvL4pnG9Bz9WLnWufYYaHFI3lHY/mUlzdmv+0wd3xAivwcQ5soxLo8GGFN+1I47zU3lGDehjSVbqPrGBayN4ExWvYFb2NGVkxZF0H6+YNdv4L5b8xS4Sfdb5rNvnbHK1kqcSRD/V1W2aCq5ioGGUWkui97ZpNn3qRriBj1zqs2isPXqjpxfiEsPQiG9GYbqRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+LYIc29fSljhJf8lkYwfglV7sTmM/fMJ7bu21RgKSM=;
 b=RtPBOU7P1PXyJzDwQKs/H9WvuMd7F9MDBg6cRuQfk0KNOgFCSD3A0EyV+RsEy82KycC7HU6/xmJ/4XcMxWra1/Rj09gr1++ycrU3aQ0CrE7B2+/e6WsjavRPoDvEQnLDTBXWVFgJKDj6YVNKJWP1YyQSWPvxgSlB1a9mB+nlWG0SGfvMquDgmPXedhbUSR9FpDmNnw61kAfIFF9DeswGP+/vSUIZLsiWLxq93cR5IHWBHaAYLwS8nvetXEyyEV3/5zFENzy7enTVilvap/4kYtKykVddgKkG8S8DB9fJrHFBlUhG0/hM4Odz+CqzwXH+VXGP5L0a8QyWgvQGS14pYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+LYIc29fSljhJf8lkYwfglV7sTmM/fMJ7bu21RgKSM=;
 b=pvCh2u8atwjNdFkSVcene+ThwwoLWYrwGseA03cffvFCZvPYyb6tGZz+mXJis2xgZfzIPrlnrUDfvTDbm6xLhkx7R2+cM5d+QvmCIgO6qk5hgVFXCTViWJ58D/ZUjTutgI4Adr81i0Z6D7nFTG0f+HuvT8Z68AQ8J0SNn0GCO38=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB6329.namprd04.prod.outlook.com (2603:10b6:5:1e6::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.30; Sat, 2 Dec 2023 16:47:23 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4%6]) with mapi id 15.20.7046.028; Sat, 2 Dec 2023
 16:47:23 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        "CLoehle@hyperstone.com" <CLoehle@hyperstone.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "hare@suse.de" <hare@suse.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
        "asuk4.q@gmail.com" <asuk4.q@gmail.com>,
        "yibin.ding@unisoc.com" <yibin.ding@unisoc.com>,
        "victor.shih@genesyslogic.com.tw" <victor.shih@genesyslogic.com.tw>,
        "marex@denx.de" <marex@denx.de>,
        "rafael.beims@toradex.com" <rafael.beims@toradex.com>,
        "robimarko@gmail.com" <robimarko@gmail.com>,
        "ricardo@foundries.io" <ricardo@foundries.io>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv2] mmc: rpmb: add quirk MMC_QUIRK_BROKEN_RPMB_RETUNE
Thread-Topic: [PATCHv2] mmc: rpmb: add quirk MMC_QUIRK_BROKEN_RPMB_RETUNE
Thread-Index: AQHaIt3uugCp9rO7UEO94df443a6MrCSq88AgAAvjgCAAGE4AIAAL3CAgAAE5ICAAJy6AIAARKeAgABFQgCAABTwAIABhBXQ
Date:   Sat, 2 Dec 2023 16:47:23 +0000
Message-ID: <DM6PR04MB6575FF9532A9FC0EE91B5B37FC80A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231129160533.2827458-1-jorge@foundries.io>
 <CAPDyKFpg+7W1ODGHw5oXy_wzWA1Qqzg9w_12rhQ8qW4o--6dWg@mail.gmail.com>
 <ZWiNDgUFF8ug7gZf@trax> <fbc82848-d402-4075-8176-de9ed0345d78@intel.com>
 <ZWkGZ7av1S4Clwdv@trax> <ZWkKgU+J9atnJdqT@trax> <ZWmN+k+wUWcXT5ID@trax>
 <fecd033b-b2ea-4906-a320-22a5c2ede46c@intel.com> <ZWoBqs/5m6tCuBGo@trax>
 <ZWoTOm+8Y75TLz6q@trax>
In-Reply-To: <ZWoTOm+8Y75TLz6q@trax>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM6PR04MB6329:EE_
x-ms-office365-filtering-correlation-id: f4b05e18-0808-4e28-9739-08dbf3565ba8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fD1Yk38DYH5Kq5rHs9yuNRQn2YifHfCyE59ho7zZv3kXdfk8uTG+K6KgF4GB4TsibeeVvSCKIy4ZhbyIYyV+9jXRLYUDpoMD80A59olbv7QE8ZhSrs+TYjbjF24PIYqfPUs84/eJkKydaNcxM+Nq7deOmqhoKX3laRIUXqxN8paEq6DkywFqeKQFllUVBxYGlc5CwBcge46MbohsD5Ni9SSkZLRg8DfFuw1Gp+n5ot4TfoeEZyPqAwOOx2XwMJ8D7JHnAqQ2DkOOBtPqfk1ZkmuP6QP9DR6QRdMy7MNI1TYPDSGiyWd84vqG67II/TfTRveeewy7w7Wpz23ttT/f4QSkk2NfeGPLI10+i9K9wc7yciKw+yFicrBnOTIDRNmyhUA9r6TPAAYrMGMxRAfB9/KrC/4KBOkJsmUhNQkx/sgqkdMzvAlV5sR+NyBGI1Du92rbxACfG5as4RsBRj39R8abHap3MNT9X4Waaq/s05NW4nQiZEqC8RzJhKwjWRIIdepe+cGUPDqkQx8c/aGVMJ5xUCB/qnwzLg9py+A+RpKBHBW6dtzdm1qc+H+yWyWfQQo5IkoCI46Lf72JdN1qWxk1XJd8stJVNdD7o/jjitbq3Ysd+F4DkHHBUzQ0KYYq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(5660300002)(52536014)(7416002)(86362001)(66899024)(4326008)(8676002)(8936002)(2906002)(38070700009)(41300700001)(33656002)(9686003)(6506007)(82960400001)(83380400001)(478600001)(26005)(7696005)(71200400001)(38100700002)(55016003)(122000001)(316002)(54906003)(64756008)(6916009)(66446008)(66476007)(66556008)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?geXvN66gl7xRCACnlSehTGafKnxDxXNBn8V1HqXMOfFxx49bCO0FoH3tXU/Q?=
 =?us-ascii?Q?1T5oEih4eOlpnCRbbra5Rgr0E3FPwrdKpimV705SpTki/mmCWZSNAeFPUs8S?=
 =?us-ascii?Q?rAFOIu7iVGxOUQ1fY1dJ4MVIZda8Mpv/Hd10f0ZcmusbrgQJSmcfgaDQX736?=
 =?us-ascii?Q?3VlPbzFUgKrvxJVJlOJRSbKN08G4PJhZwrRF/5Y3ObezC2QEFjyQ0BqJ5I/I?=
 =?us-ascii?Q?wPufPhhjSAJVCGpz37QoaLxBqxHp/9OztAOgkDnHm3KCiKrpLInMWNm0+0Z8?=
 =?us-ascii?Q?ie+CZjGM1Xtvh7iY5nucrtMFXiuFG6R27yk+wrXVbVvAzP8l8cs55DJkIv6f?=
 =?us-ascii?Q?T6t8W37Rm5IhNDFstvR1+nohwfCyF+/987QShfmmYFSGw4fg2FgeYY2S+bUo?=
 =?us-ascii?Q?iMzCBxEwZEqurhIcP9T11AxPKx0eWc1lCCYZsr4PFuryW8AKEsBmNQZG635B?=
 =?us-ascii?Q?F5RbUqV68/X5QtXAQH8INikscUiu5Z5PhsB4R09J8ouTe6K9+94hpYHnDAtA?=
 =?us-ascii?Q?+r4cjbL+DRE5mq5ushSmkGJXg/uWEGj0Dgx75lVHAp9oO/j9oj9/3IPMgE+o?=
 =?us-ascii?Q?WpXmYrpTkJO4kIMUQfR1OPZY75/JXOR+QRDl1gVypIoq3vwZ+0ENr1YIaA5r?=
 =?us-ascii?Q?RNtnO/UZgBH/WDNk1aR0Nf56LMAq+wLNxA1kCdHZ59UlaQC/+jU/TCcaBQPI?=
 =?us-ascii?Q?fyTIsimEVDtLPxocyYPYm1GpIEQbifcvI+fMx95U27UffEsr92F4fw4wbOjw?=
 =?us-ascii?Q?OMfBDBrQi4AOoYNBr78/HLiC19wH/5ZNt3ConA2JmEGHghznVfW4cSx/WoHN?=
 =?us-ascii?Q?AYJgj6dkR+uVRdJAqNce/IavGScbzHncp9SnVayUpyZBt8vxcSur5/oIbp20?=
 =?us-ascii?Q?fEN7cTuWo+RL3kV3jyggKMnz3vBM9ncz8Njo9d+FN/OkmESjvuq+5l2AY6Yc?=
 =?us-ascii?Q?nFCvBKz4pcmIfZeWcS3rpC+P2Gaum7GahnivIq8Shs6sNB0LI1eHGRVKoEGu?=
 =?us-ascii?Q?1H3WFFG7zH94tPB017WwzJ14q+XaBss0TUuxsvD+9jA2YxHsminGlFBbNNmr?=
 =?us-ascii?Q?JjcWFidekwguFXR48OwuLe/7JAQFpzdqkLKt63zFLtdMykeqVdA1k3z4KJPy?=
 =?us-ascii?Q?VXdKQHxwcuXavGb7/EAjXurUobTrQHg03TIrMGMut10Ooq9/MxhWsonBIU3s?=
 =?us-ascii?Q?WQbw6aV1q2ynEFtv2TkjYGqbicSkcpm3dTWKFvH61SXJKpcMJXsEbzgbtgRV?=
 =?us-ascii?Q?fcv3efQPz52+WVpPIc7SgTeUPFe4I9tgLBGMWHAmwVf3fUnkOwzVVcobAh2Q?=
 =?us-ascii?Q?DQJ0LYHcIBDj3c/Q7A7m6N7bmSS5NU2IzEJJZYyAqRunOJ1rV02+xliydc2H?=
 =?us-ascii?Q?OLSGlp8TLDTr8RTCYMvXMoDW/vlmYxUvH8sLj8qQZ6PfLum+eQt6TDBHwwcj?=
 =?us-ascii?Q?sggf74RRH3zHPJha1Q06Jfqs4xn48Hs3K1McgXq1GwR4JMLKbX1FeyhkZrqQ?=
 =?us-ascii?Q?n6jyo7hShyBVMO9aUgfJXNyvBLllDPba8c1pd1jC9dF5cpJHlfgZDmRTcz1x?=
 =?us-ascii?Q?7/zuUzrb0jnpvI37dYVUPgT4pbn0LPuxiH+KpWaA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?qS2KL0y0wPWzt0cR1H/D1jJ45AXmElNoNbNmRZGRwKr3fU4zLX5B+fp0OWy9?=
 =?us-ascii?Q?VuUhJ3AwzLGqkYJEV6KALzzklQ1OUJCmmH2dRQSrSKp7zNDe6kQlnTWbJtwm?=
 =?us-ascii?Q?c9etz960ZAHtxhXseZCaXI3xI3BiVXuSQZorw+Q1mVrh1RLjv/E+lXTa1B+d?=
 =?us-ascii?Q?3aTcq1FLxkW/hfjUlj2EHC0BEvtFo3vcniDe12IWCC8AzdUxX7OMBLpCsV4L?=
 =?us-ascii?Q?mgjngWZFs6gQhfVeBczFdm1y6HEYuoT+eREzVHoKVvMG7YVKxpBh/uBHX83g?=
 =?us-ascii?Q?js17vS6XYSy4g3+85aGh5uWORv3zlyoB1CMJNLqU0WhfsrbgpJdILQ4ZXdo7?=
 =?us-ascii?Q?V9ALz8WQfzbzL3zjLsFPF6OwlBhNo7F/HsIl0fOGFhtjL4Iu8CBDirxD5lHZ?=
 =?us-ascii?Q?5W+JyTQlO0R2iTcZ565uce2DArj+95SpAruy0ACn3MiF9rIEQaPcKRfv8yF8?=
 =?us-ascii?Q?NdlvDiQ1t+wagU/t9dCHZkqtavcN/NHVJrPUkvfo58FrYRD3UHWxCjJKiwfT?=
 =?us-ascii?Q?cUG6ekaMfyU2hhi6DdXEWUoQO0jXmW0+2QQxbX5x7Ea794IyABRFzrnoP+Q5?=
 =?us-ascii?Q?xs3wcIPEBahV3KZ/ZhwJ7RfdpawnfjZtOR2qlxz1xb+MGKsWdEdTOyh3KD5V?=
 =?us-ascii?Q?DUxjppFUEH2Xa4Zwq+nU8LaKQ+zLkzefQTIPU8sE9Vf2xJLNzBPqvind3O+K?=
 =?us-ascii?Q?AX5yzud0cPnkSrrVmDHmrx40dRmqz6bZ4JYEf3c+vHZyKdP4aFfdOhtACt+h?=
 =?us-ascii?Q?d9HBGILC1nGTMfgyVyurgXEqru7hpoeG+cnL2KoBBRjBLxXPiGnlfciVYexu?=
 =?us-ascii?Q?0Zvo8YMzwnAVVop1ci8jLEuVFeuru1/Q7Z3WbetL1EALx0ZVbSApuJViAE58?=
 =?us-ascii?Q?6zJbwZ5uHcb1mWaWk7rnL9iDQP5Crno+7il4ADqkHAOOSQQ6ZeJ2EDPBMeCz?=
 =?us-ascii?Q?vDJpiiRtjbE48iLwCVaH5/SGUvSqztxufUp0i07GjwAKZeGbqH8mnXkWhJOm?=
 =?us-ascii?Q?84tBEuKFVSCuDDd9lPATJ7m64gKQg3/mO3nDipdllBQlihShO3Ai9T48k3yp?=
 =?us-ascii?Q?QeU77v+JXK8ZxAJ4H1VWTBT5zK2QtFKvNlkVxwC9wPx4DMYpmpWVPGWHKZEJ?=
 =?us-ascii?Q?mOQgk0X0diH/gOgp3erWRk4LbkZkvT0x57K3ZotMwx1z+9GF3HU8GVA=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b05e18-0808-4e28-9739-08dbf3565ba8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2023 16:47:23.3540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +rTmKVPWRkM6Ie9hl6f+pqF/lJNHGGERWOyNKpv+JnxIKafZw7WC3/5YR8i32/6MFG8lTJ/XQWrf73EFeUPNjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6329
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Sorry for joining so late - This thread was routed to my junk mail somehow.
We were observing this issue recently with one of our clients using a Broad=
com platform.
Similarly like in this case, the tuning process didn't use cmd21, so sendin=
g only cmd6 is perfectly ok.
We couldn't find any issue with the device at the time.
During our investigation, it turned out that the client had a kernel hack o=
f its own,
and once it was removed the issue wasn't reproducing anymore.

> > > >>> hi Adrian
> > > >>>
> > > >>> Sure, this is the output of the trace:
> > > >>>
> > > >>> [  422.018756] mmc0: sdhci: IRQ status 0x00000020 [  422.018789]
> > > >>> mmc0: sdhci: IRQ status 0x00000020 [  422.018817] mmc0: sdhci:
> > > >>> IRQ status 0x00000020 [  422.018848] mmc0: sdhci: IRQ status
> > > >>> 0x00000020 [  422.018875] mmc0: sdhci: IRQ status 0x00000020 [
> > > >>> 422.018902] mmc0: sdhci: IRQ status 0x00000020 [  422.018932]
> > > >>> mmc0: sdhci: IRQ status 0x00000020 [  422.020013] mmc0: sdhci:
> > > >>> IRQ status 0x00000001 [  422.020027] mmc0: sdhci: IRQ status
> > > >>> 0x00000002 [  422.020034] mmc0: req done (CMD6): 0: 00000800
> > > >>> 00000000 00000000 00000000 [  422.020054] mmc0: starting CMD13
> > > >>> arg 00010000 flags 00000195 [  422.020068] mmc0: sdhci: IRQ
> > > >>> status 0x00000001 [  422.020076] mmc0: req done (CMD13): 0:
> > > >>> 00000900 00000000 00000000 00000000 [  422.020092] <mmc0:
> > > >>> starting CMD23 arg 00000001 flags 00000015> [  422.020101] mmc0:
> > > >>> starting CMD25 arg 00000000 flags 00000035
> > > >>> [  422.020108] mmc0:     blksz 512 blocks 1 flags 00000100 tsac 4=
00 ms
> nsac 0
> > > >>> [  422.020124] mmc0: sdhci: IRQ status 0x00000001 [  422.021671]
> > > >>> mmc0: sdhci: IRQ status 0x00000002 [  422.021691] mmc0: req done
> > > >>> <CMD23>: 0: 00000000 00000000 00000000 00000000 [  422.021700]
> > > >>> mmc0: req done (CMD25): 0: 00000900 00000000 00000000
> 00000000
> > > >>> [  422.021708] mmc0:     512 bytes transferred: 0
> > > >>> [  422.021728] mmc0: starting CMD13 arg 00010000 flags 00000195
> > > >>> [  422.021743] mmc0: sdhci: IRQ status 0x00000001 [  422.021752]
> > > >>> mmc0: req done (CMD13): 0: 00000900 00000000 00000000
> 00000000 [
> > > >>> 422.021771] <mmc0: starting CMD23 arg 00000001 flags 00000015> [
> > > >>> 422.021779] mmc0: starting CMD18 arg 00000000 flags 00000035
> > > >>> [  422.021785] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 1=
00 ms
> nsac 0
> > > >>> [  422.021804] mmc0: sdhci: IRQ status 0x00000001 [  422.022566]
> > > >>> mmc0: sdhci: IRQ status 0x00208000
> > > >>> <---------------------------------- this doesnt seem right [
Why not?
Its cmd25-cmd25-cmd18 which implies rpmb write?

> > > >>> 422.022629] mmc0: req done <CMD23>: 0: 00000000 00000000
> 00000000 00000000 [  422.022639] mmc0: req done (CMD18): 0: 00000900
> 00000000 00000000 00000000
> > > >>> [  422.022647] mmc0:     0 bytes transferred: -84 < -------------=
------------
> -------- it should have transfered 4096 bytes
> > > >>> [  422.022669] sdhci-arasan ff160000.mmc: __mmc_blk_ioctl_cmd:
> > > >>> data error -84 [  422.029619] mmc0: starting CMD6 arg 03b30001
> > > >>> flags 0000049d [  422.029636] mmc0: sdhci: IRQ status 0x00000001
> > > >>> [  422.029652] mmc0: sdhci: IRQ status 0x00000002 [  422.029660]
> > > >>> mmc0: req done (CMD6): 0: 00000800 00000000 00000000 00000000
> [
> > > >>> 422.029680] mmc0: starting CMD13 arg 00010000 flags 00000195 [
> > > >>> 422.029693] mmc0: sdhci: IRQ status 0x00000001 [  422.029702]
> > > >>> mmc0: req done (CMD13): 0: 00000900 00000000 00000000
> 00000000 [
> > > >>> 422.196996] <mmc0: starting CMD23 arg 00000400 flags 00000015> [
> > > >>> 422.197051] mmc0: starting CMD25 arg 058160e0 flags 000000b5
> > > >>> [  422.197079] mmc0:     blksz 512 blocks 1024 flags 00000100 tsa=
c 400
> ms nsac 0
> > > >>> [  422.197110] mmc0:     CMD12 arg 00000000 flags 0000049d
> > > >>> [  422.199455] mmc0: sdhci: IRQ status 0x00000020 [  422.199526]
> > > >>> mmc0: sdhci: IRQ status 0x00000020 [  422.199585] mmc0: sdhci:
> > > >>> IRQ status 0x00000020 [  422.199641] mmc0: sdhci: IRQ status
> > > >>> 0x00000020 [  422.199695] mmc0: sdhci: IRQ status 0x00000020 [
> > > >>> 422.199753] mmc0: sdhci: IRQ status 0x00000020 [  422.199811]
> > > >>> mmc0: sdhci: IRQ status 0x00000020 [  422.199865] mmc0: sdhci:
> > > >>> IRQ status 0x00000020 [  422.199919] mmc0: sdhci: IRQ status
> > > >>> 0x00000020 [  422.199972] mmc0: sdhci: IRQ status 0x00000020 [
> > > >>> 422.200026] mmc0: sdhci: IRQ status 0x00000020
> > > >>>
> > > >>>
> > > >>> does this help?
> > > >
> > > > Just asking because it doesn't mean much to me other than the
> > > > obvious CRC problem.
> > > >
> > > > Being this issue so easy to trigger - and to fix - indicates a
> > > > problem on the card more than on the algorithm (otherwise faults
> > > > would be all over the place). But I am not an expert on this area.
> > > >
> > > > any additional suggestions welcome.
> > >
> > > My guess is that sometimes tuning produces a "bad" result. Perhaps
> > > the margins are very tight and the difference is only 1 tap.  When a
> > > "bad" result happens in non-RPMB, a CRC error results in re-tuning
> > > and retry, so no errors are seen.  When it happens in RPMB, that is
> > > not possible, so the error is obvious.  Not re-tuning before RPMB
> > > switch helps because the CRC-error->re-tuning to a "good" result has
> > > probably already happened.
> > >
> > > However,  based on that theory, it is not necessary the eMMC that is
> > > at fault.
> > >
> > > It may be worth considering a stronger eMMC driver strength setting.
> >
> > sure I can tune the value (just building now). however I am not sure
> > about the implications - is there any negative consequence of
> > increasing this value that I could monitor (if tests pass)?
>=20
> ZynqMP does not set the property "fixed-emmc-driver-type" and since the
> sdhci-of-arasan driver does not implement select_drive_strength() the
> drive_strength setting is zero.
>=20
> So AFAICS things are working accordingly - it is hard for me to say if th=
ings
> should have been coded any differently.
>=20
> > >
> > > sdhci supports err_stats in debugfs - that may show how many CRC
> > > errors there are when not accessing RPMB.
> >
> > ok
> >
> > >
> > > I don't object to skipping re-tuning before RPMB switch, but I am
> > > not sure about tying it to a specific eMMC.
> >
> > thanks. will follow up after further testing.
>=20
> should I just repost the patch now skiping the retune for all cards befor=
e
> switching to the RPMB partition? instead of using a quirk?
>=20
> On this particular card it has now run for a couple of days so I am confi=
dent
> that it addresses at the very least the symptom of the issue.
As aforesaid, we observed a similar issue on a different platform as well.
If it's not realistic to further pursue Adrian's theory, *And* this doesn't=
 reproduce on other cards,
we have no objection setting the quirk for Sandisk.
(if you're having trouble testing other cards ping me privately I can help =
you with that).

Thanks a lot for fixing this,
Avri

(btw - yes - our manufacturer id is 0x45 - it is set differently in the mmc=
 driver for historic reasons -=20
Thank you for adding this.)

>=20
>=20
> >
> > >
>=20

