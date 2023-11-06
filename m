Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBBC7E1B56
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 08:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjKFHht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 02:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjKFHhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 02:37:42 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F28CD69;
        Sun,  5 Nov 2023 23:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699256259; x=1730792259;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qo+O2yjj4SEnS0kzerSsgzF/xPaRnYPmMnDM4simOWM=;
  b=igIc/3ONb7MxUVDIN5yAnT7pVkgtLHDj3fIQQCpaZeO4GQHnTTP5Lxm3
   p3RtQohFZwurbpwgvSOKyKoX7WHRpBDCBg2JJ5vpFoxpeujwWdWR1m4qc
   7BxIYmZG8JxEJr2DXMF/t/xNrgL48WlQGymzyU3K3DK3T54pt3cEjx9s3
   pl4FLA8PcbuSO8F1S9XPyKqWrVbGqeKlO1nMQM4DmcwfqafN5JT6n6dGe
   Z2oM9AHuf3spLt4Bt5jpSzsgg9xRfHenCtxexv4GWJ4gIHWtY8zlkj0hT
   G1BYMUrAOQIhe36kqvDiXxmploCcm3ot5fsp7tRgRc/slYUrF3TAFR9UQ
   g==;
X-CSE-ConnectionGUID: WKuwBHOoSbaTD/otpRO6JQ==
X-CSE-MsgGUID: GbA3J9d+RKyAIgBGNUnoSA==
X-IronPort-AV: E=Sophos;i="6.03,280,1694707200"; 
   d="scan'208";a="1617455"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2023 15:37:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYp/nMmsTISwPg+JJs42pR8Jej++36luX820h//cJg5ICi5MIrP80BINSErZfhaokNBCL3HtUNBoEhwUAqV0rWna/xgPAEuX5/8jDohko+NPmDbCJE1wpdrucmLHBcRA5zQDKOqnJ3LngzaxMFEWL4XXdvxkykINu4kxPhW7Qf1Xyfl0PsOnvPkqncdWBHwX+NIBPbjz1m72Z3hmJHL+PX5AvC+tejyYMVBeOtgjsqICdo1K7vzcLFcTuIrkZ79/dslu9bTuDWf6tZV165revwH+12Q1/li5Ivi7dVaiBxlxWMznf3ieTyiSE1GAAwooVZ6ogrD+cQZte/BHAVTjmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31k0HhUfy57k5KNwd6d9o5cHdMYHj7LW7ENwZP+mNak=;
 b=DU55H5sylDeH1tbRlgtdUjW+QM/yjZ3N2Yy4MCnd4pggnZA4SzGKKzaporUbrgTX829brhCUIrtrOBlt8qors8Cq3Fn4INKqboh63qcpdXE/dy3b4l8QXAIOgkcNxXWPb2GecLs/Jx9Bllu+Tl+ivG2CSY+0LnM5Z6rhpnFL+eBAqs6MGskBCQ23FyWATTNGBtCvae10Vw2Z4SAwugb9O/SqOfTJ3TdfubhAqvfbzxSghpIGzNw9B81gdlNoalSSmEsoFxA5cSmyz+b+iqPRVmuf9VZew2tVa/7omaipydwJJ197p3tKAIG+UW00+ItpkqAwEDpDyuFveuMzHoIzcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31k0HhUfy57k5KNwd6d9o5cHdMYHj7LW7ENwZP+mNak=;
 b=uNiaZUSDfFrQP8bPW50M0gQD3UNakHfhJl90IkFy41Vp6FazLVNAXzYBD8PPQHhLZEysIZguucEkEiV4DXILTc5pvypziFBRxpcRHZre1NGAx3chN2Y9qUS7o3hEJW5MdyUxSeiD3L3KDv68rK3unSbPoOsPYnEDgeaR9bgs5lk=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN8PR04MB6337.namprd04.prod.outlook.com (2603:10b6:408:dd::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Mon, 6 Nov 2023 07:37:33 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd%5]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 07:37:33 +0000
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
Subject: RE: [PATCH V2 4/6] mmc: block: Retry commands in CQE error recovery
Thread-Topic: [PATCH V2 4/6] mmc: block: Retry commands in CQE error recovery
Thread-Index: AQHaDjLaTo9YqQ/5n0yX0FBiNZ7vjbBs66XQ
Date:   Mon, 6 Nov 2023 07:37:33 +0000
Message-ID: <DM6PR04MB6575383D23F5FC567D4A69CCFCAAA@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231103084720.6886-1-adrian.hunter@intel.com>
 <20231103084720.6886-5-adrian.hunter@intel.com>
In-Reply-To: <20231103084720.6886-5-adrian.hunter@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN8PR04MB6337:EE_
x-ms-office365-filtering-correlation-id: ee3eec37-e3e5-4405-30a7-08dbde9b3d70
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U5hhr9+rKKwuvigvQ0Saw01D7i73wxwLdGqS7jwRmSp1NTVynt9OSb8sEp+H26n17qk595WxJ5fhLjJDIlAEkAu85lgssMORA7FFSejd2X2rbUL08oQhILQYiOPODnQRKOSrNRcdvALX4ViDdCM+kkV5PJd59GLD7iw/KqW7HtknAiw6oJ7+lHUzFHxAKWXFf4KhQjdmzLcmaOUHQjeLp0n5Ag6gGjuLHFJkN44iHKIBYZNnZCcl1qKrV2Y9WHFRxZVE9qEXKVHI9U6WXiCZbqjvqM5t2TCLbh3wTekRC5fgTKYtm6c7vknD3W+aKqq5svvlTUFpQTHP3XoVFpNwi2Su4OVDfvnP/KTfXY2SHD8Bw+ALLSkzyFwaN+O/rjWWcZHw33f9DjWigIXU0sqTWr/9XtILEHcFmLJNkRwK6Z5bLlfrILuy/7eFS68WO4dhSSJoj8NDQA187k/y5CpdjzIOeQkA3WAC7wFe/bR++LSh3O9lXVPpKZkUzZ9ZSjzgtiSIml4ZNJoyrSUNQ7jPlPDYCqQXJuERMCjJ+tnm3ih63rGiOnsJcVWy2jCyr8zfpfp/EKLDpyVn5mUsCjpM8iqOE+t6IlDTmz9mTV1aYBHWC3E1DklIxvVy7oGQ29a6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(4326008)(8676002)(8936002)(41300700001)(2906002)(38100700002)(5660300002)(55016003)(66556008)(9686003)(33656002)(316002)(54906003)(64756008)(66476007)(66446008)(86362001)(7416002)(52536014)(110136005)(76116006)(66946007)(83380400001)(26005)(82960400001)(38070700009)(122000001)(6506007)(478600001)(71200400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?DEXakv15ei6l6eD0EmEkqAXP4f7ICeYYxv4KY3pKN/YM8jWOsuY7UTTaED?=
 =?iso-8859-2?Q?d/8qB+WROPHOUpMwBt/AVLOK1GYwWqbvLZ851jsSW258r+e4TWzx5uSv98?=
 =?iso-8859-2?Q?u50oF0bqObOb4yU/2vd92UK7u06FKPdsJHDHBV3w/uhdlmeRIY1M8LyD4k?=
 =?iso-8859-2?Q?Oa6nzHJejzF/QjWtUUrklux2LcyvEeDeX3zKsA2N+A4o1blIk/xydjC3pa?=
 =?iso-8859-2?Q?DTsjNX2UtnFfqFnlQJH8tf5EAyWsLaB59JiM9YJGKbjlAXlFFLTZ/FpYh+?=
 =?iso-8859-2?Q?n4RhWLFv+uTcqsyJRu1GtINgLW/D4qSqCirZV7pscKlG1bQoD8iF1Wtk3b?=
 =?iso-8859-2?Q?kEJUSWOchB48l+4zTr+oS3Odbe+Wcz4bXIcr/JfEerMjQlo3xz5YbQ6+SD?=
 =?iso-8859-2?Q?gpRAoq+Q5c8IIocpllXtSxRCVedgP3J83LZ4R+fVyFsVgnXC/iT2SkrOyb?=
 =?iso-8859-2?Q?z5FFzC3Re5kvO0l/LBaN9JHApNkyDYTon1/HfwGU58K+PdJ1sfadGqKpDI?=
 =?iso-8859-2?Q?O3vjqFfmzZstg1yKECgjsRMdlyZ1H3ph/8g0V8ltzbHi5LZ0QCIXS2aU8W?=
 =?iso-8859-2?Q?TsCS3BdNfC6NsBltTCO78dNyvlLrPkunEAuqH4gQyrNqJ46RZsWXHyDRrV?=
 =?iso-8859-2?Q?ldYyImDExaFnn96NHRmFioVWifGNrE3pYMptNACbUqa4xPIzHbrTA/+sVA?=
 =?iso-8859-2?Q?n1n7XCSRayNOaRmSc+bFKANXElFBqQBFnUUEbNRzDJ+ctFPBfmpKlVlYHU?=
 =?iso-8859-2?Q?F9dJfu3mJW8M2EaOT5VRh7z9aKda8Ifjqzla53f7XUJ9uFVwhr+a+z12jV?=
 =?iso-8859-2?Q?VraCwXn44m3P9kUHe2FdVgLw326ji25CfFNm6XFAWAEqDC//ARw7nRDl9g?=
 =?iso-8859-2?Q?z/SigRX3YNZuhAlzPl/4uc1hAUmIYwNkcxnVZdKsfKuXbrJlbKuqQ+yGrC?=
 =?iso-8859-2?Q?D1uAXDsEvJBeMu7chhcOkKr2/lf9H/J+mCiXQXqgia8hf8qNjl6mgvSwww?=
 =?iso-8859-2?Q?kGRznAPITEQoAuZnSvTy3LKAMbdtJVt04KZrlg7xj6d4iyyQANaqt2PBE+?=
 =?iso-8859-2?Q?LPGizNxiunWL5aBxzr1ll8kQCEsLHaBvmFXaZj6p3UiHwcZCebKHg1c3Ih?=
 =?iso-8859-2?Q?K1zXKYRLUrsG9La1Ldb2k7k6AQuSiHtBFV1FNcujLtyhNav6cwQvAqvV5+?=
 =?iso-8859-2?Q?HUJmoTr0kpzBJO0LwbGWI2/cCc2gAkjk9VhoOf31KPiSn1grCQOwK70Oyf?=
 =?iso-8859-2?Q?UW03n67hvq2j559ATmLerkK77EwQa1OSwl60IIEjvH9jF7mMmzqk30NS/I?=
 =?iso-8859-2?Q?XjLLuhQeuTrgq5uCJbtjaAaZqpQNLouTez6m4d6KEiyMKbm694jIZOq6g2?=
 =?iso-8859-2?Q?lfl2b4Tc4xDw+AbuWx/NMQvBElitpyIWy2Vf1aX3MasUxNpJyzLwGbb+KO?=
 =?iso-8859-2?Q?nEbX9txcCZidPKXhZDss1FU9/+dhYXzOX5Ftk0bH21OoudoehJkGTHQvf6?=
 =?iso-8859-2?Q?7mSw7wIlHubuE16Fcm+ZlisGVYu3p6srzzeSoGVwiCnccoMoe5sO1n+cYK?=
 =?iso-8859-2?Q?L21ryjWgQiBZRHHdVY6J4TSdzzJ6i68VfwtY1hazwmPpDfaSj0N2VA+O75?=
 =?iso-8859-2?Q?KWLndHZB3lo3Kq7ofk6vI8ATIwg5bGZjrC?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-2?Q?pO5brDUL+Mk2f4fXfve8fGPDRPg8fT1hiVUejWsUfMGjeFbbDJvZRDP72B?=
 =?iso-8859-2?Q?9P6BlxzSsoh20vFooeDyy0wqTNNDGG/B/JH4ivW4TLTRJJb7jBYCdffCvw?=
 =?iso-8859-2?Q?pGQRwNBOVBN/olGRuDZD3GeaKuN3+gS0B5mxORZkrtV3n9GHLGI2BfYytq?=
 =?iso-8859-2?Q?xb7easAVClpJ//6P/5U7XuashpmmBgat2GACFhfZygaczFDb2tKpFTSiBr?=
 =?iso-8859-2?Q?Prw3sSQEmr63Y0AbBqUF6GPkolaWOeewrygoh7B+Qb+CnyNcXjooaXkXeA?=
 =?iso-8859-2?Q?Wb8wZ3lnqGW/Ga/6EqXfuxF2pIcYnDaUPj6kSx3vuN/xJOtpdOzb0Nx2td?=
 =?iso-8859-2?Q?0G1eW0eNRuZfJGGBygRUD3Vf1FPawoxw7hletZJbtNfwDYTJhdsSpwEghc?=
 =?iso-8859-2?Q?vgLG0wTmFgyJxS5o6vdcVOVBMmmpXqp4hYFwcwCJbbIYg4MPfDnyexHXTr?=
 =?iso-8859-2?Q?6WXKtGJNTX8uYlQrTger+v19yhy9aYDV6vuIrTsc5qBK10Ldw2XnJ3ahLx?=
 =?iso-8859-2?Q?dNJFfJx1nB23j/N0P7I2qhDq9/l6GDbnlaxkKPwghufKDjRvhwocY+near?=
 =?iso-8859-2?Q?NBnJ8ihrE+UqkYKBW/ri+DAcApD1Rd/bJK89IpOvlNl9eOFKUr6dcPlezr?=
 =?iso-8859-2?Q?mT5J2mh5TEtvfaeP7RPgqkxLKRU6R0rd4slFfBRCIhkghaGJY5/sKibbNb?=
 =?iso-8859-2?Q?uZz/AYCaMgva2RKD1kZYUvKgCgB8LCjzg9kows+Fno4EDTx3HVQye1GuiW?=
 =?iso-8859-2?Q?GVejEKXHcXyK5TuhrRaXsD5E9EJQf3hHZAAhZwMmHssOIBSHrvlCbtFGD7?=
 =?iso-8859-2?Q?2aWfCZWMVDGxIuGPHMZJQ9DOBdi5CwPzh2etDwPL7aTT6lEWd9Pt6p0oLg?=
 =?iso-8859-2?Q?KpJrYSt9sZjMoAEH+clEpb9WALpaqGP7Y3dwSfAUtoRUnKUAK2dZi4SH44?=
 =?iso-8859-2?Q?cyRmHXjem0GoqAW1KoQ+7EKodM98EriK7Ffgs5fRzFKprYW2f6YWTTRver?=
 =?iso-8859-2?Q?Nx3DC2/PltRpnIFmnqMhzfyzKsXfHq4//lzXCdxdzO85p+0vfevzBYFg7u?=
 =?iso-8859-2?Q?QPrMJ3XFongBjGGSVZOzYDvm6UbNrRpBz19FQ9KFq/sVILdnbcVm9Fc6S0?=
 =?iso-8859-2?Q?k6vLfE6wGZapP7t+Yc0hew7F4z4vWmfsCSlzGo2nIuZU4PjZJ8qIauHprR?=
 =?iso-8859-2?Q?V8oIIXIHTrLG4kFLRYKiEMhIqrvfjiSP+w4=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3eec37-e3e5-4405-30a7-08dbde9b3d70
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 07:37:33.4575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kVK5/b4XbmHw1YFkEz2gCaAxGGYnwpNLHSrtUIFP7DGMwyruhaFERAgEMh62OYiOXmhSuGMRiKEGI59aEStn9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6337
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It is important that MMC_CMDQ_TASK_MGMT command to discard the
> queue is successful because otherwise a subsequent reset might fail to fl=
ush
> the cache first.  Retry it and the previous STOP command.
>=20
> Fixes: 72a5af554df8 ("mmc: core: Add support for handling CQE requests")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
>  drivers/mmc/core/core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
> befde2bd26d3..a8c17b4cd737 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -551,7 +551,7 @@ int mmc_cqe_recovery(struct mmc_host *host)
>         cmd.flags        =3D MMC_RSP_R1B | MMC_CMD_AC;
>         cmd.flags       &=3D ~MMC_RSP_CRC; /* Ignore CRC */
>         cmd.busy_timeout =3D MMC_CQE_RECOVERY_TIMEOUT;
> -       mmc_wait_for_cmd(host, &cmd, 0);
> +       mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
>=20
>         mmc_poll_for_busy(host->card, MMC_CQE_RECOVERY_TIMEOUT, true,
> MMC_BUSY_IO);
>=20
> @@ -561,10 +561,13 @@ int mmc_cqe_recovery(struct mmc_host *host)
>         cmd.flags        =3D MMC_RSP_R1B | MMC_CMD_AC;
>         cmd.flags       &=3D ~MMC_RSP_CRC; /* Ignore CRC */
>         cmd.busy_timeout =3D MMC_CQE_RECOVERY_TIMEOUT;
> -       err =3D mmc_wait_for_cmd(host, &cmd, 0);
> +       err =3D mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
>=20
>         host->cqe_ops->cqe_recovery_finish(host);
>=20
> +       if (err)
> +               err =3D mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
> +
>         mmc_retune_release(host);
>=20
>         return err;
> --
> 2.34.1

