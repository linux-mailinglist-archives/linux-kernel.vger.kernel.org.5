Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCDC77D987
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 06:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241729AbjHPEvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 00:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241712AbjHPEvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 00:51:14 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2079.outbound.protection.outlook.com [40.107.7.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A1D268F;
        Tue, 15 Aug 2023 21:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nU1SSU4bDqK/f96SmoNZYosTy9kxFGyPU0+VFf0hlALOb6Wm1hL313ZPruCme8QAVIWYadmmymIURzPF9JelX9+NMDAvd2vFJLd21ra/hfvTNQIhj9fpXW8RcZpNhrGavZ5fFpSxxHqElPMwQJDVK/5sOzGZdY2iuj5hMh5E7Vs/gefiKX93vgU8+X6c64aL4omwguUvWBo9yEIBlZjISxirvTN+EB3MBTpIC/hT3D26+9MDJG+FObY0BnL2K4o8Wb9YivqyEKKvsXLTnT6KCvK01nTagS/KEYxFuflwdJ2mRZc+yDJjfWyhm5qyeJ2o2WNEGC1wKSRVRZWbo7yVnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eg1BrFXSGyvHnk4HwLthJp1C9cyLM6axkP0x11mt8A=;
 b=OC3cQ9Ng1BytJE2r6z/iNMWREjSh/C3gS6v8C89zdV+kXn+ymGB1osDmLTRb35SeEyyLhZFBVSATRNdYlGFYUuqU9E3fQ+6hHYnX9ROEnOKExVjDhsmvKgxIZ349Fl/T9yUvNJ5sDPG3NPnE9ufNwr6ur+rv8Z1M04O/vsCiuU10d5/8mEzet5NNDHZ6buTPuTCPKm2tC9bzzGv8EhrLW5Lz09TByprMN/Mvwce+G87Y9QM1tAzn1FioVSX/Ue3glmH1VuK49M/8KqoRPFsMckYlPvXQYV8ChNazeLWKSfaxpA8j1IlyLncCyDHENnMBmmbII0XrovHzIMtrQDbKAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eg1BrFXSGyvHnk4HwLthJp1C9cyLM6axkP0x11mt8A=;
 b=rjY8WIGgvFpGmUi+gbF2jQ2pfbCgjXGkqL1lmrRgc0sGJNczpbfEIEA77TRYK2xJF49D4DSYl5Oe0X0fOXy7IocJC4jiDNAxmqxOkAVwtt2TCJfSFr1DGIfw5OFJU8KZZUzyz7OeDKd5/4hvcy5K1Onawslxskb7Xt5fhdtQxNrrL15mR1Bqca/ac+ilvscgs5XeHaUk5kI1SYGDyYOb3Q7qiiiAf74Ox/+lSn1PtE/v0ocBoqWTJpeoW2NJJBYTHKuHNFGKl5+MfZNks0OJAMlJDOoXkFcfC5E7t9GpKOOqggrDOFHjgW2L/ByXbETTVf8JDhqylKjZ53WpZWc7Eg==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by PAWPR10MB7126.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Wed, 16 Aug
 2023 04:51:06 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::eee:6a15:6c5a:af9c]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::eee:6a15:6c5a:af9c%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 04:51:06 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 09/10] tty: n_gsm: expose configuration and statistics
 via proc fs
Thread-Topic: [PATCH v5 09/10] tty: n_gsm: expose configuration and statistics
 via proc fs
Thread-Index: AQHZkuk2CX8IrRHQ9kCvVOo/5/xSz6/s1LXA
Date:   Wed, 16 Aug 2023 04:51:06 +0000
Message-ID: <DB9PR10MB588118BBA6BEDC06EEF6FC75E015A@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
References: <20230517155704.5701-1-daniel.starke@siemens.com>
 <20230517155704.5701-9-daniel.starke@siemens.com>
 <2023053053-cider-canopy-36ae@gregkh>
In-Reply-To: <2023053053-cider-canopy-36ae@gregkh>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=aea84db9-593f-4a86-896d-f5cfcfa48723;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-08-16T04:45:07Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5881:EE_|PAWPR10MB7126:EE_
x-ms-office365-filtering-correlation-id: 64c23fae-1185-4648-4cc6-08db9e1466d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cVDYrHGNsjB20GbowddCOMkUUHlWPy3ERysFdx4iV+aL3wUAKiCOKzUTvCmHP40uzDwZsa1F7Ms/ClPWHiHzJQ12CRLmaYukEObghFDou+Kn15tjAbpTqe7Gf1iUpfW8qZHS929M4yp5NmIrXVSMeogKoJx4bQMVrLX7FQT92beuVNc01mpJH05NnkN0/jT/wUCJpnlYxW6Acy93/o8E5hDAUyxGnTjO2Y3U+9WAsntvL8AfK7Ivt1hIq7Fk1NExugOzrHImvx+7S3EM/JN0awwGUn0bVu26PmHcpaQA1GBtCKI/TvMtBOyE627L8IY/l8y/YdxqJt3HTPzh5yTCMyGHhag9RCpSLnTT5PfEj1TEGdW4aEPJoEyOxYZ2UiEBf9K7SqvkLdGhqqSTk1e8Si72YSo/K9ngQ/vbsGx84zSRBt4wN/nfFm0P6KDUCTJoknj2vfm8pJMUCYRP6mFTidYtDxFjV5Y3ERGDvLZicfeMzhMqZEq4DKMnMrxs5r4iGMJZVr4h848Qh3tIW407sxOnc5gA/1JB6TFCVf1V2eM/WLhKtx9wQwK62W3/j1RScJk4a2jdI9jGOKDZYEHLlJ49loTtxgBVQRWB7JfjasxJQpBCRVpmSPhisZqzNgA+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(1800799009)(451199024)(186009)(71200400001)(64756008)(54906003)(66446008)(76116006)(66476007)(66556008)(66946007)(7696005)(6506007)(4744005)(2906002)(478600001)(9686003)(26005)(6916009)(5660300002)(83380400001)(52536014)(41300700001)(316002)(8936002)(4326008)(8676002)(122000001)(38100700002)(38070700005)(82960400001)(33656002)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GKk0HYEshqXa353WdiYBlTLtX75iFtseIquVlERsQjI0v05PC9LyhE7d3ufw?=
 =?us-ascii?Q?ddeOJElLve0XYqnpxvjuQb1iuuf3Dsm199JMRhIzWd2cVlUv6pDnDJC0MKO6?=
 =?us-ascii?Q?dWvi6vsNucnAqTKJaV4+OCJyQvLt//ofkVfFwb6r0p+Tl2vfhGxQj9Jzogh5?=
 =?us-ascii?Q?1iffQ2VynXjaMcfcBomJnit5vIAwCIU2bav8Zy+ptfZXek9y7J7KRdC0Rb6L?=
 =?us-ascii?Q?HlZNi2cSxJs21hvsASWp3RqPPF+EJgLVuzdpKg4JdH0eLeI5i8wjkYxjEQkL?=
 =?us-ascii?Q?O7z+5Azi46qIgPh83JJ2mFW51GWnJN24wslnwL9iDvb8Svy99r6e28sUXRWm?=
 =?us-ascii?Q?rewZPi0cQ7Yyhgs84Nt6olEw9ZCAFpCo8c+ZgDPcYioLy5SzHS0ocRoD3rlb?=
 =?us-ascii?Q?O/m2hiMZHEsSImlgzftz9UbgP1hxMbwS6bxBGmgmr/2LwmAE+mKIJvumWcs4?=
 =?us-ascii?Q?reAGfBhZ3FzQEVTJY6L0Xq196EkevMSFLwTm2L1KU5h76v2fVmMEAdhnnJG3?=
 =?us-ascii?Q?6+B0Pu+0T5ULXgBxYnu3Q+omlwp2EYt+RALTJSM42wETJdt4cFxa3F/e/MGZ?=
 =?us-ascii?Q?wmSzZV5H0uE+4vrRIOrw/AUcNxQwfrjSbbT0Mramv9BFz4bQAbi+5FWk31B2?=
 =?us-ascii?Q?x8vWh/bqGZ5wrdfLgCPPc0VME1i0RccOszqTcI5kfEsTe1r9/JijKDdWyTnH?=
 =?us-ascii?Q?J1ZzFuc3rH9kakLCz986/KeSOqJLYHQL/W9jKZEt0gQPt2pUJ4jLsfqzgcNC?=
 =?us-ascii?Q?l8gdT7C0A33Vn3Ec2on4qZRROrAIs3yNKIsZZ+wgRCmwkRxnBwyGrnq+hdGe?=
 =?us-ascii?Q?9XvKYNs/vQm7ZvN4e9FWeCaxnO6PehfowiFEg0koIsGfvjvWCCsuS/rZgPma?=
 =?us-ascii?Q?ajFjhuc9hDaNmaT56X1yAiZkqYjCSKBJZXpAUUUH8QDIyia1O8pnyq6v5WD2?=
 =?us-ascii?Q?zXU5X3UR3XsxtiP5LshXKJRePuMFUoZDHcztgN+ZOEfIeX5Ij7reb4EBXrju?=
 =?us-ascii?Q?ubMn3326ST7avOUau+v92ixz6qGYQO3opZx4NwzMJDFCy28CtFHmXmTSSzkv?=
 =?us-ascii?Q?lDhrqfW3BgAz5FnILpz14k+uNawZMN4idBbYT1lQBoZQ93ZuecakAapsaH1I?=
 =?us-ascii?Q?SaIKQv9avzCkUgbUBu7PGAQnM/XUelYcRDtYCphrnmwVf0Ulg0mkmjN0B+g3?=
 =?us-ascii?Q?ZjdZpoJwnP6WPms5kackYnkU9xekpVrvi84zWx2/AVFKDhgyF/30EFsyAviN?=
 =?us-ascii?Q?Owqw+qt79OiTHNw3PoqtPE3Im70554IEMkzKqdXYUfoXQYBYCU30IuVrbUm4?=
 =?us-ascii?Q?0gCnNmNJXKORrEHnmQzs5fYldF4uzH3F7pZ6aSSENwgERAVDBCi0R6+Wb6/V?=
 =?us-ascii?Q?jM/BqJsOv5WebmWeYBbe7zjE7IjGhl/MI9BbZ1fZ+4r7ec2HzHVc3BhJGoBs?=
 =?us-ascii?Q?/7Sa7Xmop9Kt1UKokswLdQl5bF79j/PQTUB8cGY70oMtKfO0YjRWVI2CKrf9?=
 =?us-ascii?Q?bdFyBJi8zaV7OHx6vLZpBwiJgsU0lG8u3OJeggNmdm4QdZrHhUf9Sq+7l/0X?=
 =?us-ascii?Q?MAbUtYlyU96Z0cc4D58v1/10kY+whGRAAwawQ+4edLCWx+eVRXQwDUxCN7vy?=
 =?us-ascii?Q?kQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c23fae-1185-4648-4cc6-08db9e1466d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 04:51:06.4562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gDEp6MYb4x8MXyltTwsy+DMoq/C6MXxc3o+vBVezED+kRX5cl6iua7PSMdkAJ6b+4OpNFK6+N5znZ/ZM4LYLFIcxU8mUgMhdipddAOsmwpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7126
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Please no, procfs is NOT for driver/device statistics like this, that's
> what sysfs is for if you really need/want it.
>=20
> What userspace tool is going to read/parse this thing?  Where does it
> live?
>=20
> And what about the security issues involved with all of this new data
> that you are now exposing to all users?  Has it been audited to verify
> that it is safe to do so?

Thank you for the feedback and patience. I understand your concerns.
Therefore, please proceed with this patch series by excluding this
patch #9. Please let me know if you need me to resend the patch series.

Best regards,
Daniel Starke
