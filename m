Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277097B7AE7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241871AbjJDI6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241857AbjJDI6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:58:38 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0852A7;
        Wed,  4 Oct 2023 01:58:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+pucCNg6BEGE4sX2fUoazRkGztUKUgOy9vEUuXBgbv1pcyGnXouhJsKsKEcgwW2wG1RJFM4rC1ttNYkG+Z7ywpWMyg7SU8N7O09dA03T9DehjrNWIpNrQnQUwJniyFjcF3Epqkr29/7u8gLzhqMG4PYrkrieMZNTktBmV8SkeCVX/i6ch5drsFFkvRaD1pBHyeDitQqDfCGZB22yWYsfe+SXBKJfOGWaYHL683GNE80kIALEtAm41PJwWr1jEeL9CyGDUyT1+u/mRLGvuKl4JljWpDTbZVHqENT0l+sCZpFBuxR7CvAUZOyQfq7KS9TSDUcss8tTShtABGZdV9OYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkFcNijkgqGXLjRf9yyjkZ8f39Ouw3vU6GsUuxaG4nw=;
 b=oD2zOsKQ5up12KJrdqy91MkOdjiUDYcLrx68osCjrifVnjlZGKyqGTrnFy32snybIINicDPXpYETvFKUdZcw2N9mKLZ10S3GjBIyLVITaFpb7uLNNx4HqOc9RvAEPMRDhNMFUpJH6KPyb8oR5Ibd10CHDj4niC0JTqNulsgmbmJEyF2RXhggq4hCkij81JqbCW4fN9TNQhyISjylpGCeZ2b2cSd8iOB/mQWisgG9VpX/godFIkLBJDmLK0cbfXGp96zfJClpL+zSOjrzLoKcQo2TDkDcNFFY3PHkoI0I3Dtxyg8LmZxyNl+XnEnex4P78CSTA+UMGLFYvRnxl2qPFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkFcNijkgqGXLjRf9yyjkZ8f39Ouw3vU6GsUuxaG4nw=;
 b=yY92sVQULWx2mrre9p3xAsNDcLGutCEcoJTJJTuN2urc6lh4HEaSKgnKlyhOfQfKycvfH0+7mzUxu/XPVVAD6zzLUgNnaxc4VQdQ3EtfqT0vTkEPr577ZQ049MAW23ORnnvjgPHjaTjtO+u/pFbbV50cFEgQs3T2tZwW6enI2FWjEZXe2Q4HdDOMZXSMR56MpJLBB2faGLLAm7sxcFxJZZDl1zGyuWKM0lpGilLRk6gxyc/BrvhkqiggicABQgTvd2HiGqBFEGjrrBDUduM7ZLZL8m99UfdsYj5dsDjsmemOas9zt4e7ZpzlI+Nx7WiFfeBx9cWPo0ygCWmuRMd3Cg==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by DB9PR10MB6737.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 08:58:32 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4880:f83a:7de4:ac92]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4880:f83a:7de4:ac92%5]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 08:58:32 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Lee Jones <lee@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fedor Pchelkin <pchelkin@ispras.ru>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com" 
        <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>
Subject: RE: [PATCH 1/1] tty: n_gsm: Avoid sleeping during .write() whilst
 atomic
Thread-Topic: [PATCH 1/1] tty: n_gsm: Avoid sleeping during .write() whilst
 atomic
Thread-Index: AQHZ9hsms1Jp2Ee+x0K6pi4iDpsHIrA4XssAgADExJCAAC0rHYAABPWw
Date:   Wed, 4 Oct 2023 08:58:32 +0000
Message-ID: <DB9PR10MB5881526A2B8F27FE36C49134E0CBA@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
References: <20231003170020.830242-1-lee@kernel.org>
 <2023100320-immorally-outboard-573a@gregkh>
 <DB9PR10MB588170E923A6ED8B3D6D9613E0CBA@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
 <2023100421-negotiate-stammer-1b35@gregkh>
 <49453ebd-b321-4f34-a1a5-d828d8881010@kernel.org>
In-Reply-To: <49453ebd-b321-4f34-a1a5-d828d8881010@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=846fae1e-4113-47a4-abcf-c9db309758cc;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-10-04T08:45:37Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5881:EE_|DB9PR10MB6737:EE_
x-ms-office365-filtering-correlation-id: f9be4671-6550-40f5-02dc-08dbc4b815fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ac7ydRWSvO7PGoioW8xQzo0mLsHzhmSwK2rSGrsm5TS9g588bXy1PVDK4Y/hTjPSR9CtRZCfCAIBXVP2Ye2LediKGRXLvxplf3HmMOZR3eYPyoaGNw0pB7MvHroT8mJqUe5FVutE8BSDYI8UI+8ZXdr6XchLgzPRegsPY6HjhPGBZBq5YeYTt/0+khTQPflgPyXYW8rNYZTaHysFpm1E6n2uLobmVr15FRXu2LCL8tBmLuS+dWlYuJHoJ8wdLvip2WzBjZuTtgOOy2glf0IQlIo4A3OFe07UOsHmeDcjngPuoP/mL8zlFBAbuGrciFi/VVaGRIX2Im80yo5c4Gmdf6QOau+r5dXjSOG1Lle7LnMh6RuQQfeb1wj6KlTDMoyOwWiApIfFJWcj9d6cZYwLJyDuKhWIlevjf/Jd/E+TcY3gUcrKQzx7cDRdux9kRpjyt3tn3D5Bhkg1S3YGBdm35C0DqQajKdIKGGPiD/xk61SmSQO6GaPdLrVh0b5adEquLRUuhUmBS8C2kpe0H6V8DGOrozuQqsmN7wxKStr+9SvMzfcJo9WnenCTRwiMa4oHDqCAfDrJIE6bs7mIjOUx3YdiegFAouuY/pMLVfRwRcL71M3YcGG992h6oOSwfvf7Bi/54ymWOzh+RNXpQwGTnLBbNqAYpzOGYAsOP/eLfViovV9TX/rr5p6eMitVz1ez
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6506007)(478600001)(71200400001)(7696005)(9686003)(26005)(2906002)(4744005)(54906003)(41300700001)(316002)(76116006)(66946007)(66556008)(64756008)(66476007)(5660300002)(66446008)(8936002)(52536014)(4326008)(8676002)(33656002)(110136005)(38070700005)(38100700002)(122000001)(86362001)(82960400001)(55016003)(142923001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6stSPyPQxR/Bb6VK6xMhLSwZEJE6FyOm09nnLCIfRP0vSNs+hY7GJ/stU21t?=
 =?us-ascii?Q?a1YytDyZH5cZhvUA21BpFXvCQxgGaA5NCfuPM2UGy88gDDUnfPMBoyPN7poW?=
 =?us-ascii?Q?3M7SfFqNWzHQVYwitfu+qHYEeOfH8p0QR0oCFmz6O9Yf07IClZncmpgq74Mw?=
 =?us-ascii?Q?TGa7R9WSvpLsIZuSVqixC7dOnXI5tPl7r2CGg7LpfU67RcTGfffQ8Pm2wOS9?=
 =?us-ascii?Q?y0mVczZ9cLDsJCxR0IkeqVLpxctA1+Ci1XYq7SRToEFHZi/E4U6f5ZG0tmyQ?=
 =?us-ascii?Q?0daUeSja6tfwmjMIkmtvOJjitGcBOxTSlzW/rdQhjliO5rMuwzoyhMTjv+dr?=
 =?us-ascii?Q?kst+iyImzPEaK6IBBc2QlSkv1iqARLL5lp7JJUiSmEPmJ4iXoIgOr003sBS1?=
 =?us-ascii?Q?nbgaYPr69MMcu5feZ0ukuWKi9ht5XX2Gi0jeKyRYauMUwwTCAq92TXcMMlgo?=
 =?us-ascii?Q?w+bQnL7DTKvDto1e3htRZxM1PmasIReY3qwDBTxfwjpkc4E4Rnp7N3oUkkeq?=
 =?us-ascii?Q?XtORsi6gm5t3DuNazF63jqZeTDgoHwMbPhFvo9C9qv0Wf66D2PWTEwg8Cz9r?=
 =?us-ascii?Q?/aV54nTL2mmT33MEskk9iDqN1K6jq/MkFcJpg4aBCXT1RAmbnXlc3LmDIDUM?=
 =?us-ascii?Q?r12Qa1YldCCBLbxUWa0OTzwevuEloYf7s2eNMhJDlbNYbXaxLUCsu1KIwdwA?=
 =?us-ascii?Q?tukdYnYzbvqDUkSWV+7+SOmHQaknPNL4YU3odYFLrWgdw7Xl0Zf/kYlBvR4u?=
 =?us-ascii?Q?5YdhPX/MlbXI2sfuDQOWoXCoLVjq9fVhBaGyoQvOaqfq6QhyCKDXFFQ8YE9W?=
 =?us-ascii?Q?Q1JQPNiSxvWzMr95YBWzv1MCevhFBsnIKEL3QXHuiTGquYcXfTS9Qi9Bckt6?=
 =?us-ascii?Q?cWKnJvIAMn4YXwXQApTWU5RDt++OW0XrzcSEYeRJvCJWJRV8ZkJ6USogtFQ5?=
 =?us-ascii?Q?dpTHPlPTcaXbEWwmHzHuMQ/tSUn3T0VDw2Wg76bA11DIR4IoQLcfLQGVjbBR?=
 =?us-ascii?Q?AmoNDqXphlL16EJea7pTgbmvAF4TxrPqIqSMp97bCvSyspAB+jLSesHVixjQ?=
 =?us-ascii?Q?GNq8x/63Kw/vYcv5Xq7rDgxwmTqgGZpBMl8WLHrJHU6E/6y5kUuFIVVwqk5P?=
 =?us-ascii?Q?j9sy28fzrW+hcJEKIzXQEu5PmsET/kRtkAAZs0ufiInMfLW4d/DyfBaY4YtI?=
 =?us-ascii?Q?KA6cSr5iBM6Zr7/YEkNRQQ+NbNrwzuxWQP+TpZCcreuGzvo8Z8A55sdFEV0a?=
 =?us-ascii?Q?v0KlF8NrhulpEV4+rhvtu2sXaw+jjJ1emnKyI6sy5OemQHdLFqHLeje52Qt0?=
 =?us-ascii?Q?uqQEyHaAVDzQz7C/vSqPsDx2LHk6PrBsynIzOPXD5XRa0VeTtp4GE/B0Ckms?=
 =?us-ascii?Q?F9jtLHfcXlwPQy9wbSKb/xHwStGj/P+dJ4qZzrE/HmJN3Fky0khGrY81fdK0?=
 =?us-ascii?Q?IEhmCUqMK9Q6kuKaL2zkLHZY+whp6HBlo0E52bGyJmDWcIpPlNMdWbwBC8q2?=
 =?us-ascii?Q?pHUt+XQ2rAHyyUfC6+fEu8xB8mLM2yPRdauG8XN5hKgbLKWDezn8qoiouv8t?=
 =?us-ascii?Q?TBb8iBv+m7moirbYsBCh9NxTLuBpxIk0qKeZL89E?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f9be4671-6550-40f5-02dc-08dbc4b815fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 08:58:32.4654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MyvebmYr8QNzVNUgVxFmqT/JGigQFx03toXJzl8ajAqc+VHhH4Eyk5x8wy9iYIUTI91b/3tc3fPdFvTMKmXR8rqX/yDMvolgMk+Iq50eF+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6737
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So without actually looking into the code, can we just somehow disallow
> attaching this line discipline to a console (ban such a TIOCSETD) and be
> done with this issue? IOW disallow root to shoot their foot.

Probably possible by patching gsmld_open() if there is a function which can
check this based on a struct tty_struct * handle. That may, however,
introduce some cross references that are hard to maintain.

Best regards,
Daniel Starke
