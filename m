Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE9C7BE7BE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377829AbjJIRW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377314AbjJIRWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:22:53 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ED89D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 10:22:52 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-352a27ab1aeso18318525ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 10:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696872171; x=1697476971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FyrHUncwIbuAenfVDZXIgy/WAecJiWycGhNcLfrs9wQ=;
        b=S7I8hYhoWO0Dke2WGOzGu+y/xeYTRmS7y5b/Dd8CatpuD/lxJtjoTqkBjFltZk/Gxm
         DeYDNQFX69s9vhgMoct6OpDKxokUZRazscn+Gh1KO+TwlHvsqj0ECCPPtqHMNWelPNL4
         Lj2FNFR6hSbRNcVVvGX6PxTA9HIFMhJPvUN1A/LKIQa21E822YCqQG8uF0uGLQvb7ygp
         /w6RNMzcsClSk24ncdlM61x8VKylRItSyHAno8Yq3Ae25ohmbX5lJNu/pT7UrJptkG/p
         OwCvxmxyBojG9c+uavJ/Iyu4UpK6I5jecY7qKJxMvHOM3oXSgo54avvzWbkKL+7TngVA
         Ulcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696872171; x=1697476971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyrHUncwIbuAenfVDZXIgy/WAecJiWycGhNcLfrs9wQ=;
        b=ox3qUXV8Eykmzcr4xFdkQGANIHAkJJ0EKiUjmnsHvhdCBKBU2DdFeqlLx8Emu0wn8g
         kggkBZ5JV6awHmFLMDH9Y5udYZUG7VB+j9Dw1wCGyN/C8kOurmFYFm/eZaSfNOwMxG+6
         dJwFih1343GOS6oO/VCGVGYOp+T2DH9Cnj3SVxskJoekMT3Mg2HV9ZEVROD5A6LJVu5f
         hZJVgmvWZoaVons4kz3kDXw/CGUcmKlhSpuWRujJdHL4kiYdOIO32MehVnCEDU2oK+tB
         pEdNlmuWFE5LS2MuzcffFHo2/ylHQ5E3P0SQwAN2NTrz+zxEpa6yedMivyQL0Gn4jUYi
         3pmQ==
X-Gm-Message-State: AOJu0YwxZygIvxZB6BM4FenD5wDeJ/vKwbuEw5RYSN3+sYuKWDs+PP5L
        Z3mkSg1VVLtpcgsTnW8/d1pOfg==
X-Google-Smtp-Source: AGHT+IESGDL5JZuUy4WjDigCmfDdd2PwU93Z9KgGz2t770bhc/dWPwn/PzFLzV84RY8/doRRjiQqFg==
X-Received: by 2002:a05:6e02:1c46:b0:351:57d5:51c4 with SMTP id d6-20020a056e021c4600b0035157d551c4mr21254542ilg.1.1696872171467;
        Mon, 09 Oct 2023 10:22:51 -0700 (PDT)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id cw19-20020a05663849d300b0042bb6431487sm2246205jab.65.2023.10.09.10.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 10:22:50 -0700 (PDT)
Date:   Mon, 9 Oct 2023 17:22:45 +0000
From:   Justin Stitt <justinstitt@google.com>
To:     Ricardo Lopes <ricardoapl.dev@gmail.com>
Cc:     manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
        coiby.xu@gmail.com, gregkh@linuxfoundation.org,
        netdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: qlge: Replace strncpy with strscpy
Message-ID: <20231009172245.wholw3yhu46l6xiq@google.com>
References: <20231006161240.28048-1-ricardoapl.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006161240.28048-1-ricardoapl.dev@gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 05:12:24PM +0100, Ricardo Lopes wrote:
> Reported by checkpatch:
>
> WARNING: Prefer strscpy, strscpy_pad, or __nonstring over strncpy
>
> Signed-off-by: Ricardo Lopes <ricardoapl.dev@gmail.com>

Nice patch!

It looks good to me and helps towards [1].

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
> v2: Redo changelog text
>
>  drivers/staging/qlge/qlge_dbg.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/qlge/qlge_dbg.c b/drivers/staging/qlge/qlge_dbg.c
> index c7e865f51..5f08a8492 100644
> --- a/drivers/staging/qlge/qlge_dbg.c
> +++ b/drivers/staging/qlge/qlge_dbg.c
> @@ -696,7 +696,7 @@ static void qlge_build_coredump_seg_header(struct mpi_coredump_segment_header *s
>  	seg_hdr->cookie = MPI_COREDUMP_COOKIE;
>  	seg_hdr->seg_num = seg_number;
>  	seg_hdr->seg_size = seg_size;
> -	strncpy(seg_hdr->description, desc, (sizeof(seg_hdr->description)) - 1);
> +	strscpy(seg_hdr->description, desc, sizeof(seg_hdr->description));
>  }
>
>  /*
> @@ -737,7 +737,7 @@ int qlge_core_dump(struct qlge_adapter *qdev, struct qlge_mpi_coredump *mpi_core
>  		sizeof(struct mpi_coredump_global_header);
>  	mpi_coredump->mpi_global_header.image_size =
>  		sizeof(struct qlge_mpi_coredump);
> -	strncpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
> +	strscpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
>  		sizeof(mpi_coredump->mpi_global_header.id_string));
>
>  	/* Get generic NIC reg dump */
> @@ -1225,7 +1225,7 @@ static void qlge_gen_reg_dump(struct qlge_adapter *qdev,
>  		sizeof(struct mpi_coredump_global_header);
>  	mpi_coredump->mpi_global_header.image_size =
>  		sizeof(struct qlge_reg_dump);
> -	strncpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
> +	strscpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
>  		sizeof(mpi_coredump->mpi_global_header.id_string));
>
>  	/* segment 16 */
> --
> 2.41.0
>

[1]: https://github.com/KSPP/linux/issues/90
