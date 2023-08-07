Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D555A7729D6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjHGPwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjHGPv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:51:58 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0D6171A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:51:54 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-ccc462deca6so5132282276.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 08:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691423513; x=1692028313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fywVO3lf7mQtJxXDySZPqv0vkHYL4Ucsl/1T7KbfFw0=;
        b=YEEAhG6FfOCvgKllcbCs6rN8SsxbA/TeCFqwQuVfthmEHVcho1S5Pd5mSLN+6tXv5V
         1FJlibgt3ADfPmZsQ5F8EpJybfTs8SQaAHpx4OAk8BfAb4JV0Bkn/fTO+GHumm/tTR7W
         YPNp85lAGLnuf/oE8KpRs0Sxgf+mPuNz1owr4PFuZZ7RvuZIryqy93ywQmJ1R8SrP8JK
         KhMObsY9SqtnDdSXZnWtNkoBH8/fuyJhr6FVJvtCkKzAunqOppCVJUP31bWfONFqdYBG
         AD0pR3U5e2hdDEBAmsCprvLAR6M4d8otzYVbdQJikpG+uvMZVlu/SZPg1OEvKUeM7vMT
         n8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691423513; x=1692028313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fywVO3lf7mQtJxXDySZPqv0vkHYL4Ucsl/1T7KbfFw0=;
        b=ePK9i1lCJauTXlQs9HAQvZ/sPfunUf9YSdmiNlZ1tqhu9kg7KQtrtjvWUm9AsBjm9B
         x6qHhdraoaP4NlRc+7pRJu4CxuMx2zqtPUi5ORnXRZeECB8rci+ZM79swmgusrBzt7eu
         4SDJ4typL+wHqZCpcOagSmDVox0GAZIHhZRG27jh0t1QDc7YiwQ4JZMUFde25XG3gshU
         oMWritxBxK6y/eOpfyFzjUkw6tKUUvuvQ31Fk3SvZw19n5mF6rirebqJq2Lr0TQU+jvL
         FFQ+mHjUSGsZpFNxFGgAPcqkQosLXIGrgXJGd4IVszGK/+sPB/7tpH/fy5mX2oSYHN0h
         HM0w==
X-Gm-Message-State: AOJu0YyGauqPcZAPqBeQXpU9Cnql6vNsy2cGVY2CSexQUF639ZBnci2t
        kSlW6epr0u9+yUojUsaLAgRYNDDzKgEbCfAOuVNBJYp2nCY7xHWO
X-Google-Smtp-Source: AGHT+IHotlZf+gkYBU+hlFS/BaBSmIccrU6QFT+2vGHAtsc9eE269pZH6xcQbzUh4Xs2WZxxw1GaJxKs/vfyVAadD7k=
X-Received: by 2002:a25:d1d2:0:b0:d3c:932b:806f with SMTP id
 i201-20020a25d1d2000000b00d3c932b806fmr9771257ybg.43.1691423513649; Mon, 07
 Aug 2023 08:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230725-mmc-removable-v1-1-b2e0c4f18e6d@weissschuh.net>
In-Reply-To: <20230725-mmc-removable-v1-1-b2e0c4f18e6d@weissschuh.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Aug 2023 17:51:17 +0200
Message-ID: <CAPDyKFrWXQHWaEX5=rq-Gf5-by90iqtxWCuUu_QquRaMfhHtVw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: propagate removable attribute to driver core
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 at 16:17, Thomas Wei=C3=9Fschuh <linux@weissschuh.net> =
wrote:
>
> Userspace can use this to distinguish hotpluggable mmc devices such as
> sdcards from non-hotpluggable ones such as eMMC.
> One example is the lsblk tool from util-linux.
>
> Note that dev_set_removable() is not related to GENHD_FL_REMOVABLE which
> is not applicable as per the comment in drivers/mmc/core/block.c
>
> Link: https://github.com/util-linux/util-linux/issues/2379
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/bus.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 2c3074a605fc..0af96548e7da 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -310,6 +310,9 @@ int mmc_add_card(struct mmc_card *card)
>
>
>         dev_set_name(&card->dev, "%s:%04x", mmc_hostname(card->host), car=
d->rca);
> +       dev_set_removable(&card->dev,
> +                         mmc_card_is_removable(card->host) ?
> +                         DEVICE_REMOVABLE : DEVICE_FIXED);
>
>         switch (card->type) {
>         case MMC_TYPE_MMC:
>
> ---
> base-commit: 0b5547c51827e053cc754db47d3ec3e6c2c451d2
> change-id: 20230725-mmc-removable-5cfdca9ed062
>
> Best regards,
> --
> Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>
