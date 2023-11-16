Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F3C7EE3E8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345401AbjKPPHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345330AbjKPPHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:07:16 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A026BD5;
        Thu, 16 Nov 2023 07:07:10 -0800 (PST)
X-UUID: ccc0a076849111eea33bb35ae8d461a2-20231116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=lF+St0zm1e43dw+lOUGbYY3xZ/oq2CKAMTbA+O1L2wk=;
        b=iMB6Ygldg83ufLzFqT5fNgVLMRyttT/we2dBHIU9sYgjuoK9uLYn/xyxQNstfval5r864Rvqdyy4L8zRKiZLTObIf2WbZgrlFtW/lk5NrS7b5BnYFjDV7DSn0IxV8rkcuOyg3wOGgdO1RMhst1gudoeAnHaDwXqU71oC/TxY3/A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:c2bc124c-e0f6-49a7-9c89-9273ee00d4c6,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:364b77b,CLOUDID:4e3c7995-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: ccc0a076849111eea33bb35ae8d461a2-20231116
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <bo.ye@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 321049516; Thu, 16 Nov 2023 23:07:03 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 16 Nov 2023 23:07:02 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 16 Nov 2023 23:07:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eh6lIG8eKhFz3mEZaRVc+QkNYMw47MwbRJP6stU4sdOX/kSDYB8mWgv2itJSrGIcNYkgmygiLC9U3WPwHEA8f4W5JdRnm3eJtEamiODV5EmaFYXDyPs3A1MFjzu2PNB6GR9DV9AfLKoLb47Rp2gKXcf38gsjuNLcF7Dy43/OXRzc3AQd+V8SCEg0qu10cH49gHM8mV8hA4ELKCk8WQjNneXZAZdMErg+wUJC+zLvT0tcvudcfHxoWS+h8X5yxTwqUK/1Q93h6KAlcRahFRicbt/dy71VG8TEafkVtz3Piep2C4TUnr2qqpxflaWyQUwhvKyoIQXHkP+WQtgKHkbxkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lF+St0zm1e43dw+lOUGbYY3xZ/oq2CKAMTbA+O1L2wk=;
 b=JYtmJU0anDPZ8/uvK646gAw2P07yZO72ljUt7g6a0X4ayb2h3BgkL5N4BjBWIyjUjVVpSabh5cwC1qIUBWJhZZopZM347by9jcKqK8JiT0TV6vnz4MitKGUDfOZsZOpa12mwZ4M4HSOOMN/W6QvVPkNzlmsdZGC9kXeA438NOU3DDy7cEa5g/70rcsLvwiVdysBbiC+iBcSxEuFUw09fqmxWxjT9XoM2HiSXUTg7bX0rs0JceKYy0Wp0errA9eNiOPMat905r+QPJn3WOKyEhYmFdZ8G7KA4uR1KPPIT1oY3IQXPTS4CKB1/3uE2W9j7clyMrpY90Jq0jYeLANWMVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lF+St0zm1e43dw+lOUGbYY3xZ/oq2CKAMTbA+O1L2wk=;
 b=goeBQ2NsDPQG61xJZZmpHvogJvWjVLORPfAScuq2HYbtDE9Q5CniiQvg80Uz6isFuFcJglL+jUAIh7sx/1rClgw4miyFn4cd2yr9EtfbTe6KpMsK7+RlQbhJA3dZ9f+zrTBisNgqMYbh9kiu5YU+TZ/w2GdfWdXZ6G/5NN5Mruo=
Received: from TYZPR03MB5199.apcprd03.prod.outlook.com (2603:1096:400:32::11)
 by JH0PR03MB8021.apcprd03.prod.outlook.com (2603:1096:990:31::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Thu, 16 Nov
 2023 15:06:58 +0000
Received: from TYZPR03MB5199.apcprd03.prod.outlook.com
 ([fe80::3439:9de9:ec9d:4e68]) by TYZPR03MB5199.apcprd03.prod.outlook.com
 ([fe80::3439:9de9:ec9d:4e68%4]) with mapi id 15.20.6977.029; Thu, 16 Nov 2023
 15:06:58 +0000
From:   =?utf-8?B?Qm8gWWUgKOWPtuazoik=?= <Bo.Ye@mediatek.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        =?utf-8?B?QnJvd3NlIFpoYW5nICjlvKDno4op?= 
        <Browse.Zhang@mediatek.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        =?utf-8?B?WW9uZ2RvbmcgWmhhbmcgKOW8oOawuOS4nCk=?= 
        <Yongdong.Zhang@mediatek.com>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?WXVnYW5nIFdhbmcgKOeOi+eOieWImik=?= 
        <Yugang.Wang@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] thermal: Fix race condition in suspend/resume
Thread-Topic: [PATCH] thermal: Fix race condition in suspend/resume
Thread-Index: AQHaDNPevanWicGux0eGx3l2bTLI9rB9I2wA
Date:   Thu, 16 Nov 2023 15:06:58 +0000
Message-ID: <2f6530d551665e87cdf0331ecb223bdf4feb2435.camel@mediatek.com>
References: <20230916113327.85693-1-bo.ye@mediatek.com>
         <542a64a842d715329b35654db908681e074b0db5.camel@mediatek.com>
         <148c8e2d10bbb932177f732dfc44230681dc4d91.camel@mediatek.com>
         <CAJZ5v0hSeCcpOr4qOpji8sbN89GnsYYc1pYBhV+LmS=TiJQMnA@mail.gmail.com>
         <c8d305f8b46287d86a49a887983ff2198cfbc297.camel@mediatek.com>
In-Reply-To: <c8d305f8b46287d86a49a887983ff2198cfbc297.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5199:EE_|JH0PR03MB8021:EE_
x-ms-office365-filtering-correlation-id: d6bb4d51-3e42-4846-83da-08dbe6b5addc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BebsqBE2wgqxpaGSw4ebVjPJAPFeoMm/zRu5kvJE511yyWpDg+WpQHv9lYc7fAQ0Zhohs64XAYTGfMf51fmYITkf3E90XCBUIOrVOLjIF30Xys2RUVln2TLRYsH1YHxnPOo8inVHtCbmZ0/+3PlWGFOJj/x7NbHVTnYO5DaKLCy4yoO6r+fPTZTGh7aKGwy32bo5yQre63IfIGoio0xPG+Govhr2rnPrYRRz2ybouZSGk2p7nQ3sACVbCVY2Gek6tMGv8JAbP2KuZ2Jeo6pT/6EkdPxk661f2ei60Q4wAI9+gUVIdNyNXpRhT52RqMT7aUbBgm3zTwVxTYyg6sVgM9gO07uQnZyisFAG/kUfaHUlsWyU80uuvn2HbvtE7OrF+v9SCGefm6qwAKsfNOkMKm2u/82JJ3AdWxi9IQYD0sS5IX6rV8OgS8o6ErD9v9uhtI3U4hOBDv8Z9bDI/H/WaLW6b0LDjsPBOeKPJcbr/Afv7uR4WMyvgsCeUITFQVRDz6RgPxWjKp6wq+IU9UBbJbX06Ce5Otf7Aj5pAlFA8c0s6mfZMoo8LDCWLRQQUTeof+Rw27tp3UZ51KJbIWm3YGA7ceYqDacC0mj359wSvBzNiuRXGC90+yONCyh0dBWrRZ5nrNo9w+GQCy8OIrIx/Qd055AqU4t7exvwuL5ayPB9m5YwuLFLbK8B1jDSazAgcvHwrTYb2cdkZu0qMcO6/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5199.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(230922051799003)(230273577357003)(230173577357003)(1800799009)(186009)(451199024)(64100799003)(53546011)(41300700001)(2616005)(6512007)(83380400001)(4326008)(8936002)(8676002)(71200400001)(4001150100001)(26005)(2906002)(478600001)(6486002)(122000001)(38100700002)(7416002)(5660300002)(6506007)(15650500001)(316002)(54906003)(66446008)(36756003)(76116006)(66556008)(91956017)(6916009)(66946007)(85182001)(64756008)(66476007)(38070700009)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0FsdHlTK2hWc2xxdlZpV00yQXQ4aUFXOEl3OFlBQUJBVC9OM3cvbjlDcmND?=
 =?utf-8?B?bkRvckpGVERMcnJyRU1OdVBIbW1RRkpWWlZ1Ulk3RWxybGdDaVliZHBnL0JN?=
 =?utf-8?B?MDZiQU00UjlmNFo0amNmNkczalJPUWZON3dQbFNxSks3ZTNoc3I3VnNVRCtM?=
 =?utf-8?B?OHNpWUpJUlpmVC9uamowRVRjWXlaZDB2RlFYZHdQOVJkb3ZPUGZ6NXk5ZHFk?=
 =?utf-8?B?NzR4QVpuVmt0ck03MzNHYnoyY01KQUF0VlJ4TE92MXNIS0pFV2toTlJlYUI3?=
 =?utf-8?B?NW1Ta0lSWkUrYXBxT05FV0RhdHZOSGR6aEtRcCtjYkZkWjBNcmIyNUYvR3Vp?=
 =?utf-8?B?Y0thY0NvSG9FOHFZT0N3MHRiSFJVMmNiREN4STVoT2lOaHBmM0NqSnNMeTgz?=
 =?utf-8?B?ekJsQTVFcnZWOHBEc0dqNmVwZFFhZCthWmtvZURSVGJYSys3Zm5oQ1ZWaTZv?=
 =?utf-8?B?UkpzOCtmc1RnSWhJUTBDY3E1akVja1FGN3RCbVc2TzJOWUFLMk5iMkZueTV5?=
 =?utf-8?B?azFSV2VZREFNTEhyR2RlM3o4dmRQTFRDclBQNkIrWngxYW9Sa1hGRmdaZlVa?=
 =?utf-8?B?UHQvNlZ5SldCdC8weWF3Y2ZsazZ1SGc2WHBYMEhPOHhrQXdnREY5SUgzNnJZ?=
 =?utf-8?B?M1B4NktJcjQ1TjlmaFpBdjQzUmZLMGJlN1hjTjhVOUJlNEN4R25yMThUUG0z?=
 =?utf-8?B?REFCTWZ3Nkh0NU5Lb3BKdHFDR25la1NYcDRVbzNTM1Y1TkV3aXQ0bWFWcEtD?=
 =?utf-8?B?WGlIQmZsYmt2VHQwdEhjN0NoODJiaFhKUTRpYTZpc29zMG96bmV0UkRLaVJ1?=
 =?utf-8?B?MTZSMVRYR2t6a01LUXBvU3lIU0kybStrZjQydzlrb3dsbXVReVozU3NJMEZ3?=
 =?utf-8?B?NlFtckc2V0Rsd2d3ZktsRmJrZFhPcVpETm9vd24yaTMycDRyS05MMTZSN3lF?=
 =?utf-8?B?bm1ZZ0NSbFlMVVRUa2k4LzNZeTBOdzFyUTBRZ2t4bnpqcDFCVWdFN1JQMzZN?=
 =?utf-8?B?M3g5S20weml6dy9LWTN1Z3hwRHp6SmdTRWYwbmp2bDB3bEk1SHd1d3dZNGFy?=
 =?utf-8?B?c256djV4VnNWSmExZVN3bnljdnRWa2Q0bTFpWVhxRjFldXdhMEZxTUJ2T3BD?=
 =?utf-8?B?N2lzZjVDT1UwY1BwL3Q2K1A5ZTdVcnNZS0NNaGIvVnRPVWZBckNxNk5wNWI3?=
 =?utf-8?B?WXFNTXM2YjRia2lKbFNMRjd3R1FUcHF2T2dRVStOM3pYZnJ2VlRCNGg0QjRJ?=
 =?utf-8?B?cXFLY3VPTVgyMm5lV1ZiRWxwTU5nSEdFTklXblJ1bXVtVmdWTWZ6WWlJUzZ5?=
 =?utf-8?B?R083VTZhcS9YbFlwcFI4SStGS2xBRko5cFNPbUVaSWdKUkFhWWZ1bjNMZS9P?=
 =?utf-8?B?OXlmTERETnZneGNacXdmMVhyTGlzd0pISzdIZC9OaktIbkVqWk5YWDhaaXBz?=
 =?utf-8?B?Y2h5VjN1RDVrRHc3MFlmL3VjM1ZPaTJ3dEhyK3Q0cHdvbzlBVkxWeW5LUDNx?=
 =?utf-8?B?N2pHN2VPVDhXQ3djdDZaZjlxVTdKdUJ3OHNQRFREK0xLNEVjZ0lveFE4eDJS?=
 =?utf-8?B?ZnhaWVR1SDNwRmNxU00rMDRYYklPL2hnY0FiNkJKcVZ6aWROV0ROYWhic2Rj?=
 =?utf-8?B?Ylo3L3FndHE2UjdUclpqKzRtNlZVNEpJNHl3SWtSencyOFEwRHV3Y2JSVVlm?=
 =?utf-8?B?NkRTM0xBTFhBVG1tYm1mOEFpT1JjL2RPM2loOEdvRmdERDZOTFRGZ0Fma1A4?=
 =?utf-8?B?aGNFYVVQWDc5MEwxYzUxbnFERm1HSWxObG9mWEtKeGlmODltK1k1eUI4NTAr?=
 =?utf-8?B?aUpSYUpNNW51QitjejBGVzRjYnlSSzgyNmJxYlIxUFZxWkp1elVLYnZDTTdi?=
 =?utf-8?B?TCtTS0dWZ0t6QmZvd1hKMXlvMTBzMXBFOTdtQzRxOUFjR0UxSUc5Y2FiLzNi?=
 =?utf-8?B?Tkh0aHQ1KzdrYUNGaG5UNEJSU3FTZzBtS3lKTkVMRWRrbVFETS85TE1KdzNh?=
 =?utf-8?B?c1BPdlF5Y1JLV3BPVkNhdTJLbXlVampnOVROdDNpYkc1OWF5eXYwNWxwUFhC?=
 =?utf-8?B?YWpoNFk5NVpkV3pCOWxUL3NSNjlULzNMMklJMTJZWWJyeCsyWFZnZDhnOWJ5?=
 =?utf-8?Q?ZqgBfOogii/lWNGPHld/tWQkJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <599D9B00C8C55541B49635FDE8A9BCE6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5199.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bb4d51-3e42-4846-83da-08dbe6b5addc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 15:06:58.3040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: otLBz+GmaX5IaJ+GGylON2p1TiIUdGqqgIN44nCJhWeCCKnvchoaFqCDnKOvOiZhFHgX7u4C5MMTVtN3VRA4Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8021
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--22.729800-8.000000
X-TMASE-MatchedRID: qsaWi0FWcYtoR8pJe2OQczQYTpun39rMEtdrY/Wb3fMNcckEPxfz2D6h
        VXnKDh9XyksWSdvP+9GsXAiB6VK48AbbLE2rYg/9wvqOGBrge3shmbYg1ZcOnlXWVD8efRM6jim
        x9MF/qqvhLPfiHpqaBksSOv5vuirz7K35r0y1/56k3yyn4uPtLe8lj2kHOCDUCVuEXtlNqcvnan
        y7O4hLNf2NEom6a0VCL9ThiNRo8XGDzdmvk4Gt0i/T1r68E/jW0ZujfvihvDAvM0Gdq0fzqTO+s
        IxDA42K1efx9s5LIqIMyVGKfdy+2SYfjgcHThpty7TSWcbz49ZHa/4lGLR8PBd2FPQEB0XOI+eY
        m11U0ibJeAbZu9PDgWw2LRyO7O9Sl6sbR4NBGnsG7bNEJKsuNiseSAhqf1rRitUKTl2bFupOvhl
        FlRq4L/IGNvarzMgfKmnKUkn6ieNZT98H9cWYnAPZZctd3P4BeFyzQYzPQ+TKY//WmIj/oWCzOe
        Iofg8fv79/yDp7Sf25XXl2CvsM9GgAguu6mUCqB7TqRAYVohYhotH7bEpEMgqiCYa6w8tvhbVMk
        p0EYS3wjOXCtjzdWQaESrOUmXKOus7M7cbjIyisMW2Z7ncq+30tCKdnhB58pTwPRvSoXL2y5/tF
        Zu9S3DDmMp5UGBhvC24oEZ6SpSk+Mqg+CyrtwA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--22.729800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: B7F78918ACC6B00978465DE458991BAF0EC9D995E65EE14F9300BEE03E21DF052000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmFmYWVsIHNpciwNCg0KQ291bGQgeW91IGhlbHAgcmV2aWV3IHRoaXMgcGF0Y2gsIHRoYW5r
cyBhIGxvdC4NCg0KQmVzdCBSZWdhcmRzDQpCbyBZZQ0KDQpPbiBXZWQsIDIwMjMtMTEtMDEgYXQg
MjI6NTggKzA4MDAsIEJvIFllIHdyb3RlOg0KPiBPbiBXZWQsIDIwMjMtMTAtMjUgYXQgMjA6MjEg
KzAyMDAsIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOg0KPiA+ICAJIA0KPiA+IEV4dGVybmFsIGVt
YWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzDQo+ID4g
dW50aWwNCj4gPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0K
PiA+ICBPbiBNb24sIE9jdCAyMywgMjAyMyBhdCAzOjIw4oCvQU0gQm8gWWUgKOWPtuazoikgPEJv
LlllQG1lZGlhdGVrLmNvbT4NCj4gPiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gWWVzLCBpdCBpcyBv
YnNlcnZlZCBpc3N1ZS4NCj4gPiANCj4gPiBJdCBkb2VzIGhhcHBlbiwgc28gaXQncyBub3QganVz
dCAicG90ZW50aWFsIiBhbmQgdGhlIHN1YmplY3Qgb2YgdGhlDQo+ID4gcGF0Y2ggaXMgc2xpZ2h0
bHkgbWlzbGVhZGluZy4gIFBsZWFzZSBhZGp1c3QgaXQuDQo+IA0KPiBEb25lDQo+IA0KPiA+IA0K
PiA+ID4gRmlyc3RseSwgaXQgbmVlZHMgdG8gYmUgY2xhcmlmaWVkIHRoYXQgdGhpcyBpc3N1ZSBv
Y2N1cnMgaW4gYQ0KPiA+ID4gcmVhbC0NCj4gPiA+IHdvcmxkIGVudmlyb25tZW50LiBCeSBhbmFs
eXppbmcgdGhlIGxvZ3MsIHdlIGluZmVycmVkIHRoYXQgdGhlDQo+ID4gDQo+ID4gaXNzdWUNCj4g
PiA+IG9jY3VycmVkIGp1c3QgYXMgdGhlIHN5c3RlbSB3YXMgZW50ZXJpbmcgc3VzcGVuZCBtb2Rl
LCBhbmQgdGhlDQo+ID4gPiB1c2VyDQo+ID4gDQo+ID4gd2FzDQo+ID4gPiBzd2l0Y2hpbmcgdGhl
IHRoZXJtYWwgcG9saWN5ICh0aGlzIGFjdGlvbiBjYXVzZXMgYWxsIHRoZXJtYWwNCj4gPiA+IHpv
bmVzDQo+ID4gDQo+ID4gdG8NCj4gPiA+IHVucmVnaXN0ZXIvcmVnaXN0ZXIpLiBJbiBhZGRpdGlv
biwgd2UgY29uZHVjdGVkIGRlZ3JhZGF0aW9uIHRlc3RzDQo+ID4gDQo+ID4gYW5kDQo+ID4gPiBh
bHNvIHJlcHJvZHVjZWQgdGhpcyBpc3N1ZS4gVGhlIHNwZWNpZmljIG1ldGhvZCBpcyB0byBmaXJz
dA0KPiA+ID4gc3dpdGNoDQo+ID4gDQo+ID4gdGhlDQo+ID4gPiB0aGVybWFsIHBvbGljeSB0aHJv
dWdoIGEgY29tbWFuZCwgYW5kIHRoZW4gaW1tZWRpYXRlbHkgcHV0IHRoZQ0KPiA+IA0KPiA+IHN5
c3RlbQ0KPiA+ID4gaW50byBzdXNwZW5kIHN0YXRlIHRocm91Z2ggYW5vdGhlciBjb21tYW5kLiBU
aGlzIG1ldGhvZCBjYW4gYWxzbw0KPiA+ID4gcmVwcm9kdWNlIHRoZSBpc3N1ZS4NCj4gPiANCj4g
PiBPSywgc28gcGxlYXNlIGFkZCB0aGlzIGluZm9ybWF0aW9uIHRvIHRoZSBwYXRjaCBjaGFuZ2Vs
b2cuDQo+ID4gDQo+ID4gPiBPbiBUaHUsIDIwMjMtMTAtMTIgYXQgMDc6MzUgKzAwMDAsIEJvIFll
ICjlj7bms6IpIHdyb3RlOg0KPiA+ID4gPiBPbiBTYXQsIDIwMjMtMDktMTYgYXQgMTk6MzMgKzA4
MDAsIEJvIFllIHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gQ29ycmVjdCBtYWlsIHRpdGxlIGZv
cm1hdDogcmVtb3ZlICJTdWJqZWN0OiIgZnJvbSBtYWlsIHRpdGxlLg0KPiA+ID4gPiANCj4gPiA+
ID4gPiBGcm9tOiAieXVnYW5nLndhbmciIDx5dWdhbmcud2FuZ0BtZWRpYXRlay5jb20+DQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gQm9keToNCj4gPiA+ID4gPiBUaGlzIHBhdGNoIGZpeGVzIGEgcmFj
ZSBjb25kaXRpb24gZHVyaW5nIHN5c3RlbSByZXN1bWUuIEl0DQo+ID4gDQo+ID4gb2NjdXJzDQo+
ID4gPiA+ID4gaWYNCj4gPiA+ID4gPiB0aGUgc3lzdGVtIGlzIGV4aXRpbmcgYSBzdXNwZW5kIHN0
YXRlIGFuZCBhIHVzZXIgaXMgdHJ5aW5nIHRvDQo+ID4gPiA+ID4gcmVnaXN0ZXIvdW5yZWdpc3Rl
ciBhIHRoZXJtYWwgem9uZSBjb25jdXJyZW50bHkuIFRoZSByb290DQo+ID4gPiA+ID4gY2F1c2UN
Cj4gPiANCj4gPiBpcw0KPiA+ID4gPiA+IHRoYXQgYm90aCBhY3Rpb25zIGFjY2VzcyB0aGUgYHRo
ZXJtYWxfdHpfbGlzdGAuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSW4gZGV0YWlsOg0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IDEuIEF0IFBNX1BPU1RfU1VTUEVORCBkdXJpbmcgdGhlIHJlc3VtZSwg
dGhlIHN5c3RlbSByZWFkcyBhbGwNCj4gPiA+ID4gPiB0aGVybWFsDQo+ID4gPiA+ID4gICAgem9u
ZXMgaW4gYHRoZXJtYWxfdHpfbGlzdGAsIHRoZW4gcmVzZXRzIGFuZCB1cGRhdGVzIHRoZWlyDQo+
ID4gPiA+ID4gICAgdGVtcGVyYXR1cmVzLg0KPiA+ID4gPiA+IDIuIFdoZW4gcmVnaXN0ZXJpbmcv
dW5yZWdpc3RlcmluZyBhIHRoZXJtYWwgem9uZSwgdGhlDQo+ID4gPiA+ID4gICAgYHRoZXJtYWxf
dHpfbGlzdGAgZ2V0cyBtYW5pcHVsYXRlZC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGVzZSB0
d28gYWN0aW9ucyBtaWdodCBvY2N1ciBjb25jdXJyZW50bHksIGNhdXNpbmcgYSByYWNlDQo+ID4g
PiA+ID4gY29uZGl0aW9uLg0KPiA+ID4gPiA+IFRvIHNvbHZlIHRoaXMgaXNzdWUsIHdlIGludHJv
ZHVjZSBhIG11dGV4IGxvY2sgdG8gcHJvdGVjdA0KPiA+ID4gPiA+IGB0aGVybWFsX3R6X2xpc3Rg
IGZyb20gYmVpbmcgbW9kaWZpZWQgd2hpbGUgaXQncyBiZWluZyByZWFkDQo+ID4gPiA+ID4gYW5k
DQo+ID4gPiA+ID4gdXBkYXRlZCBkdXJpbmcgdGhlIHJlc3VtZSBmcm9tIHN1c3BlbmQuDQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gS2VybmVsIG9vcHMgZXhjZXJwdCByZWxhdGVkIHRvIHRoaXMgZml4
Og0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFsgNTIwMS44Njk4NDVdIFtUMzE2ODIyXSBwYzogWzB4
ZmZmZmZmZWI3ZDQ4NzZmMF0NCj4gPiA+ID4gPiBtdXRleF9sb2NrKzB4MzQvMHgxNzANCj4gPiA+
ID4gPiBbIDUyMDEuODY5ODU2XSBbVDMxNjgyMl0gbHI6IFsweGZmZmZmZmViN2NhOThhODRdDQo+
ID4gPiA+ID4gdGhlcm1hbF9wbV9ub3RpZnkrMHhkNC8weDI2Yw0KPiA+ID4gPiA+IFsuLi4gY3V0
IGZvciBicmV2aXR5IC4uLl0NCj4gPiA+ID4gPiBbIDUyMDEuODcxMDYxXSBbVDMxNjgyMl0gIHN1
c3BlbmRfcHJlcGFyZSsweDE1MC8weDQ3MA0KPiA+ID4gPiA+IFsgNTIwMS44NzEwNjddIFtUMzE2
ODIyXSAgZW50ZXJfc3RhdGUrMHg4NC8weDZmNA0KPiA+ID4gPiA+IFsgNTIwMS44NzEwNzZdIFtU
MzE2ODIyXSAgc3RhdGVfc3RvcmUrMHgxNWMvMHgxZTgNCj4gPiANCj4gPiBXZWxsLCB0aGUgY29u
bmVjdGlvbiBiZXR3ZWVuIHRoZSBhYm92ZSBsb2cgc25pcHBldCBhbmQgdGhlIGlzc3VlDQo+ID4g
YWRkcmVzc2VkIGJ5IHRoZSBwYXRjaCBpcyByYXRoZXIgaGFyZCB0byBlc3RhYmxpc2guICBQbGVh
c2UgaW5jbHVkZQ0KPiA+IG1vcmUgb2YgdGhlIG9vcHMgaW5mb3JtYXRpb24uDQo+IA0KPiBUaGFu
ayB5b3UgdmVyeSBtdWNoIGZvciByZXZpZXdpbmcgdGhlIGFkZGl0aW9uYWwgZXhwbGFuYXRpb25z
Lg0KPiANCj4gMS5FbmFibGUgdGhlcm1hbCBwb2xpY3kgb3BlcmF0aW9uIHdpbGwgdW5yZWdpc3Rl
ci9yZWdpc3RlciBhbGwNCj4gdGhlcm1hbA0KPiB6b25lcw0KPiAxMC0yMSAwNjoxMzo1OS4yODAg
ICA4NTQgICA5MjIgSSBsaWJNdGNMb2FkZXI6IGVuYWJsZSB0aGVybWFsIHBvbGljeQ0KPiB0aGVy
bWFsX3BvbGljeV8wOS4NCj4gDQo+IDIuU3lzdGVtIHN1c3BlbmQgZW50cnkgdGltZSBpcyAyMDIz
LTEwLTIwIDIyOjEzOjU5LjI0Mg0KPiBbIDQxMDYuMzY0MTc1XVtUNjA5Mzg3XSBiaW5kZXI6NTM0
XzI6IFtuYW1lOnNwbSZdW1NQTV0gUE06IHN1c3BlbmQNCj4gZW50cnkgMjAyMy0xMC0yMCAyMjox
Mzo1OS4yNDI4OTgyNDMgVVRDDQo+IFsgNDEwNi4zNjYxODVdW1Q2MDkzODddIGJpbmRlcjo1MzRf
MjogUE06IFtuYW1lOndha2V1cCZdUE06IFBlbmRpbmcNCj4gV2FrZXVwIFNvdXJjZXM6IE5FVExJ
TksNCj4gDQo+IDMuIEl0IGNhbiBiZSBwcm92ZW4gdGhhdCB0aGUgYWJzZW5jZSBvZiBhIHN3aXRj
aCBzdHJhdGVneSB3aWxsDQo+IHBlcmZvcm0NCj4gdW5yZWdpc3Rlci9yZWdpc3RlciBvcGVyYXRp
b25zIG9uIHRoZXJtYWwgem9uZXMgKGFuZHJvaWQgdGltZSBpcw0KPiAyMDIzLQ0KPiAxMC0yMCAy
MjoxMzo1OS4yODIp77yMDQo+IEJlY2F1c2UgdGhlIGxvZ3MgZm9yIG90aGVyIHRoZXJtYWwgem9u
ZXMgc3dpdGNoaW5nIGFyZSBub3QgZW5hYmxlZCBieQ0KPiBkZWZhdWx0LCB3ZSBjYW5ub3Qgc2Vl
IHRoZSBsb2dzIHJlbGF0ZWQgdG8gb3RoZXIgdGhlcm1hbCB6b25lcy4NCj4gWyA0MTA2LjQwNDE2
N11bVDYwMDkyMl0gbXRrUG93ZXJNc2dIZGw6DQo+IFtuYW1lOnRoZXJtYWxfbW9uaXRvciZdW1Ro
ZXJtYWwvVFovQ1BVXXRzY3B1X3VuYmluZCB1bmJpbmRpbmcgT0sNCj4gWyA0MTA2LjQwNDIxNV1b
VDYwMDkyMl0gbXRrUG93ZXJNc2dIZGw6DQo+IFtuYW1lOnRoZXJtYWxfbW9uaXRvciZdW1RoZXJt
YWwvVFovQ1BVXXRzY3B1X3VuYmluZCB1bmJpbmRpbmcgT0sNCj4gWyA0MTA2LjQwNDIyNV1bVDYw
MDkyMl0gbXRrUG93ZXJNc2dIZGw6DQo+IFtuYW1lOnRoZXJtYWxfbW9uaXRvciZdW1RoZXJtYWwv
VFovQ1BVXXRzY3B1X3VuYmluZCB1bmJpbmRpbmcgT0sNCj4gWyA0MTA2LjQwNDUwNF1bVDYwMDky
Ml0gbXRrUG93ZXJNc2dIZGw6DQo+IFtuYW1lOnRoZXJtYWxfbW9uaXRvciZdW1RoZXJtYWwvVFov
Q1BVXXRzY3B1X2JpbmQgYmluZGluZyBPSywgMA0KPiBbIDQxMDYuNDA0NTQ1XVtUNjAwOTIyXSBt
dGtQb3dlck1zZ0hkbDoNCj4gW25hbWU6dGhlcm1hbF9tb25pdG9yJl1bVGhlcm1hbC9UWi9DUFVd
dHNjcHVfYmluZCBiaW5kaW5nIE9LLCAyDQo+IFsgNDEwNi40MDQ1NjZdW1Q2MDA5MjJdIG10a1Bv
d2VyTXNnSGRsOg0KPiBbbmFtZTp0aGVybWFsX21vbml0b3ImXVtUaGVybWFsL1RaL0NQVV10c2Nw
dV9iaW5kIGJpbmRpbmcgT0ssIDENCj4gDQo+IDQuIHRoZXJtYWxfcG1fbm90aWZ5IHRyaWdnZXIg
S0UoYW5kcm9pZCB0aW1lOiAgMjAyMy0xMC0yMCAyMjoxMzo1OS4NCj4gMzE1ODk0KQ0KPiBbIDQx
MDYuNDM3MTcxXVtUMjA5Mzg3XSBiaW5kZXI6NTM0XzI6IFtuYW1lOm1yZHVtcCZdS2VybmVsIE9m
ZnNldDoNCj4gMHgyODljYzgwMDAwIGZyb20gMHhmZmZmZmZjMDA4MDAwMDAwDQo+IFsgNDEwNi40
MzcxODJdW1QyMDkzODddIGJpbmRlcjo1MzRfMjogW25hbWU6bXJkdW1wJl1QSFlTX09GRlNFVDoN
Cj4gMHg0MDAwMDAwMA0KPiBbIDQxMDYuNDM3MTkxXVtUMjA5Mzg3XSBiaW5kZXI6NTM0XzI6IFtu
YW1lOm1yZHVtcCZdcHN0YXRlOiA4MDQwMDAwNQ0KPiAoTnpjdiBkYWlmICtQQU4gLVVBTykNCj4g
WyA0MTA2LjQzNzIwNF1bVDIwOTM4N10gYmluZGVyOjUzNF8yOiBbbmFtZTptcmR1bXAmXXBjIDoN
Cj4gWzB4ZmZmZmZmZThhNjY4ODIwMF0gbXV0ZXhfbG9jaysweDM0LzB4MTg0DQo+IFsgNDEwNi40
MzcyMTRdW1QyMDkzODddIGJpbmRlcjo1MzRfMjogW25hbWU6bXJkdW1wJl1sciA6DQo+IFsweGZm
ZmZmZmU4YTVjZTY2YmNdIHRoZXJtYWxfcG1fbm90aWZ5KzB4ZDQvMHgyNmMNCj4gWyA0MTA2LjQz
NzIyMF1bVDIwOTM4N10gYmluZGVyOjUzNF8yOiBbbmFtZTptcmR1bXAmXXNwIDoNCj4gZmZmZmZm
YzAxYmFiM2FlMA0KPiBbIDQxMDYuNDM3MjI2XVtUMjA5Mzg3XSBiaW5kZXI6NTM0XzI6IFtuYW1l
Om1yZHVtcCZdeDI5Og0KPiBmZmZmZmZjMDFiYWIzYWYwIHgyODogMDAwMDAwMDAwMDAwMDAwMQ0K
PiANCj4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBDaGFuZ2UtSWQ6IElmZGJkZWNiYTE3MDkz
ZjkxZWFiN2UzNmNlMDRiNDZkMzExY2E2NTY4DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogeXVn
YW5nLndhbmcgPHl1Z2FuZy53YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBCbyBZZSA8Ym8ueWVAbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+
ICBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMgfCAyICsrDQo+ID4gPiA+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jDQo+ID4gPiA+ID4gYi9kcml2ZXJz
L3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMNCj4gPiA+ID4gPiBpbmRleCA4NzE3YTMzNDM1MTIuLmE3
YTE4ZWQ1N2I2ZCAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwvdGhlcm1h
bF9jb3JlLmMNCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMN
Cj4gPiA+ID4gPiBAQCAtMTUyOSwxMiArMTUyOSwxNCBAQCBzdGF0aWMgaW50IHRoZXJtYWxfcG1f
bm90aWZ5KHN0cnVjdA0KPiA+ID4gPiA+IG5vdGlmaWVyX2Jsb2NrICpuYiwNCj4gPiA+ID4gPiAg
ICAgY2FzZSBQTV9QT1NUX0hJQkVSTkFUSU9OOg0KPiA+ID4gPiA+ICAgICBjYXNlIFBNX1BPU1Rf
UkVTVE9SRToNCj4gPiA+ID4gPiAgICAgY2FzZSBQTV9QT1NUX1NVU1BFTkQ6DQo+ID4gPiA+ID4g
KyAgICAgICAgICAgbXV0ZXhfbG9jaygmdGhlcm1hbF9saXN0X2xvY2spOw0KPiA+ID4gPiA+ICAg
ICAgICAgICAgIGF0b21pY19zZXQoJmluX3N1c3BlbmQsIDApOw0KPiA+IA0KPiA+IEl0IGlzIG5v
dCBjbGVhciB0byBtZSB3aHkgdGhlIGFib3ZlIHN0YXRlbWVudCBuZWVkcyB0byBiZSB1bmRlciB0
aGUNCj4gPiBsb2NrLg0KPiA+IA0KPiA+ID4gPiA+ICAgICAgICAgICAgIGxpc3RfZm9yX2VhY2hf
ZW50cnkodHosICZ0aGVybWFsX3R6X2xpc3QsIG5vZGUpIHsNCj4gPiA+ID4gPiAgICAgICAgICAg
ICAgICAgICAgIHRoZXJtYWxfem9uZV9kZXZpY2VfaW5pdCh0eik7DQo+ID4gPiA+ID4gICAgICAg
ICAgICAgICAgICAgICB0aGVybWFsX3pvbmVfZGV2aWNlX3VwZGF0ZSh0eiwNCj4gPiA+IA0KPiA+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBUSEVSTUFM
X0VWRU5UX1VOU1ANCj4gPiA+IEVDDQo+ID4gPiA+ID4gSUZJRUQpOw0KPiA+ID4gPiA+ICAgICAg
ICAgICAgIH0NCj4gPiA+ID4gPiArICAgICAgICAgICBtdXRleF91bmxvY2soJnRoZXJtYWxfbGlz
dF9sb2NrKTsNCj4gPiA+ID4gPiAgICAgICAgICAgICBicmVhazsNCj4gPiA+ID4gPiAgICAgZGVm
YXVsdDoNCj4gPiA+ID4gPiAgICAgICAgICAgICBicmVhazsNCg==
