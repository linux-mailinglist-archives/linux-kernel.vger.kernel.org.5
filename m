Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05A07D8BA0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 00:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344937AbjJZWWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 18:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjJZWWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 18:22:50 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED3191;
        Thu, 26 Oct 2023 15:22:46 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QMFUXg012061;
        Thu, 26 Oct 2023 22:22:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=BimMw2mT5JYHFQlck9hqdTNXqV87pMX+ghIR8qjdklQ=;
 b=d9UndpQK4QHM10XHm/GaAzz5celmaJJ4sGzqq3+FQ9+5jcRmU2D5QTSicccvpOqwuxTT
 fzABG+dhLyAGkqZIqG2U7PphdxUn/lqtKpUNHMUWuaQeh7vGE1j09qYo2LUzGpSYp+YW
 ghkg4cMvL4TWURFSjnBZdgkQwDLdAA7nQqgSYLzHKhj/SAd7ln7Z7Orx9+U9BXwXIzR5
 xZ9DUAv8rIqrE57oCdf0UZqTqJ2SVhpHJOTleuWpiZbL2snZ4bHgInzM0kZwHucmgU9R
 ef7obQX8fKwLzmd0pz5mFp6FImdKaP+FURmnm7sFPeKccrF3YURESShAlhgCnXz4pNEH JA== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u00rd872p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 22:22:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTF+9hDZwje+YGcfJZiu6BNvIM8eypaeNGfnn3OLPJa6aY4OXWz6i7WASZkqGY6m7Yv3BL+rNzqogoo+sAk0yH36M10fg/UlNzqktWfxUyUxExxJWi+/hQ2A9vqD2BzT1JOYqidRR9GFz9YyQRJJMlJt7pSZsUVa8i0+o0Ehf6Xg5HeYYjV+2+NLinphLYJh4X4kLyZgAGRhF6Pl+zr+M0QAOhw4Qi0rl327SUswkdYrSQMgwx2Y4DTpLZDdX0hT3LKK8SD55NUv+02F8KqsvtwYeFk2Mzj8yAaZxwKae1XT6bLR6pDG7YLp98s+7O8WQakl6p4u3Esj+sGFH2EhkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BimMw2mT5JYHFQlck9hqdTNXqV87pMX+ghIR8qjdklQ=;
 b=Mpu/7ianwIhHteQDNfYBEeo6JADPSsuLF0hQPDaKciPWr0bdbipLPU23yHRS0F2gn1FTN3+8+m61oDzMrLsJX5zY91cQGsNx33OstFaCe5Z6PHkysO+6L8ZnAqEtnUJ2cXaKJSbpkl4zDY+VQa+kU43EX+Ce4DEBTdVJcVQ2cim6tlXSQD9suEH3yDuPU8sBCApU+QFq2Z1w/e2KfaXxFmAj+M4cHJbmBit60VqqbQexmoO8GJcf4wUgxGQGWuS85y9nZI3mvpe9jAEwphBI5d6JF5sVshLfoX48y+i6h4tpFItQIA19HzHkyPS7rEue3bLQAbUhdVUQZXRf7B2KoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3898.namprd15.prod.outlook.com (2603:10b6:303:43::24)
 by SA1PR15MB6398.namprd15.prod.outlook.com (2603:10b6:806:3a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.14; Thu, 26 Oct
 2023 22:22:25 +0000
Received: from MW3PR15MB3898.namprd15.prod.outlook.com
 ([fe80::6b98:b5af:76f4:8825]) by MW3PR15MB3898.namprd15.prod.outlook.com
 ([fe80::6b98:b5af:76f4:8825%6]) with mapi id 15.20.6933.016; Thu, 26 Oct 2023
 22:22:24 +0000
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "eajames@linux.ibm.com" <eajames@linux.ibm.com>,
        "ninad@linux.ibm.com" <ninad@linux.ibm.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v3] hwmon: (pmbus/max31785) Add delay
 between bus accesses
Thread-Index: AQHaCFI+nUbWUZpaBUaECGLr4r09erBcmbGA//+3ogA=
Date:   Thu, 26 Oct 2023 22:22:24 +0000
Message-ID: <90705251-9B87-43A1-83C3-8B703CA847FD@us.ibm.com>
References: <20231026212009.1555534-1-lakshmiy@us.ibm.com>
 <d9f31043-38a1-475a-8d84-6c2ff06c5922@roeck-us.net>
In-Reply-To: <d9f31043-38a1-475a-8d84-6c2ff06c5922@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3898:EE_|SA1PR15MB6398:EE_
x-ms-office365-filtering-correlation-id: 4a85e289-395d-446e-9cd5-08dbd67207c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bWj9DDAHlCMgdr85pH02DQSDHFhCSAwV1m575fZOqQ+qTf5TwSgSZZOCpbqmX45gzlDxMgoYO7h0fNdiFPti9vIYzR3vgWly1h7sKVCcSSGXL7HwbpUQursDcSlJznY60YaxtyfE+v4ar1tUBax+3suWgGAzINH8GCWYVPFsskVhUiWeR7lGeVjQiO56vCIZ8IE6VqJl60jH0vwEQRkDy2IUGy2yM85vCqhnFXcTcZvZJfIcnkX2iMKI9Orml0zseoKbpl1tninTK/IAeMbxec0FJE7v5OTYxSCQwunqPJRguQRElciNSonX5mWSLfD3oJaIcwpSqBvX2ZIO6fT1bYIXUnYpKLJE1l4bLUou8kqFpZQArZBEhcrRyefhfX//UlZiS9GS77nW9G4yJr6AWh75snJqLfPSrt6ns9cTXBNowxUHJVU7Dm9py2c0BVAPT8bYVWPbCASxuJm1cbNsWpd/aUnz/dutBMeIOfjsNbe7CsFRP/5/Zz2RY1hWN0iiX+H6udmcjR1gtOtzOogE18RvabjRc7l+2HG3U6Ux64LpFHZk8SH4x97Tr8FiKDs4iTiuD67Ls84KnxUKcjbvElnoPetP3/kTodbJCJFqRFcmaMDNL6qvqQBsKsXlOLTOhg9Nt01qdwn5RTki37TaEFLx4jbZ0HTnKlaKdqcH92eb5bnrcMNbyXXR+yIZLMKs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3898.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(396003)(346002)(230173577357003)(230273577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(8676002)(8936002)(41300700001)(4326008)(38070700009)(2906002)(5660300002)(71200400001)(122000001)(6506007)(6512007)(83380400001)(2616005)(66946007)(38100700002)(91956017)(76116006)(86362001)(33656002)(54906003)(316002)(66556008)(6486002)(6916009)(66446008)(66476007)(478600001)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTFiQTc2TjBkWGh1UENSOUg3cmxjRkh3dWZWN2VxUVZkb3BZVXlmb3poeFlY?=
 =?utf-8?B?NXppSWQvTy9HcEZBUlZLWm5QYXdCMlE1SkZvQU0raDlMY0xTVlBpeVR5MGto?=
 =?utf-8?B?d1BlYnA2Qzh1VVFFeG1BdHI1VUNRR2F0V240ZmVDLzJhM3BjYkxjQ3JYMkJN?=
 =?utf-8?B?NjYwRmFqa0MxYzRHeFJ6cThhdVJPdERXZzR1QmtzOU1rRTdTbVlrd3E1T2Qw?=
 =?utf-8?B?THY1aWxUejJqcWlsZ3B6SzFEZytKL1ZHM24xMERxdGNoWnBmcW1qOWxrWVND?=
 =?utf-8?B?aktFQVdmOVVMdTdlSENlbEV6YnQ1bFhNNW9VbU5YSmhmSTFhRmlNV2lMdUVP?=
 =?utf-8?B?NkFvb0hnNmgxcFd4L1VXR3hka0dmWXVmRThQbVBSVXlWcXJGak9nbXJrbklD?=
 =?utf-8?B?V0Y5MFd3NWZRYnNzMnhEM3E2aHVUVkZpWmR2MXovNW1BOC9IK3cvSlRueGNr?=
 =?utf-8?B?THdnbXAyb1VNU2dRbnh1WjV1ODRoQ2lIV2EzK3VBN2pLM2dPRHBvbHkyWTNp?=
 =?utf-8?B?S1d3akp3NjlWcDNDK1VkK1VxMWIybUREcUpGRi95bDB5L3RjdFRpVS9vaGF1?=
 =?utf-8?B?YU9YRU4wTlcwN0hMU25aN0NUdklSZzhYUHJGVUU3aWFxOGMwcFc2dlZiQVdi?=
 =?utf-8?B?RHJhMjNqcWdYQjhvSGhKMVB1SXJqRDJzQjVLRXRrZmtWcTM3aURNZjdJVXo0?=
 =?utf-8?B?SkpQSkhEdjQ5YjdybDJkRE11eDYzOHplODZpRmpPdnlSczI4a3JvNXh2NzV3?=
 =?utf-8?B?MEljK0Z5b2UrRWZtaWgwMlp4d3ZHS2xkOGRPSm81QjBtV1ZkdlIyNmxFZHVK?=
 =?utf-8?B?c1BzSVJlZHZ1amEyQlhwb21EYVNWMzF0VHVXV2E2NlNzR20zdFNGOGV2Yjkw?=
 =?utf-8?B?b1BmU0EyZGRycFBZbCsxSWtEUHFGVDB4Q3lEcXFDQmZHV0hzYkJoV1A5OE54?=
 =?utf-8?B?RXUyNEQ0Sm5SK0VyNDlrZzBnQkhNMHZtcEY2a2lkQzNMVmMrUDh0MmZsQzBJ?=
 =?utf-8?B?RnRWTEVycGJLVHIzUXVxYVpoRUdadGo1VjdBRno3RkFQeTZTdlB2RXdkQm9w?=
 =?utf-8?B?NElrNHV6RStrTkJSKys1Nllmb0xnbkZuLy9aRXJwZWU4dWNTRksva2p1ZzM2?=
 =?utf-8?B?N3lTSUhPWUltVlVGeUZNL0IvUlFoRWlIbDgvRHZqemV6NmZiUFdyRVQraDZ3?=
 =?utf-8?B?cmJrZHFZaTJwSEhaUzhDUVZxdllkcHFVLzBNbXJLWDlIa3F1T29yemlWTjZE?=
 =?utf-8?B?N0YzWEFzRjBOWnF1WkxTK0IwWGFjMjBhQUlpcmM3eXlLVGtLZkZsYVB3WEli?=
 =?utf-8?B?YVQxbFFCR1h2VXhzV1dqRWpwa3hzMUszU2ZFOHcwK3BtTjIvWkZCbzl3RHIr?=
 =?utf-8?B?a3RnUnhFOXlpNWxEOURzeHFaUXdDRjJBSkZ2Z21jczF4WHc5c3RRK1o5MEsv?=
 =?utf-8?B?YVZQbVRtazFacXdJbFhSL2cwSnpCYy84RVB0WDFhUENyTE9pRXM1T1NQNUtC?=
 =?utf-8?B?RXFNeG1tU1puKzA2NHRPcjVlaU1iN3pCbVIyemZaTStydjhOTnk0UzFESDdJ?=
 =?utf-8?B?WXduSi9MbzRrL200UGJoeGxxdVd6RmJweFgyUG01YWxvOHUraWFGTnQxa3dV?=
 =?utf-8?B?cEhoVmZGV1BweWpaV1lzeTRRKzhKMXl4TXY5NTFISCtOZlFScTBIWVlUT2dG?=
 =?utf-8?B?eWNnTnlxTjhKaDhtU281TUJkZUdBTllxVmJ3V3NaTlAwUlVNanE5WTIwTlA0?=
 =?utf-8?B?bzVJN2pRREVVKytJU2pTbkpOVytIVy9QcGtjc29xU2pKaWV5MytRN25NcXl0?=
 =?utf-8?B?cmRXKzRkZldwTHdXb0NFZzY4Vk5UTXFkSy9ZcUpPM3l2ZTFIWDZzYnkwNm5l?=
 =?utf-8?B?cXQ2L0RVNVdXY21XR0VScXVUN04va3BDWkx5Nld2d0NTMDNKUkZxTWc3WEhC?=
 =?utf-8?B?T0NlSHV3MkltRFVDZTZoRXdSWGNpb05FbTdqZ2VlNXhyQWNpNDY3NHRtb2Fk?=
 =?utf-8?B?MmdjUEVKK0l6emZRNVhWR1dOVURiaFhvQUNYSVh1MTEwYjNzM3EyTWZ4QTVO?=
 =?utf-8?B?Slp4SXVJd1NGN1hNTmRMbC9tQTJ3ZEN3aUd5UmtleHJab2VVOXFmYUdGTW0v?=
 =?utf-8?B?L2JwUE85bC83SElSTG1jNlE3Q281WHlGY0ppTndOUUkwM3Z5RWpJd3FvMVIr?=
 =?utf-8?B?cDZUMUpFZEwxSFNyd2NKTmp6ZTFRNzcybHpDV3RRMGlRdittSzZ1WkZQV1h1?=
 =?utf-8?B?b2tTc29uVllQVlBSN3V5a1NVdFRnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8270B6456C979847B4BA99C747FA80AE@namprd15.prod.outlook.com>
X-OriginatorOrg: us.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR15MB3898.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a85e289-395d-446e-9cd5-08dbd67207c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 22:22:24.8035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nOPnkC1gZ4gmbcgLiTgdNXr0To6yX7WpCUWu4l2Fmyqkf0wRG2+2JozIhVEcUOOzn9h5ixHOoo/sWXTNPeVIGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB6398
X-Proofpoint-ORIG-GUID: hfRCQVMe1QYdxot3Rt0Q-5ne_c4dY8B0
X-Proofpoint-GUID: hfRCQVMe1QYdxot3Rt0Q-5ne_c4dY8B0
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
Subject: RE: [PATCH v3] hwmon: (pmbus/max31785) Add delay between bus accesses
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_21,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 phishscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310260194
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDEwLzI2LzIzLCA0OjQxIFBNLCAiR3VlbnRlciBSb2VjayIgPGdyb2VjazdAZ21h
aWwuY29tIDxtYWlsdG86Z3JvZWNrN0BnbWFpbC5jb20+IG9uIGJlaGFsZiBvZiBsaW51eEByb2Vj
ay11cy5uZXQgPG1haWx0bzpsaW51eEByb2Vjay11cy5uZXQ+PiB3cm90ZToNCg0KDQpPbiBUaHUs
IE9jdCAyNiwgMjAyMyBhdCAwNDoyMDowOVBNIC0wNTAwLCBMYWtzaG1pIFlhZGxhcGF0aSB3cm90
ZToNCj4gVGhlIE1BWDMxNzg1IGhhcyBzaG93biBlcnJhdGljIGJlaGF2aW91ciBhY3Jvc3MgbXVs
dGlwbGUgc3lzdGVtDQo+IGRlc2lnbnMsIHVuZXhwZWN0ZWRseSBjbG9jayBzdHJldGNoaW5nIGFu
ZCBOQUtpbmcgdHJhbnNhY3Rpb25zLg0KPiANCj4gRXhwZXJpbWVudGF0aW9uIHNob3dzIHRoYXQg
dGhpcyBzZWVtcyB0byBiZSB0cmlnZ2VyZWQgYnkgYSByZWdpc3RlciBhY2Nlc3MNCj4gZGlyZWN0
bHkgYmFjayB0byBiYWNrIHdpdGggYSBwcmV2aW91cyByZWdpc3RlciB3cml0ZS4gRXhwZXJpbWVu
dGF0aW9uIGFsc28NCj4gc2hvd3MgdGhhdCBpbnNlcnRpbmcgYSBzbWFsbCBkZWxheSBhZnRlciBy
ZWdpc3RlciB3cml0ZXMgbWFrZXMgdGhlIGlzc3VlIGdvDQo+IGF3YXkuDQo+IA0KPiBVc2UgYSBz
aW1pbGFyIHNvbHV0aW9uIHRvIHdoYXQgdGhlIG1heDE1MzAxIGRyaXZlciBkb2VzIHRvIHNvbHZl
IHRoZSBzYW1lDQo+IHByb2JsZW0uIENyZWF0ZSBhIGN1c3RvbSBzZXQgb2YgYnVzIHJlYWQgYW5k
IHdyaXRlIGZ1bmN0aW9ucyB0aGF0IG1ha2Ugc3VyZQ0KPiB0aGF0IHRoZSBkZWxheSBpcyBhZGRl
ZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExha3NobWkgWWFkbGFwYXRpIDxsYWtzaG1peUB1cy5p
Ym0uY29tIDxtYWlsdG86bGFrc2htaXlAdXMuaWJtLmNvbT4+DQoNCg0KPkkgZGlkbid0IHJlYWxs
eSBleHBlY3QgdGhpcyBhdCB0aGlzIHBvaW50LCBidXQgY2hlY2twYXRjaCBzYXlzOg0KDQoNCj50
b3RhbDogMyBlcnJvcnMsIDggd2FybmluZ3MsIDAgY2hlY2tzLCAyNzIgbGluZXMgY2hlY2tlZA0K
DQoNCj5fUGxlYXNlIHJ1biB5b3VyIHBhdGNoIHRocm91Z2ggY2hlY2tvYXRjaCAtLXN0cmljdCBh
bmQgZml4DQo+d2hhdCBpdCByZXBvcnRzLg0KDQpGaXhlZCB3YXJuaW5ncyByZWxhdGVkIHRvIHRo
aXMgY29tbWl0LiBUaGVyZSBpcyBvbmUgb2xkIHdhcm5pbmcgdGhhdCBJIHdpbGwgYWRkcmVzcyBp
biBhbm90aGVyIGNvbW1pdC4NCg0KV0FSTklORzogRFQgY29tcGF0aWJsZSBzdHJpbmcgIm1heGlt
LG1heDMxNzg1YiIgYXBwZWFycyB1bi1kb2N1bWVudGVkIC0tIGNoZWNrIC4vRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzLw0KIzUzMTogRklMRTogZHJpdmVycy9od21vbi9wbWJ1cy9t
YXgzMTc4NS5jOjUzMToNCisJeyAuY29tcGF0aWJsZSA9ICJtYXhpbSxtYXgzMTc4NWIiIH0sDQoN
Cj4gLS0tDQo+IFYyIC0+IFYzOiBGaXhlZCB0aGUgY29tbWl0IG1lc3NhZ2UNCj4gVjEgLT4gVjI6
IA0KPiAtIENoYW5nZWQgdGhlIG1heDMxNzg1X3dhaXQgbWFjcm8gdG8gYSBmdW5jdGlvbiwgZm9s
bG93aW5nIHRoZSBjb252ZW50aW9ucw0KPiB1c2VkIGluIG90aGVyIGRyaXZlcnMgdGhhdCBoYWQg
dGhlIHNhbWUgaXNzdWUuDQo+IC0gQ2hhbmdlZCB0aGUgZnVuY3Rpb24gbmFtZXMgZnJvbSBtYXgz
MTc4NV9pMmNfc21idXMqIHRvIG1heDMxNzg1X2kyY18qIGFuZA0KPiBmcm9tIG1heDMxNzg1X3Bt
YnVzXyogdG8gX21heDMxNzg1XyosIG1ha2luZyB0aGVtIG1vcmUgY29uY2lzZS4NCj4gDQo+IGRy
aXZlcnMvaHdtb24vcG1idXMvbWF4MzE3ODUuYyB8IDE4MSArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0NCj4gMSBmaWxlIGNoYW5nZWQsIDE2MCBpbnNlcnRpb25zKCspLCAyMSBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2h3bW9uL3BtYnVzL21heDMxNzg1
LmMgYi9kcml2ZXJzL2h3bW9uL3BtYnVzL21heDMxNzg1LmMNCj4gaW5kZXggZjlhYTU3NjQ5NWE1
Li4wZTRmOWJlYzU0MmQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaHdtb24vcG1idXMvbWF4MzE3
ODUuYw0KPiArKysgYi9kcml2ZXJzL2h3bW9uL3BtYnVzL21heDMxNzg1LmMNCj4gQEAgLTMsNiAr
Myw3IEBADQo+ICogQ29weXJpZ2h0IChDKSAyMDE3IElCTSBDb3JwLg0KPiAqLw0KPiANCj4gKyNp
bmNsdWRlIDxsaW51eC9kZWxheS5oPg0KPiAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+ICNp
bmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4NCj4gQEAg
LTIzLDE5ICsyNCwxMTIgQEAgZW51bSBtYXgzMTc4NV9yZWdzIHsNCj4gDQo+ICNkZWZpbmUgTUFY
MzE3ODVfTlJfUEFHRVMgMjMNCj4gI2RlZmluZSBNQVgzMTc4NV9OUl9GQU5fUEFHRVMgNg0KPiAr
I2RlZmluZSBNQVgzMTc4NV9XQUlUX0RFTEFZX1VTIDI1MA0KPiANCj4gLXN0YXRpYyBpbnQgbWF4
MzE3ODVfcmVhZF9ieXRlX2RhdGEoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwgaW50IHBhZ2Us
DQo+IC0gaW50IHJlZykNCj4gK3N0cnVjdCBtYXgzMTc4NV9kYXRhIHsNCj4gKyBrdGltZV90IGFj
Y2VzczsgLyogQ2hpcCBhY2Nlc3MgdGltZSAqLw0KPiArIHN0cnVjdCBwbWJ1c19kcml2ZXJfaW5m
byBpbmZvOw0KPiArfTsNCj4gKw0KPiArI2RlZmluZSB0b19tYXgzMTc4NV9kYXRhKHgpIGNvbnRh
aW5lcl9vZih4LCBzdHJ1Y3QgbWF4MzE3ODVfZGF0YSwgaW5mbykNCj4gKw0KPiArLyoNCj4gKyAq
IE1BWDMxNzg1IERyaXZlciBXb3JrYXJvdW5kDQo+ICsgKg0KPiArICogVGhlIE1BWDMxNzg1IGZh
biBjb250cm9sbGVyIG9jY2FzaW9uYWxseSBleGhpYml0cyBjb21tdW5pY2F0aW9uIGlzc3Vlcy4N
Cj4gKyAqIFRoZXNlIGlzc3VlcyBhcmUgbm90IGluZGljYXRlZCBieSB0aGUgZGV2aWNlIGl0c2Vs
ZiwgZXhjZXB0IGZvciBvY2Nhc2lvbmFsDQo+ICsgKiBOQUNLIHJlc3BvbnNlcyBkdXJpbmcgbWFz
dGVyIHRyYW5zYWN0aW9ucy4gTm8gZXJyb3IgYml0cyBhcmUgc2V0IGluIFNUQVRVU19CWVRFLg0K
PiArICoNCj4gKyAqIFRvIGFkZHJlc3MgdGhpcywgd2UgaW50cm9kdWNlIGEgZGVsYXkgb2YgMjUw
dXMgYmV0d2VlbiBjb25zZWN1dGl2ZSBhY2Nlc3Nlcw0KPiArICogdG8gdGhlIGZhbiBjb250cm9s
bGVyLiBUaGlzIGRlbGF5IGhlbHBzIG1pdGlnYXRlIGNvbW11bmljYXRpb24gcHJvYmxlbXMgYnkN
Cj4gKyAqIGFsbG93aW5nIHN1ZmZpY2llbnQgdGltZSBiZXR3ZWVuIGFjY2Vzc2VzLg0KPiArICov
DQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgbWF4MzE3ODVfd2FpdChjb25zdCBzdHJ1Y3QgbWF4MzE3
ODVfZGF0YSAqZGF0YSkNCj4gew0KPiAtIGlmIChwYWdlIDwgTUFYMzE3ODVfTlJfUEFHRVMpDQo+
IC0gcmV0dXJuIC1FTk9EQVRBOw0KPiArIHM2NCBkZWx0YSA9IGt0aW1lX3VzX2RlbHRhKGt0aW1l
X2dldCgpLCBkYXRhLT5hY2Nlc3MpOw0KPiArDQo+ICsgaWYgKGRlbHRhIDwgTUFYMzE3ODVfV0FJ
VF9ERUxBWV9VUykNCj4gKyB1ZGVsYXkoTUFYMzE3ODVfV0FJVF9ERUxBWV9VUyAtIGRlbHRhKTsN
Cg0KDQpTdXJlIHlvdSB3YW50IHRvIHVzZSB1ZGVsYXkoKSBoZXJlIGFuZCBub3QgdXNsZWVwX3Jh
bmdlKCkNCm9yIG1heWJlIGZzbGVlcCgpID8NCg0KDQpUaGFua3MsDQpHdWVudGVyDQoNCg0KDQo=
