Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884D87C6A49
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343598AbjJLKB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235798AbjJLKBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:01:09 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEF010E;
        Thu, 12 Oct 2023 03:00:15 -0700 (PDT)
X-UUID: 20168cb268e611ee8051498923ad61e6-20231012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=zemzA5azsgkDRhdp0ShrGAbLsYiH90MErarvBxPWywY=;
        b=joGFOSjXHTe/DVqiDlmXP1KqyqQngF1nsdBITibPgyR2prXsGiKMqLIcExKFW0sHTQW1hCBQ3Ochu+PR5mIFboQTA2Ih10hC1tYC0KYmE5zPBgSZnewmHtWmF6GqDrEFAFPWxOMtNgQVCxrCmP9CPbO4xR5ZHzK9BSRAhHc5Qzo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:dd263f81-9059-4994-8f6f-5aa757ef7ca2,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:5f78ec9,CLOUDID:7809f414-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 20168cb268e611ee8051498923ad61e6-20231012
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 158313168; Thu, 12 Oct 2023 18:00:08 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 12 Oct 2023 18:00:06 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 12 Oct 2023 18:00:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZQ2ToxnyCCUMRUfAAAENQFTMsNqvaLKQtfQHSGSHPYzgPsXTpQ48TFEk4ST1FddAK4iA1BYzeU28Z+FxHbUB4/1gDDH0mwQJe78h6oxAeiGbtS8sjoMInSAWW4ws+zUZvu0KRizlrgijoibN+W2RMXuN/glzYlHa4HAs4BiR+rZQYrVO1k+4l5a2G5SZOv69Ky7eOu1Zkz6pRoz9di3SYtdak3tAccnpVSjdJfgwAvnkDnb2HY82Iycrm+MjnTmpXHUOMcAhsoIKgYhn0C7YA3dERgBR0doMoGGgBcxw70U3TnDxRWGJkzIipzrf5Zu2DMcer8anEO0gL3h+rv33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zemzA5azsgkDRhdp0ShrGAbLsYiH90MErarvBxPWywY=;
 b=FFAWRvlNycf/Jg8HOUBjAURc0bdNS2xNmPjaivCny6SfQMudt0yUpLGJeOdSSEYArsXwjObWdbV7A2ezF5vi3o7zRjWNKXvD0u//VOv3ZLKYl/NcNpKu6a+RQ6uh8pPA65RVpNu//GdWhSgIKSrZfC1gqk4DO732ce/pdIzZEmqR7ClffsVOHprEljf+6uXngbpK/DliaadDnCMSjZI7SfErfNK84JcWl1Dmv/Eq+ASvIzKwdJef0WmQ+71e/Sd7rpuCMv75wJN95lFYBiToN7ThFRUZjN+e5TCxQpEdHek794f6iRXHaefnE1uJLQnfuylCTiHDUgz+FTBv2d6pXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zemzA5azsgkDRhdp0ShrGAbLsYiH90MErarvBxPWywY=;
 b=SRQ/2d3Gu46bgdTCsYqJ/KAKJ/KqJUwTl7GVms95CcTDc59O5drDl+D1PkAXfmwfqVw/6ES26LK8xIY9QQdt9NAFU2tAJs+2KCPcsrb3AFvoRuVusIapMyYrkB3SxMhINDk/TizRuRq6g5V0cY2K59UpeoTHI3tJxg4vp3uYyQc=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by KL1PR03MB6141.apcprd03.prod.outlook.com (2603:1096:820:90::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 10:00:04 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::d451:c5cd:4a93:2a62]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::d451:c5cd:4a93:2a62%4]) with mapi id 15.20.6813.017; Thu, 12 Oct 2023
 10:00:04 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] media: mediatek: vcodec: using encoder device to
 alloc/free encoder memory
Thread-Topic: [PATCH v2] media: mediatek: vcodec: using encoder device to
 alloc/free encoder memory
Thread-Index: AQHZ+3QvchoRVljVA0CgvSOPwLHgh7BF7tSA
Date:   Thu, 12 Oct 2023 10:00:04 +0000
Message-ID: <3b8c1e14c49724e03a6d3e70eee28fd354a3a1a0.camel@mediatek.com>
References: <20231010122010.25937-1-yunfei.dong@mediatek.com>
In-Reply-To: <20231010122010.25937-1-yunfei.dong@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|KL1PR03MB6141:EE_
x-ms-office365-filtering-correlation-id: 6faeaec5-9149-436e-b162-08dbcb0a01b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wSHKCnQx2df5p1vZpUL7Deh4CIVriquBzQ3OMgX+++FxGS6Uj6+4Whce8dV+1/p1VRoN62Isppqxlu9/URP/FHUU8sHvjn2tM/r7s9jLIgTuS+0z3Ph6fOqR3B+q4SYcXgTQH8MYvW/uigFQH7OVc9alhUiHshre0jeJH6VbvTZMrSkhnOtdz9QrIE06P5D4pu+C/bRBDSUwHxK45OL9n/AHzZXvTpfSSf0ZqxOH1n97rkFSDmNB9moHYG3vKVQ1Gu//QCUWRo8EoQPE/aykCmB+CB/blK7jx+Hq25C6eZUu/cAA4e/IBT5SbjNM/U8/O/CL92vJ27GNrGVm26FT9syl+IJMzmPF+Q1AxjHKd/JKdjVKrd8faE4H3EJtS7wRYzByLCSxQmNIrwazKxXRqxL4JlTUA0NIBlT+3zCfMx5PgExAOS0GicB11b/NhfZ0V6Y+Ai8FwAqyx85tdef/ZesMOEkxLCMAszcGyWfTVyv1wb0cohSVZd14c5QOSfEFM34AgqKK7k2oO74Q0Sb3PGZl9wyZNkoyIzzTXKqdbD5BwENPT9KHN4Q61O/5Unyr98+IaG2GKSpanf4oOjidVHacCNH9rULvQ6eaMXYBg62ysrFV3FMNl7WfN5J4DUyEmy3ONKbjm1j7CEP7Kd2WvG/oPXCgiTjmEglBmZ5wbAWplGor6jpE0R1EVxflVkP6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(136003)(376002)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(6486002)(478600001)(91956017)(110136005)(66446008)(83380400001)(64756008)(316002)(54906003)(41300700001)(66556008)(5660300002)(66476007)(66946007)(8936002)(71200400001)(8676002)(76116006)(4326008)(7416002)(6506007)(4001150100001)(2906002)(2616005)(85182001)(36756003)(26005)(38100700002)(6512007)(38070700005)(122000001)(86362001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1JDOWF1YnhGTkpHM21YTGNSSFpzQVFWV1JHZVcxY0ZHakN6dGNQZ3dVVUNt?=
 =?utf-8?B?eWQ5bEM5UTFJaG00cW1DbVdHMGE4QmQxQmlYdHJ3VEZzL29RYWpRYWQyME5O?=
 =?utf-8?B?WVVlWDJGajJQNnZBQ0FKRGQ1eU81VkNJcjJUSzNHZzc3Mk5YT1hML3lxMkFJ?=
 =?utf-8?B?dHk4Uk4rdmNiQm1leXFxRXJTZmxLMERHYlk5UlNPR3VWRm1Na0FtOWdYTzVF?=
 =?utf-8?B?U05TVFZZQUNQUG42aGhKd21laVRlNFNTNWRNbnYxSGNGUkx4YSswQU13UG5C?=
 =?utf-8?B?YStXQUZyYldGRmx5cDUwVlRKOVZMcU9ZYTQ1bTJBbi9ucnpleENtS1puR3Rx?=
 =?utf-8?B?dE9uUnYvODJZVlg0djVRZHRaUWhyWWd0NEtlaHA1WWZmS3g4dVBtbUR6VVM2?=
 =?utf-8?B?RURqYlNyTzZucm82bWNKUHVGZkhnTFFxaTBSSUQ4QysySTlRcnJDM2YreHRq?=
 =?utf-8?B?eG9JejRQeFljWGRVR1p0T1VIN3MxdlFVVWN5MmtIcFhnNlNuTkxKbEJKL3JY?=
 =?utf-8?B?dmtMYS81dDJDNVkzdFVVS2pPMS9DSVRwUVhNRmxRcXpZMzZWMnFvamoxUXVl?=
 =?utf-8?B?ckU2WUkwbDcyTFZGMkJLT3FJMS9BdU94bFp6U0drRkdCY2hDYU9PQnNyY1BN?=
 =?utf-8?B?Tk5mQ1k1VEl5Wi9sdjRBOGx5RWt5MWJLL2w0a0xrTDU0a3k3NE13OVYwZnpk?=
 =?utf-8?B?Tm9yVGIyODdGblhpckVvR3Exb0VIaGJXNnpBOHZFTHZMYUJXMlZyY2hmZDcy?=
 =?utf-8?B?TWRGTmJUUVkvTDl4QVNXa21jcGVpbXlrbGo5b3U2WTNIQW5GVFZqcE1QRjMz?=
 =?utf-8?B?SXZjd0NRT1hrZUFDWk5KekhBNlRPb2FiY2xMVzk2bnFpVzBBT0NuUlZWKy83?=
 =?utf-8?B?N2d6bGZMVDNZWW05eHRTay9vcElEV3UzU0YwTlU2WXR6cFowOGZuZTRTK0E3?=
 =?utf-8?B?aU13SlppS1ZhcXZhUWlzNlBGZkRoQXF0dCt3NmloUzNQZ0Y0K1F2emNFS2xm?=
 =?utf-8?B?c1I2c0JNaDVRbGs5aWM0WHVnZURpTDNucDRScWlhRWZMNkpaOXZVZ1kza01Y?=
 =?utf-8?B?UFNRSWhTaFJxbXZjMmxSKzAvZzZpTGRZanVYcFNOaTUvdzM2YjkxU1prY3JF?=
 =?utf-8?B?bGFxUTM3TGFyd1k3WCsrTERkZExFN0FmdnRqM2JYVi9HbVdja0VxdGZNYlNR?=
 =?utf-8?B?RjdneEwvanIxRG9hcytDc2RtTld6NytiYU5TVUk3QlRlU1FlMThCZktzT09p?=
 =?utf-8?B?akdKTHRVTXpkNTF6WnVRUmd5OWxyeEE3R0d5TFl5alFZaFM4Nkd6T3E2SUN0?=
 =?utf-8?B?M29WeEU2eFM1YnpUUnVJREJEVWJKVmhsUDBUaWMxQjlnRGMwQzA0OUxnSjlB?=
 =?utf-8?B?Z0xXRHFtSi82V1E1Uk1mVUpvWEROdUVKWWlJQ2puQURKbzZwYUVaQ3F0TFZI?=
 =?utf-8?B?SURCRGZpdWR6VVBzOTh0OW5aekt6RksvTm9UeGNGdWtOdUZ2c09UUXEvUDVl?=
 =?utf-8?B?UWZ6b0FCOEZoMjlTTmZPMEJHTkdLUlZtSjkzRmRLbG05aVZZRE4vbEFvbGlj?=
 =?utf-8?B?TlRzcG1XemxmMGQ5b25vZy80RDRVeGtqRjVnT2ZlSW1QY1FvcnFQNTZTVEpS?=
 =?utf-8?B?dDdBdEtmZW4wOUFlblUrc1dTcmxweHhFdEVGUkpJdFR6ZHAxVml1bDVxNlVL?=
 =?utf-8?B?U01hUGQwcVpFUlNnSTU4eGJraVNUa3hJUmtSTThDZCtseFlISGpramdkaDMr?=
 =?utf-8?B?UUFlbnAxL3pVRUI4SnVDcUNETmQ1SWRyZnp0ekFrWXZ5VEJrWUxQN3ZpbHF6?=
 =?utf-8?B?dzc3RnZoMDEyVHo3WDBhQi9iT0gxb0RJVnRJdGNkdm43bzR5cCtVQ3F2bUdJ?=
 =?utf-8?B?TGs2M3lQWWkyMEJNMzYxZVdQY0ZWWHVnaE0rblJRY2ViZ1c0UmRZR0l0a0ZX?=
 =?utf-8?B?NXk1TmNXUWlRamdDMnNEWjZheWgzSGRUa1pURFNmckVDNHJJUzIyd0s2bkhR?=
 =?utf-8?B?V013M0JudjJyc1NNc1FSL1l4QkhoRTVXOG1YYVBaZzBHYm1HQlBjUkVDRk50?=
 =?utf-8?B?anBERk52SFNUelliWFZ4SElkZUJIMnMwWFNLN0RUL0VTL1NxSVpXVFVwd0tj?=
 =?utf-8?B?aUs5anJ2V3lhMGxCYjRhcEJCeEJVTmdxR2pLZGRFbDhqOXBnYnAwRm1wNUJj?=
 =?utf-8?B?RkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A2DB6910FA3514F94170FFC3E8779EB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6faeaec5-9149-436e-b162-08dbcb0a01b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 10:00:04.1593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rUjChW9bdBYYHqwLBIeN+TPVYNKldIvjVG+nddXku21HEyn8EAYS69vz7tQyW+8KtGETG03lGknAuuFcVIRCu5y/keLHIMa4mgW9O0ljcGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6141
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--12.319700-8.000000
X-TMASE-MatchedRID: oTBA/+sdKaZjDV//SvkH3ia1MaKuob8PC/ExpXrHizz4JyR+b5tvoIw4
        FkpVp0jX9IqAdUPEkbteUgGM1TqOIzsjH2rWHzbWUIhTTahb7dWe4TzN1NEjXyS30GKAkBxWn1k
        iBCfjYF3VIgPUVpPw2IOEytVBBZaHYlldA0POS1JSGsgQwHevX5dhffisWXfHRQ0dAChl/lz8/L
        2o6LnOl44ktSmkU0+e9fNhUVsK8nFccQ8eam5EfdIFVVzYGjNKWQy9YC5qGvzKU1cWyI3gWkkpb
        iYOUmwxIAcCikR3vq/kOF5q0wVjb+p7/ronY78V/q0NQM9d4F4VpSjRQSGMq6mk467c73Dx
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.319700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: A1D2A4017577E1CEBF2517086A783073A311AB11465C83F15A1D610DE6B7A6242000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvR2lvYWNjaGlubywNCg0KQ291bGQgeW91IHBsZWFzZSBoZWxwIHRvIHJldmlldyB0
aGlzIHBhdGNoIGFnYWluLg0KDQpCZXN0IFJlZ2FyZHMsDQpZdW5mZWkgRG9uZw0KDQpPbiBUdWUs
IDIwMjMtMTAtMTAgYXQgMjA6MjAgKzA4MDAsIFl1bmZlaSBEb25nIHdyb3RlOg0KPiBOZWVkIHRv
IHVzZSBlbmNvZGVyIGRldmljZSB0byBhbGxvY2F0ZS9mcmVlIGVuY29kZXIgbWVtb3J5IHdoZW4N
Cj4gY2FsbGluZw0KPiBtdGtfdmNvZGVjX21lbV9hbGxvYy9tdGtfdmNvZGVjX21lbV9mcmVlLCBv
ciBsZWFkaW5nIHRvIGJlbG93IGNyYXNoDQo+IGxvZw0KPiB3aGVuIHRlc3QgZW5jb2RlciB3aXRo
IGRlY29kZXIgZGV2aWNlLg0KPiANCj4gcGMgOiBkbWFfYWxsb2NfYXR0cnMrMHg0NC8weGY0DQo+
IGxyIDogbXRrX3Zjb2RlY19tZW1fYWxsb2MrMHg1MC8weGE0IFttdGtfdmNvZGVjX2NvbW1vbl0N
Cj4gc3AgOiBmZmZmZmZjMDIwOWYzOTkwDQo+IHgyOTogZmZmZmZmYzAyMDlmMzlhMCB4Mjg6IGZm
ZmZmZjgwMjQxMDJhMTggeDI3OiAwMDAwMDAwMDAwMDAwMDAwDQo+IHgyNjogMDAwMDAwMDAwMDAw
MDAwMCB4MjU6IGZmZmZmZmMwMGMwNmUyZDggeDI0OiAwMDAwMDAwMDAwMDAwMDAxDQo+IHgyMzog
MDAwMDAwMDAwMDAwMGNjMCB4MjI6IDAwMDAwMDAwMDAwMDAwMTAgeDIxOiAwMDAwMDAwMDAwMDAw
ODAwDQo+IHgyMDogZmZmZmZmODAyNDEwMmExOCB4MTk6IDAwMDAwMDAwMDAwMDAwMDAgeDE4OiAw
MDAwMDAwMDAwMDAwMDAwDQo+IHgxNzogMDAwMDAwMDAwMDAwMDAwOSB4MTY6IGZmZmZmZmUzODk3
MzZhOTggeDE1OiAwMDAwMDAwMDAwMDAwMDc4DQo+IHgxNDogZmZmZmZmZTM4OTcwNDQzNCB4MTM6
IDAwMDAwMDAwMDAwMDAwMDcgeDEyOiBmZmZmZmZlMzhhMmIyNTYwDQo+IHgxMTogMDAwMDAwMDAw
MDAwMDgwMCB4MTA6IDAwMDAwMDAwMDAwMDAwMDQgeDkgOiBmZmZmZmZlMzMxZjA3NDg0DQo+IHg4
IDogNTQwMGU5YWVmMjM5NTAwMCB4NyA6IDAwMDAwMDAwMDAwMDAwMDAgeDYgOiAwMDAwMDAwMDAw
MDAwMDNmDQo+IHg1IDogMDAwMDAwMDAwMDAwMDAwMSB4NCA6IDAwMDAwMDAwMDAwMDAwMDAgeDMg
OiAwMDAwMDAwMDAwMDAwY2MwDQo+IHgyIDogZmZmZmZmODAyNDEwMmExOCB4MSA6IDAwMDAwMDAw
MDAwMDA4MDAgeDAgOiAwMDAwMDAwMDAwMDAwMDEwDQo+IENhbGwgdHJhY2U6DQo+ICBkbWFfYWxs
b2NfYXR0cnMrMHg0NC8weGY0DQo+ICBtdGtfdmNvZGVjX21lbV9hbGxvYysweDUwLzB4YTQgW210
a192Y29kZWNfY29tbW9uDQo+IDI4MTlkM2Q2MDFmM2NkMDZjMWYyMjEzYWMxYjk5OTUxMzQ0NDE0
MjFdDQo+ICBoMjY0X2VuY19zZXRfcGFyYW0rMHgyN2MvMHgzNzggW210a192Y29kZWNfZW5jDQo+
IDc3MmNjM2QyNmMyNTRlOGNmNTQwNzk0NTFlZjhkOTMwZDJlYjQ0MDRdDQo+ICB2ZW5jX2lmX3Nl
dF9wYXJhbSsweDRjLzB4N2MgW210a192Y29kZWNfZW5jDQo+IDc3MmNjM2QyNmMyNTRlOGNmNTQw
Nzk0NTFlZjhkOTMwZDJlYjQ0MDRdDQo+ICB2YjJvcHNfdmVuY19zdGFydF9zdHJlYW1pbmcrMHgx
YmMvMHgzMjggW210a192Y29kZWNfZW5jDQo+IDc3MmNjM2QyNmMyNTRlOGNmNTQwNzk0NTFlZjhk
OTMwZDJlYjQ0MDRdDQo+ICB2YjJfc3RhcnRfc3RyZWFtaW5nKzB4NjQvMHgxMmMNCj4gIHZiMl9j
b3JlX3N0cmVhbW9uKzB4MTE0LzB4MTU4DQo+ICB2YjJfc3RyZWFtb24rMHgzOC8weDYwDQo+ICB2
NGwyX20ybV9zdHJlYW1vbisweDQ4LzB4ODgNCj4gIHY0bDJfbTJtX2lvY3RsX3N0cmVhbW9uKzB4
MjAvMHgyYw0KPiAgdjRsX3N0cmVhbW9uKzB4MmMvMHgzOA0KPiAgX192aWRlb19kb19pb2N0bCsw
eDJjNC8weDNkYw0KPiAgdmlkZW9fdXNlcmNvcHkrMHg0MDQvMHg5MzQNCj4gIHZpZGVvX2lvY3Rs
MisweDIwLzB4MmMNCj4gIHY0bDJfaW9jdGwrMHg1NC8weDY0DQo+ICB2NGwyX2NvbXBhdF9pb2N0
bDMyKzB4OTAvMHhhMzQNCj4gIF9fYXJtNjRfY29tcGF0X3N5c19pb2N0bCsweDEyOC8weDEzYw0K
PiAgaW52b2tlX3N5c2NhbGwrMHg0Yy8weDEwOA0KPiAgZWwwX3N2Y19jb21tb24rMHg5OC8weDEw
NA0KPiAgZG9fZWwwX3N2Y19jb21wYXQrMHgyOC8weDM0DQo+ICBlbDBfc3ZjX2NvbXBhdCsweDJj
LzB4NzQNCj4gIGVsMHRfMzJfc3luY19oYW5kbGVyKzB4YTgvMHhjYw0KPiAgZWwwdF8zMl9zeW5j
KzB4MTk0LzB4MTk4DQo+IENvZGU6IGFhMDAwM2Y2IGFhMDIwM2Y0IGFhMDEwM2Y1IGY5MDANCj4g
DQo+ICdGaXhlczogMDFhYmY1ZmJiMDgxYyAoIm1lZGlhOiBtZWRpYXRlazogdmNvZGVjOiBzZXBh
cmF0ZSBzdHJ1Y3QNCj4gJ210a192Y29kZWNfY3R4JyIpJw0KPiBTaWduZWQtb2ZmLWJ5OiBZdW5m
ZWkgRG9uZyA8eXVuZmVpLmRvbmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gY2hhbmdlZCB3aXRo
IHYxOg0KPiAtIHJld3JpdGUgYWxsb2NhdGUgYW5kIGZyZWUgbWVtb3J5IGludGVyZmFjZSBmb3Ig
ZW5jb2RlciBhbmQgZGVjb2Rlci4NCj4gLS0tDQo+ICAuLi4vbWVkaWF0ZWsvdmNvZGVjL2NvbW1v
bi9tdGtfdmNvZGVjX3V0aWwuYyAgfCA1NiArKysrKysrKysrKysrLS0NCj4gLS0tLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdA0KPiBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2NvbW1v
bi9tdGtfdmNvZGVjX3V0aWwuYw0KPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsv
dmNvZGVjL2NvbW1vbi9tdGtfdmNvZGVjX3V0aWwuYw0KPiBpbmRleCA5MDg2MDIwMzFmZDAuLjlj
ZTM0YTNiNWVlNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRl
ay92Y29kZWMvY29tbW9uL210a192Y29kZWNfdXRpbC5jDQo+ICsrKyBiL2RyaXZlcnMvbWVkaWEv
cGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2NvbW1vbi9tdGtfdmNvZGVjX3V0aWwuYw0KPiBAQCAt
NDcsMjAgKzQ3LDMyIEBAIEVYUE9SVF9TWU1CT0wobXRrX3Zjb2RlY193cml0ZV92ZGVjc3lzKTsN
Cj4gIA0KPiAgaW50IG10a192Y29kZWNfbWVtX2FsbG9jKHZvaWQgKnByaXYsIHN0cnVjdCBtdGtf
dmNvZGVjX21lbSAqbWVtKQ0KPiAgew0KPiArCWVudW0gbXRrX2luc3RhbmNlX3R5cGUgaW5zdF90
eXBlID0gKigodW5zaWduZWQgaW50ICopcHJpdik7DQo+ICsJc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGxhdF9kZXY7DQo+ICAJdW5zaWduZWQgbG9uZyBzaXplID0gbWVtLT5zaXplOw0KPiAtCXN0
cnVjdCBtdGtfdmNvZGVjX2RlY19jdHggKmN0eCA9IHByaXY7DQo+IC0Jc3RydWN0IGRldmljZSAq
ZGV2ID0gJmN0eC0+ZGV2LT5wbGF0X2Rldi0+ZGV2Ow0KPiArCWludCBpZDsNCj4gIA0KPiAtCW1l
bS0+dmEgPSBkbWFfYWxsb2NfY29oZXJlbnQoZGV2LCBzaXplLCAmbWVtLT5kbWFfYWRkciwNCj4g
R0ZQX0tFUk5FTCk7DQo+ICsJaWYgKGluc3RfdHlwZSA9PSBNVEtfSU5TVF9FTkNPREVSKSB7DQo+
ICsJCXN0cnVjdCBtdGtfdmNvZGVjX2VuY19jdHggKmVuY19jdHggPSBwcml2Ow0KPiArDQo+ICsJ
CXBsYXRfZGV2ID0gZW5jX2N0eC0+ZGV2LT5wbGF0X2RldjsNCj4gKwkJaWQgPSBlbmNfY3R4LT5p
ZDsNCj4gKwl9IGVsc2Ugew0KPiArCQlzdHJ1Y3QgbXRrX3Zjb2RlY19kZWNfY3R4ICpkZWNfY3R4
ID0gcHJpdjsNCj4gKw0KPiArCQlwbGF0X2RldiA9IGRlY19jdHgtPmRldi0+cGxhdF9kZXY7DQo+
ICsJCWlkID0gZGVjX2N0eC0+aWQ7DQo+ICsJfQ0KPiArDQo+ICsJbWVtLT52YSA9IGRtYV9hbGxv
Y19jb2hlcmVudCgmcGxhdF9kZXYtPmRldiwgc2l6ZSwgJm1lbS0NCj4gPmRtYV9hZGRyLCBHRlBf
S0VSTkVMKTsNCj4gIAlpZiAoIW1lbS0+dmEpIHsNCj4gLQkJbXRrX3Y0bDJfdmRlY19lcnIoY3R4
LCAiJXMgZG1hX2FsbG9jIHNpemU9JWxkIGZhaWxlZCEiLA0KPiBkZXZfbmFtZShkZXYpLCBzaXpl
KTsNCj4gKwkJbXRrX3Y0bDJfZXJyKHBsYXRfZGV2LCAiJXMgZG1hX2FsbG9jIHNpemU9JWxkIGZh
aWxlZCEiLA0KPiArCQkJICAgICBkZXZfbmFtZSgmcGxhdF9kZXYtPmRldiksIHNpemUpOw0KPiAg
CQlyZXR1cm4gLUVOT01FTTsNCj4gIAl9DQo+ICANCj4gLQltdGtfdjRsMl92ZGVjX2RiZygzLCBj
dHgsICJbJWRdICAtIHZhICAgICAgPSAlcCIsIGN0eC0+aWQsIG1lbS0NCj4gPnZhKTsNCj4gLQlt
dGtfdjRsMl92ZGVjX2RiZygzLCBjdHgsICJbJWRdICAtIGRtYSAgICAgPSAweCVseCIsIGN0eC0+
aWQsDQo+IC0JCQkgICh1bnNpZ25lZCBsb25nKW1lbS0+ZG1hX2FkZHIpOw0KPiAtCW10a192NGwy
X3ZkZWNfZGJnKDMsIGN0eCwgIlslZF0gICAgc2l6ZSA9IDB4JWx4IiwgY3R4LT5pZCwNCj4gc2l6
ZSk7DQo+ICsJbXRrX3Y0bDJfZGVidWcocGxhdF9kZXYsIDMsICJbJWRdIC0gdmEgPSAlcCBkbWEg
PSAweCVseCBzaXplID0NCj4gMHglbHgiLCBpZCwgbWVtLT52YSwNCj4gKwkJICAgICAgICh1bnNp
Z25lZCBsb25nKW1lbS0+ZG1hX2FkZHIsIHNpemUpOw0KPiAgDQo+ICAJcmV0dXJuIDA7DQo+ICB9
DQo+IEBAIC02OCwyMSArODAsMzMgQEAgRVhQT1JUX1NZTUJPTChtdGtfdmNvZGVjX21lbV9hbGxv
Yyk7DQo+ICANCj4gIHZvaWQgbXRrX3Zjb2RlY19tZW1fZnJlZSh2b2lkICpwcml2LCBzdHJ1Y3Qg
bXRrX3Zjb2RlY19tZW0gKm1lbSkNCj4gIHsNCj4gKwllbnVtIG10a19pbnN0YW5jZV90eXBlIGlu
c3RfdHlwZSA9ICooKHVuc2lnbmVkIGludCAqKXByaXYpOw0KPiArCXN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBsYXRfZGV2Ow0KPiAgCXVuc2lnbmVkIGxvbmcgc2l6ZSA9IG1lbS0+c2l6ZTsNCj4g
LQlzdHJ1Y3QgbXRrX3Zjb2RlY19kZWNfY3R4ICpjdHggPSBwcml2Ow0KPiAtCXN0cnVjdCBkZXZp
Y2UgKmRldiA9ICZjdHgtPmRldi0+cGxhdF9kZXYtPmRldjsNCj4gKwlpbnQgaWQ7DQo+ICsNCj4g
KwlpZiAoaW5zdF90eXBlID09IE1US19JTlNUX0VOQ09ERVIpIHsNCj4gKwkJc3RydWN0IG10a192
Y29kZWNfZW5jX2N0eCAqZW5jX2N0eCA9IHByaXY7DQo+ICsNCj4gKwkJcGxhdF9kZXYgPSBlbmNf
Y3R4LT5kZXYtPnBsYXRfZGV2Ow0KPiArCQlpZCA9IGVuY19jdHgtPmlkOw0KPiArCX0gZWxzZSB7
DQo+ICsJCXN0cnVjdCBtdGtfdmNvZGVjX2RlY19jdHggKmRlY19jdHggPSBwcml2Ow0KPiArDQo+
ICsJCXBsYXRfZGV2ID0gZGVjX2N0eC0+ZGV2LT5wbGF0X2RldjsNCj4gKwkJaWQgPSBkZWNfY3R4
LT5pZDsNCj4gKwl9DQo+ICANCj4gIAlpZiAoIW1lbS0+dmEpIHsNCj4gLQkJbXRrX3Y0bDJfdmRl
Y19lcnIoY3R4LCAiJXMgZG1hX2ZyZWUgc2l6ZT0lbGQgZmFpbGVkISIsDQo+IGRldl9uYW1lKGRl
diksIHNpemUpOw0KPiArCQltdGtfdjRsMl9lcnIocGxhdF9kZXYsICIlcyBkbWFfZnJlZSBzaXpl
PSVsZCBmYWlsZWQhIiwNCj4gKwkJCSAgICAgZGV2X25hbWUoJnBsYXRfZGV2LT5kZXYpLCBzaXpl
KTsNCj4gIAkJcmV0dXJuOw0KPiAgCX0NCj4gIA0KPiAtCW10a192NGwyX3ZkZWNfZGJnKDMsIGN0
eCwgIlslZF0gIC0gdmEgICAgICA9ICVwIiwgY3R4LT5pZCwgbWVtLQ0KPiA+dmEpOw0KPiAtCW10
a192NGwyX3ZkZWNfZGJnKDMsIGN0eCwgIlslZF0gIC0gZG1hICAgICA9IDB4JWx4IiwgY3R4LT5p
ZCwNCj4gLQkJCSAgKHVuc2lnbmVkIGxvbmcpbWVtLT5kbWFfYWRkcik7DQo+IC0JbXRrX3Y0bDJf
dmRlY19kYmcoMywgY3R4LCAiWyVkXSAgICBzaXplID0gMHglbHgiLCBjdHgtPmlkLA0KPiBzaXpl
KTsNCj4gKwltdGtfdjRsMl9kZWJ1ZyhwbGF0X2RldiwgMywgIlslZF0gLSB2YSA9ICVwIGRtYSA9
IDB4JWx4IHNpemUgPQ0KPiAweCVseCIsIGlkLCBtZW0tPnZhLA0KPiArCQkgICAgICAgKHVuc2ln
bmVkIGxvbmcpbWVtLT5kbWFfYWRkciwgc2l6ZSk7DQo+ICANCj4gLQlkbWFfZnJlZV9jb2hlcmVu
dChkZXYsIHNpemUsIG1lbS0+dmEsIG1lbS0+ZG1hX2FkZHIpOw0KPiArCWRtYV9mcmVlX2NvaGVy
ZW50KCZwbGF0X2Rldi0+ZGV2LCBzaXplLCBtZW0tPnZhLCBtZW0tDQo+ID5kbWFfYWRkcik7DQo+
ICAJbWVtLT52YSA9IE5VTEw7DQo+ICAJbWVtLT5kbWFfYWRkciA9IDA7DQo+ICAJbWVtLT5zaXpl
ID0gMDsNCg==
