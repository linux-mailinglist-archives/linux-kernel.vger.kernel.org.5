Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100417D8D6A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 05:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345218AbjJ0D1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 23:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbjJ0D1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 23:27:35 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389F2B4;
        Thu, 26 Oct 2023 20:27:25 -0700 (PDT)
X-UUID: bb711dd8747811eea33bb35ae8d461a2-20231027
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=9N2JDIb7XFOdS+5mt3z7RjQaew7BWDeUVs507ky6OCc=;
        b=avkLPCVv5Lgn5IA7Iy5cN2OGuNRTPNAdexeOr5zruWqIEvQQfoUzaoe2b+rVw7okysAzx+1kjzILYgoGSWS9bBu+Yhs6Iu0MapOD8r/ldgbgTTlsU4iaz8+pZNCMhLeujaA/5O58GHWeNbHQ8ZuHk2eZyuwtJ0vxQdaEX0W3PXY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:312c11f6-f7f7-41b6-a163-4261faf21970,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:199dd4fb-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bb711dd8747811eea33bb35ae8d461a2-20231027
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <chun-hung.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1844166831; Fri, 27 Oct 2023 11:27:18 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 27 Oct 2023 11:27:16 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 27 Oct 2023 11:27:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xh1RfAifFhO45H/LsVyXdF+zM8vBXA6B55kljiTKQSCeNXy/QGn67ahj9sdYQwFTElBuyz6ur0W19ot4k2YggT9c0AhoueJgwwIMQzDliUgNAMS9XrhjJnuCc0b5JiXSdRgXnRWbMHLA4yswGZKrnwtrKu6ykjLRnSGbo2Lr8WLvQUsi5mEmMQ82YANfBXtSGJxXZf3OQd3jiiwVgnC8grTrJCB5HJZshqxLPXMOjIbNCXrmb5DqagTIkRejlRnCwW0s8aJEkC2K73O5HC09q0fhh/Xsk7qVigmVp6iaqp2+h7f0vWmPGp4284exandShzXCbbJ/FXMlKHdmrIuX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9N2JDIb7XFOdS+5mt3z7RjQaew7BWDeUVs507ky6OCc=;
 b=kS6bhk218RhGEqlXVJ11q9wrInWm0G3Bz2dEp5Skg/7Wn8u1cxaGn1NMLbaXLmglGYZDLUhy8chGbaL3A7oS1NxS+v7QwhbJbJP+t2IC9L1Od+yCi1wtfpaNJ3XJjFWFeYhHu1WfKj0xFgCr4DjKgg9oLHjuVaQoh5EuDV94ZKu5/+ZTj4hIdxKJZa0S46QV6K5pOwuH22f9sN7XYUL+Iy/u5pOYEry/VTnE5GSHbN6DBSU4SLdYu3GKtVmwrlea5fIwpEXML4BimeqFtlBWvFAGw7MrgC6gOr6dWPlvzLIyFhNg5Sh09gjoHWyfnTczuXpEJb6fMaFsT3Q0vh4g6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9N2JDIb7XFOdS+5mt3z7RjQaew7BWDeUVs507ky6OCc=;
 b=G5xEtUvBhTetoh89uc1v+cxg65BuOKywlCZ5NbGoBaO5P0e4YOLYA4o0pDMUao6z23IHvfimkvpcHiLajM04nMrG+qUgb/02bY2lweSbkrab/h8iFtl2Nnw5r9/7ip/6w2BVPNXvuw8k6wa9hP3C29TpjycVxLlWvRB+ynrmO5k=
Received: from TYSPR03MB7350.apcprd03.prod.outlook.com (2603:1096:400:413::14)
 by TYUPR03MB7206.apcprd03.prod.outlook.com (2603:1096:400:347::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Fri, 27 Oct
 2023 03:27:14 +0000
Received: from TYSPR03MB7350.apcprd03.prod.outlook.com
 ([fe80::4604:35b2:5434:cc1a]) by TYSPR03MB7350.apcprd03.prod.outlook.com
 ([fe80::4604:35b2:5434:cc1a%6]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 03:27:14 +0000
From:   =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>
To:     "ebiggers@google.com" <ebiggers@google.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
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
        =?utf-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= 
        <eddie.huang@mediatek.com>,
        =?utf-8?B?SmlhamllIEhhbyAo6YOd5Yqg6IqCKQ==?= 
        <jiajie.hao@mediatek.com>,
        =?utf-8?B?Q0MgQ2hvdSAo5ZGo5b+X5p2wKQ==?= <cc.chou@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?QWxpY2UgQ2hhbyAo6LaZ54+u5Z2HKQ==?= 
        <Alice.Chao@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
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
Thread-Index: AQHaB26oJLt4wBp9JU6b9Mq1SfN0NrBc/BUA
Date:   Fri, 27 Oct 2023 03:27:13 +0000
Message-ID: <53d7d12bc12237e5f86522faf09876ab08ef7592.camel@mediatek.com>
References: <20231025085656.10848-1-chun-hung.wu@mediatek.com>
         <20231025085656.10848-2-chun-hung.wu@mediatek.com>
         <3056c6d8-1e54-4954-9141-e0760a0d935a@acm.org>
In-Reply-To: <3056c6d8-1e54-4954-9141-e0760a0d935a@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYSPR03MB7350:EE_|TYUPR03MB7206:EE_
x-ms-office365-filtering-correlation-id: 2386bdfe-ad26-4404-7e49-08dbd69c9cf6
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FOUCiz25B5GbWf2nT7EmTu4prmQ5zWOJLDUnM4GyePtxZUnkrsMO/Bm4S6C5lngZ6NfQY7BtX7RhvUUfKCTc6BOro6C98bSoHwA8H5dVJh1JXUP0378NPRuCNI+6/q2I7hH/oCvTJNJe96YiZqejic0BufeFD6YjVGdwfZSqoLEoWypXhOqfeMzCd9hhISPxJD8mjP4kNQ1u2QF8uyJqv7ULM82dAHdLMBWqy52gODMrZtb8y/7w+CGsd1JJtqtygq+DHXbGKHKc6KybdkpiWQ1LDVSQou3XhK7ToYSr0EvtdjG4t9JIcsBCvh3TnlzEoIvUmA8qul0qS0PqwKnWwseOum7DYj8ZyC7jpXylq94XVyJuRw7dLq5Ch2kcrEw47x1g/O1OVfTCoOJRuRDCp5HuR9j3cACK78urKhvauoKtIOMJCYgqutCYXWHpM5S0noqfL0pZZUFT3K4vNJ1LabDJehl/Wq+xSdMHMPRChmVvXe9sqiA30PeM9sN2fVfDAuNUsOxZRySthxVrJ1lAaSFlHGc3DYqDFblHRsoFbYKf52kADtdpKmMOdHkxss1+b7+R+Nr0HqlhFWj/9SETkPniw0hWQ3WduU6rJprLj2NZDTznLsIppPiDQoaj651Alax4wRr9ZKJd4MWrpJDVOPlmlFk+5AcGOioe3Xzcpb3TaDFIiYLIQa1TkQKaEuJmDI+R8RnmmoAjTYVuzV74d2xJjSDfplFYVzVH3ZKZDbU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR03MB7350.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(230173577357003)(230273577357003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(85182001)(921008)(8936002)(53546011)(8676002)(36756003)(7416002)(4326008)(6506007)(86362001)(2616005)(41300700001)(5660300002)(26005)(122000001)(38070700009)(66476007)(38100700002)(64756008)(54906003)(66556008)(66946007)(2906002)(66446008)(316002)(4001150100001)(71200400001)(6512007)(110136005)(76116006)(83380400001)(478600001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTlyY0RLVFF3M0lFSTdyejdYTkhvajFoeTZJQ3lkaXZVN25pRTFqa0lBcWIx?=
 =?utf-8?B?V1NKVkU2Z0FKSmJOVXl3QkZnUFFFdlNPbnNuOGg2NXBJRjk0OGZ6d0NkUG5I?=
 =?utf-8?B?OHNURGdQQytIUEd6RWhzVG9SdjQrZ2YzU2ZYUzBuU1FuR3BKeXRsZWZJU0tX?=
 =?utf-8?B?a3BYRjY4aytPWktUTzBSMjVHRlhLSEhHa0dKay9PdXFxYnliY2JtM054S3hy?=
 =?utf-8?B?VURwSEJGWFBoOFdVdVp6SVJIcWVuVmExenpHVGtmdzNPeFlEbGJYTkpSZUdD?=
 =?utf-8?B?SFJaalBpd2dNbWZ2VEEvWjZHZWRjaGZ3ZTlwRnBFbFNVUmttM3l0bitTZThV?=
 =?utf-8?B?NlM0VFRsNFdxc1pSclRhOEtlamxNZE1PSk9kY1RJb0NHZE5KY2FIMkNsa28y?=
 =?utf-8?B?WmZjY0JWUTdrUjJKUkZYSVJPUzFjYlNVZFpENGZPbzF6dVo2K1lISFFHdmpR?=
 =?utf-8?B?S0NpT0t3dmpCNDg3enlsMHE2dGo0TW9ZVXE4WVM5VXBMU09DOXY3SlhXRzZt?=
 =?utf-8?B?ckhkYnBLSURhU0xiWWdaaGdCcURsU2ZoNTYxeEY4bGh5cXJKbGhnWE5HRU5a?=
 =?utf-8?B?ZGJ6TGhud0t5WWZ1WUY5YUY4SEMzNkRHY3h3VjVFZlVwdVJrTXlwSHRaR2hP?=
 =?utf-8?B?NXdpV2JoUWZ3SGFpUXRNVDhKVXRLVDJYWGZybFFPTmt0L25LQXprMmNXVDBp?=
 =?utf-8?B?SUlQMmNTSEdGS3RPY0ljSG1LTjhHQWJiYThITVFlc2RWd3lQRjdFZ1BLWlcz?=
 =?utf-8?B?bjZlYjEvSSs3dSs5dllCd2NQZTZBZ0VkcHBhRFd0cTc2VURGTzdyTHNrbUJy?=
 =?utf-8?B?RkNvRkNUMDdPSFdLZE8xOFYxMDMvS0RFZS8wNWtWWUNmQ3ljMThwQktBQVF6?=
 =?utf-8?B?VkZBSE9vUXF2SWo2OHlxTW9aTE94c3dNME1PSTdEU1Z0cDBpS2tVU3EwOUJh?=
 =?utf-8?B?dzR6ZWdFNFA0VjRiaTcybmZaUGJ0REFWL2MyYk5EY0h0T3pGZEZQOXN0UlRs?=
 =?utf-8?B?eUhpZW5POWJyRWtvcVFTQldlVEwwaTRHa0liNUt3NkQ5ZjNkOHlEOVlLd2ov?=
 =?utf-8?B?bnNUNFpKdmtteGVvbnE4dm5tWXlTNzVDUVg0S0QzWjR1MFRoZytwWEtva3M5?=
 =?utf-8?B?TGxheFhES2xuUDI5KzBZMFMvMGhkaFpMcDI3QVJLMmhaUGFKZjFYbHdhOGxh?=
 =?utf-8?B?QWwxTlpTTVpkdXpyOTNQcEMzaGJNZVczMkZlRENXbkw5cWt1b1VFYWU3bGxp?=
 =?utf-8?B?eWdoZEhvNWVjVmMwRFB6aW0vQjhsT0todUlCY21Nc0o4NEk0TUl4RWhwR3o1?=
 =?utf-8?B?ZHFiZXhhT1RhR2YvSXN1QldobFIwRHpWbjRSNmZpRDRUbnh6bUovQ0pBUWkv?=
 =?utf-8?B?NjJCSFp0K1NwUzA4Rng4eXRCdGN3NFBuYmx2a0ZrUkE3QlRLbjM3Wm8wdDU2?=
 =?utf-8?B?OE1SakQ3R3UxTWxZT29qaE96TkkzMWsyUEpEV2xSWjU4ME5RK3hmSnN1ZUVJ?=
 =?utf-8?B?TTl0dThDS2pzc1hRanlyQTNXdTZSS1FFZkhqblBJYytaQ0gyRzg5dEdQQkFW?=
 =?utf-8?B?WFRZVFoyUkprWjFCbkZ2OGlXeGp1WFQ3a3grT3h4SUVRaDJRM05IMzhZWmFX?=
 =?utf-8?B?VzBndmRZUTZCSUxTTlltZnBWU3JqeU1UOTRKcFJQTHlnM2k4SEFUWHRMQnVY?=
 =?utf-8?B?NGZxSWVEemh0d3VJMHJOeEUzaFpEV2RKR2k1WmtoRCtrdjEvclZSL1FmMDBM?=
 =?utf-8?B?dE0wMXNMMFVHUzdrRjViVFZMaXlhaDVhREUvT2ZacE9ESjZaclhVMXkrbjVs?=
 =?utf-8?B?WUNRRTN4M04xZHl1Ym05U0ZwVDBSNGo3UmtRL3dBVmxYdnFrYmlYRGZyVGNE?=
 =?utf-8?B?djVNZXBaQXRQcTYrRm4vbkErazY5K1lWMU5ob0k0UlBQUlVtOEdCYmZMNkxL?=
 =?utf-8?B?RUNkenJVd21JbnFLcERobXlmQnlYNnB6alV5aXdlSkZSK1BDV2Z6Z0Fza3VR?=
 =?utf-8?B?eVVWTUpJd1VXc1ZmUzVKcVFzclJMMyt2MFE0d1dJeHhjc3RwRmR5M1NrSzhS?=
 =?utf-8?B?aDRuSTAvcVJxWkFHZ0w5YUxhLzNvMFVkL0o2Mkw2dit2T3pmb2JNQUQ2b3JT?=
 =?utf-8?B?RlFjRExJTzNaaG0rM1draWpFTlJXWDFHcTdVcU0rRGtXcjZ3VStOdHpSZjhR?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92A146FE30878940976AFAC1043ABC7B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYSPR03MB7350.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2386bdfe-ad26-4404-7e49-08dbd69c9cf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 03:27:13.9674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 33VhZxAGe8P1kaH7ZQWfoA+KCWJvjbnUo2rS7qd+2RlfSpepA5dUE8SS1LWuVhz3AW0fuWs0EOKcxxXzIhjH78Tinj9fT+tcRbPQ1QoZCCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7206
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--19.662200-8.000000
X-TMASE-MatchedRID: ge9e+QLSeazUL3YCMmnG4qCGZWnaP2nJjLOy13Cgb4/n0eNPmPPe5KWz
        WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2mlaAItiONP1imi8LvNfmr8NNczdXNJoiB//
        7Jx5rmIENerKqIrGR8quxbNeYl0O1EKA/i6/8kSnmAId+2bAQwkCrr/LkAQ46uu0N7j6PSiPGN8
        n6L6dsdCwTReL3n1jmkZOl7WKIImrS77Co4bNJXQtuKBGekqUpPjKoPgsq7cA=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.662200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: BF90350D2363733CE7D33EE5EA679C4468AA9F552C372E87009777039294A7CC2000:8
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

T24gV2VkLCAyMDIzLTEwLTI1IGF0IDExOjEwIC0wNzAwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6
DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9y
IHRoZSBjb250ZW50Lg0KPiAgT24gMTAvMjUvMjMgMDE6NTYsIENodW4tSHVuZyBXdSB3cm90ZToN
Cj4gPiBUaGlzIHF1aXJrIG5lZWRzIHRvIGJlIGVuYWJsZWQgaWYgdGhlIGhvc3QgY29udHJvbGxl
ciBjYW5ub3QgDQo+ID4gZGlzdGluZ3Vpc2ggcXVldWUgZnVsbCBvciBlbXB0eS4NCj4gDQo+ICBG
cm9tIHRoZSBVRlNIQ0kgNC4wIHNwZWNpZmljYXRpb246ICJXaGVuIHRoZSBoZWFkIGFuZCB0YWls
IGRvb3JiZWxscw0KPiBhcmUNCj4gZXF1YWwsIHRoZSBxdWV1ZSBpcyBlbXB0eS4gWyAuLi4gXSBX
aGVuIHRoZSBoZWFkIGFuZCB0YWlsIGRvb3JiZWxscw0KPiBhcmUNCj4gbm90IGVxdWFsLCB0aGUg
cXVldWUgY29udGFpbnMgcXVldWUgZW50cmllcy4iDQo+IA0KPiBIb3cgaXMgaXQgcG9zc2libGUg
dGhhdCBhIGhvc3QgY29udHJvbGxlciBjYW5ub3QgZGlzdGluZ3Vpc2ggcXVldWUNCj4gZnVsbA0K
PiBvciBxdWV1ZSBlbXB0eT8gV2hpY2ggKGhlYWQgLSB0YWlsKSB2YWx1ZXMgY2F1c2UgdHJvdWJs
ZT8gTW9yZQ0KPiBpbmZvcm1hdGlvbiBpcyBuZWVkZWQuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBC
YXJ0Lg0KPiANCkZyb20gVUZTSENJIDQuMCBzcGVjICJXaGVuIHRoZSBoZWFkIGFuZCB0YWlsIGRv
b3JiZWxscyBhcmUgZXF1YWwsIHRoZQ0KcXVldWUgaXMgZW1wdHkuICpOb3RoZSB0aGF0IHRoaXMg
ZGVmaW5pdGlvbiBtZWFucyB0aGVyZSB3aWxsIGFsd2F5cyBiZQ0Kb25lIGVtcHR5IHF1ZXVlIGVu
dHJ5Ig0KT25lIG9mIG91ciBwbGF0Zm9ybSBkb2VzIG5vdCBrZWVwIG9uZSBlbXB0eSBxdWV1ZQ0K
ZW50cnkgZm9yIENRIGZ1bGwNCmNhc2UsIHRoYXQncyAgd2h5IHdlIG5lZWQgdGhpcyBwYXRjaCB0
byBmaXggdGhpcyBjb3JuZXIgY2FzZS4NCg0KVGhhbmtzLA0KQ2h1bi1IdW5nDQo=
