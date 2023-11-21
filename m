Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D527F3705
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 20:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbjKUT7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 14:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjKUT7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 14:59:37 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4441AA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 11:59:33 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALJoRee023240
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 11:59:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-id :
 content-type : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=MEipoJHKtCdZpMd1JogQaKUbso5DP463ZamwlKBlDcU=;
 b=LZaQg4+Z4MtTrslt9Zphy7uNVDCJV2mMNgHT0fMvcnwWhxCmmwTHbrbUmZS61Jt8kvkY
 HO0sJUoUFETWV7f5OlmFbEe6U9dsrKnfZPEMtSx+vNMhxGg3J3U9Bl0awVzW+DZf5A27
 iFtRxvf20xOiXMmkuC5BAjjhKhf4FlurJ9DEdGqRVPeEi4GYTyfHIg//ICDq1xdFXarF
 +TxJJVQf0+2fq2gJh+IMICudj8saFahysqiMOlbiFrEuP/U0l9cdmD0oT36snT2zgvuk
 NIohjfKx/qpbnmXb9K7sDT+LXk2JHQ/gXxR35cpMYSYQAXNMisnJP5RUouVyxa1ihSG7 sQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uh27p0hf4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 11:59:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAlRg3GhmeQlzc0I5t3ZCHOlzb3FvNQ9KqMKdMZdx8KBp4TrVk+7QqdXC0p/dbDMh9pjEF/YWFlak6v4+04spiO/+lwnUwezuRbWPLfV5yeXQch8nZcikzoJ+6iCQG84tOaycWNneJd4ZN/IW5rNP1fRu98gFUcqKwc1effYIjL7pBdpLgwu4i7tX9zkUOzSdnetBp9ZTnMnZgAaddE11+ClXLVV/0Kg9F6v9rvuVaK3+KE/BGiVouNh/8wlcrLNZgHQuoQAYpmcn2sRpo62vY3YIsW4810/oV+zVDpV+eOIWVTm3SdAaNoLDUvRtftA6OaPJ4A0ohAGMSVDsWP80g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEipoJHKtCdZpMd1JogQaKUbso5DP463ZamwlKBlDcU=;
 b=RKXdX5Eu2brsIdMOAmnzW1tsPYSG63oHwC+GBrFcXj+pK9u/32BBEHwUUa44rTPEMyNdwVBV8WOCzq4juCAfHg4HbhhhD5e4PduRfbiU3JfoMHGeOu8K1UoOLtlkrVWQf3Y5M6DCUzoHN3e5xDACUWWiZ+hRdzR1Ki1EUtn5RhxWKOh7wC6QzlFFw4kdD9LdPUUmZs02H3NziPLe4w3kF4eaZV7qu8PoJrw6dUjhLkbDdjKqtIydIDiup1h7vqHOmcetMOCfp0qkFmSw1oltPvQKVhdCP+HkPUVSvJ1vkHnc+j3aRPqZRsg/6FuGn6i/YST/UUkITd2thGW2a84G5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by SN7PR15MB4159.namprd15.prod.outlook.com (2603:10b6:806:f6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Tue, 21 Nov
 2023 19:59:29 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::cbea:e86f:62db:9b00]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::cbea:e86f:62db:9b00%3]) with mapi id 15.20.7025.017; Tue, 21 Nov 2023
 19:59:29 +0000
From:   Nick Terrell <terrelln@meta.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Nick Terrell <terrelln@meta.com>,
        Nick Terrell <nickrterrell@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yann Collet <cyan@meta.com>,
        Kernel Team <kernel-team@meta.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Nick Terrell <terrelln@meta.com>
Subject: Re: [PATCH 2/2] zstd: Backport Huffman speed improvement from
 upstream
Thread-Topic: [PATCH 2/2] zstd: Backport Huffman speed improvement from
 upstream
Thread-Index: AQHaHBTz4ziGxvjb9UezyAE3hPe067CFBqAAgAAroQA=
Date:   Tue, 21 Nov 2023 19:59:29 +0000
Message-ID: <D42705E6-94D3-4E3B-9BA8-AFFCE4B8E4E4@meta.com>
References: <20231121010318.524570-1-nickrterrell@gmail.com>
 <20231121010318.524570-3-nickrterrell@gmail.com>
 <CAHk-=whL+1xR_LJwJ7DRhFo2gkDv0jrRMX5PJoULoSBXppEV8A@mail.gmail.com>
In-Reply-To: <CAHk-=whL+1xR_LJwJ7DRhFo2gkDv0jrRMX5PJoULoSBXppEV8A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3667:EE_|SN7PR15MB4159:EE_
x-ms-office365-filtering-correlation-id: a147059c-519f-4a82-4683-08dbeacc5f17
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NU6K7A1kiOwlgTRfqfG0NJIeZQ5BCcIYNt3S2fbxiF3B42fhQyYqVxRYhYvqUWGItXJ1jpoJf7Hj+r+ledelUHQuquomo/8/l5LksjIcxlwQgOgV0zCPSCPYlNyd9+GoovVGKXAoARbO+lrcYilqrBjx6+ZcKNrgp0S9qlH1Id0C17+jZxkw+wEtmb/vvmDmEx7jMg/aEBSZmyfumoncJLxrvql7L1Ktusqi48zSkOth7Ucc5b6AGCnxE006FSVj6oVACCMTPhli0RJPNUDTTZrO1J10wOC+uXA2MgnuNaKQ5beqBNR5k5utyOmStzhtiXNWUQ1XGlvT2h23Etx79jBIKIGZOPiqlq4s0cTVqdR+m7Zb+ShXLYyy+/0cgbFmQoZQ9VoLIXulm4CG6mE5U3RKFxhe+00PVhao9qpiVXw0icZm72ShTarsUOv4TgmsVpYZozT3Jd4oiGavsqiLXPkKt9U1LGqE/F5383CmVLHEGoE9/HZGR+xanzCAD1Q6LI3osbZSJR+OwPIgh59DBc/tmz1M7Bs3Iw7wBsnD1g9DalPEspwUsTRVysJbTo763SSMwYUgDTfK0B+8x33kuyxdpXhDXwbyk4mrpKOUseFjJ8frQEWJq9Q7H8HWo5oRcCaEfGj+mlcQmmZ1HpEl0HU7YzN1i/T2Tc3ZwPbHQHU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(39860400002)(346002)(230173577357003)(230273577357003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(6512007)(6506007)(71200400001)(6486002)(122000001)(478600001)(966005)(6916009)(316002)(66446008)(8936002)(66946007)(8676002)(4326008)(38100700002)(76116006)(2616005)(91956017)(66476007)(64756008)(66556008)(54906003)(53546011)(83380400001)(107886003)(2906002)(5660300002)(33656002)(26005)(41300700001)(86362001)(36756003)(38070700009)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1UxSEZtZ1BpK041OXFpYWJKMElzT0pFakppeE05ck1FL3NuVDQxa0Rhd0xH?=
 =?utf-8?B?VEFSbkhFYU8wRXBmazVUWXdSTkZFaStESjNUMU5SWW5NQTdsR05VYXdDT251?=
 =?utf-8?B?TGRRSFFYWTY1QXJraXI4bzBUZlNVdkh1ZjcvTkNYS1BBdjJUVkk3T1FoUUZE?=
 =?utf-8?B?VE1SSnpYNUxpSHdPb1UvanBvajhXaUk3Y3NESmtxeFJlbStLOVliZ2JhR2hi?=
 =?utf-8?B?b3MzVUUvWm41aS82aGhRZWQ4RTdtTEt0cnZrL29qM1ZiV29CU2VqNUhuY0dJ?=
 =?utf-8?B?M1REYmdSVE10cmtnNElITFNBZVVhK2xGeU85bUpPYUN1RE0rWGtMVzlydjdi?=
 =?utf-8?B?bVVTVExIM2xpa0hlZ0hnUWpzdFJoNCtBWWhyRXdnNStScFYwQVU1MUJ4MmtQ?=
 =?utf-8?B?dDRLOWV2QXd6eUYrcEhTTWc4TTc1Y1BwbUl5aUppLzNjWTFsSkdNSGFsOUdH?=
 =?utf-8?B?YS9sN1hSQzl3ZVduVHpPOHI4LzF4amFNaWlDblFLUVRIcjR2c3F6N2xvRnZr?=
 =?utf-8?B?N2hJdVhCRndIbi9QVnkrNjBrMUdLSmlQdWJmTUNOZzZtWlg3NGNrWGZvY3Zp?=
 =?utf-8?B?V01hTHNoc3lzYlc2bUVZRjBlR0Nodks4RUpOODgyY2pFbmpVUXBOUTZicU9X?=
 =?utf-8?B?K25KRVhjcDhDWlBuTlZqWlJyd2xMRnk0WlMrUk1COUNuZHEyZjladFUwbkZM?=
 =?utf-8?B?cHFDLzgzVUZHdmVLWWRZMWp5aHFvblFRL0lXWC9OMDFNMUFoVVRLMkxWdlZw?=
 =?utf-8?B?Z3hhM1Z6VDZWY0lYQkVlR3JFcVk1UXpMajA5M1hyK3NjS1BwUXFBVEFOWE9P?=
 =?utf-8?B?YXJiTWR2NEh2NHdEN0c4bldkTnJ1amcxUWR3VGMxcktxL3hTZm1iVVdwa21G?=
 =?utf-8?B?RXFlbWJBWDAzUUswcWdjZkVuM2RRaUdvTTllNHo0MnZxOTZucDJYT0t3S21p?=
 =?utf-8?B?VXJPNDZKbkkybGNpbFhVZTMwN3JhOUx4Q0k3RE1tQTBQVlhkdUdpMEhwZmVD?=
 =?utf-8?B?dllBcXBjVTl3OGRnNmR4dWo5N3VESXlQUmRCTWg1ang5a1F1SThlTCtZZ1k3?=
 =?utf-8?B?UENPd0xJT3FNWkdyL084eitEMWQ0US9Sc3BERXU4UExkbnRoaVVmdUdNYVpK?=
 =?utf-8?B?NGJHZWlpZzVQWlltSmVSU3lvOHh6S25mZjdnMXhlZmw1cWUzelJ4WnhDU1NR?=
 =?utf-8?B?cndZTmxQeER5cjBqRDdMQmd1amFUZ0M3NWxjT3FmSGRvTDVpV282OXJrTEFu?=
 =?utf-8?B?cUpRaEpBL25UdXd0djBOd3VPclJUMGpieXVuWlVRb05RUUdKN0NOb3VTYmtQ?=
 =?utf-8?B?RzVxYzVpRUxrQWxWN2hDVWFqUnJQRTdkaEdRVXdONG85M1pDRXNjOTI3cVZq?=
 =?utf-8?B?SGVLR2pVaHlTOUIwTlhpU0VFY0lxMjRGbEJHRWdNN1haYndhYnp4L0JLeGtT?=
 =?utf-8?B?NFptL2p6OWtpY3NYc0g2bFlhWlladWJ0TFdDN0tNUnoybVhuWDRLeHQva0M0?=
 =?utf-8?B?V3c2VWtUc2x3RFNGOThVSmU4SmlldWZIcFA1UkZsWTdHR1owV01oU1MwSkEz?=
 =?utf-8?B?MmhaTWpPNHI2azdMRjdFRVM3RXVtb0hBSGNYYkhHd2YwN29nUXZCS2hleW5L?=
 =?utf-8?B?UVgvWFVIYjJFa3dpUDJjV0lNcCthNW4rNDM2akw2WVE0TFJ3ZzlZcXVRV0Vw?=
 =?utf-8?B?SDV5Q0NRSkRseGtrS281WXJtQkF6ZTVWNm9XRzlLanR1M21qY01KM3dLRDE4?=
 =?utf-8?B?VHNDZG51U3Z6NVFTMGJzUUw5ZWNzYkY3RVJDenh5TmgwMjlOL2IrNGVrYTd2?=
 =?utf-8?B?WVBRZ21CV3B4K0I2czFIQkdOVW9STzFmVUg4ZUQ5WWNTM0xMd0c3L0wzWWtl?=
 =?utf-8?B?U2t0emRvMFJPelM3dm5iK2VZTFJZYTg1UVJTQjFEOGxrWW5QZDI5clIxWWNv?=
 =?utf-8?B?MUhvWEFTWGl0Tk5WSHloKzRVVDg0Wm9rbW9YTHhGeWZRUWM1dmRLSktMUDVx?=
 =?utf-8?B?a1lyZnp1SnhXbDhZZ0lsdFEyZ2VHeHhaY3g2a2tpTEw2MC8xOC9QN1ZKbGgz?=
 =?utf-8?B?aDhGS3gzWm1IRGg3c2VsUkR0T0tKSmczdUROVFp5bUhMN2ZtbWZzQ1FTbzhl?=
 =?utf-8?Q?GT6dj0F3/mcq+9zjCLoXnSPE3?=
Content-ID: <D074207DA57EF1479949D6F128E4B9F8@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a147059c-519f-4a82-4683-08dbeacc5f17
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 19:59:29.2096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9OqezrTWWcgqx4Sq+kD+2klM1aEIVrq0h60n4tF/IJliQPc5kZfM5q+GZqhEFRsRpeR6adhAM9qOXTgWmTVVIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4159
X-Proofpoint-ORIG-GUID: PBU3nElXkFHfrhcc0f-Ghj4jiNogLn7j
X-Proofpoint-GUID: PBU3nElXkFHfrhcc0f-Ghj4jiNogLn7j
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_10,2023-11-21_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTm92IDIxLCAyMDIzLCBhdCAxMjoyM+KAr1BNLCBMaW51cyBUb3J2YWxkcyA8dG9y
dmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4gIS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+
ICBUaGlzIE1lc3NhZ2UgSXMgRnJvbSBhbiBFeHRlcm5hbCBTZW5kZXINCj4gDQo+IHwtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tIQ0KPiANCj4gT24gTW9uLCAyMCBOb3YgMjAyMyBhdCAxNjo1MiwgTmljayBUZXJyZWxsIDxu
aWNrcnRlcnJlbGxAZ21haWwuY29tPiB3cm90ZToNCj4+IA0KPj4gKy8qIENhbGxzIFgoTikgZm9y
IGVhY2ggc3RyZWFtIDAsIDEsIDIsIDMuICovDQo+PiArI2RlZmluZSBIVUZfNFhfRk9SX0VBQ0hf
U1RSRUFNKFgpIFwNCj4+ICsgICAgeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPj4g
KyAgICAgICAgWCgwKSAgICAgICAgICAgICAgICAgICAgICBcDQo+PiArICAgICAgICBYKDEpICAg
ICAgICAgICAgICAgICAgICAgIFwNCj4+ICsgICAgICAgIFgoMikgICAgICAgICAgICAgICAgICAg
ICAgXA0KPj4gKyAgICAgICAgWCgzKSAgICAgICAgICAgICAgICAgICAgICBcDQo+PiArICAgIH0N
Cj4+ICsNCj4+ICsvKiBDYWxscyBYKE4sIHZhcikgZm9yIGVhY2ggc3RyZWFtIDAsIDEsIDIsIDMu
ICovDQo+PiArI2RlZmluZSBIVUZfNFhfRk9SX0VBQ0hfU1RSRUFNX1dJVEhfVkFSKFgsIHZhcikg
XA0KPj4gKyAgICB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwN
Cj4+ICsgICAgICAgIFgoMCwgKHZhcikpICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+
PiArICAgICAgICBYKDEsICh2YXIpKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPj4g
KyAgICAgICAgWCgyLCAodmFyKSkgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4+ICsg
ICAgICAgIFgoMywgKHZhcikpICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+PiArICAg
IH0NCj4+ICsNCj4gDQo+IFdoYXQgc2hpdHR5IGNvbXBpbGVycyBkbyB5b3UgbmVlZCB0byBiZSBj
b21wYXRpYmxlIHdpdGg/DQo+IA0KPiBCZWNhdXNlIGF0IGxlYXN0IGZvciBMaW51eCwgdGhlIGFi
b3ZlIGlzIG9uZSBzaW5nbGUgI2RlZmluZToNCj4gDQo+ICAgICNkZWZpbmUgRk9VUihYLHkuLi4p
IGRvIHsgXA0KPiAgICAgICAgWCgwLCMjeSk7IFgoMSwjI3kpOyBYKDIsIyN5KTsgWCgzLCMjeSk7
IFwNCj4gICAgfSB3aGlsZSAoMCkNCj4gDQo+IGFuZCBpdCBkb2VzIHRoZSByaWdodCB0aGluZyBm
b3IgYW55IG51bWJlciBvZiBhcmd1bWVudHMsIGllDQo+IA0KPiAgICBGT1VSKGZuKQ0KPiAgICBG
T1VSKGZuMSxhKQ0KPiAgICBGT1VSKGZuMixhLGIpDQo+IA0KPiBleHBhbmRzIHRvDQo+IA0KPiAg
ICBkbyB7IGZuKDApOyBmbigxKTsgZm4oMik7IGZuKDMpOyB9IHdoaWxlICgwKQ0KPiAgICBkbyB7
IGZuMSgwLGEpOyBmbjEoMSxhKTsgZm4xKDIsYSk7IGZuMSgzLGEpOyB9IHdoaWxlICgwKQ0KPiAg
ICBkbyB7IGZuMigwLGEsYik7IGZuMigxLGEsYik7IGZuMigyLGEsYik7IGZuMigzLGEsYik7IH0g
d2hpbGUgKDApDQo+IA0KPiBzbyB1bmxlc3MgeW91IG5lZWQgdG8gc3VwcG9ydCBzb21lIGNvbXBs
ZXRlbHkgZ2FyYmFnZSBjb21waWxlcg0KPiB1cHN0cmVhbSwgcGxlYXNlIGp1c3QgZG8gdGhlIHNp
bmdsZSAjZGVmaW5lLg0KDQpVcHN0cmVhbSB6c3RkIG1haW50YWlucyBzdHJpY3QgQzg5IGNvbXBh
dGliaWxpdHkuIFdlIGRvIHVzZSBjb21waWxlcg0KZXh0ZW5zaW9ucyB3aGVuIGF2YWlsYWJsZSwg
YnV0IG9ubHkgd2hlbiB3ZSBjYW4gZGV0ZWN0IHRoZSBmZWF0dXJlIGFuZA0KcHJvdmlkZSBhIGNv
cnJlY3QgZmFsbGJhY2sgd2hlbiBpdCBpc27igJl0IGF2YWlsYWJsZS4gRS5nLiBfX2J1aWx0aW5f
Y3R6KCkuDQpFbXB0eSB2YXJpYWRpYyBtYWNyb3MgZmFpbHMgb3VyIEM4OSBjb21wYXRpYmlsaXR5
IENJLCBhcyB3ZWxsIGFzIG91cg0KVmlzdWFsIFN0dWRpb3MgQ0kgWzBdLg0KDQpXZeKAmXZlIGRp
c2N1c3NlZCBkcm9wcGluZyBDODkgc3VwcG9ydC4gVGhlIGNvbnNlbnN1cyB3YXMgdGhhdA0KaWYg
d2Ugd2VyZSBzdGFydGluZyB0aGUgcHJvamVjdCB0b2RheSB3ZeKAmWQgc3RpY2sgdG8gQzExLCBi
dXQgdGhhdCBpdCBpcw0Kd29ydGgga2VlcGluZyBDODkgc3VwcG9ydCBmb3IgWnN0ZC4gV2XigJl2
ZSBzZWVuIHBlb3BsZSBjb21waWxlDQp6c3RkIGluIHNvbWUgd2Fja3kgZW52aXJvbm1lbnRzLg0K
DQpXLnIudC4gZG8geyB9IHdoaWxlICgwKSwgb3VyIG9sZGVyIFZpc3VhbCBTdHVkaW9zIENJIGpv
YnMgZmFpbGVkIG9uIHRoZQ0KZG8geyB9IHdoaWxlICgwKSBtYWNyb3MsIGJlY2F1c2UgaXQgY29t
cGxhaW5lZCBhYm91dCBjb25zdGFudCBmYWxzZQ0KYnJhbmNoZXMuIEhvd2V2ZXIsIGl0IGxvb2tz
IGxpa2Ugb3VyIGN1cnJlbnQgVmlzdWFsIFN0dWRpb3MgQ0kgam9icw0KYWNjZXB0IGRvIHsgfSB3
aGlsZSAoMCkgWzFdLiBTbyBJ4oCZdmUgb3BlbmVkIGFuIHVwc3RyZWFtIGlzc3VlIHRvDQptb2Rl
cm5pemUgYWxsIG9mIG1hY3JvcyBbMl0uDQoNCkJlc3QsDQpOaWNrIFRlcnJlbGwNCg0KWzBdIGh0
dHBzOi8vZ2l0aHViLmNvbS90ZXJyZWxsbi96c3RkL3B1bGwvMw0KWzFdIGh0dHBzOi8vZ2l0aHVi
LmNvbS90ZXJyZWxsbi96c3RkL3B1bGwvNA0KWzJdIGh0dHBzOi8vZ2l0aHViLmNvbS9mYWNlYm9v
ay96c3RkL2lzc3Vlcy8zODMwDQoNCj4gICAgICAgICAgICAgICBMaW51cw0KDQo=
