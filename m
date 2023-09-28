Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D387B15A7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjI1IFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjI1IFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:05:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA6599
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:05:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168A3C433CB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695888303;
        bh=PoJNxjIqib27skFPg1Iq3N3WLP/CrJV5nudnKtbDPII=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VuXe9jKaBVlnTHa/2G75UOXO9ObpSJYL818KAAjc7/ZIr3CqqYrJI6ZTWcRupUPx3
         y+emRukG/NHHEJVGj91EPb2ZNwqGWIDVhpPQDyCJS3HXr0s1Qea/5S/pT9YjG7QTG0
         Ihqjs/uCh+g/8Im1DhUSayquqwk6kTb7+iWZZccdr05Ot7Fd6Wn0qR0qPNEdAaGVLz
         dDTDgWFM9u3Evmwf7BiahzB7rrfBs/s9I3Bk+T+SGCAw2DySqWYmIQd389dgAWe/xR
         XK3b5Fx5UteWvBnHLfwu6VMgnshwLh49gal1Q3iSKgrLhMqDiNsAufq3bEKOnr7+mi
         ULI+4Plms0T2Q==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5a1d0fee86aso85992157b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:05:03 -0700 (PDT)
X-Gm-Message-State: AOJu0YyFftMPC4AbGWQ7BdxphKJAHCklryX1tCeBLQoDBn+reaXWWRxc
        YTuJcvph9p2Zb4Mv9iF9Wfw2qNJrnzSAm0q6S04=
X-Google-Smtp-Source: AGHT+IEOxZkSkGDu/ZPVvWuf5ZzJCZK/uM0BbqQ0H6zc9VIOtBbPfG5l/y6R7KoTPnnSzOXsmKKAxUl3SEUq60tf5hc=
X-Received: by 2002:a81:7cc5:0:b0:599:da80:e1e4 with SMTP id
 x188-20020a817cc5000000b00599da80e1e4mr338729ywc.30.1695888302208; Thu, 28
 Sep 2023 01:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230927072157.2544601-1-arnd@kernel.org>
In-Reply-To: <20230927072157.2544601-1-arnd@kernel.org>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Thu, 28 Sep 2023 11:04:35 +0300
X-Gmail-Original-Message-ID: <CAFCwf13JrDtgKiqQw46knk_J2zdBNA348doaTBMvmrYYc1OgHQ@mail.gmail.com>
Message-ID: <CAFCwf13JrDtgKiqQw46knk_J2zdBNA348doaTBMvmrYYc1OgHQ@mail.gmail.com>
Subject: Re: [PATCH] accel/habanalabs: add missing debugfs function stubs
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Tomer Tayar <ttayar@habana.ai>, Arnd Bergmann <arnd@arndb.de>,
        Ofir Bitton <obitton@habana.ai>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Ohad Sharabi <osharabi@habana.ai>,
        Dafna Hirschfeld <dhirschfeld@habana.ai>,
        farah kassabri <fkassabri@habana.ai>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 10:22=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wr=
ote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Two function stubs were removed in an earlier commit but are now needed
> again:
>
> drivers/accel/habanalabs/common/device.c: In function 'hl_device_init':
> drivers/accel/habanalabs/common/device.c:2231:14: error: implicit declara=
tion of function 'hl_debugfs_device_init'; did you mean 'drm_debugfs_dev_in=
it'? [-Werror=3Dimplicit-function-declaration]
>  2231 |         rc =3D hl_debugfs_device_init(hdev);
> drivers/accel/habanalabs/common/device.c:2367:9: error: implicit declarat=
ion of function 'hl_debugfs_device_fini'; did you mean 'hl_debugfs_remove_f=
ile'? [-Werror=3Dimplicit-function-declaration]
>  2367 |         hl_debugfs_device_fini(hdev);
>       |         ^~~~~~~~~~~~~~~~~~~~~~
>
> Fixes: 3b9abb4fa642e ("accel/habanalabs: expose debugfs files later")
> Fixes: 09fe78d2e4421 ("accel/habanalabs: register compute device as an ac=
cel device")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/accel/habanalabs/common/habanalabs.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel=
/habanalabs/common/habanalabs.h
> index 2a3acdbf91714..1655c101c7052 100644
> --- a/drivers/accel/habanalabs/common/habanalabs.h
> +++ b/drivers/accel/habanalabs/common/habanalabs.h
> @@ -4041,6 +4041,15 @@ void hl_debugfs_set_state_dump(struct hl_device *h=
dev, char *data,
>
>  #else
>
> +static inline int hl_debugfs_device_init(struct hl_device *hdev)
> +{
> +       return 0;
> +}
> +
> +static inline void hl_debugfs_device_fini(struct hl_device *hdev)
> +{
> +}
> +
>  static inline void hl_debugfs_add_device(struct hl_device *hdev)
>  {
>  }
> --
> 2.39.2
>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Applied to -next
Thanks,
Oded
