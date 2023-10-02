Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437397B4C4E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbjJBHLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbjJBHLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:11:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76462B7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:11:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 197F01F459;
        Mon,  2 Oct 2023 07:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696230695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Kw1gfX638yH/94hhS8D+jNIjZbBhxyNQ0T5FKpktkI=;
        b=MC1FNFhNKMLbMSs+NYQjBALxt6PY8tjNwaBHAsJxE1X1TuSIeHEScQp76DJoe1Xz197+s4
        1ZF+M2ys5AsXYzr+Erbhy776jcicupaFzT51v15D3qWxUq0ZSTdFO8hwtlzAJf9WEgbX/0
        KFsxgB27tJF4+GV6RDMWmufNqD4fPsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696230695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Kw1gfX638yH/94hhS8D+jNIjZbBhxyNQ0T5FKpktkI=;
        b=zwq+t0QnU9ntCV4e/kmzBXLlxGsLdD/EHKPxF6JR0LRaHTRxaLqN4qjgmBZNNTBncRm2Ad
        9DvQwhn8vw6twFCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F15CD13456;
        Mon,  2 Oct 2023 07:11:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z/hNOiZtGmWBeQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 02 Oct 2023 07:11:34 +0000
Message-ID: <6b198ba6-083d-0e0e-92c6-6042d4d208b0@suse.cz>
Date:   Mon, 2 Oct 2023 09:11:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 3/3] mmap: Add clarifying comment to vma_merge() code
Content-Language: en-US
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20230929183041.2835469-1-Liam.Howlett@oracle.com>
 <20230929183041.2835469-4-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230929183041.2835469-4-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/23 20:30, Liam R. Howlett wrote:
> When tracing through the code in vma_merge(), it was not completely
> clear why the error return to a dup_anon_vma() call would not overwrite
> a previous attempt to the same function.  This commit adds a comment
> specifying why it is safe.
> 
> Suggested-by: Jann Horn <jannh@google.com>
> Link: https://lore.kernel.org/linux-mm/CAG48ez3iDwFPR=Ed1BfrNuyUJPMK_=StjxhUsCkL6po1s7bONg@mail.gmail.com/
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/mmap.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index f9f0a5fe4db4..9967acbd070f 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -943,6 +943,11 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  			vma_start_write(curr);
>  			remove = curr;
>  			remove2 = next;
> +			/*
> +			 * Note that the dup_anon_vma below cannot overwrite err
> +			 * since the first caller would do nothing unless next
> +			 * has an anon_vma.
> +			 */
>  			if (!next->anon_vma)
>  				err = dup_anon_vma(prev, curr, &anon_dup);
>  		}

