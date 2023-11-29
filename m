Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46117FD022
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjK2Hxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjK2Hxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:53:37 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41351171D;
        Tue, 28 Nov 2023 23:53:42 -0800 (PST)
X-UUID: 6545a3c48e8c11ee8051498923ad61e6-20231129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Rpq2svbZ6bssw91dXP3JBNQU8gjoQ/aKUbMgpjpLcYY=;
        b=RBZeFTVsXEymZ0NTUbLI09VIW621sZvL3yIV6mIKIj9/IFg3Qj93ESHhmrdPiRx0R+iT2JSIKoCCzIlFBDV+LFVTXBGofWThpU/6Z0uUg93XCu2GE3hJBcAuf1DxuKLoI0Yr+j+I/9YPkNR9vIEEHau/D2YnZFWcISUJG324+mA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:8f9fab24-7143-4ba7-80c7-662ffa7ea26f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:abefa75,CLOUDID:32a13373-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6545a3c48e8c11ee8051498923ad61e6-20231129
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1251049124; Wed, 29 Nov 2023 15:53:34 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 29 Nov 2023 15:53:32 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 29 Nov 2023 15:53:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5zTSuqDv25nhXK14EYHlY9/eEx05GVFCHfFmWSx+H+rOIiEFU+1ixGOVYVr06nvBzALXqStbY5SswHwd1hTUhNfgnedeH3JlpI4WRS/6TpQo4TajeZRqfoLcl6GZKhc9Gtna182AppHV6QPFakrNbOfHF0jxFwfex/cOmVNhcoZRRlNKArMs/asKUxQCvZHlo+W6KhQdMFHtLI6C6ILcTiOu7zexCkIqYeKmJxMhs7IKt20UK7Te4NcEHla4SLzKGRPyGAKOcYweYlMxfXnfhQfMZEL28zQeeCRXxejks6WpUnlvrt/Ph58HHfu5U1kWZPF3ReEr8aakxUl1RUHXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rpq2svbZ6bssw91dXP3JBNQU8gjoQ/aKUbMgpjpLcYY=;
 b=NKFxUqIhkd/gzG8XtXmz/tVWVJD6GVXB06QdeJ/ZaNChyVF86ysDWLkbk2rPHJcCainDWth43nM19QvMw3JyrgUwDn3pznl/YAaV7I9wyIzqOuon8bAw7Sh/faknitWSFJJDedsaJWkvht9arJU0NdKvtpAsvrarLhJQRrZIVMkaORz872J+s+uk7Qeg5G5iMjFWrbPR0/AAgfehN+X8x8VlIIx+km1otHZKEvd8AzNuJeD+qRciH8iP5QArvNcffa8x2vIEq4YaU0g+eOim1QuT10o1E7weLFexE6Q/pNFvb+0Yfy/lFMFFXXtTXIosna/U5MCqokLEWeAiMVtOsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rpq2svbZ6bssw91dXP3JBNQU8gjoQ/aKUbMgpjpLcYY=;
 b=FOMOgy3xrxzHJ4bxYS/9MJF/lP306nCqfLeNzdU8CJztokwip7vW0hhe2MI/e4MZje4yKsgHgodZJC8+c6+gLz4vcd+hLtNDkhe3sHu98WNyePzG6OpZstS6yhGDh/DVweWLeI/EDKrpBQ9qQGOXeX4hHZWuJjN0zuJ3VIv9Enk=
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com (2603:1096:4:17d::11)
 by SG2PR03MB6612.apcprd03.prod.outlook.com (2603:1096:4:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 29 Nov
 2023 07:53:29 +0000
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::6a1:5b59:1d76:5ff8]) by SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::6a1:5b59:1d76:5ff8%4]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 07:53:29 +0000
From:   =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "treapking@chromium.org" <treapking@chromium.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ot_shunxi.zhang@mediatek.corp-partner.google.com" 
        <ot_shunxi.zhang@mediatek.corp-partner.google.com>
Subject: Re: [PATCH v2] mmc: mtk-sd: Increase the verbosity of
 msdc_track_cmd_data
Thread-Topic: [PATCH v2] mmc: mtk-sd: Increase the verbosity of
 msdc_track_cmd_data
Thread-Index: AQHaInBHFeQ6amFvZk+BAs/iUydAm7CQ7WYA
Date:   Wed, 29 Nov 2023 07:53:28 +0000
Message-ID: <672711916c437f95e8d7e5bf57d3b4cbbdaf8d1b.camel@mediatek.com>
References: <20231129025950.1579981-1-treapking@chromium.org>
In-Reply-To: <20231129025950.1579981-1-treapking@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6279:EE_|SG2PR03MB6612:EE_
x-ms-office365-filtering-correlation-id: 05435920-47b1-4352-3efe-08dbf0b04679
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fja1kH7W+znvHjodd5S3qR0HWv8DqGVopMtUB49jwyjzk48MvZHKErRspDtX0cUnErYXO5+pX7EDNyGNxXodHNyQbjpBwjIY4v3A19rAJPHLBcrzX1sLdA7SiRdL87lQCOT1+Z8hYh/9wo95FeStKUSlOEDepC7TjGTRUNw2KGKQ8BdVAFNCRhnQeCOdHEtads3mDCbSa/2h90I75gRpCw4vpb7C5g/tCokXpkq9rZYWMX6BtyP+RNnPc0kPnD9HFfMpfyvClJUdXcCrxW+OEshg8bvcko+q8/f079nMzM6KMprei7gybX6zNq6eIDmL7N5Usnnf1PBoQX88PX6WBFrF78ejZhjCa816tJu71fEbii60FpsQ6Tr7YWr3YRSp6b42zyHA09/FNDrOPAhiMnDG9NaVAC/6e5akhGw22Y5cnnWze481AXuBRJ6D8W+1oV6pQ9UuuP+SkM4HBMvGPCb41zKK0DRIT//NI6yg5fggf/DtmIfErQ8/EwAT5oBFnum0FzSyR115Y4P8rBcqiFHmMOdHTPCYhE0XGakLBMPEhiupvA0x5BlNTnk2nlV7eYTcccMGPXuH57R1gg5x7aiML59wim2WFjdl/Y5ytDSfcc8wqwlNW0UUhdpW7LbTqdsFZ8bLOczubGNYlp/WTbrVIzYQy6dWOUpcbJIEjpvl3c3XNO3GScWtcyxfDkoZIg+lM8UE0PxnbtNKeSadsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6279.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230273577357003)(230173577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(38100700002)(71200400001)(122000001)(5660300002)(6486002)(66556008)(8676002)(4326008)(6512007)(86362001)(6506007)(8936002)(66446008)(7416002)(66946007)(64756008)(66476007)(54906003)(110136005)(316002)(6636002)(478600001)(91956017)(76116006)(36756003)(85182001)(4001150100001)(41300700001)(2906002)(38070700009)(26005)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmVORURZRWdZdjNpS01TVmxUdUFUM3dQNzNRTW5rZ0xwckVDM3JMNHBwNHUx?=
 =?utf-8?B?Zm5KN3Rnb3JnQm9WMnBVMms4dFpBQ3RCelh3UFpWREZPZmhDdjZlVDU2Q0xN?=
 =?utf-8?B?aGFMc2xvNFo1U3BLKzJUemR2UnA0cVZHcXV2MWo4VUYxMHlQK2hSNDVzTnVV?=
 =?utf-8?B?eGtOK1FWa0xRQ0N0ZGhZWS9BYm1oQm5ZNzRqZ2I3Vi91MkEvMkk4UDZKUXdU?=
 =?utf-8?B?RDlGV29VUDQ2OU56Q1daM3hrZ2JvVmpRU1BUcFZGeTdRZ0htMDVQYVMzY0hB?=
 =?utf-8?B?bk1PdXJWd0xQYitUMW9TNDJmMEtQNFBKanB3NU5XMzRoWkVZelA5dmlEdzVn?=
 =?utf-8?B?SVc5V24rdldXVjYyUE5kMGpSVisyTHNJY1dEb2V4U3djRGw2VXF4RjNBdy9M?=
 =?utf-8?B?V3psWEp0OHF5ZlA1UEFHZ0xGYzBCRVZFZW5UU1Y2YzR3SE5iVnMyRHlNTjdj?=
 =?utf-8?B?Qy92ckh2cVJtNW9Hb3l0dFQ0M1ZKSFpWZVcyVHhVeEZmNUNZMlNHclhucHpS?=
 =?utf-8?B?aVlFdzVWamxYVmlBSG5tSmVJc0J4dWF2M0pUd1lMSURFc0lSQ0d5V2JPbjBS?=
 =?utf-8?B?Wks0YmxrVUJ6dUhXS2kzd1BrOVExZmpsR3p5K1JabGxxMXZhVGM2Nll4d1lD?=
 =?utf-8?B?dGpQYlpFWWxmdVJBT3ptV3FuQTQ1MmI2R1M1WDl0T2JzSzJrMzJobWpkVXQz?=
 =?utf-8?B?K0ZiUDd5OG5wRm05dFZIVXJRd2dQRENaQjdjZytFT3l1U3VXc2Zoa012ZkR4?=
 =?utf-8?B?ODYwTiswTVU5cVp1RlJma2RDWWhXTG1OeDhOSURac0pRcWV1L2xvVkg4SWt4?=
 =?utf-8?B?UkxxaGJYQlpMc200eWU1bzZEOGtFbWZ3MCtUekdDY2ovUHMvUmtHcHorQWNs?=
 =?utf-8?B?VlB0TmdqalczeVBzZSt4QUIyQzRuNWFaZFpHZ2F6cU1MMXdwVUo1by8vMTRp?=
 =?utf-8?B?SkJhT0p5UjJmSERvdTZFMzhvOXFBNERnN2NldzNaQ3lhQ0FQVEQ0Sy9OMWxN?=
 =?utf-8?B?NUk0MWM2QUtvS0QzN3RubnlLbHlkUXIwZWtsMW54YklVWUtRQStublUwaFVh?=
 =?utf-8?B?OTdSSlBnbFdzUzhUVE14S3BtVDBUc0cvL3RjdVR1alRFdGNtQm9OcHpXdGRD?=
 =?utf-8?B?WURSZkxUT01DKzNxOG85Y2loL2hHTVYydUFJM0RqVkZRVDQrTmFxbEpIVUxw?=
 =?utf-8?B?NnZkL3EveUtsWDlTK2JSa3hxZmNTaGVOV1JYWURUM1p0cU5qRnk2a0dVeUNB?=
 =?utf-8?B?clJCeWo5a043WUNUTENESStpR0Y3OW1odzdtNkFGcDgxZjdpUllIMHRqTkZU?=
 =?utf-8?B?M1plak9SWUNIVGNFdkk2SDBNbEdKbFdsR2JzYUZrZVN3TmNuRmtzbStzVzM0?=
 =?utf-8?B?anIwSjNucEdjdnBUU3hQMitjL1ZnNkp3RUNkZEpncjY0WTk3QWFZWXVPMzhN?=
 =?utf-8?B?KzJkNDFHM1VHL0FTcVd3M2VhSVgzbUo4N3BqZXFhRXEzUDhDL1RCTnpyenFk?=
 =?utf-8?B?WGdVdWhHeVgvVnpiMWxVb205SytEUWY2L2lHbmZENzVTTzRhanVFUHU1QnF1?=
 =?utf-8?B?eGZyL25hRERUdnVZSmx5ZjlEeVBFcDZTRi9QUGFYQ1Vxc21FMDBHOUFQb0RJ?=
 =?utf-8?B?ZkdOQTNNSDM2R3JEZk13MC9PWGNsaHJlMVhvUmpVbWtaTDVHVlR6SmUyYXFS?=
 =?utf-8?B?eFh5eVhjek9BVVZJR0dZM29TMTFtejFiaGd6RXhiZDZTcEd4VDc3ZU1wKzlq?=
 =?utf-8?B?TVd4bDh4OWhOVi8vZjZYOTVkVnRXMUFuOXNuV0M1MVVqVXl3bWIwRDNzWGZp?=
 =?utf-8?B?bFhqTjBmV29nQTJZNXQrWXl0WTdackhCamYzd2JwTnJ1SzNpd0dOZ1cyVEpS?=
 =?utf-8?B?eWUwc3ZGQW1rbnFwRlNHSWlHRU01bWo3ZFk1S2tiV2NRakkrZk9RbkhiZGVh?=
 =?utf-8?B?N3BuR09KMm9CTVY2RVo1VW1QT0VPUnU3ZkNHSkJtRVYzMEszRWh1NTFLQWY1?=
 =?utf-8?B?WnVXSldub1NDbGUzUFpaL2dMaG5rSkJxMjBENVZjb3BBbU8vUytqR1czSlhS?=
 =?utf-8?B?d0FXWEliTFFEdWFLc0xoSU03c0NSS0FWYkVSam5HK24xU3VVSU0yRVFLMEFT?=
 =?utf-8?B?N3MzMjR6TFdXUkdTcWpyN1BzVm5GYndHelRZclBkZFpFV3YrQTJDQVVwNTQ3?=
 =?utf-8?B?eVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33CDA67C1886A54D984D4DA573259C58@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6279.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05435920-47b1-4352-3efe-08dbf0b04679
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 07:53:28.9839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eu8VlR9jPlJVY6IF+WAmSfgPkmPcMj34zEis2DPJOcYcPuGIamWenji1YENB1Fb6Wwl5BHrHUvj9IBwYe93dbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6612
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--16.205900-8.000000
X-TMASE-MatchedRID: GBgFBUqwD4HUL3YCMmnG4pkEOBootbyljLOy13Cgb4/n0eNPmPPe5KWz
        WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2UIhTTahb7dWAfODDLypXmg6QlBHhBZuwbd9
        Z0z1GVDY9aV6V7qBHLuW0GrVa60NakKjL2IOi2LAbmaDSnOqZfhLXa2P1m93z2oLGTNKlb9drpG
        xdhTWQl/9h0DA2LlKc0F51m+Mkv33fr/48DfD8irdQIb8hCnY+fS0Ip2eEHnylPA9G9KhcvbLn+
        0Vm71Lcq7rFUcuGp/HCttcwYNipX/UrOTjR0Rj1doYHuWfteKjgVPn5QJc/NPPou5WNDMdsAdE5
        HdxW0D0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.205900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: F88F1E8A9541224446F4D8F32B00188DCD0FFD68CDE3FE3ECC58B336EC30E8452000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTExLTI5IGF0IDEwOjU5ICswODAwLCBQaW4teWVuIExpbiB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICBUaGlzIGxvZyBtZXNzYWdlIGlzIG5lY2Vzc2FyeSBmb3IgZGVidWdnaW5n
LCBzbyBlbmFibGUgaXQgYnkgZGVmYXVsdA0KPiB0bw0KPiBkZWJ1ZyBpc3N1ZXMgdGhhdCBhcmUg
aGFyZCB0byByZXByb2R1Y2UgbG9jYWxseS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBpbi15ZW4g
TGluIDx0cmVhcGtpbmdAY2hyb21pdW0ub3JnPg0KPiANCj4gLS0tDQo+IA0KPiBDaGFuZ2VzIGlu
IHYyOg0KPiAtIFVzZSBkZXZfd2FybigpIGluc3RlYWQgb2YgZGV2X2VycigpDQo+IA0KPiAgZHJp
dmVycy9tbWMvaG9zdC9tdGstc2QuYyB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21t
Yy9ob3N0L210ay1zZC5jIGIvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KPiBpbmRleCA5N2Y3
YzNkNGJlNmUuLjkwN2MxM2Q3NDZjMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9t
dGstc2QuYw0KPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5jDQo+IEBAIC0xMTUwLDgg
KzExNTAsOCBAQCBzdGF0aWMgdm9pZCBtc2RjX3JlY2hlY2tfc2Rpb19pcnEoc3RydWN0DQo+IG1z
ZGNfaG9zdCAqaG9zdCkNCj4gIHN0YXRpYyB2b2lkIG1zZGNfdHJhY2tfY21kX2RhdGEoc3RydWN0
IG1zZGNfaG9zdCAqaG9zdCwgc3RydWN0DQo+IG1tY19jb21tYW5kICpjbWQpDQo+ICB7DQo+ICAJ
aWYgKGhvc3QtPmVycm9yKQ0KPiAtCQlkZXZfZGJnKGhvc3QtPmRldiwgIiVzOiBjbWQ9JWQgYXJn
PSUwOFg7IGhvc3QtDQo+ID5lcnJvcj0weCUwOFhcbiIsDQo+IC0JCQlfX2Z1bmNfXywgY21kLT5v
cGNvZGUsIGNtZC0+YXJnLCBob3N0LT5lcnJvcik7DQo+ICsJCWRldl93YXJuKGhvc3QtPmRldiwg
IiVzOiBjbWQ9JWQgYXJnPSUwOFg7IGhvc3QtDQo+ID5lcnJvcj0weCUwOFhcbiIsDQo+ICsJCQkg
X19mdW5jX18sIGNtZC0+b3Bjb2RlLCBjbWQtPmFyZywgaG9zdC0+ZXJyb3IpOw0KDQoNCkhpIFBp
bi15ZW4sDQoNClRoYW5rcyBmb3IgeW91ciBjaGFuZ2VzIQ0KSW5kZWVkLCB0aGVzZSBsb2dzIGFy
ZSBuZWNlc3NhcnkgZm9yIHVzIHRvIGRlYnVnLCBidXQgdGhlIGNyYyBlcnJvcnMNCmR1cmluZyB0
aGUgdHVuaW5nIHByb2Nlc3MNCmFyZSBleHBlY3RlZCBhbmQgd2UgZG9uJ3Qgd2FudCB0aGVtIHRv
IGJlIHByaW50ZWQuDQpUaGUgdGltZW91dCBlcnJvcnMgZHVyaW5nIHRoZSB0dW5pbmcgcHJvY2Vz
cyBhcmUgdW5leHBlY3RlZCBhbmQgc2hvdWxkDQpiZSBwcmludGVkLg0KDQpTbyB3ZSBjYW4gY2hh
bmdlIGl0IGFzIGJlbG93Og0KaWYgKGhvc3QtPmVycm9yKSB7DQogICAgICAgIGlmICgoIW1tY19v
cF90dW5pbmcoY21kLT5vcGNvZGUpICYmICFob3N0LT5oczQwMF90dW5pbmcpIHx8DQogICAgICAg
ICAgICBjbWQtPmVycm9yID09IC1FVElNRURPVVQpIHsNCiAgICAgICAgICAgICAgICBkZXZfd2Fy
bihob3N0LT5kZXYsICIlczogY21kPSVkIGFyZz0lMDhYOyBob3N0LQ0KPmVycm9yPTB4JTA4WFxu
IiwgX19mdW5jX18sIGNtZC0+b3Bjb2RlLCBjbWQtPmFyZywgaG9zdC0+ZXJyb3IpOw0KICAgICAg
ICB9DQp9DQoNCkJlc3QgcmVnYXJkcywNCldlbmJpbg0KDQo+ICB9DQo+ICANCj4gIHN0YXRpYyB2
b2lkIG1zZGNfcmVxdWVzdF9kb25lKHN0cnVjdCBtc2RjX2hvc3QgKmhvc3QsIHN0cnVjdA0KPiBt
bWNfcmVxdWVzdCAqbXJxKQ0KPiAtLSANCj4gMi40My4wLnJjMS40MTMuZ2VhN2VkNjc5NDUtZ29v
Zw0KPiANCg==
