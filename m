Return-Path: <linux-kernel+bounces-136035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B2D89CF34
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7429B1F23615
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B9538B;
	Tue,  9 Apr 2024 00:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="lL4DzGQ9"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E609418E;
	Tue,  9 Apr 2024 00:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712621453; cv=fail; b=fA8JKh86FrlrMtDC5LL3qX/0xR0btng6ABVc7LN02EWPoYvbapWiS2uY0uMOoHpYYMnOwOyU05acKSGQ1004lvKkV37RYxsTegYcOrBSFNvphsxdCjOGCoFnwPj0+Nvp/MJ3zSkqUEaHVeLcKzR+sVoZ+vSQUhm7Av05Y4U6NnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712621453; c=relaxed/simple;
	bh=+TNpdr6daXnTDM86vsWepPwKPSnG/ww7LgJMagz4Vl0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UTfq5YyKjWospd+P2oFQeYkthbVraRrK/OcwL9lXCkRqURwt/hTKpKo5P5HFWxt8JO01+kmnNBbYEE12x7J1NEelqkQjA6BznK8SW9TwPvntchdmHS8CyP9dE3Ny6HNddKmoOwNSA9nmtvFYb1F5oLETW3JCs1tQuxnSx/EFW98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=lL4DzGQ9; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 438GoLUx023474;
	Mon, 8 Apr 2024 17:10:34 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xb5wgebj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 17:10:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dArTwPlqV2a8I+WIuwGK+1fQ261cbDCb0mlmv7vkOxkPDON1jyWHCagC3BbUOZjQzY4q8eArlJ8TX7ScN/EEX1ok3kR123W4HbvNQ2ERd7DT/rg0308tysNziyV8dJkY0oTDLmnHdxwrfsh8zvegCgXSlBJOQ5X5tvs4HwkiR7FSO2bBMvIGJeue6DUA5qAdoIDN4hQ4V+oKatKIT5xN4N2dCdkyqZbsCQkMAdRZDK4PXtAFWElRMSOsuNEZEtp5gnJF0y5FSwPZ5vu+JZFF3BWdzE1Ogu6zxGm7aWa48zOIMy1sLlzPh1GHb1XXG2au+luhpIuhNLngR8F8EBsWHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TNpdr6daXnTDM86vsWepPwKPSnG/ww7LgJMagz4Vl0=;
 b=GxD9Xkw9eHo1JVegmerUxncuTrWW/J+hD9nylHAay7iiE25qzrO+7j24RcZvQ+vUCAqCTdFWlBznEHbxLkixptE0Dm+waOYj+KWrxzlcYMl/Wp89BC0RcWSW8oiEb7K/LLnKEA58NwbvgNScRAzxz+3OSLGNzEfsHRoawQ1ZFHSBhbMJ2tuVYKMwdCxCRwwY0MfdRzRViC8O0Lewx8fwuvSG5AQBLBbzikgyN3XL+v/EV6iMENk58BZyfxtG2CaIA5OIOtuyU9xlgTf1dTG0fuj5A0DcCIvUYv6N4fcT8ydY0qicadEeP09B6VKbQLQn1easolh+D1V92TK7SRxxIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TNpdr6daXnTDM86vsWepPwKPSnG/ww7LgJMagz4Vl0=;
 b=lL4DzGQ9rjNsWqrTNLq158+zvWrEU0gYfLnyfIJJGPiGHjmKtFLGNn8R/2exzJg2HVEx5S0iQO/Cbt8CT/swd02AZNdqJTDiOyRrJ/KWPdZ2txxnXYSXBCKBUfvmsD6eVNkPWDESzBZGb/hKFihXZTKvxkOA9v24CLI0sjgSK2g=
Received: from PH0PR18MB5002.namprd18.prod.outlook.com (2603:10b6:510:11d::12)
 by PH0PR18MB3813.namprd18.prod.outlook.com (2603:10b6:510:23::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 00:10:32 +0000
Received: from PH0PR18MB5002.namprd18.prod.outlook.com
 ([fe80::8bf7:91cd:866c:68b0]) by PH0PR18MB5002.namprd18.prod.outlook.com
 ([fe80::8bf7:91cd:866c:68b0%7]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 00:10:31 +0000
From: Linu Cherian <lcherian@marvell.com>
To: Linu Cherian <lcherian@marvell.com>,
        "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "james.clark@arm.com" <james.clark@arm.com>,
        "leo.yan@linaro.org"
	<leo.yan@linaro.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "coresight@lists.linaro.org"
	<coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>
Subject: RE: [PATCH v7 0/7] Coresight for Kernel panic and watchdog reset
Thread-Topic: [PATCH v7 0/7] Coresight for Kernel panic and watchdog reset
Thread-Index: AQHacECr+wmc6MJsCEeCTVfctSb+8bFfQ22g
Date: Tue, 9 Apr 2024 00:10:31 +0000
Message-ID: 
 <PH0PR18MB5002D016166F97E665BB0F39CE072@PH0PR18MB5002.namprd18.prod.outlook.com>
References: <20240307033625.325058-1-lcherian@marvell.com>
In-Reply-To: <20240307033625.325058-1-lcherian@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB5002:EE_|PH0PR18MB3813:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ZHEdH9WGV6uqVgyZ00aPR+nlFyCql9fAcpfNX0ywflqT3z4cy5Oppr7RRys0G2WB7O/V37RfnHGkviANQaIArFnXcsROv0QM01W0lOFuNIzC7xlzL+uaUVZ35nzTocz2ANZWLpX2CGxgZdPi5B4uOlygwI/cgKa6Z/JQVKH8u3PRgi9DoKIqzg+X11hwb6fBm4l5Gdc7jWatgtuLCwAp5HHIYZvHhs2ILdM7d8DWoEulmSJYv4fNsE8CxjpIXjlQQyWJEN1OzD0d/fgELkUA16kLqu6/HTo9R955Bx5PW4VyBdt/r2nR+Ua6weB4csmt5DloR538h+XRPTuDfMKPrgcHrWloZhAn2xPxkI6bxa+0XCiapfpey6emA8r4gYrpTWRFv3rj39nhw1Jh440fEXh0Wd97/aVnpiauUwO5s/KU8d4IazQXaXa3w1kmxYUWTMGNCvG0lL/mKpvHyfifcCqmzSvl3hH8JhQeEXyaZhE0Ewk0q9C1x7W6sVGaeSHTxxwaHkBXxW9Mo8vF/WkO3HcrXtkZS/3Fm+49J07/opW8XtdSiVJyTRsZ5tqWVfr4wxDJlzv/FfOYhItJXPs2elwo+4mfmizihQnMjrNY0YVaxAvaazkxnjmh6dVYJlEcPPWyAy3xvyLEjpa/Mr7nm1ygfetqXV7eeuvTM+EJ5Lc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB5002.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?lVjyiSXxfqeNQsAOz9QL0GD5kOXUq9dz3C7OIv1TDDaeUFjsijz6Z4cS6cB1?=
 =?us-ascii?Q?gaPfyD2a9J8oJ/Q4hqytRBPydOkvYuEoCtjDX0kYAckoZJU7ooWkaVPUNTZj?=
 =?us-ascii?Q?1X0wL/zYVopKBlA3Z4dhLr36mJ4dja2yZR8qbZl8twKSyLH484VhxplKnYnD?=
 =?us-ascii?Q?Wl59NZUc5gH3b9kCuuMFlVLmEzjCbDClJN0Wc+c9hX4CC8Wgdio/O2Vyk90T?=
 =?us-ascii?Q?K3N/1HVS9HIP7M8ynCQVyg3r5OEjDX+adQt5AFoXpAueUEGUr21HmVoJ0fFX?=
 =?us-ascii?Q?jKWQWqXT6tVIbd5pylR0+bT/1LcL72dg/X3esc/sRXlB0cL6mkp6/b7NFlKk?=
 =?us-ascii?Q?85GfAw7YCQp+ezVI3fEkFXP9rbQX1XBKsJCw3gKViW6b15+r0q9FuXD7aHJQ?=
 =?us-ascii?Q?chbhCI42AjZm9ES+TpUx1vdHywXIO/HoVcOvAbFgXQOHNPqkE8KVp+Cqhp7A?=
 =?us-ascii?Q?Hqs6994zCrfU823CVsONGlrZBo48o8tIm8g7j9xiIhKu9tSp+cNEJbAi66lP?=
 =?us-ascii?Q?6LZTRFu1MlYgqfN4PoztwHBXJzN1AZj0mVvRzB1Whn64eGjsfnw28X5XVUOD?=
 =?us-ascii?Q?r4ksz2AP/zZzPHt1NI3IaFkD9h2bKcWrZzzm4WxMmcG0X7g0gU+lsifqbYgQ?=
 =?us-ascii?Q?rQ5Tx3Y7qIFnvHN4XbxjP+dHLjZIyEKrImNwXd1VRjYv2BgF/VGpbnJC9+9U?=
 =?us-ascii?Q?ILIg4Q5/rKPRHdlo3XCkhDVmWV1DS759UDhoXPEOgNGTewGRMObw3+WRIX7L?=
 =?us-ascii?Q?WxyCVHAaqZE17DZ0EhCddvv8tEYF2HET5q77T0pHlGZd/owCU1FA9FNcHuYL?=
 =?us-ascii?Q?GIqOHctJ9BVUdF6Li1ywFVI8pcpjNqgYYMrvTGnTBgKcDs7VagM0eAaVHpHd?=
 =?us-ascii?Q?TFiBwkmUqSRZE26hd5FxNVPEZwgvWvgPqhQr0VVygNfXljp7O8zRFl5qi8td?=
 =?us-ascii?Q?zHDAGGpiQS4HV5Cc2G6TEvZkXNSQx4flFw6JFgdwWSp8YkuB7JfHIAaJiAj+?=
 =?us-ascii?Q?O6P44onIXcxi7VMRe3XYnAkLCDz2lgfR5WMgz4ABZXQxIUiGgg+ggmUSQoJG?=
 =?us-ascii?Q?G6OIAaAlqxoilfSNiDSWDrcMrvOZ9egkaHbFaHPMfHvuI1tLvQkj/f5ZSyCa?=
 =?us-ascii?Q?AJ2GoBBH1GJ1MMgOI8z0dN8SMZd8A6pUkTVNVfJ7WjDQuz1nQ6PXdC/pNGUW?=
 =?us-ascii?Q?vwz8Qgux6dVLaT/i+65nCWxigYsfNPYL7bZN+bOt60HEGO/M4nZRK+GP2oVA?=
 =?us-ascii?Q?IP4JzlCPlLn9A/gltlDWvWkDk76NAsi9THhRgAgUrzmr0lgcljHn0SJgWtBm?=
 =?us-ascii?Q?xakCB1crIYgcCp3rp0bw4PqkzCocYxmrC21HLPxI/fukfHlVlXZlCx1ac4Wo?=
 =?us-ascii?Q?Fsfjg8NCN7ZCHNQHmFpdqISp/r55KKwNlBwOX6ZvX9gqbKMf1LI/xO64fnmk?=
 =?us-ascii?Q?yEo4eX94K4thVhQwhCrK/gAswe6eVYU3/Ww9/f7kgsF76ecStDrZpJdXrW87?=
 =?us-ascii?Q?l2wYaMmg/B1Br56edII+QHmqYNYhgnCX7+UYZ0xnqjSoKgIHA2LxLdRRnCj9?=
 =?us-ascii?Q?dgs2dYvQLVC0XYCF8NS4pCR+gWoz22A9+Xbf+OV6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB5002.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a2a7a0-708a-456d-2588-08dc5829784c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 00:10:31.4335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b3J6pXkwIPnacQQMZgrCqL8kQRpVooG8XBIQGluDIqtw8JG4HY9z/H3GoSVjnFI/y+A0V5F1r84Ay5xzXAZ9HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3813
X-Proofpoint-ORIG-GUID: 4joVFZq6L9Ge3-7-IpKQr3uQRpTlBszy
X-Proofpoint-GUID: 4joVFZq6L9Ge3-7-IpKQr3uQRpTlBszy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_18,2024-04-05_02,2023-05-22_02

Hi Suzuki/James,

> -----Original Message-----
> From: Linu Cherian <lcherian@marvell.com>
> Sent: Thursday, March 7, 2024 9:06 AM
> To: suzuki.poulose@arm.com; mike.leach@linaro.org; james.clark@arm.com;
> leo.yan@linaro.org
> Cc: linux-arm-kernel@lists.infradead.org; coresight@lists.linaro.org; lin=
ux-
> kernel@vger.kernel.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> devicetree@vger.kernel.org; Sunil Kovvuri Goutham
> <sgoutham@marvell.com>; George Cherian <gcherian@marvell.com>; Linu
> Cherian <lcherian@marvell.com>
> Subject: [PATCH v7 0/7] Coresight for Kernel panic and watchdog reset
>=20
> This patch series is rebased on v6.8-rc4 from coresisght tree,[1], since =
latest
> changes are dependent on coresight_get/set_mode APIs.
>=20


Do you have any feedback on this version ?

Thanks.


