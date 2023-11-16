Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771BD7EDBF0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjKPH0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjKPH0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:26:35 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2089.outbound.protection.outlook.com [40.107.255.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40200A1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 23:26:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMqYXjpwd9+TMAN6PDDjSEC9An+cnnRHRJd9aSq+4mA9x2SYHRsRdd2FgLaCLiJQnqGhCBkYx7ECWcVMk7L5c2LDQd+PN3d4lHTYiP0mucoEF+ylZ/0CbUYtV1mA2AfvQXL2G9/blvRmEJOC0QWf1qluLm/aH1tH7446oTbGhyxo2rJxI5svjF+ZSc2fKy7kzY7LuLfaEiaUtwIbM/bDo05i4f6kPCGDSrZTOf7E/P5vW+o8ERDxl2R4Unkbc02i3HP92aW+ZDXMVdf77cEQYps4+7Xw5aeFjthJrtVlultM4PhMYycKgrtfkc221t6AtgKuZmjcdjosuVBPQMsGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ulzwv2rNKmYhNi3tvJrRTCE+VGIICI1Vu/dvDjloO4=;
 b=Pc9ssU8WOszi/ls4js32INhQhUd29PK0PIrVa86JMbEcp3iToPwp0P/p9b/qn1iN207QTehOK7dThc/i/gf5pg0zM5hrCI56DHUKMZkuIpAUQsuzxt6owO7kYfSRxbOZIFFRurno55Hs6fhm0Srdi5sA1sTixJFr0/Pi30SDEwYvdLBO1nnjCMQtBEeq04cLjPcUB7ZfMvXmp8A/SiwJfDpt+cMS6tH0RO2pYu42mCnkGM7A5GjQMfF6G6rQTGTIaCqYBCbgbAoLfGPa51k6PwYiOGzsitZaSfMVCzEcxfBoHP63yH7eSX7hqcvacMykLSfk4AJjJkq1FULsR5C1kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ulzwv2rNKmYhNi3tvJrRTCE+VGIICI1Vu/dvDjloO4=;
 b=LUwxCqF/Xsrvj0FhAEn29buQUQ8xMlUeFSE7g1s2tzbF7wW6jO+I1Y3fAwZD9izMrRsjIT8SJFdh51rKK+fWdRDjFxpwagbHfMNU2GTHjmIEKdbE1cvaGwg0ffv/fqoSYaZ3yAR2RwN1INR8BzviNyCC66W6UHw0cJD5Dths9nU=
Received: from SEYPR02MB5653.apcprd02.prod.outlook.com (2603:1096:101:56::11)
 by OSQPR02MB7791.apcprd02.prod.outlook.com (2603:1096:604:27b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 07:26:28 +0000
Received: from SEYPR02MB5653.apcprd02.prod.outlook.com
 ([fe80::164b:4e8c:754e:f133]) by SEYPR02MB5653.apcprd02.prod.outlook.com
 ([fe80::164b:4e8c:754e:f133%4]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 07:26:27 +0000
From:   =?gb2312?B?u8bU2dH6KEpveXlvdW5nIEh1YW5nKQ==?= 
        <huangzaiyang@oppo.com>
To:     Tejun Heo <tj@kernel.org>
CC:     "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ZaiYang Huang <hzy0719@163.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSB3b3JrcXVldWU6IE1ha2UgYSB3YXJuaW5nIHdoZW4g?=
 =?gb2312?Q?a_pending_delay_work_being_re-init?=
Thread-Topic: [PATCH] workqueue: Make a warning when a pending delay work
 being re-init
Thread-Index: AQHaF7e485deNRHlL02AO2lniLj2nrB8QiMAgABJxZA=
Date:   Thu, 16 Nov 2023 07:26:27 +0000
Message-ID: <SEYPR02MB5653EF3D5C5D02E3A1F6F08AA3B0A@SEYPR02MB5653.apcprd02.prod.outlook.com>
References: <20231115113427.1420-1-huangzaiyang@oppo.com>
 <ZVWFWh_HL_wzYyd1@mtj.duckdns.org>
In-Reply-To: <ZVWFWh_HL_wzYyd1@mtj.duckdns.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR02MB5653:EE_|OSQPR02MB7791:EE_
x-ms-office365-filtering-correlation-id: 45813d10-8532-49ac-cadc-08dbe67558b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pYnlP8huksaJVPE6LSDbgKijRuMKAYgMv78kGW0UWRX+QEAgz+C8Y/WPWzLtFkN/RFK8KGfb/11VnAqE0ByM/s9ca0jp0XJ/+uwirfkgTeCl6VL7NLbAo3RpOac3ywjsyuxG70g23a5gSSE3TVhHsTEJj2NtDNcAQnfz5BTkVnGzngRR13WobcfuJqPr8J8LlDtuc33eEaJPiqPVMFeAbLpJUgoPXX76P7QSK3DIDY+Q8bxDCU/eeBHkDCN45+p/rpqdp11O0/vgJDcQVeT94XVSC1O5ZxScT7FYFApJRyHJChnuvey4odpcg3cjQYc6L+y488rO2n5UfKk9RNbMwacyygG//Mzfut3z1F51L+48MZdjqGYlrEjL6X8W7k0TrBofo6PmG10SmQI50/qDQptxbWbVOgv3TBch/vwSwhSbMMP5hwoyq/rCdy3Fa/FQMlHLVglpga5lY8BCLgRapib/wStu51TU38/TR9ylkaUmYrQpmOvpAUqY76hHFtn4f9XLpIVVO3qkWBBr8GmLl3ibLhsZJkCUC3Y0epAM6VmAX8wfFM9AKH2HwoZsRvKALS2IsOH3YTWOBbfY+QLpxHYG2HiGfIMDDcID7SDb9yaCVwBnO9Pzp9S/O4clfI8F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR02MB5653.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(366004)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(83380400001)(7696005)(9686003)(26005)(6506007)(71200400001)(316002)(6916009)(55016003)(224303003)(66476007)(64756008)(54906003)(66446008)(66556008)(66946007)(4326008)(76116006)(52536014)(38100700002)(85182001)(38070700009)(8936002)(2906002)(33656002)(41300700001)(86362001)(5660300002)(478600001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SVNRRGFUYTBCdFBpV0ZMK1Q2QTMvd1diQmw4ZllwcmJLNG1DSUFyU3RRQVFC?=
 =?gb2312?B?TlVKRDRnQzEwWnZvbFBnU2dzK3phaWYvQ3lMQnFsYWpWaG4xcUNyMFdxVWoz?=
 =?gb2312?B?WE5ETVk1bmZ2TEZJZmhFWVRlWUdiVW0va2E2MXpWQm4yNGpOTi90bUxUcjdG?=
 =?gb2312?B?YU9DVCtVamJYb21IVmxWZjYvOFVGamw3KzlLcS9Gdi9XMGpBT2thTm50akhD?=
 =?gb2312?B?a2JBamtGd2FrVjRNY1paN1RhMjNRSDRyZFJ4ZXRHRmFwSTQ4dEFMVmhWbVRO?=
 =?gb2312?B?QzQ3ekxnMlFmVlR5SGtQNCtyN2JOU0lSNjYwYlFIbG02dzd1M05UeTYvSXls?=
 =?gb2312?B?enJuSlJqaTZJNk91S21CdVVaZTBnT0M0L3dURTdEemFMdFlRRmlVMVlnbm1v?=
 =?gb2312?B?d1NTNW8yWXBZK2dOeGhCUmNEZDYyd0VMUUJjQk1TdXZnV0tXMTZ3eEd2bVN1?=
 =?gb2312?B?ZUd0Y1IzVVEyaTROQ1Z0V2VmeG8yckFIUnZYK0sxY2tiNkptVlBWTTE0Sm1W?=
 =?gb2312?B?bE1FVHhaOEFtRzMwU2dmMXE5UW96Z044L05WakpMQmVqYjZQOHlEa2lVTDZH?=
 =?gb2312?B?U0NuTVVTb1NhS1lXM0NrYXRBVUF3bWNSd0JUZ0N5Wi94ek92dVBUVWs1elFa?=
 =?gb2312?B?T051Q292RWNVRkNENDc3YitWQ204WjdoYWV0NHJ3MUdyTDE1Z0tPT2kzNmNQ?=
 =?gb2312?B?eTh0Mk5LSjhhZmgwZWxBK0FmamZXUUtnaU1BbnpaTkdsd0JQV2QybWZ4TnNy?=
 =?gb2312?B?TUYzT2E4SzRxY3pQZkpkOHRXVXBMYWxhWlR4Q1dZbUdtNmd5eGNWb2l0L0ky?=
 =?gb2312?B?eUc5VE0yZHZMS1czdkZkVU0wclYyalRZWFJlU29RaTl1WXprckpDMGJWb2w5?=
 =?gb2312?B?QitDd3d5Z1dYTlZkSllpQ3pNSUVuNkFNdnBPUXFFNzB4WlZjWXplT0ZSUDZI?=
 =?gb2312?B?bkhKbUVoNW41VStPTkZSS1FHRWV0YTdsdnBOSG8xUGJLVEliN3ZTdm5MYjNt?=
 =?gb2312?B?YTYxNGdLZngrRGpVV1pLQ0IwZnE0TGRQN1RVa3ZYdkdQSXlnSUVzT3lUMXZ4?=
 =?gb2312?B?V3FQRmJlV01lQXpvamFJaWRWcUpNNndYQkJ0cUJuVjVDd04zdGhiRTl4bkRQ?=
 =?gb2312?B?TXNhYUErZEdvRFJyclNNU0lJT0hXdVdyT3hNMWFDTFh6SHlQOGNSWkRMTzZZ?=
 =?gb2312?B?U3J6eU9yWGV6cStGNUVwa2Z3SDk2OHM3U2NsS2h2eWw2Si8vYzJxajFlcTRm?=
 =?gb2312?B?ajZuZi9kWS9yOWsxVno1RVdkZUVSQzFTeU51WTJFa1BQQUdNVkZOU0o2Qjdr?=
 =?gb2312?B?RU9jTGlJbDZTRWxvN3hFUXR6M3Y2SlRYM21wT3NLM3JoWThmeTZHTzN3NUo0?=
 =?gb2312?B?eE5helh4SUpjS3d5QTd3dDdTcEsvcmw5OTRCOFplUi9xYUh6Zy8wVURXVjVp?=
 =?gb2312?B?Mk9VQURzbWUrSStyWnlqaGZEMkRIN3BXZC80QzhyWEtWb3BPSzcyZUxQc2xt?=
 =?gb2312?B?bGNkTFRrdDFjOGRXdzRXSHhscmNGeDNycENFNUkrVU9XSjhES2xUbFFVWm1y?=
 =?gb2312?B?d2h4SlJxd25HbTRpTkJFVmFhQU8vV1phLzduQ2R2eHVBblBFK2sxSStWbmox?=
 =?gb2312?B?eFNOSWlPdUt3dHE3OEdVKzQ5V1NpSk9JeXRnYTg1QTRCQTRuVmU1S3Q0RU1p?=
 =?gb2312?B?cmhZanZCTlA3bGlJbnRTU2tiZVZ6bWVETmU1Y2M2UnZ3eU0xbTBCNXVoa08y?=
 =?gb2312?B?MGl3aklUeVI0V1lER2JaUncyK0x0WlBCQlkwTURPWDErUUk1a3NlUnMzeHhG?=
 =?gb2312?B?bm1rL2RVSExUYmN1RDI0My9PdTkzSmp4MlgreGZCWTFHVHpockVRamJaYVAw?=
 =?gb2312?B?YW1KKzFWblhjUWphRW9ueGtxZzRUL0VJMXZjTjY1M015OXJySXV1enU2b0I5?=
 =?gb2312?B?QzEzOGNqeVBJbEp3NWZWV1M4QTJ4UU1ScDVXQW5JK04wU2JVZzkvUmtxSEEv?=
 =?gb2312?B?cHAvN0RrQkozUE9sVlN3R1JRV1B5aFhJQVdTajNRU3FnMVhCUjNuL3RKSllz?=
 =?gb2312?B?ZVQ0Ymx6dURNMlZlWDVJdk5haVlXbnF5Wmk2ZVNkYU94YWVqcGRDL0RSMEpl?=
 =?gb2312?Q?XT1Whp5zwaa6GbhBV9ZO04Xqo?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB5653.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45813d10-8532-49ac-cadc-08dbe67558b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 07:26:27.6941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NXaOGcA3iZleEXK7PnUqnFEXjJXk9z+pvpCAmDa180Gvs8tkcSbAfn5hckcNIun3SatpPhnlliiLr1Pi1+96Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR02MB7791
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,WEIRD_QUOTING autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkhlbGxvLA0KPg0KPk9uIFdlZCwgTm92IDE1LCAyMDIzIGF0IDA3OjM0OjI3UE0gKzA4MDAsIGh1
YW5nemFpeWFuZyB3cm90ZToNCj4+IEBAIC0zMTAsNiArMzI2LDcgQEAgc3RhdGljIGlubGluZSB1
bnNpZ25lZCBpbnQgd29ya19zdGF0aWMoc3RydWN0DQo+PiB3b3JrX3N0cnVjdCAqd29yaykgeyBy
ZXR1cm4gMDsgfQ0KPj4NCj4+ICAjZGVmaW5lIF9fSU5JVF9ERUxBWUVEX1dPUksoX3dvcmssIF9m
dW5jLCBfdGZsYWdzKSAgICAgICAgICAgICAgICAgICAgIFwNCj4+ICAgICAgICAgZG8geyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwN
Cj4+ICsgICAgICAgICAgICAgICBXQVJOX09OKGRlbGF5ZWRfd29ya19wZW5kaW5nKF93b3JrKSk7
ICAgICAgICAgICAgICAgICAgIFwNCj4+ICAgICAgICAgICAgICAgICBJTklUX1dPUksoJihfd29y
ayktPndvcmssIChfZnVuYykpOyAgICAgICAgICAgICAgICAgICAgIFwNCj4+ICAgICAgICAgICAg
ICAgICBfX2luaXRfdGltZXIoJihfd29yayktPnRpbWVyLCAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGVsYXllZF93b3JrX3RpbWVy
X2ZuLCAgICAgICAgICAgICAgICAgICAgIFwNCj4NCj5BcyBwb2ludGVkIG91dCBieSBvdGhlcnMs
IGFzIHdlIGRvbid0IGtub3cgd2hhdCdzIGluIHRoZSBtZW1vcnksIHRoaXMgd291bGRuJ3QgcmVh
bGx5IHdvcmsuIFRoaXMga2luZCBvZiBidWdzIHNob3VsZCBiZSBjYXVnaHQgYnkgREVCVUdfT0JK
RUNUU19XT1JLIC8gREVCVUdfT0JKRUNUU19USU1FUlMsIEkgdGhpbmsuIEl0J3Mgbm90IHBlcmZl
Y3QgYXMgdGhvc2UgYXJlbid0ID51c3VhbGx5IHR1cm5lZCBvbiBidXQgY2F0Y2hpbmcgdGhpcyBz
b3J0IG9mIGVycm9ycyBkb2VzIG5lZWQgdHJhY2tpbmcgc29tZSBpbmZvcm1hdGlvbiBvdXQgb2Yg
YmFuZC4NCg0KVGhhbmtzLCBUaGUgaW5pdGlhbCB2YWx1ZXMgb2YgdmFyaWFibGVzIG9uIHRoZSBo
ZWFwIGFuZCBzdGFjayBhcmUgaW5kZWVkIHJhbmRvbS4gR2l2ZSB1cCB0aGlzIG1vZGlmaWNhdGlv
biBhbmQgd2lsbCB0cnkgdG8gdXNlIERFQlVHX09CSkVDVFNfV09SSyAvIERFQlVHX09CSkVDVFNf
VElNRVJTIHRvIHJlcHJvZHVjZSB0aGUgcHJvYmxlbS4NCi0tDQpodWFuZ3phaXlhbmcNCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQpPUFBPDQoNCrG+tefX09PKvP68sMbkuL28/rqs
09BPUFBPuavLvrXEsaPD3NDFz6KjrL32z97T2tPKvP7WuMP3tcTK1bz+yMujqLD8uqy49sjLvLDI
utfpo6nKudPDoaO9+9a5yM66zsjL1NrOtL6tytrIqLXEx+m/9s/C0tTIzrrO0M7Kvcq508Oho8jn
ufvE+rTtytXBy7G+08q8/qOsx9DO8LSrsqWhorfWt6Khori01sahotOhy6K78sq508OxvtPKvP7W
rsjOus6yv7fWu/LG5Mv51NjWrsjOus7E2sjdo6yyosfrwaK8tNLUtefX09PKvP7NqNaqt6K8/sjL
sqLJvrP9sb7Tyrz+vLDG5Li9vP6how0KzfjC582o0ba5zNPQyLHP3b/JxNy1vNbC08q8/rG7vdjB
9KGi0N64xKGitqrKp6Gixsa7tbvysPy6rLzGy+O7+rKhtr61yLK7sLLIq8fpv/ajrE9QUE+21LTL
wOC07c7zu/LSxcKptvjS/dbC1q7IzrrOy/DKp7jFsruz0LWj1PDIzrKisaPB9NPrsb7Tyrz+z+C5
2Nau0rvH0MiowPuhow0Ks/23x8P3yLfLtcP3o6yxvtPKvP68sMbkuL28/s7e0uLX986q1NrIzrrO
ufq80rvytdjH+Nau0qrUvKGi1dDAv7vys9DFtaOs0uDO3tLi1/fOqsjOus69u9LXu/K6z82s1q7V
/cq9yLfIz6GjILeivP7Iy6GixuTL+cr0u/q5ubvyy/nK9Lv6ubnWrrnYwaq7+rm5u/LIzrrOyc/K
9rv6ubnWrrnJtquhoratysKhorjfvLa53MDtyMvUsaGi1LG5pLvyxuTL+8jOus7Iy6Oo0tTPwrPG
obC3orz+yMuhsbvyobBPUFBPobGjqbK70vKxvtPKvP7Wrs7zy822+LfFxvrG5Mv5z+3WrsjOus7I
qMD7o6zS4LK7ttTS8rnK0uK78rn9yqfKudPDuMO1yNDFz6K2+NL9t6K78r/JxNzS/beitcTL8Mqn
s9C1o8jOus7U8MjOoaMNCs7Eu6+y7tLsxfvCtqO60vLIq8fyzsS7r7Lu0uzTsM/so6y1pbS/0tRZ
RVNcT0u78sbky/u88rWltMq747XEu9i4tLKisru5ubPJt6K8/sjLttTIzrrOvbvS17vyus/NrNau
1f3Kvci3yM+78r3TytyjrMfr0+u3orz+yMvU2bTOyLfIz9LUu/G1w8P3yLfK6cPm0uK8+6Gjt6K8
/sjLsru21MjOus7K3M7Eu6+y7tLs07DP7Lb4tbzWwrnK0uK78rTtzvPKudPDuMO1yNDFz6LL+dTs
s8m1xMjOus7Wsb3Tu/K85L3Ty/C6prPQtaPU8MjOoaMNClRoaXMgZS1tYWlsIGFuZCBpdHMgYXR0
YWNobWVudHMgY29udGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gZnJvbSBPUFBPLCB3aGlj
aCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eSB3aG9zZSBhZGRyZXNz
IGlzIGxpc3RlZCBhYm92ZS4gQW55IHVzZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGhl
cmVpbiBpbiBhbnkgd2F5IChpbmNsdWRpbmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwgb3Ig
cGFydGlhbCBkaXNjbG9zdXJlLCByZXByb2R1Y3Rpb24sIG9yIGRpc3NlbWluYXRpb24pIGJ5IHBl
cnNvbnMgb3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHByb2hpYml0ZWQu
IElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBkbyBub3QgcmVh
ZCwgY29weSwgZGlzdHJpYnV0ZSwgb3IgdXNlIHRoaXMgaW5mb3JtYXRpb24uIElmIHlvdSBoYXZl
IHJlY2VpdmVkIHRoaXMgdHJhbnNtaXNzaW9uIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBz
ZW5kZXIgaW1tZWRpYXRlbHkgYnkgcmVwbHkgZS1tYWlsIGFuZCB0aGVuIGRlbGV0ZSB0aGlzIG1l
c3NhZ2UuDQpFbGVjdHJvbmljIGNvbW11bmljYXRpb25zIG1heSBjb250YWluIGNvbXB1dGVyIHZp
cnVzZXMgb3Igb3RoZXIgZGVmZWN0cyBpbmhlcmVudGx5LCBtYXkgbm90IGJlIGFjY3VyYXRlbHkg
YW5kL29yIHRpbWVseSB0cmFuc21pdHRlZCB0byBvdGhlciBzeXN0ZW1zLCBvciBtYXkgYmUgaW50
ZXJjZXB0ZWQsIG1vZGlmaWVkICxkZWxheWVkLCBkZWxldGVkIG9yIGludGVyZmVyZWQuIE9QUE8g
c2hhbGwgbm90IGJlIGxpYWJsZSBmb3IgYW55IGRhbWFnZXMgdGhhdCBhcmlzZSBvciBtYXkgYXJp
c2UgZnJvbSBzdWNoIG1hdHRlciBhbmQgcmVzZXJ2ZXMgYWxsIHJpZ2h0cyBpbiBjb25uZWN0aW9u
IHdpdGggdGhlIGVtYWlsLg0KVW5sZXNzIGV4cHJlc3NseSBzdGF0ZWQsIHRoaXMgZS1tYWlsIGFu
ZCBpdHMgYXR0YWNobWVudHMgYXJlIHByb3ZpZGVkIHdpdGhvdXQgYW55IHdhcnJhbnR5LCBhY2Nl
cHRhbmNlIG9yIHByb21pc2Ugb2YgYW55IGtpbmQgaW4gYW55IGNvdW50cnkgb3IgcmVnaW9uLCBu
b3IgY29uc3RpdHV0ZSBhIGZvcm1hbCBjb25maXJtYXRpb24gb3IgYWNjZXB0YW5jZSBvZiBhbnkg
dHJhbnNhY3Rpb24gb3IgY29udHJhY3QuIFRoZSBzZW5kZXIsIHRvZ2V0aGVyIHdpdGggaXRzIGFm
ZmlsaWF0ZXMgb3IgYW55IHNoYXJlaG9sZGVyLCBkaXJlY3Rvciwgb2ZmaWNlciwgZW1wbG95ZWUg
b3IgYW55IG90aGVyIHBlcnNvbiBvZiBhbnkgc3VjaCBpbnN0aXR1dGlvbiAoaGVyZWluYWZ0ZXIg
cmVmZXJyZWQgdG8gYXMgInNlbmRlciIgb3IgIk9QUE8iKSBkb2VzIG5vdCB3YWl2ZSBhbnkgcmln
aHRzIGFuZCBzaGFsbCBub3QgYmUgbGlhYmxlIGZvciBhbnkgZGFtYWdlcyB0aGF0IGFyaXNlIG9y
IG1heSBhcmlzZSBmcm9tIHRoZSBpbnRlbnRpb25hbCBvciBuZWdsaWdlbnQgdXNlIG9mIHN1Y2gg
aW5mb3JtYXRpb24uDQpDdWx0dXJhbCBEaWZmZXJlbmNlcyBEaXNjbG9zdXJlOiBEdWUgdG8gZ2xv
YmFsIGN1bHR1cmFsIGRpZmZlcmVuY2VzLCBhbnkgcmVwbHkgd2l0aCBvbmx5IFlFU1xPSyBvciBv
dGhlciBzaW1wbGUgd29yZHMgZG9lcyBub3QgY29uc3RpdHV0ZSBhbnkgY29uZmlybWF0aW9uIG9y
IGFjY2VwdGFuY2Ugb2YgYW55IHRyYW5zYWN0aW9uIG9yIGNvbnRyYWN0LCBwbGVhc2UgY29uZmly
bSB3aXRoIHRoZSBzZW5kZXIgYWdhaW4gdG8gZW5zdXJlIGNsZWFyIG9waW5pb24gaW4gd3JpdHRl
biBmb3JtLiBUaGUgc2VuZGVyIHNoYWxsIG5vdCBiZSByZXNwb25zaWJsZSBmb3IgYW55IGRpcmVj
dCBvciBpbmRpcmVjdCBkYW1hZ2VzIHJlc3VsdGluZyBmcm9tIHRoZSBpbnRlbnRpb25hbCBvciBt
aXN1c2Ugb2Ygc3VjaCBpbmZvcm1hdGlvbi4NCg==
