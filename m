Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38297EA0A3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjKMPxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjKMPxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:53:43 -0500
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC8CD52
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:53:40 -0800 (PST)
Received: from pps.filterd (m0174677.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADFUj6G028016;
        Mon, 13 Nov 2023 15:53:33 GMT
Received: from eur01-he1-obe.outbound.protection.outlook.com (mail-he1eur01lp2050.outbound.protection.outlook.com [104.47.0.50])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3ubk0rs92v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Nov 2023 15:53:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ufh+ui458jT/tIE1XYuSiugPrmyQfXtkoNgREXLC76ey05cKDB3+9sj/t2qsTSQfMZBnb3GGka3UMahthL2+FLlp63OnyZAz0cPJTeayluYkHCzt9UI/96UFyHs+PoCeDvGhQY2dl2btWcdw9/F5P3OflktlDj/cAaVdSJ5ort2MLSxdV06hQj8E326DfUltfIrdeV5l6Mhcl8M4szBI0Y5Xh/HQH8z0PiOEN/ZQWBaP3LtOTRVfrJIwaOu4vk6J1frfGmTRFhmOTN2TBW0mq1qBTohP5CludYlFwY/RSWyfAbwhuPEO62JnH8iHeq3PthwfADUuXOR9FitcHArKXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETMtRESNJmr+goj+uKvRRM2zLqwLPCkv27sDTe2V00g=;
 b=j7s834UTT5EAMsvA1ynxtIp3Ce59ryCLm6CSmQgueX7n/ETfuFtJfO116YoAkX6ZGnDR6UrL6wsnM1mD0iyg/t3yZdy+dclNpTxE2IhxD6ohzcE+XBgfW7h28du+ebmMcUWso5muX5IZJTvcVK+OEXNVlo6aG0X/zIJtH6RyB9JWsofh69kwKtezfxP+zgydAFU3UxEfYuMkJH9nrFrcYjNRkfSF7BYupMI9d6iFw0Bg2AQNkEzzAd1MsIBq1G1ZGyPkRCoTJi4uYoWf1VcC5L7FXM/T4UOfXJ2A2KcFCc2VD6pndiYDuJSZE5RxSmkQAjjDGbmpTqjdZ4mWFay/MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETMtRESNJmr+goj+uKvRRM2zLqwLPCkv27sDTe2V00g=;
 b=PCROIdLtaYOcJdg3D1NqNSogWfWYfs0fNcY3KEThtgSIkpc/CwqtphRiqPS6TOxDDiHSa4A47EJpJ+L01ZysPm7UDV2pHzqc+3+p72MQauOr36oY9bOr7kc6Rt0SlYe9NR19/2PwK1iEqACTGasALnfvmlNGNLKbq6Ufl7U+hpWPTsrjggF2a+JRwG6iCGVrAmfMHGIcEhrmfoZuz1thjkD3QIFFeDVQG0cJVbnykMJHqMZzJmxcMdESxiXy7RfdbBX/g1exAEb0Z+KMHHl8g/kz950nc6OeBzKV6XJ0pKTYujIZIvXEgA+mF1b1l+qyKH/QEsZLf30QeyTP4SMmfA==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by PA4PR03MB6893.eurprd03.prod.outlook.com (2603:10a6:102:eb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Mon, 13 Nov
 2023 15:53:28 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::fea9:8f02:fb13:fd44]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::fea9:8f02:fb13:fd44%6]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 15:53:28 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 3/7] xen/events: reduce externally visible helper
 functions
Thread-Topic: [PATCH 3/7] xen/events: reduce externally visible helper
 functions
Thread-Index: AQHZ//oKavD9kfGMLE6r3CZA/iY8BbB4kyCA
Date:   Mon, 13 Nov 2023 15:53:28 +0000
Message-ID: <86612c88-5ea9-4730-acf3-2a7e40804c27@epam.com>
References: <20231016062831.20630-1-jgross@suse.com>
 <20231016062831.20630-4-jgross@suse.com>
In-Reply-To: <20231016062831.20630-4-jgross@suse.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|PA4PR03MB6893:EE_
x-ms-office365-filtering-correlation-id: bb885ef5-0d95-491a-a81e-08dbe460ad7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lE+WyCYjoABhSSUmGpvWhEqyxv7PzEK+HtTmSryyuuQKnbyI9ah5DfOHIjUUj5NLmU0rHMBLQwmd6UGR+DSk3gYcCgL83FvH72qCejlNKJCsXKT+q4A38As9j7vudPo8hOpgRh2UCLlT6DFHKeucfb7iD8ay+Pt8oMYMF/gE4QYFaD81JTMjv37dlQ0IEgZGEIethdKcZ4WmMsawu0N234/jTkLYpM6bBIg6O4JzC6uJJOV05bCttt/u0L/WZ9MwboQoaJITqWFZ+dqBmM4zY4TYaiV0Q2I9QfZuqVMdbfDhdgTzJ2RkDh1MxKfpK3bpSrQr05MfKrJiImwK2N6cZosrNibVFx6ZPan6XvgiuEqF4PcV8vg0x3b5AxCTK/7BA1Pf7eagDMvebl0FX3DR/5r7ACWP7NyvDkfdbJikVynNxLwwYabluEjmU4eBhBU5MtMSMq0OGKSDfpyLomyictQ1cdQLN03LOt/P2CvTIS5RqlpMbXN0jKAdmqS22CynDIjGZIq2OH3YoEtP1qJE3Pp7sSUY1JQWKLh2xNVGKymNN6J/a/wpDCjywR7upnql9tv2SiFMGIUrJ4GF05jCY77NGEXdKT7Wi6yzBNOyYqQenDmwCh+3zT8qPT+Yox8cpWpz43n8yXdi8gK6BYSmEaYZNbgWK1Szeez0/g0wpZq0eWJ0BObB3mGDo7v4jl3G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(366004)(39860400002)(230273577357003)(230173577357003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(4326008)(8936002)(8676002)(83380400001)(86362001)(31686004)(26005)(41300700001)(53546011)(2616005)(55236004)(38100700002)(122000001)(6506007)(316002)(36756003)(31696002)(64756008)(66556008)(110136005)(54906003)(66946007)(66476007)(76116006)(66446008)(91956017)(6512007)(38070700009)(71200400001)(5660300002)(6486002)(2906002)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFJUU1UvdmpvNjNnYnZOMzdqRk1FdUJ5VzVKUzlOZ3U0NEo2MTRWakhpWjg5?=
 =?utf-8?B?RzNORTh4Nmo1MVlpSCtVbm8yeGJ4Vm5NbkgxNzloM3Y2b3ZQUHJKTjZNRFlS?=
 =?utf-8?B?K1NsRzJlRkNTY2c1T210WTB3RHFrdURXWnVlRDNrODJXOXlNUlcwc3BuSHNI?=
 =?utf-8?B?MU44THc5Unp6aTVCUDFZZUM0VUl1SXVuWEJoMmtOanBNTFdFTzVWbjZhMjkr?=
 =?utf-8?B?c0VLMDh0bm05Ry96TWhqRlA3TWxlQVhHWXp4ajhUYTlENVpTTUdKdG9GVGFk?=
 =?utf-8?B?N051MTFmK0prUmttcWtyRlBWQ09WOUZqcTdBN1lDZGdzT05NVVFENUg5dlRG?=
 =?utf-8?B?MFh3Ym9ZamZidWttUTk0dHBrTzl2NGpMdTB1UmhxZk96aVp1QTNibUVIMjFK?=
 =?utf-8?B?am0rVGNIRDgvOW94bE9DZk9kc0tLaTFwdmZGUjZzRVQ2VjBqcmtETGw0RlZV?=
 =?utf-8?B?THVLNEo2eWNnV2dxVEtZeStFN0t0ZVZIbTN1MWwyN1ExQUI3WTFRZC9HeERN?=
 =?utf-8?B?VWh1UDZDTXZ0T2lSRWl2eHFydVJOQWVEL0grSllaOUI1T1I5WFI0am1rZmF0?=
 =?utf-8?B?UEE0UVpYN25rbW91UUtreUNRdnRvVUdkWlI3VkJqa2tDTVRUZkFnZURteVdo?=
 =?utf-8?B?QXdJOGJqQnl2dGF0S1B5OGxPMkJBOU5YRUlvanRRZEhuZVBFcWx0UjN3clg5?=
 =?utf-8?B?K2lWMzJmTnJJaExxSFIyZkZ3YUJpVkpjdmtyZ3NDQVBNc0M5MzZ3dUZja085?=
 =?utf-8?B?bGVIYS9seUcwVWIzOUoreHhaUk1UV3Z0alduV1kvOE9nSXlqYkZTV2VuMGVH?=
 =?utf-8?B?YlJTUWhlMVVOVUdOY1VHeHdJSGR0K20zd3o0VDBoKzZ6b0trSmtqaVZxZlVy?=
 =?utf-8?B?VndBZHhYRHMzRlVwR2M4SHpQMDhHNDJ0SFZuVnBvTmpBL09mTEJZclRuM0hw?=
 =?utf-8?B?SDlDQ2FKWGhTZzhaOWFNRkdzUG1uTlZCNi9GTDZiMkt3amxwSHVMQkJrUHY1?=
 =?utf-8?B?WmJUZWorTmNjTnNkUlRBZGtyTUY2ZmlmdmRwa0ViNUVxQVRuYmZvRFgzeFhM?=
 =?utf-8?B?Uk9sYmxnTER3YjB3MkRQZU1vSHFvbW5RdHprZnRIMjQ5OUc3Q21KVUMvRE0w?=
 =?utf-8?B?TmlmRU1USGFMMjFtOEhwZWJhQ0daTFpkZFlSUjVBN3hDNEpibTE3VHpmeWxh?=
 =?utf-8?B?dGN4Z05Tak1wRHdiMy9ZV28zaDJqWkxtMWRFVUx3aUpzbkgwRXhGK3lNSlVS?=
 =?utf-8?B?NXdkTkZpc1FTNUpQczJSV0hWcitOMkJzTm1mQUVMUnM1QlUzbXNKekhrMW00?=
 =?utf-8?B?SVR4YkNTcjFsQUFDcmtRM1VzUnlUNW1HNmdXRXpaYjI1Vm4rdzRZZXAySkty?=
 =?utf-8?B?OXZUNGR3ZFZlclYwWDBOaWs5dE9IZ1pzaEdPdUxHNGErZ0ZDcGhSTmhBeFR3?=
 =?utf-8?B?MHdGSnZMSis3aVNrTnRZc2Y1czRPMFpRVVJFUjVpKzN3MFZ5NWhPdTZwT3dk?=
 =?utf-8?B?N1h1cmJiZWQ1YXgyN1VJZHlabndaVTQ0TEJ6Tkdzcm41cDJ1ZHVaSkpKNENB?=
 =?utf-8?B?R05zc2lrc0JMclI1UlY2RE53V1VKc0NMN0N3WGVTaitHZ2NPR3ZSSHNNSlV2?=
 =?utf-8?B?UTU1MkpUOHJ0ZXZiSGFVZEliaTUrWTZuSEhZWXoyR1UxN1M4bkE3dkZ4TGNT?=
 =?utf-8?B?RDV1MHFYZGlQcTVobVA1ZkZsUmh4V04ya2FqMU5PQ0UrcDJuZUg1WUhFVmxx?=
 =?utf-8?B?ejkvV3RKdmtzQ2Q5cnVoRjQ0ZXh4K1cwN3FSc3VHVGQ5SmdrT1pVRnZ3WUVi?=
 =?utf-8?B?anUrVzJxcmppZURXSUQ4MXZBOHE4M0toSE44ZlJwem9CckpJVjVLd0lNeHkz?=
 =?utf-8?B?Q004cG1SQzBDTk0zSElNYlN5OTNlaG94a0k5Z20wNHRNcjNNNGJrWmhWSVZW?=
 =?utf-8?B?cUZDZkJtMHdZMVdEVDZzZlFENTl6L055cTdNclpIdWY3azk1WG9mVkNoWHpS?=
 =?utf-8?B?RVhwTU9Ec2VmUzFsQ2tDaGxaVDh6Wk4vTm95Sk9KVW1pOC9qczRIZ2RjbjVS?=
 =?utf-8?B?T3djRTE0d0daZU0yMktZemVZcUhZdmYzWGJGQ0VNL3EwSmlmbWg3R0ErTFRL?=
 =?utf-8?B?TTB6ZE9yMW1pdk43NE1LSjFzQUFpSS9lV0Z4eG5icndyVDJ4R3cxRnBCNWVC?=
 =?utf-8?Q?XzyaUVmLG/XRw6iYgZIIHzc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D120A4ED1730A742B851EE66EA44C5E5@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb885ef5-0d95-491a-a81e-08dbe460ad7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 15:53:28.1575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQ6kBYLdW9Q5jrz1bc9asN0d+NZIoYXG9vYS5mp9DiyWz4+GQyCG4owG6WZUQe5DYNj5z1qpxPfbpdhYw1EOeBQy88vnop0/bsS+2Kp0ey8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6893
X-Proofpoint-GUID: pV8qRS2m9tEHSdArQchcymCNt80g-bAQ
X-Proofpoint-ORIG-GUID: pV8qRS2m9tEHSdArQchcymCNt80g-bAQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_05,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=800 suspectscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311130129
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE2LjEwLjIzIDA5OjI4LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KDQoNCkhlbGxvIEp1
ZXJnZW4NCg0KPiBnZXRfZXZ0Y2huX3RvX2lycSgpIGhhcyBvbmx5IG9uZSBleHRlcm5hbCB1c2Vy
IHdoaWxlIGlycV9mcm9tX2V2dGNobigpDQo+IHByb3ZpZGVzIHRoZSBzYW1lIGZ1bmN0aW9uYWxp
dHkgYW5kIGlzIGV4cG9ydGVkIGZvciBhIHdpZGVyIHVzZXIgYmFzZS4NCj4gTW9kaWZ5IHRoZSBv
bmx5IGV4dGVybmFsIHVzZXIgb2YgZ2V0X2V2dGNobl90b19pcnEoKSB0byB1c2UNCj4gaXJxX2Zy
b21fZXZ0Y2huKCkgaW5zdGVhZCBhbmQgbWFrZSBnZXRfZXZ0Y2huX3RvX2lycSgpIHN0YXRpYy4N
Cj4gDQo+IGV2dGNobl9mcm9tX2lycSgpIGFuZCBpcnFfZnJvbV92aXJxKCkgaGF2ZSBhIHNpbmds
ZSBleHRlcm5hbCB1c2VyIGFuZA0KPiBjYW4gZWFzaWx5IGJlIGNvbWJpbmVkIHRvIGEgbmV3IGhl
bHBlciBpcnFfZXZ0Y2huX2Zyb21fdmlycSgpIGFsbG93aW5nDQo+IHRvIGRyb3AgaXJxX2Zyb21f
dmlycSgpIGFuZCB0byBtYWtlIGV2dGNobl9mcm9tX2lycSgpIHN0YXRpYy4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCg0KDQpSZXZpZXdlZC1i
eTogT2xla3NhbmRyIFR5c2hjaGVua28gPG9sZWtzYW5kcl90eXNoY2hlbmtvQGVwYW0uY29tPg0K
DQpUd28gTklUcyAqTk9UKiBkaXJlY3RseSByZWxhdGVkIHRvIGN1cnJlbnQgcGF0Y2ggYmVsb3cu
DQoNCg0KPiAtLS0NCj4gICBkcml2ZXJzL3hlbi9ldmVudHMvZXZlbnRzXzJsLmMgICAgICAgfCAg
OCArKysrLS0tLQ0KPiAgIGRyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jICAgICB8IDEz
ICsrKysrKysrKy0tLS0NCj4gICBkcml2ZXJzL3hlbi9ldmVudHMvZXZlbnRzX2ludGVybmFsLmgg
fCAgMSAtDQo+ICAgaW5jbHVkZS94ZW4vZXZlbnRzLmggICAgICAgICAgICAgICAgIHwgIDQgKyst
LQ0KPiAgIDQgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy94ZW4vZXZlbnRzL2V2ZW50c18ybC5jIGIvZHJp
dmVycy94ZW4vZXZlbnRzL2V2ZW50c18ybC5jDQo+IGluZGV4IGI4ZjJmOTcxYzJmMC4uZTM1ODUz
MzBjZjk4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3hlbi9ldmVudHMvZXZlbnRzXzJsLmMNCj4g
KysrIGIvZHJpdmVycy94ZW4vZXZlbnRzL2V2ZW50c18ybC5jDQo+IEBAIC0xNzEsMTEgKzE3MSwx
MSBAQCBzdGF0aWMgdm9pZCBldnRjaG5fMmxfaGFuZGxlX2V2ZW50cyh1bnNpZ25lZCBjcHUsIHN0
cnVjdCBldnRjaG5fbG9vcF9jdHJsICpjdHJsKQ0KPiAgIAlpbnQgaTsNCj4gICAJc3RydWN0IHNo
YXJlZF9pbmZvICpzID0gSFlQRVJWSVNPUl9zaGFyZWRfaW5mbzsNCj4gICAJc3RydWN0IHZjcHVf
aW5mbyAqdmNwdV9pbmZvID0gX190aGlzX2NwdV9yZWFkKHhlbl92Y3B1KTsNCj4gKwlldnRjaG5f
cG9ydF90IGV2dGNobjsNCj4gICANCj4gICAJLyogVGltZXIgaW50ZXJydXB0IGhhcyBoaWdoZXN0
IHByaW9yaXR5LiAqLw0KPiAtCWlycSA9IGlycV9mcm9tX3ZpcnEoY3B1LCBWSVJRX1RJTUVSKTsN
Cj4gKwlpcnEgPSBpcnFfZXZ0Y2huX2Zyb21fdmlycShjcHUsIFZJUlFfVElNRVIsICZldnRjaG4p
Ow0KPiAgIAlpZiAoaXJxICE9IC0xKSB7DQo+IC0JCWV2dGNobl9wb3J0X3QgZXZ0Y2huID0gZXZ0
Y2huX2Zyb21faXJxKGlycSk7DQoNCk1vc3QgdXNlcnMgb2YgZXZ0Y2huX2Zyb21faXJxKCkgY2hl
Y2sgcmV0dXJuZWQgZXZ0Y2huIHZpYSBWQUxJRF9FVlRDSE4oKSANCmFzIGl0IG1pZ2h0IGJlIDAu
IEJ1dCB0aGlzIHVzZXIgZG9lc24ndC4NCg0KDQo+ICAgCQl3b3JkX2lkeCA9IGV2dGNobiAvIEJJ
VFNfUEVSX0xPTkc7DQo+ICAgCQliaXRfaWR4ID0gZXZ0Y2huICUgQklUU19QRVJfTE9ORzsNCj4g
ICAJCWlmIChhY3RpdmVfZXZ0Y2hucyhjcHUsIHMsIHdvcmRfaWR4KSAmICgxVUxMIDw8IGJpdF9p
ZHgpKQ0KPiBAQCAtMzI4LDkgKzMyOCw5IEBAIGlycXJldHVybl90IHhlbl9kZWJ1Z19pbnRlcnJ1
cHQoaW50IGlycSwgdm9pZCAqZGV2X2lkKQ0KPiAgIAlmb3IgKGkgPSAwOyBpIDwgRVZUQ0hOXzJM
X05SX0NIQU5ORUxTOyBpKyspIHsNCj4gICAJCWlmIChzeW5jX3Rlc3RfYml0KGksIEJNKHNoLT5l
dnRjaG5fcGVuZGluZykpKSB7DQo+ICAgCQkJaW50IHdvcmRfaWR4ID0gaSAvIEJJVFNfUEVSX0VW
VENITl9XT1JEOw0KPiAtCQkJcHJpbnRrKCIgICVkOiBldmVudCAlZCAtPiBpcnEgJWQlcyVzJXNc
biIsDQo+ICsJCQlwcmludGsoIiAgJWQ6IGV2ZW50ICVkIC0+IGlycSAldSVzJXMlc1xuIiwNCg0K
Y2hlY2twYXRjaC5wbCBzYXlzOg0KDQpXQVJOSU5HOiBwcmludGsoKSBzaG91bGQgaW5jbHVkZSBL
RVJOXzxMRVZFTD4gZmFjaWxpdHkgbGV2ZWwNCiMzNzogRklMRTogZHJpdmVycy94ZW4vZXZlbnRz
L2V2ZW50c18ybC5jOjMzMToNCisJCQlwcmludGsoIiAgJWQ6IGV2ZW50ICVkIC0+IGlycSAldSVz
JXMlc1xuIiwNCg0KDQo+ICAgCQkJICAgICAgIGNwdV9mcm9tX2V2dGNobihpKSwgaSwNCj4gLQkJ
CSAgICAgICBnZXRfZXZ0Y2huX3RvX2lycShpKSwNCj4gKwkJCSAgICAgICBpcnFfZnJvbV9ldnRj
aG4oaSksDQo+ICAgCQkJICAgICAgIHN5bmNfdGVzdF9iaXQod29yZF9pZHgsIEJNKCZ2LT5ldnRj
aG5fcGVuZGluZ19zZWwpKQ0KPiAgIAkJCSAgICAgICA/ICIiIDogIiBsMi1jbGVhciIsDQo+ICAg
CQkJICAgICAgICFzeW5jX3Rlc3RfYml0KGksIEJNKHNoLT5ldnRjaG5fbWFzaykpDQo+IA0KDQpb
c25pcF0=
