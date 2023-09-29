Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8DB7B303C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjI2K35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbjI2K3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:29:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382941BE;
        Fri, 29 Sep 2023 03:29:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D97F11F390;
        Fri, 29 Sep 2023 10:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695983342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YI7Ztywt2LP6ZcfMdUFyA7x6td6Q5w3HHThS4KJiN20=;
        b=X1vS2aRDHPDytEwMy+aMU/AsSK5x2ZyiLaTUg7jxLgBPni7pRZ4IGGjwGQgaDf/ecqRKSG
        wMpTQ+YqG+/LctkJkX191DAwnQvVzEDy5KmfJ2lE9HQ09OL48aEiWzyms6ekhyhH9rMp+y
        8iZbdD7Q21k/hQ9NEsnGqpJsEVmKmwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695983342;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YI7Ztywt2LP6ZcfMdUFyA7x6td6Q5w3HHThS4KJiN20=;
        b=XXhDjW4L2RqjigtCsUpjVRZ0rVUgtHZMGWOUGcMsrSeyT6ZiCjfH5wZJKP5vLnDzlfLOpd
        GU8TNzZUZc0JScBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B12621390A;
        Fri, 29 Sep 2023 10:29:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UfGEKu6mFmWgJwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 29 Sep 2023 10:29:02 +0000
Message-ID: <78bedfc2-0edc-fa64-8718-88767f7842ee@suse.cz>
Date:   Fri, 29 Sep 2023 12:29:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/3] mmap: Add clarifying comment to vma_merge() code
Content-Language: en-US
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
References: <20230928171634.2245042-1-Liam.Howlett@oracle.com>
 <20230928171634.2245042-4-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230928171634.2245042-4-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/23 19:16, Liam R. Howlett wrote:
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
> index 2f0ee489db8a..3c78afb707cf 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -937,6 +937,11 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
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

