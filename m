Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67A878A9A8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjH1KL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjH1KLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:11:10 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6AFC6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:11:05 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bcfe28909so381455866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693217463; x=1693822263;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w0aB9mS5umki3nGOOnKy5a7bG3YzGO91VSux9t3FVE8=;
        b=gjMlGyX8G2VIT7hQHBZSXvGAPMXuXvIzp5uFw5evMTbkHFfmnR9t5PpqNJEF/7rAKR
         UeTv+SNyjtDb2gfCQYiWjx4ypzTa0Ih81Et19ExVxMTALwtoMM1qS5Uj6bQuR4rm4p64
         /BDTbyPEMHEFuUZ0V7le8aaC89qWIjRR+vUHveu4eMVsGfZyj48NvXqda0lbS2k6nas9
         9DrGJFTbjpPMb4S+kGAgM3bNdOFWd/JA/cxJxHOpY04WtFW/a+28rivkI6SZwBPwCxSI
         q9On66xw4xChEY+DmM4W1fC/PDGeT+kLp0vw0OGB7y5d7a4A6IkivL+rFxT+NuShg+GI
         Vwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693217463; x=1693822263;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0aB9mS5umki3nGOOnKy5a7bG3YzGO91VSux9t3FVE8=;
        b=WHj1xc4ytczcyflTxsvABaoRVDJLRCjEp2hMOLQa7Bev7A+LXWDV+Ab20O0c1sAfcY
         Opdt1fCYUcCgBRHiZ6Rzm6aHNWeIUMor72eJy2ATJCL/WJvwCgEsy7XO22ZDwf+gwRO1
         tMuWMSYNpaCDEOMIDcqBhLyHa1dP0ETRI8y/j0WK61azzMs+/hB/cUlmhc5b90/Z0K1a
         MDJBoD/efF4LYX1GUfh/o0bYy7GU2CwOGMwHwL+4t6lkX3ZQRi9GK+hjLaExz0zZuJuY
         vSid68VZFNKSsXZJRA1ZuFw5kJfOnSgYlqLOrinq+6bedivzW0E55fHPoptqMX1dv51L
         1JYQ==
X-Gm-Message-State: AOJu0Ywb6Y1gqiAUPtB1oQzzxNsWcCbkfWziO6Me9EGuA9CRlIbLObWu
        2cEvkdHrPLt5Jm9mrdgaL9cGHssZyH8MHoXSJ3hb4sTx9+Y=
X-Google-Smtp-Source: AGHT+IEffL1V9Vg80JKgXLFjxaKl63RL5C7oiWdzSnzCbNhM9RluZ0rqTJEkaQNqLwFGxiPKgxLdg3fPaBOuJya1kcE=
X-Received: by 2002:a17:907:a08e:b0:9a5:b8c1:2ce1 with SMTP id
 hu14-20020a170907a08e00b009a5b8c12ce1mr851592ejc.31.1693217463503; Mon, 28
 Aug 2023 03:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230727122448.2479942-1-arnd@kernel.org>
In-Reply-To: <20230727122448.2479942-1-arnd@kernel.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 28 Aug 2023 11:10:27 +0100
Message-ID: <CADVatmNWhvCh3d0XAAOTQ0Cen2d=ghfrAvabVB8fOqHSt4duSg@mail.gmail.com>
Subject: Re: [PATCH] [v2] parport: mfc3: avoid empty-body warning
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 at 13:24, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> on m68k builds, the mfc3 driver causes a warning about an empty if() block:
>
> drivers/parport/parport_mfc3.c: In function 'control_pc_to_mfc3':
> drivers/parport/parport_mfc3.c:106:37: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
>
> Remove it in favor of a simpler comment.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>


-- 
Regards
Sudip
