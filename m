Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33217B3A82
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbjI2TSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbjI2TRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:17:54 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7AE1BF
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:17:50 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c1ff5b741cso130891455ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696015069; x=1696619869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9Agy5s4S8M1IK3kKW72b7BGJqP7wh82OnywEz1kIDU=;
        b=YCkq46jRGmImCAivsYasdO1yZRpq8MBFpCPMcS8448SaK56i/1rbbNnaoHUe6QghrG
         vdXi130cFuZODB44qWLxoIz3PZ12jUQRl6TsqdO/Tld+Sl8gSZ3FXjGBc4f3uep82zHs
         p1WO0hhsHgctz4uhJNcS3aPi/tXmloOjtMM7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015069; x=1696619869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9Agy5s4S8M1IK3kKW72b7BGJqP7wh82OnywEz1kIDU=;
        b=PX4D5GAq0pTWbY/xfvbysEHyg9/y2GmXiwVHFbVR0IcDC1Psnjm6euPp4jHH1iwNlJ
         AKNYMBFpqPvOAynWyTUP20EcE7LePP7OlkMK0v9bhDA3RQ3IFQUY/qiBq5Fm6i5+Ux49
         LsaJDVKe5ykiDdX3AStLPB1qH2oSIQCKiG92BJ8RkRy4RJ3py28lVmdpAPtaNz4MO/Os
         hrLlsiQDvWBw/UuJnPdFOfnAuIj4cgM/v/0SJyt1Wg/62Zi87yy7OR6NqfDBAH7uJ0YF
         8a2ZLNwOJFTCk8V2LhsW6NWIm/ki2XmCjNtwYPujfindg+n4yN2gdo6COuorlOo2Z//j
         CvZQ==
X-Gm-Message-State: AOJu0YwkjguTDjrALLYA/CqL4X7cPj3mRqu2rT+KiIeFrQ+ayQ5pehkn
        rUd0JZirL8H5U2TjWi9pA5Ok/w==
X-Google-Smtp-Source: AGHT+IEVDhX/ETUEQbx2moy+5lx2QtId+M6PvXVx/7NtlV7iSWepfhzKC/QMvckGkhEfvGTPuEjidw==
X-Received: by 2002:a17:903:1247:b0:1c4:3cd5:4298 with SMTP id u7-20020a170903124700b001c43cd54298mr5884998plh.18.1696015069590;
        Fri, 29 Sep 2023 12:17:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902dac300b001b9c5e07bc3sm17326434plx.238.2023.09.29.12.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:17:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ilya Dryomov <idryomov@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        ceph-devel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ceph: Annotate struct ceph_osd_request with __counted_by
Date:   Fri, 29 Sep 2023 12:17:45 -0700
Message-Id: <169601506494.3012633.9364328079132196540.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915201517.never.373-kees@kernel.org>
References: <20230915201517.never.373-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023 13:15:17 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ceph_osd_request.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] ceph: Annotate struct ceph_osd_request with __counted_by
      https://git.kernel.org/kees/c/b25373dde858

Take care,

-- 
Kees Cook

