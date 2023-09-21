Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300E57A9ED0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjIUUMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjIUUML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:12:11 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDCE5A01B;
        Thu, 21 Sep 2023 10:20:46 -0700 (PDT)
X-UUID: 50686786588911ee8051498923ad61e6-20230921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=n/LFb/aFpz3zw5uPfAVDwlUHxvembyE/H85bqVVmtL8=;
        b=u39l2cDDc1IYvNafSMn67Ou3x1zmiMqh3moO/owworWi2hL1pFMBx7ndC/QXy0Oo1Z3CkXhG4hDhVv0I+2KvB/Ps0v/pjSp++KEA3tYe5IGcqpIQlLb1k9v+sLKfO0qmym0iihnqye+rcPVbuKGQidVOkCl1vdaLGiUETN3thxI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:18ceeced-80f4-44b7-8c88-ee4fc7923070,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:e6cbf8ef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 50686786588911ee8051498923ad61e6-20230921
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 322097023; Thu, 21 Sep 2023 22:15:27 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 21 Sep 2023 22:15:26 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 21 Sep 2023 22:15:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiWpZlhrnbBCWoNbd0WEuEWkMKY5cD7WoiF/sIcdGZ1nuLVCbUqPvk7ty8CnliZXKTZrg450iNQP/Y/oJUUe3pOILv4s/mK6BCF8sg/onwk9GdQFlWl3KhXQj3yvPCaB3TgIaBLGo/LekmLCHOxgKRhBBu9AARUyWF/birHyhf1XL/n3p3b4iNNe3vNilPG5VNY1AlVBjeHpeeLg5dnOn48JnkuUojs9onO6up0ewC39rSCWnvGD331xrfs/P82nhEI3aonKqtjbU2STxXXG3+vEdROQhmaNWsnL4X1bM2LKbB4ppq+DupwsqgU6bhdh2v+AhsDz4x6Ko8EP+wqtGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/LFb/aFpz3zw5uPfAVDwlUHxvembyE/H85bqVVmtL8=;
 b=gra2CM0RzZ820AbsUQQQI6F/NVGOgN96uf7QMP0DZpyL3v2z7+Etbcnlz/KYZ0aXG9WqvqkM3ESruv3qnNYt8IVPaaJaYUkEK1KQLmvCZUWHtwlQqsX2+DcJCgmmpxGQekDDgRAje6u9cPiHhsO1xgzPwxOYxIh/HrbfaAJ9iTow0t+oHfe/iG+mP0jm4430reQ6+kPK0CEWRkZ0msXT+Mg20ejAPOq6/wSeLzOOwtZuOrri6rMEGVvTm4tdEkfJIf5dZ4SH5poSOs5/v02LRSAWbO6EBGAaYe1S897mXhnkRMv7ySerFSTdZ+5ar4TQR2ylYQhcCY3173NzdSDB4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/LFb/aFpz3zw5uPfAVDwlUHxvembyE/H85bqVVmtL8=;
 b=W55djysU0hfmpyV1MvblLg0b5MjKd0/EU84AFRS8EKAZV4x6Q4SXz201D4RJ2RFJohNJsuLgBocPErDczfhSYUKxZwVTzsoVFPpbYpGwsix0aspDi5QddCSfvjNtq1mPD5pn1mKxJKomCx4Qz4nWQ7yffxSKTWipJu4qLkKoYT0=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB5229.apcprd03.prod.outlook.com (2603:1096:400:3b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 14:15:23 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8%4]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 14:15:23 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
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
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?utf-8?B?RWx2aXMgV2FuZyAo546L5YabKQ==?= <Elvis.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH 06/15] mailbox: mediatek: Add cmdq_mbox_stop to disable
 GCE thread
Thread-Topic: [PATCH 06/15] mailbox: mediatek: Add cmdq_mbox_stop to disable
 GCE thread
Thread-Index: AQHZ6mVzAB+DDXoZvUWdOhEu85xiW7AhW1KAgAP8AAA=
Date:   Thu, 21 Sep 2023 14:15:22 +0000
Message-ID: <e8a5d5dae3742c571e1efbe55088ff027012b914.camel@mediatek.com>
References: <20230918192204.32263-1-jason-jh.lin@mediatek.com>
         <20230918192204.32263-7-jason-jh.lin@mediatek.com>
         <e4449273185eb7794f344386d9b5a4605cfea4d2.camel@mediatek.com>
In-Reply-To: <e4449273185eb7794f344386d9b5a4605cfea4d2.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB5229:EE_
x-ms-office365-filtering-correlation-id: b183e4ca-fba9-4ee3-e9bf-08dbbaad31c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TFWalRNHYgk0v5/iLKl8e2r0YTVgwqDJc2VLeTMBUCv5fxo7B+pkuHHw4rNp2uycvmxl+uCi/Vx1OCIUCamqfjExeA8BNPRQEPElXoFUXnzgYBPGDl2lfEvEnh3pudgwVE+kJYddqtElYerN/zzwKPKajGrhmLlYfdhubI04P73WJaQBe/B+ApnpzG7Tzu/ITsbrf5v3Hb8sSscLW3yUel0Hm8KSCXaoOPJVe11rKj5475IhZmKmR0r+NZA6v53PfV8OdkAcE3XuGQzYoSMNdeNurc0AdOUVqF+DeB6l8MfB8DGci+fkkxyRb6PLRnLV9fYWkVJVI80V6AxnYC5rYra+wKAGeGGWSDWlwi5U3Mi/ATl1EvbupAOBvSDKJ46IjP3L6Syg3NuAzSgym9XUyyT4am5TdwKgs6bC3iGGS/ysBZ9Xz3btG5RiuJkEO8BISWaL11uTSKyX5twH4MprRMppfbGc6Pl+bLRMgjQPT+ZZoKLxf1cYgUf1LMZlI2f8u0cGx4G9Ke740k5dgQJ8X25R7QoAdY+660sTQOTRBvN+WnxohYomiwl5eg7BB7kwFL0PwJdTy5gBOBbEMpGZ9Nxo6a3ATcnDl9mhlGmOLCazLHs48sgiWHifU8xHTSJ+i0+l0F1M8cJoSfDixZkeQ/qNoXoRwuE7vwZU2QxDMQc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(136003)(396003)(1800799009)(451199024)(186009)(38070700005)(2616005)(107886003)(38100700002)(6512007)(122000001)(83380400001)(26005)(478600001)(5660300002)(91956017)(8676002)(8936002)(4326008)(7416002)(86362001)(15650500001)(2906002)(316002)(85182001)(41300700001)(36756003)(66946007)(54906003)(64756008)(66446008)(66476007)(66556008)(6506007)(110136005)(6486002)(76116006)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UElYKzc2cFhzaUdKcFhsbWFxZHBiVkVZbzU5ZTFPMnM1MVBuVk9KZUVJTnB1?=
 =?utf-8?B?RjhyVEUyajNPcUVMSWQvTlFlaEowZHRjVjJSOTF4VThpQVpzMlljanFrVURz?=
 =?utf-8?B?Sm9GWGpoaWVublZwVGxGN21PSFpBK3lXeXVKVkVucFBVb2o1Mko1K1kzQTkr?=
 =?utf-8?B?a2Ftd0NhdlJpcC8yM2lFMlhDY2pLWkRtdFd1KzNzWVdPWHFsT25OMWVGcFpz?=
 =?utf-8?B?SnZkQkRZVjNtRzhmZFZXL2dlcE5VNTJ2NFR4YmlLblhoNitDMDR0c2JtMTk0?=
 =?utf-8?B?YmRRbll6dURQcERUeFF1aWVBbmZHSXBPMGgreVR5S2JGTlllbytiU0hLb2tk?=
 =?utf-8?B?UFJhalZYVmo4cTVlVlpzYUtCUDNoYWNsZzVpZmtINENZTTZvOFVrNDEwWUJC?=
 =?utf-8?B?aFlKaWZGeFYwanVRK3QrTEc3clZPUjBRRXE4QnA4N1VwL1NpMVluaW1TMDRt?=
 =?utf-8?B?dXl5RDVuZHo3ZjJ2aE1lUEg4Qmw4OENkUmJWZ2tvYzNGd2Q0QkU4b3BMVXNY?=
 =?utf-8?B?bVlPbFl1cEpBL29uWXVTYnlReGV0dllDbXBlOTcwd0NhNngybnIxOHRXL0Ir?=
 =?utf-8?B?cEllNmtScXlPR3YzcDdORTFhaGZZZ2dtK2w5YytsSjNqMis3WTVQMEVORUtm?=
 =?utf-8?B?YkQ5UnZKeTdZWHdmTFc3S1hoenR3Z2ZCYVlCNk5LcEVNaUtnQnN6SjFLRVo5?=
 =?utf-8?B?OHJpOUFrWjUrczRCYXpXUTU2MGQvRnRqTVVOb0NXL2J3eUlUaXFXNndjNkNN?=
 =?utf-8?B?ZlJ5cURTT0VmUEJpRzl6RW5iYWx2UG1RaDlVd2NOVWtXWWY5Tm1LVlRwZFNW?=
 =?utf-8?B?VVUxSzQxTW9xVGpsMm5NbWtiM2VkV3lXeGxhY05Bcy9Ma0NBWWgvbFYyZ3Ja?=
 =?utf-8?B?Q0lxd05TS1E0bEJDVkFTb2N6bndaV3cvQmdOM2FEbWd3ZjRhZ05LYUVHM3Fz?=
 =?utf-8?B?a0RFSVFxTXd2YjRMQzFUNGNQTnNjWldHOVRiUUp1RnpuOERjZFcxMzBVRGhP?=
 =?utf-8?B?Y0QxTGc0eVJCd3dmbGFYaHl6TFRWYzdEMk1OeldQMGlmSHFsVUUxcHJUWHdM?=
 =?utf-8?B?bEQ4M0dQUkY3eGpoVVZkbWRHTXRtZ29YVzlDZlZMNVdia0d3TXhLNGZiMk5Y?=
 =?utf-8?B?aGY4Tyt4bTZRQzNRekQxcDJ1Wm92VEZBU3pYSnlmWWtxNWpmM1diL1d4Z1Rw?=
 =?utf-8?B?dkRWZFB3YXY0blI2RXlxS2lLTy9pMnpqYTZPMDMxSjVGdG9xWGk3SUxOMGdL?=
 =?utf-8?B?MmVpNTJBdnNRVWxXNGIzVkVNeW5XbU8wOWYxc1VmbkN5bGJlM2FHTUF6WmV6?=
 =?utf-8?B?K2VTdmNxYjlGSTZtdEVFSGtSbGFFekxTeEQ3VGduUm5lWG9RaTJ1WTVGeTUy?=
 =?utf-8?B?a1VGbTBmWCtBcXlMQ2JnUnFYZTlPeVVvRzQ3dzJVdlZwTHFSejdGbFRIdHRi?=
 =?utf-8?B?TDZCcTBuWlF6NVY3dW5WeG5QS1NWcFk2NFhjbUhUaUVCR0MxeFJqK3N3REV1?=
 =?utf-8?B?OWdUVXBkVmtlWDBnZU5rZDY5M3VKNU1tb1IrZmZJdEJ6bzQyaURtUkRIMGw3?=
 =?utf-8?B?MVM2d2YwZHhzQWRKNm5rSWFHNktnbDFRTWU2KzkrYjkzZVNVWExBa3dMRzFt?=
 =?utf-8?B?R2Z4cFdvODBTbmVSRkpSYUNzbVorNUxDN3NPQS9iMDJhV2kxV1ZXd1FneVB3?=
 =?utf-8?B?dzIrUG02VXhUdFFBK0pUdzhnOXV2ZCtjbXRJVkk5em1aOGlwMkRhSjh3aWlZ?=
 =?utf-8?B?M1JGWUtncndCZS92aWRBL2VtZUtsZFZva3BnaFFub2JGdVUvc2h2Y0dETzFJ?=
 =?utf-8?B?VVBDa0RyaEFhV3lvam5jUHRGZXhDdUk2S21yU3F6TmREejhrckM1ZGlIWEF2?=
 =?utf-8?B?QStOc1Bwa0lKOGh3UjlOTkxySnI4OFZHSDRoYTd6QlJzWFArbGJESUhEcmh2?=
 =?utf-8?B?blV6MitEeEx3MUJ3YkcwZ3ZLTjhyKzBuTUh4eFZ5ZEdXUVF3dkU3dU1zTEFo?=
 =?utf-8?B?QlhFY1hMaVhxU1IzYmdGYjVDb25GaHhGOE5walIxYnlhbWJZdVZOVGpUTm4w?=
 =?utf-8?B?UTJkQ3RBS1dsVjduNWFHQmVtSzcxYVYrb2lCd1RUclU3dGNHcFFCak9NT1RL?=
 =?utf-8?B?VWozVi9FQy9xRjNrcGdzUExBem55OXM1T0pXamtvTytUYTNBVTlvSVRxczJr?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8B021FFE1AE0745AAE485E196E06D2F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b183e4ca-fba9-4ee3-e9bf-08dbbaad31c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 14:15:23.0103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 01U7NryKijnc4YsOglw6DQVvaAUJFgOupna6434Ta7fr4BtsLzV6GuAfU/CgvivIZtDBEHUp/Frnw6ffNtyC1wnclDYZ42+hPQZPBPk3mCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5229
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCg0KT24gVHVlLCAyMDIzLTA5LTE5
IGF0IDAxOjI0ICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90ZToNCj4gSGksIEphc29uOg0K
PiANCj4gT24gVHVlLCAyMDIzLTA5LTE5IGF0IDAzOjIxICswODAwLCBKYXNvbi1KSC5MaW4gd3Jv
dGU6DQo+ID4gQWRkIGNtZHFfbWJveF9zdG9wIHRvIGRpc2FibGUgR0NFIHRocmVhZC4NCj4gPiAN
Cj4gPiBUbyBzdXBwb3J0IHRoZSBlcnJvciBoYW5kbGluZyBvciB0aGUgc3RvcCBmbG93IG9mIHRo
ZSBHQ0UgbG9vcHBpbmcNCj4gPiB0aHJlYWQsIGxvcHBpbmcgdGhyZWFkIHVzZXIgY2FuIGNhbGwg
Y21kcV9tYm94X3N0b3AgdG8gZGlzYWJsZSB0aGUNCj4gPiBHQ0UgSFcgdGhyZWFkLg0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNv
bT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYyAgICAg
ICB8IDYgKysrKysrDQo+ID4gIGluY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94
LmggfCAxICsNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiA+IGIv
ZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiA+IGluZGV4IDRkNjJiMDdjMTQx
MS4uOGJkMzlmZWNiZjAwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21k
cS1tYWlsYm94LmMNCj4gPiArKysgYi9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5j
DQo+ID4gQEAgLTQ2OSw2ICs0NjksMTIgQEAgc3RhdGljIHZvaWQgY21kcV9tYm94X3NodXRkb3du
KHN0cnVjdA0KPiA+IG1ib3hfY2hhbg0KPiA+ICpjaGFuKQ0KPiA+ICAJc3Bpbl91bmxvY2tfaXJx
cmVzdG9yZSgmdGhyZWFkLT5jaGFuLT5sb2NrLCBmbGFncyk7DQo+ID4gIH0NCj4gPiAgDQo+ID4g
K3ZvaWQgY21kcV9tYm94X3N0b3Aoc3RydWN0IG1ib3hfY2hhbiAqY2hhbikNCj4gPiArew0KPiA+
ICsJY21kcV9tYm94X3NodXRkb3duKGNoYW4pOw0KPiANCj4gY21kcV9tb2J4X3N0b3AoKSBpcyBl
cXVhbCB0byBjbWRxX21ib3hfc2h1dGRvd24oKSwgc28gY2xpZW50IGRyaXZlcg0KPiBjb3VsZCAg
Y2FsbCBtYm94X2ZyZWVfY2hhbm5lbCgpIHRvIGRvIHRoaXMgYW5kIHRoaXMgZnVuY3Rpb24gaXMN
Cj4gcmVkdW5kYW50Lg0KPiANCg0KSSd2ZCB0cmllZCB0byB1c2UgY21kcS0+bWJveC5vcHMtPnNo
dXRkb3duKGNtZHEtPmNsdC0+Y2hhbikgaW4gbXRrLQ0KY21kcS1zZWMtbWJveC5jLCBidXQgaXQn
bGwgY2FsbCB0byBjbWRxX3NlY19tYm94X3NodXRkb3duKCkuDQpJZiBJIHdhbnQgdG8gY2FsbCB0
byB0aGUgY21kcV9tYm94X3NodXRkb3duIGluIG10ay1jbWRxLXNlYy1tYWlsYm94LmMsDQpJIGhh
dmUgdG8gZmluZCB0aGUgd2F5IHRvIGdldCB0aGUgbWJveCBvZiBtdGstY21kcS1tYWlsYm94LmMu
DQpTbyBJIHRoaW5rIG9wZW4gYSBBUEkgaXMgZWFzeSBzb2x1dGlvbiBmb3IgdGhpcy4NCg0KSSBo
YXZlIGNhbGxlZCBtYm94X2ZyZWVfY2hhbm5lbCgpIGJ5IGNhbGxpbmcgY21kcV9tYm94X2Rlc3Ry
b3koKSBhZnRlciANCmNtZHFfbWJveF9zdG9wKCkgaW4gY21kcV9zZWNfaXJxX25vdGlmeV9zdGFy
dCgpIGluIG10ay1jbWRxLXNlYy0NCm1haWxib3guYy4NCg0KDQpSZWdhcmRzLA0KSmFzb24tSkgu
TGluDQoNCj4gUmVnYXJkcywNCj4gQ0sNCj4gDQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTChj
bWRxX21ib3hfc3RvcCk7DQo+ID4gKw0KPiA+ICBzdGF0aWMgaW50IGNtZHFfbWJveF9mbHVzaChz
dHJ1Y3QgbWJveF9jaGFuICpjaGFuLCB1bnNpZ25lZCBsb25nDQo+ID4gdGltZW91dCkNCj4gPiAg
ew0KPiA+ICAJc3RydWN0IGNtZHFfdGhyZWFkICp0aHJlYWQgPSAoc3RydWN0IGNtZHFfdGhyZWFk
ICopY2hhbi0NCj4gPiA+IGNvbl9wcml2Ow0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQo+ID4gYi9pbmNsdWRlL2xpbnV4L21h
aWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQo+ID4gaW5kZXggYThmMDA3MGM3YWE5Li5mM2U1Nzcz
MzVhY2IgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1h
aWxib3guaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94
LmgNCj4gPiBAQCAtNzksNSArNzksNiBAQCBzdHJ1Y3QgY21kcV9wa3Qgew0KPiA+ICB9Ow0KPiA+
ICANCj4gPiAgdTggY21kcV9nZXRfc2hpZnRfcGEoc3RydWN0IG1ib3hfY2hhbiAqY2hhbik7DQo+
ID4gK3ZvaWQgY21kcV9tYm94X3N0b3Aoc3RydWN0IG1ib3hfY2hhbiAqY2hhbik7DQo+ID4gIA0K
PiA+ICAjZW5kaWYgLyogX19NVEtfQ01EUV9NQUlMQk9YX0hfXyAqLw0K
