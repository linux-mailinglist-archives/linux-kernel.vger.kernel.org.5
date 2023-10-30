Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102237DB5C1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjJ3JGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjJ3JGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:06:13 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FE4E1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:06:10 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-457c441555cso1531487137.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698656770; x=1699261570; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2OdcaOyDWUAa5voeFS+aWD7oVKDHZY12nV1O4/Mi2GE=;
        b=lx39+V1SZQPCFiMvaKxUFBezYkNtZ9FOspVQOAY/EXSjeBS9nHSKWEXv0/DTBvQDsS
         rWlwNkEHL6gvLr2nAB2lsAw4VH1tXPyyM2lKdGx3Q4smA0fXQoRj2EAoKGL2ae2xaGr8
         R0X31nIHUr/9Dmb2FPxYvcUf+uHtHlG6na1i/h1Wdi/VFm28/pRN+/9KxLa0vTs/46F7
         bW5GTHfIb1LzvFj98+e4S5dffX2y1/ED4ooyN+fnT1G08t6sjnRMjcz5V1KC3PpYFD9a
         2TH1NhWZOP0/eD+oKJ2w0N9LKrdKXqUXRlczwSNo40kkqyIVLv9nWhQ50NcYM7UPkTTo
         b7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698656770; x=1699261570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2OdcaOyDWUAa5voeFS+aWD7oVKDHZY12nV1O4/Mi2GE=;
        b=v/b1iyJuQ9cozBWMUuwQ00g06BpCQbZPkl6Y2cV35HjVGztFYwn1o42zwK17M/+hp+
         HrMeVQdTRVLaTzrL3AGQiiUttIByH7dA3I+kuuG633AhsgkXnSD2oRb6svS5WYqBl/vp
         sRbCFednnHxAZT0Qih85P0NQ04SpqQn8e5DMde0wlxjLmsvw9I820C/DJfvimigC12iT
         Q8VUVTt1SqilPWAUfP+3rrKXva24fQxKOwhDQNBQjV0MFfwow9h9GMjtAR4ETg/I0OdQ
         bgMKOW4tuGnWYDir9lnT9yLYWvW0rO/BjOt6cvmdeg0HhLxAglxB8GsJ03JydI+ysrlJ
         ptGQ==
X-Gm-Message-State: AOJu0Yy0LTkxDHrB7H9/FkVzlgAGe3Sn0Z578fdSqCrdYk8Pvv88Zjkt
        PVybvK1B1NakOuU/F04Y8lKswEsCL/JEVyd1r8UmRg==
X-Google-Smtp-Source: AGHT+IFew14tAfN8mn9H17+RgQdoQdY8IAqkv79fqM1mDuM+KN+CoDwwS68Mr7ku3beaHgU3P61lluDjpmdPBlvcQKE=
X-Received: by 2002:a67:c309:0:b0:454:5a16:890d with SMTP id
 r9-20020a67c309000000b004545a16890dmr5654062vsj.24.1698656770068; Mon, 30 Oct
 2023 02:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231030085515.907123-1-etienne.carriere@foss.st.com>
In-Reply-To: <20231030085515.907123-1-etienne.carriere@foss.st.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 30 Oct 2023 14:35:59 +0530
Message-ID: <CAFA6WYO4m5n9oTzP1zJdJXASCwXdhVaa_tMN2EhDTNDMmxwaJg@mail.gmail.com>
Subject: Re: [PATCH] optee: add missing description of RPC argument reference
To:     Etienne Carriere <etienne.carriere@foss.st.com>
Cc:     linux-kernel@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        op-tee@lists.trustedfirmware.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 at 14:25, Etienne Carriere
<etienne.carriere@foss.st.com> wrote:
>
> Adds missing inline description comment for RPC optional arguments
> reference.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/lkml/202310192021.fvb6JDOY-lkp@intel.com/
> Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> ---
>  drivers/tee/optee/smc_abi.c | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index d5b28fd35d66..67bfa25d6302 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -806,6 +806,7 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
>  /**
>   * optee_handle_rpc() - handle RPC from secure world
>   * @ctx:       context doing the RPC
> + * @rpc_arg:   pointer to RPC arguments if any, or NULL if none
>   * @param:     value of registers for the RPC
>   * @call_ctx:  call context. Preserved during one OP-TEE invocation
>   *
> --
> 2.25.1
>
