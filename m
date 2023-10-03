Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFAD7B71A4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjJCTV2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 15:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjJCTVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:21:25 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9CF9E;
        Tue,  3 Oct 2023 12:21:22 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-57ddba5ba84so110251eaf.0;
        Tue, 03 Oct 2023 12:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696360881; x=1696965681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J07arKxPhBE5rnWHs+W7EtnjO5FU638RRkKT7+PaWpg=;
        b=KmU+P0Lz0Kqcb+CNQQoTEtK4pR6aTDrJK+wzSNoPmp1xLrhMUR3/tCvTJ/lK9+w3Hf
         ke+E/3vwKJqHOYqngeh7oc1J1hdzzSsryJSAEOzxzke5wGOAlhuzk7rn8e6pvX+KbXP0
         ufWsacyVK2a76CtHEEoHoGCa7YgzXJl9UWbzvAou0sRDNX4iZQQkf0eyrK1PPQIJ/rgc
         BbjRBhY6B73Gv46AYwDQ7PbUykfxb7dri08b1DOaRQiHC8Um4bf7Fx8hX7O5QBy7yLsE
         fSOY5xyQXevRWHn8caLhoxTx/UfdKAXGnzUPvC0aeU/VPByoa9OOBqdN4h0mPYdD0a9m
         kFGQ==
X-Gm-Message-State: AOJu0Yx/ed/V0yDCZOjrKyfj+jlU9bbzVpROTjsNsS67QCyw8vYAKFLr
        tXMSpmyuv3Am6UwGgZ7U4DlazkfTaZbQ9LH9POcdeKw8
X-Google-Smtp-Source: AGHT+IGFaRIXSHi99kNgDcHLm2UMpLuGWM/+wDAn3cApVRn6pa2cCI3SO0+MG4kvHsYCDhyIry2fRFOPz8oC1Tgh6JQ=
X-Received: by 2002:a4a:b588:0:b0:578:c2af:45b5 with SMTP id
 t8-20020a4ab588000000b00578c2af45b5mr331719ooo.0.1696360881692; Tue, 03 Oct
 2023 12:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <13c70c43.85d.18ad53580c7.Coremail.chenguohua@jari.cn>
In-Reply-To: <13c70c43.85d.18ad53580c7.Coremail.chenguohua@jari.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Oct 2023 21:21:10 +0200
Message-ID: <CAJZ5v0hwn3AueWnxD37Ar04FAYrKE+MkUMg5MjjLki9nSu=w1g@mail.gmail.com>
Subject: Re: [PATCH] pnp: Clean up errors in pnp.h
To:     chenguohua@jari.cn
Cc:     rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 8:31 AM <chenguohua@jari.cn> wrote:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: "foo * bar" should be "foo *bar"
> ERROR: space required after that ';' (ctx:VxV)
>
> Signed-off-by: GuoHua Cheng <chenguohua@jari.cn>
> ---
>  include/linux/pnp.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/pnp.h b/include/linux/pnp.h
> index c2a7cfbca713..267fb8a4fb6e 100644
> --- a/include/linux/pnp.h
> +++ b/include/linux/pnp.h
> @@ -291,7 +291,7 @@ static inline void pnp_set_drvdata(struct pnp_dev *pdev, void *data)
>
>  struct pnp_fixup {
>         char id[7];
> -       void (*quirk_function) (struct pnp_dev * dev);  /* fixup function */
> +       void (*quirk_function) (struct pnp_dev *dev);   /* fixup function */
>  };
>
>  /* config parameters */
> @@ -419,8 +419,8 @@ struct pnp_protocol {
>
>         /* protocol specific suspend/resume */
>         bool (*can_wakeup) (struct pnp_dev *dev);
> -       int (*suspend) (struct pnp_dev * dev, pm_message_t state);
> -       int (*resume) (struct pnp_dev * dev);
> +       int (*suspend) (struct pnp_dev *dev, pm_message_t state);
> +       int (*resume) (struct pnp_dev *dev);
>
>         /* used by pnp layer only (look but don't touch) */
>         unsigned char number;   /* protocol number */
> @@ -492,7 +492,7 @@ static inline int pnp_start_dev(struct pnp_dev *dev) { return -ENODEV; }
>  static inline int pnp_stop_dev(struct pnp_dev *dev) { return -ENODEV; }
>  static inline int pnp_activate_dev(struct pnp_dev *dev) { return -ENODEV; }
>  static inline int pnp_disable_dev(struct pnp_dev *dev) { return -ENODEV; }
> -static inline int pnp_range_reserved(resource_size_t start, resource_size_t end) { return 0;}
> +static inline int pnp_range_reserved(resource_size_t start, resource_size_t end) { return 0; }
>
>  /* protocol helpers */
>  static inline int pnp_is_active(struct pnp_dev *dev) { return 0; }
> --

Applied as 6.7 material with edited subject and changelog.

That said, checkpatch.pl is for checking patches.  Applying it to the
existing code is questionable and sending patches based on that is
even more so.

Thanks!
