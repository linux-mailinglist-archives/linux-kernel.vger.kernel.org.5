Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353197D90E7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbjJ0IRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjJ0IRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:17:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E47A1AD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:16:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698394617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5vqjsZQYzkOpkucTBtbfABYZjar3BHhvV65+VQJpg9Y=;
        b=zS5ulztE7PU8MnShxIs7VrTd0CKk1xtpWwCHPbF/RsEGHPnUsJW9fVOIMxxIVfyvuHuAha
        LPw+yYTxXhKqa14bSpOylicHntafilOUmrbheskp7KVj+6aX+kYka9/ELj0vBu1nLc8ILJ
        sfTQkveNfNSdk9kCBnfexnXjWmlXSIrEFYF8rblhfiiz1Dr7yjU2syb7695eaXz/3aRoFf
        0DxIl/C1LmC7C3fkmj9QxZjK5C8EuDWeJpyc0/5yQndWO98EgaZud5/uldvzZGfTqG+UTG
        ixlEJqpaRaA/Wl2ztEanrS4P74jevuHSZ7soXFhNmQEHm7laeijaqygkH8gftA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698394617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5vqjsZQYzkOpkucTBtbfABYZjar3BHhvV65+VQJpg9Y=;
        b=08TZ7D6ati0sg+R/lxzQ+pgDAnEKRgsqaZOzqlAbAbnkiufOGVpd5GRU8cK7zms6t4cNfL
        stcBFT3ux+wH9nAg==
To:     Fang Xiang <fangxiang3@xiaomi.com>, maz@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     fangxiang3@xiaomi.com
Subject: Re: [PATCH v2] irqchip/gic-v3-its: Flush ITS tables before writing
 GITS_BASER<n> registers in non-coherent GIC designs.
In-Reply-To: <20231027031007.2088-1-fangxiang3@xiaomi.com>
References: <20231027031007.2088-1-fangxiang3@xiaomi.com>
Date:   Fri, 27 Oct 2023 10:16:57 +0200
Message-ID: <87v8as32fa.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27 2023 at 11:10, Fang Xiang wrote:
> In non-coherent GIC design, ITS tables should be clean and flushed
> to the PoV of the ITS before writing GITS_BASER<n> registers. And
> hoist the quirked non-shareable attributes earlier to save effort
> in tables setup.
>
> Signed-off-by: Fang Xiang <fangxiang3@xiaomi.com>

Seriously? You claim authorship for a patch which was written by Marc:

   https://lore.kernel.org/all/87sf5x6cdu.wl-maz@kernel.org

without even the courtesy of giving him credit via 'Originally-by' ?

That's not how it works.

Thanks,

        tglx
