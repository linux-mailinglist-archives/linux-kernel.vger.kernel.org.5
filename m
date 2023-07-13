Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5158752558
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjGMOkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjGMOk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:40:27 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06871734
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:40:25 -0700 (PDT)
Received: from pps.filterd (m0174678.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DCxkiV030300;
        Thu, 13 Jul 2023 14:40:12 GMT
Received: from eur03-dba-obe.outbound.protection.outlook.com (mail-dbaeur03lp2174.outbound.protection.outlook.com [104.47.51.174])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3rsx91md00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 14:40:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsqAdu2R4EXtx0frvVcKB2jlRCB48n/Gkij4e4PTZmJ/XVgmaUuTGzs36GzFsQS0T9wnNaD9duJasHjB6WAMoM01QVIp7oMENm1MN/G5BdouJJMoV3rf1FfO4grMqY22g+hzf+5xd2gp4vL4Qx6N8yHQ3iGecV7QQf0Sf3IYo1MLOQp6/3g0O6BlznRfD5Zj2J3g6gXr3yxk1ZwZLsLmibsMs06CBpvP9EHMFXL9wjtRGPRFnU7jg5NBa3GRAYusbjaGRheJ3Q2cBwKJ1rB2wsB+LaGbjXcKfcySfKRkhHZ6RiYMGDK1t5ky1k5YTn/RCfiGNwxr9Wj0tNs2TjK/jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AWXD6xifU4U0eaRhlp3L/5/ivssBJWP3bjtBZPlTns=;
 b=UeSY0DWNHVnX5y0xI3/BvMmqWSJ1Ck2WieoHj6dVvhx+IiX/XvZ0MYT5dOC67DqZEobyRAEDY9r7zeyJ8/iFeE3KiVpcWzBC7VxgeW8zVvRjp58MtTLWyQmI6r7nMpOHVUw78ti+7BzAtGRax3LNe+lzwnPFQ1J1GrSDj9wx5LCgHOxCk3f9A3xruDmUcGfaWxT97AotYTaUkJfc06DoRfp3NPAV2y0cganSEe9EgfIXuFahorQ5u89ojNWJrmL0btjBhmswNV1Id4V9oCHcIjBwjcUbNx7uihdNilGy9GZaZH+Unmi4UfTjPJwZDxE0dRvswQjhF0qPj9+Fgjk3zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AWXD6xifU4U0eaRhlp3L/5/ivssBJWP3bjtBZPlTns=;
 b=XO9oAEl+ISI5GqiBdl6hp/ic13lQQD5LsfuWf8NT5gRmPqMXpXBc0qhVYAMMgBnwFFud3L9cGZa+TftR3lei1a0SMWVPpYn40fjeADumZNlEUydmgJbGciPg7kKN9R/CSXIp3Pfq7o9c3O9vso367hLwsd7/83Q7pF/r3HDPKlADTs7Cni1pvZy3AKLTOnKh+M7FXQMu/e15m01UVGyERHazB7bpZNqAt/rvAVk7kiMQpGyUdIzLEhavq5YBhUkTMRtjRk/pRgiUs+6tt3RvA2lLjzUzpnet2KBlitwGsxrpn83S+TZiC8QaKkbKKN8NrmX8pSbXKMhhEtL0mbOpkw==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by PAWPR03MB9201.eurprd03.prod.outlook.com (2603:10a6:102:341::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Thu, 13 Jul
 2023 14:40:08 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::11f9:615a:4d9a:a5d2]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::11f9:615a:4d9a:a5d2%6]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 14:40:08 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Juergen Gross <jgross@suse.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stefano Stabellini <sstabellini@kernel.org>
CC:     Vincent Guittot <vincent.guittot@linaro.org>,
        =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        "stratos-dev@op-lists.linaro.org" <stratos-dev@op-lists.linaro.org>,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen: privcmd: Add support for irqfd
Thread-Topic: [PATCH] xen: privcmd: Add support for irqfd
Thread-Index: AQHZtJ2tw+2Ln+ZUhUa/nIHLslV4fq+3Uo+AgAB0BQA=
Date:   Thu, 13 Jul 2023 14:40:08 +0000
Message-ID: <97e63191-e2ba-34f6-ca6c-99b9e9841587@epam.com>
References: <d4e0233524b8c7c48614b09cae4d23f2cdf10988.1689150266.git.viresh.kumar@linaro.org>
 <a5521a9d-72c6-4e03-0fbb-8a37418c32f2@suse.com>
In-Reply-To: <a5521a9d-72c6-4e03-0fbb-8a37418c32f2@suse.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|PAWPR03MB9201:EE_
x-ms-office365-filtering-correlation-id: ab676c45-0dc9-469d-95a0-08db83af0e64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z3PHHN0LCQ+FmHDNW3acd2f4bpuslnlaDs7r6Kx9YL0l98fhlytqxIZWmKbCLpHcqc1lI6W4ukjABe/2VtmeSvbyPnnawSzAL1Q2qRasS6CTuNdNy5Wv+RryOlnHh89a/I3vfs7uopewHDTXDk8r19yCCF5/K42QCmGB7akAcyHtPy98vLNyRYybZQ9CzC9p5x4paovwMMu2I6kQi+wCzUQQl8At9F5+0T8BeHOkOuL1aI0LICrlDvowt/4Wgr2CLONnPps6rbl/+VvqeoJe/qKTt3Z54PVMphYoqC65bMi9Byy8LoK/ZGMNnwqp0sgzj2l+oVmtDMwPVwCBIFh5F5JjpsIb/NzSlUKtq3CbF4EDuxNk70gn0tcQSLOv8kEQ6cXM63+3DV7wZB7iDlEsFLWF6/cjqICvHIvi+QbE0v/GgdrNPOZBP4hhGmmriHVg2HHVGZsZaAP62NHFvefobzEvUwH5Wkokm/svZJL+zU6bnPQYfzOegGSor0lag+fukq+88XQjQeJW3nt0+mL6ikbRAwsTftKJwkjdhUMR8KKFzIIc/5ynvqdERhF7R+Y1QdpzzKvHgTHCwuIcRqIx8+IAOBRCxjISfRMxtijl7RxkGuxhBwKowEzBwswh4/J0OC71IiZy055RtUJGgzYhn68qD8CRSxJzAyCw9/AxQtI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(86362001)(31686004)(2906002)(8936002)(71200400001)(110136005)(54906003)(478600001)(6486002)(7416002)(36756003)(41300700001)(66946007)(66476007)(76116006)(316002)(4326008)(66556008)(66446008)(64756008)(91956017)(6512007)(83380400001)(122000001)(38100700002)(5660300002)(6506007)(38070700005)(8676002)(53546011)(31696002)(186003)(2616005)(26005)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1lFbDFJaThhbmFUcnNLQ0xScVdzdHp6U0tvcTRRWmxHNWtMOUFEUnd0NTh1?=
 =?utf-8?B?QWVqcGRnSDZLZmM5Mm5EMUpNeDNyV3lsb3grQllCRTBwdU5OM0hJRXJISFJr?=
 =?utf-8?B?VGxxMENZTTU2M01EWmpIRWIyNzNqYVdhY1l0UGlMV0NHTjNSRExodkl0VlFE?=
 =?utf-8?B?OGVSWE5qTnpUTlBNeFhUczd4Vnljd1lKSGNTMVpiRWRBNTBNU2dzeE9jYi80?=
 =?utf-8?B?NDhBWmZCVDdLL0pJdU41Vit0eTBqSm9YQUs0NHJSZUZSUlZtNVIxUlR2bnNv?=
 =?utf-8?B?amh3dkpLZzdDOS9oV1NNS1haQmtPRm8wM21aT3FlNlVqYmR2bjh2SlZzc1E3?=
 =?utf-8?B?bnM5MlRFMmxJaDY1Qzg5K3B5VmdWV0UreVc0c2pIL0syc2RyWFVxbWpPTFI0?=
 =?utf-8?B?K3RVZnJGbHV2eEU0dFdvcGRWczN0b21kSmlidW0xNnIvdUtIeU9JTWQ4dkRR?=
 =?utf-8?B?OFFId0JhdkhFWEtUSHNnVkVIMGRXNUNjODFHRmJKUUp1ODR3RmlsQXRIanJE?=
 =?utf-8?B?V1pEOGFTL3FUV3BTL0JlTHVzdEhKZXJaRnZIU3EzTU5vbTNoRmYrTml6NVpv?=
 =?utf-8?B?WFRKSWViLzQ0R3NUVGlKZGVGTU9zS05XSnZyaFRjNE5NaTU2K1JNNUp2d1B0?=
 =?utf-8?B?b3dVdlZVTWt4VUxuSVQ3SDBkQll2T3RhNGM1YWtlSjVKMEJSajZpc011a0h3?=
 =?utf-8?B?c2FjNk9UdVdNYks1eG44ek1YbVVhK3Y1WHlsaG5hdmNMZU44a1hYbHkxNURu?=
 =?utf-8?B?UTFZbnVDVlA5cVM1dS9PWHZTK2N6SWx3T0VVOTdDVXBQMDJvdjNGZWdIMGRq?=
 =?utf-8?B?NVpqVEcxQ2JkK1grZjRKRXc1blB3WWpHL1dMb3RyNzJUTVJRWWRWQXJERTcy?=
 =?utf-8?B?ZDM2WXpoUzFIZ2I1bkU4cVF1ampIVGdNUlJCRnVqcGR6NWVGa3R5R3Nta2p6?=
 =?utf-8?B?eFprZi9xaDNXSzNrVjNyOUZ0WTFNa1poOUNDVDZuY0s3WjcreUxEcktCTzFo?=
 =?utf-8?B?V3p2S2lySTlybG1mdUhkbTlBRHRuZmF6aFUxcG1jcFM2aEJZWVRpVmpUZ3hY?=
 =?utf-8?B?OVVGQVNnZSs1VWMxcjNiTWNOaTRSd09Nb0dlcUliZWJRMWZKQ1E5SnRnb29S?=
 =?utf-8?B?b25Cd3lGNXFRRGk2OUdEVFphdnRucVJ3UTlRZE11TUx1WFJMTGxyOG9QaldX?=
 =?utf-8?B?Z2pyYWZ1U2VOM2pYcUtsRTluUWg1alhJYXZkTUhnVTltYm1NSEdsQTdsc28x?=
 =?utf-8?B?cG40ZHJnZXE0Qm14cWJRaTlKbHhiTmw2QW1LUWp5QmVXKzBWd3FhWFZWMmpE?=
 =?utf-8?B?cDJnK3VXUDVjR05YMzYxdXBTY2gzQ2l4WUhkK1g1NW5mU2s1VHJpbG9Cek5l?=
 =?utf-8?B?Y2pVdkVTQ01zT2JRMXY1L0s2dVlZZytCOEVIK013V3FUR3pOZHhYazlPU2Uz?=
 =?utf-8?B?RS9GU0xmTTBvOVJEWEJVQzR3WmlTYVdKb1hYQ253NXk5bjlzSzRzS2plaHFG?=
 =?utf-8?B?azBxMTRjbVY3MlgzVTZhQVQrL2JQVXRFV3dhZ245eHBNMEZlWXhuWVI3aENq?=
 =?utf-8?B?MHVsS25Td0NXWVBUVjJ0VzFOOVN0bkVHZlVTdU03bTU4bXJ3Ym53bFdYZzNy?=
 =?utf-8?B?aTBjT0g1aXlRUHltc2x0NGE3U29mYVJmVEpaQnBydzdqTjJOTHZlUGFtbUlD?=
 =?utf-8?B?MTh1K1VRZGlqdjJVNXhpL0RDbFZNSmNiRWNhVm5kRGxzeGlYWjNTYTNXSUFi?=
 =?utf-8?B?ZW9LVytzZmJ1dVlaTXVacUFIMkszWEEwY2dJZW5vbkNOUkx2QXFmZmVXRnN4?=
 =?utf-8?B?cEhDdTFMR0VwTUJ5bDRRdk9sTUNtVGloeGtPQjRENXdhdUZFdXg1Z2FtTkN2?=
 =?utf-8?B?bGdWZjUrZEtvRHNKTUYrVFFxVjA3cHk2Rng2WXdUditxdCs2MlpjVUNnOUpD?=
 =?utf-8?B?dHJ3R2ZvZFU3aCtoMzNtUUhsSzVaMDZsKzdUcURBV0wvWVpuajlIUU02SHZT?=
 =?utf-8?B?SjFMdzZZalFIZmp1eHRDZm5IRXFuUjdWZzI4d0VnVUV6RC9OdXAxbDlSWXpo?=
 =?utf-8?B?YlZoNEc2SmZDbTk4Q1NwYjJYNUtEYjBjQittSjduUjBWSlE4RzZNVnhQZ2Q1?=
 =?utf-8?B?YmFJaVV5VDJqMCtNOW1kK05lelhYVjNUMUFHV1FISWN3T1ZxRzNNYUowTHFM?=
 =?utf-8?Q?UOE0qOBB3S2EyV1pcZnsC8k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B015EECB6F5864CBDA189B9D0373BDA@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab676c45-0dc9-469d-95a0-08db83af0e64
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 14:40:08.6672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G02DqiP8WmMSLUdCyu4JxiCRirAJl/kNzkRIwkFIpnEwHeA22iC6nwEvLeRlv4fizrLMWqDvrmz+ZlbwOLo34XklqphhP5fp36sB0Dwdk4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9201
X-Proofpoint-ORIG-GUID: e9wzjv97Rap0aQOdUjqN3Uo4SAyhqYQg
X-Proofpoint-GUID: e9wzjv97Rap0aQOdUjqN3Uo4SAyhqYQg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_05,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130128
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEzLjA3LjIzIDEwOjQ0LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KDQpIZWxsbyBhbGwu
DQoNCg0KPiBPbiAxMi4wNy4yMyAxMDo0OCwgVmlyZXNoIEt1bWFyIHdyb3RlOg0KPj4gWGVuIHBy
b3ZpZGVzIHN1cHBvcnQgZm9yIGluamVjdGluZyBpbnRlcnJ1cHRzIHRvIHRoZSBndWVzdHMgdmlh
IHRoZQ0KPj4gSFlQRVJWSVNPUl9kbV9vcCgpIGh5cGVyY2FsbC4gVGhlIHNhbWUgaXMgdXNlZCBi
eSB0aGUgVmlydGlvIGJhc2VkDQo+PiBkZXZpY2UgYmFja2VuZCBpbXBsZW1lbnRhdGlvbnMsIGlu
IGFuIGluZWZmaWNpZW50IG1hbm5lciBjdXJyZW50bHkuDQo+Pg0KPj4gR2VuZXJhbGx5LCB0aGUg
VmlydGlvIGJhY2tlbmRzIGFyZSBpbXBsZW1lbnRlZCB0byB3b3JrIHdpdGggdGhlIEV2ZW50ZmQN
Cj4+IGJhc2VkIG1lY2hhbmlzbS4gSW4gb3JkZXIgdG8gbWFrZSBzdWNoIGJhY2tlbmRzIHdvcmsg
d2l0aCBYZW4sIGFub3RoZXINCj4+IHNvZnR3YXJlIGxheWVyIG5lZWRzIHRvIHBvbGwgdGhlIEV2
ZW50ZmRzIGFuZCByYWlzZSBhbiBpbnRlcnJ1cHQgdG8gdGhlDQo+PiBndWVzdCB1c2luZyB0aGUg
WGVuIGJhc2VkIG1lY2hhbmlzbS4gVGhpcyByZXN1bHRzIGluIGFuIGV4dHJhIGNvbnRleHQNCj4+
IHN3aXRjaC4NCj4+DQo+PiBUaGlzIGlzIG5vdCBhIG5ldyBwcm9ibGVtIGluIExpbnV4IHRob3Vn
aC4gSXQgaXMgcHJlc2VudCB3aXRoIG90aGVyDQo+PiBoeXBlcnZpc29ycyBsaWtlIEtWTSwgZXRj
LiBhcyB3ZWxsLiBUaGUgZ2VuZXJpYyBzb2x1dGlvbiBpbXBsZW1lbnRlZCBpbg0KPj4gdGhlIGtl
cm5lbCBmb3IgdGhlbSBpcyB0byBwcm92aWRlIGFuIElPQ1RMIGNhbGwgdG8gcGFzcyB0aGUgaW50
ZXJydXB0DQo+PiBkZXRhaWxzIGFuZCBldmVudGZkLCB3aGljaCBsZXRzIHRoZSBrZXJuZWwgdGFr
ZSBjYXJlIG9mIHBvbGxpbmcgdGhlDQo+PiBldmVudGZkIGFuZCByYWlzaW5nIG9mIHRoZSBpbnRl
cnJ1cHQsIGluc3RlYWQgb2YgaGFuZGxpbmcgdGhpcyBpbiB1c2VyDQo+PiBzcGFjZSAod2hpY2gg
aW52b2x2ZXMgYW4gZXh0cmEgY29udGV4dCBzd2l0Y2gpLg0KPj4NCj4+IFRoaXMgcGF0Y2ggYWRk
cyBzdXBwb3J0IHRvIGluamVjdCBhIHNwZWNpZmljIGludGVycnVwdCB0byBndWVzdCB1c2luZw0K
Pj4gdGhlIGV2ZW50ZmQgbWVjaGFuaXNtLCBieSBwcmV2ZW50aW5nIHRoZSBleHRyYSBjb250ZXh0
IHN3aXRjaC4NCj4+DQo+PiBJbnNwaXJlZCBieSBleGlzdGluZyBpbXBsZW1lbnRhdGlvbnMgZm9y
IEtWTSwgZXRjLi4NCg0KDQpWaXJlc2gsIGdyZWF0IHdvcmshDQoNCkRvIHlvdSBwZXJoYXBzIGhh
dmUgY29ycmVzcG9uZGluZyB1c2Vycy1zcGFjZSAodmlydGlvIGJhY2tlbmQpIGV4YW1wbGUgDQph
ZG9wdGVkIGZvciB0aGF0IGZlYXR1cmUgKEkgd291bGQgbGlrZSB0byB0YWtlIGEgbG9vayBhdCBp
dCBpZiBwb3NzaWJsZSk/DQoNCg0KDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVmlyZXNoIEt1bWFy
IDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4NCj4+IC0tLQ0KPj4gwqAgZHJpdmVycy94ZW4vcHJp
dmNtZC5jwqDCoMKgwqDCoCB8IDI4NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystDQo+PiDCoCBpbmNsdWRlL3VhcGkveGVuL3ByaXZjbWQuaCB8wqAgMTQgKysNCj4+IMKgIDIg
ZmlsZXMgY2hhbmdlZCwgMjk3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL3ByaXZjbWQuYyBiL2RyaXZlcnMveGVuL3ByaXZjbWQu
Yw0KPj4gaW5kZXggZTJmNTgwZTMwYTg2Li5lODA5NmIwOWMxMTMgMTAwNjQ0DQo+PiAtLS0gYS9k
cml2ZXJzL3hlbi9wcml2Y21kLmMNCj4+ICsrKyBiL2RyaXZlcnMveGVuL3ByaXZjbWQuYw0KPj4g
QEAgLTksMTEgKzksMTYgQEANCj4+IMKgICNkZWZpbmUgcHJfZm10KGZtdCkgInhlbjoiIEtCVUlM
RF9NT0ROQU1FICI6ICIgZm10DQo+PiArI2luY2x1ZGUgPGxpbnV4L2V2ZW50ZmQuaD4NCj4+ICsj
aW5jbHVkZSA8bGludXgvZmlsZS5oPg0KPj4gwqAgI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0K
Pj4gwqAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9tdXRl
eC5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9wb2xsLmg+DQo+PiDCoCAjaW5jbHVkZSA8bGludXgv
c2NoZWQuaD4NCj4+IMKgICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+PiDCoCAjaW5jbHVkZSA8
bGludXgvc3RyaW5nLmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4L3dvcmtxdWV1ZS5oPg0KPj4gwqAg
I2luY2x1ZGUgPGxpbnV4L2Vycm5vLmg+DQo+PiDCoCAjaW5jbHVkZSA8bGludXgvbW0uaD4NCj4+
IMKgICNpbmNsdWRlIDxsaW51eC9tbWFuLmg+DQo+PiBAQCAtODMzLDYgKzgzOCwyNjYgQEAgc3Rh
dGljIGxvbmcgcHJpdmNtZF9pb2N0bF9tbWFwX3Jlc291cmNlKHN0cnVjdCANCj4+IGZpbGUgKmZp
bGUsDQo+PiDCoMKgwqDCoMKgIHJldHVybiByYzsNCj4+IMKgIH0NCj4+ICsvKiBJcnFmZCBzdXBw
b3J0ICovDQo+PiArc3RhdGljIHN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICppcnFmZF9jbGVhbnVw
X3dxOw0KPj4gK3N0YXRpYyBERUZJTkVfTVVURVgoaXJxZmRzX2xvY2spOw0KPj4gK3N0YXRpYyBM
SVNUX0hFQUQoaXJxZmRzX2xpc3QpOw0KPj4gKw0KPj4gK3N0cnVjdCBwcml2Y21kX2tlcm5lbF9p
cnFmZCB7DQo+PiArwqDCoMKgIGRvbWlkX3QgZG9tOw0KPj4gK8KgwqDCoCB1OCBsZXZlbDsNCj4+
ICvCoMKgwqAgdTMyIGlycTsNCj4+ICvCoMKgwqAgc3RydWN0IGV2ZW50ZmRfY3R4ICpldmVudGZk
Ow0KPj4gK8KgwqDCoCBzdHJ1Y3Qgd29ya19zdHJ1Y3Qgc2h1dGRvd247DQo+PiArwqDCoMKgIHdh
aXRfcXVldWVfZW50cnlfdCB3YWl0Ow0KPj4gK8KgwqDCoCBzdHJ1Y3QgbGlzdF9oZWFkIGxpc3Q7
DQo+PiArwqDCoMKgIHBvbGxfdGFibGUgcHQ7DQo+PiArfTsNCj4+ICsNCj4+ICsvKiBGcm9tIHhl
bi9pbmNsdWRlL3B1YmxpYy9odm0vZG1fb3AuaCAqLw0KPj4gKyNkZWZpbmUgWEVOX0RNT1Bfc2V0
X2lycV9sZXZlbCAxOQ0KPj4gKw0KPj4gK3N0cnVjdCB4ZW5fZG1fb3Bfc2V0X2lycV9sZXZlbCB7
DQo+PiArwqDCoMKgIHUzMiBpcnE7DQo+PiArwqDCoMKgIC8qIElOIC0gTGV2ZWw6IDAgLT4gZGVh
c3NlcnRlZCwgMSAtPiBhc3NlcnRlZCAqLw0KPj4gK8KgwqDCoCB1OCBsZXZlbDsNCj4+ICvCoMKg
wqAgdTggcGFkWzNdOw0KPj4gK307DQo+PiArDQo+PiArc3RydWN0IHhlbl9kbV9vcCB7DQo+PiAr
wqDCoMKgIHUzMiBvcDsNCj4+ICvCoMKgwqAgdTMyIHBhZDsNCj4+ICvCoMKgwqAgdW5pb24gew0K
Pj4gK8KgwqDCoMKgwqDCoMKgIC8qDQo+PiArwqDCoMKgwqDCoMKgwqDCoCAqIFRoZXJlIGFyZSBt
b3JlIHN0cnVjdHVyZXMgaGVyZSwgd2Ugd29uJ3QgYmUgdXNpbmcgdGhlbSwgc28NCj4+ICvCoMKg
wqDCoMKgwqDCoMKgICogY2FuIHNraXAgYWRkaW5nIHRoZW0gaGVyZS4NCj4+ICvCoMKgwqDCoMKg
wqDCoMKgICovDQo+PiArwqDCoMKgwqDCoMKgwqAgc3RydWN0IHhlbl9kbV9vcF9zZXRfaXJxX2xl
dmVsIHNldF9pcnFfbGV2ZWw7DQo+PiArwqDCoMKgIH0gdTsNCj4+ICt9Ow0KPiANCj4gSW5zdGVh
ZCBvZiBjb3B5aW5nIGRlZmluaXRpb25zIG92ZXIgZnJvbSBYZW4gaW50byBwcml2Y21kLmMsIHBs
ZWFzZSBqdXN0IA0KPiB1cGRhdGUNCj4gdGhlIHJlbGF0ZWQgbGludXggaGVhZGVyIGluY2x1ZGUv
eGVuL2ludGVyZmFjZS9kbV9vcC5oIGZyb20gdGhlIFhlbiBwdWJsaWMNCj4gaGVhZGVyLg0KPiAN
Cj4+ICsNCj4+ICtzdGF0aWMgdm9pZCBpcnFmZF9kZWFjdGl2YXRlKHN0cnVjdCBwcml2Y21kX2tl
cm5lbF9pcnFmZCAqa2lycWZkKQ0KPj4gK3sNCj4+ICvCoMKgwqAgbG9ja2RlcF9hc3NlcnRfaGVs
ZCgmaXJxZmRzX2xvY2spOw0KPj4gKw0KPj4gK8KgwqDCoCBsaXN0X2RlbF9pbml0KCZraXJxZmQt
Pmxpc3QpOw0KPj4gK8KgwqDCoCBxdWV1ZV93b3JrKGlycWZkX2NsZWFudXBfd3EsICZraXJxZmQt
PnNodXRkb3duKTsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIHZvaWQgaXJxZmRfc2h1dGRvd24o
c3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPj4gK3sNCj4+ICvCoMKgwqAgc3RydWN0IHByaXZj
bWRfa2VybmVsX2lycWZkICpraXJxZmQgPQ0KPj4gK8KgwqDCoMKgwqDCoMKgIGNvbnRhaW5lcl9v
Zih3b3JrLCBzdHJ1Y3QgcHJpdmNtZF9rZXJuZWxfaXJxZmQsIHNodXRkb3duKTsNCj4+ICvCoMKg
wqAgdTY0IGNudDsNCj4+ICsNCj4+ICvCoMKgwqAgZXZlbnRmZF9jdHhfcmVtb3ZlX3dhaXRfcXVl
dWUoa2lycWZkLT5ldmVudGZkLCAma2lycWZkLT53YWl0LCAmY250KTsNCj4+ICvCoMKgwqAgZXZl
bnRmZF9jdHhfcHV0KGtpcnFmZC0+ZXZlbnRmZCk7DQo+PiArwqDCoMKgIGtmcmVlKGtpcnFmZCk7
DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyB2b2lkIGlycWZkX2luamVjdChzdHJ1Y3QgcHJpdmNt
ZF9rZXJuZWxfaXJxZmQgKmtpcnFmZCkNCj4+ICt7DQo+PiArwqDCoMKgIHN0cnVjdCB4ZW5fZG1f
b3AgZG1fb3AgPSB7DQo+PiArwqDCoMKgwqDCoMKgwqAgLm9wID0gWEVOX0RNT1Bfc2V0X2lycV9s
ZXZlbCwNCj4+ICvCoMKgwqDCoMKgwqDCoCAudS5zZXRfaXJxX2xldmVsLmlycSA9IGtpcnFmZC0+
aXJxLA0KPj4gK8KgwqDCoMKgwqDCoMKgIC51LnNldF9pcnFfbGV2ZWwubGV2ZWwgPSBraXJxZmQt
PmxldmVsLA0KPj4gK8KgwqDCoCB9Ow0KPj4gK8KgwqDCoCBzdHJ1Y3QgeGVuX2RtX29wX2J1ZiB4
YnVmcyA9IHsNCj4+ICvCoMKgwqDCoMKgwqDCoCAuc2l6ZSA9IHNpemVvZihkbV9vcCksDQo+PiAr
wqDCoMKgIH07DQo+PiArwqDCoMKgIHU2NCBjbnQ7DQo+PiArDQo+PiArwqDCoMKgIGV2ZW50ZmRf
Y3R4X2RvX3JlYWQoa2lycWZkLT5ldmVudGZkLCAmY250KTsNCj4+ICvCoMKgwqAgc2V0X3hlbl9n
dWVzdF9oYW5kbGUoeGJ1ZnMuaCwgJmRtX29wKTsNCj4+ICsNCj4+ICvCoMKgwqAgeGVuX3ByZWVt
cHRpYmxlX2hjYWxsX2JlZ2luKCk7DQo+PiArwqDCoMKgIEhZUEVSVklTT1JfZG1fb3Aoa2lycWZk
LT5kb20sIDEsICZ4YnVmcyk7DQo+IA0KPiBQbGVhc2UgYWRkIHNvbWUgZXJyb3IgaGFuZGxpbmcs
IGUuZy4gYnkgaXNzdWluZyBhIG1lc3NhZ2UgaW4gY2FzZSB0aGlzIA0KPiBoeXBlcmNhbGwNCj4g
d2FzIGZhaWxpbmcuIEFkZGluZyBhIGJvb2wgImVycm9yIiB0byBzdHJ1Y3QgcHJpdmNtZF9rZXJu
ZWxfaXJxZmQgaW4gDQo+IG9yZGVyIHRvDQo+IGF2b2lkIG11bHRpcGxlIGVycm9yIG1lc3NhZ2Vz
IGZvciB0aGUgc2FtZSBkZXZpY2UgbWlnaHQgYmUgYSBnb29kIGlkZWEuDQoNCg0KSW4gYWRkaXRp
b24gdG8gcHJvdmlkZWQgY29tbWVudHMsIEkgd291bGQgbGlrZSB0byBtZW50aW9uIHRoYXQgdGhp
cyANCnBhcnRpY3VsYXIgZG1fb3AgaGFzIEFybSBpbXBsZW1lbnRhdGlvbiBvbmx5IGluIHZhbmls
bGEgaHlwZXJ2aXNvci4NCg0KU28gdGhpcyBmZWF0dXJlIGNhbm5vdCBiZSBpbW1lZGlhdGVseSBy
ZXVzZWQgb24geDg2IGJlY2F1c2Ugb2YgDQpYRU5fRE1PUF9zZXRfaXJxX2xldmVsIGF0IGxlYXN0
LiBBcyBJIHVuZGVyc3RhbmQsIHRoZSB4ODYncyB2YXJpYW50IGlzIA0KWEVOX0RNT1Bfc2V0X2lz
YV9pcnFfbGV2ZWwgKHRoZXJlIGlzIGFsc28gWEVOX0RNT1Bfc2V0X3BjaV9pbnR4X2xldmVsIA0K
Zm9yIGxlZ2FjeSBQQ0kgaW50ZXJydXB0cykuDQoNClBsZWFzZSBub3RlLCBJIGFtIG5vdCBhc2tp
bmcgdG8gd2lyZSBvbiB4ODYsIGJ1dCBtYXliZSBpdCBpcyB3b3J0aCANCmNvbnNpZGVyaW5nIHRv
IHB1dCB0aGlzIG5ldyBmZWF0dXJlIHVuZGVyIHNvbWV0aGluZyBsaWtlIEtjb25maWcncyANClhF
Tl9QUklWQ01EX0lSUUZEIHdoaWNoIGRlcGVuZHMgb24gQXJtIGZvciBub3c/ICBPciBtYXliZSB0
byBwdXQgZG1fb3AgDQpzcGVjaWZpYyBwYXJ0IG9mIGlycWZkX2luamVjdCgpIHVuZGVyIENPTkZJ
R19BUkNIX1hYWCBoZXJlIG9yIGludHJvZHVjZSANCnBlci1BUkNIIGhlbHBlcnMgdG8gZm9ybSBh
IGRtX29wIChBcm0ncyB2YXJpYW50IHdpbGwgdXNlIA0KWEVOX0RNT1Bfc2V0X2lycV9sZXZlbCBs
aWtlIGluIGN1cnJlbnQgY29tbWl0KS4gSWYgbm90LCB0aGVuIGF0IGxlYXN0IGEgDQpzZW50ZW5j
ZSBpbiB0aGUgZGVzY3JpcHRpb24gbWVudGlvbmluZyB0aGF0IHRoaXMgd29ya3Mgb24gQXJtIG9u
bHkgbmVlZHMgDQp0byBiZSBhZGRlZCwgSSB0aGluay4NCg0KQWxzbywgSSBhbSB3b25kZXJpbmcg
d2hldGhlciB3ZSBzaG91bGQgZm9yZXNlZSB0aGUgSU9DVExfUFJJVkNNRF9JUlFGRCANCmludGVy
ZmFjZSB0byBiZSBzdWl0YWJsZSBmb3IgYWxsIGV4aXN0aW5nIGlycSByZWxhdGVkIGRtX29wcyAo
bm90IG9ubHkgDQpYRU5fRE1PUF9zZXRfaXJxX2xldmVsKSByaWdodCBub3cgb3IgdGhpcyBjYW4g
YmUgZXh0ZW5kZWQvdXBkYXRlZCBsYXRlciANCm9uICh3aGVuIHRoZXJlIGlzIGEgcmVhbCBuZWVk
KT8NCg0KDQoNCltzbmlwXQ==
