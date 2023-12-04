Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCFE8033A6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344163AbjLDM7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344110AbjLDM7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:59:05 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527B5A7;
        Mon,  4 Dec 2023 04:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701694752; x=1733230752;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/zI/ygfzuHjna9/VtQgmuvg+f2yn7Ij1hV+EaFkWx8M=;
  b=dI7TRe9iQJaM/NsI6C0xr9gNhu9o3dkqgLEf7uzwGSMD9WFhTjPc+BXx
   MN5bKDjlhIMFdkCj71mbe8nfOMwPLEyXRCsmjKH8Oh8+VApqGkeZyOyOj
   Zvpb496Qr/tvZJEhaGPT3nxvHDUmRePrJMcikX4ajXc+sOs9dL0MWL981
   DbRGt6xZxdHwlc6aQvUFnqrIPD/h71r/3zwzK5I3qGl6m+jLmt1MrL1GC
   vL2/nLV7aNGvAeLNY6JsMSmoZvRX6fozHBPdKcWjitqjsAovuHuZZPVPG
   WbjzZIO/v2byVM1K7NchaRkj5GI1Emk575KwfMdnGm7t8Nz3mW8qqjmtB
   A==;
X-CSE-ConnectionGUID: hGBcQZleTSOyIku/+VyL4Q==
X-CSE-MsgGUID: LWbawB0XTiajxDMPlHJpOQ==
X-IronPort-AV: E=Sophos;i="6.04,249,1695657600"; 
   d="scan'208";a="4139811"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2023 20:59:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myPh1awNAAYNHH2UTPheq5M/bK0n0rwQGx3nH4sw9sSiwUwj2NqotClMPDetn2Jj1LLpyVjOsR47PshXTEhCjA+PV9coCKF1ilDAsz+1ACBkfdsqxKzHI3Qn7e0unNQzoenPf3yJoHzZ60kW+gzhOI6EATX34z6Ii3qXLmxUpp77spwFP2Vp5Gjx40wMEWVm3ngXtdLk07Fbjid1CuHzDVCrimtozy+wbkifBf7i/KJbiligJGETdqyAws1qolW1T5rjSIOFGDX+I7HmRaUjLtaXNEUIx9MUsJY8S99Svx7y2yUfYcK1X9jdwGROLzabjAMtBunDQ1e3DVh3QwUtsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zI/ygfzuHjna9/VtQgmuvg+f2yn7Ij1hV+EaFkWx8M=;
 b=lqisASs4cF/ZEAwT2fQ8EbOoaXAWCoa83GWV7jUENRGk9KDuP5nEh+7jPyIb4HYQdXwlLvyfYbiUdl75DIIvlOnlFwHKFMmMCDc0/H4WRpjwKnYMN8x42WxZvWQ9a3oH790IXwpbPX/z+kDoI/G6dMFz5Gj1fPv3AR+reuddrPgoeuTmWHht6OY8sfyySp+/nRInJdls7AqdpFiNAYjx1yyMZ+F/0s7452+BrebTbH0Dq4hW2MfKOLkFearpBIKKsxZg//O+lEkic9TZv5aibT5am8ShQ2uAKCN81sqBR4lz1RZBWcIRGpyvQ9PZmbFj43qCHVy5IgMJZ2Hz8nHAuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zI/ygfzuHjna9/VtQgmuvg+f2yn7Ij1hV+EaFkWx8M=;
 b=vmQ6Py7sMPyzMCBkAwIL2pqHkM5wjBBc9xb8LRgfdB3yeTqCA5jSExH4E+H63672sWyw+yLnl2ifQfoH1VmseovpEuXFROcIuZTdFT52sAnT5LQaRl0QWF6qzc6WZ5KMgxeK4SIx9PDjzWphQgkdWRcR5R50ZxWNXKVJtctgBZs=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CYYPR04MB8839.namprd04.prod.outlook.com (2603:10b6:930:c5::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.33; Mon, 4 Dec 2023 12:59:08 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4%6]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 12:59:08 +0000
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
Thread-Index: AQHaIt3uugCp9rO7UEO94df443a6MrCSq88AgAAvjgCAAGE4AIAAL3CAgAAE5ICAAJy6AIAARKeAgABFQgCAABTwAIABhBXQgAGUvgCAATXMcIAAIeqg
Date:   Mon, 4 Dec 2023 12:59:07 +0000
Message-ID: <DM6PR04MB6575127DFCEC4C178F7E33B7FC86A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <CAPDyKFpg+7W1ODGHw5oXy_wzWA1Qqzg9w_12rhQ8qW4o--6dWg@mail.gmail.com>
 <ZWiNDgUFF8ug7gZf@trax> <fbc82848-d402-4075-8176-de9ed0345d78@intel.com>
 <ZWkGZ7av1S4Clwdv@trax> <ZWkKgU+J9atnJdqT@trax> <ZWmN+k+wUWcXT5ID@trax>
 <fecd033b-b2ea-4906-a320-22a5c2ede46c@intel.com> <ZWoBqs/5m6tCuBGo@trax>
 <ZWoTOm+8Y75TLz6q@trax>
 <DM6PR04MB6575FF9532A9FC0EE91B5B37FC80A@DM6PR04MB6575.namprd04.prod.outlook.com>
 <ZWysTPapFyGJdu5d@trax>
 <DM6PR04MB6575F9EB1C3309F64EEE6BCCFC86A@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575F9EB1C3309F64EEE6BCCFC86A@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CYYPR04MB8839:EE_
x-ms-office365-filtering-correlation-id: ba691b2c-9f47-406a-7fb3-08dbf4c8cd66
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qi5KFoRZvNKXHBpjnyTccDyuFWsCCzE67ZT+GKKmSZG569c/QHgQ8B0nkJRkwNuXYhAjkkcA/f8QFbB7t7ZEP1KszP4b62lXDeSxKRbNEWKyq2v5yFd6xb2cQ109EupKNj7SyDOtXsrZoNV9acPM11vvBEuLtxv8n6euPJ3NeiPEHRmQKUeQ66ULyBp2YPXTZRvKgytcakUc1FsoZl9SnsOtFNwOBFi+ZhnW2U9q7XcCfDsC789avI2BUs7Qi2IcNfWo37CDciwFoEJVoGpDwuh5wuuzjD8+w2dCWjbywCn+13JE0az/gnrgaBEil+mYDze8qaKaxvU5PDJrHeN99JMTNuFdcHzeee8CU1cJnm9q8eC1t+31TaP+BsK8/Wj6ljap/dGMIHRW+i5QqnMOFM3tyltaJCU4I+OvFBn0yaCjpZCzrFIV/FqzPwMTunJuSkmatQcAjMxSCRtJ1e0R9Nc7jSsdEei7FIpgdi6p39m4WgeS/QEYVmjUwKAl+BEgpUESh+DPrAjZcsHvD4xdcEkWYeSYdjoHgBr007sKWyXHgIwdkzCg493fvH2Bn29QUZ5HnFCJo2OdI+XHXjNxTnDnD23I6HXn4vOx7yMYEKRT55oUd7ucSc48vrrqnzNn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2940100002)(6506007)(7696005)(52536014)(82960400001)(9686003)(478600001)(26005)(83380400001)(55016003)(71200400001)(6916009)(66476007)(76116006)(66946007)(66446008)(316002)(66556008)(64756008)(54906003)(38070700009)(33656002)(86362001)(5660300002)(41300700001)(8676002)(8936002)(4326008)(122000001)(38100700002)(4744005)(7416002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XHJh68JEqeo1tIyFjbW5FgNe1rtmNEfdrB8Zf8zmFFSvVe2NA2brhKTWh2Vx?=
 =?us-ascii?Q?yHqtEIRFIF1iFFrP40vDlckk4M5l4HtxcTK1xEFbfkHFjQ45HGIx4eVb5ZpR?=
 =?us-ascii?Q?5mzZvVoJnupGSvcvmISkPru9QPR5GleoHR21p/+KHwIbFLBWiRzYPZLDPUjE?=
 =?us-ascii?Q?szGV8ZaCLA68qkfnTp/2ZK8SN8JLWBV2G9BcH/s4yIpOq3z/0efb79xG0Ob+?=
 =?us-ascii?Q?LIIfZ3et2RcBf60ERnsZ/4uNEIyq8kpM/nV84VqQPArL/YURBz341lJcIOHl?=
 =?us-ascii?Q?mwNdBl+HWSe1Qfufr30BH1zReTES9CH+V9w3X/crt5xJAau3nocuL864+SAV?=
 =?us-ascii?Q?nzbrsvRSkPKN0gtsPkcts59GRnnIoosaHS6Up0B6NMNXw/FuChcKKQyxpxM1?=
 =?us-ascii?Q?V1iYKnv2D/I7nE/dBFkgb+C7vhSs8odtWplkxq+CXSsyY3z559WfqQKnWcth?=
 =?us-ascii?Q?mxnVjLW/FgueU451HtWxBic9oYt1eIge1NmJxW6K+jNdImBGsFnL7HvjEfG4?=
 =?us-ascii?Q?JHvlHPDcmoewuHnvgq32IdGqCwPs1A/ZulQe5d/3544AbVeJUXHEbXZ/cpsw?=
 =?us-ascii?Q?IbxQ/wRRCeXe9EObnLMFzeK9KuxiI/IkunfjSAoTGc1Ly/65QGxBzJ5+UZ8C?=
 =?us-ascii?Q?UeUmFuJ+FTrVsauGPdfV24KuIvcyTudaMNVE3JN5TDjBZEeTnt5Xj2Mo1PmG?=
 =?us-ascii?Q?Pz+R5TLis6hohAx7oOEGyIz0RfSE6aBGmuhICEj+cvWmglBB01SpW8SahYA0?=
 =?us-ascii?Q?PSxOq2cmQLEwV/qBSydG/EgQmPbxHgxG0RmH07N81l2uQjesljhOXQw2VF6x?=
 =?us-ascii?Q?NAgcuDCepF01fvUaSNI5xmljjTA+5isOKtGrwrv35Dm4USf4V1ttNpZEFSVX?=
 =?us-ascii?Q?OzD5+E8IDjQSROZrA19ClIflemtCZgwxB2NhgBaN7EZ80PvqFd1g6edU+ZYM?=
 =?us-ascii?Q?69xahfBlMBfOf+iscApFDyXcOUmuLqGtMrRTlawmFxFamXryZwZ4HfdEMMF8?=
 =?us-ascii?Q?KnzlhDBmHMdiuhOBTiRyixuqSjTn9X2e/eeiA1rbg6SnToaXTfC60uBSU3sc?=
 =?us-ascii?Q?dybZgkgmkPF8bLDhbhtg8tDAse/yOZSPIflCLf+Cu5sgqPZ9A36HPviEDCIX?=
 =?us-ascii?Q?GlZr1+xVP79meQ0g51cSn6pY7U3MzGWEG9+U16MF0EJ4I5+o18jh4Dxt5R8n?=
 =?us-ascii?Q?U77GfZF4vzknz80jZdcpwl/9lhv0XPD6on4tEPU4vmlgmp7OaDbHH6h0uxBv?=
 =?us-ascii?Q?/vKd0cE9vkuBtV5molhcKlRARCetDxCVrKMWdLlyLP10jgpeaSe716ZcKb7m?=
 =?us-ascii?Q?j+v6pRsAR4waQB86pLG432RheVampv1LJDMcEMcyOHErEWyYjt94CXWSseKu?=
 =?us-ascii?Q?ijL+rSNeSY4WDuTgkdj0+pQjLAFS7NoQEB3YgGNlAcLXztODtva2RHxmIiPV?=
 =?us-ascii?Q?tQQvpoExYEZxipYAtktvKUC1ngCTQDzs2W1BR+N3BXVmYrxTr+OwTucclTg2?=
 =?us-ascii?Q?3QyuZUkz48Mr9HKpTpk36BlM7xG72MW7vmJjGjVd3Q3Mwsx0fnD5fqSUtWky?=
 =?us-ascii?Q?9hR4ddyHq1W7jTVX0qSQveC/lB53CH9zxIR+QqRu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?77ufWtvHr4JxP2jkNn5hoa3mUP++m1sjOS7pciUNcrbDdRj0IavVjh5DcC4U?=
 =?us-ascii?Q?NncgMI/1ScEme5/WXL45F44F6gc7iG4wdgFLijiaxsLSLVJ+KiXfzJ3TX7hQ?=
 =?us-ascii?Q?06rmONbYUdTNeIR7oyG+3YLrub5TirmAQUP68dFKWiwrJvYM0Myr9VeS7rJz?=
 =?us-ascii?Q?6Pc3uCjlv+iII9+KSOG2XW4lF6i4kztQKAPAJv30Z//djYcnmN/gcTF8OP8D?=
 =?us-ascii?Q?nsHpWfFLwSTI1WIJzSYIOjOmuZHH7+poRTwYOKcrGf/ywkLLP4+Y2ouCH9eE?=
 =?us-ascii?Q?BYKWfC8HRE/dw3zxlETV0srghONBwJ3EqS8JJZzcUhyt3Pufo6dV25DqP/EI?=
 =?us-ascii?Q?tjVIOPmdp6uKmx803qMpifv9MjXYS8vuYd3c2F1Zain2a343/t/bPoofE9Tb?=
 =?us-ascii?Q?meAuBJptytet+3e6KkfWyxZDNoUsncv98o/xPR1Xd95TrgjH+fs+PPkV4L5+?=
 =?us-ascii?Q?4O0ne6lSDdBGH2sb5j95PGTE9BEoCwwYmUn6ZTCoQ8jz+OgtejCraTZ2hxAh?=
 =?us-ascii?Q?8uugfjz1fzVVmMzqEQsxbNkuH5Mp+10kVhM4THNwLkxZtqKpcqtpKZx3BclZ?=
 =?us-ascii?Q?xW+Lz8JpoZLFdEjLR4RBJ+MsElgGMekPYvNf4SiHaEGgI7Ke5e0T+KYh1nez?=
 =?us-ascii?Q?WN5ALy+daJKM6LCEpNk0AOhUfUe80BpccOsf+qDCoqy7iAGWTsaMP9rvUsu+?=
 =?us-ascii?Q?uxCOr3uT2KN2xWIGVoJ/n0V4DxCkpO2ZYWjZ64WKC6gC2SbDiys/P+701L1h?=
 =?us-ascii?Q?SSI6csxI58ePczSBP3Oxd4QvB/QjResar6owkIwHwBmhnRCF2b0WB32rdFnI?=
 =?us-ascii?Q?QZi6fQq8tpQoRo3AUn4SFADWNyod4zSr2VkGZV396al3POA8gPTAhQAxKEO5?=
 =?us-ascii?Q?l2zGyv1fEbqeJYpH+i+I2924VFoV7nRMo3k3nKQSLY7JNhrTj8xKlr4dlFTQ?=
 =?us-ascii?Q?S5+AgTFLOgyEo9+zVul3Pa6YqG8FNB3yKA7DMXtLNHyAo4ZSjWIV0B72R5e3?=
 =?us-ascii?Q?fiPrty0wOilYrslJdaRHycTOxnmgIBlfyD6SCnB2mF8D+2qoeaGyEzAlp7on?=
 =?us-ascii?Q?1KovYjyOAz7v5GVMC3SD6b58BRfiJSiXhWE14tbIszcvTQq5TJqba40TliAV?=
 =?us-ascii?Q?6eQYy8XJzMAqf9K0SN3BWplG7roNSQDBxzhDvAiqePOJn1FE709i1ZA=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba691b2c-9f47-406a-7fb3-08dbf4c8cd66
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 12:59:07.9450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a5uwZLLv5tFTMjA7l3aQ6Kxj5C7s7XPyi6R7/fSJy0KNnBkN4X4TM/d5NxM7hQo3owkgQSlA3hMgWlZLUDgk9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB8839
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > We could carry the patch internally (it seems harmless after all the
> > testing
> > done) but I'd much rather land it upstream if possible.
> Agreed.
Also, I am totally fine, and maybe it's even better, with adding this as a =
default behavior for all vendors.
I see no point in those tunings while accessing rpmb anyway.

Thanks,
Avri

>=20
> Thanks,
> Avri
> >
> > >
> > > Thanks a lot for fixing this,
> > > Avri
> >
> > thanks everyone for the support.
> >
> > >
> > > (btw - yes - our manufacturer id is 0x45 - it is set differently in
> > > the mmc driver for historic reasons - Thank you for adding this.)
> > >
> > > >
> > > >
> > > > >
> > > > > >
> > > >
> > >
