Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0677762C41
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjGZHBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjGZHAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:00:24 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1467A26B8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:59:28 -0700 (PDT)
X-UUID: f4e2ef3c2b8111eeb20a276fd37b9834-20230726
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=C8C9aQoCYriptqfO0phxzPA1vCwtithpToZhPKwdd+w=;
        b=quzm/YJUs7xjms4raJKvVcBPIZgUThjgAcFXCo1zRW+Ky0+0prI/iuxVI9SUmkjfo+lIe/iw9H3KkXKHZ76+/IU3Ig3fpy37x5+Q0vBO5uvWigVqRDIMt2nqLuouEAAjPJDzTpSFIoLYKhrBHBArFf9I8QKGwMu4VdEPaN/GhpM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:153c9255-098e-407b-97ec-4802592ea165,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:51
X-CID-INFO: VERSION:1.1.29,REQID:153c9255-098e-407b-97ec-4802592ea165,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:51
X-CID-META: VersionHash:e7562a7,CLOUDID:3ba87742-d291-4e62-b539-43d7d78362ba,B
        ulkID:230726103132PXEIV6U1,BulkQuantity:21,Recheck:0,SF:29|28|17|19|48|102
        ,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:
        0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_OBB,TF_CID_SPAM_SNR,
        TF_CID_SPAM_SDM
X-UUID: f4e2ef3c2b8111eeb20a276fd37b9834-20230726
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <andrew.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1441538065; Wed, 26 Jul 2023 14:59:25 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 26 Jul 2023 14:59:24 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 26 Jul 2023 14:59:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=If9dWRzxXgKIIBO12B+XRoyCWmeZckHb594laLXn6X4i//5cLQIoBWqeqrRPvGJPAugr1X/Mo5K3ioIiturgfg1mDY6Z/pwxMXygqx+GHBt3phYashJQpdholRNmxzSNeg95DsmN4VBS7HqruoSdS27I7ccd1KF56KumP86up8MQHaemvXYpIY4vkWkh+vPtHCmWN09e/a6LVIaMNaQ2wk/Eowt7nFg2R6GUfKxuLQdtbjXTAVRVHXPzuMe7UadB9nUyTomN95sw/4CEdYThTyUYa/pXtCHYWYFh056ikwzchLGoXdqxGAx6dvPpZrDmNUBtgCRTAXQMAJjRz41a+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8C9aQoCYriptqfO0phxzPA1vCwtithpToZhPKwdd+w=;
 b=QiwEWUyS2pTqyLDYPk3EOBqR0f2jLXQP1JOALj/Z6hs08QY+rSEiL4ARGiPt2aF9rjBhFYd6c4gU0o0xja+Q9aUI92BGDRSxat/r3joo0D7sNGiCH7RhUTM9gSiBzR4UCvdDX8h4uEpxiJkDjxS6OTl1YGO01XrU8hRiwN0jLajJ7K0n74BytrbhmBhxOl8sVnTv9Iped3/jbUXUat1tpFQVEsCc2Cp14nqN3Nhv8N6eW6zhezhpzsnY4UN1Bcu7/MXeLrlk8JZJ6MJRLKMFP18tEw+UlcKo+nI4wB/ZbBYd2owEUr4DBp3FdlbUJBGPC7bSIWaXfh9Jlb3N9nBzTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8C9aQoCYriptqfO0phxzPA1vCwtithpToZhPKwdd+w=;
 b=EbRxSyWfqece58JY+YPjQ7JJPOiZY4TYaA0mrUrcidFQF+O3a2obj6zAzUYnEeEJRXKk58nDc641s3sei05eGuu1SeGzbPYZN/BEeqlc5Y3Y1mh4x1Hc3cy3aRVaAyvYKBhVmWpyETXApNMV299hFtfVodXqmynT/1n0HSBAMu4=
Received: from TYSPR03MB7499.apcprd03.prod.outlook.com (2603:1096:400:410::13)
 by JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 06:59:20 +0000
Received: from TYSPR03MB7499.apcprd03.prod.outlook.com
 ([fe80::8b5e:16a0:be56:34f6]) by TYSPR03MB7499.apcprd03.prod.outlook.com
 ([fe80::8b5e:16a0:be56:34f6%5]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 06:59:20 +0000
From:   =?utf-8?B?QW5kcmV3IFlhbmcgKOaliuaZuuW8tyk=?= 
        <Andrew.Yang@mediatek.com>
To:     "senozhatsky@chromium.org" <senozhatsky@chromium.org>
CC:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        =?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] zsmalloc: Fix races between modifications of fullness and
 isolated
Thread-Topic: [PATCH] zsmalloc: Fix races between modifications of fullness
 and isolated
Thread-Index: AQHZu53Jd1JGdJ2S3EGUdQf7Nnsxca/LaIsAgAA9n4A=
Date:   Wed, 26 Jul 2023 06:59:20 +0000
Message-ID: <42f1209a686404ffd0f9dff05ed10a8d23383a11.camel@mediatek.com>
References: <20230721063705.11455-1-andrew.yang@mediatek.com>
         <20230726031846.GJ955071@google.com>
In-Reply-To: <20230726031846.GJ955071@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYSPR03MB7499:EE_|JH0PR03MB7983:EE_
x-ms-office365-filtering-correlation-id: ddf5f2c4-83d1-41a5-ab02-08db8da5d630
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0VjOrsO01i2IMuOiJlGG3pv9SYKtGiN/4/6EbwIbhg8seruCzQYPBQ37c7fvakwSs8ZHw9jH6l479XYEAJ+jksBdBYE9jzoPguPfvI4oPhVHLQNBfNkBmMVQOayfsl4/Yx4T7ykSzREM7Ic7bNVqWq3MARnJYyRrbG6i31EsdvvbCSTuHZtanFtOd+TvzCy73vg13/IuOP3Ba4j6NiupRW4YwbNLNaosrAOffzum9ODP5tWY81QmlhgcXeCnodH8ncHaGj/EBFegZz9NDlFYRraRkrUgwIhak75JCsJQwP7nHpgvpMJtiW/R/BWDfMP37B5WqOY8Fhbhqm8PROs+Citu5vJ9MmAyR2XiWpqKGFf9V3mh1HDyDh8pcZWi1YoH7PRXbVg/lgErQPxZNx+Eg6fkl6oiFbLyGTTfplHx6axGtVPubmaeeJUiRynZmrvVCIsDNwu31+DcNaLondWjTaLFucSM1pD4Ctu0525RXBAFvSe93eBgMqt9VHcwFx6bWhDp3X3QYR2h7OtGToNmtfqsuUqs4z5O4w0asUHOkBNUfmrL5iHgEJJea0M4dcJ0nCUR463vyBoEe9Dn6L32OyvMJed5GBpkJOGPt8C2bnhfRN8uVCxVyLdc5jTwTeh0uQ8pRHPRI79YiDPGbKqVt5erlx0/nq1u3WjMGhnzjaw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR03MB7499.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(54906003)(6512007)(26005)(6506007)(478600001)(36756003)(122000001)(38100700002)(83380400001)(71200400001)(2616005)(85182001)(6486002)(66946007)(41300700001)(86362001)(76116006)(66476007)(6916009)(66556008)(66446008)(64756008)(4326008)(91956017)(186003)(316002)(7416002)(5660300002)(8676002)(8936002)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTRpV0pRQkQxaGduRGduQ3JlR1dLSkVQbTJDL3B5MmkyTGp1RDhYZkxVTzZh?=
 =?utf-8?B?RWhPVXBBZm9VRzZ1SnFwK3FBSkREWFFESU52L01MRXV0L0c5VytqY1hNanpK?=
 =?utf-8?B?ZWVCY2lKOVhhRjZXMnhVSnVFTmlFYnZLaUU5aGVPTUVhclFuaUVGMk9EN3Vo?=
 =?utf-8?B?TkNvNDk0VkJpalJKZDdrZ0lvcUR5NjdOcVNvY0EvU2o0Q2srY2xBUUhiZXlV?=
 =?utf-8?B?L3gwMUwrMWkwQVpEZWpmLzhEZFRGOUdzMDhEdFI1VVFoVjJXREhpRWRGZngr?=
 =?utf-8?B?NWlhSUlyT3ZNb1JpQzBiOHE0R2tEY0hJUDMxWFVTT0hwSENPUnpCbmpYTzh2?=
 =?utf-8?B?TDFFOStkaTlaQjhrMmZLeENhRW9DMFE3a2tqckpIeHE3QVBaeU1QK0RIVjE5?=
 =?utf-8?B?bHJHVFdRZzhaVWZGaHk4M1QrK2hTZytPMUxUVFl5dHNGN0gzbU5aWEg3Yk5Q?=
 =?utf-8?B?RU50MU9ZSmdjczdndE16RWM2LzU5bE1HU0FBVmx3MnlmNWErc3prcHBhQVNE?=
 =?utf-8?B?SWlkNjlOUzV4SnBvVWhucHUxSTJNM044dDRWSnZPbjlYbUcwRjMrZTlLZllh?=
 =?utf-8?B?bGNVdkMvWDN2S2JodEptT3pTWXc1RnBvZVFUL1UvWnplZFM0NjBzOXhYSVB2?=
 =?utf-8?B?TUduN2tOUEE2OUJrTDRWeHFBR25DQkNReDFMOWlnc3ZleXBEalBzQ2E0bi9p?=
 =?utf-8?B?R0pRdGQzMDMyRnBQRlJpTGFnM2tZZ1dSQURNR2tuTGxpaFJkcHdrWFFxQUND?=
 =?utf-8?B?L3ZzOUZXbDNtVDVoRnZpek1hMWZTTndtcklqeUtCOGlGR1E5WWxJM3VaRlRK?=
 =?utf-8?B?ditWZGVLdm1YUnB1L3F5U09VVEVMTSt6dEtkM0FEOUs5aG93ZjA2UXRnMnV2?=
 =?utf-8?B?MDB4eTMwQk5mYkhzYkVkcUUxOUs3U0JEMmNkUnN5LzQ1SzJTRmF2dVhPa0Jh?=
 =?utf-8?B?UytYaWlCeER5VzBzdlBHWXNZeXRHVTBibjlLMHFPR3Rtbml2ZUxEdEhBRFVn?=
 =?utf-8?B?ay8wOURxOERFLzJGM2EvVGJXQXpBblhvb3FoRFNxM2xNQjBVZkIvTVhBQ3hh?=
 =?utf-8?B?aStRMTdlWEd5cXdJSzc3OXkzUU5lSTVVYklFMFZ0UXllT0hDWm9wQVYxSGlr?=
 =?utf-8?B?MnJyQmhGTkREcUlFejhTemJSZHdhdHdiN29KNnc2WUpzVTg3ZWJsTGFFWE9t?=
 =?utf-8?B?VENiTDRjd1oxS0ZiZmJ5VjBRRFQyMEo1dVRRdFlXYm8vTXhkT3lCa0kvdGxW?=
 =?utf-8?B?bEx2NS9ZZXlqSFdGU0RjejFEU3Q4NWd0ZndUcVRwV3BjRlVZZEJVeWJvUHNT?=
 =?utf-8?B?bnZVL3VLT3NEL1o5U3htU0ZnbEN2UUMwNE01TnZPazhYTldGd3VxNWRvRjg0?=
 =?utf-8?B?RFBFbk5QMXA5aTB1WWgyazhmdnlWc0lZVm5uWFpiZVdmZ1ptTFhiL3R6TXVk?=
 =?utf-8?B?THd3ZWpLMDNLZ2UyMWxqOEFiRkwybnhZQy8yNFJHR29zRFRGVFBHcFNZQW9K?=
 =?utf-8?B?UlBvUkdxVnpoK2VWdHBDc0RXYW14Q3JvaFdJdm1YM1ZFa2RrOGxDcU1NcmRN?=
 =?utf-8?B?b3VrY3dJbHJEVzhZeC9uRGU4dnk3VFhncUs4T3VJZ3VieTgxSmFwbWhNd0lF?=
 =?utf-8?B?S3QvZ2pISEo4UDhSRUVNOGlBbTJsaFZuL2FOTE0xTllHUEpQK3pkWGttWlF2?=
 =?utf-8?B?UWVRTHB3RjgzSnpPSWMwUFZHVkk2U1AranFXNTZJRmhCaXU4alNydTA0V2lu?=
 =?utf-8?B?Z1FtU2hvRmxQTmt1RW1jdFpDbHpmTnI3YXlVeWFuODNZWU5GRXRSUFhuRGNL?=
 =?utf-8?B?UlJFMmQ4eElSZEE4TVdXWXZUb2ZBeGkwYk1qelkxZEk3Sjhqb1Fjai9GMENs?=
 =?utf-8?B?cjk5MEFPdEhrZ1JIT3VUZVVSdmFKa0NZQ3FRNlM1aW8zUnkzNEVGNUJwTjl6?=
 =?utf-8?B?dTlZLzREcmlWaXd3Tk5MdjJzdkJwWXV2TWVGUzNQSE9Sc2ZjdU9ERXhLd3N2?=
 =?utf-8?B?WFJjMDF5VG82TndpL2hHeTVHcmwxVkxsdWZzVjlUM2FiM3FZRkNPTUpBZnVa?=
 =?utf-8?B?ZkthVHVhOFRaVEZZeG9iSS9CK1R3Y2ZxQnRmY3BjSlpPZjNyeTlJSDgvNmg5?=
 =?utf-8?B?SzVQVi80ZUpTc2xHeCt0L0doZ2RQcEJYS0d2U1RSNE5LaUljZUR3M2ozSExx?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DAB3A61190CDF449134692B3A84C02A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYSPR03MB7499.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf5f2c4-83d1-41a5-ab02-08db8da5d630
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 06:59:20.5605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IwAKgBGq+zgVmj7KdjESMoBrir3tuu68Uz5cg4eYL5YCvcC3/lnIWbDEcl64KNeZWLrLarqw158QtniCedq9MVHymri9u4oRlZ9JZ86DSY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7983
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA3LTI2IGF0IDEyOjE4ICswOTAwLCBTZXJnZXkgU2Vub3poYXRza3kgd3Jv
dGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVy
IG9yIHRoZSBjb250ZW50Lg0KPiAgT24gKDIzLzA3LzIxIDE0OjM3KSwgQW5kcmV3IFlhbmcgd3Jv
dGU6DQo+ID4gDQo+ID4gU2luY2UgZnVsbG5lc3MgYW5kIGlzb2xhdGVkIHNoYXJlIHRoZSBzYW1l
IHVuc2lnbmVkIGludCwNCj4gPiBtb2RpZmljYXRpb25zIG9mIHRoZW0gc2hvdWxkIGJlIHByb3Rl
Y3RlZCBieSB0aGUgc2FtZSBsb2NrLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuZHJldyBZ
YW5nIDxhbmRyZXcueWFuZ0BtZWRpYXRlay5jb20+DQo+ID4gRml4ZXM6IGM0NTQ5Yjg3MTEwMiAo
InpzbWFsbG9jOiByZW1vdmUgenNwYWdlIGlzb2xhdGlvbiBmb3INCj4gbWlncmF0aW9uIikNCj4g
DQo+IEhhdmUgeW91IG9ic2VydmVkIGlzc3VlcyBpbiByZWFsIGxpZmU/IFRoYXQgY29tbWl0IGlz
IG1vcmUgdGhhbiBhDQo+IHllYXINCj4gYW5kIGEgaGFsZiBvbGQsIHNvIEkgd29uZGVyLg0KPiAN
Clllcywgd2UgZW5jb3VudGVyZWQgbWFueSBrZXJuZWwgZXhjZXB0aW9ucyBvZg0KVk1fQlVHX09O
KHpzcGFnZS0+aXNvbGF0ZWQgPT0gMCkgaW4gZGVjX3pzcGFnZV9pc29sYXRpb24oKSBhbmQNCkJV
R19PTighcGFnZXNbMV0pIGluIHpzX3VubWFwX29iamVjdCgpIGxhdGVseS4NClRoaXMgaXNzdWUg
b25seSBvY2N1cnMgd2hlbiBtaWdyYXRpb24gYW5kIHJlY2xhbWF0aW9uIG9jY3VyIGF0IHRoZQ0K
c2FtZSB0aW1lLiBXaXRoIG91ciBtZW1vcnkgc3RyZXNzIHRlc3QsIHdlIGNhbiByZXByb2R1Y2Ug
dGhpcyBpc3N1ZQ0Kc2V2ZXJhbCB0aW1lcyBhIGRheS4gV2UgaGF2ZSBubyBpZGVhIHdoeSBubyBv
bmUgZWxzZSBlbmNvdW50ZXJlZA0KdGhpcyBpc3N1ZS4gQlRXLCB3ZSBzd2l0Y2hlZCB0byB0aGUg
bmV3IGtlcm5lbCB2ZXJzaW9uIHdpdGggdGhpcw0KZGVmZWN0IGEgZmV3IG1vbnRocyBhZ28uDQo+
ID4gQEAgLTE4NTgsOCArMTg2MCw4IEBAIHN0YXRpYyBpbnQgenNfcGFnZV9taWdyYXRlKHN0cnVj
dCBwYWdlDQo+ICpuZXdwYWdlLCBzdHJ1Y3QgcGFnZSAqcGFnZSwNCj4gPiAgICogU2luY2Ugd2Ug
Y29tcGxldGUgdGhlIGRhdGEgY29weSBhbmQgc2V0IHVwIG5ldyB6c3BhZ2UNCj4gc3RydWN0dXJl
LA0KPiA+ICAgKiBpdCdzIG9rYXkgdG8gcmVsZWFzZSB0aGUgcG9vbCdzIGxvY2suDQo+ID4gICAq
Lw0KPiANCj4gVGhpcyBjb21tZW50IHNob3VsZCBiZSBtb3ZlZCB0b28sIGJlY2F1c2UgdGhpcyBp
cyBub3Qgd2hlcmUgd2UgdW5sb2NrDQo+IHRoZQ0KPiBwb29sIGFueW1vcmUuDQo+IA0KT2theSwg
SSB3aWxsIHN1Ym1pdCBhIG5ldyBwYXRjaCBsYXRlci4NCj4gPiAtc3Bpbl91bmxvY2soJnBvb2wt
PmxvY2spOw0KPiA+ICBkZWNfenNwYWdlX2lzb2xhdGlvbih6c3BhZ2UpOw0KPiA+ICtzcGluX3Vu
bG9jaygmcG9vbC0+bG9jayk7DQo+ID4gIG1pZ3JhdGVfd3JpdGVfdW5sb2NrKHpzcGFnZSk7DQo=
