Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6B27D0A91
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376472AbjJTIcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376484AbjJTIcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:32:19 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FD218F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:32:17 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso748463a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697790736; x=1698395536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tqRU8lrO5DdEsJ7yzHOjWhQgZG94Il8pn8Nsr/6qC54=;
        b=YQ+wkOceBwVJbSw7QIQkjyG+/6qpGgXgcja3T+zjJDhKIPG6q+WrDg84buJA44FFjh
         qoDSrdR7aTwjpbWf2OeFErYlgTizH6xgplgjvKulkjEuyZsO53h2G+8QSp+8jruTL+mu
         hl4g88oWYTPSJ+6bT8wBDwA+MIIDNYN+wOTtLOC0rTRZ0rMRSEg73SQ7PmqSTIvFNbRe
         JoWRLz6EN3jLRZK4a3rHKcIMM2hWxhD38GUU1V/a/vmb6H5cex06TtqPNgUaV3TAGs1w
         k3XCbEcCwWqlX1mbJfa4SffONJlHxbVDcqd7WRpjSbFVsT+u8SVfeOYmDG9fVBNU59bH
         6jYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697790736; x=1698395536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqRU8lrO5DdEsJ7yzHOjWhQgZG94Il8pn8Nsr/6qC54=;
        b=LaqbH0+EiI4Ki0YlAdmjoQCLVXZC28Bc1qpy81qpC2zYmOERc0av744GMpeeJdgqNy
         5zBZRhePbtKFymwQDcCcDwz5ulJ7LndQEZxdNpfNoSoSj+FFOU8dfviUvJusuuSfgLcu
         dEDNn5prFw3+ggcSeKd/za2EXmqBtBSoT6Ddpl0h+oFkV2TJchEG27lU4Xmxo3u3w1OB
         Ka0bRiRd2Q3lwmE1WS/yBDb/FaZA+iiGdbVmNdWZpXw31cBav55OmvUMuMPc95AMCa1D
         yMRA6tkAcrbmK+/wBGs/US9NcVHhJ10+uVA54UsxBpkP9iO+hAcllDAFE4vMNWTd+fXw
         nOFg==
X-Gm-Message-State: AOJu0YyPVsmwcablObkQpTCK4B7WEYBliY27Gxlzf6Nn5UDlnjR0Y3sL
        bn7NXRjGrKDuLz724WMFExg=
X-Google-Smtp-Source: AGHT+IEb6xP1ALmiI0M4CBQddyaawn9u+DgDcAxnAtAukvVxZEk28V3a98gpRRqFGFqkycesRY2RjQ==
X-Received: by 2002:a17:907:5cb:b0:9bf:b022:dc7 with SMTP id wg11-20020a17090705cb00b009bfb0220dc7mr772906ejb.48.1697790736212;
        Fri, 20 Oct 2023 01:32:16 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id o14-20020a17090611ce00b009b29553b648sm1001362eja.206.2023.10.20.01.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 01:32:15 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 20 Oct 2023 10:32:13 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, rppt@kernel.org, david@redhat.com,
        vbabka@suse.cz, mhocko@suse.com, willy@infradead.org,
        mgorman@techsingularity.net, aneesh.kumar@linux.ibm.com,
        ying.huang@intel.com, hannes@cmpxchg.org, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 2/2] mm: memory_hotplug: drop memoryless node from
 fallback lists
Message-ID: <ZTI7DRNdObvSZXFG@gmail.com>
References: <cover.1697711415.git.zhengqi.arch@bytedance.com>
 <9f1dbe7ee1301c7163b2770e32954ff5e3ecf2c4.1697711415.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f1dbe7ee1301c7163b2770e32954ff5e3ecf2c4.1697711415.git.zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> In offline_pages(), if a node becomes memoryless, we
> will clear its N_MEMORY state by calling node_states_clear_node().
> But we do this after rebuilding the zonelists by calling
> build_all_zonelists(), which will cause this memoryless node to
> still be in the fallback list of other nodes. This will incur
> some runtime overhead.
> 
> To drop memoryless node from fallback lists in this case, just
> call node_states_clear_node() before calling build_all_zonelists().

s/memoryless node
 /memoryless nodes

> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory_hotplug.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index d4a364fdaf8f..f019f7d6272c 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -2036,12 +2036,16 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  	/* reinitialise watermarks and update pcp limits */
>  	init_per_zone_wmark_min();
>  
> +	/*
> +	 * Make sure to mark the node as memory-less before rebuilding the zone
> +	 * list. Otherwise this node would still appear in the fallback lists.
> +	 */
> +	node_states_clear_node(node, &arg);

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
