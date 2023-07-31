Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FC57691E5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjGaJh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjGaJh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:37:26 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D9110D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:37:17 -0700 (PDT)
X-UUID: d3a4c00e2f8511ee9cb5633481061a41-20230731
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=x9maRWa2FVc7+Oi2g6oDuR1B/KT0QZmZktxlgNyQSmg=;
        b=o/TVu0pMtXbW5zdZ0JvXqSfnDpap5DnNpUAhTz/useY6gROgjVgqA2WHD140KvdRc8uNK8QsNpIF/FDbyB03tHxLBp8LLqk5iuf1gcmqrdvf+88rgTrT861ua+lo7vyjpFECe7q6lw63SjcPEMv4eBlizSBgKgFnONymLA5UGgk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:b4a32915-f976-4406-a267-598b8a6928da,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:1fcc6f8,CLOUDID:0159fab3-a467-4aa9-9e04-f584452e3794,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: d3a4c00e2f8511ee9cb5633481061a41-20230731
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1602828015; Mon, 31 Jul 2023 17:37:12 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 31 Jul 2023 17:37:11 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 31 Jul 2023 17:37:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3L9kItkfLyNhyRIFZxAEtBfRdVGVZYAX2Zaybb7KvOAvl+W1GV1+GcnQsKJwyo1ZFPgLtP1q27Zx7uVjjfvxXFGRcwD4kRjIHbmf8Mb0e+1z1Lbk6XdfbKNCkiyRedIxCynRZwaDN0bWzEIJ2fXppB/W/RK/FWuJdpD12b/HpEnQq0i5NLkgfY+Y6VsuJ/Q5Kf0xh8n8q9ptkX+UbFQ/l+noIITmChxiPrBe5+5XeWT9C80uMHWnGkgORxOlHa8YalmlhIRn2zh9xV3kjC6Zuw/FpyfnOPYKzVqIVrMKeF/of3kDzHKzAQvshS86gYCgItN02sZ4Vh0vk3wxpbJ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9maRWa2FVc7+Oi2g6oDuR1B/KT0QZmZktxlgNyQSmg=;
 b=Lkn7YPCbQJO3QtcavlZomqlTlsJW9Bvpq/nAychYNdXrCnFnM3QmKf3kEJQhoon1irfoNWVx6/NCW9ae5R6g+neStPEfrAK4O4/qWmIDW3TrFKrI6Lo6/G+ZV2CoWxLBG9WTEDmCVn0Y3OgZ9112D8t5PcI0CfLBxTvtRiT68aQxQ5iFP58OTHauDqvHOqhkjCBuDBcvZn0S4fW02Bydh8Jv4X5KLjaYAs6WFVyhLb5y1UqgTVJiQlsrYfCmTKEUeygyow7ReyrrXs2DWl7kqIKUW4UMA8zfQDJODhMrFeuZs8Q1q1zeRrkN3kGZaaBVTPUcTsbaFitjb31qqHUuxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9maRWa2FVc7+Oi2g6oDuR1B/KT0QZmZktxlgNyQSmg=;
 b=NveIPvEJEeHDI/SmFogK5O2ttL2FqYHwtlhQjDHh7oZ3WQleriSPXfV9MQL/veZoRRExHvcFzPVUhSzIlrf4OxZunmxFXGktBgHBOCw2o0lrNmZdbsAJdPbkSzsI7XX4iuK6PQOApnWMWe4jmHFTTLk1BFbmeOtD0S1ldvVKhuA=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYSPR03MB7978.apcprd03.prod.outlook.com (2603:1096:400:47c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 09:37:09 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8%4]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 09:37:09 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        =?utf-8?B?TmF0aGFuIEx1ICjlkYLmnbHpnJYp?= <Nathan.Lu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v7 3/4] drm/mediatek: Add ability to support dynamic
 connector selection
Thread-Topic: [PATCH v7 3/4] drm/mediatek: Add ability to support dynamic
 connector selection
Thread-Index: AQHZwKk/CKoq3eYpZ0mHCmSyWru9/q/O1MyAgATPBwA=
Date:   Mon, 31 Jul 2023 09:37:08 +0000
Message-ID: <48a93b90740ec55ab8a563a5f0222a3a5c7d9673.camel@mediatek.com>
References: <20230727164114.20638-1-jason-jh.lin@mediatek.com>
         <20230727164114.20638-4-jason-jh.lin@mediatek.com>
         <7ba4f465-6910-8b23-e950-98598547e8d9@collabora.com>
In-Reply-To: <7ba4f465-6910-8b23-e950-98598547e8d9@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYSPR03MB7978:EE_
x-ms-office365-filtering-correlation-id: d5471d0a-344a-48c4-c22b-08db91a9b5e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ryvG3D8FPCFqnrTDCi6y9Nh0Lu65MlJbVVXklz9oT4JCcEZ70iKGQLq8d4q4Xb+w9c4yDAlszk+SFa3Yg+bXLIR0aFrsrolfJCdg0Cbur4zbkHq1GIwrK1aB6WJkreFR/4UPrtiztswlQvESFJrVpTRb3OlIgJ2V2eyPpYTKyRtFadZHogQCfa9FaJnPN9HiveNmeen0xJwGWSU7BTQFSEEr6IDu8Z7PYMwdqVrYt6gMFWAR/vvddWnsZgdosaoAZbTDJ1gHyknRXF3UwImhIm3W4y9rbe2456MbkWAEp3rCi8ltq5RjYKcSWzpg5pO3EbOXzciszx/VaOqN7W2hCepfOgUeCI7i6627coYIFWfF7YDRYznDnODVW5ZdTq4I1myPCp0ZWghjA1Jsp5EhJA/CDHzcFPts/Az/+5iAbz3fBLGGPmesbl0F+vxNl7ZJfXaQs9nh16G+XxQ/wEmqgnJSap3DXLlHoBJted6CMz0kPlcBJJc30LNzfupJNOBqKAc1L2upMXsha7XZBOe6Sjo8DLFEe2MnC17p6RJh0kwvU44m0QWhsfLAA+DUwEmk1rLj7X8XSVGgnA5OXY3INlGtYl3YK4VfGwDnIdmbpSSsLQHOueVMVBmLqIMASGM/entwjH5bxa7LC417DVttJthFV9bnpxWAk75II3Fq5o8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(6512007)(71200400001)(54906003)(110136005)(6486002)(478600001)(186003)(2616005)(26005)(6506007)(2906002)(91956017)(316002)(76116006)(4326008)(66476007)(66556008)(66946007)(41300700001)(66446008)(64756008)(5660300002)(8936002)(8676002)(122000001)(38100700002)(85182001)(36756003)(38070700005)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OW91MzVvLzVta1JVaUY2NEV6VmduZG1yT1MzRElSQ2QxRzMzdHFwaFZKTGta?=
 =?utf-8?B?aU9lQkpyV3owY1E1M05tNG91eXhZMG5mbVY1RzM2OEVZeXgwNmpwTmpEV05h?=
 =?utf-8?B?VExlWVlia09yMFN0NmNrb2w2cWNsSEtLYXZyYmNOMWVaTk1vT0dGbnBWR29H?=
 =?utf-8?B?eHZSaXNLM25VbmpwTFBJNncyL3Bha3k4emVQOURic2JOWmVMZ1JYMTJQK0tR?=
 =?utf-8?B?NlhxbCtJSWhoKzZYVkZBUTRYZEJ4ck9ERlZXUVZieHRvK3lTcUpKSzREU3Az?=
 =?utf-8?B?Rm5YaThvQXJaRzJiTVFCZGRKdG9sRWM4OFdDQkswcXNDa2h1aE5PanNmRE8x?=
 =?utf-8?B?bjBLT3FjRmxYenpwbkZsditUbk4xK1Rvc3FWOFZLTlNubXhTQmtHODlpSEt0?=
 =?utf-8?B?TTNwM1dBUDRvYTgzczBqQi9PWEdvN3pQNmk4N2ZLNG5lSnBVNjRZekVwdzNm?=
 =?utf-8?B?Ti8vZkRhV05HM1JLajEvUk1nQVJaeUdkQ1NTNUJMRzBIMVBwczUvaXprS3Zx?=
 =?utf-8?B?M2szRjhHVWN4eUFiRjZhOVFSNHVIUW1nSjR6cG82eVJKWDZhYzFjRHR6ZVZh?=
 =?utf-8?B?Q3BKNzJ5QmoyZjNFRXVZdW43U0RvUnZjU21NYlRldUJaQm9XV1pPYUNtbmE4?=
 =?utf-8?B?TXJoRUw2RjRicHZwazVPa2cxZFgzUkc5eXhGQ0o2UVZLTk9mczVFN3k0M2x6?=
 =?utf-8?B?cTdJQ3BjMlRVemw0aWN0aW1mSDhFbUM0bTZiQVlsWG5wbEpqNFl6RklpSzFk?=
 =?utf-8?B?aUtwSjNEeFF6THZYSm5BK1lQdjdzL0xmR2lGWS83U0l6bnNZVFNwdE5kL09i?=
 =?utf-8?B?VjAxN1hkd0NjTnhPOVVxZHZlY0FTWmFwRTRwUmNucENEOC9qdXBad1hCWFdj?=
 =?utf-8?B?cWxGOVNuYnVlTCt3VXM0dGxiZUxtbHdrZmpBZDFjMmFBbjlTMkhwVkI5cm9o?=
 =?utf-8?B?d2hPWUwyakRkcW9HWlJURzZiWndzWHVxdXR2V2hkOUk0TVFVSHVrR3lyaFNE?=
 =?utf-8?B?allyK21aVkUrMFdlUVBkbXV0UjZhZGh2bDR6dkFkd0ZuK1EzT05tR3JrZEVC?=
 =?utf-8?B?aE5tc0wxdFV2UmpkM3JRRHhoZFFDU0ViaDFBSkNVVlAzbGh0TlArWnVEOW1s?=
 =?utf-8?B?WkxLQkZlNnZScC9zUERyOXFLRDRCeHdRbHkvYWgyOVFnWDFkWUp3R0ZGTU1w?=
 =?utf-8?B?d01QSkdsbmpoNElsa0tveXQ0NjZtWnJqOS9mYWRtN01NR1JGN0VXd1VOcFBL?=
 =?utf-8?B?ek4yN0NuWUhDejN3R3RmZFl1a2ZOOFRwY1ltWUFqZkdqM2Zoc3N1dzRGRThi?=
 =?utf-8?B?R2JxSUJNeW8zaG5TK0VzUklBVmVyZENpVWhyR0gzNHR0U2hsWmdCUmVzeFVy?=
 =?utf-8?B?R3Y0Rm1wenZDUlpaMlVpYlowa0wyblZ3YWQ2QkVSd0NuQjlRZE8vWGM4T2Qy?=
 =?utf-8?B?cUZWZC9BbmYyTTFsNFlBVkhmZWQ0cllFT1VjdmQ3VTk4dWIwMi9yMUZXbDJO?=
 =?utf-8?B?Q1ZRRitlYlJ5allDUnJ6WnQzZ1hYQUJaN1BKOUJXUDZyamh4MUNCb2I0TCtJ?=
 =?utf-8?B?UC82R2l4SWJjMFJaWjF3TSs4YmJNT0lYY0hVNDdGS0J0TmpvRWRxMkRwaFhS?=
 =?utf-8?B?bDBHN3MxTC84TlZVM0JDelpuZzdzeldyUFFXTDZKWXhFY1RHVTV2T2RocGFK?=
 =?utf-8?B?TlRJcjZxY1orU2drdjBPckZ2MWNkY0JYRjFadnFSOFc3azQyS2lrcjU2djVG?=
 =?utf-8?B?QVJJcHR2cFhJTDk4TTJPdXFXTkkvRGswcHNTaUlVT2hMN3M4dlFJRUgzTkFB?=
 =?utf-8?B?aGpFV25RNG5xWS9nZDl3eDZiMmVDWWVIY3JIWXpJVzFjNTNRZ3pWeWkyRkRt?=
 =?utf-8?B?cjdzZW9mUUp3dzNYMVVRZXdiaFhrRVkyUmJVaFo1aXVzMFVSNTltRW02TnpI?=
 =?utf-8?B?eTNJZ3M3QkJTNG5tcFJGVGQvVUlCV0JGR1VOYlVrbEdNb0VHekRvVU0wWi9w?=
 =?utf-8?B?bC9qaXF3M1ZxSXl5QkluR29kMVkrUHdEZjJBU0JrQXFBb0k2d09MamJuUmd3?=
 =?utf-8?B?L1M3UlIwcUUrV29QM3hsQ0paTm5keE1DbkR3SHN4T280NndTQmtIdXI3MTdx?=
 =?utf-8?B?NXFHamtIdEUxRE5DNkZDSjlpRkpXNFZRYy9EaHdLWjIrSWVMc3ZOS3NITzJ1?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <108B1DFD6E98094BB49C7A0CDA31FDA2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5471d0a-344a-48c4-c22b-08db91a9b5e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 09:37:08.9699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JoGEAs6MplJ/tnkcpLNdQlFLuFgM/xes1LttPeAjYmL+3CB71KEiniotOtWbonQOjs32efuhwXpPmNtZliLoqWrgau7h5bz7DDh2Q3/xMxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7978
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBGcmksIDIwMjMtMDct
MjggYXQgMTA6MTEgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJ
bCAyNy8wNy8yMyAxODo0MSwgSmFzb24tSkguTGluIGhhIHNjcml0dG86DQo+ID4gMS4gTW92ZSBv
dXRwdXQgZHJtIGNvbm5lY3RvciBmcm9tIGVhY2ggZGRwX3BhdGggYXJyYXkgdG8gY29ubmVjdG9y
DQo+ID4gYXJyYXkuDQo+ID4gMi4gQWRkIGR5bmFtaWMgc2VsZWN0IGF2YWlsYWJsZSBjb25uZWN0
b3IgZmxvdyBpbiBjcnRjIGNyZWF0ZSBhbmQNCj4gPiBlbmFibGUuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogTmFuY3kgTGluIDxuYW5jeS5saW5AbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IE5hdGhhbiBMdSA8bmF0aGFuLmx1QG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+
ID4gICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmggICAgIHwgIDEgKw0K
PiA+ICAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYyAgICAgICAgICB8ICA5ICsr
Kw0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jICAgICB8IDc1
DQo+ID4gKysrKysrKysrKysrKysrKysrKystDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9jcnRjLmggICAgIHwgIDUgKy0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2RkcF9jb21wLmMgfCAyNiArKysrKysrDQo+ID4gICBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oIHwgIDggKysrDQo+ID4gICBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyAgICAgIHwgMjAgKysrKy0tDQo+ID4gICBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuaCAgICAgIHwgIDcgKysNCj4gPiAgIDgg
ZmlsZXMgY2hhbmdlZCwgMTQ1IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ID4gDQo+
IA0KPiAuLnNuaXAuLg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcm1fZGRwX2NvbXAuYw0KPiA+IGluZGV4IGYxMTRkYTRkMzZhOS4uYmM3YjBhMGMyMGRiIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21w
LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5j
DQo+ID4gQEAgLTMwNCw2ICszMDQsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kZHBfY29t
cF9mdW5jcw0KPiA+IGRkcF9kaXRoZXIgPSB7DQo+ID4gICBzdGF0aWMgY29uc3Qgc3RydWN0IG10
a19kZHBfY29tcF9mdW5jcyBkZHBfZHBpID0gew0KPiA+ICAgCS5zdGFydCA9IG10a19kcGlfc3Rh
cnQsDQo+ID4gICAJLnN0b3AgPSBtdGtfZHBpX3N0b3AsDQo+ID4gKwkuZW5jb2Rlcl9pbmRleCA9
IG10a19kcGlfZW5jb2Rlcl9pbmRleCwNCj4gPiAgIH07DQo+ID4gICANCj4gPiAgIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1bmNzIGRkcF9kc2MgPSB7DQo+ID4gQEAgLTUwNyw2
ICs1MDgsMjUgQEAgc3RhdGljIGJvb2wgbXRrX2RybV9maW5kX2NvbXBfaW5fZGRwKHN0cnVjdA0K
PiA+IGRldmljZSAqZGV2LA0KPiA+ICAgCXJldHVybiBmYWxzZTsNCj4gPiAgIH0NCj4gPiAgIA0K
PiA+ICtzdGF0aWMgaW50IG10a19kcm1fZmluZF9jb21wX2luX2RkcF9jb25uX3BhdGgoc3RydWN0
IGRldmljZSAqZGV2LA0KPiA+ICsJCQkJCSAgICAgIGNvbnN0IHN0cnVjdA0KPiA+IG10a19kcm1f
cm91dGUgKnJvdXRlcywNCj4gPiArCQkJCQkgICAgICB1bnNpZ25lZCBpbnQgcm91dGVzX251bSwN
Cj4gDQo+IGBudW1fcm91dGVzYCB3b3VsZCBiZSBtb3JlIHJlYWRhYmxlLg0KDQpPSywgSSdsbCBj
aGFuZ2UgdGhpcyBuYW1pbmcuDQoNCj4gDQo+ID4gKwkJCQkJICAgICAgc3RydWN0IG10a19kZHBf
Y29tcA0KPiA+ICpkZHBfY29tcCkNCj4gPiArew0KPiA+ICsJdW5zaWduZWQgaW50IGk7DQo+ID4g
Kw0KPiA+ICsJaWYgKCFyb3V0ZXMpDQo+ID4gKwkJcmV0dXJuIDA7DQo+IA0KPiBpZiAoIXJvdXRl
cykNCj4gCXJldHVybiAtRUlOVkFMOw0KDQpPSywgSSdsbCBjaGFuZ2UgaXQuDQoNCj4gDQo+ID4g
Kw0KPiA+ICsJZm9yIChpID0gMDsgaSA8IHJvdXRlc19udW07IGkrKykNCj4gPiArCQlpZiAoZGV2
ID09IGRkcF9jb21wW3JvdXRlc1tpXS5yb3V0ZV9kZHBdLmRldikNCj4gPiArCQkJcmV0dXJuIEJJ
VChyb3V0ZXNbaV0uY3J0Y19pZCk7DQo+ID4gKw0KPiA+ICsJRFJNX0lORk8oIkZhaWxlZCB0byBm
aW5kIGNvbXAgaW4gZGRwIGNvbm5lY3RvciB0YWJsZVxuIik7DQo+IA0KPiBUaGlzIHByaW50IGlz
IHJlZHVuZGFudC4NCg0KT0ssIEknbGwgcmVtb3ZlIHRoaXMgcHJpbnQuDQo+IA0KPiA+ICsNCj4g
PiArCXJldHVybiAwOw0KPiANCj4gcmV0dXJuIC1FTk9ERVY7DQoNCk9LLCBJJ2xsIGNoYW5nZSBp
dC4NCg0KPiANCj4gPiArfQ0KPiA+ICsNCj4gPiAgIGludCBtdGtfZGRwX2NvbXBfZ2V0X2lkKHN0
cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSwNCj4gPiAgIAkJCWVudW0gbXRrX2RkcF9jb21wX3R5cGUg
Y29tcF90eXBlKQ0KPiA+ICAgew0KPiA+IEBAIC01MzgsNiArNTU4LDEyIEBAIHVuc2lnbmVkIGlu
dA0KPiA+IG10a19kcm1fZmluZF9wb3NzaWJsZV9jcnRjX2J5X2NvbXAoc3RydWN0IGRybV9kZXZp
Y2UgKmRybSwNCj4gPiAgIAkJCQkJICBwcml2YXRlLT5kYXRhLT50aGlyZF9sZW4sDQo+ID4gcHJp
dmF0ZS0+ZGRwX2NvbXApKQ0KPiA+ICAgCQlyZXQgPSBCSVQoMik7DQo+ID4gICAJZWxzZQ0KPiA+
ICsJCXJldCA9IG10a19kcm1fZmluZF9jb21wX2luX2RkcF9jb25uX3BhdGgoZGV2LA0KPiA+ICsJ
CQkJCQkJIHByaXZhdGUtPmRhdGEtDQo+ID4gPmNvbm5fcm91dGVzLA0KPiA+ICsJCQkJCQkJIHBy
aXZhdGUtPmRhdGEtDQo+ID4gPm51bV9jb25uX3JvdXRlcywNCj4gPiArCQkJCQkJCSBwcml2YXRl
LQ0KPiA+ID5kZHBfY29tcCk7DQo+ID4gKw0KPiA+ICsJaWYgKHJldCA9PSAwKQ0KPiANCj4gaWYg
KHJldCA8IDApDQo+IA0KPiA+ICAgCQlEUk1fSU5GTygiRmFpbGVkIHRvIGZpbmQgY29tcCBpbiBk
ZHAgdGFibGVcbiIpOw0KDQpUaGUgcmV0dXJuIHZhbHVlIG9mIG10a19kcm1fZmluZF9wb3NzaWJs
ZV9jcnRjX2J5X2NvbXAoKSBpcyBgdW5zaWduZWQNCmludGAgYW5kIGl0IHdpbGwgYmUgYXNzaWdu
ZWQgdG8gYHVuc2lnbmVkIGludCBgIGRwaS0NCj5lbmNvZGVyLnBvc3NpYmxlX2NydGNzIGluIG10
a19kcGlfYmluZCgpIGRpcmVjdGx5Lg0KDQpTbyB3ZSBzaG91bGQgcmVhc3NpZ24gcmV0IHRvIDAg
d2hlbiByZXQgPCAwLg0KSSB3b3VsZCBsaWtlIHRvIGNoYW5nZSB0bzoNCg0KaWYgKHJldCA8PSAw
KSB7DQoJRFJNX0lORk8oIkZhaWxlZCB0byBmaW5kIGNvbXAgaW4gZGRwIHRhYmxlLCByZXQ9JWRc
biIsIHJldCk7DQoJcmV0ID0gMDsNCn0NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+ID4g
ICANCj4gPiAgIAlyZXR1cm4gcmV0Ow0KDQoNCg0KPiANCj4gUmVnYXJkcywNCj4gQW5nZWxvDQo+
IA0KPiANCj4gDQo+IA0K
