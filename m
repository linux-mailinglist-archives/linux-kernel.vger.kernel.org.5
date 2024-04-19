Return-Path: <linux-kernel+bounces-151309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A51A28AACAC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB65282575
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AA97D07A;
	Fri, 19 Apr 2024 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=svedala.se header.i=@svedala.se header.b="oUFVGocY";
	dkim=pass (1024-bit key) header.d=svedala.se header.i=@svedala.se header.b="SeAmw4/d"
Received: from smtp-out10.electric.net (smtp-out10.electric.net [185.38.180.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FAA74BEC;
	Fri, 19 Apr 2024 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.38.180.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713522007; cv=fail; b=aiPSwnNNv8p0oUOsxZynjwl0voGLrzTDEZuL/1Z+xvhz0LTqf88qp6cZ2YD7OkLhOXnzuxLYLH0Pi9M/lkLXVOILV+GCT7Hk+n0twKRTYvZWUFgXqCXA4oDVFEInbEYIx5Xs1iakwSJ6xfXskVKL4M3RAvhMnTclqtns4NHnn+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713522007; c=relaxed/simple;
	bh=VqlaXMNZEHoCbY4qy+qN29pEzzqGowjSwaPXGMOBJWw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tjBQIC2F3s2gMVHNKDBimguFhPSBMkSuPZB5NRp+XYk+fQAnwHYd31pX0eck4F1R/awFTWiqyUeBupe7U5kLWIo2edOQLFY692O+7nIRwO8eW9Ly1Uw/+091AQUYq/RIZ7TAH0J797/8YPIW1JVNIsM9YsvsJVv4Fx8YrgPgmOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svedala.se; spf=pass smtp.mailfrom=svedala.se; dkim=pass (1024-bit key) header.d=svedala.se header.i=@svedala.se header.b=oUFVGocY; dkim=pass (1024-bit key) header.d=svedala.se header.i=@svedala.se header.b=SeAmw4/d; arc=fail smtp.client-ip=185.38.180.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svedala.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svedala.se
Received: from 1rxl3U-0007Uf-W9 by out10d.electric.net with emc1-ok (Exim 4.96.1)
	(envelope-from <Niclas.Soderlund@svedala.se>)
	id 1rxl3X-00081O-TU;
	Fri, 19 Apr 2024 03:01:19 -0700
Received: by emcmailer; Fri, 19 Apr 2024 03:01:19 -0700
Received: from [40.93.214.4] (helo=GVZP280CU001.outbound.protection.outlook.com)
	by out10d.electric.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.1)
	(envelope-from <Niclas.Soderlund@svedala.se>)
	id 1rxl3U-0007Uf-W9;
	Fri, 19 Apr 2024 03:01:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcOErtMRuDnC77VQBt8vrw3yJXu6zgIKgaa/Zzg47SSEFgfbtvZXVMRKcDKcIHBMYEQ/MR+rsgMTt4l7mb21ZQKmZ7mBpJZ0QVLKSpkrJiN7BwdVH9eD3G26o9k5GFIi8ub7QG2EO2PR7YRJrTG/xL/rf1U9VJnRTgcsWsQ4OKaN52X0c893qg6rfXnpVWcKRnC2DHn6aH+YYZAbqtGc8HB12C9r/7aU4YwewVTfA4pzL8aBPxIi9UnAXODZADJYqv/I6WMAp7DTZMXSbfG4/0OdI1DVm2lOHw0GGDpCIu4ikD5cMdaAvaB0xhRuKSCd6R5fNzPZxzVXXDqXqZdpCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqlaXMNZEHoCbY4qy+qN29pEzzqGowjSwaPXGMOBJWw=;
 b=CLM2Rmtns15Ek7EqA0QgRaLVihOVb1Lh4SH2hgU6nZqOP2dWtIFjvevn8tea3z1kyHAJaOqLFZKT5vq7SrBYiqfmsvwi0f5ALMljeR0RIPgoOxwe5rYctE7Kw7p0LiG1984fAK9/MBp1/J/FVfohYLwRa5PRoiSlirdEa61gJZsPBciG4ho6SRnnZzbyUB2LzOE4ptt9gU8jQf6bqifi7OOWca/1rVV08apfH4Ym69DcfUOfFRe9Hetlc1dalHeE0lQkQqPjmpAghQmHGPVOcZ+Hkqiypm+ZRjorOXV8NuZ5/NeQAy0hJlWxig3CL0r0C20eR5RMjpbGFoAx3lAMCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=svedala.se; dmarc=pass action=none header.from=svedala.se;
 dkim=pass header.d=svedala.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svedala.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqlaXMNZEHoCbY4qy+qN29pEzzqGowjSwaPXGMOBJWw=;
 b=oUFVGocYXwgtuCzU9o4ank8tS+qzOVHciGFq8wBvw2JCEOFptsidqUDeN/7nwgXP3vt8RlveKpenneZcf/I22iZII0Y0idPfBfeB/MeYtJMK1nMJOTNr+xfMBo0nULbHTwtLsNjzoonDNWtroIdLZuFuB6X8iv7Yt/N2JiNQiY0=
Received: from GVYP280MB0222.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:36::13)
 by GV3P280MB0500.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:13::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 10:01:05 +0000
Received: from GVYP280MB0222.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6ccb:d943:9ebc:1482]) by GVYP280MB0222.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6ccb:d943:9ebc:1482%3]) with mapi id 15.20.7472.044; Fri, 19 Apr 2024
 10:01:03 +0000
From: =?iso-8859-1?Q?Niclas_S=F6derlund?= <Niclas.Soderlund@svedala.se>
To: "sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>
CC: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
	"perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>
Subject: Re: [PATCH v1 0/7] Add support for various laptops using CS35L41 HDA
 without _DSD
Thread-Topic: [PATCH v1 0/7] Add support for various laptops using CS35L41 HDA
 without _DSD
Thread-Index: AQHakkBXmYrYyUl6I0ekb2R7QAGcYQ==
Date: Fri, 19 Apr 2024 10:01:03 +0000
Message-ID:
 <GVYP280MB022216588A6BE8D2E213B8E1E20D2@GVYP280MB0222.SWEP280.PROD.OUTLOOK.COM>
Accept-Language: sv-SE, en-US
Content-Language: sv-SE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=svedala.se;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVYP280MB0222:EE_|GV3P280MB0500:EE_
x-ms-office365-filtering-correlation-id: 68c1708b-feaa-48c9-3128-08dc60579f6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?aH40jOPRMUhyTZFAJMB63gwfrFAgn63k7yd0FBlnvhO7jR5kw2tdK/plIx?=
 =?iso-8859-1?Q?wn+eWsNlnIbky9ZF2pRBID/6U3tTJyO6ggi4N3/BlOtiIWq+AH5Fnh77CO?=
 =?iso-8859-1?Q?MXR+2XD9TxD7YcwZj+yX7zep1P6snDUaBc2yC1GfAGKPgkPRCySIJT/aKq?=
 =?iso-8859-1?Q?Gf3rlHruHMvW9mL8avCUVx9/MIt0FUpajnMCvNuR7kevNZdDpZSep5G5US?=
 =?iso-8859-1?Q?K0mJ3UmV6H5uRH69eZQ2KMvErbuFEkkaGNIxRyZIzdKl42znGAVPAGWdSQ?=
 =?iso-8859-1?Q?fbHpknbhfwv3/ZcPD6wFvDEwU6ETZ7WkuBv+Kos2DGu3yC5xbBXtVPpqo1?=
 =?iso-8859-1?Q?yYKSts/3MofWs87wI/ecctHpy8S+FEJpAyTCT+cqaLNmLfjO8r4TnmVXw4?=
 =?iso-8859-1?Q?TY6heKU+nJCJbmhkOTIBt4AUjAiYqgP8CwkyP8hW6u/GWABFnkTNrXob6L?=
 =?iso-8859-1?Q?7+Oe/nBlfPzqY0eFFb2iiFqTJDDlBdUqw8gKPd8qWyD/zR24k68uw1kw4Z?=
 =?iso-8859-1?Q?OOOZK0wBvaVA9SnaNeN7aSLisFdSIf/QoEs2FE3DMlpiXe/bDHW8QasJmU?=
 =?iso-8859-1?Q?lof2pkOdHSIUV+lt8OqlPz6MFklE+cCbHUM/EFbvjUuWfZPuj81zr0Z0iq?=
 =?iso-8859-1?Q?qcIUQ+3r/GKPWCMM92X92oJvHG/szVMd6wIwIJ0b8voKv0h/sKxMi7ZtZ1?=
 =?iso-8859-1?Q?tHUhW7BSZ3S2Ho2Z406RUqE/dePCEw6fVCibbK0azinbl7vnQZey3+7KJm?=
 =?iso-8859-1?Q?nsTPmtsjC4EmNMBU1RwbH20+/d/RSq2Yz+qThtSGotWoE8jcO8ree6KSbS?=
 =?iso-8859-1?Q?GgPYfzG1Xa6Tv/tUt9KkPwQe09vIeS+YVnIWdP61dprGuDjYsVv26bktd1?=
 =?iso-8859-1?Q?0awwQTNajyLavWdqvwIhoh2HZkKAgZ9GQpcqaDdidncV5+ytLjiLrPdbxT?=
 =?iso-8859-1?Q?rI6lYoObEUyg/3Z/TV09AiNkSpV7i+9yxvXESnLf1/99f0RhGKL3+h++VE?=
 =?iso-8859-1?Q?HFM54Za3Iq/RAwKmwvIJUceLIY8St5yubonFNKIe8ZF5mPzPm7nZZ0PuE0?=
 =?iso-8859-1?Q?uunzwikTI66FKenFi7pRMlb07/TpQDL39iRpOieQe01e2AY4tCA/fTFcwp?=
 =?iso-8859-1?Q?2o0ONZ8ctHG8uup34kG7ucYhGDob92KLr1H/4qOmMIA7WmWVlnQ8io4W88?=
 =?iso-8859-1?Q?81U5rn3N4P5qaewlrkRRI/NwjHlJIRMxRUty6L8AWBtKtsJbH73wqE90cz?=
 =?iso-8859-1?Q?i4BouQ/KE1sjUGL3QwEv1ETK8t+0Rx30fdnNrgi7eSYSNYJ3/W1G8Y8v7u?=
 =?iso-8859-1?Q?5vQlbO2hdO/UngXf3qeMnB02ZQdNisfELXjI4sDB6nrro2rvoR3Xy18w3j?=
 =?iso-8859-1?Q?g5kRj6N9gWe4dMNHkFL/pYl/sPYB5oEg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVYP280MB0222.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vBPbCKj973+QRyb1ZoDpLhFK8HiNepEifk45c2dBaGEyNGS2PFo4OuCoSK?=
 =?iso-8859-1?Q?dgXUNUKzwn0fsBiHOgWSjsH5Aqn20idB10SMzd9OPC05mUCYwKQ6StGr1w?=
 =?iso-8859-1?Q?Y8m4RrXmY8gPTDK2zm+zOUHTMK9wDYcElvflenglL4RrqsF+WJcGXRS9wM?=
 =?iso-8859-1?Q?hVoMdZH82FDcvKbJpUB8NWSgf74TN+E8yzR0ZW/rxngJmZNLh4dX2l9Tw+?=
 =?iso-8859-1?Q?Lz1rI/JHgCXxbFYd13zFTpXfxqgPPL32L3jwMNLdEcTV4xkYHTcB3jYW04?=
 =?iso-8859-1?Q?L/vQnVALDIf5CXzaS+qlgKW0GnmDlv+udFGMAogqxxJCD78kP+6EtvFgxX?=
 =?iso-8859-1?Q?8heJvqabgT+zaZkmlxFroFqoCrg35Ctui/Gxsnv0OPuXcv5n73R5/Rm8ve?=
 =?iso-8859-1?Q?boU4whmuxlqB5VZYmX1AazaZWzerzjg6mipxLp01OpwHBkHstgaW0NViYI?=
 =?iso-8859-1?Q?nTkgzWX5Su8FHj65VKcIcSe/RdtWowdbLvM9tWRP/7si/wfCk7lr2idhFL?=
 =?iso-8859-1?Q?ZOkgRiYeo/L1ThKkWLdoLS0noYELIlimID1al5DjXt0QU9mD5cKUvOWeln?=
 =?iso-8859-1?Q?R2uuL6qQRxhcy15gfaIALC3DaLTRp5JIiHRiOK+WC0ryqpzY/PCJHN6G6n?=
 =?iso-8859-1?Q?NObXlGGd0U6N24bZ26sGYhdjgZuPJdSo9TZZeBEKDlrcq7R5ihCN3CSYyr?=
 =?iso-8859-1?Q?kwG6cDZc99CQ7XhCjSkNcW0efmLlRhSFS+P3zRxEhWfyRR7layLimytBzX?=
 =?iso-8859-1?Q?nX6vk++MEKiRN+XdcCtg2BCUrp7zwq9ag5fvTVmBGNKE0QRQZWFhGCjphH?=
 =?iso-8859-1?Q?HIn+R/tqSBwU5SQzJKBFZC0D3W1z4LcnUMT0DIKsG6LnpGRUVYopyRj0qK?=
 =?iso-8859-1?Q?iwqoudsvzMVz2fN0e6YTLpDoltFnPlJBkbUooMgzN3hBXMyt1Y3ZfKTSB8?=
 =?iso-8859-1?Q?NePw3xO/JGro9gR0AWfVCExCijd+YGqCNa6/PaFXixsfQ2NzjrKZaIs7xY?=
 =?iso-8859-1?Q?RW0GXdNXTaXKzmMni/bir57rv8iP1kLXZmZ2a0CdF0OvoIplOFlaeRoZvz?=
 =?iso-8859-1?Q?+mlegN60oOc4VxAy7hoRPhOi5pZIsU5Vqc0dCKFQzYdKPef+xiXPaZ0GkZ?=
 =?iso-8859-1?Q?XbceKvxJeNPWiRzvoCbKTU65E0zWp2Vm4Lc6/DcW3svkQnae1MAdhImUmC?=
 =?iso-8859-1?Q?s5TOxzYlPEzQrDFspTybNrSbhAztyhgLIrryRcJX/qXiDQ26OahX8eHuOH?=
 =?iso-8859-1?Q?9R2ccHlx0fQZtGUhr0h+MrJAkhz8zdTxHe0QxnxdX9QmNGVBXh5/E9GryZ?=
 =?iso-8859-1?Q?eCegGXVwvPxD6U04UWNa6dvJYIpwXPo+U6jO8zVpx8811lCkp6E0+Q+7cK?=
 =?iso-8859-1?Q?Rk2QGmSOiWApq3Ge5ouckDszNgSGGRkeS9XNk4V5JwCa2ITJl/Bc4fik52?=
 =?iso-8859-1?Q?7Fq00anISCI1eEd0zR2giTJ7XgifUTy9ima+2YOLaCj7LpCRw8cA26d0Gq?=
 =?iso-8859-1?Q?r/j7Uxwsow+GH43i884Ne59SNXpziUSgOjDvW1YsrAbMdOiNsU6l20gUg+?=
 =?iso-8859-1?Q?9/z4LbHnLsllSjuEHh/NudQ1Hha3XbU1F+usWTTUreI3OQxyPA607lktpD?=
 =?iso-8859-1?Q?Ec0SpjhRLE7GDW6Z7LwqBjC96yewNQ7PrJ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: svedala.se
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB0222.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c1708b-feaa-48c9-3128-08dc60579f6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 10:01:03.2455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a43f767-6833-455f-b87d-61ec9dc036cc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HGueVQ/6gJNahzuieGMwspfmSo7iIGv4K0keZOxjAEmRAzDYgN84t7VUETVSKdSHL0tGT+Uq0y6FwIiFIoF6akYuqzi1AszYekdo6KaFOyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV3P280MB0500
X-Outbound-IP: 40.93.214.4
X-Env-From: Niclas.Soderlund@svedala.se
X-Proto: esmtps
X-Revdns: mail-swedencentralazlp17011004.outbound.protection.outlook.com
X-HELO: GVZP280CU001.outbound.protection.outlook.com
X-TLS: TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256
X-Authenticated_ID: 
X-VIPRE-Scanners:virus_clamav;virus_bd;
X-PolicySMART: 32514092, 30573092, 18988237
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=svedala.se; s=mailanyone20190125;h=MIME-Version:Message-ID:Date:To:From; bh=VqlaXMNZEHoCbY4qy+qN29pEzzqGowjSwaPXGMOBJWw=;b=SeAmw4/dVzTGy9ddM21hHtjGifpA4p9C42slI99T3tbgeQKno3CZF/VtjA2T7e0vqR4OeP4nnWGMKwunFFm13sq1zmnuQjmWoVmslwwuEaTUMs7G8qtXQ2o6fREm2EgjEQO+ePObRBDINPoJXJQm9hZyRaUufrJZZahNuA6/qIo=;
X-PolicySMART: 32514092, 30573092, 18988237
X-PolicySMART: 32514092, 30573092, 18988237
X-PolicySMART: 32514092, 30573092, 18988237
X-PolicySMART: 32514092, 30573092, 18988237
X-PolicySMART: 32514092, 30573092, 18988237
X-PolicySMART: 32514092, 30573092, 18988237
X-PolicySMART: 32514092, 30573092, 18988237

=0A=
Hi,=0A=
=0A=
amazingly high level of laymanship here and equally high level of dispear. =
But model after model is added to fix the problem with speakers not working=
, but nowhere is my model seen. I have the Lenovo 13X G2 model and even at =
kernel 6.8.7 my speakers still doesnt work.=0A=
=0A=
Where can I add a request to also include this model in the patches, so I h=
ave a hope of having the speakers start working?=0A=
=0A=
I do apologise in advance but it would be a huge loss if this laptop is not=
 appended as being one of the models being fixed.=0A=
=0A=
Mvh, Niclas S=F6derlund=0A=
=0A=
=0A=

