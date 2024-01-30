Return-Path: <linux-kernel+bounces-43822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B616C841935
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D791F28374
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9EA36AF5;
	Tue, 30 Jan 2024 02:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IxT6nFGQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cPtBcmEY"
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E57364C6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706581498; cv=fail; b=m76RKSrUahYsg63pUQdazse5avCI7o+1PBch5AY7oGm+ll2Rc+ltuXCY6RnIouhJxHB3miSIHbsPfEeq1OyriTSL2WQSdj7pPQVkVBiAXqmXaUz/pHxq3P79BCx6vfchGAVKfzWndwgCInfOEviCAx4ZNCm47smjvS/NAJmNDdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706581498; c=relaxed/simple;
	bh=4/c03DHHVR63J6bKfaAbrP8R39hkUkIMYlvWyQApVQI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mqx6RvX2p8ywFrj2WIXxbUMe+9CUw++D4kHotJqNlcvyUAEiU1WbMANxeD35zxCq74beoV/CLm42FWpfNym74kVe6cMa45b3Db+7kbDVOSJxB1EF7qsQ4pQdsmv96l+8dNDTfOIZ5gMJ1Dsbo1+TfBJRYZVHOkZX+MFBLc9cI7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IxT6nFGQ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=cPtBcmEY; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706581496; x=1738117496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4/c03DHHVR63J6bKfaAbrP8R39hkUkIMYlvWyQApVQI=;
  b=IxT6nFGQynlgnMUWmSUq0XrnlfmAoH6PEUI6QPGqyEO9KsGtEf9SLUMb
   pzj5RQUzjaEgZtF0xUmWdmo/duzLMwt2/Ub9uACFgrj+UAjfyrNyH3LvZ
   ziwxRV0OFGvlM2sty4Shv5dSaEwJrfBF3lFIs+7yt4/2zXouJuAsCq+6F
   vZ/0pGFn6b5uxaVbp4/DSW2aAk4QPJHTi1ml720q8cb5X6I1c2tErefk2
   3ays0ENvmMOuDWhHSbKpVwjcFgNEmLBcTnHxEmSDMzCD67OTmimJiL39s
   x6k8q26nh5P63lWPbl40gL0sxx9P5FYah2UC2nc6UfREY4nP21xmDgymF
   w==;
X-CSE-ConnectionGUID: lFQxeYxERKyQ2mgJ1WoaMA==
X-CSE-MsgGUID: GCZM0N4eTIORFVamqQOPCQ==
X-IronPort-AV: E=Sophos;i="6.05,707,1701100800"; 
   d="scan'208";a="8557644"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2024 10:24:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLUDtxM5m8+5NPVNfP7JF/Ba+2mR4PB0/4ilM3OOYtdclLIxMSWMknYAwjtZwhaVMkjn2ce8UG9pQ9VK1RkCpLoS00/CiO7yEyRjl1HePXdLJdUr5X5F7O9BB8zJBeOImWJuLisKZNfpnjO6Il+bW6RudkMBPTQOkrETC0Xo3rV0qp7p7Ni1ZAsjfGbiRXUoMnrBR6lWr0USuvsGRVNlMQJh9z38xAhKFrY9Kpgi4XwcuSbslVCFYFmY6pt4qFjcPPVNRKgE8oIrKe+9ih+eeKDOeK1nVw9xjnLgZP3BVb5A40J0m0pBRQrj4mfA6Ht3O27DYkFiAWNm0xRIsL0BXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiD4C+0+i8bzaWg0+Nh+9kwQQu6AQlmljMj90AT02tM=;
 b=BhTEaaLwZ8LHhmns0sv6zf1EfLaEFHBA6BAKl20XgTsSz809VLmLsM9l+zu+PU7ntp05NPIewkU1NnjZQAZl/hV5VXd9jxzYIBwxiQpQUFJsMeEiGNUJpJDPSMKWAVmjBTPfWqZXGOpGU4bzMDq2gStXrO4KC/rV1IrVxnCKp4S2p1TRhMxdR211UjRQ62aDXO7PWfC/ispVcwwkQrEJmDPv1CygNq+XvFS/ELgsCMqi1ihlw3bQmG0wbXvB4o1SuoVTP2MsdkyOhOwG44UQ1btNcHqpPGq5QGRSKu6QAB8Q9YAcQ/IyJyOrQYD+Lnub/rJddh2f2rh9abQ4vwUvnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiD4C+0+i8bzaWg0+Nh+9kwQQu6AQlmljMj90AT02tM=;
 b=cPtBcmEYYim3gxnQpvcDK2sDoRdwnqMLIA8B6PkNfOgjsiegEwgUDuuZ8IHoiOFaksA9Smw/kAm+WoZ4DdElKp5VjxFZ4bpqmx7qdTuFxVHawgMnRvSudncxRw4EjTZfH34JrhGYR9WJ03G5NTYb7ZEzBaYBFeQu3BNKy7370Lw=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SA2PR04MB7673.namprd04.prod.outlook.com (2603:10b6:806:144::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Tue, 30 Jan
 2024 02:24:52 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 02:24:49 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Tejun Heo <tj@kernel.org>
CC: "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: Re: Re: [PATCHSET wq/for-6.8] workqueue: Implement system-wide
 max_active for unbound workqueues
Thread-Topic: Re: Re: [PATCHSET wq/for-6.8] workqueue: Implement system-wide
 max_active for unbound workqueues
Thread-Index: AQHaMxW+fup8mSSkJ02yqXaFIZNHL7DKm++AgArgQYCABQnoAIACkwmAgBTHq4A=
Date: Tue, 30 Jan 2024 02:24:47 +0000
Message-ID: <a4obzmueffpsmvlzfe64oksxdzyknxacxb2kkeytwzjtlzhz6r@w4lyfr6vrrp7>
References: <20231220072529.1036099-1-tj@kernel.org>
 <e3r47rru6go5fqxl5issvduzzmsxrtkefigrkfcnqiuouxm467@72hfzpblzr36>
 <ZaCMkV_pjPfhZmrn@mtj.duckdns.org>
 <znrr4upkwnaehoifwcfuhk25ddv4kriyhrymqawcvnxseampml@drwl73kklgmq>
 <ZabvdYTNhj6fiHgl@slm.duckdns.org>
In-Reply-To: <ZabvdYTNhj6fiHgl@slm.duckdns.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SA2PR04MB7673:EE_
x-ms-office365-filtering-correlation-id: b5250821-7b06-4f5d-455a-08dc213aa115
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WYY5U2qCKluednU2kcTZnoINnW4KITVsVLtw8mmgWmwACDsRBdPhWJHdrQG2/ADX8lIa/oxMxspucd/nilf7p3rtnxFqJkz3QDouFW49Y9BoNym/8qJjNb5cvGrWB5aywRHDptJlC50MItKk9qbMcECccCZU1dj3pSltf6s/wyRX3Vo3jqgxrBXjff43Q3SRhbUMUHlsX8VzyUsT73QDZbulfj8MV+bVLwl9VUkN75YEgIcReVLWiXqo8Ts69BSSeeJ3ujMzPSaMPt+m7xn7jZxQJVukZq4E2GdoUa0XFJvUmhKZQTzeDcSqE93uAim84BC7xdixcgMUl2srSKlh5SsWv//9i3ST+LDmVxOwphhm9wYnywX7pzyk4trBvPMt5D4ZNkJa1FQ2u55/U1V7hbYlCursjKByDIANXaR+10YO7L1qgufIWyXs7YyHiVubcXetmHe7REtOeP6T2J7QKZ+h6ZVd7FNm5gVzPsLrFTpWVfVXYSaikc+LMuBOWaCZtrbHMmho3TCb9y4vmVMjZfMNtZA2U9x8AYpYC/X4y5tVUSTZtyh4z9Glf6o0RwqPkJyFA1EIrMcZdlzhX21wuAH34cm5jKMVJgmTZSZHItB3WJh8fbsNePc1jCdBg8on
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(83380400001)(2906002)(5660300002)(82960400001)(19627235002)(38100700002)(6486002)(122000001)(66556008)(66946007)(41300700001)(91956017)(54906003)(71200400001)(316002)(4326008)(64756008)(6916009)(6512007)(8676002)(8936002)(66476007)(66446008)(9686003)(478600001)(26005)(76116006)(6506007)(86362001)(38070700009)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vqxu4Z+MEFDHE/K9cex9Kullzdbzk5ceGzCxNFcGoMmGZX4jA7DhJO/Al382?=
 =?us-ascii?Q?4KKXhgh1Az4aekbyyqzTZdVhMbxRCwn0b9c7keu/uynYGu3ILqmc3UMm4Hpj?=
 =?us-ascii?Q?yk4DQkOz9OjxCAqISbNgY6kHQnED1gPcyIWywmhyu474ae6FaY2WyinsIpve?=
 =?us-ascii?Q?O65FzWCaKAzqlaqTGS+7hV8ih3weGEGexRA7wOic5vmLYZ2oRxA8j/SNKmEj?=
 =?us-ascii?Q?EWEkLzte4WDxq/aD1rotWoKud8u0fPHIlKh74LoDeEV96N71AU6ok4sBi7GW?=
 =?us-ascii?Q?DhSJNH1VPTtovvOv7CAtZxEg8m1V0DvDaCslbRwQ9F7+7ruqR2zExRVNsc6W?=
 =?us-ascii?Q?qo4v41U6bA5RmNN4SupPoXKbEUxFNJ9oHfCIrbYFDuxuDbDbaznvuTKCMvJ1?=
 =?us-ascii?Q?/PzMBf9vKil2hYjPiiulWVA0Z9gjZ52tH33iSh8z0OXAkE6/JuCmCIhHiFPM?=
 =?us-ascii?Q?aGpoBjsjpvzXovpoU4s2ScM0sZWCI1AOAJ3sFphC8JgjV+WkIC8Mh5OeQO0O?=
 =?us-ascii?Q?B9quTV1j8U3pLnQy2ymFNBT/TZw6dpicKlAvAq2nz89wTVejt3glSpTm9+Oz?=
 =?us-ascii?Q?DVdH4Rfg94YOj96TUSzo6RXyShceGIV9xeGc2xjk+XkOVPhNPr5eUrT++X3L?=
 =?us-ascii?Q?OD/f45gIKmJ7/ZOdukCzECJAzWB70WxWvG6v+w9qdel+BvrpKXKr8aYPvGJ5?=
 =?us-ascii?Q?rYA8q7a0PuPlYBQo8V5KGOTKMIzld142Yvil51600PmIAiePpSrBOf3e26Ry?=
 =?us-ascii?Q?R4tbfICUGRerlsWwu01W2HasHFUtL7BP4FbwPa76VRrbBNkW8xe9LhT7WgZB?=
 =?us-ascii?Q?vI+61nWawVMb+TILk+k2IUlNN2NXW7clTVVL0PYGt+Wsg1ng6CisgUCfBbIP?=
 =?us-ascii?Q?urR544ndX8SKBPJ1APt1oWjDseoWs9fCsgL/FWZFcn15BpXVOjduDuQvf8dd?=
 =?us-ascii?Q?n2MnNARCAexuQiYFJKc2q7s/TuizxknSMQZ/GigKAaQcw7RUFXdcpdxxK4mj?=
 =?us-ascii?Q?+A/pYWivziOA27TdpA7Mj6UNNwc74tCSyWxj8vNYCkJcHAeOmK2BT9f2H/KN?=
 =?us-ascii?Q?ASg5aZE3dA+KOp3C/Vmw7H63BZE3FqufFpAtQlpYgexyuWvg0Rs9sGp55QhK?=
 =?us-ascii?Q?//+s7MCvdtdPDoY+5MIwQE3X3XaD4E9xCIlNQmYCd5hYlRHcDGg9xvKGbMYz?=
 =?us-ascii?Q?ebUgKh1iTzNSoL+Cr0bhLvnL73GGtckeu1YCshQMY/IpbtcRNVItKi8GABDx?=
 =?us-ascii?Q?phcc1gLu9piUQuz/eB+Wkdw36HLrR2qS0iRHiK0lqep8uOYkMUyw714eWD0I?=
 =?us-ascii?Q?e/fcaQyyhVEnc58boYaQ4/IlAG8ddz4NPwg2gLqFcHGDhR3+ePQJHzssUUzQ?=
 =?us-ascii?Q?cq1XkEsPsHFzPEVKfXVt2VBW82bjQ3sXPmdFw2l0FM63DwQxYuSkTCfFRaBo?=
 =?us-ascii?Q?EdHiExL4/sLs7neONlP291ltNvBdIKhCLPZ/ucPJwnxBiw5F5QMS/ldMpQcW?=
 =?us-ascii?Q?UH1iLuB+lndUysv8MRGfap8ZnjjtdFgvS/igoQh6nwchgwES4LMcMaHNS7Vq?=
 =?us-ascii?Q?q98pwg1JcfBcHDIZtUdYju8PF4CXwJiN5Ha8x2ltCmhJQOzIThNz/8iSC3v5?=
 =?us-ascii?Q?oA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5615616D9953A94D83E85EDCF085D4CF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Rm0uhhGtNwh1qcWHNAiv9Tn0iLRDyB5XHjK5VoPPGhsPz8Yf6528pdhU8ZBDeSeXrpbZJhlpZWytl9BjQj6qoWsu4QYF54tZkIY9KfEGGsVj+0HrXxIBcsljHF9x8FHNOqMaPTaRMwZjJnM9TJTqhpx5+8uwjgC9WSR8xtAm+X1zhNU9mjb8hc8shRw+/OSeHbYCneEmluA3nDg6q+klCONx+Ms8810fBoRo7FZAq7aQAdLEUrl2tO+fBrWTRQNm9uEwIY8prVQ3QcwYWwLrRKgVWIGHAlKau2wNuYgsHzpQ5kwT6k/m1tG7ppbLU1e+ske2K6oPfe2LM/rZk0tdLkQPHQIQJ4abRmS+nQH/nWZ5QSp2rsct6hT0/7oYlcMmc1UNlE0YfXWQQ8LKxXDu569nD7q+pYgsQ+z6fPSbZwN26x61rMkIOc21AwvsjZEngPE8KFN+U+BFgoAZ82VA1tYsjaTLE3hpPtZAWjKYDDac19LHnnLCymCuPF1TQAfDCnDX8IMYQJLWD79d7s/NNckIt+Bq/rl7kuASk9DUduojgGQFaf+leqq5oUKdB8+6paVLGJovwTCzH+3gXhRzHBQP0ihSD8DP4PB/SkESTEnOAz0jBzy05eOHZMfkDW2Q
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5250821-7b06-4f5d-455a-08dc213aa115
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 02:24:47.3563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RWQ1Mm+jMVneWp19T2AMmx240XcrtjnG4LOz+26PzLc3wIXTaavJoNZFFPxMmgcA+/yQsiXVEzmJmkgaWLCj7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7673

Hello,

I'm sorry for the late response.

On Tue, Jan 16, 2024 at 11:04:53AM -1000, Tejun Heo wrote:
> Hello,
>=20
> On Mon, Jan 15, 2024 at 05:46:07AM +0000, Naohiro Aota wrote:
> > CPU: Intel(R) Xeon(R) Platinum 8260 CPU, 96 cores
> > NUMA nodes: 2
> > RAM: 1024 GB
> >=20
> > However, for another benchmark experiment I'm doing, I booted the machi=
ne
> > with "numa=3Doff mem=3D16G" kernel command-line. I admit this is an unu=
sual
> > setup...
>=20
> So, does that end up using only memory from one node while making the ker=
nel
> unaware of NUMA topology?

Yes.

>=20
> > On that machine, I create a fresh btrfs with "mkfs.btrfs -d raid0 -m ra=
id0
> > <devices>" with 6 SSD devices. And, I run the following command on the =
FS.
> >=20
> > fio --group_reporting --eta=3Dalways --eta-interval=3D30s --eta-newline=
=3D30s \
> >     --rw=3Dwrite --fallocate=3Dnone \
> >     --direct=3D1 --ioengine=3Dlibaio --iodepth=3D32 \
> >     --filesize=3D100G \
> >     --blocksize=3D64k \
> >     --time_based --runtime=3D300s \
> >     --end_fsync=3D1 \
> >     --directory=3D${MNT} \
> >     --name=3Dwriter --numjobs=3D32
> >=20
> > tools/workqueue/wq_dump.py output is pasted at the
> > bottom. "btrfs-endio-write" is the workqueue, which had many workers on=
 the
> > unpatched kernel.
>=20
> If so, I'm not sure how meaningful the result is. e.g. The perf would dep=
end
> heavily on random factors like which threads end up on which node and so =
on.
> Sure, if we're slow because we're creating huge number of concurrent
> workers, that's still a problem but comparing relatively small perf delta
> might not be all that meaningful. How much is the result variance in that
> setup?

Yeah, that is true. I conducted the benchmark 30 times, and the sample stan=
dard
deviation is 320.30. They ranged as follow.
Min 1732 MiB/s - Max 2565 MiB/s
Mean: 2212.3 MiB/s Sample stddev 320.30

Comparing to that, here is the result on the baseline.
Min 1113 MiB/s - Max 1498 MiB/s
Mean: 1231.85 Sample stddev 104.31

For a reference, a result on reverted case is as follow:
Min 2211 MiB/s - Max 2506 MiB/s
Mean 2372.23 MiB/s Sample stddev 82.49

So, the patched one is indeed better than the baseline. Even the worst case
on patched version is better than the best on baseline. And, as you
mentioned. patched version has far larger variance than baseline and
reverted one.

>=20
> > FYI, without the kernel command-line (i.e, numa=3Don and all RAM availa=
ble as
> > usual), as shown below, your patch series (v1) improved the performance
> > significantly. It is even better than the reverted case.
> >=20
> > - misc-next, numa=3Don
> >   WRITE: bw=3D1121MiB/s (1175MB/s), 1121MiB/s-1121MiB/s (1175MB/s-1175M=
B/s), io=3D332GiB (356GB), run=3D303030-303030msec
> > - misc-next+wq patches, numa=3Don
> >   WRITE: bw=3D2185MiB/s (2291MB/s), 2185MiB/s-2185MiB/s (2291MB/s-2291M=
B/s), io=3D667GiB (717GB), run=3D312806-312806msec
> > - misc-next+wq reverted, numa=3Don
> >   WRITE: bw=3D1557MiB/s (1633MB/s), 1557MiB/s-1557MiB/s (1633MB/s-1633M=
B/s), io=3D659GiB (708GB), run=3D433426-433426msec
>=20
> That looks pretty good, right?

Yes, it is so good. Since the numa=3Doff case is quite unusual and it has a
large variance, I believe this patch series is a good improvement.

>=20
> Thanks.
>=20
> --=20
> tejun=

