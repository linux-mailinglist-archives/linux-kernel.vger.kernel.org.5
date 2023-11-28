Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55C37FB6A9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjK1KEl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Nov 2023 05:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbjK1KEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:04:37 -0500
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0E7BF;
        Tue, 28 Nov 2023 02:04:43 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5cfa65de9ecso24784107b3.2;
        Tue, 28 Nov 2023 02:04:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701165882; x=1701770682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVYbGk8nOx+pxSV84i/1qbnW/GNJF1Gu7ctCWCcQoto=;
        b=PUNDoxt4Wa3zrwvorqri5wSiNSH7dPvWRtOea1zXbR6peQndf/fDbZ2mSJjbalDd4f
         viLh5oz9C527J16XMoGtMg4TP3YQR7t/2ypPMNFQb/E4Bmr9zUoOlDbRiQwkihAaG5UD
         5maWMXOZjmHYmKgDSSTKJQEIVYyLJeG+lq13F2/8OqPok1g+ObUt4RHJWflwLlRuCDJy
         hISnQ8zmkNKdU0zKddH/wY1ZOYP9pXaO9v1ngsd8ncKVo5e8w+5KkGNS2bnhZwJ4A2Tq
         35gjJNJCji+RPgfQGTBBXM3IiVxu4zjUwZE5xp8vybKvzkK+tbsQSk6aUVoIB4kuf1VA
         sCMQ==
X-Gm-Message-State: AOJu0YxaQhoKjLZeKeBsanqyXFXRTjwbah3l/Te5N+Wp/uGKDq64AKxZ
        9XvH17slCL7V00fzuMkey1R4A8vlAjJIxw==
X-Google-Smtp-Source: AGHT+IGsl0Nq/1I/eqdAItPwveGjeqEE+qndQzI59+8BTNdccZZr+25bYc5HBBBFaXSVkjnq/uCQvA==
X-Received: by 2002:a0d:f281:0:b0:5d1:1bab:5902 with SMTP id b123-20020a0df281000000b005d11bab5902mr3955847ywf.15.1701165882596;
        Tue, 28 Nov 2023 02:04:42 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id w2-20020a816202000000b005cc916956d5sm3856505ywb.145.2023.11.28.02.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 02:04:41 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5cfa65de9ecso24783787b3.2;
        Tue, 28 Nov 2023 02:04:41 -0800 (PST)
X-Received: by 2002:a81:9282:0:b0:5a7:afcc:80fe with SMTP id
 j124-20020a819282000000b005a7afcc80femr9012513ywg.3.1701165881168; Tue, 28
 Nov 2023 02:04:41 -0800 (PST)
MIME-Version: 1.0
References: <20231122112930.5e7c7bcd@canb.auug.org.au>
In-Reply-To: <20231122112930.5e7c7bcd@canb.auug.org.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Nov 2023 11:04:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW_6rU3uVuBBKh2nMWPC0tPOpxhf9xhD2L6T5frsF=q3w@mail.gmail.com>
Message-ID: <CAMuHMdW_6rU3uVuBBKh2nMWPC0tPOpxhf9xhD2L6T5frsF=q3w@mail.gmail.com>
Subject: Re: linux-next: manual merge of the drm tree with the drm-misc-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Wed, Nov 22, 2023 at 1:29 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Today's linux-next merge of the drm tree got a conflict in:
>
>   drivers/accel/ivpu/ivpu_hw_37xx.c
>
> between commit:
>
>   3f7c0634926d ("accel/ivpu/37xx: Fix hangs related to MMIO reset")
>
> from the drm-misc-fixes tree and commits:
>
>   3de6d9597892 ("accel/ivpu: Pass D0i3 residency time to the VPU firmware")
>   cc19fedab8bd ("accel/ivpu/37xx: Print warning when VPUIP is not idle during power down")
>
> from the drm tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks for your resolution!

> --- a/drivers/accel/ivpu/ivpu_hw_37xx.c
> +++ b/drivers/accel/ivpu/ivpu_hw_37xx.c
> @@@ -720,14 -731,19 +733,14 @@@ static int ivpu_hw_37xx_power_down(stru
>   {
>         int ret = 0;
>
> -       if (!ivpu_hw_37xx_is_idle(vdev))
> -               ivpu_warn(vdev, "VPU not idle during power down\n");
> +       ivpu_hw_37xx_save_d0i3_entry_timestamp(vdev);
>
> -       if (ivpu_hw_37xx_reset(vdev)) {
> -               ivpu_err(vdev, "Failed to reset VPU\n");
> -               ret = -EIO;
> +       if (!ivpu_hw_37xx_is_idle(vdev)) {
> +               ivpu_warn(vdev, "VPU not idle during power down\n");
> +               if (ivpu_hw_37xx_reset(vdev))
> +                       ivpu_warn(vdev, "Failed to reset the VPU\n");
>         }
>
>  -      if (ivpu_pll_disable(vdev)) {
>  -              ivpu_err(vdev, "Failed to disable PLL\n");
>  -              ret = -EIO;
>  -      }
>  -
>         if (ivpu_hw_37xx_d0i3_enable(vdev)) {
>                 ivpu_err(vdev, "Failed to enter D0I3\n");
>                 ret = -EIO;

I've just run into the same conflict, and I think you lost the split
into two if-statements in the last hunk of commit 3f7c0634926d
("accel/ivpu/37xx: Fix hangs related to MMIO reset")?

My resolution is:

--- a/drivers/accel/ivpu/ivpu_hw_37xx.c
+++ b/drivers/accel/ivpu/ivpu_hw_37xx.c
@@@ -720,11 -731,16 +733,13 @@@ static int ivpu_hw_37xx_power_down(stru
  {
        int ret = 0;

+       ivpu_hw_37xx_save_d0i3_entry_timestamp(vdev);
+
 -      if (!ivpu_hw_37xx_is_idle(vdev)) {
 +      if (!ivpu_hw_37xx_is_idle(vdev))
                ivpu_warn(vdev, "VPU not idle during power down\n");
 -              if (ivpu_hw_37xx_reset(vdev))
 -                      ivpu_warn(vdev, "Failed to reset the VPU\n");
 -      }

 -      if (ivpu_pll_disable(vdev)) {
 -              ivpu_err(vdev, "Failed to disable PLL\n");
 +      if (ivpu_hw_37xx_reset(vdev)) {
 +              ivpu_err(vdev, "Failed to reset VPU\n");
                ret = -EIO;
        }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
