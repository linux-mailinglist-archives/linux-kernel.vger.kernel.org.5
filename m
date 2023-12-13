Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3616811F97
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 21:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442241AbjLMT7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442230AbjLMT7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:59:51 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E301B118
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:59:56 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-dbccfd048d4so959307276.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702497596; x=1703102396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s31Qnl2jy9dVbfR9SU0O1e0gpO4gYzM2ckO1KK9cNWQ=;
        b=jH6SPAsqxum5r3bxOr50QI5W87HWpirYc1yAIgS/RNk9lEb5qFNA6PDAz2emVohfq1
         gOwnW748Yc7xrx+hYRlaJMmMhMj4iEBIn1WM2oDG2dl/x1xnY3WsP8v7ITohdLywlGd8
         HGs2IvZ/FY9gTmgtVvecABlfpLXjRNz/FDTKUDSuL6/m4SMJBIAVzfqgMX6LeqDNWNuM
         73UkEIW4t49gpM0cixQTLOGffy9lfjQmwzbmxDaTGBmxQcsyTusofHLMOfFlP7SfKkMn
         BnDkfhGMO1ql5kdAQqUyYWJEmdzxqY4hriswEuWn8AqPsYBZLyEtrRFur1hvPEm9fZFt
         wEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702497596; x=1703102396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s31Qnl2jy9dVbfR9SU0O1e0gpO4gYzM2ckO1KK9cNWQ=;
        b=JGJMb7t5DlBwJFv495z+bhDzMOdXs1dank26zPV3Wz5gabbmWUHceLkRB9WI1ozLz9
         l//CKT/1kq5UbVMiDMHlu+skU7rGu2/pUUMSUELRUXJ3IaU794qJ6S3N1MYHjgLuRvA6
         5MukDViGTQjWULW/9C9/0DeIRap4Be/NjtcA4pSuzJu7q5SyFwGm3JmH/LWqZn6pABR0
         eUG1vIkrDXVvr2jZFjICzvyjihgZc4XNKllzHXua9gDdPYJHUK0QIDh/GKSyeRoe5ti6
         cNxjj4gG7scJhU0Cn2wnF0pC6CCWggK5T+YvJS279GwgsO1ia1nIWMdfOR9iXNSIB3C8
         u/Zg==
X-Gm-Message-State: AOJu0YxmUgIqOrpbAkJ5AGYQ3ZcL6ZdM5qRnrs9NanYNsh4/Hg3hHMee
        7aHcKOyxyiVWErr5VCOWyr8NsK6ZP/7L8d74xWwjWg==
X-Google-Smtp-Source: AGHT+IGoanEfSAfWqtQw7++5uapiVETyiSe4lA5KkKISTBsZpDDCHd2EgxZu4V1rN9q+R/qEjWhYJ9uGnGBTlEe8bKg=
X-Received: by 2002:a25:6ac4:0:b0:db7:dacf:3fb6 with SMTP id
 f187-20020a256ac4000000b00db7dacf3fb6mr4418808ybc.99.1702497596004; Wed, 13
 Dec 2023 11:59:56 -0800 (PST)
MIME-Version: 1.0
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org> <20231122-arm64-gcs-v7-20-201c483bd775@kernel.org>
In-Reply-To: <20231122-arm64-gcs-v7-20-201c483bd775@kernel.org>
From:   Deepak Gupta <debug@rivosinc.com>
Date:   Wed, 13 Dec 2023 11:59:45 -0800
Message-ID: <CAKC1njQVB71A8fQBLmBnx++agM12XDLhS=7iL7-A4NTXSqUM+A@mail.gmail.com>
Subject: Re: [PATCH v7 20/39] arm64/gcs: Context switch GCS state for EL0
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
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 1:45=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
> +
> +/*
> + * Apply the GCS mode configured for the specified task to the
> + * hardware.
> + */
> +void gcs_set_el0_mode(struct task_struct *task)
> +{
> +       u64 gcscre0_el1 =3D GCSCRE0_EL1_nTR;
> +
> +       if (task->thread.gcs_el0_mode & PR_SHADOW_STACK_ENABLE)
> +               gcscre0_el1 |=3D GCSCRE0_EL1_RVCHKEN | GCSCRE0_EL1_PCRSEL=
;

If the intent is to disable, is the GCS stack freed or kept around?
I expect if libc is taking the decision to disable, kernel should free it u=
p.
Is it freed in some other flow?

> +
> +       if (task->thread.gcs_el0_mode & PR_SHADOW_STACK_WRITE)
> +               gcscre0_el1 |=3D GCSCRE0_EL1_STREn;
> +
> +       if (task->thread.gcs_el0_mode & PR_SHADOW_STACK_PUSH)
> +               gcscre0_el1 |=3D GCSCRE0_EL1_PUSHMEn;
> +
> +       write_sysreg_s(gcscre0_el1, SYS_GCSCRE0_EL1);
> +}
