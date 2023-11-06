Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0E67E1B46
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 08:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjKFHfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 02:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjKFHfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 02:35:44 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB35793;
        Sun,  5 Nov 2023 23:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699256142; x=1730792142;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pKDAf8w+b8r0sWS17T7R16fybgzR1LP5BPtmcZQNZ8I=;
  b=F+kDPE/Uw9dtHN5Jpvyy//7z3uqlzzIRWzqsmMOOkpKMDtp8y7tZK+32
   Q8uy0M/P2Phlrgg+DMKSz5jI8OlyxH0wkm3E8bTB6hC+AxfaZSihXhUdA
   g4F05aOlRSsv2HNkctgbt3q+aHmiKQty8BFnhAPYjfkBFeOXwdwVBXfXE
   YZCn7UQS62RVbkOhoJwiugfi7E+HnfQohNBouBY6qcIPFor2wgPzCctQp
   7l9n8MT/Xp3pxci4Dpn4yN8jVLK7w0NGTtB3u7njr39GMPyxBHgw5fQRz
   VE7nK7EGcV4EmYpu2KMVMfVz9p5hVuztEyYx5C9hcNqwA/iDDEMhZHSCY
   Q==;
X-CSE-ConnectionGUID: aqg/YT3GRY29iqxd6TRxeQ==
X-CSE-MsgGUID: c9mqFU19RIqe/y93DK/pag==
X-IronPort-AV: E=Sophos;i="6.03,280,1694707200"; 
   d="scan'208";a="1521093"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2023 15:35:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRx4wcKs78n13Ey9KHOnEPHTZIsmTAQG4t3iasAXa4DrC2mfrBojgDeI4oNndemlEpbOH2Hqw+kvNYLjE5dG+DdH4gqiIosYYThK/YJvL75P2Yb7vr5pil2nMIZryeTJeyr76oBl+hrQhIB+XiK09YRtvwjjDjMkyktzFT0ql6QRpaD9I1nNE5a/WlU6E7TEBsaThvire7nXChDgWwd8MhJ7v4IXO5R9X9EsfdDaAbSh6nC9hD31+PVA/hxufCLi4DdFkCZjyVN/3Y0QK3hI43GeM4Hl4yyq+0ulJfwAkQ3V+OcAxaHdIdN7ZmFU0h2ofOzwY0KavCoPbUJF1/6nQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JZju58wqd8AUtu6q+CL0LMRG/v2tn0lE+51K3IvlLE=;
 b=laA2NMoCAw99Wmo9CGLGREO8Qd6vxG4eGqaplhFmNa+lTaVi4pS2THA8xbtfamxdCy0kCw6qN8crWprDx+l/zXEKLMnCjLLfZ3KnDDtFE0FaVxMmZCjmCdPub27ZsUkggRXvy4GKRp1kU2Jefr2otxPIYmY3pwJr8iGJYBn8tXCOhxYTQxjlaKa19GIuNBIlf4ykwO/0S/znxgqcRvSfwdZ37DStsDykBLOr8RwrpCTNhB8sQuedXhU7cXzDPtT5I1DONJCizKFeVKYT8Q1q3y4l3L6C1W3vmdzYyA/57sCOrBuJG7+1Q5mViReneiyJ993mJuYA/s2bHBKoSwMkyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JZju58wqd8AUtu6q+CL0LMRG/v2tn0lE+51K3IvlLE=;
 b=QBwihh2k7r5Gf63A7bNdF1rACIfxMjqc16BrV1G1l68+iedjj/UCqiOzl47YqveNKezKyDhah8FMWHodD2KhxXtYjzR9kESgIZn7azVOrS6qyXahT/noPrfzjlRF69p+Rts47BPqUhyUEfpD2tPSjV9i2xCd6u+8C05hs43lmdM=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN8PR04MB6337.namprd04.prod.outlook.com (2603:10b6:408:dd::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Mon, 6 Nov 2023 07:35:38 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd%5]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 07:35:38 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?iso-8859-2?Q?Kornel_Dul=EAba?= <korneld@chromium.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Bhavya Kapoor <b-kapoor@ti.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Thierry Reding <thierry.reding@gmail.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 3/6] mmc: block: Be sure to wait while busy in CQE
 error recovery
Thread-Topic: [PATCH V2 3/6] mmc: block: Be sure to wait while busy in CQE
 error recovery
Thread-Index: AQHaDjLdE0xH2Uhog0iwIpZyoLJPK7Bs6xkQ
Date:   Mon, 6 Nov 2023 07:35:38 +0000
Message-ID: <DM6PR04MB65755BEC314408279FC4A6D5FCAAA@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231103084720.6886-1-adrian.hunter@intel.com>
 <20231103084720.6886-4-adrian.hunter@intel.com>
In-Reply-To: <20231103084720.6886-4-adrian.hunter@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN8PR04MB6337:EE_
x-ms-office365-filtering-correlation-id: de72cd37-e35d-4045-cedc-08dbde9af8af
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 23mSzZQGPd4y3VbcRcCiF4mn+4SCFcBiOv0IWDPhp397jcysRGoDZ1i+y4WB7gQM3AgS8tySPbPQVU0BCbYF/46d6vym3f7M64g4sGJj5/ugePAW3C+VxJmw/Ry95zowB2invfJZjiCpKCyqHtPz96AjYYBlT6jawjQxPRXpa544Cw5VGOu4qcZGR1QlyyI99aQvWQwqSrHOayXOud9TNA9HJ8RaIPwcFA6Wqn4dYBnYRHm62/FRNfmJPUKOc2QLHHMg9d/zNBBqnC2zMfF7vgChCiN4XGjtVVPXPeKNeWA82oxzP/oNb0/2ozDSnRhBQ3CXE/OH4fLdzLYczjf2Un5UPnbif4tSM2XHCOZ+RXsCTV0Rv/MuYxQvdXD8MrRYkcRnXGmPe36tWekE+Of7QMevPnVsFqIPYN1npalp+SnWnv3eIbypDVh38CbAZhYjSs/AWNNEyk7bBl03Gt8roD9QQLz8YRbKWhfuhJieyW06tlQXl6FnG5le+GCZdCOc9kChLLv1L0ma2yP+RbDAzAjS00zE6kV5jZz7H1CT1nT3FHCTu3TlLuaa6uIoPrOXMHft4G/jmleXNhCHJCMKqTmeqE0cnYA2kcR1ACu26qHJChgVmRutWOrfcwl1CwTX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(4326008)(8676002)(8936002)(41300700001)(2906002)(38100700002)(5660300002)(55016003)(66556008)(9686003)(33656002)(316002)(54906003)(64756008)(66476007)(66446008)(86362001)(7416002)(52536014)(4744005)(110136005)(76116006)(66946007)(83380400001)(26005)(82960400001)(38070700009)(122000001)(6506007)(478600001)(71200400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?kQeByKc57RrwI0dIOub6Rpm8ZS3wSC5fbmvUQRgUYxskO3bZ6H8FipQpBM?=
 =?iso-8859-2?Q?HO/PvfAqxyT6tMjAm3qxrcxtmToV8XUTYJKswcZWoYjdeMwWVMvaq4dKYK?=
 =?iso-8859-2?Q?0rYLSiIW4nv+DujS/ASMSVfTqmF4RTjezPLJaXeKv6fuzCgAhhSDrXmvqR?=
 =?iso-8859-2?Q?P6gQlarSCDre0+yT2S43GtU6+Cifvkrd3lpbXfa07jm+j3rSPKlJIitiSN?=
 =?iso-8859-2?Q?Jzz3tUomrfsNUMwdwT84Mlhrlc1CH5nFlKtLYXfuAwjfREwL3HtQZ4KFvV?=
 =?iso-8859-2?Q?vHTmYJcYPCfV0FsA0w5nMkEXtlXjXgc9a5aRa6dCLxn8ZRnHDEnTuxAj2J?=
 =?iso-8859-2?Q?FZuGua1yMT9glBO/swBb1lD2vTikUMFDOs8UiL1tw6tw0TkAkULW5iqxs4?=
 =?iso-8859-2?Q?W4+GQXQJAXNzzB2iRJaCAUpF8Sd84KqqmYU5wjass49yQqgdiJoMvNAoqH?=
 =?iso-8859-2?Q?b3ldEMtpuQAoaWxezFuBSH0WC6BvyHCy7Vn6FNdlit/+MhJo8AKQRxiitJ?=
 =?iso-8859-2?Q?8IEmOQVOiyb2dJHs/MLCtRrGpPUe2D9TZeyKgzxHEgXokPGY7WdfgqQgkx?=
 =?iso-8859-2?Q?MirfL7Oh5DQ0Pvgsf8Ceqqaw2NFrbyrtE1zDfREGVGulnIvly1McFIZztf?=
 =?iso-8859-2?Q?lIkgZ9XlWfjyylnHOIvc/iobsynhs9/O4o79kdwapZbIoKEd3c8UiRKgjO?=
 =?iso-8859-2?Q?Q6kzcyZTDn+Pz1rLomnQxQSY6ju90DM+ptQVmzXZcTCxJNm0A4sKCgTuzO?=
 =?iso-8859-2?Q?yJhve0AsiBD+H1kn40II4iUQTrYEAv+dnDHEelH9M8vqUSR0eRTmpYr9aV?=
 =?iso-8859-2?Q?L9J5F2wBXkw29eaDiRHOGlM2i96boQgNibF2shfCgOG7bfH0s0d9KWyeXs?=
 =?iso-8859-2?Q?MTfYApqinzpalBVCEr/U8MHWwkF3esKkBxNFbTuDW5ce2V4xXrRGhvdwVF?=
 =?iso-8859-2?Q?rAtbaTB4N6D9/OT2KNUwipqiDjcJHFPLS0KfbAKMDCGerkHIy8gTm2S9A9?=
 =?iso-8859-2?Q?lRdV2fGl+5zHuYc+Xg0n0ib8NSvADCBcYWTZFXKzerVZgvUFSD8GrHKsyL?=
 =?iso-8859-2?Q?/PlbV1ITpDpYa7CXG/gjnSHyPfWoCb08IALAFjLnzUDbODKI7mt0FUxM5N?=
 =?iso-8859-2?Q?ILbbNOENWoaxCUhger38T7enRS03IKlgXLm1OFGnAmCx3CXA4RmPYs2EEo?=
 =?iso-8859-2?Q?rVEzFI8fA0kYtHppwH0czTPRRzv//hF16MwF7nK75BWZ/ppyxvZFngfzh3?=
 =?iso-8859-2?Q?ty7xOAsPoLaxq5xlD5YVrn+0YOnZV80ouofER4IcBPmgssn/JiXSQpIiDK?=
 =?iso-8859-2?Q?1gB7q/ZFzs2Mf2eIKsYcFIf/THxH8iRb8nAAgjBINjFGUzzIG8l28eqFzL?=
 =?iso-8859-2?Q?QDcqC3EC+OyihRxw+EnTZ93w1hGYVvVVwfxdOstQPRTgC1/Rg8iuBRd7QY?=
 =?iso-8859-2?Q?AO2Vy2TyAY7ZDvDvAH9bTDftp7Hs61L6x1NqoB5x8/2HyBsUwQSbhlGQ8d?=
 =?iso-8859-2?Q?9AokApuAi3X0b3tpiqJQZuSjY2fD4OVwnEUUf40wMooPV1l/xsui2TXMnH?=
 =?iso-8859-2?Q?AIp+o8nc0Zos1HdekvlM3+DpIYSeU+6ZTxdJBkto+JUJS/tpYFF7P8YAAh?=
 =?iso-8859-2?Q?Fxhfvf+t5ZofUNRr3fuWDOvwotN2ETbQO8?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-2?Q?vIOnzKSGqPS/JdfA1YxEsgPubXktgYW7Ya4FYBODhYFXpFkimadlAIkYmd?=
 =?iso-8859-2?Q?pYM+WXO7lHy/QsHt+AlfNHcY49mYrI0+snpSTOl2wEF9Vr8V/2KpRb8o9a?=
 =?iso-8859-2?Q?KRnWyh2E7jnoyaIMDXSF/WpLVXTyAujtXUA7Hcp/MwM/QFOUU+jxTayF8a?=
 =?iso-8859-2?Q?on5cxlt5uj6WDe9DEnBFgyAA9v1JYN/xRl4NifVu6ikRWhHm3g4c60XQdM?=
 =?iso-8859-2?Q?tnd46wW+8g2EAThVm+4cQvzq2fLq9rTRzwAVxxkfUkSLWdDMWD7FOcehvK?=
 =?iso-8859-2?Q?hHnoehwk6MZtK1/idhnpMIbpMvvtZM2IH8dN1bQXyZCs+ZtOH4dJ9CCdFm?=
 =?iso-8859-2?Q?lt5QfAp6FO+kyz8d0yTPn15fhZB01WuHBApohn1IjmJTXJzDVTPlN/mGBL?=
 =?iso-8859-2?Q?YYTZknjpR1WF9ZEIPJ6ZUL1ZCwIGcncwl+1vYsVLrNWtisV2vZrzQeclfl?=
 =?iso-8859-2?Q?3jinTkM0oec/arEtADLM9nDww++9ZCZbsplB6swk4qGV9sJKFMCCDsnOrW?=
 =?iso-8859-2?Q?VdvyQhQvEhK1p/MiCZr0FuVJz5WAQIg0f9AgZGCAtljmhc85uD98KI2gO3?=
 =?iso-8859-2?Q?LKOPxfgLKP2FfI/Luj62jzssJ9iw8ZEizRppNPnJuWhkG8vCcf2YzxM1+f?=
 =?iso-8859-2?Q?Tvwc40ZTNDkhtjC+amqcGqwDL2RH/L8XGaQBjPwYlhojGHPwOxulgd9hvE?=
 =?iso-8859-2?Q?jD9EyuNWsSZIcLUZtpTqYctISaSiMahq1EHR0iZotBpon73n9zP7pEeDSG?=
 =?iso-8859-2?Q?BJLyeLxoHRh5gY2Z0oLIpAKLC9lQ+mZY7Lb19EmvTX/Qc3i/7XfR06wVLV?=
 =?iso-8859-2?Q?z3GPt+FLht51xD/FYl/Go938ZFZdJf47Pa4CqFd4fRTbbe9OzdA/w9l6tT?=
 =?iso-8859-2?Q?UldunWrz09TEsxe9KqbQc2+AUGYke5jLNhth2tHR+cY3/CkcwPokC2N5rs?=
 =?iso-8859-2?Q?cNGcgIdcgOy1nfT/sK+C/9bKdMEKZQBmtKk0njpktxDM7391Vl0qR/HM/H?=
 =?iso-8859-2?Q?+3FsfXXo6pOvlZ33FISAxPCtGFLE05JxaMV+DM8ATl92OXokwn9DJ8sAYt?=
 =?iso-8859-2?Q?lwS+Rtg9BlzORfYzMnofpMj7R3KBCQtkIiIbnDVxIU4OiniK+yspAdr077?=
 =?iso-8859-2?Q?PqFGuTglKFA6z3QjUz0G5N3cEgV4cEkc+lPeYTV5TrnGkO8Ydabt9IVNBP?=
 =?iso-8859-2?Q?uI6T0J/1I3b+2h4dWVd9FXCdmd1djuvFimM=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de72cd37-e35d-4045-cedc-08dbde9af8af
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 07:35:38.1552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aa3MeDC27Aw21g3iwlzcQAQUAmHtYp2CZs43JVcbH2SGgjPAy6i7mOBE10uLfS89f38OiDXZ7fNrzAHWL+jbsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6337
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> STOP command does not guarantee to wait while busy, but subsequent
> command MMC_CMDQ_TASK_MGMT to discard the queue will fail if the
> card is busy, so be sure to wait by employing mmc_poll_for_busy().
>=20
> Fixes: 72a5af554df8 ("mmc: core: Add support for handling CQE requests")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
>  drivers/mmc/core/core.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
> 3d3e0ca52614..befde2bd26d3 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -553,6 +553,8 @@ int mmc_cqe_recovery(struct mmc_host *host)
>         cmd.busy_timeout =3D MMC_CQE_RECOVERY_TIMEOUT;
>         mmc_wait_for_cmd(host, &cmd, 0);
>=20
> +       mmc_poll_for_busy(host->card, MMC_CQE_RECOVERY_TIMEOUT,
> true,
> + MMC_BUSY_IO);
> +
>         memset(&cmd, 0, sizeof(cmd));
>         cmd.opcode       =3D MMC_CMDQ_TASK_MGMT;
>         cmd.arg          =3D 1; /* Discard entire queue */
> --
> 2.34.1

