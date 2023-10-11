Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD667C4973
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 07:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344185AbjJKFwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 01:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjJKFwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 01:52:15 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F078E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 22:52:14 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7b0767462adso1920841241.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 22:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697003533; x=1697608333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UlQLZZ3WQmdzwySqmWy0BN8h7pX0WW9J4xU4reoyJFQ=;
        b=Gcrhiu32owL3fUt7Qr7naFGnnVw49ik0s9BNJ5njQzAXH/5Keh5BBUR5mipiKS3LGj
         vEH3eR7B0AtAjr/l0gjPrZNv5SBulCPZHRGZeUdRsAJUE3uNEVtG3GcejhUKUNPJZY1i
         M/sW8NMZkiEtkCATEJ9ORgy7uofUo04BSCBOpdTFYmODSLqyDspLQ+7q+h6Yzg6dsf92
         hzGFijV05cHlh5embMmk+rnuqkvE9HqNSXrrFlgmg+ylUK8TNeUZdRBr/yIlvpmreEaZ
         lvTnqYj7RwzJgFEriaswSJMZuAxzFBHPslHZ4yzsXzPdaY+JINUUxczISwR88htjdJAG
         rp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697003533; x=1697608333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UlQLZZ3WQmdzwySqmWy0BN8h7pX0WW9J4xU4reoyJFQ=;
        b=uErhkAA6SdPUdNItRzhHWhdS04RHeqDC9Fk6M5VV9vqJ6v68yvZUTOQPRMClC79uBI
         bQvZ2/axMR2DYrKo99Q1SlKjZObdu/AchRmgh/NgEVf3x1zZLl/LuSfPBvzTKdPJ8Tps
         1Q+CUN5ujLKM5Bt3jWk/K418x1Z02ek0cPsz+vhjZt8Qet68ro9zQUks0gm6rjuZZiyT
         lpDSQgSrye8pY7LWxi5BnaL/tCOVV8JSCMPUCfdx2IYTV7jq00aIEoKH99O+6pQpwY4c
         qE3VqGHyb+lbV/1iZQ315h8dSYdMfRmLRY6B5g2oH5drqyGOzUOx0Bf2cEaj6Ag11QqW
         mzSw==
X-Gm-Message-State: AOJu0YzWgfSE/2bNkckrDPqi157iDlcn/VDWbHzmWk9YjExlgISsRfWI
        UoG7FiqxLZ9Dqbj083FWX/Cwy7jKKYkCAuh/ZiiFbA==
X-Google-Smtp-Source: AGHT+IGmhZ2oEbIJ4JrwhdmJV114Mlgz3c7RIS4tMhZxtuObkq2qomaUF7sUnF9rFRTqqr3qGJHh2N682dVpJIQsPTA=
X-Received: by 2002:a67:b606:0:b0:452:58f8:71de with SMTP id
 d6-20020a67b606000000b0045258f871demr13637693vsm.8.1697003531657; Tue, 10 Oct
 2023 22:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231006051801.423973-1-sumit.garg@linaro.org> <CAHk-=whOPoLaWM8S8GgoOPT7a2+nMH5h3TLKtn=R_3w4R1_Uvg@mail.gmail.com>
In-Reply-To: <CAHk-=whOPoLaWM8S8GgoOPT7a2+nMH5h3TLKtn=R_3w4R1_Uvg@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 11 Oct 2023 11:22:00 +0530
Message-ID: <CAFA6WYMsG8e2TCCT39HJ6SE1YKuK0sJRyoyyCYmujh_C_QFfGA@mail.gmail.com>
Subject: Re: [PATCH v2] KEYS: trusted: Remove redundant static calls usage
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, jarkko@kernel.org,
        peterz@infradead.org, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jejb@linux.ibm.com, David.Kaplan@amd.com, bp@alien8.de,
        mingo@kernel.org, x86@kernel.org, regressions@leemhuis.info,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 at 23:59, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 5 Oct 2023 at 22:18, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Static calls invocations aren't well supported from module __init and
> > __exit functions. Especially the static call from cleanup_trusted() led
> > to a crash on x86 kernel with CONFIG_DEBUG_VIRTUAL=y.
> >
> > However, the usage of static call invocations for trusted_key_init()
> > and trusted_key_exit() don't add any value from either a performance or
> > security perspective. Hence switch to use indirect function calls instead.
>
> I applied this patch to my tree, since it is a fix for the issue, and
> doesn't change any logic otherwise.

Thanks.

>
> However, I do note that the code logic is completely broken. It was
> broken before too, and apparently causes no problems, but it's still
> wrong.
>
> That's a separate issue, and would want a separate patch, but since I
> noticed it when applying this one, I'm replying here:
>
> > +               trusted_key_exit = trusted_key_sources[i].ops->exit;
> >                 migratable = trusted_key_sources[i].ops->migratable;
> >
> > -               ret = static_call(trusted_key_init)();
> > +               ret = trusted_key_sources[i].ops->init();
> >                 if (!ret)
> >                         break;
>
> Note how this sets "trusted_key_exit" even when the ->init() function fails.
>
> Then we potentially do the module exit:
>
> >  static void __exit cleanup_trusted(void)
> >  {
> > -       static_call_cond(trusted_key_exit)();
> > +       if (trusted_key_exit)
> > +               (*trusted_key_exit)();
> >  }
>
> With an exit function that doesn't match a successful init() call.
>
> Now, *normally* this isn't a problem, because if the init() call
> fails, we'll go on to the next one, and if they *all* fail, we'll fail
> the module load, and we obviously won't call the cleanup_trusted()
> function at all.
>
> EXCEPT.
>
> We have this:
>
>         /*
>          * encrypted_keys.ko depends on successful load of this module even if
>          * trusted key implementation is not found.
>          */
>         if (ret == -ENODEV)
>                 return 0;
>
> so that init() may actually have failed, and we still succeed in
> loading the module, and now we will call that exit function to clean
> up something that was never successfully done.

Here we consider -ENODEV as a success case since we don't want to
block encrypted keys module loading since it can use user key as
master key instead.

>
> This hopefully doesn't matter in practice, and the cleanup function
> will just not do anything, but it is illogical and inconsistent. So I
> think it should be fixed.

Agree as the exit function won't do anything without the device being
present but we should make it consistent.

-Sumit

> But as mentioned, this is a separate issue
> from the whole "you currently can't do static calls from __exit
> functions" issue.
>
>                   Linus
