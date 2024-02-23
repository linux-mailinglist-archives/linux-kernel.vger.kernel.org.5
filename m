Return-Path: <linux-kernel+bounces-79285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEEF86200B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2991C221DD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D7424B2B;
	Fri, 23 Feb 2024 22:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BMmxNvcB";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VaC4RDJr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GJ4xtngb"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FD822071;
	Fri, 23 Feb 2024 22:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708728595; cv=fail; b=Hg9RVL6/o3y1iXO6jqA6YaOnfD9H/SSLMfjVCm37PekHAzIeuTljdEeEa8AfrFzyYFq+ENN+6q0YYKR1G+OS/YGPxubLOFNQeCGwruxEwshObpom4YjkwJiUzctPeLeYoLVsLOu6+/9dDUVg2jlltkTVpTmn1pTAKTQq5ggHopU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708728595; c=relaxed/simple;
	bh=dfLRGkcPkVUkq6MyYST0MvuRf02WMCgMbo0MB//cLRs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mH51D1D9Uk3BaXnkHPyGOhULQtBLiBg0KS4axf3gZ9B6YYWy8wXoGMM2LfdTqC49EbxasAtcMJWRtoDv6hSkJvYlrDhTESUktc+n+vRgsiEsmwhe2PxX0vohSMt2m4OA3prj72gE3uQjCpntKKXYG785BecDUnRHaxzBG1eRPek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=BMmxNvcB; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=VaC4RDJr; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=GJ4xtngb reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NGjXlC019063;
	Fri, 23 Feb 2024 14:49:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=dfLRGkcPkVUkq6MyYST0MvuRf02WMCgMbo0MB//cLRs=; b=
	BMmxNvcBQQkWMrvi7YXOYpqkV3+nj9sic3pT3CqumInVk6WrhfI3qKRYe3TtDagk
	Xs44/0m+T6OuZXBK16/p8PgKQAgUAzBe1vPu59zC28jfQSb+Iu32tGjQiFKbQb5F
	3ID7MLh6b2XhEEEMeq+PMDIS4w/GPMN5+MzTkdsHtYLtc6olw3Rmj9GK1PyTcpvh
	qigAv8OgL36z2UFebXKluxtMYhbSj0eG9/Es5/EQgJ8XvP/UgCyS5cpPaD2PbFvA
	1rHJvFiXJgsEZjZQhb4MyqT8+eica7XoY5y9T5tA4tMI9lbcPc4Tnoc6k8BZ/rom
	tcRqV62dDhMXLLOiiQmXSA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3wd20wh036-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1708728587; bh=dfLRGkcPkVUkq6MyYST0MvuRf02WMCgMbo0MB//cLRs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=VaC4RDJrUY5VroPQskPVWAsMlT59ziwIFpHshRWFhSzOS20O+CEQeO+6/TjPjE0dY
	 dXlsQEwmMdrli0u93DZJC1Xpp21jp9mU72LlYq8SxdtKdpG0u0FExDZticWoQeZk0T
	 ApNSnD+2NTJtI28zESznqgQ1olXv0a/8kS3awZnxMKjODXP1JwmyyJ/20/xqOy8NWr
	 riVoPe9ZO4A6VIR7GSWlVssMwvGSIYFcsrkJMm3Hj60WS2kdN4+2U2vQbh/CkHatEy
	 ooqTAH6OUm/pq98c06Lvggx018vNzwmmUSYtUlQKDqxpjw+QwdBwEM93XQp1U+8wR9
	 3QLtqD29pyekA==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1FF9440235;
	Fri, 23 Feb 2024 22:49:47 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 6B92FA0077;
	Fri, 23 Feb 2024 22:49:46 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=GJ4xtngb;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3974040582;
	Fri, 23 Feb 2024 22:49:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9pYV10l1AL+HtjBUcoIQcP2pVKf81ItnsCnweSMpnW6lreHImntX051aNbMSUvX26legGCQ4PbnzV8awjokvKmlvWik7l8DnADcYKx1ij6yCMpSJaPKmpqI/I6dR0+P3qQK1XDVXl+FoBtPBiKRyCc+pNJhMXRFjt53bU6bOb5WzC6to0GbFiY+ftSvXtbsFURc7+6IZyrA9GNgiT7Jb3TLrSTLvsFoKQ+rnzGPyEF/djXqOH2DGcPtxzYJ+hnPGByqqWk89GspeYqyfWOrpUbOTk2Vo3UDn+PXmxK5JvuHE7AgbDNSSM7cGa79OY/z1G3aYglTNOsXC9PkYTzTbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfLRGkcPkVUkq6MyYST0MvuRf02WMCgMbo0MB//cLRs=;
 b=aDnynSK1+CX0aZbm8eUDFHRvlm5z/amGYNmOXSH6tLV7aFVRlSFRzrDNofiQ4lARJT2fJjC3eqAq0M2NzwnF00EFuh+/jE/KqN51mogmbxk/kOpX5WQ+qTr9i7vdp4a+4fgpfR7DIMEqahTY8WBmtO8AbTgjsNNoq7QAgY4+l22h8Q57Ay0Hy8yq9AAV1tfGNZ87wOIVxtSqkqWvUY0wpfGBVNuQAJveWCEHoLjpafoVYfQ7sQ2ObKWolZQelyvLC3PliFUei6aniFOepIK18OMweAdDjoiUjbySXrA7I1orAMWXGZeKNQV+BeFPKlqKlnU2TnRQBbxsjOMKW8S9/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfLRGkcPkVUkq6MyYST0MvuRf02WMCgMbo0MB//cLRs=;
 b=GJ4xtngbUgZAK5LXS4p6gpIHk6mxX15OJsLgRHLSZdBjrCzwnB7R2TVBvrw70wn2cruK3UaX2IdVF+/IY3EoXn9Ztaajbx+DPxIPhYS3BfXkOEHe8NJay4Mmgy8kjJZgFkYpABNWemgRRgr7z05r/Mgt9mMr026G5ySApib/xTk=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.23; Fri, 23 Feb
 2024 22:49:41 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 22:49:41 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git@amd.com" <git@amd.com>
Subject: Re: [PATCH v2] usb: dwc3: core: enable CCI support for AMD-xilinx
 DWC3 controller
Thread-Topic: [PATCH v2] usb: dwc3: core: enable CCI support for AMD-xilinx
 DWC3 controller
Thread-Index: AQHaZpDfVUYctKsozU2uHIlcC3QiPbEYiAkA
Date: Fri, 23 Feb 2024 22:49:41 +0000
Message-ID: <20240223224940.y34qflo2azxrvksy@synopsys.com>
References: <1708717523-4006664-1-git-send-email-radhey.shyam.pandey@amd.com>
In-Reply-To: <1708717523-4006664-1-git-send-email-radhey.shyam.pandey@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM6PR12MB4284:EE_
x-ms-office365-filtering-correlation-id: 38664e66-03d9-4b49-33c0-08dc34c1b8bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 kqhHArrOEJynggj6j2QTHTmJhkLFFdresh8xEdkZdwj1CJDURX/FW7rh0xKg1XSY44qTSRxq3xf7zM0Rd2T4pxl0hKcv35+BwoZoZ9Ll86RC9gSe/dhLT0OYJA+NfzLx684g9YJAx37NVL5/kYYgmctQpKdJDpf8u/AAju1hL37dfifjbIyJrXdeqE6NaEF2/kKI4OdMUlcpsqiUscZ27+8Fx8IYi/MukrW26F/EK4bHZFBOKOeB+8pgjQyqrdpFAn5PARc6EF4mazLa35BPWBFQoI7fqyyROsxXltLX/2oni6IQa6nNW2LsutaejVJDLHM8bqTz2p3hMr/O5asrtJjd9S/zPEbo84TZQ/ihrri7ChDjesPzIE/YuEeGk1GXhRtaLH9KyFptnVB2vWpdFa5lmQ4YOpmd47HDYNbZtvMhU3GvQ2+kUC03k6o5uwHyo9hyRrauBOrcEiAPsA0houdVqEZ1rs+DQC18vdZ3QIAvRejeEEZP6qIxqOdJv7SxDFweT8uUnX+QqVzVODEMltWofQMLxRnW74chiAZcWvGGn3H9YkJBOQ/Wwj48Uz8KeugKMACba2kQObNJa9OR1Ml64j8ayhYaiH+sJ0ADqd4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aGpkQkQzYm0vbzNnL29tcUdZeDRHeGxxTWZ3ZGFQSmVwenMwdWFUOFBNRUV2?=
 =?utf-8?B?S1B4czQrOHdab2YxWGJFTGtDYU4zL1ljeWlQZ1YwTjE0dEZldUMvUnF5WTFD?=
 =?utf-8?B?MC9xZExWb1paVUNPRFBSTDdOMURFSnNiTFQwNnE5czAzOENxdXIwcllJZFBq?=
 =?utf-8?B?ODl2NzJJNkxxcytsbUhQcUx5TXlKTEZYM0M0ZDRZdFplYXBxeFhoZVN2Vm5m?=
 =?utf-8?B?ZmRTeVFLT1pvTDY1MUhpS1BlR3ZUM1pHeHpBN0JUZmZPY25lMTB4a2lNeTlr?=
 =?utf-8?B?TnZSSDIvdHNHRndTaWlMZ3QxMklsL0tNTDdtTmtzTUhERDdVbGI2aXBYVHJw?=
 =?utf-8?B?dlMyYzRRdEF6RjZ5SnVsNGZpdERSU1hTdUtCSFR0eXM3UWNCUmFaU2Ywb1pF?=
 =?utf-8?B?VUhBRkMvYmtIcTFBTDdXWlo5TzFtcndrSzg4bkN1ZnZiaklIaTFCWDc1aEFs?=
 =?utf-8?B?TWgrTUZPcnk5ZmZ0S1V3TWdFSlI4RDQ1RlhwdU9Nbm5PQzl6Sjh1TXJ2REhu?=
 =?utf-8?B?N25SMEpmMzdLYVhaeEZLNGxNUVFCQjNadWZVODNWMGVlcHZnSCtOZHJuZ3lF?=
 =?utf-8?B?WW91Q3ZxSFB1NFV0MkxTZm9tVzluMHN2Q2U2NHlnR09SUzhCa0ZQQldMay8v?=
 =?utf-8?B?VzlaWDg1dVlVcEVDakJlVlRFZFRHQWpTMGw0SE9mbmhlcmZXNzA2blhocXcv?=
 =?utf-8?B?OW5Nb3J3eUZRMHM2cnZUZFR5cnJMT1BRQkNxbTZSWnczU3NNSGJUMGhITW5h?=
 =?utf-8?B?alZmc3YwT1FadGczTUM2ZlFXOEFaY2lFdSt3bHhMTDJKT3k3L3NaYzkwODRG?=
 =?utf-8?B?RTRCekU3dTdaMHBWVU9OUkpjUngrNk00UEJtQXZwbWgwVmkxNFVOQ2dESlM5?=
 =?utf-8?B?aUkvM293ZXBiVG5Zc1pCQ2locjhVOUU4UHBSNURDeTlLVEw1SW5GNG82VVhD?=
 =?utf-8?B?REd6VzM0K3lneUc1R2YrTmtCZUtIRGlyYjk0TTlscXlFcHNqaFZ4YUJRUzBS?=
 =?utf-8?B?N1g3UHNjOEpTZjl4ZmtHOUtLNmNVQjViRXJ5eXdDUllPenY5OGhGUmIvblFX?=
 =?utf-8?B?YW9CNnlzRkl3YXU4Y09xclVoZ2tCQ0hRMm96QnFpeFA4MHFqTWFkdjNZVUdr?=
 =?utf-8?B?aTdNWE9aQzRFVkY4SVM4bHVjRTMrMm1KOXdDMlNHckd0bC9ISERtVmlmS2dE?=
 =?utf-8?B?RCtoVVFYVThpbWlTdm4zcTFRZjh3YjJoNDgvbHo5TWQwL0R1SEtGSXlucFdW?=
 =?utf-8?B?enVLSldJTEk1NHNEaTlqbDdVS0ZHM1g3Skg1ZjFOMlNROE13aG9Ra2VwZk83?=
 =?utf-8?B?TU43RGg3ZFJmQSt3NXgxNnNmMGFpK0s2QkRXVlJLRXdraU5yMHZqSldIME1y?=
 =?utf-8?B?bU9jbDVVMlhrKzllREZRS0Vydy8wVDlWQVpKeHQ3aEd4TWFyN0N5U1lNTmdT?=
 =?utf-8?B?dXZzbklWemR2eUpQTlllTmY3MWNjM3M0bmFSTVZzekdWR1ZseUxkM3o1OWFK?=
 =?utf-8?B?cHdUeEEvQmkvK2ZXVFBIWFB5bXVQa2hRS0J3VGJKWCsyTXoyRmN0cHIxVThy?=
 =?utf-8?B?QXVvWG10NHZleEtzeThBanBTeFdjclpWOFlZYnNQSXFrTWlCTnlja3hCd3dC?=
 =?utf-8?B?THBxNEJ1bHFmUXkvMDRKZjB3K05Kbk9oVTJicVRLaFdEQjUxVUdSL29YZkNX?=
 =?utf-8?B?MjhPQThDcFNEemxETEd3ZFhES3huU0hkY2wzMGVIOUFNLzFwR3d6RG16WTBH?=
 =?utf-8?B?T1dmaEZOSHRqc1V1WVBabmhvOHMrMWh6TTdxdktZQ05YeXozNFVtSmhhcHpW?=
 =?utf-8?B?c214LzNhY3VxaEEvUjloWlNRQ1BwQzUrSnU1VU93T0kwU0FpRlJVRFpKQ2pp?=
 =?utf-8?B?eXRKMXRCeS8xb0x3M2wzVkVYMTlPbTFVd1poN1RCMWxkMDAzcnp4QU1ITDVj?=
 =?utf-8?B?aGtyTEhxVUF6emVQcGRpdTdLallzRk1vejB6ckk5Z0tMUzhGVjRFN1AxNENQ?=
 =?utf-8?B?ZlI2bnhwT3oxRlIrb3hvdGpvYU5SVk1vRnZNSEE1UTNsWjJPdDhMVU9jQ3lh?=
 =?utf-8?B?emhyUzhNbHlzbHhBTzVWYUU2d2lZQk9YRXN0K2c2djJ3ZUJqK2NiMVB6WU5E?=
 =?utf-8?B?a0dRTFlIcnQ0eTdmaEhyL0lVOGVwaUhSdlVwOGh6YXZaTFYrMmZpVmtDb1Ja?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54DD2B55C5EA844F94CD66ABA7051A74@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Wdbeoj9SklNdDvyigudc2TAtS78iALp+YupqYIljzuIqWgg5IXwZn/NABeKlZHhMcQn78ZBZyzaK0nIfKilWxxEiknrJssPp2sz5AuL4yKhv1zG1Ko4WalQJDpDwi8LBVKa3g1U+E+ZaKita51p6EfuQnykQTHNRVw8ThBg6cMaa+Qkjnf7ovw1aPb9GC6PEGTQmoJYLo6af/NAMUtQQa7edwc8aI2lyTj/oQBdYPrVepfZltAhNyxVUnpx4HT6VVb9Fk/WnEbeRmDE21d0M9kIIBiYsa6e9PUOT9Tn/dIDUUYvJzQQgLwH7ey+8K38qtLPWVlBOn+itaoNBypGeKeTUGjGr31M1whNTek9Y6w7yBMiqWSZOPedLZn10Wxs65M1IaBWNzgRAaa/rmHUIS+Kl0tV+xt3JpjlN8VHjkV4NmeSjl/5wY1mtFMbKYYdzESIjrzFO2DJ7Bny3TdlIY3CtbQJ0ELIjlyDWGMHfFIw7vuvIvKp4Y3dYUSphzNHIvR6HKVA9NG5rL7fqpfKxTvAFAAbdo10Leu1BNUmKsy3egbTnfLk+WADfPK5UgwwHKxNMN3KV6UpCUEEV+MQ8r4ZBRqwlEacIXXJnq4kTdoOMfNTcBib0IGndHcnSPBQrXf6JkMhP1CITyzqFWquayg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38664e66-03d9-4b49-33c0-08dc34c1b8bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 22:49:41.2250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +stZrddZnC83T6KXALc2KOBVXqntZ2ihfVzQCbADG+ubmpuHI/nUJO1gQ0wMB1GPN0jHasKfKiegMOp1kpCn6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284
X-Proofpoint-ORIG-GUID: TqOlfUJLu_aP6FwnoQXZsgCM-vuBGwGG
X-Proofpoint-GUID: TqOlfUJLu_aP6FwnoQXZsgCM-vuBGwGG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 spamscore=0 phishscore=0 adultscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 clxscore=1011 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402230163

T24gU2F0LCBGZWIgMjQsIDIwMjQsIFJhZGhleSBTaHlhbSBQYW5kZXkgd3JvdGU6DQo+IEZyb206
IFBpeXVzaCBNZWh0YSA8cGl5dXNoLm1laHRhQGFtZC5jb20+DQo+IA0KPiBUaGUgR1NCVVNDRkcw
IHJlZ2lzdGVyIGJpdHMgWzMxOjE2XSBhcmUgdXNlZCB0byBjb25maWd1cmUgdGhlIGNhY2hlIHR5
cGUNCj4gc2V0dGluZ3Mgb2YgdGhlIGRlc2NyaXB0b3IgYW5kIGRhdGEgd3JpdGUvcmVhZCB0cmFu
c2ZlcnMgKENhY2hlYWJsZSwNCj4gQnVmZmVyYWJsZS8gUG9zdGVkKS4gV2hlbiBDQ0kgaXMgZW5h
YmxlZCBpbiB0aGUgZGVzaWduLCBEV0MzIGNvcmUgR1NCVVNDRkcwDQo+IGNhY2hlIGJpdHMgbXVz
dCBiZSB1cGRhdGVkIHRvIHN1cHBvcnQgQ0NJIGVuYWJsZWQgdHJhbnNmZXJzIGluIFVTQi4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFBpeXVzaCBNZWh0YSA8cGl5dXNoLm1laHRhQGFtZC5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IFJhZGhleSBTaHlhbSBQYW5kZXkgPHJhZGhleS5zaHlhbS5wYW5kZXlA
YW1kLmNvbT4NCj4gLS0tLQ0KPiBjaGFuZ2VzIGZvciB2MjoNCj4gTWFrZSBHU0JVU0NGRzAgY29u
ZmlndXJhdGlvbiBzcGVjaWZpYyB0byBBTUQteGlsaW54IHBsYXRmb3JtLg0KPiBUYWtlbiByZWZl
cmVuY2UgZnJvbSBleGlzdGluZyBjb21taXQgZWM1ZWI0MzgxM2E0ICgidXNiOiBkd2MzOiBjb3Jl
Og0KPiBhZGQgc3VwcG9ydCBmb3IgcmVhbHRlayBTb0NzIGN1c3RvbSdzIGdsb2JhbCByZWdpc3Rl
ciBzdGFydCBhZGRyZXNzIikNCj4gDQo+IHYxIGxpbms6DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5j
b20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzEwMTMwNTM0NDguMTEwNTYt
MS1waXl1c2gubWVodGFAYW1kLmNvbV9fOyEhQTRGMlI5R19wZyFmZkFEbE5KbVJ5Q2IxQzJCMHoy
MS04QWJKRTRZRHlpWE54S0JLQnFtaG1CT1NTWkJva0hTX3F5ZXRHRXFiN0N3YXdlMFd2YnoyYXFT
WnpfYlRmdlMwY1hkd1hMVld3JCANCg0KUGxlYXNlIGNoZWNrIHRoZSBjb21tZW50IGZyb20gdGhl
IHByZXZpb3VzIHRocmVhZDoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXVzYi8yMDI0
MDIyMzIyNDc0NC52cHR2ZmtxemdxdjI0cHR6QHN5bm9wc3lzLmNvbS9ULyN0DQoNClRoYW5rcywN
ClRoaW5oDQoNCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDI2ICsrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCB8ICA1ICsrKysr
DQo+ICAyIGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGlu
ZGV4IDNlNTU4MzhjMDAwMS4uM2FjZDRhYjNmY2NhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Vz
Yi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtMjMs
NiArMjMsNyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+ICAjaW5jbHVkZSA8bGlu
dXgvZG1hLW1hcHBpbmcuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiArI2luY2x1ZGUg
PGxpbnV4L29mX2FkZHJlc3MuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9vZl9ncmFwaC5oPg0KPiAg
I2luY2x1ZGUgPGxpbnV4L2FjcGkuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9waW5jdHJsL2NvbnN1
bWVyLmg+DQo+IEBAIC01NTksNiArNTYwLDI5IEBAIHN0YXRpYyB2b2lkIGR3YzNfY2FjaGVfaHdw
YXJhbXMoc3RydWN0IGR3YzMgKmR3YykNCj4gIAkJcGFybXMtPmh3cGFyYW1zOSA9IGR3YzNfcmVh
ZGwoZHdjLT5yZWdzLCBEV0MzX0dIV1BBUkFNUzkpOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgdm9p
ZCBkd2MzX2NvbmZpZ19zb2NfYnVzKHN0cnVjdCBkd2MzICpkd2MpDQo+ICt7DQo+ICsJaWYgKGR3
Yy0+ZGV2LT5vZl9ub2RlKSB7DQo+ICsJCXN0cnVjdCBkZXZpY2Vfbm9kZSAqcGFyZW50ID0gb2Zf
Z2V0X3BhcmVudChkd2MtPmRldi0+b2Zfbm9kZSk7DQo+ICsNCj4gKwkJaWYgKG9mX2RldmljZV9p
c19jb21wYXRpYmxlKHBhcmVudCwgInhsbngsenlucW1wLWR3YzMiKSB8fA0KPiArCQkgICAgb2Zf
ZGV2aWNlX2lzX2NvbXBhdGlibGUocGFyZW50LCAieGxueCx2ZXJzYWwtZHdjMyIpKSB7DQo+ICsJ
CQlpZiAob2ZfZG1hX2lzX2NvaGVyZW50KGR3Yy0+ZGV2LT5vZl9ub2RlKSkgew0KPiArCQkJCXUz
MiByZWc7DQo+ICsNCj4gKwkJCQlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19HU0JV
U0NGRzApOw0KPiArCQkJCXJlZyB8PSBEV0MzX0dTQlVTQ0ZHMF9EQVRSRFJFUUlORk9fTUFTSyB8
DQo+ICsJCQkJCURXQzNfR1NCVVNDRkcwX0RFU1JEUkVRSU5GT19NQVNLIHwNCj4gKwkJCQkJRFdD
M19HU0JVU0NGRzBfREFUV1JSRVFJTkZPX01BU0sgfA0KPiArCQkJCQlEV0MzX0dTQlVTQ0ZHMF9E
RVNXUlJFUUlORk9fTUFTSzsNCj4gKwkJCQlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR1NC
VVNDRkcwLCByZWcpOw0KPiArCQkJfQ0KPiArCQl9DQo+ICsNCj4gKwkJb2Zfbm9kZV9wdXQocGFy
ZW50KTsNCj4gKwl9DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgZHdjM19jb3JlX3VscGlfaW5p
dChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgew0KPiAgCWludCBpbnRmOw0KPiBAQCAtMTI1Niw2ICsx
MjgwLDggQEAgc3RhdGljIGludCBkd2MzX2NvcmVfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAg
DQo+ICAJZHdjM19zZXRfaW5jcl9idXJzdF90eXBlKGR3Yyk7DQo+ICANCj4gKwlkd2MzX2NvbmZp
Z19zb2NfYnVzKGR3Yyk7DQo+ICsNCj4gIAlyZXQgPSBkd2MzX3BoeV9wb3dlcl9vbihkd2MpOw0K
PiAgCWlmIChyZXQpDQo+ICAJCWdvdG8gZXJyX2V4aXRfcGh5Ow0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvZHdjMy9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRleCAy
NWRjMDU5OTM0NWUuLmJmMTlhMjBlMjQwZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdj
My9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gQEAgLTE3NSw2ICsx
NzUsMTEgQEANCj4gICNkZWZpbmUgRFdDM19MTFVDVEwJCTB4ZDAyNA0KPiAgDQo+ICAvKiBCaXQg
ZmllbGRzICovDQo+ICsvKiBHbG9iYWwgU29DIEJ1cyBDb25maWd1cmF0aW9uIFJlZ2lzdGVyOiBB
SEItcHJvdC9BWEktY2FjaGUvT0NQLVJlcUluZm8gKi8NCj4gKyNkZWZpbmUgRFdDM19HU0JVU0NG
RzBfREFUUkRSRVFJTkZPX01BU0sJR0VOTUFTSygzMSwgMjgpDQo+ICsjZGVmaW5lIERXQzNfR1NC
VVNDRkcwX0RFU1JEUkVRSU5GT19NQVNLCUdFTk1BU0soMjcsIDI0KQ0KPiArI2RlZmluZSBEV0Mz
X0dTQlVTQ0ZHMF9EQVRXUlJFUUlORk9fTUFTSwlHRU5NQVNLKDIzLCAyMCkNCj4gKyNkZWZpbmUg
RFdDM19HU0JVU0NGRzBfREVTV1JSRVFJTkZPX01BU0sJR0VOTUFTSygxOSwgMTYpDQo+ICANCj4g
IC8qIEdsb2JhbCBTb0MgQnVzIENvbmZpZ3VyYXRpb24gSU5DUnggUmVnaXN0ZXIgMCAqLw0KPiAg
I2RlZmluZSBEV0MzX0dTQlVTQ0ZHMF9JTkNSMjU2QlJTVEVOQQkoMSA8PCA3KSAvKiBJTkNSMjU2
IGJ1cnN0ICovDQo+IC0tIA0KPiAyLjM0LjENCj4g

