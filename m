Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9797B78A659
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjH1HQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjH1HQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:16:19 -0400
Received: from out-248.mta1.migadu.com (out-248.mta1.migadu.com [95.215.58.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B13139
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:16:10 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693206969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ea3oJojfHwYhg/cah6p3oZm1twpvjQ6dlwY+OIn4Srk=;
        b=UVbI66/qKVdEmeAVCoKGswbLzkvWdcdpCEDlNWN0G2s7DtDg0Si1KNkza71j4IE+FaNSJN
        xCGP/SSOXcHOoLTA/ExQDA3NHQf8445cgKbcJHqQrOVIuGccwXlbtJ1NUQYrbcAlBow3GW
        /znAvrd/G4DyATPrrLdQ3zoRb8LgF28=
Mime-Version: 1.0
Subject: Re: [v3 1/4] mm: hugetlb_vmemmap: Use nid of the head page to
 reallocate it
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230825111836.1715308-2-usama.arif@bytedance.com>
Date:   Mon, 28 Aug 2023 15:15:27 +0800
Cc:     Linux-MM <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com
Content-Transfer-Encoding: 7bit
Message-Id: <4BE9BCF9-AD29-484B-BBB0-3709B77E2236@linux.dev>
References: <20230825111836.1715308-1-usama.arif@bytedance.com>
 <20230825111836.1715308-2-usama.arif@bytedance.com>
To:     Usama Arif <usama.arif@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 25, 2023, at 19:18, Usama Arif <usama.arif@bytedance.com> wrote:
> 
> If tail page prep and initialization is skipped, then the "start"
> page will not contain the correct nid. Use the nid from first
> vmemap page.
> 
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>

Make sense even if without your optimization. Because the nid is
used for allocation for "reuse" page, it really should be extracted
from "reuse" page instead of "start" page.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

