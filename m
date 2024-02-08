Return-Path: <linux-kernel+bounces-57574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B8784DAE5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5714F2874E2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8036F69DF3;
	Thu,  8 Feb 2024 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="A5+bxS2Y"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72B869DE8;
	Thu,  8 Feb 2024 07:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707378787; cv=fail; b=pbhypcCs9o3ZNcrHCGEP/a35DT/Elm25zQKhb+Fe5cbTyN7PuAsdaEbSCb62COLkkG7X1nHtXYT5/yh+gR9ec5kEWbKz3owiNNBMBiojJgO5UtPuNKD/uIt/k8+VPJiidVPPBw7uWbSBKp6IIxL34Y2TiZoumIkxJA5aXke7uTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707378787; c=relaxed/simple;
	bh=s+CxEqiDNlUW0Rpm0OS733Tlm3DFMijtuduJe6O4k1c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tAMAjplLB1P/WodI6MHvGeT2dLqq+T/vgZd3oQYv2QEZsmd9B/Qj7D2uJ5vWKljY5anQvBKtxV+tCK5RxAU6KoT2sXL2B7iLIc/QtBZn3TPEdaTjb8CNWDBBrA5wV5VYTpnjWwsZ5oC3LA8q9VXb5jzh5N9/jcT5WuuwDbcrr+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=A5+bxS2Y; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4187dh15005880;
	Wed, 7 Feb 2024 23:52:55 -0800
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3w4trp817c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 23:52:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlxPGzfnxI8FHsmkX8l+H1oaguw5ANmtG915DY+b56zCJerQUs846myAUAxHB79ZCWkPCLdGsfa0bJWmcxijb8xiMGUHSbildD9MgfdkrsEtdboIcO/EicoqH/cJiZ6H7Beu9LBOLTmetYKZRQQ/X113DtNaSoqn5wb1qObnQtJ5XAOndCm04lk2tbIh2v6FtC88SBCVvoq7XbEuUsLYqcZ6/4x83btZ5Ts+sd2fWPmTza86YJPieI/SfyocDQapPtc2ondRoeJkseYfw4mIYR0C5gNJTua00T7WEWj5RY0WEjXT/z2VoG3v9hybv+FylB/6aN2JMDQ7d+wH4m+gnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+CxEqiDNlUW0Rpm0OS733Tlm3DFMijtuduJe6O4k1c=;
 b=ehPCYiI8ksHufrXschJAacvCZ4yE2az9Ly7+rrtpLZTOc45BWStWqQTzI7qNsc2BBfosXxO/XToz+22GA547FyT4M+5l/s6zJg9Kj43qx/riaECkJn4c4TtgYYwk6HZwcL+hRZzSccuJ8pmzuh2eoJj0t/fvHHvN++Blzgc1tuvRuy8qGCsi/BZpvV0GYVKewpqf20tdyvleZblmz8gonp8ftcqY2oMOaA06v0EOnEecb+qCvJW6O9TblJAWPpM/9ASNnA56Si6zm6/hyNDBOhmd3e5rn1iM3BlSVQ2ItfEtCBQQybKwax89sBJgUstrZo4yQpGcDCd1Gr4UHGKgmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+CxEqiDNlUW0Rpm0OS733Tlm3DFMijtuduJe6O4k1c=;
 b=A5+bxS2Y476GV9J8k8whXzS37rvaU81bYazp6vwoJK09UhJ0T+l1jlwT6nb7ytvD1wvzgrfrFCa5BEZJ0C7XodHwO78gdCOKtSqXlz8rnwBIr6Ia8VCUMSFC7xFH4Y9wxAiLd3XKb8mb6lJ+X3lt+wQmR0hjbP3Vdl88CJ+jEkY=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by SJ2PR18MB5633.namprd18.prod.outlook.com (2603:10b6:a03:55b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 07:52:52 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::e893:20f8:10ab:d524]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::e893:20f8:10ab:d524%3]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 07:52:52 +0000
From: Shinas Rasheed <srasheed@marvell.com>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani
	<hgani@marvell.com>, Vimlesh Kumar <vimleshk@marvell.com>,
        Sathesh B Edara
	<sedara@marvell.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        "mschmidt@redhat.com" <mschmidt@redhat.com>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "kheib@redhat.com" <kheib@redhat.com>,
        "konguyen@redhat.com"
	<konguyen@redhat.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Satananda
 Burla <sburla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>
Subject: RE: [EXT] Re: [PATCH net-next v6 5/8] octeon_ep_vf: add support for
 ndo ops
Thread-Topic: [EXT] Re: [PATCH net-next v6 5/8] octeon_ep_vf: add support for
 ndo ops
Thread-Index: AQHaWZJDhRL31pJsKkmO0QSKuJjTg7D+hueAgAGNSMA=
Date: Thu, 8 Feb 2024 07:52:52 +0000
Message-ID: 
 <PH0PR18MB47347EC45BDBD9F192BC05FAC7442@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20240207065207.3092004-1-srasheed@marvell.com>
 <20240207065207.3092004-6-srasheed@marvell.com>
 <CAH-L+nN04MuWS-QOxpPfQMD5iAvdZPFCp0nffuhB43+puLgk_Q@mail.gmail.com>
In-Reply-To: 
 <CAH-L+nN04MuWS-QOxpPfQMD5iAvdZPFCp0nffuhB43+puLgk_Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|SJ2PR18MB5633:EE_
x-ms-office365-filtering-correlation-id: 097fc7d6-7c12-4fe0-8946-08dc287af429
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Z/4FOvuT+sNIk4pG/YedeXRhFJ/WstBCO/CkGYqAjBytGrHAo6OrSS70w94ct+LtyuPeLEcSQcIiRPhYuzgajV2dSIBeVTRKgTyrYEZEl2GdmLiZhtwFJ8OjPc6lVr3eBAaeD5/CHR05AC5r32A919D8VRtbvvOLJZM/dbH4PXDBhqkOfRoY71dpDXlZvOsQvUeJto7eZ4yrRE1fzUINnvtpAUdM2vKPfN3O/g2qsjkHHWopwW1QkAnQv5EBJFHT+7/w7J0w7GIdXS6t3g+oi0qe4pLv+XZHj6v/xQV4IlZgoefMG3wQAQLR0YnfkUiEKHnw4hg21SkosxWn6b5zf29dcN0esFNsNdeOH2v/CFRsTbJGC7+4A5+cMEy7woWk7eXbmTcj9n8KjY/JKZpIn0bTfEAjYsjF9tSK/8PNcPg10kOwuqTC1jRkg9d3JPoP1rA/fQjlPSAknCqJAVMP52XlSkwz5zA2fRXOTv53+odoo4DphCkSk25xTxxuA+LWZ0O7OjrG27Yrfu5zyqw7tOA7L46S7VjBmyl/sDl/3x+4mqPPhelZW1G2XcJ6yULb+gJIhrPk+SpmiICFokMmZTUlb/Ynbx0I140e48XA3on5GnOAyFH3yP6XKJxYOADy
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(39850400004)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38070700009)(41300700001)(55016003)(33656002)(8676002)(54906003)(66476007)(64756008)(9686003)(8936002)(76116006)(2906002)(86362001)(26005)(66556008)(71200400001)(316002)(5660300002)(38100700002)(6506007)(478600001)(66446008)(66946007)(6916009)(53546011)(7696005)(4326008)(52536014)(7416002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bGlsQnNQd3hpVzBNZ1cweWpjYjQ0MXRVS1YwM3pvUFR0MmJYNi9HdHpjaFF6?=
 =?utf-8?B?d1NQMHBCczM2a0hCOG5FdnEzeEhScjNOTXBQc3FXOWJTVUM5RTliczBsSFlC?=
 =?utf-8?B?ekZRK0tuZWZBNDM4K2daWHptUUdFeXJnWThpcVNjSEpKMDN3Y0R2eFE0YkE2?=
 =?utf-8?B?QVdtVGlCUGxsSjR3dktxak83VjZlTUZoaXFRRWhZalR2M0w5cm1IUWRyOFY0?=
 =?utf-8?B?S2U3V1BaK0VlVHIyUU8rQVljbHQ3V1pLZndjTFpJRWFuamIzOHhBYWhYSG5L?=
 =?utf-8?B?WGlFTFlOcGlndUtsdFVpSWJXYXdIbmpaMy9DS1dSdU5zUTZYT0NHNjk3OENq?=
 =?utf-8?B?bXR0QjBzbHZyRUU0bUhOL0x3SzdMUnlBVEhvWFRhWll0dHZwOTlqUU9jSHZj?=
 =?utf-8?B?TmFXRU5TVDl5MGNCSFRLSklFcTRpTnVPUXZQWnVHOUdhN0Jkbkp5OS9UV1BJ?=
 =?utf-8?B?bUhWZGNUMGR1eVBWWXFHNzBtUUZqeVAzVVNZU1lQdS9lMmZxS2NLdC9FQmg3?=
 =?utf-8?B?Ym1RMWpMY2Naa1ZJbUNFQ0Q3dlJ6WjV6VHRJOXFMQWwrRHJtcVlvVnNUNUJo?=
 =?utf-8?B?ejFwNndGdVZjYVl4QWFLSmRsN2g2QzRUTG52Zy9UcFpNa1RUakN1YzU4b1Fz?=
 =?utf-8?B?T3JweHVCbVovd1cxSmVuaWg2TjVxa2Zob0RRbXpvYk1DUnkzbHFuUXJqVCtp?=
 =?utf-8?B?NG1GKy82RE00REFqK0ZMa1U4ZzVVd0FuYTE1Ly9VVE5KNUk4TTFmZ0pNTFNW?=
 =?utf-8?B?d1Z1eWk0dkYrWHRZSURBMFpEcmxQSXdmK2dZdXhoeU5JQVd5QVpNWElLVndN?=
 =?utf-8?B?b1lpM3lpaHdkeVFYTDVKYkp5N0hvK2ZXdFVzdUFqMnNNOXI1bG02QWY4MENV?=
 =?utf-8?B?aW04dXlrVjBGejlqc0lvQjhSUHhSeHdVMmhUR0pML1BjZFRheEMzRVorKzRt?=
 =?utf-8?B?QUk0Yk5FTE9CUldvbUFyYU1NYVN0NGZHRGtIeWxRWlFoR0lieXlQYndRRE5N?=
 =?utf-8?B?VWttdWtMRmdqZmk4UTUvT2dQTXpNcjZhbm5LVFc2MFBicFZJeTlWb1dBYmll?=
 =?utf-8?B?ckxsSkFYUUwvOFFOa0cwSExvZ3RzcExzc3M4MEhmaXhzYVVEZDlaUnBtUm5U?=
 =?utf-8?B?d0xrK1BZQWFxZTYyVjdvVjBibHBZU21OMFg4QU9VSlR2QVdMakFteWlidXE1?=
 =?utf-8?B?T1BmVU9MT3Q4SWFTcXhqc3BxcEoxRzdYbldsQkE0akhFNmxEQ1FxRzZYZXRT?=
 =?utf-8?B?WVJhTlA0NktZNnQxZmNjb0lWZXdCQmdZdU5rbUVRVEpQM0FYRm4yZTZqVll3?=
 =?utf-8?B?Wnh6dFdhZjcwb3pYQjZTbnN5dm9uN3BFY0R2bUpZQXJIaFNoNnZjRmt2QVE1?=
 =?utf-8?B?Y0FxZWRHMnJnUnBZL2U3S3g5bnZidHNPM0RnbXRjcGZGSTJtdWJqVzFGeFBB?=
 =?utf-8?B?RXVBYnlnV2N1aWgwcEQxSzhhQmtpYll6MTcxeTdtUkQvNEJmSEEycnZpd1pW?=
 =?utf-8?B?WHZWMVRiUWNBQmhCWTM2bitWenJYMGl6SWo3MVFuL0RSVk4vUmtuNHFGWTJV?=
 =?utf-8?B?Y0Q0clNYeWtFM0JEQzNPT3ZFb29CZHBxTlpEV3JUeWNiVThZb3c4MmR2Njd5?=
 =?utf-8?B?SHZ2akcraVdOVVZpby9DbjBsL3RMbmNvaUJkYUVpdmtPNFRmRkVIOEYxVmF5?=
 =?utf-8?B?eHNsNEZiamVGUWJhdDJVN3ZLK2Y1S0FLTk45YmF3RlFSY0NvVklVYy95bVZH?=
 =?utf-8?B?UVBFbzdWSjU0NjZCOHExRVZ1U0ZQbW9WTkQ1cHhOMjF0UnRjYTZtaUlqYnh5?=
 =?utf-8?B?b0VCSmlpMy9PRU5Yamh4NnByaXJtTVpLQ1ZyeTFoK3lFZ0ZFZTBBRHoxdnBr?=
 =?utf-8?B?dVdjQ1pOVmhFbUIxcTIyTXBBckVtUzVLNzQrYUR0d3kwNlQ5VWVoODBhWFhw?=
 =?utf-8?B?QzZYMEJpb3RKZ1JYRm9pV25QbWgzN3VEa1B5TFFlZk8yOFdaUUI3YVFYK3Bi?=
 =?utf-8?B?NFZKbmxFNzZlZzErQ1J1TTJVWnVIMHBGRnlkZENKUCtIcUJGS2dpUVJ0VEl6?=
 =?utf-8?B?amplQ1ZZYkhQYzBpRGEzdURQV0hzalJNbzV1N2kybThyTFhyeVBvNEFhaUdm?=
 =?utf-8?Q?9jjxTJ4wzgJReW1IKrWYfGjTo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4734.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097fc7d6-7c12-4fe0-8946-08dc287af429
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 07:52:52.6655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZEHWjiFnuN9M2cwFnZmWu1arHnOY21GM/xJ/f44tnB5Y/MozOb/wg3x1c4xLVAWcFl3UUOPj6VBehQ1ZFaf+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR18MB5633
X-Proofpoint-GUID: 20riXqfxT1juKeBzNA7T7tMwnnj43Vxy
X-Proofpoint-ORIG-GUID: 20riXqfxT1juKeBzNA7T7tMwnnj43Vxy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02

DQoNCkZyb206IEthbGVzaCBBbmFra3VyIFB1cmF5aWwgPGthbGVzaC1hbmFra3VyLnB1cmF5aWxA
YnJvYWRjb20uY29tPiANClNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgNywgMjAyNCAxOjQwIFBN
DQpUbzogU2hpbmFzIFJhc2hlZWQgPHNyYXNoZWVkQG1hcnZlbGwuY29tPg0KQ2M6IG5ldGRldkB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEhhc2VlYiBHYW5p
IDxoZ2FuaUBtYXJ2ZWxsLmNvbT47IFZpbWxlc2ggS3VtYXIgPHZpbWxlc2hrQG1hcnZlbGwuY29t
PjsgU2F0aGVzaCBCIEVkYXJhIDxzZWRhcmFAbWFydmVsbC5jb20+OyBlZ2FsbGVuQHJlZGhhdC5j
b207IG1zY2htaWR0QHJlZGhhdC5jb207IHBhYmVuaUByZWRoYXQuY29tOyBrdWJhQGtlcm5lbC5v
cmc7IGhvcm1zQGtlcm5lbC5vcmc7IHdpemhhb0ByZWRoYXQuY29tOyBraGVpYkByZWRoYXQuY29t
OyBrb25ndXllbkByZWRoYXQuY29tOyBWZWVyYXNlbmFyZWRkeSBCdXJydSA8dmJ1cnJ1QG1hcnZl
bGwuY29tPjsgU2F0YW5hbmRhIEJ1cmxhIDxzYnVybGFAbWFydmVsbC5jb20+OyBEYXZpZCBTLiBN
aWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2ds
ZS5jb20+DQpTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIG5ldC1uZXh0IHY2IDUvOF0gb2N0ZW9u
X2VwX3ZmOiBhZGQgc3VwcG9ydCBmb3IgbmRvIG9wcw0KDQpPbiBXZWQsIEZlYiA3LCAyMDI0IGF0
IDEyOjIz4oCvUE0gU2hpbmFzIFJhc2hlZWQgPG1haWx0bzpzcmFzaGVlZEBtYXJ2ZWxsLmNvbT4g
d3JvdGU6DQpBZGQgc3VwcG9ydCBmb3IgbmRvIG9wcyB0byBzZXQgTUFDIGFkZHJlc3MsIGNoYW5n
ZSBNVFUsIGdldCBzdGF0cy4NCkFkZCBjb250cm9sIHBhdGggc3VwcG9ydCB0byBzZXQgTUFDIGFk
ZHJlc3MsIGNoYW5nZSBNVFUsIGdldCBzdGF0cywNCnNldCBzcGVlZCwgZ2V0IGFuZCBzZXQgbGlu
ayBtb2RlLg0KW0thbGVzaF06IFlvdSBhcmUgYWRkaW5nIHN1cHBvcnQgZm9yIG9ubHkgb25lIG5k
byBob29rICIubmRvX2dldF9zdGF0czY0IiBpbiB0aGlzIHBhdGNoLiBBbSBJIG1pc3Npbmcgc29t
ZXRoaW5nPw0KDQpTaWduZWQtb2ZmLWJ5OiBTaGluYXMgUmFzaGVlZCA8bWFpbHRvOnNyYXNoZWVk
QG1hcnZlbGwuY29tPg0KDQoraW50IG9jdGVwX3ZmX2dldF9pZl9zdGF0cyhzdHJ1Y3Qgb2N0ZXBf
dmZfZGV2aWNlICpvY3QpDQpbS2FsZXNoXTogWW91IG1heSB3YW50IHRvIG1ha2UgdGhpcyBmdW5j
dGlvbiBzdGF0aWMuwqANCg0KVGhpcyBpcyBhbiBpbnRlcmZhY2UgYXBpIHdoaWNoIGlzIHVzZWQg
aW4gcGF0Y2ggWzcvOF0NCg0KK3sNCivCoCDCoCDCoCDCoHN0cnVjdCBvY3RlcF92Zl9pZmFjZV9y
eHR4X3N0YXRzIHZmX3N0YXRzOw0KK8KgIMKgIMKgIMKgaW50IHJldCwgc2l6ZTsNCisNCivCoCDC
oCDCoCDCoG1lbXNldCgmdmZfc3RhdHMsIDAsIHNpemVvZihzdHJ1Y3Qgb2N0ZXBfdmZfaWZhY2Vf
cnh0eF9zdGF0cykpOw0KW0thbGVzaF06IFlvdSBjYW4gYXZvaWQgbWVtc2V0IGJ5IGluaXRpYWxp
emluZyB2Zl9zdGF0cyA9IHt9O8KgDQorwqAgwqAgwqAgwqByZXQgPSBvY3RlcF92Zl9tYm94X2J1
bGtfcmVhZChvY3QsIE9DVEVQX1BGVkZfTUJPWF9DTURfR0VUX1NUQVRTLA0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKHU4ICopJnZmX3N0
YXRzLCAmc2l6ZSk7DQorwqAgwqAgwqAgwqBpZiAoIXJldCkgew0KDQo=

