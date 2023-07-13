Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332567525A5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjGMOxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjGMOxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:53:13 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB21270D;
        Thu, 13 Jul 2023 07:53:09 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36DAi0Nc001540;
        Thu, 13 Jul 2023 09:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-id:content-transfer-encoding:mime-version;
         s=PODMain02222019; bh=MR4jVEvUIahGtitGHMRSMfFYs7ZKw/KyxxynSn8z9
        xA=; b=KRQIGk5Q5eYoje8D+HkcwRGrnD5ZN4hbbIdVLLZVUrr3UnZSQk25SDrPB
        hL4uMQhMT6zdcDxgPAtkySiN4Wdc6kQRge/U0gFrd4BkI9KTiZVk2PNUySE8Heq/
        F4MVd0e3z3jUPyseZ1HJmBblrjiej86Prl6FsdfwH+Kqsz6Nt3D0qlDb7M2Hcij5
        7hFmDx5kyhm8j+f0wL2lxqQ6I0hmiK1s4TiJ3jSmDCyVt7rPIfvg8u0Lgob8IkMi
        o0kmcxCfYQbvuhNo43nDE3vJF3OMpb3c2UE+omCjxez5KSbsQvgINafz5K/l5HwW
        6ojpELD2W8QHTPRbPdeYs3o6bA0zg==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3rrtepucxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 09:53:07 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgsh6dxJvHsOQEUjTKZRyHxl156/t6pZKpONAYNG8AFoK+hLFW6MzCVp7fidYB1weL7TEz4xzR1wyVzvUywkAUugQ/Kd98/oZRomQ6Zqc9N+dyWgRwice3pPSQ0fYm64SNz3EsRXRY6UGtA19tK6Wf/oqm6GmvxME26vHpVuTLQ7O/l/h71QuqJbgMc6TSm8NmJq/Sy6Il08v0xGL7JWnG5ZXSeA3r9mXOcb5DlL+aPsVMO7MeMr4g1TeEn6mCj57WgIKXFMaGH6xlaFfxlZ6XhgwkWZORHXYOE7Y8tBT+DWG2bw2iuEbWNuB2W1tf1avuxUGDvvXXNBK9qGeDjFNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MR4jVEvUIahGtitGHMRSMfFYs7ZKw/KyxxynSn8z9xA=;
 b=F+CjHjEj9fky7V2HRuoXR4XPYfX8zgaZMMhvbaGmNruogFlkAvrHzj4PYm1+hxFyf9A4RD7cusMFcm7d4oMHyBL+BPVyPaQ6tIlggzc00cbI1I/pxur/BpnZvBLBwmpqzxPv4Z/XlsJp3SfHvSnX3Ya6sRjEyOX/sTEnenFhiypxsVg1qqVYXuxIns9PuQOuiptAn09wUuAtaGj4bsXULLO5u+vmx/jbPuJ+GBgHeGJ1VUyMZUhInKxd+4HmO5VqF7cMW1WdDS+2W2TmuUYVOHR2Ozg3FkeKilHYMPJUGHrGJSN5lbXE0X8lJk3gkqHhhBe+5Y7cCZauuTRV+jS/3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirrus.com; dmarc=pass action=none header.from=cirrus.com;
 dkim=pass header.d=cirrus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MR4jVEvUIahGtitGHMRSMfFYs7ZKw/KyxxynSn8z9xA=;
 b=yYGFcY+kPhgjP+vnBaI3uCVlQ/AK4n24rCMFGHLW/dvYITFmCo2knEBEbXfnYoW37RTSQ1MvOnpzrxxKKLAA4yohNwgPXa69klrBESz9gWRdddjo17KJAxTcuGYUks5bIchMZiy60SGG8QoL8feV07HG6gijdeBjgAiwj63QMrM=
Received: from BN8PR19MB3057.namprd19.prod.outlook.com (2603:10b6:408:95::13)
 by CY8PR19MB7156.namprd19.prod.outlook.com (2603:10b6:930:50::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Thu, 13 Jul
 2023 14:53:02 +0000
Received: from BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::81ad:2413:ec2b:455d]) by BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::81ad:2413:ec2b:455d%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 14:53:02 +0000
From:   James Ogletree <James.Ogletree@cirrus.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] Input: support pre-stored effects
Thread-Topic: [RESEND] Input: support pre-stored effects
Thread-Index: AQHZnWZJRPFp0nzRyka5D0UkE35WMK+3+JkA
Date:   Thu, 13 Jul 2023 14:53:02 +0000
Message-ID: <8222E19A-FE7E-4822-AD30-4CC380930994@cirrus.com>
References: <20230612194357.1022137-1-james.ogletree@cirrus.com>
In-Reply-To: <20230612194357.1022137-1-james.ogletree@cirrus.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR19MB3057:EE_|CY8PR19MB7156:EE_
x-ms-office365-filtering-correlation-id: 19418543-e76f-4c9a-1660-08db83b0db88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T+t7cYQn4mS1Uw02omPkL8rWCsS/PFqhFIaSH+RG7uo90cRGU5W4gOklLevJkU8iBBJ5Hf6axgr4c/sQEA+/90CD73rIm6ksBtguXBlcOpfs8OmS+81wlGkn7Ff8+ZaqbsgqOhAoB22zWQKIs1nSu1c0ScVbNmjUTocBREuha0WvBiIZVNMssfPduj3/k8WdBFJ9nLYINCijz2EURHZ3qYxhXLI1+En56XlVevFHplZHFoDiNmeAW/PPQ3O5yUNoJVA2ifc107bP2YiKMlpCQAI2mxfNUhYNq6KDclOCCNcahq6w2WR7AKwIBm/Ow4jq31DxyystfpzxuBANbZdmxCpOJJxO4pB1OR1eLf70jtghbzXdCxKyBHK3eOCYR9R8ING9d86ebfABUCWJpztV3KWK+/zNhZlYXB2OAHaIyDLFnSjfKe/YRDL/AoT55wVfNfLnrJt1ujdxQVRwLOhsyX7Md3iQ3wEamvCtMT0XtWk7lx5Gjs7LpYDfLHqvPsKs6UdQf/H2tqPAtwvpRRmSYJtBJr0kFC8ZCHGo8AVVgaZVHWJMgc8lfwpfiuOEhIcrmlXftL1awl4KBra/rrI+EvB747IPMxqB/67SkMvk19+BnqwK8LSUwBH20mxqpYbrxmchTsXkRJEKfOGCe+QtwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR19MB3057.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39850400004)(346002)(366004)(136003)(451199021)(478600001)(6486002)(54906003)(91956017)(71200400001)(83380400001)(2616005)(36756003)(38070700005)(86362001)(76116006)(2906002)(53546011)(33656002)(186003)(26005)(6506007)(6512007)(38100700002)(122000001)(66446008)(64756008)(4326008)(66946007)(66476007)(6916009)(41300700001)(316002)(8676002)(5660300002)(66556008)(8936002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEJJNHpRZ1Z1TTV1UUhqcHdDek14R0NYdnJWbitFcWF4NmRwQit1WWZFbzAv?=
 =?utf-8?B?dXJQRUdaT2syRjU0a3FUR2NDOFVlazAyZ3VsdHhGR2tTZmMrV3BMUkZkNU5R?=
 =?utf-8?B?TnoxVGFMWGJGcXZ3RWdiNGVreVE3VFJ2REpRbGM1bi9OUFFHdFJtdTRoMFhs?=
 =?utf-8?B?alJXcFVFRk9qZ3o1OVcwcHkvNEFKdEJRY3pTQUNDeEhrY3VaVnZWcXVNejF4?=
 =?utf-8?B?Z0NLMUxCUlljaUR6R05kRXhJbDF1QkxlZDdneXdlK25oR01ydldJOTZRSEs1?=
 =?utf-8?B?S2lLTnZLT3dxVnJ6eE05ZjVtazVMUVVtcVRxU01XTngrR3BkMVJYTCtHT0k4?=
 =?utf-8?B?VjNrcEhUdGMvbWUycXZKTnRFclppOWJSY0p6NXR3Y1dySUYwOXI3dlNXUUtm?=
 =?utf-8?B?SXBBbjAwTURjMWgvOFVZaGY0ZHpEa1czK0FBQkl1dHZkc2pFS1ZQa2NxdlBu?=
 =?utf-8?B?aERSM0ZFcG5FK29VbERCa3FzanVLWHovZGJ1Y0FyZllheGprU0pSWVliK1Nm?=
 =?utf-8?B?L1FMb2Q3cGFTK3VpRUdqTXdxK0Vkd00rNURYT2VCQVFaOHB2bHoxUHNJZkx2?=
 =?utf-8?B?QXh2U2diT0hVY0svTHF4ZG9tYnM3K0JydjdnOGd2TndNTmFDbnFPWmVKQWpB?=
 =?utf-8?B?UzFhNVlQZW1ybXBWbXU0cnZFY3BMTUdJeFRQMCtSRVg4c3V5U2daYmhETXFF?=
 =?utf-8?B?YThSVkJpaStqUHQ5VjdoZ3IxaW45bHFDUlNBQmhVK0c0RU4ybG92aERkcTBR?=
 =?utf-8?B?ZEtBbjJqTHE0Y1BXVXEvZERpa3pmNk9pQlJkMnBXaWpmc25yQTBVM1p6aVU4?=
 =?utf-8?B?TE5pSDVwK1NkaGYvQWZoQWgxTHFBOWdyZ1Q0akY2Y2dWZE5xTDBHYk9NREQr?=
 =?utf-8?B?ei9oTlkxTTkyOHZmalNmSGszR20rSE1JTzYzOHcwTzJ5Vkd1b2M0V3FqZ1Fz?=
 =?utf-8?B?U00yM2FVSWUydk5DZEUrMG01eUJPZnVpcUx6ekNsUGl6QVVKZlh0SVRxRS9O?=
 =?utf-8?B?enQ1MEhEaXZPZ0dmWmZVbWt1amlRcXhKRTJ4b05CbXo4T1hQc0xRa2R2WTFu?=
 =?utf-8?B?dmlHVVlmclpDc3YrWG5MSmxDTkpEeCtielZmd2NjZDArbTU5LzgwV2RaZ0pP?=
 =?utf-8?B?cjhhQ1VRcVhsVmlyS05WZiszbTJaUXNmNG51c1hWRkhhbW5kVWlvclRRbWRC?=
 =?utf-8?B?ZVNCWkkvRFhtWW5QVTEyV25kWUc5Qkd5YnVxc28xVUlPSWFaVE00Q2JIalZY?=
 =?utf-8?B?UHRVdU5hQU92VVFmaUFEc29VVHA3NHI4dndQMTZoV1BoSEJZSlozN1U5UDUr?=
 =?utf-8?B?dTBsVFFDWVBMcUxoalZmZ0dCZ2RzVmkxenBGZHE4bDE3aWdaNklGcUtjNVNi?=
 =?utf-8?B?T3J3dUpNc2E5MnYxUnozYTY3ZUFmTkFxVDJveWtzME82T1QydXJaa2NMWGFQ?=
 =?utf-8?B?NHFJNThScmNRbjN3ZCtvUEc0MWNNMnNtazRqeE5MSzdaNWh6ZEsrYkk3NlJC?=
 =?utf-8?B?RitjMDlnSUhPOUoyMFY4dEtZVERxQ1FHVEgrVGhSQUk5WmVLNkI5YU9xblZO?=
 =?utf-8?B?dnVVMjVGbFZGWUNBQzZlWTIzZmxYSFJHL0dUaUpXa2dnRVdXQjFuSXB4dTVT?=
 =?utf-8?B?NkxaSVhUZXRYU2ZVTnNNMk9tRVRxNkhrcW92SlRzN2MvRzBCaktiTUY4K25O?=
 =?utf-8?B?M0ZGbTNSeklpOW1zeEpYdGdPUDczSUJxaXpReC9GRDJqVU56T0hhRHkzSzdX?=
 =?utf-8?B?SjFwMmRpNjRNWkZqdGZVUklaZENGUUlNVm5aVHBiWnNpYTR1czBhdGR3RGZD?=
 =?utf-8?B?Rm9yd3kwMTJPU3hxcSs1RDJrQy8vUGYweVV3a3I0cHhFdjNpa1dGRWduSmlC?=
 =?utf-8?B?dlpjVzN1R05rbzFobTMvMU1QQ2pTYUxqVFhacjhtOEN2YnJLM01jVGY1Vmgx?=
 =?utf-8?B?SmhoREo5Y3NwZDhKRHhHNXR1RUl5d1JIN1pRTkZwSEtJRzZPd29KMUNEdFFq?=
 =?utf-8?B?MUhIMjhZTklzdlUwY1gydlJRUWF5bFh5eFV2MmQ3VGV4VmFMOGhqbjdrZEpn?=
 =?utf-8?B?Tll0U1Y0THc5RDRqYldyTWlJeFhGbjJNQjdVY1hiTkZJQ2tTR2R6TTU4T1pk?=
 =?utf-8?B?eHpqeFpGL1kzL3hzY0RHRnU4U0lDRGxwZW9ycU1HOUUyWUhPTWVTTEI5QjhM?=
 =?utf-8?B?S1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28436D3A58FD8549A67ABE72B255ADFC@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cirrus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR19MB3057.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19418543-e76f-4c9a-1660-08db83b0db88
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 14:53:02.3483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xt3fYCX+CDs1eIkL4+3ko2mib5Twydc6wrOgV8AftbclxVYygIyGjhJ9Z7AVuhaqAyAgLu6KqJ77TgH9XErJowVoClOduKNCPDhIVOROt50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB7156
X-Proofpoint-GUID: W6NjsUMoqLEQjSoPADO8XNCUpEohqgNH
X-Proofpoint-ORIG-GUID: W6NjsUMoqLEQjSoPADO8XNCUpEohqgNH
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG1pdHJ5LA0KDQo+IE9uIEp1biAxMiwgMjAyMywgYXQgMjo0MyBQTSwgSmFtZXMgT2dsZXRy
ZWUgPEphbWVzLk9nbGV0cmVlQGNpcnJ1cy5jb20+IHdyb3RlOg0KPiANCj4gQXQgcHJlc2VudCwg
dGhlIGJlc3Qgd2F5IHRvIGRlZmluZSBlZmZlY3RzIHRoYXQNCj4gcHJlLWV4aXN0IGluIGRldmlj
ZSBtZW1vcnkgaXMgYnkgdXRpbGl6aW5nDQo+IHRoZSBjdXN0b21fZGF0YSBmaWVsZCwgd2hpY2gg
aXQgd2FzIG5vdCBpbnRlbmRlZA0KPiBmb3IsIGFuZCByZXF1aXJlcyBhcmJpdHJhcnkgaW50ZXJw
cmV0YXRpb24gYnkNCj4gdGhlIGRyaXZlciB0byBtYWtlIG1lYW5pbmdmdWwuDQo+IA0KPiBQcm92
aWRlIG9wdGlvbiBmb3IgZGVmaW5pbmcgcHJlLXN0b3JlZCBlZmZlY3RzIGluDQo+IGRldmljZSBt
ZW1vcnkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBPZ2xldHJlZSA8amFtZXMub2dsZXRy
ZWVAY2lycnVzLmNvbT4NCj4gLS0tDQo+IGluY2x1ZGUvdWFwaS9saW51eC9pbnB1dC5oIHwgMzIg
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4gMSBmaWxlIGNoYW5nZWQsIDIyIGlu
c2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
dWFwaS9saW51eC9pbnB1dC5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L2lucHV0LmgNCj4gaW5kZXgg
MjU1N2ViN2IwNTYxLi42ODllNWZhMTA2NDcgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvdWFwaS9s
aW51eC9pbnB1dC5oDQo+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9pbnB1dC5oDQo+IEBAIC00
MjgsMTcgKzQyOCwyNyBAQCBzdHJ1Y3QgZmZfcnVtYmxlX2VmZmVjdCB7DQo+IF9fdTE2IHdlYWtf
bWFnbml0dWRlOw0KPiB9Ow0KPiANCj4gKy8qKg0KPiArICogc3RydWN0IGZmX3ByZXN0b3JlZF9l
ZmZlY3QgLSBkZWZpbmVzIHBhcmFtZXRlcnMgb2YgYSBwcmUtc3RvcmVkIGZvcmNlLWZlZWRiYWNr
IGVmZmVjdA0KPiArICogQGluZGV4OiBpbmRleCBvZiBlZmZlY3QNCj4gKyAqIEBiYW5rOiBtZW1v
cnkgYmFuayBvZiBlZmZlY3QNCj4gKyAqLw0KPiArc3RydWN0IGZmX3ByZXN0b3JlZF9lZmZlY3Qg
ew0KPiArIF9fdTE2IGluZGV4Ow0KPiArIF9fdTE2IGJhbms7DQo+ICt9Ow0KPiArDQo+IC8qKg0K
PiAgKiBzdHJ1Y3QgZmZfZWZmZWN0IC0gZGVmaW5lcyBmb3JjZSBmZWVkYmFjayBlZmZlY3QNCj4g
ICogQHR5cGU6IHR5cGUgb2YgdGhlIGVmZmVjdCAoRkZfQ09OU1RBTlQsIEZGX1BFUklPRElDLCBG
Rl9SQU1QLCBGRl9TUFJJTkcsDQo+IC0gKiBGRl9GUklDVElPTiwgRkZfREFNUEVSLCBGRl9SVU1C
TEUsIEZGX0lORVJUSUEsIG9yIEZGX0NVU1RPTSkNCj4gKyAqIEZGX0ZSSUNUSU9OLCBGRl9EQU1Q
RVIsIEZGX1JVTUJMRSwgRkZfSU5FUlRJQSwgRkZfUFJFU1RPUkVELCBvciBGRl9DVVNUT00pDQo+
ICAqIEBpZDogYW4gdW5pcXVlIGlkIGFzc2lnbmVkIHRvIGFuIGVmZmVjdA0KPiAgKiBAZGlyZWN0
aW9uOiBkaXJlY3Rpb24gb2YgdGhlIGVmZmVjdA0KPiAgKiBAdHJpZ2dlcjogdHJpZ2dlciBjb25k
aXRpb25zIChzdHJ1Y3QgZmZfdHJpZ2dlcikNCj4gICogQHJlcGxheTogc2NoZWR1bGluZyBvZiB0
aGUgZWZmZWN0IChzdHJ1Y3QgZmZfcmVwbGF5KQ0KPiAgKiBAdTogZWZmZWN0LXNwZWNpZmljIHN0
cnVjdHVyZSAob25lIG9mIGZmX2NvbnN0YW50X2VmZmVjdCwgZmZfcmFtcF9lZmZlY3QsDQo+IC0g
KiBmZl9wZXJpb2RpY19lZmZlY3QsIGZmX2NvbmRpdGlvbl9lZmZlY3QsIGZmX3J1bWJsZV9lZmZl
Y3QpIGZ1cnRoZXINCj4gLSAqIGRlZmluaW5nIGVmZmVjdCBwYXJhbWV0ZXJzDQo+ICsgKiBmZl9w
ZXJpb2RpY19lZmZlY3QsIGZmX2NvbmRpdGlvbl9lZmZlY3QsIGZmX3J1bWJsZV9lZmZlY3QsIGZm
X3ByZXN0b3JlZF9lZmZlY3QpDQo+ICsgKiBmdXJ0aGVyIGRlZmluaW5nIGVmZmVjdCBwYXJhbWV0
ZXJzDQo+ICAqDQo+ICAqIFRoaXMgc3RydWN0dXJlIGlzIHNlbnQgdGhyb3VnaCBpb2N0bCBmcm9t
IHRoZSBhcHBsaWNhdGlvbiB0byB0aGUgZHJpdmVyLg0KPiAgKiBUbyBjcmVhdGUgYSBuZXcgZWZm
ZWN0IGFwcGxpY2F0aW9uIHNob3VsZCBzZXQgaXRzIEBpZCB0byAtMTsgdGhlIGtlcm5lbA0KPiBA
QCAtNDY0LDYgKzQ3NCw3IEBAIHN0cnVjdCBmZl9lZmZlY3Qgew0KPiBzdHJ1Y3QgZmZfcGVyaW9k
aWNfZWZmZWN0IHBlcmlvZGljOw0KPiBzdHJ1Y3QgZmZfY29uZGl0aW9uX2VmZmVjdCBjb25kaXRp
b25bMl07IC8qIE9uZSBmb3IgZWFjaCBheGlzICovDQo+IHN0cnVjdCBmZl9ydW1ibGVfZWZmZWN0
IHJ1bWJsZTsNCj4gKyBzdHJ1Y3QgZmZfcHJlc3RvcmVkX2VmZmVjdCBwcmVzdG9yZWQ7DQo+IH0g
dTsNCj4gfTsNCj4gDQo+IEBAIC00NzksMjAgKzQ5MCwyMSBAQCBzdHJ1Y3QgZmZfZWZmZWN0IHsN
Cj4gI2RlZmluZSBGRl9EQU1QRVIgMHg1NQ0KPiAjZGVmaW5lIEZGX0lORVJUSUEgMHg1Ng0KPiAj
ZGVmaW5lIEZGX1JBTVAgMHg1Nw0KPiArI2RlZmluZSBGRl9QUkVTVE9SRUQgMHg1OA0KPiANCj4g
I2RlZmluZSBGRl9FRkZFQ1RfTUlOIEZGX1JVTUJMRQ0KPiAtI2RlZmluZSBGRl9FRkZFQ1RfTUFY
IEZGX1JBTVANCj4gKyNkZWZpbmUgRkZfRUZGRUNUX01BWCBGRl9QUkVTVE9SRUQNCj4gDQo+IC8q
DQo+ICAqIEZvcmNlIGZlZWRiYWNrIHBlcmlvZGljIGVmZmVjdCB0eXBlcw0KPiAgKi8NCj4gDQo+
IC0jZGVmaW5lIEZGX1NRVUFSRSAweDU4DQo+IC0jZGVmaW5lIEZGX1RSSUFOR0xFIDB4NTkNCj4g
LSNkZWZpbmUgRkZfU0lORSAweDVhDQo+IC0jZGVmaW5lIEZGX1NBV19VUCAweDViDQo+IC0jZGVm
aW5lIEZGX1NBV19ET1dOIDB4NWMNCj4gLSNkZWZpbmUgRkZfQ1VTVE9NIDB4NWQNCj4gKyNkZWZp
bmUgRkZfU1FVQVJFIDB4NTkNCj4gKyNkZWZpbmUgRkZfVFJJQU5HTEUgMHg1YQ0KPiArI2RlZmlu
ZSBGRl9TSU5FIDB4NWINCj4gKyNkZWZpbmUgRkZfU0FXX1VQIDB4NWMNCj4gKyNkZWZpbmUgRkZf
U0FXX0RPV04gMHg1ZA0KPiArI2RlZmluZSBGRl9DVVNUT00gMHg1ZQ0KPiANCj4gI2RlZmluZSBG
Rl9XQVZFRk9STV9NSU4gRkZfU1FVQVJFDQo+ICNkZWZpbmUgRkZfV0FWRUZPUk1fTUFYIEZGX0NV
U1RPTQ0KPiAtLSANCj4gMi4yNS4xDQo+IA0KDQpJcyB0aGVyZSBzb21ldGhpbmcgbW9yZSB5b3Xi
gJlkIGxpa2UgdG8gc2VlIG9yIGRpc2N1c3MgYmVmb3JlIGNvbnNpZGVyaW5nIGFwcGx5aW5nIHRo
aXM/DQoNCkJlc3QsDQoNCkphbWVz
