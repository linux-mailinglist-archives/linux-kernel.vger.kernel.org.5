Return-Path: <linux-kernel+bounces-69114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6076F8584C9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1278B2847FA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5A61350C9;
	Fri, 16 Feb 2024 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=trendmicro.com header.i=@trendmicro.com header.b="RRrW3b+O"
Received: from edc2-mailout4.edc.trendmicro.com (edc2vmout04.edc.trendmicro.com [216.104.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95544133997;
	Fri, 16 Feb 2024 18:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.104.20.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106645; cv=fail; b=CF+VkYRXbtuXE7g4nhlPX/vvpwOE8aBkKPUXHI49ItnQo62tSwQ8P4qQ+PiAZtfoEsIh4Q0zIQNG93RmrGCGGxeH95UsgY/HIj7cTNMHsJPsFu1lUXKZplJGVDbhcSVKjnI87vIh4/NDd/whLeC5qGWmRSuZnm69wZHB+eR/bHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106645; c=relaxed/simple;
	bh=g/5G/CY7sEIP5u/uF1xtIfiYpmv86AIN2KPnI2WwFkE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LFvNj20cYlHpkDnh6QpmW0esgEjLEk3beUo7HXyGmxXPMRy0mKkR1FUgaNmBkOkP5ANvoSXmIwsOUQOb8Rodmiy9hI9pNZZ39FKikpkGsds0OEQVUXjBkCJjX97kyu7CX5LdiLbP1IPB1mp4bzYzhOtuEERnW+38cH8945OX56Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trendmicro.com; spf=pass smtp.mailfrom=trendmicro.com; dkim=pass (1024-bit key) header.d=trendmicro.com header.i=@trendmicro.com header.b=RRrW3b+O; arc=fail smtp.client-ip=216.104.20.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trendmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trendmicro.com
Received: from edc2-mailout4.edc.trendmicro.com (unknown [127.0.0.1])
	by DDEI (Postfix) with ESMTP id 69ADC427C74;
	Fri, 16 Feb 2024 17:58:25 +0000 (UTC)
Received: from edc2-mailout4.edc.trendmicro.com (unknown [127.0.0.1])
	by DDEI (Postfix) with ESMTP id 56348426C2F;
	Fri, 16 Feb 2024 17:58:25 +0000 (UTC)
X-TM-AS-ERS: 10.34.72.183-127.5.254.253
X-TM-AS-SMTP: 1.0 RURDMi1FWENIMDIuZXUudHJlbmRuZXQub3Jn emRpLWRpc2Nsb3N1cmVzQ
	HRyZW5kbWljcm8uY29t
X-DDEI-TLS-USAGE: Used
Received: from EDC2-EXCH02.eu.trendnet.org (unknown [10.34.72.183])
	by edc2-mailout4.edc.trendmicro.com (Postfix) with ESMTPS;
	Fri, 16 Feb 2024 17:58:25 +0000 (UTC)
Received: from EDC2-EXCH02.eu.trendnet.org (10.34.72.183) by
 EDC2-EXCH02.eu.trendnet.org (10.34.72.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 09:58:23 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by exhybridemea.trendmicro.com (10.34.72.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 09:58:23 -0800
Received: from DM5PR0102MB3477.prod.exchangelabs.com (2603:10b6:4:a1::19) by
 CH0PR01MB7019.prod.exchangelabs.com (2603:10b6:610:108::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.40; Fri, 16 Feb 2024 17:58:20 +0000
Received: from DM5PR0102MB3477.prod.exchangelabs.com
 ([fe80::62f9:a52f:7777:ce4e]) by DM5PR0102MB3477.prod.exchangelabs.com
 ([fe80::62f9:a52f:7777:ce4e%4]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 17:58:20 +0000
From: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"valentina.manea.m@gmail.com" <valentina.manea.m@gmail.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "i@zenithal.me" <i@zenithal.me>
Subject: RE: ZDI-CAN-22273: New Vulnerability Report
Thread-Topic: ZDI-CAN-22273: New Vulnerability Report
Thread-Index: AdoDaZfX1Pq+Y8aLRweLJ8giuYn76QAnSoKAFz2O8lAAAHKGgAAALldg
Content-Class:
Date: Fri, 16 Feb 2024 17:58:20 +0000
Message-ID: <DM5PR0102MB3477B499A8A3292D6BFFBE80804C2@DM5PR0102MB3477.prod.exchangelabs.com>
References: <DM5PR0102MB347711AF2F5655852AC60BEB80DBA@DM5PR0102MB3477.prod.exchangelabs.com>
 <2023102134-reflux-saddling-c750@gregkh>
 <DM5PR0102MB3477B594C9D018BC884DF3E4804C2@DM5PR0102MB3477.prod.exchangelabs.com>
 <2024021605-disloyal-overlying-ed56@gregkh>
In-Reply-To: <2024021605-disloyal-overlying-ed56@gregkh>
Accept-Language: en-US, es-ES
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ActionId=c44f7461-1107-46df-a12f-d72c1d6224a5;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ContentBits=0;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Enabled=true;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Method=Privileged;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Name=Public
 Information - no
 protection;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SetDate=2024-02-16T17:44:28Z;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SiteId=3e04753a-ae5b-42d4-a86d-d6f05460f9e4;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR0102MB3477:EE_|CH0PR01MB7019:EE_
x-ms-office365-filtering-correlation-id: 67e0f5e3-4c9d-439a-673d-08dc2f18dcb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Kj9pB47e2pYPqgVEOVpdgsMECz7uafgfgkXR38B2FA+LKIbaCKMtrrzx2snGZQaIFYuhuVGJXS6k77ottF7FHX2/m/bLi35emdCTBIVAbPK9RSsvdKKkEn23CK03Xk0exw1PqkH3mJOLSkYko4K8Ps8VEr9t9inOFafwTFKLj5ctyovgUnNrhYhTACjGQ98qsCGweLkWCtfD8czkGbScE8GNz+FBLJQ32aTRE6TvirmNeDEAIsoOut+pkeErLEfC630bdr8qJenoi7//qQog1YzAD73yO4y32MIqo2pMKv4zqA1eygzCzb/uoQtxYE/qFpOppWdoxIaf/ui4P/kmIGvSNmvJBNLE9eUxTBTQ/iZ+ZvrCA5xYTrqB4xvjCcheTSVGnCzJTaOEVAMEnUSieac1zsi1c+q3SxnSdlcaGhMza5r65ol4HvvoFbe/6kddAd7kWbx5cyFICMiveoloYgAQbyeVGPNoknJfALVMXqpD65dn292It/knQ8Bec1U1wh+NtmsC5YWzXHEKrw5ty8cQL95Dz6zWw3vpa3VBgBswgdUix69mrJ6YPw3Oo5pYp65frF9mWHRgN3xhW0RN6pEGf3Vk/vN2+vexJje6t5JJ5x8bJGWpFn8HtPBGP/r
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3477.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(4744005)(2906002)(55016003)(8936002)(26005)(66946007)(41300700001)(8676002)(4326008)(52536014)(6506007)(64756008)(66476007)(66556008)(66446008)(83380400001)(76116006)(6916009)(53546011)(7696005)(38070700009)(71200400001)(9686003)(33656002)(316002)(54906003)(478600001)(122000001)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zhuvhrzwXhyzoOIGtJPA8GcZAK3g+lxTwpINUB0HUiLws9YgAmhj3j+aXlH2?=
 =?us-ascii?Q?uRweh2ye5lpLSGKK2SE1Uh7lPSKSNac1bjVuNFfpKgazeu1gAIgnBJWshcQI?=
 =?us-ascii?Q?y67SCJ2d0NuoYOL/TksYNg3iMC7QsxZknNiIhqQA0bLY5xvFSwMHK3L0v9Wo?=
 =?us-ascii?Q?Ef7GDW/LASsHqEhD5IIhdEw9REOJrIiO+b+5bUmKL8s3/Ed4y0SDKxX7pF8X?=
 =?us-ascii?Q?KRhV9GX7hIPUHm2+WwyYZk9BUFtR7Zc70OEB/YgnH8HEQ0EMDb2zivhcYEkI?=
 =?us-ascii?Q?qomkWWdHkwm/QGgg5r8PiH2fS6OC1MUTIP3p1WZmQW2ijmql3tWrgEKIetT6?=
 =?us-ascii?Q?mwnBjUver+z6t12rxhyD9PQXt9X3CvA0rDh1s2jQhKsTcVYcClwgqaFnkECj?=
 =?us-ascii?Q?a2ibokeBUbLE9nmMpFtAmUDRbTJJXDOznVxmxkMDwMeM/XQS/De5pHbk//Kk?=
 =?us-ascii?Q?he9PEM7mYL77JXV4QnC02xiF7OeHDrfrBa2EPxDE1nKQfmetY7VsJ1rrfd5I?=
 =?us-ascii?Q?u78rgGcKAnxk8zl3r2LqJf2W7jrvgW6AKaRvovlCqIAV60oSyuHG3k0JiGwD?=
 =?us-ascii?Q?nsqGgfvOpLI2I1GRNyXZLt8QCkJYzWxSmU8bMghBTu+aGRJk80JMxRYjnaCZ?=
 =?us-ascii?Q?xXMqMAXAQnN3qBcHxTNHHgvk0N/aTKYjMsZowc/+S79hNovAlecz5MUt5Gkk?=
 =?us-ascii?Q?NeXhy6EAW7VOn7vLUFlS6RuhstShTl1nXs3qOG5C/XqXNc55B7v+jehyUM1T?=
 =?us-ascii?Q?T+fbw49sKQQ9sbyZTV/IGRkATODAt6YCpP2sJ6+3X6SR7S2EGHs+yj3AE2Jb?=
 =?us-ascii?Q?ckQ/TJH0DrbMBr55BKlUCB1K9dC17utP+MozQ4SdF503F0sXFAlKCfdNPv64?=
 =?us-ascii?Q?wff3rlIKYZnSRDwdEprY5WvCUq2nOfBfTsmtIxBCDaEOTYNeRhQC93TKRhlI?=
 =?us-ascii?Q?11K5PpEpr176NSuqdRw6dbmnoRs1hylhzcpf7wuG9eASoFBL9woX8i48vWYG?=
 =?us-ascii?Q?opV9fCvCT/c4i/kzGKDBzVlkAE/kjZ3JPcJ1fzpdT4aXSeOyEwRXC7NcIf6/?=
 =?us-ascii?Q?TqQsLuDt9pjiuRYyoNm6fsvT8o/r6GM/rNGKMQ35e9rjqlejs+FsIppT6Fk9?=
 =?us-ascii?Q?gQJzsdYcU+DomfGnEUoQ/VUzwhiN3j9oziTN1Z9nikY1OWDJa93bDN5w4CU8?=
 =?us-ascii?Q?hvf+cLg30xAPIH5saqzSo5GOIT5sgmCBfwyWZrUAdcf2HTx/S1tywbz5N+YB?=
 =?us-ascii?Q?JzfH+GFLkNw3EwLwNlglx4OQDvyNruRQ+OHC6kteyZ7AVHHWO+XfVR/q0WSF?=
 =?us-ascii?Q?sEyilPtYkysvf4/PCFAmQ8cqjltV+ftvAoBdPk3MTy+MaX41i/C+6ftrN38K?=
 =?us-ascii?Q?F9LCZRqbm3BW606GTCQ7IEi+lxzDQbbonP4uAGa/0169GSZCN+5IW2JDY7O1?=
 =?us-ascii?Q?Yoi8i+qawJ/d2YIzULvpC6eNxcmJTQ51x6HfdVQgK+RvvHWh9PbqIYNkrDV9?=
 =?us-ascii?Q?MDRcs1Luk8bW8GDXXtc8iJJcQdXPhndsSnCP5DJK4d5jrBlHcLDNaP6c6ICj?=
 =?us-ascii?Q?WWY6Gt/79IMFzhgLwFXpNfh/AXTvxLNHVYsMfKCQ/XWGmC2ZUqcmpqjWzdas?=
 =?us-ascii?Q?CQ=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpXcA5wmh0s5Ieg//nQuOIoAFY/6qwPikyllE6TLhpoTFErZlex7w9CbvQay9niWrdEtSc/DdeYPOu5/baijEQaSoyKt2KGbNb7QvHfEYEhIpDipHZ2LixOXBVeVr8O3dd+aK7TwWLRTOjGO+Qja651i4kPQQL5eGbbKyU3UlDsIMO3ifGWb8LlH6bFArbXdUrrNkzva5tR81w+LZE5LFwv+Ku5cSk8sCUstOjSriFRnDXCKczBOJVDkg/RVZBGWriySYbpG3LNlwrK31LqubKkQlgT1ztzNblu2RsOrZx4StR53ew+WRBAShEyC92MQOpYR2PRXpRApOXSG+zUcsA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAwcjUJIfWKPGPbSELy1iPEHIqUPhPSFETpWEyqwW8g=;
 b=FXI3Of3OaghjfOykAm6RG7ngBCb1ZeDdgOxZGOXXfioq/ZyCQdchS58bG5Amxshbc3vCM9jkBv0+S2XdwyXrvY4DRQ3M+XUP4/BB9Xol60/TkbA2nbs4fEYsaRjGNaPLg0RjdZSwEjKUhHx8+KyDFg/NNCgefkj0kuBvxR98xR1SesjpKj00xUhhO+b/kVeUNxDlSlL1wRbjYrJRCAngyRhTUBMCZTvNhMKp85HxptYM87omsPti3UK4h+cAJPvCyfATPvsY8K2i73skkcjyk4608p1Nd+upaWL5ZC3Yd0XBE9uFfdizn2Z3avXcjHe6LfPpajcwq+y8Vhp5F6fUoQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=trendmicro.com; dmarc=pass action=none
 header.from=trendmicro.com; dkim=pass header.d=trendmicro.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: DM5PR0102MB3477.prod.exchangelabs.com
x-ms-exchange-crosstenant-network-message-id: 67e0f5e3-4c9d-439a-673d-08dc2f18dcb3
x-ms-exchange-crosstenant-originalarrivaltime: 16 Feb 2024 17:58:20.7761 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 3e04753a-ae5b-42d4-a86d-d6f05460f9e4
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: pkpMGre4pQxb5B1gze40hdqNItFBBX6OtnjA/cNpzOK0unbi3Wb6SSnZebdQLn4cZxxZcUlPhg8c5NrAy89RaRlZwVWWPVyJ5Ac28Cqgtx0=
x-ms-exchange-transport-crosstenantheadersstamped: CH0PR01MB7019
x-originatororg: trendmicro.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-ERS: 10.34.72.183-127.5.254.253
X-TM-AS-SMTP: 1.0 RURDMi1FWENIMDIuZXUudHJlbmRuZXQub3Jn emRpLWRpc2Nsb3N1cmVzQ
	HRyZW5kbWljcm8uY29t
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=trendmicro.com;
	s=tmoutbound; t=1708106305;
	bh=g/5G/CY7sEIP5u/uF1xtIfiYpmv86AIN2KPnI2WwFkE=; l=1647;
	h=From:To:Date;
	b=RRrW3b+OdFXbCcWFbIMHoX0k4riGVEkkJFJ4ksC1SGHXPQm2YiiueA8o7yJrBeqjP
	 /Y1nkNnci5Bz9775qOS8SOWZFQTqdJtcYm25gIMoJcEA4dC2GvaP/8/TeOeru4Jw4W
	 RkuslsqYbytKIVg370ZQeLiZXrcv1bYwPPlLCWXs=

Hi Greg,
Thanks for the update :)

Cheers,
Rebecca

-----Original Message-----
From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
Sent: Friday, February 16, 2024 12:37 PM
To: ZDI Disclosures Mailbox <zdi-disclosures@trendmicro.com>
Cc: linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org; valentina.mane=
a.m@gmail.com; shuah@kernel.org; i@zenithal.me
Subject: Re: ZDI-CAN-22273: New Vulnerability Report

On Fri, Feb 16, 2024 at 05:27:57PM +0000, zdi-disclosures@trendmicro.com wr=
ote:
> Hello,
> Do you have any updates to share regarding this vulnerability? The 120-da=
y deadline for this case was January 31, 2024. We will publish this soon in=
 accordance with the ZDI 120-day Disclosure policy if there is not an avail=
able fix.

I asked some questions to this, a few hours after you sent this to us,
yet we recieved no response and as such it did not go anywhere.

So this is all on you now.

Also note, you are talking on a public mailing list, there is not much
left to "disclose" :)

thanks,

greg k-h
TREND MICRO EMAIL NOTICE

The information contained in this email and any attachments is confidential=
 and may be subject to copyright or other intellectual property protection.=
 If you are not the intended recipient, you are not authorized to use or di=
sclose this information, and we request that you notify us by reply mail or=
 telephone and delete the original message from your mail system.

For details about what personal information we collect and why, please see =
our Privacy Notice on our website at: Read privacy policy<http://www.trendm=
icro.com/privacy>

