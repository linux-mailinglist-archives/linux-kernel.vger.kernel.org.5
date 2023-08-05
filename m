Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A812770E70
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 09:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjHEH1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 03:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHEH1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 03:27:40 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEE04EC7
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 00:27:35 -0700 (PDT)
X-UUID: 89562742336111eeb20a276fd37b9834-20230805
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Zu4ALzOwePJ58nkeXs9lfkjK+5Skr26csccCDwH2AZ8=;
        b=eFSysnHIa9wNyzMZP+8IknW1DnQkJlE2ppW+9n2i2Pmzr42CUqOfirm7XpA0ZT4Hj2T05vSj7pknWdV0YNWXhGSjKsG0mSeofgAn2WM8Sb8WAfRxPkxoIdMJQiimZhhRw7dMOr2RpshAt8GCGicy11yWCxtKE7waGcPzx7g1Lzg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:c7beabb3-f3bc-4f20-829a-155e346702b5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.30,REQID:c7beabb3-f3bc-4f20-829a-155e346702b5,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:1fcc6f8,CLOUDID:9f9db5d2-cd77-4e67-bbfd-aa4eaace762f,B
        ulkID:230805152730W3G6JWO7,BulkQuantity:0,Recheck:0,SF:17|19|48|38|29|28|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,C
        OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM
X-UUID: 89562742336111eeb20a276fd37b9834-20230805
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 536729911; Sat, 05 Aug 2023 15:27:30 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 5 Aug 2023 15:27:29 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 5 Aug 2023 15:27:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h69TLbYGSUhkgXhffKS3PpsLbiDjlJGBOALTgsGYGLbC5mNM3BrAeX21GWvZGANnyhTRgruBWbrRFSi/pNl0zpu3j/wSIugWmqpBtZNIqW0b76q7lNcYULpElK7NasMYuLgRW89kGks+3NMPRtdTTzw7IwhcIl0rAngmXBL7laVRy/2fs1akOYkCwcgjDLAeCk93ArV7rRQYIN+CGM6aQj6aQCf528eGs1Th/+IAWSsXD6zi1CppJC8OlO7Y0MAthkMbArQK0hJopw8/++HSVTJaF2yewmxkoUlZT+5X0TtG34Ofuqy/LKTXmQl9Eh/zEVI4EM5hQsH0Mlj4CNnmeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zu4ALzOwePJ58nkeXs9lfkjK+5Skr26csccCDwH2AZ8=;
 b=EXls83kapZgQW+ebV35r9lRJdrD5GMSW/o2+aqas8Yt5ygcx2/5/OJvEsCbmECJRSf3zfZVyRTz5q4TnrqpF1Gv/D0oNJ6e3eVhUr9qobxK/E1B2e/t7VNimQjgZb/nfX7HwqsQmIuxvIX3j6YplpfZwF8nDXfp874lcjDP+ueCrYrKaPfHJpuAMr/HyTpxz+nr7bfB+FbiFU+4KJGyieZFQzsHqZNG2ODeH9XK2+a5ZB/7OcYZt6felsY6bBTH3nX+bIzZH/qusuDLZycemAd6OxGYXhjB7lcJQKcskTuD/IgovL3uO80tpH48yr1J365i8zfdGVMynvJKuCQcYiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zu4ALzOwePJ58nkeXs9lfkjK+5Skr26csccCDwH2AZ8=;
 b=HO3U+2+S6CUM/Gt2yfxlxyPLVcf5sq8W23+/Os2SHQaG3qCPkZSzfnIRq4oDtCFVcJiAW4Ilz4RHlaqFQZv1Y2B4YFqRuC+guag7cQLAsN8llfYEeCYlbu2NCntyqrPz52gPGRur0AT4YEYIsOVb6DhlGmR/VOhacMWlLbFzB8c=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by KL1PR03MB6391.apcprd03.prod.outlook.com (2603:1096:820:96::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Sat, 5 Aug
 2023 07:27:24 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8%4]) with mapi id 15.20.6652.020; Sat, 5 Aug 2023
 07:27:24 +0000
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
Subject: Re: [PATCH v8 2/8] drm/mediatevk: Add crtc path enum for all_drm_priv
 array
Thread-Topic: [PATCH v8 2/8] drm/mediatevk: Add crtc path enum for
 all_drm_priv array
Thread-Index: AQHZxVCB6KnncXlRP0CJbGtTm7kD4a/Yj0cAgALCpYA=
Date:   Sat, 5 Aug 2023 07:27:23 +0000
Message-ID: <213ffc402a5b55f20d80ed9229f7d4a538bf6273.camel@mediatek.com>
References: <20230802144802.751-1-jason-jh.lin@mediatek.com>
         <20230802144802.751-3-jason-jh.lin@mediatek.com>
         <38720b56-df8e-d25a-0e6f-ca6e1fb3df26@collabora.com>
In-Reply-To: <38720b56-df8e-d25a-0e6f-ca6e1fb3df26@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|KL1PR03MB6391:EE_
x-ms-office365-filtering-correlation-id: be1143a6-73a2-477e-e9cf-08db958569ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eiXt1kisbk/fslx4qbcOPLs0TvU/AuKi/kq8rAI5m3G+Blw6DP74SndgYm9jeAjlXXcuRLcRdydwOPv5XvBBRIK9UR5QqZPgfV5+Ots+RMoHX4VY+NW2/L2PD/O2ml3QrW8u7TO/bdv0XCmuUAu5Oe9yAdFz0UjJRZAcqP3dHSlOWmbzkB4mcUrU/ER0k8QjEy8IsHyS2jjqqlKqGhhpBp7cUypz/oXQTab0/S1LaO/4tLhoBYkjldyVi1KW4Dgv7zf5WVl/D7CIT/g7GQZpRsYVWGShPodxaNEqkEhLgF+TkN21g2mJfBkYz7UM4lzJlm9450OMzAAdr0zZkKTabJNnsDk1UhIs8PKrPZFW2eiSyxiUyW3K1wuE53JAQ51h5LHe3GCGyjHsM2DZBKBDo4Ys5ECAaPVGE/CCvM92fLCzJ1P8UuchrwGmyCHFJ6zeTmBLWerqBbHad9iJmkNxPw9pjRvOSonKyrIhu+Fo4bLY+WuIUvQzFazIKiaAtwB+3zxBbXjzzwE4ePudAle/Dz+iDzjuo8HM1NOQ/OtyKOVvOjpz1ykpIUlaSZYU1GPfp1R3McaCcNoRYitucwaSZtjvl0dwCOy3+MQOJrT/fQM+MJmfLeV5gBSlnU9bqWlGtZADyRV3Wzewu38F8JOujHPLYlGcXICFnyCJdAI8BWw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39860400002)(346002)(376002)(186006)(1800799003)(451199021)(6512007)(6486002)(76116006)(4326008)(91956017)(6506007)(53546011)(71200400001)(26005)(478600001)(110136005)(8936002)(54906003)(2616005)(2906002)(86362001)(4744005)(66476007)(66946007)(66556008)(66446008)(64756008)(5660300002)(36756003)(38070700005)(85182001)(316002)(38100700002)(8676002)(41300700001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzFqT1BJWVVnMkVIT0JxT3l4UDFwNDlzTlZvWTlLNGlhUnR1QzNqYVRXb0E1?=
 =?utf-8?B?YmFnL1lVRnFUaEtzYWxOQlovM21VSXErUmt4bWg5M3J1VGJ0NjdlRkdzNFdR?=
 =?utf-8?B?OFdyVWtsdE15TWI3OWJjU0lxTlY4UnVmbjdUbmYrdTc1N2lwbjZBNHllekpM?=
 =?utf-8?B?SjhJUWNZSG1rTHNRRmgwRXJtc2t4RVRyVFpMcGN5Y0lhUml2WFdmZGp3NHU1?=
 =?utf-8?B?ZGFObk9NQnBNL1pNUEdFVjQ5NjZxWU8xQ3hoT05PeTVqd3RhWEt1K2pVOUYv?=
 =?utf-8?B?cmRBMnZEcHIwZVUvK0dGM3hwTDJwWjZUYkFXa09aRlZqdWJjY01xdlNpVXBI?=
 =?utf-8?B?c2o1QWQ2Ylk5TEtjNSt0UmUzZG04dkxIcER3OUpsd2kzQk5ieFZjeG4rVk9p?=
 =?utf-8?B?MFJtVUsyamYyTDk0Ymc5cmI1WTFQWUx5QnMwMWtzRmJRQ3Jnb1RDcmtLV3hv?=
 =?utf-8?B?VStzWEh1RzJ3TFljbXBJQldRSE5XNGtqMVFBdnIzOGJyWmJOOTAvRkxoaHh2?=
 =?utf-8?B?YXl5OUY3dFZMQlhJUHFTa0czaDJpU29HTnZzR2Y4bWVrOFI4ejNsOXJGa0xS?=
 =?utf-8?B?YnJrZlJDeDRqRWE5WDVMWDQ5K2dTUEx4Vk5TcmYwUUg3bURCKy85empINnlm?=
 =?utf-8?B?MWszV0lZckRDWmgydEw0aW9laElyb0EwTWF4bW96QjlrY3FISyt4YmtzQWN2?=
 =?utf-8?B?ZmJVYWJuYm5YajZ3K0IyWFBGcGlON0p5blY5QkdrOVdoNjZSN0FyT0tSbkRW?=
 =?utf-8?B?QXVRcGdTWGtGc3FEQVRuSEVreWpSMkJZQ3FiMjU5dmUrS0s2eW5EMk8xTWxW?=
 =?utf-8?B?TUZOU3l4MGJCV2I1YUpEYVhpcFZIdWxmM2d1bENlTVpvTlF2cG9OTk1aM1hN?=
 =?utf-8?B?R0hKZ09IMDRFTjZzRjRjUjY3c2ZDTk5TOGpnU3lqd2dMK24vaTdpazlTdEN6?=
 =?utf-8?B?THg3cWpCbzQwaUU2NFIyTnN6bTF1NEx2NFN5NkcvU2pNMDk2U2FqSTBsOVNZ?=
 =?utf-8?B?K3YzQUN0aFZDT3NTMmhvL3dLL3UwS2hvWmdERlVJbzFkZHJvSHhNS2hXYW1v?=
 =?utf-8?B?Y1h6LzcyZVhiQXhlRlg4eEl3bGtTQmFnYVdCRFFrRUUzMzdWNXkzYk96N2pX?=
 =?utf-8?B?bEovY3MvOEhoMDE0K2dYaURxSjFXN3J6VTdQbytCczc1ei9ZUmRGMEJoQWNG?=
 =?utf-8?B?dlZ1Q01neWNEcE9vdGw1RUE2azNqUkUyVlRKR3hmRUxGVmV2L3h6S0ZKRzVj?=
 =?utf-8?B?dEUzK2JhOXUxNnVmM21DUVd1alcxUUZEZ1ZGbzVKR0lSTHhWTVBsYzVncHBE?=
 =?utf-8?B?Y0xpZHdFVTFlNldtNmRWbGJmdFNyd3FEb2FtUGZaVzdpbEFac3pObTdSQ1Fm?=
 =?utf-8?B?ek9iZkF4dURrR3l4UkZVc3BHaVYvVWpkcXAvV2xNMHZtNXNTRTBRYmdSYkpR?=
 =?utf-8?B?VFR3RENjTTBHSFFERUlBTXpPcGlTa2RHMG0wTFhXSTIxZEwyR0dvcjJVbEtI?=
 =?utf-8?B?a1A0cW1ZVGYwNU52SXAvaHdlT2dTRWxZUFpIT0hkRjdXVVg0RDg5MGRINHRU?=
 =?utf-8?B?WURLREJaczVzUWJBb1ZiZktjU1U1NFREbGpvY1A0ankxcVBNRld4NE5GWlpt?=
 =?utf-8?B?M2gvNDdrSVRXK2N0VE55Y0NNaDRWV05pcGgrenBhdThRcmxqTG4rU21lV3N1?=
 =?utf-8?B?ZDJoS2pPRjEwcWJTNnFnbGQ4QUtDaDRpRGlJRmVpY2E2L0FabEhMbXpIQUdF?=
 =?utf-8?B?bk4xaHJ5dy9kZUdhTm9kUFBrMVlrUDQwVW41Y1Q5UWpxVTBPZVhGRDZUZXBC?=
 =?utf-8?B?aTlSWXFIbnVNcExaTWF2K0hSWCtvMUU3OVBDcnNLRDE4d1BWWFdqWTYrelNN?=
 =?utf-8?B?NzV4c3BvZzRaRFhGVU1BL3ZoUGJZSWwrVXFMNStlQTJ5bXFhTTJVd1VxdHdx?=
 =?utf-8?B?QkNyckRmU0RzTkdQSllNSUUxdGR2dmwxU1RFSEFabEtpd2VpZ3RiREt5aGpU?=
 =?utf-8?B?ekNGS2F4enpwMkZLd05DYXU5MXpKaUs0RnE0M0drK011VGYxWklPWVUzVlNS?=
 =?utf-8?B?Q0xzbFU1WjZEcGFFamRVUERNUElZb3pEVmZ6WW52OW41Z253VG5ESFRSRCti?=
 =?utf-8?B?T2hGUE5BSSs4bHY3cjJVZStEbmpsbjRGMnFxSWFMVTc2UkZKY3VMMkJqc0Zy?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92E42AE3524A3B4F8640DCEFD57FD49C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1143a6-73a2-477e-e9cf-08db958569ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2023 07:27:23.9136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8LtXe46Lwx9aJ01rQT/7840zQcyr0mhOhoHsHn5vaO9E2x4q2FK+5QmqZxEcC+fsDyIieZi/dqiJ334NUEF2LCt4kOBAYvbwAslE3GK24u4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6391
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRXVnZW4sDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIFRodSwgMjAyMy0wOC0w
MyBhdCAxNjoxOCArMDMwMCwgRXVnZW4gSHJpc3RldiB3cm90ZToNCj4gPiANCg0KPiBPbiA4LzIv
MjMgMTc6NDcsIEphc29uLUpILkxpbiB3cm90ZToNCj4gPiBBZGQgbXRrX2RybV9jcnRjX3BhdGgg
ZW51bSBmb3IgZWF0Y2ggZGlzcGxheSBwYXRoLg0KPiANCj4gVHlwbzogZWFjaA0KPiANCkknbGwg
Zml4IGl0Lg0KDQo+ID4gDQo+ID4gSW5zdGVhZCBvZiB1c2luZyBhcnJheSBpbmRleCBvZiBhbGxf
ZHJtX3ByaXYgaW4gbXRrX2RybV9rbXNfaW5pdCgpLA0KPiA+IG10a19kcm1fY3J0Y19wYXRoIGVu
dW0gY2FuIG1ha2UgbW9yZSByZWFkYWJsZS4NCj4gDQo+IGNhbiBtYWtlICpjb2RlKiBtb3JlIHJl
YWRhYmxlID8NCg0KWWVzLCBJJ2xsIGNvcnJlY3QgaXQgYXQgdGhlIG5leHQgdmVyc2lvbi4NClRo
YW5rcy4NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+ID4gU2lnbmVkLW9mZi1ieTogSmFz
b24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0K
