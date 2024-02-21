Return-Path: <linux-kernel+bounces-74554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B10385D5EC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB897283450
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFFB39AE3;
	Wed, 21 Feb 2024 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZnPn4NeV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jkDVTNMj"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554402E637;
	Wed, 21 Feb 2024 10:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708512265; cv=fail; b=lScymQVdJA/z4DuDQdsalpn2shaAnVtatxirTw2QmrcP9f1oktiWk84z28SuzDasRK1D4U9GAKHvaIYTCymYE8B89jIiQAZd1+s3vr2Y7BffJibQG9B+iGYlOteMLVJcYI2bUbE8RlyLuKqCRB9MDuj6vPXmAzdpYsDhZrC0xPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708512265; c=relaxed/simple;
	bh=GtAoxXwKpJt+4prnWytYYXuIfa+tAgKU7tiv4zUOGbk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SYHxdlvw/2HZ4W7M1llCIkXNiBYoD8SHDF0EGB8x4knRtWI5CmNEePHC2AAml9H9SiDfMWjgWbZncJku7zvQKt5P1JnNgtoAU5JL0pI3qRR+D8+2bC4KX8DsBLqSuvT+kJqzelTR18adOa8Vd8Wli6h2f5kP6fsWXLkp+IEqO2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZnPn4NeV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jkDVTNMj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41L9i3L1019713;
	Wed, 21 Feb 2024 10:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=/FZkRIT5Hdv5nCekNuPpJOz3Y/Vyd8B7iMqjacDZLtA=;
 b=ZnPn4NeVe3iv7fDpf119/tq4ssWD9N+B4IzY43LeR03dH/V7f4DlmLpy/L6dIvBehybv
 WGCqLdPYVOaz7g+22cf/tCI4UnOpx6Y92Bjbu+pTg3BmjT8YURU07vt3MIkidAPV7Wxg
 1gB0kp0IvdmdSOct6BrzDIy4GsLLHruU/OfZ1gDLECqWvvq6L7lAQNw5JROyNoYIShW8
 bGso4QYDe4MFPEHzJ89YUfQwOMBOhXc6xQGRZrrNYrHOp/m5FXSQZZFHytozx3/PKzJd
 /KlLcnKsyYtidjfY2LloKpX4t97b4kiA+CRSYBcyiArTCg/DlZAErussYTQOx3NBkIbX bQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamud1gn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 10:44:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41LA56N7032495;
	Wed, 21 Feb 2024 10:44:13 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak88trsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 10:44:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7oLX2FWgw4GfXO1y73PGOeWwJhxTTeBrM7zjBv4KI1JLmKnt2aSDq+z5XO/8qXhCvA9tCe6uXL8IRnfZB/fejtxpeWf5C5u7/NT1kloaKpIZZ2QjoRZS5jfxSJV9aHPdg8d14I9UycRtBisnuS6WVyBetTo2b3tYHT6MjVRcVymuwTGjn0VUB2sN9FOZbPvLvEY04iH/oQmFbBSnT3kPbaF74p19I5yMANljlpO/wQ1wJ3N8wwZcLehBRxRJ5yN/izeSHUNVv4KD6FxMjzu1hM1pL5ZseYTtFHohya1oMK10JJo3zkOQi+hGCfVuVeu3SVGEefbEGHMmQST/jG/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FZkRIT5Hdv5nCekNuPpJOz3Y/Vyd8B7iMqjacDZLtA=;
 b=NHCBJBzWq6m6V6L0JVOVIs+vSsyCaq5aX2zg8lnjgSurPcmI62bZtCz0mOxQ88Lf7jgwUkGMWI5pRyMMEMPFXPWYwWesCPLznvEqd+cgrh0R2ObYe2Z432+IV+//t9jj3DuFKqGbny2WH++7+0100VVpUKkMDpDf9RvQ6yknJi/v/CZRjDfvzwu5Ii17l3NCnihtF4SDzvBWKLM/rXyXtszHWtgK+ZZY0WsLWp0YXd96Jqtczlw9a+XUUrEOC1PMT5hPWJ1d/7pugFf1xmJADR1wFwfFRu+zg/9cQygeVeu0dmjv7Ayc7mpsXI4MFURevH0Y2qBqlolITaWmXpQPXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FZkRIT5Hdv5nCekNuPpJOz3Y/Vyd8B7iMqjacDZLtA=;
 b=jkDVTNMjRqWiWovE8xJKz3CC15XpDFSC1QCULjtnJ1a0IbznnJhipD/UAA3MOUAh/Y8s1QsqoD0MtZQ5FEAtP7jcG3ZrE4vwxJxGfbiOQYfqQmwLNbgd4777TwMTyyC/sZhZPS7XP76kOSsIBQlSuYVUrhnk1KYeA6bzaGAQmqY=
Received: from SA1PR10MB6445.namprd10.prod.outlook.com (2603:10b6:806:29d::6)
 by BN0PR10MB5272.namprd10.prod.outlook.com (2603:10b6:408:124::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 10:44:11 +0000
Received: from SA1PR10MB6445.namprd10.prod.outlook.com
 ([fe80::f51a:7f6d:973d:c219]) by SA1PR10MB6445.namprd10.prod.outlook.com
 ([fe80::f51a:7f6d:973d:c219%4]) with mapi id 15.20.7292.028; Wed, 21 Feb 2024
 10:44:10 +0000
From: Praveen Kannoju <praveen.kannoju@oracle.com>
To: Simon Horman <horms@kernel.org>
CC: "j.vosburgh@gmail.com" <j.vosburgh@gmail.com>,
        "andy@greyhouse.net"
	<andy@greyhouse.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajesh
 Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
        Rama
 Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Manjunath Patil
	<manjunath.b.patil@oracle.com>
Subject: RE: [PATCH net-next v6] bonding: rate-limit bonding driver inspect
 messages
Thread-Topic: [PATCH net-next v6] bonding: rate-limit bonding driver inspect
 messages
Thread-Index: AQHaZJ/z/dX/Wg+OFkqAMns3Aqcnw7EUmxOAgAABAFA=
Date: Wed, 21 Feb 2024 10:44:10 +0000
Message-ID: 
 <SA1PR10MB6445FD1C1390E0D7186896E78C572@SA1PR10MB6445.namprd10.prod.outlook.com>
References: <20240221082752.4660-1-praveen.kannoju@oracle.com>
 <20240221103853.GD352018@kernel.org>
In-Reply-To: <20240221103853.GD352018@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB6445:EE_|BN0PR10MB5272:EE_
x-ms-office365-filtering-correlation-id: dd7adae8-b311-4c67-e90c-08dc32ca0995
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 attlVRVkFLgZs3sSrCoiFbGGLJi9AdofVdNaEtuLH8NfrDy5wCeOElYGLFCWrWBGNIt7FnapLDgP4Hto1r7L56Pffwsu/GeH1hJxJ9K4aMNibPhcOYP2NruxGJ8brf83DNuYfJz4shgmfS80xFVElwMlF1aKsgR4ARELyeXJ2odW2tdap1xrDy4i551Tn8+HfnjQWFgFMeML/PfTiScG/RU/kOZ3XxsH4gcJhgpnpV8K3zXHA/y89aXz1khgsBQ0dHKjj+8/Uu8eQg56EINaQpp8slMYt0YsoSd6S9ne6jNG5Aur36sPf/U5fy/Df4ia2I5iJKS+00X6WymlNZdpvJ2Rg6Emm4O1FoXFs/t37g1j800f9HCBqvwgE9DfjjMN6LLM3ciZJXO8q4M80/CHMojIe9rZ5XvvuQm+kSCRG1aglmXsnbxDWYRrza+57QQQ9UgVcQzj2DEMJ51GWGFkC1I1LP+K9OgKr8curfQU6Vgks5F+eVusHtvQLegcVU9pPaD6npWwJ78CvE8dE2XT7Z5EdtOjcwFHZuMvMHbI40JpvOsk1+CgVhVToPO3CEAvGPQfFXH5/h6a2cdzu1vjs6ls44IsONwHkqF45FRM010=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6445.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?wo6heOpgrlUbloT8bQSVvLSzjjRCRApOh+kSgPOF2ZmECfyF4E8B6c14fOXe?=
 =?us-ascii?Q?bD6P72r8FPMF6EchnkCTtEwOPG45VGHzIwOtteDndYQrfgmszj7191yi9r4i?=
 =?us-ascii?Q?HwPJcOaGrZJW6diaclhDftoSV3IvSGD9tK6F04RzuOXWhp+rI6vruvGmLo5H?=
 =?us-ascii?Q?2Ik1SIdxLtxzltG0vBHuDN4yXevagVGoy4LC7IQZ8e0yr0o0QXckseIoH9NZ?=
 =?us-ascii?Q?1FtlF7C6bYYcS4BBM8nKSBTb1iIjcCyZPTNOJ4T/zl8NgWVMveUQOJ1Puu2u?=
 =?us-ascii?Q?9QxGte9g8b+6zLDmjF7whsrxvUce9X95nCqHzPt8QSmP0q/nxLfN+1mJdPmz?=
 =?us-ascii?Q?MiqTnRvSbVFs2ceVw0i5CQLCTSwybbg3HKsTEcVStpeJb9exwtGaJXB5XR6k?=
 =?us-ascii?Q?/SIJY7IzIof6Sk272K3PEAuU4KPT8h4A8KlrUxYrno13bi0wOcgo34QXIGqC?=
 =?us-ascii?Q?lv+x1qt0qTJOes2ILVi+vvS9q9cTEUjyUqC5RTyKiwDl4LqAoC82Q8Wt2+Yb?=
 =?us-ascii?Q?TmmLZt9ZdH1xAAWxxkKUjHJceKCVOmg7rU9c0shsR5EG+4aTxGX0d8hfok5o?=
 =?us-ascii?Q?oRBup0ZQhxf+XHsu07m9TBt09lBBfILQzdqVafEVWds7NZJtrAWdXoOuY9cH?=
 =?us-ascii?Q?47flTCYE1ZRQ3jZQF2JpM2KwVYvKP1vuJUADtHp6CtB8A/WN7qs2c2U+Hl4p?=
 =?us-ascii?Q?AYFqP+Vd9wwvKx4rYpSPYpN1Rz1I0CF+jbE+rtz7+9JSktWZIgNY2HzPSTkh?=
 =?us-ascii?Q?4JzOmmD9JrL5TghXabYS/y1SHolrTQxuiXNHLlC9/33oE4mBnf+qWcoy12WG?=
 =?us-ascii?Q?W/y7X1oDYg46e10py0hATcpj6WeK9cgQ95SrPGqBAj8K7FTrzsivUedDVzom?=
 =?us-ascii?Q?AJ/7h/Z/fjwB9hEFWYO3EVrihQT2mwQdOY1cRvrrMiv2D+uefSpJL4o65Hlp?=
 =?us-ascii?Q?NjO1WDyuskTUBoWG96EZ2L40HCq8kSFGJLy6Y+VZGleeLe1wlLTtT4TDGXV2?=
 =?us-ascii?Q?kppeAC5FIILGqvZm6ATKD/Ka7jCHAchV31ZjVHC9L0CBEqxYngxngwI5ZZBW?=
 =?us-ascii?Q?Js3mS4OJfbERCD3xxiuFkr8vBzaTs4CXkSLp3Sf43O3pdf6ZVZ12KrM7nGmx?=
 =?us-ascii?Q?7/O+c9/2ygf7nVKz1i+//xRTytXrkxo1QXbYQMPdmKYeZEQKnVllI8MTnb3L?=
 =?us-ascii?Q?r3RXeNQ3ArQ07xyyT1FsmlBdCrfDh9FT+btWu/UzsfVhETI5Q/Dt95KVTQbA?=
 =?us-ascii?Q?0EBcY56Zj6WJLeHSEeIM2Oelm8PvoBtKJev8TJvOxKbKFjJkGD9mV/Axokmr?=
 =?us-ascii?Q?SxgOpM/DkI0jimEjJ39f9z17v1KJRh10IFS2EBeGTLdx5kSFe4an0rO05WrV?=
 =?us-ascii?Q?aMuoVv7AXu4bKKUXrd1v0wRlFswBS5WgxU01pq7AEFkvoXuT4WCW+8fhTs0m?=
 =?us-ascii?Q?bYZKU1sEfawTqNJ5zFE2ULZd45WQ+S2ZA8jgmWYUkQW8hmYX0VLgi6ErIPj0?=
 =?us-ascii?Q?o1bINV3uw5LnJfTjcnLghSNGr9nOU1jxUFq1Dep+l8TpNrMvPYrXdn/U9wM/?=
 =?us-ascii?Q?plwr0D/6rmJufOhTLo+S5CPLs3GiSakHGhckp8HrO4EbXJvjHqcb6kWfx5J1?=
 =?us-ascii?Q?Kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mM825wEfbCNJOCBWZ1owrHGG4JdMfkMUskJ0eTlpf/Ru1LcVugbxqo5mdpV+ADv+K8yJNG+lot/LkgsR3Dui9jwCenvJk70N1wUHLuqzStbVZ+URBACxjwnsw5kAGNo7Ttx59rFoWrbP4gkkHv9Gd4p1G9xNNkEraf7d7HP+TUaECzN6lStVJ+YsCQUfGE5Y7Sj/x/3kcZS2VVKqaPxJVKq1nRVp3/9BcSe4fmmdYfAe2QVZ1bbQpib61M/jl5IVnlQw6LCwjcEA2l4kpwzUaizZYl9YGNmAZDmIv4FkhKFPEtqB3bH+Pg9C5uXyp4jXjK211Hnd+tMpBGGi4adudH9i0ha+ki8wZPdqWHfABhCdbIVcLCtKUILru+s01R2yLGSCi38xaNk1xXjdpfJVeYahcHSV/dN5wqoQT839vrJwvs4YSMpw5AedRoLhBxgiZwK2ODJp2/pQlTRENKnppaO70gJNq6uKP2tk1hcGkXy3/lzCNXM78A3/z3ysPL7UygRjU6Uxyu7RGD+JkUe1wXv/qO8rMjA2FYVeFTKotCjXW1CJQq22FirTcffVbSzp0w+vSKG7u7hfYblSSpgw8HnYVsZ30hVdGZWBfHJ1FLY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6445.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7adae8-b311-4c67-e90c-08dc32ca0995
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 10:44:10.5216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SydhAKUZG31jCqtMqyxlT0KYcnLOPfdeGVd8Gc+DDSpngdv0/UeJeHQRb2KLmK6CaxTqvvfDNJjjxW773xeLEMROxFbLGC1FLW1KqbIFYh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5272
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402210082
X-Proofpoint-GUID: eLbW7RwgHcBzy_RVYItpjkw2_FzSeGuM
X-Proofpoint-ORIG-GUID: eLbW7RwgHcBzy_RVYItpjkw2_FzSeGuM

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: 21 February 2024 04:09 PM
> To: Praveen Kannoju <praveen.kannoju@oracle.com>
> Cc: j.vosburgh@gmail.com; andy@greyhouse.net; davem@davemloft.net; edumaz=
et@google.com; kuba@kernel.org;
> pabeni@redhat.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; =
Rajesh Sivaramasubramaniom
> <rajesh.sivaramasubramaniom@oracle.com>; Rama Nichanamatlu <rama.nichanam=
atlu@oracle.com>; Manjunath Patil
> <manjunath.b.patil@oracle.com>
> Subject: Re: [PATCH net-next v6] bonding: rate-limit bonding driver inspe=
ct messages
>=20
> On Wed, Feb 21, 2024 at 01:57:52PM +0530, Praveen Kumar Kannoju wrote:
> > Through the routine bond_mii_monitor(), bonding driver inspects and
> > commits the slave state changes. During the times when slave state
> > change and failure in aqcuiring rtnl lock happen at the same time, the
> > routine
> > bond_mii_monitor() reschedules itself to come around after 1 msec to
> > commit the new state.
> >
> > During this, it executes the routine bond_miimon_inspect() to
> > re-inspect the state chane and prints the corresponding slave state on =
to the console.
> > Hence we do see a message at every 1 msec till the rtnl lock is
> > acquired and state chage is committed.
> >
> > This patch doesn't change how bond functions. It only simply limits
> > this kind of log flood.
> >
> > Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
> > ---
> > v6:
> >   - Minor space additions addressed.
> > v5: https://lore.kernel.org/all/20240221050809.4372-1-praveen.kannoju@o=
racle.com/
> >   - Redundant indentation addressed.
> > v4: https://lore.kernel.org/all/20240220050437.5623-1-praveen.kannoju@o=
racle.com/
> >   - Rectification in the patch subject and versioning details.
> > v3: https://lore.kernel.org/lkml/20240219133721.4567-1-praveen.kannoju@=
oracle.com/
> >   - Commit message is modified to provide summary of the issue, because=
 of
> >     which rate-limiting the bonding driver messages is needed.
> > v2: https://lore.kernel.org/lkml/20240215172554.4211-1-praveen.kannoju@=
oracle.com/
> >   - Use exising net_ratelimit() instead of introducing new rate-limit
> >     parameter.
> > v1:
> > https://lore.kernel.org/lkml/20240214044245.33170-1-praveen.kannoju@or
> > acle.com/
> > ---
> >  drivers/net/bonding/bond_main.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
>=20
> Hi Praveen,
>=20
> Thanks for addressing my review of v4.
> This version looks good to me.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
>=20
> ...

Thank you for the review, Simon, Hangbin and Jay.

-
Praveen.

