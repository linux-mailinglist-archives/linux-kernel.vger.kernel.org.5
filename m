Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C4D7F6BE3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjKXGEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjKXGER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:04:17 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCE9D6F;
        Thu, 23 Nov 2023 22:04:19 -0800 (PST)
X-UUID: 4add77a68a8f11eea33bb35ae8d461a2-20231124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=RXipcTi+zUJ9Sm6nxztPEybWNQ9n9L57iacSItOBfDQ=;
        b=VJKas09roin4cTJknfYDbxMYGONbNKaqjCtpf5g5jwA5y1rpLReoxSqIWPPlryutTMSovmfevaQLd3mM8hHtTmaxiFYTadeAxlV9PSF5M0GChZfEKp+1SmYbhStFdhFCviygc5mh0PGgSVdlqs0GOoVwMQzQrKFUhDGkATLeBtk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:ea70ea6b-277e-45b2-9cbd-6c611d910b10,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:412be6fc-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4add77a68a8f11eea33bb35ae8d461a2-20231124
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 980465108; Fri, 24 Nov 2023 14:04:13 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 24 Nov 2023 14:04:11 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 24 Nov 2023 14:04:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfPI4NjdcRDf8xY3kc89WRkll/5NW8Tlh7yKQunFpbNBZWHcUIwuef27+5bRQ+NlGSTs427ymEwlX400Bg1KbSr0V1ohPR7oFmU+cHf6HZh0D9ApnDOw0VEfyJwi2Iz71s5WvqkT8EXsJjFKaAX63ytFSL/f8Lwqa7uZRDyS2LLfcThzvnjK2Fgrf6o3eDQTLnj/Pi7GKP0IEc3uhLJogVY7DaERce1ap5RmjpmU70pux60Lbk8kCBEVVtPhHbMXa4635t+dGSeTmsv2kW8dECMOsvuwas5ahox0RYtniDMZUc9ripllSWwAG1sasQOaI+/KIAK5AJnlLACVK0Au3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXipcTi+zUJ9Sm6nxztPEybWNQ9n9L57iacSItOBfDQ=;
 b=UwGbKCS8kWnqXfh8j2JOMfrDcrLYNfy0NbpIr1ZfnYQa2CQ3iw2mHhPqhUH8s5MDx0N7MjDtzBa9nj0nuowvQ8YIeZQ8KJnpGuvJXtCz/xLu33WhK11M8RY+EwVVjLIRilXbgebCzm2vsmwWWi5DFRHx4ShEh054af7GL7H9BS/23x1AWaEMWby3M7oxwjNdHvchfkQyYjfqmNSLMAFH9//ryGyemOTk8Qm0gGbeiGWMwKwCFHtVF6qXI/86LTnpghWoOG+C7maMuuZV3ZaDhHvL9kLuf27+adxA/xnO9L1JajDUbESPzZM88B4J/exejyrEjVvV5MM28xw1T+E+mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXipcTi+zUJ9Sm6nxztPEybWNQ9n9L57iacSItOBfDQ=;
 b=lOaDIVMnAUIIu9Mvn/Y+6yXncejFJgyOP22jmcK7XHIQffbtW9aFj94I8BKcWqLvqR/PMzT1qJN7Q0e+jkY23bmsxBPYe3VlKW9L4qQOzm3QWk/vnXCZCgqinilpYWWQZ8p1pIBJX+fM2mTdBKachFekmWdZbHns2aD70OTXHhI=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB7717.apcprd03.prod.outlook.com (2603:1096:820:e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 06:04:08 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a4e1:1557:a3fe:c252]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a4e1:1557:a3fe:c252%4]) with mapi id 15.20.7025.021; Fri, 24 Nov 2023
 06:04:08 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 08/11] drm/mediatek: Support alpha blending in VDOSYS1
Thread-Topic: [PATCH v3 08/11] drm/mediatek: Support alpha blending in VDOSYS1
Thread-Index: AQHaAMXsghWTpDfVY0O89qkQs8RmCrCJNoWA
Date:   Fri, 24 Nov 2023 06:04:08 +0000
Message-ID: <175fbe990a7334a74f870107866c77755f5d9f12.camel@mediatek.com>
References: <20231017064717.21616-1-shawn.sung@mediatek.com>
         <20231017064717.21616-9-shawn.sung@mediatek.com>
In-Reply-To: <20231017064717.21616-9-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB7717:EE_
x-ms-office365-filtering-correlation-id: 7803b7a5-a6a3-443b-7c6c-08dbecb32bea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9pwYJZNLGoKs7KE882L8NMJzwI0/oaUORawBn1kx3KoptHg63QlQm30V8+DSoY2Fj/WKLhhGrCbh88Fn9Lk9zlVp1YqzoHo1wHYakOSISN8erlDkI/djEwgw1FC+6VO/Qy/ZLD2FgmSutePKqg9Vh+VXzmfxbrX7gv0bO7r5rKX9tkZt3fa6TtlhAsZ3ABgQV6XDYcBLw4VH3v41YGTn0CEQ37aFN2gVtaDXJfe6ZkZ8m7egJbHaPKTDNWBvsKRpqq75VLpmgLspmzSityh8oFRB+i17c83Bwr/9Dqevu7dORYKRCPfTErwK8YjqOwdnlM/oUy2agISoPv7g8Byvu3YmNf0QnsR378ommGIhadYARsuGK3A3Olnx8HQyweZfu3KyJ9lgvxiZIhhQYBpredg3Xffdp1aSK6wYzHnwOOlqvofhj15zs4XnSzK3+37CAkIf9Xz4TfkYmkIQ6wQHTyjaOs8dgokHmvVL4EsKazZ4duge4qCJtXYZ+0UjMoN7UDyMaYdHKiwGL1/W38vrTQMoU/B2SAF2/BdzyMYTV5vXXD4iv/KF8BjFe7GpLApt/OmtvE0GqHAv2AYeXkZPOEtkkNvzTCn9qvMGR8ag6ienfpl80stk94Ry1DQOl8mbH6x8TGMuo2Yd1gxDT0yccu/zuJtVMnzM7bOJEssKa84=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(38100700002)(66946007)(316002)(110136005)(66446008)(66556008)(6512007)(76116006)(2616005)(6506007)(71200400001)(54906003)(64756008)(478600001)(38070700009)(6486002)(66476007)(4326008)(8676002)(8936002)(4001150100001)(7416002)(5660300002)(26005)(86362001)(2906002)(41300700001)(83380400001)(85182001)(36756003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emFkSWo0Ny9mR0FKWlh4d3dDa1FCOVY2dDMvc2g5OGpLY3Y3SmxYaEplUEpa?=
 =?utf-8?B?MjN6QmdGeWpPVnEwSCt3aXExVTJ0YU9TWUlTaUE4Qnc1SXBVRjhlUkIyUkhB?=
 =?utf-8?B?aWY3TEFhVVZvMWVsN0lqTDhEbmFuN2UyK25SREd5VnZHeXhGYkF6NUdkTUJT?=
 =?utf-8?B?Vk5ZVUUrdUJ0NXVFUDU5YXQ3S3BUajFoUWtiUEhBdDdOUEpNdUxXOGZTZk9k?=
 =?utf-8?B?NE9wLzQvakRvSUprVHFUMlAwTm5VYXdiRkxQZ09xbXNMRUx4NWRIak9Hdkwr?=
 =?utf-8?B?aE5qdC9WNGVoeERFb0pSZ3h6dHNXejRpeERkRHN2L3dTQkxpVUl3bXFHT1Iw?=
 =?utf-8?B?b1FleWRiTzJBSk5pRXp4Njd0NGkyV2NVekFzUVlJZ3NTVXphOHFPTE5lVVNy?=
 =?utf-8?B?NmhlazN6OUY2djBFWG03alAxaTBLWTFZdkppc2dqUEdPUzVhZFdteUxQM3Vn?=
 =?utf-8?B?akMyaGpmVDQrNStSblhVdnhGYTZCclBDQmM5MzloTGJ6VmVhSGdpYmZvbmdQ?=
 =?utf-8?B?d1ZlbU8zelUvcVlFTHZKWWRBOGJHSHJPU3ZoanB4bHFoZHorZzJEZTQ4cFRt?=
 =?utf-8?B?elQxMloxRU9keXlWMkNveVZFdS9Sd2lpMVkwVk9XTjZTWmxaQ3NsU2NWZXNa?=
 =?utf-8?B?VGtvZE1sR0lNOWR2bjZWNm80UG50QWFIeUkrUHVMbXVLZ1RSVDRvaFNmcmlF?=
 =?utf-8?B?K0ZXdVdIVkFLSnBXTzA0ZTF4V0pTU0JTY2hoWWhHbFFLTGNHOTRpRnF0a3Bl?=
 =?utf-8?B?aFV6b1VhdytHenpGcjIzTUJlWGhhNGorOHNBeXVMRFhHNmtNTDg3NHAyT2dx?=
 =?utf-8?B?TDNIdzJ5cjZXRng0U1JnNXcrMG4reWsxZFVRMzVmb3g0UE5tczZkR3F0MEVL?=
 =?utf-8?B?SXJJc3VaenBJa2RBeDBQa2Jzdlc5NlZtUkFqeVU2T0NuMisrQTdDaHNlQ0RF?=
 =?utf-8?B?SVhjZWdFalM5Z2ErOTNIT29ieXpIMnYrTDFPWmp3dE5peTNHeDJ4N2xiSElw?=
 =?utf-8?B?QjNTTTYwNVdMcFBvd1YyNm9WY1hGdkVjczdBNHNRbmFPWXkzOFBUNFdQMmdT?=
 =?utf-8?B?M29weXRJQk9lQUwzVUVYc2loUXpESTN2VjRDMzhxcTJod0pVNzlHUmFaK1Bh?=
 =?utf-8?B?NXUxTEFZOVJnQmI5S05aYml1Vmt4RStFTGRPVFhoM0hnWWtEOWw1VnNXNEZC?=
 =?utf-8?B?SC9vbnJ5TFBHcjg0NTZzd3g3NEhyZ3MwQ1hyaUNVWXVZcitNZFNuSGdoUXJz?=
 =?utf-8?B?NDE3WlhNUE1ySVR3OTNwYzd1WTMyWVVqMmU2cnZBTkdEMHhxU3pSTkFzd1Vw?=
 =?utf-8?B?ZFhIVkhhdXBSL0tLTUxsUzZPVmNGVXRUOVV0eno2QS9PWVh5RHdxYTdER05G?=
 =?utf-8?B?VG1ZeE0vN1R3UndDeFlrNkhmRE40dFRNZmh2cUYxSUMyaGZjSDFXQ3FJSkR1?=
 =?utf-8?B?U205cFVCdWJ4by82dlNtN0xUV0c5Ni9SMFhjc0RVOTNjVU9ZMXhtNnQ5R1o4?=
 =?utf-8?B?UWZWZW40eTVPeHAvZ1QwMEg0d1lzS29rQm1qMHdML2xYcm1BZ1UweEFpdGoy?=
 =?utf-8?B?cUVyUlRCYmYwQ2RMYWdsRFY5TThPbEQ4bkVIVWQ3bFlyWDJDZzdwa3ZveEpr?=
 =?utf-8?B?ZjhFL1hNN1ZoMTEwUE0xbWd3MUJPNEZxWTNBNTlCVzhzRGtsUGVUS01ZRERX?=
 =?utf-8?B?QjdQZERzQmR2aWJKbmloT0VXeUhKcWVpTk9ZU2JmREtCSU5BRUpTV2pNOHI1?=
 =?utf-8?B?K24xRVhhajkzSXlueG5URVYzb3hGWGtteThwbmw5ai83RjNMYVIzekFZZzVQ?=
 =?utf-8?B?VkcwR0g3UVJoeEdLV21Dbm0vdFJCbE5heXRMUUpHbzliUVZadk5DM2dpNnlM?=
 =?utf-8?B?RGpqajZCbW1NVTR3KzlFbkhuK0k1YUVCY3pmT0VCakF5YmxHeWxlUGY1Nktp?=
 =?utf-8?B?MUdxeGtVTmtUMUIrUm50STJYSEhnUzR6U2pZeDBsN1M0ZW9DQXJCQ0RFa2I3?=
 =?utf-8?B?TDNtMnVPcmVkZVNpRHkyWnBLcEE0K3hwMHo3TXgzOHNQWm9vLzVTNVRseEpp?=
 =?utf-8?B?YlArK2VqNkVDTjZCYmMwVHFpcWZ1ZWMvRk05RGJsYVBWVWE1TG5MV0VHRzB6?=
 =?utf-8?Q?WIZDk4em8+pbRZYqiLZZuMztU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <467F3EE280D43A4687B03569CEC5958C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7803b7a5-a6a3-443b-7c6c-08dbecb32bea
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2023 06:04:08.3101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gy7bB9+f5u5UUON5+xWLrynOkSLXhNCf2ej6S6XUxVievroz3jnk/LLutfPeR4CgocxJU7WB/gtVJ/2aR9IXhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7717
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--13.220600-8.000000
X-TMASE-MatchedRID: u7Yf2n7Ca/0/XHdICuW5r8AmcZEx8XHJMZpQS7dE0daxUZq4R85n78kU
        hKWc+gwPzjqJngvc26gd5e75RGwObSQVVteP90CtFYJUGv4DL3yZ2scyRQcer2I4wQ1Yq/d0Jxp
        QBrN5TwcyZsaIS6SCOcoEqppSYyJ3ZnD+ReIWrW0MH4SsGvRsA0opYlyHMD9xv8D7QPW2jo9who
        Ol0hGGnWsRPSp/FWsqKcCLQaAlV2N1ty+qQThQe935+5/2RxqmLAnNohUyMa34JyR+b5tvoHQ+I
        gV9Gazougm9TX6RNFpTCNJKBtcVsybhJjVR0U35ngIgpj8eDcDBa6VG2+9jFNQdB5NUNSsi1GcR
        AJRT6POOhzOa6g8KrRH54I16oehra0aYYoYl00qGSURVbbTgOUfZeQbZEQgIJNGRObeF7SU=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.220600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 4FF3D5C38808E5BA3C8E11EF63EB998195488C943A6E39AD3D9688509C4DB7152000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaWFvLWNoaWVuOg0KDQpDaGFuZ2UgdGhlIHRpdGxlIHRvIFN1cHBvcnQgYWxwaGEgYmxl
bmRpbmcgaW4gZXRoZHIuDQoNCk9uIFR1ZSwgMjAyMy0xMC0xNyBhdCAxNDo0NyArMDgwMCwgSHNp
YW8gQ2hpZW4gU3VuZyB3cm90ZToNCj4gU3VwcG9ydCBwcmVtdWx0aXBseSBhbmQgY292ZXJhZ2Ug
YWxwaGEgYmxlbmRpbmcgbW9kZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGllbiBT
dW5nIDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICAuLi4vZ3B1L2RybS9tZWRp
YXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jICAgfCAgMiArLQ0KPiAgZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19ldGhkci5jICAgICAgICAgIHwgNDggKysrKysrKysrKysrKysrDQo+IC0t
LS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292
bF9hZGFwdG9yLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2Fk
YXB0b3IuYw0KPiBpbmRleCA4ZGU1N2E1ZjU1MTguLmI2OWFjOTBiMmU2NSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4gQEAg
LTE1Niw3ICsxNTYsNyBAQCB2b2lkIG10a19vdmxfYWRhcHRvcl9sYXllcl9jb25maWcoc3RydWN0
IGRldmljZQ0KPiAqZGV2LCB1bnNpZ25lZCBpbnQgaWR4LA0KPiAgCW1lcmdlID0gb3ZsX2FkYXB0
b3ItPm92bF9hZGFwdG9yX2NvbXBbT1ZMX0FEQVBUT1JfTUVSR0UwICsNCj4gaWR4XTsNCj4gIAll
dGhkciA9IG92bF9hZGFwdG9yLT5vdmxfYWRhcHRvcl9jb21wW09WTF9BREFQVE9SX0VUSERSMF07
DQo+ICANCj4gLQlpZiAoIXBlbmRpbmctPmVuYWJsZSkgew0KPiArCWlmICghcGVuZGluZy0+ZW5h
YmxlIHx8ICFwZW5kaW5nLT53aWR0aCB8fCAhcGVuZGluZy0+aGVpZ2h0KSB7DQoNClRoaXMgaXMg
bm90IHJlbGF0ZWQgdG8gYWxwaGEgYmxlbmRpbmcsIHNvIG1vdmUgdG8gYW5vdGhlciBwYXRjaC4N
Cg0KPiAgCQltdGtfbWVyZ2Vfc3RvcF9jbWRxKG1lcmdlLCBjbWRxX3BrdCk7DQo+ICAJCW10a19t
ZHBfcmRtYV9zdG9wKHJkbWFfbCwgY21kcV9wa3QpOw0KPiAgCQltdGtfbWRwX3JkbWFfc3RvcChy
ZG1hX3IsIGNtZHFfcGt0KTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZXRoZHIuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZXRoZHIuYw0K
PiBpbmRleCA3M2RjNGRhM2JhM2IuLjY0OGUxNGU4NWJkMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19ldGhkci5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZXRoZHIuYw0KPiBAQCAtNSw2ICs1LDcgQEANCj4gIA0KPiAgI2luY2x1ZGUg
PGRybS9kcm1fZm91cmNjLmg+DQo+ICAjaW5jbHVkZSA8ZHJtL2RybV9mcmFtZWJ1ZmZlci5oPg0K
PiArI2luY2x1ZGUgPGRybS9kcm1fYmxlbmQuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9jbGsuaD4N
Cj4gICNpbmNsdWRlIDxsaW51eC9jb21wb25lbnQuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9vZl9k
ZXZpY2UuaD4NCj4gQEAgLTM1LDYgKzM2LDcgQEANCj4gICNkZWZpbmUgTUlYX1NSQ19MMF9FTgkJ
CQlCSVQoMCkNCj4gICNkZWZpbmUgTUlYX0xfU1JDX0NPTihuKQkJKDB4MjggKyAweDE4ICogKG4p
KQ0KPiAgI2RlZmluZSBOT05fUFJFTVVMVElfU09VUkNFCQkJKDIgPDwgMTIpDQo+ICsjZGVmaW5l
IFBSRU1VTFRJX1NPVVJDRQkJCQkoMyA8PCAxMikNCj4gICNkZWZpbmUgTUlYX0xfU1JDX1NJWkUo
bikJCSgweDMwICsgMHgxOCAqIChuKSkNCj4gICNkZWZpbmUgTUlYX0xfU1JDX09GRlNFVChuKQkJ
KDB4MzQgKyAweDE4ICogKG4pKQ0KPiAgI2RlZmluZSBNSVhfRlVOQ19EQ00wCQkJMHgxMjANCj4g
QEAgLTE1MywzMyArMTU1LDU5IEBAIHZvaWQgbXRrX2V0aGRyX2xheWVyX2NvbmZpZyhzdHJ1Y3Qg
ZGV2aWNlICpkZXYsDQo+IHVuc2lnbmVkIGludCBpZHgsDQo+ICAJc3RydWN0IG10a19wbGFuZV9w
ZW5kaW5nX3N0YXRlICpwZW5kaW5nID0gJnN0YXRlLT5wZW5kaW5nOw0KPiAgCXVuc2lnbmVkIGlu
dCBvZmZzZXQgPSAocGVuZGluZy0+eCAmIDEpIDw8IDMxIHwgcGVuZGluZy0+eSA8PCAxNg0KPiB8
IHBlbmRpbmctPng7DQo+ICAJdW5zaWduZWQgaW50IGFsaWduX3dpZHRoID0gQUxJR05fRE9XTihw
ZW5kaW5nLT53aWR0aCwgMik7DQo+IC0JdW5zaWduZWQgaW50IGFscGhhX2NvbiA9IDA7DQo+ICsJ
dW5zaWduZWQgaW50IG1peF9jb24gPSBOT05fUFJFTVVMVElfU09VUkNFOw0KPiArCWJvb2wgcmVw
bGFjZV9zcmNfYSA9IGZhbHNlOw0KPiArDQo+ICsJdW5pb24gZm9ybWF0IHsNCj4gKwkJdTMyIHJh
dzsNCj4gKwkJdTggc3RyWzVdOw0KPiArCX0gZm9ybWF0Ow0KDQpZb3UgZGVmaW5lIHRoaXMganVz
dCB0byBwcmludCByYXcsIEkgdGhpbmsgeW91IGNvdWxkIGRpcmVjdGx5IHByaW50IHJhdw0KYW5k
IGRyb3AgdGhpcy4NCg0KPiAgDQo+ICAJZGV2X2RiZyhkZXYsICIlcysgaWR4OiVkIiwgX19mdW5j
X18sIGlkeCk7DQo+ICANCj4gIAlpZiAoaWR4ID49IDQpDQo+ICAJCXJldHVybjsNCj4gIA0KPiAt
CWlmICghcGVuZGluZy0+ZW5hYmxlKSB7DQo+ICsJaWYgKCFwZW5kaW5nLT5lbmFibGUgfHwgIXBl
bmRpbmctPndpZHRoIHx8ICFwZW5kaW5nLT5oZWlnaHQpIHsNCj4gKwkJLyoNCj4gKwkJICogaW5z
dGVhZCBvZiBkaXNhYmxpbmcgbGF5ZXIgd2l0aCBNSVhfU1JDX0NPTiBkaXJlY3RseQ0KPiArCQkg
KiBzZXQgdGhlIHNpemUgdG8gMCB0byBhdm9pZCBzY3JlZW4gc2hpZnQgZHVlIHRvIG1vZGUNCj4g
c3dpdGNoDQo+ICsJCSAqLw0KDQpJcyB0aGlzIHJlbGF0ZWQgdG8gYWxwaGE/IElmIG5vLCBtb3Zl
IHRoaXMgdG8gYW5vdGhlciBwYXRjaC4gSWYgc28sDQpkZXNjcmliZSBtb3JlIGRldGFpbCB3aHkg
YWxwaGEgbmVlZCB0aGlzIGNoYW5nZT8NCg0KPiAgCQltdGtfZGRwX3dyaXRlKGNtZHFfcGt0LCAw
LCAmbWl4ZXItPmNtZHFfYmFzZSwgbWl4ZXItDQo+ID5yZWdzLCBNSVhfTF9TUkNfU0laRShpZHgp
KTsNCj4gIAkJcmV0dXJuOw0KPiAgCX0NCj4gIA0KPiAtCWlmIChzdGF0ZS0+YmFzZS5mYiAmJiBz
dGF0ZS0+YmFzZS5mYi0+Zm9ybWF0LT5oYXNfYWxwaGEpDQo+IC0JCWFscGhhX2NvbiA9IE1JWEVS
X0FMUEhBX0FFTiB8IE1JWEVSX0FMUEhBOw0KPiArCW1peF9jb24gfD0gTUlYRVJfQUxQSEFfQUVO
IHwgKHN0YXRlLT5iYXNlLmFscGhhICYgTUlYRVJfQUxQSEEpOw0KPiArDQo+ICsJaWYgKHN0YXRl
LT5iYXNlLnBpeGVsX2JsZW5kX21vZGUgIT0gRFJNX01PREVfQkxFTkRfQ09WRVJBR0UpDQo+ICsJ
CW1peF9jb24gfD0gUFJFTVVMVElfU09VUkNFOw0KPiArDQo+ICsJaWYgKHN0YXRlLT5iYXNlLnBp
eGVsX2JsZW5kX21vZGUgPT0gRFJNX01PREVfQkxFTkRfUElYRUxfTk9ORQ0KPiB8fA0KPiArCSAg
ICAoc3RhdGUtPmJhc2UuZmIgJiYgIXN0YXRlLT5iYXNlLmZiLT5mb3JtYXQtPmhhc19hbHBoYSkp
IHsNCj4gKwkJLyoNCj4gKwkJICogTWl4ZXIgZG9lc24ndCBzdXBwb3J0IENPTlNUX0JMRCBtb2Rl
LA0KPiArCQkgKiB1c2UgYSB0cmljayB0byBtYWtlIHRoZSBvdXRwdXQgZXF1aXZhbGVudA0KPiAr
CQkgKi8NCj4gKwkJcmVwbGFjZV9zcmNfYSA9IHRydWU7DQo+ICsJfQ0KPiArDQo+ICsJZm9ybWF0
LnJhdyA9IHBlbmRpbmctPmZvcm1hdDsNCj4gKw0KPiArCWRldl9kYmcoZGV2LCAiTCVkOiAldXgl
dSgldSwldSklczogU0NBPTB4JXgoJXUpLCBNSVg9MHgleFxuIiwNCj4gaWR4LA0KPiArCQlwZW5k
aW5nLT53aWR0aCwgcGVuZGluZy0+aGVpZ2h0LCBwZW5kaW5nLT54LCBwZW5kaW5nLQ0KPiA+eSwN
Cj4gKwkJZm9ybWF0LnN0ciwgKHN0YXRlLT5iYXNlLmFscGhhICYgTUlYRVJfQUxQSEEpLA0KPiAr
CQlzdGF0ZS0+YmFzZS5waXhlbF9ibGVuZF9tb2RlLCBtaXhfY29uKTsNCg0KSSBkbyBub3QgbGlr
ZSBwZXIgZnJhbWUgbG9nIG1lc3NhZ2UuIEV2ZW4gaXQgd291bGQgbm90IHByaW50IGJ5IGxvZw0K
bGV2ZWwsIGl0IHdvdWxkIGJlIHJlY29yZCB0byBsb2cgYnVmZmVyIGFuZCBkbWVzZyB3b3VsZCBz
aG93IGl0LiBTbw0KZHJvcCB0aGlzLg0KDQo+ICANCj4gLQltdGtfbW1zeXNfbWl4ZXJfaW5fY29u
ZmlnKHByaXYtPm1tc3lzX2RldiwgaWR4ICsgMSwgYWxwaGFfY29uID8NCj4gZmFsc2UgOiB0cnVl
LA0KPiAtCQkJCSAgREVGQVVMVF85QklUX0FMUEhBLA0KPiArCW10a19tbXN5c19taXhlcl9pbl9j
b25maWcocHJpdi0+bW1zeXNfZGV2LCBpZHggKyAxLA0KPiByZXBsYWNlX3NyY19hLCBNSVhFUl9B
TFBIQSwNCj4gIAkJCQkgIHBlbmRpbmctPnggJiAxID8NCj4gTUlYRVJfSU5YX01PREVfRVZFTl9F
WFRFTkQgOg0KPiAgCQkJCSAgTUlYRVJfSU5YX01PREVfQllQQVNTLCBhbGlnbl93aWR0aCAvDQo+
IDIgLSAxLCBjbWRxX3BrdCk7DQo+ICANCj4gIAltdGtfZGRwX3dyaXRlKGNtZHFfcGt0LCBwZW5k
aW5nLT5oZWlnaHQgPDwgMTYgfCBhbGlnbl93aWR0aCwNCj4gJm1peGVyLT5jbWRxX2Jhc2UsDQo+
ICAJCSAgICAgIG1peGVyLT5yZWdzLCBNSVhfTF9TUkNfU0laRShpZHgpKTsNCj4gIAltdGtfZGRw
X3dyaXRlKGNtZHFfcGt0LCBvZmZzZXQsICZtaXhlci0+Y21kcV9iYXNlLCBtaXhlci0+cmVncywg
DQo+IE1JWF9MX1NSQ19PRkZTRVQoaWR4KSk7DQo+IC0JbXRrX2RkcF93cml0ZV9tYXNrKGNtZHFf
cGt0LCBhbHBoYV9jb24sICZtaXhlci0+Y21kcV9iYXNlLA0KPiBtaXhlci0+cmVncywgTUlYX0xf
U1JDX0NPTihpZHgpLA0KPiAtCQkJICAgMHgxZmYpOw0KPiAtCW10a19kZHBfd3JpdGVfbWFzayhj
bWRxX3BrdCwgQklUKGlkeCksICZtaXhlci0+Y21kcV9iYXNlLA0KPiBtaXhlci0+cmVncywgTUlY
X1NSQ19DT04sDQo+IC0JCQkgICBCSVQoaWR4KSk7DQo+ICsJbXRrX2RkcF93cml0ZShjbWRxX3Br
dCwgbWl4X2NvbiwgJm1peGVyLT5jbWRxX2Jhc2UsIG1peGVyLQ0KPiA+cmVncywgTUlYX0xfU1JD
X0NPTihpZHgpKTsNCj4gKwltdGtfZGRwX3dyaXRlX21hc2soY21kcV9wa3QsIEJJVChpZHgpLCAm
bWl4ZXItPmNtZHFfYmFzZSwNCj4gbWl4ZXItPnJlZ3MsDQo+ICsJCQkgICBNSVhfU1JDX0NPTiwg
QklUKGlkeCkpOw0KDQpUaGlzIGlzIG5vdCByZWxhdGVkIHRvIGFscGhhLCBzbyBkbyBub3QgbW9k
aWZ5IHRoaXMuDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICB9DQo+ICANCj4gIHZvaWQgbXRrX2V0aGRy
X2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCB3LA0K
