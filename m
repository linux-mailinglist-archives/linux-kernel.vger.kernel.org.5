Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2BE80B6DC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 23:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjLIW2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 17:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjLIW2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 17:28:18 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5E6100
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 14:28:24 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b8958b32a2so2463620b6e.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 14:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702160904; x=1702765704; darn=vger.kernel.org;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=GIZ+mcVI5qd9xzhqd2Lq/djPmsscI/1vsqmZHAfk8NA=;
        b=p9DCWxDYC+nU3o7gjWxDHNHSfBEM7bYidKRtAZY+E/dEXZN97n3jp8E6Rc2dujZM4D
         SsYd9ylFbbOp/XIIzKaa4/Zgf3pvN16Hydic0pikAlhBMxZWHrCW2O0KmjD+tPCTeNof
         erPBXmZp6fgX70njfyCnjVcirM8gB1D8oMP4xhfqxblsmR3PzxXEGWG679A9oXVYvkOx
         /X8RHPaadhSq9KTtwsdT5Wz783W+ILD02kJvg7E57qPN5PtTBLidE+9d+wZse5jVNLDb
         +IoeJl/fyymQ4uzCe3asTM9GxZh2DxhPL3e1BDji8dq3QTo1riT+uN2BLv+lNdERK+p+
         DlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702160904; x=1702765704;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIZ+mcVI5qd9xzhqd2Lq/djPmsscI/1vsqmZHAfk8NA=;
        b=jkuPRYPJEQXN7IcVrjHS9kdxkVhAP7uUZ4AHhQ44XOU0rb+NUIEFBVqRFLMfSvxFHr
         GZbFZXPxjqXcZzdxbA1IPN01aDEIOvF+pAvf72NLt0MAW9HGI6ohVYE2Z9e8w5MV3RYz
         cGGYBhpbCrgwmTykVZ5oFqfcJYvAYhzbdg2O3PfNMAKxtEwVtQLTp84CIjj4VAmCaBeb
         p5ss+uHE98B367J9QbOCE8KUSa/QJZlhATbFKiKXyzDHfB9GA40YPK1r8sowq3uIclGX
         4yts6/1C/wP2Lt0113yBvoUw+n0K7Z5LSY12Hb7KG0IoqueqNN/i29/B9XK9YqlpfD8X
         Gs/Q==
X-Gm-Message-State: AOJu0YxHiHNM9qwq1GvEjoVATibTrmoG6tNY2AZwbBJq18NpKWzmmh4q
        UAunfkVdF1S/JBDfBkZeL4luoA==
X-Google-Smtp-Source: AGHT+IHe/3Q7T7mqAS39AMZy9ESnpkNFM6q37u24Z3u046keYsm8BlHmxnJkG9/CppRHC9PxpHjPRw==
X-Received: by 2002:a05:6808:21a6:b0:3b9:e87b:d963 with SMTP id be38-20020a05680821a600b003b9e87bd963mr2922446oib.85.1702160903962;
        Sat, 09 Dec 2023 14:28:23 -0800 (PST)
Received: from localhost ([2804:14d:7e39:8470:ded6:9593:9f4f:5c29])
        by smtp.gmail.com with ESMTPSA id h17-20020aa786d1000000b006ce7ed5ba42sm3794269pfo.171.2023.12.09.14.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 14:28:23 -0800 (PST)
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
 <20231122-arm64-gcs-v7-25-201c483bd775@kernel.org>
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
Subject: Re: [PATCH v7 25/39] arm64/signal: Expose GCS state in signal frames
In-reply-to: <20231122-arm64-gcs-v7-25-201c483bd775@kernel.org>
Date:   Sat, 09 Dec 2023 19:28:21 -0300
Message-ID: <87sf4bf1tm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mark Brown <broonie@kernel.org> writes:

> +static int preserve_gcs_context(struct gcs_context __user *ctx)
> +{
> +	int err = 0;
> +	u64 gcspr;
> +
> +	/*
> +	 * We will add a cap token to the frame, include it in the
> +	 * GCSPR_EL0 we report to support stack switching via
> +	 * sigreturn.
> +	 */
> +	gcs_preserve_current_state();
> +	gcspr = current->thread.gcspr_el0;
> +	if (task_gcs_el0_enabled(current))
> +		gcspr -= 8;
> +
> +	__put_user_error(GCS_MAGIC, &ctx->head.magic, err);
> +	__put_user_error(sizeof(*ctx), &ctx->head.size, err);
> +	__put_user_error(gcspr, &ctx->gcspr, err);
> +	__put_user_error(current->thread.gcs_el0_mode,
> +			 &ctx->features_enabled, err);

Other preserve_<foo>_context() functions zero the reserved fields in
ctx. I suggest doing the same here. It helps with backward
compatibility.

> +
> +	return err;
> +}


-- 
Thiago
