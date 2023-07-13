Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12549751CAE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjGMJHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbjGMJGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:06:11 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2100.outbound.protection.outlook.com [40.107.215.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D849A1BF2;
        Thu, 13 Jul 2023 02:05:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ivcor+4MLyaLDCP969VzzWh/07WWCuCQxN3rgExYlUL1QzWUIhvSloBRE9jmoUeDsK+FJ8V1MTS3ERXLNN+mDOngsN/DB+DcDu0c2Yg5HJSvGkHK9iKRVuwodEjmASMgOKB/cCOAdqHYKN9qjQ0ucmUNiYykg0FbM+CNfAjz/GOWitje4AXD/QnVmxDd7wq2oWW7I7OVg2Z2hupdGAyENz8gG2DCArTXVKUdIC9ja/g/3IH11b9aOTnCbrgOYdA+UimEcVk5PFCdxtWqmLoDjTDvgNvrrhLH+PZ0582zuoujqpJTTnyqIxHOXJkH9Qlcj9OrXYvKPo6nTMijFFEXhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOFg2uqMGHfceZ/QLL7DhZjzBpf5uA7d0v9cfwl3nqI=;
 b=Cco7eYh4WU9s1mQV/hmZbxeqXfixj/euYagnqCpoAbz9JkyCv/7hrc81a3kfDW1yuOqE2Fdkf+jR+Bxf4pBYDeBK99T2wURnwWk9WxaJrAcCmp2ViwdlvmthYuvkjtLURyXrD139jrLTUrXbt7iWAfW/TToABCjAGxawbfta5xOOZuDccm30mwCNKp/QqedI6T/roYs1Hc4SQAV0vFV9rBgsL6lugTUXmYQJtlYibJm6Kus0zm1RtEiZkasj1jZ9VIhLq3l95qcQsFoEy2cnlm7jtForF/Zf8/ME/6S5gxl4xAcXgr8ILtEKWV4qx1gEVhRyifKf65jkh+QbXT+R1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOFg2uqMGHfceZ/QLL7DhZjzBpf5uA7d0v9cfwl3nqI=;
 b=X+/DKHRp9nP6218HXKkyxNYavGzKCHR42Nekvu9Syl8D9pyaSI+cpc3eeq8XV2uTwHbkJtkXzo5BsRzqR+hNjcvAl7Ec9Qdn3NK0TkLQODrBB09qRQlpr/QFRLC/nPdQgF2b3KAFF2Rry8kIF2V8uxa+H4IY+HMYuA+eEWa1akAX/U7/6Mse4VslWhEFxKL9VolPqCg8jdb2VbXkwQfcgMz7ysrIU6R6zOIbHOAjtABfolm1QaE1pCMXCFiQv3nvbmiNIZwZcNcLZO2LMB9h/UoEgUaAlrYbWvimLKli3mT2tii6QjNxLvk7TCwlFVDvg7HrKX84oAbdFKXhA+fBWg==
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 KL1PR0601MB4210.apcprd06.prod.outlook.com (2603:1096:820:2c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 09:05:15 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 09:05:15 +0000
From:   =?utf-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= 
        <machel@vivo.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     Rasesh Mody <rmody@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        "GR-Linux-NIC-Dev@marvell.com" <GR-Linux-NIC-Dev@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krishna Gudipati <kgudipat@brocade.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggbmV0IHYxXSBibmE6Rml4IGVycm9yIGNoZWNraW5n?=
 =?utf-8?B?IGZvciBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoKQ==?=
Thread-Topic: [PATCH net v1] bna:Fix error checking for debugfs_create_dir()
Thread-Index: AQHZtUxFdBcs7OOjzUWXxK9s8E8HO6+3MS4AgAA1ehA=
Date:   Thu, 13 Jul 2023 09:05:15 +0000
Message-ID: <SG2PR06MB37438F03D13983B7F603E43DBD37A@SG2PR06MB3743.apcprd06.prod.outlook.com>
References: <20230713053823.14898-1-machel@vivo.com>
 <27105f25-f3f9-0856-86e5-86236ce83dee@infradead.org>
In-Reply-To: <27105f25-f3f9-0856-86e5-86236ce83dee@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3743:EE_|KL1PR0601MB4210:EE_
x-ms-office365-filtering-correlation-id: 6a60c312-7bc5-4092-9f15-08db838045d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iegrbYJOBUOw3d4CO/CfiWYh1DFJPS4ajhfNQOqPivTMpq7Mfc6aW5eWNQ8ju3FQkNOv3erepB+r6JFFDXqWvCabohGIZL31rr4wKhKviFJwNvn59LK788wUN35MjtCak1BhbJ/nDxpU/Oxmeo5xC4oe/FPa+ekj/HOG8TZTUTzXfWMHAo06RzOV41DYYy/HskVIAT2u5RlKCA24gnVdlGfhTi79y8LmCZBSlVjG5JGiZGgVNt6v0tRljTM5WEeLGhq/R414l/x5m5Db3YjAAAiU43DdqwL9DE0bnwpjK4iOAITLNra2HJEVzY7xewwi8BQyA6E6EJ+uKaY0vB5N1ZgjzdUr1K990imoy0JP7egVTDe+VCnBYpYs9diaAIeit7mrxxXviwz4bhzk0RUTNEC5tWLGiAclXgJzx4iTa3IWXAG4/yklNgw7cJhQLsHmnUt9Kr8BM2z/up1CSGvX7HAcbEdCmZ7foAvnLx0JjJdHspCowORER7VSFhCc/s7jCZdN4IZB0WdfQz/ewX8UFQHNdERJlU5ANfWC08dN+VXiYIMdNpz0sB8NgK2Tv6JldltPtjWeKo5m+jsD2Cyj16wlIh3XWQYANoLphubyeBo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(122000001)(38100700002)(38070700005)(478600001)(7696005)(4326008)(86362001)(71200400001)(6916009)(54906003)(66476007)(76116006)(66446008)(66556008)(66946007)(64756008)(316002)(966005)(9686003)(33656002)(41300700001)(83380400001)(224303003)(186003)(85182001)(2906002)(8936002)(26005)(7416002)(53546011)(5660300002)(55016003)(52536014)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVU3RVMrWFpiQWVGbXJyYkFTRk9jQyt3TEJiS3RvVXY3MTVKYWs3Lzl0anYx?=
 =?utf-8?B?MFRhOTl1bjNJU3ZMRkFDS3MwRm1Mc3doaHdNVUFxK3ZRZlBkaGl5RTlHWUxv?=
 =?utf-8?B?b1B0Q2ZRNGR6ZERCRVdkZWV4UVMvSlZVbjF2OFI5UWpRZGVqb0ErZXhRcHhl?=
 =?utf-8?B?SHhJUTJDOHg2ajJ3bmpQek9kSlFnaU4rZTdYU1htekJaVkgreUZ4QWtpV1RV?=
 =?utf-8?B?WG94dTFacXIzL1FyYlUyT2lYeFdCby9aL3BHTEFpZGZMS1dzWFhvaVpuYTJ6?=
 =?utf-8?B?Z1NLQUd6NEdWYjQxZ1BKZGk0WHAxbkN6QTZiNUhGeEI5TEF1bStqRFNFcnJa?=
 =?utf-8?B?eDAvWDNoLzVob21KWEl4UjRIQmtzcVpCRUJ6ZU1yaEFZSDJrc3lsRWtqajRq?=
 =?utf-8?B?dmZyZ2FieGZpMGJtWG1hMFVVNlVOQjd1R1ZqOGw4TnhjYUFDSU9oYm9RWHkx?=
 =?utf-8?B?cFZ2dStGZ3paQmhaT1M4RGpQTHFiOFQ1cTg0bGZ3ZDVlYy9pVkEvSnBDV1k1?=
 =?utf-8?B?ZERoOUZHcjBKOVpJRjVoZEtmS2czK05qZkNrdFEyYndsTHRtNjVyMzEvMXI5?=
 =?utf-8?B?RFU2dkM5a0tPbEd5OHNOSDBYT1htMjNGaHduUW1xSiszbTZ0WG1hMk9HYy9G?=
 =?utf-8?B?aHNnMndET2J1MEdHVmdOQW5TbnFqK1E2Zjc5SVR2M1ZYOWxPNm9sTk1Jc0dZ?=
 =?utf-8?B?L2N3akEvVW50ZTVnbkVFVFNXUDNOdEJBdjlmRVQ1Zit4ZGMybVg4cGRSZnUx?=
 =?utf-8?B?TlAvNitxcWYySENZYnpzYjJXSXB4cFJiMjArc3lqbnFsZ3gxbk93cUpoZVh6?=
 =?utf-8?B?dmhXdUc1N2JnOFo3ckJTWnRpbllieXpkeGdqM1hPSTFTbUp6MGJHcnhBMVRw?=
 =?utf-8?B?R0Z6MG9xWGQ1UmgrQk1YdFQrQVliTWxwY3ZaVzFtWDFtbFZUZ2E3TVBxa3B6?=
 =?utf-8?B?SXhOYncrcnoxeFkvUkZCMzk5WHpwazRGbjRQNk5WZVZQbFhZZXpTTmdWYURW?=
 =?utf-8?B?SGtCaXVSNGQ5L0o0aHNoMzVLQ2lPNUxpVjNCWTNHek9ncEVCRm8wV1J1U2hy?=
 =?utf-8?B?S2hsaHFNd1NiL01WSjZTZ3FFMXZRUTd4VkV5a2FYT01FUlNoT2sxRm1nalow?=
 =?utf-8?B?SFpFNFZYLzJIekVuZklzcGJzeHBMWWRYQ3E0d0s5bC9XZWlyY2xTQzBXb1M2?=
 =?utf-8?B?OVcxSytqdHpsZVgvKzZSNUREcktaa2s0MXVkQkgvSytDemlnMmVpbCtQQ1VD?=
 =?utf-8?B?UnI2dnRacVN3SFFqM2F3VXhmQVpsakswR3hMODFGcmxoYW04dGhKb21MSjJz?=
 =?utf-8?B?aW8raUlyQTF0TnJ3a0Q1cjdKRkZPek9yNUVHVUpYOFdXRXNYUE9mb3pOZktW?=
 =?utf-8?B?K29PbzRKQ2NKSm0xZVF2R3l6ZlNuVTFhL0xXUG5lS2RHc3lCRjhPdXZhalk2?=
 =?utf-8?B?MnlIdjNkSFh0N0ZYUTkzOXY1WjJZRDlESk1GcGNhMDhFeVdIR0VnUk1qTlVD?=
 =?utf-8?B?VHJlcDh5UERJRGJMUWlSbUdJclVnM0xkcjNSZDBYZlc5MS9keGlyOUFmekdF?=
 =?utf-8?B?WEJLVHdBdnJ4eXhUTXhadGhVNEk1MEtTTkR4UElZN2Zsc3JMZUJqazRnTE1y?=
 =?utf-8?B?VkxNTHl5V2tHbGpaQ2RTQWIzWWJJU1U1Q2tvc0ZTblQxai8vaHpyUHEzZXZT?=
 =?utf-8?B?czJSWUJKUjVIUVd3Q1gzTlFJSFlBLzVVLy96VHltTk1Zd1hMbkd1cFREZEww?=
 =?utf-8?B?c090VDhOY3habTUwVXpKUzBFWFBrUUo5V3c1NHc4QzIrcTkvWlYvK1M3WEUz?=
 =?utf-8?B?ZXZvOFRWbkNQdTVWNFJJc2NZRWJGbHM0RXRYb3lESWZpSXRiQ1NwZGwwZUpl?=
 =?utf-8?B?NEU1aG9pYXoxanQzMGVZVnNaZUx2MmJIcXBaU3cxamdrajFwMVh6MjFUK2Jy?=
 =?utf-8?B?d0Ura1BJVGtXR3VaRldPVjVlS1Njb3JtVE5NdzlETTV4WlRRUm9tVHZ5a3F3?=
 =?utf-8?B?aVZ5dW8wckIxbkdnckdrbm5pRVh1ekhmeUxDYUx3TXRRZUt5dlVnMFUvMlky?=
 =?utf-8?B?K01NM3VjY1NPaUsyd3NNaHdBYnZQcEdGY084NmpUQStpOUlRN3NvUGNOeXFt?=
 =?utf-8?Q?pGoA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a60c312-7bc5-4092-9f15-08db838045d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 09:05:15.3513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P5JWGEtfI2GxMLyTvfjale+gpMnKAO9dzL2a3gXyvheePCDXgqV7lqZMo9kWsW/E5EC9YZSbmSs1lzj0poKBcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4210
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T2ssIHNvIEkgdGhpbmsgd2Ugc2hvdWxkIGRlbGV0ZSB0aGUgY2hlY2sgb3BlcmF0aW9uLiBXaGF0
IGRvIHlvdSB0aGluaz8gSWYgaXQgaXMgY29uc2lzdGVudCwgSSB3aWxsIHN1Ym1pdCBpdCBhZ2Fp
bg0KOiApDQpNaW5nDQotLS0tLemCruS7tuWOn+S7ti0tLS0tDQrlj5Hku7bkuro6IFJhbmR5IER1
bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPiANCuWPkemAgeaXtumXtDogMjAyM+W5tDfmnIgx
M+aXpSAxMzo1MA0K5pS25Lu25Lq6OiDnjovmmI4t6L2v5Lu25bqV5bGC5oqA5pyv6YOoIDxtYWNo
ZWxAdml2by5jb20+OyBSYXNlc2ggTW9keSA8cm1vZHlAbWFydmVsbC5jb20+OyBTdWRhcnNhbmEg
S2FsbHVydSA8c2thbGx1cnVAbWFydmVsbC5jb20+OyBHUi1MaW51eC1OSUMtRGV2QG1hcnZlbGwu
Y29tOyBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQg
PGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsg
UGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgS3Jpc2huYSBHdWRpcGF0aSA8a2d1ZGlw
YXRAYnJvY2FkZS5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQrmioTpgIE6IG9wZW5zb3VyY2Uua2VybmVsIDxvcGVuc291cmNlLmtlcm5l
bEB2aXZvLmNvbT4NCuS4u+mimDogUmU6IFtQQVRDSCBuZXQgdjFdIGJuYTpGaXggZXJyb3IgY2hl
Y2tpbmcgZm9yIGRlYnVnZnNfY3JlYXRlX2RpcigpDQoNCltTb21lIHBlb3BsZSB3aG8gcmVjZWl2
ZWQgdGhpcyBtZXNzYWdlIGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIHJkdW5sYXBAaW5mcmFk
ZWFkLm9yZy4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xl
YXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQoNCkhpLS0NCg0KT24gNy8xMi8yMyAyMjoz
OCwgV2FuZyBNaW5nIHdyb3RlOg0KPiBUaGUgZGVidWdmc19jcmVhdGVfZGlyKCkgZnVuY3Rpb24g
cmV0dXJucyBlcnJvciBwb2ludGVycywgaXQgbmV2ZXIgDQo+IHJldHVybnMgTlVMTC4gTW9zdCBp
bmNvcnJlY3QgZXJyb3IgY2hlY2tzIHdlcmUgZml4ZWQsIGJ1dCB0aGUgb25lIGluIA0KPiBibmFk
X2RlYnVnZnNfaW5pdCgpIHdhcyBmb3Jnb3R0ZW4uDQo+DQo+IEZpeCB0aGUgcmVtYWluaW5nIGVy
cm9yIGNoZWNrLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBXYW5nIE1pbmcgPG1hY2hlbEB2aXZvLmNv
bT4NCj4NCj4gRml4ZXM6IDdhZmM1ZGJkZTA5MSAoImJuYTogQWRkIGRlYnVnZnMgaW50ZXJmYWNl
LiIpDQoNCkNvbW1lbnQgZnJvbSBmcy9kZWJ1Z2ZzL2lub2RlLmM6DQoNCiAqIE5PVEU6IGl0J3Mg
ZXhwZWN0ZWQgdGhhdCBtb3N0IGNhbGxlcnMgc2hvdWxkIF9pZ25vcmVfIHRoZSBlcnJvcnMgcmV0
dXJuZWQNCiAqIGJ5IHRoaXMgZnVuY3Rpb24uIE90aGVyIGRlYnVnZnMgZnVuY3Rpb25zIGhhbmRs
ZSB0aGUgZmFjdCB0aGF0IHRoZSAiZGVudHJ5Ig0KICogcGFzc2VkIHRvIHRoZW0gY291bGQgYmUg
YW4gZXJyb3IgYW5kIHRoZXkgZG9uJ3QgY3Jhc2ggaW4gdGhhdCBjYXNlLg0KICogRHJpdmVycyBz
aG91bGQgZ2VuZXJhbGx5IHdvcmsgZmluZSBldmVuIGlmIGRlYnVnZnMgZmFpbHMgdG8gaW5pdCBh
bnl3YXkuDQoNCnNvIG5vLCBkcml2ZXJzIHNob3VsZCBub3QgdXN1YWxseSBjYXJlIGFib3V0IGRl
YnVnZnMgZnVuY3Rpb24gY2FsbCByZXN1bHRzLg0KSXMgdGhlcmUgc29tZSBzcGVjaWFsIGNhc2Ug
aGVyZT8NCg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2Jyb2NhZGUvYm5hL2JuYWRf
ZGVidWdmcy5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9icm9jYWRl
L2JuYS9ibmFkX2RlYnVnZnMuYyANCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9icm9jYWRlL2Ju
YS9ibmFkX2RlYnVnZnMuYw0KPiBpbmRleCAwNGFkMGYyYjk2NzcuLjY3OGEzNjY4YTA0MSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvYnJvY2FkZS9ibmEvYm5hZF9kZWJ1Z2Zz
LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvYnJvY2FkZS9ibmEvYm5hZF9kZWJ1Z2Zz
LmMNCj4gQEAgLTUxMiw3ICs1MTIsNyBAQCBibmFkX2RlYnVnZnNfaW5pdChzdHJ1Y3QgYm5hZCAq
Ym5hZCkNCj4gICAgICAgaWYgKCFibmFkLT5wb3J0X2RlYnVnZnNfcm9vdCkgew0KPiAgICAgICAg
ICAgICAgIGJuYWQtPnBvcnRfZGVidWdmc19yb290ID0NCj4gICAgICAgICAgICAgICAgICAgICAg
IGRlYnVnZnNfY3JlYXRlX2RpcihuYW1lLCBibmFfZGVidWdmc19yb290KTsNCj4gLSAgICAgICAg
ICAgICBpZiAoIWJuYWQtPnBvcnRfZGVidWdmc19yb290KSB7DQo+ICsgICAgICAgICAgICAgaWYg
KElTX0VSUihibmFkLT5wb3J0X2RlYnVnZnNfcm9vdCkpIHsNCj4gICAgICAgICAgICAgICAgICAg
ICAgIG5ldGRldl93YXJuKGJuYWQtPm5ldGRldiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICJkZWJ1Z2ZzIHJvb3QgZGlyIGNyZWF0aW9uIGZhaWxlZFxuIik7DQo+ICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm47DQoNCi0tDQp+UmFuZHkNCg==
