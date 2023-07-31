Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA34769007
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjGaIWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjGaIWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:22:00 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F589E46
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:21:42 -0700 (PDT)
X-UUID: 4383d3842f7b11eeb20a276fd37b9834-20230731
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=T99hATGukInAJcGycKe4WY5UKk1pHm+CWdE9a3WT16M=;
        b=WbyNnfNpFYKqWLc9C0eK7P668jtqVRAlny5d8eyGbmvS10z/noGb1YA/Oq6SmASbzIDOJJaxcdOQqBb4HGV4TthoPgsGziETiEYnkf8MLf1k1rJ6CoJX4cTncCh+dQYhgdSDHQydNbCTQzW2PgggpMOEJWcVwch8T+HGhBhsbYY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:7a3988e8-d7c7-4f5e-8f41-e2e12ae07ed1,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:1fcc6f8,CLOUDID:fc57b7a0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4383d3842f7b11eeb20a276fd37b9834-20230731
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 579664568; Mon, 31 Jul 2023 16:21:35 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 31 Jul 2023 16:21:34 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 31 Jul 2023 16:21:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iC8UE/3KMlL51CSSdOv0VRQUyeuIgGKpUSk5YYNUqCSNnidvIkmQFreQ2qs32lxvZF0bWAQ4n2Z58JXtnfiXDR7s+DYh/cyCOA+8aMFpjLm43GkSO8MkSLX9Qf+nZi9LgZKkcLkTLTVyhQJi6QNWli2/ooyYY9h1BUbs2i42NWOosyQpIe3XxTi+rNAzxpGGmQ53ctgy1Gj6yP8zpSNSbM6g7Y9QF62W9RFpVOsluFwjh2pQNWjavqw46FuG9Nxe8rzbLIr14fMtdpGOc6M8UqadAi+pBzIlIJlMBkvdGqPqtviaEhpXySEaD9aWMlCPa12Ighz4F3dNTeksroYrGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T99hATGukInAJcGycKe4WY5UKk1pHm+CWdE9a3WT16M=;
 b=OLdVSytXzdFuNgA7CBjQ/+ErUVV1suTQ7VtYS8fWN7B1rmAMlskh+MERkQvVTUCZ5K7vZe98yAv0FrnD72s5on5BMnqAnnGJiD1Y5kJBkiSyX3a9r97TpdLrzGjT3F1ibvRUNEry/sUXGnW6cY4riI7CEFRzVnGZgldViaMiwCXrOkK75kGtjdWd364u9TTZf1fusqUM8jiAAb8wP/aWwatgtLrMdQgEH3h/aBR4q3ot+IpkSQLuo90KnEuSIEjIZM/ICqzp6Y3u3+vp2Vz8Kv66dgYSkNkzvDGywlLVkKL47o5RVwHcXR6Kk4qFrsJFU5WoTD3YqgD4q/20qW7pWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T99hATGukInAJcGycKe4WY5UKk1pHm+CWdE9a3WT16M=;
 b=m17/fYuDjTmFlmErykNo4jlItIcbwMG1LVTdkI5Gx0w6GpdwltoKgNnGLrSTbQ7eiKgHCKY+7ny95K9qLAUq5HQJSL5oCgXoJq3xtU0F3fUxeVDo/dxVU2Ed5qBXMDBZ/rHspYqxOYt3ngS2/ymdPea4ojdC6Aoby51vbHtRSUM=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEZPR03MB8016.apcprd03.prod.outlook.com (2603:1096:101:181::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 08:21:29 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8%4]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 08:21:29 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "eugen.hristev@collabora.com" <eugen.hristev@collabora.com>
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
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v7 2/4] drm/mediatek: Fix using wrong drm private data to
 bind mediatek-drm
Thread-Topic: [PATCH v7 2/4] drm/mediatek: Fix using wrong drm private data to
 bind mediatek-drm
Thread-Index: AQHZwKkypTU41zGk0kqR4mBL6m3qP6/O3w2AgASvoIA=
Date:   Mon, 31 Jul 2023 08:21:28 +0000
Message-ID: <6c07d1bc12c9226bf623da0a46ffaadb151c2175.camel@mediatek.com>
References: <20230727164114.20638-1-jason-jh.lin@mediatek.com>
         <20230727164114.20638-3-jason-jh.lin@mediatek.com>
         <d74f959b-2255-4587-e99c-2c6b043dc44c@collabora.com>
In-Reply-To: <d74f959b-2255-4587-e99c-2c6b043dc44c@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEZPR03MB8016:EE_
x-ms-office365-filtering-correlation-id: 5c60428b-2040-451a-b165-08db919f23d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rHn1LGqK9cz3ZvI+2sxp6GtRrY6pciNfliYwwW+y5GI5ABvNh8qTQX3hN1Dy9lkQldgHu1PhZCk2K8Yx8j9+ZsgeMzISG99i89aBmecUfNkldRXRfpEZvG3WWAqS+LBzd3YOZGUvPc8QRrBqOVV78fT0z6xmow92Q9Yc9QC3w+d8culHAfbRtWKm/aHf4kEpObQ52N/t9WH0IcpKTP9UvReDphyXzAolbtjAHwky46ohOLPPYTnzw3di90blUehLXEjBX+iiaNOmuSpLH03tDMnK+yTkkrjyejGH1DuL9Qivmu0qAZdtRAOug3NgjXgWHa1he3Tf1W0RCKv+v4iSszyYJaNo32XofNorYqXU0Iv9sJsT5xtRIqMbC/e4g6Mx+a81FiCcoRdGItIFzbRleyWI9f2xNwJfJwjgoZgcNoDPKeNgP/xqN0+wcGUbZELCp60BvTcV/p2ROMjKj3FHaT0iukqGY1cXgjb9wcP4lndS60A/5hujwieecpvxKf1HEX4AzFIh3WXqWnQP3fGInAjogrrN2H+1R2e/ET5XmfbmgxsdGT7Wln++ghS2TgJ5HpSXOOK8gdlMCqEOFORdWPHzRLGJYbIEpQNAzm+JWSNkch5Ho+s82+INk9NeRi+YA2RXUYGVIVyGdnWwX6teeiXJcAA2LTKxTwHxS3ei3gs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199021)(6512007)(71200400001)(6486002)(186003)(83380400001)(2616005)(36756003)(85182001)(86362001)(38070700005)(122000001)(38100700002)(53546011)(26005)(6506007)(64756008)(66446008)(66476007)(66556008)(2906002)(66946007)(4326008)(76116006)(91956017)(316002)(5660300002)(41300700001)(8936002)(8676002)(478600001)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1Zya2NzbWpQVDlSN2pMVEJIWkpXUk9SeGw5R0FZMDByN3ZLb3ZocVU1MUd4?=
 =?utf-8?B?aHc4eGhGbXJrdmlsMmt4dzl1NjdTYzBhaTVWT1lXWGxxLzhlVlBIUUc4ekVq?=
 =?utf-8?B?Y1pWWVJHd2xzVEEvbmpjd3l1T2VBTWZFVTlNcTlvU21iTGVueUMrVFpIenRE?=
 =?utf-8?B?blBuR1UzK2lYLzZhb1d5V012ekx1OXF4Q3MrYVpzMnYxRS9MWmRLYXk4K0NN?=
 =?utf-8?B?cEtad0ZYdFpobWwwWWZDbFcrZFY1RWN5UVFaeTQvZjJjb3NjNldvMkdEeWls?=
 =?utf-8?B?bFZBeFp4aWVDVzNJSnpmWjA4V1dSbW1ybEFnNHErS2NiN0JEamxXaG5IZDkv?=
 =?utf-8?B?VFk5d1FzSjd5QVB2b0tueWUyUnhPVXJIdUlrRVdnOHhKcWtYdDBCQllLYW1Q?=
 =?utf-8?B?VHhUUkx6RThGVHlEekJOVTBXTkRFbDFHTzBHYUxncko2NnR6eUgxSmxxd2Nr?=
 =?utf-8?B?blhyWkNRZDFzTFo4Yi9FeDUzeFJvSGdXU2Y0L01PK1RDS3ZuUFBFYURZQXdW?=
 =?utf-8?B?WXYrNEsvZjBvSUVFYmZhQjhIMGtBYy9DZzYxVWlTaU04WWszK280dzdoVzkx?=
 =?utf-8?B?ZEF3WkxVZnZTQ2N6UzU4aEJoYXd3ZEpaMnlWY2NNRDhMMkJ6ZEQrb1BRcEhR?=
 =?utf-8?B?WExqNC9RY0xncHBFcC9iWTJocmdmWHkzUUJDbFcxTDQ3eU5KdGlOMlBIQWlN?=
 =?utf-8?B?aTR1MDlqd0FEN3FVQUdOMWk2Ull6cVZOa2c0cGZLTFZXdENvVk9mUGgwTnFq?=
 =?utf-8?B?RVAzM0k2NmVGN2h1MmxvZGJkSDJsRW55Z2tZUVI2LzFFZkVDT0pIclJ0Vm1n?=
 =?utf-8?B?N0xBVDBmSUxDbjJ6QW1DeXhHVGJYVWZQek1qaVlqdXo4TzJqMGdIQnI1T0Vk?=
 =?utf-8?B?SUw0Yjg1VVl4Q0xYS3BOOW5ac0VPQWc1d3U5NzREOUZLY1pSd04vZEtoV2tk?=
 =?utf-8?B?ODg5SndDeFlmM0tSYWVwNW1FRnRicDJNYkc2UTZ5WXVnTlNBUXJsem5ZdjdL?=
 =?utf-8?B?OG1kd2oxNGRJVWVOV0tTR2o4NWhjbmdyRVNHTjVBQXRON1Rmbk91RnZrcWRK?=
 =?utf-8?B?Ty8wV3djZ2NPVDVKaC9Lb1dsVDl1Q3F5aTJ4Q08ydnNSN2ZuUDIwQ2Nzem5E?=
 =?utf-8?B?YXJsUXBwd0FIUUR6T1ZtVGxYMGlUcU5Jalh1L0hTVEtDVjI3dlV3VXVKYzgr?=
 =?utf-8?B?UnhRR0RkVDNrbVZaUm9KalZqckxsdm5FQ1VMSTkzakNDQmptdWpqdkdFWml6?=
 =?utf-8?B?VkxXcUViYThVNDluU014YjdMRDM2YjJGQU5Fd3lqMWU0aE80dW8wN1NBejU3?=
 =?utf-8?B?VHNxT2hFcERPZ09zU1ZvbUpRNERNYnorL25kdGovc3ZPeEZXeWdCaUpCaFZa?=
 =?utf-8?B?ZFFsc0haeHdaZzZ5VlpYYmV3MjBNbkN3QXBObmlvWXdQSEdiQzJ6R1ZTd3hp?=
 =?utf-8?B?ejVvZGhwTXBhU29JV2VUNitSZWo5dkMraGE4V1BWcTgydmFodk1rcUtSeWtD?=
 =?utf-8?B?MWJUTm5YS2dKQmU2eVo0eGN6QkdUSUNOS3Rnc2VneWMwdDJzdlZjbGRjVjJE?=
 =?utf-8?B?QTFqUmxMYmtSKzRNd2JLMktSVGxMN0dMMVBKTEZ1c1VPWlVVWVNEakdEM1NK?=
 =?utf-8?B?L3QwbnJkT25ZN0JlSWI1UWQ4dlVYd3JMc0xIbTVqbUxGSzhUN2tnL24vVEUw?=
 =?utf-8?B?MlY2ZzlnQTFHallXMHU0eU5LR2RjY3RTbE5WUFp6aS9iZkFuc29JMnVPU3Ji?=
 =?utf-8?B?bUhUdTc3a0gzbW4yR09vT3RQRGNrRjFST2RYY1oydUN0QW9hdHZxR2M1MkhY?=
 =?utf-8?B?d0pTM3RjNzhkNXVWcC9yWCtEMFRpcXRXbXpYTzBOQ2pDdWZQZGsrd3QrQkYr?=
 =?utf-8?B?VHJoWXliVjVCSkxHenZxa0ZqMDJCQVkwNnd6eU9QUmt5d3BuYmtZajFNTlBR?=
 =?utf-8?B?Y3d0NlhPRm1aMnM3amF3SmFIREp4bmkzWG9vWTBmRisranlIQ0V5NTI4VHhW?=
 =?utf-8?B?bFlXVHBQWGZaSkFDOVZxM0RxZlFHb2lNc3ZRd3Q5eGFXRkpUYkVXUkVaT3JC?=
 =?utf-8?B?d21lcnIwTTRBN1FzZHpDNW1GVjBuem1JMjJQSm5tWXU3eDdua0ROWi91eWdx?=
 =?utf-8?B?OWs2K1V4UHhkK0hiVTl0SHMzSEtuMjZQL1crbDQzbTBUL3NwZ0JCTzlZU1FJ?=
 =?utf-8?B?OHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49BBB81ADC99DA46AA6E02A74792490E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c60428b-2040-451a-b165-08db919f23d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 08:21:29.0027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ok/Wp5DC3iRNkwtXQrhac++EptJoV5ImVHma145Mw2WsxFPzFB1fNgyJ3CAE8wUU6vFXDzqrvfAa1mDRRwHjYpgM9nnWfbxPgdVW3kpn4zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8016
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRXVnZW4sDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIEZyaSwgMjAyMy0wNy0y
OCBhdCAxMTo0NyArMDMwMCwgRXVnZW4gSHJpc3RldiB3cm90ZToNCj4gSGksDQo+IA0KPiBPbiA3
LzI3LzIzIDE5OjQxLCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+ID4gQWRkIGNoZWNraW5nIHRoZSBs
ZW5ndGggb2YgZWFjaCBkYXRhIHBhdGggYmVmb3JlIGFzc2lnbmluZyBkcm0NCj4gPiBwcml2YXRl
DQo+ID4gZGF0YSBpbnRvIGFsbF9kcm1fcHJpdiBhcnJheS4NCj4gPiANCj4gPiBGaXhlczogMWVm
N2VkNDgzNTZjICgiZHJtL21lZGlhdGVrOiBNb2RpZnkgbWVkaWF0ZWstZHJtIGZvciBtdDgxOTUN
Cj4gPiBtdWx0aSBtbXN5cyBzdXBwb3J0IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5M
aW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyB8IDE2ICsrKysrKysrKysrKystLS0NCj4gPiAg
IDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+IA0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0K
PiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gPiBpbmRleCAy
NDljOWZkNjM0N2UuLmQyZmIxZmI0ZTY4MiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2Rydi5jDQo+ID4gQEAgLTM1MSw2ICszNTEsNyBAQCBzdGF0aWMgYm9vbCBt
dGtfZHJtX2dldF9hbGxfZHJtX3ByaXYoc3RydWN0DQo+ID4gZGV2aWNlICpkZXYpDQo+ID4gICB7
DQo+ID4gICAJc3RydWN0IG10a19kcm1fcHJpdmF0ZSAqZHJtX3ByaXYgPSBkZXZfZ2V0X2RydmRh
dGEoZGV2KTsNCj4gPiAgIAlzdHJ1Y3QgbXRrX2RybV9wcml2YXRlICphbGxfZHJtX3ByaXZbTUFY
X0NSVENdOw0KPiA+ICsJc3RydWN0IG10a19kcm1fcHJpdmF0ZSAqdGVtcF9kcm1fcHJpdjsNCj4g
PiAgIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKnBoYW5kbGUgPSBkZXYtPnBhcmVudC0+b2Zfbm9kZTsN
Cj4gPiAgIAljb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkICpvZl9pZDsNCj4gPiAgIAlzdHJ1Y3Qg
ZGV2aWNlX25vZGUgKm5vZGU7DQo+ID4gQEAgLTM3Myw5ICszNzQsMTggQEAgc3RhdGljIGJvb2wg
bXRrX2RybV9nZXRfYWxsX2RybV9wcml2KHN0cnVjdA0KPiA+IGRldmljZSAqZGV2KQ0KPiA+ICAg
CQlpZiAoIWRybV9kZXYgfHwgIWRldl9nZXRfZHJ2ZGF0YShkcm1fZGV2KSkNCj4gPiAgIAkJCWNv
bnRpbnVlOw0KPiA+ICAgDQo+ID4gLQkJYWxsX2RybV9wcml2W2NudF0gPSBkZXZfZ2V0X2RydmRh
dGEoZHJtX2Rldik7DQo+ID4gLQkJaWYgKGFsbF9kcm1fcHJpdltjbnRdICYmIGFsbF9kcm1fcHJp
dltjbnRdLQ0KPiA+ID5tdGtfZHJtX2JvdW5kKQ0KPiA+IC0JCQljbnQrKzsNCj4gPiArCQl0ZW1w
X2RybV9wcml2ID0gZGV2X2dldF9kcnZkYXRhKGRybV9kZXYpOw0KPiA+ICsJCWlmICh0ZW1wX2Ry
bV9wcml2KSB7DQo+ID4gKwkJCWlmICh0ZW1wX2RybV9wcml2LT5tdGtfZHJtX2JvdW5kKQ0KPiA+
ICsJCQkJY250Kys7DQo+ID4gKw0KPiA+ICsJCQlpZiAodGVtcF9kcm1fcHJpdi0+ZGF0YS0+bWFp
bl9sZW4pDQo+ID4gKwkJCQlhbGxfZHJtX3ByaXZbMF0gPSB0ZW1wX2RybV9wcml2Ow0KPiA+ICsJ
CQllbHNlIGlmICh0ZW1wX2RybV9wcml2LT5kYXRhLT5leHRfbGVuKQ0KPiA+ICsJCQkJYWxsX2Ry
bV9wcml2WzFdID0gdGVtcF9kcm1fcHJpdjsNCj4gPiArCQkJZWxzZSBpZiAodGVtcF9kcm1fcHJp
di0+ZGF0YS0+dGhpcmRfbGVuKQ0KPiA+ICsJCQkJYWxsX2RybV9wcml2WzJdID0gdGVtcF9kcm1f
cHJpdjsNCj4gPiArCQl9DQo+IA0KPiBQcmV2aW91c2x5IHRoZSBjb2RlIHdhcyBhc3NpZ25pbmcg
c3R1ZmYgaW50byBhbGxfZHJtX3ByaXZbY250XSBhbmQgDQo+IGluY3JlbWVudGluZyBpdC4NCj4g
V2l0aCB5b3VyIGNoYW5nZSwgaXQgYXNzaWducyB0byBhbGxfZHJtX3ByaXZbMF0sIFsxXSwgWzJd
LiBJcyB0aGlzDQo+IHdoYXQgDQo+IHlvdSBpbnRlbmRlZCA/DQoNCkJlY2F1c2UgZGV2X2dldF9k
cnZkYXRhKGRybV9kZXYpIHdpbGwgZ2V0IHRoZSBkcml2ZXIgZGF0YSBieSBkcm1fZGV2Lg0KRWFj
aCBkcm1fZGV2IHJlcHJlc2VudHMgYSBkaXNwbGF5IHBhdGguDQplLGcuDQpkcm1fZGV2IG9mICJt
ZWRpYXRlayxtdDgxOTUtdmRvc3lzMCIgcmVwcmVzZW50cyBtYWluIHBhdGguDQpkcm1fZGV2IG9m
ICJtZWRpYXRlayxtdDgxOTUtdmRvc3lzMSIgcmVwcmVzZW50cyBleHQgcGF0aC4NCg0KU28gd2Ug
d2FudCB0byBtYWtlIHN1cmUgYWxsX2RybV9wcml2W10gc3RvcmUgdGhlIHByaXZhdGUgZGF0YSBp
bg0KdGhlIG9yZGVyIG9mIGRpc3BsYXkgcGF0aCwgc3VjaCBhczoNCmFsbF9kcm1fcHJpdlswXSA9
IHRoZSBwcml2YXRlIGRhdGEgb2YgbWFpbiBkaXNwbGF5DQphbGxfZHJtX3ByaXZbMV0gPSB0aGUg
cHJpdmF0ZSBkYXRhIG9mIGV4dCBkaXNwbGF5DQphbGxfZHJtX3ByaXZbMl0gPSB0aGUgcHJpdmF0
ZSBkYXRhIG9mIHRoaXJkIGRpc3BsYXkNCg0KPiBJZiB0aGlzIGxvb3AgaGFzIHNlY29uZCBydW4s
IHlvdSB3aWxsIHJlYXNzaWduIHRvIGFsbF9kcm1fcHJpdiBhZ2Fpbg0KPiA/DQoNCkJlY2F1c2Ug
dGhlIHByZXZpb3VzIGNvZGUgd2lsbCBzdG9yZSBhbGxfZHJtX3ByaXZbXSBpbiB0aGUgb3JkZXIg
b2YNCm10a19kcm1fYmluZCgpIHdhcyBjYWxsZWQuDQoNCklmIGRybV9kZXYgb2YgZXh0IHBhdGgg
Ym91bmQgZWFybGllciB0aGFuIGRybV9kZXYgb2YgbWFpbiBwYXRoLA0KYWxsX2RybV9wcml2W10g
aW4gbXRrX2RybV9nZXRfYWxsX2RybV9wcml2KCkgbWF5IGJlIHJlLWFzc2lnbmVkIGxpa2UNCnRo
aXM6DQphbGxfZHJtX3ByaXZbMF0tPmFsbF9kcm1fcHJpdlswXSA9IHByaXZhdGUgZGF0YSBvZiBl
eHQgcGF0aA0KYWxsX2RybV9wcml2WzFdLT5hbGxfZHJtX3ByaXZbMF0gPSBwcml2YXRlIGRhdGEg
b2YgZXh0IHBhdGgNCmFsbF9kcm1fcHJpdlswXS0+YWxsX2RybV9wcml2WzFdID0gcHJpdmF0ZSBk
YXRhIG9mIG1haW4gcGF0aA0KYWxsX2RybV9wcml2WzFdLT5hbGxfZHJtX3ByaXZbMV0gPSBwcml2
YXRlIGRhdGEgb2YgbWFpbiBwYXRoDQoNCkJ1dCB3ZSBleHBlY3QgYWxsX2RybV9wcml2W10gYmUg
cmUtYXNzaWduZWQgbGlrZSB0aGlzOg0KYWxsX2RybV9wcml2WzBdLT5hbGxfZHJtX3ByaXZbMF0g
PSBwcml2YXRlIGRhdGEgb2YgbWFpbiBwYXRoDQphbGxfZHJtX3ByaXZbMV0tPmFsbF9kcm1fcHJp
dlswXSA9IHByaXZhdGUgZGF0YSBvZiBtYWluIHBhdGgNCmFsbF9kcm1fcHJpdlswXS0+YWxsX2Ry
bV9wcml2WzFdID0gcHJpdmF0ZSBkYXRhIG9mIGV4dCBwYXRoDQphbGxfZHJtX3ByaXZbMV0tPmFs
bF9kcm1fcHJpdlsxXSA9IHByaXZhdGUgZGF0YSBvZiBleHQgcGF0aA0KDQo+IEkgd291bGQgZXhw
ZWN0IHlvdSB0byB0YWtlIGBjbnRgIGludG8gYWNjb3VudC4NCj4gQWxzbywgaXMgaXQgZXhwZWN0
ZWQgdGhhdCBhbGxfZHJtX3ByaXYgaGFzIGhvbGVzIGluIHRoZSBhcnJheSA/DQoNCkVhY2ggZHJt
X2RldiB3aWxsIG9ubHkgY2FsbGVkIG10a19kcm1fYmluZCgpIG9uY2UsIHNvIGFsbCBob2xlcw0K
d2lsbCBiZSBmaWxsZWQgYWZ0ZXIgYWxsIGRybV9kZXYgaGFzIGNhbGxlZCBtdGtfZHJtX2JpbmQo
KS4NCg0KRG8geW91IGFncmVlIHdpdGggdGhpcyBzdGF0ZW1lbnQ/IDopDQoNClJlZ2FyZHMsDQpK
YXNvbi1KSC5MaW4NCg0KPiANCj4gRXVnZW4NCj4gDQo+IA0KPiANCj4gPiAgIAl9DQo+ID4gICAN
Cj4gPiAgIAlpZiAoZHJtX3ByaXYtPmRhdGEtPm1tc3lzX2Rldl9udW0gPT0gY250KSB7DQo+IA0K
PiANCg==
