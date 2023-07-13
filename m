Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EAD7527CC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjGMPzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjGMPze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:55:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9D22709
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:55:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CB5A62215A;
        Thu, 13 Jul 2023 15:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689263730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=412n7lYoKjHlbIlZLjKAZjKE+o1hSuNXSIeZkXwjckE=;
        b=FEGMnaRzRtZWgYklNcgw0HLJ/Fy1kduOwuf7hMk3OVGkYHDyfrFFpsHL/NVn4aI6PN8LXE
        Gxhm9MyRtcJCFu6G2U+0jG9ODmzADSzqxNVecpzF4eEL8ko16DgIVMN37norodXcRg/lG6
        mE73Qc3xXJqr9kgMyEW7noVlxbIlSwk=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9F94B2C142;
        Thu, 13 Jul 2023 15:55:30 +0000 (UTC)
Date:   Thu, 13 Jul 2023 17:55:30 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 5/5] printk: Rename
 abandon_console_lock_in_panic() to other_cpu_in_panic()
Message-ID: <ZLAecmAnR_fdgzo-@alley>
References: <20230710134524.25232-1-john.ogness@linutronix.de>
 <20230710134524.25232-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710134524.25232-6-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-07-10 15:51:24, John Ogness wrote:
> Currently abandon_console_lock_in_panic() is only used to determine if
> the current CPU should immediately release the console lock because
> another CPU is in panic. However, later this function will be used by
> the CPU to immediately release other resources in this situation.
> 
> Rename the function to other_cpu_in_panic(), which is a better
> description and does not assume it is related to the console lock.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Looks good:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
