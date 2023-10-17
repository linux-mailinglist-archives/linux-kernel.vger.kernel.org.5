Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AAF7CB81F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 03:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjJQBw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 21:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJQBwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 21:52:25 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054229B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 18:52:23 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5079eed8bfbso4242133e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 18:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697507541; x=1698112341; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sm2JSoLthJQaCK+qYlXy6tvsIhwv+wYfjUyfiGpUUtM=;
        b=Rai3Tym8BkAwbu5SHGC3LF+E27MQ+q70lRLotbzOOJutPRFTxjUPkXl7BVaZwA41KV
         zAAYPMaS5jTnVCF2JbRmojtTib+xMVuGYyzid2aNyNWFClhD6HMXs512EgDT1mAB0YqN
         s5NjYqF5A9hyDCsrLLWo2zxzwBCnmMe03+2Zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697507541; x=1698112341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sm2JSoLthJQaCK+qYlXy6tvsIhwv+wYfjUyfiGpUUtM=;
        b=DUD8qEYafAup9VXZFOJd6BCfjfA307OTadRvQQPOlXxXkZV4jRxG05oUm7zIK5bSAz
         nKakRUiw6jWH/G2zu3q1SyF6AC4pFIbagXD0UGTZDP2M31LJaOpvwIVbiimXIS742zLa
         qL8KRpp+FzHeXzWQcUsNtjDQ8HB1WL6PEPzHhMYeNW9gStVs2qDsW63JvxL5j5l/as4z
         gd7Hgzp/SCDp4uTse9e1K7TQdzei7jrhw7bCuX0MOrw0elK/YGEpAKKDJykV+7KdFPHI
         UAnawNnAWlIjf0LtrH9AJPy+leyJ6WQd15E/yG4OXazoN1UgOZdGIlOgKiq+F9OUbfhi
         eyng==
X-Gm-Message-State: AOJu0YxAXQRlH/M7HtpI4y6q817U2vhAy3HMmIk8r9CyW6ImdjykKKE4
        Ekqao6ci4eVnyNSaTUf7BaU4Oz00DOKbcm8MPxvYx05C
X-Google-Smtp-Source: AGHT+IGWa1AOfAkyo/Z3/7qIo7SwtU94d94Vuq6geeMuRZrPT9xfMuaZBiX0HhP9sqA1DkiGld59BQ==
X-Received: by 2002:a19:a411:0:b0:507:b8fb:1e2f with SMTP id q17-20020a19a411000000b00507b8fb1e2fmr718244lfc.28.1697507540920;
        Mon, 16 Oct 2023 18:52:20 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id o20-20020aa7d3d4000000b0053e799314d7sm293173edr.73.2023.10.16.18.52.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 18:52:20 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9ad8a822508so839975066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 18:52:20 -0700 (PDT)
X-Received: by 2002:a17:906:db04:b0:9a1:f21e:cdff with SMTP id
 xj4-20020a170906db0400b009a1f21ecdffmr596986ejb.23.1697507539788; Mon, 16 Oct
 2023 18:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231017103949.3e81d95ecf737e55bdbdf7f3@kernel.org>
In-Reply-To: <20231017103949.3e81d95ecf737e55bdbdf7f3@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Oct 2023 18:52:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3k8JA93pKh9VjuafNN9Qyrk6eH-tQbWePyRSgXi_3FA@mail.gmail.com>
Message-ID: <CAHk-=wi3k8JA93pKh9VjuafNN9Qyrk6eH-tQbWePyRSgXi_3FA@mail.gmail.com>
Subject: Re: [GIT PULL] probes: Fixes for 6.6-rc6
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 at 18:39, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Masami Hiramatsu (Google) (2):
>       Documentation: probes: Add a new ret_ip callback parameter
>       fprobe: Fix to ensure the number of active retprobes is not zero

No diffstat? Tssk.

           Linus
