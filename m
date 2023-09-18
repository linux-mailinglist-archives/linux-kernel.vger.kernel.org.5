Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E637A4CA6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjIRPh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjIRPhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:37:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9933CDA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:34:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 932F11FF72;
        Mon, 18 Sep 2023 14:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695048846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zHsVRFl6rPyVqnKaEgGX1HZU0nfHZaiZ6CbMuC7hMUA=;
        b=tHbh1bbltaOTZnr54cnvuC2rr5akMswYgtduL8Yjl6rPAoCEJSAhXm2wqIkBfJ34DYEVTA
        FlIGrjchHv7y9txKdN+Hp96tZW1Mn+5lXi+ZfCsIxySUUVlupRsFHdFRM4itGOHHm52LQy
        SxRos0R91Ycy6vt9Nnz85+X8TfaiIiI=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4BA872C142;
        Mon, 18 Sep 2023 14:54:06 +0000 (UTC)
Date:   Mon, 18 Sep 2023 16:54:04 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v5 0/8] provide nbcon base
Message-ID: <ZQhkjGxX_Wmo-v0J@alley>
References: <20230916192007.608398-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916192007.608398-1-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2023-09-16 21:25:59, John Ogness wrote:
> Hi,
> 
> This is v5 of a series to introduce the new non-BKL (nbcon)
> consoles. v4 is here [0]. For information about the motivation
> of the atomic consoles, please read the cover letter of v1 [1].
> 
> This series focuses on providing the base functionality of the
> nbcon consoles. In particular, it implements the ownership and
> priority semantics for nbcon consoles. This series does _not_
> include threaded printing, atomic printing regions, or nbcon
> drivers. Those features will be added in separate follow-up
> series.

This series seems to be ready for linux-next and I am going to
push it.

Thanks a lot for the effort.

Best Regards,
Petr
