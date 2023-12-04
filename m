Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BC6802A31
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 03:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbjLDCOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 21:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDCOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 21:14:10 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2655C3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 18:14:15 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5b4e3284e68so5185647b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 18:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701656055; x=1702260855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=388DnSOOl0dwCbXab02Ex4X5WwZLrBD/+hKfrfZ6LKo=;
        b=I6I3HXCKIyKq8eZyLsdgMqlcab3at3QRIDnOisTcfBigDotD30CBJJent1GrVw1FzO
         96BTl0n79ToD2MASNnU9aJitDqB9LknN3YboGn9hYn+xEaTI0Ne0aH8MlY/u13r35kcW
         /dXinOp/K0CEMN2xOFYS5dRKo657MXl1wPMwHDIbcc9lxH8Pc9LolYjR5XG3FpZWGPIE
         jRA9P27orVYj0S6dmshwGcy30dRb85tUCDENQT/h7vpi4d/NcUD6QUR496LSqH/cKFlI
         83ZztWc1wyawn5pFe+Qh0UHc3mbkRo+EhYf3PxFU3LQIHOjdq5CfnddtHfFv15tfyo6W
         V6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701656055; x=1702260855;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=388DnSOOl0dwCbXab02Ex4X5WwZLrBD/+hKfrfZ6LKo=;
        b=FgSNCelAJ1EZe2oD+PTt4cJ374xM8agadq4v7NlVnCZq+Lt8gHzuP81/OqXo0iOR5j
         s3bpVWxTSsvAjQX2I9zTXmxT4XeNRwKBoutfBIMIOuriW2jwAFlcN+8tZqNeoyil+J0A
         cDQcOPn98YYieEgjCxKA1cDd/9N9lH9dvF5FwY7ji9nPtutgqiewkijKHW+uZhhdJd7p
         m4386OuXnPA2G4LfP1Q5qB8rqBJ55q+Mb0yHg9JRtxjwLkZf5+p2yDRrON3Zl6aw+hNl
         2i+Qv89HkVSfE7V7LYvl8vJawGRxje4tuXehhNqfnxMX3Or55UOgLlSjRemekLG/KBLw
         jlDA==
X-Gm-Message-State: AOJu0YyFdUClGUnnMUsuLjHMpA+Za6VqAJcKFx1jp9+cPpNP/jb2+i8o
        wyJ1d1crzAVZUckmeMPF9lrPpw==
X-Google-Smtp-Source: AGHT+IFcNWA+eNuaKGM1iJBwEifJAMmJ6R7Kp8kjw7jQPXUFTpog7ShcxdvqW3FEv8diKT/ZtjkVHg==
X-Received: by 2002:a0d:d68d:0:b0:5d4:1d55:b677 with SMTP id y135-20020a0dd68d000000b005d41d55b677mr5218306ywd.5.1701656054802;
        Sun, 03 Dec 2023 18:14:14 -0800 (PST)
Received: from [172.19.131.145] ([216.250.210.88])
        by smtp.gmail.com with ESMTPSA id w20-20020a0ce114000000b0067ac5a570aesm620392qvk.109.2023.12.03.18.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Dec 2023 18:14:14 -0800 (PST)
Message-ID: <e9a1cfed-42e9-4174-bbb3-1a3680cf6a5c@kernel.dk>
Date:   Sun, 3 Dec 2023 19:13:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Allow a kthread to declare that it calls
 task_work_run()
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
References: <20231204014042.6754-1-neilb@suse.de>
 <20231204014042.6754-2-neilb@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231204014042.6754-2-neilb@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/23 6:36 PM, NeilBrown wrote:
> diff --git a/fs/namespace.c b/fs/namespace.c
> index e157efc54023..46d640b70ca9 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1328,7 +1328,7 @@ static void mntput_no_expire(struct mount *mnt)
>  
>  	if (likely(!(mnt->mnt.mnt_flags & MNT_INTERNAL))) {
>  		struct task_struct *task = current;
> -		if (likely(!(task->flags & PF_KTHREAD))) {
> +		if (likely((task->flags & PF_RUNS_TASK_WORK))) {

Extraneous parens here.

> diff --git a/kernel/task_work.c b/kernel/task_work.c
> index 95a7e1b7f1da..aec19876e121 100644
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -183,3 +183,4 @@ void task_work_run(void)
>  		} while (work);
>  	}
>  }
> +EXPORT_SYMBOL(task_work_run);

If we're exporting this, then I think that function needs a big
disclaimer on exactly when it is safe to call it. And it most certainly
needs to be a _GPL export.

-- 
Jens Axboe

