Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA397D27E3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 03:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjJWBUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 21:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjJWBUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 21:20:21 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8610AEE;
        Sun, 22 Oct 2023 18:20:12 -0700 (PDT)
X-UUID: 4aca38dc714211ee8051498923ad61e6-20231023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=HNCwaAcq0THHGXENS9aJ4eK8VEX1RTq0D+xPa534X3k=;
        b=B2k+jPZQAp9Q6PNqBRoLbY9PYVXxYmvTh1nFH3ZbeNPxOi/BTh+l3NouXFchSyC8VmX+2v+5ZqqBjqAe72GtAc77SzeKLZbgyqBmPWyci/89lgwvnJdzS6qx6diP2QUJkROq21qDUZI3jN3RIDmDKQewD4EEo8XDFK2EjIon/nE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:f24bd9f1-0f75-43c2-991d-125ae88cec1e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:55f92ed7-04a0-4e50-8742-3543eab8cb8e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 4aca38dc714211ee8051498923ad61e6-20231023
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <bo.ye@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1462552182; Mon, 23 Oct 2023 09:20:03 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Oct 2023 09:20:02 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 23 Oct 2023 09:20:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIuDGbrud9bK4p23bBlsh/K2CkjD2+Bgr5fFwuLjxZpf6Ua8auhn+8SJ8A9j/UV92dodN8AOPvcdcQpXAq1v4J/uwTciZxxJ1uZpq3Fwh4rXUS8MRaUmG3chJ+6d3YsmcjSJSDqddxnxGFzew2RR3dr6v63MlwUvJmuGzMbbgpn75t/5PyO0eTFDIKH2ziBfAQ/iMnhiA1Bm8k4ZMJ+zY945YBmkbBXzLWwdWwXGaDOJrIQv5Ae1c48ED4mJbyuGBQF5KVTeMn9yoqldgYXt+3HfKml48AUebi/7qBY75SU8Nz+rKwu4rP62dg80vG+IcPTal1OS7/xALIRNTA+nvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNCwaAcq0THHGXENS9aJ4eK8VEX1RTq0D+xPa534X3k=;
 b=LY5JMGoGro5hd9txtualwgmS6sO72swE1xdDoJvf8fGRrkPQiN2pq7t8PYsIr/Z/Wgr1TqzM+UWmvbDndw3uJmvTwoEBhrSIsuPWWNPACu9h9Vp+xdc+WUsN2ss0d2J1Ff8/0z71rfwalSn4KVkrSqHMyhSlSoucBEZs13jBZ+G3/dwGC7WVjl3t6+EKuVcUSO/NwQiKKbQ98KyFlSqsFIMRDrE3j2Lz1RvFxreL1BkH/AAF9ogUMLMGHjlqyd3K5h7cmn5MsTGA3kcjK37HSb+k2Mdr9zpmVUKvkLsz+6DlZHhAvosjtuEPOzRW3g9xH4Enle0qnTbixRiv4u3zaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNCwaAcq0THHGXENS9aJ4eK8VEX1RTq0D+xPa534X3k=;
 b=r1NcSdEUKirjCvwOymgpHaCnHulUPyX7186dtcsNSUwpA3FbhkaBle6hF8PzTEFTd6H+sBlDQ6UeI+fBoDKEoAbPHdMTdVXt9pR2qqbDO0fSAjgnRCBdnwOziV82phhB1NV8JBcPHQISw7+OOjt4pqHGz17NLgGUn9Z69+ajwok=
Received: from TYZPR03MB5199.apcprd03.prod.outlook.com (2603:1096:400:32::11)
 by SEZPR03MB7122.apcprd03.prod.outlook.com (2603:1096:101:e5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Mon, 23 Oct
 2023 01:19:59 +0000
Received: from TYZPR03MB5199.apcprd03.prod.outlook.com
 ([fe80::b06f:65cf:b887:6fcf]) by TYZPR03MB5199.apcprd03.prod.outlook.com
 ([fe80::b06f:65cf:b887:6fcf%4]) with mapi id 15.20.6907.028; Mon, 23 Oct 2023
 01:19:59 +0000
From:   =?utf-8?B?Qm8gWWUgKOWPtuazoik=?= <Bo.Ye@mediatek.com>
To:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     =?utf-8?B?WW9uZ2RvbmcgWmhhbmcgKOW8oOawuOS4nCk=?= 
        <Yongdong.Zhang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?QnJvd3NlIFpoYW5nICjlvKDno4op?= 
        <Browse.Zhang@mediatek.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        =?utf-8?B?WXVnYW5nIFdhbmcgKOeOi+eOieWImik=?= 
        <Yugang.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] thermal: Fix potential race condition in suspend/resume
Thread-Topic: [PATCH] thermal: Fix potential race condition in suspend/resume
Thread-Index: AQHZ/N6xgCQByEGiEkOT8i2+eBLPS7BWpFUA
Date:   Mon, 23 Oct 2023 01:19:59 +0000
Message-ID: <148c8e2d10bbb932177f732dfc44230681dc4d91.camel@mediatek.com>
References: <20230916113327.85693-1-bo.ye@mediatek.com>
         <542a64a842d715329b35654db908681e074b0db5.camel@mediatek.com>
In-Reply-To: <542a64a842d715329b35654db908681e074b0db5.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5199:EE_|SEZPR03MB7122:EE_
x-ms-office365-filtering-correlation-id: 5ac913a6-e27d-4b9f-4fbd-08dbd3662cb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BecGy7IKVXGHHG2/kNLoh/IMol0nXNFPj9Cw2sggEFUOtCBWnMpjK0Fu/WuDM2bck7aYBzErKr5v91aisxlNdIIS3T/XELUnF38Y7UH5i4To46pIFLzeOT3JGiVJ+J53tbAgOOn/wG2M35K3Clq4fBH7API5dOmqCYQ9cRRko6RzdufxoDG5ZHWjx4nyjKDEC7o6ErpV07e4oMmMBDHw3eOK95s3yqcGyxux+sL77svWK5CCt2fFANEkBqq+D3dtlKR/0H44zWIxB5BUWoyOcP11OHjygz09KAObMIokk179BCzX7kNi1usnabEEjx9RrTxRWfmYlfWPRR83ST6kH06u7/GxQwYe9j5TsYj9LdCUflD8pWi0xBnzjYKgYK6OUPhr0gqKcDaVi0BPm5EpKEwH6CSf/kclWUkvxDZltY8MOf1F8zW2ebB8A1LFpamGqZ7OXaP45W+WklmUAW+Fwzu9HZhmV1fbl9XjV7rW9/BmGwi4tGJysXmrG8HVc8XwqlSIpSWKwuEcLuPhSs5l2T873jop5Q3rEGvHWyy+pyFBpp7VO1THYfuWYBCOcJ2JxJcmQesnIthNGfcOpOk/dmzpjIKOyoUet17HY1MwV6r9R7VZXS3NbG1LXjotbOLoqXJQ7KaS+xtIXdG8XW3QuhqEYZYb6Et1fJB6EG9qvRA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5199.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39850400004)(136003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(2616005)(6506007)(71200400001)(8936002)(6512007)(26005)(83380400001)(41300700001)(5660300002)(7416002)(4326008)(8676002)(2906002)(15650500001)(4001150100001)(6486002)(478600001)(110136005)(66446008)(66556008)(76116006)(316002)(54906003)(64756008)(66476007)(91956017)(66946007)(122000001)(86362001)(38100700002)(38070700009)(85182001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEoxaU4vc01mNW5hdlpvTjBIRnl1VmRCcUJGZFcvSnFGVFNiem13dUszY2Q5?=
 =?utf-8?B?NWhQc2lmTFNUV0QzRDdZQ0RPY0JGME1pTTFaMFVTSUJJMjZyWWNpWVZ2dzhn?=
 =?utf-8?B?d2tlRHVjMDg0MHRNWkwvbDVKckxNV2QvNEpuYmtxbXF0WGtEc3p0MUpWMDVo?=
 =?utf-8?B?WXRwTGFKbko0QytBZnIzUFpFWUpYQXpVQXQrR1FvSVhKT2ViU3pTY2tZSlJY?=
 =?utf-8?B?OXU2MXdrZXFEWCs1RHhKT0l3R1E0VlVKdWlCb0hYVUZvdmVMajgrUTZvcmFP?=
 =?utf-8?B?WXQwb1h2NVZUT1JxNlNwclFZeHVpTUFUMU5XM1FScGpDWVRPbUpBL3lJb1Ft?=
 =?utf-8?B?WnRqSDJEZUpEZWVYWUpzaTJ4SGtyenNIZkRSWFRUaUNVTkhZVzRYaHl6em4z?=
 =?utf-8?B?bFd2ODN5akxFUlJvMkdHM0RPeGNVWlc0cjB1WEwzMCtmaElQK0ZDVWF5bzJR?=
 =?utf-8?B?RlhHWWR1d3hFNnpOMm1PS3BqemtNUW9ZVXVzZ25Dcjd2TlV2Vk8xUTlrOVFv?=
 =?utf-8?B?TWFDZnhEZnVJL3lyNmczVXIvS20xSnJST1Q5TnZ2ZENObzBZVVpnVk8yYXNl?=
 =?utf-8?B?OXRXandIanRXcDQ5NzUwdE1TYWJXaUxzM0RPUkNIdzhleEV4WTQ1TE5nZXVK?=
 =?utf-8?B?VURRd3RJQnhrTjdzMURETVVSUElaMXZIRVZsRzg2d3EzMzRCN01nM2ZuZzVr?=
 =?utf-8?B?a3FuNmJDenl3enhXeXdkSGpGN3FGd0NzNFpEOXJFMW9yQ0ZsNTRYUU4zR0hK?=
 =?utf-8?B?TkZZVFNFNmhRVDUyN3FuWU9vSFlzVktrRU02WDNSZTRRS3Q3bVVnMU1RdWZy?=
 =?utf-8?B?SXgwWkRla3lCcEc5UmdNelhyZWN5enZSZFFoekdkeVhucVQ0UXp6SEFZUkNM?=
 =?utf-8?B?U1NNYnFzOGF6WGhna1hlcHZnZnFnZ09ZR241L1g1RmVETHQ0a3NCMEw2ZkNs?=
 =?utf-8?B?VXJTUVdtS2l3MEVQNnNBYkduRElUTVlTa21HZG1ZblcxV29FeG1HOVhTWEZB?=
 =?utf-8?B?ZnU4RzdnYTNNR3Z5bDZTZjNFbmxUdWQ0V0xMVWRiWmYzemg0SmV2SDlxTTlF?=
 =?utf-8?B?aEhxQWxPYkg2UXo2KzBLZ0w2akhHV0JmVTluMmtOSTNURCtKR3FYSVBHdnRu?=
 =?utf-8?B?bDJBQXlGUGlONkRmM3FpZmRXNGgyVEIydktrd1hlcG9GR0oweGROc0h4OE4w?=
 =?utf-8?B?WWZySmszemhkUGdCVklGWWRYYVhjRWgwZm1IcjdMQ2xSaURSRkhHU0NkTVh2?=
 =?utf-8?B?My9IV1BFWmVKRGhUMG5Hc3NkTEdnSjZkNnVWaVFwdnA3MW5CZFJ0OElGL2w1?=
 =?utf-8?B?UW92TmJQaGtCUHo4SEJYTm54Z0pnMkJVR3ZlVC9IMSswS0d6bTROcE9JaDZj?=
 =?utf-8?B?eWNveUNPL3lIenNjMHBuZ1N2Q3pYK2l1cUx2K0NMc3d3MzFScEgzVGZXN245?=
 =?utf-8?B?Ull6dWVkaWxoTlIxYlY2YSsrbmNiWWxFYnFsQnljaVNxSEMvT0VNWkhXYmp1?=
 =?utf-8?B?cGdYa1U5NEErM0xXNHBZTExhNmxCZ0R4K0VzckZmOVZvZ2d2OVNWVWU5Z0VJ?=
 =?utf-8?B?TVZRdm81R0ZiYlQxWkloVUQva3EwY2U5TGg4TStNWWNibEpxck94bHJKVnJH?=
 =?utf-8?B?WGtEVFBIQWh6QUFiUktvNThuRkhlditqdkx1anViUXoyM1cwaUZIdTNhUGww?=
 =?utf-8?B?UUVYN3p3aHFtcThGRmV2V1JCMElaRnliQ3NQZTBGaFZNeDQvMmZ6UkZPcVFh?=
 =?utf-8?B?aHd1L2gwMWZzVXoyQ1MydW9hQnZucFNMWkdGR1I3c05FSnNRSW8rNlRNN1ZO?=
 =?utf-8?B?L2JrTURRcGZreXllUXFKNFV3LzRaN0UrSUNIUW9aOHJwWjJ6N05UTUxpbEd0?=
 =?utf-8?B?THZwWU90Rll0WWM3enNzMWhOVW5PcFVlc1NiVnBMdTQyVUhGK3NJd3ZvdW1t?=
 =?utf-8?B?QkJ3c0JLeTRaTnI4NHFISEVBVmE0c29QcnJncnNiS053WVJsMTNtK0lZNDlt?=
 =?utf-8?B?WE5ieW5ocXptcjNVd2VTa2FVc2UwZkQ4OUU0QU5ZK2MxRmg2S0szYVRWVjFW?=
 =?utf-8?B?VWFTUi9OTXQ5UXNzWmdFT3hGQnltWHpFV1gzQkxsUy9tWmZoNGpQdDhReDl3?=
 =?utf-8?Q?jt5Jvnbkz7Ue2s1YVJTbXE8Kw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F435EA1D6DB5BF46B912638DFB1E00D9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5199.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac913a6-e27d-4b9f-4fbd-08dbd3662cb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 01:19:59.2900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6b6hlK46ofS5LR1aT4bXWwnDKX93wqZmxevGwa0zyvxp9zLAewN7QoZEZUALMsF1oX/q9H+WWWdXyHNDz82iPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7122
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WWVzLCBpdCBpcyBvYnNlcnZlZCBpc3N1ZS4NCkZpcnN0bHksIGl0IG5lZWRzIHRvIGJlIGNsYXJp
ZmllZCB0aGF0IHRoaXMgaXNzdWUgb2NjdXJzIGluIGEgcmVhbC0NCndvcmxkIGVudmlyb25tZW50
LiBCeSBhbmFseXppbmcgdGhlIGxvZ3MsIHdlIGluZmVycmVkIHRoYXQgdGhlIGlzc3VlDQpvY2N1
cnJlZCBqdXN0IGFzIHRoZSBzeXN0ZW0gd2FzIGVudGVyaW5nIHN1c3BlbmQgbW9kZSwgYW5kIHRo
ZSB1c2VyIHdhcw0Kc3dpdGNoaW5nIHRoZSB0aGVybWFsIHBvbGljeSAodGhpcyBhY3Rpb24gY2F1
c2VzIGFsbCB0aGVybWFsIHpvbmVzIHRvDQp1bnJlZ2lzdGVyL3JlZ2lzdGVyKS4gSW4gYWRkaXRp
b24sIHdlIGNvbmR1Y3RlZCBkZWdyYWRhdGlvbiB0ZXN0cyBhbmQNCmFsc28gcmVwcm9kdWNlZCB0
aGlzIGlzc3VlLiBUaGUgc3BlY2lmaWMgbWV0aG9kIGlzIHRvIGZpcnN0IHN3aXRjaCB0aGUNCnRo
ZXJtYWwgcG9saWN5IHRocm91Z2ggYSBjb21tYW5kLCBhbmQgdGhlbiBpbW1lZGlhdGVseSBwdXQg
dGhlIHN5c3RlbQ0KaW50byBzdXNwZW5kIHN0YXRlIHRocm91Z2ggYW5vdGhlciBjb21tYW5kLiBU
aGlzIG1ldGhvZCBjYW4gYWxzbw0KcmVwcm9kdWNlIHRoZSBpc3N1ZS4NCg0KT24gVGh1LCAyMDIz
LTEwLTEyIGF0IDA3OjM1ICswMDAwLCBCbyBZZSAo5Y+25rOiKSB3cm90ZToNCj4gT24gU2F0LCAy
MDIzLTA5LTE2IGF0IDE5OjMzICswODAwLCBCbyBZZSB3cm90ZToNCj4gDQo+IENvcnJlY3QgbWFp
bCB0aXRsZSBmb3JtYXQ6IHJlbW92ZSAiU3ViamVjdDoiIGZyb20gbWFpbCB0aXRsZS4NCj4gDQo+
ID4gRnJvbTogInl1Z2FuZy53YW5nIiA8eXVnYW5nLndhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IA0K
PiA+IEJvZHk6DQo+ID4gVGhpcyBwYXRjaCBmaXhlcyBhIHJhY2UgY29uZGl0aW9uIGR1cmluZyBz
eXN0ZW0gcmVzdW1lLiBJdCBvY2N1cnMNCj4gPiBpZg0KPiA+IHRoZSBzeXN0ZW0gaXMgZXhpdGlu
ZyBhIHN1c3BlbmQgc3RhdGUgYW5kIGEgdXNlciBpcyB0cnlpbmcgdG8NCj4gPiByZWdpc3Rlci91
bnJlZ2lzdGVyIGEgdGhlcm1hbCB6b25lIGNvbmN1cnJlbnRseS4gVGhlIHJvb3QgY2F1c2UgaXMN
Cj4gPiB0aGF0IGJvdGggYWN0aW9ucyBhY2Nlc3MgdGhlIGB0aGVybWFsX3R6X2xpc3RgLg0KPiA+
IA0KPiA+IEluIGRldGFpbDoNCj4gPiANCj4gPiAxLiBBdCBQTV9QT1NUX1NVU1BFTkQgZHVyaW5n
IHRoZSByZXN1bWUsIHRoZSBzeXN0ZW0gcmVhZHMgYWxsDQo+ID4gdGhlcm1hbA0KPiA+ICAgIHpv
bmVzIGluIGB0aGVybWFsX3R6X2xpc3RgLCB0aGVuIHJlc2V0cyBhbmQgdXBkYXRlcyB0aGVpcg0K
PiA+ICAgIHRlbXBlcmF0dXJlcy4NCj4gPiAyLiBXaGVuIHJlZ2lzdGVyaW5nL3VucmVnaXN0ZXJp
bmcgYSB0aGVybWFsIHpvbmUsIHRoZQ0KPiA+ICAgIGB0aGVybWFsX3R6X2xpc3RgIGdldHMgbWFu
aXB1bGF0ZWQuDQo+ID4gDQo+ID4gVGhlc2UgdHdvIGFjdGlvbnMgbWlnaHQgb2NjdXIgY29uY3Vy
cmVudGx5LCBjYXVzaW5nIGEgcmFjZQ0KPiA+IGNvbmRpdGlvbi4NCj4gPiBUbyBzb2x2ZSB0aGlz
IGlzc3VlLCB3ZSBpbnRyb2R1Y2UgYSBtdXRleCBsb2NrIHRvIHByb3RlY3QNCj4gPiBgdGhlcm1h
bF90el9saXN0YCBmcm9tIGJlaW5nIG1vZGlmaWVkIHdoaWxlIGl0J3MgYmVpbmcgcmVhZCBhbmQN
Cj4gPiB1cGRhdGVkIGR1cmluZyB0aGUgcmVzdW1lIGZyb20gc3VzcGVuZC4NCj4gPiANCj4gPiBL
ZXJuZWwgb29wcyBleGNlcnB0IHJlbGF0ZWQgdG8gdGhpcyBmaXg6DQo+ID4gDQo+ID4gWyA1MjAx
Ljg2OTg0NV0gW1QzMTY4MjJdIHBjOiBbMHhmZmZmZmZlYjdkNDg3NmYwXQ0KPiA+IG11dGV4X2xv
Y2srMHgzNC8weDE3MA0KPiA+IFsgNTIwMS44Njk4NTZdIFtUMzE2ODIyXSBscjogWzB4ZmZmZmZm
ZWI3Y2E5OGE4NF0NCj4gPiB0aGVybWFsX3BtX25vdGlmeSsweGQ0LzB4MjZjDQo+ID4gWy4uLiBj
dXQgZm9yIGJyZXZpdHkgLi4uXQ0KPiA+IFsgNTIwMS44NzEwNjFdIFtUMzE2ODIyXSAgc3VzcGVu
ZF9wcmVwYXJlKzB4MTUwLzB4NDcwDQo+ID4gWyA1MjAxLjg3MTA2N10gW1QzMTY4MjJdICBlbnRl
cl9zdGF0ZSsweDg0LzB4NmY0DQo+ID4gWyA1MjAxLjg3MTA3Nl0gW1QzMTY4MjJdICBzdGF0ZV9z
dG9yZSsweDE1Yy8weDFlOA0KPiA+IA0KPiA+IENoYW5nZS1JZDogSWZkYmRlY2JhMTcwOTNmOTFl
YWI3ZTM2Y2UwNGI0NmQzMTFjYTY1NjgNCj4gPiBTaWduZWQtb2ZmLWJ5OiB5dWdhbmcud2FuZyA8
eXVnYW5nLndhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJvIFllIDxiby55
ZUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdGhlcm1hbC90aGVybWFsX2Nv
cmUuYyB8IDIgKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+IA0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMNCj4gPiBiL2Ry
aXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYw0KPiA+IGluZGV4IDg3MTdhMzM0MzUxMi4uYTdh
MThlZDU3YjZkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYw0KPiA+IEBAIC0xNTI5
LDEyICsxNTI5LDE0IEBAIHN0YXRpYyBpbnQgdGhlcm1hbF9wbV9ub3RpZnkoc3RydWN0DQo+ID4g
bm90aWZpZXJfYmxvY2sgKm5iLA0KPiA+ICAJY2FzZSBQTV9QT1NUX0hJQkVSTkFUSU9OOg0KPiA+
ICAJY2FzZSBQTV9QT1NUX1JFU1RPUkU6DQo+ID4gIAljYXNlIFBNX1BPU1RfU1VTUEVORDoNCj4g
PiArCQltdXRleF9sb2NrKCZ0aGVybWFsX2xpc3RfbG9jayk7DQo+ID4gIAkJYXRvbWljX3NldCgm
aW5fc3VzcGVuZCwgMCk7DQo+ID4gIAkJbGlzdF9mb3JfZWFjaF9lbnRyeSh0eiwgJnRoZXJtYWxf
dHpfbGlzdCwgbm9kZSkgew0KPiA+ICAJCQl0aGVybWFsX3pvbmVfZGV2aWNlX2luaXQodHopOw0K
PiA+ICAJCQl0aGVybWFsX3pvbmVfZGV2aWNlX3VwZGF0ZSh0eiwNCj4gPiAgCQkJCQkJICAgVEhF
Uk1BTF9FVkVOVF9VTlNQRUMNCj4gPiBJRklFRCk7DQo+ID4gIAkJfQ0KPiA+ICsJCW11dGV4X3Vu
bG9jaygmdGhlcm1hbF9saXN0X2xvY2spOw0KPiA+ICAJCWJyZWFrOw0KPiA+ICAJZGVmYXVsdDoN
Cj4gPiAgCQlicmVhazsNCg==
