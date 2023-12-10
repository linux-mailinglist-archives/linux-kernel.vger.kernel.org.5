Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E61080BD75
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 22:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjLJV4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 16:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJV4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 16:56:39 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC0BCF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 13:56:42 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2ca0715f0faso52477681fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 13:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20230601.gappssmtp.com; s=20230601; t=1702245400; x=1702850200; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k9IfgR4rckGeImC/tzT5gweS2V09bG6J5YloGPaYcsM=;
        b=Byh4/LzIP6KDOK2URZbyPdEcQAofvJBK52rUYJdzFzFBDrj1DZCuME8Zi1Ha/lo2LT
         hSFiDNrheqnUFPdpKDeRvhZsKbB5ggW+QSNgWR++Vgbv6a5ypdL7tVVnDvyV0zMhdMmk
         hR+8cnq4q/1ycfAsHex1xB7Ssmu5/Nr/WSHLr8OgB4OHDhZQfhlzGFA2b7aNdhFQOsl5
         4Cg6lxOX5T/Cs2Ui/ZoZkHHxhgwq5ogQIUeoxamBZVPeRly/rnX0s85ioMIHCj9/RWvE
         BIjju10hDScybUHxIw58YPXS9BlWGQYWmVRGdYlMSo8NJommFnEee98oR5dGjAjEGOPh
         OjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702245400; x=1702850200;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k9IfgR4rckGeImC/tzT5gweS2V09bG6J5YloGPaYcsM=;
        b=nnTyYxrIFpWUbDxov3yveDV76vaZM/xuLZwI4V24fq2rLo+bx+rYv/IreYMKSEkqcA
         9WhwKO2qWktdTA4A12NxCc1I7qdsxC2OY1NQCdkC65yPZfUHqX4wq6bFB20HpOOszsOM
         SaMthY5Zf00B1DBP3ZsSuiVSqAPoJ0SkXtf2fE4Z3Ti+Phc2HbLntAe0sdv+2GZsnQUn
         HXwBTqtBkCsusqde9FX4hFBU7eFjVY7bfZirtlcXH3Qp6dWGBcxndP4wN19/6NVTLQOQ
         +rmNDi/igdhAf0a7QZ4yMHdkKuNzv3dSRz55wd8Ir4rE6ZWN4A1vSwy1yJIhknh5w0Cw
         cdpA==
X-Gm-Message-State: AOJu0YxW6DuA//2XHJLM7MaNhOXZMhSFpu1+jGvV3l0wino/A61XGnnX
        5TuhyDc1mStfx84q9oOGCfs6Gg==
X-Google-Smtp-Source: AGHT+IEbcVChfJICU5xmpT+2MUhjeS7q0xbcgjqAjf3RTtyD+2ANoO7P4SmxQ9undFWMS68tf5qWKw==
X-Received: by 2002:ac2:4470:0:b0:50c:c7d:9ef4 with SMTP id y16-20020ac24470000000b0050c0c7d9ef4mr1240548lfl.49.1702245400274;
        Sun, 10 Dec 2023 13:56:40 -0800 (PST)
Received: from localhost (h-46-59-36-206.A463.priv.bahnhof.se. [46.59.36.206])
        by smtp.gmail.com with ESMTPSA id m17-20020a195211000000b0050bbdf9616bsm892916lfb.217.2023.12.10.13.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 13:56:39 -0800 (PST)
Date:   Sun, 10 Dec 2023 22:56:38 +0100
From:   Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Louis Peens <louis.peens@corigine.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Simon Horman <horms@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] checkpatch: Also accept commit ids with 13-40 chars of
 sha1
Message-ID: <20231210215638.GA1863068@ragnatech.se>
References: <62f82b0308de05f5aab913392049af15d53c777d.1701804489.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62f82b0308de05f5aab913392049af15d53c777d.1701804489.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thanks for your patch.

On 2023-12-05 20:34:16 +0100, Geert Uytterhoeven wrote:
> Documentation/dev-tools/checkpatch.rst says:
> 
>   **GIT_COMMIT_ID**
>     The proper way to reference a commit id is:
>     commit <12+ chars of sha1> ("<title line>")
> 
> However, scripts/checkpatch.pl has two different checks: one warning
> check accepting 12 characters exactly:
> 
>     # Check Fixes: styles is correct
>     Please use correct Fixes: style 'Fixes: <12 chars of sha1> (\"<title line>\")'
> 
> and a second error check accepting 12-40 characters:
> 
>     # Check for git id commit length and improperly formed commit descriptions
>     # A correctly formed commit description is:
>     #    commit <SHA-1 hash length 12+ chars> ("Complete commit subject")
>     Please use git commit description style 'commit <12+ chars of sha1>
> 
> Hence patches containing commit ids with more than 12 characters are
> flagged by checkpatch, and sometimes rejected by maintainers or
> reviewers.

I agree, it's not nice that the two commit id checks do not agree on 
length and that this should likely be aligned.

To clarify, the two commit id checks in checkpatch.pl do not conflict 
with each other as one check Fixes tags while the other checks the 
format when referring to commits in general, right?

The intention when adding the check for Fixes tags was to conform with 
what is documented in [1]. And to enforce a minimum number of characters 
as there where issues where too few where used.

> 
> Fix this by aligning the first check with the second check, and with the
> documentation.

I think this change is a good idea, but the documentation should also be 
updated.

1. https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

> 
> Fixes: bd17e036b495bebb ("checkpatch: warn for non-standard fixes tag style")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Perhaps the time is ripe to increase the minimum from 12 to 16 chars
> (in a follow-up patch)?
> 
> Running git-unique-abbrev[1] on a tree containing v6.7-rc3 and all
> stable releases gives:
> 
>     12000853 objects
>      4: 12000853 / 65536
>      5: 12000717 / 1048423
>      6: 6130888 / 2703295
>      7: 525025 / 260563
>      8: 33736 / 16861
>      9: 2106 / 1053
>     10: 160 / 80
>     11: 10 / 5
>     12: 0 / 0
>     21cf4d54d3c702ac20c6747fa6d4f64dee07dd11
>     21cf4d54d3ced8a3e752030e483d72997721076d
>     8a048bbf89528d45c604aed68f7e0f0ef957067d
>     8a048bbf895b1359e4a33b779ea6d7386cfe4de2
>     d3ac4e475103c4364ecb47a6a55c114d7c42a014
>     d3ac4e47510ec0753ebe1e418a334ad202784aa8
>     d597639e2036f04f0226761e2d818b31f2db7820
>     d597639e203a100156501df8a0756fd09573e2de
>     ef91b6e893a00d903400f8e1303efc4d52b710af
>     ef91b6e893afc4c4ca488453ea9f19ced5fa5861
> 
> 12000853 is still smaller than sqrt(16^12) = 16777216, but the safety
> margin is getting smaller.  E.g. my main work tree already contains
> almost 18M objects.  Hence the Birthday Paradox states that collisions
> of 12 char sha1 values are imminent.
> 
> Note that we standardized on 12 chars in commit d311cd44545f2f69
> ("checkpatch: add test for commit id formatting style in commit log") in
> v3.17.  For comparison, running git-unique-abbrev on a tree with all
> (upstream + stable) releases from that era gives:
> 
>     4052307 objects
>      4: 4052307 / 65536
>      5: 3966948 / 940963
>      6: 869691 / 417363
>      7: 61208 / 30523
>      8: 3979 / 1989
>      9: 258 / 129
>     10: 24 / 12
>     11: 6 / 3
>     12: 0 / 0
>     21cf4d54d3c702ac20c6747fa6d4f64dee07dd11
>     21cf4d54d3ced8a3e752030e483d72997721076d
>     d597639e2036f04f0226761e2d818b31f2db7820
>     d597639e203a100156501df8a0756fd09573e2de
>     ef91b6e893a00d903400f8e1303efc4d52b710af
>     ef91b6e893afc4c4ca488453ea9f19ced5fa5861
> 
> So the number of objects increased threefold during the last 9 years.
> 
> Thanks for your comments!
> 
> [1] https://blog.cuviper.com/2013/11/10/how-short-can-git-abbreviate/
> ---
>  scripts/checkpatch.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 25fdb7fda1128aa9..a4e178a68f6d1d5f 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3209,7 +3209,7 @@ sub process {
>  				$tag_case = 0 if $tag eq "Fixes:";
>  				$tag_space = 0 if ($line =~ /^fixes:? [0-9a-f]{5,} ($balanced_parens)/i);
>  
> -				$id_length = 0 if ($orig_commit =~ /^[0-9a-f]{12}$/i);
> +				$id_length = 0 if ($orig_commit =~ /^[0-9a-f]{12,40}$/i);
>  				$id_case = 0 if ($orig_commit !~ /[A-F]/);
>  
>  				# Always strip leading/trailing parens then double quotes if existing
> @@ -3226,7 +3226,7 @@ sub process {
>  			if ($ctitle ne $title || $tag_case || $tag_space ||
>  			    $id_length || $id_case || !$title_has_quotes) {
>  				if (WARN("BAD_FIXES_TAG",
> -				     "Please use correct Fixes: style 'Fixes: <12 chars of sha1> (\"<title line>\")' - ie: 'Fixes: $cid (\"$ctitle\")'\n" . $herecurr) &&
> +				     "Please use correct Fixes: style 'Fixes: <12+ chars of sha1> (\"<title line>\")' - ie: 'Fixes: $cid (\"$ctitle\")'\n" . $herecurr) &&
>  				    $fix) {
>  					$fixed[$fixlinenr] = "Fixes: $cid (\"$ctitle\")";
>  				}
> -- 
> 2.34.1
> 

-- 
Kind Regards,
Niklas Söderlund
