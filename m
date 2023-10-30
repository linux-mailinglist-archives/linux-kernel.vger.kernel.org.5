Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0207DB329
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 07:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjJ3GTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 02:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjJ3GTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 02:19:50 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F3A9C;
        Sun, 29 Oct 2023 23:19:43 -0700 (PDT)
X-UUID: 4c27439676ec11eea33bb35ae8d461a2-20231030
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=PYfi3bAoc2w0jtsMCr2QQqPTWUi7q5L3C+exMo2bXt4=;
        b=PKrCVczMwLH4nRuwVcGBbY1haRpsVED3ZIzr97mOfF5NWP2zbAtmzisa2iD7P8LGLIyahlGbyjktUJiPZF77fAUPBty4I/6nOuiTrGco7mQ8l3nrv/6jesBDhVxQ6aKOsdlZikcuK9fnsPprwYHzd+cXJtbKS6FN/TzEmLW9cCo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:818608e8-0971-4b56-8d7b-3085bf2c65d4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:148d0b72-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4c27439676ec11eea33bb35ae8d461a2-20231030
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <chun-hung.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1777822525; Mon, 30 Oct 2023 14:19:35 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 30 Oct 2023 14:19:34 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 30 Oct 2023 14:19:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjzDLm1+elXEqVtbTI5X9GmC93ZbpaJ47Z/t/usF5+CvNZvmithsHAV/AHQkpiZGCoZAV8CmWj48SwrNkDUPwb9xhh4qWn8hY/lT0xSc01ugygUKewqY90TBqUTJVDcNbPvUI/PDpszjym18JUDCUAhpTdSp/XfXatXBCPEAE/sNOmnPCwDJ5zqseXo5g88tasBQKYjXGh1oDofEz5fJP3g9RqXppXg9nKykQFc7XFeKRnRwe7kr664mAgR3fp5KzwMN2QKGjj+HpD9V7h3B+Rg19hkuH4RZYZFvYh7mSQ1KZKGSshxfJCmIfkFDsTCaOM/VuXkdNR68HbkH50/faw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYfi3bAoc2w0jtsMCr2QQqPTWUi7q5L3C+exMo2bXt4=;
 b=K7FEHdbc1/h/xSYmhuoBX/VPbWxZPMG2ElNwzPnHAIXC21NQsys8zieJiiS48j4M9d9XBVSEH3mgHVNsqjpp2zDvhYaKE3t4VesmGtl9vETdJvZjuoydWFe20gDJvHoSqWd3//Uq8qujiWRZ0TTZH45BfNfwkugoi0Mp/vTmkyR5hE01xAvrONU1Ox4lFBirgUQOOjJOJpC/WuoUCBe/YAvme2S2ybA/kQ6gJltcYl3OcLUfinwzIfvVoD+ITOlxb+5Db8GUPDefX6zwrHgubQSqLf7Kg+dPtXieiar9k7fgVDf6FVVK4+jlJFo6g5OOqF6h7+FHrgVx12wjXYXYlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYfi3bAoc2w0jtsMCr2QQqPTWUi7q5L3C+exMo2bXt4=;
 b=rgUBXloEay5zJbJ9iaskvEEx4xYn038PXzxTXwG3IOnsj2f2Ey260SsrI9E1g7FbxvPevYyQrnfGsH7TgZa+wLsYPz5KGl110QJf6WgQ20I3T2lvd6kivy0AtRAC/VWaVjYyJqcbIH7DvHGHU93x5cvNbg23FFcyhgjRVlTlhK0=
Received: from TYSPR03MB7350.apcprd03.prod.outlook.com (2603:1096:400:413::14)
 by SEYPR03MB7166.apcprd03.prod.outlook.com (2603:1096:101:d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 06:19:31 +0000
Received: from TYSPR03MB7350.apcprd03.prod.outlook.com
 ([fe80::4604:35b2:5434:cc1a]) by TYSPR03MB7350.apcprd03.prod.outlook.com
 ([fe80::4604:35b2:5434:cc1a%7]) with mapi id 15.20.6933.026; Mon, 30 Oct 2023
 06:19:31 +0000
From:   =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>
To:     "ebiggers@google.com" <ebiggers@google.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "Arthur.Simchaev@wdc.com" <Arthur.Simchaev@wdc.com>,
        "keosung.park@samsung.com" <keosung.park@samsung.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "yang.lee@linux.alibaba.com" <yang.lee@linux.alibaba.com>
CC:     =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= 
        <peter.wang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?SmlhamllIEhhbyAo6YOd5Yqg6IqCKQ==?= 
        <jiajie.hao@mediatek.com>,
        =?utf-8?B?Q0MgQ2hvdSAo5ZGo5b+X5p2wKQ==?= <cc.chou@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?QWxpY2UgQ2hhbyAo6LaZ54+u5Z2HKQ==?= 
        <Alice.Chao@mediatek.com>,
        =?utf-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= 
        <eddie.huang@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        =?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        =?utf-8?B?VHVuLXl1IFl1ICjmuLjmlabogb8p?= <Tun-yu.Yu@mediatek.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        =?utf-8?B?TGluIEd1aSAo5qGC5p6XKQ==?= <Lin.Gui@mediatek.com>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        =?utf-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?= <Powen.Kao@mediatek.com>,
        =?utf-8?B?TmFvbWkgQ2h1ICjmnLHoqaDnlLAp?= <Naomi.Chu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?UWlsaW4gVGFuICjosK3pupLpup8p?= <Qilin.Tan@mediatek.com>,
        "kernel-team@android.com" <kernel-team@android.com>
Subject: Re: [PATCH v1 1/1] ufs: core: Add host quirk
 QUIRK_MCQ_EXPAND_QUEUE_SLOT
Thread-Topic: [PATCH v1 1/1] ufs: core: Add host quirk
 QUIRK_MCQ_EXPAND_QUEUE_SLOT
Thread-Index: AQHaB26oJLt4wBp9JU6b9Mq1SfN0NrBc/BUAgAEk2ACAA8JKAA==
Date:   Mon, 30 Oct 2023 06:19:31 +0000
Message-ID: <bb1e65a60d16a5a3ffd665eb6b84fc91f9baae91.camel@mediatek.com>
References: <20231025085656.10848-1-chun-hung.wu@mediatek.com>
         <20231025085656.10848-2-chun-hung.wu@mediatek.com>
         <3056c6d8-1e54-4954-9141-e0760a0d935a@acm.org>
         <53d7d12bc12237e5f86522faf09876ab08ef7592.camel@mediatek.com>
         <a16dc8ba-ca3b-4dd6-a8b5-dbb3ac7a49a5@acm.org>
In-Reply-To: <a16dc8ba-ca3b-4dd6-a8b5-dbb3ac7a49a5@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYSPR03MB7350:EE_|SEYPR03MB7166:EE_
x-ms-office365-filtering-correlation-id: 716ca101-e709-4997-0aec-08dbd9102dc2
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZnLe1RHprQ8i4hfMnvDahctYKsSE9dd6gWFl+9DhFZBmBdI/qluKKChg10yB2vPvzGob4eaDQNarewJaa08TDcrpo9s39a6WIBXYnkVlm4QkU35d1oVejpDcXOzMVr3O8eTMiyNnr7QTbztqevWynVGtVn+TbUjaK/mommFgvNS4o75o0ZK0E8I0xPB71wKTB3+EDyPFGiD4gUsZlhxzwGBOEo817PbH+oWk7H7eP+o+H4hNFYmAq3HYYFSiF0emQsQdU4T55a+js/UsZJQ+e2oIOcRL+2tTgmO8Uh3lScTS6pv9lDMA6RSmgCNHqcu6uXYWdmsWzdYKM/+mUbws2OZ81cv7pDvAL8+tl1N7hNo6AfbcPE89jttBvci3IYZklGj1z4pHb8AZRDxRx9UjZKAOn3epxbbuNAm/LQKa+MY1pNe5U165GoKSAhuxjp6BsY/JBQpmqGtf3bznHu+6x2t9MkZN8PQmu9qrT3zNOjBDDl1haexkpqumqcSJKjR7E6FEuL4TWOVETVADxA5KfbGHRwfCDwBvw6vOOuJz6WLcP/LRB02aMALtGMb1/HwkNhefAFauTw/+OkWcaEOyyLhGARQe/FBH7x665bettUolPH69POhpXJtlxQfK23nPkL3sJIGqyjBmCsaRomrx3UiPlvI7GhuBZKz+cki0US6cDac15zRo+yjbsJEI1DMoyVkAn/nDl+E2fR3UyM3PWr5rI0fEMx/frDPj0gwix+M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR03MB7350.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(230273577357003)(230173577357003)(64100799003)(186009)(451199024)(1800799009)(6512007)(26005)(2616005)(53546011)(6506007)(478600001)(71200400001)(41300700001)(6486002)(2906002)(83380400001)(7416002)(66556008)(110136005)(66946007)(5660300002)(76116006)(66476007)(66446008)(4326008)(8936002)(8676002)(54906003)(64756008)(316002)(38070700009)(38100700002)(122000001)(921008)(86362001)(36756003)(85182001)(4001150100001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3dzWnNZY2ZXa3VOWG9nY2pPNzlDYmJJYnVySjJBc3JmV2xSeDFsYXY0RU9E?=
 =?utf-8?B?d28vNzh2d0ZLUk9jOUpTbnI4NzY4TlBIeU1yYjVFT2lELzlqYWlaVTFpem04?=
 =?utf-8?B?M2xsLzJyNWFvSXBNYVJ6MlQ0MTZ0OTZKMTZyQzkwdkszZCtLakljMnJIdHhk?=
 =?utf-8?B?bXNvYlcxN3dsc2NuZm5reFY0UjNXeXFabW9UK0dXcTNVeXdrNERMMS9QaURT?=
 =?utf-8?B?K0ZkRXhUZ0hlSEd4OWtLY0w2Nk9qNWRkQmxraG01d3VVSDc5eFVCSnJYL0p3?=
 =?utf-8?B?b0JJYjltZmxqUVRjZjlWckJjSThCUGJHRDhTZ3hMQ1BsKzdJS3BQeWNLbkJV?=
 =?utf-8?B?WjFZdG41ZWVpVFBxTlN0ams3UzB3QldaanFHVGtUSlpUc050ckJhUUlsNzRu?=
 =?utf-8?B?dW1sa0gwZ2hlTTJZZ0kxQTVjRFpUcTVyYnRyTll5aW5KS2xwWHZDbUEwV1BL?=
 =?utf-8?B?bmxCT3BzbjNPQU1Xc29BakFOTnlzNjc5MkxoeGZEMjBjdWdoTTlOQ2ZBZkZW?=
 =?utf-8?B?UWNFUzRTdDcyN3A0NmNQSldLc3o1MlNneU9BT2xZaisvY1FxUGt2Rm9WZ1BM?=
 =?utf-8?B?VkdXOVQ4NStCdEVXYmVEUjZPYjZ2OVdaZVBHcVp1K2N1azRpZXM4RHRuS29t?=
 =?utf-8?B?TUg3dVVNUWdjVXR0ZXFTcGQ5MFAwZWtFM1c0bnZueDhGcHhPZ3MrZlRDc2FL?=
 =?utf-8?B?VFlhYk44RE8zNHMrN2hZUkZlSnVKRzI0RTY5MGFwSThIZFNnTXhxSU1SOTRi?=
 =?utf-8?B?a1lRNWF2cXVOUk8vQ3NvVTRVdE8vN1V1Sm5vU0NoMWJoOHBzUXZhd3hIdjVF?=
 =?utf-8?B?OTR0Y3FQTEZXUENoZkk3TlFTR2NTaWtGcUp6VW5CcVlrVVlGekpDWHd1OExy?=
 =?utf-8?B?blJvSDhCMHh5L0dtOVJhWHVzTnl1Vi9jZzEwTDNEODBidml2bllYbVdwYTI5?=
 =?utf-8?B?dUJDYkV5WjhWYlhjU2VpREtVK204QSs0a3VHOW1DMXFXazAvblIvc0pyTFFy?=
 =?utf-8?B?bGtOcDFpVEptT1F4ZWMrNlY2WFNUSURIcmQyQkFFT3c1SHhaMWYyaE1DR1lZ?=
 =?utf-8?B?TGRwRnFscEM2aXM1Q29vbmZ0cVZxMnl4T3pPakZZa096SG5oZlJQM1hPYkFi?=
 =?utf-8?B?VXIweGszVDMzN3o3ZkRZendieVZBaGlrVlBtWU1BdFNYa3QremdLbjRENTh1?=
 =?utf-8?B?YmtVT2JNdDdzcURCOXUraGZjV1krWmNadFJUSDF1MU9nRkRmNXY5WmhrTnlt?=
 =?utf-8?B?TDI3cDZ6V2MxSzZCOUExazJtbEdEcDd6elZLZG5Za1ZUbGVmdU5nOXF2Zzh2?=
 =?utf-8?B?MUpsOHU5eDZ3aE1XZkhiVnZ2R0JYcjdFSnkyVThrN2xSVUVmc3FMTnFqZ2p2?=
 =?utf-8?B?N2lrNFFpd2dCNnhyMVF6QUE5L3hIUlBSUGVlUHUyVmc4T05kUHBLVUJOeWc2?=
 =?utf-8?B?dUg2ZnRoR3BHNHl3cGEvcVF6VnlvSURrNzkyRnVZa1BFTFgzSEE1c3hsbUFX?=
 =?utf-8?B?cmRMQ0IzQVUyNHNBRWV2S3dEcjNPSHVYZTJTdmJSNHlsSzhqaENzY0dtZUhv?=
 =?utf-8?B?MElreDhEOTUxRzRIRnBNRWV4dE5FOUFNZHB2UmZIVXZ4Ujk2N0FWNlZuR3Rw?=
 =?utf-8?B?YjlqUndqbk54WUNpTldBa0VMWEFnMWplWW8xcXN3NGRmNG9iQVhueVFZUk9q?=
 =?utf-8?B?MkFIUnB4azBFMjhFNytGOGpWU2krL2huSXVubXk2Y3VmTlBwaDh1d3BGd1NH?=
 =?utf-8?B?QzhmVFBoN3NoT0VBTFp2UEJ6Zm14SGVidnhJeUVVMWtXMnFXcVZTVWRIR2Ur?=
 =?utf-8?B?NVdhZ1dRRzVPVDMvK00wNmVic0ljNWJaR2NCbEJhTHFGQ3JmMy9IUXFMUHgw?=
 =?utf-8?B?SktCOXlwZGlXNlZPbmlUUGtSZnRmdlFybm52UmcvOEJ3RFVBSS8yNENmOGtw?=
 =?utf-8?B?ckJrUDNpamxsdUNxOWFoWWR6NG5rUE95YWZCcjQrdXN4T09JRFRZa0FsbzRL?=
 =?utf-8?B?MlZpVm9URnkyRDlHZWc3ZHdKaXQ5enZ5VFZpMjdDSWplQ3RhSy9SenRwdTRR?=
 =?utf-8?B?K1duZEJkcjZzSThsMEQ4QXRCcGJGeGl0d3AzUGRyMENWalk2MndPWnZmL3l6?=
 =?utf-8?B?MTJ4dE5uTFhWYVB5UExqb2hnV0YvRTBVYUIrem5iekxSSVlxUjVZcFdNenhn?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <311F78862DF0D54BB5E9D52E662CA5F6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYSPR03MB7350.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716ca101-e709-4997-0aec-08dbd9102dc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 06:19:31.3188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: menbHkFcXablOzs9UXBQVZaWuWub3agoQR8p+iAEV3rfroKzyudSQewfMJCgFOWvVHsIJ3Us1NuKE0dJ5+tdu4ik87Ixxp4CFYdUZ7xXKOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7166
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTEwLTI3IGF0IDEzOjU1IC0wNzAwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6
DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9y
IHRoZSBjb250ZW50Lg0KPiAgT24gMTAvMjYvMjMgMjA6MjcsIENodW4tSHVuZyBXdSAo5ber6ae/
5a6PKSB3cm90ZToNCj4gPiBGcm9tIFVGU0hDSSA0LjAgc3BlYyAiV2hlbiB0aGUgaGVhZCBhbmQg
dGFpbCBkb29yYmVsbHMgYXJlIGVxdWFsLA0KPiB0aGUNCj4gPiBxdWV1ZSBpcyBlbXB0eS4gKk5v
dGhlIHRoYXQgdGhpcyBkZWZpbml0aW9uIG1lYW5zIHRoZXJlIHdpbGwgYWx3YXlzDQo+IGJlDQo+
ID4gb25lIGVtcHR5IHF1ZXVlIGVudHJ5Ig0KPiA+IE9uZSBvZiBvdXIgcGxhdGZvcm0gZG9lcyBu
b3Qga2VlcCBvbmUgZW1wdHkgcXVldWUNCj4gPiBlbnRyeSBmb3IgQ1EgZnVsbA0KPiA+IGNhc2Us
IHRoYXQncyAgd2h5IHdlIG5lZWQgdGhpcyBwYXRjaCB0byBmaXggdGhpcyBjb3JuZXIgY2FzZS4N
Cj4gDQo+IFRoZSBVRlNIQ0kgZHJpdmVyIHNob3VsZCBtYWtlIHN1cmUgdGhhdCB0aGVyZSBpcyBh
bHdheXMgb25lIGVtcHR5DQo+IHF1ZXVlDQo+IGVudHJ5LiBEb2VzICJwbGF0Zm9ybSIgaW4gdGhl
IGFib3ZlIHRleHQgcmVmZXIgdG8gdGhlIFNvQyB0aGF0DQo+IGluY2x1ZGVzDQo+IHRoZSBVRlNI
Q0kgY29udHJvbGxlcj8NClllcyBoZXJlICJwbGF0Zm9ybSIgaW5kaWNhdGVzIFNvQyB0aGF0IGlu
Y2x1ZGVzIHRoZSBVRlNIQ0kgY29udHJvbGxlci4NCj4gDQo+IFdoYXQgaXMgdG90YWxseSB1bmNs
ZWFyIHRvIG1lIGlzIHdoeSB0aGUgZm9sbG93aW5nIGNvZGUgZGVwZW5kcyBvbg0KPiB0aGUNCj4g
VUZTSENJIGNvbnRyb2xsZXIgdHlwZToNCj4gDQo+ICtpZiAodWZzaGNkX2lzX21jcV9leHBhbmRf
cXVldWVfc2xvdChoYmEpKQ0KPiAraHdxLT5tYXhfZW50cmllcyA9IGhiYS0+bnV0cnMgKyAxOw0K
PiArZWxzZQ0KPiAraHdxLT5tYXhfZW50cmllcyA9IGhiYS0+bnV0cnM7DQo+IA0KPiBTaG91bGRu
J3QgaHdxLT5tYXhfZW50cmllcyA9IGhiYS0+bnV0cnMgKyAxIGJlIHVzZWQgZm9yIGFsbCBVRlNI
Q0kNCj4gNC4wDQo+IGNvbnRyb2xsZXJzPw0KPiANCj4gVGhhbmtzLA0KPiANCj4gQmFydC4NCj4g
DQpJIHRoaW5rIFVGU0hDSSA0LjAgc3BlYyAiV2hlbiB0aGUgaGVhZCBhbmQgdGFpbCBkb29yYmVs
bHMgYXJlIGVxdWFsLHRoZQ0KcXVldWUgaXMgZW1wdHkuICpOb3RoZSB0aGF0IHRoaXMgZGVmaW5p
dGlvbiBtZWFucyB0aGVyZSB3aWxsIGFsd2F5c2JlDQpvbmUgZW1wdHkgcXVldWUgZW50cnkiIG1l
YW5zIHRoYXQgIlVGU0hDSSBjb250cm9sbGVyIiBzaG91bGQgYWx3YXlzDQprZWVwIG9uZSBlbXB0
eSBxdWV1ZSBlbnRyeS4NCk9uZSBvZiBvdXIgaG9zdCBkb2VzIG5vdCBmb2xsb3cgdGhlIHNwZWMs
IHRoZXJlZm9yZSwgdGhpcyBob3N0IHdpbGwNCnRyZWF0IENRIGZ1bGwoaGVhZCA9IHRhaWwpIGFz
IENRIGVtcHR5IChoZWFkID0gdGFpbCkuIFRoYXQncyB3aHkgd2UNCnByb3Bvc2UgdGhpcyBxdWly
ayB0byBleHBhbmQgb25lIHF1ZXVlIHNsb3QgZm9yIGhvc3RzIGhhdmUgc3VjaCBpc3N1ZS4NCkl0
IHdpbGwgbWFrZSBDUSBmdWxsKGhlYWQgIT0gdGFpbClba2VlcCBvbmUgZW1wdHkgcXVldWUgZW50
cnldIG5vdA0KZXF1YWwgdG8gQ1EgZW1wdHkoaGVhZCA9IHRhaWwpLg0KaHdxLT5tYXhfZW50cmll
cyB3aWxsIGJlIHVzZWQgdG8gc2V0IFNRJkNRIHNpemUgaW4gU1EmQ1EgQ29uZmlndXJhdGlvbg0K
UmVnaXN0ZXJzLCB3ZSB0aGluayBpdCBzaG91bGQgb25seSBhcHBseSB0byBzcGVjaWZpYyBob3N0
cyBuZWVkIHRoaXMNCnF1aXJrIG5vdCBhbGwuDQoNClRoYW5rcywNCkNodW4tSHVuZw0K
