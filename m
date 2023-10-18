Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A19A7CE715
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjJRSo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjJRSo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:44:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2B5114;
        Wed, 18 Oct 2023 11:44:24 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IIZSnq015918;
        Wed, 18 Oct 2023 18:44:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=GKpoudkoVYBcj9rFJZE1sQnpUo21X34DyF2ualcZRPQ=;
 b=eSEMJSo+DIgVOKmjKlz5YlE1yEGFHJRq0XFGCB3DWmnPOrYdo1qQcInqa86FzMcfGw4q
 mZ6cEfjHz5YyvSiUYkc207qCWyxs+BlMCAqGMDjcSAD9D64vwjgSICvxPNUOwkARnRX0
 b4akyGp+eMrzUFc5KZCcj18TCX68bOKPpAc2zyIU+lam3wqgByE3fM+CAKSvv462Pe/o
 ji8/9gP+zzuxU4PnbGJfa5cOT5hLaQVB9xiW60t3wQd4dXi842TTU4r7EGEPHPCzsRLq
 Ysmj/uwQm5k0WDoRLZEKGmLT1cLSKCVd6nIUo+k3A/FLs3y+ElGUpLXLllE6bhsaCas+ 0g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1cgetb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 18:44:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39IIeH7O028411;
        Wed, 18 Oct 2023 18:44:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trfy5egnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 18:44:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azYIN4nuIHETd3CYbrynWfsRR9DvpuW26v1HtUJ1smEJp8qI2c9UNhLskAJdoTvS/6M035f4zMk3YQCeZFbdECGocy78yRNLbalbtAY8TNUMokOhcLMzSZNW4l/7uTimOrJHNx7wNonjTc8l6+f52DrX0kMX97uIgtonCwSErBrfmWvECISFuhmSngHT+TGsrTj0s3wX1N3m+w8OZg6H3Sbnu5nmQgngxT1V4ovuQ99RMM7iqaFFQPFJWANN0e38M/veP9Fb/a6b8R692rmfNko9gV97mPiifWUH4lMxyDvw7WCtcRw/1UVCGM57mbr4rbf4FeoLbClRnmjKCd6YVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKpoudkoVYBcj9rFJZE1sQnpUo21X34DyF2ualcZRPQ=;
 b=O1Ay5i6aGmXbFaTf712hxobccaKQ1mmYnQ+IIv7WKG9Ysbr+LbPVgzxipqMopmgksdpQ/hqXb3YofOHc+d2TapA2cBgH5OEOUFiHKIxuW3y+l3lG4RXIjAhZZWWv0QgUiXPpw5i4lYLpIQPxVm2KmYBt5//vwcD6TpJ40W3pIAwyxbZyhaOJZPmx+xV0EJmDi6ugKAr5PsLKYW58HQt1FfIXEbO5EjOgHF9UD+3RBm6t4iepeJM4tbQd0MDYGDB8wosOtRpmGcn1SDNHrcGAK19X+IVNNYYquyxR5dBzrowH3Jwu8GQi+N5oyd0m+iJ79W9YR9CZVrvzOxjVlFfwbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKpoudkoVYBcj9rFJZE1sQnpUo21X34DyF2ualcZRPQ=;
 b=h+dGUHPV5eJ4kE1Cxp4GABK3bP7NZ4Sa8gf3tbxI/WafFsJJaTUU81Z0Ns2xI4DVAx8tz3XMaguxC9NWTSetDoW0481tZ323jd6lTziyYVlFHwqpSfoMTUirfdlrVJtiPiulh3c6IOf7wMW53TwUjJVDtuxVPv0/zSmV2nZRMuk=
Received: from CO1PR10MB4563.namprd10.prod.outlook.com (2603:10b6:303:92::6)
 by PH7PR10MB7105.namprd10.prod.outlook.com (2603:10b6:510:27f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.40; Wed, 18 Oct
 2023 18:44:18 +0000
Received: from CO1PR10MB4563.namprd10.prod.outlook.com
 ([fe80::b0e5:a37e:64a0:6866]) by CO1PR10MB4563.namprd10.prod.outlook.com
 ([fe80::b0e5:a37e:64a0:6866%6]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 18:44:17 +0000
From:   Gulam Mohamed <gulam.mohamed@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] Consider inflight IO in io accounting for high latency
 devices
Thread-Topic: [PATCH V2] Consider inflight IO in io accounting for high
 latency devices
Thread-Index: AQHZ/hoaiR7GZT8ggkid9oX8ZtKxUrBM2pawgAAVLICAAHNRMIAAq74AgAHbHvA=
Date:   Wed, 18 Oct 2023 18:44:17 +0000
Message-ID: <CO1PR10MB4563F2D918EF5BBAD98FC87098D5A@CO1PR10MB4563.namprd10.prod.outlook.com>
References: <20231013195559.1306345-1-gulam.mohamed@oracle.com>
 <35e3e173-8018-42d8-a6e8-7ba994ff6b17@acm.org>
 <CO1PR10MB4563B1B650C89FA32B60AE1298D7A@CO1PR10MB4563.namprd10.prod.outlook.com>
 <d10c329b-85c9-4bc2-be00-f156c48639e5@acm.org>
 <CO1PR10MB4563AA8AE670E9EDBF3AF32B98D6A@CO1PR10MB4563.namprd10.prod.outlook.com>
 <8f239910-af73-4363-abca-d35c5d6d3216@kernel.dk>
In-Reply-To: <8f239910-af73-4363-abca-d35c5d6d3216@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR10MB4563:EE_|PH7PR10MB7105:EE_
x-ms-office365-filtering-correlation-id: 6c2f6c26-2af1-4dcb-7c25-08dbd00a3c02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BZRowOBzKyXsVIHMeC3LngAwAS6Eib4vynUIMjh8UzMgF4BI6KjTQ/LPEVh2j0awb6A7/xsXVEuvjvMboikbDPjrlrqrDN19a/vRvIE2D7ICeMf3wlzHZOLWG0yFvDy6/dteNcUcBP8uocKAwx3AMaXvZFWuj7zxhQ249JyGOQeqYcJLNrppUxQ7DDKNFZZQl+1JxY1QaXy/a2sYztliNaq27X2SsdXrTyQ194OP7gwWkUDu1GkqncO5+R0zmi0yhdU9CWQPYApBsRrrnLc2952pvU7yWGHNhMmguKhdC5Ztfp3nMVUPE1AXGnfZ1cNaW3cSRgHAIq8awRfmFZnCFMaAz/OU6xeYilTg5fwU97U36EvLzmlVt1bvlqSvurVkRYXbRtUxRFbxZSKpMBhODepjGvZvSKIkGENgdPY5gvhpHZynOw7B66TXouoMcjSM4i3XC6hQ36q7zf8fUrl3WnCUjeFr9KULP7yGITjUuqhGBnscOYgZ3D0gtXXYip5qdw6lYX3EZhJbG/zWoudAR3dpWE6ufWwXnrPevDA9gBMWGjBuRtmaZxn5DBXqA3Mxhfx87Ag3mEW/OYyxm37694AR3KiYCo5kubCJ7Ok+KGN9eAcXjv8fjQrLz+ylKgBx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(83380400001)(38100700002)(55016003)(9686003)(38070700005)(122000001)(41300700001)(15650500001)(316002)(2906002)(86362001)(110136005)(66446008)(66556008)(66946007)(66476007)(76116006)(5660300002)(8936002)(52536014)(8676002)(64756008)(478600001)(6506007)(7696005)(71200400001)(33656002)(53546011)(44832011)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzhDVlA2Wm53RDkxaWVuVS9OWTlrRjdtbmFCcHJGa0VDRlI5M3ZqM25Vdmp3?=
 =?utf-8?B?YWtncUdHbjRxcWljb0F0bnNWRzJ2dG5tQWVkKzVPSGx3Q0VzM1lxdjJzSGNr?=
 =?utf-8?B?UndpdTlxUXBMN25INVZoajFtNXNDbE9FQmoybnFWemZDVnIyTjdmaTFwSWE2?=
 =?utf-8?B?OG12dElFUTJzYjlhRk9BMlkyVXZiQ1NUclhaa3lGbFJ1Mkx5WC9JcEVYMElK?=
 =?utf-8?B?Z2F0dFFiSnorYmhpUFBrRGhlZDZGTVdIZ3ZJTEd6Vm9Xb3ZFQm9Zbld0dk8v?=
 =?utf-8?B?Qnp3UjcwVFNCangyZWJLZk8vK0h0S1JVOHpySDl3ZU0zVUd6SW51RHlodVUz?=
 =?utf-8?B?SWtYU3lrODArS0E5SEJLaFhVNGZmUm01TjlYdDRxcHNmQzliTHJLWUtBQ2VW?=
 =?utf-8?B?cWh3MDBMazJyOXZNY2pCbXVCNW1MM3MwL09jdHl1OFI1b1NnL1lBb0w4NnFs?=
 =?utf-8?B?MjRDeGxpVU5aak5oZnB0NU4wWkJDTWllS0VyVmhteWwwYzVBVW9UTm5TQjFO?=
 =?utf-8?B?MDFIZnNRY1RhY2d3ZTFCUWZSeXJkQW1ib1k2WGxNa1ljcTE4MWx5M0Y3MEY0?=
 =?utf-8?B?M0dBcXhrcHdnWkRDNy9aV0ZXb0ZyTCsza1MwQlg0WnE1cUZURzAvTEhnWTBB?=
 =?utf-8?B?YmxrYTREeTNZbDg5YWRqbHBtZGJaT2EzMVZMc2lSUlh6ekZWc2JTZ1JqWHFh?=
 =?utf-8?B?WGVsZW5aWGduOHBmMFhaNHJjZXZ2NndVWkJVbTVLREsvZ0ZpY2NKR1h4YVNJ?=
 =?utf-8?B?VGxjeUIxTW02dnVPaTJtVFB4TkpvVUM4cFRGamNiSVVoTURPeHZXK01zMEJX?=
 =?utf-8?B?RmJlTHl3YWNHR0J2aDlVaTREVWVoa1RCV0pXOFpZYTNmTTRMQUpsTFVoN3B0?=
 =?utf-8?B?SjA0c2dNdjc1bWdYR0Jkc3AvYVVhakxsckpHTjhGejFpTG1UbmV1WkZDYjBP?=
 =?utf-8?B?NWpINUtsNlNGaTV4QXlTM1o4QnZWOVRuVGptN1dIYVNqbTI0dW9iekJKTGxV?=
 =?utf-8?B?YXlNTDE3YURXUFVPVlpXM0hNNEJuMWN2OEEySlpoN2dvYnFZc1pXV3dhZ0xK?=
 =?utf-8?B?V09PYnhGbkRTcnFTRmpHemxSa3BhTkFNMW1GNDJRUkhTV0FBc3h1WjRZMXRM?=
 =?utf-8?B?cm1GVnJqYVhQcDBjQUJrTG8ydE1uZ3hFTS9SSnlSVW5pcUQ4UnpCcTBnc3E2?=
 =?utf-8?B?ZVRBMmdZVExhSVpYUHhoT2FRNFhOT1EydHAyTGUyMy9TOTdPQUtoeERFRXB4?=
 =?utf-8?B?ajhEc1lkejJxNmpDc05uV1grRGJHTG1XSW5SdGgwcWhCcGlRYlQybVRTWUlL?=
 =?utf-8?B?ckRaV0hHZVhFamJDNi9jbEdJNU9ISXEwVmZQOGtpVVgwdnZKQStic0ljR20x?=
 =?utf-8?B?aS9lbVMvb1IzK2lhaXc0Wis2bVFXaEFmR0RmZmp1eTlVOHVKY0RPak1LWVdn?=
 =?utf-8?B?bWRET0UvS2h0VnJOQjZRR3JkS3U0dVVIaWNQWDhndnUxc3lYVGVVcFpBKzcv?=
 =?utf-8?B?eFBqd2xsZnUya1ZyUkJnQUZwbEhTOEUzc1NLUjBHS0F1VzFXcHFnNlQwcGhm?=
 =?utf-8?B?NTFoeWNpbERWVENhSUVpUVBLSVkvbFJIUVR0TlBhUXlkQ2w3QXllU1NEb2xH?=
 =?utf-8?B?dmNSdnRqL2JMSmVCNllkb1RaTWMvM01leUcrS1JlbDcyZmFGSHhuNTgxME8w?=
 =?utf-8?B?T1FNak15WGhrWVk1dWxxVVQ2YUtZaDI4R09TVGhieUhCL0JvaG02U2U1TEFk?=
 =?utf-8?B?R1ZSQUpxM1JLb2pLN0NIblVtR3BiUTh5OGJLR0pMSGhwc1c4QStzU1B4UmxX?=
 =?utf-8?B?RXZ6OG1OTnNhQ3YyRzZIZXNJQVoyQmV5QS9aRDZGRGlSNktxcEJLNUYxZ3lx?=
 =?utf-8?B?TkJuejN5emxBUmlhaUlZR3JXY1RsZncyZkFtSTlFeG1ITEJaa0psSEtSeFd5?=
 =?utf-8?B?YlllQ3piR0FaRGloSjRHbEdaa2RoUXBwRUswampxRkNqSW94elFRZzg3bnFF?=
 =?utf-8?B?Y2JVTElPRm9YWThsVlIwNGdtdm1DUVQyc3FnRWlHZ3E4THM3M0VHbzJkeFAr?=
 =?utf-8?B?amNGbUtPTFo4dVlIcHNHZVRINEJDZ1pmRldROGJOdm03Zlhxanc1MGxRSGta?=
 =?utf-8?Q?S/ClISXGWKVV85WAJIE3Ampwx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +h0sj4A16q6Tdi8+OBiB6E80QDKBNt8S4B5VbaK41x1In2raj6Uyp4BxcnZjgB8YYjLNUXPi7Vzh8bJgquGmmTiK0Esmn6UyQlo4ZVtz7i6dGOPiAOHCt3uvfuDSD8hh5G1Ia9OGwX8bjqkRB5n7zW2c7AqJSmd/ue0B+pB72ENm7Gs+L/qtS+Rqpndm7xZgRgI0U2UW+jLs3dg+Fc3wbZ7WD0eQ5PQwVIFjcmVVTvn0f5dMVd5tuhy3osjG/jak4s3XnnBRsL+JhozZ0HErZjSqViCm54q5e24Pg9CkEtn7LtE9UBTih+PLqfJsJpBscN6pgcy0zckkeJdfY24yRyWI0r9bLq1xQ/T+OeKbt3SNBFUI8B/J0eQEPswppMs9lNT4s+DtJE4NiPi5SMOZM5a+ybt9pZ+NLbiztckd4um5yLtkWh8E7l7poEInO+EAyEtltT3NF2ozruZGcDmh6FdTcnZrMuv7xEWYYGO4dnOufBrBHC+bYomzfLEr0orSJUe191WYuhVu5HAoMNE32byPhPepZvY6hkiAcSOi7KpJ+CqjvX69QLkr1ZtyUnlz2Gi77p8/II2iOlP57pthzwYANvUQ1JHYa3C2qD0F4eTF9YjXOVe+VYVGfyHmasWPuhT3UdIOIeTO1b2AHDRyo2A4YSfQDWoxzbIOZE7WPCTfPxw7GNclL+6wG/UJo7WuUOMW5ew/PC/z6pBzqtHYDRUfFjaaUGZr2IFdju1FWko7mF8L3HOE51grmZdqqWQeVZmttVyT+UY6FTmNSzdX9Ht3/dgSfEnyb4A1wyHDgAn5vnwNPHNzvODh0MmsCbP+
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2f6c26-2af1-4dcb-7c25-08dbd00a3c02
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 18:44:17.7965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I06AWlCeVVW3RRN2PuaDeeTwG6pIXTv+xCcHe8HTa4Fo/VetPWUIe2jHm65hBEJhrsmlmAvIdAlx6rRQ4O+0upreM/Y5CglBzW2MxG1dQYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7105
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_17,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180152
X-Proofpoint-ORIG-GUID: 6zaW30koDjxu6fhstAUpLs9NS-43kP_6
X-Proofpoint-GUID: 6zaW30koDjxu6fhstAUpLs9NS-43kP_6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5l
bC5kaz4gDQpTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDE3LCAyMDIzIDc6NTQgUE0NClRvOiBHdWxh
bSBNb2hhbWVkIDxndWxhbS5tb2hhbWVkQG9yYWNsZS5jb20+OyBCYXJ0IFZhbiBBc3NjaGUgPGJ2
YW5hc3NjaGVAYWNtLm9yZz47IGxpbnV4LWJsb2NrQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCBWMl0gQ29uc2lkZXIgaW5m
bGlnaHQgSU8gaW4gaW8gYWNjb3VudGluZyBmb3IgaGlnaCBsYXRlbmN5IGRldmljZXMNCg0KT24g
MTAvMTYvMjMgMTA6MTMgUE0sIEd1bGFtIE1vaGFtZWQgd3JvdGU6DQo+IEhpIEJhcnQsDQo+IA0K
PiBUaGFua3MgZm9yIHRoZSByZXZpZXcuIEkgYWdyZWUsIGZvciBsb3cgbGF0ZW5jeSBkZXZpY2Vz
IGlmIHRoZXkgaGF2ZSANCj4gc2luZ2xlIGhhcmR3YXJlIHF1ZXVlLCB0aGlzIHBhdGNoIHdpbGwg
aGF2ZSBzaWduaWZpY2FudCBpbXBhY3QuIENhbiANCj4geW91IHBsZWFzZSBsZXQgbWUga25vdyBh
Ym91dCB3aGF0IGtpbmQgb2YgbG93IGxhdGVuY3kgZGV2aWNlcyB3aWxsIA0KPiBoYXZlIGEgc2lu
Z2xlIHF1ZXVlIChqdXN0IGZvciBteSBrbm93bGVkZ2UpPyBBbHNvIEkgd291bGQgYmUgZ3JhdGVm
dWwgDQo+IGlmIHlvdSBoYXZlIGFueSBzdWdnZXN0aW9ucyB0byBmaXggdGhpcyBpc3N1ZT8NCg0K
SSBtZW50aW9uZWQgdGhpcyBsYXN0IHRpbWUsIEknbGwgZG8gaXQgYWdhaW4gLSBwbGVhc2UgZm9s
bG93IG5vcm1hbCBtYWlsaW5nIGxpc3QgZXRpcXVldHRlLiBEb24ndCB0b3AgcG9zdCwgYW5kIGRv
bid0IGRvIHRob3NlIHVucmVhZGFibGUvdW5xdW90YWJsZSAic2VlIHJlcGxpZXMgaW5saW5lIi4N
Cg0KQXMgSSB0b2xkIHlvdSBsYXN0IHRpbWUgYXMgd2VsbCwgdGhlIHByb2JsZW0gd2l0aCB0aGUg
YXBwcm9hY2ggaXMgZXhhY3RseSBhcyBCYXJ0IHNheXMgLSBpdCdzIGV4cGVuc2l2ZS4gQmVjYXVz
ZSBpdCdzIGV4cGVuc2l2ZSwgeW91IGxpbWl0IHRoZSBmaXggdG8gc2luZ2xlIHF1ZXVlIGRldmlj
ZXMgYW5kIHRoZW4gaG9wZSB0aGF0IHRoaXMgaXMgZmluZSBiZWNhdXNlIG9mIHNvbWUgaWxsIHBl
cmNlaXZlZCBub3Rpb24gdGhhdCBzaW5nbGUgcXVldWUgZGV2aWNlcyBtdXN0IGJlIHNsb3csIGFu
ZCBoZW5jZSB0aGlzIGlzbid0IGEgYmlnIHByb2JsZW0uIEJ1dCB0aGlzIGJvdGggbWlzc2VzIHRo
ZSBmYWN0IHRoYXQgeW91IGNvdWxkIHZlcnkgd2VsbCBoYXZlIHNpbmdsZSBxdWV1ZSBkZXZpY2Vz
IHRoYXQgYXJlIG11Y2ggZmFzdGVyIHRoYW4gdGhlIG9uZSB5b3UgdXNlZCB0byB0ZXN0IHdpdGgu
IFRob3NlIGRvIGV4aXN0Lg0KDQpUaGlzIGRvZXNuJ3QgZXZlbiBhZGRyZXNzIHRoZSBmYWN0IHRo
YXQgcHJlc3VtYWJseSB0aGlzIHByb2JsZW0gaXNuJ3Qgc3BlY2lmaWMgdG8gc2luZ2xlIHF1ZXVl
IGRldmljZXMgYXQgYWxsLiBZb3UgbWF5IG9ubHkgY2FyZSBhYm91dCB0aG9zZSwgYnV0IGFzIGEg
Zml4LCBpdCdzIGxhY2tpbmcgYXMgaXQgZG9lc24ndCBhcHBseSB0byBkZXZpY2VzIGFjcm9zcyB0
aGUgYm9hcmQuDQoNCltHVUxBTV06IFRoYW5rcyBKZW5zIGZvciB0aGUgY29tbWVudHMuIEkgdGhv
dWdodCB0aGF0IG1vc3Qgb2YgdGhlIGZhc3RlciBkZXZpY2VzIHdpbGwgaGF2ZSBtb3JlIHRoYW4g
MSBxdWV1ZS4gU29ycnkgZm9yIHRoYXQgbWlzaW50ZXJwcmV0YXRpb24uIE5vdyBJIHVuZGVyc3Rv
b2QgdGhlIGlzc3VlIHdpdGggdGhlIGZpeCBoZXJlLg0KSSB3YXMgdHJ5aW5nIHRvIHVuZGVyc3Rh
bmQgaG93IHRvIGZpeCB0aGlzIGlzc3VlLiBDYW4geW91IHBsZWFzZSBwcm92aWRlIHlvdXIgc3Vn
Z2VzdGlvbnM/DQoNCi0tDQpKZW5zIEF4Ym9lDQoNCg==
