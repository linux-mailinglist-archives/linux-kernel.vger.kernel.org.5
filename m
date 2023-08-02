Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F043076CBBB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbjHBLZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbjHBLZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:25:12 -0400
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109E21FED
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1690975511;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kg9pv6WLfZurnZI/UbZK7XhwsFSx2raFsfUT7CtISlY=;
  b=VeUY+QZQCx8mJ+V6MxJPsalsQuz+ZisvRLQCHJOWgIAmdAGa7FrufLqV
   DhLz5fXPkQcb6VO+DN8sP4jgtfPnK2nUczvTtZ16IH4yy/xsdPmk6f77G
   JR1YzAPziPqlQ/8u0N5CP6sfjhyJ1co0xGT0fTrc397k49RcC6j5fZC3w
   0=;
X-IronPort-RemoteIP: 104.47.70.109
X-IronPort-MID: 118118251
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:aJhtjq+d1hX0hMj5enklDrUDXX+TJUtcMsCJ2f8bNWPcYEJGY0x3x
 jMYWGGHOvaKMTHzLox/aNy1908Pu8eDnINnT1Bk/Cw8E34SpcT7XtnIdU2Y0wF+jCHgZBk+s
 5hBMImowOQcFCK0SsKFa+C5xZVE/fjUAOG6UKicYXoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqojUNUTNNwRcawr40Ird7ks21BjOkGlA5AdmNagR5Aa2e0Q9V/rzG4ngdxMUfaEMdgKKb
 76r5K20+Grf4yAsBruN+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+v9T2M4nQVVWk120c+VZk
 72hg3ASpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn9IBDJyCAWlvVbD09NqbDklUy
 9EHBRkobSmd3c+a/6uiQa5Fo5o8eZyD0IM34hmMzBn/JNN/GdXpZfqP4tVVmjAtmspJAPDSI
 dIDbiZiZwjBZBsJPUoLDJU5n6GjgXyXnz9w8QrJ4/ZopTeLilUpgdABM/KMEjCObexTklyVu
 STt+GPhDwtBHNee1SCE4jSngeqncSbTAdtCTeTorKMz6LGV7mgfAQVKBQe7m9KemGm/fN1OL
 1c+4BN7+MDe82TuFLERRSaQuHOYswQOc9tWHfcz5AyExuzT+QnxLnhUEBZCZcYguctwQiYlv
 neNntX0FXlsvaeTRHa16LiZt3WxNDITIGtEYjULJSMH+97ipYs0gzrMQ8xlHarzicf6cRncy
 i6LoG4djq0XhMgj3qC3u1vAhlqRSoPhSwc04kDdWD2j5wYgPIq9PdXwuB7c8OpKK5ufQh+Zp
 n8YlsOC7ecIS5aQiCiKR+ZLF7asjxqYDADhbZdUN8FJ31yQF7SLJOi8PBkWyJ9VD/s5
IronPort-HdrOrdr: A9a23:/omNiK4CFODBWS0WVwPXwD7XdLJyesId70hD6qkQc3FomwKj9/
 xG/c5rsyMc7Qx6ZJhOo7+90cW7L080sKQFg7X5Xo3SOzUO2lHYT72KhLGKq1Hd8m/Fh4tgPM
 9bGJSWY+eAaWSS4/ya3OG5eexQv+Vu8sqT9JnjJ6EGd3AaV0lihT0JejpyCidNNXB77QJSLu
 vg2iJAzQDQAUg/X4CAKVQuefPMnNHPnIKOW297O/Z2gDP+9g9B8dTBYmKl4is=
X-Talos-CUID: =?us-ascii?q?9a23=3AqggOwWs23h6fVZBN8devdfxU6Is/TFDC4V71IHa?=
 =?us-ascii?q?mU0tFd6SMQhi53f17xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AwdTmdQ/dxV9TbVH2DBTaZaWQf8Nk6rzyWBwNq74?=
 =?us-ascii?q?hqe6FEiNhPyy3lg3iFw=3D=3D?=
X-IronPort-AV: E=Sophos;i="6.01,249,1684814400"; 
   d="scan'208";a="118118251"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Aug 2023 07:25:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e13Ti35oJIFLy5s+bG9+as2BH+vxGAB2fSz4P08fvtmHAnoQJfAV6snahn8t76ZMZZo6K/bSt5Gwr/mi1s63NJVF3fQke2GAsEQge4sL9j3GxfvQQh/6fSf8Y1oWu+V2vWM3YjNiP+i8AbBYpJpOaFlQHUcVzd1ODxJS0Zd3oAhNFtf8ryCzmFonCIHy5JaNjVCJQVWBw5WwNdgLKn63stflhzotF3DTjNz5jrPBGQUP77HetWHcgabCD10nuLck+kLRA2OVaUFItsI02iBPoCbjsPGWzdMshhTSrxfvisc/attbIDRDybw1xT4fDOslXuIlct2+HoPbBstwRdgosQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kg9pv6WLfZurnZI/UbZK7XhwsFSx2raFsfUT7CtISlY=;
 b=iU5IniogwTfzbrxd270zGMNmhHLNBweEV56IXJVmmHZZ0c/m9pXTSoFiVeW29PKT0rejVBs9c1hDWU8kedwO5S1MelckX0+gbEYkA8Sdu6XszgS3w3GQQsT/LohlNEmzuNYUyPynoUT6GW3UGf6zqWvSLtn+fDa/xKvMP+vH2xmtqmEtPjlf6zwPwSC4XgK1A9ldAdm6LCV72z/PsB8/HJEZTZPSktInbEPLeNVZqdXFVQDm0z6WLAYQaZ0460tx+M2Xme3BstfNwGEAG4Tuc8aCYNC4uZfj/pA6w76eKy5NJtnsf6Wi5AzXxq7qdO6eu45d6Lvt34yLGFNYXHMW2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kg9pv6WLfZurnZI/UbZK7XhwsFSx2raFsfUT7CtISlY=;
 b=SdNlBKAW6TJ0q/PSKfLRL7xDNcyv34jfbGl2PmhbHw0u8jvXKcBM45YHvttsMc2sev67/RwkMWv6oCkVlLcee4c+NorLgSPHqrpessYAtKuKfcVzcyM5Rcay+YXhlaelYQwDiG//LlAH3+UEkeEoahQSdHAWroDhtlRYmnjghos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SA2PR03MB5756.namprd03.prod.outlook.com (2603:10b6:806:112::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 11:25:06 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::9410:217b:251f:2a98]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::9410:217b:251f:2a98%4]) with mapi id 15.20.6631.043; Wed, 2 Aug 2023
 11:25:06 +0000
Message-ID: <9e30c47f-9297-8d98-8f96-0005b3de8c37@citrix.com>
Date:   Wed, 2 Aug 2023 12:25:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   andrew.cooper3@citrix.com
Subject: Re: [PATCH 0/2] x86/ibt: Fix some spurious ENDBR instances
Content-Language: en-GB
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@kernel.org,
        David.Kaplan@amd.com
References: <20230802105545.594381530@infradead.org>
In-Reply-To: <20230802105545.594381530@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0359.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::22) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|SA2PR03MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc07fef-b5d3-4425-a55f-08db934b1f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xriKNvyjXOD8kqkdyqcoe51azYFvtrnFbQg8RVuE6mVWwzDV5GnHJbABc0UIZkT/kNx2xEbftLcipCan90PZszndu30L3RDU9AEGZG1F8AjCiDuPB+ogCH/xT79DGIoeO+YMEY2O+iqBExZIBZ8rkZRtq2QQbLMA9OD7SPgaeVYa1hf7fPhvEjeHv+Lvo3vBHb4rAu76aWxWqM7QCyV/zFvMq8CjF/Ah73/cpMHtgKoxeSRl5vNGrow5G+o7MTtWNPbI3FaebC2hmJ3zR23h04Qa95y/gekPoegVJB3nnsVH4Mmc3MYzmxKUod9WXImChr8tQBs2X/TpcXctgVCB+HovawQR+Ex6Vlwu4mdEIhOvt+hRbh9sn7rb6mnKKg/LzZhKK/pwEWU2nVLwIm4gwvjq+ASxASobF8iZFpkR8Fu9RAeBlDld2DVVpgEf7au6kOmFL8Gcsl2hVYiesZtvl14h5rOVxOZsFXi6u4EBRntmMDe084vStBpQ71fUX6vcVLSgxUCQHuNYIdLscpbF49bzgRLJ+AWjYDsEVQt6rmFo92DtpVdimXDjIuQkxn7d+1WxkVDJDkQP8+qTBkAH4VE4Wi35pWJyeWGRSmWfi7cnFL+srMaWwv9fUNjqtyIx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(8936002)(8676002)(5660300002)(26005)(41300700001)(2906002)(83380400001)(31686004)(36756003)(2616005)(558084003)(478600001)(38100700002)(316002)(86362001)(6506007)(53546011)(6486002)(66946007)(66556008)(66476007)(6666004)(31696002)(82960400001)(4326008)(186003)(9686003)(6512007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXd6YnM0V0c3VCszTXJBZzRkeWlCMjhNckhlV0tDSVROOW5XOXJRUUJSTWdr?=
 =?utf-8?B?NGFKaU1ldzR1ck9VWGtpbGUrL1Y5NVIvWWZOckVRSGl1b2h3VnRqRWhJTTlX?=
 =?utf-8?B?THQxUzRMQWgwZ283VGJXN0JvSHpMcXdoYVBqUldSK2ZCekEvTHJ3WFlpUitm?=
 =?utf-8?B?TUh2R3N3blVHOWlwQjlWVkdpVmY4am9yWkRoTjJ3M0N4WFNSS3huUmxhY2t5?=
 =?utf-8?B?TTRCRFNLOCsxdC8vT1hHTDQySU1wNHJQUUhTMm5nL3N4WlhMNnprNG9EVWpr?=
 =?utf-8?B?eEhpOEpaUG9VKzcwRnVCZWRBZzY3TzBNWXRVSWlXRVdsM2JLbFJGM2Q3NDI5?=
 =?utf-8?B?RzB3QXBZd0VMUFlqeG9PUVorL200NHExNFQ2WnlBb2xtSTQxZ0g1Q1RBbDhN?=
 =?utf-8?B?eHVvL2JockQvLzUzUEVtTldiYnlMZ2ZNZnpFTXZ0dXRwZFV3eUhFT0xLaVc5?=
 =?utf-8?B?c2U3MVpLQlBuOThuSjJ3UnFSUE9wK25hSXNGOC8xWWErRFJ0QktIRHZab3NU?=
 =?utf-8?B?UjRFeXNLTk4zdlhMeUN4SHQ0UnI0OTJBM3B4Vk1VUkxvZFpsUk9BMHQxK0lz?=
 =?utf-8?B?RjJMODJqQkNCbStkQTIzVC9wbEdKVGNrRHhtajdXU3RYeFh0ZnNjNG5WVm81?=
 =?utf-8?B?SVBBZFpoMWJxWHRId3NGV2pPZm90eDRlUnBOcExKQmF4dnFuNXZ2Q2hLQ2U0?=
 =?utf-8?B?M2tYNU1STFFzMUZJdE1uYWdRSnduUVE4RGZ3ajkwQVNzME8yeGIzUEhLZ2Zn?=
 =?utf-8?B?SW51MWJId0g0cTc3QTRYdi8xUk5PMFd1dWtTSUR0MWtqQWVYbVM4MTE0enNV?=
 =?utf-8?B?NTMvYTN5MnlZNHllSzFyNURwdTJmeEFMY25Vckkwc1hJQTlDNk9nbW02MEho?=
 =?utf-8?B?cWx1RjJ5UVAyVWJlbkJpSDczVzJDQW9qNkNSeGM4b2JWY1dPbWF6MWY5aE95?=
 =?utf-8?B?Nyt0OXVXYXN3RnY0NE5PM2g1eVFCLzVkWWtPd09QL2tZc0p0NmRDMHVhcHZD?=
 =?utf-8?B?SEF5MUQvUHMzY0QvcHk1bnBXczZ4U0hGaUVUSGRsdXJEL1BhUktyejZBdkJO?=
 =?utf-8?B?ZEFoWFhpdkZSNElIMzJNb0hUMjRXRm9iU00wOTVKbHh0UjM1OU9tR3BQaDRL?=
 =?utf-8?B?S2RCV0NlNS91Sm5zSGpXWjYrb3gxSlNsYm4rNzRrQ3VkRjUyL2d3NHZiL3li?=
 =?utf-8?B?Y0dyMTRUTkhQSjdBVVVkZnVZenZrM1NkZURrZUtjaDZpL01mRmR3Q0k1TjMv?=
 =?utf-8?B?MVMzUXhkdm5DYnliSU9sRldPUm03TGc4ODhjbTdOdk9FdFBpekh0aUhGQUtR?=
 =?utf-8?B?OTI3WUMxZE9OeEhCVWZYSml0ekFTNUVRNURUNFY2elNzd2YvangralB1dGo0?=
 =?utf-8?B?K1M5aGFlb1lvQm1jQmUrd2x1WmV6cWxHOW9ZdVFoUzRIdHZXNU15S1U0alVj?=
 =?utf-8?B?OWg4cVZvbDFjZVVlSStERjZsSC9pM3hlRnlrOHVGcGhBTXIvd1RsZDRITExO?=
 =?utf-8?B?OHBqdnhabGNFblFSN2RLenNHTHNkWk9JNC9aMDVrUFg0bHFpV0tYK0R2S1JJ?=
 =?utf-8?B?dFVmVXdLakpPM3IrT1FpQWUwWkdpUTZDMWVuK1NWM25nWk9MTkFGSVJzNVVo?=
 =?utf-8?B?aWppSno3OWJZMWpNbFpmMzZwZXArMmpMdjZZNnZTNEQ1cFRneTYwbXI4eFA3?=
 =?utf-8?B?L2wvdytVdEkvM3VJOHVuZ0JmK2svTjEzVFRFNFNyQTdReWZ1QXUwZkhhSnR4?=
 =?utf-8?B?dlN5eVZqZzh2THE4elNjUXZYUVNZcmZPT1hJRHdFb3NONWV1Sy8vTFhTK0lu?=
 =?utf-8?B?NGhMV0tkT05jUnc5Q2ZDZUlkQ1JzTmdTTitNMVZkMktjcWd3cUJuV0FWWWdT?=
 =?utf-8?B?YWNzZDBsYW9GNDZBUDBQTEduUENqWVowVytIRHlBM2V6ZktSd2tCYWFDSzF1?=
 =?utf-8?B?NUE5RDcraVhobk85ZFV2R1R6TFJCR2R4ZHE1QmdKTVhGRnVrWE9YQ3ZzM2VF?=
 =?utf-8?B?cHF1ZzE4cFRGMnU3a0txNGYvQzBVTUJuMkNRNDlGYjloTkhUYzlJdmJnNWRS?=
 =?utf-8?B?VmlsVzNSRGZhU2RjMTFxUDUzYU9mK09kQ3BRNG9pY1JpMnM1QVdDVzFXMU9Q?=
 =?utf-8?B?elNiUHNMMncyNXVOUXRuWTFCUENpbDUxUnRRcmMvZXh1Q3pNQjc1ZS9Sc1ZJ?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BX4oT5koiU4h2Zy6KrA8Uj3ov8Mn5f7LF1gghsB/U4gMe0PxmT2fKEKbEX8NQqx8KOCBmTya7+/MZE12jv2zVEab/TxhhIVnyjTja+NU49g7at5db3ml3EkXoY8gX68orICJhPE/XcA/PgiKZ52o9X9Zsfw8sv56xVzvI5tohAdi1qtXdmOg1OmwNALqCC6AjX188+XiYFazYq/n8ennR6/tsHW4Si1KWOiO3kXAdvjCl9UeBSTtf/+5SEKNhJTGgpjy5Ci+lQPN2N3YOQ55kDyDKgmcHvWz2k7vy5O6V0ucMUIockuDsnyBvIcIwlH158ir1SACVYhpGznkauPQ1UBJCOKwo7Qj482WsAKFmy+OsGpFATqWM2g8C2Or+MlxCn38pY7vTdJW3NsdyAfr8MEHV9JzvTQfsqecbd+Kup4kflmFaQOqwgdRiHq9YKlLfpbrxuX+A9GfPgsuX+s0cnXVdksesSZCN2k8C+iEzM1YWES0MNTm8lviQ25ZW1wwaYfJylCEdROeCbD4JTgDVYddsoUC+xVrNgUK9AawxLcioYEp++QLr9BuAcRekKS/p7DynwpH/1gSqGKctv+9wTRC5MMsS9JvHDLpWvFzp3KKTxTKDbj7DB4Syc6hjg07d3f10D+AfT6u6RGsgkHnzmffTkGZwbAZi/1hH5v8PZ6y4kYwqj0m9iQXEiOH/6+6AYTUUCYJf9gPHXOO9Jd409QbEY/it7Euenl9JW4VKRAQjvvhDr841Pj0ef+xrKtxiDGMpqV4NvQBMnQ8OjNOpYHTiwF7mMYoRSXjNHwgrcYfKf40FFY/9y7gHtwEd28q3I1z87LLTMb6eaCSN/BTEV8U47BN9gPoLIS5XvP/rVA=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc07fef-b5d3-4425-a55f-08db934b1f7e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 11:25:06.6658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inK0lsd9XN3UkgDgWx24SrC4xJEAsJ9zdkhcWCUFNzjy/fL0QWTzcKYjonjwzXca2Y3/s1racxxhpxSnohGYrMAZOuq/x+Z5Jd/J1d3Jw3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5756
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2023 11:55 am, Peter Zijlstra wrote:
> Hi,
>
> David was staring at assembly output and noticed a few spurious ENDBR
> instructions.
>

Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
