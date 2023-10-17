Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1B77CC174
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343489AbjJQLEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbjJQLEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:04:43 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E15B0;
        Tue, 17 Oct 2023 04:04:40 -0700 (PDT)
X-UUID: f447ff806cdc11ee8051498923ad61e6-20231017
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=yDxJgVfrhe88HKkfbwBXRIxNB8gZKUpW43UgqlSO9hM=;
        b=cZPAZ9yHYTBxvNzvCYqmgpeD3CGSm3ubdesPtyDpTF/w6fOFdniwFTvcKofr8A4G0j2oqeCH9rQYH/HhyUkPGU9xnc6IhWy/F+ISFSP8M9EVuTmGLAJK8jBMspMKALIvK+nyTrVd98G9wDWIxPZuMkzsGjsbUQ2h2WZX7MbTbAY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:0f0db9f0-52b0-4ddb-963a-d95d9d64d232,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:451fe5f0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: f447ff806cdc11ee8051498923ad61e6-20231017
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1562327875; Tue, 17 Oct 2023 19:04:34 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 17 Oct 2023 19:04:32 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 17 Oct 2023 19:04:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZbXPWhXzG/ykX+0IUPzmOTKI0U6XZLAPxl5GhiGB6totEIOqQG0ZGWpS9jH7FaGTukapINsQI5cQ5fp/0fMfa8L8LYpom3wz7ujsPj/K1NaoHNKzJqEDxugqlAqbQFYKSCAIWnU6t8rYO/ni7P/+oY4HpI8og1HtqnkV/Oll61DdK9qW+v2mW9y4WXxAzZXDSgEBGeRuDtBQvJ9y8suRydoDIR3NaWQ+ZXWwO60tOuLQzQ4QTESB6UcjNhfuXONKhAu0gIqeG3/QL8jVHwmVV5KSmpx9YFeOj62Ow5JuL8jvsBoMaD9Y3Nt+U/kXu7H1it21eVp5COf1gY1o+W2QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDxJgVfrhe88HKkfbwBXRIxNB8gZKUpW43UgqlSO9hM=;
 b=LTYIex2Brrn092m2LN+suWEu86eclGMkxJUBKnv4ufH5+LOEe83xcc8kIlAijJmcLIpjDW4VYG6N8yfT77p/pMwtlzskWvrrihpL5hj/ni0s8U0r+PMQDydQHuhKMd94WqtYIdn0dHSy8AqqM939L65aPAn2zVrplT4Ch3iT438tEP0/Vf21tU2ZU4VyHbuSFDIqKaIZwjqEHq2VceVmogYbyUM8aG4cLqNz0RGjWXg0U/43IlqZcgokbgNowsFsrzzd416PZqDrZGRXc9CkvGG3WY6ChsPyQjDZrrpAJYf3fKieL/zNAF72/VEa/zkVxFtgTWOUFai18/YDBPplag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDxJgVfrhe88HKkfbwBXRIxNB8gZKUpW43UgqlSO9hM=;
 b=NAyqVtIIv+fEH1hZx3DO4BB3KhxB1/Kdc1PBhzfsKBG4RvyAcrQ1LQ7U8YKl4b/IfvRrqVLeVgCk8U6u0+Vm6Otuo+Q7NPKhH1hXoLMBOkBL2N4tT83vU4dB8FcpVUfW7j+i65p5WPExmVFIhtKzYNjwsG2ErmixlncfDws/RRw=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by KL1PR03MB7174.apcprd03.prod.outlook.com (2603:1096:820:c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 11:04:28 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::faa3:6316:28ab:206b]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::faa3:6316:28ab:206b%4]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 11:04:28 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?utf-8?B?TmF0aGFuIEx1ICjlkYLmnbHpnJYp?= <Nathan.Lu@mediatek.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "fshao@chromium.org" <fshao@chromium.org>,
        "johnson.wang@mediatek.corp-partner.google.com" 
        <johnson.wang@mediatek.corp-partner.google.com>
Subject: Re: [PATCH v8 22/23] drm/mediatek: Power on devices in OVL adaptor
 when atomic enable
Thread-Topic: [PATCH v8 22/23] drm/mediatek: Power on devices in OVL adaptor
 when atomic enable
Thread-Index: AQHaAB1HEdFfDejVNEqf1UEj5S+jd7BNv64AgAATeoA=
Date:   Tue, 17 Oct 2023 11:04:28 +0000
Message-ID: <63f9b96208e0b0b25da843f6aa0c7e0dd7f8e0bf.camel@mediatek.com>
References: <20231016104010.3270-1-shawn.sung@mediatek.com>
         <20231016104010.3270-23-shawn.sung@mediatek.com>
         <fef1cae9-057c-4946-b9d3-27a799fefc5d@collabora.com>
In-Reply-To: <fef1cae9-057c-4946-b9d3-27a799fefc5d@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|KL1PR03MB7174:EE_
x-ms-office365-filtering-correlation-id: fd3e5192-efdb-48a1-4d13-08dbcf00d527
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5nh7B606HsDFIMxhbcYtkmziV5ozMnOyPPo517XYeELc3EKAFPo7cDZWGgbP1xC1dy8GROL38c6tcxiqh4uIpUn3bFWMVvE4BvQcUXGL2hUzRgDtN89GaSSdx3CEiZ4A+p91XsOAS2PWekFGjyFLd7SyytOkM8tAvP88dl3lSCvs7M9kJpzTR+TcnATj9SSSBmkkdbeUvidmetmv7GgboMRjB/+Gwi+qn54IQOK59hPW3vHihq/qIXU0m4wlMx5Ann0MARZBiEeilr+rYmil7LER97xuDxrKjuBtw3EjiR2uAJurG1hTaOGmgnGTcOQCEWZU6OwHzG8HibUy/4tK+0nKEUcXT/wwduhhAWoJmKLYnI7a2u0pgaWXC1RTEHK2DB2L6EEZC8CyX4TTz+PfYT3J96Evtka4vkzb7C3lEzdBpTl5tRS+kyH3s5hYARB4hpY48HRaf+SXiPXhwkqG0Onkv52XZeMKfVuJ8d8WIvEtdFmn1DBxeQs/pSoYhWC5cPEl23CPdGvqdAikStkveC21NQnlo4+knOjhOfEgdgP02A5brZf6OuZYWo9ucUCf36TvPxowf2tI4KeABLu7qCuJLML90chJU7IKL+Nz28Ei4vuq5qbsicrPy8s6qiMVAwMgpD5a49zX532BFdn2Zg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(346002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6506007)(2616005)(6512007)(478600001)(71200400001)(26005)(86362001)(83380400001)(6486002)(966005)(110136005)(2906002)(38070700005)(7416002)(5660300002)(41300700001)(66556008)(66476007)(316002)(66946007)(122000001)(66446008)(76116006)(64756008)(54906003)(4326008)(8936002)(8676002)(38100700002)(4001150100001)(85182001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHdHd2huejEyRVNmZ1ZHUnN4Y2UxdUdZeXp0ZFlpaEFSZFp2am1VbzFHSlFQ?=
 =?utf-8?B?TVJNK2JlTVJnQkYwV1RrUGgyL0wxeEZQVWFuc3BZdTNkc3RYR1VWQi9pUDdP?=
 =?utf-8?B?eTd1WjhwYmNvdlJWU1pxSHBZUzFnc1FOQUV3VnBoQ2N0cFNWNCtHM040WE5C?=
 =?utf-8?B?ZTltQ1R0VWY5N1dNZUVjamM3TWhuT0VJanJBR0oxTFRsRXlOVlRTRmY4S1Qx?=
 =?utf-8?B?NE5zMjlHYWlQNUNLZktqRkVocnBmT2p3OXRHTGo3cmlMRFZWc0tobiszWjZs?=
 =?utf-8?B?ZDNGbFZlNVJ4RWIrZ2s4QWU1dHByUUxqWGM5QXorWGxRcHZMU0p3cTErWCtw?=
 =?utf-8?B?Ri9Pc3NjMGFyT3ZrTHNrYURFbGsrbC9KRExVT2QrL1k4Q1lFNER0YmdVMEs5?=
 =?utf-8?B?bFRmczh6MEpwVzVtSHRORVZUTFdwWCt2UmtWY24rQTZ1UDlSbXdzdnY1bHRn?=
 =?utf-8?B?THgrMnZDN3lTRmdTYWZCVjZ2RTRyRTIwNC8wWTMwQy9CTHpPM2toa25GMGoz?=
 =?utf-8?B?YmpvUkVsdm1kL21FSTJ5bnp5YjJwajdVWXpuVlh6d1l5RllKQmJKOHRPT1Br?=
 =?utf-8?B?aGozWDBxWVoyVW5aa3FtaVdXUFJWSVg4RFBWaHErL1phb3JGZGRpTEw2a080?=
 =?utf-8?B?cksvdlFDZmwvSlVzaGxIWHkrakNlTWkrVklNSzBXdEU1emdJRVBZaGYzQ01k?=
 =?utf-8?B?WWExOHppdmRyWGFRc2dHVnAzbkhuWVVHbkh0dVhTT3hOU0xpcUNIV2FnYlV4?=
 =?utf-8?B?M1doZE9GdWdNOHJidk1KcFl2ZHFDVDZZYnZRN1pNNzBLUmViT1VVTTBHeG5t?=
 =?utf-8?B?cWlVanJsMkg3MU5rV0x5YjgxMEJTZlhOOWJMUlpyOG5ESCs1L2tpbmJMcjNj?=
 =?utf-8?B?Yzh5cTM2d1JjR3FESnFKSVBhNHZaT0tObFFZT1B6czlZN0x1YmZ1T2VzRGlY?=
 =?utf-8?B?clJuSVI1YnI0NVYxLzY5WGZmZ01sMEFrSENJUWdpUFZQUTY2WElUR1dHNzg5?=
 =?utf-8?B?aW80Q0c1Z2hEbmNuNitpZlBsWnB4ZVpXVzRDQUwrL1dLMjdpckRsbmVLalhZ?=
 =?utf-8?B?QmJtSGlZbmh3U3BmMFJuZko4K1JwNFRSZVNkWTRpVEdIcFg3UHArNS9iTE51?=
 =?utf-8?B?czBiUUl5Y0lWVHVVei90MWJHVUlINnFYREhHdm9KSENQTGJrVENFMnhYWThE?=
 =?utf-8?B?dHhEN0dsQmJEdXJDd2svRC9wSm9sRkltaFRCeEtvWGxJRHhnN1h0RUN3MUcr?=
 =?utf-8?B?U09NVWlPM3kwVWc1NzZCcXd0RVZuQlFMaUlDU0x0c1BhWWVqM1FYdDVCM0Vy?=
 =?utf-8?B?UW5PRFdONmlFNk1wQmE2UzhKeW85M1JTNUVFS1hib0lIdlh2UWZrTnZvYlgx?=
 =?utf-8?B?ajlJVXhSd2pwQXBncjJ4MUs4UDJjelF1ajk3bXhTWENqbGwxR3RRRkZXWGdY?=
 =?utf-8?B?dy9wYzZ1TWQvWGJjcTNDR2hralBXWC80WUpJOWMwV0MxNE4zcU52Zi9OcllY?=
 =?utf-8?B?bFBqcHBNMDZKRmpnNGNKL1ZJNDlIaE5NRiszc1phNDFoZDlxaVFvb00wckZj?=
 =?utf-8?B?ZDh2WlhRMVl4dEhmMXUwbXlZeTVNY05NSGdKb3lHVXV3VG5pRVB4RW8raFdU?=
 =?utf-8?B?SnpTcDFGZTNZajY0ZVhKbEVmaUdwTlBrQ1Mxc0x6YmZ2ZGFLZGV4Z1BvYTRo?=
 =?utf-8?B?eXF1SnRveHdBWXRpazNwNWJUNFZNUmM5d3VLQnFwQ3pPMGQ1M0QxUEF0aTds?=
 =?utf-8?B?SUVUQlcyb3JINXdRMFpqbDQxUTdnd1NISXVXY1J3S0ZzRXJOZlNIQmV3ZmEw?=
 =?utf-8?B?OUNkQnY2ZGNhSDh1YkxlVURXYmI2aFJrSEF1cFR6MjJ4QlQ2RUQzUm04MWZ1?=
 =?utf-8?B?bnJhRW1PUVhSbkk5YlE2aW94elYzL09ZRGlFeERyZDByU3dEQk5RYndaWERO?=
 =?utf-8?B?aGg4WEZaMXdKRTArclAxbnRkNzBRWHUrZFhKbHQ4NmJYaGxwR0ZRWlFxZ3dO?=
 =?utf-8?B?em1sM3gxZ0c3bjJKU1ZRc0w0L2F3bXpwTzNYUzNDeHdGa2JBRmhock1kOTVX?=
 =?utf-8?B?bmtCMnBTTVovSmNLTFo4RW8yYmVpdU1McG43Yk0vc3g5Y3BnUzdpdGNYM2Rx?=
 =?utf-8?B?K1BWcmQ1bURiRTlhY05BMThvUHlMN3doNVQzTjNBaitUTWpvcGlaaUFPOU1Z?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33C3F33862AD424CBA4A43FD7ECA5C3B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3e5192-efdb-48a1-4d13-08dbcf00d527
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 11:04:28.6057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2xh6dWqVfzSbt8+jUhIK7tSHMnw0J4KZX85XEm03rZn5HT9DjudfCkg2ttW6OBFN8dBfdYOlqklmaGvOFHCJFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7174
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--19.320900-8.000000
X-TMASE-MatchedRID: WTos3XtpXXHUL3YCMmnG4kD6z8N1m1ALjLOy13Cgb49qSjxROy+AU/wt
        lOVHF2NRUmsNbSHn8eBUIymPyNhNXdw6ZBw9OLRPbT3mGmWPpNet4laWdJbsDFS8bDtrR8ULqLP
        bJfc3npHyeRTP9gdA/C0dankWfuifPOvhMkqO6Qpc/msUC5wFQRG8SlV3e9LV31GU/N5W5BAwM8
        VxHnHPZKzqi1beauBRiIlayt+3hhzD/HB6o7/l2OKXavbHY/C17jKCYH0yICHDra5IbmQvVj6l3
        VPPG5GaQDQ0vuAkSrWOzgGY+NxIlYoNrmb7m9Z4msge4JmkzOVd7K6NvtpeBAL65aBpm3K7U9a6
        zfLFA1YGCaltd5dZD/2CsQy5o+e9oFbZmsVVg1HBVprK8rvWX56KYa03LCO2myiLZetSf8n5kvm
        j69FXvEl4W8WVUOR/joczmuoPCq2UTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.320900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 75FE3CFF4C3645F86858A91D1B91A56AE9A0AB940EEE2F07B18C92F06B585D322000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpPbiBUdWUsIDIwMjMtMTAtMTcgYXQgMTE6NTQgKzAyMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAxNi8xMC8yMyAxMjo0MCwgSHNpYW8gQ2hp
ZW4gU3VuZyBoYSBzY3JpdHRvOg0KPiA+IERpZmZlcmVudCBmcm9tIE9WTCwgT1ZMIGFkYXB0b3Ig
aXMgYSBwc2V1ZG8gZGV2aWNlIHNvIHdlIGRpZG4ndA0KPiA+IGRlZmluZSBpdCBpbiB0aGUgZGV2
aWNlIHRyZWUsIGNvbnNlcXVlbnRseSwNCj4gPiBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KCkN
Cj4gPiBjYWxsZWQgYnkgLmF0b21pY19lbmFibGUoKSBwb3dlcnMgb24gbm8gZGV2aWNlIGluIE9W
TCBhZGFwdG9yIGFuZA0KPiA+IGxlYWRzIHRvIHBvd2VyIG91dGFnZSBpbiB0aGUgY29ycmVzcG9u
ZGluZyBJT01NVS4NCj4gPiANCj4gPiBUbyByZXNvbHZlIHRoZSBpc3N1ZSwgd2UgaW1wbGVtZW50
IGEgZnVuY3Rpb24gdG8gcG93ZXIgb24gdGhlIFJETUFzDQo+ID4gaW4gT1ZMIGFkYXB0b3IsIGFu
ZCB0aGUgc3lzdGVtIHdpbGwgbWFrZSBzdXJlIHRoZSBJT01NVSBpcyBwb3dlcmVkDQo+ID4gb24N
Cj4gPiBhcyB3ZWxsIGJlY2F1c2Ugb2YgdGhlIGRldmljZSBsaW5rIChpb21tdXMpIGluIHRoZSBS
RE1BIG5vZGVzIGluDQo+ID4gRFRTLg0KPiA+IA0KPiA+IEZpeGVzOiA1ZGIxMmY1ZDg0M2IgKCJt
ZWRpYTogZHJtL21lZGlhdGVrOiBBZGQgcG0gcnVudGltZSBzdXBwb3J0DQo+ID4gZm9yIG92bCBh
bmQgcmRtYSIpDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hh
d24uc3VuZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3BfZHJ2LmggICAgICAgfCAgNCArKw0KPiA+ICAgLi4uL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYyAgIHwgNjINCj4gPiArKysrKysrKysrKysrKysr
KysrDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgICAgICAg
fCAyOCArKystLS0tLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rk
cF9jb21wLmMgICB8ICAyICsNCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2RkcF9jb21wLmggICB8IDIwICsrKysrKw0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19tZHBfcmRtYS5jICAgICAgIHwgMTYgKysrKysNCj4gPiAgIDYgZmlsZXMgY2hhbmdlZCwg
MTExIGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gPiBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiA+IGluZGV4IGUyYjYwMjAzN2FjMy4u
YzQ0ZjViMzFiYWI1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZGlzcF9kcnYuaA0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlz
cF9kcnYuaA0KPiA+IEBAIC0xMDksNiArMTA5LDggQEAgdm9pZCBtdGtfb3ZsX2FkYXB0b3JfY29u
bmVjdChzdHJ1Y3QgZGV2aWNlDQo+ID4gKmRldiwgc3RydWN0IGRldmljZSAqbW1zeXNfZGV2LA0K
PiA+ICAgCQkJICAgICB1bnNpZ25lZCBpbnQgbmV4dCk7DQo+ID4gICB2b2lkIG10a19vdmxfYWRh
cHRvcl9kaXNjb25uZWN0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZQ0KPiA+ICpt
bXN5c19kZXYsDQo+ID4gICAJCQkJdW5zaWduZWQgaW50IG5leHQpOw0KPiA+ICtpbnQgbXRrX292
bF9hZGFwdG9yX3Bvd2VyX29uKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ID4gK3ZvaWQgbXRrX292
bF9hZGFwdG9yX3Bvd2VyX29mZihzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiA+ICAgaW50IG10a19v
dmxfYWRhcHRvcl9jbGtfZW5hYmxlKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ID4gICB2b2lkIG10
a19vdmxfYWRhcHRvcl9jbGtfZGlzYWJsZShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiA+ICAgdm9p
ZCBtdGtfb3ZsX2FkYXB0b3JfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50
IHcsDQo+ID4gQEAgLTE1MCw2ICsxNTIsOCBAQCB2b2lkIG10a19yZG1hX2Rpc2FibGVfdmJsYW5r
KHN0cnVjdCBkZXZpY2UNCj4gPiAqZGV2KTsNCj4gPiAgIGNvbnN0IHUzMiAqbXRrX3JkbWFfZ2V0
X2Zvcm1hdHMoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gPiAgIHNpemVfdCBtdGtfcmRtYV9nZXRf
bnVtX2Zvcm1hdHMoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gPiAgIA0KPiA+ICtpbnQgbXRrX21k
cF9yZG1hX3Bvd2VyX29uKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ID4gK3ZvaWQgbXRrX21kcF9y
ZG1hX3Bvd2VyX29mZihzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiA+ICAgaW50IG10a19tZHBfcmRt
YV9jbGtfZW5hYmxlKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ID4gICB2b2lkIG10a19tZHBfcmRt
YV9jbGtfZGlzYWJsZShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiA+ICAgdm9pZCBtdGtfbWRwX3Jk
bWFfc3RhcnQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgY21kcV9wa3QNCj4gPiAqY21kcV9w
a3QpOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bf
b3ZsX2FkYXB0b3IuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292
bF9hZGFwdG9yLmMNCj4gPiBpbmRleCBiODA0MjUzNjBlNzYuLjhkZTU3YTVmNTUxOCAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3Iu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRv
ci5jDQo+ID4gQEAgLTk4LDYgKzk4LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGRwX2Nv
bXBfZnVuY3MgX3BhZGRpbmcgPQ0KPiA+IHsNCj4gPiAgIH07DQo+ID4gICANCj4gPiAgIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1bmNzIF9yZG1hID0gew0KPiA+ICsJLnBvd2Vy
X29uID0gbXRrX21kcF9yZG1hX3Bvd2VyX29uLA0KPiA+ICsJLnBvd2VyX29mZiA9IG10a19tZHBf
cmRtYV9wb3dlcl9vZmYsDQo+ID4gICAJLmNsa19lbmFibGUgPSBtdGtfbWRwX3JkbWFfY2xrX2Vu
YWJsZSwNCj4gPiAgIAkuY2xrX2Rpc2FibGUgPSBtdGtfbWRwX3JkbWFfY2xrX2Rpc2FibGUsDQo+
ID4gICB9Ow0KPiA+IEBAIC0yNDEsNiArMjQzLDY2IEBAIHZvaWQgbXRrX292bF9hZGFwdG9yX3N0
b3Aoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICAgCX0NCj4gPiAgIH0NCj4gPiAgIA0KPiA+ICsv
KioNCj4gPiArICogbXRrX292bF9hZGFwdG9yX3Bvd2VyX29uIC0gUG93ZXIgb24gZGV2aWNlcyBp
biBPVkwgYWRhcHRvcg0KPiA+ICsgKiBAZGV2OiBkZXZpY2UgdG8gYmUgcG93ZXJlZCBvbg0KPiA+
ICsgKg0KPiA+ICsgKiBEaWZmZXJlbnQgZnJvbSBPVkwsIE9WTCBhZGFwdG9yIGlzIGEgcHNldWRv
IGRldmljZSBzbw0KPiA+ICsgKiB3ZSBkaWRuJ3QgZGVmaW5lIGl0IGluIHRoZSBkZXZpY2UgdHJl
ZSwNCj4gPiBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KCkNCj4gPiArICogY2FsbGVkIGJ5IC5h
dG9taWNfZW5hYmxlKCkgcG93ZXIgb24gbm8gZGV2aWNlIGluIE9WTCBhZGFwdG9yLA0KPiA+ICsg
KiB3ZSBoYXZlIHRvIGltcGxlbWVudCBhIGZ1bmN0aW9uIHRvIGRvIHRoZSBqb2IgaW5zdGVhZC4N
Cj4gPiArICoNCj4gPiArICogcmV0dXJuczoNCj4gPiArICogemVybyBvbiBzdWNjZXNzLCBlcnJu
byBvbiBmYWlsdXJlcy4NCj4gDQo+IFlvdSdyZSBhbG1vc3QgdGhlcmUhIFRoZXJlJ3MganVzdCBv
bmUgbWlzdGFrZSBtYWtpbmcgdGhpcyBpbnZhbGlkDQo+IGtlcm5lbGRvYzsNCj4gY2hhbmdlIHRv
Li4uDQo+IA0KPiAgICogUmV0dXJuOiBaZXJvIGZvciBzdWNjZXNzIG9yIG5lZ2F0aXZlIG51bWJl
ciBmb3IgZmFpbHVyZS4NCj4gDQo+IA0KaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBz
Oi8vZG9jcy5rZXJuZWwub3JnL2RvYy1ndWlkZS9rZXJuZWwtZG9jLmh0bWxfXzshIUNUUk5LQTl3
TWcwQVJidyFrQWZwVDZhU29pSGJ2MUV2aU15Z21Ub3hmemNXVEhnYkoxM3ctLUpLV2l0cTBlX0lt
NmtvS0dGRlhuQ3RfWlpfQkQ0SW9xcUc5dnVCQlUyME04Z1cwaFRIeUdfbWg3cVgkDQo+ICANCg0K
VGhhbmsgeW91IGZvciBwb2ludGluZyB0aGlzIG91dCBhbmQgZ2l2aW5nIGFuIGV4YW1wbGUuDQpX
aWxsIGNoYW5nZSB0aGlzIGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCj4gPiArLyoqDQo+ID4gKyAq
IG10a19vdmxfYWRhcHRvcl9wb3dlcl9vZmYgLSBQb3dlciBvZmYgZGV2aWNlcyBpbiBPVkwgYWRh
cHRvcg0KPiA+ICsgKiBAZGV2OiBkZXZpY2UgdG8gYmUgcG93ZXJlZCBvZmYNCj4gPiArICoNCj4g
PiArICogY2FsbCAucG93ZXJfb2ZmKCkgZnVuY3Rpb24gaWYgZGVmaW5lZA0KPiANCj4gICAqIENh
bGxzIHRoZSAucG93ZXJfb2ZmKCkgb3ZsX2FkYXB0b3IgY29tcG9uZW50IGNhbGxiYWNrIGlmIGl0
IGlzDQo+IHByZXNlbnQuDQo+IA0KPiA+ICsgKi8NCj4gDQo+IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0K
PiANCg0KR290IGl0LCB3aWxsIG1vZGlmeSBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpUaGFu
a3MsDQpTaGF3bg0KDQo=
