Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C69759203
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjGSJtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGSJth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:49:37 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8B510D4;
        Wed, 19 Jul 2023 02:49:36 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36J5hVtE009307;
        Wed, 19 Jul 2023 02:49:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=x+Gx2D3GlZfrRf4BIGeESG0e3Kniqr1h/jyE3fDPsNg=; b=
        FUhR0pYB8gqQG4QP2Iim0GHtMdsXx1bxXKqOdlKdJdOo8XHrSVqIQmsmFGvy2Pp3
        Q/XDDrB6MCfIpQ2hFyd6epUYx+gop8CqcfLTPTL81Mhb3auP7WTbFqb1yLFW07pJ
        S8dkl+DPr2VmJdx+MeLm/c1Wzxfmm6ub2OW1Ozmp/5O/NXA92ZvtpQ4XVVBkpNIg
        3fYwJ4ceSTPvXcsqHjAhmLeF5AmnZsViPkmf94aebaLazkP2tCX8qpWZLWzXkbYI
        tHvs9fRuxBgxPR8nP7jHPFX7zIooATOpYqSqzhX7CZQ2aUqdd9aYGH+N/s4xcxl+
        W5grHmnxOpREVhzrCVr3BQ==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3rutyeuc05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 02:49:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRFnSBFuCTWHTeiIa2RB98uQl/GD4nPuf1fKmwZP2HyGl5R7pw660CkDMKGMFwS3vsI1JLboWvvtvH9JqZ31mA4juaa7HEAd6iC/6Y3DgeXIRP3sKZ3zPQxLOY4YnjHjrBdTf9PVpiHb9KAQuuBKM/JPxOXNxg7MH0l+od2rbXTFGgMr9Suw9eh6Zmhj1ntEvmY2XKhvINRm2yJhWracnqQ7r/whfi8PP6/C2Zsz+eGgjwXdZGAVc/kPSsy5BqQSgUjWSdiJsKEvJaEyfZ/Rwq1Mle+0VRiQp4zfrP3ZwEluB05lb3/tIKGB3sT3tdj0vta2bQPGBaLnu8tuR9n2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+Gx2D3GlZfrRf4BIGeESG0e3Kniqr1h/jyE3fDPsNg=;
 b=CLuvMS1pjO4/sGybfW2PM+IUfJ+jodBXM6x8XcG5ImHvCbPM6TAsl/xwDlB+zS2vWG+kMW05K4579puBC7gvnYOKjyGucsoyGOuT0eRdicsUlKJUAy45eFTrMS8DUXH8o5J/73CYPQYcC68rwlq4Z7evpTjsOEmP1CBuAEU24a+1Ua9HuYQSxrqiethL6F3z1VvAuWxl3vXqnlJ43pGe5TReJpTV1XuvQBXIAiuXVgJszGudz8hectKtJvX0AMszEAJwI8wZlBUgI6v5FhuuiunWs5OYnn2CGa8y8nYmHeUeR42L1cpg55d0vNBunj4ALMCNuoQdj0gZ3frKalvIDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by BL3PR11MB5682.namprd11.prod.outlook.com (2603:10b6:208:33d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 09:49:25 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e4:3974:df17:77c9]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e4:3974:df17:77c9%3]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 09:49:25 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "hminas@synopsys.com" <hminas@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] dt-bindings: usb: dwc2: add compatible
 "intel,socfpga-stratix10-hsotg"
Thread-Topic: [PATCH 3/3] dt-bindings: usb: dwc2: add compatible
 "intel,socfpga-stratix10-hsotg"
Thread-Index: AQHZueyAFusz4XumYEyDAazHOHYAza/Ao6MAgAAh9eCAAAUUgIAACRZw
Date:   Wed, 19 Jul 2023 09:49:24 +0000
Message-ID: <PH0PR11MB5191867DF205B301A8FD701EF139A@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20230719025509.3007986-1-Meng.Li@windriver.com>
 <20230719025509.3007986-4-Meng.Li@windriver.com>
 <488835c0-e08e-c0cc-abac-192f658b093f@linaro.org>
 <PH0PR11MB51913FB3A55B1420B7798C01F139A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <86cbedcd-692b-ecb8-2075-d50835739bcf@linaro.org>
In-Reply-To: <86cbedcd-692b-ecb8-2075-d50835739bcf@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5191:EE_|BL3PR11MB5682:EE_
x-ms-office365-filtering-correlation-id: f4d32824-a381-48c6-90c1-08db883d6f75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: buiAafC4vr60+SLXUhyTUZpwoJ3jQytVqlD4PVAXUVG7ndV3VTtdvbb2fRH9ZaqaIGWOR7CcJp+TTv64tcmoA2LgpvRxe9yodv2adxzzXQZ9A29USrNgSsQ0X6DWT2LfNVdnvrkxjFBInoVKFKn7LkqO9u+Y0U+umySBU/mzygV8wR6mikU38iNjeC+oLCD8cjvscM+htyoanQ26jIv20Ji05Yjr/uat+QqYHio4ygkn10wiunt98i9CQdc9CRukyBVSt89mFtiY3ANRvOhfo4kmoh55lW8cCBajhdWo0L6iF7deolrNc0yBawa5cQ5k/eGm4u/ikgsiZd5Z0SBwqSH2H5NWD6sQLjzbh7TkmqAnO1iKgVlboYmf4qbEPoso3zEpL1y8DViJ/bnAkp7rdNoG9aPXAyXnVt3JhUCC8JKFvFn9JqZfXe+x2V8r8v0dSENdIsOKszrUCBkrhQ/7b4cj6SvugH8Pr3WSGg29kQePb+YN+yHZ1cRAxbsm3ndk9lzEBxJq6vSj9Tk4TJbGN0h5JECiXzYJNw9ES3YtP59C/5xvzfjAuX/HPmP1hTLMf1hsYt6pwurDsgJylooAfuOT3LvVfCvBRVnAUbt0aMEc2YGzeg8MwshEMmCg0CZ2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39850400004)(346002)(396003)(376002)(136003)(451199021)(41300700001)(110136005)(52536014)(8936002)(8676002)(7416002)(5660300002)(4326008)(316002)(38100700002)(9686003)(7696005)(66556008)(66946007)(66476007)(66446008)(76116006)(64756008)(83380400001)(71200400001)(2906002)(33656002)(86362001)(55016003)(478600001)(38070700005)(122000001)(53546011)(6506007)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXdoTzdQS1BjcVAzODFaUVRrRXdHQytCL2VYazRQWDFuSWFKQ1hhNTdvSDEz?=
 =?utf-8?B?YXRRUzFRdHgwTkRCcG8wcFZEa2ZCUkNrZTJET3ZRUTVsdnFzbmJrQS9iT1Fy?=
 =?utf-8?B?RXRWSEljMXZZbk4yN2IwWEMwZWN4blpON21ad0dCVHJWM1UzMWx1cmdSdWNs?=
 =?utf-8?B?VENPQUlRZFdXYmh0bFNzVitiM0d1aENiSjVTNW5RVDVTa1EyUVZYYmd6MjB5?=
 =?utf-8?B?SGgzdWQwdmZGUnZEaXl1WWtBeEFRMWtob2d0M1RiMU92WTB6VnNtWkpobyty?=
 =?utf-8?B?N3FPcXluT3BQQlBpRWYwbUpTWEpZKzl1K1ptWUl2UVlpdTRWQ0FjTGFvdjRT?=
 =?utf-8?B?Z1lhTVVRb1BaTmJOcVpqSjB6blBzbWhIbHdQOTlHdVd5dkltSExSd0piZDZm?=
 =?utf-8?B?WFhzSkg1Tkp0ZHkrK2JzNStjUXZaQmRteWhKbTVGMGhqTklSMVAwVlphd0Z3?=
 =?utf-8?B?V1pCcUhJQmtHRWlIQXpCU3lIbTFGSzh3cDlzOStXOWdGUnRoYVJza1psaEY2?=
 =?utf-8?B?TUsvUkVHbStzTE5BdnhyV0xra3dkOXFiRkZjeWl0d3lNWUNzaGhzUjJxdnla?=
 =?utf-8?B?cm82d0Z6ZHVVUE5QbFZ6VzZCa2lIL1RSVklVSGE4WjdMbTFlYW5IaUFxUm05?=
 =?utf-8?B?YWlINjVNYlJ5a1NTSlJlUDlQckhJVGZ1U2xwalFWMzEyaW1TOVI4bUhLTm1M?=
 =?utf-8?B?a2FGdFpGbWxJM0dncUMxM3d2MmZmMzJ4ZnMvaGZEeFBwa0xQS25kT2w0QWxW?=
 =?utf-8?B?RUxYRy9acmcwMnlYMzAveTFVUjY1blFSV1ZkcHgxaXRyV0hPTEVxeXhGTWF1?=
 =?utf-8?B?b3dSWDNoUTgrcGE5Ymk3OVNNeUx3L1RIV1Fibnd5cTd2b2pFc2R4MytHMFIr?=
 =?utf-8?B?c3BVcDNUYlA0dUh6UVQvOXJxblp1T3B0Q3MxOHJ3Y3B2V0ZFbVRQRGIyUm5x?=
 =?utf-8?B?b2NISjkrVTk3Ymd2NlRmUGlWNzk0aEQ4VDFwWUtQZFVYd29sMTFoWkRwa2c4?=
 =?utf-8?B?ejdadmkvbThEaVMzMlNJTzdPNllVL0F4NnV1Q3p2eWR3bnZDNG5oNDNLeEN2?=
 =?utf-8?B?dmpwSVNhekxGUE5TZXhGYVBVaG5zUEJERm50WlN3QkVGN2QrUGdGVHlRcUc5?=
 =?utf-8?B?NUlESFdTS0RXTFVlKzR0S1g0NWgvajB6aGpBUWFGWWJIRjY1N3pRWXVlQWR0?=
 =?utf-8?B?VktFSFhuQ0VXd2ZBMFdFNHVXR0NrWlBVeG91bmQ5WkJzaHE5WktDYnNGQklF?=
 =?utf-8?B?cWxTZXNtU0ZVNEJVTkNSUlZmN3oyb1NBeEFXbmRNSkhCSy9JUGd3ZzZFT2xE?=
 =?utf-8?B?cFZrMUpFcUJHMTdUWUhmQUhQM3lvOFR4Mkx2Z3BPc29mbXY4a1FDWjN6SERj?=
 =?utf-8?B?K3BrbGR2L3gvekNQTE9hT3BkaCthdHQ0aUxLSmU0N1JHWDBjbWlzOWRqY0FJ?=
 =?utf-8?B?emNNNjE1c1ljSUdMUTZYOXR1MXRlTnRNQkN6TTFuQXBabE9BdWEvYS9kaUtm?=
 =?utf-8?B?SVZXeG9mV2lpcnduQVdPcDlaWDJsM01LYzRVNXNBV3ZyTHdKTFpGSm1KZ2o0?=
 =?utf-8?B?UDZJN0ZiVGpubVZUVWRzcU00QnYxM2ljL0V2eENXZ0xVWmtoNHBhNi93eVA3?=
 =?utf-8?B?ZkNGeGovdFR2SkhIMWMyc3NlOC93RFFCUFdPbklLd0ZOend2VGVnc3R1bGlQ?=
 =?utf-8?B?ZGtWU0pFNGlVd2VrOGdNZ0JiTFB0bmlkcHk3TGw3Z2tSMVlYWXhpdE1CeTF4?=
 =?utf-8?B?YUdXcyt3eXEwN21YV1NqUXFuTFZEQWJhVGt0Zk5YWTIrcmZGck9ZVTVSQ3Zj?=
 =?utf-8?B?UlArRlBlZHlhOHduY3VyTGptTVg2SDc3VVU5ZjZKTHNsenFWS2YzcGl4ZGZD?=
 =?utf-8?B?L21WVEw1d3pERVJ5QStmVFBoZkZmQUEweTR3bCszT25SWUxpMG1HSktYQXVs?=
 =?utf-8?B?NEdNMEFHTzk2dTNLc2FhTDdCZmo4TE92RnZ0Ums5aWhVb3Q3Z0NTcFJLYUNq?=
 =?utf-8?B?K2p6alRsZVFnVTROeG9hQzFmRU4vNVZxTnF6YXROZHNhMTBHaE1tN1ZWL2xa?=
 =?utf-8?B?MTVVeVlLS214c1M5bnI1Rm1wSFFGS2c4dTZSYSs0K1JTa1lZdkVBR05SSS9P?=
 =?utf-8?Q?QciEzKLyb7u9Cw42a4or4SAva?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d32824-a381-48c6-90c1-08db883d6f75
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 09:49:24.6854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I8mMXfOEbD24cdtuIdFFsE5OyAK9V6mjVKGJ7rYGNv9dzn4q8yKWNtdRclDRp12PM0B+SZCkFqbfG842sUvd6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB5682
X-Proofpoint-ORIG-GUID: S5i3pDFVVpOn4IBhDmpOeDExN-qaPfcb
X-Proofpoint-GUID: S5i3pDFVVpOn4IBhDmpOeDExN-qaPfcb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_06,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=941 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2306200000
 definitions=main-2307190089
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IEp1bHkgMTksIDIwMjMgNDo1OSBQTQ0KPiBUbzogTGksIE1lbmcgPE1lbmcuTGlAd2luZHJpdmVy
LmNvbT47IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOw0KPiByb2JoK2R0QGtlcm5lbC5vcmc7
IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsN
Cj4gZGluZ3V5ZW5Aa2VybmVsLm9yZzsgaG1pbmFzQHN5bm9wc3lzLmNvbTsgbGludXgtdXNiQHZn
ZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAzLzNdIGR0LWJp
bmRpbmdzOiB1c2I6IGR3YzI6IGFkZCBjb21wYXRpYmxlICJpbnRlbCxzb2NmcGdhLQ0KPiBzdHJh
dGl4MTAtaHNvdGciDQo+IA0KPiBDQVVUSU9OOiBUaGlzIGVtYWlsIGNvbWVzIGZyb20gYSBub24g
V2luZCBSaXZlciBlbWFpbCBhY2NvdW50IQ0KPiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZA0KPiBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiBPbiAxOS8wNy8yMDIzIDEwOjQ1LCBMaSwgTWVuZyB3
cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZy
b206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4N
Cj4gPj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDE5LCAyMDIzIDI6MzkgUE0NCj4gPj4gVG86IExp
LCBNZW5nIDxNZW5nLkxpQHdpbmRyaXZlci5jb20+OyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9y
ZzsNCj4gPj4gcm9iaCtkdEBrZXJuZWwub3JnOyBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFy
by5vcmc7DQo+ID4+IHJvYmgrY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gPj4gZGluZ3V5ZW5Aa2Vy
bmVsLm9yZzsgaG1pbmFzQHN5bm9wc3lzLmNvbTsgbGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsN
Cj4gPj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gQ2M6IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCAzLzNdIGR0LWJpbmRpbmdz
OiB1c2I6IGR3YzI6IGFkZCBjb21wYXRpYmxlDQo+ID4+ICJpbnRlbCxzb2NmcGdhLSBzdHJhdGl4
MTAtaHNvdGciDQo+ID4+DQo+ID4+IENBVVRJT046IFRoaXMgZW1haWwgY29tZXMgZnJvbSBhIG5v
biBXaW5kIFJpdmVyIGVtYWlsIGFjY291bnQhDQo+ID4+IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZQ0KPiA+PiBzZW5kZXIgYW5k
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gPj4NCj4gPj4gT24gMTkvMDcvMjAyMyAwNDo1
NSwgTWVuZyBMaSB3cm90ZToNCj4gPj4+IEFkZCB0aGUgY29tcGF0aWJsZSAiaW50ZWwsc29jZnBn
YS1zdHJhdGl4MTAtaHNvdGciIHRvIHRoZSBEV0MyDQo+ID4+PiBpbXBsZW1lbnRhdGlvbiwgYmVj
YXVzZSB0aGUgU3RyYXRpeCBEV0MyIGltcGxlbWVudGF0aW9uIGRvZXMgbm90DQo+ID4+PiBzdXBw
b3J0IGNsb2NrIGdhdGluZy4gVGhpcyBjb21wYXRpYmxlIGlzIHVzZWQgd2l0aCBnZW5lcmljIHNu
cHMsZHdjMi4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBNZW5nIExpIDxNZW5nLkxpQHdp
bmRyaXZlci5jb20+DQo+ID4+DQo+ID4+IE1pc3NpbmcgY2hhbmdlbG9nLCBtaXNzaW5nIHZlcnNp
b25pbmcuIFRoaXMgaXMgdjMgb3IgdjQuDQo+ID4+DQo+ID4+PiAtLS0NCj4gPj4+ICBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2R3YzIueWFtbCB8IDEgKw0KPiA+Pj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2R3YzIueWFtbA0KPiA+Pj4gYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2R3YzIueWFtbA0KPiA+Pj4gaW5k
ZXggZGM0OTg4YzAwMDljLi5mOTAwOTQzMjA5MTQgMTAwNjQ0DQo+ID4+PiAtLS0gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2R3YzIueWFtbA0KPiA+Pj4gKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9kd2MyLnlhbWwNCj4gPj4+IEBAIC01
MSw2ICs1MSw3IEBAIHByb3BlcnRpZXM6DQo+ID4+PiAgICAgICAgICAgICAgICAtIGFtbG9naWMs
bWVzb24tZzEyYS11c2INCj4gPj4+ICAgICAgICAgICAgICAgIC0gYW1sb2dpYyxtZXNvbi1hMS11
c2INCj4gPj4+ICAgICAgICAgICAgICAgIC0gaW50ZWwsc29jZnBnYS1hZ2lsZXgtaHNvdGcNCj4g
Pj4+ICsgICAgICAgICAgICAgIC0gaW50ZWwsc29jZnBnYS1zdHJhdGl4MTAtaHNvdGcNCj4gPj4N
Cj4gPj4gU28geW91IGp1c3Qgc2VudCB0aGUgc2FtZSBwYXRjaCBhcyBiZWZvcmUuIEkgcG9pbnRl
ZCB5b3UgdG8gdGhlDQo+ID4+IHByb3BlciBzb2x1dGlvbiB3aXRoIGNvbXBhdGliaWxpdHkuDQo+
ID4+DQo+ID4NCj4gPiBOby4gbm90IHRoZSBzYW1lLg0KPiA+IEkgZG9uJ3QgdW5kZXJzdGFuZCB3
aHkgU29DIHNwZWNpZmljIGNvbXBhdGlibGUgImludGVsLHNvY2ZwZ2EtYWdpbGV4LWhzb3RnIiBp
cw0KPiBhYmxlIHRvIGJlIGFkZGVkLCBidXQgdGhlIFNvQyBzcGVjaWZpYyBjb21wYXRpYmxlICJp
bnRlbCxzb2NmcGdhLXN0cmF0aXgxMC1oc290ZyINCj4gaXMgbm90IGFsbG93ZWQuDQo+ID4NCj4g
PiBZb3Ugc2FpZCAiV2hlcmUgaXMgU29DIHNwZWNpZmljIGNvbXBhdGlibGU/Ig0KPiA+IE5vdywg
SSBhZGQgdGhlIFNvQyBzcGVjaWZpYyBjb21wYXRpYmxlICJpbnRlbCxzb2NmcGdhLXN0cmF0aXgx
MC1oc290ZyIsIGJ1dA0KPiB3aHkgaXQgaXMgc3RpbGwgbm90IHJlYXNvbmFibGUuDQo+IA0KPiBU
aGUgY29tcGF0aWJsZSBzaG91bGQgYmUgYWRkZWQsIGJ1dCBJIHNhaWQgdGhleSBhcmUgY29tcGF0
aWJsZSwgc28gZXhwcmVzcyBpdC4gSQ0KPiBhbHNvIGdhdmUgeW91IGV4YW1wbGUgb2YgZmlsZSB3
aGljaCBleHByZXNzZXMgaXQuDQo+IA0KPiBXaHkgdGhhdCBjb21wYXRpYmxlIGlzIG5vdCBhbGxv
d2VkIGFsb25lPyBCZWNhdXNlIHdoYXQgd2Ugc2FpZCBoZXJlIG1hbnksDQo+IG1hbnkgdGltZXMg
YW5kIGJlY2F1c2UgdGhlIGRvYyBJIGdhdmUgeW91IHdoaWNoIGV4cGxhaW5zIHRoaXMuDQo+IA0K
DQpJIGhhZCBhIGxvb2sgdGhlIGRvYyAsYW5kIHJlZmVyIHRvIHJrMzEyOC5kdHNpIGFuZCBjb21t
aXQgNTAzMmIyNjkyMDMyODdjMTcwNjRkMzNjNzJiZTFlYmYzMGMwNGE5NS4NClNvIEkgdGhpbmsg
aXQgbmVlZHMgdG8gYWRkICIgaW50ZWwsc29jZnBnYS1zdHJhdGl4MTAtaHNvdGciIERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvZHdjMi55YW1sLg0KQnV0IGlmIHlvdSB0aGlu
ayBpdCBpcyBub3QgcmVhc29uYWJsZSwgY291bGQgeW91IHBsZWFzZSBzaG93IHdoYXQgaXMgeW91
ciBtb2RpZmljYXRpb24gZm9yIHRoZSBkd2MyLnlhbWwuDQoNClRoYW5rcywNCkxpbWVuZw0KDQoN
Cj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
