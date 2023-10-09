Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112397BD331
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345207AbjJIGPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 02:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345176AbjJIGPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:15:01 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965AEAB
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 23:14:58 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99357737980so720703866b.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 23:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696832097; x=1697436897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P23SOHfgTa3e7Ak8Wub57wHs43gpPbuk/YCIa0JR4k8=;
        b=i2scqwCvW11zGtYa9YlkIJYeoduJcaxgkCP9345YIKfrvchxywKGNwNbSq/sD39mul
         UgL9yFAqhCDWUnrwR1gg+bqHLecec0f5cp8jjqlRlxiTT6Lfdta2m+d8W4U8xtt/41a+
         IXZhtugmO7DAaMccfZQ4DJXfq1u1qn3LjVmzV9O33dUGBnd2Dr/nMXk82jSZAqFpI4K5
         9DZTjzqmYkjETJCJzxUg7O5NGkNV9m7CNgRiyTAz5kTLEHb2llSrd/aoS1duevDGvZI5
         KcXhdBSNwv/DaoTZv6QduZ5vJViUvlpefLxXyXJbGNaM8MR9jiUTQGIyMD5udA9XiaRO
         c9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696832097; x=1697436897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P23SOHfgTa3e7Ak8Wub57wHs43gpPbuk/YCIa0JR4k8=;
        b=BfsR/DvQHYSXJVcn4JZJWd8wAOj1IDmoEbPv+cAiDiKc5mjCI5syqM70bEfhaZQMDl
         KUxkSnZsadpZf+mt9kJeNO+atWltwod0fwV2QJ8UJJrE13QlU7Dg6HJbcPACsbOXTmmF
         9g2u4UnxXprfIg2bbDCfWoWzLx/N8f6SPO3sr8IuLQBP1FFPCL/qEXUn72+J9VJoJd1N
         Ajr+WyqAJ9gPVT1zguCt9z28Zkoyo1vLDTOYXRLWutTq5dMs+dI2+QVecUrbf0eKNl7H
         VSRszMo9QPk6Zcpw7mKQNOLtT7Le+ent8wAJELdCpPdsCNzYcSW/Iuh3L+zFTDpSJgHI
         GYuQ==
X-Gm-Message-State: AOJu0YwtQ89BvSjk+EsQu6axQOUG2eFYDnujkmn0GB044oGBchY5Pjte
        yaoHcG9KsPGF1KqjyfMWwM6M3kDc4A==
X-Google-Smtp-Source: AGHT+IH9dYLjKjyRbNLNxCGr2aitLHgL/WpSDYrBjYwtMgmm0ESrkkcaR7vIKbmh3YnCCkjUMn1Eug==
X-Received: by 2002:a17:906:30db:b0:9b2:f941:6916 with SMTP id b27-20020a17090630db00b009b2f9416916mr13677295ejb.17.1696832096832;
        Sun, 08 Oct 2023 23:14:56 -0700 (PDT)
Received: from p183 ([46.53.254.83])
        by smtp.gmail.com with ESMTPSA id f16-20020a1709062c5000b00992e94bcfabsm6261019ejh.167.2023.10.08.23.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 23:14:55 -0700 (PDT)
Date:   Mon, 9 Oct 2023 09:14:53 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org, hughd@google.com,
        swarupkotikalapudi@gmail.com
Subject: Re: + selftests-proc-add-proc-pid-statm-output-validation.patch
 added to mm-nonmm-unstable branch
Message-ID: <9ce82fc2-4e09-40c4-b5a5-a9a049c2f493@p183>
References: <20231004201701.87CB5C433C7@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231004201701.87CB5C433C7@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 01:17:00PM -0700, Andrew Morton wrote:
> 
> The patch titled
>      Subject: selftests: proc: add /proc/$(pid)/statm output validation
> has been added to the -mm mm-nonmm-unstable branch.  Its filename is
>      selftests-proc-add-proc-pid-statm-output-validation.patch
> 
> This patch will shortly appear at
>      https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/selftests-proc-add-proc-pid-statm-output-validation.patch
> 
> This patch will later appear in the mm-nonmm-unstable branch at
>     git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> 
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
> 
> *** Remember to use Documentation/process/submit-checklist.rst when testing your code ***
> 
> The -mm tree is included into linux-next via the mm-everything
> branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> and is updated there every 2-3 working days
> 
> ------------------------------------------------------
> From: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
> Subject: selftests: proc: add /proc/$(pid)/statm output validation
> Date: Wed, 4 Oct 2023 01:13:19 +0530
> 
> Add /proc/${pid}/statm validation
> 
> /proc/$(pid)/statm output is expected to be:
>  "0 0 0 * 0 0 0\n"
> Here * can be any value
> 
> Read output of /proc/$(pid)/statm and check except for 4th position, all
> other positions have value zero.
> 
> Link: https://lkml.kernel.org/r/20231003194319.602646-1-swarupkotikalapudi@gmail.com
> Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  tools/testing/selftests/proc/proc-empty-vm.c |   57 +++++++++++++++--
>  1 file changed, 52 insertions(+), 5 deletions(-)
> 
> --- a/tools/testing/selftests/proc/proc-empty-vm.c~selftests-proc-add-proc-pid-statm-output-validation
> +++ a/tools/testing/selftests/proc/proc-empty-vm.c
> @@ -303,6 +303,56 @@ static int test_proc_pid_smaps_rollup(pi
>  	}
>  }
>  
> +static int test_proc_pid_statm(pid_t pid)
> +{
> +	char buf[4096];
> +	char *tok;
> +	char *string;
> +	int non_zero_value_indx = 4;
> +	int i = 1;
> +
> +	snprintf(buf, sizeof(buf), "/proc/%u/statm", pid);
> +
> +	/*
> +	 *  Output can be "0 0 0 2 0 0 0\n" where "2" can be anything.
> +	 */
> +	int fd = open(buf, O_RDONLY);
> +
> +	if (fd == -1) {
> +		if (errno == ENOENT) {
> +			/*
> +			 * /proc/${pid}/statm is under CONFIG_PROC_PAGE_MONITOR,
> +			 * it doesn't necessarily exist.
> +			 */
> +			return EXIT_SUCCESS;
> +		}
> +		perror("open /proc/${pid}/statm");
> +		return EXIT_FAILURE;
> +	} else {
> +		ssize_t rv = read(fd, buf, sizeof(buf));
> +
> +		close(fd);
> +		assert(rv);
> +		string = buf;
> +
> +		while ((tok = strsep(&string, " ")) != NULL) {

This is unreliable too. read() doesn't terminate the buffer so this relies
on termination from

	snprintf(buf, sizeof(buf), "/proc/%u/statm", pid);

Buggy kernel could return a lot of data and overwrite it.
