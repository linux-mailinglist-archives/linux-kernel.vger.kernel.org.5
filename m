Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3F0812D2B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443696AbjLNKiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443641AbjLNKiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:38:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2CDBD;
        Thu, 14 Dec 2023 02:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702550304; x=1734086304;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7c5HRQ7p7rUQq5773tY1I2FoClyIopr+txUkw392o24=;
  b=kNjxxrErRmVPqiJKpWPZozw21h5oA0VqbLPK++eBaB7sY/RIuDnuwYth
   3Z9buktEfx+q4p148nXCQnVaMTDrPyVllxfkxz28T1LXhrg5FLdQHH+sH
   LshPxJ1izdeLwl4ptCjikBOwgns/fhDUOxg38j8pLADKX+5WtQRYy1m7C
   I/jnGoxBvx7a2izno69fced9gQ824EgTuFPZifzYz3morW+/DhvORk4sj
   D1doCYo3y/7M1xfSu3qr/09rhsjieKyYSdtAUzPGmUDoVnH12sgb/djzY
   Eo4STbFcc2tUiajdpuV/JbKcAAt1fd6bzWMOMZNzZ16P57n1kmkDeqzyk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1920361"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="1920361"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 02:38:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="844659550"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="844659550"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 02:38:11 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 02:38:11 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 02:38:11 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 02:38:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJewVmpGQMUFocBNp+TXWDK+1uv5t95iZ8D8tGFVMI+B8rmvD+/C0uEoQtkO3pITDkG9A3jqBCy1AkiLb1c5Y5oUz7sdjwSxFbSU99095XnTr2dy+rZ9Awl9F9XYu0P0rwWRsaX5Iklb/P1cI/zAyrVZfxcMJ1O4DSI5fZhBh8LOOvwYcTsRzZPJ83E/SQYnc04hacSZ2bh54AXztvxsJEsEAQFPcnaAkHVBAwBiHgynSlCzcf/5z9JmnKysNYOPvC0oaXxTX/aQyeK+cAyB+lTXhHyknoonEge5wEcEBYVPxnMTYyqsA8Q+5sI9DzXRnphSIdF4qwh7J0d3S2N6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7c5HRQ7p7rUQq5773tY1I2FoClyIopr+txUkw392o24=;
 b=DjseNiJgc/VXPDWPMMgvSCWloo2ca9bwX40u+pM8qlSGEzwT8nSInYEwSJT2AtRu9TRZ875SNwQTKewIpuCKOK1o7CbO4TUHSGExiPm6av7lCuWIOBYVS5OHS5VUZpuMwB4mXHv9mCuQAoN78MssbPu3ipbjnKRdRO4o75xnnuBblea8bfPOypvKjdM63EP5L12EfuSFQGXtjVreU+0w14AttbRpiMk5xhSRJI9rbvYadpqSNiZQJisSpjsdMeKVmiFsMjYexM8UgR76/uuKT64iM2cfAcAwZHzhDKE7AoZNhLfk5YZk4dAWJxFFq0NRFbG+sNtL0XUZNko9T5KmgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CO1PR11MB4850.namprd11.prod.outlook.com (2603:10b6:303:9c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.29; Thu, 14 Dec
 2023 10:38:04 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::4ef8:c112:a0b4:90f2]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::4ef8:c112:a0b4:90f2%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 10:38:03 +0000
Message-ID: <2cd811ab-30ac-4f68-b519-00743b64d343@intel.com>
Date:   Thu, 14 Dec 2023 11:36:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 00/12] net: intel: start The Great Code Dedup
 + Page Pool for iavf
Content-Language: en-US
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        "Jesper Dangaard Brouer" <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>, <netdev@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <20231213112835.2262651-1-aleksander.lobakin@intel.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20231213112835.2262651-1-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::7) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CO1PR11MB4850:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f15596-16ae-4ce5-93ed-08dbfc90c034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bCm9hCv+tK30ndForeiCf1PJMbSDlqY/nd4Xw2VmzJJY6DG5MuzJqkVcFWFC4yZ84XtQorIm/AdewR8UQkTccMnSqnDe9OrQ0EktAcjnBJpfDY3ZA5ee9rRt2l512JNkNEWXxoYs40YOM/Vz8ktUI8goZ0SqdQ39P0BaA49Fy0WONAuXc0aYsOqtpIOXJiITCZUakEAVEXa82VZLPTo2dm01W0np/nqv07IFyBxmryytpKzvyVX5eR+ZAkC1Z6/d4QCdGgSl9vq38eP0H7RvtIjKNir4E6L84z8F7Tc3wmUUzhpKxJMc+IGib+WVvjg+I0v5DAUsyv9hXecP2MFKF9WuoMrNWwAuNV5ITAvFaG4RdtQm/DJT+QfFWs7NbCtY3zliFpOzTffWzad2c0kZoAQTOJzwf+Rt77CaTM9nkvATZQ1afvYlGKxkzZeU4SqPxVa+ZszM0dZTOIvw6ueBS9YZgV2kHp9EJdD4XxJB9ZzZG947H5n+coA/7AQE5DUwg2R+xdNATplixFNY1EXbluY/EDnFZHxlu2NqZoe1HzHhDN4zftDPx60GLTQ5FCZd1p5YQpEBaexepF5bpJ0t0r3iDpcr9KEOIyv6zOxWkDi11SbMIHR6ypv21lFHkyc6xu++2XEFbK3Bl5rqsmMK4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(2616005)(26005)(6666004)(6512007)(6506007)(82960400001)(86362001)(36756003)(31696002)(38100700002)(5660300002)(8936002)(8676002)(7416002)(4326008)(83380400001)(66476007)(54906003)(66556008)(110136005)(66946007)(41300700001)(4744005)(2906002)(316002)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2F3bExHbjFjSVpmSk9Xc1U3RjZEV1kvZ3RacWZFTGxBYkZsK2Zha2NVeVdq?=
 =?utf-8?B?ZkZ2SlppeWdnL1FFTFpGWVlhUzVoTm1lK1R4YUp0ZGMzRG5oUkZEeG1QQWQ2?=
 =?utf-8?B?VUsreE5yc0Uxd3JVeU9LYjJkL2QvazVCZjZ2Qlo1Nk93TFhBR0tLemNlMFVu?=
 =?utf-8?B?dEZ6SGhLT1dBcmdMT2lFMVYvbFQvVmU3azY4Qnpxa2FsLzUwR1g5SStsN3Fu?=
 =?utf-8?B?b0sraUZoenpXZFd0dThUSW1UQ1YrRWd1ZUFzK2tIYldKSzFobWp1cTdYQWtQ?=
 =?utf-8?B?ZUV6OU5YdG9kaFhHUzlYd3MxWngxQ1lJZjNPWE1nbDk1aVR0U09TSGMrekNG?=
 =?utf-8?B?RFhhMkEycnA3M1BuNVgxbjRNeDliMmlDNzhuK1E2TUFHSDhvWDBDaTh5SENT?=
 =?utf-8?B?OWJVKzVmOGxkcG93MVFVQXV6RGU0TmdZaHBrc0xQM092STdWTEt6Ulkvd1RP?=
 =?utf-8?B?YVdkcFZWRHVRVUhVYW5rdW9kWnBhanpKUXBDcUljOXFyeFVOMWxJQlM1OTBR?=
 =?utf-8?B?VW94Lzdja3d0TGZRQ0ZYOEF5Q1FkbXk0cEZQaEZ3dHROL3RrL1gvbXpGbk5L?=
 =?utf-8?B?N0RaS3NnYjladis5WDZOK0RYWHVvVUhqazJmOXdKeTZxV1FtSWdWMVdBNjNJ?=
 =?utf-8?B?NGtsU2RsVzBidmVpOG5ReXNLbTAwTmdSeEI1WTdqVThRcFJFQk9lTGlXOUhr?=
 =?utf-8?B?UUxZV1p5SXZsUnpEZ1pNa1VXRURnUlZ6SGpvV1RPaHZSU21Pc0JaVFJkMXIv?=
 =?utf-8?B?RTZYZ2ZHQXhncURndnV0S1hzSjlvbFAyL2FIZFNCOUtJdGEyRGVaQU9Pemlm?=
 =?utf-8?B?S3VXdDA1RWpOS0laam0rb1c4c1plKzdNMHpMaisxK244NE1ucjZHcWw2ZVVw?=
 =?utf-8?B?aW5yZXhqK1gvVTVqMUtoQ1Z6QWRyM1R1V3JHMFZMQm9wbDFNN2pxNU5wMDNC?=
 =?utf-8?B?K1RGVC9FVFY4SDVDNnUraVlrSHJjc1Z2NDNmTExzRERFSUdES0d2RkI0VU1O?=
 =?utf-8?B?bVFVNmVMRGVHV08xY1VHK1NDdVFlU1hkYk0vL1dzdjhGVnlMUGJDbG9VTkhD?=
 =?utf-8?B?Qzl2MTVKZ2pCemxpWWd2ek9zQkVxNEROSmc1eTREdFpzaG9RSWlUcEdJZUky?=
 =?utf-8?B?aHI2aDRtZ1Q3YnJzOUVjQ1dMc1IzZDc2b1J2QS9JaTFGR3FuN25taFpkaG9H?=
 =?utf-8?B?N21JR2ZEbXQ2Q01uVUVyM0g5cDUvYmd1NDB6OTN2WTNyQjRwa1MxQ012ZURw?=
 =?utf-8?B?dUhKdUNNbWU5YlhFZDlrUVNGVS9UZUtUbC9GU3pTaU5NcFRkVXRwSlZFM3Jn?=
 =?utf-8?B?VnJwbDBoWjkxY0hmU21xNitqUk9FMGkwQW1mRXJCS3hwMmZGWm9SRXFybXZu?=
 =?utf-8?B?UWU1UzlzQmJsZWRQWmZ6bzVxMW9GN0ZTVVl0WXMzRGhnSzVUVS9Wc0JydVRx?=
 =?utf-8?B?L3VWVVZoY25mSHJVNDkybW0xYUdOSHNVMkdMck9KYVJ4NU5rbnM4aVJNUm9u?=
 =?utf-8?B?dlFhSGd0SG9nSnR5UkNGYUhKV0RWVzhGckRCdmZnck5jdXhKSlZCY1NBOE8z?=
 =?utf-8?B?SmxPS3pBQWR3M2N5TGMzNm56bkYzenl2dnpweUFvSGFKZ0Q5aFU4THA4VFZJ?=
 =?utf-8?B?YlJBdmpZYjhoWDREaXN1RHZCVXFLdlBQNjUyMGhmRk9pSlZYZWZJZVZqNnY0?=
 =?utf-8?B?Yks3bTF0UThSVjE5M3VaS1MxSnNFYWRXeVhWZkw1M2U5Tk11cU1QYVBpTStt?=
 =?utf-8?B?cEtuU1huZVVuVnhSZWlhekl0cFhoUlA1SmNaemFFTkZUazV6cC9OZ1VaTmxv?=
 =?utf-8?B?NGt4SFB1QVlkSURGeTdHSmRjNDVnaU9OMnJaVVNDQ01VL04wTlU1UG56K3R3?=
 =?utf-8?B?eFpPTTQ2dUIyNFp4bVdaR2JGdmNjbGphaHBvcnhyM2FLRVdCdHI3VENBM0xE?=
 =?utf-8?B?MkhnNFlWcm9oc0tVYzZDdXlxZ0dkMjVzSWVYRzBXQVRFaC9qTG84TGFiYWMz?=
 =?utf-8?B?c2V0YUh5cUdGVHQ2czNGSjd6bTVGK2NwaENZOGFlZDdmTWQ1QnhVb2YxdmhK?=
 =?utf-8?B?WHE2M2Y0VzBCWWlRRTV2U1E5Ymo1YlRiYXhmREdkSUFFcFdxTVZ5cG1uZ09Q?=
 =?utf-8?B?Q0ZuWmlXc3lvWXpNODM4ck1mdDg0UDFmNXJaZ1hVNWNNQU1YR0hQMDVhVElW?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f15596-16ae-4ce5-93ed-08dbfc90c034
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 10:38:03.5864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNjQCChiY8g/m8nO9zCiDgMZyoHV4H1gdOI7KZpPmbyVqouKUZoP18Or03lmgeX/wIt1RJ5DvKahf9YeN9mOIYI0Tpllmk0HN273RuS6SkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4850
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Wed, 13 Dec 2023 12:28:23 +0100

> Here's a two-shot: introduce Intel Ethernet common library (libie) and
> switch iavf to Page Pool. Details are in the commit messages; here's
> a summary:
Now conflicts with bpf-next =\

I'll send a new one soon, hopefully bpf-next will be pulled to net-next
meantime?

Thanks,
Olek
