Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB3A77A108
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 18:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjHLQ2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 12:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjHLQ2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 12:28:47 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0CF1BEC;
        Sat, 12 Aug 2023 09:28:50 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-487d998be8fso58748e0c.2;
        Sat, 12 Aug 2023 09:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691857730; x=1692462530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wI9FQMCLNTpjL2qhhzRaINad7koGEujRLKt4T3Y5F2s=;
        b=YyfNRdluycvVmawX6YasZQk9xLOZaZGtUgI83btoGQZ5Bdc9x2Jej/XESKtU6ow+Ig
         jbDiwlk4efKGURTf6wv+kf4DG09qC4hgP3QieimabEWDh/4eW3yNTuN3yBymOv3xTHGq
         D6LjTUv9X3lTFYU7BA2qe/qFIZwUFXc7p+zH8/XwLyoipkt+t16h3b+SMq59ee5HU44C
         k7mDLjXV+k3zPn9EeZ9IET9xMyqeZHj8aYNd0Rq0WLyDASeXFJGD3zdsDKyNMX3xe59N
         5BGrQo4IOHXcCzBiuwlMSmjCso+STImlWQ2xAwSITD+CcAcTFmwE5nucxWFIdpu/Ih3K
         zbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691857730; x=1692462530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wI9FQMCLNTpjL2qhhzRaINad7koGEujRLKt4T3Y5F2s=;
        b=l6feYH4jUOJNGA4IBCVgOVSMNIZnMfRiPlcFRRYAkWZIPHI6n2cbHGpj5B1x9kCvMf
         VCIflfci0vHUIg0w8cmOIvwov3W+dDjxAFbt7K+xyhAK/iglaUNUGvBVumloAwYQf/k9
         NJ29cqj+BB1o1VZlRk0SRlfpncFeliNcBCGYoqX741xUn80xhdvQ/lUl0tiFhXNEFszO
         k5RdW5mNkf+ki+ge50JYF/mGlypAutvLWEXXv8PQNbfG6xYoUoBGIYAD/iSUeANk3t4A
         CSYTsLx4fnug51erKC/2UxvTUUuwlWJ4hPhB+iNtkxlb0YSmxNkrseMyWAnvkETjWzp6
         D84Q==
X-Gm-Message-State: AOJu0Yw5R4UKn3giRYjoJSZS4So+4qIHL8fu16V8nBYfUaNoDcbfuHcD
        VaZ0pbk85qXBMRZzFBxLiPvBWMh67fXCP1MOXvQNUQAKCbs=
X-Google-Smtp-Source: AGHT+IHwMU6ZqvaSpsMWf4CoeExm9OpLPl8DKkQaQhlRRioXQrUSXY5J9zkviBMdrR8GKUUQ4oXbNK2/DC1fAJtzgDQ=
X-Received: by 2002:a1f:4545:0:b0:487:1370:d672 with SMTP id
 s66-20020a1f4545000000b004871370d672mr3587225vka.13.1691857729780; Sat, 12
 Aug 2023 09:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230521082813.17025-1-andrea.righi@canonical.com>
In-Reply-To: <20230521082813.17025-1-andrea.righi@canonical.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 12 Aug 2023 19:28:38 +0300
Message-ID: <CAOQ4uxhE8Y0eLDoKu9tfxvjJo-7K3aAmt4jN9+Q37Jzk7LxokA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] overlayfs: debugging check for valid superblock
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 11:28=E2=80=AFAM Andrea Righi
<andrea.righi@canonical.com> wrote:
>
> OVL_FS() is used to get a struct ovl_fs from a sturct super_block, but
> we don't have any check to determine if the superblock is valid or not.
>
> This can lead to unexpected behaviors or bugs that are pretty hard to
> track down.
>
> Add an explicit WARN_ON_ONCE() check to OVL_FS() to make sure it's
> always used with a valid overlayfs superblock.
>
> To avoid enabling this additional pendatic check everywhere, introduce
> the new config option CONFIG_OVERLAY_FS_DEBUG, that can be used in the
> future also for other additional debugging checks.
>
> Maybe a nicer solution could be to return an error from OVL_FS() when
> it's used with an invalid superblock and propagate the error in the rest
> of overlayfs code, but for now having at least the possibility to
> trigger a warning can help to catch potential bugs in advance.
>

Applied to overlayfs-next with following changes:
- open code WARN_ON_ONCE() in OVL_FS() (Miklos)
- rebase and add missing OVL_FS() accessors

Thanks,
Amir.

> Changelog (v2 -> v3):
>  - do not hide is_ovl_fs_sb() under CONFIG_OVERLAY_FS_DEBUG
>  - split consistent use of OVL_FS() and superblock validation in two
>    separate patches
>
> Changelog (v1 -> v2):
>  - replace BUG_ON() with WARN_ON_ONCE()
>  - introduce CONFIG_OVERLAY_FS_DEBUG
>
> Andrea Righi (3):
>       ovl: Kconfig: introduce CONFIG_OVERLAY_FS_DEBUG
>       ovl: make consistent use of OVL_FS()
>       ovl: validate superblock in OVL_FS()
>
>  fs/overlayfs/Kconfig     |  9 +++++++++
>  fs/overlayfs/copy_up.c   |  2 +-
>  fs/overlayfs/export.c    | 10 +++++-----
>  fs/overlayfs/inode.c     |  8 ++++----
>  fs/overlayfs/namei.c     |  2 +-
>  fs/overlayfs/ovl_entry.h | 14 ++++++++++++++
>  fs/overlayfs/super.c     | 12 ++++++------
>  fs/overlayfs/util.c      | 18 +++++++++---------
>  8 files changed, 49 insertions(+), 26 deletions(-)
>
