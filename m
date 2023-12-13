Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5997810853
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 03:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378292AbjLMCpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 21:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjLMCpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:45:04 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D986EA6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:45:09 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6cebcf8a48aso5181666b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702435509; x=1703040309; darn=vger.kernel.org;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=CJ7qwCmvq20mGgi3dRymJGPN14h9pbhwL4VM2txPZCM=;
        b=ZcidFv8JCRaEhFx285fX5LJKtnAW/6xdQ+f7UfXQ943HmZyW9UeCMTAYCaHECv8vLb
         URWXgHbvPOMeXQuHw0S2vjSjHuBlCXvquyzPVXx4sAqi1JBubDTEmBqHBx1KrJeEMFSr
         062t+bhgVI5fKT3UeJt5TWjN/EyiUIycC4uMBVg7+ZpGfANAqH9sq327mW42WX36tCBA
         EmOhUf9rvG1Eo7TCMc5XNLm9Olzb5gcmAmGaze1GIY+DTTPP25On2mTimeGQpBImvEr/
         eUYhQKfZ/0EQF0sRexHfXempTf+gySR6FEDkr6mkUt0DHZ4wXN6L7dp0zbLaL0qsZsT+
         vaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702435509; x=1703040309;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJ7qwCmvq20mGgi3dRymJGPN14h9pbhwL4VM2txPZCM=;
        b=vMk9HwqWaBvVI2JcZvtCCB64qTyvqjBQy6j8LoEHt6gMP1KJdgLadaKktpZf+Vxq1N
         FIudn4BMPLNdKYtjEFFcddyNwXn8Hd+usc2IMzK4ITdzhEdVnLNCweqN13X+YkUGo59b
         lLLbiWZzGUKZ8Jtmm6UN43VSrG75ZGlDE0mGvZmfmJdnHYh+DKWrxhs/sKHX+n8HHZpx
         AOlo2W3CDySglDHZJgNFm+Mq4kNTbiqXkHFTN+caQ8n6tQTx9oLb+xJZ0gKnlO7DT/AF
         +M45iVry7D2bxVudCFb2XbiknVjeGEjFtjOIrE/l90OUz8/tsrhhihlVQTZkBc14wrSK
         XJFA==
X-Gm-Message-State: AOJu0YzcYYD9BBQ1hbO0WYCSrro73AEGZq6n1nXy1R8DDGzxQacyFy43
        ovsTA53FEqMwhoz2kSVE7pNgow==
X-Google-Smtp-Source: AGHT+IGi//6HE3KINOZpirefGAX+e3jIHwZFWzUp/AR1xA1scaFysKSWvBw9/QjFkCNOqGCFGdEidA==
X-Received: by 2002:a05:6a00:c81:b0:6cb:a2f4:8579 with SMTP id a1-20020a056a000c8100b006cba2f48579mr8585102pfv.15.1702435509333;
        Tue, 12 Dec 2023 18:45:09 -0800 (PST)
Received: from localhost ([2804:14d:7e39:8470:cddd:ffc9:f19e:a4dc])
        by smtp.gmail.com with ESMTPSA id y72-20020a62ce4b000000b006cb7bdbc3besm9528817pfg.17.2023.12.12.18.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 18:45:08 -0800 (PST)
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
 <20231122-arm64-gcs-v7-37-201c483bd775@kernel.org>
User-agent: mu4e 1.10.8; emacs 29.1
From:   Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v7 37/39] kselftest/arm64: Add a GCS stress test
In-reply-to: <20231122-arm64-gcs-v7-37-201c483bd775@kernel.org>
Date:   Tue, 12 Dec 2023 23:45:06 -0300
Message-ID: <87zfyex1l9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I'm going a bit out-of-order to report a build failure in a test:

Mark Brown <broonie@kernel.org> writes:

> +// Recurse x20 times
> +.macro recurse id

I get an assembler error here:

gcc -nostdlib gcs-stress-thread.S -o /home/thiago.bauermann/src/linux/tools/testing/selftests/arm64/gcs/gcs-stress-thread
gcs-stress-thread.S: Assembler messages:
gcs-stress-thread.S:236: Error: unexpected end of file in macro `recurse' definition
make[2]: *** [Makefile:24: /home/thiago.bauermann/src/linux/tools/testing/selftests/arm64/gcs/gcs-stress-thread] Error 1

This is with gas from Ubuntu 22.04, which ships binutils 2.38.

> +function recurse\id
> +	stp	x29, x30, [sp, #-16]!
> +	mov	x29, sp
> +
> +	cmp	x20, 0
> +	beq	1f
> +	sub	x20, x20, 1
> +	bl	recurse\id
> +
> +1:
> +	ldp	x29, x30, [sp], #16
> +
> +	// Do a syscall immediately prior to returning to try to provoke
> +	// scheduling and migration at a point where coherency issues
> +	// might trigger.
> +	mov	x8, #__NR_getpid
> +	svc	#0
> +
> +	ret
> +endfunction
> +.endmacro
> +
> +// Generate and use two copies so we're changing the GCS contents
> +recurse 1
> +recurse 2

-- 
Thiago
