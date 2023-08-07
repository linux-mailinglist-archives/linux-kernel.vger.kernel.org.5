Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4FC77267F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjHGNt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbjHGNtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:49:21 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A461BE2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:49:09 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d075a831636so4954157276.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 06:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691416148; x=1692020948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LrwjN5Q8LetwblRISR8oyofHz7AZ81IID5+NzR+/8cA=;
        b=V7Jh7Nsn3GJVY+ygsTFOkvGh4bLV8N8/Ew/DUfO2RWeke7HQyKDyjJX+JH09EUP2rA
         Jju6Z82uwl1JMOag6O15FNgv0xHCpxqyF6scOiN5H6wvWBVLBpQAZYVxgKhm29sonjSH
         TUYPL4ckDcXINMIpHVuFl+V+kpgsZjqnuZdEpGzTr8XStLu6S+g4JDUmGdlgBXaAUM9n
         bjPmpPjvVEQJr0K3eRuPaaXg4zdZFd/S2DaXMRrvLdjIBJLBqdqpOTfsnkgnGeK64FJR
         NxGiN3P3Vg/fHgZLkbbIvyLeA/NV8B11XiV/mObIGlymdQt9CJQqeELnuL5Kv2Sayvt0
         dJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691416148; x=1692020948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LrwjN5Q8LetwblRISR8oyofHz7AZ81IID5+NzR+/8cA=;
        b=ifWFRs2Jldq2utj3S3zBVJqpRDa3tPMbRE4fSW1+j6z43MAtuGz/bKrrijE5kwDXy8
         mMl6AGzHwD2dpdpewIVbUDeaPKvYtS7XyfABuxex8pvFI9EAE+6KNlr8UmVhJfniIj83
         jjtraZpyvhWUOGZTbkXWOxJAEKkLS/Enjay6JNCHYhtf2Vl6pGuSFYrAJ3EIeWvVtrVD
         muZbxFeT8sUtw0pgokxSQekmOPCompuwvkEkKbHCRGlcDBP8D7EglQEFumqzIpH6BkLk
         lFEkIAY1MnVuCmw7248bYkf1GtzJ++BcV/P6dOi49+zqBvxb5tByZfF3pqa9nkYHTBU7
         uA2A==
X-Gm-Message-State: AOJu0Yzt4n7DWtebMLNLkRZjTjDnHicrJZ30WJ2x+sEjLsV78bS4ciBS
        MldSweVGiuzOekFJgNFmHwNX00rqwPJSAPKJ83ICDQ==
X-Google-Smtp-Source: AGHT+IFlfGibypvOnYH7G4eRsSzX2n2Sgj1wUF/VjFKrm12jEANuab024sswGKNkLGhC7dNM+6Cl6fZVefMCQC5Ucn4=
X-Received: by 2002:a25:b316:0:b0:cea:b62d:620f with SMTP id
 l22-20020a25b316000000b00ceab62d620fmr9376359ybj.45.1691416147971; Mon, 07
 Aug 2023 06:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689802933.git.daniel@makrotopia.org> <1ce5f56df546cec25ef741f381286f1d7c33d000.1689802933.git.daniel@makrotopia.org>
In-Reply-To: <1ce5f56df546cec25ef741f381286f1d7c33d000.1689802933.git.daniel@makrotopia.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Aug 2023 15:48:31 +0200
Message-ID: <CAPDyKFqhZtCHVmCNnm_Qm7X+=GtJY8uNJOWOgZXuTTVEw0msNA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] mmc: block: set fwnode of disk devices
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dave Chinner <dchinner@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Jan Kara <jack@suse.cz>, Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Min Li <min15.li@samsung.com>,
        Christian Loehle <CLoehle@hyperstone.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Hannes Reinecke <hare@suse.de>,
        Jack Wang <jinpu.wang@ionos.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yeqi Fu <asuk4.q@gmail.com>, Avri Altman <avri.altman@wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ye Bin <yebin10@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 at 00:02, Daniel Golle <daniel@makrotopia.org> wrote:
>
> Set fwnode of disk devices to 'block', 'boot0' and 'boot1' subnodes of
> the mmc-card. This is done in preparation for having the eMMC act as
> NVMEM provider.

Sorry, but I don't quite understand what you are trying to do here.
Maybe you should re-order the patches in the series so it becomes
clear why this is needed?

Moreover, I don't see any DT docs being updated as a part of the
series, which looks like it is needed too. That would also help to
understand what you are proposing, I think.

>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/mmc/core/block.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index f701efb1fa785..fc1a9f31bd253 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2413,6 +2413,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>                                               int area_type,
>                                               unsigned int part_type)
>  {
> +       struct fwnode_handle *fwnode;
> +       struct device *ddev;
>         struct mmc_blk_data *md;
>         int devidx, ret;
>         char cap_str[10];
> @@ -2509,6 +2511,12 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>
>         blk_queue_write_cache(md->queue.queue, cache_enabled, fua_enabled);
>
> +       ddev = disk_to_dev(md->disk);
> +       fwnode = device_get_named_child_node(subname ? md->parent->parent :
> +                                                      md->parent,
> +                                            subname ? subname : "block");
> +       ddev->fwnode = fwnode;
> +
>         string_get_size((u64)size, 512, STRING_UNITS_2,
>                         cap_str, sizeof(cap_str));
>         pr_info("%s: %s %s %s%s\n",

Kind regards
Uffe
