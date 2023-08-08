Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17A8773B78
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 17:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjHHPvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 11:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHHPti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:49:38 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ECC49F7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:42:09 -0700 (PDT)
X-UUID: 282a345835c911eeb20a276fd37b9834-20230808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=xO79R5rnOTestYuLz2xOml1FKRnzqjxw+4xg6OmQi8Q=;
        b=oHOgvodlo0oc4+APa+8sJXhLWpSxRdElKydlKsIZe9GMq+ZqbFLf3kjmH5/B3/hx8BDi6J/ssrFJb/4+1x8G1LWkg/Jt8sf6saGLXVoVLddK8L6tqGptCULWO+ZF1IeDuyg/Bpt2JydzM0ZdLB8DG+6DJM8fpmV3oCodGn81Dp0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:69c88141-b841-4395-bd29-48d11b94c3c4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:73
X-CID-INFO: VERSION:1.1.31,REQID:69c88141-b841-4395-bd29-48d11b94c3c4,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:73
X-CID-META: VersionHash:0ad78a4,CLOUDID:5a9f04a1-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:230807165914VND9HJNH,BulkQuantity:27,Recheck:0,SF:38|29|28|17|19|48|
        102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:ni
        l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_OBB,TF_CID_SPAM_FCD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,
        TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 282a345835c911eeb20a276fd37b9834-20230808
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 905032135; Tue, 08 Aug 2023 16:54:17 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 8 Aug 2023 16:54:16 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 8 Aug 2023 16:54:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0J2BLyn8KL8c2M2J8Ogzq8pHt6bPnMHlV4+aicBhF0r4knGzciDjpj61WlVQ3XlcuXeUWpDK42c3etgUqAXGs7mD9DeE9V89DXZmKioQJ8jX7phiZlRwry3EMmv/bAr/Zr0w7DLeL6ml8mBMCHhWKdTPNEKClWUEHFP1p81rwLx35LfmDg3EQBMvblxz+RP5OIxkKKT66sNOQJuJgNyNggHlt83p6VZyui52l53U0w1b+23RHLl0QGNoIlBiAtUw0h3gJULMR7TsFqFACoRznl43P/sytIdiojiOlQt+/K8FEP8PVvZa56m4z2q9kvOaC9YKHwcSX9qpOc7GCwYLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xO79R5rnOTestYuLz2xOml1FKRnzqjxw+4xg6OmQi8Q=;
 b=St8PHbNAoaEXtUIIW+3thq+D30yBL7pYTrSTW1vQP2Sipfd4DhEVP559Is3jVMQbsP1msA49IuWHbjtOtnH1td1D/42l1eT0bgeXjlucqXNveqVoVdb7WEWmRBgbXVPdWkO4OKCvBFa9Ep8Z7PfyUMlmt4mGDoCE4yZgBkNmgvEG+H9rBctlC0RRvVdOipurR3UShHryA1rTPXuj8PE17nBpCt02x8zgfXqsMVRVvPbkav3GXZy9JSCFktpMGCuLd/zhQiuHVTYTfVHSSr0lazPA5YFY24LQ4MIpyLZMy+ZaxZ5g0k9RnH5HInn5ldn7C88EQwCO6dDX2VeVnsSeZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xO79R5rnOTestYuLz2xOml1FKRnzqjxw+4xg6OmQi8Q=;
 b=eX2snbSJsuka66CswmXVLSpoWPc3gQbYXSqjJ4dfSiBIZj09WJ3Q3eRf0HcJwBFchirXS9wFRP4QJ2obZBJ31bYBaIvDRr95Rab/a0c74sWKfMZ6sr0NjOUNk8sLr8J8zQkL5SXFUU+MVHgr5sP3mAnogUyQt4P7L8ekN9tvDtI=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYSPR03MB8046.apcprd03.prod.outlook.com (2603:1096:400:472::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 08:54:14 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 08:54:13 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RESEND v4 2/2] drm/mediatek: Fix iommu fault during crtc
 enabling
Thread-Topic: [PATCH RESEND v4 2/2] drm/mediatek: Fix iommu fault during crtc
 enabling
Thread-Index: AQHZyNG+FsizTgWRg0G/DVBCFYkp76/eiTeAgAGQ8gA=
Date:   Tue, 8 Aug 2023 08:54:13 +0000
Message-ID: <564fbfd873adf42e33eff6110f7ee499531e6887.camel@mediatek.com>
References: <20230807015110.30579-1-jason-jh.lin@mediatek.com>
         <20230807015110.30579-3-jason-jh.lin@mediatek.com>
         <10c997127b0d6aa4c94b455f35d2429445d1d31d.camel@mediatek.com>
In-Reply-To: <10c997127b0d6aa4c94b455f35d2429445d1d31d.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYSPR03MB8046:EE_
x-ms-office365-filtering-correlation-id: 4a59b5cc-a71f-4509-aefe-08db97ed0a3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EZCOcjaemCdo3jco7L7Ac8iYhsvTSlEUHNiAieMxG0h/9aKZ4ljgX7zKkx9QMhq4z+ppR+PWMZxq3pHjX47Xd8etmiwFQ0HGmqTYllgxThiIrQXNIRf7vYViH/4rXMwmIHEMtMTiWpiWI7CR7/V+IAH5bZuyeC5sKMLD9l9JTymjX2YyEvCN8qkWm/P+D8vTC6cLPto4GKI/6ynBnxUsQ5hqWWxH/3OMj/fm9QvBzxZ7kq+vvHHs2EmK8j3PIrfcmLPFF1XMQKYBJCY4JZWt7HeljfMGIdJaIQn1UoSq6HniaOFvo9oYnZCrXKwvOzKqV0rfPm7AFGPv44c0oXaQ2K/o9dG9E1ewUAw3zvpj9gpAEtICoQqoD9IKfctKUCe5dSnvPLcMAc61gK2hwsXUY0yjnvxH/aKFytXIiiYfj81rpGga0yY2zrSlFMGS6f0SJqb0DGDjR0odjkjHqdPVsGTnDO3livRVUyYSrLlEhpQt4uJMp4rvwKYLpOmMFMv3/8rY3EMmW4DyxLiW4QQATCgmsN3zx9qdbk+6js8AMC3BIDslJMYg3nd2G8pOwI9msSe/wgPjiboWsL4h2loAgbyoamhG6TbVK3SMQshba+aLabAuzX1TN0wREJJawpvYCBni/UM4LZjKBj1YwUuD4bt5kX4WENqdcSbGXrLOPzs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(39860400002)(136003)(396003)(186006)(1800799003)(451199021)(71200400001)(64756008)(6486002)(6512007)(478600001)(110136005)(54906003)(4326008)(316002)(38070700005)(86362001)(66476007)(41300700001)(66446008)(38100700002)(122000001)(76116006)(66946007)(91956017)(66556008)(83380400001)(2616005)(26005)(6506007)(85182001)(36756003)(2906002)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QitCemdJaDZiZ1BsZElNUDI3QWFCb3ovU2doNE5LYmFFV1pQQ1kvMVhwbkRY?=
 =?utf-8?B?MkRvbmhUMTREOFhNWUQ5K1ZyeHVXekNlQ00zbHBpc1NXekZVZC81SlJhaUNT?=
 =?utf-8?B?RE5TcUFEQ2krTGM3dSs3TkNHbStueU5oZTVXenBaTWUvaThxTk5OcXNPbFFS?=
 =?utf-8?B?T1FvQnlmOXRvSEp0WlhTNTY2eHpUVG1qKy9nSko0TlRLaUxaZ0IraEZ3amZP?=
 =?utf-8?B?WUpTcFRteTJadnZZbkFCN0RMYU1ETnBxcTZ0djh4U1BnOWN0NkRXb3dnUTdX?=
 =?utf-8?B?UitWNkFqLzdzNzl4OCs3TVVTRG9IK3FhMVVMK2xaOVN1NlUwYkxwczEzUjdw?=
 =?utf-8?B?WUtaVjdHTE0zdHRBMzJPNUovZlJwR084QnBQTGQzSkhkaERmektxNnI2bCtj?=
 =?utf-8?B?Umd1RitOeDBLU3U1WDQ3NWFzSmFhUlZjcC9jMnFYS1BBR0JTVTBScmlseTNx?=
 =?utf-8?B?ajZERTZLVksrVWVjWTJLYXd2NWdPOGh4MWhoWXhHVndpLzhwenkwbDV3Y2dO?=
 =?utf-8?B?MTh6cnhNSlBJRmhOUEVEQXgwdUlhVzN2K0x3ZTZCdkVTNnpHV1RHQ1JScW55?=
 =?utf-8?B?MmwzYkxxS21vN05ic3V1R2djbGk1d2NmaTEwcDloOWtDeHpwanUrUmwrOXNN?=
 =?utf-8?B?TWNLZGRVYTJDRzg0cmFFUzVhMnZ2UjZJNG5FQjRoWXBDL29iZnhNTVJONnJw?=
 =?utf-8?B?WVJqRWpycGNpMkpGMDgzTzl5Zi84MXUwQmlzRXQ0bTM0cE5sUDUzSVlBc1NW?=
 =?utf-8?B?dFJmUXpSMmJnY0dtcUVJTmRuTUJEd1JMOHFWZjEwaWc3V285akRGdkJvS1Yw?=
 =?utf-8?B?WDhmeW9uVWNqSkw5UHhyUE80UFRXN1ZtL0hhOFNOcmF4S2RsUkJZTzM4VHFt?=
 =?utf-8?B?QW9WMVcxZVYxZWxGRGdMbFd0Q0hZcFVkc0QzTE5qR3RUN011THFzM1pDcTFQ?=
 =?utf-8?B?bjVyN2FXMkd2cDIzQnRoT2pUZjQ0ZzNlOVpiaSswbktYU2VFb1VLcFJxWWdG?=
 =?utf-8?B?dXRtQjQ0NmZBYzhzaTRjRWxMdzJUdmM2cXJTd2lLUXVVU2RHb3c5QTh1Zmtv?=
 =?utf-8?B?TlJ1UlRTc1BBbml5NlVzd3BPdmZISUZ2VE92SG1PUzhvZkRJMGordEpwc3lS?=
 =?utf-8?B?TXRGREpEL1hrS0loWUFBZkloUTRaUlEvVXJvelNiNWRZVG1oS0RNMGdHMTJ1?=
 =?utf-8?B?OTQ3elZpTFJPcmVja2JXS0hHck1tVnFUcjFxSnhWQ2NPSXZYYytMZlpDNFU1?=
 =?utf-8?B?WUF6QXNSNG9IMmd1YUZtLzZVVy9UYVcyYkxkWkw1YnlkZG9heldpODRTSUM1?=
 =?utf-8?B?clBQTTZScEtLaEo3VkxzUE5yTEQ4VFhNQ0V0N3JxaVNkajg2QmhHYWRlUXdh?=
 =?utf-8?B?OUNCczFMRFRpS3M2RGd1ck9Ka0s4dm9LVjI4WDJtNFp5YVlXL2YyaWJ5T1NX?=
 =?utf-8?B?NjRBMkZEdGlGb1NMUG10SzJob2dTcFd4NGRacnBhcW93VkM4MWI1Z2I1dzVO?=
 =?utf-8?B?QW1aUTJUeUMxOEZHUWQzR2k4N3ZtQk15bTdyd2xGakdha1Z5NUdoR2xTYnJS?=
 =?utf-8?B?ZElTd3Q1YlJMcit1VWtpWG5xQk9BZU9jZE1wOVBSTVRDMWhDbjlOUFVtZHBj?=
 =?utf-8?B?STJhdUR5c2xncnhKclFUWk4zeEVWbWYvSjVSc2l0Rjh3R3VyWm9LakxiTFFz?=
 =?utf-8?B?RUFUcWdBOWVnUjc3aHJjOXVzMWlMZXFVdGNNcU45TVRzVC9NUldQMnZTWHZU?=
 =?utf-8?B?bE9SZ081Mk1aY0t4b3lCcmVUMDdidWdOcE1wT1l2NUhuNVZaelphUzV1emtZ?=
 =?utf-8?B?Q2M4VEM4cFV1LzZMT2x1ZjdBcDZPeUdLY3JBSXkxZWc2elRpNmdYRmxaUGto?=
 =?utf-8?B?ZzZNZG1LWmxWN2JMVTBwakMyRm9IWVNnQ0llTVBwWTkwcVFKNVo2TDZDbDBI?=
 =?utf-8?B?Wm1FeU9mNzNseGRobER1d0kvcjJzSTg0bmxqUVdQcEE3bGhwV1RBdTlmdml1?=
 =?utf-8?B?cHVFUVgxUEpxZHlLU2lMaktXYnhlZzVqMlU3NkQwVnd6YjB4dWx6bG1DKzdK?=
 =?utf-8?B?WkgyekN4UHBiK3pDaVZOZmRubGxJbEdablB4WkZKcFJUbnlOQnRZQU5YWm1z?=
 =?utf-8?B?NEVLWjJlQVJqTWF5OWtwNFNKT3IzYWFwN1BVaThjbEp5cE44MHlJalV2V0VR?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8929C0697CE92B44BE7D307D6A351880@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a59b5cc-a71f-4509-aefe-08db97ed0a3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 08:54:13.7585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hBKx8Enr9BKvYIfgyexUhj+rOP89uyvB2qrAB2bTCNjJEHo+rYTP0MV7giL4+5rk1M53CvAqaWECMez4K1z2CGP2gpiuLwcRrxQN8k/yqRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8046
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNCk9uIE1vbiwgMjAyMy0wOC0wNyBhdCAwODo1OSArMDAwMCwgQ0sgSHUgKOiDoeS/
iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4gDQo+IE9uIE1vbiwgMjAyMy0wOC0wNyBhdCAw
OTo1MSArMDgwMCwgSmFzb24tSkguTGluIHdyb3RlOg0KPiA+IFRoZSBwbGFuZV9zdGF0ZSBvZiBk
cm1fYXRvbWljX3N0YXRlIGlzIG5vdCBzeW5jIHRvIHRoZQ0KPiA+IG10a19wbGFuZV9zdGF0ZQ0K
PiA+IHN0b3JlZCBpbiBtdGtfY3J0YyBkdXJpbmcgY3J0YyBlbmFibGluZy4NCj4gPiANCj4gPiBT
byB3ZSBuZWVkIHRvIHVwZGF0ZSB0aGUgbXRrX3BsYW5lX3N0YXRlIHN0b3JlZCBpbiBtdGtfY3J0
YyBieSB0aGUNCj4gPiBkcm1fYXRvbWljX3N0YXRlIGNhcnJpZWQgZnJvbSBtdGtfZHJtX2NydGNf
YXRvbWljX2VuYWJsZSgpLg0KPiA+IA0KPiA+IFdoaWxlIHVwZGF0aW5nIG10a19wbGFuZV9zdGF0
ZSwgT1ZMIGxheWVyIHNob3VsZCBiZSBkaXNhYmxlZCB3aGVuDQo+ID4gdGhlDQo+ID4gZmINCj4g
PiBpbiBwbGFuZV9zdGF0ZSBvZiBkcm1fYXRvbWljX3N0YXRlIGlzIE5VTEwuDQo+ID4gDQo+ID4g
Rml4ZXM6IDExOWY1MTczNjI4YSAoImRybS9tZWRpYXRlazogQWRkIERSTSBEcml2ZXIgZm9yIE1l
ZGlhdGVrIFNvQw0KPiA+IE1UODE3My4iKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxp
biA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2UgaW4gUkVT
RU5EIHY0Og0KPiA+IFJlbW92ZSByZWR1bmRhbnQgcGxhbmVfc3RhdGUgYXNzaWduaW5nLg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgIHwgMTQg
KysrKysrKysrKy0tLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxh
bmUuYyB8IDExICsrKysrKysrLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX3BsYW5lLmggfCAgMiArKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMo
KyksIDcgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fY3J0Yy5jDQo+ID4gaW5kZXggZDQwMTQyODQyZjg1Li43ZGI0ZDY1NTFkYTcgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+
ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gQEAg
LTMyOCw3ICszMjgsNyBAQCBzdGF0aWMgdm9pZCBkZHBfY21kcV9jYihzdHJ1Y3QgbWJveF9jbGll
bnQgKmNsLA0KPiA+IHZvaWQgKm1zc2cpDQo+ID4gIH0NCj4gPiAgI2VuZGlmDQo+ID4gIA0KPiA+
IC1zdGF0aWMgaW50IG10a19jcnRjX2RkcF9od19pbml0KHN0cnVjdCBtdGtfZHJtX2NydGMgKm10
a19jcnRjKQ0KPiA+ICtzdGF0aWMgaW50IG10a19jcnRjX2RkcF9od19pbml0KHN0cnVjdCBtdGtf
ZHJtX2NydGMgKm10a19jcnRjLA0KPiA+IHN0cnVjdCBkcm1fYXRvbWljX3N0YXRlICpzdGF0ZSkN
Cj4gPiAgew0KPiA+ICAJc3RydWN0IGRybV9jcnRjICpjcnRjID0gJm10a19jcnRjLT5iYXNlOw0K
PiA+ICAJc3RydWN0IGRybV9jb25uZWN0b3IgKmNvbm5lY3RvcjsNCj4gPiBAQCAtNDA1LDExICs0
MDUsMTcgQEAgc3RhdGljIGludCBtdGtfY3J0Y19kZHBfaHdfaW5pdChzdHJ1Y3QNCj4gPiBtdGtf
ZHJtX2NydGMgKm10a19jcnRjKQ0KPiA+ICAJLyogSW5pdGlhbGx5IGNvbmZpZ3VyZSBhbGwgcGxh
bmVzICovDQo+ID4gIAlmb3IgKGkgPSAwOyBpIDwgbXRrX2NydGMtPmxheWVyX25yOyBpKyspIHsN
Cj4gPiAgCQlzdHJ1Y3QgZHJtX3BsYW5lICpwbGFuZSA9ICZtdGtfY3J0Yy0+cGxhbmVzW2ldOw0K
PiA+IC0JCXN0cnVjdCBtdGtfcGxhbmVfc3RhdGUgKnBsYW5lX3N0YXRlOw0KPiA+ICsJCXN0cnVj
dCBkcm1fcGxhbmVfc3RhdGUgKm5ld19zdGF0ZTsNCj4gPiArCQlzdHJ1Y3QgbXRrX3BsYW5lX3N0
YXRlICpwbGFuZV9zdGF0ZSA9DQo+ID4gdG9fbXRrX3BsYW5lX3N0YXRlKHBsYW5lLT5zdGF0ZSk7
DQo+ID4gIAkJc3RydWN0IG10a19kZHBfY29tcCAqY29tcDsNCj4gPiAgCQl1bnNpZ25lZCBpbnQg
bG9jYWxfbGF5ZXI7DQo+ID4gIA0KPiA+IC0JCXBsYW5lX3N0YXRlID0gdG9fbXRrX3BsYW5lX3N0
YXRlKHBsYW5lLT5zdGF0ZSk7DQo+ID4gKwkJLyogc3luYyB0aGUgbmV3IHBsYW5lIHN0YXRlIGZy
b20gZHJtX2F0b21pY19zdGF0ZSAqLw0KPiA+ICsJCWlmIChzdGF0ZS0+cGxhbmVzW2ldLnB0cikg
ew0KPiA+ICsJCQluZXdfc3RhdGUgPQ0KPiA+IGRybV9hdG9taWNfZ2V0X25ld19wbGFuZV9zdGF0
ZShzdGF0ZSwgc3RhdGUtPnBsYW5lc1tpXS5wdHIpOw0KPiANCj4gZm9yX2VhY2hfbmV3X3BsYW5l
X2luX3N0YXRlKCk/DQoNCkkndmQgdHJpZWQgZm9yX2VhY2hfbmV3X3BsYW5lX2luX3N0YXRlKCks
IGJ1dCBpdCBjcmFzaGVkIGluIHRoZSBmaWZ0aA0Kcm91bmQuDQpCZWNhdXNlIG1vZGVfY29uZmln
Lm51bV90b3RhbF9wbGFuZSBpbiB0aGlzIG1hY3JvIGlzIDgsIGJ1dCBtdGtfY3J0Yy0NCj5sYXll
cl9uciBpcyA0Lg0KDQpTbyBJIHRoaW5rIHdlIGNhbid0IHVzZSB0aGlzIG1hY3JvIGhlcmUuDQoN
Cj4gDQo+ID4gKwkJCW10a19wbGFuZV91cGRhdGVfbmV3X3N0YXRlKG5ld19zdGF0ZSwNCj4gPiBw
bGFuZV9zdGF0ZSk7DQo+ID4gKwkJfQ0KPiA+ICsNCj4gPiAgCQljb21wID0gbXRrX2RybV9kZHBf
Y29tcF9mb3JfcGxhbmUoY3J0YywgcGxhbmUsDQo+ID4gJmxvY2FsX2xheWVyKTsNCj4gPiAgCQlp
ZiAoY29tcCkNCj4gPiAgCQkJbXRrX2RkcF9jb21wX2xheWVyX2NvbmZpZyhjb21wLCBsb2NhbF9s
YXllciwNCj4gPiBAQCAtNjg3LDcgKzY5Myw3IEBAIHN0YXRpYyB2b2lkIG10a19kcm1fY3J0Y19h
dG9taWNfZW5hYmxlKHN0cnVjdA0KPiA+IGRybV9jcnRjICpjcnRjLA0KPiA+ICAJCXJldHVybjsN
Cj4gPiAgCX0NCj4gPiAgDQo+ID4gLQlyZXQgPSBtdGtfY3J0Y19kZHBfaHdfaW5pdChtdGtfY3J0
Yyk7DQo+ID4gKwlyZXQgPSBtdGtfY3J0Y19kZHBfaHdfaW5pdChtdGtfY3J0Yywgc3RhdGUpOw0K
PiA+ICAJaWYgKHJldCkgew0KPiA+ICAJCXBtX3J1bnRpbWVfcHV0KGNvbXAtPmRldik7DQo+ID4g
IAkJcmV0dXJuOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RybV9wbGFuZS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFu
ZS5jDQo+ID4gaW5kZXggYjFhOTE4ZmZlNDU3Li5lZjQ0NjBmOThjMDcgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMNCj4gPiBAQCAtMTM0LDggKzEz
NCw4IEBAIHN0YXRpYyBpbnQgbXRrX3BsYW5lX2F0b21pY19hc3luY19jaGVjayhzdHJ1Y3QNCj4g
PiBkcm1fcGxhbmUgKnBsYW5lLA0KPiA+ICAJCQkJCQkgICB0cnVlLCB0cnVlKTsNCj4gPiAgfQ0K
PiA+ICANCj4gPiAtc3RhdGljIHZvaWQgbXRrX3BsYW5lX3VwZGF0ZV9uZXdfc3RhdGUoc3RydWN0
IGRybV9wbGFuZV9zdGF0ZQ0KPiA+ICpuZXdfc3RhdGUsDQo+ID4gLQkJCQkgICAgICAgc3RydWN0
IG10a19wbGFuZV9zdGF0ZQ0KPiA+ICptdGtfcGxhbmVfc3RhdGUpDQo+ID4gK3ZvaWQgbXRrX3Bs
YW5lX3VwZGF0ZV9uZXdfc3RhdGUoc3RydWN0IGRybV9wbGFuZV9zdGF0ZSAqbmV3X3N0YXRlLA0K
PiA+ICsJCQkJc3RydWN0IG10a19wbGFuZV9zdGF0ZQ0KPiA+ICptdGtfcGxhbmVfc3RhdGUpDQo+
ID4gIHsNCj4gPiAgCXN0cnVjdCBkcm1fZnJhbWVidWZmZXIgKmZiID0gbmV3X3N0YXRlLT5mYjsN
Cj4gPiAgCXN0cnVjdCBkcm1fZ2VtX29iamVjdCAqZ2VtOw0KPiA+IEBAIC0xNDYsNiArMTQ2LDEx
IEBAIHN0YXRpYyB2b2lkIG10a19wbGFuZV91cGRhdGVfbmV3X3N0YXRlKHN0cnVjdA0KPiA+IGRy
bV9wbGFuZV9zdGF0ZSAqbmV3X3N0YXRlLA0KPiA+ICAJZG1hX2FkZHJfdCBoZHJfYWRkciA9IDA7
DQo+ID4gIAl1bnNpZ25lZCBpbnQgaGRyX3BpdGNoID0gMDsNCj4gPiAgDQo+ID4gKwlpZiAoIWZi
KSB7DQo+ID4gKwkJbXRrX3BsYW5lX3N0YXRlLT5wZW5kaW5nLmVuYWJsZSA9IGZhbHNlOw0KPiA+
ICsJCXJldHVybjsNCj4gPiArCX0NCj4gDQo+IFRoaXMgc2VlbXMgZG9uZSBpbiBtdGtfcGxhbmVf
YXRvbWljX3VwZGF0ZSgpLCBzbyB5b3UgbWF5IGNhbGwNCj4gbXRrX3BsYW5lX2F0b21pY191cGRh
dGUoKSBpbnN0ZWFkIG9mIG10a19wbGFuZV91cGRhdGVfbmV3X3N0YXRlKCkuDQoNCm10a19wbGFu
ZV9hdG9taWNfdXBkYXRlKCkgd29uJ3QgdXBkYXRlIHRoZSBtdGtfcGxhbmVfc3RhdGUgaW4gbXRr
X2NydGMsDQpzbyBJIHVzZSBtdGtfcGxhbmVfdXBkYXRlX25ld19zdGF0ZSgpIGhlcmUuDQoNCkJ1
dCBJIGZvdW5kIHRoYXQgd2UgY2FuIGZpeCB1cCBpb21tdSBmYXVsdCBpc3N1ZSBieSBoYW5kbGlu
ZyB0aGUgTlVMTA0KZmIgY2FzZS4NClNvIEknbGwgY2hhbmdlIHRoZSBwcmV2aW91cyBtZXRob2Qg
dG8gZGlzYWJsZSB0aGUgcGxhbmUgaWYgaXRzIGZiIGluDQpuZXcgc3RhdGUgaXMgTlVMTC4NCg0K
UmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+IA0KPiBSZWdhcmRzLA0KPiBDSw0KPiANCj4gPiAr
DQo+ID4gIAlnZW0gPSBmYi0+b2JqWzBdOw0KPiA+ICAJbXRrX2dlbSA9IHRvX210a19nZW1fb2Jq
KGdlbSk7DQo+ID4gIAlhZGRyID0gbXRrX2dlbS0+ZG1hX2FkZHI7DQo+ID4gQEAgLTE4MCw3ICsx
ODUsNyBAQCBzdGF0aWMgdm9pZCBtdGtfcGxhbmVfdXBkYXRlX25ld19zdGF0ZShzdHJ1Y3QNCj4g
PiBkcm1fcGxhbmVfc3RhdGUgKm5ld19zdGF0ZSwNCj4gPiAgCQkgICAgICAgZmItPmZvcm1hdC0+
Y3BwWzBdICogKHhfb2Zmc2V0X2luX2Jsb2NrcyArIDEpOw0KPiA+ICAJfQ0KPiA+ICANCj4gPiAt
CW10a19wbGFuZV9zdGF0ZS0+cGVuZGluZy5lbmFibGUgPSB0cnVlOw0KPiA+ICsJbXRrX3BsYW5l
X3N0YXRlLT5wZW5kaW5nLmVuYWJsZSA9IG5ld19zdGF0ZS0+dmlzaWJsZTsNCj4gPiAgCW10a19w
bGFuZV9zdGF0ZS0+cGVuZGluZy5waXRjaCA9IHBpdGNoOw0KPiA+ICAJbXRrX3BsYW5lX3N0YXRl
LT5wZW5kaW5nLmhkcl9waXRjaCA9IGhkcl9waXRjaDsNCj4gPiAgCW10a19wbGFuZV9zdGF0ZS0+
cGVuZGluZy5mb3JtYXQgPSBmb3JtYXQ7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmgNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX3BsYW5lLmgNCj4gPiBpbmRleCA5OWFmZjdkYTA4MzEuLjBhN2Q3MGQxM2U0MyAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5o
DQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuaA0KPiA+
IEBAIC00Niw2ICs0Niw4IEBAIHRvX210a19wbGFuZV9zdGF0ZShzdHJ1Y3QgZHJtX3BsYW5lX3N0
YXRlICpzdGF0ZSkNCj4gPiAgCXJldHVybiBjb250YWluZXJfb2Yoc3RhdGUsIHN0cnVjdCBtdGtf
cGxhbmVfc3RhdGUsIGJhc2UpOw0KPiA+ICB9DQo+ID4gIA0KPiA+ICt2b2lkIG10a19wbGFuZV91
cGRhdGVfbmV3X3N0YXRlKHN0cnVjdCBkcm1fcGxhbmVfc3RhdGUgKm5ld19zdGF0ZSwNCj4gPiAr
CQkJCXN0cnVjdCBtdGtfcGxhbmVfc3RhdGUNCj4gPiAqbXRrX3BsYW5lX3N0YXRlKTsNCj4gPiAg
aW50IG10a19wbGFuZV9pbml0KHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHN0cnVjdCBkcm1fcGxh
bmUNCj4gPiAqcGxhbmUsDQo+ID4gIAkJICAgdW5zaWduZWQgbG9uZyBwb3NzaWJsZV9jcnRjcywg
ZW51bSBkcm1fcGxhbmVfdHlwZQ0KPiA+IHR5cGUsDQo+ID4gIAkJICAgdW5zaWduZWQgaW50IHN1
cHBvcnRlZF9yb3RhdGlvbnMsIGNvbnN0IHUzMg0KPiA+ICpmb3JtYXRzLA0K
