Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCDE78E27C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344132AbjH3Wnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343986AbjH3Wnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:43:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84C1CEE
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:43:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5631CB8203D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 20:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C5EC433C8;
        Wed, 30 Aug 2023 20:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693428405;
        bh=9PpwDOZlrXxmM5h+/8DH4Tb0Qdk2qGewp9UCJh/JT3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fgke78mPM5hsHAZDMRaxYQZQ1V/50qjDZkXY17NAIz8RR4li2IIZWpcDUhSXQvzx4
         kieFOx+TOYG4fHJcspfcRe6YJuMPxsWV/zVkVYcN+mBHVrdW9sw1RX+zeOoTvPpUYj
         UCFBDdXyZUeSu/OBR8vYd5YzRmB0BoQnA1oriqYo=
Date:   Wed, 30 Aug 2023 22:46:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-coco@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v3 4/5] mm/slab: Add __free() support for kvfree
Message-ID: <2023083034-grimace-panhandle-f332@gregkh>
References: <169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com>
 <169342401666.3934343.5520453508283712955.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169342401666.3934343.5520453508283712955.stgit@dwillia2-xfh.jf.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 12:33:36PM -0700, Dan Williams wrote:
> Allow for the declaration of variables that trigger kvfree() when they
> go out of scope. The check for NULL and call to kvfree() can be elided
> by the compiler in most cases, otherwise without the NULL check an
> unnecessary call to kvfree() may be emitted. Peter proposed a comment
> for this detail [1].
> 
> Link: http://lore.kernel.org/r/20230816103102.GF980931@hirez.programming.kicks-ass.net [1]
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/slab.h |    2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
