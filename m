Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2777521CE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbjGMMtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbjGMMtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:49:06 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AC0272C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:48:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9939fbb7191so140733866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1689252511; x=1691844511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fp4jrD0ygkJDJFkWGuFutfJdRI3HLTanG1V2Pol42Cs=;
        b=EOfdCr6iiOuuTNeK3CwI0fjcEzCrcjSEMhZxpmDwTAsUYUGRmEbN4J3P/KWj+lbnRV
         H3H5LgYWFSq8LpQAFrnS11hWAMu3jThEZYt1uEjysR4lE8hZvuiScxPUTY1JBowIa1sH
         VftqMEF/Yo+psGZPwo2ygzyJAfyX6/YNU5gqD7PwrjpSC/q2Jj7Hh7OeyTIzz8v4Gre0
         5ayG8V3a8n93aKvEbAUwe+GRycP79O7hwW5BbRHfoWtH+/e8CbrsjG15Ty9jiOAg0ZqV
         J3cKYSb1nQMioih/tQ08tz5SmCDZQ3tEDX52Gy7VadWkcvkw+PQR74HWTkSQywXYs4u7
         WF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689252511; x=1691844511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fp4jrD0ygkJDJFkWGuFutfJdRI3HLTanG1V2Pol42Cs=;
        b=ELPVQ1+mh4V/3zQDD0AM6G8pJTcZefBxVms/Io7fa5t18+GtdbkkFXhfAvBAKY6d1V
         5ba7MhlRYc72R+5JH7LLKtpiSCI/4Kx4Y+xaIX3BhRakGpSsTCy69rKQcBM/O9clLMfx
         +YoGSkSXCH77xPORTVWPmdEGpjptEROfaN4J4TUhIgM+ekdqfNSnZyeJvllIR3XqVmhb
         w54UXoScjUGuLZaxd7+kmH9ihMI30VjKVOKQtrM/7fywmeQGd7oT1iSqTduLf+CPtl7p
         TphlQlglFYmG9pV1oghAoqQVpbYJERpA5n3W64x2PFYSB761TrQdsLX7h8+k15OpyEdB
         7hIQ==
X-Gm-Message-State: ABy/qLbRs7AbTVnf7pir+4qkrKraI8bRBeUcE1ra2s6b9Q6BXwpNN3Ds
        7ulsWpzRTnQDRC9WRNS9pwKaLQ==
X-Google-Smtp-Source: APBJJlFXhJzEW2rHuTuVDvIaDHf/V6o0OrzDtrKElPkDaTyWkk0l1GjBgS7jdgy/ld4Qg5h+QAf4TA==
X-Received: by 2002:a17:907:3fa0:b0:986:38ab:ef99 with SMTP id hr32-20020a1709073fa000b0098638abef99mr7436157ejc.9.1689252511508;
        Thu, 13 Jul 2023 05:48:31 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709066d4a00b00992eabc0ad8sm3958509ejt.42.2023.07.13.05.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 05:48:31 -0700 (PDT)
Date:   Thu, 13 Jul 2023 14:48:30 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Samuel Ortiz <sameo@rivosinc.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] RISC-V: KVM: Allow Zbc, Zbk* and Zk* extensions for
 Guest/VM
Message-ID: <20230713-bf041a3bbf91d041db3bd623@orel>
References: <20230712161047.1764756-1-apatel@ventanamicro.com>
 <20230712161047.1764756-7-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712161047.1764756-7-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 09:40:46PM +0530, Anup Patel wrote:
> We extend the KVM ISA extension ONE_REG interface to allow KVM
> user space to detect and enable Zbc, Zbk* and Zk* extensions for
> Guest/VM.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/uapi/asm/kvm.h | 11 +++++++++++
>  arch/riscv/kvm/vcpu_onereg.c      | 22 ++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
