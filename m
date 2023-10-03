Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AA67B6270
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjJCHCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239611AbjJCHBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:01:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3F12D6D
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 23:58:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7BC972188B;
        Tue,  3 Oct 2023 06:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1696316334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GYtCgJ3rFZ9kELQnTwdyPMMMvpMMoEj8v+7eDg9mxbM=;
        b=2JzYM2HS3wkAuIOJjkEFH6fVsYggUcTqfJxaPqPh+Nj/jNggHlRYtvO0M61dRMvyg65My8
        tR4RWcLbIzuP27soWaEw0uhOVqiA7zbWR4tFE7je0HnJJ3cD0AwTwIEySEgaAwpjSd9mwa
        FQj8gMxKfalwtjY53xnXkznCfcDTWAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1696316334;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GYtCgJ3rFZ9kELQnTwdyPMMMvpMMoEj8v+7eDg9mxbM=;
        b=2hB7uZkX1WfIHvigrv4+8oZxmdklyaXhXDSixVXQF5pKvUMinB5jr5OK1Zz8UYOxHNZ0u0
        1nKQoBKZFlac14Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 47092139F9;
        Tue,  3 Oct 2023 06:58:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n5OSD667G2V5DAAAMHmgww
        (envelope-from <jdelvare@suse.de>); Tue, 03 Oct 2023 06:58:54 +0000
Date:   Tue, 3 Oct 2023 08:58:52 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH] eeprom: Remove deprecated legacy eeprom driver
Message-ID: <20231003085852.3ca85c28@endymion.delvare>
In-Reply-To: <18241458-52db-4537-bead-d570801253c3@gmail.com>
References: <18241458-52db-4537-bead-d570801253c3@gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2023 23:49:09 +0200, Heiner Kallweit wrote:
> Driver was marked deprecated 4 years ago, so it's time to remove it.
> This driver is the only i2c client driver using class I2C_CLASS_SPD.
> Apparently, as a follow-up step, we can remove I2C_CLASS_SPD
> altogether.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/misc/eeprom/Kconfig  |  14 ---
>  drivers/misc/eeprom/Makefile |   1 -
>  drivers/misc/eeprom/eeprom.c | 214 -----------------------------------
>  3 files changed, 229 deletions(-)
>  delete mode 100644 drivers/misc/eeprom/eeprom.c
> (...)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

Thanks,
-- 
Jean Delvare
SUSE L3 Support
