Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2CD7BFF73
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjJJOko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjJJOkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:40:42 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1CF9E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:40:35 -0700 (PDT)
X-UUID: f3b8c66a677a11ee8051498923ad61e6-20231010
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=R6yDmlXukqK5E8HYAt3QgHXCKvoaGoWP2V1/lg1Mx5U=;
        b=XTsmgH5T5u9eXqXjlOzwTj+aZ9o5D9A1a1/iI0aAA3SfxTwiWF92sV3jk5obWkoy44y1ejFFDZKdd8f3yX4K/dve8OVBH9x7z96eBu57iGiZbeBEAeP9Nz18PrM79psuz/XjJCmtJ9YlPQEhPXjpW48FwWZ/U1j3MJ3Uk1EcqjQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:09705b7f-9521-4fdb-9968-ac7a48300282,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:e26cf5c3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f3b8c66a677a11ee8051498923ad61e6-20231010
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <kuyo.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1207852921; Tue, 10 Oct 2023 22:40:26 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 10 Oct 2023 22:40:25 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 10 Oct 2023 22:40:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfpBv+0ZPpC1XYLCj+xraL4x1KHQyxS6Vr3ojf499Xj2psMI3lp5XmUpLRVkNLtCNBF3VctV8g3UyOevxH9wMT+udXoaOuCwhvy0zotEiwYN/oB+ke7ZWaOcmLlfx1x4ykLsYJhHpM6JKzAfIT7H0kIJUQ5n5hs1YeqJbrrV3mw5I8DBWeR2KQasq+vIrC/Ir6VSNIW0vuwwbVN2+5o/6T7FCvvGrWaTCyGItt6z8I4w37K59wad/u1MjOJpfvYqkxn2XQhfqorHynD518OBykA/arYd6T/ig2FbQ6qW/ZjK39pp8IWR6K4rAoduJZ54RDxXaOLn9ev4J3uf53XIdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6yDmlXukqK5E8HYAt3QgHXCKvoaGoWP2V1/lg1Mx5U=;
 b=X2GpOi9fnjRWymBl4kgUzIxS+oihU4dU+4oP0FYWu6zYd6taZtHj4F+sXXYMzebFfORxY950oHbNce5cnH6nChwRkV6huqS/EXoEc1ANLwWdf3zfsLFQlbLNETRixMFYX1XmvkbIKBkMCjV3u/ji8n3pe7ZTqF1yrwh9FfrLbod846h5RHd1/kjsNmMTsntayfi1uh74ojzQuEgEqANA6KdDxJSOjzc5CedkvdL4v1plqfAkixXPeC+VXHTpXs+7DjGu083tH2gGA/UQJpwdylXYmVuN7Y7AdN983wgkshuVqQO5PlfzKqkysjVgfODLNey3JkazSEbxLYdFXt1uuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6yDmlXukqK5E8HYAt3QgHXCKvoaGoWP2V1/lg1Mx5U=;
 b=vBfFGJYXUK+8zOhkII2A3Om/KcrWbu7AYr/XHNrahcXU/ebTu0pBgLYQly9W7+4JHGflzRENZpdC9i59Ovt0LX+3mMu9phzFoIKuUWRida4eT4x2rCxbzPLZH94ZNpGXFff4eywUsbtrB8sQGeir21YA+FCt4BZVnz7pjRTRL1g=
Received: from SI2PR03MB5580.apcprd03.prod.outlook.com (2603:1096:4:12e::5) by
 SI2PR03MB5971.apcprd03.prod.outlook.com (2603:1096:4:148::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Tue, 10 Oct 2023 14:40:23 +0000
Received: from SI2PR03MB5580.apcprd03.prod.outlook.com
 ([fe80::a8c0:4146:462f:76e6]) by SI2PR03MB5580.apcprd03.prod.outlook.com
 ([fe80::a8c0:4146:462f:76e6%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 14:40:22 +0000
From:   =?utf-8?B?S3V5byBDaGFuZyAo5by15bu65paHKQ==?= 
        <Kuyo.Chang@mediatek.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/1] sched/core: Fix stuck on completion for
 affine_move_task() when stopper disable
Thread-Topic: [PATCH 1/1] sched/core: Fix stuck on completion for
 affine_move_task() when stopper disable
Thread-Index: AQHZ8PONNdMSrYrApES66NU/CC/LkLAuUcoAgACC+ICAAsbJgIARkfGA
Date:   Tue, 10 Oct 2023 14:40:22 +0000
Message-ID: <8ad1b617a1040ce4cc56a5d04e8219b5313a9a6e.camel@mediatek.com>
References: <20230927033431.12406-1-kuyo.chang@mediatek.com>
         <20230927080850.GB21824@noisy.programming.kicks-ass.net>
         <b9def8f3d9426bc158b302f4474b6e643b46d206.camel@mediatek.com>
         <20230929102135.GD6282@noisy.programming.kicks-ass.net>
In-Reply-To: <20230929102135.GD6282@noisy.programming.kicks-ass.net>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5580:EE_|SI2PR03MB5971:EE_
x-ms-office365-filtering-correlation-id: 77873e04-9a88-46b5-06e4-08dbc99ed56c
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QoOKI0sI72+ku6RYTnK0fr6r1iKAYv8+T8sNx8mevXUnCwjhn0CO27BRyCuhnxGe7V60NmhkBM0unJBJ6W69AlpFf0PRynh6oc+qj5CR4HUk/b2pfZ5mVfvVJ2x0Xo4YTBO9BqILx/osYDXoSSbZptzy/E29qeWR2B+qPVeZrfOGI7E34PHHkx/I1gPD8b998ym6BWGuoxcshzlcz05dzs0dejmJi/sePMfLyN6DQFjRNyBp3dLBjlIHsMp1xp6AMjiEXv8o4AKE9Hmqgj8O7aeNNVnQPYb3xndbett/SSy6rPZ7AIsW2XWjQiyupUCX47xUBWoy3UcFX6nAiw1aFnjM+fvSTFyOLCZU1Un04u5SEfZgTG80SjqK1royY/f4ektjg1UUWC7AsKb2dGuabCA8IRO/zqOxS/8kwk0OddIpXYLacNhZPjaYBqSPBOIKb9qO9XvQYzg2XxNZWidHgB9r64MNgXhsW1E0LQRlxV3q2Fdkc9+TyAngrusDhgtYbT+WbsQPT/eyg7i7hwwigy7JrWPVmJu7HGfap7KcUHnqK4D8c4MmakdxcwALN2fcTfKOlHFwZwx9UHZRpk4DGa9pZ7tOLTIM5NbQT+3o29k3Sl6THpPcTeAczxX6g+kEIrQ4IWoNvmf40uL5qt95ih7u4mQSYR9qynaB2cGsH6I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5580.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(7416002)(86362001)(2906002)(38070700005)(122000001)(38100700002)(6512007)(66556008)(66476007)(66946007)(76116006)(6916009)(54906003)(64756008)(66446008)(91956017)(6506007)(85182001)(316002)(26005)(2616005)(478600001)(6486002)(71200400001)(36756003)(83380400001)(5660300002)(41300700001)(4326008)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTFUSUY2MVJDLy9SYzZQRUMwTCthakp3Sk1LN1NYZml2NWV3aUd4TzRPOG82?=
 =?utf-8?B?SmJNeGhhQ1FzU2tiMHRQWkZ6VXZRTWVhR0FJSGVLc2xrdFhXMFRsbDJuSXFz?=
 =?utf-8?B?dmMwUkYvejY1TzIzV3RFL0cxUEtlam1YYm9OdjdaRHVpRC9GcHRXQndUb2li?=
 =?utf-8?B?RFlBRUtIQ2tMMzJyMDZtaGlsOE83bnlXREN2b1hOTHY2b1dHNWxVc0diK0JB?=
 =?utf-8?B?ZTVLU0dEckUxUG9PSDQraTZDMnlzcmdiRjNVdXMva0JRUFd3QXBqQmFsVWk5?=
 =?utf-8?B?TGJnb1o3WGN5OTJUcERVOUQxdnRIVk8yVmMvcDRVOVFOMDVHVkVIRmdJVThX?=
 =?utf-8?B?UTRRaE82eWIvQzZVdUVaTVRlbFh4T0owOW4xS0UySTVpZXUzVlZENGlSU3Jl?=
 =?utf-8?B?VXVSK1FlK2RIZXZlWUIyRmtsVVkxcDhqUXI3bU1zZ2xnbE0wU0tRQmx0M0ZV?=
 =?utf-8?B?S3BWMzJ0K3NVUjk1bGtybGlYalJyT3hjcWczV2lQNUdUU0wvNmg4OHJ0cDlj?=
 =?utf-8?B?bFgvK0pVREpGY3ppeWlGRnl1K0lqRjRDenpOa0JaRVBkTm9JSWdOVTEya3Q3?=
 =?utf-8?B?R0VSTEM0RlkzWXlCaGxOVFRGRitVK3pnaWg2SmxSd3ViNWgxM1hLQW9JZFdi?=
 =?utf-8?B?Q05WYkNLUEVDNUZ5RFoxK0NoYVFaZ2xBM2hvRndWcmxsMEJROUIxaWsxdUZO?=
 =?utf-8?B?UHZtNlIrUkJ5ZzREUCt1U3VFSXo3dyt3ZUNuK3d3enZ3NnY5TjVRYVlkTDdz?=
 =?utf-8?B?YU5LYkJjOTRaN2tUMnJLQnNWak5KTjltQkFlUjhTUVgzU2NhbDh2Qmt3ZW02?=
 =?utf-8?B?Y2EvZk51djBYUDZkTVBQWGxRN2g3SFFpVlF2SE5VQzBxNmlCdHBWbDlYRXFM?=
 =?utf-8?B?NDFXQXNEU0dLTmdPOHVZdXJCajZ5dHBBaGl4ckYvZnlyc0llQlFuZEM1MFFi?=
 =?utf-8?B?UEt5QUlKemZQcXl0dnkzNFV4SnVjNGRZZG5MWjg2WFM4MkMxVXMveUlqZkNo?=
 =?utf-8?B?RnVScXJyRWpMbXkvTmdmeHIwZ1FiTTNZWEhaMmpLS3kxQjVKdDI4Z2dWTkRF?=
 =?utf-8?B?MEVGM253ci9IZy8xdWYrNmwwSlIvKzZ4RHk5bGJMZWYyUkxnZGtsaWZGWGIv?=
 =?utf-8?B?Nml5MVZyaEFSbU9HTXdtVm9rdmhHTGVPQ29uUTYwejRTL1ZmWHIrbjBINDFC?=
 =?utf-8?B?YlZmVmFKMVhNenFHNGdBcjltNk5pTDE0NXIxQmhucU5WQVhQYVBoSmxXa043?=
 =?utf-8?B?bzVuYS8vUngvSFlKT3d0QVR3eCsvcm81QWRKQ1pTZ1hSZzlUNTFqRkZ0R2pM?=
 =?utf-8?B?VDk2RUE3bzBZNGFFQXZKd3NKMmRza2p3a3FGczgvakxielVZaDJGS085Vjhl?=
 =?utf-8?B?bldWdU9NaWhrVFBTQy84d1UrN0hpZkRGRU9TTDJERmV4MG9SYUdzNXl1NzdJ?=
 =?utf-8?B?K3hzUklRQTN2UXRKVEpreEp3U0JrRzdnVG5GMWNMUEJuQnNtRTZwTnN0bzFj?=
 =?utf-8?B?bWdKdHV4dlRLb1l5N0Y0QnZsWGdZeU1RY2loVlZtZHBoWkhTYysxcE45MzVu?=
 =?utf-8?B?OFVNaldzay9mY0hGMTF3eWtLa0x4MUZWaHdac3JVT3NFb2xEUDVzL2RNcUJH?=
 =?utf-8?B?ZkhuVk9UcDNqNmxXeDF4YTVsU3NJZXErSzVzc3JRYXdDMndLK2E0TThUQ3Rq?=
 =?utf-8?B?M0RGNmk5SkVoUUhjaTJ1cXYxM1V0Ujg3QzkxNzhFZ3J2Y3BiRzFpUHpWU2hu?=
 =?utf-8?B?VEZWOVNtSytMMmRhOUpuYklqM1VJRUpiajh0RUVKZHByNWhXRW5aUXcrVGtD?=
 =?utf-8?B?d0tSUzhaNVBXZHJyRjN5djlEbnQ2U3cxa2NEZ01LYmkyZ3dWMzE0ZnBxMmM4?=
 =?utf-8?B?YU1wQUp4Wk15SXQ5U0t6SFRobFhMUGVHWWI3amZJbkE5cmZtcWdQcG1uRHFk?=
 =?utf-8?B?MzhuK24xdUNBMERjZkJ5emE4SGY4SkdZVzR5L2JhNVVIOXBUS1V1RjlNbHpD?=
 =?utf-8?B?ZFdhK0xhQXlNSnRFeTZaM0Y3NEwvdmpneHdDYWNrTk9QTGxpaGNLaHZ3bHpG?=
 =?utf-8?B?eVh2QzZFKzg0VDBqalJJMzY3d0U0L2R1SDZDMlJGZEdrYnF6cUI3S25kOTln?=
 =?utf-8?B?d2FwMkU0TE51RnlVcXE0Qk82cDRlazRKK09jWjA2aWo0RE9Jd0pQVVZiblRo?=
 =?utf-8?B?L1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2F0C540E9E9224E95F747FD600E3E2D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5580.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77873e04-9a88-46b5-06e4-08dbc99ed56c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 14:40:22.5094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oAKm2F/NQajCr5Cgw1VK+DiJ7Owx2srRuK+s+PMwVALNaWCCJy+2DlNHCo4wKewby785ORJz/9AWxeZmTCLUBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5971
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--23.753300-8.000000
X-TMASE-MatchedRID: gIwa0kWWszLUL3YCMmnG4omfV7NNMGm+zqP/yfxANUENcckEPxfz2DEU
        xl1gE1bkfdd9BtGlLLzx1uczIHKx54/qvvWxLCnegOqr/r0d+Cx+Mk6ACsw4Jrv408/GP5HqPvr
        EcPlYVkBqWU1QvNIQBvE3mNsb15PKykUkfPOnitKzLD5kmcW6ZPqZGJlZc2fLeG6ZQhhAKrD5WK
        Feqf3EsW9uijK/DjLT0ETlUWsEcepVDs7/hETL64dlc1JaOB1T7yWPaQc4INSVgeI/5EikpFTKO
        /kpdJ9DKI87v44UVk2Rk6XtYogiatLvsKjhs0ldVnRXm1iHN1bEQdG7H66TyOk/y0w7JiZo
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.753300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: B8F32F500CD61E0A0C46A37A5180DF5E3693BF334F9226A10E1D886A68AAB9F92000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA5LTI5IGF0IDEyOjIxICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+ICBPbiBXZWQsIFNlcCAyNywgMjAyMyBhdCAwMzo1NzozNVBNICswMDAw
LCBLdXlvIENoYW5nICjlvLXlu7rmlocpIHdyb3RlOg0KPiANCj4gPiBUaGlzIGlzc3VlIG9jY3Vy
cyBhdCBDUFUgaG90cGx1Zy9zZXRfYWZmaW5pdHkgc3RyZXNzIHRlc3QuDQo+ID4gVGhlIHJlcHJv
ZHVjZSByYXRpbyBpcyB2ZXJ5IGxvdyhhYm91dCBvbmNlIGEgd2VlaykuDQo+IA0KPiBJJ20gYXNz
dW1pbmcgeW91J3JlIHJ1bm5pbmcgYW4gYXJtNjQga2VybmVsIHdpdGggcHJlZW1wdF9mdWxsPXkg
KHRoZQ0KPiBkZWZhdWx0IGZvciBhcm02NCkuDQo+IA0KPiBDb3VsZCB5b3UgcGxlYXNlIHRlc3Qg
dGhlIGJlbG93Pw0KPiANCg0KSXQgaXMgcnVubmluZyBnb29kIHNvIGZhcihtb3JlIHRoYW4gYSB3
ZWVrKW9uIGhvdHBsdWcvc2V0IGFmZmluaXR5DQpzdHJlc3MgdGVzdC4gSSB3aWxsIGtlZXAgaXQg
dGVzdGluZyBhbmQgcmVwb3J0IGJhY2sgaWYgaXQgaGFwcGVucw0KYWdhaW4uDQoNCj4gZGlmZiAt
LWdpdCBhL2tlcm5lbC9zY2hlZC9jb3JlLmMgYi9rZXJuZWwvc2NoZWQvY29yZS5jDQo+IGluZGV4
IGQ4ZmQyOWQ2NmIyNC4uMDc5YTYzYjhhOTU0IDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvc2NoZWQv
Y29yZS5jDQo+ICsrKyBiL2tlcm5lbC9zY2hlZC9jb3JlLmMNCj4gQEAgLTI2NDUsOSArMjY0NSwx
MSBAQCBzdGF0aWMgaW50IG1pZ3JhdGlvbl9jcHVfc3RvcCh2b2lkICpkYXRhKQ0KPiAgICogaXQu
DQo+ICAgKi8NCj4gIFdBUk5fT05fT05DRSghcGVuZGluZy0+c3RvcF9wZW5kaW5nKTsNCj4gK3By
ZWVtcHRfZGlzYWJsZSgpOw0KPiAgdGFza19ycV91bmxvY2socnEsIHAsICZyZik7DQo+ICBzdG9w
X29uZV9jcHVfbm93YWl0KHRhc2tfY3B1KHApLCBtaWdyYXRpb25fY3B1X3N0b3AsDQo+ICAgICAg
JnBlbmRpbmctPmFyZywgJnBlbmRpbmctPnN0b3Bfd29yayk7DQo+ICtwcmVlbXB0X2VuYWJsZSgp
Ow0KPiAgcmV0dXJuIDA7DQo+ICB9DQo+ICBvdXQ6DQo+IEBAIC0yOTY3LDEyICsyOTY5LDEzIEBA
IHN0YXRpYyBpbnQgYWZmaW5lX21vdmVfdGFzayhzdHJ1Y3QgcnEgKnJxLA0KPiBzdHJ1Y3QgdGFz
a19zdHJ1Y3QgKnAsIHN0cnVjdCBycV9mbGFnDQo+ICBjb21wbGV0ZSA9IHRydWU7DQo+ICB9DQo+
ICANCj4gK3ByZWVtcHRfZGlzYWJsZSgpOw0KPiAgdGFza19ycV91bmxvY2socnEsIHAsIHJmKTsN
Cj4gLQ0KPiAgaWYgKHB1c2hfdGFzaykgew0KPiAgc3RvcF9vbmVfY3B1X25vd2FpdChycS0+Y3B1
LCBwdXNoX2NwdV9zdG9wLA0KPiAgICAgIHAsICZycS0+cHVzaF93b3JrKTsNCj4gIH0NCj4gK3By
ZWVtcHRfZW5hYmxlKCk7DQo+ICANCj4gIGlmIChjb21wbGV0ZSkNCj4gIGNvbXBsZXRlX2FsbCgm
cGVuZGluZy0+ZG9uZSk7DQo+IEBAIC0zMDM4LDEyICszMDQxLDEzIEBAIHN0YXRpYyBpbnQgYWZm
aW5lX21vdmVfdGFzayhzdHJ1Y3QgcnEgKnJxLA0KPiBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIHN0
cnVjdCBycV9mbGFnDQo+ICBpZiAoZmxhZ3MgJiBTQ0FfTUlHUkFURV9FTkFCTEUpDQo+ICBwLT5t
aWdyYXRpb25fZmxhZ3MgJj0gfk1ERl9QVVNIOw0KPiAgDQo+ICtwcmVlbXB0X2Rpc2FibGUoKTsN
Cj4gIHRhc2tfcnFfdW5sb2NrKHJxLCBwLCByZik7DQo+IC0NCj4gIGlmICghc3RvcF9wZW5kaW5n
KSB7DQo+ICBzdG9wX29uZV9jcHVfbm93YWl0KGNwdV9vZihycSksIG1pZ3JhdGlvbl9jcHVfc3Rv
cCwNCj4gICAgICAmcGVuZGluZy0+YXJnLCAmcGVuZGluZy0+c3RvcF93b3JrKTsNCj4gIH0NCj4g
K3ByZWVtcHRfZW5hYmxlKCk7DQo+ICANCj4gIGlmIChmbGFncyAmIFNDQV9NSUdSQVRFX0VOQUJM
RSkNCj4gIHJldHVybiAwOw0KPiBAQCAtOTQ1OSw2ICs5NDYxLDcgQEAgc3RhdGljIHZvaWQgYmFs
YW5jZV9wdXNoKHN0cnVjdCBycSAqcnEpDQo+ICAgKiBUZW1wb3JhcmlseSBkcm9wIHJxLT5sb2Nr
IHN1Y2ggdGhhdCB3ZSBjYW4gd2FrZS11cCB0aGUgc3RvcCB0YXNrLg0KPiAgICogQm90aCBwcmVl
bXB0aW9uIGFuZCBJUlFzIGFyZSBzdGlsbCBkaXNhYmxlZC4NCj4gICAqLw0KPiArcHJlZW1wdF9k
aXNhYmxlKCk7DQo+ICByYXdfc3Bpbl9ycV91bmxvY2socnEpOw0KPiAgc3RvcF9vbmVfY3B1X25v
d2FpdChycS0+Y3B1LCBfX2JhbGFuY2VfcHVzaF9jcHVfc3RvcCwgcHVzaF90YXNrLA0KPiAgICAg
IHRoaXNfY3B1X3B0cigmcHVzaF93b3JrKSk7DQo+IEBAIC05NDY4LDYgKzk0NzEsNyBAQCBzdGF0
aWMgdm9pZCBiYWxhbmNlX3B1c2goc3RydWN0IHJxICpycSkNCj4gICAqIHdoaWNoIGt0aHJlYWRf
aXNfcGVyX2NwdSgpIGFuZCB3aWxsIHB1c2ggdGhpcyB0YXNrIGF3YXkuDQo+ICAgKi8NCj4gIHJh
d19zcGluX3JxX2xvY2socnEpOw0KPiArcHJlZW1wdF9lbmFibGUoKTsNCj4gIH0NCj4gIA0KPiAg
c3RhdGljIHZvaWQgYmFsYW5jZV9wdXNoX3NldChpbnQgY3B1LCBib29sIG9uKQ0K
