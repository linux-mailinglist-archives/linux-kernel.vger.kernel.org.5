Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DDB78C0C7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjH2Isx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjH2Ish (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:48:37 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15516B5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:48:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-991c786369cso529906266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1693298913; x=1693903713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7YJc8FCGCtf+QA21PW9zw+dSzN4oao0rbur83lcAqpY=;
        b=Nkoj5q9dpgihnYQDPjsqU6J6Uuu9c8pYZBsdwMP2jSuzFN/URHy4uhx/gAYTdEX32i
         msyWquKqH7TyXlBzqaQkLwp0sL177Ys+TKCv/110EI5nE4tzMlccH3ibQajkI5ptQu73
         s80ARD1kkvuMVOgxOFHdtFvvcr4jJ9gruwZSuQNNTf5uZ68tYeLzcSMryNVQkhz1PXqL
         2htVRTZcB4z+6aRYe7Mn/Szlr91Os1jMRgjZn1gspUnOeD6bCKCDZxYRIc9IeDOTfKjz
         ppH7c/aNgMT1ltsDXRUPxDSAf8X09phm4Lkd91008AqflC31IAKtoow49OwDLLtvgTik
         v1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693298913; x=1693903713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YJc8FCGCtf+QA21PW9zw+dSzN4oao0rbur83lcAqpY=;
        b=E6lOe2WrGtw5Ve0GGFnwGfip+o2ba5pt/6pBvMZA5EGmTDsAagsqBtijmksPPq63jf
         ZfmPmC1U+3VEGvuAIuMj/62kj3kmR+xd191fGLhy+YJB4wa8sB+x/rLTFpGSjmb9zhra
         pP0qFIzdCVtFYjzOQbRnbuQLFm891meg7aHAa9N07RvQabb7c0yPqVY5J4iw86TDg6xa
         8lZLALVpoIcZQSFvOXQcn6/3j1c6uc0XR3CBrK6x9IaZrY5tZ0QGzvgeEnEN7oXw69iF
         MotRwC/3wWnaLB/zYX2JnIQiAQpCKg8+k2iEa1TcTxSgZErAvYGqiRni8QZjDMGwZbCc
         qtYQ==
X-Gm-Message-State: AOJu0Ywadba+8du+LQreV4l/T+0NkwkhPN87ekrN5AgvdlxTpYKS5N5q
        /Uc0ybwNJ4BerUAoIxjeduu+9Q==
X-Google-Smtp-Source: AGHT+IGANV0ko3RQERka+ZkTfDKbn4edddXZrJXmeK3uAtPTDgyJGdXhlgqVkQjEV7B8tUjt22YIPg==
X-Received: by 2002:a17:907:2bf7:b0:9a1:ad87:1354 with SMTP id gv55-20020a1709072bf700b009a1ad871354mr17131329ejc.34.1693298913427;
        Tue, 29 Aug 2023 01:48:33 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id lw13-20020a170906bccd00b00992f2befcbcsm5675917ejb.180.2023.08.29.01.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 01:48:33 -0700 (PDT)
Date:   Tue, 29 Aug 2023 10:48:32 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
Message-ID: <20230829-e445d0bdff78969cc33a6263@orel>
References: <20230711201831.2695097-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711201831.2695097-1-evan@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

Here's my stab at new wording.

On Tue, Jul 11, 2023 at 01:18:30PM -0700, Evan Green wrote:
...
> diff --git a/Documentation/riscv/uabi.rst b/Documentation/riscv/uabi.rst
> index 8960fac42c40..afdda580e5a2 100644
> --- a/Documentation/riscv/uabi.rst
> +++ b/Documentation/riscv/uabi.rst
> @@ -42,6 +42,16 @@ An example string following the order is::
>  
>     rv64imadc_zifoo_zigoo_zafoo_sbar_scar_zxmbaz_xqux_xrux
>  
> +"isa" vs "hart isa" lines in /proc/cpuinfo
> +------------------------------------------
> +
> +The "isa" line in /proc/cpuinfo describes the lowest common denominator of
> +RISC-V ISA extensions understood by the kernel and implemented on all harts. The
> +"hart isa" line, in contrast, describes the set of extensions understood by the
> +kernel on the particular hart being described, even if those extensions may not
> +be present on all harts in the system. The "hart isa" line is consistent with
> +what's returned by __riscv_hwprobe() when querying for that specific CPU.
> +

The "isa" and "hart isa" lines in /proc/cpuinfo list RISC-V ISA extensions
which the kernel can identify (the kernel recognizes the extension's name)
and have not been filtered out due to effectively not being present.  An
extension is effectively not present when it is unusable, either due to
defects (which the kernel is aware of), due to missing information which
is necessary to complete the extension's description, or due to being
explicitly "hidden", such as when a kernel command line parameter
instructs the kernel to pretend the extension is not present.  Note, an
extension's presence in a list does not imply the kernel is using the
extension, nor does it imply that userspace or guest kernels may use the
extension (__riscv_hwprobe() should be queried for userspace usability.
The hypervisor should be queried, using hypervisor-specific APIs, to
check guest kernel usability.)

The "isa" line describes the lowest common denominator of extensions,
which are the extensions implemented on all harts.  In contrast, the
extensions listed in the "hart isa" line need not be implemented by
any other hart than the hart corresponding to the line.

---

I've specifically dropped the 'The "hart isa" line is consistent with
what's returned by __riscv_hwprobe()...' part because I suspect hwprobe
could at least lag what gets put in "hart isa", since the kernel may be
taught about an extension for a different purpose first, neglecting
hwprobe. And, there may be cases that hwprobe never enumerates an
extension which the kernel does.

Thanks,
drew
