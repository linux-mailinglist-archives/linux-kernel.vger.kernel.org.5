Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4E67E3730
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbjKGJIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbjKGJIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:08:14 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7645DD6E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:08:08 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a8d9dcdd2bso110024077b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699348087; x=1699952887; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C0xSdaRDzh/HWjDSjU83VJSZR2dGM+ZjfBD2HxHt7ZI=;
        b=BbNkTzxZWz0YduPK4IftJRKjr2zYeAxzsyTF9qKkG3/LYecbzvK+NKMdfVqkRSQ/09
         BtCsFQPw1AnhkvHNe3CAKvMi/6CuYfVGpWwo0++py3n1CP9S6f+0Gy+YzudqTFGMVMNY
         kuyBBvWMVAZFEzw8SQOZ43E/nyyZWckG5dvLU+BGCPowDLYVeorMCu1mDqZSBHKopA3B
         6g9DYj3ZRSA021JMeMjbEyRJ8VcE7BUh7VaDYfA/QB0Oqt17RtQXQ87by/A+lxQTeM8c
         cazAVQ/vR9I2ta6AnwABeADTT5sWYaZaaoxMbJo7TqnWnM9k39Y0+vGA9AFPMK0MJ5Ic
         4Kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348087; x=1699952887;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C0xSdaRDzh/HWjDSjU83VJSZR2dGM+ZjfBD2HxHt7ZI=;
        b=Wi1qd39197g1T9ekwQbkm/ptSwN3Nse8E7zLDxnXnpzZuYQrjbRr+BP21Zyft43tuI
         63Arpub31GakgJNPY336nHnoXf1gSQ3MhVhHYMwsvxilF5baXsw01rBdLMQDYuM1dvyB
         c+AOx5skxONAb0HFS70OBp5xUVqWf6OgVwIsg3tSXc7dBxE/WlUzZIPy2A7sO7Lw+obj
         PkypT8p5Mn0Xuupe/HquByerHpV+R9EZMLdc07q0D+iYKH+v7TZ0wAPGy1Qxxh19rhFv
         q0ldg9tvvwyCxteW256MOE3DLqT7V4wvPFVApgqScoUduNVMv4H9h6rzp7zIe+fyH6kl
         CH8Q==
X-Gm-Message-State: AOJu0YwmNu1Mo2H5mjbIgGbKB8ed8oMV4KC1p1lM8+k2adU+aV6P+GMW
        YP9dcmWEXmX05UN9PaWKJ43t07hLltN1RVE=
X-Google-Smtp-Source: AGHT+IHXKXnhXPv/Q69NZBg+Vkn6rXOrn4LecOP4SXQYcWiZ72hlMV4lR6teAz3b+xL5tls4wqeSNLiqkEwHA2g=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:6907:0:b0:d9a:cbf9:1c8d with SMTP id
 e7-20020a256907000000b00d9acbf91c8dmr570322ybc.12.1699348087479; Tue, 07 Nov
 2023 01:08:07 -0800 (PST)
Date:   Tue,  7 Nov 2023 09:08:05 +0000
In-Reply-To: <20231102185934.773885-6-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-6-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107090805.257105-1-aliceryhl@google.com>
Subject: Re: [PATCH 05/21] binder: fix trivial typo of binder_free_buf_locked()
From:   Alice Ryhl <aliceryhl@google.com>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>, Todd Kjos <tkjos@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Llamas <cmllamas@google.com> writes:
> Fix minor misspelling of the function in the comment section.
> 
> No functional changes in this patch.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0f966cba95c7 ("binder: add flag to clear buffer on txn complete")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

It's a bit confusing that the pair of methods binder_alloc_free_buf and
binder_free_buf_locked are inconsistent in whether they user the alloc_
prefix. It might be worth it to change them to be consistent?

Either way, this change LGTM.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
