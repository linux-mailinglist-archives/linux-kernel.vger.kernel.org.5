Return-Path: <linux-kernel+bounces-473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAD08141B2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0F7283C27
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B54CA64;
	Fri, 15 Dec 2023 06:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Q59Me2I2";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="BbEa3ek1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD0710782;
	Fri, 15 Dec 2023 06:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a7cf2e3c9b1011eeba30773df0976c77-20231215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Cq2QeswQ35/31u2kQ4ggWOSFs5g2Cs3YR6usBDY2mpc=;
	b=Q59Me2I2kgdo7Qjqnc6SeqqG/VU6b62y/Tg+EqKJ0pFk2TIBwxKQ8elSIjkNCkiP+DnaPvSN7YKrp9YEPx/iF04ngGAYr5Dp+ALhLfR/DBVTBhaTm4XvBedFPE0gHj3sOmEMryOTdHlkGN0kRHDmyagzs5BpPJe6RYzV4bQoqbA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:98c3fe24-041d-4fff-91e0-6fc2738c3523,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:6688b3fd-4a48-46e2-b946-12f04f20af8c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: a7cf2e3c9b1011eeba30773df0976c77-20231215
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 435131621; Fri, 15 Dec 2023 14:10:33 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Dec 2023 14:10:32 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 15 Dec 2023 14:10:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejNDnw6iFJOh4tIMqFmGI0JioPro3xXuGSfRYhIpfeouA41TGmsASN31KiT67nC54uVl0EmbtHbH4enQCF8veTbOlGwDh6B9/eEk0dgYJFcXbGAl/iOwekKoaaq37tILTxUN49XTy7aNshS/emSyMHF2+w+dTcA/2d/PBLl0vIRXYY0tIy4Uapl8vNe9pujweUilfvUQnQZVSwJzLh89x/B3Hjnea3o3y6+RJODxJ6RY7iPkWZGgncW/GjnxRsdFo7qxKFNvr/QUmOxQ8T0Z+ArPOdCmJue0HbcvTucNjMSvmGekouIDjMjE5yrzmf0/4Gi1DfZq6eUfQelvDxmm7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cq2QeswQ35/31u2kQ4ggWOSFs5g2Cs3YR6usBDY2mpc=;
 b=moaBLMDbeXg1UKDCp7e1jP+5layCsLFDwebBulFOc6Yr4Hfz7hQXegEdoztFBTZCTmYtY5PoV2+q8tAJI2OKeqghhHIco+v5T93N7b04enSrafocqCh4Y3V7xqMxE5I0o3ekKQNXSApU7wqZU4X1tsRukp8ssDyvKrQpWRjV8P+/pUaz/09hsAUmlGcjP4RDpeFVPnpp2H1OaIYtf2eaq66+P/w6kOUM12k4XmRQ4nqd4CCr9YZvKrQWJo7xCrod9lFuEMUK/7jJPl0B0nfk5HCdJcTu2sbHqIX+veMkSsIlMEWPkCkuut5CawsXpBWiTdGTL60h5ryygJfZWyS8Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cq2QeswQ35/31u2kQ4ggWOSFs5g2Cs3YR6usBDY2mpc=;
 b=BbEa3ek1m8XwT4132jaxleNzBIj2HlJt/i6JwcsVwGxE49TLDS3L5bqW4hFVNw2UcHSoXnCIFRjO0lRdfNdXW+A2OctcZwYWXcr4vkoGkC6oHqr6CFrbM2OPC9KIe3zPKMlW5iy2FYA+M5PBMwE+y6ymsKPth8OdALs+fND4k/c=
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com (2603:1096:400:33c::6)
 by KL1PR03MB7078.apcprd03.prod.outlook.com (2603:1096:820:cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 06:10:27 +0000
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946]) by TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946%6]) with mapi id 15.20.7091.029; Fri, 15 Dec 2023
 06:10:27 +0000
From: =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>
To: "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"mathias.nyman@intel.com" <mathias.nyman@intel.com>,
	=?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= <Eddie.Hung@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	=?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/3] dt-bindings: usb: mtk-xhci: add a property for Gen1
 isoc-in transfer issue
Thread-Topic: [PATCH 1/3] dt-bindings: usb: mtk-xhci: add a property for Gen1
 isoc-in transfer issue
Thread-Index: AQHaLY6dWSsEXZq+1E2EPlX2xQrPALCm20YAgAMEZwA=
Date: Fri, 15 Dec 2023 06:10:27 +0000
Message-ID: <150d776b6a4ab0f0ee1926dd916d6eea3a583ad5.camel@mediatek.com>
References: <20231213063543.12435-1-chunfeng.yun@mediatek.com>
	 <c1bc144d-07d6-422c-8294-42be47f83e59@linaro.org>
In-Reply-To: <c1bc144d-07d6-422c-8294-42be47f83e59@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7153:EE_|KL1PR03MB7078:EE_
x-ms-office365-filtering-correlation-id: bf19c423-cfc2-49c9-8c46-08dbfd3488cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rc4fIY0EPrLF9qcSvBTg3YqSKYOMUBsKyQ8wxff8upW0ETlC/CxJcweHOUuToOoagt62pR5xyIznVZNGuCDtgcfOT2k80k2SQnwFPi4WNUKLHQ5TyR062XpcM9Juv7zllJey9/IJb7Br/Vp6w8cjOuBTJNjFnt/PRsT0GHDZVw3mQmv4k4GpMwoqXjBi9AsrrWKhGyBzmahiIZnugV1r2FX+EJAw0csEus93+P8cdL5/9diZAyReaOEFuvmVDYLl41GX4dvKf5/nAERPVkzP7tQMFjWIdH/fmculYaU7d5C4akJMBZCpz53KkDu/0csEwciyQS1sputR7pybm5icWb4TjVTeVblH+NmTZcLXg9d35GblOihGU+mUaPvaYAvLXyLzEMa1LRMLgStmgwi31ySX+6OZ1WOjlHyxMcDLxfKhLdd8spj05wcZ17EXEOmGRs7ztVFZi3jZzHjquM0YlN/dgaKA0AM22zzD0b1Gyj4RbGvcNxmpJfUtKkBoBjOIiFmdUSbdr9TUdDFhuYsRwKaVjAj9HOOTGPZDSAtIKxAnkvVYDpL8/gzgjlI+U9XMQwvHG0MNPkDTtrgdOAMObfQBL/qFs22gp6mY/umdoAC/Fy2unC06FPfUhlk6v3r274tr2fNyLWen5B7VGnZGC3KNFPNI40kC+yoR+xnkJ+oktQyJH2qmQKzspvCbXc/ppdpS1h3AvEnJB57kEXi7d/yGboGlbWQgnvuUgU6arE4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230273577357003)(230173577357003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(4326008)(8936002)(8676002)(83380400001)(316002)(36756003)(38100700002)(85182001)(41300700001)(4001150100001)(86362001)(38070700009)(2906002)(122000001)(7416002)(5660300002)(2616005)(26005)(54906003)(478600001)(6486002)(6506007)(53546011)(6512007)(71200400001)(91956017)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(110136005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkVlcEVtd2NlT3dUS0M4M1UwZEdaaUIwK0UvOW5MYzVXNzhLQ3ZPbWphV01s?=
 =?utf-8?B?WmhaWnpkV0dHWXVFYzdic1BGaWlxbVlrUUs0RnMzU0QzV0s2NTVzWWVnZFd3?=
 =?utf-8?B?QTdBRE9WRWFjaGppbmpNN0hNN1VmQ1dRTko3M2ZRNlAyMDFUdHl3ZHYxRllR?=
 =?utf-8?B?T2pyM0J2eGxQQmU3UkhsQmJ5aitsMUI3Y01xdUMwcXFSZTQ3ME5VbEVsNjhl?=
 =?utf-8?B?SUFWK2h3YmRhMUJBRG55cTdtQitzLzV4NVlZUGNiNkoyWFQvQStnSkx6VENo?=
 =?utf-8?B?TlZMNUFtOWNqNjlHUysvMnZyN2xhdGYrTUM3cVFRc3pQd0N1WWlrbjBUZ05u?=
 =?utf-8?B?U1p6L3hKc2ljV0haQVN5QWZ2Y1BkK0JWQldxZzFsckowZnhmU0tBY0RoQ1ZU?=
 =?utf-8?B?TXM1OUdpeGpwUzFsdEdZK09oZW1JMXJhMVEwcVZPTUNCbEI5L2Y1M2IvNGZR?=
 =?utf-8?B?eW5nVmJCV3FxT1lCOUhMcG5PUzV5ZVZBS2xSTkZFZTVhbm1oOFhhanE3Q0sv?=
 =?utf-8?B?blRINHNNV1RnMkZlNFp0VEZmVmt5Y094eGp4SVJmNnFQNk56cmFXWUd2NVBG?=
 =?utf-8?B?a2xseERwY3ZLTllBajZwbldRd2VoNXRieXNQNWkwdlF5L1ErdmlVK1AyR3RG?=
 =?utf-8?B?U0NZMDJRZkxWVlV1V0crZlcxa2JYNFFwMlIzNDU1YzB2Z2RyN2J2UUtiNEpk?=
 =?utf-8?B?QnByeS9Pd2I3TGxSWm8zNDVEREpLbXZxVnBIOW9ITkp2aGhFNkswdHkzV0I3?=
 =?utf-8?B?eDRpOXd1eG4yVXB6dFJEbWJWQkwwbkxxcVpBNnhCYWtXSjlNT2FrTm95WTdk?=
 =?utf-8?B?dnF2ZVNmZkRSVENyMDYyMm5wdDNGSFgwSGV3YVRLejZybWVSbmNIMGptRzhQ?=
 =?utf-8?B?Zk8yOS9vcE42WnczU3JKZ1YvakRJb1YzRzBxb2oxT0dwOXJQRXRsTnBMVUN0?=
 =?utf-8?B?dERqNlFxcHJPQUp5VHhrSjUyeGtKQ003UTNUQWxJOXlrMVZNeHZ5SnoyRzFO?=
 =?utf-8?B?cmpWd0t2ZllPMEtKa2dPemd6UUsyOW9xOGoxdHFBWDdNMGF0TTlJL3lldHZR?=
 =?utf-8?B?L0FtT3BldWx0Z2dJTmtGS0NHWXhIMXZlZG0vYkwxRUVWNU92TDdvUVNUTlZr?=
 =?utf-8?B?a2ZuWU1qNGpKYnJ1eDZ3M3NseWl3SE1ZQ3ZZVzhmaThCYi9mVHJnb29HSG85?=
 =?utf-8?B?cFo5VENwTjNvaHZ1aVM0QnVVUktGOWI4d3JUbVh4MFpXKzVGVkpUQ0lRS3lm?=
 =?utf-8?B?T2NHQU5rSUx1WTRUOFVQeXQ0aEdRNitva2xqU3l5M3hwck9SMmpiWCs1bC9V?=
 =?utf-8?B?cXcrVXRDNTFMajUrSllLK0d1T3JtemorZ2wwMjNPdDdadzJpTWhrTDMveDdn?=
 =?utf-8?B?MlBseExZblZzMndRaHhpYjFHUDc0QldOZWdOQS9pTnRsK0pIdC9TS3lkZTc0?=
 =?utf-8?B?ek1XZDlYRkFCcGJPVnh0NW1nNUJlSEY4aDdyVlVRMEpDekpYb1UxZTRwRVVa?=
 =?utf-8?B?aE1sNTgwUGtWRkZhL2FzRklMcElvK29tRENmVDV6T1VNN1BFcGxPR25KejdW?=
 =?utf-8?B?Q2Yrb1JVdG43UmZ1UmR6NGZiQlA4c3dNRGE5MndWR2lLMmxlZmFlYUNDbDdk?=
 =?utf-8?B?MU9JOFA3MUNNTThEOXNWYXZ1dlN3L0VEZ3JaK2dteFVUZjY5bWxUYm4rdTAr?=
 =?utf-8?B?b1hwRHJ0UTh0ZFNGRkpZVm9ac3FvZ3hWWnlQdFIwVUJ0Wm1tS1c0Lzc1VjJU?=
 =?utf-8?B?QWZjaDUxZStKaE1QczRFZVN4V2FacUVhYlk2cHZWem1UMmpncytWV0ZiOFMy?=
 =?utf-8?B?eXhKREdieC9wbGhZUlhoTnRKUjZvdys2aG1EdFA4amNIakdGMG9zdEd3UzUw?=
 =?utf-8?B?L1Z2Unl5T09LSkdqWExrUDJFWE4rSnNldnp3TC94d0JVbEVLYlB5RUFBd205?=
 =?utf-8?B?aWppWXJnSjhKMlh3RWhhcjNlVUNvVXA4Qm1QUFdISU5BeXVYSE5TdmU1aVNC?=
 =?utf-8?B?ampoL1BmWDRFVDNXOFZBVmdqWldNUy9TYXVkTHF4Y0s2cWRXM3lxbjdGSG5Y?=
 =?utf-8?B?RGU2MkcraWNVSk9RTTcyQldKVzdHNERkU1M1ZWYxcHQ3aExRMlpKekJ2ZFlG?=
 =?utf-8?B?bmI0NzJ5SXRsbGhpSEtjRElZNWw5U2Q0dUxLbGZtWTlhQ1IxaU80ZlhpVWZx?=
 =?utf-8?B?dHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E799EBB1FE1E44E8BA5FA3E2FB157C2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf19c423-cfc2-49c9-8c46-08dbfd3488cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 06:10:27.8124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HZCRPlddh555yWw4YUb536xSzragA2tzSdLhMOell+9JjHjkjDFLQJbrcVvkxT5q73L4mwoLQAtbjUsC6gfnFwFzGdZSLu6qi5oZcapEjnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7078
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--30.219400-8.000000
X-TMASE-MatchedRID: c/HXCguHooHUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCs4D9nSCoJCSmlaAItiONP0mOHJ0aBcO1LVhTD1Udgq8Q4m
	03/V++Q7aFEofExIUPLYkV2Ealq/r0RCs70uuPqGM29hkek7Xd0yQ5fRSh265ArMcoUfMuwmrwz
	W10Vkqj1jFdRz4gFyhkDfm1zFLejyz4qmxBSXJhTPDkSOzeDWWJNtuyL6mpIXHkH7uosEn7P0ub
	/xgdoFfDN6hJxw3x/8fZdczzDm/ukL9tcyTZdAsgxsfzkNRlfKx5amWK2anSPoLR4+zsDTtAqYB
	E3k9Mpw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--30.219400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	8C41EB17B18EE8A3D75F4281A26982A5A7ACA5B5308BAFF05E4023A4AAA672872000:8
X-MTK: N

T24gV2VkLCAyMDIzLTEyLTEzIGF0IDA5OjA1ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDEzLzEyLzIwMjMgMDc6MzUsIENodW5mZW5nIFl1biB3
cm90ZToNCj4gPiBGb3IgR2VuMSBpc29jLWluIGVuZHBvaW50IG9uIGNvbnRyb2xsZXIgYmVmb3Jl
IGFib3V0IFNTVVNCIElQTQ0KPiB2MS42LjAsIGl0DQo+ID4gc3RpbGwgc2VuZCBvdXQgdW5leHBl
Y3RlZCBBQ0sgYWZ0ZXIgcmVjZWl2aW5nIGEgc2hvcnQgcGFja2V0IGluDQo+IGJ1cnN0DQo+ID4g
dHJhbnNmZXIsIHRoaXMgd2lsbCBjYXVzZSBhbiBleGNlcHRpb24gb24gY29ubmVjdGVkIGRldmlj
ZSwNCj4gc3BlY2lhbGx5IGZvcg0KPiA+IGEgNGsgY2FtZXJhLg0KPiA+IEFkZCBhIHF1aXJrIHBy
b3BlcnR5ICJtZWRpYXRlayxyeGZpZm8tZGVwdGgiIHRvIHdvcmsgYXJvdW5kIHRoaXMNCj4gaGFy
ZHdhcmUNCj4gPiBpc3N1ZTsNCj4gPiBUaGUgc2lkZS1lZmZlY3QgaXMgdGhhdCBtYXkgY2F1c2Ug
cGVyZm9ybWFuY2UgZHJvcCBhYm91dCAxMCUsDQo+IGluY2x1ZGluZw0KPiA+IGJ1bGsgdHJhbnNm
ZXIuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5A
bWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy91c2Iv
bWVkaWF0ZWssbXRrLXhoY2kueWFtbCAgICAgfCAxMA0KPiArKysrKysrKysrDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLQ0KPiB4aGNpLnlh
bWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10ay0N
Cj4geGhjaS55YW1sDQo+ID4gaW5kZXggZTk2NDRlMzMzZDc4Li5iOGVkNjg1NzRiYTQgMTAwNjQ0
DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRl
ayxtdGsteGhjaS55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3VzYi9tZWRpYXRlayxtdGsteGhjaS55YW1sDQo+ID4gQEAgLTEyNCw2ICsxMjQsMTYgQEAg
cHJvcGVydGllczoNCj4gPiAgICAgICAgZGVmaW5lZCBpbiB0aGUgeEhDSSBzcGVjIG9uIE1USydz
IGNvbnRyb2xsZXIuDQo+ID4gICAgICBkZWZhdWx0OiA1MDAwDQo+ID4gIA0KPiA+ICsgIG1lZGlh
dGVrLHJ4Zmlmby1kZXB0aDoNCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiANCj4gVGhlIHByb3Bl
cnR5IGRlc2NyaXB0aW9uIGFuZCBkcml2ZXIgcGF0Y2ggc3VnZ2VzdCB5b3UgY29uZmlndXJlIHRo
ZQ0KPiBkZXB0aCBvZiBGSUZPLCBzbyB0aGlzIHNob3VsZCBiZSBub3QgYm9vbCwgYnV0IHNvbWUg
dWludDMyLiBBbmQgdGhlbiwNCj4gdXNlIGdlbmVyaWMgImZpZm8tZGVwdGgiIHByb3BlcnR5IHRv
IHNldCBkZXNpcmVkIGRlcHRoLg0KSSBmaXggaXQgYXMgMiwgaXQncyBPSyB0byB1c2UgYSB1aW50
MzIsIEknbGwgbW9kaWZ5IGl0Lg0KDQpUaGFua3MNCg0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywN
Cj4gS3J6eXN6dG9mDQo+IA0KPiANCg==

