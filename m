Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A7275A2F2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 01:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGSXuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 19:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGSXuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:50:44 -0400
Received: from out-32.mta1.migadu.com (out-32.mta1.migadu.com [95.215.58.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23959C6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 16:50:44 -0700 (PDT)
Date:   Thu, 20 Jul 2023 08:50:35 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689810642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RCVkYVVeqi5N6Z5dc11m8iY9xquKs/O/et4i98KCIVA=;
        b=oOo/VMPsUndu4nAy/dDp+fJt3aR3XEbr0eVAr05HSdqgdmGi5aDsnAGKpMZHuwdU/LWO4t
        pfvGW5H0YA0RJii4RSrHSZ8gEJUOGSxUjRs/uwLJR27fw/2SsWmbiGklBaFzu3ksaMGgUr
        rCom3jIk7298+c9UKu+R8whqf7hUDK4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: memory-failure: avoid false hwpoison page mapped
 error info
Message-ID: <20230719235035.GB1583723@ik1-406-35019.vs.sakura.ne.jp>
References: <20230715031729.2420338-1-linmiaohe@huawei.com>
 <20230715031729.2420338-4-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230715031729.2420338-4-linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2023 at 11:17:28AM +0800, Miaohe Lin wrote:
> folio->_mapcount is overloaded in SLAB, so folio_mapped() has to be done
> after folio_test_slab() is checked. Otherwise slab folio might be treated
> as a mapped folio leading to false 'Someone maps the hwpoison page' error
> info.
> 
> Fixes: 230ac719c500 ("mm/hwpoison: don't try to unpoison containment-failed pages")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
