Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABFC804AD8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 08:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344590AbjLEHAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 02:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344575AbjLEHAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 02:00:50 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD39FA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 23:00:51 -0800 (PST)
X-UUID: 011f5fd4933c11ee8051498923ad61e6-20231205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=75CS47A78QUxju6Ci44gGWms01vgA4dkpH2I+Iyunr4=;
        b=aXpVDtsUjKsYXZBOAxnSLUfw6doQ9oLkmiUsmwisfABVr7kO2qFJfcw0CnDeb47znB0eiglmTm0ZOa/vxfNCHoFZdYCOKx+dVOhKJ/zWAfsv70tKdtiVnLKfAjDHdsfg28cw/bNZNo+XVG5YeCbV03Pl3frHjFEWnMeWr2ri2ms=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:e275c39a-a537-450c-9b02-ac27ecaf7fe0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:abefa75,CLOUDID:b6e74cfd-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 011f5fd4933c11ee8051498923ad61e6-20231205
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 148193023; Tue, 05 Dec 2023 15:00:42 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 5 Dec 2023 15:00:41 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 5 Dec 2023 15:00:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzhvVv/vWdiu7ZsYy3p2d54jMgHqRSqJvKrLsoefCKzJkOWVsVH8lgNf7Y+49+0n+CTpn03OM0T5GqrV7bMYbKFY+F4o+MMEmnDBj+oJ1E8TOa43eJU3WaWxToraALFew0fm+LeCEeAPsalXKbPeXwSvHjhtNyJLZcLbBwhAuC/8BqQDWkMn3FzHJgsU/kP6TvH9YBD/UbCVHC+Wawbq2LW3ko+3UIkTeDxRk1e/2MnDwdH0/jw6LgUJ3HMkZw9TOo0Dl31r0TISO09gytBAHyCA3RCEErjDKo6s9QYXImVyyAAUVxSWFxzaZCG57pbQePlByu/zkmziXUqzR6ey/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75CS47A78QUxju6Ci44gGWms01vgA4dkpH2I+Iyunr4=;
 b=IeUiyu1ySrPChngImFkyJg4NEk7J1d1uO3gdSZp1SmwLsvWVUbhcTP/hc2F7ad89iUn7/0fF2FUF8CF0kQIRk80ohiLKYa/02cTO9trJz1ZOkH8/d4IzMtgBzNr67v60m6P0LWDfT6x7v5vqwFd3zXGJJkNwRLftuoX2DVY6pQG0KGDVHjzq+GDo7SNeccU4V6FXgH6Bdy3mV3ppricGcqvDrOvDUrbvaG6nb0cespHNdGaC6rMw42YyUZ04vnEIvDPNTwqnbrVo/eA27MyEyh7kMFbjZ4pkx3O4CnnfBNKdAPW3Ek8lTWgyu179iNTjUKZ+QLclTGtqQavlQevYpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75CS47A78QUxju6Ci44gGWms01vgA4dkpH2I+Iyunr4=;
 b=oTk/1CPUXsJ0SMA/x403McgPbv3dyDrOuNnDbMe/7BirjZMVqyOEidTkDen5w+QewUrmXnJV2O6N2TyMQQOxLztJVBMSMLcFp0QZemOq2Fwmg/D19MC53W0gwDq5ddee8rsfAbkJF3a1KbuLgQOHkNqImwpyiLdJsIuEnSRGj3k=
Received: from PUZPR03MB5964.apcprd03.prod.outlook.com (2603:1096:301:b4::11)
 by KL1PR03MB8375.apcprd03.prod.outlook.com (2603:1096:820:13a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 07:00:37 +0000
Received: from PUZPR03MB5964.apcprd03.prod.outlook.com
 ([fe80::387e:9c86:14f4:446d]) by PUZPR03MB5964.apcprd03.prod.outlook.com
 ([fe80::387e:9c86:14f4:446d%3]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 07:00:37 +0000
From:   =?utf-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>
CC:     "kbingham@kernel.org" <kbingham@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
Subject: Re: [PATCH] scripts/gdb: Fix lx-device-list-bus and
 lx-device-list-class
Thread-Topic: [PATCH] scripts/gdb: Fix lx-device-list-bus and
 lx-device-list-class
Thread-Index: AQHaI0ZiNsPK+31EHkC6h63NE8hh67CaSvEA
Date:   Tue, 5 Dec 2023 07:00:37 +0000
Message-ID: <5d4b14c8b0db1dadc5b1de014c68e48530b1a97b.camel@mediatek.com>
References: <20231130043317.174188-1-florian.fainelli@broadcom.com>
In-Reply-To: <20231130043317.174188-1-florian.fainelli@broadcom.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB5964:EE_|KL1PR03MB8375:EE_
x-ms-office365-filtering-correlation-id: 0fe08a5c-4ea5-42a3-c9c7-08dbf55fe25b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GAomlELbv5C16czscn6BsPNpcXXOP/DywFhckg0/GikdttBhhSafc1+mIa++LCLc4n3jZdlvPtGZAwshvXNgabaQRiXsTGUQ56cvmORWSMIiDDYErhDhuTFujXId9sthtzsNMxLy2tu5ph87XV56yasV6PAq9HqOsUPsNchczAm446vKAPFeyM/Cf6YM8fji1OE1l3A/0ry2nLnfzHxQWskQizUWblIHujdo2+gFNPWtw6IdmExKJic2KyFNJHz6xGXnWYCGXjZwE7juATuN3/ZhUovFL+YZR6B/AUJ4fAtzpCP4bLDxw2XSjOIFYMdkPScER9BXXp2z1V95+2G/maEEEMAfNkBEBAwhOsghz3JZRBG7pDQzo2TKtVuy/47eHRPOKsxf9k+XuDo/pG09dQAx7c43lswaLmkotVq32UFoZexxng4BYf/eNk0l1y0kdntXlCFi4httHuugaujFLVqGngvSvAbE1TJX/nx6IhtR8gF0F4dnfTqLaeQKA89RNmkG3LJ5/6l40h0kVEpTCyAY4LehU7gTYo5BcAnhq3P/um9F4c5i/bKzsYxhpwvNt297DggpfeiPHgL7/bYp48pLmnOxXgFD3Rhk3hapwBpQW6YY75kSJsMRp81es1j+Tvf2IlidiuZWU84eLfSDB1Od6KwwSy3DcKvRp2t9f32EzJ8siIK6jh9nbiUlAq/6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB5964.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66446008)(64756008)(54906003)(316002)(66476007)(8936002)(86362001)(8676002)(4326008)(66556008)(6486002)(478600001)(66946007)(110136005)(91956017)(76116006)(41300700001)(36756003)(85182001)(38070700009)(2906002)(5660300002)(4001150100001)(122000001)(38100700002)(2616005)(26005)(6506007)(71200400001)(6512007)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnJ1Qi9sOERNWFdsZm5QT2RBWk52QTF5VzdubnJNNlpTTS8rQk1XckpXUDVJ?=
 =?utf-8?B?dG9HbWJtVXdkMEVKd0M2MUF2QVlKMEV1cElySGV1R2dreWdvdG80L29YN09V?=
 =?utf-8?B?cGordUFNc2krWXhKWmxjaDE0NHZGNXhNeW9iVHBUUG95VzhXL1hqYUVQSEFO?=
 =?utf-8?B?UXBTdkgyR3o3cmhlN1V6SUxtZW0ya1RpQWtIcHhQenoyUkdVeFRkMmJJSFhJ?=
 =?utf-8?B?bVZicFhUU1BiVERMMVd5VGpITGNuVGRlMmN4NEdhVWs2QktVNnA1S21pclBU?=
 =?utf-8?B?Q2V2T2M1MFVmem5OYnUxNVljY3puUnNiUzdkT0k1TXBCL0k3Qm03Z3V4R0ZJ?=
 =?utf-8?B?SytYQXZ6UUZmZ0ZWSFllMWRaUUNKbzgvMVZ6NENwZERvTDZpMFdGUHFPdVRn?=
 =?utf-8?B?ODdZRk5rTWFqWEppakE0cm9FM1Q0MzE3Z1dXaU85bWM5TkN4bHF0UEN0VXVz?=
 =?utf-8?B?S21ZT2J5YjhqZGFXSUtnUzI5bHdtZFdkV0syWkxMOVd1b0pOUFQweWdUQStL?=
 =?utf-8?B?OEVsZmRIaHVWT3E3VGVFeFowQkxtY3JOSThHRTRISDRDK3ducnR1bmlPTWdM?=
 =?utf-8?B?Nk95WTdOREUwQUkzUXZiVisvK3djZUlRYjgxamYrc1pzWG1DMERMckp1OWlV?=
 =?utf-8?B?QVByU3FFSzFuWVozcVFibXRnZG0rNFMrWERsUzUwMmRMOWJzc2hidWhTdW5k?=
 =?utf-8?B?eGowWWlGZzRBQTBUSlhlVDVPSmNqelFLM0RXeDRXTVU0WVdzTlNsdTBsSnQ0?=
 =?utf-8?B?VE15NzVkYlZHY2xYOFVxUS9KN0c5eHFScHgrMmYzNGhrUzZyVzcvL0gzMnRh?=
 =?utf-8?B?RlJEakFyV1U5UFkwRkNERUVTM0RvZHZhaHpDWG52VmpUTjBtTFZtd0l3NXJO?=
 =?utf-8?B?b0FiN25keU1JbjNRQWEzN094MEpxcEkwODRwbmZlL3NLK3ZlcFFieldaU2xh?=
 =?utf-8?B?eUFMWVJ0djBna1MxVzd5ZG5YTERVZUhoNnE4UlZIRk1DdS9DeWQ0SXZkUlpG?=
 =?utf-8?B?ZmhlVWRyTmdHdVNHVm9lTXdKT0hNckNTTHk0cC9hK0l3TmtnVFZqaGpCb3pS?=
 =?utf-8?B?d1lYbGJMcVluVVpuaks1c3FkQWVPbU5tV2FjUmRyTzNpemxzOFlMZzgwMXhI?=
 =?utf-8?B?WWRiMGttY3lKWXoxTDgvenUwNFpFVHk3Qm9LVXlHZFc1QzVZNUpTdUdOVVE5?=
 =?utf-8?B?amRkZ0ZneFN6b2tici9PZTN0d2NEYTJBWGJkaE12N0ZCZWVDeUxQb0laaTQ1?=
 =?utf-8?B?dHFFVFh2ME1lYU05Sjl2RUNRMVIvVS8vN0FtL3d5OEtSL2RyVDNaTENWRWdG?=
 =?utf-8?B?TWpLN3YxcXNBY0ZrOVBac1RYWlRMK280aUpkTWZDN1FWMXl0am42RXlJSUFr?=
 =?utf-8?B?RHJSc3hxaktnT0s1RnBzZG1ORFYxcEQyQzVvbldBdFNYaWREcXliTDMrRjNE?=
 =?utf-8?B?MmdjK0k3eWI3eU1mc1lWdHhkRFhnckFzN1Frb28zNGZlckRUQjd3R09VdGV1?=
 =?utf-8?B?WjE3SUZ3aGVtUXZLOHhlSnZ3OS9FMTBhRmcyc3BhOFNYRVNBZ3dyYXRGLzFk?=
 =?utf-8?B?V0YxWW9aMDVkMzgvTHhhcmF2M25RdjBIYVRPWTJGOEg2NjVGanFpL2IyWGgz?=
 =?utf-8?B?S0xSUVQrbDNJN3hwQUVOMzZCa2JJNTE2elU3d0h2Y0RoYkx5bEhDWGM3aWlO?=
 =?utf-8?B?bVF1Y28wKzlRREMzL2txT0NDTkxpUUNZU1d6bW50b3orRjJ5aGVaK3JTeHI3?=
 =?utf-8?B?aVo0c0xLcVIzNHZiUXc1cmJKaW8xQTQwb1ZtK0Z1OCtxUU15QWpYeFkrTUtI?=
 =?utf-8?B?OVVTWmt3SjhQdkNPY21qS21hQ2RBZExSTGYwaTRSYWpVcnBDNzMrdVAxMk4x?=
 =?utf-8?B?OTB4ODVzVzR2MW9VZW9Kb1RaOE9taHNoSG01NTZDM28yS0dVVVFKTmZTRUdo?=
 =?utf-8?B?UFhLZ21VTGgxTVNEd3BxSnExTzhYK3Z6c05sTzZVTVNvZlgwLzRoTEVnRWNK?=
 =?utf-8?B?Y2pwUGhzdW82d3oyZ3JKcjN1elFqUU9YVDIwMWQ1WWVXVTZMY2JLZUM1Nmg3?=
 =?utf-8?B?MlVBNU9aWWZDMTRSakhVK2pHb3JIVUduVG5XanpxSno5aFBEa3UrVTFBekQ3?=
 =?utf-8?B?cERKNVhldmtrUzdqb3kxZFpXTTZuR2xTOFBUcDdGdlpVUnlsNGppUWZ2MU5o?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF4727A156075D468F6ABC2F286B3ED0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB5964.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe08a5c-4ea5-42a3-c9c7-08dbf55fe25b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 07:00:37.1195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZ27hCJBMJu8+dMXj9n8TJHNLH5AP1PsTemW9i05M8Y/nKbVGdO3OoilOE6+tv7dgkUGWvhLmfUS/8x/JBsJpKf8pcys0g8Cq1aAhoFL4ZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8375
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--10.487000-8.000000
X-TMASE-MatchedRID: LVkZzMT5mErUL3YCMmnG4tWcXTld/c2GOETNYVYe2VXd3lJL9Cw8DMkU
        hKWc+gwPWASbhXBhlp58ZwVSY1LuqcUzuVE/w8fNcxGQfOZHrIfSlWtltt+KSDRCaZSKE/Oskb+
        qhi+AKmesp9XzC6B2sIznw5CAXjz0jyxvgNKrxKaEryjhqiyzyrn7V+KB+3cu31GU/N5W5BCyoM
        t3o0ROMVoRCdvztsc2VPdUVnwGewdIGJIfj527fxuZoNKc6pl+u56wFPSkMVFyTn0y32aE/6PFj
        JEFr+olFUew0Fl/1pHYh0PvnvUH8FZ0V5tYhzdWxEHRux+uk8h+ICquNi0WJDLxhRePDtSGa8LT
        rSSVjLiIOTq7Pzwi/KlsGum3FugxftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.487000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 38CC8BA8271F46D628CC9432E44DED13710ED4E4FD7D99B11D38617DBB2472E02000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTExLTI5IGF0IDIwOjMzIC0wODAwLCBGbG9yaWFuIEZhaW5lbGxpIHdyb3Rl
Og0KPiBBZnRlciB0aGUgY29udmVyc2lvbiB0byBidXNfdG9fc3Vic3lzKCkgYW5kIGNsYXNzX3Rv
X3N1YnN5cygpLCB0aGUNCj4gZ2RiDQo+IHNjcmlwdHMgbGlzdGluZyB0aGUgc3lzdGVtIGJ1c2Vz
IGFuZCBjbGFzc2VzIHJlc3BlY3RpdmVseSB3YXMgYnJva2VuLA0KPiBmaXggdGhvc2UgYnkgcmV0
dXJuaW5nIHRoZSBzdWJzeXNfcHJpdiBwb2ludGVyIGFuZCBoYXZlIHRoZSB2YXJpb3VzDQo+IGNh
bGxlciBkZS1yZWZlcmVuY2UgZWl0aGVyIHRoZSAnYnVzJyBvciAnY2xhc3MnIHN0cnVjdHVyZSBt
ZW1iZXJzDQo+IGFjY29yZGluZ2x5Lg0KPiANCj4gRml4ZXM6IDgzYjkxNDhkZjJjOSAoImRyaXZl
ciBjb3JlOiBidXM6IGJ1cyBpdGVyYXRvciBjbGVhbnVwcyIpDQo+IEZpeGVzOiA3Yjg4NGI3ZjI0
YjQgKCJkcml2ZXIgY29yZTogY2xhc3MuYzogY29udmVydCB0byBvbmx5IHVzZQ0KPiBjbGFzc190
b19zdWJzeXMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBGbG9yaWFuIEZhaW5lbGxpIDxmbG9yaWFuLmZh
aW5lbGxpQGJyb2FkY29tLmNvbT4NCg0KVGVzdGVkLWJ5OiBLdWFuLVlpbmcgTGVlIDxLdWFuLVlp
bmcuTGVlQG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtzLA0KS3Vhbi1ZaW5nIExlZQ0KDQo+IC0tLQ0K
PiAgc2NyaXB0cy9nZGIvbGludXgvZGV2aWNlLnB5IHwgMTYgKysrKysrKystLS0tLS0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9zY3JpcHRzL2dkYi9saW51eC9kZXZpY2UucHkNCj4gYi9zY3JpcHRzL2dkYi9s
aW51eC9kZXZpY2UucHkNCj4gaW5kZXggMTYzNzZjNWNmZWM2Li4wZWFiYzVmNGY4Y2EgMTAwNjQ0
DQo+IC0tLSBhL3NjcmlwdHMvZ2RiL2xpbnV4L2RldmljZS5weQ0KPiArKysgYi9zY3JpcHRzL2dk
Yi9saW51eC9kZXZpY2UucHkNCj4gQEAgLTM2LDI2ICszNiwyNiBAQCBkZWYgZm9yX2VhY2hfYnVz
KCk6DQo+ICAgICAgZm9yIGtvYmogaW4NCj4ga3NldF9mb3JfZWFjaF9vYmplY3QoZ2RiLnBhcnNl
X2FuZF9ldmFsKCdidXNfa3NldCcpKToNCj4gICAgICAgICAgc3Vic3lzID0gY29udGFpbmVyX29m
KGtvYmosIGtzZXRfdHlwZS5nZXRfdHlwZSgpLnBvaW50ZXIoKSwNCj4gJ2tvYmonKQ0KPiAgICAg
ICAgICBzdWJzeXNfcHJpdiA9IGNvbnRhaW5lcl9vZihzdWJzeXMsDQo+IHN1YnN5c19wcml2YXRl
X3R5cGUuZ2V0X3R5cGUoKS5wb2ludGVyKCksICdzdWJzeXMnKQ0KPiAtICAgICAgICB5aWVsZCBz
dWJzeXNfcHJpdlsnYnVzJ10NCj4gKyAgICAgICAgeWllbGQgc3Vic3lzX3ByaXYNCj4gIA0KPiAg
DQo+ICBkZWYgZm9yX2VhY2hfY2xhc3MoKToNCj4gICAgICBmb3Iga29iaiBpbg0KPiBrc2V0X2Zv
cl9lYWNoX29iamVjdChnZGIucGFyc2VfYW5kX2V2YWwoJ2NsYXNzX2tzZXQnKSk6DQo+ICAgICAg
ICAgIHN1YnN5cyA9IGNvbnRhaW5lcl9vZihrb2JqLCBrc2V0X3R5cGUuZ2V0X3R5cGUoKS5wb2lu
dGVyKCksDQo+ICdrb2JqJykNCj4gICAgICAgICAgc3Vic3lzX3ByaXYgPSBjb250YWluZXJfb2Yo
c3Vic3lzLA0KPiBzdWJzeXNfcHJpdmF0ZV90eXBlLmdldF90eXBlKCkucG9pbnRlcigpLCAnc3Vi
c3lzJykNCj4gLSAgICAgICAgeWllbGQgc3Vic3lzX3ByaXZbJ2NsYXNzJ10NCj4gKyAgICAgICAg
eWllbGQgc3Vic3lzX3ByaXYNCj4gIA0KPiAgDQo+ICBkZWYgZ2V0X2J1c19ieV9uYW1lKG5hbWUp
Og0KPiAgICAgIGZvciBpdGVtIGluIGZvcl9lYWNoX2J1cygpOg0KPiAtICAgICAgICBpZiBpdGVt
WyduYW1lJ10uc3RyaW5nKCkgPT0gbmFtZToNCj4gKyAgICAgICAgaWYgaXRlbVsnYnVzJ11bJ25h
bWUnXS5zdHJpbmcoKSA9PSBuYW1lOg0KPiAgICAgICAgICAgICAgcmV0dXJuIGl0ZW0NCj4gICAg
ICByYWlzZSBnZGIuR2RiRXJyb3IoIkNhbid0IGZpbmQgYnVzIHR5cGUgeyFyfSIuZm9ybWF0KG5h
bWUpKQ0KPiAgDQo+ICANCj4gIGRlZiBnZXRfY2xhc3NfYnlfbmFtZShuYW1lKToNCj4gICAgICBm
b3IgaXRlbSBpbiBmb3JfZWFjaF9jbGFzcygpOg0KPiAtICAgICAgICBpZiBpdGVtWyduYW1lJ10u
c3RyaW5nKCkgPT0gbmFtZToNCj4gKyAgICAgICAgaWYgaXRlbVsnY2xhc3MnXVsnbmFtZSddLnN0
cmluZygpID09IG5hbWU6DQo+ICAgICAgICAgICAgICByZXR1cm4gaXRlbQ0KPiAgICAgIHJhaXNl
IGdkYi5HZGJFcnJvcigiQ2FuJ3QgZmluZCBkZXZpY2UgY2xhc3MgeyFyfSIuZm9ybWF0KG5hbWUp
KQ0KPiAgDQo+IEBAIC03MCwxMyArNzAsMTMgQEAgZGVmIGtsaXN0X2Zvcl9lYWNoKGtsaXN0KToN
Cj4gIA0KPiAgDQo+ICBkZWYgYnVzX2Zvcl9lYWNoX2RldmljZShidXMpOg0KPiAtICAgIGZvciBr
biBpbiBrbGlzdF9mb3JfZWFjaChidXNbJ3AnXVsna2xpc3RfZGV2aWNlcyddKToNCj4gKyAgICBm
b3Iga24gaW4ga2xpc3RfZm9yX2VhY2goYnVzWydrbGlzdF9kZXZpY2VzJ10pOg0KPiAgICAgICAg
ICBkcCA9IGNvbnRhaW5lcl9vZihrbiwNCj4gZGV2aWNlX3ByaXZhdGVfdHlwZS5nZXRfdHlwZSgp
LnBvaW50ZXIoKSwgJ2tub2RlX2J1cycpDQo+ICAgICAgICAgIHlpZWxkIGRwWydkZXZpY2UnXQ0K
PiAgDQo+ICANCj4gIGRlZiBjbGFzc19mb3JfZWFjaF9kZXZpY2UoY2xzKToNCj4gLSAgICBmb3Ig
a24gaW4ga2xpc3RfZm9yX2VhY2goY2xzWydwJ11bJ2tsaXN0X2RldmljZXMnXSk6DQo+ICsgICAg
Zm9yIGtuIGluIGtsaXN0X2Zvcl9lYWNoKGNsc1sna2xpc3RfZGV2aWNlcyddKToNCj4gICAgICAg
ICAgZHAgPSBjb250YWluZXJfb2Yoa24sDQo+IGRldmljZV9wcml2YXRlX3R5cGUuZ2V0X3R5cGUo
KS5wb2ludGVyKCksICdrbm9kZV9jbGFzcycpDQo+ICAgICAgICAgIHlpZWxkIGRwWydkZXZpY2Un
XQ0KPiAgDQo+IEBAIC0xMDMsNyArMTAzLDcgQEAgY2xhc3MgTHhEZXZpY2VMaXN0QnVzKGdkYi5D
b21tYW5kKToNCj4gICAgICBkZWYgaW52b2tlKHNlbGYsIGFyZywgZnJvbV90dHkpOg0KPiAgICAg
ICAgICBpZiBub3QgYXJnOg0KPiAgICAgICAgICAgICAgZm9yIGJ1cyBpbiBmb3JfZWFjaF9idXMo
KToNCj4gLSAgICAgICAgICAgICAgICBnZGIud3JpdGUoJ2J1cw0KPiB7fTpcdHt9XG4nLmZvcm1h
dChidXNbJ25hbWUnXS5zdHJpbmcoKSwgYnVzKSkNCj4gKyAgICAgICAgICAgICAgICBnZGIud3Jp
dGUoJ2J1cw0KPiB7fTpcdHt9XG4nLmZvcm1hdChidXNbJ2J1cyddWyduYW1lJ10uc3RyaW5nKCks
IGJ1cykpDQo+ICAgICAgICAgICAgICAgICAgZm9yIGRldiBpbiBidXNfZm9yX2VhY2hfZGV2aWNl
KGJ1cyk6DQo+ICAgICAgICAgICAgICAgICAgICAgIF9zaG93X2RldmljZShkZXYsIGxldmVsPTEp
DQo+ICAgICAgICAgIGVsc2U6DQo+IEBAIC0xMjMsNyArMTIzLDcgQEAgY2xhc3MgTHhEZXZpY2VM
aXN0Q2xhc3MoZ2RiLkNvbW1hbmQpOg0KPiAgICAgIGRlZiBpbnZva2Uoc2VsZiwgYXJnLCBmcm9t
X3R0eSk6DQo+ICAgICAgICAgIGlmIG5vdCBhcmc6DQo+ICAgICAgICAgICAgICBmb3IgY2xzIGlu
IGZvcl9lYWNoX2NsYXNzKCk6DQo+IC0gICAgICAgICAgICAgICAgZ2RiLndyaXRlKCJjbGFzcw0K
PiB7fTpcdHt9XG4iLmZvcm1hdChjbHNbJ25hbWUnXS5zdHJpbmcoKSwgY2xzKSkNCj4gKyAgICAg
ICAgICAgICAgICBnZGIud3JpdGUoImNsYXNzDQo+IHt9Olx0e31cbiIuZm9ybWF0KGNsc1snY2xh
c3MnXVsnbmFtZSddLnN0cmluZygpLCBjbHMpKQ0KPiAgICAgICAgICAgICAgICAgIGZvciBkZXYg
aW4gY2xhc3NfZm9yX2VhY2hfZGV2aWNlKGNscyk6DQo+ICAgICAgICAgICAgICAgICAgICAgIF9z
aG93X2RldmljZShkZXYsIGxldmVsPTEpDQo+ICAgICAgICAgIGVsc2U6DQo=
