Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78B97CBD28
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbjJQIN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbjJQIN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:13:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97CAB0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:13:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EEEE31FF08;
        Tue, 17 Oct 2023 08:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697530433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l8Uxvnp+afGL5t1DPxVjcVWqjHuaCiM0M/YSyAS3x4E=;
        b=FtCLP5U5FalpC0rLexHkLEUc+2h3Id1WDJBdGAugXH9+EiErwtHd9qr9LfctYqdVPE4qKY
        8dhNLd4L8zyqWLXtJPp5ZEkYA+craDDv7I1K8Fsad5AKRPk205agpClwyc37EGJmHAEeZ+
        ZslMYcVQAA+5A13NUiAzWhwX5IYekts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697530433;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l8Uxvnp+afGL5t1DPxVjcVWqjHuaCiM0M/YSyAS3x4E=;
        b=UrbsHyAiclGuToXCnLZNBgll+JueGSvT2KvJKPlQb/vo9dXj47okB/vFBZg5VW4omOzVdA
        vhzFMe1sae6MkABQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3F0213597;
        Tue, 17 Oct 2023 08:13:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8TElM0FCLmU1RgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 17 Oct 2023 08:13:53 +0000
Message-ID: <9f91b2be-dfb2-8bc3-91f8-6bd0715cc89d@suse.cz>
Date:   Tue, 17 Oct 2023 10:13:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5/5] tools/mm: Update the usage output to be more
 organized
Content-Language: en-US
To:     Audra Mitchell <audra@redhat.com>, linux-mm@kvack.org
Cc:     raquini@redhat.com, akpm@linux-foundation.org, djakov@kernel.org,
        linux-kernel@vger.kernel.org
References: <20231013190350.579407-1-audra@redhat.com>
 <20231013190350.579407-6-audra@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231013190350.579407-6-audra@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -7.10
X-Spamd-Result: default: False [-7.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-3.00)[99.99%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/23 21:03, Audra Mitchell wrote:
> Organize the usage options alphabetically and improve the description
> of some options. Also separate the more complicated cull options from
> the single use compare options.
> 
> Signed-off-by: Audra Mitchell <audra@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks a lot for making the tool useful again!

> ---
>  tools/mm/page_owner_sort.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/mm/page_owner_sort.c b/tools/mm/page_owner_sort.c
> index 5a260096ebaa..e1f264444342 100644
> --- a/tools/mm/page_owner_sort.c
> +++ b/tools/mm/page_owner_sort.c
> @@ -634,19 +634,26 @@ static void print_allocator(FILE *out, int allocator)
>  static void usage(void)
>  {
>  	printf("Usage: ./page_owner_sort [OPTIONS] <input> <output>\n"
> -		"-m\t\tSort by total memory.\n"
> -		"-s\t\tSort by the stack trace.\n"
> -		"-t\t\tSort by times (default).\n"
> -		"-p\t\tSort by pid.\n"
> -		"-P\t\tSort by tgid.\n"
> -		"-n\t\tSort by task command name.\n"
> -		"-a\t\tSort by memory allocate time.\n"
> -		"-d\t\tPrint debug information.\n"
> -		"--pid <pidlist>\tSelect by pid. This selects the information of blocks whose process ID numbers appear in <pidlist>.\n"
> -		"--tgid <tgidlist>\tSelect by tgid. This selects the information of blocks whose Thread Group ID numbers appear in <tgidlist>.\n"
> -		"--name <cmdlist>\n\t\tSelect by command name. This selects the information of blocks whose command name appears in <cmdlist>.\n"
> -		"--cull <rules>\tCull by user-defined rules.<rules> is a single argument in the form of a comma-separated list with some common fields predefined\n"
> -		"--sort <order>\tSpecify sort order as: [+|-]key[,[+|-]key[,...]]\n"
> +		"-a\t\t\tSort by memory allocation time.\n"
> +		"-m\t\t\tSort by total memory.\n"
> +		"-n\t\t\tSort by task command name.\n"
> +		"-p\t\t\tSort by pid.\n"
> +		"-P\t\t\tSort by tgid.\n"
> +		"-s\t\t\tSort by the stacktrace.\n"
> +		"-t\t\t\tSort by number of times record is seen (default).\n\n"
> +		"--pid <pidlist>\t\tSelect by pid. This selects the information"
> +		" of\n\t\t\tblocks whose process ID numbers appear in <pidlist>.\n"
> +		"--tgid <tgidlist>\tSelect by tgid. This selects the information"
> +		" of\n\t\t\tblocks whose Thread Group ID numbers appear in "
> +		"<tgidlist>.\n"
> +		"--name <cmdlist>\tSelect by command name. This selects the"
> +		" information\n\t\t\tof blocks whose command name appears in"
> +		" <cmdlist>.\n"
> +		"--cull <rules>\t\tCull by user-defined rules. <rules> is a "
> +		"single\n\t\t\targument in the form of a comma-separated list "
> +		"with some\n\t\t\tcommon fields predefined (pid, tgid, comm, "
> +		"stacktrace, allocator)\n"
> +		"--sort <order>\t\tSpecify sort order as: [+|-]key[,[+|-]key[,...]]\n"
>  	);
>  }
>  

