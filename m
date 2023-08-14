Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B128877BE56
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjHNQpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjHNQpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:45:05 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE43BD2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:45:04 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 31A8F40E0185;
        Mon, 14 Aug 2023 16:45:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8veT9hBcmqeZ; Mon, 14 Aug 2023 16:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692031500; bh=+9AbNnnhC+iM+H1yvYLtDl/MP14/nozr8xQE8R57ZdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QIuIYdatxtRyva1+XDm0W5sVrQPm7HARBLt2oz+eC63yRGQmlZVB3MZ1JWoN6CiDv
         StvsKkOnid7crwTppRqATt8DbLNZkhGL94gT8QSKpnVok6pjLSEjc/yyLBz8E1EYDd
         b+KhprxY+kBgvREna38sDXukedySbgAEnd2JccUmMhOEltCf1UL0te+uVYs6ifDCZf
         nbqMgBL46KCB+Uu00d3W12u9X30bnqhRcwoYvcRhGNP1NUQEfSyD1yfApfgZixCx4Z
         HUpsPEvQ/9J0MSOzpzNOzcG8q9O8xz50Q7AXpjAfgjKOFZp2RGctEidfQkyOm2BTzO
         8Z1KXvjxYzDRP8zOjsQv1wwi7IfkbsgFqlfSgJpQIXSMfnCwvtuo/zKzDYkyjW8EYM
         DPYdUSwR2IaowkRjp31eTqfDxOHRQe5BbxxxRJjnvpd6v3Q8dNWI9+z/mex1GhLAZA
         7yKMDaxLoyyg+9xSLf78gmf8enUf2gda9zQEA7CrjzGiIxzTOxYYX2GYF3bDmnQJEQ
         HybWSpw96ndFyiM43oSmSJfDfaTLlVKIHiculcEC2yuOo8FRYqLvOUkOBgasPLvwiP
         CZni+LVls+y5BawghNHULAm9546e9oQ5lsjcI70tAF6lLTrfjOgfuSxwgJ7yjQmw98
         VVso0c+nGBB2dS6zps78wNYM=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D83B740E0196;
        Mon, 14 Aug 2023 16:44:51 +0000 (UTC)
Date:   Mon, 14 Aug 2023 18:44:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, nik.borisov@suse.com
Subject: Re: [PATCH v2 00/11] Fix up SRSO stuff
Message-ID: <20230814164447.GFZNpZ/64H4lENIe94@fat_crate.local>
References: <20230814114426.057251214@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230814114426.057251214@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 01:44:26PM +0200, Peter Zijlstra wrote:
> The one open techinical issue I have with the mitigation is the alignment of
> the RET inside srso_safe_ret(). The details given for retbleed stated that RET
> should be on a 64byte boundary, which is not the case here.

I have written this in the hope to make this more clear:

/*
 * Some generic notes on the untraining sequences:
 *
 * They are interchangeable when it comes to flushing potentially wrong
 * RET predictions from the BTB.
 *
 * The SRSO Zen1/2 (MOVABS) untraining sequence is longer than the
 * Retbleed sequence because the return sequence done there
 * (srso_safe_ret()) is longer and the return sequence must fully nest
 * (end before) the untraining sequence. Therefore, the untraining
 * sequence must overlap the return sequence.
 *
 * Regarding alignment - the instructions which need to be untrained,
 * must all start at a cacheline boundary for Zen1/2 generations. That
 * is, both the ret in zen_untrain_ret() and srso_safe_ret() in the
 * srso_untrain_ret() must both be placed at the beginning of
 * a cacheline.
 */

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
