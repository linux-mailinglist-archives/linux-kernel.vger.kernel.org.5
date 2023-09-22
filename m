Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C78C7AACC9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbjIVIhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbjIVIhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:37:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180EC114
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:37:17 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D212B21890;
        Fri, 22 Sep 2023 08:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695371835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2CqHABqHUufAvV/A7GI/JlrAAexrizdIUmYHFtS9jrA=;
        b=MZ6aAZBsN9UUjPraL8uTbgeEOptzfvU86713N3MO+teglGI0W0FC9QALm38AvfoM+2UMGW
        TcnakaVzHIPPeUDHDexo97Nh2Zxc37PT4wI80wxOOoh4YHT+zKTxB+oCLZE5xuHI++Fk2i
        EdU1co4MQITrm6yZKezvSy5FN4RC+qs=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9B6E12C142;
        Fri, 22 Sep 2023 08:37:15 +0000 (UTC)
Date:   Fri, 22 Sep 2023 10:37:13 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 02/11] printk: Let console_is_usable() handle
 nbcon
Message-ID: <ZQ1SOYYNH0Wr-wQy@alley>
References: <20230919230856.661435-1-john.ogness@linutronix.de>
 <20230919230856.661435-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919230856.661435-3-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-09-20 01:14:47, John Ogness wrote:
> The nbcon consoles use a different printing callback. For nbcon
> consoles, check for the write_atomic() callback instead of
> write().
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
