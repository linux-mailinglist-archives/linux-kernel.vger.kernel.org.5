Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E827ADF83
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 21:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjIYTXm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Sep 2023 15:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjIYTXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 15:23:41 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24575AF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 12:23:35 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qkrA5-0005Zv-2J;
        Mon, 25 Sep 2023 15:22:29 -0400
Message-ID: <692fafae9842a9b15b7b4a033bb7dc800784d4aa.camel@surriel.com>
Subject: Re: [PATCH 3/3] hugetlbfs: replace hugetlb_vma_lock with
 invalidate_lock
From:   Rik van Riel <riel@surriel.com>
To:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com, leit@meta.com,
        willy@infradead.org
Date:   Mon, 25 Sep 2023 15:22:29 -0400
In-Reply-To: <202309250923.NEPT0ip2-lkp@intel.com>
References: <20230922190552.3963067-4-riel@surriel.com>
         <202309250923.NEPT0ip2-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-09-25 at 10:04 +0800, kernel test robot wrote:
> Hi,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> [also build test ERROR on linus/master v6.6-rc3 next-20230921]
> [If your patch is applied to the wrong git tree, kindly drop us a
> note.
> And when submitting patch, we suggest to use '--base' as documented
> in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]

OK, so I have a fix for patch 3/3 that gets rid of the
compile error, but the libhugetlbfs test cases show that
patch 3/3 opens up a condition where resv_hugepages 
underflows.

I have not figured out the cause of that yet, but
patches 1 & 2 seem to survive all tests fine.

-- 
All Rights Reversed.
