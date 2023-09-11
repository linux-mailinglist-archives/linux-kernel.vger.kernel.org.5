Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF0279A436
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjIKHNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbjIKHNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:13:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F9AE47
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694416369; x=1725952369;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=hcgE4JUGvacvxdy8cNZjqrTjfaM3Jxa8S+BC98wbNtw=;
  b=F09riTPnnZbV2rWZJ+VNRIZ3jaFB59hKTYz53j1Yi8P1nmd61/bRVzJD
   aoHMpkxlAlVccTBD0VPGtCc/plDLmXTL//3tnJ3KkvPwQdWaqUyfjaUZ/
   l3U2Fc409zKpbFPhrpE76e7DOan8aJ8FAIUmwiEhWc/mS/jKuXtovlUPL
   Qq4aksM1sw2lYJ5ULobwzRiZG0m6yDS+H3LMv/ZHtM6gF+GVwlus2G8/q
   82O5aj+RZLRtA6MsVlJv1pnrtxYSYMtee5Gwfg43j93DZGKGmO1aeR8xC
   0a5Jvf8ERlN1cfDKuWPaTQ2yCV6y5k1wt0vD1/i+VZWrxnq0asEBXFUFv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="408981174"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="408981174"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 00:12:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="866816011"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="866816011"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 00:12:45 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 00:12:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 00:12:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 00:12:44 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 00:12:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/hR4DpRewz1OPp6/dR+Tes1OTjKB5fMUqwYp06xpxthcW1BKrZRrCvy4U3eesM4nmFKn8I/V7bDfj63z0k7VBtSKt2a2nlTdSo2nWBmR5uOQdintpe1v3e9WcdRKCTscaw2PCOqFa61033EFndzRY+6DA4lPeYAaH3MqLICcHXEsnlJ8TkvG1TncWiIXnj4RWiSdVwe2r4XHBGD9kFsCXMqk21Y3xEyKvZHora7vo8uAI0J8uM5KJr2CwY4YfK4cggJgqCBWqWeJz/JpJbUv+Suy6s6H+IvjuCo0kLloZk5C15Cd2k7atq1xi6rLnfAEE70/A5zoSqTXFhChpbZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l48vNs6SZdNKPjdoyO0pQiL16zKhM5bp1BPtY1rbgp0=;
 b=BCZt3VsvVqfPOuz4pJvMd3s4D3c4sGhj+d1IvG/JgbpR3/3FmWipFGv2Wi9rtV8bGNDZVEKos0IHxhJjZ9OiQOO3wMkc8WimTmh9xBUh8kvE2e//yAnRwP8pmhIfemZhr2LXmDrDS4e0ruAvV+agdJV8tgtQiyGDkC2svM2Nq1sTzvKbgfG1RMWHEVhBLVMYiOYfNUlna0X2ZxsV+z3Q4UXfaHio0C7X4KMUyUTENhLFJVYoFBoooZw6iYwzdD/MIQ0NrXlLn3KCup2Ni2QAmLuB1WLxPkIdw8ydDGmgb7XpJXrcdTFWuclh8VN4vL1A0a1a4z+22/ALeumsdSuhmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CH0PR11MB5298.namprd11.prod.outlook.com (2603:10b6:610:bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 07:12:42 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6%4]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 07:12:42 +0000
Message-ID: <0465d13d-83b6-163d-438d-065d03e9ba76@intel.com>
Date:   Mon, 11 Sep 2023 15:12:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [syzbot] [mm?] BUG: Bad page map (7)
Content-Language: en-US
To:     syzbot <syzbot+55cc72f8cc3a549119df@syzkaller.appspotmail.com>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <syzkaller-bugs@googlegroups.com>,
        <willy@infradead.org>
References: <000000000000d099fa0604f03351@google.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <000000000000d099fa0604f03351@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CH0PR11MB5298:EE_
X-MS-Office365-Filtering-Correlation-Id: c06de69a-b3e2-49db-349c-08dbb2967d6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oofcDYplx4Aii037D4CrHVvTf+95HMsWcu6lvljJiQbLT1rxEs6+UKJmM6jKe0nV5PLRZfY6h9OhiNl5iaihozS1xtXP7W91sfCGs6KGtDAtUm8DxcYgDzIHZ/yH108dmtiDtfR/kTVXeox/h0Uv2ldqK5TPBWRIxLF/FDZqh7+GV6PU8lU2QEU4tlGVmDBFBv0u+Zaj0LQQj93XFUnlbznGnvbhBRf64OpiNkKmhSHWPp19zZcJMy3K/YHDIOamhl58WOA6XhZbpgWmQgVW3lkPB+mxL8ySDP2w8qCr928VEDr1OS2L1PrtSDJdPCpa+LEHW9xLGrS0j+gnrVhqihRJV8LKk/RM6DftkelxEungOR5YQbpB4/nctffh2ql4UyRcQ9Nf3GzlLcXa/sskgaRTHlZq9bW3fsztP68aO6oOOCAtOnuNM2+yNB9645tJQ2pRhBKK9iTK4KGAm1yAncArX2WP/7c+QKsZxTVm3GouzErTiysxDuMgxGqI9X6P6ZNBrLCyOlgd4zPKy27+br1qQ5/RAGBlfO08nSEKUmJrCPOCh2B2w05ODf83tXahmanq++HJYEGEvQRp/Zo4kNocGQJyu/ccHhWoyg63bGpEOPKe+Mr9MpYXp8lecjlBCk0EMyhM2nWa04UvbTwaQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(136003)(346002)(396003)(1800799009)(451199024)(186009)(6506007)(53546011)(6666004)(6486002)(478600001)(6512007)(41300700001)(2906002)(2616005)(26005)(66476007)(66556008)(66946007)(316002)(8936002)(8676002)(5660300002)(82960400001)(31696002)(86362001)(36756003)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uy9mNHc5OFRpNXhiM3BXVW1SWktCakovTzM2VE9GMjgrRFkzS2ZyakJndnph?=
 =?utf-8?B?T1FCNFFjdm5wMTdKYnJ1dGYrRW1TaktYMzFrR1N2SlIyay9TMDdrTWJJQVN0?=
 =?utf-8?B?a1piNFh6cURaVHhHaVF5dDFSK250cFlmOVZSZlJkckkwVVMwak9tQWlVd2dz?=
 =?utf-8?B?UlRoOXBock82Mzk0OFAxVnJGRzFTYUpobG5hMVAvRnJEc1FnUldERHlkRVpV?=
 =?utf-8?B?bUxOYWFTUzRBcy9ZSjhLbWw4NWJHbTMyRXVXQ3EvM3N3bisvTzU3eVhKSERt?=
 =?utf-8?B?SE9YUG5Qck81TjlaN2wxZWVlVmJGWWZ6R1ZEZFA0QkhpTkxqakdYSGhNUjE1?=
 =?utf-8?B?OVZwYnVsQ2VUNnZWQThaeXl0QjVHMmJuVHNhdFEwV0dDNzhkenJHOE15VVBj?=
 =?utf-8?B?NkVxcjlmZFFOUHFMZU5hb3pBaDVMMFRiSUtqMUhKZ0ZmcGU1Rm83eXgxVnJ5?=
 =?utf-8?B?VTFudHNLcWJUeFFocTFGTEJxdEkzQTVORS9OSUkxckg1WjhHTkZYaWpLTWRu?=
 =?utf-8?B?NXJLQllNanUwN0tISEJGZkl4cXBMSDJtcWl6QStDUmlOTWo3dHNBSVBYM0lD?=
 =?utf-8?B?WitVKzBKR3pSVDd3L2REaHVXcldGK3lWaHdnQ1RHVTJwVXl3aTdyMXJieDJQ?=
 =?utf-8?B?ZTZFZU9nSVpwYXNHVVJDKzFYYUYxYWcwcE1XejVxS2I4aEhvckExQkZHT1di?=
 =?utf-8?B?NUNUdlhZRDNwWWsyMWNQV2tMazl4cTkvK00ySXU1R0ptOG01WG95WXlVQzBu?=
 =?utf-8?B?SXZDRUt6UHA4Qm9DdHg2czQwNjFWVFdpQ1YzeFdBb1BTTkJnemhlaVg4cmRO?=
 =?utf-8?B?MzRTYU1iWCtsd1FQMnlaR0Zoc1N1RWRVZ0NPbzYrVmM0bGVOSFN2R2pLanFN?=
 =?utf-8?B?RWRRaklJRVh3S1oyZVFpd2k3eWtmZXRNa1hPelZRTmFaSDV2SlBoVFRUV2lY?=
 =?utf-8?B?ZXRnMHFCSGNacjVqcE1qeDdjaU1DSERFaWppYzh3MUQ5d1hhbS9YU2RFZ0VW?=
 =?utf-8?B?N3Q5NUZjSU9xdU1yQXZBNEsrSHlHRWNKRVFHb1hYcWh4dmNlZFBLalJsM003?=
 =?utf-8?B?eXl5QjR5Nk5PcStPbnIwNkVhYUozKzFZRnpEUm9IaFZjTFE2NEZpa01icjcx?=
 =?utf-8?B?b21WQVlZazI3a1VZMHVsQ0tndDNncXhGWDM1R0thZTduSXRBMGVudksyekxq?=
 =?utf-8?B?TUpQYVRCYVNsRlcxdTRBVW9HYXozdmJmM0RSbktwMk9paE1sV1ZwazZaSlg0?=
 =?utf-8?B?Mk1zbHRVYUxia3dsUy9oWi9DQ3oxeUM2dkovdmlpaTBGU0hQOHJYNWx0WXNC?=
 =?utf-8?B?dkp0WVRtVGhFdUp6QnZac2JIUXFsU1dYM0ZnWjBhNzVGV3ljcnNGSG9rdTNJ?=
 =?utf-8?B?Vzk2ckxta1l1M2VteGFjN0t3TjlHcEh3Z2JZTnVjNFhqN24xMkloZHkzRmkv?=
 =?utf-8?B?WWFuMlBKVjE4ZFN1UGViYnJCUDIvNmZvRTZwbXFISjNRdk04bjJycm81Qm9G?=
 =?utf-8?B?M1UzekNCSGxxaDF0RTIwNGQ3QURYNm8rbFgzbW55V2IzWmJCY0M3ZENuMzlO?=
 =?utf-8?B?NTc2SnBxOXoxdXVDZUpaaTNlNkdTVW1ZeStkLzRBYk90c0pudmE5MlIxa3Vp?=
 =?utf-8?B?TkdzcEo2aksvZ0cyb0FBTmsyL25CQXRiMnM5anhNam4vVGFrRHZkSDA1R2RY?=
 =?utf-8?B?T0swdHd2bFZTQjJGWjFUR0d2WGUxZnFkbTFiZEM0bFJGS3I0SGFaS2pCTmV3?=
 =?utf-8?B?V3dmbjdDQXJyL0tIcks1Y20rVzZBcCtCZkNvblUvNjFjU2xTcXhBR0dUdUpU?=
 =?utf-8?B?RG5WTFZWbm41RmJFVXJ0UldHZTJIM1VvbGg2eTA3QnVnNUtHL0hzbnU5c1lF?=
 =?utf-8?B?T3o5c2dzT1dtZW9QYTVXaEl6K0lIVmtSakUzTVlvNWpjcEFkT1VnTnBwNXJu?=
 =?utf-8?B?M0pQUnZwdWlIWE01clVzWXA3cVBWVVRHc1lmU1FMaS9VT3RKdzVEMG1XZFQy?=
 =?utf-8?B?c01aR0VYaGZUUllaSjFuNDdtc1lBcmhWQi9NRkp0RjJpVlpkWk9NV1ExVkkr?=
 =?utf-8?B?MkFidjlyUkpJR0N0M3FyN2RKVHFOYUtNKytxa0l6NDVuMXdyMkRYcW1XVzYz?=
 =?utf-8?Q?FbElOYwqA1X4QgYxsTfKLRenQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c06de69a-b3e2-49db-349c-08dbb2967d6d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 07:12:42.5032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KE9ccbMmPuLPh+r/qpgb+xptG2WAq9QZFe4ExXhr4oPtfukXZmxDEX5QMUG5h62BOlTiycUa1CADU9PFxyTbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5298
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/10/23 01:12, syzbot wrote:
> commit 617c28ecab22d98a3809370eb6cb50fa24b7bfe1
> Author: Yin Fengwei <fengwei.yin@intel.com>
> Date:   Wed Aug 2 15:14:05 2023 +0000
> 
>     filemap: batch PTE mappings

#syz test

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index a629b1b9f65a6..2701b47efa8f7 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -168,6 +168,28 @@ static inline void native_pgd_clear(pgd_t *pgd)
        native_set_pgd(pgd, native_make_pgd(0));
 }
 
+static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+               pte_t *ptep, pte_t pte, unsigned int nr)
+{
+       bool protnone = (pte_flags(pte) & (_PAGE_PROTNONE | _PAGE_PRESENT))
+                       == _PAGE_PROTNONE;
+
+       page_table_check_ptes_set(mm, ptep, pte, nr);
+
+       for(;;) {
+               native_set_pte(ptep, pte);
+               if (--nr == 0)
+                       break;
+
+               ptep++;
+               if (protnone)
+                       pte = __pte(pte_val(pte) - (1UL << PFN_PTE_SHIFT));
+               else
+                       pte = __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
+       }
+}
+#define set_ptes set_ptes
+
 /*
  * Conversion functions: convert a page and protection to a page entry,
  * and a page entry and page directory to the page they refer to.
