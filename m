Return-Path: <linux-kernel+bounces-64919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A548544A6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5C51C21271
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B3EBE5B;
	Wed, 14 Feb 2024 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="NSHffhwQ"
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BB911716
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707901727; cv=fail; b=OtFzISC9CMmM7cc/cwjzB0FmZnIgNdnpn+bB+MMX8O5fBHry7vIkrlRDc00EkqbX1jj1wllsAMJpp9GvtX6wdhFDbE9t75HrOnBbyo1iTePwd0yWZSA/eOyN292ho0murr+T3etYCOiQrG1UtKOahqWBv5E+c9PRKoPDInGcrWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707901727; c=relaxed/simple;
	bh=wjf1CuxSWXPVHb9ONIrpCVTzeLKX2ny4QKEBSkIlXaY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WBzRykK2WnOyMexhbtdPuzFRFiA95W+MjPIRuMGjh8e3yJx/2yjNeJXlsGbzvlJ62Fenl/vMMV0porzs3Si91bCRVpFcuL8ZmGYln4ONutHEC8DK/iQZoII1+wS9kHWJCAelV9Pt7BS0MVLhJMHsiV78NihRD88jJ/ecGr7jasI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=NSHffhwQ; arc=fail smtp.client-ip=18.185.115.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.10.186])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 62DE410054A31
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:08:35 +0000 (UTC)
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.199.136])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 721DD10000F7E;
	Wed, 14 Feb 2024 09:08:28 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1707901707.743000
X-TM-MAIL-UUID: aa5decf4-714a-4e54-9a1d-cddd6660aaa7
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id B5AE810001537;
	Wed, 14 Feb 2024 09:08:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irH9r7lGAGEFVms7BWUCsQEBtpmvUtfZa71V/73qbK9/Y5WZUGJugwsgFWfJoH2biXfhYDCTTUB2/M+ifBKkZhxtAAw7ZgDhquophwSnR76z8L+hh3IOn2ysQAQE6rzF69kMXZZ3Q5g6tblmigjiqjpMPBzEV0BAEEXjXCEqpF6CAUb0uZegFI4gZgI7M5Mthd2AHsbUYU5IbPHiYhlsOi4yE3w/4TfJTb+CBXnsgBbzBdNjRvhh+EY4nKOJpl/oiPrZWmci6du0SgkGP0YmIjwJXGhQFmZCyUS9BFwwGG1id0Z3s7dKofes0gZZhK7EOc09QusHMzAivo6W/f4zvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjf1CuxSWXPVHb9ONIrpCVTzeLKX2ny4QKEBSkIlXaY=;
 b=XiMKi/pVB98O1CdtdCrpUdqGSxMwszsOen9GUMvWus5UjSDuaMKkQ1FqZADjjO8hLkGlDpM9Ehmw0TiOpVCbBeYhp/d8c/bTw3pUGZDVOE6iGOScTLADlHnKQ+/Jxu3Z/7Z5BIcpZ9csx6eTo3iSucBSElhV2heYuACrHEG6T5wdFWhjXHvu5q9FCMV6rr9THD5ZuvVngnLuAp7Ht/GM7SG5BVfmmHLsG0zIfnsCMMlFPyMrdeav/bbGKtUcc5eaqXwk63Fq1xR9SU3ukKApKTD6Ej4CWTaU5QRNSBQjgfjzVAZplcdMSbQn9D6jJ0laYLdLmBPYwUYoVcV2bd2tXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
From: Aiswarya Cyriac <Aiswarya.Cyriac@opensynergy.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "perex@perex.cz"
	<perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Anton
 Yakovlev <Anton.Yakovlev@opensynergy.com>, coverity-bot
	<keescook+coverity-bot@chromium.org>, Mikhail Golubev-Ciuchea
	<Mikhail.Golubev-Ciuchea@opensynergy.com>
Subject: Re: [PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op():
 Uninitialized variables" warning.
Thread-Topic: [PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op():
 Uninitialized variables" warning.
Thread-Index: AQHaXlnwumXLUlRI8EyDGVo/HR4isrEH+wuAgAGSox8=
Date: Wed, 14 Feb 2024 09:08:26 +0000
Message-ID:
 <FR3P281MB25272BA9CC886E270EEAE380E64E2@FR3P281MB2527.DEUP281.PROD.OUTLOOK.COM>
References: <20240213085131.503569-1-aiswarya.cyriac@opensynergy.com>
 <20240213035806-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240213035806-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB2527:EE_|FRYP281MB3161:EE_
x-ms-office365-filtering-correlation-id: a0a1ebff-0f7a-48f5-b9c9-08dc2d3c80e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LaYtFc0Zt5UM74NKonGFVHuFbJpDYPhmv7cDnzoy+rql+apZg04AE5QFf4IcNXW9ulnT4vMl8xUamPZQ8DyUWkje+RN8MdyB11Mhhn9xgPkin6WK9sUp7sqXE5FqRiRjPU3LCXeNDfn+nKnnee7okCz0irtfCu7Dh3LBRtd1COM4HduFygk5e5O7zaW7DspKTUaWgKID6d4AatqzHw8BWyoO9LOP/eRHvOI1A73Zm0cywY949QuYEzkc+UzWCDpaxRXFgz/oZGFoJu5S9g20qoKmUciK/kRz+Emh9H3nbgZzSCSuImNJ7DtT8JyYFvUlvbPczZMNZHXHPDqh95GYVJKtcpUDd1T/Fy8U5zWhhny2BV8a4pACcy5sd5jXKtDwylrEGLs4Avn9avEdLPIthB0WjNFEX58wVpDQe5F1BAY1Oll47DbxwvTg3U/ZNx5mdteq55bYR47KDCcJcpY4awHBZQHoZ8Y5mWL+sKg2A1gAXq+3lHiX0IQV+8nU8/zRl7eZ5XkBGMbatfJ6P6QYVb09Qt1WTfjha6lPdPlXRFhHn7W/SuLLzYt6OLXQhVxZjw8gMn5s0XTRBDsr9wOAyncOyKOjFczjt8Q/2Gm/R60=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB2527.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39840400004)(230273577357003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66946007)(76116006)(91956017)(41300700001)(83380400001)(2906002)(5660300002)(66446008)(316002)(66476007)(64756008)(42186006)(66556008)(15974865002)(52536014)(4326008)(8936002)(8676002)(54906003)(86362001)(6916009)(33656002)(71200400001)(26005)(107886003)(55236004)(9686003)(53546011)(38100700002)(122000001)(478600001)(38070700009)(66574015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGNtbStVcDRhRWRzVzVYTHRSR09hb215bHlxYTdkRE9jQi9nVHdmdzM3RW1G?=
 =?utf-8?B?bXh0WVF5UmNKejJ5dlpSRkpuSFhQSlFoQTk3OVlvQW5ZbzdWSEhZR0psUDI2?=
 =?utf-8?B?WXhkUWU1dHBha3V6cFhJUGZMdS9LWVdjcVhIazhicU9rb1p0NjF3aDcwZWRh?=
 =?utf-8?B?bGtqNjFJN2F6SERvQ2FYcE44ZS8wRTNSQkFsUEp3eTNsTXlXL1MrT3doZ3NL?=
 =?utf-8?B?RUMwYUs0SUlSVzNibCt4YkJCbDJ3RFVUZTRnOVhHMHlwak5lWU5Sb0VscWRa?=
 =?utf-8?B?TWxQU2oxQWpyNGFTOU8rbHpJOW5hQ2ZrWFIxYVc2dVpjUi9jbE95eUtpWDBP?=
 =?utf-8?B?anVDVnhRZURUbDdCNVQxQ1hDMlhmV0did0NKcU1aZCtKOThFa3FBY3kyOFRq?=
 =?utf-8?B?S2F2ZFc3QTMxOWY3RXhpdzNCZkMwblZqMUhrcHBTbDhWdGIveXRRSXhVL1NS?=
 =?utf-8?B?a2ZuRmZ0clBidlJJaStkeENYWHF6djBwQ01vZzRrRjRkRXpOOTdCdXlrenp3?=
 =?utf-8?B?bUhGcEZBL3pJKzlLSWYyL2tjTFNvZnY1NEJMMy9UeUwrNkZhYUVrNW9FMEhj?=
 =?utf-8?B?ZU05TjlJMElXUEIxM0V1TjVuSDdHM3E4QXhGVkMwTWRQcnE5ODF6Q0FUMGFZ?=
 =?utf-8?B?Q0h5UU5uTjVFZktIV3VCbmg2aXFvc1p2djVyWUxZa3ZUVlAveENueUp3eVFF?=
 =?utf-8?B?MDhLOHdBSGQ4dUgxaUpORVI2SVdBUmRnTFVtVk9ucmhiRmFHVmpIVmh4ZzJD?=
 =?utf-8?B?RHpkNXUzdmRFelpybXVnektvV2o5cnBoNGFReGg5WmZXZWRBcHBoL0kyMkwv?=
 =?utf-8?B?UHUveWJXMC85eHYva2hLWSt6Sldiamc4NTFnVTVSbzFhUHVUREZsZVVVOVBr?=
 =?utf-8?B?L0hSaU9UaTRoRTF6MmRXRTROb2ltMXZtdDBHTUFIZDhxbFFQaTdwbjFTRXUr?=
 =?utf-8?B?c0xGdzMweWxxMGE0QUM5Mi8zTkRSNUwzMC9MamtoN3lyTEwxOElBRG5hbkhQ?=
 =?utf-8?B?UzlkaTJEUWxnUCs1WTN5dXVZS3hqY3FRR1djZG9lbDJtbWJsMmkzUEJ4RFcx?=
 =?utf-8?B?NXN5RnhzbkRPRGlDVURmQ3pFMWJHeE1sMGNuT0N3MUlkWDZRZHBxQ2VxU0Vr?=
 =?utf-8?B?RlNSbTE3ZDMydzRWWG5LVTE4WDlQZkg2dzJDeEFZRTNLZStkYTYvNTJlbW12?=
 =?utf-8?B?N1BYQytOa2dzOWpIdmpZL2YydFFIa2x3eHY4dG95WGVucy90VWJ2MW82MkZS?=
 =?utf-8?B?KzJPQ1dORjQxNkNDUjdQOVU3emo1UVowc1RBTENjTkFIcllONjFxVjdCS2xX?=
 =?utf-8?B?ZzZOcmQ4RUZmTWN4Tkd1ZXUxYzRwQVdaMjROb0hmU1ZDMTM1K05QNEpzQ205?=
 =?utf-8?B?NlEvQUdHbXd6a0pTSVhXNUhiQzJhQ1JSbSs1dGRoYWxoWEVuOTJqUEM2NVls?=
 =?utf-8?B?MzFYT2U0WGpuV2V4aFRoZm1MNGxYU2pqdW9nRDBaZnhvaEdmdFNZNm1aemho?=
 =?utf-8?B?TStINzBIbEtCMGpZYzJlay9RRVUwOEtEcVV3RUkveC9CY1Y5QWszZS9hK0hM?=
 =?utf-8?B?QUI4N3V6NU9ZUm9Qdk8xY1JVWE5hZDBRbTg5b2xnbWNqc09SY2gyRTZXYlp4?=
 =?utf-8?B?bmpSOExLV0xFSmd4VWJJTVlTdjFMRXI5bkpSRHk0bkZkREEvYkVCMnU1STVB?=
 =?utf-8?B?T1dKZ0JOR0VJMUdwRkpmRHBkT1hXajhhK0Q4MFRZSXcvb2huRUp4N1ZHMkw1?=
 =?utf-8?B?bEdGa0J0c2tnZmVxbVZ4WWliR0lXdTZDd2NRalE0Qzg1WU9qT0Q3YTQxNmVk?=
 =?utf-8?B?WERSV2NzeG5HTHhEYytoVW51dDVyQ09JT1FYMEZNWTBtSkZ5SlllN0E0SFRl?=
 =?utf-8?B?eVNMYnpvMXJlODJoUmpLQ1cwTlIxa0Z6OTBMazRtMVFyMWtrRTBMdlZZR0U0?=
 =?utf-8?B?aGU5NmFSajNXa1pORmtPS3BUSDJSd2RFZFZwSndRRUhSRmczbGpSZmVJQ0V2?=
 =?utf-8?B?a1BGcU9ORHFGSUxNdlNBVjFhcVFzRjZOVDlmcnJRVDBkY1VIMyt3RVRxRHJG?=
 =?utf-8?B?cHgwN1MzNVpUNFRFZ09YVXdoYWg3WUZsWE93RGdBbWxvNzV6ejhPY0taQUFo?=
 =?utf-8?Q?MPBM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB2527.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a1ebff-0f7a-48f5-b9c9-08dc2d3c80e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2024 09:08:26.3268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VlvVp2We7S7WcPAG7GqvZDIKwi2p6S2X/MAGwqzFTSDI74JbVFMON0y4BSPiv5eabzMgeWbaaU+CT2wMZAy7PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB3161
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28190.006
X-TMASE-Result: 10--20.700700-4.000000
X-TMASE-MatchedRID: dL10VBB8yodCD2A4wqgJu400PILgpqtbwowsbJRkKzk32MNYHthSkwDP
	bjs0elTcHe/Upp/4ecSYpshGKPqYF8YDrGYMIhU0nRTJpY7VAKclC02Y8wtl3zAPdWnwC9eDJQk
	txNYzOLONk6CnOOT0tJ4u7onx25MlSGzHQK3NWLsnDrpxCH9Hl2StUhdkd3nYBK4oo7tJnZEIzZ
	QUPW10lGpsf9ill7qA/SVxq7nB4ndxcvc/d2qgHDvQG0xdFpDCEpRQcMr0mi7UxxaDlU1Cjx1Ix
	cyWa+RZODzw2zhU/jSkEwwiLfZvaSiPWGNLcXU6UlO0zoIcpU6B1fO2o4QGcA/b3t9WxHC2EMS6
	8y17Xslu5Klvssxgy7LXvs9okX5VqIpjxEoeciFyIoQdDbaH+hEpiC9sFr1z6OVVbPUdUDY3YHm
	XJWZ2yxahR82zXng1ua1cy7E5WMtHPX+SmBBQVQLM3qrYpxJ7iZ5bcWVVE8A+0J9ZTAkB2Lf2ry
	HsrOL4OUNM7PeW/7/rEDQC9rvecFw6eqmDL5urkcN38V3mAjajg0lrtKMWyrGUhQPYQJHNTvOSX
	KE9MP1vXWAjKN//C7/a0nd+hIFCwPd9fpjXfbAWefvMt+drgg==
X-TMASE-XGENCLOUD: 45e607e3-5474-45fc-8116-773c9f758a1c-0-0-200-0
X-TM-Deliver-Signature: FD50801FEB734037DCFFF5CF53FF2479
X-TM-Addin-Auth: Cc3xNSo8L5ExjmdoMeJkV7S99HglQv69LvLt/k52XCL1bx3E0aZWV7MUFl/
	D0jlrNVKDQXJyw1tFWZSFQB6lpGFkYSiKL/RvjYaftGpNuU0T/ohNX19Sz3qSFD1rHDc7Zndy0o
	djxHz2VUGcYcfa0F87RyIUA/3FfqJN1KxgZ0rA0r4zaEBPvFZlPAaMrJaJhWUq3HBYEsqBwEnjU
	5QvwcZNqBta3nDORiFhC65yICwOIxpLDVzgLAL9si+lKZgZtEyQx5vOLxAEnvrYEW8I9xW9iMci
	12U8zPCmy575KJMD+dG66xtffmOVjIs0KChf0rSzXd1bmzh2EMdZw53dcw==.kVXi7vA30NMJj0
	0yetn1EJtMkuiVQ5VyjkncEvnBFjIiWiNZ3mBaKuSBCM+12iGDsPMaZsZ1qiS6yHerX37hrND2Q
	zWG06YeSM6GdBoeg2xBaY6lOsWcQzLYAv1gY4iv6LyZx03nXQHK+XqFVg4EXaGPknPmCacb852N
	tVZHg2+s5LxQY6e+YFU/kclf70AS+JQ+CLUKwMLZ/wRd8ty4iB2fII18KKSkyjLOKH5BwUKHbQC
	6PzL5zL0+zKtMtoFcA3TutS0Zi6ABs3QqFCzT0RZQfjIRRWCrKmMiOcncMXDDlKvOpvUT+GG25e
	gqYV9fwLZGStIMtDN088meSEZsPA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1707901708;
	bh=wjf1CuxSWXPVHb9ONIrpCVTzeLKX2ny4QKEBSkIlXaY=; l=7702;
	h=From:To:Date;
	b=NSHffhwQjz+kGarA/07HgrQzvJusprY9d/xsh5RU4tRpphKEL0MHqYSLYejaRT1Ei
	 UUBQ9XGR3QeEsohqY8GZ9ipWeBEDXqJkd3t2zAeefhSiVfABvnDAe5rESHe2L+IC46
	 tznAK8V57P7u88dUtTlQrnvFp/VcXutI9Q1hd2IWLCJYaJlJrFw1tHCEAyyGNJgMcD
	 4NixnSygEVhGer088xkeQvK1i0o+pSsTS0x9SyCszJJF6Kjr4MMVMiEs2qwV+JsyBt
	 1xdXIdUdgTSNIJfU1rPKVzJRvb2D+OnunDR/y/VGh57a6PsjUB12bf3v9Q7BdKvRwM
	 ja91AYa61smhQ==

SGkgTWljaGFlbCwNCg0KVGhhbmsgeW91IGZvciByZXZpZXdpbmcuIEkgaGF2ZSB1cGRhdGVkIG15
IHJlc3BvbnNlIGlubGluZQ0KDQpPbiBUdWUsIEZlYiAxMywgMjAyNCBhdCAwOTo1MTozMEFNICsw
MTAwLCBBaXN3YXJ5YSBDeXJpYWMgd3JvdGU6DQo+PiBGaXggdGhlIGZvbGxvd2luZyB3YXJuaW5n
IHdoZW4gYnVpbGRpbmcgdmlydGlvX3NuZCBkcml2ZXIuDQo+Pg0KPj4gIg0KPj4gKioqIENJRCAx
NTgzNjE5OiAgVW5pbml0aWFsaXplZCB2YXJpYWJsZXMgIChVTklOSVQpDQo+PiBzb3VuZC92aXJ0
aW8vdmlydGlvX2tjdGwuYzoyOTQgaW4gdmlydHNuZF9rY3RsX3Rsdl9vcCgpDQo+PiAyODgNCj4+
IDI4OSAgICAg4oCD4oCD4oCD4oCDYnJlYWs7DQo+PiAyOTAgICAgIOKAg+KAg30NCj4+IDI5MQ0K
Pj4gMjkyICAgICDigIPigINrZnJlZSh0bHYpOw0KPj4gMjkzDQo+PiB2dnYgICAgIENJRCAxNTgz
NjE5OiAgVW5pbml0aWFsaXplZCB2YXJpYWJsZXMgIChVTklOSVQpDQo+PiB2dnYgICAgIFVzaW5n
IHVuaW5pdGlhbGl6ZWQgdmFsdWUgInJjIi4NCj4+IDI5NCAgICAg4oCD4oCDcmV0dXJuIHJjOw0K
Pj4gMjk1ICAgICB9DQo+PiAyOTYNCj4+IDI5NyAgICAgLyoqDQo+PiAyOTggICAgICAqIHZpcnRz
bmRfa2N0bF9nZXRfZW51bV9pdGVtcygpIC0gUXVlcnkgaXRlbXMgZm9yIHRoZSBFTlVNRVJBVEVE
IGVsZW1lbnQgdHlwZS4NCj4+IDI5OSAgICAgICogQHNuZDogVmlydElPIHNvdW5kIGRldmljZS4N
Cj4+ICINCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBBbnRvbiBZYWtvdmxldiA8YW50b24ueWFrb3Zs
ZXZAb3BlbnN5bmVyZ3kuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogQWlzd2FyeWEgQ3lyaWFjIDxh
aXN3YXJ5YS5jeXJpYWNAb3BlbnN5bmVyZ3kuY29tPg0KPj4gUmVwb3J0ZWQtYnk6IGNvdmVyaXR5
LWJvdCA8a2Vlc2Nvb2srY292ZXJpdHktYm90QGNocm9taXVtLm9yZz4NCj4+IEFkZHJlc3Nlcy1D
b3Zlcml0eS1JRDogMTU4MzYxOSAoIlVuaW5pdGlhbGl6ZWQgdmFyaWFibGVzIikNCj4+IEZpeGVz
OiBkNjU2OGUzZGU0MmQgKCJBTFNBOiB2aXJ0aW86IGFkZCBzdXBwb3J0IGZvciBhdWRpbyBjb250
cm9scyIpDQoNCj5JIGRvbid0IGtub3cgZW5vdWdoIGFib3V0IEFMU0EgdG8gc2F5IHdoZXRoZXIg
dGhlIHBhdGNoIGlzIGNvcnJlY3QuICBCdXQNCj50aGUgY29tbWl0IGxvZyBuZWVkcyB3b3JrOiBw
bGVhc2UsIGRvIG5vdCAiZml4IHdhcm5pbmdzIiAtIGFuYWx5c2UgdGhlDQo+Y29kZSBhbmQgZXhw
bGFpbiB3aGV0aGVyIHRoZXJlIGlzIGEgcmVhbCBpc3N1ZSBhbmQgaWYgeWVzIHdoYXQgaXMgaXQN
Cj5hbmQgaG93IGl0IGNhbiB0cmlnZ2VyLiBJcyBhbiBpbnZhbGlkIG9wX2ZsYWcgZXZlciBwYXNz
ZWQ/DQo+SWYgaXQncyBqdXN0IGEgY292ZXJpdHkgZmFsc2UgcG9zaXRpdmUgaXQgbWlnaHQgYmUg
b2sgdG8NCj53b3JrIGFyb3VuZCB0aGF0IGJ1dCBkb2N1bWVudCB0aGlzLg0KDQpUaGlzIHdhcm5p
bmcgaXMgY2F1c2VkIGJ5IHRoZSBhYnNlbmNlIG9mIHRoZSAiZGVmYXVsdCIgYnJhbmNoIGluIHRo
ZQ0Kc3dpdGNoLWJsb2NrLCBhbmQgaXMgYSBmYWxzZSBwb3NpdGl2ZSBiZWNhdXNlIHRoZSBrZXJu
ZWwgY2FsbHMNCnZpcnRzbmRfa2N0bF90bHZfb3AoKSBvbmx5IHdpdGggdmFsdWVzIGZvciBvcF9m
bGFnIHByb2Nlc3NlZCBpbg0KdGhpcyBibG9jay4NCkkgd2lsbCB1cGRhdGUgdGhlIGZpeCBhbmQg
c2VuZCBhIHYyIHBhdGNoDQoNCj4+IC0tLQ0KPj4gIHNvdW5kL3ZpcnRpby92aXJ0aW9fa2N0bC5j
IHwgNSArKysrKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4+DQo+PiBk
aWZmIC0tZ2l0IGEvc291bmQvdmlydGlvL3ZpcnRpb19rY3RsLmMgYi9zb3VuZC92aXJ0aW8vdmly
dGlvX2tjdGwuYw0KPj4gaW5kZXggMGM2YWM3NGFjYTFlLi5kN2ExNjBjNWRiMDMgMTAwNjQ0DQo+
PiAtLS0gYS9zb3VuZC92aXJ0aW8vdmlydGlvX2tjdGwuYw0KPj4gKysrIGIvc291bmQvdmlydGlv
L3ZpcnRpb19rY3RsLmMNCj4+IEBAIC0yODYsNiArMjg2LDExIEBAIHN0YXRpYyBpbnQgdmlydHNu
ZF9rY3RsX3Rsdl9vcChzdHJ1Y3Qgc25kX2tjb250cm9sICprY29udHJvbCwgaW50IG9wX2ZsYWcs
DQo+PiAgICAgICAgICAgICAgICBlbHNlDQo+PiAgICAgICAgICAgICAgICAgICAgICAgIHJjID0g
dmlydHNuZF9jdGxfbXNnX3NlbmQoc25kLCBtc2csICZzZywgTlVMTCwgZmFsc2UpOw0KPj4NCj4+
ICsgICAgICAgICAgICAgYnJlYWs7DQo+PiArICAgICBkZWZhdWx0Og0KPj4gKyAgICAgICAgICAg
ICB2aXJ0c25kX2N0bF9tc2dfdW5yZWYobXNnKTsNCj4+ICsgICAgICAgICAgICAgcmMgPSAtRUlO
VkFMOw0KPj4gKw0KDQo+VGhlcmUncyBhbHJlYWR5IHZpcnRzbmRfY3RsX21zZ191bnJlZiBjYWxs
IGFib3ZlLg0KPkFsc28gZG9uJ3Qgd2UgbmVlZCB2aXJ0c25kX2N0bF9tc2dfdW5yZWYgb24gb3Ro
ZXIgZXJyb3IgcGF0aHMNCj5zdWNoIGFzIEVGQVVMVD8NCj5VbmlmeSBlcnJvciBoYW5kbGluZyB0
byBmaXggaXQgYWxsIHRoZW4/DQoNClRoaXMgYWxzbyBuZWVkIHRvIGJlIGhhbmRsZWQgYW5kIHZp
cnRzbmRfY3RsX21zZ191bnJlZiBuZWVkZWQgaW4gY2FzZSBvZiBFRkFVTFQgYXMgd2VsbC4NCkkg
d2lsbCB1cGRhdGUgdGhlIHBhdGNoLg0KDQoNClRoYW5rcywNCkFpc3dhcnlhIEN5cmlhYw0KU29m
dHdhcmUgRW5naW5lZXINCuKAiw0KT3BlblN5bmVyZ3kgR21iSA0KUm90aGVyc3RyLiAyMCwgMTAy
NDUgQmVybGluDQoNCkVNYWlsOiBhaXN3YXJ5YS5jeXJpYWNAb3BlbnN5bmVyZ3kuY29tDQoNCnd3
dy5vcGVuc3luZXJneS5jb20NCkhhbmRlbHNyZWdpc3Rlci9Db21tZXJjaWFsIFJlZ2lzdHJ5OiBB
bXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZywgSFJCIDEwODYxNkINCkdlc2Now6RmdHNmw7xocmVy
L01hbmFnaW5nIERpcmVjdG9yOiBSw6lnaXMgQWRqYW1haA0KDQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fDQpGcm9tOiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRo
YXQuY29tPg0KU2VudDogVHVlc2RheSwgRmVicnVhcnkgMTMsIDIwMjQgMTA6MDYgQU0NClRvOiBB
aXN3YXJ5YSBDeXJpYWMNCkNjOiBqYXNvd2FuZ0ByZWRoYXQuY29tOyBwZXJleEBwZXJleC5jejsg
dGl3YWlAc3VzZS5jb207IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGFsc2EtZGV2ZWxA
YWxzYS1wcm9qZWN0Lm9yZzsgdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmc7IHZpcnRpby1kZXZAbGlzdHMub2FzaXMtb3Blbi5vcmc7IEFudG9uIFlha292bGV2OyBjb3Zl
cml0eS1ib3QNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIEFMU0E6IHZpcnRpbzogRml4ICJDb3Zlcml0
eTogdmlydHNuZF9rY3RsX3Rsdl9vcCgpOiBVbmluaXRpYWxpemVkIHZhcmlhYmxlcyIgd2Fybmlu
Zy4NCg0KT24gVHVlLCBGZWIgMTMsIDIwMjQgYXQgMDk6NTE6MzBBTSArMDEwMCwgQWlzd2FyeWEg
Q3lyaWFjIHdyb3RlOg0KPiBGaXggdGhlIGZvbGxvd2luZyB3YXJuaW5nIHdoZW4gYnVpbGRpbmcg
dmlydGlvX3NuZCBkcml2ZXIuDQo+DQo+ICINCj4gKioqIENJRCAxNTgzNjE5OiAgVW5pbml0aWFs
aXplZCB2YXJpYWJsZXMgIChVTklOSVQpDQo+IHNvdW5kL3ZpcnRpby92aXJ0aW9fa2N0bC5jOjI5
NCBpbiB2aXJ0c25kX2tjdGxfdGx2X29wKCkNCj4gMjg4DQo+IDI4OSAgICAg4oCD4oCD4oCD4oCD
YnJlYWs7DQo+IDI5MCAgICAg4oCD4oCDfQ0KPiAyOTENCj4gMjkyICAgICDigIPigINrZnJlZSh0
bHYpOw0KPiAyOTMNCj4gdnZ2ICAgICBDSUQgMTU4MzYxOTogIFVuaW5pdGlhbGl6ZWQgdmFyaWFi
bGVzICAoVU5JTklUKQ0KPiB2dnYgICAgIFVzaW5nIHVuaW5pdGlhbGl6ZWQgdmFsdWUgInJjIi4N
Cj4gMjk0ICAgICDigIPigINyZXR1cm4gcmM7DQo+IDI5NSAgICAgfQ0KPiAyOTYNCj4gMjk3ICAg
ICAvKioNCj4gMjk4ICAgICAgKiB2aXJ0c25kX2tjdGxfZ2V0X2VudW1faXRlbXMoKSAtIFF1ZXJ5
IGl0ZW1zIGZvciB0aGUgRU5VTUVSQVRFRCBlbGVtZW50IHR5cGUuDQo+IDI5OSAgICAgICogQHNu
ZDogVmlydElPIHNvdW5kIGRldmljZS4NCj4gIg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbnRvbiBZ
YWtvdmxldiA8YW50b24ueWFrb3ZsZXZAb3BlbnN5bmVyZ3kuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBBaXN3YXJ5YSBDeXJpYWMgPGFpc3dhcnlhLmN5cmlhY0BvcGVuc3luZXJneS5jb20+DQo+IFJl
cG9ydGVkLWJ5OiBjb3Zlcml0eS1ib3QgPGtlZXNjb29rK2NvdmVyaXR5LWJvdEBjaHJvbWl1bS5v
cmc+DQo+IEFkZHJlc3Nlcy1Db3Zlcml0eS1JRDogMTU4MzYxOSAoIlVuaW5pdGlhbGl6ZWQgdmFy
aWFibGVzIikNCj4gRml4ZXM6IGQ2NTY4ZTNkZTQyZCAoIkFMU0E6IHZpcnRpbzogYWRkIHN1cHBv
cnQgZm9yIGF1ZGlvIGNvbnRyb2xzIikNCg0KSSBkb24ndCBrbm93IGVub3VnaCBhYm91dCBBTFNB
IHRvIHNheSB3aGV0aGVyIHRoZSBwYXRjaCBpcyBjb3JyZWN0LiAgQnV0DQp0aGUgY29tbWl0IGxv
ZyBuZWVkcyB3b3JrOiBwbGVhc2UsIGRvIG5vdCAiZml4IHdhcm5pbmdzIiAtIGFuYWx5c2UgdGhl
DQpjb2RlIGFuZCBleHBsYWluIHdoZXRoZXIgdGhlcmUgaXMgYSByZWFsIGlzc3VlIGFuZCBpZiB5
ZXMgd2hhdCBpcyBpdA0KYW5kIGhvdyBpdCBjYW4gdHJpZ2dlci4gSXMgYW4gaW52YWxpZCBvcF9m
bGFnIGV2ZXIgcGFzc2VkPw0KSWYgaXQncyBqdXN0IGEgY292ZXJpdHkgZmFsc2UgcG9zaXRpdmUg
aXQgbWlnaHQgYmUgb2sgdG8NCndvcmsgYXJvdW5kIHRoYXQgYnV0IGRvY3VtZW50IHRoaXMuDQoN
Cg0KPiAtLS0NCj4gIHNvdW5kL3ZpcnRpby92aXJ0aW9fa2N0bC5jIHwgNSArKysrKw0KPiAgMSBm
aWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvc291bmQvdmly
dGlvL3ZpcnRpb19rY3RsLmMgYi9zb3VuZC92aXJ0aW8vdmlydGlvX2tjdGwuYw0KPiBpbmRleCAw
YzZhYzc0YWNhMWUuLmQ3YTE2MGM1ZGIwMyAxMDA2NDQNCj4gLS0tIGEvc291bmQvdmlydGlvL3Zp
cnRpb19rY3RsLmMNCj4gKysrIGIvc291bmQvdmlydGlvL3ZpcnRpb19rY3RsLmMNCj4gQEAgLTI4
Niw2ICsyODYsMTEgQEAgc3RhdGljIGludCB2aXJ0c25kX2tjdGxfdGx2X29wKHN0cnVjdCBzbmRf
a2NvbnRyb2wgKmtjb250cm9sLCBpbnQgb3BfZmxhZywNCj4gICAgICAgICAgICAgICBlbHNlDQo+
ICAgICAgICAgICAgICAgICAgICAgICByYyA9IHZpcnRzbmRfY3RsX21zZ19zZW5kKHNuZCwgbXNn
LCAmc2csIE5VTEwsIGZhbHNlKTsNCj4NCj4gKyAgICAgICAgICAgICBicmVhazsNCj4gKyAgICAg
ZGVmYXVsdDoNCj4gKyAgICAgICAgICAgICB2aXJ0c25kX2N0bF9tc2dfdW5yZWYobXNnKTsNCj4g
KyAgICAgICAgICAgICByYyA9IC1FSU5WQUw7DQo+ICsNCg0KVGhlcmUncyBhbHJlYWR5IHZpcnRz
bmRfY3RsX21zZ191bnJlZiBjYWxsIGFib3ZlLg0KQWxzbyBkb24ndCB3ZSBuZWVkIHZpcnRzbmRf
Y3RsX21zZ191bnJlZiBvbiBvdGhlciBlcnJvciBwYXRocw0Kc3VjaCBhcyBFRkFVTFQ/DQpVbmlm
eSBlcnJvciBoYW5kbGluZyB0byBmaXggaXQgYWxsIHRoZW4/DQoNCj4gICAgICAgICAgICAgICBi
cmVhazsNCj4gICAgICAgfQ0KPg0KPiAtLQ0KPiAyLjQzLjANCg0KDQo=

