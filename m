Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EA37D6A42
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbjJYLg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjJYLgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:36:55 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8FC129;
        Wed, 25 Oct 2023 04:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1698233813; x=1729769813;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J6zG2lSVqoaHxrGpsVRoNeVQ1/qHg86lX71ATrG+N4M=;
  b=jnpix59GFEeW/gP0UHn4jCJ/4k8Sa7CQsytUunYn1Qt28HHw8gl2nNTC
   WV9qZrH55XqzpUUQ/xzOpzmKQ+WNPmvmsZ/jffQHDBIn0ShK4NvIH4ClH
   BVVy631tb3Pqfkkyzq+v5f2Jiu6kGFmHbmmDoMmCxq3g37sXpjIL5gDoA
   EcJ73pfvl4hnp1nQXYeS9qa4a+zqayaKDQPEipDfAsvxu5UzyJngGsrR3
   uFRQgdrrMz37lOenYwozk/6DffiPyyqM7F8NqVWmgxVMYe3XGwkavnJK6
   izZ2CJg1412JQOTpbPZrYcTtfI6jRAjMHpH7AnBE+Ch0im2qfwUgmpUlm
   w==;
X-CSE-ConnectionGUID: IQAjWkBaTh284bivVlgSxw==
X-CSE-MsgGUID: zUIIYKcWQnSSWnttTqJegw==
X-IronPort-AV: E=Sophos;i="6.03,250,1694707200"; 
   d="scan'208";a="589839"
Received: from mail-bn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.41])
  by ob1.hgst.iphmx.com with ESMTP; 25 Oct 2023 19:36:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0mNoErJVWjX7BPDkClLAgjVQUiaY/lKfUltHWtQc1f7otQvk9Wvzu7LFxVQwCtL2myJoGnWQrgOuE3N1V19sGIBntfmIeiasQ4u+/UuohrifiEELYNdktUaghOFUQpllftsmzqrVtHLl7D4MAGAzVfBjUheWHrvm1QmcVTXtYXiZSEguR8BEhWganvgEaefNv/t7GtRK9cLzz877BR6ew2DIgxVf1xXwfrkd0qrqqXas0uouBA6hm1k7sVpUcVtskp6tjBVLQdefOhjAxbnxhgm/H6gE/0UZopg3ETnuYSqH3BIJI+nJSkypH5IBUXfUjjljvZZXYZq5k3lOPkp5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xt6TshVJx3Kf+hTnnANr5mZJZ8+7xW2Pe8yxi3IQDKY=;
 b=DZaEPVocVMQHRmzGPvfu5i5Pvh8Bsa2dv8F4J/s3UtuU8RgXrn+orvg5wadip/dDahIl+Uu0OzLFrIu/cNGG76TVRXXNHKoEUzJRJbuvZk3qzvRGpbcyKdw+vXyccFZXzZJSkwSdRRkHMQX6abcPu7EPyococDvtw72FGzRLNB/QNSPM+CaKt1dfxjIx7IMvBc6GYnsYnP+22iaV96Q2tBrTWiHB1jloNLNo8h+is0MkTRq+kRrHpRJjGhYQqFNBlMh4IyAY0VIlVBS7LfMjBPr/d8cG+4GbRbW/rN++oGBqyLwbTu8NKRO/ryVKNEeW5apm+FTctC5tPwUKUXAlDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xt6TshVJx3Kf+hTnnANr5mZJZ8+7xW2Pe8yxi3IQDKY=;
 b=dsGA2tFuUeuQe0wpW9vSdKjfFxuiFhlmcXMnnVhwRfSaUkgHIBF7dnDl9Njk5yY3glKfcElh+SByeT65BUvQB2h5i8MhUvSMABwMobzhkMLtzijTvTu4fJPxHsrII8reG+rOlNZrumiU3HUN8oi3Pz0FAjrhWER2ZSLsjiMJSKQ=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SA0PR04MB7354.namprd04.prod.outlook.com (2603:10b6:806:e9::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Wed, 25 Oct 2023 11:36:46 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 11:36:46 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Can Guo <quic_cang@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Eric Biggers <ebiggers@google.com>,
        Keoseong Park <keosung.park@samsung.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
CC:     "wsd_upstream@mediatek.com" <wsd_upstream@mediatek.com>,
        "casper.li@mediatek.com" <casper.li@mediatek.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "powen.kao@mediatek.com" <powen.kao@mediatek.com>,
        "alice.chao@mediatek.com" <alice.chao@mediatek.com>,
        "naomi.chu@mediatek.com" <naomi.chu@mediatek.com>,
        "cc.chou@mediatek.com" <cc.chou@mediatek.com>,
        "chaotian.jing@mediatek.com" <chaotian.jing@mediatek.com>,
        "jiajie.hao@mediatek.com" <jiajie.hao@mediatek.com>,
        "tun-yu.yu@mediatek.com" <tun-yu.yu@mediatek.com>,
        "lin.gui@mediatek.com" <lin.gui@mediatek.com>,
        "eddie.huang@mediatek.com" <eddie.huang@mediatek.com>,
        "qilin.tan@mediatek.com" <qilin.tan@mediatek.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "kernel-team@android.com" <kernel-team@android.com>
Subject: RE: [PATCH v1 0/1] ufs: core: Add host quirk
 QUIRK_MCQ_EXPAND_QUEUE_SLOT
Thread-Topic: [PATCH v1 0/1] ufs: core: Add host quirk
 QUIRK_MCQ_EXPAND_QUEUE_SLOT
Thread-Index: AQHaByFSoPyKu9dDZUqQ/R3gM7mu+LBaYHlw
Date:   Wed, 25 Oct 2023 11:36:46 +0000
Message-ID: <DM6PR04MB65755C1E01075441D815DE68FCDEA@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231025085656.10848-1-chun-hung.wu@mediatek.com>
In-Reply-To: <20231025085656.10848-1-chun-hung.wu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SA0PR04MB7354:EE_
x-ms-office365-filtering-correlation-id: 430e0431-3348-40af-28dd-08dbd54eab9d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YPcF23KFnA4mTg/16RrduZ6GV+O5AG+EMuxKGcN9ocruKTNJW9DNA3tx8sn43d4Wm/H60zGX+OZXo+MicWcWvwkdoF6qAQlRhi2AjSBm1rFOdhhFJKov6VH/k+4eFrsw2HzzakZ/m/0sieBi6Ai1OLtxtZUJZN5QPV6O8vpl2woQFUeSkUiAeq2m8TJtWaUHBW99tjsrZq4U/67v8OMhsX9s+H5uTDXmDr1OMMYBtx1DgVtiluSRJpLhZEj1d0I8KsF0eqmrB7dNUKr2kbp80tyTZm6hntoZU+/HXM8mSQpmfDWKotS/fekcKOOjRSMNeTG2PXAJhaz8JliucAF/VnAoe5ncnTgVBZL9l0vVXc/+TZfe/Da+Cl8pnqBhOgiJLPQeHMBQ0nmk8Qe1WELmaI0N6IZtHvlfngYesLQAxplhEvHnr6d54AF/yoz3E65wtL0hRzygu6cy3ncDgE5ozHDHzsrZ/F1zKxkiFDpOc6gKKLAaKb2V1xszffQZR6nji4KVDlAR7S0uvfv5HJLa6NsMv9J5A8sL8Y+4gZ5lXiyWI6fN0PMwE94NvH3gXixW7ayW5yX9VFKskrW36xclRQhXvko7gE46sjfNGchnQqXuO1GhWxFT0T2i496eN8CEj+dRCY8PzVRpVATNhrK1ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(26005)(38070700009)(921008)(86362001)(55016003)(41300700001)(38100700002)(2906002)(4744005)(7406005)(52536014)(5660300002)(8676002)(7416002)(4326008)(8936002)(33656002)(7696005)(82960400001)(6506007)(478600001)(110136005)(76116006)(122000001)(66446008)(6636002)(66556008)(66946007)(64756008)(54906003)(66476007)(71200400001)(316002)(83380400001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VPjvlvAWUEQ9xqMWJzDw9ZVy8HbgJFbwMFtu39nsi1hfFb3gUnDnB982HxPH?=
 =?us-ascii?Q?LpBMoDBqoMBE+bbXiskJYmvF7BoB4Uw+NU/vdi+TUMKSoZgpzJbPfBvF8wDu?=
 =?us-ascii?Q?NTMvynN3Lvxt+1Ag2ZTJNioKCuXuxgB801XEeTlHdLzPYu3kY4CurCRF3wB9?=
 =?us-ascii?Q?f1e7tD9GQxO02FB4B5oxH/bxACRoIW0x/cWdFvUknrC5ZJkErc0LEefszBir?=
 =?us-ascii?Q?lqBR9ND3TeYA8xA/mbfF/8xlXFswg+GNN+C3HdEMhdrXfQIInewfQS7omiby?=
 =?us-ascii?Q?nkNEuQGDX2s5P81z6739GapVWKO5znIygvhuPVmn7ID44PP0tSN+nwKcDNxF?=
 =?us-ascii?Q?nIzRQtCqroYsUI1aEUpWkx7nxAhC9+f8ChJUgJw3An9qQ3aaWBpKncyFMXbJ?=
 =?us-ascii?Q?baZ11JZTVceL7fKBB850KvllvNio1GMLlfcUB6y9CZ2qgQapks5ZEvRIPYbi?=
 =?us-ascii?Q?7gBgHrHb25rE0r4W1dIjAk0ugIXxKHeuEctlJrGsD8bTXMh6BJG0lu7Pbf5q?=
 =?us-ascii?Q?rpnUrQG2E2MNglxFpW9DaPPuxK+TiDbOvG9LX3dnHXEJd0IUaqK4jDxD0BZ/?=
 =?us-ascii?Q?EbhCWdugtLq0RsNMV3vbRmAHFM9L7hBXxT3k5J8RAxRMw7vzhE7fbtdPBX2R?=
 =?us-ascii?Q?Ika4TVwMNnfkeW3vD1EnCBwQuuoAStlcU5kjL24XoQCAaYbsNQFufjUqg1Bo?=
 =?us-ascii?Q?IDVOnNJfun5W/4KCI8pddfRzn208aFHih7zUI6K2k2Q3ONulFzKsV8UmKav2?=
 =?us-ascii?Q?uy+6ABXGivGZ/eITJgonIsFYgCzgTJw/y05t1FCd1s2K1XVV2JFOC226iJhk?=
 =?us-ascii?Q?Jy9MB3AXhqZV51ie/IO0nx0VzIWm/D3B4NlhgE2zt0BYjA0Zbjq5cMTsl7BM?=
 =?us-ascii?Q?as2O46pCFmZbyMiqu82aPQhsaKUpeCVmw/a2S85BU/E+2RDWkaV4Hv3BKWiX?=
 =?us-ascii?Q?riCPbuabPq00EwhrPpjl7HwS/7LQ/KTF4EKGA6uam4BRACBaUdaPuHaUZDug?=
 =?us-ascii?Q?UMKlnHgZQlg5lijVeAjVGUv2gqFf+krosQpy0jQ+0+54k1c/0ZOSLtIwFMvS?=
 =?us-ascii?Q?T3PZ979KXmj4PUtuAd3I3qDF3OwnnuNqORo4SOK/mEqn9Z62yChjRyscBIwM?=
 =?us-ascii?Q?KeGLyM41qJyeK8c3//wPMXdyFlfO/v7EMy1Gim/EWxLNCHbAwuQVo+yh9UlJ?=
 =?us-ascii?Q?RnZz623TwXOfjs3VzuIMwDv0SHmpCJqEPW/JGF0rp7M2FvL5y5WlkINgI5oG?=
 =?us-ascii?Q?3YNAirL0Qf6XvWOzBqnHqd7W19YTer4G83uQutUvCOkmMUSIjeywWAKgvkbq?=
 =?us-ascii?Q?srElJdRwNjCvthfVxkWRsYDuVSMSRkOP8JiOw3JiT+8eM2Sj5oOgmXF8GUhr?=
 =?us-ascii?Q?nBwxOJgt4FDD2n6pF8C/ASoXsBgZ8/ewQzCNyfWeDB9iYUsEEw6eXr1cvoEE?=
 =?us-ascii?Q?k2Dexmxf8PdW1yTYZYe0lj6yGR/U05fRuRmtVHqZy6Pt41r88eO6CtHnkmmL?=
 =?us-ascii?Q?fd218Og73EXRJlcNfozZTN+OAPFRGcd/YW9UycGhyjEo8QbU18Ea1K8BPrAR?=
 =?us-ascii?Q?BSV5CkR2k172NWUv6NE/xbrHuKC03xdbknCBN7QT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?qVaW9hH70Kl+evxmk5cdRFu4h7k9XtDERdF8dpZf7wNIU5l+i5eDAZuqc+RY?=
 =?us-ascii?Q?A7DeHQQxKpBVmbxXNGDZQgaYMdnuGixScDCPXbqCrSJRjMD9pcp9ssHrxAPJ?=
 =?us-ascii?Q?KihnbfZqR6NlRaISC4gJkC0wPE18rGpnk0qW4ynAySAWGFUh2wwd9NXwKhS0?=
 =?us-ascii?Q?lKvyK0tDnrjpBnKELuTgOLIk40jbFCrauKz3PH8PXdMVi24RfV5AUeN2z7g3?=
 =?us-ascii?Q?pfeMWDWPCMm4SEFQheZWC76HSmKxrX7t+gmJX6O1A22fnhLXdH/SAXcXaO7C?=
 =?us-ascii?Q?FZ2qQwn3dvRGH0MTg9gjdo9lzg8Vmbr85f//Q8OJtJ/v3ls4swC6eAq1ZmK4?=
 =?us-ascii?Q?vFeNEvVDTUUctNRIv/5NZAo8pJZLYuaZSq6S8B+8F1EH/F8W1PK6bkk/NGsJ?=
 =?us-ascii?Q?rvSe9DNq6A4Jivc700iBxVu+kym4NpCr9ytLLDUCp1wbcSCsvl3pLlq6Qw9p?=
 =?us-ascii?Q?33UhqFHH9PabeTLgSqOnPqJDiWTgEdTicYpml10XiYV+HFOsuHHvIBYhmN8J?=
 =?us-ascii?Q?kNMHh7mM/7S1PmBGvJc/qq7zKeXWOI02+rYgm6m/4xvhR7ABgCDDNhecqTZd?=
 =?us-ascii?Q?jnZWtHMImab+GHWBwBTeZqtqhruGxKpecm/p5/TMUnr/kgaDoU49cxj9dk3z?=
 =?us-ascii?Q?rofsI8FbOM++KVLEv7nO1WnakziYlEuVUyjPicc4TzRLz8wZViQEZr8gTPSH?=
 =?us-ascii?Q?OrK+JuSl5Ldv7ByenaXCUoZOa89+355urXH/lLMtrQFjDvAnN3Eqx/q4nITe?=
 =?us-ascii?Q?KEGAdZtWlU5Xa9CdAmejyFQbASBGpWyoKKzhC104hosfoktN7+WRur6/jQmK?=
 =?us-ascii?Q?VUgmDzTETJj6W1aJelbN/s0KrPXoKtJBAAZQcbDi0sNVzcyTU+/6PF956cGG?=
 =?us-ascii?Q?VAH/PRxb4C/li79JfYPjPEw8kGwau/RG3zShkAApPC6S+EU7xKzaC0pIEvD6?=
 =?us-ascii?Q?/FtSJJD7bw1d0+S/dcroiTmc/DGT02FHf+vxX2fvB6AI7NszBSEafvYipEbr?=
 =?us-ascii?Q?ux7v7tEODceDb9IETffABYTwSRo6ShUChD2RgMb9bDc3yghQ52rvtaiI3m5C?=
 =?us-ascii?Q?ZWUFwgCVeYr7jdF0nR3atIg4ZUq6a5a/QEjntAKf9nx3TEyTLLj1goZb8+Fq?=
 =?us-ascii?Q?bawxfRsY61nTNCSo3VunhE17St/Oe9tK/Tb1LbdJCw94QxZOHflqdYmfQS2t?=
 =?us-ascii?Q?n+1g9eZhNj6LyDBBowIyd6QJCS9JKoow+eZ/WsgmtM4G3ZVJRvr85vCDKKs?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 430e0431-3348-40af-28dd-08dbd54eab9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 11:36:46.5994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6pVjVtZxQYbax5snEVV5QhqUBPLyJKNw4tdZRc1bUMbpvUvr4OdUe5aI/H75CzXAc7/FypbzunRCCLSnnL+/wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7354
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Support quirk for host controller not able to distinguish queue full or e=
mpty.
>=20
> Alice Chao (1):
>   ufs: core: Add host quirk QUIRK_MCQ_EXPAND_QUEUE_SLOT
As part of introducing the quirk, you need to set it on for someone.

Thanks,
Avri

>=20
>  drivers/ufs/core/ufs-mcq.c |  5 ++++-
>  include/ufs/ufshcd.h       | 11 +++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
>=20
> --
> 2.18.0

