Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25207D34B2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjJWLmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbjJWLmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:42:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC101733;
        Mon, 23 Oct 2023 04:41:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9C376218E0;
        Mon, 23 Oct 2023 11:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698061300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q3h7bYkmxNuybyYNDcveX5DD2P/BKzeu6mm/kPPgPdU=;
        b=h/G7ygAoWyM5zG8eKGcVm8HrcWPzEDEivri0BJSGDEgVhXNBapQpqLSY/8WomkLmxcWnPW
        Qd/etiyPEqAW5IiWxf5u3MHWyFl6LJVnk1+HZFFADVEBlP4wT4UihwYeIKatbtOywQW/Ot
        59VmbHbqJsX44/2IWsJWPT+BxFhrie8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698061300;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q3h7bYkmxNuybyYNDcveX5DD2P/BKzeu6mm/kPPgPdU=;
        b=TfEkAPS+RDAVdr1D6jh0FO7uRl0fz6n7JS5sAVCpeRIX8ZVWMqM1dosMUdnVhvssKVsGwC
        bSetY7o4jXdTWfDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55407139C2;
        Mon, 23 Oct 2023 11:41:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q2VGE/RbNmWTDQAAMHmgww
        (envelope-from <jdelvare@suse.de>); Mon, 23 Oct 2023 11:41:40 +0000
Date:   Mon, 23 Oct 2023 13:41:39 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eeprom: remove doc and MAINTAINERS section after driver
 was removed
Message-ID: <20231023134139.66e95a04@endymion.delvare>
In-Reply-To: <20231012042834.6663-1-lukas.bulwahn@gmail.com>
References: <20231012042834.6663-1-lukas.bulwahn@gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -3.75
X-Spamd-Result: default: False [-3.75 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-1.15)[88.68%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         HAS_ORG_HEADER(0.00)[];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[8];
         FREEMAIL_TO(0.00)[gmail.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[];
         FREEMAIL_CC(0.00)[arndb.de,linuxfoundation.org,gmail.com,lwn.net,vger.kernel.org]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 06:28:34 +0200, Lukas Bulwahn wrote:
> Commit 0113a99b8a75 ("eeprom: Remove deprecated legacy eeprom driver")
> already removes the eeprom driver's code.
> 
> Remove also the eeprom driver's documentation and MAINTAINERS section.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Greg, please pick this patch into your -next char and misc tree on top
> of the commit above.
> 
>  Documentation/misc-devices/eeprom.rst | 107 --------------------------
>  Documentation/misc-devices/index.rst  |   1 -
>  MAINTAINERS                           |   6 --
>  3 files changed, 114 deletions(-)
>  delete mode 100644 Documentation/misc-devices/eeprom.rst
> (...)

Probably too late, but anyway:

Reviewed-by: Jean Delvare <jdelvare@suse.de>

Thanks,
-- 
Jean Delvare
SUSE L3 Support
