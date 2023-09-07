Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67CA797412
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344813AbjIGPdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243447AbjIGPb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:31:59 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7898D1BEC;
        Thu,  7 Sep 2023 08:31:23 -0700 (PDT)
X-UUID: d9435e904d6611eea33bb35ae8d461a2-20230907
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=N86ldxzMzjZmaJvBYHKUCJqg1DocoUSYvcrtbmPx1SU=;
        b=ipK/7pd99kboJ8XJHDlkG0s1x7qLSGGLTb5iiJO1X1KJediLGtz0Eymy4GyN1LpcAUNMZFBJVaut/2IrxrSi7onnfAChj0j+djA2mynAvH7gGfW37jsrRDE6cGG7xnJfR3PtfA6Q7vTVWpjg3TM4aOGu3rQ9OUbNxrL0G8fVL2g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:a13225ac-9eda-41a9-9d4f-40976d27c1a6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:35f3aa13-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: d9435e904d6611eea33bb35ae8d461a2-20230907
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <tze-nan.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1666760224; Thu, 07 Sep 2023 18:11:02 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 7 Sep 2023 18:11:01 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 7 Sep 2023 18:11:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxxbPbaK4E+VsXbZgFNfYAybgLkkLaTJCWgZcuxEwzEIzp6O6YvqUaSWoFbxxHlDs9JV6SFLSyUUnnOGyf0ryJgEkJu7IY/ZCSFwLtbd5UCesSEi1TeZyGjN/Fz1CtOKNN72+aoCMdAu3DS+1AfV+LIhiGeSqYK/krrJZPAH3ChRhP1iNxl/7j+NVTbbLAgDLmH1lm1ZYnyakBKGhMiQQAL6ANva9yCLorzoPOJoWSWMN8zxvjjJhc2pt21frVYgOCUkpK/atMkxlRIRrk5+XWmZ/0qoRA+WAlYOGV5E7EjS9HoOeaHIi1+NO52FTKxVxwDkVAUqq4K8RvkKSQKtYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N86ldxzMzjZmaJvBYHKUCJqg1DocoUSYvcrtbmPx1SU=;
 b=SQXlB51TqD7UHUziWoiWGme5EW2Q6gkKMaiMCRIEIZPcTU/ltaHE2xO/vGLyJr84yuFy5fQE0ddSZGAx+aP4qhPG97otx7g2RhALULYM+E+Xk5tNtZ2hKfDiEugm1Srxu7W4cwAgav4MN5EAZCWvtRL6x56eq/Evx1axkJE8DQRdK6fOkOq7GkMfDOA/l79D5kg9FneSvS18p567nGmIwe4IxoMkdXWu+GLdBAIiNXx+70jTnPI650V0tnvFM6eRbI2nc0pyiIhRfX6iWA49njm0TfCg87XlgBn030mUwrVRzSlAbVupy5GjEN0KKoX+u7QXqUX9upnGQ+CElSRPiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N86ldxzMzjZmaJvBYHKUCJqg1DocoUSYvcrtbmPx1SU=;
 b=C2iF5BDOSWXMDa6uvHy2ABgOQbyEFsTpQEaJPVZMg4s4rc8e81WlcOUx/C1s9uFHCQIaW+5iKgw+c6zDiUpxvDxarO9Ip/k/G0RD3X9rquWSMAMYKfv6ZNmQfj2w4zAfykJp1deb3/8CZp2uuzpEKLH+DLo02/CcBUYzcBqA5SI=
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com (2603:1096:400:33a::11)
 by TYUPR03MB7137.apcprd03.prod.outlook.com (2603:1096:400:344::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 10:10:58 +0000
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::f225:e6ee:8a9:ee06]) by TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::f225:e6ee:8a9:ee06%6]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 10:10:58 +0000
From:   =?utf-8?B?VHplLW5hbiBXdSAo5ZCz5r6k5Y2XKQ==?= 
        <Tze-nan.Wu@mediatek.com>
To:     "rostedt@goodmis.org" <rostedt@goodmis.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?= 
        <Cheng-Jui.Wang@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        =?utf-8?B?Qm9idWxlIENoYW5nICjlvLXlvJjnvqkp?= 
        <bobule.chang@mediatek.com>,
        =?utf-8?B?VHplLW5hbiBXdSAo5ZCz5r6k5Y2XKQ==?= 
        <Tze-nan.Wu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] ring-buffer: Do not read at &event->array[0] if it across
 the page
Thread-Topic: [PATCH] ring-buffer: Do not read at &event->array[0] if it
 across the page
Thread-Index: AQHZ4AMSZ8i3KRUX2kOyE7jyhtvSj7AMbyqAgAKwGACAAAfmAA==
Date:   Thu, 7 Sep 2023 10:10:57 +0000
Message-ID: <0944a5f3e10c0eba8b32e51fb941e0dd98ec086d.camel@mediatek.com>
References: <20230905141245.26470-1-Tze-nan.Wu@mediatek.com>
         <20230905123953.3c0b3d7a@gandalf.local.home>
         <3a89d49ae0da6378de83bc68690cf6664d97cb24.camel@mediatek.com>
In-Reply-To: <3a89d49ae0da6378de83bc68690cf6664d97cb24.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7183:EE_|TYUPR03MB7137:EE_
x-ms-office365-filtering-correlation-id: 85c2e3af-bf54-4df0-fb34-08dbaf8abac6
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8mAPX9C3NPSjCM5V3wYdvM7sopTQjZwvN2dBYTqrhnSJgFp+Hx+kx0Ffz7474TNNt/LizwNZ1R2FkomKG1snCrt4IJPI+4fvv/mrB0g5VxHOKNaVremKwRuXDdmPa+BER9v/9X81oMUroNbzdQBnEfzhCuhU1TfgMEslum2rxyAwdWOfcW7q0BrSOMuP13vo98iYeiMEGhyIkgxT5K00IR0V2ZLa7/LrKfjLRYAJkv5v+wr9wqiPQgksRBgdv+/50JOzAnGAtNHVexAwpjgccLa6amWtixOPMzQlC2KQwReQhjnfsBet8E+6mkgRjsVZsQtUsucuYqDlq/qmHfRRTO44qXacjyDwew5vPZma0e9g+wA6uiaxw1YZVZGFgJNt6AzD1CTW0HTxaE6yMfjJjvJVNU8sZXMb/6tAGsnMKA+oqSAlkFIksdfuxnxWlr166DmhIbg6LypM4xbhm/KURBwIOuBwAaf1LIF2E5mHiTcOMmj6TQiLFRC+X21lD0/fJc2tvccql/V0Xby5/noBek43kF1YEQK+ycx6buHHmPLrEV0gr80UH9RWKO+83wxPE6hR0ABuP+lyyi8V6/kwOPgCziirdQZEdjfetrjcvF0VY1vSGlUEdoRymdd5MpT+ZSqu9NDlnfWFKBxXp3tlfdBv4H3BnPF85YrUgX8hzVc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7183.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199024)(186009)(1800799009)(38070700005)(6506007)(6486002)(6512007)(71200400001)(38100700002)(85182001)(36756003)(86362001)(122000001)(26005)(2616005)(478600001)(83380400001)(8676002)(5660300002)(54906003)(8936002)(316002)(41300700001)(66556008)(4326008)(66476007)(66446008)(66946007)(6916009)(76116006)(64756008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWRaYStqc01jQkl0MjNHekNsU1FIOFV2WjVLclBhaUl5K25oU0dUMEZ5b1pO?=
 =?utf-8?B?U3QzUGZJN1FFczU5cWV2dU5TS1pVeS9lMXdnYVo0eFh6c2lLV3RCRzc1RFpx?=
 =?utf-8?B?aTBoZ0E5eFRVcHg1TFAybkNSazJNQ3k5VUVFNEtsUk5hYk1DNWUzTkxnL1dU?=
 =?utf-8?B?NnNoSHNIczVMQXpreGduNzZoZm1kOWNrSHVROU9yU2hkR3gvVitwVEZZeWhX?=
 =?utf-8?B?ZktpbjVldVczOWp5MHEzbC9hU3Y3V1V4RWEwLzhhellmNitST1Jqb3VXdWow?=
 =?utf-8?B?cUdDQmk0MS82cU8rWHJLbW9iYURhcGJ4RjhGcmZ1cUJvTEtOekkxcHJ5Z0pz?=
 =?utf-8?B?RUM3ZjFJenZGVXY4RUdVaDlyYUNKQ3libW4wb0JVQjY4ditOOUlxdlg5Mi9M?=
 =?utf-8?B?YXdUUG1GN0dxeUlVdU9lMWloUzlyR3BDaVZud1NNRWhjUVhweU91Q3JweTIx?=
 =?utf-8?B?cGhmZGdlM1NjUHJZenJpOGZIenJZZnBJUlNMaGhzbEg5SVJaSnRWVUg3a3My?=
 =?utf-8?B?VlJKSkttVTlJMzRHdmsxRjZrOEllTVlzVUphRDk5eEU0NlRxSVcwaitQd1Qw?=
 =?utf-8?B?L04vNkgvbmpWQkFMb3VRUk9LeHF4b3NxZWoyOEx4R1V2aWF4Y0lTMGcxTHdS?=
 =?utf-8?B?N3o5UkR2NDFLOTRUeDZoTVYwR0NEN2xva3F6enNxM2Q3YXpIZjR1dkZvOGNw?=
 =?utf-8?B?ZysycG5lQVB4TmJhaXJxbmpNbm9zTTFSSDhOTWd0Zm8vbG8yTGM2aFVDU3J5?=
 =?utf-8?B?YkkyTkgwQ0o4NTh0YjJXa0duYkJXU0lrb0cvZnliRVZNeC9uU1VocklmQUlt?=
 =?utf-8?B?WkJ3d0JEYWoyYlVseDhlOHdVT2RocTU1emVZSU91MnVnZWR6VGpZTW1QVE5M?=
 =?utf-8?B?RUhuSzEzbHFZbGJGUGxpaHowK0hwL2pXalByQXQwU0NXT2kwaUE3L0h6T3dC?=
 =?utf-8?B?dHNsVnVZdCtaa2M3b01mclhWR2dLZlY1RVprdW5IOUV3K3dRVnB3YjVnQVFS?=
 =?utf-8?B?R2l3VWF3WlV6N2FNa2dvUFYvT1k3d0d6ZGV4TVgrR1ZFTENSTE80RkxxYm5L?=
 =?utf-8?B?S1dSTG9wejRTVWdVTW1CekQ3RG5vTzRhYUtXamxRdkVwVWE1a0dzMFFxeEFr?=
 =?utf-8?B?U0xoVy9qME9XS3lJLzAwYnJrNnF0cUVkdUQza2tyNWVtbFFNd1R3WDJ2TVJ3?=
 =?utf-8?B?YlRJbDRxY3FsRlZsRzJ3WkJWd0cxNzhBWlpvazUycTViUVowaWdnRWxuQm9y?=
 =?utf-8?B?NDNyUjZJY0VyNFlGT3drYmVLMS8rQkhZU0VBeG5tNXZyTXVrSG1pOS9pOXY3?=
 =?utf-8?B?eGx2U1VkNDBheEpla3lac1MzY3J5ZDNvbHZpMHZCU2I4UG54cWpTcXlTcm1m?=
 =?utf-8?B?NktDS1VWMWhQWVJkK28rMWJ1UGY2RCtIQXM3eWRQZ2lVcHhHUWRzV2VDS0FB?=
 =?utf-8?B?SFhSM2FXV09LTGRabmowZ2MrcW4vbHRsbWt4NWRnWWxJWDVkYTZQUzZRTDBB?=
 =?utf-8?B?eUIzdVVjdUptNHhrUUhiQkJVN3hLQzZmS0I5U05MeElsbzVEcjNLcDhGU3kx?=
 =?utf-8?B?TURCZ1lGTkRmMWx1L1hzUUJvODNXeUtkWHh5M2dJTE9rY3g4dm1SMWFTZXE3?=
 =?utf-8?B?SUhJOWUrd2s0MHYwTm15VzBacHdYM2M3WFlFVmhaTGkyalV3bk9razlURzM3?=
 =?utf-8?B?VlUvVHhnVldWT29wYXNDZWpwVE0zMzh3V0wveVNoeFg2YlpyVHVCbWdINFhT?=
 =?utf-8?B?Z0Y2TGw2dmNNK3pxcXUyRFFHcUZ0bzdlcE1teDZpOVFiMlpJVUtkaEIzRXg2?=
 =?utf-8?B?REJNekoyVVlOcFJQRjlla0NDT0RNdXpIZm5wV2hVYmpaQndHUjRlQkFYQnpG?=
 =?utf-8?B?Y2k4Y1R0eitEaUNmWktXQ2tEYlpPQjNvc0g0YjE5eUNoRkNOTDRWaW5hamZ4?=
 =?utf-8?B?NG1veDNlOTgxNnFVZHVQV1V4Q2kzdk9JRjJWT0trWldzWXp5KzBOeTZBZ1N1?=
 =?utf-8?B?M3lpeHAyTVlqcTU3aS9YVlpZUExxd1dldVZKOHVvTjYvbGRwNDI0ZHJLV2tH?=
 =?utf-8?B?OUZDZnlBOHdvZWdLemphUjZJMi9MODg0Q2pzWVlLQUZBcTFSTm5GbnJ4cy9v?=
 =?utf-8?B?WXBFalZmVEJMQjJtcHpVMExCR3hHZEYwR0lVMmZ1a2tHOEE3MEdVbllkSmtB?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0505AC406F58A347AB10116B91B5534F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7183.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c2e3af-bf54-4df0-fb34-08dbaf8abac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 10:10:57.6986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CTF5TXSqXPOdlLtoC9Yfz8VZj2wUJ2aTFcuHpqc+B28MsFyDz684d5nNZ2VHqjW1hef8NLdCEARatMURHEdG0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7137
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA5LTA3IGF0IDE3OjQyICswODAwLCBUemUtbmFuIFd1IHdyb3RlOg0KDQpN
b3JlIGluZm9ybWF0aW9uIGFkZGVkLg0KPiBPbiBUdWUsIDIwMjMtMDktMDUgYXQgMTI6MzkgLTA0
MDAsIFN0ZXZlbiBSb3N0ZWR0IHdyb3RlOg0KPiA+ICAJIA0KPiA+IEV4dGVybmFsIGVtYWlsIDog
UGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzDQo+ID4gdW50aWwN
Cj4gPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+ICBP
biBUdWUsIDUgU2VwIDIwMjMgMjI6MTI6NDUgKzA4MDANCj4gPiBUemUtbmFuIFd1IDxUemUtbmFu
Lld1QG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gPiBXaGlsZSByZWFkaW5nIGZyb20g
dGhlIHRyYWNpbmcvdHJhY2UsIHRoZSBmdHJhY2UgcmVhZGVyIHJhcmVseQ0KPiA+IA0KPiA+IGVu
Y291bnRlcnMNCj4gPiA+IGEgS0FTQU4gaW52YWxpZCBhY2Nlc3MgaXNzdWUuDQo+ID4gPiBJdCBp
cyBsaWtlbHkgdGhhdCB0aGUgd3JpdGVyIGhhcyBkaXNydXB0ZWQgdGhlIHJpbmdfYnVmZmVyIHRo
YXQNCj4gPiA+IHRoZQ0KPiA+IA0KPiA+IHJlYWRlcg0KPiA+ID4gaXMgY3VycmVudGx5IHBhcnNp
bmcuIHRoZSBrYXNhbiByZXBvcnQgaXMgYXMgYmVsb3c6DQo+ID4gDQo+ID4gV2hhdCBrZXJuZWwg
YXJlIHlvdSB1c2luZz8gVGhlcmUncyBiZWVuIHJlY2VudCBmaXhlcyB0aGF0IGhhbmRsZQ0KPiA+
IHRoZQ0KPiA+IHJhY2UNCj4gPiBiZXR3ZWVuIHJlYWRpbmcgdGhlIGxhc3QgZW50cnkgYW5kIHRo
ZSB3cml0ZXIgYWRkaW5nIHRvIGl0LiBUaGlzDQo+ID4gbG9va3MgbGlrZQ0KPiA+IHlvdSBtYXkg
aGF2ZSBoaXQgdGhhdCBidWcuDQo+ID4gDQo+IA0KPiBJIGFtIGN1cnJlbnRseSB1c2luZyBrZXJu
ZWwgdmVyc2lvbiA2LjEuMjQsIGJ1dCBJIGhhdmUgYXBwbGllZCB0aGUNCj4gcGF0Y2ggZm9yIHRo
ZSByaW5nYnVmZmVyLmMgZmlsZSB1cCB0byBrZXJuZWwgdmVyc2lvbiA2LjEuNTIuIEhvd2V2ZXIs
DQo+IEkNCj4gYW0gc3RpbGwgYWJsZSB0byByZXByZHVjZSB0aGUgaXNzdWUuDQo+IA0KPiBCVFcs
IG15IGRlY2ljZSBoYXZlIEFSQ0g9QVJNNjQgYW5kIFBBR0VTSVpFPTRLDQo+IA0KPiA+ID4gDQo+
ID4gPiBbbmFtZTpyZXBvcnQmXUJVRzogS0FTQU46IGludmFsaWQtYWNjZXNzIGluDQo+ID4gDQo+
ID4gcmJfaXRlcl9oZWFkX2V2ZW50KzB4MjdjLzB4M2QwDQo+ID4gPiBbbmFtZTpyZXBvcnQmXVJl
YWQgb2Ygc2l6ZSA0IGF0IGFkZHIgNzFmZmZmODExMWExODAwMCBieSB0YXNrDQo+ID4gPiB4eHh4
DQo+ID4gPiBbbmFtZTpyZXBvcnRfc3dfdGFncyZdUG9pbnRlciB0YWc6IFs3MV0sIG1lbW9yeSB0
YWc6IFswZl0NCj4gPiA+IFtuYW1lOnJlcG9ydCZdDQo+ID4gPiBDUFU6IDIgUElEOiAzODAgQ29t
bTogeHh4eA0KPiA+ID4gQ2FsbCB0cmFjZToNCj4gPiA+IGR1bXBfYmFja3RyYWNlKzB4MTY4LzB4
MWIwDQo+ID4gPiBzaG93X3N0YWNrKzB4MmMvMHgzYw0KPiA+ID4gZHVtcF9zdGFja19sdmwrMHhh
NC8weGQ0DQo+ID4gPiBwcmludF9yZXBvcnQrMHgyNjgvMHg5YjANCj4gPiA+IGthc2FuX3JlcG9y
dCsweGRjLzB4MTQ4DQo+ID4gPiBrYXNhbl90YWdfbWlzbWF0Y2grMHgyOC8weDNjDQo+ID4gPiBf
X2h3YXNhbl90YWdfbWlzbWF0Y2grMHgyYy8weDU4DQo+ID4gPiByYl9ldmVudF9sZW5ndGgoKSBb
aW5saW5lXQ0KPiA+ID4gcmJfaXRlcl9oZWFkX2V2ZW50KzB4MjdjLzB4M2QwDQo+ID4gPiByaW5n
X2J1ZmZlcl9pdGVyX3BlZWsrMHgyM2MvMHg2ZTANCj4gPiA+IF9fZmluZF9uZXh0X2VudHJ5KzB4
MWFjLzB4M2Q4DQo+ID4gPiBzX25leHQrMHgxZjAvMHgzMTANCj4gPiA+IHNlcV9yZWFkX2l0ZXIr
MHg0ZTgvMHg3N2MNCj4gPiA+IHNlcV9yZWFkKzB4ZjgvMHgxNTANCj4gPiA+IHZmc19yZWFkKzB4
MWE4LzB4NGNjDQo+ID4gPiANCj4gPiA+IEluIHNvbWUgZWRnZSBjYXNlcywgZnRyYWNlIHJlYWRl
ciBjb3VsZCBhY2Nlc3MgdG8gYW4gaW52YWxpZA0KPiA+IA0KPiA+IGFkZHJlc3MsDQo+ID4gPiBz
cGVjaWZpY2FsbHkgd2hlbiByZWFkaW5nIDQgYnl0ZXMgYmV5b25kIHRoZSBlbmQgb2YgdGhlIGN1
cnJlbnRseQ0KPiA+IA0KPiA+IHBhZ2UuDQo+ID4gPiBXaGlsZSBpc3N1ZSBoYXBwZW5lZCwgdGhl
IGR1bXAgb2YgcmJfaXRlcl9oZWFkX2V2ZW50IGlzIHNob3duIGFzDQo+ID4gDQo+ID4gYmVsb3c6
DQo+ID4gPiANCj4gPiA+ICAgICBpbiBmdW5jdGlvbiByYl9pdGVyX2hlYWRfZXZlbnQ6DQo+ID4g
PiAgICAgICAgICAgLSBpdGVyLT5oZWFkID0gMHhGRUMNCj4gPiA+ICAgICAgICAgICAtIGl0ZXIt
Pm5leHRfZXZlbnQgPSAweEZFQw0KPiA+ID4gICAgICAgICAgIC0gY29tbWl0ID0gMHhGRjANCj4g
PiA+ICAgICAgICAgICAtIHJlYWRfc3RhbXAgPSAweDI5NTVBQzQ2REIwDQo+ID4gPiAgICAgICAg
ICAgLSBwYWdlX3N0YW1wID0gMHgyOTU1QUMyNDM5QQ0KPiA+ID4gICAgICAgICAgIC0gaXRlci0+
aGVhZF9wYWdlLT5wYWdlID0gMHg3MUZGRkY4MTExQTE3MDAwDQo+ID4gPiAgICAgICAgICAgLSBp
dGVyLT5oZWFkX3BhZ2UtPnRpbWVfc3RhbXAgPSAweDI5NTZBMTQyMjY3DQo+ID4gPiAgICAgICAg
ICAgLSBpdGVyLT5oZWFkX3BhZ2UtPnBhZ2UtPmNvbW1pdCA9IDB4RkYwDQo+ID4gPiAgICAgICAg
ICAgLSB0aGUgY29udGVudCBpbiBpdGVyLT5oZWFkX3BhZ2UtPnBhZ2UNCj4gPiA+ICAgICAgICAg
ICAgICAgICAweDcxRkZGRjgxMTFBMTdGRjA6IDAxMDEwMDc1IDAwMDAyNDIxIDBBMTIzQjdDDQo+
ID4gDQo+ID4gRkZGRkZGQzANCj4gPiA+IA0KPiA+ID4gSW4gcmJfaXRlcl9oZWFkX2V2ZW50LCBy
ZWFkZXIgd2lsbCBjYWxsIHJiX2V2ZW50X2xlbmd0aCB3aXRoDQo+ID4gDQo+ID4gYXJndW1lbnQN
Cj4gPiA+IChzdHJ1Y3QgcmluZ19idWZmZXJfZXZlbnQgKmV2ZW50ID0gMHg3MUZGRkY4MTExQTE3
RkZDKS4NCj4gPiANCj4gPiBBcyB0aGUgY29tbWl0IGlzIGNvbnNpZGVyZWQgdGhlIGVuZCBvZiBi
dWZmZXIsIGl0IHNob3VsZCBuZXZlciByZWFkDQo+ID4gcGFzdA0KPiA+IHRoYXQsIHdoaWNoIHRo
ZSBhYm92ZSBhcHBlYXJzIHRvIGJlIGRvaW5nLiBUaGF0J3Mgd2h5IEkgdGhpbmsgaXQNCj4gPiBo
aXQNCj4gPiB0aGF0DQo+ID4gcmFjZS4NCj4gPiANCj4gDQo+IFNhbWUgYXMgbXkgdGhvdWdodCwN
Cj4gc2luY2UgZXZlcnkgdGltZSB0aGUgcmVhZGVyIHRyeSB0byBhY2Nlc3MgdGhlIGFkZHJlc3Mg
aW4gbmV4dCBwYWdlLA0KPiB0aGUgYmVsb3cgY29uZGl0aW9uIGhvbGQgaW4gcmJfaXRlcl9oZWFk
X2V2ZW50IGZ1bmN0aW9uOg0KPiANCj4gICAgICAgICBpZiAoaXRlci0+cGFnZV9zdGFtcCAhPSBp
dGVyX2hlYWRfcGFnZS0+cGFnZS0+dGltZV9zdGFtcCB8fA0KPiAgICAgICAgICAgICAgICAgY29t
bWl0ID4gcmJfcGFnZV9jb21taXQoaXRlcl9oZWFkX3BhZ2UpKQ0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICBnb3RvIHJlc2V0Ow0KPiANCj4gSSBvYnNlcnZlIHRoZSByZXN1bHQgYnkgdGhlIGRl
YnVnIHBhdGNoIHByb3ZpZGVkIGJlbG93Og0KPiANCj4gICAgICAgICBAQCAtMjM3OCw2ICsyMzc4
LDE5IEBAIHJiX2l0ZXJfaGVhZF9ldmVudChzdHJ1Y3QNCj4gcmluZ19idWZmZXJfaXRlciAqaXRl
cikNCj4gICAgICAgICAgICAgICAgIGNvbW1pdCA9IHJiX3BhZ2VfY29tbWl0KGl0ZXJfaGVhZF9w
YWdlKTsNCj4gICAgICAgICAgICAgICAgIHNtcF9ybWIoKTsNCj4gICAgICAgICArICAgICAgIGlm
ICgoaXRlci0+aGVhZCA+PSAweEZFQ1VMKSAmJiBjb21taXQgPT0gMHhGRjBVTCkgew0KPiAgICAg
ICAgICsgICAgICAgICAgICAgICBwcl9pbmZvKCJyYmRiZzogY3B1ID0gJWQsIGV2ZW50ID0gMHgl
bHgsDQo+IGl0ZXItDQo+ID4gaGVhZCA9IDB4JWx4LFwNCj4gDQo+ICAgICAgICAgKyAgICAgICAg
ICAgICAgICAgICAgICAgY29tbWl0ID0gMHhGRjAsIHR5cGUgPSAweCV4LCB0cyA9DQo+IDB4JXgs
DQo+IGFycmF5IGFkZHIgPSAweCVseFxuIixcDQo+ICAgICAgICAgKyAgICAgICAgICAgICAgICAg
ICAgICAgaXRlci0+Y3B1X2J1ZmZlci0+Y3B1LCAodW5zaWduZWQNCj4gbG9uZylldmVudCwgaXRl
ci0+aGVhZCxcDQo+ICAgICAgICAgKyAgICAgICAgICAgICAgICAgICAgICAgZXZlbnQtPnR5cGVf
bGVuLCBldmVudC0+dGltZV9kZWx0YSwNCj4gKHVuc2lnbmVkIGxvbmcpKCYoZXZlbnQtPmFycmF5
WzBdKSkpOw0KPiAgICAgICAgICsgICAgICAgICAgICAgICBtZGVsYXkoNTAwKTsNCj4gICAgICAg
ICArICAgICAgICAgICAgICAgcHJfaW5mbygicmJkYmcyOiBjcHUgPSAlZCwgZXZlbnQgPSAweCVs
eCwNCj4gaXRlci0NCj4gPiBoZWFkID0gMHglbHgsXA0KPiANCj4gICAgICAgICArICAgICAgICAg
ICAgICAgICAgICAgICBjb21taXQgPSAweEZGMCwgdHlwZSA9IDB4JXgsIHRzID0NCj4gMHgleCwN
Cj4gYXJyYXkgYWRkciA9IDB4JWx4XG4iLFwNCj4gICAgICAgICArICAgICAgICAgICAgICAgICAg
ICAgICBpdGVyLT5jcHVfYnVmZmVyLT5jcHUsICh1bnNpZ25lZA0KPiBsb25nKWV2ZW50LCBpdGVy
LT5oZWFkLFwNCj4gICAgICAgICArICAgICAgICAgICAgICAgICAgICAgICBldmVudC0+dHlwZV9s
ZW4sIGV2ZW50LT50aW1lX2RlbHRhLA0KPiAodW5zaWduZWQgbG9uZykoJihldmVudC0+YXJyYXlb
MF0pKSk7DQo+ICAgICAgICAgKyAgICAgICAgICAgICAgIGlmIChpdGVyLT5wYWdlX3N0YW1wICE9
IGl0ZXJfaGVhZF9wYWdlLT5wYWdlLQ0KPiA+IHRpbWVfc3RhbXAgfHwgY29tbWl0ID4gcmJfcGFn
ZV9jb21taXQoaXRlcl9oZWFkX3BhZ2UpKQ0KPiANCj4gICAgICAgICArICAgICAgICAgICAgICAg
ICAgICAgICBwcl9pbmZvKCJyYmRiZzogd3JpdGVyIGNvcnJ1cHQNCj4gcmVhZGVyXG4iKTsNCj4g
ICAgICAgICArICAgICAgIH0NCj4gICAgICAgICAgICAgICAgIGV2ZW50ID0gX19yYl9wYWdlX2lu
ZGV4KGl0ZXJfaGVhZF9wYWdlLCBpdGVyLT5oZWFkKTsNCj4gICAgICAgICAgICAgICAgIGxlbmd0
aCA9IHJiX2V2ZW50X2xlbmd0aChldmVudCk7DQo+IA0KPiBOb3RlIHRoYXQgdGhlIG1kZWxheSg1
MDApIGluIHRoZSBkZWJ1ZyBwYXRjaCBjYW4gcmVwcm9kdWNlIHRoZSBpc3N1ZQ0KPiBlYXNpZXIg
d2l0aCBzYW1lIHRlc3QgaW4gbXkgZW52aXJvbm1uZXQsDQo+IEkgYW0gbm93IGFibGUgdG8gcmVw
cm9kdWNlIHRoZSBpc3N1ZSB3aXRoaW4gMTUgbWludXRlcyBpZiB0aGUgZGVidWcNCj4gcGF0Y2gg
b24uDQo+IA0KDQpUaGUgZGVidWcgcGF0Y2ggbWF5IGdpdmUgc29tZXRoaW5nIHNpbWlsYXIgdG8g
dGhlIGJlbG93IGxvZyBqdXN0IGJlZm9yZQ0KdGhlIGludmFsaWQgYWNjZXNzIGhhcHBlbmVkLCBm
b3IgbWUgaXQgbG9va3MgbGlrZSB0aGUgcGFkZGluZyBldmVudCBoYWQNCmp1c3QgY29ycnVwdGVk
IGJ5IHRoZSB3cml0ZXIgYmVmb3JlIHRoZSByZWFkZXIgaW52b2tlIHJiX2V2ZW50X2xlbmd0aA0K
ZnVuY3Rpb24gb24gaXQuDQoNClsgIDMzOC4xNTY3NzJdIGNhdDogW25hbWU6cmluZ19idWZmZXIm
XXJiZGJnOiBjcHUgPSAwLCBldmVudCA9DQoweD8/Pz8/Pz8/Pz8/P2RmZmMsIGl0ZXItPmhlYWQg
PSAweGZlYywgY29tbWl0ID0gMHhGRjAsIHR5cGUgPSAweDFkLCB0cw0KPSAweDAsIGFycmF5IGFk
ZHIgPSAweD8/Pz8/Pz8/Pz8/P2UwMDANClsgIDMzOC42NTY3OTZdIGNhdDogW25hbWU6cmluZ19i
dWZmZXImXXJiZGJnMjogY3B1ID0gMCwgZXZlbnQgPQ0KMHg/Pz8/Pz8/Pz8/Pz9kZmZjLCBpdGVy
LT5oZWFkID0gMHhmZWMsIGNvbW1pdCA9IDB4RkYwLCB0eXBlID0gMHgwLCB0cw0KPSAweDAsIGFy
cmF5IGFkZHIgPSAweD8/Pz8/Pz8/Pz8/P2UwMDANClsgIDMzOC42NTY4MDNdIGNhdDogW25hbWU6
cmluZ19idWZmZXImXXJiZGJnOiB3cml0ZXIgY29ycnVwdCByZWFkZXINClsgIDMzOC42NTY4MTBd
IGNhdDoNCltuYW1lOnJlcG9ydCZdPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09DQo9PT09PT09PT0NClsgIDMzOC42NTY4MTldIGNhdDogW25h
bWU6cmVwb3J0Jl1CVUc6IEtBU0FOOiBpbnZhbGlkLWFjY2VzcyBpbg0KcmJfZXZlbnRfbGVuZ3Ro
DQoNCg0KPiA+ID4gU2luY2UgdGhlIGNvbnRlbnQgZGF0YSBzdGFydCBhdCBhZGRyZXNzIDB4NzFG
RkZGODExMUExN0ZGQyBhcmUNCj4gPiANCj4gPiAweEZGRkZGRkMwLg0KPiA+ID4gZXZlbnQtPnR5
cGUgd2lsbCBiZSBpbnRlcnByZXQgYXMgMHgwLCB0aGFuIHRoZSByZWFkZXIgd2lsbCB0cnkgdG8N
Cj4gPiANCj4gPiBnZXQgdGhlDQo+ID4gPiBsZW5ndGggYnkgYWNjZXNzaW5nIGV2ZW50LT5hcnJh
eVswXSwgd2hpY2ggaXMgYW4gaW52YWxpZCBhZGRyZXNzOg0KPiA+ID4gICAgICZldmVudC0+YXJy
YXlbMF0gPSAweDcxRkZGRjgxMTFBMTgwMDANCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTog
VHplLW5hbiBXdSA8VHplLW5hbi5XdUBtZWRpYXRlay5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IEZv
bGxvd2luZyBwYXRjaCBtYXkgbm90IGJlY29tZSBhIHNvbHV0aW9uLCBpdCBtZXJlbHkgY2hlY2tz
IGlmDQo+ID4gPiB0aGUNCj4gPiANCj4gPiBhZGRyZXNzDQo+ID4gPiB0byBiZSBhY2Nlc3NlZCBp
cyB2YWxpZCBvciBub3Qgd2l0aGluIHRoZSByYl9ldmVudF9sZW5ndGggYmVmb3JlDQo+ID4gDQo+
ID4gYWNjZXNzLg0KPiA+ID4gQW5kIG5vdCBzdXJlIGlmIHRoZXJlIGlzIGFueSBzaWRlLWVmZmVj
dCBpdCBjYW4gbGVhZCB0by4NCj4gPiA+IA0KPiA+ID4gSSBhbSBjdXJpb3VzIGFib3V0IHdoYXQg
YSBiZXR0ZXIgc29sdXRpb24gZm9yIHRoaXMgaXNzdWUgd291bGQNCj4gPiA+IGxvb2sNCj4gPiAN
Cj4gPiBsaWtlLg0KPiA+ID4gU2hvdWxkIHdlIGFkZHJlc3MgdGhlIHByb2JsZW0gZnJvbSB0aGUg
d3JpdGVyIG9yIHRoZSByZWFkZXI/DQo+ID4gPiANCj4gPiA+IEFsc28gSSB3b25kZXIgaWYgdGhl
IGNhdXNlIG9mIHRoZSBpc3N1ZSBpcyBleGFjdGx5IGFzIEkNCj4gPiA+IHN1c3BlY3RlZC4NCj4g
PiA+IEFueSBTdWdnZXN0aW9uIHdpbGwgYmUgYXBwcmVjaWF0ZWQuDQo+ID4gDQo+ID4gSSBndWVz
cyB0aGlzIGRlcGVuZHMgb24gaWYgeW91IGhhdmUgdGhlIGZpeGVzIG9yIG5vdD8NCj4gPiANCj4g
DQo+IHllcywgSSBjb3VsZCB0cnkgdG8gcGljayB0aGUgcGF0Y2hlcyB0aGF0IG9ubHkgaW5jbHVk
ZWQgaW4gbWFpbmxpbmUNCj4gYnV0DQo+IG5vdCBpbiBrZXJuZWwtNi4xLjUyIGZvciByaW5nX2J1
ZmZlci5jIGZpbGUsDQo+IGFuZCBkbyB0aGUgc2FtZSB0ZXN0IHRvIHNlZSBpZiB0aGUgaXNzdWUg
aXMgc3RpbGwgcmVwcm9kdWNpYmxlLg0KPiANCj4gPiA+IA0KPiA+ID4gVGVzdCBiZWxvdyBjYW4g
cmVwcm9kdWNlIHRoZSBpc3N1ZSBpbiAyIGhvdXJzIG9uIGtlcm5lbC02LjEuMjQ6DQo+ID4gPiAg
ICAgJGNkIC9zeXMva2VybmVsL3RyYWNpbmcvDQo+ID4gPiAgICAgIyBtYWtlIHRoZSByZWFkZXIg
YW5kIHdyaXRlciByYWNlIG1vcmUgdGhyb3VnaCByZXNpemUgdGhlDQo+ID4gDQo+ID4gYnVmZmVy
IHRvIDhrYg0KPiA+ID4gICAgICRlY2hvIDggPiBidWZmZXJfc2l6ZV9rbg0KPiA+ID4gICAgICMg
ZW5hYmxlIGFsbCBldmVudHMNCj4gPiA+ICAgICAkZWNobyAxID4gZXZlbnQvZW5hYmxlDQo+ID4g
PiAgICAgIyBlbmFibGUgdHJhY2UNCj4gPiA+ICAgICAkZWNobyAxID4gdHJhY2luZ19vbg0KPiA+
ID4gIA0KPiA+ID4gICAgICMgd3JpdGUgYW5kIHJ1biBhIHNjcmlwdCB0aGF0IGtlZXAgcmVhZGlu
ZyB0cmFjZQ0KPiA+ID4gICAgICQuL3JlYWRfdHJhY2Uuc2gNCj4gPiA+IA0KPiA+ID4gICAgIGBg
YCByZWFkX3RyYWNlLnNoDQo+ID4gPiAgICAgICAgd2hpbGUgOg0KPiA+ID4gICAgICAgIGRvDQo+
ID4gPiAgICAgICAgICAgIGNhdCAvc3lzL2tlcm5lbC90cmFjaW5nL3RyYWNlID4gL2Rldi9udWxs
DQo+ID4gPiAgICAgICAgZG9uZQ0KPiA+ID4gDQo+ID4gPiAgICAgYGBgDQo+ID4gDQo+ID4gVGhh
bmtzLCBJJ2xsIGxvb2sgYXQgdGhhdCB3aGVuIEkgZmluaXNoIGRlYnVnZ2luZyB0aGUgZXZlbnRm
cyBidWcuDQo+ID4gDQo+ID4gLS0gU3RldmUNCj4gDQo+IEFsc28gdGhhbmsgZm9yIHlvdXIgcmVw
bHksDQo+IA0KDQpBbmQgdGhlIHRlbXBvcmFyeSBmaXggcGF0Y2ggaW4gbXkgZmlyc3QgbWFpbCBz
aG91bGQgaGF2ZSBzb21lIG1vZGlmaWVkDQphcyBzaG93biBiZWxvdy4NCisgICAgICAgICAgICAg
ICBpZiAoKCh1bnNpZ25lZCBsb25nKWV2ZW50ICYgMHhmZmZVTCkgPj0gUEFHRV9TSVpFIC0gNCkN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5eXl5eXg0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQQUdFX1NJWkUtMQ0KKyAg
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC0xOw0KDQo+IC0tIFR6ZS1uYW4NCg==
