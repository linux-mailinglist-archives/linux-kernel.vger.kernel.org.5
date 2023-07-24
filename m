Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7F275F57D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjGXLxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGXLxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:53:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD0EE5D;
        Mon, 24 Jul 2023 04:53:44 -0700 (PDT)
Received: from nazgul.tnic (unknown [193.118.249.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B51951EC0D1F;
        Mon, 24 Jul 2023 13:53:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690199622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bACLSvsioxv49MYs9XN1df4vLILpl206RVNLYoKxqpo=;
        b=oSl3Q/m8pqnwWocdk1fWcZ4brHhm6Ok1ukSSqc58ZqKAS1pywGBEGVL23mkjgWKTVcOEMJ
        eO7AW8RKkWdzKeCJV8WmeRNo9R63YuwgahETpgRNIpp5N0f74R0OvBeTrPQfKRqJuAY2aJ
        DwLe8BtvkipUK+bf8iGziL6jVCuRhtQ=
Date:   Mon, 24 Jul 2023 13:54:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Niklas Cassel <nks@flawful.org>
Cc:     linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: WARNING: CPU: 1 PID: 67 at drivers/ata/libata-core.c:1688
 ata_read_log_page+0x173/0x1f0
Message-ID: <20230724115420.GAZL5mbE+tlsq6vOdN@fat_crate.local>
References: <20230722155621.GIZLv8JbURKzHtKvQE@fat_crate.local>
 <ZL5lt+9jo1KrnW9b@flawful.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZL5lt+9jo1KrnW9b@flawful.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ hare.

On Mon, Jul 24, 2023 at 01:51:19PM +0200, Niklas Cassel wrote:
> Hello Boris,
> 
> this is a null pointer dereference,
> because ap->ncq_sense_buf buffer is only allocated when CDL is enabled.
> 
> We are not supposed to fetch sense data for successful NCQ commands when
> CDL is not enabled.
> 
> This is my bad.
> Could you please test and see if this patch solves your problem:
> https://lore.kernel.org/linux-ide/20230723130315.427513-1-nks@flawful.org/

Yap, saw it, thanks.

I'll be able to get to it towards the end of the week.

Will let you know,

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
