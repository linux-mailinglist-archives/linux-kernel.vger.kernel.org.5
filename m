Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3747E3733
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjKGJId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbjKGJIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:08:19 -0500
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD54F126
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:08:14 -0800 (PST)
Received: by mail-lf1-x149.google.com with SMTP id 2adb3069b0e04-507d0e4eedaso5185364e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699348093; x=1699952893; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LbjjG7/WjvtfoJ9X+xOX//648LHgZumZkeZE/gohLJY=;
        b=VDdPY4o4m8sPr5CGGouUMRQkq/SlquVJcMdp+LnhsMIK06p0ctsH7rpk/SJ/I7FzD2
         /nf4wkXyelljB0B9wsj2rKhYr09Dqzuf1FqCK5ZEzrDnIvjPfPklh2Ntyl0/3aopBYmZ
         qwepdIYilPq92YYB4eWmG4lE1FASyGvaxWmUvZCHcKdf1/xQNpUqTKmO+5jZpnOCxUVP
         HwxnxuiBc2XjQaD+pTzldxNIHCr2EkX0lddKW3VVfNXLYdu2SxmYDrmcG/nN/1BzKwiB
         IRkjq9HmBrKIw14fOx6VGA0YpE5gk7oJQWkKCIrGC0yR2a3XLvGeAXilkBUMmzRG1/j0
         zX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348093; x=1699952893;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LbjjG7/WjvtfoJ9X+xOX//648LHgZumZkeZE/gohLJY=;
        b=iswna1qU/BM9kP/dK5IN1fcsbcnXm87vt0YbrsmGwKGlheetbth6LMiK5Wh77doTaU
         1tACv8yoPKsYRVvXQLji1BxL6cKBCjLbCIfTe1TSLF8p9XL7boCTNIoyiyBcdxnNjfUA
         rOF3QiDTBKfyVsO3Xzq/b5TUnNx06I6F9wmN/NwteXzGMUNDOuVUbG7n8Aa9XMgpmgqT
         KNvRldNYD+yfkN9eoPpfrMsm3kC2RSuLL1elNSkEgfBaz7Q9+vCL5vzyTjc/plVoDJtW
         u4ClV4mlg59uk/8oEtG8Nldl7pGr1PY3p7fqkHCNtV69Aowq4n74W7V2STMqPIHpeeg+
         uHFQ==
X-Gm-Message-State: AOJu0YzMRkQgLGZAzyricEbeb7tEq7StFv/hQYS4BEpqRIPFIS7OhwRk
        3zInxYvBqC2ntZ/MIKXvq6nyFQ7rKzJ8VQg=
X-Google-Smtp-Source: AGHT+IECdO3rN+pkxLfHgRmkHY6hFpopqaYYXX43K/NwRcxoExHDzNgHswUhMruKlsBSDeP5GISCi/QcE80EpYg=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:368f:b0:509:4956:515f with SMTP
 id d15-20020a056512368f00b005094956515fmr125651lfs.8.1699348092773; Tue, 07
 Nov 2023 01:08:12 -0800 (PST)
Date:   Tue,  7 Nov 2023 09:08:10 +0000
In-Reply-To: <20231102185934.773885-8-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-8-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107090810.257720-1-aliceryhl@google.com>
Subject: Re: [PATCH 07/21] binder: remove extern from function prototypes
From:   Alice Ryhl <aliceryhl@google.com>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Llamas <cmllamas@google.com> writes:
> The kernel coding style does not require 'extern' in function prototypes
> in .h files, so remove them from drivers/android/binder_alloc.h as they
> are not needed.
>
> No functional changes in this patch.
>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
