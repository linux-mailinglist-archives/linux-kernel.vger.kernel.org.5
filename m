Return-Path: <linux-kernel+bounces-70717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A1D859B7E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27A03B2184D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF881CD2E;
	Mon, 19 Feb 2024 05:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="pBmIA75W"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D3F28F7
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 05:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708319031; cv=fail; b=HVAXKai3BRsYJJD72/wI5WjBNmu1DEQwEIbjdh7jWLBHk91o3Rq32ngz1T94p6Xmwlq12cZea4UXe1Q3mni4Cw/f0cqWMGBTumVb2lpWbj9sta/yyv0+2KTXbwLzPSsYDYA/s32154IhQOo2T7hJkckqDGlJPwsNQttxfPr0nlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708319031; c=relaxed/simple;
	bh=Ql/8IKtoqKs7DXxkR+Swsw9+TJ5dbnxxUwi9ENxkn5Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=swmed/Dsq9Fnif4NxtoABzklZ+ftHv6h69lEDDgIWhnsi5KHfK6r+eA/p18GfUCWAxlOrviSB8L1BTchnU52US1eVqdje4zfZFJEQ8khZr5jWZiH+o6hBeccUqGK5jHLLOVCt3lu4eaQqe6F+wDrQ9XsTqwbs+mhnWepQQa6TM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=pBmIA75W; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41IMtP8r014788;
	Sun, 18 Feb 2024 21:03:41 -0800
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3waw6ju6u1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Feb 2024 21:03:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zi+/VSORF+ryjk6+NS72GRm04CfsXaWzLArVMr/1L+k/lnLco6AVuR6pjV6qgRBwykPtl7B4NGX6uh9DLJTD33hG/US3BkmqmFS3uaF+QxRuwQibTlje0FhcSAqbSbUtzPDHD6+F/gHyUKkugP1Ts4Ymff4Lxxqw+O1XrukWhglM8tOlipntU5bOFPsqAZ5mA4RvJjZb5Ctv31XJqhSnxhop8tXNchWnAMAHsQkvNYvsyvvXJeKkciZLzSBbxvVbzSIlHzBrBOTx38Ap+Y9MKHwdAr3d43kzV1DlSac84V+TUcpG26189BAsneDzBPodcuaNYdQhpegJXOOIN0bsLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yukf3Jia/oP6mxMq+luRb+h0b6ttJJJo/2uW5Q+BcXI=;
 b=FK4kPveEgpO4GAqUQqlvUM213yF4FqEBOdPAZTrfaMExL5wdLeuAUr9rzUcR4VIYpRG4A4iSLjLxk9ng+sN4p17cqnGatmHPD9nOpcLXrGDlS0VAxQW23xtdJUyei0DrnwejJz+2Wu/TQCNiQSZ1Nf5kuL/IE9zhhU2WF3Xyx//hV/Olm8kIqbcF7K0wb7UXXPO8mSOGA03KSzlRf3XYsD/aBZXjILTKd+t9qQ7uI1mvUCj+sryTc9pts+DWe4GlbsAl6yyB7bCmfSP4ODWBSJTA1xHF0OLj74TsT4UTf5du43TrnTNYjg7LO7EDNiIQ0yMVPsJmenxcM7LjoV2W5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yukf3Jia/oP6mxMq+luRb+h0b6ttJJJo/2uW5Q+BcXI=;
 b=pBmIA75WLEBC15NoLvhIOQ5bMcc6Vud77IwO/J+iu76ngReEyQup0OH4e9Av/n+r8y0UlqrEQW+Wv3+fUVYXmdkENf5adMBp3+grTbBXQ5PT2yb2X7+oEIVcRgyYF7y+N/kIwoz4xNzq57bxQ9f1+bY1r6i0qtyNS5NGfn+LI9s=
Received: from MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16)
 by SJ0PR18MB3882.namprd18.prod.outlook.com (2603:10b6:a03:2c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 05:03:38 +0000
Received: from MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::fcd8:46e5:65cd:339]) by MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::fcd8:46e5:65cd:339%5]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 05:03:38 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v2 1/1] misc: mrvl-cn10k-dpi: add Octeon CN10K
 dpi driver
Thread-Topic: [EXT] Re: [PATCH v2 1/1] misc: mrvl-cn10k-dpi: add Octeon CN10K
 dpi driver
Thread-Index: AQHaYMOArP5lpoMc+EmpN3Y/GmE2K7EOMPIAgALrHhA=
Date: Mon, 19 Feb 2024 05:03:38 +0000
Message-ID: 
 <MW4PR18MB52448A9E37DCDB04F84C2013A6512@MW4PR18MB5244.namprd18.prod.outlook.com>
References: 
 <MW4PR18MB5244844411A57790287068E5A64E2@MW4PR18MB5244.namprd18.prod.outlook.com>
 <20240216103225.1255684-1-vattunuru@marvell.com>
 <2024021713-corrode-landline-e186@gregkh>
In-Reply-To: <2024021713-corrode-landline-e186@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5244:EE_|SJ0PR18MB3882:EE_
x-ms-office365-filtering-correlation-id: a1e4315e-b22c-492d-ea7c-08dc31082250
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 oqw3y873VceuI8DIkb8sFggpt/cWsb0TGVM9cLv2gJlG2Zh1FsAJD9Vb4fvo0LuXp3MH9ykT65HAs5SfOUoxmNWP/vqSu3NnmBARtYmbB7DoN9luE/eitpRyu1zlV9cM2RH6mASgX1els4LiTiFGBZKw+VE++F5HwuYaw+pmeE5KCMf6Gf+G8cPR1X6sikG+1yuI4cGsNfPySQAXVB5JiZk8pGNHSO4McMw0xIjgyhLfsUXTUCulMUPUFGFiHKCRsEDAoqKK+e8YdwnnBq1ExExJ1o3x2DwgX2AUw6dC2zADHlsciR9RGV0HJWLLYB3mUUlldiIEPpp2ZwynZNK+sN/WODEIae+KCcAEHdmwuKDib1gmGzUwg7cEP/+JEhtzfy9L0zD+6hL7iDZjppHgeP52RlFbqx/Ey1d6C2+ofyvlGtEET1dAsFfkDCBBnWnTdmKXtCnZSLAYqfnOOPMRaaCfN5h00w9USeHE2cAyqAkjTm0ifaCnp2mBA0i2mNDir0S7TnkWxb14+eVc6qXFF38KnOdUJIpayTr+f2qh/OBvFRwlIycWZQZhomn+mogmRxMO2ZE//rC/5iYmnefU64kvCzTd5hN0lszkNBwVy+3VaWeX1cge7SYbhOeqLXvX
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5244.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(39860400002)(136003)(230922051799003)(230273577357003)(64100799003)(1800799012)(186009)(451199024)(41300700001)(71200400001)(55016003)(4326008)(2906002)(52536014)(8676002)(8936002)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007)(6916009)(38100700002)(5660300002)(86362001)(53546011)(122000001)(54906003)(6506007)(316002)(7696005)(38070700009)(33656002)(478600001)(9686003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?5rDBdkLWFHDsat0jgoc8FPbDFocDKV5+nMyCxlNGGRPNFtS4NCa50drP9XER?=
 =?us-ascii?Q?RKjupQ1rJoT/TvsSfKMbT10oRZ+I2zIV7kd8ydl4grNP1GZ0B/5+5MV2cl8b?=
 =?us-ascii?Q?Kd/glMvfHKbNDXe/InSm8us2VWOw47TmNmCnWZg0nrE9kkCPFQXmZkEZwpRl?=
 =?us-ascii?Q?ksbfqLrODO4enxi+0NA4vn7eYxxt4skCLEvQEXAlZMUtEE+u1YFG25jwpJ76?=
 =?us-ascii?Q?05/w0DMa6Dh5ntDBRCXvefupijt+x9vV5L0JLA0ykLJbV42HpdTKIKVwQx0D?=
 =?us-ascii?Q?ZwaexZPigTeKGl+5fJ71pXsrTvLn1dDt8r08YANLnlXfwb0LPK6sU07BxdXq?=
 =?us-ascii?Q?DqHR3ZySggPeiBk37us85THGll6DtfMtznQfsEdbcOzKDnWgdmuUIm1hz6gl?=
 =?us-ascii?Q?G8oX3pxQRo+9lcUy6TpSIoWHX05Te5urW0OIkg+akTQ2Rw31imlUqIOZjHIL?=
 =?us-ascii?Q?bPJubRibjqHd66pN/sURcbqMw/1KN8JNYCrDLJF/nfFiYt4lHek0tFam4Ynt?=
 =?us-ascii?Q?PZMdmiIZ9IcPMxuyDkL2TnzNDfbvb03Xg3y7YYPGKGQC3bZSz+6IYcoiNorv?=
 =?us-ascii?Q?wzGe63KNbXjE923Kb5Zf5aZSjHEuHaW/Bc0K3GG+FTfjmG3M90hScVJD4Yg3?=
 =?us-ascii?Q?RZApC7FW+RaqzAWdBMGtqa3gqSzqdcJWkVtwXP4mW80i+f8i8qd/X1VCoQsA?=
 =?us-ascii?Q?da5SWizehnTI2iuum+kK22hXMOVVUFWB2v29/XqlqCr47UT45SOnAncU2vZD?=
 =?us-ascii?Q?qv4eUGGzih8EH89kYTnbMIj1kGe+fAzGIlL/GHq3wwTlIM7tEaXMk5wmll/4?=
 =?us-ascii?Q?hLVA7wMoirQGJwxE0S0C1RcLKElLZbi+gln6sBE2Z1KDcmevWlZWJf/o2TSo?=
 =?us-ascii?Q?nYHu5akS414K4ns9rGWp6b8/+pzWSDn0bncI3hI+BaXTMezy6fDtVpzZi4qy?=
 =?us-ascii?Q?+NnsHG12R4iaK49K0FZWqw97s5Un16xIWHgSRV1BWZAEXJmGTAWnTBJQiSyw?=
 =?us-ascii?Q?3wzXrAanOzwtrIPFVIG/ReumapJnyTlh6ygMfK8fJPQ77vE0CqFxE2QFGxVG?=
 =?us-ascii?Q?u+W6QHFQb56BJdyek7Uy2seNp3LmPdMNZSsFxgR38UgFWS36zZy4tN1fvOJn?=
 =?us-ascii?Q?SeIgLJTC/DzwpEUu0vM5pOUQ9CXxZeM/0oVHY2Ws/nY21Hdo6at2ofkYiAGH?=
 =?us-ascii?Q?m9kyg4I21aWWdHuI9cx1uAgIea2Qx98n2so04U9oo2Hb03DG0qPfUcBBLlYg?=
 =?us-ascii?Q?TLknTBd5kYuu6HruP73l5vD2QzLvW5ciWKAtaASiymdQtLP8c8g3yYFQlgLe?=
 =?us-ascii?Q?S0tvZcLZiuiKwxajwsdxDqvhJ1GrV8HBDb05xizV2G0HuzeX5ADQYifg4Ve2?=
 =?us-ascii?Q?TAmz8KJVDChM7maVBU/qgGe5eJmulWMjU2NMD7FIwBZYR7sLJwDh5/mi/YD8?=
 =?us-ascii?Q?0JohAEuSOiJbY4NL005p+fh4pZc3BqD28IO4MVHaitrL3Waf3YnTMN26q5n8?=
 =?us-ascii?Q?jTkuawWluE2nkuYqJfUoz0wNksKGWd4ig7/tD3Zr74NDHAXxWsijwYJ8VaIk?=
 =?us-ascii?Q?kDHU6pCY2Izew/LgfIrdk4hT4XYY0Pum1LrUGdGQ0gfSCHdaSTOVs+xH76QU?=
 =?us-ascii?Q?Q+6AVMPMhzRT8z771kCYxghNOeVDE6b8Mcd6gknyrB6l?=
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
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5244.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e4315e-b22c-492d-ea7c-08dc31082250
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 05:03:38.4653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T43NTXnRzz5Omt+udHk5Eez63B2nvrnpxcuUfkAQU/XpMp8yTORfqqTlLaQyRLrIElf9yNIhSxz5QR22hCMHmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3882
X-Proofpoint-GUID: dvSldjwwFlVV6s2giMIACeBS26G7bTF1
X-Proofpoint-ORIG-GUID: dvSldjwwFlVV6s2giMIACeBS26G7bTF1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_02,2024-02-16_01,2023-05-22_02



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Saturday, February 17, 2024 1:44 PM
> To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> Cc: arnd@arndb.de; linux-kernel@vger.kernel.org
> Subject: [EXT] Re: [PATCH v2 1/1] misc: mrvl-cn10k-dpi: add Octeon CN10K
> dpi driver
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Fri, Feb 16, 2024 at 02:32:25AM -0800, Vamsi Attunuru wrote:
> > Adds a driver for Marvell CN10K DPI(DMA Engine) device's physical
> > function which initializes DPI DMA hardware's global configuration and
> > enables hardware mailbox channels between physical function (PF) and
> > it's virtual functions (VF). VF device drivers (User space drivers)
> > use this hw mailbox to communicate any required device configuration
> > on it's respective VF device. Accordingly, this DPI PF driver provision=
 the VF
> device resources.
> >
> > At the hardware level, the DPI physical function (PF) acts as a
> > management interface to setup the VF device resources, VF devices are
> > only provisioned to handle or control the actual DMA Engine's data tran=
sfer
> capabilities.
> >
> > Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> > ---
> >
> > Changes V1 -> V2:
> > - Fixed return values and busy-wait loops
> > - Merged .h file into .c file
> > - Fixed directory structure
> > - Removed module params
> > - Registered the device as misc device
>=20
> Why register as a misc device if you don't actually use it at all?  That =
feels
> pointless and extra code and confusion for everyone as you have created a
> device node in the system that will just fail all operations made on it.
>=20
> confused,
>=20

Module params are removed in V2, planning to use device node to pass the de=
vice configuration tuning parameters and other ops, can you please also sha=
re other v2 review comments, I will plan to address it in V3.

> greg k-h

