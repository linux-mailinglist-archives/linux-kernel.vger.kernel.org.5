Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7710C7BE90E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377304AbjJISRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbjJISRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:17:05 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04269C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:17:03 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c6219307b2so28643145ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696875423; x=1697480223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3wxbTWey7VYS/X8pZf6468es0EsAe+MV/D8mmu8Us/k=;
        b=kxTJ1T70TEk8PaSubz5OhYdwBui3gxCaGKYZbKkrALpcWpNvo5toHcQTutE+wzLDid
         8koFHakZo10FJsL15/+nyw4FILo2QEqDO9109n5tuMq616ivO67XwW9DVDvvh5+cNY60
         u5OvtofaqgolShNrT5GZstmXyvOO7983YMCCrFU00WUCGm+UXBSL4TzAC6DkcjnWSirU
         ZYKl5THljsMFRCNYQxjDIzHC1L1ey5wy8lzG/K61udANr8yt6R3pEh/lv3eieuiqcZOn
         UuQnHtO1MkRiSDObHOkrKQnHVLNc/VcnYEpIUUY/s4wx+VKBqzmMgc6Ej6Pkh2+OEF2q
         Hk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696875423; x=1697480223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wxbTWey7VYS/X8pZf6468es0EsAe+MV/D8mmu8Us/k=;
        b=dWi80VmalfJlgEriMNOquklYV9XSFBkUV3cv3kY6fMvxGv/zrDZVkpVC/FJ7jYYBLI
         HXiK82H39OE1tEmsFHH0ORtHb2L1DSI7JdysJLzZLBii51sWwV23zKky2MjE7lcZLE6S
         LRW0xGuL5CJcZUNWtl6jY39k6g+UmYD8NDsTB0bgR6Dew8wpZyEo0N3+COcx41BFCLN1
         rlNY72lbdXQkf0A/bp2XW61BqxI+4SuZU0yUg4oTdHlMXymKhsJCkJ+Amk1yGw85Df8n
         cY9p5UrSPssbJgW9h4VxJATO82c2ZEZgKWCMkXnNKOvRFqqyZD7s8550P7uM2n1/Rp8J
         zz8g==
X-Gm-Message-State: AOJu0YwX1jwflfyWDgNBZ1ygd9o2BlNaQcI3bnku6G7Ku5nM0rE/KMR9
        nWPcgelQJPBBnHEEHYjuqpOQx4ItsRPPuhLI
X-Google-Smtp-Source: AGHT+IGzKSHHX2xUeM7emFya8q1AK+biM8I2HXwPqC4MGwzzUhmRwGYN3ARvXRvNQ6qzj815S/gWNA==
X-Received: by 2002:a17:902:efc4:b0:1c5:ad14:9095 with SMTP id ja4-20020a170902efc400b001c5ad149095mr10888439plb.64.1696875423090;
        Mon, 09 Oct 2023 11:17:03 -0700 (PDT)
Received: from swarup-virtual-machine ([171.76.87.78])
        by smtp.gmail.com with ESMTPSA id jj22-20020a170903049600b001c62c9d7289sm9911788plb.104.2023.10.09.11.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:17:02 -0700 (PDT)
Date:   Mon, 9 Oct 2023 23:46:57 +0530
From:   swarup <swarupkotikalapudi@gmail.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org, hughd@google.com
Subject: Re: + selftests-proc-add-proc-pid-statm-output-validation.patch
 added to mm-nonmm-unstable branch
Message-ID: <ZSRDmTwxARRENuqK@swarup-virtual-machine>
References: <20231004201701.87CB5C433C7@smtp.kernel.org>
 <9ce82fc2-4e09-40c4-b5a5-a9a049c2f493@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ce82fc2-4e09-40c4-b5a5-a9a049c2f493@p183>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

eOn Mon, Oct 09, 2023 at 09:14:53AM +0300, Alexey Dobriyan wrote:
> On Wed, Oct 04, 2023 at 01:17:00PM -0700, Andrew Morton wrote:
> > 
> > The patch titled
> >      Subject: selftests: proc: add /proc/$(pid)/statm output validation
> > has been added to the -mm mm-nonmm-unstable branch.  Its filename is
> >      selftests-proc-add-proc-pid-statm-output-validation.patch
> > 
> > This patch will shortly appear at
> >      https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/selftests-proc-add-proc-pid-statm-output-validation.patch
> > 
> > This patch will later appear in the mm-nonmm-unstable branch at
> >     git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > 
> > Before you just go and hit "reply", please:
> >    a) Consider who else should be cc'ed
> >    b) Prefer to cc a suitable mailing list as well
> >    c) Ideally: find the original patch on the mailing list and do a
> >       reply-to-all to that, adding suitable additional cc's
> > 
> > *** Remember to use Documentation/process/submit-checklist.rst when testing your code ***
> > 
> > The -mm tree is included into linux-next via the mm-everything
> > branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > and is updated there every 2-3 working days
> > 
> > ------------------------------------------------------
> > From: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
> > Subject: selftests: proc: add /proc/$(pid)/statm output validation
> > Date: Wed, 4 Oct 2023 01:13:19 +0530
> > 
> > Add /proc/${pid}/statm validation
> > 
> > /proc/$(pid)/statm output is expected to be:
> >  "0 0 0 * 0 0 0\n"
> > Here * can be any value
> > 
> > Read output of /proc/$(pid)/statm and check except for 4th position, all
> > other positions have value zero.
> > 
> > Link: https://lkml.kernel.org/r/20231003194319.602646-1-swarupkotikalapudi@gmail.com
> > Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
> > Cc: Alexey Dobriyan <adobriyan@gmail.com>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> > 
> >  tools/testing/selftests/proc/proc-empty-vm.c |   57 +++++++++++++++--
> >  1 file changed, 52 insertions(+), 5 deletions(-)
> > 
> > --- a/tools/testing/selftests/proc/proc-empty-vm.c~selftests-proc-add-proc-pid-statm-output-validation
> > +++ a/tools/testing/selftests/proc/proc-empty-vm.c
> > @@ -303,6 +303,56 @@ static int test_proc_pid_smaps_rollup(pi
> >  	}
> >  }
> >  
> > +static int test_proc_pid_statm(pid_t pid)
> > +{
> > +	char buf[4096];
> > +	char *tok;
> > +	char *string;
> > +	int non_zero_value_indx = 4;
> > +	int i = 1;
> > +
> > +	snprintf(buf, sizeof(buf), "/proc/%u/statm", pid);
> > +
> > +	/*
> > +	 *  Output can be "0 0 0 2 0 0 0\n" where "2" can be anything.
> > +	 */
> > +	int fd = open(buf, O_RDONLY);
> > +
> > +	if (fd == -1) {
> > +		if (errno == ENOENT) {
> > +			/*
> > +			 * /proc/${pid}/statm is under CONFIG_PROC_PAGE_MONITOR,
> > +			 * it doesn't necessarily exist.
> > +			 */
> > +			return EXIT_SUCCESS;
> > +		}
> > +		perror("open /proc/${pid}/statm");
> > +		return EXIT_FAILURE;
> > +	} else {
> > +		ssize_t rv = read(fd, buf, sizeof(buf));
> > +
> > +		close(fd);
> > +		assert(rv);
> > +		string = buf;
> > +
> > +		while ((tok = strsep(&string, " ")) != NULL) {
> 
> This is unreliable too. read() doesn't terminate the buffer so this relies
> on termination from
> 
> 	snprintf(buf, sizeof(buf), "/proc/%u/statm", pid);
> 
> Buggy kernel could return a lot of data and overwrite it.

Hi Alexey Dobriyan,
I will try to correct read() function.
Thanks,
Swarup
