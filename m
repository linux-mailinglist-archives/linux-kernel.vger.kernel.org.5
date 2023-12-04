Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61C1803281
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343880AbjLDMXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjLDMXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:23:40 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A22C106;
        Mon,  4 Dec 2023 04:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701692626; x=1733228626;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Woo1xumnxO+7YpjDOnRnFAEwTFTTRvB6L2xV9NI9wYw=;
  b=SlmwcAKM4eqrShQ1i1doiv8eq7SCc29k0Put8rmThgKYwE++l5WK2+Bb
   V0ZR8zcHib1f94ICEKNHL3QDRDvsK6NU6fsyZDilyc3MtmZdeUYULUNyZ
   eGxPVLFQdlczrZyLJ8P/W/AfFPymGgBwpxt9aAa0u9DTjNRg49XPCQdWU
   VHV2z0Q2s+dPItcXcwYh+XGiOuZ8sS5rES+Rt7BNPC8aQ4NXIXXBWPtuK
   cxvl9osvfajvMGbLH3oXu1vit2i9iE0nRCbsKrl8Tu+GwWhkE0ClIqRuy
   37a7g/+5r8Nx7w/fpQedmoyx658Gk8Zj0rhTsYt1zPH0Fla7piDBtoMF8
   g==;
X-CSE-ConnectionGUID: Cd8uu0jfRIerWGaTL8MhNA==
X-CSE-MsgGUID: txfIE0E4S4ivtVXMzOJ+ZQ==
X-IronPort-AV: E=Sophos;i="6.04,249,1695657600"; 
   d="scan'208";a="4082535"
Received: from mail-dm3nam02lp2041.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2023 20:23:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+j4ykgfbtMBiPeUUg86pyJAFMQn/srD30+63sqKpFt7rHszX7PPCSXmI4WKSMySLCbguuG+BjVm/C5ZsDRHxOmEYgRv1xeLpCalL27uaQSKKbYzz/DqFTCRGd0XJxpXwFVCXb76p9i7I/uylZ8THb7jJ9ZJSMwl9OM34us+Tzn6YCRHPCQbnsK+Kc8GsAeShRfHTceKk4/eqGkqIZah4kdGurORfCVnxJjpW0Aaz2NwRAXztVLtF7xNBNn5T2DalL3YncS+KZYYW2n54EW4LkTzirJTGYHY42eUdLtFRtPPMcXoId+3JIyJ8zNssrdy/t6s8zQx7hV8kz7xIBAJew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZq/f0mFhGhfiydDKJb0E57m5cgOE4kMG5bkyjLG7fY=;
 b=g1ytoW5QOTFwCTU58b9Hn9uC/K1n4v3RfLAeeVM7J5eQvOUU2zk/k1KkzUyWm8/4OfzBenG05Kuutu4YOWJ/o/fADij3pauJqLywvanGC95ZxiwgRfPmBGodeBAUjwv2XRC7XMtXpek/KZ4x82EzlLF6wFLCEEJoOsK/AC2V2o27FjUwsEb0G2J1OlNh0Mzyd6geQxi+xHC/ZAHmTZg5W6yu2qy5WvJQoOUGh9Jyp27K4voukQni/tqZtM74CJerYYZSeSnIsSu9RWQjb+Xdv2Kx0XRNulyh5Xm21VSlLZnw4s5fOch+D6CkthFwGP2qLcfyy0BCOWqIqytMRFWZ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZq/f0mFhGhfiydDKJb0E57m5cgOE4kMG5bkyjLG7fY=;
 b=HJ0YBtDBLG1Gj1R+E7+6PJSxx+Fztoukv7VVb5JUod4ORpnXBhK4qrySrGibgA9BF93jkw48kW+Go8WjrG7UcZCGRdKdCw9LxO0F5awul9XSBP6Fw6l/8GCeU3PGD02cLNCF0IgLrYIziSJaM9MHFd5jMLUSUsKj6X7k1xNivBE=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MN2PR04MB7102.namprd04.prod.outlook.com (2603:10b6:208:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 12:23:42 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4%6]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 12:23:42 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bean Huo <beanhuo@iokpp.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "thomas@t-8ch.de" <thomas@t-8ch.de>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mikebi@micron.com" <mikebi@micron.com>,
        "lporzio@micron.com" <lporzio@micron.com>
Subject: RE: [PATCH v3 2/3] scsi: ufs: core: Add UFS RTC support
Thread-Topic: [PATCH v3 2/3] scsi: ufs: core: Add UFS RTC support
Thread-Index: AQHaJTkKGJCMMiwoCEWzpUFDJD5+pLCZCRfggAAFs7A=
Date:   Mon, 4 Dec 2023 12:23:42 +0000
Message-ID: <DM6PR04MB657587A7051D5B70F8B39D72FC86A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231202160227.766529-1-beanhuo@iokpp.de>
 <20231202160227.766529-3-beanhuo@iokpp.de>
 <DM6PR04MB657594BADE76428806210D3AFC86A@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB657594BADE76428806210D3AFC86A@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|MN2PR04MB7102:EE_
x-ms-office365-filtering-correlation-id: 3bf487f5-1650-4148-54a8-08dbf4c3daa4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hU9dFtarQCLkUbZpaWrVZNs0/9SILZwPLr+gEuv2pa2mxceeOUYGa0pbbmWfOAWrjLH4hsDKEGDTOGNLLO6mYQ6GosnY/WwWV8dPakXlgmFEDdXqeo5FWOYTmKDMq8sAm5IK+2M4h7NmruSwZDaIMh4o0edKBCrzMy2iJ5ihYnWqgMoD8dMVW+E+Sero5f3PCedYBZdChfncLdnkAQlHgMMd2K6lREf+lfB1XouswrnPILH2nBVnRdna63QuPVePWHCcDrNexCg4HkMN6bkdKo0y26LvX16AbdfoPg1z5tm9acGVLr42voJ02n1MlCszfS11oTM9a3J8sfSX4SFh6nutufzLxNTBp6piCWD02KWbsWyoQbb8kECodIojmDcAgIk4m7foh9CA5hDCVPjN+xEgiGLVd25k0xt47WKer5onJx7eqYSJGA7tAzo7SZ5j8lZfqCjGzqdEvozxcfm6/2E9tDuMACvPGWCJL+IqMS1ml7U+moBl4z6Qljv74vxCfv+4DVNXGpTOHZoaclNRYlw7K6k6VqyXCfjV/ix0AvA/Xtgb4ESr/73pzCXHcFPMTSyenOjRWtX8MYZkIVpAU4K0DvZLfxMXcAQTr6+SyLC5GIoRh9u0HGeUXikSeZhnKhFgIkFFYja15nKy0J3FUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(7416002)(9686003)(921008)(6506007)(26005)(2940100002)(33656002)(38070700009)(7696005)(82960400001)(41300700001)(38100700002)(86362001)(83380400001)(122000001)(71200400001)(478600001)(2906002)(55016003)(316002)(66946007)(76116006)(110136005)(54906003)(66476007)(66556008)(64756008)(66446008)(8676002)(52536014)(4326008)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cWwKGzzazTooFUVmetsdYs6vYFNnpKoTds4Gcsiq18NJtWG6Uxf+HFlYBdCg?=
 =?us-ascii?Q?VdNs33egpG3J2mfGFec5WbHCUE+yIz0OLJD71g+sfEPSev3GVcrRMuiASCCE?=
 =?us-ascii?Q?G8rWnJaqqblh0oAh848uEAKzg2qZFwm+c3EgV6u7fPiZs5Qi71MhF/Ci71RO?=
 =?us-ascii?Q?UZ1+p7VoRlployASn6nieEeyvnKVfbi94fTuA3NYaDQGvQIu0fGp1Rc33Lri?=
 =?us-ascii?Q?BqunlWQ9FX2tIwF5CDjvCD17EDyDJ8Wu0WC7bIhtJEksBf6xIKxJKB2s9dL2?=
 =?us-ascii?Q?mHIYi6yCi/Oe/bm4za6lVtKwux0L6tek5fcaorh/zVeVQ8Ych9DuIw1hfjLB?=
 =?us-ascii?Q?wB2G1McEKwa0cL1IjaLASt9qJWXujEza8rfVtaFTY9hBu+lBV1HbtBBiCwgC?=
 =?us-ascii?Q?g4zRlY5Nxrb1g5/dBHWuUpg+axePv6i+eYiBLSgJJbuqcUW0A3oNJOqN8Awv?=
 =?us-ascii?Q?0/GzPasY92S/dK54fXb+zFyi5SoEeZ/0LruuRnea3V7bjR6lXwaIUoSLrTMn?=
 =?us-ascii?Q?TXSRJpcz05ivyYI0xD2W9oQujXECdlgxI42wZt0gfJ2OBXnvovFv0pgzrXVp?=
 =?us-ascii?Q?+PzOV+6ghIgi5lvui6P0yEKZ2E8civCK/bXnA9kjHKfMds2iQmRGbD9xcpHu?=
 =?us-ascii?Q?WhtZlpwFU15LvD3HRZwk62r7r1eQ1Tb0sAuV/CCNPg9BsGpOc8eaDPoSXztS?=
 =?us-ascii?Q?pqJZJOfYUJkld0wm0GAv/NflkHdVEbYMlRtQnnlrydoBbF7JJ7un7T+ZIB98?=
 =?us-ascii?Q?sCeOzNm6gglwhnL+V8dLvCs9qnJjhvISxubplZQKws9SbONoCCxVo5IKxWpQ?=
 =?us-ascii?Q?DO+/EWf4s5b13NOEo5zxVXnChfujJ7TIMH6ocAxoaRoMC352Xg42OhmNu7ym?=
 =?us-ascii?Q?5ZTDlxiZOdagTPDlhlkv4qLQVzOf4YPf28eeebBrV5GZSM6pIQWMn/5kJNbo?=
 =?us-ascii?Q?/bjYJVr7yIJQFhByVsCCSc8D5p7xwtQxzZ0YD6Y2xWkB1cET+kib26nzgKtx?=
 =?us-ascii?Q?mjhzCCHYT8+mvKOdytrs8U10N6RYRL83W2A9wFfjebbt7bWqtmQG5FbpabEF?=
 =?us-ascii?Q?ivB6804kpuBNIBSh+4Fy7MeBlcTVtlQpoefBV8NYHHvqpGWBP2qGSDn7e1XK?=
 =?us-ascii?Q?T5oIhqLdQWyvup8VnkGeaDoLWgZzlFVGdyJUgp/6gw0bggnEBzZVGA/tkad6?=
 =?us-ascii?Q?3bKkJMNVJmZptd6yb+bbh3qmoTuVW7WtVcSYu8vGsaSWO0Cesrjx94vMsBzn?=
 =?us-ascii?Q?wh72956RT0yLs8UrKFr73uczcw1kAL0IIK5kVpUzlNLBP+0RbOLwVZ4z+WmD?=
 =?us-ascii?Q?cIbrExYsqagcx4s5fzSl1XfYANVYF9EBRIJ+8XCFua2oyFPDh3p/pqwe/w88?=
 =?us-ascii?Q?WyFCQE4hbJFlzS0DtNrYd2dJ/45/lDL2nzffxsPK300NDIC0ijN1hxJuqgJ4?=
 =?us-ascii?Q?gsW8ThjwI7x0RPntRWLTsw3FzS3Xtt8NmrgUJnUEOs2YiRlhK1t/4O2m0ApB?=
 =?us-ascii?Q?A1CuZ3VFZZlNSbusaGw+kWGtjr9eUwrywI7NnxVd3cG3L7SKBIQYipvUmHBy?=
 =?us-ascii?Q?fz5vA2zkLUrOf3LMetKFvC2qWmKd3tWrW4/QGrOY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?jdRywnAYsk3aE19VKKyJK7Nn0sT6u+2zpVDyIECz/Pw4ZQJ7WPbtnlsO/Ys+?=
 =?us-ascii?Q?sb4oaFHIR3FZelLkrqtVMH/MFaMbqXdGIqtaEQcJ316F9mJWAuhcl2x5hK1x?=
 =?us-ascii?Q?q7dhZ27iNlYdoCo1K7+mHPM1mToY6H7tvSO98434wLvut1HvwIy0+gR3xXnr?=
 =?us-ascii?Q?Sd+yxrjbj2kPsa6rPrYlKTVmsh7wkZ2fTK3zmj4GHDbSbp3y14bjkGAnQVQ+?=
 =?us-ascii?Q?03zCQyS6esImePs3Ze14UUhfkdtZJPbj8Zgb4IE3e7hhq16JeJnssb39gjvL?=
 =?us-ascii?Q?PYYHkTyfTdGT6MfwGAPvGWE9jpmXbvrQ4Y78ix0NyUcMKslnXo82UkmOkQIY?=
 =?us-ascii?Q?zSgqO6A4E1rHINU6onm3DHZjKP92uO152f+pTihKnttJaw33O68Nv78V+0YC?=
 =?us-ascii?Q?iy1URQ9nYe/OwYv9bqzAqSiDpTAz+VFY7Yj11vw9FgUm1ActdyYlOM+kH7n9?=
 =?us-ascii?Q?GGpj/IbQNN8HtibTnrofeIdNGy90WQD0HtMdqWCMYPYMqjWnDMLTe/sLvDvA?=
 =?us-ascii?Q?vVBfR+cBZa6VTmWdsVnp6rWBQKLcpMt31Ogd7sa/mrgm/VGMUufhfYMlfYtK?=
 =?us-ascii?Q?v1gMlXw+PBzQpAaglxGoPPdRWwX68TXJN6VfvR42xDUQZAtSrmtWoVpIx+au?=
 =?us-ascii?Q?qlTNf7anfEZyo7T1jVXHJ1tywcS5LTP6Ai5cXMPG3IS7qF4UUuTLNHB+2pYW?=
 =?us-ascii?Q?1UIUU6Ty1mBZ9S/mB1SlZVeCTzFASdf8XBTLSrXeQNxJdaRnTTyo57oTJpfh?=
 =?us-ascii?Q?pq2nn+XgQ52kEI4L82j5cc74Y52On5IBTbZWZqEyCo8GQOEO/qY1PTaSCHL1?=
 =?us-ascii?Q?aHeKSF5ZyFk0ZM2NjezQIZIqOWTCstJ+3Nz15kaeSBoiTw/ySjSher5gcj/c?=
 =?us-ascii?Q?PpM9r7Cm+Nc+Pi3by/QhPHYaIK2n0elBlQScUjuskC4Aipw+5BUgRay/kJS3?=
 =?us-ascii?Q?02pphNC8pQE6ihUVgkfhOEGHx6xcAeb+45QRVjt5VAOoCMEsKzYHqujyFsXV?=
 =?us-ascii?Q?YnkyVvbQBb+BIpvmDj45MEjEy9MzHjfI3Bm8Fx282yS21x4=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf487f5-1650-4148-54a8-08dbf4c3daa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 12:23:42.6751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3v++FQgBiwqxxpYbe64CTV7/POMOumJvczIUCSfZn+a9UB3fAziKkwa8hkofvdvutUkUNP2VjH4Tuo3vxXV2Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7102
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> > +static void  ufs_init_rtc(struct ufs_hba *hba, u8 *desc_buf) {
> > +       struct ufs_dev_info *dev_info =3D &hba->dev_info;
> > +       u16 periodic_rtc_update =3D
> > +get_unaligned_be16(&desc_buf[DEVICE_DESC_PARAM_FRQ_RTC]);
> > +
> > +       if (periodic_rtc_update & UFS_RTC_TIME_BASELINE) {
> Is it allowed to ignore the update period as depicted by
> wPeriodicRTCUpdate?
> And choose a different update period, e.g. 10 seconds instead?
> If yes - then It deserve a comment IMO.
Oh - the comment is in the 3rd patch.
Sorry - please ignore.

Thanks,
Avri

>=20
> Thanks,
> Avri
>=20
> > +               dev_info->rtc_type =3D UFS_RTC_ABSOLUTE;
> > +               /*
> > +                * The concept of measuring time in Linux as the
> > + number of seconds
> > elapsed since
> > +                * 00:00:00 UTC on January 1, 1970, and UFS ABS RTC is
> > + elapsed
> > from January 1st
> > +                * 2010 00:00, here we need to adjust ABS baseline.
> > +                */
> > +               dev_info->rtc_time_baseline =3D mktime64(2010, 1, 1, 0,=
 0, 0) -
> > +                                                       mktime64(1970, =
1, 1, 0, 0, 0);
> > +       } else {
> > +               dev_info->rtc_type =3D UFS_RTC_RELATIVE;
> > +               dev_info->rtc_time_baseline =3D 0;
> > +       }
> > +
> > +       INIT_DELAYED_WORK(&hba->ufs_rtc_update_work,
> ufshcd_rtc_work);
> > }
> > +
> >  static int ufs_get_device_desc(struct ufs_hba *hba)  {
> >         int err;
> > @@ -8241,6 +8310,8 @@ static int ufs_get_device_desc(struct ufs_hba
> > *hba)
> >
> >         ufshcd_temp_notif_probe(hba, desc_buf);
> >
> > +       ufs_init_rtc(hba, desc_buf);
> > +
> >         if (hba->ext_iid_sup)
> >                 ufshcd_ext_iid_probe(hba, desc_buf);
> >
> > @@ -8794,6 +8865,8 @@ static int ufshcd_device_init(struct ufs_hba
> > *hba, bool init_dev_params)
> >         ufshcd_force_reset_auto_bkops(hba);
> >
> >         ufshcd_set_timestamp_attr(hba);
> > +       schedule_delayed_work(&hba->ufs_rtc_update_work,
> > +
> > + msecs_to_jiffies(UFS_RTC_UPDATE_INTERVAL_MS));
> >
> >         /* Gear up to HS gear if supported */
> >         if (hba->max_pwr_info.is_valid) { @@ -9750,6 +9823,8 @@ static
> > int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
> >         ret =3D ufshcd_vops_suspend(hba, pm_op, POST_CHANGE);
> >         if (ret)
> >                 goto set_link_active;
> > +
> > +       cancel_delayed_work_sync(&hba->ufs_rtc_update_work);
> >         goto out;
> >
> >  set_link_active:
> > @@ -9844,6 +9919,8 @@ static int __ufshcd_wl_resume(struct ufs_hba
> > *hba, enum ufs_pm_op pm_op)
> >                 if (ret)
> >                         goto set_old_link_state;
> >                 ufshcd_set_timestamp_attr(hba);
> > +               schedule_delayed_work(&hba->ufs_rtc_update_work,
> > +
> > + msecs_to_jiffies(UFS_RTC_UPDATE_INTERVAL_MS));
> >         }
> >
> >         if (ufshcd_keep_autobkops_enabled_except_suspend(hba))
> > diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h index
> > e77ab1786856..8022d267fe8a 100644
> > --- a/include/ufs/ufs.h
> > +++ b/include/ufs/ufs.h
> > @@ -14,6 +14,7 @@
> >  #include <linux/bitops.h>
> >  #include <linux/types.h>
> >  #include <uapi/scsi/scsi_bsg_ufs.h>
> > +#include <linux/time64.h>
> >
> >  /*
> >   * Using static_assert() is not allowed in UAPI header files. Hence
> > the check @@ -551,6 +552,15 @@ struct ufs_vreg_info {
> >         struct ufs_vreg *vdd_hba;
> >  };
> >
> > +/*
> > + * UFS device descriptor wPeriodicRTCUpdate bit9 defines RTC time
> > baseline.
> > + */
> > +#define UFS_RTC_TIME_BASELINE BIT(9)
> > +enum ufs_rtc_time {
> > +       UFS_RTC_RELATIVE,
> > +       UFS_RTC_ABSOLUTE
> > +};
> > +
> >  struct ufs_dev_info {
> >         bool    f_power_on_wp_en;
> >         /* Keeps information if any of the LU is power on write
> > protected */ @@
> > -578,6 +588,10 @@ struct ufs_dev_info {
> >
> >         /* UFS EXT_IID Enable */
> >         bool    b_ext_iid_en;
> > +
> > +       /* UFS RTC */
> > +       enum ufs_rtc_time rtc_type;
> > +       time64_t rtc_time_baseline;
> >  };
> >
> >  /*
> > diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h index
> > 7f0b2c5599cd..7bdda92fcb1c 100644
> > --- a/include/ufs/ufshcd.h
> > +++ b/include/ufs/ufshcd.h
> > @@ -911,6 +911,8 @@ enum ufshcd_mcq_opr {
> >   * @mcq_base: Multi circular queue registers base address
> >   * @uhq: array of supported hardware queues
> >   * @dev_cmd_queue: Queue for issuing device management commands
> > + * @mcq_opr: MCQ operation and runtime registers
> > + * @ufs_rtc_update_work: A work for UFS RTC periodic update
> >   */
> >  struct ufs_hba {
> >         void __iomem *mmio_base;
> > @@ -1071,6 +1073,8 @@ struct ufs_hba {
> >         struct ufs_hw_queue *uhq;
> >         struct ufs_hw_queue *dev_cmd_queue;
> >         struct ufshcd_mcq_opr_info_t mcq_opr[OPR_MAX];
> > +
> > +       struct delayed_work ufs_rtc_update_work;
> >  };
> >
> >  /**
> > --
> > 2.34.1
> >

