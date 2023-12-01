Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9884800656
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377955AbjLAIzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377951AbjLAIzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:55:17 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F55D1;
        Fri,  1 Dec 2023 00:55:23 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B18A7gN013029;
        Fri, 1 Dec 2023 00:55:10 -0800
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3updt6ew80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 00:55:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5lI+8e/KynYUTuquYTke9JLqs8f23hNgGmrCXIeBSCrNDEWKTUP2vu+edHu1xz7GYMcearan1IGuImINbHDttd9L8pcVpWxTcaN5IlIli/Jxg2TU7+FOLmmrzSwEuSW3zfjbd37dPLrdUuWid6kTuhs8f1eUU3Q/pxfbV5U/49Y1cdtH4mItJqgC0ZRjTQkxUcZ9/c3EhrUmXDSkgWdacbuub1rf/od2iR/iRc/oYcEhlIpUI4NozWzCYUMztuNZlgXFDrZ8zjhwhGlE7sEFyyzYZWJWgw4h/hinxVqaGUEZV0jCamWg/ARyvfsE7DNq68BF00ECwxwIxzskAKolQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVllYZPC+etCwXh5CSZThMJIp0eWred+tTnA0c5ATVA=;
 b=Xim2qZ8CyxHe/CYb7JYb+CRR82GNUB7dvv1HtzhPioVVlzS4f30zSbzfjsvhBEWNALf8IJWd1JvEiXj+dZ1KtUSOoKnfm9CWvWsGt5scyX11VX520bwrMtImOBshEgQktVE0Rn0O9BNs4OxwrR0TJKNB3yCRebr0hOPI5qdGY7OQPIA3uCsLVpgVD+iK/R4MGNNxdQbeeSHsjI1SnncTkflDGXKB32PHO01X1YLKzgH5rp2VlMhKfteDRuhOegEyVsWcs77XHja0NVMi1XUKyP8yPiweYSKKVb82yMgX9MIirtLdx9jbZmI7Pdf6bHMYL+sU/AhWBbBjNb5dEX8dKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVllYZPC+etCwXh5CSZThMJIp0eWred+tTnA0c5ATVA=;
 b=Q/KNRqBYhtfQlkh7cSOn+ejLLlcARCEtRMkngOPDd2aEVikjLfExjKWBaFe1173AghEXfezUU86j96LxpUnyHsx7z+PfuWR8/1bTP9WJsDDV9z/+fpDaDE6qA5Qrhnd3qvgHd0NlyR7QLUDKTKACUI7qh4lMYT2AUis8NAV0UWk=
Received: from MWHPR1801MB1982.namprd18.prod.outlook.com
 (2603:10b6:301:6a::30) by SJ0PR18MB5213.namprd18.prod.outlook.com
 (2603:10b6:a03:381::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Fri, 1 Dec
 2023 08:55:07 +0000
Received: from MWHPR1801MB1982.namprd18.prod.outlook.com
 ([fe80::60ce:c263:ce56:b367]) by MWHPR1801MB1982.namprd18.prod.outlook.com
 ([fe80::60ce:c263:ce56:b367%3]) with mapi id 15.20.7025.022; Fri, 1 Dec 2023
 08:55:06 +0000
From:   Sathesh B Edara <sedara@marvell.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Shinas Rasheed <srasheed@marvell.com>
CC:     Veerasenareddy Burru <vburru@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH net-next] octeon_ep: Fix error code in probe()
Thread-Topic: [PATCH net-next] octeon_ep: Fix error code in probe()
Thread-Index: AQHaJDQUcOq9NXBiNEOoZYNhRs9fOg==
Date:   Fri, 1 Dec 2023 08:55:05 +0000
Message-ID: <MWHPR1801MB19828A129D67109B97458B2FD881A@MWHPR1801MB1982.namprd18.prod.outlook.com>
References: <cd2c5d69-b515-4933-9443-0a8f1b7fc599@moroto.mountain>
In-Reply-To: <cd2c5d69-b515-4933-9443-0a8f1b7fc599@moroto.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR1801MB1982:EE_|SJ0PR18MB5213:EE_
x-ms-office365-filtering-correlation-id: 4ec50264-4537-4c78-6460-08dbf24b369e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1/RGCIzs/w/DVfim2qUw/N9U4NRKCeLNvJFg372tdYofsFxodl5NQOUcKIppjoclgTkuAfOwIownSLrOEZ+nR01wSSEeNcUonuwiRbWliyhZBV8JWfSIpd7S8v2BhfLWjOZTDXU20Y50p4pJ4+yvrz8ihSz1OoSch3f6Yk165P0Hf7kqpD+r45hvwnuLGKVlz45BpUxHRPIqhxfBD/ke0n799L1qzmAhwwCBWhbiLZgr50ob1ufJ/DJEroHSrcMAxXU4hwZ8PZSYbub60lEvtXAeLT5uckXN7i14s8qokEcwM801ukYsu9ZKOO7puCdCa+JQxTJWASO5Tb8AS4QmT51KXFtvwFLpfQnDMxSjW+uWew4XYtDc+awddjci47MliRqBCFQGB8rvjOjtBXNOpb/CwpJxB9uqW+ROgMJOP62F5xKy1Xyz0JnWkcS53bKZ+gkIYBvGEjXrlc0MpQjpuCasXJL/LtOQ5tq63JDEwHqO1E32j82EgbeABjdt3MAKJPFfd/WaeER83rcQ08R9M3/fFomEaRiiJEh1BvJRFS+WOWJeDlHpf6kj8BMU9YLx2ycfrasUsRNci2cfxiV2L+iwGGambomApBwuoqtUIRLrR6+ZF/DeaJoZwX6GgmRZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1801MB1982.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(478600001)(9686003)(6506007)(26005)(53546011)(122000001)(71200400001)(7696005)(83380400001)(2906002)(5660300002)(64756008)(54906003)(66446008)(66556008)(41300700001)(66946007)(66476007)(6636002)(76116006)(110136005)(316002)(8936002)(86362001)(8676002)(52536014)(4326008)(38070700009)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PafG4npfRukqrqutcTgubvGbfy0GHHrW1vQ6Sh4DTukuydhDx6YljYrnJKF1?=
 =?us-ascii?Q?ib4oV8DNt14HwbB5ZGFxysyZaJn/sdsVtId6M6g/cC5fsvTMydF+K75nobSA?=
 =?us-ascii?Q?kgG+USPFrSRMOV1t8FwSlfZahoOdimL4J85tCyzRNq+e7lrZX7y4D7lYaSAY?=
 =?us-ascii?Q?WlcyWoBQludDN51lVepmtqCT6ISlvSt4Q7uczZRrVNBBt/mOqavPgVWlFboS?=
 =?us-ascii?Q?Uo2xiEUxhQ20gzUdmkhSgE6UVsr3GkGB6XZ3d1J4G1I6d5G/82f1NNa3fWoN?=
 =?us-ascii?Q?/HwDFkh5ThLtrUTae0+2t/GZy3Kkxbp04+3US7Ss3aCb8ayx8XJiTqo0XdMI?=
 =?us-ascii?Q?tTKHlfRAf6svItdwkFmR3MrSE5DQx/GSmMjHHJxm8Li4cedmZdZL94X+5R6b?=
 =?us-ascii?Q?Jjn+ZRJY28OFMmaH5FhUp2gb33WJN+r9EiOeX4cBy4V/X8u+hpHp55sYMlTM?=
 =?us-ascii?Q?Q9sffAdSWfnEmhk64lNzjBqxyf6/YxEP4B3l09VpVl7wrsi45svBMoQTSnBu?=
 =?us-ascii?Q?PIZ65zgukYfsTisLC3M8/hGyPMNAkFrGY9Xmt5GRaQsbMDnjUhfHOgFul951?=
 =?us-ascii?Q?KTGP/Y+91yzgREbtBmuTrPJmQlEymRibZoqpXdgXsRT9aAQL7T7eJXdTyFX0?=
 =?us-ascii?Q?tQLHj++B2GHjVbFAj8otyor9G1lQsR7SyLzLx4N2CP8Nz6G7kQgK0ySgDXqp?=
 =?us-ascii?Q?HFq0vLmxuM6koau4FgONw8kkBRF/Ei+ar9agdcoJuRJ2DLudU8Ah8nnk+16K?=
 =?us-ascii?Q?EJA5ScMdMMrypiOQ7hB8bW4McKuEmyzVmWSRkCcunVuF7H2lOx5QYk2bhojt?=
 =?us-ascii?Q?Os5HFQSm4hDQPI13zTUjUH1zaTmSyWcTGlcguSHAKLNVZRkr0FBryTQcEGSj?=
 =?us-ascii?Q?310pznYM/yBStxcRjQrq+2DgETFRji/z1v+YeARGfyu9X5615DtwLJV+nQMl?=
 =?us-ascii?Q?eKZsDEvpDVSXd1Q1elTam0fuAKvMSzFqL7D6yrcUJceTtyFcWg5Td+6oAKDr?=
 =?us-ascii?Q?6wRerFor1yplcG2q2Lbm2emu4nX41s6BEvZj5Wc70zF76BgK0sBMPqJC21mF?=
 =?us-ascii?Q?apQ9pKhCrtmIpZwo4J4kJQ2K31bObrTwI0IaNf7pkRotuqCHyu8FIaoZHlSC?=
 =?us-ascii?Q?OcQw0Ak63X1jy62/HKV7M/nQrDvrn//oDb+Jyo7pB1Nhy8S14AVL6GgN0yBf?=
 =?us-ascii?Q?5KBidISdnoKzz5x0GGz3nfCcl28SXQCQVlywD4+EUPoLgHdpsh7CuqlLwosB?=
 =?us-ascii?Q?AZSsAXGIN3DSH1+2exrWnib0PXXZiiaJzzpUZ9QAamL2eMC8caXC7joPMVGf?=
 =?us-ascii?Q?CXqIPifPtncbrm3IuZRmUyvOQV3b9fSCBBi5ynobFdV45vMsDDn0naBv4dbJ?=
 =?us-ascii?Q?mbeqgwdaa0iNsA9ib0A8cHoby+bZtIVsLZSYbGE1oT6J2KMyFwZqVTB+r/IL?=
 =?us-ascii?Q?dBck2r95lTInDsj02yT/SIQ1owOm8bmikhstXHh7BBJeXProIeHOnKFEydVT?=
 =?us-ascii?Q?R3xplFYcQKNReUVXAJcs7mpKkVNYl3ysQgiBCluLfLX7K7Lo6gqoc6O1wyTt?=
 =?us-ascii?Q?892hZP6cseGr8IjitYs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1801MB1982.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec50264-4537-4c78-6460-08dbf24b369e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 08:55:05.5621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fCX6a2qljO0xZb77nNz52eKqtswY+K7jf9trSJxrTxor5G0xs9wFdGGXoTzFjTTZJ3t/MVsXDrlZq5/sA9F0Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB5213
X-Proofpoint-GUID: aNIip92kE6v19Q1Qny_4hM4fM77gF-Hp
X-Proofpoint-ORIG-GUID: aNIip92kE6v19Q1Qny_4hM4fM77gF-Hp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_06,2023-11-30_01,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Dan Carpenter <dan.carpenter@linaro.org>=20
Sent: Tuesday, November 28, 2023 6:43 PM
To: Shinas Rasheed <srasheed@marvell.com>
Cc: Veerasenareddy Burru <vburru@marvell.com>; Sathesh B Edara <sedara@marv=
ell.com>; David S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@goo=
gle.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>=
; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kernel-janitors@vge=
r.kernel.org
Subject: [PATCH net-next] octeon_ep: Fix error code in probe()

----------------------------------------------------------------------
Set the error code if octep_ctrl_net_get_mtu() fails.  Currently the code r=
eturns success.

Fixes: 0a5f8534e398 ("octeon_ep: get max rx packet length from firmware")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/=
net/ethernet/marvell/octeon_ep/octep_main.c
index 423eec5ff3ad..f2e5c7d80398 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -1383,6 +1383,7 @@ static int octep_probe(struct pci_dev *pdev, const st=
ruct pci_device_id *ent)
 	if (max_rx_pktlen < 0) {
 		dev_err(&octep_dev->pdev->dev,
 			"Failed to get max receive packet size; err =3D %d\n", max_rx_pktlen);
+		err =3D max_rx_pktlen;
 		goto register_dev_err;
 	}
 	netdev->min_mtu =3D OCTEP_MIN_MTU;
--
2.42.0
Reviewed-by: Sathesh B Edara <sedara@marvell.com>

