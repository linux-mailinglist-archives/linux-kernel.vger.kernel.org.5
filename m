Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F221C7FE66F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjK3B5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK3B5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:57:03 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2112.outbound.protection.outlook.com [40.107.117.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851341B4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:57:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1+L+sQYPEHaP7TYIUyzyuU+/2i/rjwXf/iBcuySYYnEuMG6VzehGy5tvAcV6YUannivnEePPMG6zxZPEiTjAe/eNC9ajOnAQGZaPOaDnS/k+PudUMNelYlBIAYK5+XEqauR0ZbwJa7L2EJmSj9whN6rf/2UWueGQHRDLIpdKiWZHr33cejYs4hzGdrgiJtDpMgFiFPTYV75IJS1KqQJ7/LzWvahEmQcsv6uCJpcPhRjwKVp2H+c5KkWgpLDtdkPC0PU3zU04FbErDGTjn9ms76UH7lWd3ktKzqLvI2tKJpIrxVWY3NrG2v6Q9+nTgv28B/SEhSPEzmHmvEkX2+EPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86Bdboi9mTewJ2e8fd3ST8UxMdIAA7I9t0bJejhsDGw=;
 b=gIY+ebIsB6PQ7mJAkf7c9Pzd5DZq/iLBRtM0AXtNZt7SFeUYN3/1g6/JkNJUsFMRXu5GC4dv0GbixS8dJCLRaB+1Nx9OUmgnNnZvbbX+S0GWpZp46Tsd5sxmfCRKzEmCPFZKMl9VcbAlem5NyIT3DxsewYOPq0q2JClYAusR5YqofQ9P0ebdDk/p2dJWTaxZKdVqxaVRcA9fH5zviXphJjG6ZosQugWLEDAiDZj1msE5wXNPJcaUpmSwX9pTCbzHr+a2GsTppMV3Lzk+99EiBFIxgnehG2ewQmeFaFyKZDmSzO4f0OKJrN9qS/Ni2+8zyYyGcnJpRabwYJ4PAjSU3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86Bdboi9mTewJ2e8fd3ST8UxMdIAA7I9t0bJejhsDGw=;
 b=Yp+/MFFcXJa5IE/fPSs70/XWu+wCs6khLwYAAFa9hJoUqKj3lZf2g0ntyT6VAIENdvY/xXAaEyW/R8gdnVJlARmGcz1TRc4e4HP0N9pxh4gm1ze4Ms00AV81XDlateUOcgy9vDmU4Ccnz+P3G8gFcDSjm5w1puIn6HhRIHtt866pDsd34AcytWcC5fUvcAKzqxX+ox7PipSV+nim6hkYFvxSRBQ5YRI21Sg7SPBcAtVNhErcrvbuaauQk4/tL3yHEiMG9A8JdjKf0nqVF7nSTYBV8FVVEWKzEDzLkffwAw1QAWh3aUCSRvd2l+PfHIx242GHF0Ov1xtO0rHdh3wZGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by KL1PR06MB5994.apcprd06.prod.outlook.com (2603:1096:820:d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Thu, 30 Nov
 2023 01:57:04 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:57:04 +0000
Message-ID: <dc01e0d2-17db-4531-bc7d-7d637d96c2f1@vivo.com>
Date:   Thu, 30 Nov 2023 09:56:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm:vmscan: fix shrink sc->nr counter values issue
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20231129130126.2130-1-justinjiang@vivo.com>
 <ZWdWFx1mXl29dP5U@casper.infradead.org>
From:   zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <ZWdWFx1mXl29dP5U@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:3:18::13) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|KL1PR06MB5994:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b3ba365-0b2a-42d5-2446-08dbf147a655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QESC5ujW5c53sWZPhnKO5AeuiLpBfkH5sN6xv/R9iWmV7ZpHc0jdcU/D+CwCVv5CZ8cU9OubUCYssejXyrgHavQRoxDRv71qv2dJDx8rBTc9PdHOpCInUDn9ZGYy5qVb8pKHR6f6Gi7XnJCVrYPT5/Rxg3wRigT8YbGjcfSuspjVpu/834DSSRrrmPMyj4Ze93Tl18EBGF5W/gWn/1/8a8su8LJdlyMavIS0hT7IjDZUCTtsF8c2yhBHiPAP0jyL1t9ZIdLE7AW7dirTBOzZTnZ9F/c/6PzV8LWv9wjkB1bnGxf7pU2hvHMs0nMaa0jA/2vwBdcMXIGF6EgTdtPM1u+ybPQAnWQkuJbsEVPNAsxFUh254pVbcrdCye5WXWrHqgrjVFzWvDMFxwQCyau7EKyN+aysNU81xPWRpjWWsrXxQPZ/ezoDmYcJ0hHxn0dDAoDTjawVZyutfWgvG2dx3sA5oVBAhfoB8vQp+576fkMC8YhkP+1xWQzNsVJmY+kgumV5Int+SScLgRMI0AI+kIFAUaowigh2/ltmMJ9XnKxSPB6FwunEqHd7gj6A1r6MWgE8XUjPp7ZX5+meuhW1Gnw+pXGrXpMQ7x3LlGOJPYernYnygQKYo+5RvkPOg2H3wAyaT5IUBnjuPHzj8Smt6E1xfS7cle9I9kuczvRrU+1hBhQLvIEJwRxnTJb16Ye1AkKilxjwYk7aLdXx5/vVvpOW2XeieF/Ira1NI8FvgnzFZHBlIXmo0/vmKtW67a8y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(2616005)(107886003)(202311291699003)(6666004)(5660300002)(52116002)(6506007)(4326008)(8936002)(31696002)(86362001)(6512007)(6486002)(66556008)(66946007)(316002)(66476007)(8676002)(6916009)(478600001)(38100700002)(31686004)(2906002)(36756003)(38350700005)(41300700001)(43062005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnF3dDhoWm0xYXN3VEVmTzcwQmJva2NkdHVzUEk5QXdIVUVOaUtnUGkrZEdB?=
 =?utf-8?B?Yk1qQXM5MlBmUktzSE4rVXlXZjgzQW4zbGxPWkVadXZHR1IrQ3kwZ3R2ZW5x?=
 =?utf-8?B?NmNqTnVGNXlWT0pKRzI3U3hNYWhzWXZQL0cyLzZIclZFVDBtLy9xYzNkZDVa?=
 =?utf-8?B?OGpsUUwwazZkblJ2QWlDMTJKWVdIbGZtUnlnOW53cDNwcEZhSGpKUjZsdUNt?=
 =?utf-8?B?d2tyajg4L1YzQmFLU3JPaWlPOC9tWUx0RWFjM0RnVlI4MmpNeFYyWnBBdUhL?=
 =?utf-8?B?eDhJeFFPOGpnaDFYTDlENXhQdUl2VGZaa0lYbmk2MDlJRmd5SklKQ3pKYWhO?=
 =?utf-8?B?c1VadHVFenFneWdGNU9rSU0rcFQ4aVVVaFZUSE8yMThoTHZWWllndGVYbjEx?=
 =?utf-8?B?T1lpWmFVUEx3RHBndlMzcDVVcC9pWFBYb2x2RDIwOWhESkZ4NFdsQ1gvSFgx?=
 =?utf-8?B?cmF3c1V2ZURHcmFhenduemREdm43VDRsWkllN0ZnNG9XcWF5a2tEdzB6bEs1?=
 =?utf-8?B?dlduaDh4OGVVL1p3OVlLekxmZXBxZk0vNUVWSUROSFRocXE4ZStQcnJGa0xC?=
 =?utf-8?B?TFROTkQ3dyszUldJOU9HSEVOeXZEWitvVGkyWG5ya3Vleklsd3FNUXIwOTZH?=
 =?utf-8?B?bGpIZU05QkNzL3BKRXhaY09OSmFHdW9wQ2YyeTdvcUZrbzJwSk9ETTFrY0Vo?=
 =?utf-8?B?RWlTR1djUFY1Nm1CVEVPblQyM0Q2MmlaazRFbGhnSkFpbnFVV2RMYndnK0Nh?=
 =?utf-8?B?bXZheVhwNmlpVzY2bkRXQ1M5enM5dDhweXo4aUFpWU1xVDNOS0RUcWtDMUtJ?=
 =?utf-8?B?SStXY0lFMFJsTitBSllPTHZDY3pESGVEVjdUN2MxUmlFNm9OSjd6RFJoN0pO?=
 =?utf-8?B?NHlzcjlsQjRUY05jbncwYm92ZkdpR2ZRUzFvb05xS2NpZ04zQndPY2xYV0RT?=
 =?utf-8?B?d3FXd2pJNXBiTDVsMWt0SkFaeGF5NDhVUEJKa3ZxZWg2THBkU3MzWkhsUklS?=
 =?utf-8?B?aDF1S0VUa25NVGpKeVNCdXE3RE82c1BpVit6VVpDdDRQMVdKU0ZUWmxNTXUw?=
 =?utf-8?B?MGtHczZ6Q09MOTFzNDFVeXZGV1h1SHdzMDlCMnM5Rm1wL2NIb1d1WEtSVy9U?=
 =?utf-8?B?UHFJT1k0VTJFNDAyOHZnNEZxS3pBdHFvTlF5ekJGRmduWmVZNzFuc2xRajFq?=
 =?utf-8?B?ZFY4UEZJaEpoaHpHWG03LzRNbWM4eGNHMC9RQUtvek5udXlyRFZiNm0xK3hF?=
 =?utf-8?B?QzdIcEZjV1o5QXVvWkxRTXpxa29qTGZIazZWWmpmaFEwZEpHWUFkTDVCWW9V?=
 =?utf-8?B?MS9va1NTVE9waUtpZDBFenBvN0tEaFltSkFwZ3c1NlFTYjZPVDYvUG5TNmt5?=
 =?utf-8?B?c0w2VTRKekZDK0w3ZVdPcU1Nci9rYXpsbjdzUU9Kd2lkU2JLeEJ6bVpQbnB1?=
 =?utf-8?B?REdRS3crbkEzNlp2VnJnclhxNEsvVjFjQnJSQldLOVVwYUJlRnhycndzUG9Q?=
 =?utf-8?B?UkFrbWNkTk5OTW8zaEpRSVEvTGRaellXT2pvNk01TFUrb3VVOEdZd3Z3eXBn?=
 =?utf-8?B?WTMwV1ZFV3ZJNU1JRTJ2bUtrWmxPcWFyVk5NRlVrU1Y2L1lob2F4Wlp4aURa?=
 =?utf-8?B?T1c5T09HeGFYR2xHVWpJbnpMc2E4dXRONjNyenpRN0lMblEzQS8wL2w5MEJB?=
 =?utf-8?B?QU9SN0h3VmZRN20vWC95dURENnA1UkpVNnJncVZ2TG9qcDB1ZGpvbGtMaXV4?=
 =?utf-8?B?UkRKSVA2S0JFdmR2aHorbmlVM1RwUlljZEdkeFlYU3pFTnV0NUdTOXo1d2x5?=
 =?utf-8?B?aVJ0MTZYOE1ndW9RN3lTQzU1aEVENzkwUVM5alZXYmlPU0krMWlIdzBjY0Ra?=
 =?utf-8?B?a1M4Y3RSSndrQldyQXNpSEJUaWQrQlpabWpmM0VwbTdxMWlTN1kzMGFKTzJ5?=
 =?utf-8?B?SnVSTjdRTWJkTzFORmFSNkhFN3ZvaE5EQy94RzVMSyttUGRnMUFPSkZrcVNT?=
 =?utf-8?B?cDVrbDF6MEhDZHlpck9UQnFCRDM2Sm0wTGNJdG94K1E0SVJxc0hmcy93T2hW?=
 =?utf-8?B?VDlOTUV5ZXFBZ0FxNG9qK0laZS94cTE1ZGNiOFhnWjlqd2lOZU9RUlhhSnd0?=
 =?utf-8?Q?W0sLStH1FaV86WUl5Gmn93g5F?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3ba365-0b2a-42d5-2446-08dbf147a655
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:57:04.7719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31CcVvKVpRzPzMh0bMjWkgYvD5OQovY9elBINg5TxO2NwpFadNi9NAqDbSXldCP/L3xaDqZcxo/YGzF0gcSDcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB5994
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/11/29 23:17, Matthew Wilcox 写道:
> On Wed, Nov 29, 2023 at 09:01:26PM +0800, Zhiguo Jiang wrote:
>> It is needed to ensure sc->nr.unqueued_dirty > 0, which can avoid to
>> set PGDAT_DIRTY flag when sc->nr.unqueued_dirty and sc->nr.file_taken
>> are both zero at the same time.
> Have you observed this happening, or is this from code review?

Found in code review. The other sc->nr parameters are also judged whether they themselves are zero first in shrink_node.

>
>> It can't be guaranteed for the PGDAT_WRITEBACK flag that only pages
>> marked for immediate reclaim are on evictable LRUs in other following
>> shrink processes of the same kswapd shrink recycling. So when both a
>> small amount of pages marked for immediate reclaim and a large amount
>> of pages marked for non-immediate reclaim are on evictable LRUs at the
>> same time, if it's only determined that there is at least a page marked
>> for immediate reclaim on evictable LRUs, kswapd shrink is throttled to
>> sleep, which will increase kswapd process consumption.
>>
>> It can be fixed to throttle kswapd shrink when sc->nr.immediate is equal
>> to sc->nr.file_taken.
> So you're fixing two distinct things in the same patch?
It can be understood as two issues, and I will submit them separately.
>
>> +++ b/mm/vmscan.c
>> @@ -5915,17 +5915,17 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>>   			set_bit(PGDAT_WRITEBACK, &pgdat->flags);
>>   
>>   		/* Allow kswapd to start writing pages during reclaim.*/
>> -		if (sc->nr.unqueued_dirty == sc->nr.file_taken)
>> +		if (sc->nr.unqueued_dirty && sc->nr.unqueued_dirty == sc->nr.file_taken)
>>   			set_bit(PGDAT_DIRTY, &pgdat->flags);
>>   
>>   		/*
>> -		 * If kswapd scans pages marked for immediate
>> +		 * If kswapd scans massive pages marked for immediate
> I don't understand why you've added the word "massive".  Do you mean
> that the pages are large, or that kswapd has scanned a lot of pages?
The added "massive" means that there are a large number of pages marked 
for immediate reclaim on evictable LRUs.

The added "massive" is relative to the situation that there is only a 
small amount of pages marked for immediate reclaim or even only one page 
marked for immediate reclaim on the evictable LRUs for throttle kswapd, 
and I think this situation don't need to throttle, because there may be 
other types of pages on evictable LRUs.
>
>>   		 * reclaim and under writeback (nr_immediate), it
>>   		 * implies that pages are cycling through the LRU
>>   		 * faster than they are written so forcibly stall
>>   		 * until some pages complete writeback.
>>   		 */
>> -		if (sc->nr.immediate)
>> +		if (sc->nr.immediate && sc->nr.immediate == sc->nr.file_taken)
>>   			reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK);
>>   	}

