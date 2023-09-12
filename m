Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B931579DA71
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbjILVB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjILVB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:01:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855DD199;
        Tue, 12 Sep 2023 14:01:53 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CKeA32003187;
        Tue, 12 Sep 2023 21:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=K0r4yot++dDZO6XvG7RhlDWiTuSEQVmLs/Dsuor6mHw=;
 b=QKWYDHpp+YL7GtdtFHH+fOZmJz8oy2nY+IZF9VEEpzNmTt+T0StC1eP0BHHu3VV+fkve
 RWAY+440kEL2FpDKbTtNpfv0OODDKAElOzMk5mlsPgQJkaNsi6kgo9pPmltYnim2O9QB
 J+SszrjeQTSFLJGQ9j2iCmvnOYhC+6Rndg9ML2GiJV5xB8UNwX2RRPkHSFgA8N+HigNb
 MYoPjj5aVR59tFfeYbvPI7etrOtPVJo6OO8LNnLoJnSxKIawLclPERWyDhHhxI+11mYS
 RsbnnZjVLfKBmDY4aC05m7t3RFQqXh7SZPo13AL5d5rNxNOvXjLa/qLSnh5j4k22Rtx/ WA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7r816r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 21:01:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38CJGRTe004452;
        Tue, 12 Sep 2023 21:01:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5733b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 21:01:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSfIyoKoO1p57r5G7YAQTe2ZihkFP+/svWXCEBqDcbYlxmDv29Uu0fpol0qe45NYKDpDDpHcoMk18LZDoshUaMEWshPtKaEG+1lEryqJArb/XwBXSenZOB7Tw+BeuLsazlHG1v9F9L9pYqkAUy5dUQFtBmVAJI1VnWx4oMCxpFwnXkkEDEkGls2fIaTLXKnEmv5HlQwlDZ9aO+gfgNtEE+9VcCbGGsHuX3vsLOwrE/ypi4Yu4Dw3XXPBG11TwzLJIHnBE6skZyrOakscyML841k5yHur7Ub9P6ZKlPt79AAC7lvaD+04m0Mb0LHa4IcN9scRhLT1Hof79OISrxon8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0r4yot++dDZO6XvG7RhlDWiTuSEQVmLs/Dsuor6mHw=;
 b=EascBTc1RBZc3q0CQ0atOoeGWM8LMNf4izcLo8dOAH3EEmIalzsOjUuGBRVz3ekI+ECX59aKCUxBUQDg5EMqg6hgGqexs1wV25R2FBd7jsEw4F2XeAviz6Y+iCWcrSlCGvbK7HvlKx4MaEbYKjiQnhvSEl30u+Xbk3hs3d+984ub4Wsb6PeEzCIFGx0fldIPxCDiBa1wZN/gnyNuhSiAms8/UFwehmM90DG48kkXJKxCbByz6qnpgscMprjmhPVx9bRxLcdfwrvFU5GY1BTKgm7LPPpXZisF2Myjqd58ZDQcUUO2MSuMgELHwl2lZGusS2TVV/s0eAP+drI7/JUJzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0r4yot++dDZO6XvG7RhlDWiTuSEQVmLs/Dsuor6mHw=;
 b=soa1GMj2BnahqVRDzvsKtwDIdb3wvOME1y54l6vr0W9CvLwdNketlry2oJCHmM7KDus6X8wLliIJNIoVLofsnzy7eqPj9zaNCXSPB5qc1Q2MkawvRErGeft9eKDNy9bbKYaJisW+kAvtk/fGJEUsH3pPh25fzkz+x+O7o9SmRwE=
Received: from CO1PR10MB4563.namprd10.prod.outlook.com (2603:10b6:303:92::6)
 by PH7PR10MB6333.namprd10.prod.outlook.com (2603:10b6:510:1b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Tue, 12 Sep
 2023 21:01:48 +0000
Received: from CO1PR10MB4563.namprd10.prod.outlook.com
 ([fe80::33f1:5716:3755:2532]) by CO1PR10MB4563.namprd10.prod.outlook.com
 ([fe80::33f1:5716:3755:2532%7]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 21:01:48 +0000
From:   Gulam Mohamed <gulam.mohamed@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] block: Consider inflight IO in io accounting for high
 latency devices
Thread-Topic: [PATCH] block: Consider inflight IO in io accounting for high
 latency devices
Thread-Index: AQHZ4mGAemae+4E1hEiaQrtjQnB/LrAXq1ZA
Date:   Tue, 12 Sep 2023 21:01:48 +0000
Message-ID: <CO1PR10MB45639869A3F7505302F0113C98F1A@CO1PR10MB4563.namprd10.prod.outlook.com>
References: <20230907214552.130636-1-gulam.mohamed@oracle.com>
 <ae3d6e46-eb4f-48f6-99b5-bd0f6588ffbf@kernel.dk>
In-Reply-To: <ae3d6e46-eb4f-48f6-99b5-bd0f6588ffbf@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR10MB4563:EE_|PH7PR10MB6333:EE_
x-ms-office365-filtering-correlation-id: 80975243-2b44-4dba-1ab7-08dbb3d37af7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p4dNovFsysFtjcME3LzLwXOd84u0hNg34Dd0vhIxFxa8GtASadA0WlwTWXgxdHAd9sqP95KG5WvYILGc4PfNZTkMkaYugJVGyYWeD2L1kIDixUx1NxI1Yn9qhTRBwvpDXB5J255cNwdTnbjHAUI2IwmeTu4iuPXqCHMM3L6FtjQHFMPbwwox0626DKWMMb/Oxj1/aOgShnzvqFoS+WS0ywSFaJqkx14D7QNQl5e0ExXmt2+2ZbX3ekCHkgEiGbbR4yYOr5jLxu7NGUnEgbEFZV63dBBA8QRQDHRiPb8eAVzdY7Rmm4+5L/peu0qoAvrUlm+gRHif03hhCF9+na3N+IbCT+OrjLozLgkPQmPzPDeeGx9q2O6EgrLCDxsbILz1cfZTN9Kf8bcMGtwkMR0biTwdE7hn+B2YF1megloaMI1kMbkIoWTWnqMaCbK27Io+Y5ExODavWW0/aJLzGrf78Q/+sBOBd39B3zvk8TwPWgAs9kzg7pCgldo/IK3ziS56fQ/6yJSxrsaMg4b5VrUbhKl/ox0tkrrtQmRrDOgM/kdPeWCZZSFf/aLwpK+7ZoP6ROiNIXRpEU5V2IqVyiAMA4lx1BA2Nzfa6lz+6FvtidxBLpZJvMopw7aFmTMSdKf4D+B9oyZqjEIq2r++pmiuRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(346002)(366004)(186009)(1800799009)(451199024)(52536014)(41300700001)(316002)(15650500001)(26005)(55016003)(66946007)(110136005)(44832011)(76116006)(66476007)(66556008)(8676002)(66446008)(64756008)(478600001)(8936002)(5660300002)(2906002)(53546011)(6506007)(7696005)(9686003)(71200400001)(86362001)(38100700002)(83380400001)(33656002)(38070700005)(122000001)(309714004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2IwSTdOcnlVdHUxSDAwQ3R4azFQT1l2ckdDd1ZqdVc2NWs4ay9pUXhjQm1Z?=
 =?utf-8?B?bTZFRFlJQWNJTksxbjRISDdHR2xaSlp4dG45U3ZaS0dMczFINHhsR01rclBM?=
 =?utf-8?B?MmNNUHEzNmpvYWladkc1c3hWbGcweGdIZXloSWtpTkZCeE5MaDFDVEtCVk5l?=
 =?utf-8?B?MHQybXFRWWFQbnV0YmV0NzBxeHlrNFdld1l5RTY2S21saEd4YlJrWHJ4WGVj?=
 =?utf-8?B?c0VtRHdkM3dCYVhFZlpLQTV1aENFNnc4WDdobnFsK3RjSUtEZzgzN21oTzFR?=
 =?utf-8?B?SlI5WkJzSVAwb1l2RjltTGUzUUFiOGx1ZXNoV1dXL0pQWlhGeWR4aWZoVVlr?=
 =?utf-8?B?NlhKcThGeDVrYkxVRExNSXBRRW5sdDNiT2ZJWlVxR1lITEVQcnQ3YmpQUlVY?=
 =?utf-8?B?NVBhNi9DQmJVVGljRDh6S3BPUFhCdDlJMm04TDRyZ05ES1hqMEVsblhEOGU5?=
 =?utf-8?B?RGdUdUJzbTN2U0cvQnI3blp0dDgzWTRUK1hHVVlTajh2alZ1N0pOaUlOOTJS?=
 =?utf-8?B?L2taT3pVTWx0eDhvbGVNQml4S0g5QWpOV0JHUXdXYzd0L2FWbHEyYk95VWw1?=
 =?utf-8?B?cGlxbGtHRWxxZnprKzJiOVR2WlBua3ZxNXlFUU5ZaEY5dW1YWGc4dXNsV0FV?=
 =?utf-8?B?QlRRSGcrSnRlbGVhbHZsY1Y2SWZFazlsaVpjWjFPZm9iKzB1R3NLbGNnOGN2?=
 =?utf-8?B?Ym9lTEVYWU52Z1o2TUdYNDRxbzdhSG5Zc3pUanRranMrMUYrbEdxaFhiR1dV?=
 =?utf-8?B?MWRyR3NYR1VOK09WdzExVnRLaXZWcDd3WWJEemwrKytLWVRzMVhMSU1oMno3?=
 =?utf-8?B?ZlhUKy80NkNsYkRRZmEyL3h3MTFOZWU2TS9RanRXdnAzWkNDS3BHRWtweU9j?=
 =?utf-8?B?TjRqc1BKaGVLeXVBcEp0SDZwVVRjeDdVMjd5T2hONThmMndETlhJN0cxMXRo?=
 =?utf-8?B?SUMzcVhFWHN3OUE2S1pjYjJWUHZNM1N2emhkK0MydHVnZDdrcDRxbzZHU3o3?=
 =?utf-8?B?YWVjZ21Yb0N5bGNneStVTGIvNENORWxFSEtlTXp3OUtuQWo4bWlzMWkxVm9R?=
 =?utf-8?B?RW50L2VxSXJqK3pwYStXRW9IMnl5b3o1a2VJaC9IaVIyWDVmbENXK3BwSUNE?=
 =?utf-8?B?dmltVTRpbVBKZTI3WVFRK3pIRE1DNFFRUEJhN0NZaWxNZEQrRkVzcVBrZlpF?=
 =?utf-8?B?a0tUZGNQRmpVYmtJaVJseUNGdXZJeWNPNVRCc0JxOEtndHpWOW5sYUR2Zlpw?=
 =?utf-8?B?R1o3V25zcG5yNG9OYk1CcXV0TUsxVTRTUWVTOFVMRExDbnVwMEVNaGNFVXdH?=
 =?utf-8?B?S2ZVUTIvbGw5L21UVzZFSEJ1Tk90c1U2dkc5QmNxQU0zYXVIQmxlemxKb1NC?=
 =?utf-8?B?R2N4cjMyVm15Yk9VNlVmTjB0aU5lUC9UbTE4N1I1QitZUUJqZjd4N2tUUWEv?=
 =?utf-8?B?Z2RXeENNTENMUFlBdHJiNTdNVWZxVEEvMUV5KzAxOHJLcW5DZEpkRm9YOUps?=
 =?utf-8?B?eS9yREhlTVl1aUE0aFQwcHV5UFZRL1pScHdYT0VvYlh6NWRpWWdzZU5neFhC?=
 =?utf-8?B?dUlwSTdXTFViREY5L3A5UmRoTGUwQVRKbGlVY2c1dS9UQ0IxYldCTnBKWU5q?=
 =?utf-8?B?QllJVlVXREt2bVI0QXdZeUVUR0t6V3JkNHNjS2x0YkFDOEtESFk0UEx5K0py?=
 =?utf-8?B?SWFqRFJaSE1TUEZoMFJHWFFrRDA3TnlZQVkwWUlKZmQ1a3FsUTFPVVBSeHdZ?=
 =?utf-8?B?UkprdWRyNDV3eWdzdDBGZWZ4L0JZWlVmbDlDSTNQSW03ZU5OQno1aUhzYVZZ?=
 =?utf-8?B?MWxUbEQybnpiM3lOdVpZb0IvaDFTbzZ4T3NQU3FOaFgwa0s0L1djQ3AzMUZx?=
 =?utf-8?B?ZGYwdHdGODNMbWhKR1JjbkJ0aUhNN3Vjc2tzQnRaZGIxMjI3cmtpbjBBVktY?=
 =?utf-8?B?UUpYMGt2VWdISFFHMUNWT0wwamh0Q3h2bWpaY3BybS9xR1o2bFV3WVNKQ00r?=
 =?utf-8?B?TTFhWVdlejJtdlFKUExaR3YxN3AyMEZ5YktFbVk4VVlYQUJwaDJzeWtiOWpW?=
 =?utf-8?B?U2FyNUNPSDNrc2N0eDdPWVpiaDBsdTVYV3k5dEQrVnRnUDA4cW9YNkw4TG8z?=
 =?utf-8?Q?2Dm2oUR4BW2z2y/S9shgGlFpW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: N/6RcVPUALz6jemyjbfaAz75t2R9yVyjMXrMv5Z38dpwVKWf0MEqyJe/iVb5QzkMR+UGHYvYz5xCcJYZuAxs+ngqIzt9AkeNX832FfT4zahVgUDBsYlQy3BBRCwZOWtjV4m95fvWZgn5GlWsqZWS/zSt102Z8Hs4dgoHYF4N2JOBkaeAtKejJ1c668J9u65oFRqVPup8Bdt/4MzsBwOUefCqXvQCMhY9N0rggqVJaHRZFRTmywoidYVpJ3fAiiY485z6W22ziMytagWIcfbSEWWvSWb4jqaeiYJAji+tBQDklh5bCjOceXK80ONWv55SoPSU7+XD8vlevLqXCK5YFWWFQuKFsTScvXm8wA+JH9uLV6gICcOj01jgg3T/fr0f35mnzikz1t/SxyDX+H7RL9pkMmwC2gsiCyOpTXs0Rb31IlNyY06/QnilPBDeZZC/d7VmnL/q7qYUYhj7Ey9Buj2iPjfHZ334YWC1TBgBE8nakNNj3qxHrrPUm9lUxpBkjRnHtpVATPcEme79QlRiucZCR7lUq/hSM2TpPfJfOTFKOH7qRMnmP/EyxTUWNQVH65Xe5Efk921ElfomUIsfxhnGBHBvQ5qI8hxJTPp9uKwkxOOFCSgpxSOHIwg9W8GVYUZoKjGCNeB5j1GnR0BKuWwcPh56Kw3eZulNidtDxo3tSuMk56CL4hkNunybz91MGBglNUsGROz0tCzHpAWamcbmUBh4YoZVJNVQB1uiJeXRJhLuIKa6ZzUcsJhn5jZARjJCEODoLfZTfnWIpiwNxlqQSfPJXmS6ipi+LO/3Je4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80975243-2b44-4dba-1ab7-08dbb3d37af7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 21:01:48.5360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TkYOWkoi3OY6QJHG9sMt0ULmPdE3yfQ6yUZzL62UQeOB5m54WvekkvduYpbZfrJbaRmJ755qzmJ493V/SpX/vcD3ZidEE2Li3ge5lG8kmZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6333
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_20,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309120178
X-Proofpoint-ORIG-GUID: 6W_f94DEGAdzHpHcRPI3oSMV5YusfHM-
X-Proofpoint-GUID: 6W_f94DEGAdzHpHcRPI3oSMV5YusfHM-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIEplbnMgZm9yIHJldmlld2luZyB0aGlzIHBhdGNoLiBDYW4geW91IHBsZWFzZSBsb29r
IG15IGNvbW1lbnRzIGlubGluZT8NCg0KUmVnYXJkcywNCkd1bGFtIE1vaGFtZWQuDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPiAN
ClNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDgsIDIwMjMgODowNCBQTQ0KVG86IEd1bGFtIE1vaGFt
ZWQgPGd1bGFtLm1vaGFtZWRAb3JhY2xlLmNvbT47IGxpbnV4LWJsb2NrQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gYmxv
Y2s6IENvbnNpZGVyIGluZmxpZ2h0IElPIGluIGlvIGFjY291bnRpbmcgZm9yIGhpZ2ggbGF0ZW5j
eSBkZXZpY2VzDQoNCk9uIDkvNy8yMyAzOjQ1IFBNLCBHdWxhbSBNb2hhbWVkIHdyb3RlOg0KPiBk
aWZmIC0tZ2l0IGEvYmxvY2svYmxrLW1xLmMgYi9ibG9jay9ibGstbXEuYyBpbmRleCANCj4gZWM5
MjJjNmJjY2JlLi43MGU1NzYzZmI3OTkgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL2Jsay1tcS5jDQo+
ICsrKyBiL2Jsb2NrL2Jsay1tcS5jDQo+IEBAIC0xMDAwLDYgKzEwMDAsOCBAQCBzdGF0aWMgaW5s
aW5lIHZvaWQgYmxrX2FjY291bnRfaW9fZG9uZShzdHJ1Y3QgDQo+IHJlcXVlc3QgKnJlcSwgdTY0
IG5vdykNCj4gIA0KPiAgc3RhdGljIGlubGluZSB2b2lkIGJsa19hY2NvdW50X2lvX3N0YXJ0KHN0
cnVjdCByZXF1ZXN0ICpyZXEpICB7DQo+ICsJYm9vbCBkZWx0YSA9IGZhbHNlOw0KPiArDQoNClRo
aXMgaXMgYW4gb2RkIG5hbWUgZm9yIHRoaXMgdmFyaWFibGUuLi4NCltHVUxBTV06IFRoYW5rcy4g
SSB3aWxsIGNoYW5nZSB0aGlzLg0KDQo+IEBAIC0xMDE1LDcgKzEwMTcsMTAgQEAgc3RhdGljIGlu
bGluZSB2b2lkIGJsa19hY2NvdW50X2lvX3N0YXJ0KHN0cnVjdCByZXF1ZXN0ICpyZXEpDQo+ICAJ
CQlyZXEtPnBhcnQgPSByZXEtPnEtPmRpc2stPnBhcnQwOw0KPiAgDQo+ICAJCXBhcnRfc3RhdF9s
b2NrKCk7DQo+IC0JCXVwZGF0ZV9pb190aWNrcyhyZXEtPnBhcnQsIGppZmZpZXMsIGZhbHNlKTsN
Cj4gKwkJaWYgKHJlcS0+cS0+bnJfaHdfcXVldWVzID09IDEpIHsNCj4gKwkJCWRlbHRhID0gISFw
YXJ0X2luX2ZsaWdodChyZXEtPnBhcnQpOw0KPiArCQl9DQoNCk5vIHBhcmVucyBuZWVkZWQgaGVy
ZS4gQnV0IHRoYXQgYXNpZGUsIEkgdGhpbmsgdGhpcyBjb3VsZCBiZSBhIGxvdCBiZXR0ZXIuIFlv
dSBkb24ndCByZWFsbHkgY2FyZSBhYm91dCB0aGUgbnVtYmVyIG9mIHJlcXVlc3RzIGluZmxpZ2h0
LCBvbmx5IGlmIHRoZXJlIGFyZSBzb21lLiBBIGJldHRlciBoZWxwZXIgdGhhbiBwYXJ0X2luX2Zs
aWdodCgpIGNvdWxkIGRvIHRoYXQgYWxhOg0KDQpzdGF0aWMgYm9vbCBwYXJ0X2FueV9pbl9mbGln
aHQoc3RydWN0IGJsb2NrX2RldmljZSAqcGFydCkgew0KCWludCBjcHU7DQoNCglmb3JfZWFjaF9w
b3NzaWJsZV9jcHUoY3B1KSB7DQoJCWlmIChwYXJ0X3N0YXRfbG9jYWxfcmVhZF9jcHUocGFydCwg
aW5fZmxpZ2h0WzBdLCBjcHUpIHx8DQoJCSAgICBwYXJ0X3N0YXRfbG9jYWxfcmVhZF9jcHUocGFy
dCwgaW5fZmxpZ2h0WzFdLCBjcHUpKQ0KCQkJcmV0dXJuIHRydWU7DQoJfQ0KDQoJcmV0dXJuIGZh
bHNlOw0KfQ0KW0dVTEFNXTogIElzIHRoZXJlIGEgcG9zc2liaWxpdHkgdGhhdCB0aGUgSU8gcmVx
dWVzdCBzdWJtaXQgYW5kIGNvbXBsZXRpb24gY2FuIGhhcHBlbiBvbiBkaWZmZXJlbnQgQ1BVPyBJ
IGFtIHRoaW5raW5nIHRoYXQgdGhlcmUgY291bGQgYmUgcG9zaXRpdmUgbnVtYmVycyBhbmQgbmVn
YXRpdmUgbnVtYmVycyBmcm9tIGRpZmZlcmVudCBDUFVzIHJlc3VsdGluZyBpbiB0b3RhbCBpbmZs
aWdodCB0byAwLiBUaGUgbmVnYXRpdmUgbnVtYmVyIGNvdWxkIGJlIGR1ZSB0byB0aGF0IHRoZSBJ
TyBjb21wbGV0aW9uIGNvdWxkIGhhcHBlbiBvbiBhbm90aGVyIENQVS4NCg0KQnV0IEkgZG8gd29u
ZGVyIGlmIGl0J3MganVzdCBtaXNzZWQgc3RhdGUgY2hlY2tpbmcgZm9yIHRoZSByZXF1ZXN0IGl0
c2VsZiB0aGF0J3MgbWlzc2luZyB0aGlzLCBhbmQgdGhpcyBpcyBmaXhpbmcgaXQgZW50aXJlbHkg
dGhlIHdyb25nIHdheSBhcm91bmQuDQpbR1VMQU1dOiAgVHJ5aW5nIHRvIHVuZGVyc3RhbmQgdGhp
cyBjb21tZW50LiBDYW4geW91IHBsZWFzZSBleHBsb3JlIG1vcmUgb24gdGhpcz8NCg0KLS0NCkpl
bnMgQXhib2UNCg0K
