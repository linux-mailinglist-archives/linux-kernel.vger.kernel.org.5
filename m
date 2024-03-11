Return-Path: <linux-kernel+bounces-99478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C537878909
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9AC71C20CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC75756443;
	Mon, 11 Mar 2024 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ADTRAN.onmicrosoft.com header.i=@ADTRAN.onmicrosoft.com header.b="hHK5WGeT"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6750E3F8F6;
	Mon, 11 Mar 2024 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710186034; cv=fail; b=Gw+Edl2dty4+bD2/6SXL8bewRrfBLmehK0hhRWVJM24K4MraWvLEECDBVM7Mfwg7+ujdXWg2AKKYE8oM2Fpirzfdx+B7zRIoBAAb3i6/XP7B2TEBhk3sF7lbDzhjhCdPdYSeps6yKhm8IwGTUjtn42F1vBKT1c22HZSTl4c0Z3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710186034; c=relaxed/simple;
	bh=74uXV+jOyXz4aCydtqQglXHcRFZfXcYLxzedfECyBMU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sH9h7g1+8fsrBOlXzixkf1ExuVvZjXvfiK8GlMO/z341EYEZ/nk4pbyW2ECQISw8tQzk9bbV8Oukx5VUUL7B34TKuJ2OdjlWPq1dA3WmZqVhcSL8DCVnvRmtdNMfm7eTGVVyr5vhOgHXBrFc5niFKj5A/XEB4ZBYaiDZZBmImOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (2048-bit key) header.d=ADTRAN.onmicrosoft.com header.i=@ADTRAN.onmicrosoft.com header.b=hHK5WGeT; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mm9aflQ4huODOYKJlW010gaJeoEc1SGn1stKYd1G53HpqvqdldU+MLVxtrI4TlHpkqIt5SnJbcjziWFtQgtjA/pcgiom8bCDMevVH8d0+fbeksHcDCrfrjfHZwbD4WjFVu2ttM4zr6a6nNZhc1q+fFByBp68s2dNJgFlFOIKGXMRe66G2Hkv8hFnjXdZNlX4EjO4+asYul/fdZ6utC5YfhVESLdXtTnD4+hKp7ia38nZ224SfCQ9jWtLacUX74YrDr8QnC17iplTuZazrNICTNqnFaHtn7cbksovEiBpZqGONWQnk4jyyt1v3YQZk9DuFxNBp49wMDOrsfG0/wFD6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74uXV+jOyXz4aCydtqQglXHcRFZfXcYLxzedfECyBMU=;
 b=AT/PLYt4WEwzDvA/Fk6D4KH8uCexAzKetavlUwlwgL1cdvcNrd7SnqvTW1Fmf9vL3XzCVLTX8dTsQO+EwHoZYBLwD3xu4d2ZjoXUcHWfel8Xy1oKARUuviYywaAPQwrlbz39vD1Ps51L1wSu/sEnAzKZCnnZ/sjgH4hPZXXO+ZcDKFV/t3R6jWL+tFkR9c7nEL5cpcMV0AcXZpJZwloMVSetoYH3ad/Xeqyx/RI43Sy1tnY4dKu2IZbKpdVDK4XLWYxh7KXuOj9C3sfiHgj7PvcyQgHHILCkCc/ydQnspA7SJh7842HBrLsuZkEMf1s9fXc47mONWlZxryPAyfRWBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ADTRAN.onmicrosoft.com; s=selector2-ADTRAN-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74uXV+jOyXz4aCydtqQglXHcRFZfXcYLxzedfECyBMU=;
 b=hHK5WGeTxeDvX0QVyj2qulYKMiDPTi5u2b6bUy1hMROnckS1G6ZmYHoadsQrsx/69XA4x8Y8IybAE6lCJrBf/7is6UAcW3DzP3A7tEmSZy4MuKF87KtULJ0/S8h3sygcZd0J+p5aR4EH4OXgg3Z0ogxIw9DAOrugKoi5U/SxQ8PR4kBnlTslsMpLQhIWpaZl4rI/kzx3TjWwWfvWsp7t8WrojIxKmAe65KCqnVKlY7fTKzPQ51E39taRiv7bd226ClS85LLLFD8hBrzniUshtulYq3Uqx+eiXA1jWKHPhI/6Wuzmo77bAe52j0ND/ivtvgarlb97GhfIuhFm3xfASg==
Received: from PH0PR19MB4844.namprd19.prod.outlook.com (2603:10b6:510:75::5)
 by SA0PR19MB4352.namprd19.prod.outlook.com (2603:10b6:806:8b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 19:40:24 +0000
Received: from PH0PR19MB4844.namprd19.prod.outlook.com
 ([fe80::8546:1fe6:2190:6a9e]) by PH0PR19MB4844.namprd19.prod.outlook.com
 ([fe80::8546:1fe6:2190:6a9e%5]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 19:40:24 +0000
From: Chad Monroe <chad.monroe@adtran.com>
To: Rob Herring <robh@kernel.org>, Daniel Golle <daniel@makrotopia.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe
	<axboe@kernel.dk>, Dave Chinner <dchinner@redhat.com>, Jan Kara
	<jack@suse.cz>, =?iso-8859-1?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>,
	Christian Brauner <brauner@kernel.org>, Li Lingfeng <lilingfeng3@huawei.com>,
	Damien Le Moal <dlemoal@kernel.org>, Min Li <min15.li@samsung.com>, Adrian
 Hunter <adrian.hunter@intel.com>, Hannes Reinecke <hare@suse.de>, Christian
 Loehle <CLoehle@hyperstone.com>, Avri Altman <avri.altman@wdc.com>, Bean Huo
	<beanhuo@micron.com>, Yeqi Fu <asuk4.q@gmail.com>, Victor Shih
	<victor.shih@genesyslogic.com.tw>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>, "Ricardo B. Marliere"
	<ricardo@marliere.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Diping Zhang
	<diping.zhang@gl-inet.com>, Jianhui Zhao <zhaojh329@gmail.com>, Jieying Zeng
	<jieying.zeng@gl-inet.com>, Adam Fox <adam.fox@adtran.com>, John Crispin
	<john@phrozen.org>
Subject: RE: [EXTERNAL] Re: [RFC PATCH v2 1/8] dt-bindings: block: add basic
 bindings for block devices
Thread-Topic: [EXTERNAL] Re: [RFC PATCH v2 1/8] dt-bindings: block: add basic
 bindings for block devices
Thread-Index: AQHacKKp9hC8jPZxIEu5tTtMXn0DXrEy9RtQ
Date: Mon, 11 Mar 2024 19:40:24 +0000
Message-ID:
 <PH0PR19MB4844582040B0622565ED11ED8D242@PH0PR19MB4844.namprd19.prod.outlook.com>
References: <cover.1709667858.git.daniel@makrotopia.org>
 <f70bb480aef6f55228a25ce20ff0e88e670e1b70.1709667858.git.daniel@makrotopia.org>
 <20240307145102.GA2550133-robh@kernel.org>
In-Reply-To: <20240307145102.GA2550133-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR19MB4844:EE_|SA0PR19MB4352:EE_
x-ms-office365-filtering-correlation-id: 57620b99-af3a-4a7f-686c-08dc42031886
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CLmkSehR7ohLrunxKqC2BTMfB01i6+SKTUvGF7hxmW9Jma/5wS9VsOpvkkWbODr2yVsyz75DmbqCPbZYdAkj+Yd6BWb/uJHHVrzLGgq1uoH4EivVWBve6w2U3d1IQFeJgrmGfNerslBZQ9VYcXyP72YPBZ8GC2LA4EXg3jrxUOr5I9+2zLHjV8SJGsStNrod3lSxpO6+oB0ycoBrhbDmdVUY3C1P/0FxHaHYNdGdZqfFrDhGEIHZjczy4ij5lJumaZloipadqAb0l/b/yMjXR+/qTWUF6OVJq/x/tRTHRNLJjw2acv+Yq5zAN/ltQst8MsveTlIQ2mwlSOFAVy6W3pes8IPAfb8ZApfLB4ZhuxI56ZsGKJojGREexmdXnfVku4o8ndJQ15lYy383cpZ4Ef8CCJ8JsfKFF/jmPYhXTIFjKeSgfANOnJ+tOQw6z/wAgbAoi15pD2Me8W+hMF6+pTqYaA7f1bf5XO3wW5ppL7kYmX5Qo8Kx8kjSlyrGDERhHHOeDT3ObZmIA9eEM+QaNfyPK4+MBUJVWH5aIq8rWGlZ4/1q86Kv54kMw/75AVxRhOtw3Ke9nObSbQpNtAhztxGC3VrvxZzu5LzhJ9IPc8vfazjH+Y3FVy7T22CXgtc2nOYBDW14NrboDPU/E56i2E72+yhWDcNw92xvy9Zy3vc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR19MB4844.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?6IPSMAkbJzdgr0qd1+BZdu12uMQbZFZM4r4wVs8xsWYngIVyGTkbphvrS+?=
 =?iso-8859-1?Q?v3k4vAbG0ATWWLYvltGXHlomHG8gQFHnazVBCPtkIzuH1ct/KMRk3oNhYS?=
 =?iso-8859-1?Q?hIqnhSY+ZaACOjgmng0exvQhjK4mcVTH73pAGCXnjc+Ck9Ag/5D9s/1ssc?=
 =?iso-8859-1?Q?Df5SNIYWAyMDPQVmFZ7V1U8zU0X4ZP9FQ+rxbjnQzcQD/UlI+6+7RK1i+q?=
 =?iso-8859-1?Q?PJqoALeysp/P9L4N2To3MmAtjf1ybX3jLJGs+dm14y4wV9kXira9Bct1wN?=
 =?iso-8859-1?Q?ebsJHMq9jeBvmh2fjPe5448fXUEn9wk4k6HAwUtq4hWhOuwjRBo/Y3AQyx?=
 =?iso-8859-1?Q?cJAYOQTiN9AfKspp/eU3y+K+AfHmhDM4Sb4PKICIlVPUFxB7K5SULxMHC4?=
 =?iso-8859-1?Q?NqvN8HNVenn6ZM1lMDjjJqTGBRGWRE+8pSNqicgK+V90xtQ6A7rPshnpSz?=
 =?iso-8859-1?Q?aTZJoQJ7tILHW4L0gDMOVGjFYQ960SRAwoIo5GW5V/oRtBEAsWCeCVzFky?=
 =?iso-8859-1?Q?c2ZZz7QSoCYiyVJPJ8LL4nD42YScyZ4l4qmeQpoG4N8lK8lozA8XD05h/z?=
 =?iso-8859-1?Q?42RkHT4UwtPa9HipGRkTdZweMp/rrPAFIfxNxiHqRGK8g7R0JehxeDlWOb?=
 =?iso-8859-1?Q?pq7lsQsyPfPEdj+PcADLdFelJbtNM0Ido7RgGMfO+gMWfv3KUcouV+bkQA?=
 =?iso-8859-1?Q?ZjpxuVUDOI7wz4tqD52s0ZWE7hQPMmRZf0rwitNLyzp2hkn5DE1dDxQRQq?=
 =?iso-8859-1?Q?nN5AjaUBIuuKs9628NaFWzhQ+1pJvvyd2P9BXniBkMEpRoZOcu7fGv+La3?=
 =?iso-8859-1?Q?/q9hkrZCmQZ8y/tN0YJitB8q/hCLM2MUoH6RChf1IG1PJdyumct6lbSt9B?=
 =?iso-8859-1?Q?Jwj3i3CNUwYaraji9HRc60GTJo3fBjOBi+ykiebySqpGyLVCw9YGM7+1vO?=
 =?iso-8859-1?Q?/IuQjVDA+KW3e40qJbWiH787WvOPIZ8RkvlAwM0PNBBtARJCFErCcdngNO?=
 =?iso-8859-1?Q?4YsmT0SxiYceAS9uJQC80CsNK5oczE7BwwvyFGjP+kjhnI7Ra63Yd8Jv36?=
 =?iso-8859-1?Q?nXn6/IIEyqu8IKm72Y2utK0k+ef2b8xt6YdSo/TTBvxwV9LtW+DFWWu7AT?=
 =?iso-8859-1?Q?FrhsP24MjQBfpDwRzl2sbSfnrKa3gfyh20u0WNjBG5BAFOXaGqkWwiUVhQ?=
 =?iso-8859-1?Q?p7IelNBLavhRgWgWAcqrswS36gIzF9lbyhnkuq8gM5L3Kce9qS84tOxXQq?=
 =?iso-8859-1?Q?GDbOjd1mYniAm+1E1M0G+/Gnj9GpGoVfOw6sY3B66JCDd97GcUeuNv+zu9?=
 =?iso-8859-1?Q?v8elka8Q2TBTpzBDgpa2N+SNE5WMBt+mfUvNjiY7XGGJtRapu2AfcwyIvm?=
 =?iso-8859-1?Q?wEy22mGaAdTD/KGHc2GLgMs+nCMU0EllEkxJ54ipooZZ8cacG1zLR8zfYx?=
 =?iso-8859-1?Q?Ws118Ube9YXZG2Vynj4gt4rEzOyNu5HJ/w13e7R1IQtf4urlVuRhPA2IiT?=
 =?iso-8859-1?Q?ze++QkT+Z11ltkSXgFn76jow1Ux5CR0XR6xgf2qD0oR/toMMrrzO5ohaB1?=
 =?iso-8859-1?Q?86fx/+e8riHJRMFupupH3jGw3rum07NZsd5eusYTJTbbfdpLWvCh/MrLgC?=
 =?iso-8859-1?Q?49t40ae23HYlqbqCpq4ZX7sHdLgXwwgTqt?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: adtran.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB4844.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57620b99-af3a-4a7f-686c-08dc42031886
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 19:40:24.3033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C1OtquyqKU/psEGqWY7Xf6z2q7qnYd7+GJn8O4REhi+C+F/oYUoZ/+PEJGw+mAJb2/YPENrpe8v3DDz9K7lUgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4352



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Thursday, March 7, 2024 6:51 AM
> To: Daniel Golle <daniel@makrotopia.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; Ulf Hansson <ulf.hansson@linaro.org>; Jens Axboe
> <axboe@kernel.dk>; Dave Chinner <dchinner@redhat.com>; Jan Kara
> <jack@suse.cz>; Thomas Wei=DFschuh <linux@weissschuh.net>; Christian Brau=
ner
> <brauner@kernel.org>; Li Lingfeng <lilingfeng3@huawei.com>; Damien Le Moa=
l
> <dlemoal@kernel.org>; Min Li <min15.li@samsung.com>; Adrian Hunter
> <adrian.hunter@intel.com>; Hannes Reinecke <hare@suse.de>; Christian Loeh=
le
> <CLoehle@hyperstone.com>; Avri Altman <avri.altman@wdc.com>; Bean Huo
> <beanhuo@micron.com>; Yeqi Fu <asuk4.q@gmail.com>; Victor Shih
> <victor.shih@genesyslogic.com.tw>; Christophe JAILLET
> <christophe.jaillet@wanadoo.fr>; Ricardo B. Marliere <ricardo@marliere.ne=
t>;
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>; devicetree@vger.kernel.o=
rg;
> linux-kernel@vger.kernel.org; linux-mmc@vger.kernel.org; linux-
> block@vger.kernel.org; Diping Zhang <diping.zhang@gl-inet.com>; Jianhui Z=
hao
> <zhaojh329@gmail.com>; Jieying Zeng <jieying.zeng@gl-inet.com>; Chad Monr=
oe
> <chad.monroe@adtran.com>; Adam Fox <adam.fox@adtran.com>; John Crispin
> <john@phrozen.org>
> Subject: [EXTERNAL] Re: [RFC PATCH v2 1/8] dt-bindings: block: add basic =
bindings
> for block devices
>=20
> On Tue, Mar 05, 2024 at 08:23:20PM +0000, Daniel Golle wrote:
> > Add bindings for block devices which are used to allow referencing
> > nvmem bits on them.
> >
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> > .../bindings/block/block-device.yaml | 22 ++++++++
> > .../devicetree/bindings/block/partition.yaml | 51 +++++++++++++++++++
> > .../devicetree/bindings/block/partitions.yaml | 20 ++++++++
> > 3 files changed, 93 insertions(+)
> > create mode 100644 Documentation/devicetree/bindings/block/block-
> device.yaml
> > create mode 100644 Documentation/devicetree/bindings/block/partition.ya=
ml
> > create mode 100644 Documentation/devicetree/bindings/block/partitions.y=
aml
> >
> > diff --git a/Documentation/devicetree/bindings/block/block-device.yaml
> b/Documentation/devicetree/bindings/block/block-device.yaml
> > new file mode 100644
> > index 0000000000000..c83ea525650ba
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/block/block-device.yaml
> > @@ -0,0 +1,22 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/block/block-device.yaml# <https://p=
rotect-
> de.mimecast.com/s/gI6FCDqGk9uBM0gMFZVG39?domain=3Ddevicetree.org>
> > +$schema: http://devicetree.org/meta-schemas/core.yaml# <https://protec=
t-
> de.mimecast.com/s/rGEGCEqJR9uWnMRnHZK6FQ?domain=3Ddevicetree.org>
> > +
> > +title: block storage device
> > +
> > +description: |
> > + This binding is generic and describes a block-oriented storage device=
.
> > +
> > +maintainers:
> > + - Daniel Golle <daniel@makrotopia.org>
> > +
> > +properties:
> > + partitions:
> > + $ref: /schemas/block/partitions.yaml
> > +
> > + nvmem-layout:
> > + $ref: /schemas/nvmem/layouts/nvmem-layout.yaml#
> > +
> > +unevaluatedProperties: false
> > diff --git a/Documentation/devicetree/bindings/block/partition.yaml
> b/Documentation/devicetree/bindings/block/partition.yaml
> > new file mode 100644
> > index 0000000000000..df561dd33cbc9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/block/partition.yaml
> > @@ -0,0 +1,51 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/block/partition.yaml# <https://prot=
ect-
> de.mimecast.com/s/8Tf9CGRL65UJqGjqu07YGR?domain=3Ddevicetree.org>
> > +$schema: http://devicetree.org/meta-schemas/core.yaml# <https://protec=
t-
> de.mimecast.com/s/rGEGCEqJR9uWnMRnHZK6FQ?domain=3Ddevicetree.org>
> > +
> > +title: Partition on a block device
> > +
> > +description: |
> > + This binding describes a partition on a block storage device.
> > + Partitions may be matched by a combination of partition number, name,
> > + and UUID.
> > +
> > +maintainers:
> > + - Daniel Golle <daniel@makrotopia.org>
> > +
> > +properties:
> > + $nodename:
> > + pattern: '^block-partition-.+$'
> > +
> > + partnum:
> > + $ref: /schemas/types.yaml#/definitions/uint32
> > + description:
> > + Matches partition by number if present.
> > +
> > + partname:
> > + $ref: /schemas/types.yaml#/definitions/string
> > + description:
> > + Matches partition by PARTNAME if present.
>=20
> Why do we need something new here? The existing fixed-partitions can
> already define block device partitions. It just matches by
> address/offset which works whether its MBR or GPT. Also, in DT we always
> have an address when there is an address.
>=20
> I'm sure you want to statically define this and have it work even if the
> partitions move, but sorry...

The partitions which hold this data are typically defined as a MBR or GPT
partition and referenced by PARTNAME, PARTUUID or PARTNO. The data is
referenced as an offset within that partition. It's possible for the offset
of the RF/calibration partition to change if the size of eMMC chip changes
between builds of the same device for example. Within the RF partition the
data is always available at the same offsets.

Based on this, we don't always know the offset of the RF partition and
simply want to use the partition table to point us at the right location.

>=20
> > +
> > + uuid:
> > + $ref: /schemas/types.yaml#/definitions/string
> > + description:
> > + Matches partition by PARTUUID if present.
>=20
> If this remains it will need some work in the dtschema tools. The reason
> is json-schema already has support for UUIDs as a defined 'format' key
> value and we should use that.
>=20
> > +
> > + nvmem-layout:
> > + $ref: /schemas/nvmem/layouts/nvmem-layout.yaml#
> > + description:
> > + This container may reference an NVMEM layout parser.
> > +
> > +anyOf:
> > + - required:
> > + - partnum
> > +
> > + - required:
> > + - partname
> > +
> > + - required:
> > + - uuid
> > +
> > +unevaluatedProperties: false


