Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D093A7BFF3B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbjJJO2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjJJO2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:28:03 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDAFC4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:28:02 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-59f6e6b206fso71651517b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696948081; x=1697552881; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G+bzCawygPfYZQRWEWjzk60GqJiz5rFfjOtmLh7nplo=;
        b=K4rP0Ygv/I4SvoYv70rISgW7p1M57QcSAw786+766t/xC+pz9fjluzqMY79BLKNhKR
         RUpCz8qq3rxbFVA81LG8yzezrYU2UZqCD04hbOxCoycJuPx0rcKPcPZJefUpIa4lyU1s
         F0yo12ixoH8ppEwSkgf7++kz5HhICvbERPg0HPJ4h6fS42k0DFKeRQhG4lSOThjQjFyJ
         3DcCpzrnekpd8MX8rNUxXWTwHVM93w5IyYyQgfLzT8tJ6Xx/vHoQBAtHjQSgAzNn7YtT
         6PqcEJ+x3uMdq0lP0yrOlF4+PEYDco0QfKRijPbOB8IOTbmPxRKKeXIeQR7GaW8+2lSM
         e+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696948081; x=1697552881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+bzCawygPfYZQRWEWjzk60GqJiz5rFfjOtmLh7nplo=;
        b=DYc13btguUwTjAuBBR/gBFcvilkYVpbyGaqYn3BnJOo6EKuQF2c/AUZ7Y9r/bj5PUO
         CgEv1x6M0zyC4O1Q4dhnrWJ8ypuWUXsVaptVKED3IyHUW3ne/NQsqZkgGY0dxgG4BfDM
         cjEBH7PnmJxPafUyJtchkF/CnrgtOR2IU2/C6jKjmmGedsQ3IJesm2FuGpMHUXJUvDwS
         hYQOMV5rX7d4P7iMx4I3HtewSNEGWKI+kjHPAvEfSJPzidAGxi5+JXScQTRiB7dEpxnS
         Ks3KgZsmRcwutczXCN/6TjIKRyGDL3YR593TSUJqEnBzecElXw+8JWpwAwp2edkM2jDU
         Q/2g==
X-Gm-Message-State: AOJu0Yy1BOB1YCGokQh05EbOyIgnHAbtVu5tQGiWtgDc1CG2nMGToMD4
        Svbyxkc+gWsCEcdpqHuAf6rC8gqsctw2RGHJGmGc2Q==
X-Google-Smtp-Source: AGHT+IEWokDbVqlkMPFDHZLLeXvpDy2LcMylLq0K1tDaame0w/TBAEIlq4XoMo0X/ee88uUG+47+PxMN4Jyxd7+521A=
X-Received: by 2002:a25:6b4e:0:b0:d85:b09e:b9c9 with SMTP id
 o14-20020a256b4e000000b00d85b09eb9c9mr19897738ybm.52.1696948080773; Tue, 10
 Oct 2023 07:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230929-mmc-caps-v2-0-11a4c2d94f15@axis.com>
In-Reply-To: <20230929-mmc-caps-v2-0-11a4c2d94f15@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Oct 2023 16:27:25 +0200
Message-ID: <CAPDyKFob43kTEXqf4-gXj7CQCpdn2nKHxoAsXv4nFgaQ88s-dQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mmc: Allow speed modes to be adjusted dynamically
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sept 2023 at 09:45, Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> During board verification, there is a need to test the various supported
> eMMC/SD speed modes.  However, since the framework chooses the best mode
> supported by the card and the host controller's caps, this currently
> necessitates changing the devicetree for every iteration.  This series
> provides a way to adjust speed modes dynamically via debugfs.
>
> --
> Changes in v2:
> - Replace module parameter with a debugfs file.
> - Add patch to move mmc_select_card_type().
> - Link to v1: https://lore.kernel.org/r/20220623080009.1775574-1-vincent.whitchurch@axis.com/
>
> ---
> Vincent Whitchurch (2):
>       mmc: core: Always reselect card type
>       mmc: debugfs: Allow host caps to be modified
>
>  drivers/mmc/core/debugfs.c | 51 ++++++++++++++++++++++++++++++++++++++++++++--
>  drivers/mmc/core/mmc.c     |  7 ++++++-
>  2 files changed, 55 insertions(+), 3 deletions(-)
> ---

Applied for next, thanks!

Kind regards
Uffe
