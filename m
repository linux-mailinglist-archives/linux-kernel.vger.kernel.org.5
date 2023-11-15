Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37FC7ED681
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbjKOV7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbjKOV7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:59:42 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A991318B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:59:38 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 795AD40E0199;
        Wed, 15 Nov 2023 21:59:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cS1EHJFxfxSI; Wed, 15 Nov 2023 21:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700085574; bh=gnQc3JN9v8kA6tZGKxO8vOCK2sDLkjsw7bhunBDg00M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gtyjtEkzOK8TSa9Q6BymFEgAejpTzQH++8sGhLM7nW89BoZiRIqYv/oQ0uQfHd6QH
         8hgvAw2xf73O/kO5fRQlg41P9CYBA+KuS8Lre6NQQxUX2fnbu9sRwY4E2bQQsqj4hA
         fK2Rkgdlea1lx7fjGCTASJFm7UzG6Scrx+YzL4I4zlodCCLjq9cVABI097NSf3WyNh
         MZYsGeMAxOVyg6JTKe0NugY76PC9+hZDhvDvvCO/LqiF5hZ7abB+5TnJ8p+shBiK+q
         zH83wVWlxWZbF0IpABxqlszUk2EBrKtjDJajC+h68raQo0EC8UacqZjq7gJ9Ez4yfy
         7n6UEIwF1XimU6dUAzWm+xdUPAJRXsJJNJLD2QswvgMmDNfedl7V7sWbeMXF8iRFJo
         uBaMwjhDnBUQ/nP8VzBwAjhAbTT6nvIApqz+1UwkdgL5t2aDAnYwOTcqetTOt6AHgl
         RLFfLCe5e/h7ZrAS6+VfFdwZm75CWF3wZGOii97+UNPLEJlWMV/KktD7cXji5AO3it
         71+7TZNKfgJzVtsghAOKnec5MrO6YVM02+SsqZv/wExkHJaAL86cDNG6L3MZSG8LDZ
         1/5/kAhwP9H9U14PYsPfpQmBnOfLuBG1gnzqQAeCLmpDowdH7yFRxuGKdHbRwp5QnF
         9J1JlehoJkUOeFu4bvjUxSdI=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 224E440E0032;
        Wed, 15 Nov 2023 21:59:18 +0000 (UTC)
Date:   Wed, 15 Nov 2023 22:59:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        David Laight <David.Laight@aculab.com>, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
Message-ID: <20231115215917.GKZVU/NXl5BkyCPt/M@fat_crate.local>
References: <202311061616.cd495695-oliver.sang@intel.com>
 <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
 <4097023.1700084620@warthog.procyon.org.uk>
 <CAHk-=wgR3Mw2-8k2O3S10T-f4oz8FNfg7aziLU_6pbx0qowxew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgR3Mw2-8k2O3S10T-f4oz8FNfg7aziLU_6pbx0qowxew@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 04:50:06PM -0500, Linus Torvalds wrote:
> Sadly, we don't seem to have any obvious #define for "this is not real
> kernel code". We just have a lot of ad-hoc tricks, like removing
> compiler flags and disabling things like KASAN etc on a file-by-file
> (or directory) basis.

Yeah, "untangling" memcpy() has always been a PITA, every time I tried
it. So I'd need to come up with a somewhat sensible scheme of "use this
special memcpy() only in kernel code proper and fallback to the library
version or gcc builtin otherwise"...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
