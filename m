Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21EC787BCF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 01:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242000AbjHXXHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 19:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244014AbjHXXHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 19:07:35 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D381BE5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 16:07:32 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bb97f2c99cso4892481fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 16:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692918451; x=1693523251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i0gAwhqOWZT0diMDK7kLkhF5OyNhIxTRw4Qs38qP1Eo=;
        b=U+zh9Sft3rt+a9QVtTqiWf4TgEepKuDsGDCloFQGlF263DJbDIr1mEFLChcTpH7o9c
         u76JfrVBd75If2ETxFctQFZJytzFR07KoO7yJonBWHn7g4turExkilvs0bBkJHx9Oj3u
         6HRJI47jEC2q6M2pLxwgAzzkLw5ve0onqRn0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692918451; x=1693523251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0gAwhqOWZT0diMDK7kLkhF5OyNhIxTRw4Qs38qP1Eo=;
        b=JNYNumcZ3kq5Tjo4o0Lc1fvp6zJZ1qccSsu46a9xhY2rFXCBPEYp+JsL20yTr84WXR
         N0ss/oyhZz7F7X573jcbltUBJL8rS6TFPrSNS3URNGg7EN7b9OlsJmJLc9aohcc09QY+
         kCxofE03naH+KB0W9EETnY7VF3U/RB/kLwJmBBxAlvgPwFgBUzLES3nDBWoNZpLcpm5i
         xxDdssBu9RsH/lqrT3kmDD3xt+OUa0QcAaktOVOZ3I6D4RGlJDOnXEo9ePNhA3MoxhZ3
         BhiYMy/i0vqoQO9CmoVZiIZW8+VrJQsjzGZt31USpSX9VGGkV6XboFSByqNJXHJXz4Ds
         6+/Q==
X-Gm-Message-State: AOJu0Yy+mwfSJQlBGtwLJkAxu+dswlPOh/51gfP3453GkbNt9IisOGQz
        cBnb2k0o9Vp5C+3t7gb6j7d9YNYLQhOjMrShl03bMsPp
X-Google-Smtp-Source: AGHT+IFUfK0uIHY9X2AqqOkBpGwKIAY3u6DKZm2bzQRa2RaWdTxr7/DzNcdsuR2tJ9fUy3d7uOeANw==
X-Received: by 2002:a2e:9d54:0:b0:2bb:8d70:c9b with SMTP id y20-20020a2e9d54000000b002bb8d700c9bmr13059718ljj.30.1692918451120;
        Thu, 24 Aug 2023 16:07:31 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id h17-20020a2e3a11000000b002b9b90474c7sm62490lja.129.2023.08.24.16.07.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 16:07:30 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2bbbda48904so4473181fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 16:07:29 -0700 (PDT)
X-Received: by 2002:a2e:9bcc:0:b0:2bc:bc70:263f with SMTP id
 w12-20020a2e9bcc000000b002bcbc70263fmr9572475ljj.0.1692918449041; Thu, 24 Aug
 2023 16:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <79cb1ec7-08ec-40d2-bbb4-ce40b684f1a4@paulmck-laptop>
In-Reply-To: <79cb1ec7-08ec-40d2-bbb4-ce40b684f1a4@paulmck-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Aug 2023 16:07:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whn=hcK3E+je=QjJ-b0CYbp2aY6sQBJGjFsX34L7wO+xA@mail.gmail.com>
Message-ID: <CAHk-=whn=hcK3E+je=QjJ-b0CYbp2aY6sQBJGjFsX34L7wO+xA@mail.gmail.com>
Subject: Re: [GIT PULL] scftorture changes for v6.4
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        rcu@vger.kernel.org, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 at 15:06, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Once the merge window opens, please pull these scftorture changes:

Heh, hedging your bets a bit?

This email had "for v6.4" in the subject, the CSD-lock one had "for
v6.5", and the RCU one had "for v6.6".

But I'll do them all in the next merge window, never fear.

              Linus
