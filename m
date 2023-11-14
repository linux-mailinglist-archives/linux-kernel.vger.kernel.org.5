Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2321D7EA88E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 03:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjKNCJm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Nov 2023 21:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNCJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 21:09:41 -0500
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252BCD43
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 18:09:36 -0800 (PST)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1r2iqM-0007BR-2R;
        Mon, 13 Nov 2023 21:07:58 -0500
Message-ID: <74c9d165c2e09f962467364319c2a2a4e05583a7.camel@surriel.com>
Subject: Re: [PATCH] hugetlb: fix null-ptr-deref in hugetlb_vma_lock_write
From:   Rik van Riel <riel@surriel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc:     eadavis@qq.com, nh26223@qq.com,
        syzbot+6ada951e7c0f7bc8a71e@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        nathan@kernel.org, ndesaulniers@google.com, muchun.song@linux.dev,
        akpm@linux-foundation.org
Date:   Mon, 13 Nov 2023 21:07:58 -0500
In-Reply-To: <20231114012033.259600-1-mike.kravetz@oracle.com>
References: <20231114012033.259600-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-11-13 at 17:20 -0800, Mike Kravetz wrote:
> 
> Mask off low bit flags before checking for NULL pointer.  In
> addition,
> the reserve map only 'belongs' to the OWNER (parent in parent/child
> relationships) so also check for the OWNER flag.
> 
> Reported-by: syzbot+6ada951e7c0f7bc8a71e@syzkaller.appspotmail.com
> Closes:
> https://lore.kernel.org/linux-mm/00000000000078d1e00608d7878b@google.com/
> Fixes: bf4916922c60 ("hugetlbfs: extend hugetlb_vma_lock to private
> VMAs")
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 

Reviewed-by: Rik van Riel <riel@surriel.com>

-- 
All Rights Reversed.
