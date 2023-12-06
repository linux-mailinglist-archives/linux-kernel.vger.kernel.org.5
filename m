Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756B48078BE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442801AbjLFTi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379386AbjLFTiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:38:25 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFB8D4E;
        Wed,  6 Dec 2023 11:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701891511; x=1733427511;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nRkuQgFqUhM4/uY4tY7a/OECYfg9QhmHhM8v6NTus7w=;
  b=hho4eXj4sD/cLyvu0s7rtwI+xypzp8cTwqIi40BN5kLHT7RBRcmeCmjT
   o/jRmE4Z8HeVaLzfRtB/QjfidWs1AS8Zux9mdrWD6FWQ1KOr5qriHhKF2
   GArxWPtsdW0M0BVL8c42W89QivRvn4EOHdWhX832mgpLc4rWoDePvSgW4
   vWBjeMhWbozaE4B9K9QVtbMwCtL95bUEgTE8NXX7LRF82Wk45EBHBtff1
   P9fvo3aXlAhYb7rWvt8iA5jSNyLcppbgTCDQ5c+u0UHKnENKA/fLxiNMr
   IYVpkryHFDkUVioGCUeJxxaWi4u0mpV1uIJX3D1D23Y0mN3nBgS6JJkmo
   A==;
X-CSE-ConnectionGUID: eawEha00Ri2+tMH49KwXxA==
X-CSE-MsgGUID: 23231It1SjW9h7IDuDgCoA==
X-IronPort-AV: E=Sophos;i="6.04,256,1695657600"; 
   d="scan'208";a="4337500"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2023 03:38:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbYdg/4F/ei4kacMx1V0l6pKIMuCG9glHQjuNpBRyn1jDvidVUionGpC0tSAvGH2GMqtL2NA9d9DjXUGgI054MKWRVMBetHsjg0d8YPWpvTR+4xXWPLxIf//sCd5+pwr4w2x1LarU7RlXMvrUU93gq+OiVD7GDqmouTluxii8KydcTeyYX48Vgc00g159ZxkP40WEbO/HsSpRdFSYVKvdw7AYMz8vd9EDJ2BjEr46n3BUd5N30kUmZItSF4HNHiP2juNubTR+N/J/cZRIrsLexsCttQQflamIgJKTYeEqdOsbOe5qIH2JsTzYFSvpRULHFkBl7LAHZSqrdGT5HHhRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRkuQgFqUhM4/uY4tY7a/OECYfg9QhmHhM8v6NTus7w=;
 b=RNZtN91rttprIzjf4/WqyBexdMh0kZgLpbzD4wr5bPfJdCgM5yxRLrfxkjyKrfRg6FKyXHoWi0jULAvbCImrzZgY6OQpmXQ4TxVTYLQ82/veOzSfhuDl5mCjtJlWt77xAhXdhY894fbiDypZqWLIHi4rB1AgmjuK/PiGni3TKUiXK+ggGxx0HDjRqFxnIpKzHar5UqRefrf77wbNPRYZFxH56GBQBNu7iUsX21R+U5SKnOM1k2YRPs0guoAmgUXCDbAJc2H3LUcaAHidB/jdYZYSVP5TbA/6TQHl1+7yzk4bwv/NQ6hl6ODLvSfoIcQdKD+tiYrpmwCqmf5otKtPGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRkuQgFqUhM4/uY4tY7a/OECYfg9QhmHhM8v6NTus7w=;
 b=rGwZV7bacG4QcW7TsVJjGxLx+VXfRMfBOW8EEiYAiJK41kJeg5+kP/XU3B2CNow7LY0yWS2sJyOnHVf8qF/oUJboqhmibDUDlVF2y3lCET2ShU4l9yb6r3+3cOqL1+T+fu4a/k/azEH4Twbw2HfR+mMqbA2CZRIPnbDw6kTd5PI=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MW4PR04MB7140.namprd04.prod.outlook.com (2603:10b6:303:7e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.34; Wed, 6 Dec 2023 19:38:26 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4%6]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 19:38:26 +0000
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
Thread-Index: AQHaJTkKGJCMMiwoCEWzpUFDJD5+pLCcrOBA
Date:   Wed, 6 Dec 2023 19:38:26 +0000
Message-ID: <DM6PR04MB6575C233D314AF011D5008C0FC84A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231202160227.766529-1-beanhuo@iokpp.de>
 <20231202160227.766529-3-beanhuo@iokpp.de>
In-Reply-To: <20231202160227.766529-3-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|MW4PR04MB7140:EE_
x-ms-office365-filtering-correlation-id: 4015a4b5-aaaa-446d-1b20-08dbf692ea6b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 08AlysAe94KG0cccUGShiu+Z5L2JW+czo5sarKSN3KtSv+5oIwhoqY42qviznilVy9bO58czqoEMrIc0dLaOcdXsNm9ojfa0Oldh87x+3sp8bKjY4mdDnYxGOLkXuKyY/LLn059QOd27thQfunOkNAZ0f1Cw90S3l/yCC4F3oX3phwLX/BgwtSZAe7QEEiUG+1X5cHYV1mDEDt5b3UaSLHdiwBK+v6Cm1cx6n+Nd1BVfnVObVcgPcDwB8ujb1PeQVIO4MR7nLfql39JboCQlfz76tRWL/QqnlbCVtJDlHTabZnCxw6YeQ4STIlQ1IOId4nk9tdT59TnF6IezheqOg+TnIz0yaWOTfm7PuvQUIV0IF9pWPYzae+saB0wIkFq6laru2tidhMS0rkBH/BsFsG1KDY7UYVqEJ0eiUg08tm3yydPJoPwTpPszLeZVVGKXbWm+BaJaf8iY5pF744vxQOOZnGoNPITnf4rdJc2cInXgTnyju+5MLd63IuOsgBmMB8JEeWxE1f0YENQ9AuidQmNPtfduzB8qmipzfEgQaOqYAxpJuvZttPanMxVYwmdyIAJdMzv+gWGHUxtMrkKTaGBMaZwP5RamyVtanShyW4k/hipAhuMXNpYfiRxcRYbyonq9wWedzB++I7AtYTegQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(9686003)(82960400001)(26005)(38100700002)(83380400001)(6506007)(7696005)(122000001)(55016003)(478600001)(71200400001)(66899024)(76116006)(66946007)(66476007)(66556008)(66446008)(64756008)(54906003)(110136005)(316002)(8676002)(8936002)(4326008)(33656002)(2906002)(921008)(41300700001)(38070700009)(52536014)(86362001)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qhfSC3RazOl2RZETSzTEtsoOcMKkla/DMy4+IUNz/cz370R2DTJJkXLcL3TD?=
 =?us-ascii?Q?fip8ttJ1kJ8RhFW3vv5QvbnoYaY+s3uRlDKNeReZofMSNb+eivgGlWrBMrHS?=
 =?us-ascii?Q?lWOaCksm9RZ8F1Hbww/kO4UvoCZdw7s+/cWBlPsn259vZ4P6PSJZnVk7FXwS?=
 =?us-ascii?Q?u9tj59NfDvdyTm2ka1VSjkVu1GmkffhWDr0C1mVCTS9k0FiLmy61YkHyWD5Y?=
 =?us-ascii?Q?m4fLuQptFc6fkODUdazaepRwbzqnLGwR+fe6JTlpajpWtlwA9ovr+FRGP7eZ?=
 =?us-ascii?Q?F/WS7Kar+pAuj40xgzXU79akIJ8F5OMcz+TW7mmLBpd7G5SlFOFDzznEJmbn?=
 =?us-ascii?Q?hgGDKS1eAwTCY9kJgaz8FT2UxkEZR49N9HD2EVOz5jVKzplP/28Ops7Zr4RW?=
 =?us-ascii?Q?SgZoJwEKuZkjXQGLG3uQCGktDqFmH9hF6aqGnY8NLXT0X9SnVyn36g8Ig3d2?=
 =?us-ascii?Q?HsDDs5jj5imgzc64hYGII3Kne9pJmxkzquPcqaqw/NZYZ1GCs5WyCZ8dIbvk?=
 =?us-ascii?Q?iY2DVcSyyXv/dFJ/72yltDj/fZ2iAekNdDtoDqUsWFopvDsDbZjJ5WfumDam?=
 =?us-ascii?Q?nyDivWoWnrqGNJtATv3ibVJ5YhSv6f8zXxyTs4sn+7mlUmzjO1zJlM7zciPO?=
 =?us-ascii?Q?gX6ZonOjITG9qUiHw7pAqf9q+88LJzf/I2ewDwaUHxgnXjERUrZyeHyyp7fP?=
 =?us-ascii?Q?2nGAUTYyikeu5EqGnIGkF0k45BsYPPFK6IAGXdPva93SOweMIlpwsyC6NE9H?=
 =?us-ascii?Q?w6zNHQxUtrDDGWDk5j11ZeSDrqH9BaRFb7RZKVeaZMnxLKXTW4hBsfnWq0ta?=
 =?us-ascii?Q?jr5LqgJlfrBCzFoTvJG+fdvG9oVUPrSADL2/77WmG66x3uFlinlesvJ1f4ba?=
 =?us-ascii?Q?LjxAyXdte85ioxLPvLcfy0sVjlsEUBsZkUMwav+sP5IZ0H+zV6gsvGSSpBoZ?=
 =?us-ascii?Q?2xBzAGy/QE+9ltuGl7pZhpiMSDl2MUsDRuA2FdB+edjVRQe2DTA59T7AN2dh?=
 =?us-ascii?Q?BtePp7GSnY2S9HiPqqEvB2aNg8c4+fhpAtz2TFmHMP4zqJCY0/VEK2dV9MxS?=
 =?us-ascii?Q?ZVRRZYj+r2IFeN6INnYcamTVXk07gUSLn1P1hJFev2cTVYZ61usmePsI6lJe?=
 =?us-ascii?Q?6TxJ0A23iX7KXDGCj75Bt5P65pt3f/yjAOodewe1/m14wujmERyEsc++Nl7t?=
 =?us-ascii?Q?e6tOCLYuGI9/c+I/olczr3CahlKVaxfig/JIcyDIvJtD20AyIEOuOu+rt2r4?=
 =?us-ascii?Q?Z34WO2FtG3wAQXnDuDAi58n82c1ZbWmeZxuUJsElW6/hhqhD4ygAP/q+8e6f?=
 =?us-ascii?Q?Lo+lYffuADz46vFUmu8ANT927t7oFJwrWsE5BHixpmX9Ubtw6vmb5AQMAl91?=
 =?us-ascii?Q?LQNGcT2F20W/G95tUThTkI6Npcfu1Jf+WfQu64ZI/Qf9ZcCtRuPpYWYM10hu?=
 =?us-ascii?Q?3KBUNfQrDPZmfyRKjR/INAorx0LEDVl0CTEc1H7o5sWOp24FMBgexrVLBZqv?=
 =?us-ascii?Q?0Vp7I0QkQNNytbTgz1I0bPwoxBic8pKD74HnbzlAyqoqCB6HpOCyxU5u6btL?=
 =?us-ascii?Q?mWfTmT/iSCJtuyCik4V0ZVh1hdhFgCErJLmb6sdP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?fIXzK0+WP1UDHWADwAxYcQ9rgFPBA+23p5RK90/JCVXPJMT7hSCV7sVNqTP8?=
 =?us-ascii?Q?mq4sH5X+IKf3ONJ90hsM2nh5Okwc5OZlKd3IE7aJoTw2NfF1JoXS8ZjUy6qi?=
 =?us-ascii?Q?j0GJqEPM7EyaNN5LIWE8NrVcTTggwQVS650ZJHGD7zjR1TMMtYieAdajnfRk?=
 =?us-ascii?Q?n7buTk0f+nIhJ2Sf28KLw97lCq0wKpvKm52jG9AcWGqhGZtLWWfEufs7on/v?=
 =?us-ascii?Q?1+kjQmC4AVyamYxPOCiwxdwAZwmyQxatI/TuHt48QnyxFvAMODmzb8kD/Cu5?=
 =?us-ascii?Q?UFBJDzaxhZ+aPrb7bGPvWuU7W03sTyvVj47o3uZlYgHJ5myDATKwyK3o/brQ?=
 =?us-ascii?Q?nIH4SrovoMpFNwpiO90KE7Ji0jqzzElNjpgcRDtoH5q60byJuRU5e5ySvpuZ?=
 =?us-ascii?Q?JKkhCX035Ud/1OOyOYyyDbzXA5rXPQ5FpaPqQHg2l3WYRQddoURo823ajgOA?=
 =?us-ascii?Q?WsA4vQ/Xu5spm9etQrdSr5QRxRjzTPmEMiQdRvnR8+UnLMi544Qyb0izQ1Aa?=
 =?us-ascii?Q?2rIaU4if/cL4VUP4FCI1chRMhO7MpaLH5e/CzLpd8PYmfGj/aZSX8+CijTWa?=
 =?us-ascii?Q?VH66LNZua2vtCphS2d1mKP+qdYEYH8FYfrZnme4kHXtawLXS473daZp6CDiX?=
 =?us-ascii?Q?qkOD0Qja+kh2GsMfGgeWwNF+qwvgHl63xj0r1aJqshWAaOXt2utzhC0ywVgM?=
 =?us-ascii?Q?GO66TVdpQP0lqSxRTSD0GobffpG/F6xiS1yJGf9RWVgiVId+9hFEjMCasiLP?=
 =?us-ascii?Q?vhb17GED7J6syquE1Idt6zjNVZJExQfMJpOOBjJyWuQPxjUFK8vvixmDmwSc?=
 =?us-ascii?Q?1Abl2Yz0esZvnHrpI19tQNr1cX72xEIYy3Pf3lFlRmmfN2FVLwr4XXK+lsBF?=
 =?us-ascii?Q?K2v14xUoBktdo5WJQTKqIxvWM9G8pJQtJPr556KV4eeL39SbYdOqd9dBVma6?=
 =?us-ascii?Q?X0BgxGKDfzjbyE3YMH5oPlUvMeM9FMBPDj3V9/b/qJ2peyq23ZS7yc/DzTFv?=
 =?us-ascii?Q?9L3Ik8dR9/OC8MFYz8zkTY6Kk9cJ6iI7BOTs0xuA2tcyCW0=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4015a4b5-aaaa-446d-1b20-08dbf692ea6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 19:38:26.1537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jPZNEt1RJqBiEdD9FBP3guSxxZBPnq3vj6l43033Fr6BAy+Qk4tZSZrRa0QvAbaVFRjtgK/8CBP/Q6SvtQya7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7140
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Bean Huo <beanhuo@micron.com>
>=20
> Add Real Time Clock (RTC) support for UFS device. This enhancement is
> crucial for the internal maintenance operations of the UFS device. The pa=
tch
> enables the device to handle both absolute and relative time information.
> Furthermore, it includes periodic task to update the RTC in accordance wi=
th
> the UFS Spec, ensuring the accuracy of RTC information for the device's
> internal processes.
>=20
> RTC and qTimestamp serve distinct purposes. The RTC provides a coarse
> level of granularity with, at best, approximate single-second resolution.=
 This
> makes the RTC well-suited for the device to determine the approximate age
> of programmed blocks after being updated by the host. On the other hand,
> qTimestamp offers nanosecond granularity and is specifically designed for
> synchronizing Device Error Log entries with corresponding host-side logs.
>=20
> Given that the RTC has been a standard feature since UFS Spec 2.0, and
> qTimestamp was introduced in UFS Spec 4.0, the majority of UFS devices
> currently on the market rely on RTC. Therefore, it is advisable to contin=
ue
> supporting RTC in the Linux kernel. This ensures compatibility with the
> prevailing UFS device implementations and facilitates seamless integratio=
n
> with existing hardware.
> By maintaining support for RTC, we ensure broad compatibility and avoid
> potential issues arising from deviations in device specifications across
> different UFS versions.
>=20
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> Signed-off-by: Mike Bi <mikebi@micron.com>
> Signed-off-by: Luca Porzio <lporzio@micron.com>
Acked-by: Avri Altman <avri.altman@wdc.com>
