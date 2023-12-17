Return-Path: <linux-kernel+bounces-2496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AA3815DE2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 08:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841A41C212AE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 07:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823BB185E;
	Sun, 17 Dec 2023 07:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adcsuf.onmicrosoft.com header.i=@adcsuf.onmicrosoft.com header.b="OABmxDab"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4090B1849
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 07:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csu.fullerton.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csu.fullerton.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQubJsR4V0BrZoHxG/wfBZ9Raalp39D7UG7EvmAjGhuR3N3hAa/8zo8Kj1Hz3C4ncoUanrryhIp4wEsCxVOufHG7IpL24C7q9tfD/AR0zvrRIEDydZTICLWI7UaRfGMfhXbaaLVK5+qpJkkmg7nW7dZaMpSlYrsnlfEn1SkYWD8lHnXrTbNM4jB03mLKQnY991f8KSeCUua+zYV8avaqhmAZSu6aXGgwpXX/5PNTCwlRWUAZbsjiGBFodHgp6u42JtzofbWUedWgx9VMouFMGDAbReK/gfnxAJzvK/IUuSCvWXqpeqDRg3grXbgPZNeYZ6w0X8xqE9BNDqpRr9Tb7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRZCVfLWuoWDPxumCrHdOa9XUEZliwLZgRd9FXbh53o=;
 b=DT8jWsb8RNpJAbEI61vPOsTU7CMlZPKr1LyUbd1kxNRnK8y1wimqjeYnSyhH+x0rzAd+C7g1E9zmkcedrQZqbs1Uai3OTT8D22RTVNreLIygtsJdvSb9ENCIqlMYQ9mh3ZkYkg2kEeRmTPsZVdVT0YFOIR2Z4HSnGes+yjjKmCYDNkq6BcFn9dR5h8vT/e4jPcrx0tHMg5pyu5K1ywJD0kwHHXv9/J03PRWCTGd+j2NdOQxENtnP7N7UYPdoZoueEOZkEEIm2MNJa4e8gqCZBQWz7rTIPGb0naaX8VeCEXasAS0LagVBU/WcUPGK62sLv0AbKd7jQkLzxNvQUvawVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csu.fullerton.edu; dmarc=pass action=none
 header.from=csu.fullerton.edu; dkim=pass header.d=csu.fullerton.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adcsuf.onmicrosoft.com; s=selector2-adcsuf-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRZCVfLWuoWDPxumCrHdOa9XUEZliwLZgRd9FXbh53o=;
 b=OABmxDabITjmkSiqIMfE/vJbgQKXGaHclEP+oi5Sg2RHVLZfuAW1OlirMU0K3JcbI7AMhfGXkLKhpdAuLUHUWe1qaEF5KYL9aWed7FxvmDcvIXtoR71Mq5yD42CoqS1NriyuRiXEhKnY8Exq1uIEjsvYoWKKoOsVLGGHTEpn6tQ=
Received: from SA2PR08MB6716.namprd08.prod.outlook.com (2603:10b6:806:11c::14)
 by DS7PR08MB6960.namprd08.prod.outlook.com (2603:10b6:5:3a8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.15; Sun, 17 Dec
 2023 07:23:04 +0000
Received: from SA2PR08MB6716.namprd08.prod.outlook.com
 ([fe80::3eea:fbce:f372:6cda]) by SA2PR08MB6716.namprd08.prod.outlook.com
 ([fe80::3eea:fbce:f372:6cda%5]) with mapi id 15.20.7113.010; Sun, 17 Dec 2023
 07:23:04 +0000
From: "Parker, Amy" <amyipdev@csu.fullerton.edu>
To: "cl@linux.com" <cl@linux.com>, "penberg@kernel.org" <penberg@kernel.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] slab: fix include indentation
Thread-Topic: [PATCH] slab: fix include indentation
Thread-Index: AQHaMLlk1MmNKn6Zb0KQLeT23KdZcg==
Date: Sun, 17 Dec 2023 07:23:04 +0000
Message-ID:
 <SA2PR08MB6716A0570D4EDAAD4221A7788191A@SA2PR08MB6716.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csu.fullerton.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR08MB6716:EE_|DS7PR08MB6960:EE_
x-ms-office365-filtering-correlation-id: 0e668162-02fa-4206-cd4f-08dbfed10262
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +vykKLQfpqBlPsSTf4hKoNbcrFN4j/ixM5goxfxQgRx7zK8vcZUBidgdzAthZGuNXBbbPB8CsdyQgvcP9iU2uEGkE40bl0EZSYZl7eq4rW5Eq1+UCuQjC5xWm8BvUQ4E00oxx+vHu4v2ZnJxYuzeTFiIzLUhR/rJ5gOZtKxCg3jW7EURKb9VbU3sqfNEnzSkG+cVlbt4nG+PW1TXMzNS0uCKmkWGeYcGoFCZ+KCfJVXG7XaVpNp2wqEFReWt7wctai0B3vCdz05IR0+EExNxE/f+UuJAArrE6p2agepYE+1AGug0w2yfOyQ8SXvcN/gmT26msLjxELWIAM7HL0Ra1MFdYcFlcjrqO3fEH4XWM3gM+pdF+rbvEhTQiXp1/epgSNdwu+QcwHFgQZUvDa1p1ADzR2k/zBc2JPAx1kO2tlcesQ3ek7bh1otHS3Wc7HwjIUkJg8zC1+gwMO5jIIYFsje9u594KwG07CLoe5lLXPastCKMRVpVJa+jCxx9yNFUGfFYgdA+npyYn8Od+rpwT7cLFB1zW/T/6WkRxmTtbKnle1RU/f8FiqMMyEluvGmlJ66zmGTKaN4xrc+Ki6uoJG1ukjusBmmJ99aGpPySkxiZdr9yLWfVm6gZo2M2iFjz
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR08MB6716.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(39850400004)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(75432002)(38070700009)(66556008)(316002)(786003)(83380400001)(55016003)(91956017)(110136005)(66946007)(54906003)(64756008)(66446008)(66476007)(4744005)(76116006)(38100700002)(2906002)(122000001)(52536014)(8676002)(8936002)(4326008)(5660300002)(71200400001)(9686003)(7696005)(6506007)(478600001)(41300700001)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?zSI4OyFG75VbE5CEX08FdmpHBSj8m12fiEy1Bg1Niqds+9vdFLd5l1pB9V?=
 =?iso-8859-1?Q?r3FAfBo1r4WHSNXj/g7Evctz0/D0Virn075XGLSqi093DxwocCUYh64zzw?=
 =?iso-8859-1?Q?ZyFG/sDmsjvI6Iw5p/QGOsh4AnJWolmqKCLCIyLIIhZwusHyFcJBX7JJyE?=
 =?iso-8859-1?Q?Wzke38NK5UXlU2rAn7AvsdYHhXne5k6D5/Xn0BHuJIb398FE4EzzahPjTB?=
 =?iso-8859-1?Q?irBjW67aNfvd1o/hboi758Sh4rJU3g3jSidBn56mcsBnlEHzSk3+WDxWuA?=
 =?iso-8859-1?Q?4yvKk3bKruJFp8RcPAFvWZ8FKU87IW8TFeTZXaYA0ok+N9EiqxUKW706Vu?=
 =?iso-8859-1?Q?+NBIyJnlRKcUmdJLRVqOUefqHyA+yHi0nGzJXHosb51mpgpNdz49xjJKnh?=
 =?iso-8859-1?Q?j28WYZxuIZsACLBFLSYZbwSetGqyBZTM+TZ7UexWA6/lCDJeVJNBe4l5kw?=
 =?iso-8859-1?Q?mStQGaAdNrhg2bzjlaOpPRRi2PTSBGwda15xT18tLWB2k+ui0+OBE/D9CX?=
 =?iso-8859-1?Q?20yiX9F1lbVXLISbWabsLPSXspB2OHeWa4bmglE33liNCmzUM6wuNbOUPV?=
 =?iso-8859-1?Q?DCxbWSMY7IgqpzNE2YcsbR6fJpE8qHqkNhixFTXSM8yf3YNmgUOrW0dVlm?=
 =?iso-8859-1?Q?kqsPGLDwJ9eZ/95Xl/ipogGQZy1WcgVS6bNwv3ytdFmCbminJY8Fy9LTex?=
 =?iso-8859-1?Q?ZA8eZmhbBzICHXeHqh6gNwatdMc2UjP4bCojIkG7jnxGh75QrIzJS/WcEJ?=
 =?iso-8859-1?Q?J4tdU7qoSGc4hdkRqVNI8jf0fNeOdQp1/RT/D2kbwbltiQzhccMu7j/3SU?=
 =?iso-8859-1?Q?ruovAJNuUT29yhBVIIIxnW9EUTrUZg3SfrRGoWd8iQHCIrzcBLYIz7AtPC?=
 =?iso-8859-1?Q?2nkuNIQWJck7Q8HG8rDu2CbLFXZ+QYvEUBXrgWvArucwJkxeDN/JO4tHKA?=
 =?iso-8859-1?Q?IvouAgagVNFdaqM7j3lYPPKf2eLhba/ayXgavaEUqbj/21+eaTv9UClb0L?=
 =?iso-8859-1?Q?9A/lZM/zeT/5QjM4vxIBp4EtYJeUCxm1JagHUsR8rANHN9FUVlJVXUvI0r?=
 =?iso-8859-1?Q?Ji5O+peUSVZWkXgFMKFlsqc8/a2u9bUXV5tlUbXDh2kFAWFiTVfUp7rK58?=
 =?iso-8859-1?Q?QC2BpDhmrXwOWY25hRpz+rmtW+jaQ6aD7UeDvmVf6Er9CWhdC//+Wg+Hee?=
 =?iso-8859-1?Q?sLaamycqsmz6SXne29FPrP9lID9ccY4dFC+YCReb98lRJJLcvnO6GnV59D?=
 =?iso-8859-1?Q?Fk6dkMjnUnxEObNGvGr+RHNGjvb5xGpK296giLWOJ//eBTDoZmPTLpOAe0?=
 =?iso-8859-1?Q?tgN0JjvBWgL5pZ8gH+6GPiAnwv+GUU9QE8lm/x4O74CnIrXIVDNkRo2Ybl?=
 =?iso-8859-1?Q?sHXyuJjK+NvO9vCFGDpAiMKU/YYIJlqkD7cIXBw7B1hU/9CuK0F14dOvpy?=
 =?iso-8859-1?Q?ie1q9SoVTYo2dS+4I92zqnB5UtW6l2vq66tMYsRX/aVT2o3peXqj1R+erZ?=
 =?iso-8859-1?Q?5WqIi5SJAanEbtGAwcWCx5yXEdmtX/NeCCEOaMJ/7BeC6bUEfzPTPqyvLJ?=
 =?iso-8859-1?Q?mQYWcmMn2CucRaBb0+pJFdCw2RYwTtRdBjoF+nS+DIomYGvJVCLmvzw/3c?=
 =?iso-8859-1?Q?lQ0o56avI/IgVDrlT0EHCCKCg9plof3ky8R6spkukgPHHAKxkIyQokJ5Ki?=
 =?iso-8859-1?Q?f9XY7I/jOpXukHwSGr4DNsD02PBJISTmNO090pGRHoG+nGU0fa/9aNYpLU?=
 =?iso-8859-1?Q?VL1A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csu.fullerton.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR08MB6716.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e668162-02fa-4206-cd4f-08dbfed10262
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2023 07:23:04.4647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 82c0b871-335f-4b5c-9ed0-a4a23565a79b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FO4gJastI37DdWhyKFd1oqSO/XgpXlP0S6MTeQgVGq2LjvNHU06ygDCVVgCQ3SYnZdWZl062CcOQay0uosx0bXI15XfGTLe1vpFjUuXVHaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR08MB6960

Include directives in slab are indented by tabs, except for=0A=
trace/events/kmem.h, which is indented with a single space.=0A=
This aligns in some editors depending on tab width setting,=0A=
but on others causes the directives to be misaligned.=0A=
This patch fixes that alignment.=0A=
=0A=
Signed-off-by: Amy Parker <amyipdev@csu.fullerton.edu>=0A=
=0A=
---=0A=
 mm/slab.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/mm/slab.c b/mm/slab.c=0A=
index 9ad3d0f2d1a5..e09c44f5b5ac 100644=0A=
--- a/mm/slab.c=0A=
+++ b/mm/slab.c=0A=
@@ -125,7 +125,7 @@=0A=
 #include	<asm/tlbflush.h>=0A=
 #include	<asm/page.h>=0A=
 =0A=
-#include <trace/events/kmem.h>=0A=
+#include	<trace/events/kmem.h>=0A=
 =0A=
 #include	"internal.h"=0A=
 =0A=
-- =0A=
2.43.0=0A=

