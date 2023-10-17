Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B27B7CCC20
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344224AbjJQTU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344196AbjJQTUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:20:55 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FB0C4;
        Tue, 17 Oct 2023 12:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697570452; x=1729106452;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5w1A15h+1vl8mA7wQ252RN4YghAI6eeLYW2QEaVeAOQ=;
  b=cP34ivSBwV0OGgGBMyKTTxN0ELPcKkB8luV0Ae9U0bbwVzqSYKkis3+K
   6fRxJL1tsb+QvL9D13twEYMwUs2iNGZL8VMsRKJ4sOnFv0/LhkubS9OU7
   Gb5+5pYofWMsX85EorH3iNG5LGtVxVFend12xgSbhIP60SFXMDMlsuotV
   u/1YlV89ScPsYhB8ag2PnyEBIYAHpQ56BDGBkcv+ICEE9mkMWMtYUOCGc
   X4Rr5JIOy8fpoPzogw/gC8Mp7X/ZWi5Jq3iZuTxB3oqwrHONbZ89VwDAF
   e9NRZwMvgnVKfhBpGQnmLzy9wbDd85F/GF0Avq5NcYz//ZLxoQSpowZQ+
   g==;
X-CSE-ConnectionGUID: nOiFQDunRWudZxBMmxuvhw==
X-CSE-MsgGUID: RP4wN/q9Sp+7Sog1OSDdTw==
X-IronPort-AV: E=Sophos;i="6.03,233,1694707200"; 
   d="scan'208";a="247064956"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 18 Oct 2023 03:20:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ebw+8MMODD2JrkeHGrCSTV3jlJl7UVaKqxZTzgrwPWA8mn1AdUCy5IYPHan/A6SaWLfHQh8jiOGkHsdsdbuI746ie4IZfb2FfYTqNEe/OxxE76VY7AA9L7XDzLJ/4IHOoMUmmfu/JObf+1vKZGltDOn5FqcAFssXG17ZeUj/wJHNaPIGfKgUXbEJZFgTohXFXwnsjX5abTpNRz6zIybwVq2PI9S66yYah/mve7uDeSwrPK7jkhKezLKOHs8yAlVhmKmksqIClgebG66+hxmNcN+nIvlOMUZVcdRGLyw1/Aj3TiRTDYILyLmyis6ygRVeBRHYMsoE2hl9BXx+ot85DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5w1A15h+1vl8mA7wQ252RN4YghAI6eeLYW2QEaVeAOQ=;
 b=k6Qhc4NmFVuZHNT2dyuVXONWmFKFmeNDVryPBQze0B1iA4cB0e1u2ZgL0WukAnbbk2qWLLpfW8eQu0dknC9Dkcmk2HEhC+NcOZGFOBWFVWvBpCBdchNt+16jdcNA7rKJJLpjufdvDW86xtx5WoPQqRU1zQG1TBeP9idrFgp7BE6TyfPqJy0Rt03g6DhM5cKixQ/MXST6KHq8ZVGIcvFc8zFbm46J/lgZSpAtfiqy5unpEvf7j/ww4ZJQedWjltGZMoeXgpFeJRoMurNEYk8/7MnCG1Ql7rN/RFO0liFS+NTIv2SMwAvRyz+3pd4Ha0O9BAxrWlfgXkf7FOghAafu4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5w1A15h+1vl8mA7wQ252RN4YghAI6eeLYW2QEaVeAOQ=;
 b=JVbGJaZz2pSE0hBxOleYEKPlMjyscTQ/nCJjXY7qQTthz5LkvW5x2+GL1qOCoOQUcCicS6zp4jpVA2VTXiKAf5Uzr6zqZFodfTVpOZe7kp3AEhaw0tlkq3cIHO83o4N7Iol/Un4gu0FGe9/+KHCVn+kXoJXTW7HdO9yWf0Jrm58=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH8PR04MB8658.namprd04.prod.outlook.com (2603:10b6:510:239::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.20; Tue, 17 Oct
 2023 19:20:49 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd%4]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 19:20:48 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Daniel Mentz <danielmentz@google.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tomas Winkler <tomas.winkler@intel.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mars Cheng <marscheng@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Yen-lin Lai <yenlinlai@google.com>
Subject: RE: [PATCH] scsi: ufs: Leave space for '\0' in utf8 desc string
Thread-Topic: [PATCH] scsi: ufs: Leave space for '\0' in utf8 desc string
Thread-Index: AQHaASai47IeABHu2E6maHLX7VfBYbBOW24w
Date:   Tue, 17 Oct 2023 19:20:48 +0000
Message-ID: <DM6PR04MB6575C45CF299649DF41FD963FCD6A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231017182026.2141163-1-danielmentz@google.com>
In-Reply-To: <20231017182026.2141163-1-danielmentz@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH8PR04MB8658:EE_
x-ms-office365-filtering-correlation-id: 2e825d6f-f1a4-4da0-ea55-08dbcf462b9a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GP4j4+3gPWyQ62RZEtwMJx5Wjgo8tY+F8QUdso7Gfl5GySBxF+KDuMt/RlZCX8S51XUsNaSBsmWX6UVf1OQD2bBGj3vPGXNwRxVGeJ0kq+j7XmYNSuYLSjjm2cXstgtgdg4OjXOPENk0VRDg2pVOIxArJzsw0LhYqrPA+FKkQjLfeVxIY/Ur+260NzcSFNQrJx3T9hqCteWVAt2eoLArMq2dLcwolnZZsf20M8kyuwzngpALn1bhd0LxR/V5cHYe8YhehZYEuRxOt5F0e1bd7nEAVIn3s1LfC5hNtNOAZ2y7jk8o2TpsA24zsSGV+GMe3K8zVZ7/0J3ILHOHsM7vye0v3vppRIwJHMPiV/EJu/Pi7TY8Ezmb55PXNjIsy4Q5CpT/lbdzQOekhaR8X5fGLccw2fusPOx4zFyE452QUvYC7QRhAnwJyYqQpLhOEfALZbiUIkzFZz7Z7iq7gW7/w/sPektniyZN1tWahYuMGDwXmZ4Yb1NhKnmL75eMUmrPNH6qhJAdADOKCovgYs+hxe5CSKejBv0Zg2aqmb6afaAAxxdALMvdcE2hvHITCOIW1Xul88TRzcGepStN/rT7DqxbX6hnVK75YYgpwLaq5kgSZt/jGZUcUpIjpZvo3UT/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(9686003)(7696005)(5660300002)(8676002)(8936002)(52536014)(4326008)(41300700001)(316002)(64756008)(54906003)(76116006)(66446008)(66476007)(66556008)(110136005)(66946007)(478600001)(55016003)(38100700002)(82960400001)(33656002)(86362001)(6506007)(83380400001)(38070700005)(71200400001)(122000001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUg0RG5nZTZEZWdGa3czLzZFSEN4WnBjLzBqeVlVQ3ZJeUppYVA1M1A0dlRX?=
 =?utf-8?B?bzd2ZWxCaXdhZUlTTHdxRGw0UjZnU2dMTW1ublFtc2NQRFNMZ1N2b1lFZzZy?=
 =?utf-8?B?Z0ZRZkZJUVplbzZaeFJORGZ4V2VJSlFtR0JxM1dUNVQ4Um9KOTZrTEVrRTZ4?=
 =?utf-8?B?V05TUWVZQ2ZocGtFTkFFR1h1LzdzNXRQcCtxL2RBQkpIaG1MN1duN1NmVUF1?=
 =?utf-8?B?Z083QTB1MXlqc2k4QW5ROFd3TE5rcTdUOUVmVUdXZE1rSkdsVE5QWGhFTEdn?=
 =?utf-8?B?MTRhMnp4dkw3SUtQbTdoMWxKREZrOFU4Nko0WVk3SGNwSW1ZZTArUmJLMWQz?=
 =?utf-8?B?TGY5Y0VGSUx5T282WWkyMk9wMkhrdnZoemFLWnNMRTkvSVNxNzZmZk1Tc041?=
 =?utf-8?B?NGMwV1Z5bDBTdFVFcjNqdy9qUU5Uc0Zoa1ExaE5ZaUZ2MVVKd2JNNzNDMmVa?=
 =?utf-8?B?Y0ZxVjB1azFpam4zOVptaDRRcTlJd2Y2ZDZOMnR0NktoWGFFOG9jb1BmZ1l2?=
 =?utf-8?B?R1dOQjRzQ09vK3c0ckE4ZC9RZW5zeWY3aGNLZDdGdTJVWVRiMWtpSW1hcUZk?=
 =?utf-8?B?WCtlN2tPWnIxekFhbGtISEFsUW5tUlJ5a0MwaUZKZS9rZTdvYm1yVUdNc01o?=
 =?utf-8?B?RllyMHpHTXFuZStFZW9uNlkwR3J2MGxzdWliaGVzdVVWZ2hZczVYMVpXSkx3?=
 =?utf-8?B?RklDYzR6MW9HbitZUlU3b2poaGtad01nWENLTWxXaTA4OExVMjZNTkYvVHZj?=
 =?utf-8?B?RkNqRjBoWTdDVldpSlNRN2VJSVRVK3pSYWJ5MmxNL29Eb3FMUjVvT21CNGZ0?=
 =?utf-8?B?dE5WWTFvaHZldzVENGVTbkFsbjRreE1UanNFYmcxT2Q1VjFCSUxVRWdIclVP?=
 =?utf-8?B?RVl1L01jMjduZkJhSGpTYlhsL0tmRytlZ2pOREt3ZVl0WFJMdlhRdWgwcVEr?=
 =?utf-8?B?SE9WdG5yTEd1S1dYMTNxQnhkQXdydllvM3ZlT1NobXh3Yy9PckdZaHZZMmEw?=
 =?utf-8?B?MUdydzBQWDFXc3VuUE53Q3dsRWxpbXdrY3NYRnh2WGFJclNWQjB0aDR0bmpz?=
 =?utf-8?B?N0dENXVxdnlxVGJOWjBqR0ZvWDZvdUMvQWVxMGxQU0VSZXZFSTd0SFAxMEpW?=
 =?utf-8?B?anh6b0o4N3F5KzgzNkpHK293QWQ1V0ZIUU8rVi8vaGdpUjFlVTE1TmZka2xG?=
 =?utf-8?B?T210VWIyd1lKQ1lnTjNwOUdYdjl3ZWV1TWVNa256VlVIcGY4WmhNVm1ZQVRx?=
 =?utf-8?B?ZlBFVlp4RTJicEpwZi8xZnYzV0FVVFo5RHBNSWVIYytYQkpjUEVOOFpzNEFF?=
 =?utf-8?B?NFNFU0tqOWk0L1JxMldVUWhzd1E3aGZYVk9LcXJkcW5mbXlJelJoM2lwUUhH?=
 =?utf-8?B?c0JJUnFZSUJuajJ4YTZ3L1V2ejE3NUV3K0s5WVB5K1JIQ0pPek1PUGhJOTBZ?=
 =?utf-8?B?VTlCQklYWTkzcTlneW1LQlBveXkyOG5kRnhIVVRoaExvOGdBZTN3VmFKKzRR?=
 =?utf-8?B?elVHQklFaWVhNytUS0VzRWhoa040T0hDQllTb1BsSExXbHdYYXllcURUVXJy?=
 =?utf-8?B?TzBqNFZ6eUJuZW1pcWJ1dGZRME94bWxPYW13anFsYklwc0dGOFpRdXZQbk5s?=
 =?utf-8?B?S1JETDF4WFVFUzNIaFlHTDQrOEY4eVZab3g4RXZocFRXa3U2ME9pelc5ZXFN?=
 =?utf-8?B?dkxYVE9EVGYvb2NldVJNYWpJSHhGMThPLzNPR2NqVXpTcDBaZ1RWdHNmdXh0?=
 =?utf-8?B?ejkxM2xVdFhSckFzZzZtbUNVSjhPbyttVG1hWlkxN0VENzI4OEtmZk8xbnZ0?=
 =?utf-8?B?eFhISmxvWEEwWmhETXMzUjB1RFF6a2pCM1BEODA1SmxGa0lwWGUzWUIyUkRn?=
 =?utf-8?B?QTZzU2FhbkxSdGtBV2d5N2xXWklrcnRjSEVTT28vdEU4NVkzSk0wM3M4R0pw?=
 =?utf-8?B?U2VtbDUxWlhoSHZPa2JBRGdlbWs3Nlluck81TVpJMS84NWU5N1NCbHg1OE9B?=
 =?utf-8?B?QkdJT2Q3NVhsbEYzYjNNelQ0Uks0YlNHdFlRMHE1bW9US0VPTXZXakd2bDU1?=
 =?utf-8?B?VlR4TUdCdkRzeUNRdHhvejNIN1Myb0g5M0FEL2MrVFZHR2RVajRYUGVGdWZq?=
 =?utf-8?Q?WDzIlTmJrtlALSSbCbVdniR/a?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hLQD6868jEU82bsY9aI0t5sy5nEmUKZLXiEaKBfEk6dggRGG+5vHTDYHQKabJqQQ7d/V7FSaPn9BXY1ZG8hGzkw9kjzsxvJMD30mBwc9hLH9qVGD5DNyOkGz53iSBEOm8Qfm7H2EEK+bQJz5BCCNxRpurnVa5D1N5RZ6df6u+LobwUJgebjApuM+1/oUhrBzMlcDgDLv89Bo3nfjP5LVtE904KDbRCi765r34dnzcpcDqDj+r7NfY/7bNaLtZw95sc+IgfFCb4jtBHI+i6KhW2tk3xg/ShdB/ETiN7LWuRLw3DVLT1O14XYsSSCB5dFKH9O/9jNjOIuYHor4t4wSY0dJ1i+cfoF1H9nSdCVX1n+wjKOTOQ+hLP/afYrZNqVflZp0sav8E0lxyLVXzYx4pWl1D8pG+eA+LhZ1kS8XvpjytEZcAp2NR2ch+f3nQSLOQyOb7C8mX5nybpofYduEuX/LOEtcroGXXfRecsd9ca82ozE/mvx5BGB7vcqvym1fhjGxcXiOfT/FTywaS8hdTZHG8QksXZ/0igwW/Gifydafc++OEJJcigUN3Z7Eotyfeuylvuvq6O0RmGRLuuOzi+V2Dap4C0KOWHbDRNGZES2EdidUaMqYFzPrErWgHvfmhWljpnCkPn+ojJuxlrWy5pPwbr80T0wexKYemejgp1MGhnr8hj5KeA665z7iwQ8ZoHLxiXnUY8759t3tot663uWHo1uZOIIMZg+qfL+B6aJTwLgd8SypoYd4GctfEi56uFIJpI/ZIRTv1i3+/Crlv2hF+4KYdXSHEpvHYh8TlFD98U4kuZabt6wIyYVnVIs2jM5gB0KcAzlRKtDxVSuOJCXGf8KAgfIruXhd3HLXF/R3sNu74N2dnIR0g0oc2dH9MFXy2GiUYPRerH4dvj1Mvw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e825d6f-f1a4-4da0-ea55-08dbcf462b9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 19:20:48.9164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uRdwaNnOt8RANPfSDQTf0XLr7GUIzb2YjEBclQAvBfcHkI98N6bq5SqnBtB+TSQhTLKyghW32rJoosx6bmILOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8658
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiB1dGYxNnNfdG9fdXRmOHMgZG9lcyBub3QgTlVMTCB0ZXJtaW5hdGUgdGhlIG91dHB1dCBzdHJp
bmcuIEZvciB1cyB0byBiZSBhYmxlDQo+IHRvIGFkZCBhIE5VTEwgY2hhcmFjdGVyIHdoZW4gdXRm
MTZzX3RvX3V0ZjhzIHJldHVybnMsIHdlIG5lZWQgdG8gbWFrZQ0KPiBzdXJlIHRoYXQgdGhlcmUg
aXMgc3BhY2UgZm9yIHN1Y2ggTlVMTCBjaGFyYWN0ZXIgYXQgdGhlIGVuZCBvZiB0aGUgb3V0cHV0
DQo+IGJ1ZmZlci4gV2UgY2FuIGFjaGlldmUgdGhpcyBieSBwYXNzaW5nIGFuIG91dHB1dCBidWZm
ZXIgc2l6ZSB0bw0KPiB1dGYxNnNfdG9fdXRmOHMgdGhhdCBpcyBvbmUgY2hhcmFjdGVyIGxlc3Mg
dGhhbiB3aGF0IHdlIGFsbG9jYXRlZC4NCj4gDQo+IE90aGVyIGNhbGwgc2l0ZXMgb2YgdXRmMTZz
X3RvX3V0ZjhzIGFwcGVhciB0byBiZSB1c2luZyB0aGUgc2FtZSB0ZWNobmlxdWUNCj4gd2hlcmUg
dGhleSBhcnRpZmljaWFsbHkgcmVkdWNlIHRoZSBidWZmZXIgc2l6ZSBieSBvbmUgdG8gbGVhdmUg
c3BhY2UgZm9yIGENCj4gTlVMTCBjaGFyYWN0ZXIgb3IgbGluZSBmZWVkIGNoYXJhY3Rlci4NCj4g
DQo+IEZpeGVzOiA0YjgyOGZlMTU2YTYgKCJzY3NpOiB1ZnM6IHJldmFtcCBzdHJpbmcgZGVzY3Jp
cHRvciByZWFkaW5nIikNCkkgdGhpbmsgdGhpcyBjb2RlIGdvZXMgYmFjayB0byBjb21taXQgYjU3
M2Q0ODRlNGZmIChzY3NpOiB1ZnM6IGFkZCBzdXBwb3J0IHRvIHJlYWQgZGV2aWNlIGFuZCBzdHJp
bmcgZGVzY3JpcHRvcnMpDQoNClJldmlld2VkLWJ5OiBBdnJpIEFsdG1hbiA8YXZyaS5hbHRtYW5A
d2RjLmNvbT4NCg0KPiBSZXZpZXdlZC1ieTogTWFycyBDaGVuZyA8bWFyc2NoZW5nQGdvb2dsZS5j
b20+DQo+IFJldmlld2VkLWJ5OiBCYXJ0IFZhbiBBc3NjaGUgPGJ2YW5hc3NjaGVAYWNtLm9yZz4N
Cj4gUmV2aWV3ZWQtYnk6IFllbi1saW4gTGFpIDx5ZW5saW5sYWlAZ29vZ2xlLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogRGFuaWVsIE1lbnR6IDxkYW5pZWxtZW50ekBnb29nbGUuY29tPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvdWZzL2NvcmUvdWZzaGNkLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3Vmcy9jb3JlL3Vmc2hjZC5jIGIvZHJpdmVycy91ZnMvY29yZS91ZnNoY2QuYyBpbmRleA0KPiA4
MzgyZThjZmE0MTQuLjU3Njc2NDI5ODJjMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91ZnMvY29y
ZS91ZnNoY2QuYw0KPiArKysgYi9kcml2ZXJzL3Vmcy9jb3JlL3Vmc2hjZC5jDQo+IEBAIC0zNjMy
LDcgKzM2MzIsNyBAQCBpbnQgdWZzaGNkX3JlYWRfc3RyaW5nX2Rlc2Moc3RydWN0IHVmc19oYmEg
KmhiYSwNCj4gdTggZGVzY19pbmRleCwNCj4gICAgICAgICAgICAgICAgICAqLw0KPiAgICAgICAg
ICAgICAgICAgcmV0ID0gdXRmMTZzX3RvX3V0ZjhzKHVjX3N0ci0+dWMsDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdWNfc3RyLT5sZW4gLSBRVUVSWV9ERVNDX0hEUl9T
SVpFLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFVURjE2X0JJR19F
TkRJQU4sIHN0ciwgYXNjaWlfbGVuKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBVVEYxNl9CSUdfRU5ESUFOLCBzdHIsIGFzY2lpX2xlbiAtDQo+ICsgMSk7DQo+IA0K
PiAgICAgICAgICAgICAgICAgLyogcmVwbGFjZSBub24tcHJpbnRhYmxlIG9yIG5vbi1BU0NJSSBj
aGFyYWN0ZXJzIHdpdGggc3BhY2VzICovDQo+ICAgICAgICAgICAgICAgICBmb3IgKGkgPSAwOyBp
IDwgcmV0OyBpKyspDQo+IC0tDQo+IDIuNDIuMC42NTUuZzQyMWYxMmMyODQtZ29vZw0KDQo=
