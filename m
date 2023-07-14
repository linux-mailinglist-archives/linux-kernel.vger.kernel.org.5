Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E61754046
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbjGNRQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGNRQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:16:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56B91BF3;
        Fri, 14 Jul 2023 10:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689354968; x=1720890968;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mb+b8vPpxlFf3JTjbZEZ3ovdXeXl0TXEeyiSdBZbhVA=;
  b=lQkWjmZuFB2jRsYY/+/2NwEJ9MCIWaoj3KIO3tjkpcgHixb7M0FDU/0t
   AjYk6RXZR+MtopTufNVdfS8cu4HcW88vm1YsWYaPbTQA2Q1YtrPRkiJJE
   BBQVjoA9ERP4B/uKw7exazQt3PjZ27Std+hVZ/y/e2hkwglJM3ShKMrjJ
   75fkEnfcfnzChN1jlgZa/+GWhH0ySxRkKURejJ5DMGg9iLsx3Y3/0BUOE
   JRzjoRRfbLRJmBEalu8/EeFwcyzzo5k4f122KBIvqf1EPO+Oo9++ZZc3S
   5J6CnL3lBg9SZKC81ksAo3fTbLYcgGh+Q7UtE2Ihq8y2twNaqdDqe2sNj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="355465614"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="355465614"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 10:15:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="672777403"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="672777403"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 14 Jul 2023 10:15:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 10:15:47 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 10:15:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 14 Jul 2023 10:15:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 14 Jul 2023 10:15:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etNKgS+VOKN/bQPrx8SW6ctxsem6gG4CpXjN01ew4LuiIA26ZfCWxFwwXaPJ8RWHoLAfzfcbmpydWXe1S59S5OLlsfNmQ0U8IFtU7keoDd7gC2alYA1yv1FzTbRRcR4EZJ0v6p/+dAP6pa9yexf1iimKuLjR0TAew+q/NhL6Bxl3sI7M4q4eTBqAE+CMsRznDKGJ9ZYTAxks0UxdzXx4cgSzGYndNgq7i3S6SN2Ybfhtd8hQNb1xMfG5lmHkAZ1IszuEVFzPxzXXuInGiWGcXRSFFrmTksbIiH5djqWaxfZl97GIedsRrVafL43MzX+mDQSxeupb2Or/YCcVfBud+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mb+b8vPpxlFf3JTjbZEZ3ovdXeXl0TXEeyiSdBZbhVA=;
 b=O31yr4z2vXbWx/3KHdLMT75T9+yl+bBOas94kU9v7eeJYtDET4inCHoZVbBSjawsD7W40+Y52X1SEQCeiLqjTeZT26s6Zl6X9hctjGM+obgXK+scwWfeyv+l3YGVfR7kvJfrri86s0rO8nefULg2KeLUprOzpzngRBSa4+4BVsDH0ccAU7xBsbWiwLLbq0ymdJK9fjSSb9RcMgUegEe93FDLPO2QjFw3wd6tWY1LAlECEGplZJAM8AS1GmHBbrVDVZoDcMEkT0pHsTxklujEthYnnVeNhq25lDTs9903hljNavSnWIdoNiDGlLqyjs/WIM2PxeaHJtkYZtvrZzjZNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by MN0PR11MB6136.namprd11.prod.outlook.com (2603:10b6:208:3c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 17:15:45 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130%5]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 17:15:44 +0000
Message-ID: <95834174-35c1-bec8-eaef-39518dc8a919@intel.com>
Date:   Fri, 14 Jul 2023 19:14:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC net-next v2 2/7] net: page_pool: place frag_* fields
 in one cacheline
To:     "David S. Miller" <davem@davemloft.net>
CC:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230714170853.866018-1-aleksander.lobakin@intel.com>
 <20230714170853.866018-3-aleksander.lobakin@intel.com>
Content-Language: en-US
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230714170853.866018-3-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::17) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|MN0PR11MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bcfca6d-419b-4655-53c5-08db848df549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DnxwICs4cdnIPcjLUjPCR3KWPV58KTiseKsU8Smb9QV+pSRAwp36lDazV83N9xmX+9Z+PNIV1bEw2vIgwC8xvgsbGaX7ZRQRlkR62YLNAU8ztiU3xcIaG040OQozgZ1vsRHaRI2xi2cmXDLwfo42Qy4zMQokxUMRP06pPqu0ikNNTbQAnJbL0od5jX9uvS1ksRqZP35+q0pkwLwKGGZxVijvJAWIwZx60VjNhOo+jY/RbgcIHte+PekGCCpOuohrxzLO1p3QZwUpJh8KfdY9q9h/RYd0OOCfGtb0CdxYffPAxZ2v1QQ28GXb15bRzkiEJATwVJ4F80aTT/EgBqVlZu4lGvXfatO1XYCoZ4SgYJAFl5lmLGXDCsRxZJD5ZXlUyP9WSFgWTxTUYvFVFR762SSAuTj4DZGSuPpjfafiFjllJu1KQpp7eRubno6uasANP8DPs+HHryZcKgMo/ixr8YoGKkaqIDfgANFDqrQc+1aXjS8Inwy90Vb84uSdCsR/IF51WcwzZuwkOM9H13+ZSj1/5mNMSuk6smHlCrV7rkUQ+OvaKHSENLwXZ+LrR7mF7iomY3fMwxf1kclQM7cnsGl2QrU8quvTltiJFF+BGHj0eT2AmWKwLyvEIPYJWXK12BgIeNu74Oxd28JPbayKzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199021)(31686004)(6486002)(478600001)(54906003)(6666004)(2616005)(83380400001)(86362001)(31696002)(36756003)(4744005)(2906002)(26005)(186003)(6506007)(6512007)(38100700002)(82960400001)(4326008)(6916009)(66946007)(66556008)(41300700001)(66476007)(8936002)(8676002)(316002)(5660300002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG5ZR1Y2Nmc4bWdXQUVmbFBPbnBBL0c3TlhIRnR1UmNEUWFXMTJZZ28zb3Iw?=
 =?utf-8?B?eDRZQW9Id0tvV0F1UFYyNGdHUU03Tm5KVTRKN3liQnltR0pBaDVMMDczTWc1?=
 =?utf-8?B?OVZqR3k3Q3hwWTJQeS8rMWsrRHJ3ajJEdjM1MStNS3BHakROYXBZd3lKaGtH?=
 =?utf-8?B?VFNjVEhsZlJISFlnTmFuZjI5VDVIZEhXZW4yMnJEWDRFQ3U5THNOVVM1dHVV?=
 =?utf-8?B?RUFPSVo1TmI5eTFvbkJaYkF0bFZrVnlsK1lJSFJ0S2RYdmh2YjNMUjJwSzlU?=
 =?utf-8?B?WXJQRVR6dG1ueE1YeXdkeFJpeHNpbUN1OGhzN0FRdmtQN3hWY2ZNSXQ2bU9Y?=
 =?utf-8?B?RHRjeEdTck1ySE80RzRZbWs5WGEvbHpQQzNLc002YXk0NlVnSDdaNkVTSHBF?=
 =?utf-8?B?OFpBQ1N1eGwvSlhVOEJNV0xjSlA5UnVrU3h4MEl1WTFvcldtV0tDU1U0clVp?=
 =?utf-8?B?dnNoMmw5TEVxeEtIbFg2eFVBdmpMaGNNUEh1ZzM3OTJ2VEdNMUZQYmJ5K3l5?=
 =?utf-8?B?RDh0S3NEZFdEandyeDlncm1EeVM3UlUwTDFzbHQzOWdtZWhHUEx6czB5U21u?=
 =?utf-8?B?NVcwRlZ1aEE2KzQ2SFh1NVlYdGo1VUhRL3EwdWE5K2NVb1BkVjdpTWNCbjk5?=
 =?utf-8?B?YVgwT25pRDBRdnAwdlNNL2tOSkgyY1NZVnd1aDRXNHNBKzdYajV5Uk1lNEVy?=
 =?utf-8?B?SkwzVE54bGpCTFFCMkpRY2xLdjBqMnV1WTgzVnNFRDljanJCYnhJME1la2E3?=
 =?utf-8?B?blFxd1Q3R1Z0SVZLYWNYVnAwVnlpbkJaa0xsR3QyRUtoeTc2OXpqSlpNREs5?=
 =?utf-8?B?cXdQS0czMklqOG5xMkZjSFJwMHh5NlJlREdDbitDQUhsUnZCV0YzRXBjTXNI?=
 =?utf-8?B?OXUvNXE2cm8xYmlBU3NLbm14UzVKendzRFNnRk1qN0ZwV09Ya3hCejVSemph?=
 =?utf-8?B?TEUyRWJ3d2wxekcwWFk5MWZuVFZ2TTdqbktobkRkTU4rUXp6QmFKNGFmWS85?=
 =?utf-8?B?QnJBc1VZTGM5bVlGZ0RqdWtqUC9vRlZ6VG1SZHRjR0dqUzRIZTBURGorK3NI?=
 =?utf-8?B?NU9yd25aVThQR0ViOWFQMTNZWDJjSUY5QkRLRjhGSHVndU5WZ2I4VFlVMkpi?=
 =?utf-8?B?WmRNRWlBVXcrMnJXZHdVT056MUFBMDhDdFhXZ3NDRm9NWUpnV3hJN3UrVHY3?=
 =?utf-8?B?MVQ0K3cyV0dKbWlLUlN4YkduK2hLNXllam10SkRuR3poaXJpUDhtS2p4U01w?=
 =?utf-8?B?SXVDK1RycUkxbXRwcnNkL0NjUFRlQlFnRlF4c09YQ0xqNy8xOU1OR2xxRStU?=
 =?utf-8?B?UDQ0STBtQ2pPdmRSRkRiSnJ5R1NpcFZTTU1CVExrTEZJS0NleE9QK2RSLzZB?=
 =?utf-8?B?by9ZdkZtT0JUeVhwRlNubm56a2txTmhPQXZrNGk2SnZ6M2dWTktxOVlrRDdI?=
 =?utf-8?B?OEE5dEg4TlBLMVoybzNUaXlZUnB3aEM0WFZ1OFIwRENPZjI3bW9INGRQRS8z?=
 =?utf-8?B?V3A5eVFnZGdvamJWb1l2TkJzMW9kWUdJL3luVkdqV3Q3aG9DdjFUTXZENDRx?=
 =?utf-8?B?RDF0ZVN6VjM0N3FUQjVwQ0Y5TDBwbmdqSjh3SzZWTkNtMHJNS0NsS2hlRytK?=
 =?utf-8?B?d0VxOWRyM0tUKzcwcFQvU3Jqc25qZTdMWCtWY28vYkVyREdtZEdNd0ZVL3Ji?=
 =?utf-8?B?eWlObSs4YjV0dHpDTW9WVHVtakxmVXZEZmV1aTArU2NKSS95WUlObmVabmw5?=
 =?utf-8?B?M0FXTjhXaWFUcXFrbHpGYmtDN0dhY1N6cm5RMlBOOHcrWk1ZSVhQaHVPcVg1?=
 =?utf-8?B?eGJZOVg1SEtHZ0RhNklyZnBIRHdSRFVqVWRYajFVTXdDWVM5VFRPbkxYNDJs?=
 =?utf-8?B?bnNtU01zZzhmNXpaTk9NbGxGa3l6QTNUSGNhajJkUDc2WUdSZXFaRE9pWUZ4?=
 =?utf-8?B?OXhzRG1oakZxdURUZ3lrN2l2LzJQb2RJb1RmRXhoMEtSK04zclJHeGxvSWpS?=
 =?utf-8?B?aHVVTWxBMzNTTHJCVGFrUHBWQStFQnB0RW41VXVEbDN4UC81SERyVnFzQ09Q?=
 =?utf-8?B?Q291eWRXQ2g2aWtQMXd0cTBCZlNEd1ZEZ3VvUU5rVGUzQk9FOVVTUktmdXdt?=
 =?utf-8?B?Rk5qc1NxeFFDMnRXYVJ1aFpRMWt6RC9XcThsOXNQY0M5REJqVGNrd0ZBZnlw?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bcfca6d-419b-4655-53c5-08db848df549
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 17:15:44.7869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esIdbyJ0N1lnC80omz/gQXOqDo4JNJcLoBQkVETjnV5XmRLof+zh+QEgklQN4P9h5azGRQ0cMMXa68s/mtsgjPDUSj/6n76x2FdtrZYpvDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6136
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Fri, 14 Jul 2023 19:08:45 +0200

> On x86_64, frag_* fields of struct page_pool are scattered across two
> cachelines despite the summary size of 24 bytes. The last field,
> ::frag_users, is pushed out to the next one, sharing it with
> ::alloc_stats.
There are two copies now of #2 and #3 as I reordered them and forgot to
remove obsolete files ._. It's an RFC anyway, so please just ignore the
duplicates. Sorry.

[...]

Thanks,
Olek
