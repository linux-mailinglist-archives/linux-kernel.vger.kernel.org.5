Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EE27D969A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345763AbjJ0L26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345735AbjJ0L2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:28:53 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7EA1B6;
        Fri, 27 Oct 2023 04:28:44 -0700 (PDT)
X-UUID: f971e2fa74bb11eea33bb35ae8d461a2-20231027
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=zTmwrXUjcPLWucza9yPjoN5DOgkNNxFrnx89ofoOgHc=;
        b=TwE8US6+zBSIgFH0k0dqTC8HhVduInOhTj7SQzq9RUlP0dWdaqn7ddshZwbXlz/xDWJVrfdRAVYQXZto4nAwmVVJmLTAjTOqiWRNnRBEj1IBLLWTt7/6ilfw5cY3MLjbfdMLm9YrDcsUuAj9Q4NWbLlvZQGyd2DVuz1J+RBQAiE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:f777d997-428f-480a-ae01-6df004056b9b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:b3dff871-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: f971e2fa74bb11eea33bb35ae8d461a2-20231027
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <lena.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 645001060; Fri, 27 Oct 2023 19:28:38 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 27 Oct 2023 19:28:35 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 27 Oct 2023 19:28:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWcKH2QOgUzEaharbNPLIj8HzPnpBlvSQF4xq6X8zE1IE84vMEhjrfpp72pzoFna1qYYoYw/dmg+IAO1KdKof1k8h9WQFg6Nr/HMIbnhegZy3R0b8HmMeKNfW+CSEhFJgnJUO4oncTT7OxwJl3Y+RLNRu6yiPEBIh+M6oEy7x8gJ2FpXa2SE2B2gk8Mk5goPkmvvdjAE4WOpSlnGp0ugwjNe+iYF3Lknx/EMFpAzm0xrDWLbzN25xwDCCDMcAGTphReOhEyG2JTqaitIQksuJ24zUyDF8dHEV/+6+nZQmiwxVnRUh39UI/LD/oHXI5KQkq99QopIbF+Y4XPgsbE/8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTmwrXUjcPLWucza9yPjoN5DOgkNNxFrnx89ofoOgHc=;
 b=QITYGafcgFpgfuayGgI9/EXr7NMR3yXf74Py6GCRuijflbDCpSQEM64H/E+J2C/+Ep5ZxBNWmKOA+Qf1hxBbbOClDJzvQrVcbX+8cSMO+y029R5asoD1drk9L5VdFNRO26tR2ArLr+p5WWnvVBLO/1pmR7cA0eA1CQ63ctzrD4vrpMyYNRL0kV3fyrmjExs1fGiPx0lfDOyEQLC3r4yeJu7UExveO9OVQmDcFv3aquwVSXoVs83+wuFWksUO9JVYBRuIH57WcJyJIX4ToLw1A3rpDjnWMK5jHxgnaf/xyPpwlqE2AdU8ssuCEFgxLdpCaJ11swYuaKpXdZR/krXKUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTmwrXUjcPLWucza9yPjoN5DOgkNNxFrnx89ofoOgHc=;
 b=s3/V/nJP+RdFk+lD2liuYMjDQuNXpyhUsnmWgMUkHDYP6pIg1chrTgweTT4mjhZXIEaovxPPS9pZXLqT3veiK1WdxbaLo7EDhafiUDCkozcBV02xlFbeLNP8aB79J6r9yIhserQrRkAOBxFi7bW3kyKZKzr+FsqYzmaFMkZ3ie4=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by JH0PR03MB7511.apcprd03.prod.outlook.com (2603:1096:990:14::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Fri, 27 Oct
 2023 11:28:32 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::d556:7c13:6e10:9a97]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::d556:7c13:6e10:9a97%4]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 11:28:32 +0000
From:   =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
To:     "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "maze@google.com" <maze@google.com>,
        "cmllamas@google.com" <cmllamas@google.com>
Subject: [PATCH net-next] net:prevent shared skb corruption on rx-gro-list
 segmentation
Thread-Topic: [PATCH net-next] net:prevent shared skb corruption on
 rx-gro-list segmentation
Thread-Index: AQHaCMi3juco6AiSCEKGZptWFr/Uog==
Date:   Fri, 27 Oct 2023 11:28:32 +0000
Message-ID: <a6f256694783a0692f2f079e7ac76ace621308c3.camel@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|JH0PR03MB7511:EE_
x-ms-office365-filtering-correlation-id: bca524a5-abe5-4a05-4537-08dbd6dfd9ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VhNsnD3I5IAqQPIIoMvlzvU3JHq7WQvqT4tauTecLOPonPuNq1l9Unpvj5aQ1QGQIPdlY4UsbjeeAec7faYq3tnp9tfLLvsCCfMBwyEI2GsET/uP5wee2WY+CSBztcoKZozZ1cPxAlV5Z6DoCOeM9R+JIhfgdo+QlxfNkSB4Y4G88Z6RtKyDknrbKzhj9UuFMRikgvucuZMcHzM/Yek5+QF7u+9vSHxWZF1cAalVwBvn0GAUxSXGfAyy7zlw8r61J2MDgNbgipF1Z/8ijFLI+c2rQs1DTjNnB8q2SER7sd7JBvLGYaoEGVKuMpVC5QhyOEhfDFKH4Zegpafwu2VNsV4mPaNC4Ubyko79GcbqIK60uL2926TPSDqNJtU97+GaCmisIkbKF/90kdxJIIA6HX4ekNp96AV+opqkQfv2QM3QRvb8DEskVw9hXf+PrXbdKAwAJzfVu03ItC9HeQ6F7velETc4vCr5WihbZC4Jg0ICyEuP6RsNUJKG3f2T2E8VrQVHcz3rGnbYQEznEcWrDk91RZMumv2hbly+/zGqlAy0J/623bpl924mOqFF48LJnih8kfX8N1ENbdeglSv06t9PYsSMEE9SlLoG1Ul8k5MDUc/F06Ndu/ZcJ7Yr6eQmbInFVIDEs/OPHyRE6kIcOdrCGE300s/5oSODk7+m4H4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(66476007)(26005)(2616005)(38070700009)(38100700002)(36756003)(122000001)(86362001)(85182001)(6512007)(83380400001)(66556008)(64756008)(8676002)(4326008)(8936002)(54906003)(6506007)(110136005)(91956017)(66946007)(41300700001)(5660300002)(7416002)(2906002)(316002)(71200400001)(66446008)(76116006)(53546011)(6486002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXEweWM2Zks1MG9nZ3JCdHpWNmRVdDU1dmYyMnphWWNzUTFjYWY1MGx1UDV6?=
 =?utf-8?B?YnFWcXYwSkw2VmxyRmxNNE9MVjhaa3MwdGFvdzJqNDFNVFBDRVBHaU9jR0Zh?=
 =?utf-8?B?aFR2VDhmNjNnUVR2SWV6dUpwUmlLWkVLNVdabEMwZXB5UG4zNExaSHluM3JU?=
 =?utf-8?B?VkpOTzFKc1lFVUV6VWxqeG9rcGtjTWlVd1BqTGxwVVc1MDlJUDJoZllMdld1?=
 =?utf-8?B?TEtQRXVhbjdyRGplaG1EbnZhbGNKVFRaTEdRV0ZRbS9ydU5STFhUQXJ2SHhS?=
 =?utf-8?B?VXZkQSsyR05ESWlSZTRVVDJ1RmhPcHRQcjhZWE9Mdk82Rk1GWjBiRlNKdm9Y?=
 =?utf-8?B?VVJnUnkveUo0TnBTNXJzc1p5SUtBSExLcVdkRWxWMTF6cmVQR2FkZlU4UkV2?=
 =?utf-8?B?THNnVnBUaGFCSGNRaGd1Rjg4V3NJYmZhd3REMG83MWF3ZDNiT1dNT3dtOE5K?=
 =?utf-8?B?Z09BUW5FK203MmJ5QXM3NGJCVTFua3g0YU1YSUQ0SnJ5Q0lvY2ZQU2FodU1t?=
 =?utf-8?B?OXQyVkx1T29UZ1pSMXJiaDFDTFZabDNscEgyb1UzTUJpU0swZWo0N2dLSkov?=
 =?utf-8?B?Y0FIQi80YithZlRwRjI5dVhoclBRekZVeFg4RGdyMWZTaG1JK1o1QWt4NmRv?=
 =?utf-8?B?UmJKeEU3WmFhUnBkYk9veHJ6b3kwM1FsOUpyamc2SmFudjRPYkprSHFTMW54?=
 =?utf-8?B?eVhjRmhXR3dVeHJrWWYxdTlTZDVRSU0yK2RIR2VwQ0F0NDNFY244NDN3V3Z4?=
 =?utf-8?B?ZVE2d2huQ0hMM0VqWmRHNW1EQkY5WWROblZEWmxlNy9ydHh1QWVDaFpkTkJC?=
 =?utf-8?B?ODFUd242Z1VGYVpNUW9RbVBUbnB2WkhyR1pGSzVQeW9BNHNBR0FtSlQ0NHFX?=
 =?utf-8?B?ekRaNENodG52YUdEcGdpdjFUWjRzWVZ0Tk1jdEdsZnBtQ25kTElaMVpJY1Qz?=
 =?utf-8?B?K0czMzVqZXR0em11aDBOMC9UOVZXblZmb1J4bVJEQmF4Ym0xb3ZuZVo4V3Zp?=
 =?utf-8?B?K3ViZlZ0OXVVU28yMjluaXZiY291djZDbzkxdm51S2RwTVhyNkFjb2NmRFBY?=
 =?utf-8?B?L3owUmlIMjljd2JRRzV3NkhKYWRmc3U2MGFXQU9LZm1pQUVQVnFyVW9pWm1i?=
 =?utf-8?B?S1JPOXE4Y2lqTjVzV0x0Wi9yWW0rVHVKK0ZxTEk0enJzV29GSVhYd1cweXZi?=
 =?utf-8?B?dlJwTUN2TDhPcXlzWjZFSDFIS3FyY3Z0TE4ydnZNSDZkNUFNMm5HTTVuclp0?=
 =?utf-8?B?Mms3c3lGL0p4cktIMUVLeW9iNndPTVYwekJGMi91RW9wR2U3QVNsMVZFRmFM?=
 =?utf-8?B?U2x1bW5rSUY2b0RERDhndWRNbWQrMUJDVmVUUWQwQ0lzeUtIcjBvTmJyNzdQ?=
 =?utf-8?B?TzJ4dW15eE5pSFpEcFd2V0J1bndpN285cjQwZk1odE5XZzJUeEdRcUVvUmlX?=
 =?utf-8?B?QWM3MU9RalR1S1duYXB6NzBTWVZqOWJqOG5aMTJ1elRmb0pGd1RrakhudlNT?=
 =?utf-8?B?eWp1M2FlYXNYMW9GdEVaeERHc1p2VWNDVEExRVBVcVZhTFlhdDd4OVoraTlo?=
 =?utf-8?B?MXdFMjdESVBDZkpzT0hEYmpuTVhtazdvK2paMS9ZREJ2a1B4VkRhTGljdVJM?=
 =?utf-8?B?QndFdVZJNWdmZllvWmdjWGRnbkVpYXZKVFlaM0FkNWNxWDY5RnhGWit5Skhz?=
 =?utf-8?B?dCs2MVVoM0pmRmJhMVo5NXZUaGtsZ3N0b2EzYTdWNmV1UWQxbW9VdWNEMlNk?=
 =?utf-8?B?S1dDWFYybkQrS1JQK3czdFRCQlZXS3RvQTd3MnRneFUwZGpaeFdpK1BlcjNh?=
 =?utf-8?B?QXk2Z1FIRzJ6OTRtR2pRQ1pkbXZJSzFWdE5Sbi8vMkI2VmR4U1pmUTY2aGRy?=
 =?utf-8?B?OFhLYnkxYVRvcHp1ZDAxUDBUZ01TNFdrYVBSa0RTTHdYdTRXOWgxc2JuK1NF?=
 =?utf-8?B?cFhlQ2NRWVVCVDIxSFZZL1BZdEpjUnV1eTd2N245b1llNVhnZkwvSVdjcWtK?=
 =?utf-8?B?ZVRrT3lsQ05Da1lEWDQwUUxoL1FNb00reDArZHFudHcyV1pFaGJ3bGtiejVk?=
 =?utf-8?B?V0Rxd3NJRnFGalJzN2tFREFCQ29MT3E2NVQwa1QwQlJaVFJhUW5WMzl5Q1VZ?=
 =?utf-8?B?bHRzcnNRUUZMaFVLMjBJUFRWVVI5YzA3bEZjQytQQzJveXFVbjE3WmNNajJl?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AD13706B34E3243B06346F5D8BB5B21@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bca524a5-abe5-4a05-4537-08dbd6dfd9ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 11:28:32.4829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pyaBh43CtcEZpA22em/vAk7CcqQoLOK79I80Pn3ImRp2X+u/lA5Dx98t5qpUReVn7ZDg9sKzPNWIkezzPzDCBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7511
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--11.273600-8.000000
X-TMASE-MatchedRID: SKbLpZM5T57rGF2YAiBufhn0UD4GU5Iq6I7Cfs2GijW1eX0jEQ9c6j5u
        F8U3iZbPxhNmTkc2QakQzB2LH5qdIHAvdl/gU+kWyeVujmXuYYUhpWQUitAWG8A0eOJZYj7t+a/
        zdHOJ3WnkizndBEr04f5ea+rBmZ5JqMLr8w1TE6hQiFNNqFvt1YiSXIsyDf91MG+k7K2p8r/Hb3
        5aKn1Q4U4kHnA/WiqE1ODNrcSmC/IfLZjRGBdfQZ7tR0mnRAg1Wmr/8mnjMG7VMpDytURQKH1Xi
        rrq3Fh2fggDbY7vGPrKD20ZIof5hbrHOg4kwG3xplK4KT+wlsx/r8x3wtvaX43EVvTKniavA9qj
        I0r4m/drefdokZpqBID0SK8dS6vPhyg/LteTqKeeAiCmPx4NwMFrpUbb72MUGtkvK5L7RXEXvQk
        Gi3tjz/cUt5lc1lLgoGRyAacnhaa/1IRjkFXuT3jJ9OkL+F8ZyT7H4VZK27HvZX05Pm8yjX7cGd
        19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.273600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: CD63BED8D821E2848EE65AAA59DFCE7DC269D3AB3DD10A8E5C78AA464740D3462000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbSAxZDRhZWE4NDZkZDA4ZDgyNGUxMDk3YTkzM2VkODYxOGE2ZGEwM2RhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogbGVuYSB3YW5nIDxsZW5hLndhbmdAbWVkaWF0ZWsuY29tPg0K
RGF0ZTogRnJpLCAyNyBPY3QgMjAyMyAxNzo1Mjo1MCArMDgwMA0KU3ViamVjdDogW1BBVENIIG5l
dC1uZXh0XSBuZXQ6cHJldmVudCBzaGFyZWQgc2tiIGNvcnJ1cHRpb24gb24gcngtZ3JvLQ0KbGlz
dCBzZWdtZW50YXRpb24NCg0Kc2hhcmVkIHNrYiB0cmlnZ2VycyBjb3JydXB0aW9ucyBvbiByeC1n
cm8tbGlzdCBzZWdtZW50YXRpb24uDQoNCls0MjQzOC43NDk0NzRdIFsgVDE0MjVdIFVuYWJsZSB0
byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlcg0KZGVyZWZlcmVuY2UgYXQgdmlydHVhbCBhZGRy
ZXNzIDAwMDAwMDAwMDAwMDAwZDgNCls0MjQzOC43NDk1MzBdIFsgVDE0MjVdIE1lbSBhYm9ydCBp
bmZvOg0KWzQyNDM4Ljc0OTU0N10gWyBUMTQyNV0gICBFU1IgPSAweDAwMDAwMDAwOTYwMDAwMDYN
Cls0MjQzOC43NDk1NjZdIFsgVDE0MjVdICAgRUMgPSAweDI1OiBEQUJUIChjdXJyZW50IEVMKSwg
SUwgPSAzMiBiaXRzDQpbNDI0MzguNzQ5NTg4XSBbIFQxNDI1XSAgIFNFVCA9IDAsIEZuViA9IDAN
Cls0MjQzOC43NDk2MDZdIFsgVDE0MjVdICAgRUEgPSAwLCBTMVBUVyA9IDANCls0MjQzOC43NDk2
MjNdIFsgVDE0MjVdICAgRlNDID0gMHgwNjogbGV2ZWwgMiB0cmFuc2xhdGlvbiBmYXVsdA0KWzQy
NDM4Ljc0OTY0Ml0gWyBUMTQyNV0gRGF0YSBhYm9ydCBpbmZvOg0KWzQyNDM4Ljc0OTY1Nl0gWyBU
MTQyNV0gICBJU1YgPSAwLCBJU1MgPSAweDAwMDAwMDA2DQpbNDI0MzguNzQ5Njc0XSBbIFQxNDI1
XSAgIENNID0gMCwgV25SID0gMA0KWzQyNDM4Ljc0OTY5MV0gWyBUMTQyNV0gdXNlciBwZ3RhYmxl
OiA0ayBwYWdlcywgMzktYml0IFZBcywNCnBnZHA9MDAwMDAwMDFmOTZiOTAwMA0KWzQyNDM4Ljc0
OTcxNF0gWyBUMTQyNV0gWzAwMDAwMDAwMDAwMDAwZDhdIHBnZD0wODAwMDAwMWY5NmJhMDAzLA0K
cDRkPTA4MDAwMDAxZjk2YmEwMDMsIHB1ZD0wODAwMDAwMWY5NmJhMDAzLCBwbWQ9MDAwMDAwMDAw
MDAwMDAwMA0KWzQyNDM4Ljc0OTc2OV0gWyBUMTQyNV0gSW50ZXJuYWwgZXJyb3I6IE9vcHM6IDAw
MDAwMDAwOTYwMDAwMDYgWyMxXQ0KUFJFRU1QVCBTTVANCls0MjQzOC43NDk3OTZdIFsgVDE0MjVd
IGNwdWZyZXEgc3RvcCBEVkZTIGxvZyBkb25lDQpbNDI0MzguNzk3MTQ0XSBbIFQxNDI1XSBLZXJu
ZWwgT2Zmc2V0OiAweDI5ZWIwMDAwMDAgZnJvbQ0KMHhmZmZmZmZjMDA4MDAwMDAwDQpbNDI0Mzgu
Nzk3MTg1XSBbIFQxNDI1XSBQSFlTX09GRlNFVDogMHg0MDAwMDAwMA0KWzQyNDM4Ljc5NzIwM10g
WyBUMTQyNV0gcHN0YXRlOiA4MDQwMDAwNSAoTnpjdiBkYWlmICtQQU4gLVVBTykNCls0MjQzOC43
OTcyMTldIFsgVDE0MjVdIHBjIDogWzB4ZmZmZmZmZTlmM2UzOGMzNF0NCl9fdWRwX2dzb19zZWdt
ZW50KzB4MjRjLzB4NDhjDQpbNDI0MzguNzk3MjQ4XSBbIFQxNDI1XSBsciA6IFsweGZmZmZmZmU5
ZjNlMzhiZjRdDQpfX3VkcF9nc29fc2VnbWVudCsweDIwYy8weDQ4Yw0KWzQyNDM4Ljc5NzI2OV0g
WyBUMTQyNV0gc3AgOiBmZmZmZmZjMDE3YWNiNWMwDQpbNDI0MzguNzk3MjgwXSBbIFQxNDI1XSB4
Mjk6IGZmZmZmZmMwMTdhY2I1ZDAgeDI4OiAwMDAwMDAwMDAwMDBjODVmDQouLi4uLi4NCls0MjQz
OC43OTkxNzJdIFsgVDE0MjVdIENhbGwgdHJhY2U6DQpbNDI0MzguNzk5MTg0XSBbIFQxNDI1XSAg
ZHVtcF9iYWNrdHJhY2UrMHhmNC8weDExOA0KWzQyNDM4Ljc5OTIxMF0gWyBUMTQyNV0gIHNob3df
c3RhY2srMHgxOC8weDI0DQpbNDI0MzguNzk5MjI3XSBbIFQxNDI1XSAgZHVtcF9zdGFja19sdmwr
MHg2MC8weDdjDQpbNDI0MzguNzk5MjUwXSBbIFQxNDI1XSAgZHVtcF9zdGFjaysweDE4LzB4M2MN
Cls0MjQzOC43OTkyNzBdIFsgVDE0MjVdICBtcmR1bXBfY29tbW9uX2RpZSsweDI0Yy8weDM5OCBb
bXJkdW1wXQ0KWzQyNDM4Ljc5OTM1NF0gWyBUMTQyNV0gIGlwYW5pY19kaWUrMHgyMC8weDM0IFtt
cmR1bXBdDQpbNDI0MzguNzk5NDI1XSBbIFQxNDI1XSAgbm90aWZ5X2RpZSsweDgwLzB4ZDgNCls0
MjQzOC43OTk0NDddIFsgVDE0MjVdICBkaWUrMHg5NC8weDJiOA0KWzQyNDM4Ljc5OTQ2M10gWyBU
MTQyNV0gIF9fZG9fa2VybmVsX2ZhdWx0KzB4MjY0LzB4Mjk4DQpbNDI0MzguNzk5NDg1XSBbIFQx
NDI1XSAgZG9fcGFnZV9mYXVsdCsweDk4LzB4NGEwDQpbNDI0MzguNzk5NTAzXSBbIFQxNDI1XSAg
ZG9fdHJhbnNsYXRpb25fZmF1bHQrMHgzOC8weDU0DQpbNDI0MzguNzk5NTIxXSBbIFQxNDI1XSAg
ZG9fbWVtX2Fib3J0KzB4NTgvMHgxMTgNCls0MjQzOC43OTk1NDBdIFsgVDE0MjVdICBlbDFfYWJv
cnQrMHgzYy8weDVjDQpbNDI0MzguNzk5NTU1XSBbIFQxNDI1XSAgZWwxaF82NF9zeW5jX2hhbmRs
ZXIrMHg1NC8weDkwDQpbNDI0MzguNzk5NTc1XSBbIFQxNDI1XSAgZWwxaF82NF9zeW5jKzB4Njgv
MHg2Yw0KWzQyNDM4Ljc5OTU5MV0gWyBUMTQyNV0gIF9fdWRwX2dzb19zZWdtZW50KzB4MjRjLzB4
NDhjDQpbNDI0MzguNzk5NjExXSBbIFQxNDI1XSAgdWRwNF91Zm9fZnJhZ21lbnQrMHgxMTgvMHgx
NWMNCls0MjQzOC43OTk2MjhdIFsgVDE0MjVdICBpbmV0X2dzb19zZWdtZW50KzB4MTY0LzB4MzM4
DQpbNDI0MzguNzk5NjQ0XSBbIFQxNDI1XSAgc2tiX21hY19nc29fc2VnbWVudCsweGM0LzB4MTNj
DQpbNDI0MzguNzk5NjY2XSBbIFQxNDI1XSAgX19za2JfZ3NvX3NlZ21lbnQrMHhjNC8weDEyNA0K
WzQyNDM4Ljc5OTY4Nl0gWyBUMTQyNV0gIHZhbGlkYXRlX3htaXRfc2tiKzB4OWMvMHgyZTANCls0
MjQzOC43OTk3MDNdIFsgVDE0MjVdICB2YWxpZGF0ZV94bWl0X3NrYl9saXN0KzB4NGMvMHg4MA0K
WzQyNDM4Ljc5OTcyMl0gWyBUMTQyNV0gIHNjaF9kaXJlY3RfeG1pdCsweDcwLzB4M2QwDQpbNDI0
MzguNzk5NzM5XSBbIFQxNDI1XSAgX19kZXZfcXVldWVfeG1pdCsweDVmMC8weGQ0MA0KWzQyNDM4
Ljc5OTc1N10gWyBUMTQyNV0gIGlwX2ZpbmlzaF9vdXRwdXQyKzB4M2Y4LzB4NDYwDQpbNDI0Mzgu
Nzk5Nzc0XSBbIFQxNDI1XSAgX19pcF9maW5pc2hfb3V0cHV0KzB4MTk0LzB4MjQwDQpbNDI0Mzgu
Nzk5NzkwXSBbIFQxNDI1XSAgaXBfZmluaXNoX291dHB1dCsweDIwLzB4ZjQNCls0MjQzOC43OTk4
MTBdIFsgVDE0MjVdICBpcF9vdXRwdXQrMHgxMDAvMHgxYTANCls0MjQzOC43OTk4MzBdIFsgVDE0
MjVdICBORl9IT09LKzB4YWMvMHgxNTQNCls0MjQzOC43OTk4NDhdIFsgVDE0MjVdICBpcF9mb3J3
YXJkKzB4MzA4LzB4MzIwDQpbNDI0MzguNzk5ODY4XSBbIFQxNDI1XSAgaXBfc3VibGlzdF9yY3Yr
MHgxZjAvMHgyNWMNCls0MjQzOC43OTk4ODddIFsgVDE0MjVdICBpcF9saXN0X3JjdisweDEzOC8w
eDE3NA0KWzQyNDM4Ljc5OTkwNV0gWyBUMTQyNV0gIF9fbmV0aWZfcmVjZWl2ZV9za2JfbGlzdF9j
b3JlKzB4MWU4LzB4MjhjDQpbNDI0MzguNzk5OTIzXSBbIFQxNDI1XSAgbmV0aWZfcmVjZWl2ZV9z
a2JfbGlzdF9pbnRlcm5hbCsweDFlYy8weDJiNA0KWzQyNDM4Ljc5OTk0Ml0gWyBUMTQyNV0gIG5l
dGlmX3JlY2VpdmVfc2tiX2xpc3QrMHgyYy8weDE0NA0KWzQyNDM4Ljc5OTk2MF0gWyBUMTQyNV0g
IGNjbW5pX3F1ZXVlX3N0YXRlX2NhbGxiYWNrKzB4OTgvMHgzMDQgW2NjbW5pXQ0KWzQyNDM4Ljgw
MDAwOV0gWyBUMTQyNV0gIHBvcnRfbmV0X3F1ZXVlX3N0YXRlX25vdGlmeSsweDE3OC8weDFjMA0K
W2NjY2lfbWRfYWxsXQ0KWzQyNDM4LjgwMDI1N10gWyBUMTQyNV0gIGNjY2lfcG9ydF9xdWV1ZV9z
dGF0dXNfbm90aWZ5KzB4ZjAvMHgyYTgNCltjY2NpX21kX2FsbF0NCls0MjQzOC44MDA0OTZdIFsg
VDE0MjVdICBkcG1haWZfcnhxX3B1c2hfdGhyZWFkKzB4YjAvMHgxZDQNCltjY2NpX2RwbWFpZl0N
Cls0MjQzOC44MDA2MDJdIFsgVDE0MjVdICBrdGhyZWFkKzB4MTA0LzB4MWQ0DQpbNDI0MzguODAw
NjIxXSBbIFQxNDI1XSAgcmV0X2Zyb21fZm9yaysweDEwLzB4MjANCg0KSW4gc29tZSBzY2VuYXJp
b3MgdGhlIEdSTy1lZCBza2Igc2hhcmVkIHdpdGggbXVsdGkgdXNlcnMuIFRoaXMNCnNlZ21lbnRh
dGlvbiB0b3VjaGVzIHRoZSBzaGFyZWQgaGVhZHMgd2hpY2ggc2V0cyBmcmFnX2xpc3QgdG8gbnVs
bC4NCkFmdGVyIGxpbmVhcml6YXRpb24gdGhlIHNrYi0+bmV4dCBpcyBudWxsIHdoaWNoIHJlc3Vs
dHMgdGhlIGNvcnJ1cHRpb24uDQoNClNvIGZvciBzaGFyZWQgc2tiLCBpdCBuZWVkcyB0byBjbG9u
ZSBmaXJzdCB0aGFuIHVuY2xvbmUgd2l0aCBoZWFkZXIgYW5kDQpkYXRhIHNlcGFyYXRlZCBmb3Ig
ZGlmZmVyZW50IGRldmljZXMuDQoNClNpZ25lZC1vZmYtYnk6IGxlbmEgd2FuZyA8bGVuYS53YW5n
QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIG5ldC9jb3JlL3NrYnVmZi5jIHwgNiArKysrKysNCiAxIGZp
bGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9uZXQvY29yZS9za2J1
ZmYuYyBiL25ldC9jb3JlL3NrYnVmZi5jDQppbmRleCBiMTU3ZWZlYTVkZWEuLmFkZWIzYWQ5Njk3
YiAxMDA2NDQNCi0tLSBhL25ldC9jb3JlL3NrYnVmZi5jDQorKysgYi9uZXQvY29yZS9za2J1ZmYu
Yw0KQEAgLTQzNTEsNiArNDM1MSwxMiBAQCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiX3NlZ21lbnRfbGlz
dChzdHJ1Y3Qgc2tfYnVmZg0KKnNrYiwNCiANCiAJc2tiX3B1c2goc2tiLCAtc2tiX25ldHdvcmtf
b2Zmc2V0KHNrYikgKyBvZmZzZXQpOw0KIA0KKwlpZiAoc2tiX3NoYXJlZChza2IpKSB7DQorCQlz
a2IgPSBza2Jfc2hhcmVfY2hlY2soc2tiLCBHRlBfQVRPTUlDKTsNCisJCWlmICghc2tiKQ0KKwkJ
CWdvdG8gZXJyX2xpbmVhcml6ZTsNCisJfQ0KKw0KIAkvKiBFbnN1cmUgdGhlIGhlYWQgaXMgd3Jp
dGVhYmxlIGJlZm9yZSB0b3VjaGluZyB0aGUgc2hhcmVkIGluZm8NCiovDQogCWVyciA9IHNrYl91
bmNsb25lKHNrYiwgR0ZQX0FUT01JQyk7DQogCWlmIChlcnIpDQotLSANCjIuMTguMA0K
