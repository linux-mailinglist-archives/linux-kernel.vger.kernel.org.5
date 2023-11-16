Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7A87ED87C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 01:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343676AbjKPAWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 19:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjKPAWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 19:22:20 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2048.outbound.protection.outlook.com [40.107.255.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E11A9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 16:22:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=au7jNMG3uFhp1R4BZsC22VqLfLAD1eTY6kp6Y6/2aknlW/OfLLWke2JuNxqGMBnT9ed9sHg45J/4SMLauBHEwZR3pjnsQ4xQhDpB1kNoM2pwbsb7GqynJ+8kpzwGolakApGDJGc0zNPL+R9SVKlvvSmAdvq4NIJVyb5IWtoXQenMAPTBNtn/pBXeMXtKjEUaB9OTNpWPuwud3+45SVc95DPv4XastxYv27bd91Ktthv+m7JnD9udjGGa+k4ni6bMXqyoBzUxxU/Xc0sIpGyg0k1VcoXTmCWnx5+3SPMeHsGXrMirZ0pLEXbcYgxmZoWDtGAo9IgKpbLfqeGBsKSCFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccw//BmWD1lblBGQzmW7iPw9hM0WaP8JYXqwkPF/he4=;
 b=f1ftq5wG8xkwAS17TlCBUf+qsClms+ip2S1UlpziWHcv4j8sJejdsBcDUdt0Sl4BeTe4vKhG6Jt/3Vr1+sC7jZZAYDaq35YR3eLWqkokig+e8Y8gQwqiHEhsviP1d7QXqHo0rBLi3c9aZ+cYSLODgq/RulTeNjko+jF2ugAW0jHFEw3fnA6ImLMhR7Capj/n1GeZzh7GWvUenY/QjEEPK6h5ycuYKDcTVWsPqpRYsJKdi3hQeXZEghNrO2slB6zUTUko9XH8qd7D9fVB2qnqIr1+9kGBWOVnKGzQAwY1xmJAPGYXWqunaGgFT9uaa+5kMPlubIpA5gZT6qGorKjPVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccw//BmWD1lblBGQzmW7iPw9hM0WaP8JYXqwkPF/he4=;
 b=BEJkIyzsB5TTWwjqsvOB189QogxYpjdp6WoKwclp+sskySA0e/bsLyjY39ZQkLePGR+kLfTfvK4r+NHN3ax3DHD/HGxzV5/i5qhfxUC+JTlE7J89oG0lbCd1adFgb3ecmffrPEA47p+L6oqBKYaEJ1pWyhx8k9bP2OxBuElXPVI=
Received: from SEYPR02MB5653.apcprd02.prod.outlook.com (2603:1096:101:56::11)
 by TY0PR02MB6151.apcprd02.prod.outlook.com (2603:1096:400:27b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.36; Thu, 16 Nov
 2023 00:22:12 +0000
Received: from SEYPR02MB5653.apcprd02.prod.outlook.com
 ([fe80::164b:4e8c:754e:f133]) by SEYPR02MB5653.apcprd02.prod.outlook.com
 ([fe80::164b:4e8c:754e:f133%4]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 00:22:11 +0000
From:   =?utf-8?B?6buE5YaN5ry+KEpveXlvdW5nIEh1YW5nKQ==?= 
        <huangzaiyang@oppo.com>
To:     =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <thomas@t-8ch.de>
CC:     "tj@kernel.org" <tj@kernel.org>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ZaiYang Huang <hzy0719@163.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIHdvcmtxdWV1ZTogTWFrZSBhIHdhcm5pbmcgd2hl?=
 =?utf-8?Q?n_a_pending_delay_work_being_re-init?=
Thread-Topic: [PATCH] workqueue: Make a warning when a pending delay work
 being re-init
Thread-Index: AQHaF7e485deNRHlL02AO2lniLj2nrB74eSAgAAz2kA=
Date:   Thu, 16 Nov 2023 00:22:11 +0000
Message-ID: <SEYPR02MB5653CCC06C7EBBD806019A46A3B0A@SEYPR02MB5653.apcprd02.prod.outlook.com>
References: <20231115113427.1420-1-huangzaiyang@oppo.com>
 <54af48a0-2d3c-4888-953b-28760f129d33@t-8ch.de>
In-Reply-To: <54af48a0-2d3c-4888-953b-28760f129d33@t-8ch.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR02MB5653:EE_|TY0PR02MB6151:EE_
x-ms-office365-filtering-correlation-id: 12c504a4-ed93-4589-a346-08dbe63a136f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ardXuWEoUz+Hdccvhh//DI1lWXkBw60txcGpCgJCPstobR9yvdep18gnJ0A/4yurVEpPOg53kQj9iYbjMec1py5j1yjO1UxO6eenff5RrBe0jKR0j2AAJZX26o65k7rE9xd+nRuKwfvsJ02fef9mxNNY3rv2cGWvUWVTIONdeW8zQD5pUsKULyhXV0BBDfsljQZFwbv+lgoy9+SuNr0X33LjRzG/VsuXmq7n2ba721Cwzm+OmU+v2omfjRAQGQakjaWqK2yg2rNoVrbAwR/r8UXHjyTSkws0lvavzTNLa5YonNfPtM7SiB2JnD6r7OL59Vnkol7aNG1jWvEfz3cyPF+X8l5Q9hBdbItMO18OPso/pLZRwUwnxqK1x37Oa7iPRD/Tnca3Zd71UYPBJ7iXeNAZn4N5GuovcX4NwYXKrpPzcMWOpC5mp/NzUfWvSQ31M/oyUM8+r0oBwfO1YK46q1L5qhRprgvx6c2htwhj5HmY1U4XWxgLPVVo5wUu8l5UJxZNzXz2vn+hOYyKkZceINdgTxJNWbwfWbwTYtGhXSAT9iFkYqyMame39RZ1cggXHy0Bd1+z1zuJ5MPp99qvLEAdTT/aB+03Y1MDZZYfBg4SbyhD4EIVpSbvLx1DsGCTmiAng99gShW4hwjKaXPhmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR02MB5653.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(376002)(136003)(346002)(230173577357003)(230273577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(38070700009)(224303003)(38100700002)(83380400001)(66476007)(66556008)(64756008)(54906003)(4326008)(66946007)(8936002)(66446008)(76116006)(122000001)(85182001)(55016003)(41300700001)(26005)(9686003)(4001150100001)(6506007)(7696005)(86362001)(478600001)(966005)(2906002)(567974003)(6916009)(316002)(52536014)(33656002)(71200400001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0xQZGQyN2U0czRMc0x1K0RNQUZ5bldneHB6SXYxa2thdGUxTDVwMXZ1SjFL?=
 =?utf-8?B?My9jVjFydEdSK3lRR0x4TVN2c255MlpnRnE1QWcvVVdSNEhTTEdHaW9Db3Bq?=
 =?utf-8?B?enpKNklFNEplREZKY2JqL1dGSWJqMG0vVS9CZDZSckxQbVptZWFGaFRKd0JO?=
 =?utf-8?B?dFkyWU9FeXcvMjJNRDZEdGxmM3lUOUw1Z3R2RElUMUd0UU4zc3VyMkx1ZzBO?=
 =?utf-8?B?Y1BJanRtQW9iU2JmNE9iT2hZeXQyaWVCUzBoT3puekN2VThGTGZiWEFxVlFz?=
 =?utf-8?B?YVFicTVNY1JXalFWUVdmVUg3ZHdLUFFFbTJzcEhYTkYzaGhhemN4MlJhTUti?=
 =?utf-8?B?clp1MVN1KzFzOWc5b1hvTkZxZXd3Z25Od1dJMmRuNWIvbVY0ZDd4OTVHWnY4?=
 =?utf-8?B?ZkRyYUt3aVc0c3RxZmp0RmR0aHA5ak9tYmlXY2MzMUI2a1FGeC8zVWxzaGpT?=
 =?utf-8?B?ckZLQUxlbDdXNVA0U0Y3RlFPMDhhRlB6d1NuMVNtSHJrNlBHcVhNTHQ4TzRX?=
 =?utf-8?B?RWhRK3Ntbnl3NjduazFZTzdvQVpqeCtiUWQ3SzJTRXQ1Uy9iRmJVY21aWTRV?=
 =?utf-8?B?QWpuZ3U2YUYyclV2bFNybmo1RHoyNGJFdkRqTnlhOGJkZmlIWVpuUkhlQnhB?=
 =?utf-8?B?b25HYzZpS0RuOFJIeUlRMXNzbUNnVFBaVUJDU1BDUE9IUHIrMFJsY3o0T3gz?=
 =?utf-8?B?UXVxVTNNNVh3KzZlUEtWMURIeGhLemhaMDJSNFptR1cvakM0a0k1RUo5a3Bv?=
 =?utf-8?B?aVV6cHNGeEhxUm1QNkpDZERLOWE3ZzZCNVR0M0JTZHZGcUdrTW00VGRnM3Fn?=
 =?utf-8?B?Y2VyR0hxWmx1ZGZBV0wzZGNPMlBvWWtDYlR0QWVUM3lTMG9kbU93V3FlUlVr?=
 =?utf-8?B?Y2M3SWdNM2dIR2tLbzVyQjViSEZ5NzNFdEpzdFdLYzMyU0VxYTRLUlhWTmxL?=
 =?utf-8?B?MUxUUUU3V1lOTUQzVjlRa1U5L2JjNFY3VVhZR0srTkRuUm1HbEp4d3JNbjMz?=
 =?utf-8?B?cHVqeFBjQU02bkJFRTB6Mml3a2FkaFlsLytqK1llZTN2aitUSHFSVGQvd3Bq?=
 =?utf-8?B?OUxQcThHb3F5dzRHbEJPdGYwN1U5Z2YxdStCUCtKSmVTaTczVk04OSs5NkpU?=
 =?utf-8?B?V1gyYnJJM1BEaTJUU2gzU3d1SnNVNGp6SThaQmZIRTQ0NnZSYXE5Sm9aTzJQ?=
 =?utf-8?B?c3V1RFprU0ZPUGhqeWpTeDVodFMxUllycS81bWppNk52NzNPVUdXdzZwRkxX?=
 =?utf-8?B?Q3ZYUWNEOFR5a1RPcjV4SEdOY25oa3pPZmQ4eFd1U3NJU2Q5cm4vY3hoWjR5?=
 =?utf-8?B?cG02dU1tQTlnMzlzbU9YenhGa3ZzbE85N0trMHpvTHFudXRFSnBLVnRobTVH?=
 =?utf-8?B?MWRjSmZWUHZTV0w3RnRMZWdldVl5VlYrRGdyUEt2dnN0Nm9ZZU1PUnhmVWRm?=
 =?utf-8?B?dmhUUlF2QXkxSzN2Y0JRV1pxT3FWM0hvNnR3VnE2Nlh5VHRNN2tyZEJVbUZT?=
 =?utf-8?B?ZlZBM2NHeWxKNDg0cEMwTWRVeklMTWI3YzhEZ1g4Zk1CWkJ5L2lGdE5YZmlF?=
 =?utf-8?B?Y0dVWENWcERzbVd1R093bmxWTXRvekpRbmdXTE5aV0wzaEdhaVJXQzdITlV4?=
 =?utf-8?B?eXM1cmsxRkdaeFZQL2lPZTBOSS9Gc0NZVEFOeHRNVHFKdGtBQUIwVG1KdkR1?=
 =?utf-8?B?U2pDZEJISk1IcmdwZEFOTlBrQmZaZjBvK3cxc3RIUjJWTU9YZlNneGs0SmZQ?=
 =?utf-8?B?V0pBWmJ2MWVKZVJVUk9QdGJWOXhyakdPNmNKVEdHM2tYMFZBelZlUEU5OEpE?=
 =?utf-8?B?YnBZMHVvN09SOE9BSGYwQlppdU53MklhQXo3bTZXVER2ZmxyZVBUc0RrT3BJ?=
 =?utf-8?B?a1lGVmN6LzExUllXaG1aY1lNOGFuSjdOaWx4b0NwVmd6aEN1eTFhQVNPdlBL?=
 =?utf-8?B?MEpCdnZReGg5ellKVUhzb01mNG9FZXVDem1HaWlVNmNWOVcvWVNUVkxTZktt?=
 =?utf-8?B?Ym02LzBKZTVKMzBGUjFIajVOdWZ0b29Lazk2WU9nQmZZZFo1S0ZuZzVsYm0y?=
 =?utf-8?B?YzlBVVlrd0hsRnA2dHpaWGZSUmIrR0hVb2MrYjY0R2FIazlFK08ydnBrUjRC?=
 =?utf-8?Q?0RP9wziaQ3hLle6nxJNBDE+Rh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB5653.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c504a4-ed93-4589-a346-08dbe63a136f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 00:22:11.1561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OjWxl8M54EeFxAXkS5lQjsNkILaxNL1dggLAM5iEOajd+rMyHCxlPPuYDg1kui/E/28idCWXx/w9728eN4507g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB6151
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyMDIzLTExLTE1IDE5OjM0OjI3KzA4MDAsIGh1YW5nemFpeWFuZyB3cm90ZToNCj4gVGhl
cmUgaXMgYSB0aW1lcl9saXN0IHJhY2UgY29uZGl0aW9uIGlmIGEgZGVsYXkgd29yayBpcyBxdWV1
ZWQgdHdpY2UsDQo+IHRoaXMgdXN1YWxseSB3b24ndCBoYXBwZW4gdW5sZXNzIHNvbWVvbmUgcmVp
bml0aWFsaXplcyB0aGUgdGFzayBiZWZvcmUgcGVyZm9ybWluZyB0aGUgZW5xdWV1ZSBvcGVyYXRp
b24sbGlrZcOvwrw/DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL21h
c3Rlci9kcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS4NCj4gYyNMNDg3IEEgd2FybmluZyBtZXNzYWdl
IHdpbGwgaGVscCBkZXZlbG9wZXJzIGlkZW50aWZ5IHRoaXMgaXJyZWd1bGFyDQo+IHVzYWdlLg0K
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBaYWlZYW5nIEh1YW5nIDxoenkwNzE5QDE2My5jb20+DQo+IC0t
LQ0KPiAgaW5jbHVkZS9saW51eC93b3JrcXVldWUuaCB8IDMzICsrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDE1IGRl
bGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC93b3JrcXVldWUuaCBi
L2luY2x1ZGUvbGludXgvd29ya3F1ZXVlLmgNCj4gaW5kZXggMjRiMWU1MDcwZjRkLi41NDEwMmVk
Nzk0ZTUgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvd29ya3F1ZXVlLmgNCj4gKysrIGIv
aW5jbHVkZS9saW51eC93b3JrcXVldWUuaA0KPiBAQCAtMjY2LDYgKzI2NiwyMiBAQCBzdGF0aWMg
aW5saW5lIHZvaWQNCj4gZGVzdHJveV9kZWxheWVkX3dvcmtfb25fc3RhY2soc3RydWN0IGRlbGF5
ZWRfd29yayAqd29yaykgeyB9ICBzdGF0aWMNCj4gaW5saW5lIHVuc2lnbmVkIGludCB3b3JrX3N0
YXRpYyhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspIHsgcmV0dXJuIDA7DQo+IH0gICNlbmRpZg0K
Pg0KPiArLyoqDQo+ICsgKiB3b3JrX3BlbmRpbmcgLSBGaW5kIG91dCB3aGV0aGVyIGEgd29yayBp
dGVtIGlzIGN1cnJlbnRseSBwZW5kaW5nDQo+ICsgKiBAd29yazogVGhlIHdvcmsgaXRlbSBpbiBx
dWVzdGlvbg0KPiArICovDQo+ICsjZGVmaW5lIHdvcmtfcGVuZGluZyh3b3JrKSBcDQo+ICsgICAg
ICAgdGVzdF9iaXQoV09SS19TVFJVQ1RfUEVORElOR19CSVQsIHdvcmtfZGF0YV9iaXRzKHdvcmsp
KQ0KPiArDQo+ICsvKioNCj4gKyAqIGRlbGF5ZWRfd29ya19wZW5kaW5nIC0gRmluZCBvdXQgd2hl
dGhlciBhIGRlbGF5YWJsZSB3b3JrIGl0ZW0gaXMNCj4gK2N1cnJlbnRseQ0KPiArICogcGVuZGlu
Zw0KPiArICogQHc6IFRoZSB3b3JrIGl0ZW0gaW4gcXVlc3Rpb24NCj4gKyAqLw0KPiArI2RlZmlu
ZSBkZWxheWVkX3dvcmtfcGVuZGluZyh3KSBcDQo+ICsgICAgICAgd29ya19wZW5kaW5nKCYodykt
PndvcmspDQo+ICsNCj4gKw0KPiAgLyoNCj4gICAqIGluaXRpYWxpemUgYWxsIG9mIGEgd29yayBp
dGVtIGluIG9uZSBnbw0KPiAgICoNCj4gQEAgLTMxMCw2ICszMjYsNyBAQCBzdGF0aWMgaW5saW5l
IHVuc2lnbmVkIGludCB3b3JrX3N0YXRpYyhzdHJ1Y3QNCj4gd29ya19zdHJ1Y3QgKndvcmspIHsg
cmV0dXJuIDA7IH0NCj4NCj4gICNkZWZpbmUgX19JTklUX0RFTEFZRURfV09SSyhfd29yaywgX2Z1
bmMsIF90ZmxhZ3MpICAgICAgICAgICAgICAgICAgICAgXA0KPiAgICAgICAgIGRvIHsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+
ICsgICAgICAgICAgICAgICBXQVJOX09OKGRlbGF5ZWRfd29ya19wZW5kaW5nKF93b3JrKSk7ICAg
ICAgICAgICAgICAgICAgIFwNCg0KSG93IGRvZXMgdGhpcyB3b3JrIHdoZW4gdGhlIGRhdGEgX3dv
cmsgcG9pbnRzIHRvIGlzIG5vdCB5ZXQgaW5pdGlhbGl6ZWQ/DQpSZWFkaW5nIHVuaW5pdGlhbGl6
ZWQgZGF0YSBpcyBVQiBhbmQgbWF5IHNwdXJpb3VzbHkgdHJpZ2dlciB0aGUgd2FybmluZy4NCg0K
LS0+IFRoZSBkYXRhIG1lbWJlciBpbiB3b3JrX3N0cnVjdCBpcyBhIHZhcmlhYmxlIG9mIHR5cGUg
YXRvbWljX2xvbmdfdCwgYW5kIDAgaXMgdGhlIGluaXRpYWwgdmFsdWUgb2YgdGhlIGF0b21pYyB2
YXJpYWJsZSwgcmlnaHQ/DQoNCj4gICAgICAgICAgICAgICAgIElOSVRfV09SSygmKF93b3JrKS0+
d29yaywgKF9mdW5jKSk7ICAgICAgICAgICAgICAgICAgICAgXA0KPiAgICAgICAgICAgICAgICAg
X19pbml0X3RpbWVyKCYoX3dvcmspLT50aW1lciwgICAgICAgICAgICAgICAgICAgICAgICAgICBc
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGVsYXllZF93b3JrX3RpbWVyX2ZuLCAg
ICAgICAgICAgICAgICAgICAgIFwNCj4gQEAgLTMxOCw2ICszMzUsNyBAQCBzdGF0aWMgaW5saW5l
IHVuc2lnbmVkIGludCB3b3JrX3N0YXRpYyhzdHJ1Y3QNCj4gd29ya19zdHJ1Y3QgKndvcmspIHsg
cmV0dXJuIDA7IH0NCg0KWy4uXQ0KDQo+IC0tDQo+IDIuMTcuMQ0KPg0KPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXw0KPiBPUFBPDQoNClRoZSBndW5rIGF0IHRoZSBlbmQgb2YgdGhl
IG1haWwgd2lsbCBwcmV2ZW50IHlvdXIgcGF0Y2ggZnJvbSBiZWluZyBjb25zaWRlcmVkIGF0IGFs
bC4NCg0KPg0KPiDCscK+wrXDp8OXw5PDk8OKwrzDvsK8wrDDhsOkwrjCvcK8w77CusKsw5PDkE9Q
UE/CucKrw4vCvsK1w4TCscKjw4PDnMOQw4XDj8KiwqPCrMK9w7bDj8Oew5PDmsOTw4rCvMO+w5bC
uMODw7fCtcOEw4rDlcK8w77DiMOLwqPCqMKww7zCusKsDQo+IMK4w7bDiMOLwrzCsMOIwrrDl8Op
wqPCqcOKwrnDk8ODwqHCo8K9w7vDlsK5w4jDjsK6w47DiMOLw5TDmsOOwrTCvsKtw4rDmsOIwqjC
tcOEw4fDqcK/w7bDj8OCw5LDlMOIw47CusOOw5DDjsOKwr3DisK5w5PDg8KhwqPDiMOnwrnDu8OE
w7rCtMOtDQo+IMOKw5XDgcOLwrHCvsOTw4rCvMO+wqPCrMOHw5DDjsOwwrTCq8KywqXCocKiwrfD
lsK3wqLCocKiwrjCtMOWw4bCocKiw5PCocOLwqLCu8Oyw4rCucOTw4PCscK+w5PDisK8w77DlsKu
w4jDjsK6w47CssK/wrfDlsK7w7LDhsOkw4vDucOUw5jDlsKuDQo+IMOIw47CusOOw4TDmsOIw53C
o8KswrLCosOHw6vDgcKiwrzCtMOSw5TCtcOnw5fDk8OTw4rCvMO+w43CqMOWwqrCt8KiwrzDvsOI
w4vCssKiw4nCvsKzw73CscK+w5PDisK8w77CvMKww4bDpMK4wr3CvMO+wqHCow0KDQpbLi5dDQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KT1BQTw0KDQrmnKznlLXlrZDpgq7ku7bl
j4rlhbbpmYTku7blkKvmnIlPUFBP5YWs5Y+455qE5L+d5a+G5L+h5oGv77yM5LuF6ZmQ5LqO6YKu
5Lu25oyH5piO55qE5pS25Lu25Lq677yI5YyF5ZCr5Liq5Lq65Y+K576k57uE77yJ5L2/55So44CC
56aB5q2i5Lu75L2V5Lq65Zyo5pyq57uP5o6I5p2D55qE5oOF5Ya15LiL5Lul5Lu75L2V5b2i5byP
5L2/55So44CC5aaC5p6c5oKo6ZSZ5pS25LqG5pys6YKu5Lu277yM5YiH5Yu/5Lyg5pKt44CB5YiG
5Y+R44CB5aSN5Yi244CB5Y2w5Yi35oiW5L2/55So5pys6YKu5Lu25LmL5Lu75L2V6YOo5YiG5oiW
5YW25omA6L295LmL5Lu75L2V5YaF5a6577yM5bm26K+356uL5Y2z5Lul55S15a2Q6YKu5Lu26YCa
55+l5Y+R5Lu25Lq65bm25Yig6Zmk5pys6YKu5Lu25Y+K5YW26ZmE5Lu244CCDQrnvZHnu5zpgJro
rq/lm7rmnInnvLrpmbflj6/og73lr7zoh7Tpgq7ku7booqvmiKrnlZnjgIHkv67mlLnjgIHkuKLl
pLHjgIHnoLTlnY/miJbljIXlkKvorqHnrpfmnLrnl4Xmr5LnrYnkuI3lronlhajmg4XlhrXvvIxP
UFBP5a+55q2k57G76ZSZ6K+v5oiW6YGX5ryP6ICM5byV6Ie05LmL5Lu75L2V5o2f5aSx5qaC5LiN
5om/5ouF6LSj5Lu75bm25L+d55WZ5LiO5pys6YKu5Lu255u45YWz5LmL5LiA5YiH5p2D5Yip44CC
DQrpmaTpnZ7mmI7noa7or7TmmI7vvIzmnKzpgq7ku7blj4rlhbbpmYTku7bml6DmhI/kvZzkuLrl
nKjku7vkvZXlm73lrrbmiJblnLDljLrkuYvopoHnuqbjgIHmi5vmj73miJbmib/or7rvvIzkuqbm
l6DmhI/kvZzkuLrku7vkvZXkuqTmmJPmiJblkIjlkIzkuYvmraPlvI/noa7orqTjgIIg5Y+R5Lu2
5Lq644CB5YW25omA5bGe5py65p6E5oiW5omA5bGe5py65p6E5LmL5YWz6IGU5py65p6E5oiW5Lu7
5L2V5LiK6L+w5py65p6E5LmL6IKh5Lic44CB6JGj5LqL44CB6auY57qn566h55CG5Lq65ZGY44CB
5ZGY5bel5oiW5YW25LuW5Lu75L2V5Lq677yI5Lul5LiL56ew4oCc5Y+R5Lu25Lq64oCd5oiW4oCc
T1BQT+KAne+8ieS4jeWboOacrOmCruS7tuS5i+ivr+mAgeiAjOaUvuW8g+WFtuaJgOS6q+S5i+S7
u+S9leadg+WIqe+8jOS6puS4jeWvueWboOaVheaEj+aIlui/h+WkseS9v+eUqOivpeetieS/oeaB
r+iAjOW8leWPkeaIluWPr+iDveW8leWPkeeahOaNn+WkseaJv+aLheS7u+S9lei0o+S7u+OAgg0K
5paH5YyW5beu5byC5oqr6Zyy77ya5Zug5YWo55CD5paH5YyW5beu5byC5b2x5ZON77yM5Y2V57qv
5LulWUVTXE9L5oiW5YW25LuW566A5Y2V6K+N5rGH55qE5Zue5aSN5bm25LiN5p6E5oiQ5Y+R5Lu2
5Lq65a+55Lu75L2V5Lqk5piT5oiW5ZCI5ZCM5LmL5q2j5byP56Gu6K6k5oiW5o6l5Y+X77yM6K+3
5LiO5Y+R5Lu25Lq65YaN5qyh56Gu6K6k5Lul6I635b6X5piO56Gu5Lmm6Z2i5oSP6KeB44CC5Y+R
5Lu25Lq65LiN5a+55Lu75L2V5Y+X5paH5YyW5beu5byC5b2x5ZON6ICM5a+86Ie05pWF5oSP5oiW
6ZSZ6K+v5L2/55So6K+l562J5L+h5oGv5omA6YCg5oiQ55qE5Lu75L2V55u05o6l5oiW6Ze05o6l
5o2f5a6z5om/5ouF6LSj5Lu744CCDQpUaGlzIGUtbWFpbCBhbmQgaXRzIGF0dGFjaG1lbnRzIGNv
bnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZyb20gT1BQTywgd2hpY2ggaXMgaW50ZW5k
ZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkgd2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQg
YWJvdmUuIEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55
IHdheSAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQgdG8sIHRvdGFsIG9yIHBhcnRpYWwgZGlz
Y2xvc3VyZSwgcmVwcm9kdWN0aW9uLCBvciBkaXNzZW1pbmF0aW9uKSBieSBwZXJzb25zIG90aGVy
IHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudChzKSBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgYXJl
IG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2UgZG8gbm90IHJlYWQsIGNvcHksIGRp
c3RyaWJ1dGUsIG9yIHVzZSB0aGlzIGluZm9ybWF0aW9uLiBJZiB5b3UgaGF2ZSByZWNlaXZlZCB0
aGlzIHRyYW5zbWlzc2lvbiBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVk
aWF0ZWx5IGJ5IHJlcGx5IGUtbWFpbCBhbmQgdGhlbiBkZWxldGUgdGhpcyBtZXNzYWdlLg0KRWxl
Y3Ryb25pYyBjb21tdW5pY2F0aW9ucyBtYXkgY29udGFpbiBjb21wdXRlciB2aXJ1c2VzIG9yIG90
aGVyIGRlZmVjdHMgaW5oZXJlbnRseSwgbWF5IG5vdCBiZSBhY2N1cmF0ZWx5IGFuZC9vciB0aW1l
bHkgdHJhbnNtaXR0ZWQgdG8gb3RoZXIgc3lzdGVtcywgb3IgbWF5IGJlIGludGVyY2VwdGVkLCBt
b2RpZmllZCAsZGVsYXllZCwgZGVsZXRlZCBvciBpbnRlcmZlcmVkLiBPUFBPIHNoYWxsIG5vdCBi
ZSBsaWFibGUgZm9yIGFueSBkYW1hZ2VzIHRoYXQgYXJpc2Ugb3IgbWF5IGFyaXNlIGZyb20gc3Vj
aCBtYXR0ZXIgYW5kIHJlc2VydmVzIGFsbCByaWdodHMgaW4gY29ubmVjdGlvbiB3aXRoIHRoZSBl
bWFpbC4NClVubGVzcyBleHByZXNzbHkgc3RhdGVkLCB0aGlzIGUtbWFpbCBhbmQgaXRzIGF0dGFj
aG1lbnRzIGFyZSBwcm92aWRlZCB3aXRob3V0IGFueSB3YXJyYW50eSwgYWNjZXB0YW5jZSBvciBw
cm9taXNlIG9mIGFueSBraW5kIGluIGFueSBjb3VudHJ5IG9yIHJlZ2lvbiwgbm9yIGNvbnN0aXR1
dGUgYSBmb3JtYWwgY29uZmlybWF0aW9uIG9yIGFjY2VwdGFuY2Ugb2YgYW55IHRyYW5zYWN0aW9u
IG9yIGNvbnRyYWN0LiBUaGUgc2VuZGVyLCB0b2dldGhlciB3aXRoIGl0cyBhZmZpbGlhdGVzIG9y
IGFueSBzaGFyZWhvbGRlciwgZGlyZWN0b3IsIG9mZmljZXIsIGVtcGxveWVlIG9yIGFueSBvdGhl
ciBwZXJzb24gb2YgYW55IHN1Y2ggaW5zdGl0dXRpb24gKGhlcmVpbmFmdGVyIHJlZmVycmVkIHRv
IGFzICJzZW5kZXIiIG9yICJPUFBPIikgZG9lcyBub3Qgd2FpdmUgYW55IHJpZ2h0cyBhbmQgc2hh
bGwgbm90IGJlIGxpYWJsZSBmb3IgYW55IGRhbWFnZXMgdGhhdCBhcmlzZSBvciBtYXkgYXJpc2Ug
ZnJvbSB0aGUgaW50ZW50aW9uYWwgb3IgbmVnbGlnZW50IHVzZSBvZiBzdWNoIGluZm9ybWF0aW9u
Lg0KQ3VsdHVyYWwgRGlmZmVyZW5jZXMgRGlzY2xvc3VyZTogRHVlIHRvIGdsb2JhbCBjdWx0dXJh
bCBkaWZmZXJlbmNlcywgYW55IHJlcGx5IHdpdGggb25seSBZRVNcT0sgb3Igb3RoZXIgc2ltcGxl
IHdvcmRzIGRvZXMgbm90IGNvbnN0aXR1dGUgYW55IGNvbmZpcm1hdGlvbiBvciBhY2NlcHRhbmNl
IG9mIGFueSB0cmFuc2FjdGlvbiBvciBjb250cmFjdCwgcGxlYXNlIGNvbmZpcm0gd2l0aCB0aGUg
c2VuZGVyIGFnYWluIHRvIGVuc3VyZSBjbGVhciBvcGluaW9uIGluIHdyaXR0ZW4gZm9ybS4gVGhl
IHNlbmRlciBzaGFsbCBub3QgYmUgcmVzcG9uc2libGUgZm9yIGFueSBkaXJlY3Qgb3IgaW5kaXJl
Y3QgZGFtYWdlcyByZXN1bHRpbmcgZnJvbSB0aGUgaW50ZW50aW9uYWwgb3IgbWlzdXNlIG9mIHN1
Y2ggaW5mb3JtYXRpb24uDQo=
