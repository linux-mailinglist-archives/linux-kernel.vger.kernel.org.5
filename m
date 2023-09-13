Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C19279EB83
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241543AbjIMOrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241506AbjIMOrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:47:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3827AB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:47:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9E30C1F385;
        Wed, 13 Sep 2023 14:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694616449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=91ytSZhAZZJxRLS51DPAMbgyIGi3HFabuhDgqq8+ZcY=;
        b=pqlznT6UI67IMPdHtm8FZNrlprjno9lQRxR/VNssD6mG4gJMCHrMmzrN2gwPJeb6GxBC0B
        bWPDmDYM8Z4KwfYEDP09Csi0E7YrqjnA6DQ+3BzmZv2h6zXZMjoUcxRdaZRwxENDje5pdG
        2e1Ug5Swug0e0lzs0YBrtjGk9BeF728=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694616449;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=91ytSZhAZZJxRLS51DPAMbgyIGi3HFabuhDgqq8+ZcY=;
        b=dtYqore8nc2Jlv7dpegTaDv40gsMQCTVkFUEzhxShCWbxdRvoN4pCFIdbBK1zENcYRL/3N
        HAZb6p0s7GZSs1DA==
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id 077842C142;
        Wed, 13 Sep 2023 14:47:29 +0000 (UTC)
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
        id D571C4A04B1; Wed, 13 Sep 2023 16:47:28 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     suagrfillet@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, anup@brainfault.org, alex@ghiti.fr,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: BUG Report: Some issues about vmlinux with emit-relocs
In-Reply-To: <mhng-0208249f-0619-4be7-bbc7-e1c0ee6e3c8c@palmer-ri-x1c9>
        (Palmer Dabbelt's message of "Wed, 13 Sep 2023 07:30:48 -0700 (PDT)")
References: <20230808085438.3445957-1-suagrfillet@gmail.com>
        <mhng-0208249f-0619-4be7-bbc7-e1c0ee6e3c8c@palmer-ri-x1c9>
X-Yow:  My nose feels like a bad Ronald Reagan movie...
Date:   Wed, 13 Sep 2023 16:47:28 +0200
Message-ID: <mvmcyymxh8f.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 13 2023, Palmer Dabbelt wrote:

> Having R_RISCV_NONE in any binary is a bug, it's not a real relocation
> just an internal binutils thing.

That's not true.  It's an official part of the ELF psABI.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
