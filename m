Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F187DF1A0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjKBLuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjKBLuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:50:10 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A2E133;
        Thu,  2 Nov 2023 04:50:02 -0700 (PDT)
X-UUID: f1e11b32797511eea33bb35ae8d461a2-20231102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=hyUOBtsY2ktqoj0NBJXYEixnC4O76PSI0K7PC/Gu+Kg=;
        b=QZsLSjyTcuQiOg6jkr4PD/C4unMFldshxoxSQRnYAEojrnLUQqVxoeEfL5bWZu6Qbj2cagVZvNNTngqSmBPPXixjnzbZt+2nkoo0vWDFRKyV95gGpF7MvwWkFwVc9SHr+C/xXQiHFuy/npr/vDuZ3cJXLPsVXfgdqosLITMUuSM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:bfe6e44f-49ad-4f19-806e-a9d753205ba7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:948313fc-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f1e11b32797511eea33bb35ae8d461a2-20231102
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yu-chang.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 595444641; Thu, 02 Nov 2023 19:49:57 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 2 Nov 2023 19:49:55 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 2 Nov 2023 19:49:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzxSbYpu1KTgnNaW4q+MNz6EJXO7+oHxYijO8EEntJPRKiwx77IRVEvHBY56cv+j/LFGLaBq+nFylg9fsmFn0+Q7Il1ork9Usbd5E+g6/d7Oiw3VXgSAfiF5o0wgBwYHZnqQY9JuLtwoQot4AlwL1/PnbDmwjhbb/u5QA6a06rPpX18YFhwj4U9N5SVnsEhXVa1eCkjosk1949Nu07MRqt+9AWr/W6ZWk49OKLEP9VoOQhQI+NaZ8cHO1lkP3vQwSFFNI6+7jCVFam6I4tQ+cAAjZMZiSsO1ZmWhcxhFyTsSxDU0LqltdZEzIbKiIApBeJfrmmk1mCevActTIgej3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyUOBtsY2ktqoj0NBJXYEixnC4O76PSI0K7PC/Gu+Kg=;
 b=gf8ftcS3hJ6mtxYqgqfXDu+Pb25PA2y5GUbjyOckwJ+0/Uq2b5eYFlzv9pIvHnnwjaVOnkR2kI1bMF8tFikCWqNRLGwv0mHFnLUF7ig/u094849+WVdTJjJJJJCZcXPXHkodPYcjWZaDBkZx6ZKoXo1pnSzZVyEyPoKigabDQH01DlsaqjNiUop4Ec7E/ef57647Kgp5M/BI1zodPV/n++OcoITgTYpkQF173L0ZoIfZlGPZDO+vYvQ3bPDFDUMOURz6uyzEvOKXE9cwLpYCK1wxHlM8lgjNwP/YAifc0LelADwhgYB/vIpgRBK5D+NseiwDIOCu44wRSLSVoMUEhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyUOBtsY2ktqoj0NBJXYEixnC4O76PSI0K7PC/Gu+Kg=;
 b=YCIDkYlZ/POfzNa7u+NB39vIW4zdalRragKFvQ5p7jHnWJKtBmXsRmHNT8708WDuhWZQT20dtzgKLjnv8X6afJ5uxo09YThL9FFQssZ0AAvfcS3lIcJ0uxw62XU/F/moursHMmiVi5zaa+2hGdVS3ByBGE5R74svOkCSVUShCyY=
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com (2603:1096:820:ea::9)
 by SEYPR03MB6676.apcprd03.prod.outlook.com (2603:1096:101:69::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 11:49:49 +0000
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::1bd1:4be7:8749:79ea]) by KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::1bd1:4be7:8749:79ea%4]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 11:49:48 +0000
From:   =?utf-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= 
        <Yu-chang.Lee@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH] clk: mediatek: mt8188: probe vpp with
 mtk_clk_simple_probe()
Thread-Topic: [PATCH] clk: mediatek: mt8188: probe vpp with
 mtk_clk_simple_probe()
Thread-Index: AQHaCAEOpE53qx8tMEeQ8E3pMUSPoLBb87EAgAFOl4CAAAHigIAJsS0A
Date:   Thu, 2 Nov 2023 11:49:48 +0000
Message-ID: <b178c75e39ea2104f07afa989131d5a90e2eefb9.camel@mediatek.com>
References: <20231026113830.29215-1-yu-chang.lee@mediatek.com>
         <a7321404-0c8f-430c-b14c-7ffc9e4fc5d7@collabora.com>
         <aeb71e4321637fdebd414acf58480e520afd2b15.camel@mediatek.com>
         <b8b2ff9d-293d-4e21-b3b2-92b456b8f7c4@collabora.com>
In-Reply-To: <b8b2ff9d-293d-4e21-b3b2-92b456b8f7c4@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7366:EE_|SEYPR03MB6676:EE_
x-ms-office365-filtering-correlation-id: ba4a4bfd-cffc-40c3-24fe-08dbdb99d0d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nyb20frGKYujLarw4NtQKPwWfSjZd4d7ZslIJg1aiX1ZMNq6RaPA44rO3JJAYXWxMQlUQnYBlyc3Co9L/77Rn3VzfGydIl1GQY1iv0R2DujISwrFZ1Ez1q8Gso6neOmuVyyGx04FEZb2g5fgvT6fScZ7CkiQ2rcM4OQyKPQf9q7tTwpl1Xah2NQZ3o1LcjQDYxaQEBPUC7q08ZljGJax6Vz/i2x6hN++s2y5haM56Zk0QLt0cQm6zp5mqXOPG3f7tMkXvigf89NpCYWyvacMJoKbDnu8dGUDBHXuKlhUi3mBTssQOnruzljDkPW94+W7DcJQo7/3tZhkVPWHPPZp4XxAfngRvPRDhVh5nLRePPOzfvIY9xoAwsNIX1Zt9jVBYnTsMehWWw6cDUy1qJgoHsVvkCW7KlTmXlF6d2bROqE28hP1lHlNIci87IW4LfNPYYxdu6b2NVqrgMMnvalJPQP6FOp78ApraH+FwyMbgqcCNtK/yiXcWpBQ4aWVJIBVEaROoLlrpajXIghoXfK6LM+2Lz0wbdTlnOahVcVtQwIZLF60OXWP2y8vyQHTwwu36psDVLI38v/hJORzqFmZ9jpklk/Ncp4gb33QqkNGUVxuM/PuBSOSmyh9bHWI5Ynrut0c47pEZFb8/2rofYmJuy+1IzJ/3Ul179wgFOmvpTM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7366.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6512007)(2616005)(26005)(478600001)(6506007)(71200400001)(83380400001)(7416002)(5660300002)(2906002)(4001150100001)(41300700001)(91956017)(110136005)(6486002)(76116006)(4326008)(8676002)(8936002)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(38070700009)(38100700002)(122000001)(86362001)(36756003)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2lWWkVMalJ3MWRhcUVBUHlHVEZ3RTlVZXpTYUx5MUtEYXNFTGVFeWNhcS9v?=
 =?utf-8?B?aHBtR3dVUXVxWTQydWFkU1lWSDZJaWtuUmFUUGNvZ2tpN0RVUTUyeTl4NVdR?=
 =?utf-8?B?YVpXMGZMM0M2SGhnUXdHOEVtZjlRQVZsU2s2QUNKQU00VTVPOEcyMjRrVkZO?=
 =?utf-8?B?c1ZyU3pPSVBiK1dnQzZmSThoUjlxODdIWTZMQ01jb0FSZEJrb2NxUjhSZGtJ?=
 =?utf-8?B?ZTNpNDR3Y242ZVhPTzZQUElHZnpRaXk1WEg1U293Mzg2M0IxU0NyMzJuc1By?=
 =?utf-8?B?ZWx1cTZuV3A1QzJ4dmRMUjR1dHpiUkhKOWlkcVU2K3VUNzhVQmJDSXhuYlRx?=
 =?utf-8?B?S1F2Uk1qd3RYLzFzU3dXR1pZRnlKeSsvcXRlMXkza0R1QnBoUkdvZStzYnAv?=
 =?utf-8?B?UW1SdStpbyt2NkRMb2lMNm04bi9UeU43TGp2YjF2cHU2dlBieEFxWXlWQktt?=
 =?utf-8?B?MlpyOHd5YnNNazg1V0ZDRlV6UERiTXlLd3FqZTBqeDdaQjZRSU55UEhVUjJy?=
 =?utf-8?B?VU9pTDAydkFBdHFORThOR2dyYjZLUTdYSXRpa0xzQ2tUMWpGSGVkUFQ0VkN4?=
 =?utf-8?B?VGtJcVlROVk0TXJLT1RGeFhHbmd4bHJzUUlXUmYzRGtkeXlETkVDUUxpcmtD?=
 =?utf-8?B?ZDlVVUp6SUNFMUo4bVp0WWMwbjFRR3FmSkVNNCtRWjhDZ0dIUEVVaS8xem1R?=
 =?utf-8?B?UVlzTkdzWlRubVRka0QvU0xBTWxETFlnVFFZSVlORS9EalJGTWJHRkZTTWpi?=
 =?utf-8?B?aTZsRGNsdnpZdWl5WFBIUUtUYVhRc2dUME1mRys4UEI3Q2piNVlRRzRnUWJF?=
 =?utf-8?B?Vmk1a2VRYkpEY1NVekFjaVlrSkQyanNORCsrMS9hNTB5WDV5QmI5QUkwODBB?=
 =?utf-8?B?cDVsa3NRUisvTlhCbGg5Vk52blYrSjF2dFMzRE9FWWU5YkhGOWNoQ05kcytX?=
 =?utf-8?B?UFNCWnEzV3YzTnF4U3hPaTIxUDBlblJIbFU5R1hwTnREaVd3ZkJ6NDZveW9W?=
 =?utf-8?B?K3V5OWllbkNWcXpRd2RTTGdjMHFHWkNHcGpFSERmVm9PMGZuU3Zpejd4aUs1?=
 =?utf-8?B?cGprNVVMSnJBZGVyS1luMWhVMXBJQ0RuYzZ1dzhCKzZGQnBGRllpT1p5bG9x?=
 =?utf-8?B?bHl5OSt3ZDluVCs4UmdhSE8xTmlVcm5nai94OVZtOXFTUklNVGRPbk9hSE9s?=
 =?utf-8?B?Wk1iV2U5ZUVmbmhkUXBwOXh4NFJYbXF0aEc1d080SEFBN1AzZEpMOEx0WDN6?=
 =?utf-8?B?ejI2WGxBYmI4bjRManRtY1VNVHVvQUpURWRKS2ZJNGpZR09RUW5oQVVFVnY3?=
 =?utf-8?B?eGUxWGhVakxZdisvWUQxdzlUWjRpZTFIZ2JLbW55VXRsa01DdjZJZUhPeGNo?=
 =?utf-8?B?dXZkaUN3Q0w4dDZxOVg3WW1iVWxQc3JlVWdhVElsanFuZXpWWTVqUkMxM1Y4?=
 =?utf-8?B?bUJVM1UvQm1xaVlNOS9SS0YxL0pkVnBnMmxndTZUSFpDYkUydzE2NTN4a0Rz?=
 =?utf-8?B?RThCNVB5TVdDbmxGazhXOGQxVFVibndMcXE2ckZRZTd4R2VWWm9XVFpHY2Nu?=
 =?utf-8?B?RmpsbXlscS9oSythdmwwVWhWbDJlV0Y5M2toVGZJUmxqUVRMQllYdnZUVjZJ?=
 =?utf-8?B?WlppK2NrdEY3RkFSdmJSNm5oRU5NZEtqRUFjMW1namxSdmNDUXJBU3NEUHdG?=
 =?utf-8?B?MmFtT2JZMTM0OWFoTVltREVucDUyTXBmSThsYzJvalBZWEVsUUFSTmhORmEw?=
 =?utf-8?B?Nnlpc1N1dHV0YlkxTzhlWWlNdk5OaFcrUi8vZUQvVVp5cTFJR1p3QjNIVmI5?=
 =?utf-8?B?aUE4RGtDQkduTDNVaFB6WUpUVElPN0szNXV6cEwxRWtVV3FiSFpOS0c2b3Bx?=
 =?utf-8?B?aGE4Ti95ZytOdGxCRjEvVDZRMnFtL28rZ2luRkpNa1BySmdpemxpck91dDM0?=
 =?utf-8?B?M3lIN2hLcmQyOVBxRVBTTkpDMkRCN0hxbGtTbEFDcmJya1VEYVY3aFhmN240?=
 =?utf-8?B?U0J6NC9PQXpJd3dkb1IwOGZXZExvcHY5Sng5WWNUTjFVZTg0Qk9xOFBaRGtN?=
 =?utf-8?B?K2NDbHRETmhuTHhBbnpaMFliVVppa2RLRVB3cHhHRFZiaS9OOFIyTFcrWVcy?=
 =?utf-8?B?cCtMM3VNQXhNcXd0enhnb2xtOHVJYXB5YnlqL1B5YndXREFManMxclpPR1JG?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC7A6D1B79DE714C9C855676CD4DA0FD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7366.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4a4bfd-cffc-40c3-24fe-08dbdb99d0d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 11:49:48.2787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ipRyrFyJX3wNjRNy5EIqOtBx9cr8iAxLgsNNIjV2diZrj9inXuxU/3Qp5sDVJmlR2/MaxLIUTQRCDihCMuTS0iS7+q9BWyInSTA+32IvYAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6676
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTEwLTI3IGF0IDA5OjQ5ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjcvMTAvMjMgMDk6NDIsIFl1LWNoYW5nIExlZSAo5p2O56a555KL
KSBoYSBzY3JpdHRvOg0KPiA+IE9uIFRodSwgMjAyMy0xMC0yNiBhdCAxMzo0NSArMDIwMCwgQW5n
ZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8NCj4gPiB3cm90ZToNCj4gPiA+IElsIDI2LzEwLzIzIDEz
OjM4LCB5dS1jaGFuZy5sZWUgaGEgc2NyaXR0bzoNCj4gPiA+ID4gc3dpdGNoIHRvIHRoZSBjb21t
b24gbXRrX2Nsa19zaW1wbGVfcHJvYmUoKSBmdW5jdGlvbiBmb3IgYWxsIG9mDQo+ID4gPiA+IHRo
ZQ0KPiA+ID4gPiBjbG9jayBkcml2ZXJzIHRoYXQgYXJlIHJlZ2lzdGVyaW5nIGFzIHBsYXRmb3Jt
IGRyaXZlcnMuDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBTbyBWUFBTWVMwIGFuZCBWUFBTWVMx
IGFyZW4ndCBkZXBlbmRhbnQgb24gTU1TWVMgYW55bW9yZT8NCj4gPiA+IA0KPiA+ID4gTGlrZSB0
aGlzLCBpdCBkb2Vzbid0IGxvb2sgbGlrZSB0aGlzIHdpbGwgZXZlciB3b3JrIGZpbmUsIHNvIGlm
DQo+ID4gPiB5b3UNCj4gPiA+IHdhbnQNCj4gPiA+IHRoYXQgdG8gaGFwcGVuLCB5b3UgbXVzdCBw
cm92aWRlIGEgZ29vZCBleHBsYW5hdGlvbiwgYW5kIHRoZW4sDQo+ID4gPiBzaW5jZQ0KPiA+ID4g
TVQ4MTg4DQo+ID4gPiBhbmQgTVQ4MTk1J3MgVlBQU1lTIGFyZSBwcmFjdGljYWxseSB0aGUgc2Ft
ZSwgeW91IHNob3VsZCBhbHNvDQo+ID4gPiBjb252ZXJ0DQo+ID4gPiBNVDgxOTUNCj4gPiA+IHRv
IGRvIHRoZSBzYW1lLCBhbmQgbWFrZSBzdXJlIHRoYXQgZXZlcnl0aGluZyB3b3JrcyBhcyBleHBl
Y3RlZA0KPiA+ID4gYmVmb3JlIHNlbmRpbmcNCj4gPiA+IGEgY29tbWl0IHVwc3RyZWFtLg0KPiA+
ID4gDQo+ID4gPiBQbGVhc2UsIGV4cGxhaW4uDQo+ID4gPiANCj4gPiA+IFRoYW5rcywNCj4gPiA+
IEFuZ2Vsbw0KPiA+ID4gDQo+ID4gDQo+ID4gSGkgQW5nZWxvLA0KPiA+IA0KPiA+IFRoYW5rcyBm
b3IgeW91ciB0aW1lIGFuZCB0aW1lbHkgZmVlZGJhY2suIEkgZG9uJ3QgZmluZCBtdDgxODgtdnBw
MQ0KPiA+IGFuZA0KPiA+IG10ODE4OC12cHAwIGluIG10ay1tbXN5cy5jLiBhbmQgdGhvdWdodCBw
cm9iZWQgdGhlbSB3aXRoDQo+ID4gbXRrX3NpbXBsZV9wcm9iZSgpLCByZWZlciB0byB5b3VyIGNv
bW1lbnQgb24gaW4gdGhpcyBwYXRjaA0KPiA+ICJjbGs6DQo+ID4gbWVkaWF0ZWs6IFN3aXRjaCB0
byBtdGtfY2xrX3NpbXBsZV9wcm9iZSgpIHdoZXJlIHBvc3NpYmxlIiwgd2lsbCBiZQ0KPiA+IGEN
Cj4gDQo+IEp1c3QgdG8gY2xhcmlmeTogbXRrX2Nsa19wZGV2X3Byb2JlKCkgaXMgbXRrX2Nsa19z
aW1wbGVfcHJvYmUoKSBmb3INCj4gcGRldiwgbm90aGluZyBtb3JlIGFuZCBub3RoaW5nIGxlc3Mg
Oi0pDQo+IA0KPiA+IGdvb2QgaWRlYS4gT24gdGhlIG90aGVyIGhhbmQgbXQ4MTk1IGRvZXMgaGF2
ZSBkZXBlbmRlbmN5IG9uIE1NU1lTLA0KPiA+IHNvIEkNCj4gPiBkb24ndCB0aGluayB0aGUgc2Ft
ZSBjaGFuZ2Ugd29yayBvbiBtdDgxOTUuDQo+ID4gDQo+IA0KPiBPaywgdGhlbiB0aGF0J3Mgc2lt
cGx5IGJlY2F1c2UgTVQ4MTg4IE1EUDMgaXMgbm90IHVwc3RyZWFtIHlldDoNCj4gdGhhdCdzIGdv
aW5nIHRvDQo+IGhhcHBlbiwgbWVhbmluZyB0aGF0IE1UODE4OCB3aWxsIGhhdmUgdGhlIHNhbWUg
bW1zeXMgZGVwZW5kZW5jeSBhcw0KPiBNVDgxOTUgc29vbi4NCj4gDQo+IFNvcnJ5LCB0aGlzIGNv
bW1pdCBpcyBub3QgdmFsaWQuIE5BQ0suDQo+IA0KPiBUaGFua3MhDQo+IEFuZ2Vsbw0KPiANCj4g
PiBCZXN0IFJlZ2FyZHMsDQo+ID4gWXVDaGFuZw0KPiA+IA0KDQpUaGFua3MgZm9yIHlvdXIgdGlt
ZSBhbmQgZmVlZGJhY2ssIHRoZW4gSSB0aGluayB0aGUgYXBwcm9wcmlhdGUgY2hhbmdlDQpoZXJl
IHNob3VsZCBiZSBhZGRpbmcgdGhlIHZwcHN5cycgZGVwZW5kZW5jeSBpbiBtdDgxODggbW1zeXMu
DQoNCkkgc3VibWl0dGVkIGFub3RoZXIgY29tbWl0IHRpdGxlZCAic29jOiBtZWRpYXRlazogbW1z
eXM6IEFkZCBzdXBwb3J0DQpmb3IgTVQ4MTg4IFZQUFNZUyIgYWNjb3JkaW5nIHRvIHlvdXIgZmVl
ZGJhY2suIA0KDQpCZXN0IFJlZ2FyZHMsDQpUb255IExlZQ0KDQo+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IHl1LWNoYW5nLmxlZSA8eXUtY2hhbmcubGVlQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gLS0t
DQo+ID4gPiA+ICAgIGRyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxODgtdnBwMC5jIHwgMTQg
KysrKysrKysrKystLS0NCj4gPiA+ID4gICAgZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE4
OC12cHAxLmMgfCAxNCArKysrKysrKysrKy0tLQ0KPiA+ID4gPiAgICAyIGZpbGVzIGNoYW5nZWQs
IDIyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE4OC12cHAwLmMNCj4gPiA+ID4g
Yi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTg4LXZwcDAuYw0KPiA+ID4gPiBpbmRleCBl
N2IwMmIyNmZlZmIuLjE4ZmZmYTE5MWVlMSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9j
bGsvbWVkaWF0ZWsvY2xrLW10ODE4OC12cHAwLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9jbGsv
bWVkaWF0ZWsvY2xrLW10ODE4OC12cHAwLmMNCj4gPiA+ID4gQEAgLTk2LDYgKzk2LDE1IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Nsa19kZXNjIHZwcDBfZGVzYyA9DQo+ID4gPiA+IHsNCj4g
PiA+ID4gICAgCS5udW1fY2xrcyA9IEFSUkFZX1NJWkUodnBwMF9jbGtzKSwNCj4gPiA+ID4gICAg
fTsNCj4gPiA+ID4gICAgDQo+ID4gPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9p
ZCBvZl9tYXRjaF9jbGtfbXQ4MTg4X3ZwcDBbXSA9DQo+ID4gPiA+IHsNCj4gPiA+ID4gKwl7DQo+
ID4gPiA+ICsJCS5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4OC12cHBzeXMwIiwNCj4gPiA+
ID4gKwkJLmRhdGEgPSAmdnBwMF9kZXNjLA0KPiA+ID4gPiArCX0sIHsNCj4gPiA+ID4gKwkJLyog
c2VudGluZWwgKi8NCj4gPiA+ID4gKwl9DQo+ID4gPiA+ICt9Ow0KPiA+ID4gPiArDQo+ID4gPiA+
ICAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlX2lkDQo+ID4gPiA+IGNsa19t
dDgxODhfdnBwMF9pZF90YWJsZVtdDQo+ID4gPiA+ID0gew0KPiA+ID4gPiAgICAJeyAubmFtZSA9
ICJjbGstbXQ4MTg4LXZwcDAiLCAuZHJpdmVyX2RhdGEgPQ0KPiA+ID4gPiAoa2VybmVsX3Vsb25n
X3QpJnZwcDBfZGVzYyB9LA0KPiA+ID4gPiAgICAJeyAvKiBzZW50aW5lbCAqLyB9DQo+ID4gPiA+
IEBAIC0xMDMsMTIgKzExMiwxMSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZV9pZA0KPiA+ID4gPiBjbGtfbXQ4MTg4X3ZwcDBfaWRfdGFibGVbXSA9IHsNCj4gPiA+ID4gICAg
TU9EVUxFX0RFVklDRV9UQUJMRShwbGF0Zm9ybSwgY2xrX210ODE4OF92cHAwX2lkX3RhYmxlKTsN
Cj4gPiA+ID4gICAgDQo+ID4gPiA+ICAgIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGNs
a19tdDgxODhfdnBwMF9kcnYgPSB7DQo+ID4gPiA+IC0JLnByb2JlID0gbXRrX2Nsa19wZGV2X3By
b2JlLA0KPiA+ID4gPiAtCS5yZW1vdmVfbmV3ID0gbXRrX2Nsa19wZGV2X3JlbW92ZSwNCj4gPiA+
ID4gKwkucHJvYmUgPSBtdGtfY2xrX3NpbXBsZV9wcm9iZSwNCj4gPiA+ID4gICAgCS5kcml2ZXIg
PSB7DQo+ID4gPiA+ICAgIAkJLm5hbWUgPSAiY2xrLW10ODE4OC12cHAwIiwNCj4gPiA+ID4gKwkJ
Lm9mX21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfY2xrX210ODE4OF92cHAwLA0KPiA+ID4gPiAgICAJ
fSwNCj4gPiA+ID4gLQkuaWRfdGFibGUgPSBjbGtfbXQ4MTg4X3ZwcDBfaWRfdGFibGUsDQo+ID4g
PiA+ICAgIH07DQo+ID4gPiA+ICAgIG1vZHVsZV9wbGF0Zm9ybV9kcml2ZXIoY2xrX210ODE4OF92
cHAwX2Rydik7DQo+ID4gPiA+ICAgIE1PRFVMRV9MSUNFTlNFKCJHUEwiKTsNCj4gPiA+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxODgtdnBwMS5jDQo+ID4gPiA+
IGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE4OC12cHAxLmMNCj4gPiA+ID4gaW5kZXgg
ZThmMGY3ZWNhMDk3Li5mNGIzNTMzNmQ0MjcgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMv
Y2xrL21lZGlhdGVrL2Nsay1tdDgxODgtdnBwMS5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvY2xr
L21lZGlhdGVrL2Nsay1tdDgxODgtdnBwMS5jDQo+ID4gPiA+IEBAIC05MSw2ICs5MSwxNSBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IG10a19jbGtfZGVzYyB2cHAxX2Rlc2MgPQ0KPiA+ID4gPiB7DQo+
ID4gPiA+ICAgIAkubnVtX2Nsa3MgPSBBUlJBWV9TSVpFKHZwcDFfY2xrcyksDQo+ID4gPiA+ICAg
IH07DQo+ID4gPiA+ICAgIA0KPiA+ID4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2Vf
aWQgb2ZfbWF0Y2hfY2xrX210ODE4OF92cHAxW10gPQ0KPiA+ID4gPiB7DQo+ID4gPiA+ICsJew0K
PiA+ID4gPiArCQkuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODgtdnBwc3lzMSIsDQo+ID4g
PiA+ICsJCS5kYXRhID0gJnZwcDFfZGVzYywNCj4gPiA+ID4gKwl9LCB7DQo+ID4gPiA+ICsJCS8q
IHNlbnRpbmVsICovDQo+ID4gPiA+ICsJfQ0KPiA+ID4gPiArfTsNCj4gPiA+ID4gKw0KPiA+ID4g
PiAgICBzdGF0aWMgY29uc3Qgc3RydWN0IHBsYXRmb3JtX2RldmljZV9pZA0KPiA+ID4gPiBjbGtf
bXQ4MTg4X3ZwcDFfaWRfdGFibGVbXQ0KPiA+ID4gPiA9IHsNCj4gPiA+ID4gICAgCXsgLm5hbWUg
PSAiY2xrLW10ODE4OC12cHAxIiwgLmRyaXZlcl9kYXRhID0NCj4gPiA+ID4gKGtlcm5lbF91bG9u
Z190KSZ2cHAxX2Rlc2MgfSwNCj4gPiA+ID4gICAgCXsgLyogc2VudGluZWwgKi8gfQ0KPiA+ID4g
PiBAQCAtOTgsMTIgKzEwNywxMSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZV9pZA0KPiA+ID4gPiBjbGtfbXQ4MTg4X3ZwcDFfaWRfdGFibGVbXSA9IHsNCj4gPiA+ID4gICAg
TU9EVUxFX0RFVklDRV9UQUJMRShwbGF0Zm9ybSwgY2xrX210ODE4OF92cHAxX2lkX3RhYmxlKTsN
Cj4gPiA+ID4gICAgDQo+ID4gPiA+ICAgIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGNs
a19tdDgxODhfdnBwMV9kcnYgPSB7DQo+ID4gPiA+IC0JLnByb2JlID0gbXRrX2Nsa19wZGV2X3By
b2JlLA0KPiA+ID4gPiAtCS5yZW1vdmVfbmV3ID0gbXRrX2Nsa19wZGV2X3JlbW92ZSwNCj4gPiA+
ID4gKwkucHJvYmUgPSBtdGtfY2xrX3NpbXBsZV9wcm9iZSwNCj4gPiA+ID4gICAgCS5kcml2ZXIg
PSB7DQo+ID4gPiA+ICAgIAkJLm5hbWUgPSAiY2xrLW10ODE4OC12cHAxIiwNCj4gPiA+ID4gKwkJ
Lm9mX21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfY2xrX210ODE4OF92cHAxLA0KPiA+ID4gPiAgICAJ
fSwNCj4gPiA+ID4gLQkuaWRfdGFibGUgPSBjbGtfbXQ4MTg4X3ZwcDFfaWRfdGFibGUsDQo+ID4g
PiA+ICAgIH07DQo+ID4gPiA+ICAgIG1vZHVsZV9wbGF0Zm9ybV9kcml2ZXIoY2xrX210ODE4OF92
cHAxX2Rydik7DQo+ID4gPiA+ICAgIE1PRFVMRV9MSUNFTlNFKCJHUEwiKTsNCj4gPiA+IA0KPiA+
ID4gDQo+IA0KPiANCg==
