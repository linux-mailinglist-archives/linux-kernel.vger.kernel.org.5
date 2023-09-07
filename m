Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE4E797A56
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244825AbjIGRiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244803AbjIGRh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:37:59 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0781BF5;
        Thu,  7 Sep 2023 10:37:29 -0700 (PDT)
X-UUID: e591c3de4d6211ee8051498923ad61e6-20230907
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=KUIpFichziDibBzvTI2Pghi7JhscG/YmfAlwKAUSGZ4=;
        b=nM7O7xy2ivVZyAPR9r0+cb4bh9j9rS+S/ylN3M2NYD5Lx7WIwuKc8jchYdXEdfsxzrnEqMGWTGaYL4WBXwcly6HqRSMFSVPyIz1NfnNKHpS+21X/JEXIRJVaNcnDDZype01kibX1uaXGFq0sWmO3oDS8wixrclOrsO/LPZK0Oxs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:c847e640-9c21-4324-9ced-73e8f66980cb,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:e233c1c2-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: e591c3de4d6211ee8051498923ad61e6-20230907
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <tze-nan.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 859946551; Thu, 07 Sep 2023 17:42:44 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 7 Sep 2023 17:42:43 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 7 Sep 2023 17:42:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byBKaOpBJJ8mH6qgAVljnGXFkYBXPjw4QLPyDAclnsMwmc37wrHBYXQlftzlawFcyPBhYc6mJpX70fzd1RgBOWVGsCMFV3r90vwy9NH+DVX+8P7w1w4bHUO5sp/RF3fxFFj0R1gYXi1kcsge2ITBCFHrsEc4IJrIFy6AZY4P1ichWPMA/rihXX3zpAZ65Mu4WmfkIgjl6kzEkBftYPydQDEY9pjcsBZOsmJCadH9HpMlczg8SIHMqE5eQk6bsSDcRhMbZEJHuDHtcceTKWmJGhVX2BQH1tXCaY596r+zpfak/lCQx7zQx7Eyljje/JcOvYPkJqvkNIykOZMHp07+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUIpFichziDibBzvTI2Pghi7JhscG/YmfAlwKAUSGZ4=;
 b=V9xOK0j/5TWf30DYiydpjoa7cws53WYPwA9qe6ZFJrDPH4lEGMGLD7KrjGSA93AQ8VQv3H2VZuQKleenopUVrrjlrwzuijonXPRQK1b7DPUy4NOM0dYQXVasxFP4aBnSQH8dyOdgDQtm3wVCEvRSkcWL3u1HG2d9Qy0GcBKyIjyqMN71OiPmQ6eN4A9/99b1MBAOTbAz3AVLbjBvQjEKcoy3bBHFdQq9ykbsbkm/uhMCk6YXiemF0rEVoWzOGem+RB9COLDhcZ7Tlp/N3AdQZ4uFDHgEx7/aMBkC4rBuU1IlbaollfWpkY/eR/lYSXXluRTS3VhL8kX4gKSO62jDVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUIpFichziDibBzvTI2Pghi7JhscG/YmfAlwKAUSGZ4=;
 b=MQsL+Uj9GW6BUEqE6HX2WeGpUiGikdNSdsei/T0Q3WA8kb+rFbFYVVKhc+3HmkVkSqzEh3bKfhkxdntBMkcuHlWHFCFGyiINK0AVhBV0mFjBhG8b//i3rBuSWYyPtlu1pgPH0ArYpXmv4fVCEgSS0ASaaIdJx6D9dCQX9ODaTm0=
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com (2603:1096:400:33a::11)
 by PSAPR03MB5717.apcprd03.prod.outlook.com (2603:1096:301:7a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 09:42:41 +0000
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::f225:e6ee:8a9:ee06]) by TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::f225:e6ee:8a9:ee06%6]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 09:42:41 +0000
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
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] ring-buffer: Do not read at &event->array[0] if it across
 the page
Thread-Topic: [PATCH] ring-buffer: Do not read at &event->array[0] if it
 across the page
Thread-Index: AQHZ4AMSZ8i3KRUX2kOyE7jyhtvSj7AMbyqAgAKwGAA=
Date:   Thu, 7 Sep 2023 09:42:41 +0000
Message-ID: <3a89d49ae0da6378de83bc68690cf6664d97cb24.camel@mediatek.com>
References: <20230905141245.26470-1-Tze-nan.Wu@mediatek.com>
         <20230905123953.3c0b3d7a@gandalf.local.home>
In-Reply-To: <20230905123953.3c0b3d7a@gandalf.local.home>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7183:EE_|PSAPR03MB5717:EE_
x-ms-office365-filtering-correlation-id: 26706e6c-6b5a-4d70-a6ef-08dbaf86c788
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vh5JX80a26WY+n3Lsvb+Kv1MRuNzLQM16N8r2wTqhldwKX6MQs8GvYm9w16cLHVZx+ZqnjpE6J4p++z1sXuJ8ym1l/KZZfST/6cpBzAFvqv80C82EzdKzj28hifTjVSfZVyuJUNkwa9FrKN5PeypIpwzrK/fv7Has4OpqGW0PCTOnhOEc2Y9LvhN8zcXGfl/HgCI+2T6dcMEUNgg1ZUxMb02G55evzukfHAd40CZr2P0xGc5opxIcn9oA1OapCr0Pz1ZnDVN7iiksdZKJOzm8p48zCUf6DAal3HM9F+GTOt0rlCfHcyzKdAiB8ORzg5pZ2AhqUNaq8jmR4S/XJrY4DkfOzvraXgjayr5ZvoLRNU7V2XIKasoUzDFYR2fh4d4Iv+hpvohzbviDH2EqPdDE/HUUcKBXOVhaJFGiTVxmBxQ5+qdwE2by/AqVeVEHrM3kNsF75L+a4PffIqWJW/cPUqjjvMOwiFwoSSCTPzyfv9X3gbkwF6HlyDbE8+zc7BQuZkaXkrPRgZ35oaLKmnPdApEhoHm5Fw/0eimqIyFvHJn1Mos7v9Z4nn4uLfVK5gQUN+InVxoH9iV1LhXwholXX7XoTl14Zxi1un7htbkJ3Q3LFpiJqExF1ASnmxkZkzbtLSMy1lUGWt8Ntj8WpmR7068YUOaGeydqk7e7ltko6M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7183.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(396003)(39860400002)(1800799009)(186009)(451199024)(71200400001)(6486002)(6506007)(122000001)(36756003)(85182001)(86362001)(38070700005)(38100700002)(2906002)(2616005)(26005)(478600001)(83380400001)(6512007)(316002)(66946007)(8676002)(5660300002)(4326008)(76116006)(8936002)(66446008)(6916009)(66556008)(54906003)(41300700001)(64756008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekNZNDdwanlIZTExekVmSnZNdngzOWY0QnMvY3crU0tkVEc0UWNkbnZMMnJT?=
 =?utf-8?B?TWdtYW8xTERWTGZaL3lOY0VwZDBlZ2FEZVAvNytHRnNDR2NQS3ZxWDU4WDQw?=
 =?utf-8?B?K21xQjBXT2plQnUyOW13enZpb3JOMkV0MXNBbmFVR2EwS01tRnpqNWt2YzVU?=
 =?utf-8?B?ZE53cFQ5WUVWN3lKSElJL3lBUk5tZ05rM2FrTGxWdmEySi85Z003Q1FaZ1cv?=
 =?utf-8?B?Mk4wazNTTmR5a1N6RWZSMHVML0VUanp1UjZHU0tqbXdWM1ZWU2JEWk1BcmFq?=
 =?utf-8?B?UWVTZmd4OWlISG1vODJrREtIaWtqOFNqbzRteUFneHU0RkJwQUVXTmNHSENw?=
 =?utf-8?B?TlRvS0lnR3l2eUxzLzhCSWJtUlo3bDVkOXZhaGxWbGZxVENnek9XVHNCaTY3?=
 =?utf-8?B?Q3RSR1M4eUk2NlRKN2o1a1RWTUdnSm9OeEtGTmpGM0c1dWNzc1ZSVzUyMUpQ?=
 =?utf-8?B?bjZnaDJHZ0tvbDBnZW1DTW1SUlIxSURWd0VxM2lXcGFnUkVaUkgyMUNIRDE5?=
 =?utf-8?B?QWMyR3NwQXZDb28ycmpBTkd3M1Y0T0kzMjJiV0hLUlpRNCszU2p3UzkvM2FK?=
 =?utf-8?B?Wk9rU1BzNHR5b0djM0pTODJyVHFFRDFtWEsvRk84dEc1dHRTNm5ma3VKRTUv?=
 =?utf-8?B?QVcwMFRhRjdUZFZLODQrbVBiZy9kY3B6MkZkWjdaZTNyankwZFVxc2JSdVlL?=
 =?utf-8?B?SnQxYjY2RE1ROWlLLzFlOGRaVCtlSFR1WnQ4aHgvSnBxTHBUODBGajl4cS9Y?=
 =?utf-8?B?dEVCa2dyR1RxSGdMYUQxcEl5Z1AxdGQzRVc3eWlLbmZSdE1vTFE4clNybjdp?=
 =?utf-8?B?MURKZjJpU1FHeEY3RjdWNlNYT05lWDZTRjlCY2hNWUZmNjl6eVg3NE9BRkVM?=
 =?utf-8?B?R3NtWWJCUGVYamdKaHp2SHJaUGplQ0ZjcXF4YXNNK0NuR1lZcGJXbzg5ZTVC?=
 =?utf-8?B?ckxCKzg2MzRNSUFidzhRZVUrTEdIMVdXS1NPcjBZZlJMVTd2ZlpHSXExbElE?=
 =?utf-8?B?WWFqQzRLanZVTzZJQXBWdkNBR0hDbnZDM0VGTG93WHZSRHZIdGlpbEI5Y1I1?=
 =?utf-8?B?bDk3ckIrUC84V1ZIZUxhZDVtajIyeU45WnNyZjFUMXB3cVRjNkVBZldVanpT?=
 =?utf-8?B?OVRiaTZhUThieVB2U2ZYSW1YR0RYejM2c0I1a2ExRlp6V0pJMEtCRlUxcXE4?=
 =?utf-8?B?d3liZFh6U1VlL0haNkdldmw2SkFWSGJTK1d1RnhoWTB3a05uUnRMZXJnSzBl?=
 =?utf-8?B?Ym9HVnNkSHZ2L29McDBkTG5ScEdUY0l2VWpvTlA0WHZTR3JudzduWWREQzIv?=
 =?utf-8?B?aG0zQStjRzBHQXN5RUE2dkFORWNGd2RubkxvUXVEbWp6dFhQREJ3UDVqNmhO?=
 =?utf-8?B?dnJBMUhCc1N2L0xBcDlaV21xcUQ5VlY4WTlUSndDY2VjRXpsYU9MRHBuNnN6?=
 =?utf-8?B?OUxFVGYzSlpDRDBEQjM2MEJKbUpBWEhQY29Bdi9BN2VCdmRjL3pkaTNyZnNM?=
 =?utf-8?B?T2NzVllwQk90eENZVFZFeVVlR3dKV0lNaGJhVkxxR3dhQU8zYjA5dnRBQlR3?=
 =?utf-8?B?K0lubUloV1ZESWV2dUJkRGhSK0tidjkwUjBGTW5nR1VjOXdiNmdKalJzQ1FB?=
 =?utf-8?B?cFNZdXpjVnBpNTJic3plZXdxdHZzaitBbGdESlNuaytidGtYOVdMSTZxSW91?=
 =?utf-8?B?WHR5V2tyNDR2cmR4cFZRbjdHTUd4RkJCLzI4dlRWa1JrR0ptcUxuRUpLVTg5?=
 =?utf-8?B?QkJEbVNNdVRwSTgzWXZEdHV0SDJBUld1ei8xa1FoS1Mycy8wMFNEMC9SVmtr?=
 =?utf-8?B?TDZkQ0I2dGxnNDV4NllIRHIzZERZSmdxOXdxcjMxSmN4WTJZdVRSd3A4V1Qy?=
 =?utf-8?B?anlYNkwvaU1NbExieHJWVjRkY3NRRGJJbG1XcUxYQUtBRVMzMVhOQ3NwYWhG?=
 =?utf-8?B?QWhlWkE1WFhjc3RmMVZlQndGTEN4QzZqM1JpNXRiTUZ5anYzdVhoZU1kcnNP?=
 =?utf-8?B?eUg4VTQ4eWQ1WFI0dkFjeW1nNUd3MUd2LzBlNzRoT1pFQ295Y2s2Ty9sY3VV?=
 =?utf-8?B?elZoTEhwNTJEZmpmRXR4eVc5V2FNOHpuSkFWdFl0TnZ5dmdkUjlPaDRyKzJR?=
 =?utf-8?B?amlseDk5SUFSZWJrZjlvc2FKMFovSUROYzkyZVoxWlNJWGJsWVZoWGtlZnpr?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E388EE53D5501444B83D78963C099AB1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7183.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26706e6c-6b5a-4d70-a6ef-08dbaf86c788
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 09:42:41.0541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sqhFJx8QRS4wIWgsNmla2UD3pgpSCrD1Ip/I5JvJPtylUCWrj7Eq4kOSJ5bAwwoStSbQzvSZHiy/8Y7F5Me2lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5717
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA5LTA1IGF0IDEyOjM5IC0wNDAwLCBTdGV2ZW4gUm9zdGVkdCB3cm90ZToN
Cj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+ICBPbiBUdWUsIDUgU2VwIDIwMjMgMjI6MTI6NDUgKzA4MDANCj4gVHpl
LW5hbiBXdSA8VHplLW5hbi5XdUBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiANCj4gPiBXaGlsZSBy
ZWFkaW5nIGZyb20gdGhlIHRyYWNpbmcvdHJhY2UsIHRoZSBmdHJhY2UgcmVhZGVyIHJhcmVseQ0K
PiBlbmNvdW50ZXJzDQo+ID4gYSBLQVNBTiBpbnZhbGlkIGFjY2VzcyBpc3N1ZS4NCj4gPiBJdCBp
cyBsaWtlbHkgdGhhdCB0aGUgd3JpdGVyIGhhcyBkaXNydXB0ZWQgdGhlIHJpbmdfYnVmZmVyIHRo
YXQgdGhlDQo+IHJlYWRlcg0KPiA+IGlzIGN1cnJlbnRseSBwYXJzaW5nLiB0aGUga2FzYW4gcmVw
b3J0IGlzIGFzIGJlbG93Og0KPiANCj4gV2hhdCBrZXJuZWwgYXJlIHlvdSB1c2luZz8gVGhlcmUn
cyBiZWVuIHJlY2VudCBmaXhlcyB0aGF0IGhhbmRsZSB0aGUNCj4gcmFjZQ0KPiBiZXR3ZWVuIHJl
YWRpbmcgdGhlIGxhc3QgZW50cnkgYW5kIHRoZSB3cml0ZXIgYWRkaW5nIHRvIGl0LiBUaGlzDQo+
IGxvb2tzIGxpa2UNCj4geW91IG1heSBoYXZlIGhpdCB0aGF0IGJ1Zy4NCj4gDQoNCkkgYW0gY3Vy
cmVudGx5IHVzaW5nIGtlcm5lbCB2ZXJzaW9uIDYuMS4yNCwgYnV0IEkgaGF2ZSBhcHBsaWVkIHRo
ZQ0KcGF0Y2ggZm9yIHRoZSByaW5nYnVmZmVyLmMgZmlsZSB1cCB0byBrZXJuZWwgdmVyc2lvbiA2
LjEuNTIuIEhvd2V2ZXIsIEkNCmFtIHN0aWxsIGFibGUgdG8gcmVwcmR1Y2UgdGhlIGlzc3VlLg0K
DQpCVFcsIG15IGRlY2ljZSBoYXZlIEFSQ0g9QVJNNjQgYW5kIFBBR0VTSVpFPTRLDQoNCj4gPiAN
Cj4gPiBbbmFtZTpyZXBvcnQmXUJVRzogS0FTQU46IGludmFsaWQtYWNjZXNzIGluDQo+IHJiX2l0
ZXJfaGVhZF9ldmVudCsweDI3Yy8weDNkMA0KPiA+IFtuYW1lOnJlcG9ydCZdUmVhZCBvZiBzaXpl
IDQgYXQgYWRkciA3MWZmZmY4MTExYTE4MDAwIGJ5IHRhc2sgeHh4eA0KPiA+IFtuYW1lOnJlcG9y
dF9zd190YWdzJl1Qb2ludGVyIHRhZzogWzcxXSwgbWVtb3J5IHRhZzogWzBmXQ0KPiA+IFtuYW1l
OnJlcG9ydCZdDQo+ID4gQ1BVOiAyIFBJRDogMzgwIENvbW06IHh4eHgNCj4gPiBDYWxsIHRyYWNl
Og0KPiA+IGR1bXBfYmFja3RyYWNlKzB4MTY4LzB4MWIwDQo+ID4gc2hvd19zdGFjaysweDJjLzB4
M2MNCj4gPiBkdW1wX3N0YWNrX2x2bCsweGE0LzB4ZDQNCj4gPiBwcmludF9yZXBvcnQrMHgyNjgv
MHg5YjANCj4gPiBrYXNhbl9yZXBvcnQrMHhkYy8weDE0OA0KPiA+IGthc2FuX3RhZ19taXNtYXRj
aCsweDI4LzB4M2MNCj4gPiBfX2h3YXNhbl90YWdfbWlzbWF0Y2grMHgyYy8weDU4DQo+ID4gcmJf
ZXZlbnRfbGVuZ3RoKCkgW2lubGluZV0NCj4gPiByYl9pdGVyX2hlYWRfZXZlbnQrMHgyN2MvMHgz
ZDANCj4gPiByaW5nX2J1ZmZlcl9pdGVyX3BlZWsrMHgyM2MvMHg2ZTANCj4gPiBfX2ZpbmRfbmV4
dF9lbnRyeSsweDFhYy8weDNkOA0KPiA+IHNfbmV4dCsweDFmMC8weDMxMA0KPiA+IHNlcV9yZWFk
X2l0ZXIrMHg0ZTgvMHg3N2MNCj4gPiBzZXFfcmVhZCsweGY4LzB4MTUwDQo+ID4gdmZzX3JlYWQr
MHgxYTgvMHg0Y2MNCj4gPiANCj4gPiBJbiBzb21lIGVkZ2UgY2FzZXMsIGZ0cmFjZSByZWFkZXIg
Y291bGQgYWNjZXNzIHRvIGFuIGludmFsaWQNCj4gYWRkcmVzcywNCj4gPiBzcGVjaWZpY2FsbHkg
d2hlbiByZWFkaW5nIDQgYnl0ZXMgYmV5b25kIHRoZSBlbmQgb2YgdGhlIGN1cnJlbnRseQ0KPiBw
YWdlLg0KPiA+IFdoaWxlIGlzc3VlIGhhcHBlbmVkLCB0aGUgZHVtcCBvZiByYl9pdGVyX2hlYWRf
ZXZlbnQgaXMgc2hvd24gYXMNCj4gYmVsb3c6DQo+ID4gDQo+ID4gICAgIGluIGZ1bmN0aW9uIHJi
X2l0ZXJfaGVhZF9ldmVudDoNCj4gPiAgICAgICAgICAgLSBpdGVyLT5oZWFkID0gMHhGRUMNCj4g
PiAgICAgICAgICAgLSBpdGVyLT5uZXh0X2V2ZW50ID0gMHhGRUMNCj4gPiAgICAgICAgICAgLSBj
b21taXQgPSAweEZGMA0KPiA+ICAgICAgICAgICAtIHJlYWRfc3RhbXAgPSAweDI5NTVBQzQ2REIw
DQo+ID4gICAgICAgICAgIC0gcGFnZV9zdGFtcCA9IDB4Mjk1NUFDMjQzOUENCj4gPiAgICAgICAg
ICAgLSBpdGVyLT5oZWFkX3BhZ2UtPnBhZ2UgPSAweDcxRkZGRjgxMTFBMTcwMDANCj4gPiAgICAg
ICAgICAgLSBpdGVyLT5oZWFkX3BhZ2UtPnRpbWVfc3RhbXAgPSAweDI5NTZBMTQyMjY3DQo+ID4g
ICAgICAgICAgIC0gaXRlci0+aGVhZF9wYWdlLT5wYWdlLT5jb21taXQgPSAweEZGMA0KPiA+ICAg
ICAgICAgICAtIHRoZSBjb250ZW50IGluIGl0ZXItPmhlYWRfcGFnZS0+cGFnZQ0KPiA+ICAgICAg
ICAgICAgICAgICAweDcxRkZGRjgxMTFBMTdGRjA6IDAxMDEwMDc1IDAwMDAyNDIxIDBBMTIzQjdD
DQo+IEZGRkZGRkMwDQo+ID4gDQo+ID4gSW4gcmJfaXRlcl9oZWFkX2V2ZW50LCByZWFkZXIgd2ls
bCBjYWxsIHJiX2V2ZW50X2xlbmd0aCB3aXRoDQo+IGFyZ3VtZW50DQo+ID4gKHN0cnVjdCByaW5n
X2J1ZmZlcl9ldmVudCAqZXZlbnQgPSAweDcxRkZGRjgxMTFBMTdGRkMpLg0KPiANCj4gQXMgdGhl
IGNvbW1pdCBpcyBjb25zaWRlcmVkIHRoZSBlbmQgb2YgYnVmZmVyLCBpdCBzaG91bGQgbmV2ZXIg
cmVhZA0KPiBwYXN0DQo+IHRoYXQsIHdoaWNoIHRoZSBhYm92ZSBhcHBlYXJzIHRvIGJlIGRvaW5n
LiBUaGF0J3Mgd2h5IEkgdGhpbmsgaXQgaGl0DQo+IHRoYXQNCj4gcmFjZS4NCj4gDQoNClNhbWUg
YXMgbXkgdGhvdWdodCwNCnNpbmNlIGV2ZXJ5IHRpbWUgdGhlIHJlYWRlciB0cnkgdG8gYWNjZXNz
IHRoZSBhZGRyZXNzIGluIG5leHQgcGFnZSwNCnRoZSBiZWxvdyBjb25kaXRpb24gaG9sZCBpbiBy
Yl9pdGVyX2hlYWRfZXZlbnQgZnVuY3Rpb246DQoNCiAgICAgICAgaWYgKGl0ZXItPnBhZ2Vfc3Rh
bXAgIT0gaXRlcl9oZWFkX3BhZ2UtPnBhZ2UtPnRpbWVfc3RhbXAgfHwNCiAgICAgICAgICAgICAg
ICBjb21taXQgPiByYl9wYWdlX2NvbW1pdChpdGVyX2hlYWRfcGFnZSkpDQogICAgICAgICAgICAg
ICAgICAgICAgICBnb3RvIHJlc2V0Ow0KDQpJIG9ic2VydmUgdGhlIHJlc3VsdCBieSB0aGUgZGVi
dWcgcGF0Y2ggcHJvdmlkZWQgYmVsb3c6DQoNCiAgICAgICAgQEAgLTIzNzgsNiArMjM3OCwxOSBA
QCByYl9pdGVyX2hlYWRfZXZlbnQoc3RydWN0DQpyaW5nX2J1ZmZlcl9pdGVyICppdGVyKQ0KICAg
ICAgICAgICAgICAgIGNvbW1pdCA9IHJiX3BhZ2VfY29tbWl0KGl0ZXJfaGVhZF9wYWdlKTsNCiAg
ICAgICAgICAgICAgICBzbXBfcm1iKCk7DQogICAgICAgICsgICAgICAgaWYgKChpdGVyLT5oZWFk
ID49IDB4RkVDVUwpICYmIGNvbW1pdCA9PSAweEZGMFVMKSB7DQogICAgICAgICsgICAgICAgICAg
ICAgICBwcl9pbmZvKCJyYmRiZzogY3B1ID0gJWQsIGV2ZW50ID0gMHglbHgsIGl0ZXItDQo+aGVh
ZCA9IDB4JWx4LFwNCiAgICAgICAgKyAgICAgICAgICAgICAgICAgICAgICAgY29tbWl0ID0gMHhG
RjAsIHR5cGUgPSAweCV4LCB0cyA9IDB4JXgsDQphcnJheSBhZGRyID0gMHglbHhcbiIsXA0KICAg
ICAgICArICAgICAgICAgICAgICAgICAgICAgICBpdGVyLT5jcHVfYnVmZmVyLT5jcHUsICh1bnNp
Z25lZA0KbG9uZylldmVudCwgaXRlci0+aGVhZCxcDQogICAgICAgICsgICAgICAgICAgICAgICAg
ICAgICAgIGV2ZW50LT50eXBlX2xlbiwgZXZlbnQtPnRpbWVfZGVsdGEsDQoodW5zaWduZWQgbG9u
ZykoJihldmVudC0+YXJyYXlbMF0pKSk7DQogICAgICAgICsgICAgICAgICAgICAgICBtZGVsYXko
NTAwKTsNCiAgICAgICAgKyAgICAgICAgICAgICAgIHByX2luZm8oInJiZGJnMjogY3B1ID0gJWQs
IGV2ZW50ID0gMHglbHgsIGl0ZXItDQo+aGVhZCA9IDB4JWx4LFwNCiAgICAgICAgKyAgICAgICAg
ICAgICAgICAgICAgICAgY29tbWl0ID0gMHhGRjAsIHR5cGUgPSAweCV4LCB0cyA9IDB4JXgsDQph
cnJheSBhZGRyID0gMHglbHhcbiIsXA0KICAgICAgICArICAgICAgICAgICAgICAgICAgICAgICBp
dGVyLT5jcHVfYnVmZmVyLT5jcHUsICh1bnNpZ25lZA0KbG9uZylldmVudCwgaXRlci0+aGVhZCxc
DQogICAgICAgICsgICAgICAgICAgICAgICAgICAgICAgIGV2ZW50LT50eXBlX2xlbiwgZXZlbnQt
PnRpbWVfZGVsdGEsDQoodW5zaWduZWQgbG9uZykoJihldmVudC0+YXJyYXlbMF0pKSk7DQogICAg
ICAgICsgICAgICAgICAgICAgICBpZiAoaXRlci0+cGFnZV9zdGFtcCAhPSBpdGVyX2hlYWRfcGFn
ZS0+cGFnZS0NCj50aW1lX3N0YW1wIHx8IGNvbW1pdCA+IHJiX3BhZ2VfY29tbWl0KGl0ZXJfaGVh
ZF9wYWdlKSkNCiAgICAgICAgKyAgICAgICAgICAgICAgICAgICAgICAgcHJfaW5mbygicmJkYmc6
IHdyaXRlciBjb3JydXB0DQpyZWFkZXJcbiIpOw0KICAgICAgICArICAgICAgIH0NCiAgICAgICAg
ICAgICAgICBldmVudCA9IF9fcmJfcGFnZV9pbmRleChpdGVyX2hlYWRfcGFnZSwgaXRlci0+aGVh
ZCk7DQogICAgICAgICAgICAgICAgbGVuZ3RoID0gcmJfZXZlbnRfbGVuZ3RoKGV2ZW50KTsNCg0K
Tm90ZSB0aGF0IHRoZSBtZGVsYXkoNTAwKSBpbiB0aGUgZGVidWcgcGF0Y2ggY2FuIHJlcHJvZHVj
ZSB0aGUgaXNzdWUNCmVhc2llciB3aXRoIHNhbWUgdGVzdCBpbiBteSBlbnZpcm9ubW5ldCwNCkkg
YW0gbm93IGFibGUgdG8gcmVwcm9kdWNlIHRoZSBpc3N1ZSB3aXRoaW4gMTUgbWludXRlcyBpZiB0
aGUgZGVidWcNCnBhdGNoIG9uLg0KDQo+ID4gU2luY2UgdGhlIGNvbnRlbnQgZGF0YSBzdGFydCBh
dCBhZGRyZXNzIDB4NzFGRkZGODExMUExN0ZGQyBhcmUNCj4gMHhGRkZGRkZDMC4NCj4gPiBldmVu
dC0+dHlwZSB3aWxsIGJlIGludGVycHJldCBhcyAweDAsIHRoYW4gdGhlIHJlYWRlciB3aWxsIHRy
eSB0bw0KPiBnZXQgdGhlDQo+ID4gbGVuZ3RoIGJ5IGFjY2Vzc2luZyBldmVudC0+YXJyYXlbMF0s
IHdoaWNoIGlzIGFuIGludmFsaWQgYWRkcmVzczoNCj4gPiAgICAgJmV2ZW50LT5hcnJheVswXSA9
IDB4NzFGRkZGODExMUExODAwMA0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFR6ZS1uYW4gV3Ug
PFR6ZS1uYW4uV3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+IEZvbGxvd2luZyBwYXRjaCBt
YXkgbm90IGJlY29tZSBhIHNvbHV0aW9uLCBpdCBtZXJlbHkgY2hlY2tzIGlmIHRoZQ0KPiBhZGRy
ZXNzDQo+ID4gdG8gYmUgYWNjZXNzZWQgaXMgdmFsaWQgb3Igbm90IHdpdGhpbiB0aGUgcmJfZXZl
bnRfbGVuZ3RoIGJlZm9yZQ0KPiBhY2Nlc3MuDQo+ID4gQW5kIG5vdCBzdXJlIGlmIHRoZXJlIGlz
IGFueSBzaWRlLWVmZmVjdCBpdCBjYW4gbGVhZCB0by4NCj4gPiANCj4gPiBJIGFtIGN1cmlvdXMg
YWJvdXQgd2hhdCBhIGJldHRlciBzb2x1dGlvbiBmb3IgdGhpcyBpc3N1ZSB3b3VsZCBsb29rDQo+
IGxpa2UuDQo+ID4gU2hvdWxkIHdlIGFkZHJlc3MgdGhlIHByb2JsZW0gZnJvbSB0aGUgd3JpdGVy
IG9yIHRoZSByZWFkZXI/DQo+ID4gDQo+ID4gQWxzbyBJIHdvbmRlciBpZiB0aGUgY2F1c2Ugb2Yg
dGhlIGlzc3VlIGlzIGV4YWN0bHkgYXMgSSBzdXNwZWN0ZWQuDQo+ID4gQW55IFN1Z2dlc3Rpb24g
d2lsbCBiZSBhcHByZWNpYXRlZC4NCj4gDQo+IEkgZ3Vlc3MgdGhpcyBkZXBlbmRzIG9uIGlmIHlv
dSBoYXZlIHRoZSBmaXhlcyBvciBub3Q/DQo+IA0KDQp5ZXMsIEkgY291bGQgdHJ5IHRvIHBpY2sg
dGhlIHBhdGNoZXMgdGhhdCBvbmx5IGluY2x1ZGVkIGluIG1haW5saW5lIGJ1dA0Kbm90IGluIGtl
cm5lbC02LjEuNTIgZm9yIHJpbmdfYnVmZmVyLmMgZmlsZSwNCmFuZCBkbyB0aGUgc2FtZSB0ZXN0
IHRvIHNlZSBpZiB0aGUgaXNzdWUgaXMgc3RpbGwgcmVwcm9kdWNpYmxlLg0KDQo+ID4gDQo+ID4g
VGVzdCBiZWxvdyBjYW4gcmVwcm9kdWNlIHRoZSBpc3N1ZSBpbiAyIGhvdXJzIG9uIGtlcm5lbC02
LjEuMjQ6DQo+ID4gICAgICRjZCAvc3lzL2tlcm5lbC90cmFjaW5nLw0KPiA+ICAgICAjIG1ha2Ug
dGhlIHJlYWRlciBhbmQgd3JpdGVyIHJhY2UgbW9yZSB0aHJvdWdoIHJlc2l6ZSB0aGUNCj4gYnVm
ZmVyIHRvIDhrYg0KPiA+ICAgICAkZWNobyA4ID4gYnVmZmVyX3NpemVfa24NCj4gPiAgICAgIyBl
bmFibGUgYWxsIGV2ZW50cw0KPiA+ICAgICAkZWNobyAxID4gZXZlbnQvZW5hYmxlDQo+ID4gICAg
ICMgZW5hYmxlIHRyYWNlDQo+ID4gICAgICRlY2hvIDEgPiB0cmFjaW5nX29uDQo+ID4gIA0KPiA+
ICAgICAjIHdyaXRlIGFuZCBydW4gYSBzY3JpcHQgdGhhdCBrZWVwIHJlYWRpbmcgdHJhY2UNCj4g
PiAgICAgJC4vcmVhZF90cmFjZS5zaA0KPiA+IA0KPiA+ICAgICBgYGAgcmVhZF90cmFjZS5zaA0K
PiA+ICAgICAgICB3aGlsZSA6DQo+ID4gICAgICAgIGRvDQo+ID4gICAgICAgICAgICBjYXQgL3N5
cy9rZXJuZWwvdHJhY2luZy90cmFjZSA+IC9kZXYvbnVsbA0KPiA+ICAgICAgICBkb25lDQo+ID4g
DQo+ID4gICAgIGBgYA0KPiANCj4gVGhhbmtzLCBJJ2xsIGxvb2sgYXQgdGhhdCB3aGVuIEkgZmlu
aXNoIGRlYnVnZ2luZyB0aGUgZXZlbnRmcyBidWcuDQo+IA0KPiAtLSBTdGV2ZQ0KDQpBbHNvIHRo
YW5rIGZvciB5b3VyIHJlcGx5LA0KDQotLSBUemUtbmFuDQo=
