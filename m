Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B6D79EB81
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241397AbjIMOrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241415AbjIMOrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:47:20 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D579B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:47:16 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-68fac73c54aso5345007b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694616436; x=1695221236; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aMCw5TG7E2QUMrbjxkEI8JkXPsdAS9lS/ivoHC9sTRs=;
        b=HYNX4JEr5yHH8m2Ge2M++apUrY5Ny341YR3SNs8t9EvtK0OIV1UY3RjOmaQNike3xf
         DGjbtmEUu6EVKf3byo/dq8g3KC5dMCFyXyHROr+lWYSLCg7k5uVF8WK3k6ebRkvQ/CW7
         jz/IY+2Y5VdAKFMSCqezEj6852NcPkYO7kNZk5c8UExHSnRblFJXId1WBfKgNkMMUBZx
         K3gw+8FSDwrNVvTUCTIQfiNGIgkgtaUvXxQb4oybr1mL7PArYNf0lTPMXc+TQbceAny7
         gxaGoXwiLSk6xPVHh3hssQ88SepGXr2aQslMB8vEUoVAuDBM5RDjba/RBt9OlTRBlGMI
         3dZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694616436; x=1695221236;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aMCw5TG7E2QUMrbjxkEI8JkXPsdAS9lS/ivoHC9sTRs=;
        b=fn2vwmdtyYGlLfEcR1f9vSuO40QfsiMyyVJU/fH6qHINzKQYJsw+r3HbW1czgru9p0
         WoTvEq/mn1iCUlFs4b8W2HHCSeHLQc9gCfba/Ae9xISf8gxvUfZNXBK0fBZs33/Efaut
         AvICYbsUet9Tp3Qd518cT0fhs/iNUSyXIO5QnTN4Hr6u1B/xHFr3BlaZgpO+bJt+NZpU
         hwX0ZqyZbjvF6MPhpLhWpSjkF+qeLO8TAjBJEQEb17FTWAVhb2tDX+hE+/LamHu+IfqG
         +ZFt78ksxdMqISLXXuKxiz+GVNu/AKnLikFafqZvYpcoAd9bg4UiObwWw8lDlavyTahn
         2Bxg==
X-Gm-Message-State: AOJu0Yx0F3enSGuvOiqI8CBWtW9ioSsLg7U8rXGzpOI33iHxRlFdXIfM
        MNmOJTUfXBY3HhbgPUU3rMcmkSfqRUo=
X-Google-Smtp-Source: AGHT+IFChbN8HMdA2gZsaodcSrytXbT4AwgAFpfF1saADVj4sQEbxn667GNHOFWcQttO8Sn32+P4Mz8Dp1Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1487:b0:68f:fa41:4e94 with SMTP id
 v7-20020a056a00148700b0068ffa414e94mr201334pfu.0.1694616435711; Wed, 13 Sep
 2023 07:47:15 -0700 (PDT)
Date:   Wed, 13 Sep 2023 07:47:14 -0700
In-Reply-To: <2eaf612b-1ce3-0dfe-5d2e-2cf29bba7641@gmail.com>
Mime-Version: 1.0
References: <20230913103729.51194-1-likexu@tencent.com> <5367c45df8e4730564ed7a55ed441a6a2d6ab0f9.camel@infradead.org>
 <2eaf612b-1ce3-0dfe-5d2e-2cf29bba7641@gmail.com>
Message-ID: <ZQHLcs3VGyLUb6wW@google.com>
Subject: Re: [PATCH v6] KVM: x86/tsc: Don't sync user-written TSC against
 startup values
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Oliver Upton <oliver.upton@linux.dev>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023, Like Xu wrote:
> I'll wait for a cooling off period to see if the maintainers need me to post v7.

You should have waiting to post v5, let alone v6.  Resurrecting a thread after a
month and not waiting even 7 hours for others to respond is extremely frustrating.
