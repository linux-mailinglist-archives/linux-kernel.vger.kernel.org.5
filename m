Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7729D7F0F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjKTJ6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjKTJ6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:58:03 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEAC9E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:57:59 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so12852a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700474278; x=1701079078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2YoIj7IxZVQMxemwiREVJYCJdXNAZDi8IPlwZCc5gE=;
        b=FxImC+f9+8IzbDwBgrwvHiHC6CBKiZB0lunGeN/z59pZ/GwLTupid8MLYr8IruCmfM
         4i2oncCTGvX6kn41g3nqLUr1Np4feKxRAKEtDaa5M7yW6EvFtluKLHjLnIvh2H8YspOF
         /OlHLQ/Cb9mNkLePbkdGPrk8b2/wXEv2RShjmxjJMPMrGUXkZbtyobACvg6xj68G+B+E
         l0X6ojHFiZlICgPTd612gMW7D6Sk2otb8+PT+p/gdGQnB/yUJXRuksTdohJHELCIj7Fz
         fOwnzAwbFH0xBH3yPfuptn9cbRDtngVpbWKTlKpFtWNvi0suqMbbZKNUnQ6TxuT5DPYS
         MlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700474278; x=1701079078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2YoIj7IxZVQMxemwiREVJYCJdXNAZDi8IPlwZCc5gE=;
        b=QVJRQA9f2BdcTtQfvl67lrmbWluCTroSOnmeGg7cDjavfhB4UMvgowGptLvVfcUbgG
         OYEgytxXjyyCaRYrkZUMa4QpeSiKxyy4IdbCl1j5BnN57G1YOK5zoEgTeoQ0S2b6VJcb
         TufphtXzCUcwzYMSSw1/bafEUqraF13WjjekBlA1lTKWBMj8AhbhYVpedmsV3HnIjOsn
         DUGqds1x14+kSU2BBCx2xz23Eycd3AiEe4G6Z5e6ozfw9t3BuwPZLKeuWLgdslnNqUp1
         CluVBjgb0A5WrgtL8vs4Q7bIaNzh8NALwUrXaaFBfP+Ah0rjaSc6HVrW3AMWSDo5PHWS
         gyDQ==
X-Gm-Message-State: AOJu0YwY8yWg6pRHUp6Hq+4V4KNcGX0ZPnNQPHKmbJachyYS6IWhaYS+
        8T5WVLUkuWmIrtgACecnPNifsmzYeCj5Pi5sXgdPmw==
X-Google-Smtp-Source: AGHT+IFCGagQaI6uXwg0TJHnLdCwNRH9AV2vQwnqB2jNFhZlUMWYV3MA9OBS+uIgQn0GN1GhmneyAlVluouNdzaJIX8=
X-Received: by 2002:a05:6402:c41:b0:544:e249:be8f with SMTP id
 cs1-20020a0564020c4100b00544e249be8fmr219302edb.1.1700474278195; Mon, 20 Nov
 2023 01:57:58 -0800 (PST)
MIME-Version: 1.0
References: <CANn89iKsirkSvxK4L9KQqD7Q7r0MaxOx71VBk73RCi8b1NkiZw@mail.gmail.com>
 <20231119092530.13071-1-haifeng.xu@shopee.com>
In-Reply-To: <20231119092530.13071-1-haifeng.xu@shopee.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 20 Nov 2023 10:57:47 +0100
Message-ID: <CANn89iL3hY5BcdJi1yRrB6YphnucYtAM3Z8bz-zWcvv49T34uA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bonding: export devnet_rename_sem
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     andy@greyhouse.net, davem@davemloft.net, j.vosburgh@gmail.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2023 at 10:25=E2=80=AFAM Haifeng Xu <haifeng.xu@shopee.com>=
 wrote:
>
> This patch exports devnet_rename_sem variable, so it can be accessed in t=
he
> bonding modulde, not only being limited in net/core/dev.c.
>
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/bonding.h | 3 +++
>  net/core/dev.c        | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/bonding.h b/include/net/bonding.h
> index 5b8b1b644a2d..6c16d778b615 100644
> --- a/include/net/bonding.h
> +++ b/include/net/bonding.h
> @@ -780,6 +780,9 @@ extern const struct sysfs_ops slave_sysfs_ops;
>  /* exported from bond_3ad.c */
>  extern const u8 lacpdu_mcast_addr[];
>
> +/* exported from net/core/dev.c */
> +extern struct rw_semaphore devnet_rename_sem;

This probably belongs to include/linux/netdevice.h

Reviewed-by: Eric Dumazet <edumazet@google.com>
