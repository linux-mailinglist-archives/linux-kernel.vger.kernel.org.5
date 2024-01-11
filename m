Return-Path: <linux-kernel+bounces-22958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE9A82A5D5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4350A1F21773
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B63EBC;
	Thu, 11 Jan 2024 02:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="aFVlVDSD";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ataEBq1S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fVtLBG6u"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB1110EC;
	Thu, 11 Jan 2024 02:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40AMwAei024296;
	Wed, 10 Jan 2024 18:10:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=HCut/bMkjclESrnTwnwyjADCUSht/TPlpmXF2DDiKQk=; b=
	aFVlVDSDxH0id8MUIns/o5TE2TSQyxzIwamEbAnUZ+pg7JGsLesVnoO5AfW5M+ng
	Bxi9007HTyKjnJiL4Wh2Ju83krc+hYZUOrAvrRirqYdbodpqjKFGlertm2KTEri5
	riRvXomBMiZNB3f0VDNJA98MLp4In7m/BXFIoOFiQUi0D1huc29J72q6/DVWc9fZ
	aYikgGjKmzB1iXRQL3Ub7wXQkVIBu/4usPPPz2TQ+ZiiKUb4CxTMbqnAIcRdgzkC
	GLceWyspEyG6KOEgG38jaboPxeWeXWseMaiMJA1i09rwZafxDrFpShkSDTJkq+rV
	MFGrqR7T4jnC9+beWdYFcA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3vj4ge0j1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 18:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1704939023; bh=HCut/bMkjclESrnTwnwyjADCUSht/TPlpmXF2DDiKQk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ataEBq1S46/Xw35aCcKK4EkUp+jBQlCpI/uBjU/sGsknisflpw75A/wIR+hNLNj5Y
	 Fu8CZwfo1ciSELIsWv7UlFrSHJyiBqRJDB5xXasgdLYlQZ2LSmRMfAh1wTVzPqEAN/
	 8je6ercW9TMs6udnd3cVzqXhnnhi+Qy1CySIPIE9rxi3oCeaomMirOWslfQVcilE1i
	 OjESHEfra1hF4jbk+3lhohPc+J0sNd86N1ZvsDlBsXY/RilRhbS1BxHEygBN0yWDxf
	 MBv1wiM2RMTUsZi2iZpd5paE84jDRnAj5xy82W9kpgY1wyyXcy8aTLZrdkGu+4BX1F
	 DYftbqxgHhRzg==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BBB334012B;
	Thu, 11 Jan 2024 02:10:23 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 8C439A0084;
	Thu, 11 Jan 2024 02:10:23 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=fVtLBG6u;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8B6EA40352;
	Thu, 11 Jan 2024 02:10:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOFCNS9dtGmjdxGN1EAmoKaiHGz/1N4cXJ3mFqGA3KEVyXsksWcFHNOo+4n9djWUSz7KW835tB7jkxloYn0YElNG87Y98OFyLikWCzjkYosHtJ2AATM2kqxLdbmQu9SzKdmr4z3rAAF/vF0AgJXz2aewlx+F6t7GanoBj1xHW0zM17wjNlgINBQO7yeZwHluFme8akRbSyZY8FcNrIwGvfy/Po6HjmRZLiu0XP/2UoTDsHwGLuuoT7HZxiogodGYIv/m1CI3HzISiPYejYVaqApWRdXWVARJQX9ksi1W/jLMW6r4N2O5TWXc3dBHaYhq/0mbXQ/eB6iEeeF8sq2wOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCut/bMkjclESrnTwnwyjADCUSht/TPlpmXF2DDiKQk=;
 b=UbgNaKs+BGDuE+0MXWcuTz2ODqjzkFoW9xhd96ryRF7XEePyzIyHLiTIDY8ea/cSq99yScJXo9cCW6wToH2MYGjpbSWUrp7Yibw12o2sDXJacC7/1oMNg8C4zQsLJgdpOeTN+YL2laAZXeB62uF6t3/KUGuVuokYCVOLWBR9iIsQppujJmFUWcUUnby6LeGiAB/iHc43V2zDDaNhO3VItyPOXxw5WTjzvAF0ARzUmZM8jN1shz88r5+C+J4TaEtVcTA3ehJ+jQFSa7MqgiwDzvJ38G1tdvym+R/Mj94EkI4uq3ImVIuebwN1aXj9g6ZI8lFnIIN8BK0SKOsuz9kqnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCut/bMkjclESrnTwnwyjADCUSht/TPlpmXF2DDiKQk=;
 b=fVtLBG6uNj0Ly82+n5ENO93jZKo6//NDhDQlOpXJt+JdcFtI5Kur2NH7nuYn670r0G+bz3HIioB1SXH0HIVAwxKUfGj9GsVV2UP+tuLfh8FeogEaOokbuHpkiL0bWxZFIwX081eB9uksBrTRCZFp9ZqAY6ukB4DoVXkJFiEde2Y=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SJ2PR12MB7989.namprd12.prod.outlook.com (2603:10b6:a03:4c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 02:10:18 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 02:10:18 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Ignore dwc3 interrupt if GEVNTCOUNT
 reads corrupt value
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Ignore dwc3 interrupt if
 GEVNTCOUNT reads corrupt value
Thread-Index: AQHaNCC0mm7MoIG+aEynlStsmItJ6bC14YCAgACreACAHXFogA==
Date: Thu, 11 Jan 2024 02:10:18 +0000
Message-ID: <20240111021015.dzgnyjo6bgri4efc@synopsys.com>
References: <20231221151620.16030-1-quic_kriskura@quicinc.com>
 <20231222221907.l7s5olt6uubwfjlh@synopsys.com>
 <61d4f3f6-dc91-449a-9666-67f1eaca414c@quicinc.com>
In-Reply-To: <61d4f3f6-dc91-449a-9666-67f1eaca414c@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SJ2PR12MB7989:EE_
x-ms-office365-filtering-correlation-id: a17add9e-96c1-4ddd-9393-08dc124a752d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zrENRL6Yf9GVg7ldEahCWJd76x7O6Kgbz8KyRHBAe4xUwylZ1y9K0zwYJVGhqnLm7aDEUmZnIQCHYas3IyHGZWbDD0PIhQL/arETLyub5+VAv52shG+XD0nFmIZkdKsk1nTHPEvTqbur2am9V7fydVsqRNv+yTnOsBhqPEylcvOBa1rRXIgDKYdDwFbnaBgXph4iixsFHlUPknZyq0GGCHB1wms6nJ9fqaMoal+1qhEeMzFiSunb6m6SEIuGVOdJRFTBQF+feINB4PVEMv5+HWpxquDTl/zFEn9117ebHGfbFNniG0BjqhCmbVzSogLpNQNfIGLhp32Dmg6SnKgad+7Zfm0ygDBxeuHmOTMC4L55RMkkDhvIWLLYOR8XTV3c3FBQPR/FIwSfW7ci+1pgJOKH6h5eocyg+Eh5ag9w+C8pFj4MEsq3eiCLl9wX7/3PsWYMlO8ZFDXuNmABepTqr0iMyGjrBCfitRlf6SW9lmcTGESQcoEex7H0gslWLp0mvMredPl0nDHrmwJlQm71yr2bjRXTClMjW3zD251vtMFLTot32KbT8b8/P5wZyG84hHJpQzCwRhGJ1PeQvDsHn1s1tBJjVArCg7+RYKKtlbg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1076003)(86362001)(71200400001)(6506007)(966005)(2616005)(26005)(53546011)(478600001)(6512007)(6486002)(83380400001)(5660300002)(41300700001)(66556008)(64756008)(66446008)(66476007)(76116006)(8936002)(4326008)(8676002)(91956017)(2906002)(66946007)(38070700009)(316002)(6916009)(54906003)(36756003)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RDg0YU11OXBwK3loWnhlUWpHMnNXWEU1dzVNN3JFd2RQK3lvNHVLRWgvakFK?=
 =?utf-8?B?dDlnZ2FwLzlyTjZqeG5uclpNZytNSkpvR1VXRUpRa0YwVSszNVRCTGlkczBt?=
 =?utf-8?B?b05sdDZqbGVKY3hnK3NQL1h5ZHZud3VqaFBkZUNsVDRmRnVzVUtNMUs3ejcr?=
 =?utf-8?B?bDJzYXd0ZDExQWxiQmdGWVBkUEJxeWpmQUhVQUhYendoSDIzUlJoZWNRcjRU?=
 =?utf-8?B?ZXdVRWFLZjYzL09GMFpiV2dxZFA0WEFLa2ZjLzNRVG1FakJyS21GVThuL3ln?=
 =?utf-8?B?anRvUmpoQjB5eTVnd2ZiMEFNUlVWd21jL2ZrZUFNcUNaOXpvTmx6Y1p1RXhv?=
 =?utf-8?B?V1ZXUVlYRzVMNTJGMHI0VDJTK0FsNk1TTC9tVUV0L1NLQTVoQjhGVzlUbmt3?=
 =?utf-8?B?TFYzWk1zdXcyMmlLZjAxYWF4eG9MVGc4eGEzandUV3VpZUMwVE4xbE5XaUhi?=
 =?utf-8?B?bHhUNkdxdFBPcENrbE5aQllTSWpMUXpkbzNmcktxd1JJTXhUdFBjdlFROVds?=
 =?utf-8?B?U3RwS2lFSzBQRW9jR3lQcVpNaDJMK0N1WnB4R1N4bzVCN3RVaGVIVHRweW85?=
 =?utf-8?B?ZTI0eVB2M0xkNkltaDV2UE9KVzhTL0Y4YzI5RkNMd3IzK1k2UHYzanhqL29S?=
 =?utf-8?B?RUtxY0dSdFp5YkFEZURYSlJLZ3hBeWIwOWxiZ25iQXR2Q2x0TG0zOXNGUG4x?=
 =?utf-8?B?VDd1UEc4eFpzYzNlNTl6dGExK0xNQWZ5VGhVSTBOeGp4KzBmYUlWWU1kbDFB?=
 =?utf-8?B?NVE1TUQ2b0F4VCtVS2dWOGhudjBWdzQzMkNEalVZMXlMQURSUVBBb2tRRWJp?=
 =?utf-8?B?YTN4Qmt2VUJSRmpiKy8rTHBLRUR2NEp1SFJ5Ti91cWltNFk5V3ZPdXFNVDR1?=
 =?utf-8?B?UzB1SnB0dXhxRk5Gbkp0cDFMbnRHQlBQZzVOc1NVYWFsRHFLcG4yUHJYWUsw?=
 =?utf-8?B?K1pPT1FLYUlXRlQ0TjJEWGlwbmlJT0JNVllWYnZIemlvZzF3aE1MMkkzY0h1?=
 =?utf-8?B?WS94b1RnVGsvaExqQzZWVXMxUG1MaFBpNlNqUDNWQWtlcWxKbWQ1ZklUK1hj?=
 =?utf-8?B?YlVEeXVyRENjZEJMVUIySHZNZG8zVXRpbm1rR1hwQkpFczdsU2VOU0FsQkJO?=
 =?utf-8?B?YUtuWk84dmZYeU1zTXA3d1ZBeG0wQmVyNWlSTG5HQ1F6TFZrellHeitBWTND?=
 =?utf-8?B?aisxYVJUbDI3cjJRN0VRR2IvVC83eTh3Q1BIRUhPZktYVFBPakUycElEYm5i?=
 =?utf-8?B?OXQ0K0l2d2xNTW9oakRsVDJ1MUdPMnVMRkQyUVZhL3VxZkMvZlFnaFZEcWVw?=
 =?utf-8?B?VmxXcElSclpkNEV6OG1Md1ROVFNEWnFkNWEyZGdnaHZBYVJhaXQwOS8wQ3hq?=
 =?utf-8?B?Q004VnJqZXk0VlYxaFc0dWZsTjRyRmpoMk1ieVVSWjAvRkN3TzRvNXFDMjQ2?=
 =?utf-8?B?dCtaN215LzJpZm1mS0Y0eGcrUmt3aStjOHBOQ21BN3hnWVBxUjRrT0txb1Jo?=
 =?utf-8?B?TEN6SXdzU05aT1g5UTZqRnNHSW1JV0IwVkRFU0RjallJdzNDMlRLV0pXbTVY?=
 =?utf-8?B?TTJOYzJtRW1Hc2o5alJCbmtxVmp0ZWo4MU9Vb01SZURMMnJyS09jZWJrajB6?=
 =?utf-8?B?K2MzUTZ4VjM2NWN4TGxtSUthL2RIYk5YQUF3VXRyRWVjNnQ1LzRiZEJyL1c1?=
 =?utf-8?B?cWtualM2Rm0xeVU1ZDRwTjJDSHo3dkovZ3N0RGxUUHRmT1JaVi9sc0VvNldq?=
 =?utf-8?B?WDlCYW4zb2ZRcTFEZXlFQUNnUW80VmRabjgrWFRKOWVyNk15Y1NWMzd6VmVP?=
 =?utf-8?B?WldtYzhYUEswL2NkVU5nTjFrbXJCNmhWL2orVDhUNlNXeVNaOXhyQVByL2Nk?=
 =?utf-8?B?d1Q5NjczUmZpWWtpZHBlV21nNm1pSzgwTXJFOHM5UDZQaUpEWWZpVW5Zem1L?=
 =?utf-8?B?WkpMV3JnZUw5Vk9Fb1d5bG9vaWdVSStjanp1RXpXY2ozN1c5a0huUTIvalBE?=
 =?utf-8?B?K2JzOE1pREEzSmliZitCWklscEhpQ0VsZUpJT3BKSUsrRnAwbHhwRkhtTE16?=
 =?utf-8?B?d1l0dGxtSml0amNocVVzU05QenM4bW9rdkFrTjFTcXpSdDc5VEw2b2V4Njdx?=
 =?utf-8?Q?JtAqB8L884RLOBIAvRUHWCk/i?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5C09660D7724643ACE34ECFD067D3E5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dYL1ZL9rREiIBlIz9Qa/Y5EgMeedRf9kI1pdeIrKZVCNfREM+5dwYuyqgPMtpmCLuXZLaFmtM7eVZPBUXjSgJHx+53rXbq8EQhgbt+Iscx0s36hG+gR0GbjpOOHdJbAnugrLJCXbi81mOHMxi0X66p8LZkHeANIRDs270CinOA+sjUX/XjZyGwbMRgFo+rpjcxLEqDybKtGjTlvf5n58ORIbGyizbWGyjtbmcTXiG4M378auuMKx7JGQaeJCsTCbOcArgcPYgLzA9py7llfc8uloSIGeMiQFgYXEKAPJtcPBIRYiKvVMUIXsOfNNX+f5VxEAH0DdQQjDfhbEQisVvwUx83iDgRO2twtNlImuELuHtciKTPG339JRIhh9eRS/A1KXAm6e5dnFTO4BP0G1m23SYuXJ/wB96Xunx0fxcR6qVgBfYWma8JGnGi1XOpxdLXqFcweYTcuyHb2sAM5zA5yYonhBiX2osPGRI1VtQk4oKn/FkQO+NA2bWO3wjQ6DXCYLLZMzp+mZoRJXPqJgDAb4KvdGKTJOoVqTIDHO9Fxnk8+AnPW/R094ATiNwoBhdm1vNpoHdavY/draf27sVoZyFjPfmXI4ec4y0/aBmjswR+bspqv4PUiht4mBO9yxi0hh2ZzEN/u+a9q4V89Nhw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17add9e-96c1-4ddd-9393-08dc124a752d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 02:10:18.2284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 55lmNPRNhBKb/wbkfYvAUbf05xzQRJ9+3Lw1vOOVmewaYsEg+XY7IEH3xa1LsTviWwoxZULPtpebr5sRBsERvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7989
X-Proofpoint-GUID: dXTcWaw3vD8IDUUiwy5O5_u7gJF2cvXj
X-Proofpoint-ORIG-GUID: dXTcWaw3vD8IDUUiwy5O5_u7gJF2cvXj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 mlxlogscore=868 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401110015

SGkgS3Jpc2huYSwNCg0KT24gU2F0LCBEZWMgMjMsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNT
TlYgd3JvdGU6DQo+IA0KPiANCj4gT24gMTIvMjMvMjAyMyAzOjQ5IEFNLCBUaGluaCBOZ3V5ZW4g
d3JvdGU6DQo+ID4gT24gVGh1LCBEZWMgMjEsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6
DQo+ID4gPiBJbiB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiwgdGhlIGNoZWNrX2V2ZW50X2J1
ZiBjYWxsIHJlYWRzIHRoZQ0KPiA+ID4gR0VWTlRDT1VOVCByZWdpc3RlciB0byBkZXRlcm1pbmUg
dGhlIGFtb3VudCBvZiBldmVudCBkYXRhIGdlbmVyYXRlZA0KPiA+ID4gYW5kIGNvcGllcyBpdCBm
cm9tIGV2LT5idWYgdG8gZXYtPmNhY2hlIGFmdGVyIG1hc2tpbmcgaW50ZXJydXB0Lg0KPiA+ID4g
DQo+ID4gPiBEdXJpbmcgY29weSBpZiB0aGUgYW1vdW50IG9mIGRhdGEgdG8gYmUgY29waWVkIGlz
IG1vcmUgdGhhbg0KPiA+ID4gKGxlbmd0aCAtIGxwb3MpLCB3ZSBmaWxsIHRoZSBldi0+Y2FjaGUg
dGlsbCB0aGUgZW5kIG9mIDQwOTYgYnl0ZQ0KPiA+ID4gYnVmZmVyIGFsbG9jYXRlZCBhbmQgdGhl
biBzdGFydCBmaWxsaW5nIGZyb20gdGhlIHRvcCAobHBvcyA9IDApLg0KPiA+ID4gDQo+ID4gPiBJ
biBvbmUgaW5zdGFuY2Ugb2YgU01NVSBjcmFzaCBpdCBpcyBvYnNlcnZlZCB0aGF0IEdFVk5UQ09V
TlQgcmVnaXN0ZXINCj4gPiA+IHJlYWRzIG1vcmUgdGhhbiA0MDk2IGJ5dGVzOg0KPiA+ID4gDQo+
ID4gPiBkd2MzX3JlYWRsICAgYmFzZT0weGZmZmZmZmMwMDkxZGMwMDAgIG9mZnNldD01MDE4OCAg
dmFsdWU9NjM0ODgNCj4gPiA+IA0KPiA+ID4gKG9mZnNldCA9IDUwMTg4IC0+IDB4QzQwQykgIC0+
IHJlYWRzIDYzNDg4IGJ5dGVzDQo+ID4gPiANCj4gPiA+IEFzIHBlciBjcmFzaCBkdW1wOg0KPiA+
ID4gZHdjLT5scG9zID0gMjA1Ng0KPiA+ID4gDQo+ID4gPiBhbmQgZXZ0LT5idWYgaXMgYXQgMHhG
RkZGRkZDMDA5MTg1MDAwIGFuZCB0aGUgY3Jhc2ggaXMgYXQNCj4gPiA+IDB4RkZGRkZGQzAwOTE4
NjAwMC4gVGhlIGRpZmYgd2hpY2ggaXMgZXhhY3RseSAweDEwMDAgYnl0ZXMuDQo+ID4gPiANCj4g
PiA+IFdlIGZpcnN0IG1lbWNweSAyMDQwIGJ5dGVzIGZyb20gKGJ1ZiArIGxwb3MpIHRvIChidWYg
KyAweDEwMDApLg0KPiA+ID4gDQo+ID4gPiBBbmQgdGhlbiB3ZSBjb3B5IHRoZSByZXN0IG9mIHRo
ZSBkYXRhICg2NDM4OCAtIDIwNDApIGZyb20gYmVnaW5uaW5nDQo+ID4gPiBvZiBkd2MtPmV2X2J1
Zi4gV2hpbGUgZG9pbmcgc28gd2UgZ28gYmV5b25kIGJvdW5kcyBhcyB3ZSBhcmUgdHJ5aW5nDQo+
ID4gPiB0byBtZW1jcHkgNjIzNDggYnl0ZXMgaW50byBhIDRLIGJ1ZmZlciByZXN1bHRpbmcgaW4g
Y3Jhc2guDQo+ID4gPiANCj4gPiA+IEZpeCB0aGlzIGJ5IGlnbm9yaW5nIHRoZSBpbnRlcnJ1cHQg
d2hlbiBHRVZOVENPVU5UIHJlZ2lzdGVyIHJlYWRzIGENCj4gPiA+IHZhbHVlIG1vcmUgdGhhbiB0
aGUgZXZlbnQgcmluZyBhbGxvY2F0ZWQuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEty
aXNobmEgS3VyYXBhdGkgPHF1aWNfa3Jpc2t1cmFAcXVpY2luYy5jb20+DQo+ID4gPiAtLS0NCj4g
PiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gPiBJbnN0ZWFkIG9mIGZpeGluZyBhbW91bnQgb2YgZGF0
YSBiZWluZyBjb3BpZWQgZnJvbSByaW5nLCBpZ25vcmVkDQo+ID4gPiB0aGUgaW50ZXJydXB0IHdo
ZW4gY291bnQgaXMgY29ycnVwdCBhcyBwZXIgc3VnZ2VzdGlvbiBmcm9tIFRoaW5oLg0KPiA+ID4g
DQo+ID4gPiBMaW5rIHRvIHYxOg0KPiA+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDUyMTEwMDMzMC4yMjQ3OC0xLXF1aWNfa3Jp
c2t1cmFAcXVpY2luYy5jb20vX187ISFBNEYyUjlHX3BnIWV3TTN1OVBkazh5RDllVTI0c091UXFt
aG04TTJWcEdYSDh6QUxxVldHS2ZmR2JjSnhydHlLS2xVUHVoOFNTMmFycU8wOURqbkM5YXRDM2Jl
bUVweC1nNVVRTWxsYkEkDQo+ID4gPiANCj4gPiA+ICAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQu
YyB8IDEwICsrKysrKysrKy0NCj4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Iv
ZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gPiA+IGluZGV4IDg1
OGZlNGMyOTliNy4uZTI3OTMzZmRjY2UzIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy91c2Iv
ZHdjMy9nYWRnZXQuYw0KPiA+ID4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+
ID4gQEAgLTQ0NTEsNiArNDQ1MSw3IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBkd2MzX3RocmVhZF9p
bnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqX2V2dCkNCj4gPiA+ICAgc3RhdGljIGlycXJldHVybl90
IGR3YzNfY2hlY2tfZXZlbnRfYnVmKHN0cnVjdCBkd2MzX2V2ZW50X2J1ZmZlciAqZXZ0KQ0KPiA+
ID4gICB7DQo+ID4gPiAgIAlzdHJ1Y3QgZHdjMyAqZHdjID0gZXZ0LT5kd2M7DQo+ID4gPiArCWlu
dCByZXQgPSBJUlFfV0FLRV9USFJFQUQ7DQo+ID4gDQo+ID4gaXJxcmV0dXJuX3QgaW5zdGVhZCBv
ZiBpbnQ/DQo+ID4gDQo+ID4gPiAgIAl1MzIgYW1vdW50Ow0KPiA+ID4gICAJdTMyIGNvdW50Ow0K
PiA+ID4gQEAgLTQ0ODAsNiArNDQ4MSwxMiBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgZHdjM19jaGVj
a19ldmVudF9idWYoc3RydWN0IGR3YzNfZXZlbnRfYnVmZmVyICpldnQpDQo+ID4gPiAgIAlpZiAo
IWNvdW50KQ0KPiA+ID4gICAJCXJldHVybiBJUlFfTk9ORTsNCj4gPiA+ICsJaWYgKGNvdW50ID4g
ZXZ0LT5sZW5ndGgpIHsNCj4gPiA+ICsJCWRldl9lcnIoZHdjLT5kZXYsICJHRVZUQ09VTlQgY29y
cnVwdFxuIik7DQo+ID4gPiArCQlyZXQgPSBJUlFfTk9ORTsNCj4gPiA+ICsJCWdvdG8gZG9uZTsN
Cj4gPiA+ICsJfQ0KPiA+ID4gKw0KPiA+ID4gICAJZXZ0LT5jb3VudCA9IGNvdW50Ow0KPiA+ID4g
ICAJZXZ0LT5mbGFncyB8PSBEV0MzX0VWRU5UX1BFTkRJTkc7DQo+ID4gPiBAQCAtNDQ5Myw5ICs0
NTAwLDEwIEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBkd2MzX2NoZWNrX2V2ZW50X2J1ZihzdHJ1Y3Qg
ZHdjM19ldmVudF9idWZmZXIgKmV2dCkNCj4gPiA+ICAgCWlmIChhbW91bnQgPCBjb3VudCkNCj4g
PiA+ICAgCQltZW1jcHkoZXZ0LT5jYWNoZSwgZXZ0LT5idWYsIGNvdW50IC0gYW1vdW50KTsNCj4g
PiA+ICtkb25lOg0KPiA+ID4gICAJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dFVk5UQ09V
TlQoMCksIGNvdW50KTsNCj4gPiANCj4gPiBEb24ndCB1cGRhdGUgdGhlIEdFVk5UQ09VTlQgaWYg
dGhlIHJlYWQgaXMgaW52YWxpZC4gV2UncmUgbm90IHByb2Nlc3NpbmcNCj4gPiBhbnkgZXZlbnQs
IHNvIHdlIHNob3VsZCBub3Qgd3JpdGUgYmFjayB0aGUgImNvdW50IiB0aGF0IHdlIGRpZCBub3QN
Cj4gPiBwcm9jZXNzLg0KPiA+IA0KPiBUaGFua3MgZm9yIHRoZSByZXZpZXcgVGhpbmguDQo+IA0K
PiBJZiB3ZSBkb24ndCB1cGRhdGUsIHdvbid0IHRoZSByZWdpc3RlciBhbHdheXMgYmUgbm9uLXpl
cm8gPyBJdCB3aWxsIGtlZXANCj4gdHJpZ2dlcmluZyB0aGUgZHdjM19pbnRlcnJ1cHQgdW5uZWNl
c3NhcmlseSByaWdodCA/DQo+IA0KDQpJIHRoaW5rIEkgYXNrZWQgdGhpcyBwcmV2aW91c2x5IGFs
c28uIFBlcmhhcHMgdGhlcmUgd2FzIGENCm1pc3VuZGVyc3RhbmRpbmcuIEZyb20gd2hhdCBJIHVu
ZGVyc3Rvb2QsIHRoaXMgaW52YWxpZCByZWdpc3RlciByZWFkIHdhcw0KYSB0ZW1wb3JhcnkgaXNz
dWUgdGhhdCB3b3VsZCBiZSBmaXhlZCBieSBpdHNlbGYgYWZ0ZXIgYSBmZXcgcmV0cmllcyBvZg0K
cmVnaXN0ZXIgcmVhZC4NCg0KSWYgdGhhdCdzIG5vdCB0aGUgY2FzZSwgdGhlbiB3ZSBjYW5ub3Qg
bW92ZSBmb3J3YXJkLiBUaGUgZHJpdmVyIHdpbGwgbm90DQpiZSBpbiBzeW5jIHdpdGggdGhlIGNv
bnRyb2xsZXIgYmVjYXVzZSBvZiB0aGUgaW52YWxpZCBldmVudCBjb3VudC4gV2UNCndpbGwgbmVl
ZCB0byBncmFjZWZ1bGx5IGhhbHQgdGhlIGNvbnRyb2xsZXIgYW5kIG5vdGlmeSB0aGUgdXNlciBv
ZiB0aGUNCmVycm9yLg0KDQpUaGFua3MsDQpUaGluaA==

