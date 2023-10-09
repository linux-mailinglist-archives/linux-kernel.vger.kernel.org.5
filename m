Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F8F7BE6B7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377309AbjJIQlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377328AbjJIQl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:41:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4253EB7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696869643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+YpXHXo6RBy8CnTiTObZdU28mMjUq9Z4XmoNn8CdwOg=;
        b=M5wXaGZpjXkD/OdeFEb27qAuAhxegOeUCLSB/ie1jz1/1DULeE07SJG/cFwpVgJtNdH1jn
        VunY2wwQ19bV9L3FAC7XL5fmwrvrdLOgJypRZD0bvg1vrB6nWQ5JeguyRJl7qPL3TgJ7NR
        qHTHgc125Xk9HM8+EwQgIak9k6Ps2fY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-Ls3o9I_mPv2QANSqzzuDeg-1; Mon, 09 Oct 2023 12:40:39 -0400
X-MC-Unique: Ls3o9I_mPv2QANSqzzuDeg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4067f186094so30413405e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 09:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696869638; x=1697474438;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+YpXHXo6RBy8CnTiTObZdU28mMjUq9Z4XmoNn8CdwOg=;
        b=rCFMB+M8iwTYYCcVMUb2cb/9BFoKqidWnIzmfGtRyfeg5ZGqncHPWpz1uvHK/To6Zr
         qLO4LM5NAY5LtYlxz/ViyBkq9OWIU8+BSostnUdZOcP6uSkeu1YBLD8GDrqITQkO7hIa
         +TXUM2C8pn6vkWvsBwExpEn3J2KaODP5RsPkBcTMXgHtyH6Q03ZBD4dDZnG99g9NzO3s
         E13ln1jFIjf6vthl26NRh1vFNJSX+KPzZ5yd8bQn1S9mq90ME01lWaRbVB7MZ2fZ3M8W
         Ha9t/mMcNVqklU1GGKVl4FdnQcYhhqOZ2XagnEPJEQlZBIDr18zzrQ9xG3O77+BT1O/u
         pVbA==
X-Gm-Message-State: AOJu0YyJmO9twtZSdph97PnkdKOZajpfOrNbBZ1jws3d1ahAr0nBjBUQ
        FZHc/KCPy5JU74ekMzwfX9D2hpoBSKKcigpuJsRzmJWA9rxv74rlNrI4NNHaa35m685JVJxsaTn
        Ws/3GBvScnyViGUfy3f6NB2SO
X-Received: by 2002:a05:600c:2949:b0:405:82c0:d9d9 with SMTP id n9-20020a05600c294900b0040582c0d9d9mr14896233wmd.41.1696869638583;
        Mon, 09 Oct 2023 09:40:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMgAs2OFs3TPKIXUcqwEYEgUj8NhgbOlPIyIMA79idAa9Hjf42+dP6kuPpgcF+X3v1F7p9tg==
X-Received: by 2002:a05:600c:2949:b0:405:82c0:d9d9 with SMTP id n9-20020a05600c294900b0040582c0d9d9mr14896162wmd.41.1696869638060;
        Mon, 09 Oct 2023 09:40:38 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id bd5-20020a05600c1f0500b004030e8ff964sm14033430wmb.34.2023.10.09.09.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:40:37 -0700 (PDT)
Message-ID: <907b351fee183609891a4d0cfb0a79bad85577a0.camel@redhat.com>
Subject: Re: [RFC PATCH v2 14/20] x86/kvm: Make kvm_async_pf_enabled
 __ro_after_init
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nadav Amit <namit@vmware.com>,
        Dan Carpenter <error27@gmail.com>,
        Chuang Wang <nashuiliang@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Petr Mladek <pmladek@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>,
        Julian Pidancet <julian.pidancet@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>
Date:   Mon, 09 Oct 2023 19:40:31 +0300
In-Reply-To: <20230720163056.2564824-15-vschneid@redhat.com>
References: <20230720163056.2564824-1-vschneid@redhat.com>
         <20230720163056.2564824-15-vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

У чт, 2023-07-20 у 17:30 +0100, Valentin Schneider пише:
> objtool now warns about it:
> 
>   vmlinux.o: warning: objtool: exc_page_fault+0x2a: Non __ro_after_init static key "kvm_async_pf_enabled" in .noinstr section
> 
> The key can only be enabled (and not disabled) in the __init function
> kvm_guest_init(), so mark it as __ro_after_init.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  arch/x86/kernel/kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 1cceac5984daa..319460090a836 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -44,7 +44,7 @@
>  #include <asm/svm.h>
>  #include <asm/e820/api.h>
>  
> -DEFINE_STATIC_KEY_FALSE(kvm_async_pf_enabled);
> +DEFINE_STATIC_KEY_FALSE_RO(kvm_async_pf_enabled);
>  
>  static int kvmapf = 1;
>  
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

