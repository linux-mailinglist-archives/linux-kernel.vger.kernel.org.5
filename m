Return-Path: <linux-kernel+bounces-65247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75427854A0D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E7D1C21CE4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C225338B;
	Wed, 14 Feb 2024 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="rIutN6cd"
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914C55336C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707916074; cv=fail; b=r7r90x8VflSVcf9ZDxtEDWYNyYXJjtAzTDYM0AefG++H09NcECPMiQviHnIAWmlVBRwlf52g2y2INFmUhKJkFYzghxXsbXpEdFRve5r2j02NmWiE44mut0Zq0i82VccQG/dDNRk76PASrrEU7W3jmVNSB3QHdzpq/QsN7O6/E2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707916074; c=relaxed/simple;
	bh=qvbiSrhy2KNV2E6WdGBDtSYTujoGpSQ38tHplogFmz4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oWDWBJlsFt56lTuBw91UyOD7vgkBtHSXI2okOOW5q23pUgpzuCgBkTrdq7Fp/lDkOF7wuhR8mjB5lykIeA5mPcdETmr9uqfq0+7DYdxjF4R0c0+TOE0xO4k4EhcxIbj9tP7J+ZHqmdPy5ij8aeBO7DowZKm0Ugs5/oMBGI4QTHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=rIutN6cd; arc=fail smtp.client-ip=18.185.115.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.19.113])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 10F37100E611E
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:07:49 +0000 (UTC)
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.176.220])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 904F51000063C;
	Wed, 14 Feb 2024 13:07:41 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1707916061.206000
X-TM-MAIL-UUID: bd29ccc0-06a3-4ad6-856c-de137039ed76
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 3260510002B97;
	Wed, 14 Feb 2024 13:07:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ba8EFVP/F0EDeRYSAAjnI3ZIJ9SMKCaLv/XAd49zU9Bhf7Sa9Q+25zMkTkZ1zLQw8G/34/II5fy+tzFrB3uddciAsZzPRs26mTRrsDBEumNPNP2bKfGDqyvVitNBZrhX47TSPDpZ/5bCAcQlX0FNwbH54s+NRatibzAqprBEOpLWHrqFH/2UHbhKPdZtgdWtV5sk1YnukIKqHocLnQ09pUaTpkAywexbj6E7T6N/A0kGVpI53Rqzm+n+93aqDQ++q1iF10Nx8/LKhuHdu1Cx32G6rpB22Yvi6DPdm40KcW7i85PItOUlxt3zFyhNuSEuMCApxTrpPVCd9cgKzu44Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvbiSrhy2KNV2E6WdGBDtSYTujoGpSQ38tHplogFmz4=;
 b=CkPS5zMuzfP+YZN+dvPEQ2VgM+dagSvPBeL+ESdRspxgJyxO9oIrGVw7Najdj/qvbcEuMuCu1wOg+v/M7nizXpsGj9MXSKPes7eHBw7175vaMknlVAxHy1yZjB7CC4ezAz3kQzU8muPLyUi2sbskauX2uhl0/s+zTTHHrzwEfOoAqMi1WcFhWiKIJhqZFwO5djD9+z4hpLRsG2Xc9Qv8Jknop0ZFTXa0Ipzkr+loyQC0lR7T60zg7xh7x4Lkv2Z9tXKPcLg6EPOOBK6FsvyNhjIPyUiYR3fG6hPQxVGT9ruamKtnGVWkX4JXVOb1IiiJJMMYGUpxqkYVVQdUDCkiZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
From: Aiswarya Cyriac <Aiswarya.Cyriac@opensynergy.com>
To: Takashi Iwai <tiwai@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>
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
Thread-Index: AQHaXzo9/mMjfDpT8U6+iZf3cE6MlbEJzbbH
Date: Wed, 14 Feb 2024 13:07:40 +0000
Message-ID:
 <FR3P281MB2527A0498C3B1E3899087028E64E2@FR3P281MB2527.DEUP281.PROD.OUTLOOK.COM>
References: <20240213085131.503569-1-aiswarya.cyriac@opensynergy.com>
	<20240213035806-mutt-send-email-mst@kernel.org>
	<FR3P281MB25272BA9CC886E270EEAE380E64E2@FR3P281MB2527.DEUP281.PROD.OUTLOOK.COM>
	<20240214062348-mutt-send-email-mst@kernel.org> <871q9fi8dw.wl-tiwai@suse.de>
In-Reply-To: <871q9fi8dw.wl-tiwai@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB2527:EE_|FR0P281MB2048:EE_
x-ms-office365-filtering-correlation-id: 24a88b68-72f1-4012-957f-08dc2d5dec69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 H9FdZHfANj4fO/sPoNojwWLGcnzRoOCWzWxC0o+dRsCb3FAdOVBQWn6XVNEt+peDP+ohXgR/cQ+5WJkoyEDTSE3WWAjib/g/+880ZuOQ0Ide0WMEpKArl3CGF6sADiLabCQRXWjxeFO8QEYz/oMVauuU7afWikjetHA4l/srZ8dyHe0phmoVP0daJNuWEchTXgrWct2aNgzHMYsc+ONJOF+EhKiMEf8C17kjU+TyZ0reZFslcCeuldJep1FssMqSIZE2Txu9Fe1bIbc4WFY9r03oLAYBSLrXS1DFHSGKHO5J+FX+VBRRtQm4o0TzO8KnsDDMOb+6wwX1ry0r4cCZyi5Jxp9EaZSUL0WZPx+5tD2T21aO4aOuNETlGMc/yXw3UqqzhC1mlbj6/Y+/zP4Jr2FLnexmoD5Utu3DgXwmYG4ihBHs737sdqbbQX1+oneJIkYOOaa7UJ9pRqKCU/C7VjJCJ3wGtrb7tO9A3df2oXDqzxKe/xWlHulAfBN4qkIn1IxOCukD0IWsYChIfQQ+q6fKY+sr42KVzu3k3i8fF8UdYRXU07gJDoIfrtLoCM33Zrmfj+zT1p7SySrS6qb6vZT7ytMi6gWbLDYvKR3ak5tDzPLLfC6ODupiuUor7HWo
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB2527.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39840400004)(366004)(396003)(230922051799003)(230273577357003)(64100799003)(1800799012)(451199024)(186009)(2906002)(7416002)(107886003)(83380400001)(478600001)(8676002)(71200400001)(38070700009)(76116006)(66476007)(66446008)(5660300002)(4326008)(8936002)(66556008)(64756008)(52536014)(26005)(91956017)(66946007)(33656002)(41300700001)(122000001)(110136005)(38100700002)(9686003)(42186006)(54906003)(316002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YjFndUNabVRqRHlZYjF4NXl0djhmU3l5WWF4Q1NXUllkOGpTZUUzNU42ZVNp?=
 =?utf-8?B?U0dJcE9WM3YvZWluMzJJdHh0Rk1EamhyaVJ0S1VjY2orazUremw4VVJKYVRo?=
 =?utf-8?B?OHFUazQvaGxRSWhPa09KcHd1NnMrNkZJOXF0aXVYRjRGZ2dxUmZnaDQwdFJV?=
 =?utf-8?B?V2xjdnJDOUZ4UWNKUFIvS1RuNFRSK3EzaUxNUXhKYTBaTWxRZGEvdFBWb2h5?=
 =?utf-8?B?c25rWXBzaWZCSmNibkdaTlJVQU1FSXhUK3pkaksvRi9UdjY5VXM3c3hHTUR6?=
 =?utf-8?B?K2hmb3hTaVVNRGw3OGxxQm1kQmJYWm9YazczTDdKRWtWWVMrdndic2ppV3pj?=
 =?utf-8?B?amVHTlNuTzdPSnB4MWN1aU45dllSQWtydzU2WUJqcDdDK1MyMUZHeUZnMWFG?=
 =?utf-8?B?VlFJNGR5dEp2NFpMR25LUFM4MmJ1V1JJbUoybkxaK1BybTRoNXFnc01SS0VQ?=
 =?utf-8?B?QjRrVjBFWUo2eE5pQzVWU0lpNHMwazZZTUE2ZkIveHkvK3U5YTRVVlFHSHBp?=
 =?utf-8?B?aXcvVXppak1NcnNYbnBWWklQMzRHWUVUY01EcnpIWk9CUUtTek9BU0hhTnNC?=
 =?utf-8?B?bGQrWTR2QS8rOXVUMzdocVNSTDBQNlRSSTVUSkNzd2JFVUM5d2lKYkswc2pO?=
 =?utf-8?B?WHVDR29TNFJwUGd1cDh4WTRPdHVxVTBaaVNYOGl0N3Z5cU1QSS9Zem5scWNF?=
 =?utf-8?B?dHFTeWxuaExOTnhGZ2tmU1VqUXgwRU5QZFE4Zjd0dUFYK01SV25wdUhSaWRV?=
 =?utf-8?B?Yk9qYWtXZnRTMGEwMGdldE9KazEwNUdHVlgwc0dTbmYvdS9TblMyVTl1ajVQ?=
 =?utf-8?B?aGNUemRWK0dXdVZaOEl2YkgxM2c1a1pHaFM2aHl4ME91UVhZYVljWlBSSFVw?=
 =?utf-8?B?VmFnZmwzV2hCNS9PTS9XNC9MTDVZWjd2bk5udWU5ajFsdWcrUEJyRlJvTDQz?=
 =?utf-8?B?My9MQVpZb2tBL1hoaTdGeFM0ME5HcUVaSmxLU251SEJFZFc0OVRWTzlzR0F3?=
 =?utf-8?B?ckJ3TERXRDF6UjlsdFNjalFPeVdqdnNVb0FyeDJobzRlbjNGWjNmSkdKcHNH?=
 =?utf-8?B?M0dZWnZRMUN2S1NYckVoSTRTajIrQ1IzQ2NWdVp5VVZQT3hvZmw3TUJKMHJn?=
 =?utf-8?B?eDNKRUFMV1JKNWFSd2R1czh0TGM2Uy9mZ2FXVnRUZVUrbGN6ME5jdjBsN0Zn?=
 =?utf-8?B?dnhnTUszeWowTU5rUEtwa0ZCeXQ4OThwaDRldmxkVk1DY3RQWFVBa2pvQlFW?=
 =?utf-8?B?djZpWk5KSGZFWTNGaTFOVll6U2l0QTNMRWg4TzlXZGRqeEhuR2lENzVxdUNK?=
 =?utf-8?B?NHdHT21yejNwQ0c1b3dIMlRtY25tR2xYbVNTOG5YVGlsUENHUW0rR0NqK2sz?=
 =?utf-8?B?ZC8wSEJuZUJ1Nmx1OFYvWDNwbEJCWXkwS2lEUE5EaEtDYTI5UTFMVkZoSVcw?=
 =?utf-8?B?aWFGNEdTV3NlRytzNjdDdE16QXNEaEhhOUcyQVR5RGxYZzFEK3BERG5vY09W?=
 =?utf-8?B?N0o0cGhqWklnV0pSQkFxZ3E5dWFyR08vVEptQ0ZMWXB3S3FBbjluL29PRG5M?=
 =?utf-8?B?VStWWXlTRVlQa0JFUVRnRUp5ZkhzOGsyeDdUR2l0WFhPQnNCTGhCWWtBOE51?=
 =?utf-8?B?MmlGc3Yxd0JVdStteXFsb2RKSDhOa2hvV1h4cGlKTFZGS2owUGhyZ3Y5TWpM?=
 =?utf-8?B?NnhuT24vc3cyeHdnTFhka1JHcEN1eklVcUFIS08wL1E5eTYzTlNzUnBjZU9k?=
 =?utf-8?B?eWJ5ZytEQ2JmdjZadXhoTWVQeGRGTmxMN01wTWY2Mk1XRlMzV0VMNzgwWUpy?=
 =?utf-8?B?NUJSUEtKS1VTRm16QnhNTEM1UGRSaTg3Wi96OTY5aFBBNUYzU2Jjc0hseDk2?=
 =?utf-8?B?WVVmQS9YeFlzb2pOL3FIN2FISm04Y2FkcHBtMW44YnY0Y1V5MFRSTHE0Y1Nl?=
 =?utf-8?B?RElPN2d4RDc3UGx1b0RMT1VWaTRYUi9Qc3I2UVFveDhVakRVMEp2eDVHdStK?=
 =?utf-8?B?RG5OenRkSUlicC9WeUw2ZFZzWnhFVlZLaWJuMyswUlhVNGFHV1ZxWmVGeEhD?=
 =?utf-8?B?UEpncGh0R3grMlY2bHRZOFFLY3NzWUNRODNyalVqQnpQbk83Q0ZERGxVQ1I0?=
 =?utf-8?Q?5z2I=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a88b68-72f1-4012-957f-08dc2d5dec69
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2024 13:07:40.0949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dg7YsiKVtjBBFaG6Pq8Jh6CUSYleMuT2vYGLwNmjPqMzeKUxHyivitobPyPwR8JTTsDkk3G5mnW46gwIV/CB3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB2048
X-TM-AS-ERS: 104.47.11.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28190.007
X-TMASE-Result: 10--16.763400-4.000000
X-TMASE-MatchedRID: UuaOI1zLN1hCD2A4wqgJu5ebF50LnN6WbU+XbFYs1xKA/R4QfleZcyhH
	DMdwawkrmACEgzETGEbQGJNCcq0h+sYDrGYMIhU0nRTJpY7VAKclC02Y8wtl3zAPdWnwC9eDJQk
	txNYzOLONk6CnOOT0tJ4u7onx25MlSGzHQK3NWLsnDrpxCH9Hl2StUhdkd3nYBK4oo7tJnZEIzZ
	QUPW10lGpsf9ill7qA/SVxq7nB4ndxcvc/d2qgHDvQG0xdFpDCEpRQcMr0mi7UxxaDlU1Cjx1Ix
	cyWa+RZODzw2zhU/jSkEwwiLfZvadYHgkWdRfS0rdPIcvaPIfaB1fO2o4QGcDB4jJltGVDbhes1
	L7EqVuqxA7pVyH8J9o19zNGhZoVDuGFtyDwZQ5pZZLPh2uNIuASXrcJGHda2cYO7LzLWqS7SVsx
	MV0lRfKMG6HbMo3MzaY/VNbSsYonDTRgGHblp66gha+Y/xAIg
X-TMASE-XGENCLOUD: 178f6476-657a-4244-ba8e-54f22bb812a0-0-0-200-0
X-TM-Deliver-Signature: AEEB02D70AEFA865AA32B4A9355CC2ED
X-TM-Addin-Auth: 3lh4A8V4dufTS6y0WKQDX/dUFL0wdP1pfeVOIvLHhc2lTAWN/VOL0SwJVXN
	qEPHAtYWQALeM6cukRVN6p68vlwn8XnJ+jbi8c7qMcmT+UIbZG9aDVxUdNNnNLq09Ss6oQOWzTF
	FQPE0EaobakWqQVTTsOISnEniXQjVBkrsQ0RhOdc+K/kc11PxDQCz/WidYvH/oj5NLMEjs+JGES
	urQQgATKWhDNY4A22SyvyWHzLpTCWV2hIS5ow2HOiNWkUYRMhsPjwRTejN5YkCEsQ9TIft5/oe+
	FcGVy/WZLM+paOg3ihtBLOamp+ZWLy1ZRiI+fk22rCfESoDD4vRi2htqIg==.CqIw5newHJpaFm
	8peXcSns608arIW7f7wtQKbRtHm8iALoHoVQKc5bO4G3YzdF3GX02gVQD4mHxnDjUJiIbC0KTEG
	GKJ9NJnjkv97fS8d2C1ZBuf2I4N3pbvftPgmfP5LUkIvzwD+KVb+338SbNkByItoGuMa8gv5xs5
	WZakQuc4vxRwAU940CKrVSTORG/kVmV6I4gjxvZkHDaEIQZCU4Wcfqh5bTItWlwIeXZ9pksE5Tf
	CLG/o4fmlckmn7wZ1Gj9rAvxsRpdUd23MLghPx/VX/1D68mE+8dd+yWyPlxFr0G4aHrFnsbei5Z
	o4A3ZeS1jOYWSf4338ulVO/HAUTw==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1707916061;
	bh=qvbiSrhy2KNV2E6WdGBDtSYTujoGpSQ38tHplogFmz4=; l=3158;
	h=From:To:Date;
	b=rIutN6cdPIXns8kUvaafRsINipStJ4muPUD01yhwzXaeC+LnzZGc+YFxlADt18p8K
	 mvkSGQZ8arRF/29gX59cESBZFj5n/HQWhd9mS0RdrqC9eKLFvABF70N53mKNXrLCfm
	 EqaXG3c76663QVlC+KRd950BgbqOoXjmLbHyDsXilxahq4zHqXcfZqi0+VcwRTK6QE
	 9TZApIxblzF3HbEyS9aPqK+/ElKQ16DEdbrmBHiwmZ6JKJkVvKWPheVSx0t3mHRu8v
	 t/gMZrnfKFy3voHEGh67450vPZO3KphKIKcBViFQIiT99o+5uTX5HzjKyw3f9Sr1hs
	 ESopehMw2KA+g==

Ck9uIFdlZCwgMTQgRmViIDIwMjQgMTI6MzA6MTkgKzAxMDAsCk1pY2hhZWwgUy4gVHNpcmtpbiB3
cm90ZToKPj4KPj4gT24gV2VkLCBGZWIgMTQsIDIwMjQgYXQgMDk6MDg6MjZBTSArMDAwMCwgQWlz
d2FyeWEgQ3lyaWFjIHdyb3RlOgo+PiA+IEhpIE1pY2hhZWwsCj4+ID4KPj4gPiBUaGFuayB5b3Ug
Zm9yIHJldmlld2luZy4gSSBoYXZlIHVwZGF0ZWQgbXkgcmVzcG9uc2UgaW5saW5lCj4+ID4KPj4g
PiBPbiBUdWUsIEZlYiAxMywgMjAyNCBhdCAwOTo1MTozMEFNICswMTAwLCBBaXN3YXJ5YSBDeXJp
YWMgd3JvdGU6Cj4+ID4gPj4gRml4IHRoZSBmb2xsb3dpbmcgd2FybmluZyB3aGVuIGJ1aWxkaW5n
IHZpcnRpb19zbmQgZHJpdmVyLgo+PiA+ID4+Cj4+ID4gPj4gIgo+PiA+ID4+ICoqKiBDSUQgMTU4
MzYxOTogIFVuaW5pdGlhbGl6ZWQgdmFyaWFibGVzICAoVU5JTklUKQo+PiA+ID4+IHNvdW5kL3Zp
cnRpby92aXJ0aW9fa2N0bC5jOjI5NCBpbiB2aXJ0c25kX2tjdGxfdGx2X29wKCkKPj4gPiA+PiAy
ODgKPj4gPiA+PiAyODkgICAgIOKAg+KAg+KAg+KAg2JyZWFrOwo+PiA+ID4+IDI5MCAgICAg4oCD
4oCDfQo+PiA+ID4+IDI5MQo+PiA+ID4+IDI5MiAgICAg4oCD4oCDa2ZyZWUodGx2KTsKPj4gPiA+
PiAyOTMKPj4gPiA+PiB2dnYgICAgIENJRCAxNTgzNjE5OiAgVW5pbml0aWFsaXplZCB2YXJpYWJs
ZXMgIChVTklOSVQpCj4+ID4gPj4gdnZ2ICAgICBVc2luZyB1bmluaXRpYWxpemVkIHZhbHVlICJy
YyIuCj4+ID4gPj4gMjk0ICAgICDigIPigINyZXR1cm4gcmM7Cj4+ID4gPj4gMjk1ICAgICB9Cj4+
ID4gPj4gMjk2Cj4+ID4gPj4gMjk3ICAgICAvKioKPj4gPiA+PiAyOTggICAgICAqIHZpcnRzbmRf
a2N0bF9nZXRfZW51bV9pdGVtcygpIC0gUXVlcnkgaXRlbXMgZm9yIHRoZSBFTlVNRVJBVEVEIGVs
ZW1lbnQgdHlwZS4KPj4gPiA+PiAyOTkgICAgICAqIEBzbmQ6IFZpcnRJTyBzb3VuZCBkZXZpY2Uu
Cj4+ID4gPj4gIgo+PiA+ID4+Cj4+ID4gPj4gU2lnbmVkLW9mZi1ieTogQW50b24gWWFrb3ZsZXYg
PGFudG9uLnlha292bGV2QG9wZW5zeW5lcmd5LmNvbT4KPj4gPiA+PiBTaWduZWQtb2ZmLWJ5OiBB
aXN3YXJ5YSBDeXJpYWMgPGFpc3dhcnlhLmN5cmlhY0BvcGVuc3luZXJneS5jb20+Cj4+ID4gPj4g
UmVwb3J0ZWQtYnk6IGNvdmVyaXR5LWJvdCA8a2Vlc2Nvb2srY292ZXJpdHktYm90QGNocm9taXVt
Lm9yZz4KPj4gPiA+PiBBZGRyZXNzZXMtQ292ZXJpdHktSUQ6IDE1ODM2MTkgKCJVbmluaXRpYWxp
emVkIHZhcmlhYmxlcyIpCj4+ID4gPj4gRml4ZXM6IGQ2NTY4ZTNkZTQyZCAoIkFMU0E6IHZpcnRp
bzogYWRkIHN1cHBvcnQgZm9yIGF1ZGlvIGNvbnRyb2xzIikKPj4gPgo+PiA+ID5JIGRvbid0IGtu
b3cgZW5vdWdoIGFib3V0IEFMU0EgdG8gc2F5IHdoZXRoZXIgdGhlIHBhdGNoIGlzIGNvcnJlY3Qu
ICBCdXQKPj4gPiA+dGhlIGNvbW1pdCBsb2cgbmVlZHMgd29yazogcGxlYXNlLCBkbyBub3QgImZp
eCB3YXJuaW5ncyIgLSBhbmFseXNlIHRoZQo+PiA+ID5jb2RlIGFuZCBleHBsYWluIHdoZXRoZXIg
dGhlcmUgaXMgYSByZWFsIGlzc3VlIGFuZCBpZiB5ZXMgd2hhdCBpcyBpdAo+PiA+ID5hbmQgaG93
IGl0IGNhbiB0cmlnZ2VyLiBJcyBhbiBpbnZhbGlkIG9wX2ZsYWcgZXZlciBwYXNzZWQ/Cj4+ID4g
PklmIGl0J3MganVzdCBhIGNvdmVyaXR5IGZhbHNlIHBvc2l0aXZlIGl0IG1pZ2h0IGJlIG9rIHRv
Cj4+ID4gPndvcmsgYXJvdW5kIHRoYXQgYnV0IGRvY3VtZW50IHRoaXMuCj4+ID4KPj4gPiBUaGlz
IHdhcm5pbmcgaXMgY2F1c2VkIGJ5IHRoZSBhYnNlbmNlIG9mIHRoZSAiZGVmYXVsdCIgYnJhbmNo
IGluIHRoZQo+PiA+IHN3aXRjaC1ibG9jaywgYW5kIGlzIGEgZmFsc2UgcG9zaXRpdmUgYmVjYXVz
ZSB0aGUga2VybmVsIGNhbGxzCj4+ID4gdmlydHNuZF9rY3RsX3Rsdl9vcCgpIG9ubHkgd2l0aCB2
YWx1ZXMgZm9yIG9wX2ZsYWcgcHJvY2Vzc2VkIGluCj4+ID4gdGhpcyBibG9jay4KPj4KPj4gV2Vs
bCB3ZSBkb24ndCBub3JtYWxseSBoYXZlIGZ1bmN0aW9ucyB2YWxpZGF0ZSBpbnB1dHMuCj4+IElu
IHRoaXMgY2FzZSBJIGFtIG5vdCByZWFsbHkgc3VyZSB3ZSBzaG91bGQgYm90aGVyCj4+IHdpdGgg
YWRkaW5nIGRlYWQgY29kZS4gSWYgeW91IHJlYWxseSB3YW50IHRvLCBhZGQgQlVHX09OLgoKPiBQ
bGVhc2UgZG9uJ3QgdXNlIEJVR19PTigpIGluIHN1Y2ggYSBjYXNlLi4uCj4gVGhlcmUgaXMgbm8g
cmVhc29uIHRvIGJyZWFrIHRoZSB3aG9sZSBvcGVyYXRpb24uCgpIb3cgYWJvdXQgYWRkaW5nIGEg
V0FSTl9PTigpIG9uIGRlZmF1bHQgY2FzZT8=

