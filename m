Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A877F7B9F64
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbjJEOXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbjJEOVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:21:23 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019C71708;
        Thu,  5 Oct 2023 06:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1696513721; x=1728049721;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IUstUzZCcMu/CFbbQEZoXK9zzqdgAJK/9sNggfwgGlk=;
  b=dkRm/5LVcDx0qRxMrAwrI/nsnbm51D9aQIw2gyDEhiQ8XK4tgJ0TxMYF
   B7DfH8p9lm3rIutMIuiHJeZIhQHrQfPydAGlZwzjv0RLsKfUKBTIL1AIN
   gKK8fLacEgc6qqT/n5JTP48rqhlwAI7cjkBNFyeEKYzmRAVsaYrcr4HcN
   Za9vF/AZI6t4ToN6j+p55StHzeLqSgmhL4o8ad4555DOvb+aafDW/j5xl
   b1Fc9I0/3y7qMwtV4/2/oa2IcGE+Nckw2LMR/jcdj0eQW7BX0abwpjd7q
   oKwYsqxsVNLDr4FEMjqDPSSrp+u/x1oAyD6syEU5M3xlxlfmYVam5X6OM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="97847469"
X-IronPort-AV: E=Sophos;i="6.03,202,1694703600"; 
   d="scan'208";a="97847469"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 17:10:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSZIzJuaawoQvJjFyW8J9TbJR16EIWD9yVwm1Dn2glyK6ZyGQM20E02AqfGMd/zA68MF3L7FNwi/LWNwUzROtqhm3oVGZXO2j5cAbJh4PtpKSzAIF0kUHf8L06Dt3IQ02Gl/w2tgIHm0fwFGcJONPJGI96R9o7qJMgKJ3vdKFPTMTeI5OZANX3NWd/hMjOBFWMdLlbbZehMk4v4h9jiWvoSAnKkpOERrcmGOUAdxoJ4368oyy/uBiB+5Z/rEn6aFzZWbEQtvRrJ/UgEw/LoXJSGfrnGLdTLZFySbKzoPOUL8Gz4wyOBCUPONllq7qGji4JutHxa/UAkKNI9qZufwgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUstUzZCcMu/CFbbQEZoXK9zzqdgAJK/9sNggfwgGlk=;
 b=SkqxOmrvZgZNWmBooDg0VvAB62xe47VawZvNaOqZSARPievZD4Z0foqQYSpQBQaAXnvAxtU/LjqEKABLdRfoZhHjnAX2xBLCp/vDDdcUxOOv/BZga53mla+J2Xx9qw9ZL5HIfeT9un6qsECxnba/qna1ck+YUd3FtjyKlw/VOpdBfxal7+E3JaJMQSi/GjE8TSasrGk5EwyjRRu4yE7W2vKr4HGwrjEAvck9fULHr1ytm3Khets3OusXR+fQ7YT0sJ0FVNP+wtb91rEaFkR8mlXkJ2DxwFnmCJpu6FuRyPBCV9kHqEsnlFIvV0Ywv7+/WSaOSPgzUiivOzZkP7DcJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYCPR01MB5776.jpnprd01.prod.outlook.com (2603:1096:400:b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 08:10:45 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::59bd:366a:131b:3f26]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::59bd:366a:131b:3f26%3]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 08:10:45 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     'Tony Luck' <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v8 0/8] Add support for Sub-NUMA cluster (SNC) systems
Thread-Topic: [PATCH v8 0/8] Add support for Sub-NUMA cluster (SNC) systems
Thread-Index: AQHZ9kDzlG+TeV0tu0+tOixhXj/TtrA62XXg
Date:   Thu, 5 Oct 2023 08:10:45 +0000
Message-ID: <TYAPR01MB6330625DB7B68BC63B4F67E38BCAA@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230928191350.205703-1-tony.luck@intel.com>
 <20231003213043.13565-1-tony.luck@intel.com>
In-Reply-To: <20231003213043.13565-1-tony.luck@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9ODg4OWVmMWEtNjA1Mi00YTIxLWJhOWMtMDRj?=
 =?iso-2022-jp?B?NGYzZmI5ODNjO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjMtMTAtMDVUMDg6MDc6MjhaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: d934467a6d3d4aeab82b952cd9e9563b
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYCPR01MB5776:EE_
x-ms-office365-filtering-correlation-id: 28d32a00-3da8-48d3-df50-08dbc57a93aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BF6Abc1lImzGtCItc3787X0/wRRKemjuUlZv7fOAIjuIj3ecClv4vAaRA26pts6vvtLLn3pymFIGzmvmZZaaHC4gupIb7dQjIav1k7/pxWfNpP1qtIVm8s5KdBkfDfiO89hYI9/A9hFJkymeQSZ4fvTlonJxU/bcQ4UzksE3TpJIq4JtbTgCxpcx2mWQUKtMDz8DjGksx6CB8dFdIpyNT/r4iil//Qe9zwY+1ggx9pzpAAjlyP21DtkJhx0Md03QvoTyPeYXqJHoVbjah6xF9A0fe/BfnJ1BL02JxONKjSUdWwtJBuR36AoBjvrmUq1Qkwjgh9U0o5FqmwbZANCelLBe+XIR6JOM+QXclEMR97/GfefoP1Va5RZQdNLWMNv9pE4T24m4kyE+BHAm1PilUhKAQQN1G+VMU0mZN/ZB0QVoP0JR9G1oT0O1pyEqJmkzzgWJvlHmk/8p4jA9p3aG0wWlsogi1Rp/1eCc5z1WhSuSxTypFCxqdCFKDGnx51fqEjajIeL17Uf88URp4XhFmf9tT+b1yRy55lXBRyiJ5A/AybvAtNCVSGgX44hrT68qIw/SLojrMny+D/bwG+A8dRQxWniqN7RVzn0FkB0kPjG+QsW7fmndoLGAi/um0HIjRXgB2fHysvwWB1ZfQTu7Dg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(346002)(136003)(230922051799003)(1800799009)(186009)(451199024)(1590799021)(64100799003)(122000001)(55016003)(85182001)(38070700005)(38100700002)(82960400001)(8676002)(64756008)(8936002)(5660300002)(4326008)(54906003)(52536014)(41300700001)(316002)(71200400001)(66446008)(7696005)(26005)(66476007)(6506007)(9686003)(478600001)(76116006)(66946007)(110136005)(66556008)(1580799018)(2906002)(7416002)(558084003)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?VzRYVXpxZ3c5OGFPaEpyY0FpMmlEVnk0M0hpODhRcHVaem5BMVVqNlRu?=
 =?iso-2022-jp?B?eEQ1NXhhZUc2bEYrSFVVT2VOWVhJbVcwdU1iNStuN0poSjVqaE5QSzds?=
 =?iso-2022-jp?B?UWtFNXF2Tmd6WFRHWjYycVMyNlVtWjBUNUtsMzlGMFdHaUxJMDJqdFZH?=
 =?iso-2022-jp?B?L1VVYjRFZm5oYjRTVTJlQW14UXFTOCtkZXhrN0VZRHgrRWlRNG5wakJM?=
 =?iso-2022-jp?B?KytKSnZHcE56NGlrZHM4QXZYbnJhOWV3Z0hoQ1E0enI5NVd4NWtQenFD?=
 =?iso-2022-jp?B?b25yRkUyc0FNM1FxOEl2eDllWElxUVRCSWxvNHNnMmk0L3E2a290cUhm?=
 =?iso-2022-jp?B?M3JGOWRGZUFKcG9JN2c0VllueUsvbEcwYThKODlOQ1Z5UkZ5SCsvd3RO?=
 =?iso-2022-jp?B?a2FiK2xWcGFCajZvNnRWZDBuTWpzSnZ3dFF5eUtLWmZrNVE0bWYyZkUr?=
 =?iso-2022-jp?B?OWYydjg4Ykd3UmtobEpvckovMDlhaXJGSXVaTHlxeFhuL203UVRmbGQz?=
 =?iso-2022-jp?B?WVBCOHdzYTcra3hxVk11MDhIaE1Hem9qM3NSekIwZzNyTXlQVjU2cG92?=
 =?iso-2022-jp?B?SGVjVjVkZTBxQW9MbkdNSHdTWDBoeTRJMDZRcXJzZ2IvVGw0Q2cxSFJQ?=
 =?iso-2022-jp?B?eHpXYWpSR0VDY3U4MCtvMEl2THlBaDR0Rk9XK0tIWUI4bmZtd29OemV2?=
 =?iso-2022-jp?B?dS9jUFhLM1RDbU1DcWFnM3Z3UTEyblpGOS9EVnppelFuWXdtNVRzNWdY?=
 =?iso-2022-jp?B?TGVyNkpvQXN6Q2RoK3p5aVpYTmo4M1pNOElzUmpWMVVxSzVpTEE5MnRh?=
 =?iso-2022-jp?B?dzBaUEQrbE1xU3BjUFMxZTNZVmhPcnNRM2MwY0ZxQVU4REhXOFhCN2lC?=
 =?iso-2022-jp?B?SUw4Umx0M2dNdWg4em82OXVPbEZqV2lTa0RLdFZqTVRhRnBFSWpzNTdr?=
 =?iso-2022-jp?B?L21wOVFNQm5hYjFnVGllNlhPbnR6U2RibldJMmJML2orQlNETmFVZVZ6?=
 =?iso-2022-jp?B?akFUS2FGdXBROVlKVmJPSTVYQWg0YmxHUG5DUURwRlVZVUFISDh2OWNO?=
 =?iso-2022-jp?B?Zlhoby8rd05FOWg5MkVjOXU3WTVsWnFWOFhZTzVvazF6Ymtkd3JlZEZz?=
 =?iso-2022-jp?B?NHZ3dzVxWTY4R3RmK2xmRENyUUluVlZQWmM4Wm5xT1lPVTRnNHhObmE3?=
 =?iso-2022-jp?B?QTZkRlNvTlJwSVJ1NWlUdS8xa1hMOFRSYThaUEdmTTZldDgvYlBnMWNp?=
 =?iso-2022-jp?B?MmovVUdvT1pxSVp0WXpiamdVUjJTNVo0blN1TTh0a3RUWFMwci9COWhY?=
 =?iso-2022-jp?B?N2pqMUJJREtISXhhSlNKQlcweE8vZkc1eGJVZWpmbDBIeXpvZWN3bjN2?=
 =?iso-2022-jp?B?ZVFqbzBRWmFkUWo1RVJzNHZ3c2V1ZUFoanNieEJQZUpvTTlTSjZ0eFh0?=
 =?iso-2022-jp?B?ek5SNVlFZWZMM1k3MnczNWtKTDNhZk5iWTNtV1FBcTI0TmNXVjY3dStR?=
 =?iso-2022-jp?B?emlwcGZyUjdEbUVreHFmZ2kxVVpPOS9yRFZLcHRTOTRZRCtOaExTVU5M?=
 =?iso-2022-jp?B?c2VWaWNLKzhWZjV6cE5pR01uZnNrbkk3TE11dG41eFIxdUNoa1d6UzFM?=
 =?iso-2022-jp?B?TlZTeXJKam5LdzIyY1F4Y3VMcnFzcXNMbEtBYkh0WnRvTGs0T0M5em9q?=
 =?iso-2022-jp?B?aEh4SXhqYmRoa3BQQW1hS1dTeS9xZHBqQkpGMUI1eDZ0VVVWQjZPSElE?=
 =?iso-2022-jp?B?cVhXVjIvZDZjbnZuVkluRGxCdklWNXpNell2VlBYUEdGVEhRUFhsZExn?=
 =?iso-2022-jp?B?QjRya2VhQmxJS2lOc2JUcW40S2tSRExTeWM0VVhxRCtHQTEwd2hjWjk3?=
 =?iso-2022-jp?B?bjJxV2VKbDNmdS9LdStvZWVLVXd1U2JDa1hZRG84MUN0c2xHYVI5Tkt1?=
 =?iso-2022-jp?B?amZTd3NGaDRtQ0gwUmhPOUt1QjVWeVJ6Q0c2SGM2a3MwdnVYeC9Ld3pl?=
 =?iso-2022-jp?B?SCs5OThkbWxIeCtRK2dQdnhzMDB3TE00TFg1dXl6VjRZWG01NUI3VUVB?=
 =?iso-2022-jp?B?dmMxVFJ3bEJzaUgyWFdxNlVlai8zSGg4eXNta2pBN0J3djMwckhHMDZK?=
 =?iso-2022-jp?B?OUE1VjNlMGg3azBjT0dXZGN6M1NiMFRhQUZvdXVEQWNaZlgxK05aVXB4?=
 =?iso-2022-jp?B?VDVNV1pCa3d6dVJxUDFZZ1kwZmdPbENHZGYwck5YY0dCMzBnczJaVTY2?=
 =?iso-2022-jp?B?bGMrV3RnWEZUVzZ0RUx0MjcwRDdGU1d5Q2llNDZXNGwxa2NvSTRSYWZx?=
 =?iso-2022-jp?B?V0lDSEI4QlJqZ1l1cUQzWXVXR2I5VUR0enc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-2022-jp?B?YVVvUWlJbUoxWlpjaG04aXBoOU1yNVY2MmhJTGxiaTR3WHA2YUdFV1Er?=
 =?iso-2022-jp?B?Q2dmRVZ5a24wN0xuMjd0YTdycGl5UlNucEVER3RmY0FqaHVnRXZvcSto?=
 =?iso-2022-jp?B?aTc0WE1LZFhQZ0JzQTVUT2UwWDFvY3FGRG5tS2ZaTkl3NnVLWTk3RjZz?=
 =?iso-2022-jp?B?dm5MQnZ4SWxFYWtKakgzZ3pDK05DYk1VNzdESjY0V0ZuZWNKOW05dW5U?=
 =?iso-2022-jp?B?UXhCZjRJVVoxS1V3MC9IdTAxVEY4MXdWYzVIdks2THRlaFNPbUFGODE1?=
 =?iso-2022-jp?B?c1Z2NEVlclZ3Y2RSTkM2ZVhjSlhEY3JxQ1NoVmdVMmlsRmJwNjJ0VnRS?=
 =?iso-2022-jp?B?eHdLaXJCQW55ZU1pMUxWT0RkSEh0Z3hhUXhJR2N6OXYyR29RWllybDRV?=
 =?iso-2022-jp?B?c0d1SjZUM2NrZVErZWJidm5KYnFyYkt2R3ZxRHdhMnRvTmt0Q3MwYnpq?=
 =?iso-2022-jp?B?cTUxcGM4TEVzZXNHNStXTit2d0ZsS2Zja1NDcXg2YlNidk9lNkt4cG9M?=
 =?iso-2022-jp?B?OHVLcXU4cjRyV2gwWmRBSWFZNS9HL2h1SjFLaGdEQmwwdlR4N2w0eUpj?=
 =?iso-2022-jp?B?Qzd4b1VWRC9zWGVTT3lzRHNnMzAzZWNlRTZpem1TYmFGRkF1cFVsZ0pa?=
 =?iso-2022-jp?B?OVhseDg2elAyNVpVUGZRdEJWYkZWOE1mSVJhYkJBWnZzV3hUY1cvbVZR?=
 =?iso-2022-jp?B?dXYvRzhoeGxPVE5kanFyUVB4Y1hLYktFNW5tN3VNOExCbllLZkRxb2hZ?=
 =?iso-2022-jp?B?TTl6SE1LMU8rS1FwMFBPWWEwSFpQMkY0amR6WDEzZjlEWjc5dHFhUUV0?=
 =?iso-2022-jp?B?YithS0xZVzQ5QXpBaHRJelhVT3djbW13a1liUjJOT2xUczJTMzg2WXYv?=
 =?iso-2022-jp?B?WnUxYVF3Y041MWlMUjBVT0wzV3RPalZpZjlZTy9VdXFnaGFpNTQwRkpu?=
 =?iso-2022-jp?B?NmJwWDFiWEhrZDRVSXlzcFF1YTkrUjFsSENXWjZ5Zi96aE1Yb0crcWQz?=
 =?iso-2022-jp?B?dDZmYnc1QTJhZElsSGQ1N29UWC9DTVFnZ2cvZTdyeEhnalN3QXVla1Rm?=
 =?iso-2022-jp?B?Nkdsa3ZpUWlmWmZUdU5hbjhZYzBsYTZ6VlkvUzhlWEhUTjJQMnhEdmZK?=
 =?iso-2022-jp?B?UVYvYnFxVE5jNllhTzl4dGxoaDB5OXBPaGlLMzQ2RnlxbUJGVmhJWHlC?=
 =?iso-2022-jp?B?YnBzL211YUxjZHNGYWZ0c3VWWVJEZ3pGNlpwQk9jTUU3U21LZlRSdU4r?=
 =?iso-2022-jp?B?TDNBL1BIRzg5MmJIM096T0VDdUdVYnBqRFF0SlRkUzZmRlFIRVIwV1ho?=
 =?iso-2022-jp?B?R3R5RjB0aTMzMGJxdlVKWTZ3TTAvUHgrTStEajY2RCtKaUc0bE1iZlox?=
 =?iso-2022-jp?B?ZVMybkp4U2pjTlJRMW8rc2s3ZUU5TzErRjdNRlBqMjNUZXZnSmNlbWRY?=
 =?iso-2022-jp?B?dVJyRmwveHNLc05mTFQrUTZ6TnZ1UEowU0FIV1J4Wk5XdVp2d1VEdDNV?=
 =?iso-2022-jp?B?Y05HeEpOemZXYlpsWmVERCtxUkJZS25QaDdUZ1kwaUg2Z0hHZDhESDJy?=
 =?iso-2022-jp?B?ZUtERGFONjNyeWcxdEVscHVRPT0=?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d32a00-3da8-48d3-df50-08dbc57a93aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 08:10:45.6659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5EhN5oVKELhkxHJE70JjW5zMFkfgdFVNPBax3zxAbgOufrrHKVCpn24jEBLq+PGlZiPa0JnM6FMgByf7b7zMz1PGRloGRXgHqIOv3dMJ17w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5776
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

I applied this patch series to kernel v6.5 and v6.6-rc4, but the kernel can=
not be booted.
Could you tell me what kernel version this patch series is based on?

Best regards,
Shaopeng TAN
