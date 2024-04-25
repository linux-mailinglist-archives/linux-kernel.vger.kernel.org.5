Return-Path: <linux-kernel+bounces-158786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5F78B24E5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14FB9287C04
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F8D14AD2D;
	Thu, 25 Apr 2024 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b="nfOwufMK";
	dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b="wj7y72JJ"
Received: from mx0b-0068d901.pphosted.com (mx0b-0068d901.pphosted.com [205.220.180.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8C11494BC;
	Thu, 25 Apr 2024 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.180.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058314; cv=fail; b=ZNGOdn5bt3uNf8GKx8OLv/qxijcfXHhMWBT9fxqJiAZ8aLSK+7N1/vU6+KTmgq3WJN3y7iT+jJbDjzvHAaadMNaHCBVkf/WMe+7uzYcJie5t5iaAHS5fsm1k7L/35OgdNDSLXjylXcSgPAUnN3IxX59Q+xKRY4Q6BzFX1IuZ88g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058314; c=relaxed/simple;
	bh=r7ytaIQzqpbgGYfqam05OFk6ssVoq/8UgT0JLvjWk8g=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=I8R76fr+SwkgOaK2BUaTHx1WAoYjOPIgF56LZFZsEtWglrcvKlmIbwxnw/oDCelEEIehIIWbZSy00bcxQ7PGMP++MFBnrLiCVXudzj9wEVGZ0VmbDULMhDHM0i/ypzoNQM9nqAkNESijyJPbAqvr+rEBmTR677XRCEVD5cAWtAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=biamp.com; spf=pass smtp.mailfrom=biamp.com; dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b=nfOwufMK; dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b=wj7y72JJ; arc=fail smtp.client-ip=205.220.180.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=biamp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=biamp.com
Received: from pps.filterd (m0278265.ppops.net [127.0.0.1])
	by mx0b-0068d901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P7vgOk026946;
	Thu, 25 Apr 2024 08:18:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com; h=
	from:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=proofpoint; bh=Bavw/7
	hNi3MAHqzBYiPJ86ZK3S9kluLhmqRUr75jAFs=; b=nfOwufMKOeqRwSE+Z+0x5K
	sjMuKjtXtTEsL8R5syHWm+tZcIsOfmKJfptES9B9U6/bURDUpBmmBLNrCtP7X0SX
	x6OetLXjFg/BW8/jFwOjrnDiP7TfKBPvZ3arvdKN353zwkT+3Libwoodxw2LpADa
	6BIoyj+L6fHbnh2/Bqy78IEyv90j8R8asCmKWT5mLUxVRXYvPenDSe3RXKLmh0Th
	Vo0CSJxZMm9MIQ4ZVAAOqwaykbSJ0MitFsEdJbHcfQTCdQvcOGaihulbdv+s8ZoV
	ELI3hW0t7pk5VXFD0ab9Qli4wx85/j/UYjqtySI1OUTugIWO6e8ULxkwpLaZBnCA
	==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0b-0068d901.pphosted.com (PPS) with ESMTPS id 3xmadvkx7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 08:18:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWT1a4PpSRi8OULIcPJKql4rq0OxkTlDYRPbtNHihFUAnzNjWQHfAa7ZHyYUTW7YwFgasQz5TNkzl+guJOT+/kurKK72lE+XWJZXqWYEv3smgLBoPeGFpe0Gou4mjCRFqvBsu3elXFWyz5IDtEvH+2d8rd6DwON8qpbWOjh2Ky8lHx/JaADa2DGL74j/57o1LWiNUNgm49BZp/7HMf1eLgRBv5QS4wgP3GMVU/Vx1PQLIzmDoBDxx7ve8AZwWrJtNrxYEABTtsO6z+zB0dH7uJGPUd9AaeooIlY1GFymXDvjq2aw3sTI74c2ZOHqUR7Vz5/3KrEkClfTlTc7GkOySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bavw/7hNi3MAHqzBYiPJ86ZK3S9kluLhmqRUr75jAFs=;
 b=U8y2vCz/kdC5XXMHyneiYmY+J4xpr0NjdC7z4JiUmKCp8G4euuvn2Qy3VSZS1xe93FIHKrnXp7H81OAdulYbqXxlngKFYfq2oQ1R4NT55L47g4vSl44FLF24ar80S7uzSbrFtmHL4RcmCbZ4pGs6vOu23gHFmYbgHuXMg7uq0bKMU1e/TeFd1v233TqrllSW0LmwoFgb3PWtzjfy5Ik8raq4L65IxhHszOG8Sh6SVEr7kSKIsQA86zdjd7xh5Zwl+xuBzTC2ug0FE6lSJo1ZPjb1l68SWZCUnUwMmD4g0jw1XEaLP9k7VuNfvB5WRbxepnDldj+48otYclNXr0IWSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bavw/7hNi3MAHqzBYiPJ86ZK3S9kluLhmqRUr75jAFs=;
 b=wj7y72JJAycPUC5joyfyPF7UO+9GlSVvxCqDCy8hkwiHMMdX36+GSI23hJCkIkRtg98Q5zaoqxoyagPiUDwH+WBoHbk8zFPDtccW1KISozkLnuHULR9XyFwX0TNeN48RWOPMI4EtNKeG1YDi2ET70vdebkY6Ia/+EytVUi/Eb/xysb+3wU2Mb2vX8QOtYkWsdVxMASukG7q0qi3J8Z7B7+mvjcKGHweVb8FrGygfdprNFT44b0UQyOE+d8TGUuiAM6XsZp+tJyGvoH0OxGpqh3qoO1h8nsB/dEl0oTgy58rn/1DrNdeZfODXJquKX5a+cPMt7fYiMSPtHu7cra2YNw==
Received: from CO1PR17MB5419.namprd17.prod.outlook.com (2603:10b6:303:ec::17)
 by CH2PR17MB3720.namprd17.prod.outlook.com (2603:10b6:610:8c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 15:18:02 +0000
Received: from CO1PR17MB5419.namprd17.prod.outlook.com
 ([fe80::f48:ee61:a81b:d555]) by CO1PR17MB5419.namprd17.prod.outlook.com
 ([fe80::f48:ee61:a81b:d555%4]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 15:18:01 +0000
From: Chris Wulff <Chris.Wulff@biamp.com>
To: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Hofman
	<pavel.hofman@ivitera.com>,
        Julian Scheel <julian@jusst.de>,
        Ruslan Bilovol
	<ruslan.bilovol@gmail.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        Chris Wulff <chris.wulff@biamp.com>
Subject: [PATCH v2] usb: gadget: u_audio: Fix race condition use of controls
 after free during gadget unbind.
Thread-Topic: [PATCH v2] usb: gadget: u_audio: Fix race condition use of
 controls after free during gadget unbind.
Thread-Index: AQHalyGSommM4qRlS0ev1Ndy19pvUg==
Date: Thu, 25 Apr 2024 15:18:01 +0000
Message-ID: 
 <CO1PR17MB5419C2BF44D400E4E620C1ADE1172@CO1PR17MB5419.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR17MB5419:EE_|CH2PR17MB3720:EE_
x-ms-office365-filtering-correlation-id: bf15ea99-bcd6-4f70-a7a1-08dc653ae5c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?xfXmOuznEYACwl5Fp7kH9dLLN0Do6YtaoPQPCQ1obJJX4TAnncouvS5xT8?=
 =?iso-8859-1?Q?H8o7+aJRuy0S7Rx8zee0k+drE/JRgba72PpLqNZ+cizKtGVMTxLmIjD3si?=
 =?iso-8859-1?Q?4lXrd1tsgSOyYKdI9YAHZPudFCI9DvIPaGkfDEiCUpXEgskp+cdVB97l9M?=
 =?iso-8859-1?Q?B3HTy8MUseQQBkJMjDeHaiOEpAzgoob4FuOVpNutJpPHQyVKe8gUpW5fOB?=
 =?iso-8859-1?Q?MXW2lf9UQvPSthZ5TvxCXt9MCOjdPJou1EhUB36EO1lYZSuakReD8QSm68?=
 =?iso-8859-1?Q?kV5befuwcZKxnMXHmRPvXvQRPT1MAKX1d+1nBHhwKzho+1xL3cYVc5Bb4D?=
 =?iso-8859-1?Q?LSVRM/DuHPmPiSxW12O2ygEIu05vGdZEBwzbShjKyT1xc/6vvvw1g9L4TC?=
 =?iso-8859-1?Q?E0Qd6x2XWv90J0V8UNl2urfA1+ZHFvj8Cql9kBCFz3X9KkL5Nrv0gODarY?=
 =?iso-8859-1?Q?xj4mp79AXjiEGG7OBFzaFeKTlNPLc4HsdSaS58CNmGaZPsHwOmxSY+sKHH?=
 =?iso-8859-1?Q?pRkbnQtiZqsoEks95z/J3wk6LdGSMyBSWQgfCggW+38rhmu4OW26kmWvdc?=
 =?iso-8859-1?Q?edEZ0MmdSkW7imhf98rKXE3qK3GSyT9EhrbIJVjzmr6AbOns+49HYDRrih?=
 =?iso-8859-1?Q?+N3l1u5VUvJCULqdHMoa0Smx3exju1F+l/JZk3NM+e9h8JOyEF2F8k8uV9?=
 =?iso-8859-1?Q?7DXkrpaelCziz0jYA6z1BSRXl95g1WSekAZpo2LpFPOxrnanOVpK5YcUA3?=
 =?iso-8859-1?Q?SQL1q6lg6D4V4xO0kybkZWbnVNq/17gEoT7rMfoSvlA5lJdOAiMyNfj4PO?=
 =?iso-8859-1?Q?E4MBX2/EDY6fRlz4PtJT4cmbKAELcg+D9NIVgXXcnyCj3feHz9UOjcWimM?=
 =?iso-8859-1?Q?yKDOFxhGK3Vr6GvpvgPj3zSNekad6uSlxpThfFiH8E3UsjgPd+8eOEFIGm?=
 =?iso-8859-1?Q?OKWCQTdJ57rjsAto1GsMJIVNQLHX9Rd7ktXdAXsLOtRC1yPZzEjnjkBkts?=
 =?iso-8859-1?Q?awjF5fsJNtk2Z0bY6lI5M9UaUPJj1KoISJLal4VtqxbYQxw4GCEoWPoS0W?=
 =?iso-8859-1?Q?tq5mcV8ZXaRLgjfS3r1g71A9Z+GElPBI2SQzo50x7SPLGa83njKwSQt4qX?=
 =?iso-8859-1?Q?Ik2CgLivyHDh7QTj2gkLPxxB6mMloyzuJD9ol6bqtGVQ/zHOGxa/YjeuYx?=
 =?iso-8859-1?Q?8kl+jX+miwFDUM5PjKmiogox9q6fG2Qn6rBbCayIclfAu7OXz1xmVHUllS?=
 =?iso-8859-1?Q?UQHbkjcOid1cchd3bVz0jl+1AHkhLotABLWKy5/h+lV6gITpEd2/mp/SAs?=
 =?iso-8859-1?Q?F6IyGWK2USNHnDeBW0GrdqLZ85VEHX3p8OGwVxCaBjs7+9ySHKVTbMPyEX?=
 =?iso-8859-1?Q?KZCEggx15rTY5Uk88q+HFqfR+kiFHyzQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR17MB5419.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?R2x+JMVnvAdP5+NjNhqU4eUahAxp8k2uAWfoQlahb3GOjxgggbkJXMX5X7?=
 =?iso-8859-1?Q?0JmquKXqVyxFfQBu+BAFpiF2aqkgvpFKk2jNwhROLc//Wr+kpCesKpPzz7?=
 =?iso-8859-1?Q?GJV5pvIfAhxKyvw2cw1S6G1farHlprNaQcVuGZS/01JuZOdae5ZSFyGuMl?=
 =?iso-8859-1?Q?OVLkeYuoYL/fkgRjGubT/rd7ffXKu1qqpjpOJjHDYfHy/ZbF/VUBvNaI2l?=
 =?iso-8859-1?Q?YC3lgr5eZsUrdfVW4YvrREZm25OqaTcJ12vkUwGtrigoHSucQs4nCzOVRc?=
 =?iso-8859-1?Q?N9jsLrlstDVVhnxTk0oN29hDfYW90adteioHbKiuXy40NgdNo+pb8aBNM5?=
 =?iso-8859-1?Q?8/k89g7ettLFf8vne4S47IZgoAqPFsQF3kfOh7pivC8xtrNG8mVDL2wdbN?=
 =?iso-8859-1?Q?boC2JnAqz8xe73STVfNReKJg+VjUuxmBGLMWG1MdCzehSerlKlFnNRjpDQ?=
 =?iso-8859-1?Q?cdA/YWEZLqRo8NFAEtuGtLvxZ76xCD1OQNixv//fsx4M0Wu2aJuqklZpKH?=
 =?iso-8859-1?Q?6v4MtgCcbjt9IvTSchLBfWItHZXOiZOaaqpC+vxGoKtCgI20a+ZzxipE8k?=
 =?iso-8859-1?Q?UhfBcZUy7RrcMWeqmctp5ye3PJ0El0CXXVKzD5qTMMnp0HNaX23Csj59e1?=
 =?iso-8859-1?Q?FxmluYQZ31DVuBCqpgmHj7q4Ef0MIwHvbz4fdml4uBgTUdwbFjVHyYpFUs?=
 =?iso-8859-1?Q?ZzgsYtwU2y/8yXSdl+qmSu3kU7QGqSAlpGHNgj/riC4bdTPUBvdtW1F7y4?=
 =?iso-8859-1?Q?waIBT2IbR6djje0YDSXgx7nkDmA5oci2KErG1rFy5rGJdZa+f1DDbDP1r6?=
 =?iso-8859-1?Q?+H7lEFIhuxq0HF3Hp7k9tnxfXBS8mmF9SBzp0W5AIN+kwbvo62oLC0Rk4n?=
 =?iso-8859-1?Q?oECbnC7+5Osw10jTOs4wz5c6yMLb4qoXhywEwlDm730ez+eoreeJKjuvLU?=
 =?iso-8859-1?Q?sLuboPpeX46im85tdXiVR2/ZEQgNcHL/kl5w0RLjFECTPCZTyUXNJ5TaMT?=
 =?iso-8859-1?Q?MWnFsj0bOtldTDHG9mM4LZN+fJi9ts6wlylWGWTC9KdJ686HaU1iEX2mPF?=
 =?iso-8859-1?Q?gD3whzboQ7zeSsK99B1XC/Cwt3/DK/4VP0pr+rD2H8DppoCLb4hozpbVU5?=
 =?iso-8859-1?Q?t/VcDv2ZGLOoEysdV/aeia+HTmF3o+ukt3U+h+BoMfMgAZtB+Jpf/srtU6?=
 =?iso-8859-1?Q?o1KKABYAKy3VkYiIiXbHhtNBmiC8biNzL37c4V+sKn7l1LkFPpNS77d6YK?=
 =?iso-8859-1?Q?NwHyj/umCc9x3DUBoeKUSnJ3ajHCp4G4hawc7roGMdcrMEDxgGcwt37QW3?=
 =?iso-8859-1?Q?vuILhSyxYJQvwEVZxKX4MpzTGc8yfgWSAwqCmXrGrtnZoTzte+G5Am0eQG?=
 =?iso-8859-1?Q?eTe6/qmVQhiXU9/etPaSBIgsdz8pmRjiw1XQd3YSLqUxLMTZSMR54PQz8O?=
 =?iso-8859-1?Q?XrAuvn1ffGqpgLAQGH1yiJBlCoOw3t+NzBVWPjbKKE3Z42bKIleo+WQl+F?=
 =?iso-8859-1?Q?wjp3sdLAB6G6/UueWUD7TQOl8vD1k9xcZfcfbNXCXUEj4yRrIJ5Y8KKX4v?=
 =?iso-8859-1?Q?WHYRX/OTs+YyXOEP7QyF8jZ31soddaC+iPLMiaKuAODkKqC+S7nQyYy+eS?=
 =?iso-8859-1?Q?zAwCHW7aCvj31R8u86bQyKDkPZuFxjyp51?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: biamp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR17MB5419.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf15ea99-bcd6-4f70-a7a1-08dc653ae5c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 15:18:01.7047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0fty15icEb8Z3zQKL5VaVILPE1OPRWYAr3zx2sHaEAyxMniSRyYkPOcMXhqJpikIAw6cpkHJsPxMWzcVC2z6Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR17MB3720
X-Proofpoint-GUID: bN78hoFvMHgcxp48r1EmzItugNX8a6LK
X-Proofpoint-ORIG-GUID: bN78hoFvMHgcxp48r1EmzItugNX8a6LK

=0A=
Hang on to the control IDs instead of pointers since those are correctly=0A=
handled with locks.=0A=
=0A=
Fixes: 8fe9a03f4331 ("usb: gadget: u_audio: Rate ctl notifies about current=
 srate (0=3Dstopped)")=0A=
Fixes: c565ad07ef35 ("usb: gadget: u_audio: Support multiple sampling rates=
")=0A=
Fixes: 02de698ca812 ("usb: gadget: u_audio: add bi-directional volume and m=
ute support")=0A=
Signed-off-by: Chris Wulff <chris.wulff@biamp.com>=0A=
---=0A=
v2: Removed items not directly related to controls. Added Fixes:=0A=
v1: https://lore.kernel.org/linux-usb/CO1PR17MB54190B898057616EEB3F9E51E10E=
2@CO1PR17MB5419.namprd17.prod.outlook.com/=0A=
=0A=
 drivers/usb/gadget/function/u_audio.c | 19 +++++++++----------=0A=
 1 file changed, 9 insertions(+), 10 deletions(-)=0A=
=0A=
diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/fun=
ction/u_audio.c=0A=
index 4a42574b4a7f..c8e8154c59f5 100644=0A=
--- a/drivers/usb/gadget/function/u_audio.c=0A=
+++ b/drivers/usb/gadget/function/u_audio.c=0A=
@@ -57,13 +57,13 @@ struct uac_rtd_params {=0A=
 =0A=
   /* Volume/Mute controls and their state */=0A=
   int fu_id; /* Feature Unit ID */=0A=
-  struct snd_kcontrol *snd_kctl_volume;=0A=
-  struct snd_kcontrol *snd_kctl_mute;=0A=
+  struct snd_ctl_elem_id snd_kctl_volume_id;=0A=
+  struct snd_ctl_elem_id snd_kctl_mute_id;=0A=
   s16 volume_min, volume_max, volume_res;=0A=
   s16 volume;=0A=
   int mute;=0A=
 =0A=
-	struct snd_kcontrol *snd_kctl_rate; /* read-only current rate */=0A=
+	struct snd_ctl_elem_id snd_kctl_rate_id; /* read-only current rate */=0A=
 	int srate; /* selected samplerate */=0A=
 	int active; /* playback/capture running */=0A=
 =0A=
@@ -494,14 +494,13 @@ static inline void free_ep_fback(struct uac_rtd_param=
s *prm, struct usb_ep *ep)=0A=
 static void set_active(struct uac_rtd_params *prm, bool active)=0A=
 {=0A=
 	// notifying through the Rate ctrl=0A=
-	struct snd_kcontrol *kctl =3D prm->snd_kctl_rate;=0A=
 	unsigned long flags;=0A=
 =0A=
 	spin_lock_irqsave(&prm->lock, flags);=0A=
 	if (prm->active !=3D active) {=0A=
 		prm->active =3D active;=0A=
 		snd_ctl_notify(prm->uac->card, SNDRV_CTL_EVENT_MASK_VALUE,=0A=
-				&kctl->id);=0A=
+				&prm->snd_kctl_rate_id);=0A=
 	}=0A=
 	spin_unlock_irqrestore(&prm->lock, flags);=0A=
 }=0A=
@@ -807,7 +806,7 @@ int u_audio_set_volume(struct g_audio *audio_dev, int p=
layback, s16 val)=0A=
 =0A=
 	if (change)=0A=
 		snd_ctl_notify(uac->card, SNDRV_CTL_EVENT_MASK_VALUE,=0A=
-				&prm->snd_kctl_volume->id);=0A=
+				&prm->snd_kctl_volume_id);=0A=
 =0A=
 	return 0;=0A=
 }=0A=
@@ -856,7 +855,7 @@ int u_audio_set_mute(struct g_audio *audio_dev, int pla=
yback, int val)=0A=
 =0A=
 	if (change)=0A=
 		snd_ctl_notify(uac->card, SNDRV_CTL_EVENT_MASK_VALUE,=0A=
-			       &prm->snd_kctl_mute->id);=0A=
+			       &prm->snd_kctl_mute_id);=0A=
 =0A=
 	return 0;=0A=
 }=0A=
@@ -1331,7 +1330,7 @@ int g_audio_setup(struct g_audio *g_audio, const char=
 *pcm_name,=0A=
 			err =3D snd_ctl_add(card, kctl);=0A=
 			if (err < 0)=0A=
 				goto snd_fail;=0A=
-			prm->snd_kctl_mute =3D kctl;=0A=
+			prm->snd_kctl_mute_id =3D kctl->id;=0A=
 			prm->mute =3D 0;=0A=
 		}=0A=
 =0A=
@@ -1359,7 +1358,7 @@ int g_audio_setup(struct g_audio *g_audio, const char=
 *pcm_name,=0A=
 			err =3D snd_ctl_add(card, kctl);=0A=
 			if (err < 0)=0A=
 				goto snd_fail;=0A=
-			prm->snd_kctl_volume =3D kctl;=0A=
+			prm->snd_kctl_volume_id =3D kctl->id;=0A=
 			prm->volume =3D fu->volume_max;=0A=
 			prm->volume_max =3D fu->volume_max;=0A=
 			prm->volume_min =3D fu->volume_min;=0A=
@@ -1383,7 +1382,7 @@ int g_audio_setup(struct g_audio *g_audio, const char=
 *pcm_name,=0A=
 		err =3D snd_ctl_add(card, kctl);=0A=
 		if (err < 0)=0A=
 			goto snd_fail;=0A=
-		prm->snd_kctl_rate =3D kctl;=0A=
+		prm->snd_kctl_rate_id =3D kctl->id;=0A=
 	}=0A=
 =0A=
 	strscpy(card->driver, card_name, sizeof(card->driver));=0A=
-- =0A=
2.34.1=0A=

