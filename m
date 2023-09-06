Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A80D794613
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 00:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245013AbjIFWRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 18:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245008AbjIFWRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 18:17:51 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD191BCD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 15:17:43 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-401da71b83cso3764955e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 15:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694038662; x=1694643462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tR7C3FVsqhAx4lDO2Eqv20v8XT8UWkznhQOLHXKHWhg=;
        b=UUDxV/DJ7AT25z74xWIVouDh5EbcBJGSU9/Ztaj6mtP8jhEdraxb5Tp6XUVYcpDyhq
         5gccd+7fpiAeMQ+ZDkJjSKmtuidBy7e3KEHB+r0+nSQnUgXF6gyIDZsxNgPM+CCXNCft
         NkAr05jUL0/o7799djh5UuqbpbIbjYsx8UOiDhtE8oQ7gOf+3HNe9ikWVXdPd3ebj3VF
         e1Tyc5kCdkeHkffhefdnL/UXj9aA/caRkwPUFbzmAbpDMw04odASEK9E3jT3RSjqGafe
         /OGs6D0EQIMyXFNIMbc3ye5uyMDV+/+n0BB+IjhCzXfAP73aWp6t686VJ1uuNvje5IwR
         AB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694038662; x=1694643462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tR7C3FVsqhAx4lDO2Eqv20v8XT8UWkznhQOLHXKHWhg=;
        b=LO2OkDNd6OLTSPDTIrON2gD1siMIrU0rbuXVo+fmC5OClx86EOCcsLXymjWOIPHQyh
         g4ALqaabY3KceNw3VnTasvusHzm1iaC/4d0t0hl/tWcejkfMh7JWav/euIIUJBDgAsJi
         cCXosdZycZUNUtIAIhkJLaZRyRaWqiLJ15xFAHvjewNxwqxTC9RtCqIfbjN41LjPjng+
         oV436q2AeIgagPTzBxPsPVTE7j9r5DrkrgVAhWfloLR39SLbdTbArwo2RLDJ0TxuaMmG
         AAl8ny3Nx/2Y+6FCbCstiEfS3pE81fGH1s27wY0omqbJTgfBoFejRzUP99XPgddAQgMA
         GPUQ==
X-Gm-Message-State: AOJu0YzTPOHAoronRJq0bZUeG2na3MoJ0T/vT9m3RM9JmAFD+SBDE6+T
        xZpOfikAJSVM4m7AoN2liQ81wqbx9Z8=
X-Google-Smtp-Source: AGHT+IEQSDWk0639huH5hKUcHsIZgQb5kMD6Tko27XXuJ/rgV4CmwTMohMUooeKG1xbhXtpJeaxIJA==
X-Received: by 2002:a05:600c:128f:b0:3fe:25b3:951d with SMTP id t15-20020a05600c128f00b003fe25b3951dmr3582610wmd.5.1694038661967;
        Wed, 06 Sep 2023 15:17:41 -0700 (PDT)
Received: from gmail.com (1F2EF6A2.nat.pool.telekom.hu. [31.46.246.162])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c204d00b00402d7105035sm697144wmg.26.2023.09.06.15.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 15:17:41 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 7 Sep 2023 00:17:39 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, Peter Anvin <hpa@zytor.com>
Subject: Re: [patch 2/2] x86/boot/32: Disable stackprotector and tracing for
 mk_early_pgtbl_32()
Message-ID: <ZPj6gxSUc8SLzpLQ@gmail.com>
References: <20230822121936.476984181@linutronix.de>
 <20230822121954.036339203@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822121954.036339203@linutronix.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> Stackprotector cannot work before paging is enabled. The read from the per
> CPU variable __stack_chk_guard is always accessing the virtual address
> either directly on UP or via FS on SMP. In physical address mode this
> results in an access to memory above 3GB.
> 
> So this works by chance as the hardware returns the same value when there
> is no RAM at this physical address. When there is RAM populated above 3G
> then the read is by chance the same as nothing changes that memory during
> the very early boot stage.
> 
> Stop relying on pure luck and disable the stack protector for the only C
> function which is called during early boot before paging is enabled.
> 
> Remove function tracing from the whole source file as there is no way to
> trace this at all, but in case of CONFIG_DYNAMIC_FTRACE=n
> mk_early_pgtbl_32() would access global function tracer variables in
> physcial address mode which again might work by chance.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/Makefile |    1 +
>  arch/x86/kernel/head32.c |    3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
