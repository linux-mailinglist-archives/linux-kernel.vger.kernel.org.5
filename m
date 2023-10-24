Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932BD7D4C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbjJXJ3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbjJXJ3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:29:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25DE1980
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698139719; x=1729675719;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bmi+Mt3uFXFdQNNNW1jd6+/99oq4YRy8jIZkBaLF+7E=;
  b=bpr8Cqi/ZGIk2LthJzsqD2+ALtzYBt57rgwh2JuwC5UhvfAIPUl4LIkr
   mXPkGSPSBRtKf9nzrUXuTP7SYHnE0ucmy1YZb0qSDvExeuCKd3fIaAeYa
   TlCTvFzvd2/RCOXpe+fd8lobSkZE5sFprlO2mKbAn5IIDLyoespYD3fMT
   a8qIXdzsp2+u/ziLr7PeD75A/ssOi8Nvkk4QRj/bUHE9N89lmKXHQGlAC
   eCNLp+Q/xRVK1g4n/erGCGTUdtRknNsvlkxlymwLS+SSsM+mDNbM1WI13
   g2Bv7ziDUD7xMrn2OLFEyJwf052CYVFJvFyheXaZfWAqrkRCCB/0BMBud
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="367247829"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="367247829"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:28:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="875008602"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="875008602"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 02:28:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 02:28:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 02:28:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 02:28:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 02:28:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qifvk5NiRo+YBag9lEekCbygdmMOgPwAi8yG1KJ9A8XuFpbmee59Rnc60PSrFsyo8kk5VkSORzoMKEPHchVVAfp+Z4UrM9+LRETDMiiFnX7pyF3y2YtSLNLCHM48gcvqIQxg2m4AJEzGZZ9sYiCQpA2VvGR2/mmC7AAw5kx6GETtFwkAinin9l4B4KgJlKGBQa4cULJB4PPRUUZ9/v+cgseW4CfGCM6ahwTCOypqEYbIplrPWCAk7l0wA2/3fjT7PCmAD2HnEZCsV9X7LLsz9T2aSFOwXapma1RSJqrsQ6W/5YSktwE98IyRL1pknuOOoaUFofza2OjWzvTkRaJtkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfO959TDqIWlFG8j50vorWa6npsPxhTtk82wd/8d3IY=;
 b=fz8vvMM40vPOxHOQoRdvw5T9j6E+jLeqllAnQH6qGH2RSmgg9012UjZLVgRwQdsSaSCkeBhu0yJEreSDv7bhvUaQhaaqBfnXMBBktPyRm/6tvs2T5wmlnWTBQhl6/kBLL5B6pgmw75bEDaRRBRyyAGr8aesF1JzlowPZ3ycJHSTIyjmJajV70W4iU1NkFl7L4P5nDuRxK3Ob2Cn4phc3Txf/cVqQjTk2sJDimfVhmBlwhTTo7UQrSrWUmnHjp5D7YpvFyjwCSaeExpbIzmcQwFXKxHOLtjkCXi57fJ4LLInT/jwPQsEW7DDe7NXPlPV753GSxFj3UkmSQKs4coI/mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SA2PR11MB5162.namprd11.prod.outlook.com (2603:10b6:806:114::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Tue, 24 Oct
 2023 09:28:35 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a%4]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 09:28:35 +0000
Date:   Tue, 24 Oct 2023 11:28:28 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     James Morse <james.morse@arm.com>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        "D Scott Phillips OS" <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
Subject: Re: [PATCH v6 06/24] x86/resctrl: Access per-rmid structures by index
Message-ID: <p35a7jfcezamdtn7euaqlo7sshgjse4iksa6nbo4rvwubyqazf@6pxfzflz5ucb>
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-7-james.morse@arm.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230914172138.11977-7-james.morse@arm.com>
X-ClientProxiedBy: WA1P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::29) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SA2PR11MB5162:EE_
X-MS-Office365-Filtering-Correlation-Id: b4bcce72-7e1a-4d12-7e3e-08dbd4739895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K0JiGl6gxeHmSBCYTfHJTGpaj/qexut4Tpu+uNPC1oSe6bDZekD9WoJ/o/aXWs/zsRIaaUwZLR+Veh1h1/I8dJcApNR8PiPt/89/xQMZsI0Rc4gFso+980YBjs2H/I1X2tS76NhkRkeMokywWmyQmjrxicFrcuZWWwxcYgevkuQ/vNnRehqGqq7IUDla0geNaGWv4sUD9P3P/ggEBfZZoud2DotshctKbCGy+lKGWZ3XN/d49QSNujAsqtZ1NmRY/eqtUNX9cNfSDMCIptjOaIs6X16p5hn8BLPQ1wBSoitmWP/wlgIrp3WJPQIgbdsDrRXmRHKrEMQBcXIQCl3Sb8CqrK3yRafsmLGjN0jZBfH1qBvXhe/Avs7pGwFH3HNYcu8XYPe0ffAmlcWc9KFz0QmMobqR/IJ3PKHz0JW/o6rXWWjv/3sJBpW/ftirqLd+UH5MGabFh0dk2Tk6emn+TMOjNSIe1FXZDVS0quwHjelRZYTBAH7E7u7WmmcUPfeMc6akLIy5Uk5o6B2iEslSAnN7EP85bA7C+IP9T8Js7mhFiqCfFwkTuVWnNZALihq5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6506007)(9686003)(53546011)(6512007)(38100700002)(86362001)(82960400001)(26005)(7416002)(66574015)(2906002)(6666004)(6486002)(478600001)(41300700001)(8936002)(83380400001)(4326008)(8676002)(5660300002)(33716001)(66556008)(54906003)(66946007)(316002)(6916009)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6MKZd4htTb4G2AlyT4Pr5w/Zk/uZIcpXVGQm2TDbvZ28QMxniXDorKoDOn?=
 =?iso-8859-1?Q?b5WE0SaKzqmW/AsNARuoeLx54Ni6sFH9pLjc4Obd29nzTXBC6sVkTfZPTs?=
 =?iso-8859-1?Q?q4/D8ALp7ilyelwgDqhQ0jvkQeTmBqDr3Skx7yP80InqDhvySWWCHxEEx3?=
 =?iso-8859-1?Q?7Qk7c9DXCNktMwgFskEM3CtgTb5/ydw8Q3lDTyPQNI/nSFANakAqugRNZe?=
 =?iso-8859-1?Q?DtI4VYzPLvKSZU1gRjedFnUDk3UjHjadJ4As1zJKMsAfyLEkxaEOoYjaoU?=
 =?iso-8859-1?Q?ITxg/bp/mPQd7grrvlZUnOcU1lh2BFTKHs2xUe7mZyi/2yyh7za470wKHw?=
 =?iso-8859-1?Q?lZj2ikhjRmpqkQzhI7rexpclBPXPNSYUGGF3gg43jqd/o/54WWC8kBgJC4?=
 =?iso-8859-1?Q?nwroTmJnPFqNVOgspqJBw+Yjzlea0wTrw1NMoFMBC/2tjbRdb1OGjit1EC?=
 =?iso-8859-1?Q?ppJ3OpxJ7UGFPalJuupRfm7pzurhfdu+dk1rniQY8AFO8E17Zgzl8AdUnn?=
 =?iso-8859-1?Q?whCcWaZla6+Z/NiuxvctBtCqN3xenv2WKPNRpl9zx7FEct9dTLDN1sxctK?=
 =?iso-8859-1?Q?87zPrHUG9k6xG8o+a7KgYaBX8AYi4nEvrOSKWwG1o9Vq57Z2B5CMGRFScb?=
 =?iso-8859-1?Q?Js27RV78NmDVNM34VTdEEiUygREtJ73DcpFWcISuLJ2KNm0lpkibrTwnjT?=
 =?iso-8859-1?Q?10mhjBE9sIhBLMEEaGmxNd8zVzsj38HgDw/PeIQ4t2LNTtmOBBMpnCXY/w?=
 =?iso-8859-1?Q?E79AElO7xxsBFFBAyFDTr+cCsEBNG+2AkWefmQMTwpBCv221CRXW7sE5hb?=
 =?iso-8859-1?Q?Z5+syKkBSk09Aok1QiPBqXXShqq+oRZcaHF5TgKQFz2D3bsKE3LWn0ImUs?=
 =?iso-8859-1?Q?yj3i9OhRaKuN7j8GNjiM/cyHkyJsCyVF1PIIXgK7CAKxMWO8fpzeQxg3c9?=
 =?iso-8859-1?Q?Wy1amexTbvLDVD6hvkKf+u/7Qc5at048E4/dP13FPpISnRqAD3Kcgj5Dq+?=
 =?iso-8859-1?Q?2ypzIWWqm0rGHrR3wyz8hd71e+ALxQtPFbWuvV8K+naKgw5CdBUmUy3zpA?=
 =?iso-8859-1?Q?xgiWoERh8SsMjCPxs7RG/63xpMKKeguRUGKNWEjMmoldRa5n1NUW/Hj/xn?=
 =?iso-8859-1?Q?ILRydtOZeZwFhuGT0z6yRvdnJBpNpyOE2c9t+WosI1/scyZHSCJnX+0XLj?=
 =?iso-8859-1?Q?tQySElP2yheDDRHrTVAjb6aYzCxQQjUFHwQHosQ5yjOjzi+YuFc27UgJH+?=
 =?iso-8859-1?Q?cru6OaPjes0yuLTQ8jqqrvFERGI25UmKXlYDIVNHkWXkDjyHADoN2iykQ0?=
 =?iso-8859-1?Q?aaOAOJ4h5s0nnRTfAuRtFuXfcaGOnVakF5uVXeZuWnwrBIk7RzKOsuBQQm?=
 =?iso-8859-1?Q?DNYQrl+4MHp5y8QNMwyQ9u3A1h+tvJl4pEfsByDXQEiwhNvPxClTRJKOX5?=
 =?iso-8859-1?Q?Qvhi63x8HBo1cAO/yMqzJFLmRozq3WAR7JPxzwQC8T6GBsA1xAitBohsPw?=
 =?iso-8859-1?Q?MHh1A52Izp50V+RcAlYHRGuoSZvr/vdzodj9XJ4fWcz6sG2CYQ/FJ08FgP?=
 =?iso-8859-1?Q?sdPYwp+0Zus5IUPyS+f310ptssHyFh19lg4o7ogqwPKGNmezxqCATG3Y1S?=
 =?iso-8859-1?Q?Qjg0ABJoX/J5TGghXJjZHvTlL+5uTFyGYjpc1mB9yycrZCPXxgcg5U+0+x?=
 =?iso-8859-1?Q?spmTk0cGKW/YP0rJwOM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4bcce72-7e1a-4d12-7e3e-08dbd4739895
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 09:28:35.2197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwxgddNRO8Vklecefk2liXpsj2E/TkuVAwIlykwKgdPNwYIMEHBE6LFV5v1iik/2OejFJvCs5i4l6agdp+GrlUt4VlHYK39AeiWK3Ratjr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5162
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-14 at 17:21:20 +0000, James Morse wrote:
>diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>index 42b9a694fe2f..be0b7cb6e1f5 100644
>--- a/arch/x86/kernel/cpu/resctrl/monitor.c
>+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>@@ -150,12 +150,29 @@ static inline u64 get_corrected_mbm_count(u32 rmid, unsigned long val)
> 	return val;
> }
> 
>-static inline struct rmid_entry *__rmid_entry(u32 closid, u32 rmid)
>+/*
>+ * x86 and arm64 differ in their handling of monitoring.
>+ * x86's RMID are an independent number, there is only one source of traffic

"are an independent number" -> "is an independent number"
or
"are an independent number" -> "are independent numbers"?

>+ * with an RMID value of '1'.
>+ * arm64's PMG extend the PARTID/CLOSID space, there are multiple sources of

"extend" -> "extends"?

>+ * traffic with a PMG value of '1', one for each CLOSID, meaning the RMID
>+ * value is no longer unique.
>+ * To account for this, resctrl uses an index. On x86 this is just the RMID,
>+ * on arm64 it encodes the CLOSID and RMID. This gives a unique number.
>+ *
>+ * The domain's rmid_busy_llc and rmid_ptrs[] are sized by index. The arch code
>+ * must accept an attempt to read every index.
>+ */
>+static inline struct rmid_entry *__rmid_entry(u32 idx)
> {
> 	struct rmid_entry *entry;

-- 
Kind regards
Maciej Wieczór-Retman
