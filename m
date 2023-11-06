Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBFE7E1B5D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 08:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjKFHik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 02:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjKFHii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 02:38:38 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E5093;
        Sun,  5 Nov 2023 23:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699256316; x=1730792316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/g2wdQpyUWgHrZj5inbiOvgajFAZhVKDHTzQSlWLPFM=;
  b=RX1fjMurW7aaaIk4YuG0KxdcXkfe+BSITR8KgPlf2KoVOHs7PKFdgC3K
   s/XtM8cXd36CBW5PQfCGhLn8pC+eFmVSFFCqu7uZ/JdCM9Mbt82MqClaI
   aI/qL8gGeQA5Zuc6ZmuuoeE/+MW9BwWJDYOlRgoG38kaF6NL0ef/rK5IT
   0+cdBf1u8PyHNHvC7Vv7zBi+/w1/67Sft1RVge0qW6Zbcu1SQWTDcHIrK
   XltAC1cIzoWJ+UaaK53UfYN9NX7NmNboMBcMWm8XlKJDcnw7W2h/6tE2M
   g+Q5w9VIrU+IzGczzUzz53V7oElg9NNZuT9RJueyVXoNTIWnP7uytZbmj
   w==;
X-CSE-ConnectionGUID: E4dhKfebSxCDfS1Onv830A==
X-CSE-MsgGUID: szLCIuMLQnSdp3dGjuiz9A==
X-IronPort-AV: E=Sophos;i="6.03,280,1694707200"; 
   d="scan'208";a="1439081"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2023 15:38:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOMah5pAe0K+9CopEuZmFVMgI+l68F9xrFREykH5MhvrjKQcIAisfLVhfB3V/t196J84bzS9Vx1lm28ABl1Ga4F+97SmwwGRmGVhCYx5y1t+nCu0LwsvegSDpTZXMIqfiZNeKw5gpugyGcFopwgU3iQGP+TAnsyB9dXaepV/Snevy+oR94I9mLkTHJ57u8IsCimQ2bP8D52eJrHAOXxT4MbFvNtmBRq/RNqmYdSrFwkqS377mUWGH4UWOplzDu1QcwBWjPX5R4qRL2oOoo416f37V2QT+J5VhGryJbLepSAoO3sg4je4bcAYbv3YJA+mwemSu9mlkmscAAlmpnz3RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaOk/Psau8KJuMTWKfy16TZGsxYdUPNYGhOyJgsDFJQ=;
 b=PoidfViAqQLsjBn+T26cwnWiaK2U5NxN9erFxaDmJWYiQ8YtL/atwYNLZr+X//tnbjnicdViJpGgYRkBBobf/4mYzpDHSovGvBZ/9/N0yAXQuxwjcR3hwV1ye3yAz5lx9xBGUqB9br0z0r/28TdBNhZisOwZQfUvzIKC+o4w881V2q3vBg3CElVehO11pQZg04gj+F4F3KStYCMr6HakJ9hWuRj0mVl361aIIhuiSPee/xFPoMotqWVkNYfOkNCBv17GF9iV8eCcOmE8Il2LBtCC28xRW8HT8zO28VWL/rst457fxHZFYr4FLou4R84xV6rFTRjzxWVX9PsCOKC+gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaOk/Psau8KJuMTWKfy16TZGsxYdUPNYGhOyJgsDFJQ=;
 b=jWsRwWBPlyLNIWgKfTE50HBAJgp6ct5ZpmZngzXmAC0S25DkLo7WaFiU1ssU7NYwElfZ42IXkjb2FqPskwgUUO2EBu/SfI/mP9Kp2vI1BVxQemwOI7l4NlHgpxuxFBNBbqR6oYtLiHhSECqzKv5QfWMWCH4+3y0IWslkRPo2GK0=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN8PR04MB6337.namprd04.prod.outlook.com (2603:10b6:408:dd::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Mon, 6 Nov 2023 07:38:32 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd%5]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 07:38:32 +0000
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
Subject: RE: [PATCH V2 5/6] mmc: cqhci: Warn of halt or task clear failure
Thread-Topic: [PATCH V2 5/6] mmc: cqhci: Warn of halt or task clear failure
Thread-Index: AQHaDjLZw7S/sDZV6UOnOsoxT8d19LBs6+yw
Date:   Mon, 6 Nov 2023 07:38:32 +0000
Message-ID: <DM6PR04MB6575B4B1FD9565A3DC5B7DF1FCAAA@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231103084720.6886-1-adrian.hunter@intel.com>
 <20231103084720.6886-6-adrian.hunter@intel.com>
In-Reply-To: <20231103084720.6886-6-adrian.hunter@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN8PR04MB6337:EE_
x-ms-office365-filtering-correlation-id: ebce004e-c559-4ba3-93d6-08dbde9b6085
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ETFjBhE7Ai7Xn4lK9uuibkw2BBZQca9OJF76qMbPnlCLArCymKEx1MD4AywE4usVjO7FocJ7IB8TSflpWlU4SvE3vswoyEZv3L0JWILAmyPt54AVdnvW5nZ7GoCosHe9yPz6bX13ClXtPrt1YNCKFFDq/4zQzIdsg14yhyNQmdS7/GLCyJjaK20CZz2/uev2TOCHB6wMD5HYxE7PArvXXep7KJK+bP9zXfca1BfUB+5JXGtnbrRpXgQSd3ON9JwmeCOQgZhQr2DVmJ+PnPFlcSrephlpzEQg+ZzoCMiWFBO5MLz/yPjraf8eVQlcOp4f+iT9ocwcG88fcAV4F2goeN5q4/ihcjGcABIN4oYOjoyZzGq++E6HFPTN6aV5h/t/DuoY23TXBqVfkh0rNf7zal4Qf1r67DNP9bATwKLLbEuR24tz83SFMsThEOdJv4TtnyCyTcrR9HmnbzpyCVxZgDbjJfTGHbNyELjbKCG5MLT/EAs8geYodsQpJEFseoYixa1LD8CTyVIq2wTFrvLA3Di1Q3nxHtdZ815Io18AOcd5KdZV5KbDfizHRKlrZ8olwSBTnHhl2JMy1k62FxUxRdxbG3zFQHd5reMLeKJlw1pM69Xa9r7VK1D+j6EzbkgWC5hRozP+93LQxwiNxNAtoUpR9QXJDwYzHXYFq5+uwdg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(4326008)(8676002)(8936002)(41300700001)(2906002)(38100700002)(5660300002)(55016003)(66556008)(9686003)(33656002)(316002)(54906003)(64756008)(66476007)(66446008)(86362001)(7416002)(52536014)(110136005)(76116006)(66946007)(83380400001)(26005)(82960400001)(38070700009)(122000001)(6506007)(478600001)(71200400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?h656EVXlZG8skE1u4qaadJ3+/Q63J9bFngyzur1sUGJ45v7yW+4PHInbBB?=
 =?iso-8859-2?Q?5Rj39/Vq0Ls6azjwqx+ltM9civXRPfLYPh+wKkKXjDk+z0yTtivR/DzUA/?=
 =?iso-8859-2?Q?FgjQ+PrqnZeJLTtFB8D3YDs/HoSTrDf5t2R50wbaHNran/S+RdB9eHHZTk?=
 =?iso-8859-2?Q?Il5puvG9bAavEZcWRykynqFL7O17OrpFEig7H74rMWV5CxtWWPH5zFJMGN?=
 =?iso-8859-2?Q?1X3QSibHRgCX+RvnIoRvIZvLXHx9kSerLsc/ZjSl1MesurttFtMesguRSD?=
 =?iso-8859-2?Q?zWAf7lFOpmbJCvAC0hTR/m5MG/omAUR5Xqocm9Uma2+xYkxY/wxd/vAQON?=
 =?iso-8859-2?Q?DbidDINnxzGWw/SzJFwRTEVPavzAnTcwDUzBZNRO/KLnMUrfKyJ0/GFJP3?=
 =?iso-8859-2?Q?xCCcklHVdIkccVk7SRfrfw9s2hWaHWt8CGJRzpH/j4lVDihoAOMs8RbFY3?=
 =?iso-8859-2?Q?//nZnD8A97eMaurSNb/CummH6TmPs+zaxHRurCV3TTjXXSZezl3vqK4biI?=
 =?iso-8859-2?Q?82z6wJ0O2uolg1AVyPKp93raflVeiMdaE1F2FI4ccJYXShSyegOBvReU/1?=
 =?iso-8859-2?Q?BH79L7Ob7VRmge2YcBB9xuiqsSh3KwR1NmCyUrtDR+R9G+AXj5y1FLqEb5?=
 =?iso-8859-2?Q?LkFn3TGwkmFxy5XgYjhEoDCUceNAt6L63CtedNMOwEPnBglnxj8kFO8fXY?=
 =?iso-8859-2?Q?S83cSXjD0H+yznq/IEGpBgFacDGEMHY8SwX+nB6v2uTiOvS7xtXiZjQLBd?=
 =?iso-8859-2?Q?pb164gt3awWxKR43zhAlxbaOt7qMV0xycf8MxdB5kjGPn19xkxmeOdiwc3?=
 =?iso-8859-2?Q?UP0JVM1nTFo1ouODJg2vFoDvHeFKzbCLCJPkqw8AwDtxdOY5r2YR5iUM2V?=
 =?iso-8859-2?Q?UsP3aUFWf+eCg6uhsMDrOL41zM3f3dGV/99S8bSyxqQNk42oN6qBjKSG+D?=
 =?iso-8859-2?Q?eR89xpBs1RvrDWBUQIRH8E2gWHeTEUwiKwLe+AL4cwGuCPMPS6zG6ujJLz?=
 =?iso-8859-2?Q?gx2EXXhK8345xdV6VgSzn+bMJByXEL9KwTmsW4o6c2zRp3r9Z1i8ufGBCm?=
 =?iso-8859-2?Q?L3YepSJz4/9cVQZ/pj52RkquxkNVZyD0OXWjlo80jsXBjuLKZAH1yHYjIy?=
 =?iso-8859-2?Q?h4eiAPr0IUlkV/UvPRu/6Ps39nR0iX8N4wc6xYvRd1K0+cyCf2A5ZqHBVn?=
 =?iso-8859-2?Q?0eFpUZdLnZ3oeNeNMPvHHLUi6W1hFlf7SWjmbT+u3LAYMiM2XJp4pvAqt1?=
 =?iso-8859-2?Q?oSSn6W9UjUO2++ECH/kDYbgdrBYj59eA10BIpLUyo9KIFrhqQ3+gdVRzJ/?=
 =?iso-8859-2?Q?Rsz+EvsZFapUeVApTtI6B2CmeKKKf7J+MbfNHV/ixlHc7eJZNJYOumpbUo?=
 =?iso-8859-2?Q?cwK60sjxcLPPtvGho3UL9rJlyhdAcn6YDOrk3NKiDcWYpelB9nyQ7yOsJO?=
 =?iso-8859-2?Q?W57/2pFOzgKrzfiCsJZnOKFcHFVfQnGDOZJojeHTHMvBkn7EYOd/qGbUP5?=
 =?iso-8859-2?Q?I7am0TNA2AIHY1aYgn8jk4QL5rOl92JxdTTHHWo+3FyAVtp1HbVN8L7TIN?=
 =?iso-8859-2?Q?lgAbG3ULHBLeNl3xYnYmoIUzRuyQsr2/+wOkNlvV2Nub0CzWy1On3u1Ikh?=
 =?iso-8859-2?Q?iK/m0NDDj3McVoWznKNkHENiSI+IdslxS3?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-2?Q?xtwumyvQoiMkwn0bhz6KnTQpiJQokUa3fauICVtNa/gdetmOTUFneSVGLx?=
 =?iso-8859-2?Q?gWOeYcE7eoJD78ywILP+EF+2ijojbuYGDKQHJ23BopxwVA/11aShBHV4jb?=
 =?iso-8859-2?Q?t59FFVwRfmAVSsJUx9EQ+yWa+/n/ce0oHgpRB5bjJXTgYKyiPYKu0fvSNd?=
 =?iso-8859-2?Q?Oo5YmXYrMO7X0RWvhqlum+jScbZHqWiWmTRx63h1iaAYZc7qISorNXKOqK?=
 =?iso-8859-2?Q?5fcG3bJzAeNHMJ4uf66XINhwCbBFW9oZ8MHotUYijhBbBZwtLu3x2mtgLb?=
 =?iso-8859-2?Q?2FgUP8wsrSnHezI3X2PgD4GeuLo+1OhDVP0NsLGoCkI/0XcvfqflK1o56Y?=
 =?iso-8859-2?Q?yYqJsNacoZg9geOyk3T+R1NHftQ+zpn5ZDnNBjze+E3zf0e7E66ImoCP6B?=
 =?iso-8859-2?Q?xWlTz4fNIlG9a5RQrL682tpvsZmOEnq4hMcl1XVVMHseBLdhcHM+D2si+n?=
 =?iso-8859-2?Q?IZvMykhZz4zciopxpaslVYvAfiE7eXZmK+g9Sj+Gvk3wloJKWlqD6v49Qa?=
 =?iso-8859-2?Q?BbuY/ifhZI7PQdAO4Ss1Zg+VwnZQ/3YhXQe8Yoq/HfVskaEXYmrYxL+zAx?=
 =?iso-8859-2?Q?0RjxMc8u3c8x2RFfI9a8XqRk7qWPU495CyIcEiewrAV/ZE+t9JhnwcjsTB?=
 =?iso-8859-2?Q?cse6bSc091KnaYiFs7qvMl7ywONH0yr0+Sd47aMVJElRKd2cYQ9ik9rI92?=
 =?iso-8859-2?Q?YFMYkN+GOB58Xfuri/McyLMQCofIa6IQ2Bi7IOUxEo+mTD6RWVTfphcilP?=
 =?iso-8859-2?Q?dpH5UXhRCbFP59dxnfZKHJkqNVlHxDI6V5bUA9hzb2bAG8x/2KIBrNDwQ+?=
 =?iso-8859-2?Q?WhZMDAH4KlBfcQAdQqaKsrFuSMaFtYX85+hmgpcSaY7KoCt9Hm4ZIyEwgP?=
 =?iso-8859-2?Q?ob7d05bQ/BUQwxV5QYmGlsbD9Hk71vsFVXVoGtg17+CGLxc4DJhl5/dPvo?=
 =?iso-8859-2?Q?uTSLt33b4BAZbOtwovX4RsAgskASfaEoQPVUATy7dd+LzUOjFL8ssZdxjn?=
 =?iso-8859-2?Q?6Q36ECfn+gmEm7HqfiYXhMPE/V7m9ih0JczeUB4YpuV82cHoOHvtv2sx5I?=
 =?iso-8859-2?Q?jTYqrpg03hNR/tvv2+IYpll7xBZkYLYoeCMi1t4+a3brH3iPapfW1T01Vm?=
 =?iso-8859-2?Q?IY/MjD6zoFxmLOcx8Y23qL+ksG8AeSCri0Rlusn5rcuK5bSJzKTIQydTkG?=
 =?iso-8859-2?Q?2VQ0T/M0slo2HI8sZC4cqZwIWupfO13Sv98=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebce004e-c559-4ba3-93d6-08dbde9b6085
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 07:38:32.3221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6RfFGgDKX1uNqaZT40saLyMiyiTIQasRPg9fGiV1Qmx90qjKqGmnzNseW9FxGxUM8dn8hVF/kWn6ccse9GmG8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6337
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> A correctly operating controller should successfully halt and clear tasks=
.
> Failure may result in errors elsewhere, so promote messages from debug to
> warnings.
>=20
> Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled
> host")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
>  drivers/mmc/host/cqhci-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.=
c
> index 15f5a069af1f..948799a0980c 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -942,8 +942,8 @@ static bool cqhci_clear_all_tasks(struct mmc_host
> *mmc, unsigned int timeout)
>         ret =3D cqhci_tasks_cleared(cq_host);
>=20
>         if (!ret)
> -               pr_debug("%s: cqhci: Failed to clear tasks\n",
> -                        mmc_hostname(mmc));
> +               pr_warn("%s: cqhci: Failed to clear tasks\n",
> +                       mmc_hostname(mmc));
>=20
>         return ret;
>  }
> @@ -976,7 +976,7 @@ static bool cqhci_halt(struct mmc_host *mmc,
> unsigned int timeout)
>         ret =3D cqhci_halted(cq_host);
>=20
>         if (!ret)
> -               pr_debug("%s: cqhci: Failed to halt\n", mmc_hostname(mmc)=
);
> +               pr_warn("%s: cqhci: Failed to halt\n",
> + mmc_hostname(mmc));
>=20
>         return ret;
>  }
> --
> 2.34.1

