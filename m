Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F20677CD9B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 15:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237445AbjHONzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 09:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237493AbjHONzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 09:55:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C653199B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 06:55:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 32C941F38D;
        Tue, 15 Aug 2023 13:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692107718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CnQRY7NVeWs4bLVHobB6JZkseOdtCa+oEP9pm8tfNgI=;
        b=bA99ITdjvjy3z4cuhTjmxo5fvxcX99oH3U0eh4ydkIq/PMQObZVTZKTcVpoqNa6k2lWEIj
        BUBvcCOGFe88xk1tmyGsmPWqsO48vg9RDQFtBZX5t1jSi6P/v0ZlkuOIt6QxvHsSSFXlRM
        jlABB+QroNA6EVb4s/hdXhG7Jn5voFM=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B479F2C143;
        Tue, 15 Aug 2023 13:55:17 +0000 (UTC)
Date:   Tue, 15 Aug 2023 15:55:16 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Yunlong Xing <yunlong.xing@unisoc.com>
Cc:     senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, linux-kernel@vger.kernel.org,
        enlinmu@gmail.com, enlin.mu@unisoc.com, yunlong.xing23@gmail.com
Subject: Re: [PATCH] printk: export symbols for debug modules
Message-ID: <ZNuDxFGoXPCwECyt@alley>
References: <20230815020711.2604939-1-yunlong.xing@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815020711.2604939-1-yunlong.xing@unisoc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-08-15 10:07:11, Yunlong Xing wrote:
> From: Enlin Mu <enlin.mu@unisoc.com>
> 
> the module is out-of-tree, it saves kernel logs when panic
> 
> Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>

I am fine with it. After all, this API seems to here for
similar purposes.

Acked-by: Petr Mladek <pmladek@suse.com>

Of course, it would be better to maintain the module in upstream.
Is there any chance to get it upstream? It seems that it
is GPL-compatible so...

Best Regards,
Petr
