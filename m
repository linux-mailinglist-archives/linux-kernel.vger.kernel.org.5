Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC43F7E9717
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 08:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjKMHhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 02:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjKMHhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 02:37:10 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708A410EF;
        Sun, 12 Nov 2023 23:37:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 736C6218BB;
        Mon, 13 Nov 2023 07:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1699861025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ks/7h4ZtJHP9K8LwK/ZBpyhaWgSD033ADJwO3+onHA8=;
        b=XzV/MSc+fh8MO/HliQ6dd6hT+LI6qivOhkZXzKG9ceYbC3p36vK1kxghABdwJczXtY/16Q
        YLTl6GnEIZTx3/JDP6D0sDnEj3YgwAfIHGa6U9H/2ss5VwURylnaHRMKDM/mWEUmXQsWmN
        7jkmay5oXut9JbjtyRiDJ/Ymj5tY2jI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1699861025;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ks/7h4ZtJHP9K8LwK/ZBpyhaWgSD033ADJwO3+onHA8=;
        b=ALek5AabeoPEmfthJ6aL1x/EEWmz1rGnt9a5JzNFkPEbtxbQI+k/wiDKYZN1QFyFBOekhO
        UqF1RizTRCLXZxDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F04C13398;
        Mon, 13 Nov 2023 07:37:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fiiHEiHSUWXEVgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 13 Nov 2023 07:37:05 +0000
Message-ID: <87fa3d2e-6822-0f24-daec-772dbe717b63@suse.cz>
Date:   Mon, 13 Nov 2023 08:37:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] exitz syscall
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>
Cc:     York Jasper Niebuhr <yjnworkstation@gmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-security-module@vger.kernel.org,
        torvalds@linux-foundation.org
References: <20231111125126.11665-1-yjnworkstation@gmail.com>
 <20231111132431.GA3717@1wt.eu> <20231112045217.GA39417@mit.edu>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231112045217.GA39417@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/23 05:52, Theodore Ts'o wrote:
> On Sat, Nov 11, 2023 at 02:24:31PM +0100, Willy Tarreau wrote:
>> Hello,
>> 
>> On Sat, Nov 11, 2023 at 01:51:26PM +0100, York Jasper Niebuhr wrote:
>> > Adds a system call to flag a process' resources to be cleared on
>> > exit (or, in the case of memory, on free). Currently, only zeroing
>> > memory is implemented.
>> (...)
>> 
>> IMHO it does not make sense to add a syscall for this, please have a
>> look at prctl(2) instead, which is already used for similar settings.
> 
> Another reason to use prctl() is there are other cases when you'd want
> to zero a process's memory.  For example, if the process gets killed
> to some kind of signal, or when it gets OOM killed (where there is no
> system call which forces the process to exit).  Also, if you want to
> zero memory when the process exits, you'd want to zero the process
> memory on an exec(2).

Probably also munmap() and maybe a number of other ways where the process
can give up its memory voluntarily. Then there are also involuntary ways
where the a copy of the data can end up leaking elsewhere than the pages the
process has mapped - e.g. swapout/swapin of pages, page migration...

So I'm not sure it's feasible to attempt making a whole process "sensitive"
and close all the holes. Instead what we have is to mark specific areas as
sensitive - things like mlock(), madvise(MADV_DONTDUMP / MADV_DONTFORK) and
ultimately memfd_secret().

> Cheers,
> 
> 						- Ted
> 

