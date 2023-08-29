Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8742B78C286
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjH2Kpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjH2KpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:45:23 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2071.outbound.protection.outlook.com [40.92.91.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F051A6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:45:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6dpMQXcLzUbN0rL5wPa5UeCRf/fsDQT33hSrtdsNXirE6f+ATfvaGXCFHbCYVp1DBUbK5aFaVEgZRhhv5O9wGKiQzFx8cRaJoSuVUT5oEHvEO0Ffoko5fm4QLNQBSYjO+73t9bIrool3O8/hV27WDO/L9oRnGr/f2ayy0BbVjMLVnbFJ6wLerYr02kqT23gKacdwWcouEVpMcva1gQsXB7IW4j47N6RKSN6/NwgKMEBRB7pvFSUVZP0g8PvKK0qzrQNTI66yrQSlLTi0D7hadg83p3ehO5jxf81ailqRYF9Wc2aBFKRMjXTCOaiIxZ+jcloucQ1s0D8fr+PVgPZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAxWIX2cvH2WHzPeqI+sKRg49iFTPKB2bDQvwiSJH4c=;
 b=jFPMh4lZOdh+8SwMzZcKA3lk2xbyHo7BgVjfRCRNowOvR02+HOxBTroMcTB8jNxg430/S5aboDplIAQ/6VkMyme/E8fIdnCg06ttyr15dlx69OdYQ4QCN+4HOah7kInQfxA/l4zjCGuj4WtLWKuHKc0gxCj+U65GzYWnmIzDIGNfbPoXoEqpbDWi3kNb8LBqQar8wkKSQhvF1Jh1402s1FMADYj3lOZpu6GOBl6B7MhQhCvIJzWd5FVZIghUpErwsk2TcLP8UGzIURrU+OrOZNbyFrPkTO/omlabyO6ARHy82w1gbfqYExWkSVpKpZwF+fJE4o/GCZyxXYawdL9CXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAxWIX2cvH2WHzPeqI+sKRg49iFTPKB2bDQvwiSJH4c=;
 b=X+fYSwiL6gLxuInGTY7ODDJggTeKMtoF3hFZCjjmJVnLuWA8low9TrBeA37D1KDBszivGLh7IsKxG8lzHWoduQNbxgfhL71scoAt0wb9UZx2HCSkKv1b827UEbncB9NaLkhTUyg6wyoalO+SBTP/ohK6QjMHGDzT0VGNXSbNK0eyBjFcT0Xo/1g/0JdmmoOWt+4jLhkaLRiyQRUnqpUkfk3/U9xS8Mfx56oyfG9/tMXB2WEXEsHJpcJmIUTFmbjVJNW261Bb6LhSx9nmFYLPucgLr4SGHoY8/T9Q/Kx0x8tggee89O6vfJbWac/YQdIsECBpKf/T+RN/d0zSeb+3Sw==
Received: from DU0P192MB2122.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:47d::18)
 by AM9P192MB0872.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 10:45:17 +0000
Received: from DU0P192MB2122.EURP192.PROD.OUTLOOK.COM
 ([fe80::4ede:18:1bab:43ff]) by DU0P192MB2122.EURP192.PROD.OUTLOOK.COM
 ([fe80::4ede:18:1bab:43ff%7]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 10:45:16 +0000
From:   =?iso-8859-1?Q?Ywe_C=E6rlyn?= <ywec4rlyn@outlook.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Bit X, now Red J X
Thread-Topic: Bit X, now Red J X
Thread-Index: AQHZ2mW3wed1GQuLn0+n5mlPL375+w==
Date:   Tue, 29 Aug 2023 10:45:16 +0000
Message-ID: <DU0P192MB2122700519F232897464E418E9E7A@DU0P192MB2122.EURP192.PROD.OUTLOOK.COM>
Accept-Language: nb-NO, en-US
Content-Language: nb-NO
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [mSBXZH8/8DE+Jjs0h4R7+W1koY6Y0Rcs]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0P192MB2122:EE_|AM9P192MB0872:EE_
x-ms-office365-filtering-correlation-id: c9613bb1-415f-478c-eb1b-08dba87d0874
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k5pUAheOUKxg/OTqCpOY+5DLVSLHveuOwIAEe0pFhL7QeyxblGoiE2YsxnYag/qlFF42jXUp2CZFVXXYq6pTiGbV4qQod75zMt5Sv8SuRxQ1DXIAYxizOSbQ3ZMUc5RYp2KS0SpILhf53ZMS3ZZzK33QzTHZ0UPw0I7Ln+FIizUhinG3PLa95NMI9w2drWMnascG5/C1RMl2ZaE94kqEtmhWUnHfPx1VJgLYuYaRLJiNFu9Oz8M461NuIThHvQ9lArP7p9+8w8m+swUOY0fA/6+tiwiouSmHX/e0mOfQt04tkADcvajDk3oQjY5fRHh8kVcSG4LLK+9MsNLwIgUkkaqD9WW1t0XOfu/nVA36/j5Hp4B5KX4dzlhSdpAOxjOAQ/ClV2OE7o6xweCjROLZGPO+kGYzP2QvvqC/LEF5NpX8DI4lz9hTxdycMZtPumy79qy2CYj+ozd8ucRepI8R60KtHKkHyKoPk//N9cvvdahsvqjjbaphgmplt4TR9+GLpatFQw1VF1FA4JksblYKL16INGbz3yXIjsi8mAiUVi0j98xsME4Mj/1XWXputQW2
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?S5PQWJXAoN2WfpdxAyusc7hPeCVE+94L6BBkpqExzLMGQevlCZraI57lue?=
 =?iso-8859-1?Q?9/fmtMQSCIoBNPncoZLL9IYKhgdhwtvyf+39vvknOX9HoAy7sepilj+BNv?=
 =?iso-8859-1?Q?Hf8zwSba6bxSF8nibN4OTGm4r/4eH9++oWAwzMSR4r5R3DxAqq1ewAvB6Z?=
 =?iso-8859-1?Q?1xsPqMMrZRKCXhSCi3y6GvMMbPFZ0RTlk1qvK0OqJ6wa23mWo4GmHn6Z38?=
 =?iso-8859-1?Q?NojEg/QPi4Ebwqvpl93gj630PPMb5HOkoc/Z8RBkbyccU6re0CruKY0i/T?=
 =?iso-8859-1?Q?PFhlbbs9xRMZawcXEefct/eGuD4IfGK15lAS57PAjvKdGs0TPuecg/kkrB?=
 =?iso-8859-1?Q?r0+rnnV4guxyVb6ZKlnjU8KNCCmmNIDXL8vtkJv15t8kyTf1+gC/djxwjN?=
 =?iso-8859-1?Q?JIwiJKZcpZFgADXkyNThbRJhdFJ+43lnLQsa9+uzI5wDEnTuQzvXNqCSrB?=
 =?iso-8859-1?Q?f8y2rB1q/T6OVVNbmVIwuJ3UAFTCn7YOMWONhlaWoTKVu/p0Vffoq7c3D4?=
 =?iso-8859-1?Q?4ZdrKvVP2Hqqmvj/zcSpoH0Cy8iwfO3wt/SbkXAKiB1SlQZP7HMFQFlQJw?=
 =?iso-8859-1?Q?Rqa3U6B5PeHLv2m+RkEMNrpkHDF6v94CmU7cddZZiFyZfAasfBE8/9dSkm?=
 =?iso-8859-1?Q?PlmDgreISIhDtCeh18mcpeMh4VnS0Kf6PGDGliuUWwfhMR+vN3HNcHlwUJ?=
 =?iso-8859-1?Q?yXzfbNrJu4ek2Bp18FS/EIWxTFJowqQUi6f8RxGbDSE4DE+yrE8iwvxJ32?=
 =?iso-8859-1?Q?c16IFVV0kMWUti1QBztFicxZniJ9dHasyB7F/adNkVm0FUysnw+ncCMBw6?=
 =?iso-8859-1?Q?AsgZyZfkLgiIquwMj3p1as7tjXNRB8WWbzfIpMZCvOJyqqDuprDE7LQMcc?=
 =?iso-8859-1?Q?IPsZdk0zjCHu2PXe3bcgqXojN9oFXi/BkJZnfcaqjOoO5UgKQdNSR3ZytD?=
 =?iso-8859-1?Q?v5mV1TTGyzmT3/V1YVcx6ycgfIEwtBsWi9PRo9wSTcWlxWmgSEJuBd8fOs?=
 =?iso-8859-1?Q?zJ4dYfGd3Guub3yyYnS8IPfWSjcWY1fEgLeFfbFg7aWD7YAIBkNSP6xv+/?=
 =?iso-8859-1?Q?hLH5yJhA8LuUcn2LhlNKWiw/xZnLo/gPFeqsPgNKtipbZM1aRSqWDIU3/g?=
 =?iso-8859-1?Q?7CZEm/PmjwCaQH7Gotoiwkw4a/1ViqtgoyrkC8jiS03MNZJcZAeINXCI6b?=
 =?iso-8859-1?Q?/9TCLssRgemuCowzN6N4KZte0u0QwR2p/NRqBE1HSAYwvXTICV9m/4Nhr6?=
 =?iso-8859-1?Q?DDcgFWGGW1mAr8IJ8DcA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0P192MB2122.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c9613bb1-415f-478c-eb1b-08dba87d0874
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 10:45:16.8965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0872
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found an even better way of saying things.=0A=
=0A=
So my suggestion for an OS, would be Red J X.=0A=
=0A=
Interested in the philosophy I=B4ve talked about can see here:=0A=
=0A=
https://www.youtube.com/@Red-J/videos=0A=
=0A=
Peace.=0A=
