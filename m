Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6427D851E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345316AbjJZOsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjJZOsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:48:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008E71AB;
        Thu, 26 Oct 2023 07:48:36 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QEfOwd031457;
        Thu, 26 Oct 2023 14:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=ZyBS5bKtGI9o/JSUwXI8tJhrt8iLjp/B0v6KI2svaew=;
 b=H2+Dc6gDiOvL3VYXkfj37nysSieyYbyiEcIcWRcZSgzjOOVPM4cM7sxM5xKSMT2o07ph
 Lpve+nvGeQ1UW5fD8XRN2Dko99e7bIhB/gaxUB2ibjE3UqlMKwZYL5uIZJygWyyJ26wH
 3AZ71jcNzZoB2n564OoX7zgRml76aGdr6LcJm7IIrkd6R/fEkW3sueH3ePu611xcEFvb
 I8nOrDFM/IRVUz/O4OxmshujTo6RAKLHSnWH5weoIRfbrmo+CBqmRQEvtG2qnRu1gQjO
 lUJNejMzQ7vt+IcK5s/hTFyroneC+5BWTVN3NFJEEM3hfaKQgYgnG2rP/oYDXqN2NwlB pg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tysnt99n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 14:48:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C30uq2GYwhsCeE7mU2zKTgrxnyXpPmlR1b8Q3IQynOErhgy8tHu9VH56mqKiyks3NXUdOHo5lT+mjsXm8OrSqzxFmxs++3mLtNHoJaQ6Mg2A4mYzGsr5+LLDF3ZqoFuurNKuhZR4kwLJQr5/g5OUsbEmYRwHQ8J+vhkOW5sFS1JLKl/NfoRlzCPmfyb+Soco0F2D+qm0WBYpGQitXdOkOSqc22oCT3VTVvDqfRiDlBIgM3bn4tlwP3gE4cEt+IwPtc533N5Pwt+G8RY2htEWyqVnuVqnoscErqxXEkHBw9+b7b+SvUYHun6ORpmRMV2Bj+zCGoXmWtbX4szs5BMdVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyBS5bKtGI9o/JSUwXI8tJhrt8iLjp/B0v6KI2svaew=;
 b=UvZ3UmMK0P+1xH9yFQJYXxV63IkZ3Mg/8G9EGMGoIJiSwolGwrgcfdqr03OIU/WncZvyjbjk9e8i4f452jtqjzJT22DzcYwRz1fZaMUEjZXx6fVMiD8mUppup9MLT/h2PskS85yHf+/cDAjxo6Zwk5CbrKhwu2rEx0eWn4km9Ic7ee0vCuRqJDy2U1yK5DLfF9XI6U25wNuyacX4S3AF2kF4u3UsuFfIaDYsdvRW1rMYftPqlmcLk3u1/FPCj+Fkl/mtR2h+n0AYLf0CjT9GmLWau770Ne7y1+yrgVJeolf3mDRGOdoL8Qq5WO7sVsFXzr9oEKMn2f64lardQCkZIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3898.namprd15.prod.outlook.com (2603:10b6:303:43::24)
 by MW4PR15MB4378.namprd15.prod.outlook.com (2603:10b6:303:bf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8; Thu, 26 Oct
 2023 14:48:12 +0000
Received: from MW3PR15MB3898.namprd15.prod.outlook.com
 ([fe80::6b98:b5af:76f4:8825]) by MW3PR15MB3898.namprd15.prod.outlook.com
 ([fe80::6b98:b5af:76f4:8825%6]) with mapi id 15.20.6933.016; Thu, 26 Oct 2023
 14:48:12 +0000
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "eajames@linux.ibm.com" <eajames@linux.ibm.com>,
        "ninad@linux.ibm.com" <ninad@linux.ibm.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] hwmon: (pmbus/max31785) Add delay
 between bus accesses
Thread-Index: AQHaBdvitD8E23Ozmk6mFt+qcR+YWLBbQHqAgACW3wA=
Date:   Thu, 26 Oct 2023 14:48:12 +0000
Message-ID: <25390DC7-E8FF-4706-B241-C45E6DFDF444@us.ibm.com>
References: <20231023180804.3068154-1-lakshmiy@us.ibm.com>
 <bbbf3668-aa7a-4489-85b0-333cf394abe9@roeck-us.net>
In-Reply-To: <bbbf3668-aa7a-4489-85b0-333cf394abe9@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3898:EE_|MW4PR15MB4378:EE_
x-ms-office365-filtering-correlation-id: ebbc8175-25fb-477a-4a6a-08dbd6329461
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gLD8kJPfEfrYTOQR0j/oi9VhHQz7G4aj4C/n95uJtEn1Ep5iPkThr4niXzmWYqa0HMqopMJmmvEyxA3O1aRSCE3PZdCkf4tvYtSfRAaCc+8yzB8rvVvcdmkPfpnZ/pWAQrsRhfhlnrKAbebFcLBYh3FKWbPs2PMCJiJWY20mmdDZf01o/NooMJeUHSKFE1AgX4XT99nRUPaXiTmNMZ7fbMpZOsoyY4E09jWlW8BxYL9MCN1EflcmlGd8G/Cmt40hXyqFvgAL9rXtFb1wRZ+CMA6RdqeLAiE6bcTtHdkcOt8ZOctCSNIFQqGMp3UBsHCB4EPQD6qnMUxSNTGEIOT3GBzTfZgt1MTgWLDVVIRGl6an5L2UugqEZBnyQID9uDLQmLKphZ9+GR+pyo27R1NdlwCWOPGWhpfSPuf5KEoxb6vpovUghD2Xc+bF/2NhxpHTmo7Kc5K2MaDFwsckvh2rsk11ZA5KmYWa9oSUG9YaQA97vYAp4FH/MrtZnomyH+wncDXkZPFGrlav1pdMl5Qcp5RJXuoe1Y+QahXKti7Vx75iKQGJ/zH4YYmKQTt09sX++CL7GnqYopkc8X0tHgxrLh2TJe/XH2Isn26Drs3sIinq5yxFT+Sq1JHmBQxwZEeKPPQn/VNF0ECQBtHdJXLTnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3898.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2616005)(6512007)(41300700001)(122000001)(5660300002)(6486002)(8676002)(4326008)(8936002)(478600001)(66556008)(316002)(6916009)(66946007)(54906003)(64756008)(66446008)(66476007)(76116006)(91956017)(38070700009)(6506007)(71200400001)(86362001)(33656002)(38100700002)(2906002)(4744005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlRtUGxDVmZKcDczbVk1Nk40ZmNvU1I2aEhoVzdwQVdDdzJ1T0ZMQkkyek41?=
 =?utf-8?B?eDI4SXFQSENYQ0dOL0JBUjNqSDIvUmwvbmJxa0VIMTF3a0FKd1pBSXhiajgy?=
 =?utf-8?B?SmVSdWtpWjhDdGF5ZC9iREJ2VGJpSjN2TlRwVElrT1FKZUFYdXRVV0g3c0NZ?=
 =?utf-8?B?ZTdWVXM2Q3drejFzano3NkE5Y1JmZThwelQ2ZkRvNjhpd2lncnhsQ2N4MzJD?=
 =?utf-8?B?VEF2dVNJS1Z4MVNPRlc1L1NuSlFsbDRtVnMzWCtySXhDWVdUQXl3REp6MVBs?=
 =?utf-8?B?ZkpxckJVb21nTGZmLzNVRUIwbFFvbzRpaWRSN2xtOTd0MFVHUGxLMGs2QlJH?=
 =?utf-8?B?TVg3Wkp3dzlLK1c0eks1bXJvbzJ5KzFJWGdmK2hhbHJ2djQ1YTE4NzZzWmJQ?=
 =?utf-8?B?YkFoVmRreGFaNWRweEVWZ1lnc0tDSnV2eWlqSWxDNExIR1lJaFljWEg2OFcr?=
 =?utf-8?B?VlBlRE9oNzBIUU92NlFwTnFTYWliUWZrbUZuak5lZVVqb0hJcDcrT3R3TExt?=
 =?utf-8?B?Qyt0V3FPVGxwUFByY0prRUpBeUdHcDIyUlZCQzFuUTBmcTVmVmIxcS9ZcUxJ?=
 =?utf-8?B?bDFTZ2Q2Nll0TVZ6NGhOM3Z2U3JHOUxJbGJtTWVxZkEydDBEY0hlZnpJUkdk?=
 =?utf-8?B?Z1daeVNicFZCWGVnRDFmN2R3ZTUvSjExOC8zSGllUm8zczhwQnNteUxsRnYv?=
 =?utf-8?B?dXJJeFZ0OUh6NDRKakFSVDNWc29USU4xb0d1WkNza2hkV1MvRDJTSVNUVm11?=
 =?utf-8?B?YVhIWDVPRWlxQUFnV0JFd3N2YnNlb3lPZG4rc3FYWVFGYXhOdU9DSlBiS3pU?=
 =?utf-8?B?aGN4MFdPS0dPdXBBSmNzWDdmUmdSVUlkQWM4WW5LcytYSG4yZ0cvekNGTDli?=
 =?utf-8?B?cStPMjVFeU03SVpZNkZLZ2pKaWxoUmNoczFoMWREOGVndkt0MWpob1QvY1Vz?=
 =?utf-8?B?aWtCcUZtWmRIa2pqZWxVT0txNThvOEVzNzNtMDNpakhJeU1mZjg0M1JPU3py?=
 =?utf-8?B?MkE3QzVqeDN2YURQR1I3SXYycXJESFJiV0xuSmhsMXZhSWdaS3VEY1VKK1d6?=
 =?utf-8?B?eFBNZTNzM1QzRWhJWEtUeTRMMEswUS8yeEVYUGE5OU1UallzK0h4MER3dGli?=
 =?utf-8?B?YjRWVGVmNk5DN3NxbFc5TW15MjQwN0lSbzAyVzRIY2NlMU1IQ3BnK3ZOR0x5?=
 =?utf-8?B?R2lEaE9Ea29kMmtXTEIyMS85K3o5dG45dlpRVUhSRk1oZUkwTXNEY29Fcllz?=
 =?utf-8?B?YjUrYXVMWldGRlBkekVxQkNPM0VOUjF3dnhUcWllbHEza1VUOVpaZHk1bXNi?=
 =?utf-8?B?QzI0M1pScXFXRUhCTk1UMW1VSU93eXFDTXpzWmlZdFdRanpUc3NFSlBCYkdC?=
 =?utf-8?B?cWVxZ1d0NW9UNkJveC8zU1F0ZHZEM0RRSWFySHJteE1jdDhqOVpVN2dRY0Vn?=
 =?utf-8?B?U0w0SkYydS9mTFBkNFBRTFAzN3hvcDh3Y09pQ1pNbUFuNHBHN2d0Yjk0clN1?=
 =?utf-8?B?VlpKbXF1cFhPOVBpRFlLbWZDK3VTbnRIa25IcUVnbHloTW9uZ2Z5WmZwSzg0?=
 =?utf-8?B?MzJVOHF3T3IvdlpkeTAxQkVmc0graVRGRjBwQ1dsUTVZUm0vU0M1TnNOMmho?=
 =?utf-8?B?NVE2QXJIQ3ZOYWxhYUlEY0lIYWdqY2lCcnM5a295Z1BKL0NMbC9CNWxHSzVx?=
 =?utf-8?B?eWRFZTdCN3RSeUV2MDNOZGZtRjRySkhZeEFaM29qTjhFNkR4OFhNZW1PeTQ3?=
 =?utf-8?B?Wm95TlBjdE16NFhvSXhKZm1kMWwzWXJpa29zdXJjSUQrV2JQWkMySmV4Y0J3?=
 =?utf-8?B?aFhKYmQzeUZvZE9QUkp1T1ZONG0xREdGa1NFU1hZdDlWR2g3MnU2SEtyL1N5?=
 =?utf-8?B?bGx0WWI3U2lOSU9WRHBpeUw5WGMySWF2SWZaV0pUZW4rZUMvaDMwU3NUWGJE?=
 =?utf-8?B?b1lsRFJUQ3J4blFvSDQ2SDdvTXNRVnd2bFQzVUhHKzZIdU9JYVM4eFFJMGdL?=
 =?utf-8?B?d05OWUQxY0xHd282Rmo5Z2h1LzNTbzlGcEl1OVhYbnY4aENJU1dDbDljQWVT?=
 =?utf-8?B?YmJPbEk5OXBmLzFMU3ljdWZFNzJnNjJzZVpoMVQ0L09GUlUrU1E5NCt4WVZv?=
 =?utf-8?B?TVZjc2c0elo3cjBUZ21EeklCMmx0ZWkvK1diSjliMjN5TDdKdUxoaVpPcnln?=
 =?utf-8?B?ODZIOEhlVS9UMTZybVR5TVc4NEltR2ZaSEpmNkZ1bXRZSUNPTVFCcnhwWGlq?=
 =?utf-8?B?c0RuSnJYUy9obHMrV25oeGIvcmJBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA9A8B0D1F3DA1458F298CABAD7171F1@namprd15.prod.outlook.com>
X-OriginatorOrg: us.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR15MB3898.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbc8175-25fb-477a-4a6a-08dbd6329461
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 14:48:12.8851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VXdy9Y871K4ZA20koR61LokoB7gkqXWkbh85Nycjpuqd4Sr2OUfTCfZrY2PwPMryKTJc/QOdm3cutsSGe5UbpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4378
X-Proofpoint-GUID: _l0YCTbcC76nzAZSyY0-GXUUs_ntjpoD
X-Proofpoint-ORIG-GUID: _l0YCTbcC76nzAZSyY0-GXUUs_ntjpoD
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
Subject: RE: [PATCH v2] hwmon: (pmbus/max31785) Add delay between bus accesses
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_13,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=515
 clxscore=1011 adultscore=0 suspectscore=0 mlxscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310260127
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91IEd1ZW50ZXIhDQpTaG91bGQgSSBmaXggYW5kIHNlbmQgdGhlIHBhdGNoIGFnYWlu
Pw0KDQrvu79PbiAxMC8yNS8yMywgNzo0OCBQTSwgIkd1ZW50ZXIgUm9lY2siIDxncm9lY2s3QGdt
YWlsLmNvbSA8bWFpbHRvOmdyb2VjazdAZ21haWwuY29tPiBvbiBiZWhhbGYgb2YgbGludXhAcm9l
Y2stdXMubmV0IDxtYWlsdG86bGludXhAcm9lY2stdXMubmV0Pj4gd3JvdGU6DQoNCg0KT24gTW9u
LCBPY3QgMjMsIDIwMjMgYXQgMDE6MDg6MDNQTSAtMDUwMCwgTGFrc2htaSBZYWRsYXBhdGkgd3Jv
dGU6DQo+IENoYW5nZXMgc2luY2UgVjE6DQo+IDEuIENoYW5nZWQgdGhlIG1heDMxNzg1X3dhaXQg
bWFjcm8gdG8gYSBmdW5jdGlvbiwgZm9sbG93aW5nIHRoZSBjb252ZW50aW9ucw0KPiB1c2VkIGlu
IG90aGVyIGRyaXZlcnMgdGhhdCBoYWQgdGhlIHNhbWUgaXNzdWUuDQo+IDIuIENoYW5nZWQgdGhl
IGZ1bmN0aW9uIG5hbWVzIGZyb20gbWF4MzE3ODVfaTJjX3NtYnVzKiB0byBtYXgzMTc4NV9pMmNf
KiBhbmQNCj4gZnJvbSBtYXgzMTc4NV9wbWJ1c18qIHRvIF9tYXgzMTc4NV8qLCBtYWtpbmcgdGhl
bSBtb3JlIGNvbmNpc2UuDQo+IA0KDQoNClBsZWFzZSBjaGVjayBEb2N1bWVudGF0aW9uL3Byb2Nl
c3Mvc3VibWl0dGluZy1wYXRjaGVzLnJzdA0KZm9yIHRoZSBleHBlY3RlZCBwYXRjaCBmb3JtYXQs
IHNwZWNpZmljYWxseSBkZXRhaWxzIG9uIGhvdw0KZGVzY3JpcHRpb24gYW5kIGNoYW5nZSBsb2cg
YXJlIHN1cHBvc2VkIHRvIGxvb2sgbGlrZS4NCg0KDQpHdWVudGVyDQoNCg0KDQo=
