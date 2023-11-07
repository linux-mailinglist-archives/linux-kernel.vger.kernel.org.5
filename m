Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4299E7E3732
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbjKGJIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbjKGJIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:08:16 -0500
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD83A11A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:08:11 -0800 (PST)
Received: by mail-lj1-x24a.google.com with SMTP id 38308e7fff4ca-2c50bebd8dfso52908781fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699348090; x=1699952890; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ExLWl0QolSWqz2kjE3GKDzaYL2afXshZrJ9QzMMJhas=;
        b=3dKIdNHbGXOllTwEl7/L3hn8z5rKYVKoCsr0t1vjngotqv7cVUCw+5ro4OlNUVggS8
         8A9F6OjV/uRZ7LLwai8Yswh3WbPMNxecVRYa71RhJe5bd0La7N3YoNxD8JOictleqyqa
         JhOdRzDI9AsGWiSZp7Px50fdg1je0yhSDZV/2jKlqi9l25BA+oXVFC9d/SJGkQR47kaX
         1N5782BoGggOV25qH99U6a7zdHnF/Ag0v34RjaGcqhLl4NG0TbDaHDT5TI17JafRu6ad
         aCYxv/PzLcVpJA9YXVZV+8hezw26A76Sh806y6BsX5LnfvZHpml2TCcgPN/9IrxIPBCf
         Tvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348090; x=1699952890;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ExLWl0QolSWqz2kjE3GKDzaYL2afXshZrJ9QzMMJhas=;
        b=oJUQpGqP3tcpAeLkX+/1oUGX8IUTebmH4lodbAPPfTNThvtClZw0jri17MaodHr+m4
         VxdS9COcfl1zTJcEcKHPYWwhPxjJlwvp7zLSNFq8aq6/dJj4pQfcEuMpiJyGb9kPuXIP
         C+bwPVH7mXGtU04TN5hVARmfPvONOgvOdw9fjm1WcE+HWxt9bRRHncvM2yZ7FwvZZ+Oe
         fV7i1Y/WWT3IJ9VxRjHDjhMVmLwPqNhVuRQeyX8L1Aq0LG4cATzF30vuyE8PPJ0gb31H
         MUaoXeNQGpQF93wAD8Y3hgZ+epdI4BHhnqHOzmsefQHMm2bC1VOFRDt+ryfBbZ90rr+8
         lKOQ==
X-Gm-Message-State: AOJu0YwpF0+iFp8QXr9ULHIGuUnJhHJuwXlBvzP0U+5j0p1B9IlJNd93
        Dyzt/27o/thLHmKPgqMYgnoYNAxkaqikEyo=
X-Google-Smtp-Source: AGHT+IEXePoTNrrGBqRaAguAqJHnXRfz2BaO8/JFEw/7ppQAkX17kYko29BpRG8TuvhHB/gS/tF8HKO5yJdcWY0=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:b0c3:0:b0:2bc:d607:4d1a with SMTP id
 g3-20020a2eb0c3000000b002bcd6074d1amr358802ljl.7.1699348090222; Tue, 07 Nov
 2023 01:08:10 -0800 (PST)
Date:   Tue,  7 Nov 2023 09:08:07 +0000
In-Reply-To: <20231102185934.773885-7-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-7-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107090807.257402-1-aliceryhl@google.com>
Subject: Re: [PATCH 06/21] binder: fix comment on binder_alloc_new_buf()
 return value
From:   Alice Ryhl <aliceryhl@google.com>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>, stable@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>
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
> Update the comments of binder_alloc_new_buf() to reflect that the return
> value of the function is now ERR_PTR(-errno) on failure.
> 
> No functional changes in this patch.
> 
> Cc: stable@vger.kernel.org
> Fixes: 57ada2fb2250 ("binder: add log information for binder transaction failures")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
