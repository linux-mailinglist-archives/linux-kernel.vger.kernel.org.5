Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4687F0208
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 19:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjKRSmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 13:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjKRSmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 13:42:31 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DE6F2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 10:42:28 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50aaae30dd0so45791e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 10:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700332946; x=1700937746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TbzyH2ZyAECsisdG+hU0lyimTFxasBONEbchbfYaF1A=;
        b=GuJQwLnsoUjXNAmxmnlx+crMxx326ddapRFuGQ4YkdTcc8F5cWr8uMwvEMLbCIF14X
         Dxwjcp21nNIgL9sEu5n2KLPZgtwJmIMy07tG5tUBowiAIYqGNSNMUh5dGQ9hfIT8OW9D
         dDwpZ7QQ4Pljq/xHBEG7OBJ2NvS4b1ZlE+q0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700332946; x=1700937746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TbzyH2ZyAECsisdG+hU0lyimTFxasBONEbchbfYaF1A=;
        b=pc1y6c1tbHarwBDYhYjBcP7Qw9m75rMX7J4LK8/2tsUvp/P/BGpAf/CxGtXqq3IeT1
         v4wGCbCYoOr1izN11p+RJStBl78/ITPGFDo4jkDDaPA0GeFltDfudneRhl+6GSnBYEtL
         CKSQnzLSn2PjKZIhhKzvdud12BVgmJzgp3wZerC+wgQvXX+hOVUGbxt4KTRNcCCpLNig
         rRn6mycy6krO39I9sPJq8MRLzlDPEBZifAaIb7IwEIB+0R6+11slPROcR9FbfOTWFrt5
         wjigiT9e1+8dDIKTRDkPbx4cw/S5tW8etNfQnnyA7kjnIOFB+Na4AGyT98HjoE6emcK4
         S3ow==
X-Gm-Message-State: AOJu0Yye7XYgER9yY/tBzNcMVcPuT8wJ+PJ6MuXqi/8tSAg3/CZCb+Ii
        K+mQartGq+hHg4IeSCtteYfCaiuiMfyf6vCMlNBIMg==
X-Google-Smtp-Source: AGHT+IEquZI72ew/qZoWB74U2yLQ578u0/OhpVOtouTC9/fu9uhPViBTuLhlDsJbERrr7boIYcjRWg==
X-Received: by 2002:ac2:59c9:0:b0:509:f45c:fae6 with SMTP id x9-20020ac259c9000000b00509f45cfae6mr2859365lfn.10.1700332945838;
        Sat, 18 Nov 2023 10:42:25 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id w17-20020ac24431000000b0050aa5f2af19sm315285lfl.45.2023.11.18.10.42.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Nov 2023 10:42:25 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2c50cf61f6dso40567381fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 10:42:24 -0800 (PST)
X-Received: by 2002:a2e:2a83:0:b0:2c8:2e3a:e974 with SMTP id
 q125-20020a2e2a83000000b002c82e3ae974mr2299009ljq.44.1700332944553; Sat, 18
 Nov 2023 10:42:24 -0800 (PST)
MIME-Version: 1.0
References: <ZVjC9P0h5mw3ZbnD@p100> <CAHk-=wgtxsw8hrLNcGz9aJtP17NR3=NSvRdYGfKB52VorhkWzQ@mail.gmail.com>
 <0f492aac-9ba7-4bc6-95b2-6b1104a12244@gmx.de>
In-Reply-To: <0f492aac-9ba7-4bc6-95b2-6b1104a12244@gmx.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Nov 2023 10:42:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgtie=7Z79CssOF10twd1mdQuy1JeiPVgbGFTa9q7JePQ@mail.gmail.com>
Message-ID: <CAHk-=wgtie=7Z79CssOF10twd1mdQuy1JeiPVgbGFTa9q7JePQ@mail.gmail.com>
Subject: Re: [GIT PULL] parisc architecture fixes for v6.7-rc1
To:     Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Kees Cook <keescook@chromium.org>, Sam James <sam@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Nov 2023 at 10:40, Helge Deller <deller@gmx.de> wrote:
>
> Would the patch below be OK? It's basically yours but with EINVAL.
> (might be whitespace-scrambled!)

I don't particularly like EINVAL, but it's not the kind of
show-stopper that the other issues were.

               Linus
