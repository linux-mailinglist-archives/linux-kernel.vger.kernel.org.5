Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEB37B2FFE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjI2K1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjI2K1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:27:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACF31B2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 03:27:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 987CD218E9;
        Fri, 29 Sep 2023 10:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695983268;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SSM2CUNa/Ilu7nDhX/B4+EnQYiLOFqVThu4qsuv5N14=;
        b=Cigw90SiOosqBvwwuH5jwKBbtcNFtdUb1w3UHTY3QHbKFLEL6w/WYXDbv6kYGMKXVzwoa1
        x7cpsD1tDlTYOjbvGG5dYWTZvIDNBoA5AhgCYvG2eIn/QTnq6FqhZ0SjRhT8wlaFWH3Wg7
        xzkLVduXeVBcs8+hKuOf6W89jkehoKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695983268;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SSM2CUNa/Ilu7nDhX/B4+EnQYiLOFqVThu4qsuv5N14=;
        b=ofDiPoEpTr1d4bfBisoGYaY0NLXzQS3MPzdqviFZ5ArkZKKEKkYAABrtVFHrUQedq1FHSU
        qCWCTTimWqLDzcAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C0E31390A;
        Fri, 29 Sep 2023 10:27:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BbNxEKSmFmXpJgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 29 Sep 2023 10:27:48 +0000
Date:   Fri, 29 Sep 2023 12:27:46 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it, linux-kernel@vger.kernel.org,
        libc-alpha@sourceware.org, lwn@lwn.net, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, Cyril Hrubis <chrubis@suse.cz>
Subject: Re: The Linux Test Project has been released for SEPTEMBER 2023
Message-ID: <20230929102746.GA370555@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230929095144.GD364346@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929095144.GD364346@pevik>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

...
> The latest version of the test-suite contains 3000+ tests for the Linux
> and can be downloaded at:

> https://github.com/linux-test-project/ltp/releases/tag/YYYYMMDD

https://github.com/linux-test-project/ltp/releases/tag/20230929

I'm sorry for the noise.

Kind regards,
Petr
