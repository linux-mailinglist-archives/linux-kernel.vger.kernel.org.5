Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718177CBCBA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbjJQHtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbjJQHtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:49:05 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF61F7;
        Tue, 17 Oct 2023 00:48:56 -0700 (PDT)
X-UUID: 9b6ab2106cc111eea33bb35ae8d461a2-20231017
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=VqWvR5V7AZlssi+Jn2dhQz3SmKM5WCMh+1lXwv6WnqA=;
        b=HmdFaR8aCKXc1e6msfID88QzA8ljx/QvIZQu/pIlFMXEl6e1/VwZ7Bo3gjJaxqdRIElq6ZbgrivyuK2uYN7H1K5muCY5BMyN1DRLeufaiANVOmzJLHFUzywMow9mFK57TBrIAmjY/bzuaAvJe0uu9Ms7KlIJb4RUCj7LRzZaWfs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:cd81f376-d460-44b9-82fb-1504e569cd05,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:017d06c0-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 9b6ab2106cc111eea33bb35ae8d461a2-20231017
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <jason-ch.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1070365962; Tue, 17 Oct 2023 15:48:48 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 17 Oct 2023 15:48:47 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 17 Oct 2023 15:48:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFdZA+F4ra7SVrieFMnzHbwtvtlqp1kIxzbySWM2uBVTbNmWundBoTidoLCezoaDeSKOEL0rlQHq3yz5eHYZ6DaA2wzqjdLIoRL+zExud8ZUa8mqS7HsTmUWFeFYuJfqpXBfWS5dzMmuokTwL32cXdGAUesAWGJR4VBsTPrk/z4SfDaYPiFEmvY/dho0V4KjPg1Rlp0d/i4oBbY2wDBbwPV6v+25irtIkyBiTRlm3zL/jgO5+md3AwSxJOyXYk1R5H1vbKLobLYGT5MQ9ozCrj/tmweCdKcGys5bHADI6xfyAWxveje82IAkqyKqB4lEVHt6E/jioOUueu6+BQMZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqWvR5V7AZlssi+Jn2dhQz3SmKM5WCMh+1lXwv6WnqA=;
 b=TvaJOwHwkEvsSeBX7UtU6cY1f076dcY3C7LYoiB1DQFDiSmxv6eooOA3qC/HLWiiJ3nIUGxmJqgIAFJGrLVEql4td0HUcYLbxlk4A5zl9zpAt1bBT0WX3CpNRlp/xgFtDUxkI8bf/QQZEZbYrHrqiGPOt8fILfRWRSQJMQodoDekXPZV4Zd3Th1IY99fQ57X4Q9z/pBYs7El1tLeNWBxkpCYTIf93uukOFn6wynZc9bfAojZonwaZCpymEjERV5I8w0v6DaGo17+/2RZg7rVdItI+WAimxzh4lxUg7QNcIxgiQe2gNLgsLtCniR4Ns7CNdQS/QpwFN0JM8YhEMccww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqWvR5V7AZlssi+Jn2dhQz3SmKM5WCMh+1lXwv6WnqA=;
 b=V05IXdGazV8CilB+Gg4HKse1Kl+VDHHw17xZ0AjPPC4c8IbbmAFSmDRg8E6X3aLhDhLtHEFHX91rVsSBm5y2J6ho9SMYuDHAEWkyFegLoaC3dGeLsNjgctLE6p25BhAph4f7WhB25UPcUYA7kaEJ1aAircY0Aq/j4LskmXUVZlo=
Received: from KL1PR03MB5650.apcprd03.prod.outlook.com (2603:1096:820:73::5)
 by TYZPR03MB5711.apcprd03.prod.outlook.com (2603:1096:400:74::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Tue, 17 Oct
 2023 07:48:44 +0000
Received: from KL1PR03MB5650.apcprd03.prod.outlook.com
 ([fe80::2af0:27:71c5:dd5c]) by KL1PR03MB5650.apcprd03.prod.outlook.com
 ([fe80::2af0:27:71c5:dd5c%4]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 07:48:44 +0000
From:   =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>
To:     "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RESEND PATCH v4 4/4] arm64: dts: Add MediaTek MT8188 dts and
 evaluation board and Makefile
Thread-Topic: [RESEND PATCH v4 4/4] arm64: dts: Add MediaTek MT8188 dts and
 evaluation board and Makefile
Thread-Index: AQHZ7FFalJ6zc1jmQUiVa/R6os7gALBMT++AgAF0IYA=
Date:   Tue, 17 Oct 2023 07:48:44 +0000
Message-ID: <7b2ab315d10e0e62fdf5597d0ca91346aa3db1df.camel@mediatek.com>
References: <20230921060235.32478-1-jason-ch.chen@mediatek.com>
         <20230921060235.32478-5-jason-ch.chen@mediatek.com>
         <3de3e2ad-382d-4e2f-8943-1cd284604ab7@baylibre.com>
In-Reply-To: <3de3e2ad-382d-4e2f-8943-1cd284604ab7@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5650:EE_|TYZPR03MB5711:EE_
x-ms-office365-filtering-correlation-id: db94194b-cadd-4bf5-f0ea-08dbcee57cf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l0Tu1S+RGnMd4Qn5NeqffVKXfKeZnvePjY5XTHFxWWNIx6xpCHYQ9BTSXxLftJP3ypN6fKDPGMHSHY+YysFhnqxKjl89LMBUude/6vpuqa8n3pLyBpuZrkawNd6lw+b3Xu/VbFnP+WojDac6DuVRn8SGb44+JuDhYqAGrRk7QaDhn1zxu5og4xwnBMC1jlVzKyJj6kHAEi1xysjpxTWUhz8qQ3Qju6PzgSD2UE8VabuzbD1IlkGzQxjbYVTHM027I6LYmkMGNWGUK6Z5dmitRqosUNAGvwoXTzbUYIbpDxITcBiNtn0y9enGX4+TKnxrrqeT+QZVAIIGoiwIM/kTLVToFuWKlTlcBDPvd+oKiGaBEfFh1A8EixHZiKIlgWWSGSxbmrmzkIFOJvxg17Bj9JWuTDLdeiMn2icliVb3n/TNDFXaP9TLYyUcaWndF2urQFMKkXz+pBcvflmTh/PxNnMdJa+8OnTNCq0AIcoEayo4y2/8NsFWOkyXY/vdwxyeSRbGUGPe397/XmoQLVYZepe/LPQYrrMlUbjff28zz3rCxQChaIsXNRVED1d5wQWtU3/UjySdsICjbb8lvV/SZ5lD6E+MXzfzSPA+dytUj4udU+w5O4v8bZqP+yy3FTmev53QUXDoBm1VmBm7/oY09A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5650.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(966005)(6486002)(76116006)(478600001)(2616005)(66446008)(66476007)(54906003)(316002)(110136005)(91956017)(66946007)(66556008)(6512007)(26005)(64756008)(6506007)(2906002)(8936002)(5660300002)(8676002)(4326008)(4001150100001)(7416002)(41300700001)(71200400001)(86362001)(36756003)(38070700005)(85182001)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWIyVWFqZ0czSjBWWXR1Qm1XRFg4NDZtazhsZDJnMVp4RFEwUWVGQzdBRkxH?=
 =?utf-8?B?a3kwUFIrcXFBY2FsbWZ4aTlrb0c5SE9CM0hDY1pOcld3Uy9OL0ZaYmxnaUtG?=
 =?utf-8?B?ZEpaQXBIQ0wway9LT2tDV1BZSTIvdkR5aFg0NFVkT3o4eE9zSkZGZFdhY2Jh?=
 =?utf-8?B?RXFuWmtaeDUwMjc0eUM5Qys4V1VZaG9QK051RDkwRkhQRXhPMFJoVmdYWGxR?=
 =?utf-8?B?L2F1OEU1NVpQWWZVV2pyQUNVVDFmNUhSV0RpSVpBL2d0QkhLZ3N4UnA5ZnhN?=
 =?utf-8?B?SXFpblNpdFhhL1VpbEpZa3d3L3h4dDNMWlAzZkFvZkk0Y0pTenQ2SjJOcW5k?=
 =?utf-8?B?Z0dHQnh0dnZZSzVPTi9aRm1aMCtEL3pXcTI0aTZaTW9Xa2pFdUpUeE0wcWhK?=
 =?utf-8?B?SEdTTmpRQ3JtSWxUdmhhQis2RG1YdXI0SFF6UFVEbCs3WnV0Q2UvQ3pCbnVS?=
 =?utf-8?B?cktGNWFyd2xFRzJBR2FPZkZXZlZhK1RjUHRhM2VoVzlYdVVERitXRlN3SS9n?=
 =?utf-8?B?RWVSOEhxcWtMcFZKSFpvaGw0L0hVeFl1bjZQRW4xU3RSZFRYa2NqeTh4SWZD?=
 =?utf-8?B?STloTDNDd1c1SVgzUUwzNHVScFRVMVZrTC9ucncyWFVkU0ZJeFg4YUNwVnlV?=
 =?utf-8?B?aU10c1pRQkp6T3JGV0xwUnZFTzRveDVyR0lva1NocHJwYkVKQVk1VDJVemNV?=
 =?utf-8?B?dlZha3JXSTIrMGFOQVVXNjh1V2pQOTVvM05VeDFrekZWWnFFTDU0QzhFQTQ5?=
 =?utf-8?B?cXNieUVBOGdHcGtneU5ZMkJjcG4xZ2RqNWFoR3JpelkzdU84N2pnOVRqaUZ2?=
 =?utf-8?B?SVlRZFNQMmxHWHJnTGQ2V2JsYm9zUnU5QVNlQlZLYjBkUTZ4K0cxWE5LRG5m?=
 =?utf-8?B?Sit0bEZwNkxGS3NSdkRaOGJEN1NXMW1IaGhaRkRqRmFIY09nWm9nSWEwdjF0?=
 =?utf-8?B?dlByMm1QS2g3d3k5NzZoMm0vUUJ1dzFIOTVCTlZCMDVHZTR3UndvWWhZSWZG?=
 =?utf-8?B?dHhnQ0Q4ZDZyNXdDWVhSRytnK3A4WVZDL2hWT3hSUkYxcXVTeisybW1MSU00?=
 =?utf-8?B?YUIrYU1Zamdya09PRW1QNnNHZkhLWnBpeXA1YlhXbTFQdXRQU2pjMU84ZUc2?=
 =?utf-8?B?VXhoOUxGVEFXMWZCL0U3K2FCMThkWW13OFArVnUwMmNrdFFPNlNOWlJJekI2?=
 =?utf-8?B?UWdQdjI3NkttWjkrMVdXZE1QUm4xd2F5dzQ3MHZsaSs0QWM4N3pOMWFnMEtV?=
 =?utf-8?B?ak5PcXZsYmhoNmphbVVYdHV2TzJPYVU0MlVVdnRJdFo4UGR2OEdQWVgwVDFY?=
 =?utf-8?B?ZWlWN2NKVVdsQTBKWnVRQUhUbVdoN1ZNMncvUmpEd0w1QkJXMjhJNXhDb3hT?=
 =?utf-8?B?RlRzQTlWbkhZUEo4QnBHTTY1c3JPQjNOUm5YTGpwNjc2SDd3M3lnbko1Rmsz?=
 =?utf-8?B?bjMyK0dZRnpuZmlpbldlQXJIYVc4Q2QyY0tsMktwVmQ3Wk9XRksrWlRoRW5U?=
 =?utf-8?B?d2V4TzU5NWpHbkxxV3kzSXFxemlQeDdPQnpGYlJod2VkelB4T1FwU2VNTERI?=
 =?utf-8?B?T2tLQ283RngyTmFhc1g0WVNQRWxQWUd5T21zYk9QS1ZVZkVlU05TTndmbXJH?=
 =?utf-8?B?Rk9iVkxCSWl0QVNGZmt4encrNnhmNHFyYkpzeHYyS2N1Qzg4NHdua0E1L25N?=
 =?utf-8?B?Z2dpY0JGZjZPcUpyRGkrb2FOdDQrMlhScm5KTzYxNkpXd0t3clkva1l2V2hX?=
 =?utf-8?B?bDNYb2hNcG1EbkwrWjJqUGQrWGVKQ2ZKbFhhWis4ZE5qcjdrOFdROVY5Skdv?=
 =?utf-8?B?R3dUZzBzK2tvcGJIMHd0cGFpNDE5Sm5JMHFUVFJnUHpPMzUrVVV0Tjhkc3Uz?=
 =?utf-8?B?ZndSS281aVVxWmJYOWxiQjlPU253dnVoL0l4WWc3alJUSXFIVzRsbE1IZlRV?=
 =?utf-8?B?cm1HOEttNHlaRzdxRkVPcVQ2WklTMzAzTHlQUW1lK3FtNVJ0cmFWQ2hQSnRq?=
 =?utf-8?B?V1BpOUVXRHMvS0dUTm9LYU9pWDN4ZzJMS2J4RW54bjVkK2pkZDE0QjhSOWFZ?=
 =?utf-8?B?Y2N0Y0RnZVFrRncvbzRBeS9ZRGYxYlpWcVk4d0ZkUE1WWXVJM0F6UHgwd0Rv?=
 =?utf-8?B?MTJTaHFGaTFjeDRQVUtUdlJzWlhJekNhOXhZai95MjR1NlBGY1N4VmpaUlBx?=
 =?utf-8?B?SWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <665E078894134549B009A298D87AD9E4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5650.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db94194b-cadd-4bf5-f0ea-08dbcee57cf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 07:48:44.2375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWz5+77ttSM5z9gZRKl87V5cmB8V12M2R987zREPuOzKGKShcl1af7ZQsP/puZZO4aJkOdFZhwtx8UtNTI19ONWukP5Voy0VNjyjC21YeDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5711
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--25.104300-8.000000
X-TMASE-MatchedRID: GBgFBUqwD4HUL3YCMmnG4t7SWiiWSV/1jLOy13Cgb480C8Dp8kkTtYCu
        qghmtWfX1nBs5d2g+EE/3c1x13eUfIPhXvvZBernEroQVzSW9XQMJ78s6JmULczGeKvj1DcIAaf
        Z8kyiagfM/98aI0xgdf2CsQy5o+e9MrjYlVK+7cBH4a2iJdV4MTFcf92WG8u/Ri9INZ1ZpGEIsZ
        Y5ECFjxx7Hl2TDndS/D43y5K7ySLDZkbbvIpCxvP2/xxdgfqR+U+A7YkpDJ1g3nZaS9VtZrqPFj
        JEFr+olFUew0Fl/1pE9wJeM2pSaRbxAi7jPoeEQftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--25.104300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 416CFBB604332B4FB9DFBDCCBA3A1D58C213692F4EB5D63CBE88E5B5884C9EAE2000:8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxleGFuZHJlLA0KDQpPbiBNb24sIDIwMjMtMTAtMTYgYXQgMTE6MzYgKzAyMDAsIEFsZXhh
bmRyZSBNZXJnbmF0IHdyb3RlOg0KPiAgCSANCj4gDQouLnNuaXAuLg0KPiA+ICsmbXQ2MzU5X3Zi
YmNrX2xkb19yZWcgew0KPiA+ICtyZWd1bGF0b3ItYWx3YXlzLW9uOw0KPiA+ICt9Ow0KPiA+ICsN
Cj4gPiArJm10NjM1OV92Y24zM18yX2J0X2xkb19yZWcgew0KPiA+ICtyZWd1bGF0b3ItYWx3YXlz
LW9uOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArJm10NjM1OV92Y29yZV9idWNrX3JlZyB7DQo+ID4g
K3JlZ3VsYXRvci1hbHdheXMtb247DQo+ID4gK307DQo+ID4gKw0KPiA+ICsmbXQ2MzU5X3ZncHUx
MV9idWNrX3JlZyB7DQo+ID4gK3JlZ3VsYXRvci1hbHdheXMtb247DQo+ID4gK307DQo+ID4gKw0K
PiA+ICsmbXQ2MzU5X3ZwdV9idWNrX3JlZyB7DQo+ID4gK3JlZ3VsYXRvci1hbHdheXMtb247DQo+
ID4gK307DQo+ID4gKw0KPiA+ICsmbXQ2MzU5X3ZyZjEyX2xkb19yZWcgew0KPiA+ICtyZWd1bGF0
b3ItYWx3YXlzLW9uOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArJm10NjM1OV92dWZzX2xkb19yZWcg
ew0KPiA+ICtyZWd1bGF0b3ItYWx3YXlzLW9uOw0KPiA+ICt9Ow0KPiA+ICsNCj4gDQo+IFRoaXMg
aXMgYSBsb3Qgb2YgYWx3YXlzLW9uIHJlZ3VsYXRvci4NCj4gSXMgaXQgcG9zc2libGUgdG8ganVz
dGlmeSB0aGVtPyBNYXliZSBzb21lIG9mIHRoZW0gc2hvdWxkIGJlIGp1c3QgDQo+IGluY2x1ZGVk
IGludG8gYSByZWxldmVudCBub2RlID8gRm9yIGV4YW1wbGUsDQo+ICJtdDYzNTlfdmNuMzNfMl9i
dF9sZG9fcmVnIiANCj4gY291bGQgYmUgaW50byB0aGUgYmx1ZXRvb3RoIG5vZGUgcmlnaHQgPw0K
PiANCj4gQW5nZWxvIGFscmVhZHkgd3JvdGUgbWUgYSBmZWVkYmFjayBhYm91dCB0aGF0IGluIHRo
ZSBNVDgzNjUgc2VyaWU6DQo+IA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2ZmNzI5MmYw
LTkwNTUtMTc4Ny0yNTQzLWUyMTlmZTMwZGRkZkBjb2xsYWJvcmEuY29tLw0KDQpUaGFuayB5b3Ug
Zm9yIHBvaW50aW5nIG91dCB0aGUgcHJvYmxlbS4NCg0KVGhlIG10NjM1OV92YmJja19sZG9fcmVn
IGFuZCBtdDYzNTlfdmNuMzNfMl9idF9sZG9fcmVnIGFyZSBub3QNCm5lY2Vzc2FyeSBpbiB0aGUg
ZXZiLiBUaGUgbXQ2MzU5X3Z1ZnNfbGRvX3JlZyBpcyBhbHJlYWR5IGluY2x1ZGVkIGluDQp0aGUg
bW1jMCBub2RlLiBUaGVzZSBub2RlcyB3aWxsIGJlIHJlbW92ZWQgaW4gdGhlIG5leHQgdmVyc2lv
bi4NCg0KVGhlIHJlbWFpbiBwb3dlciByYWlscyBkbyBub3QgaGF2ZSBzcGVjaWZpYyB1c2VycyBp
biBsaW51eCBrZXJuZWwsIGJ1dA0KdGhleSBhcmUgcG93ZXJlZCBieSBDUFUvQ09SRS9hbmFsb2cg
YW5kIGFyZSByZWdpc3RlcmVkIGluIHRoZSByZWd1bGF0b3INCmZyYW1ld29yay4gVGhlIHJlZ3Vs
YXRvciBmcmFtZXdvcmsgaGFzIGEgcG93ZXIgbWVjaGFuaXNtIHRoYXQgc2h1dHMNCmRvd24gcG93
ZXIgcmFpbHMgd2l0aCB1c2UgY291bnQgaXMgMCBhZnRlciAzMCBzZWNvbmRzIG9mIHN0YXJ0dXAs
IGFuZA0KdGhlbiBDUFUvVGhlIHBvd2VyIG9mIENPUkUvYW5hbG9nIGNhbm5vdCBiZSB0dXJuZWQg
b2ZmLCBzbyB0aGUNCnJlZ3VsYXRvci1hbHdheXMtb24gcHJvcGVydHkgaXMgYWRkZWQgdG8gdGhl
IGR0cyBub2RlLg0KDQo+IA0KPiA+ICsmbm9yX2ZsYXNoIHsNCj4gPiArc3RhdHVzID0gIm9rYXki
Ow0KPiA+ICtwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiA+ICtwaW5jdHJsLTAgPSA8Jm5v
cl9waW5zX2RlZmF1bHQ+Ow0KPiA+ICsjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gPiArI3NpemUt
Y2VsbHMgPSA8MD47DQo+IA0KLi5zbmlwLi4NCj4gDQo+IC0tIA0KPiBSZWdhcmRzLA0KPiBBbGV4
YW5kcmUNCg0KUmVnYXJkcywNCkphc29uDQo=
