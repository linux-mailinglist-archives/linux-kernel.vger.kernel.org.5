Return-Path: <linux-kernel+bounces-157575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4558B1319
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27FF4B27412
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467742C1B4;
	Wed, 24 Apr 2024 19:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b="AoPUldaC";
	dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b="ATn5I9tr"
Received: from mx0b-0068d901.pphosted.com (mx0b-0068d901.pphosted.com [205.220.180.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F33E1CA9C;
	Wed, 24 Apr 2024 19:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.180.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985285; cv=fail; b=MgnaF69Hzams4rAG8Ou6Kr0aRTle8oFC04kGvGRqJVJcSwDBl2wPzth7TrHMht65b7lmfcYFd1smeG036Yib07RqBUXTtTrHe1/dP50ndTBy6QZvrE1ShknkPYmrs5SwGXo4JHsbmpcdbd5C4yVAUCFZhE+Lm1YSEYNYdC0Hffw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985285; c=relaxed/simple;
	bh=bbzYKWmuaWDC8Xx4NbiVXdjwmtgcEgyrlIZZvrTOSKg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t5FaHYOAMb3kwOeI9badPB2UY47sVL+SbuqePSYECKSiYo4dtSWeEyBQU/aSMlIjwUexSlXAxENBR1uWT+1MMLaeGYhptdvQ2Emj2EQF+ydM7s8Mgn3Jd+XrbfzJmbAInyDNak0KtEEB0HNuhmkIbZ6tWQxvER6syn/ltYnj0VE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=biamp.com; spf=pass smtp.mailfrom=biamp.com; dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b=AoPUldaC; dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b=ATn5I9tr; arc=fail smtp.client-ip=205.220.180.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=biamp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=biamp.com
Received: from pps.filterd (m0278265.ppops.net [127.0.0.1])
	by mx0b-0068d901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OAqefU010703;
	Wed, 24 Apr 2024 12:01:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	proofpoint; bh=bbzYKWmuaWDC8Xx4NbiVXdjwmtgcEgyrlIZZvrTOSKg=; b=A
	oPUldaCFOuOVogGkOBcZs7mLN+mzSmR3IA78hwCFD0fHy5RtGq7DYfHfIyKCbzGE
	wDk4Qiz4jDG5LMvctekRheTwZx8PmaNjUXACsma94Rd4tKFRbvNsM41knygjjr9m
	27Q4KDGnUpfnrQiN2u7ivn/SZNiBCkvFnnyr56OzUMpJMaoyt49p1LFr+40ifP+b
	ofYHPO8Y2kuc8/apnHCGvJYuhziXnEgJuEV3ViokfD7tO3AiaWGKGl5q5f2+O9gr
	4M6PH023laWG2ve/peiqBaB/p00/IQ/DdQN7qybztbethr5g8fSR2tq6PYT4SxdJ
	7IovYC2dhh0Kuoi+faCCw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0b-0068d901.pphosted.com (PPS) with ESMTPS id 3xmadvk6dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 12:01:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJ7jyaJQDFDa/rjE6rPF366ZDXEulxm1KOSRktPq5fE3vRt6n8/lAqvCSeC6J7A+rshFtrDR1IdBUow9hvA28gXufxyAuVbjJv4tXkIhZnRuC61E5U4E/OUkk/WPBGv63S2i/KmkQ4leZATWh6qfGeTLtqaxw19ctFUBPee5+JQgfPZ6703lOTRdj6cnvQ0K51cZU9B0N8ieKZupK/A0cNhmFqLn6L51Y9Bqlv/n3lgMTx2+0xedI3MbI9vhp4pRVxL9pXasrGFPESLdKVM9/2paoMHLfs2WaDxps2JR+AC/XpAllUHlts+jITyI8HBKcIipZjpTamMrDrrSwvXN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbzYKWmuaWDC8Xx4NbiVXdjwmtgcEgyrlIZZvrTOSKg=;
 b=aSgyczjs2QQxbUsp2boRDU8L/pxtSJKYN1CnAoK7XvFsfUXFBlkw5wPKY3Kp4/NJXeAUF+8Lk61Ev4AKZqdm7DA567t2+3L5r0w+Me/lBTFNAqZpBwy570+/YaU+tMx+J9EGuRdug35h3fpGj9I4Hz5AiFg9MLYpoWTa5QDDCb3TKwQWQ2np4Q3ge7GdYv8WOFdVQb1YSMQbFKOlKK5NKcKUFmhR8ndirbbW407q1P34jLPPz8xrM4cwvxU628ra4rwWjtg/LvW8KiE+zLqvydl0/bKqKpvtgc4H13/KIp/houJIBykf/vAWb0cyCgwmgARRPPma7GGs4reLaR7FDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbzYKWmuaWDC8Xx4NbiVXdjwmtgcEgyrlIZZvrTOSKg=;
 b=ATn5I9trrX7fNH06kl+f03y0BD2elW4vFpIuqfIBaZD83+AMBR5E0hURjieW+oYdYvN0fICakI0PxaRdScv5rF1JGnE7gRg+PAJaToBjMX0+H7ZGX+eUmHpcyp4onkPQQ4WvDUJYnS2zCNsFr92WeiWfnd98lk4D/F4PcHBgJLZGahVBUSEujIcSemc9GZg7CyEdKaYVOhxzqMadPQYSukqgEgzf2kpMUmuvrmN5dvbFn8eJQDIFqsmlTHQwU1T5geD590qEpmYafaDqNlpjJQ9jhFJiBD75Unh8+OJkCtpx8zP8vAF7C55QbAxIfcuuzDTlJvA3dDpG7E0Oc7QZow==
Received: from CO1PR17MB5419.namprd17.prod.outlook.com (2603:10b6:303:ec::17)
 by PH0PR17MB4357.namprd17.prod.outlook.com (2603:10b6:510:19::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 19:01:05 +0000
Received: from CO1PR17MB5419.namprd17.prod.outlook.com
 ([fe80::f48:ee61:a81b:d555]) by CO1PR17MB5419.namprd17.prod.outlook.com
 ([fe80::f48:ee61:a81b:d555%4]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 19:01:05 +0000
From: Chris Wulff <Chris.Wulff@biamp.com>
To: Pavel Hofman <pavel.hofman@ivitera.com>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Gruber
	<jimmyjgruber@gmail.com>, Lee Jones <lee@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2] usb: gadget: f_uac2: Expose all string descriptors
 through configfs.
Thread-Topic: [PATCH v2] usb: gadget: f_uac2: Expose all string descriptors
 through configfs.
Thread-Index: AQHalYdWgtu02BG/fUykcYHBF1kPmLF1/Y0AgAAPjZuAAQFjgIAAtu3D
Date: Wed, 24 Apr 2024 19:01:05 +0000
Message-ID: 
 <CO1PR17MB5419DDEE71C3145C158326C6E1102@CO1PR17MB5419.namprd17.prod.outlook.com>
References: 
 <CO1PR17MB54195BE778868AFDFE2DCB36E1112@CO1PR17MB5419.namprd17.prod.outlook.com>
 <c9928edb-8b2d-1948-40b8-c16e34cea3e2@ivitera.com>
 <CO1PR17MB541989646698286B2B13CF23E1112@CO1PR17MB5419.namprd17.prod.outlook.com>
 <9b40e148-f3eb-f8f5-bf2d-37a0a0629417@ivitera.com>
In-Reply-To: <9b40e148-f3eb-f8f5-bf2d-37a0a0629417@ivitera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR17MB5419:EE_|PH0PR17MB4357:EE_
x-ms-office365-filtering-correlation-id: a8a92220-342d-44f9-e0bc-08dc6490e471
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?pXqipC7Mvy94IFFoCeFSrnUtm0Zq0iGif8ZgjWgzrQNVwoCTxwN67Go/ln?=
 =?iso-8859-1?Q?RS4cluXzg11ZrSZ08zr6XbA9spYYtvo0doTUS9BTlfMZXjXIZ11ZrstlWD?=
 =?iso-8859-1?Q?Q4r5JrPFoTKFb27XiUjBAsqZr6pB7IiMsbvmsq8G/+u6FMtouc/vgEOK2c?=
 =?iso-8859-1?Q?KzaAHbGjWSoYlBMn0CphqU6p5kCRmnosMW1YOCXx5/bnbEpg+K5dXtqx7J?=
 =?iso-8859-1?Q?SIBuru88Q65Im2/4eU2QrU08ILQNACO+wWa+gIN5HD2+ct5b3ahWet/54e?=
 =?iso-8859-1?Q?DtrKKsRZlHDe/yU8luP7SUY9PZutH6bA0q9p00u9fXOVRLUIOfCzoN/CmK?=
 =?iso-8859-1?Q?DSigQ2mKsvkgc79vLOTkNeFx1EgDRVorfjnJzz48w8juDQrhODzL4IqIcw?=
 =?iso-8859-1?Q?cyDLm81l1YUe9qjkNKmQzixxBdMnS0U3lajbOkqw/vzHil3kwXh9UKD4ok?=
 =?iso-8859-1?Q?BWkbjPD0dyhPqsJUnrEQDXcVpbTymSjL7ExbQ0LabPuarEt3cWA3BkdnjH?=
 =?iso-8859-1?Q?auJ4OX0ebMlGxOn0/+LytNWpXl/LUxYESkyTX5K3nOc2/BzBE8GkfELLve?=
 =?iso-8859-1?Q?wXvOYBPEbYaHBvLVZOU0QODNpgAh6YMgp8XA5VNzRSIjRDlLLm4MVKqUFK?=
 =?iso-8859-1?Q?3zoI7XLMa3+D1IeBlRExiOPEaneRYhF/1cZLUE1dzPQf2IF5lbAC/RfMMJ?=
 =?iso-8859-1?Q?Bl+YAMScGwnqg70m5KtvbKOJwTBaI2iU50yahmqwYVqbr/OhF2A8W9bjSu?=
 =?iso-8859-1?Q?Rqad4IoUR9pWVoHUo1lz9ICUsgbMdFB4KdElAWXxeQpn2h7E0uq5cbspP8?=
 =?iso-8859-1?Q?Exdphhln8g7UO/RlYz9B71kz40gVXIz4IoDEqSPuPHRKKfNWFNzviWxCh5?=
 =?iso-8859-1?Q?zvA/KIdPq70M3T9O8Bf+vL/Oj5GcalwDXcuIlFMI8SV3YufjRIaiY7aQK+?=
 =?iso-8859-1?Q?XpEC3VQcZCnFEl8aYX6PeOGZMMo8xZH888WV6+padZPWvjEV5YnzdoBuq1?=
 =?iso-8859-1?Q?sKcRYdlYqFzFkJgBmJ9sH1DPEOemMOk3eeK6bvcgJEEXdHPEO/1XxtcxZi?=
 =?iso-8859-1?Q?3Mu4H6ERcGZA7AMFrNHT2jThMe4gHOBalnbJfvpsovcc4pYTo7jHa2pNJu?=
 =?iso-8859-1?Q?kln1b/oJocjE0PP4C/Z4IEbdFXj+eT+f+Wn51WYmsNixcq50DbfWbk2Mmf?=
 =?iso-8859-1?Q?BfkTACHzRTuDf+seSy5ThyQWzqGnwHEKY+4TxkVXU904Co0Jgl//6hEsv+?=
 =?iso-8859-1?Q?YjTUQF8usyFPhg2l8POCHYeyXi6vrA4szJMn7qGJIF/EPwWDH1ymrI3HQ4?=
 =?iso-8859-1?Q?tAEUN9Vkcz6AQI+eKq8DirAOeA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR17MB5419.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?v1BlI3OPI1rO6WoQyGSfUaGdvxPzN5fl6p9GtESPKbycONz5YlP0ePHVDx?=
 =?iso-8859-1?Q?dGpNikOAKrj2T/m65p+UBrDTBvyDuNDA9nToztFelH9A1JtqCj0bt2Mo6t?=
 =?iso-8859-1?Q?ShRooCzVpgbyW/cd4Tqu8mvHHz22dArGIxYRayYgmdNeU17NEKzEtEVTKq?=
 =?iso-8859-1?Q?FEMsT3sa+4JWf9AjWiJx30P5AEelRP56r6f+t4YF328JCIe0F1sNC5ydxV?=
 =?iso-8859-1?Q?jimnxUn1jmk4+MVH2i8qmKyOYd2ZKFvWrFb/u/pFmHTBgTVQ720sjXDs4b?=
 =?iso-8859-1?Q?UlXunPlhvUhy2dwQHrrVziNnnd8IHceq/+rBqDLVvIiCgMecdLlPCLVSyz?=
 =?iso-8859-1?Q?M03WF6dF5RGuhcQk10vx6vlYv/NQkPilRWE1F2nIsXD3DkuhEbL90omN8F?=
 =?iso-8859-1?Q?hYI292OKdAkyPgdanPxOAkxgQIqWIxJCA4w/exiqW5aqGPK2/9lxKDI3ri?=
 =?iso-8859-1?Q?edwIeXDWme+aeicznq8oZsPK+Xk8R+l6EJd0MnWfLO3uQDhaTt7W3/bxDh?=
 =?iso-8859-1?Q?sLUm6CTj+Up9SfEgZATT2KXHn3KPS8UrDHdRnt55nyec2yQxdf1qKDIV7t?=
 =?iso-8859-1?Q?rJSjLDLuz3iqYSyFAMmiejog5bkLMfZh6DSE3AsCohVaNGPAZHvwBwBopZ?=
 =?iso-8859-1?Q?UMAN6L//5w5YM/5tTb6f6nqq0MojIOMr2lmq2F80lGz9rC6VLjPWHOm0IF?=
 =?iso-8859-1?Q?TD/Slbe8EFtif5+hCPppK8yEr5Twqyf9ineYCKjuy0eNldoXsYGuJSpFrE?=
 =?iso-8859-1?Q?Avs+gf6JEMTgapSf+MZVSk45F5Plq2zbI2aFLAOjMcszeni/y3mqLn1hpV?=
 =?iso-8859-1?Q?7Nve7XG5jpVgizjZ9MV0awxZFYk5bTDXuwUSm50j8jHkS2+5q9ueVuxrjX?=
 =?iso-8859-1?Q?xaqsDGiLRt9v3Y4HGu+NX+iwfPa8uDsCk3pa4TnFPlW5xehKrAwKeo2k7T?=
 =?iso-8859-1?Q?xFNEBDoFs5Ki6e+BAYrylieNw33IX8obAPajvPt0ALKkorqrtwdzVnmdyS?=
 =?iso-8859-1?Q?mXBNG8BC0iAUORoVMu/1wRPs37u3cX1YAP7M0dWdCcQjamfUMfeM5ULzfW?=
 =?iso-8859-1?Q?uiZALHOtRYwyTeX3+6M8UaaPctBi0juAuqOxzcdDrOgUOdver8XZE0oXpc?=
 =?iso-8859-1?Q?hkW0ooFXM7c+5/UhEPSEqYAWRslNaVLnphU92F61H5bFsHC4DDzckduraW?=
 =?iso-8859-1?Q?yoGYUB8IYCvzVFe+kguPkuFeUe4scflwnRYg6/7w2sIZKyxsKIO6PeUkEM?=
 =?iso-8859-1?Q?NvISSipcMMtFyQMMyg+85EFk2KDwbiX2IcSz1T1C1NcEWUe8vKBZviCz+z?=
 =?iso-8859-1?Q?m/n4ZIVS9ywHw8OZIMfG/2dOiM/NpyKhNsObulXDoxaG9lu0IHz67lShru?=
 =?iso-8859-1?Q?XDTKTlZVgZjt5KXZUi+WWY7fYkHHVLJFNxsHsWuzi2lCBiGhF058TJpSZH?=
 =?iso-8859-1?Q?NYRyCb8rHlLbwsAodEQ2m6g0+RLZd8geE5KLWcnHkejZNYtJxLF+OoAdp4?=
 =?iso-8859-1?Q?Hd62sDra3BYcaTvfGELOlQm5x4We9hc44Cw9/g433+XMVYgaSuq8cVq9OP?=
 =?iso-8859-1?Q?Q302vXPh/wdDBPV1VFnD3rL4XrA+qlSgtH4sMLH7UqbdU8TKvJJ/PBLVb6?=
 =?iso-8859-1?Q?njQHPforzVqF7pguv1pSjbgAXmgQKt5Qb3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a92220-342d-44f9-e0bc-08dc6490e471
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 19:01:05.0439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HjjBaUC8wD2EG3GsUWUtQ/HT11W+PcY87WKZ+hhiIORTsyt71ihVQD6JKL9hvLy8r3V0Neb5xvnjbz+pogJY8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB4357
X-Proofpoint-GUID: 6vVgdgR791LstFJzwdWAWtJhnpwfdg2P
X-Proofpoint-ORIG-GUID: 6vVgdgR791LstFJzwdWAWtJhnpwfdg2P

>From:=A0Pavel Hofman <pavel.hofman@ivitera.com>=0A=
>Sent:=A0Wednesday, April 24, 2024 3:55 AM=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p_it_name=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 playback input terminal name=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p_ot_name=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 playback output terminal name=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p_fu_name=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 playback function unit name=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p_alt0_name=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 playback alt mode 0 name=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p_alt1_name=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 playback alt mode 1 name=0A=
>>>=0A=
>>> Nacked-by: Pavel Hofman <pavel.hofman@ivitera.com>=0A=
>>>=0A=
>>> I am not sure adding a numbered parameter for every additional alt mode=
=0A=
>>> is a way to go for the future. I am not that much concerned about UAC1,=
=0A=
>>> but IMO (at least) in UAC2 the configuration method should be flexible=
=0A=
>>> for more alt setttings. I can see use cases with many more altsettings.=
=0A=
>>>=0A=
>>> My proposal for adding more alt settings=0A=
>>> https://lore.kernel.org/linux-usb/35be4668-58d3-894a-72cf-de1afaacae45@=
ivitera.com/=0A=
>>> suggested using lists to existing parameters where each item would=0A=
>>> correspond to the alt setting of the same index (+1). That would allow=
=0A=
>>> using more altsettings easily, without having to add parameters to the=
=0A=
>>> source code and adding configfs params. I received no feedback. I do no=
t=0A=
>>> push the param list proposal, but I am convinced an acceptable solution=
=0A=
>>> should be discussed thoroughly by the UAC2 gadget stakeholders.=0A=
>>>=0A=
>>> I am afraid that once p_alt1_name/c_alt1_name params are accepted, ther=
e=0A=
>>> will be no way back because subsequent removal of configfs params could=
=0A=
>>> be viewed as a regression for users.=0A=
>>=0A=
>> I have been thinking about this as well. The alt names are slightly diff=
erent than the rest of the settings=0A=
>> since they also include alt mode 0. I was thinking p/c_alt1_name could b=
e expanded to the array so=0A=
>> that the entries line up with the other settings and don't have an extra=
 entry for alt 0. Perhaps a different=0A=
>> name would make more sense.=0A=
>>=0A=
>> Along those lines, I didn't see any gadget drivers using an array of str=
ings for anything, which is also why=0A=
>> I didn't try to do anything here that merged alt0/1 names into an array.=
 If we were to do an array of strings=0A=
>> I'm not sure what the best separator would be. Maybe ";"? The rates arra=
y uses ",".=0A=
>>=0A=
>> This patch only exposes the existing strings to make them configurable, =
but I don't want to do anything=0A=
>> that would preclude a nice interface for extra alt modes.=0A=
>>=0A=
>=0A=
>Thanks a lot for your response. Please can you take a look at=0A=
>https://lore.kernel.org/linux-usb/72e9b581-4a91-2319-cb9f-0bcb370f34a1@ivi=
tera.com/T/ ?=0A=
>=0A=
>If the params in the upper level were to stand as defaults for the=0A=
>altsettings (and for the existing altsetting 1 if no specific altset=0A=
>subdir configs were given), maybe the naming xxx_alt1_xxx could become a=
=0A=
>bit confusing. E.g. p_altx_name or p_alt_non0_name?=0A=
=0A=
I am in favor of the subdirs for alt mode settings, with the main config op=
tions acting as the default/single=0A=
configuration as it is today.=0A=
=0A=
I can change these patches from c/p_alt1_name to c/p_altx_name if nobody ob=
jects to that, or I could remove=0A=
the alt name from this patch set if anyone thinks this needs more discussio=
n. I don't actually need to set=0A=
the alt name for my use case, but included it for completeness.=0A=
=0A=
-- Chris Wulff=

