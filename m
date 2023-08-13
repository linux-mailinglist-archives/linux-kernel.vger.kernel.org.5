Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F1577A5FC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 12:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjHMKhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 06:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHMKhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 06:37:12 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B811709
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 03:37:14 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0853640E0195;
        Sun, 13 Aug 2023 10:37:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kZ0SZAdvw8Qf; Sun, 13 Aug 2023 10:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691923029; bh=5jP41Q4Vr+7H7XwGqAj1QKEni1G/GvoMbtbYY6td0wM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q4MgC1vOTfOasLwcyhQaC57uQc5tIJ0FMVvEOgILPVoyT3QAx8C1PGXjhs7O/bH+V
         uEWo9MO7TTWf5gdEugHL5oWbyEsihR05apf8bFXfwPlzVuhY8Wfq4n3agA0iQNOatt
         9rf3XqgUcQgqakaoI1nuNc0plvTR8xfkaKreydokR90jQ1wmD4Hx85pw8fF6VqcySK
         1tR9ia/hV6cmS+gADRPFxYLJtvjZa5U6A5LhC2rdJTXKIA3LfBfaIxScEgFra6oYJ5
         y/v8eUbKG9Bz8iAgC3MRlL31RScEIJBtbiIBMFXsQJsHHTmsSFlR6mkY8IedoHnspO
         amiSnQnyCLpnAcwvsrIwwawlW+vditnhVLFRgCkmsj5Dhp+0wHQ6yPJoV/zQFTQl/o
         MpOP8TbY+RjKdIDAAPdTrnEaRuNdq2PP00xZg3YxXjCVCSAuV/nqslxNeuYXL+vHYt
         pViSkGyJTZwVh5LZGFBtKV80upgoXhurx9OSjJX8iUZyC611T6QfWUAphMQQuIqjZ3
         6gfkpYW6s7UsbzN4jAStc5hVW8TR23sQOokENXDyOVtgiObND31mki9VUBROc/gUx1
         9XQphUVJ4z3qJQsmIwHZ1H+ufxO5lOhJYJQt8X6YM3LGh6KlInq1NP+UnIdC8v9wSY
         WB35CxhIxH6GiILgYZdjy8D4=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 20F3C40E00B0;
        Sun, 13 Aug 2023 10:37:02 +0000 (UTC)
Date:   Sun, 13 Aug 2023 12:36:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 07/17] x86/cpu/kvm: Provide UNTRAIN_RET_VM
Message-ID: <20230813103657.GCZNiySRVa8TcT7SAW@fat_crate.local>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.922634286@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230809072200.922634286@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:12:25AM +0200, Peter Zijlstra wrote:
> With the difference being that UNTRAIN_RET_VM uses
> X86_FEATURE_IBPB_ON_VMEXIT instead of X86_FEATURE_ENTRY_IBPB.
> 
> This cures VMEXIT doing potentially unret+IBPB or double IBPB.

Can't - I have a separate flag for that and I set it only when !IBPB:

        case SRSO_CMD_IBPB_ON_VMEXIT:
                if (IS_ENABLED(CONFIG_CPU_SRSO)) {
                        if (!boot_cpu_has(X86_FEATURE_ENTRY_IBPB) && has_microcode) {
                                setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);


But I like the separate macro.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
