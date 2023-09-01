Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0A878F955
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 09:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241228AbjIAHvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 03:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjIAHvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 03:51:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E4310D5;
        Fri,  1 Sep 2023 00:51:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 68F771F459;
        Fri,  1 Sep 2023 07:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693554697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n/8D9s41YY7J3sh9R/MGNFCXqgffkEDqPYgXj5iMVE8=;
        b=L4UjQdvnuq/TFRV2jnDjERtQOcugeYNRUZhwHRnApmx2S6iT3PRHmduKFV1cBwXBgAoTBf
        A/K83Rp3eG710ZvfoA/v9m1dNbWZcWnWzS/Wb0DtE21forS45FrIkiNFRfbmPVFJC7j7nr
        hLR0U/RBrK0t6Ig61FwLdextST9wQnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693554697;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n/8D9s41YY7J3sh9R/MGNFCXqgffkEDqPYgXj5iMVE8=;
        b=7lmYQbdXEpJSr/Lodxm950zOl81DG74NMPm1uiiGiSOXgCfDDzbTosXw1LKlcABWL8kZ7y
        TwJdpPE4SxHsi4Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31A031358B;
        Fri,  1 Sep 2023 07:51:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vmHlCAiY8WS3CwAAMHmgww
        (envelope-from <aherrmann@suse.de>); Fri, 01 Sep 2023 07:51:36 +0000
Date:   Fri, 1 Sep 2023 09:52:54 +0200
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
        Radu Rendec <rrendec@redhat.com>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Pu Wen <puwen@hygon.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        stable@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] x86/cacheinfo: Set the number of leaves per CPU
Message-ID: <20230901075254.GH8103@alberich>
References: <20230805012421.7002-1-ricardo.neri-calderon@linux.intel.com>
 <20230901065028.GG8103@alberich>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230901065028.GG8103@alberich>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 08:50:31AM +0200, Andreas Herrmann wrote:
> On Fri, Aug 04, 2023 at 06:24:18PM -0700, Ricardo Neri wrote:
> > Hi,
> 
> Hi Ricardo,
> 
> > This is v3 of a patchset to set the number of cache leaves independently
> > for each CPU. v1 and v2 can be found here [1] and here [2].
> 
> I am on CC of your patch set and glanced through it.
> Long ago I've touched related code but now I am not really up-to-date
> to do a qualified review in this area. First, I would have to look
> into documentation to refresh my memory etc. pp.
> 
> I've not seen (or it escaped me) information that this was tested on a
> variety of machines that might be affected by this change. And there
> are no Tested-by-tags.
> 
> Even if changes look simple and reasonable they can cause issues.
> 
> Thus from my POV it would be good to have some information what tests
> were done. I am not asking to test on all possible systems but just
> knowing which system(s) was (were) used for functional testing is of
> value.

Doing a good review -- trying to catch every flaw -- is really hard to
do. Especially when you are not actively doing development work in an
area.

For example see

  commit e33b93650fc5 ("blk-iocost: Pass gendisk to ioc_refresh_params")
  [Breno Leitao <leitao@debian.org>, Tue Feb 28 03:16:54 2023 -0800]

This fixes commit

  ce57b558604e ("blk-rq-qos: make rq_qos_add and rq_qos_del more
  useful") [Christoph Hellwig <hch@lst.de>, Fri Feb 3 16:03:54 2023
  +0100]

I had reviewed the latter (see
https://marc.info/?i=Y8plg6OAa4lrnyZZ@suselix) and the entire patch
series. I've compared the original code with the patch and walked
through every single hunk of the diff and tried to think it
through. The changes made sense to me. Then came the bug report(s) and
I felt that I had failed tremendously. To err is human.

What this shows (and it is already known): with every patch new errors
are potentially introduced in the kernel. Functional, and higher
level testing can help to spot them before a kernel is deployed in the
field.

At a higher level view this proves another thing.
Linux kernel development is a transparent example of
"peer-review-process".

In our scientific age it is often postulated that peer review is the
way to go[1] and that it kind of guarantees that what's published, or
rolled out, is reasonable and "works".

The above sample shows that this process will not catch all flaws and
that proper, transparent and reliable tests are required before
anything is deployed in the field.

This is true for every branch of science.

If it is purposely not done something is fishy.


[1] Also some state that it is "the only way to go" and every thing
figured out without a peer-review-process is false and can't be
trusted. Of course this is a false statement.

-- 
Regards,
Andreas

SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nürnberg, Germany
GF: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG Nürnberg)
