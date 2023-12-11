Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848E680DCAE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345028AbjLKVHV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Dec 2023 16:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344987AbjLKVHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:07:19 -0500
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70B8B6;
        Mon, 11 Dec 2023 13:07:25 -0800 (PST)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-58dd5193db4so243395eaf.1;
        Mon, 11 Dec 2023 13:07:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702328845; x=1702933645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xW33nsSzaKWmTS5hJ7+2G+WMi/6TL0zdzBwWK9z2AF4=;
        b=kKZDLkz/c3jklcYi6+cIyqX571aVA2Z15vHGkIpLmFHh5lyA82MRixuOh2/8toXLEp
         mm3xiX4XY7dRYwJF0BSvNIE57/pOtCayes41bCgunjkMLI2m+Kv47HX6RES5yWnjfkqD
         7nbdZlKno0wjBD5TYOjvxpiD5e9NhsfyFZYBFq3+GXq48b2dISEKWbK1oqqimFhU98eP
         YcayGnB82QyEImoaLI3kjvJ6VGReQ3AcuYXgh4/RZ+gZEyJ8dNaLXGGXuby8awOC0g/Z
         gkZgeCWg0Q/Tdu9e0uoioQL7sNRHACIgQ1e9UC36zD6fN9G5+tIW6t5McQgt4OIvumE5
         NavA==
X-Gm-Message-State: AOJu0YzgTL3evG0OgaxtDTDdnpURpWHypaVV3Y8UnhppIDgRIInN1n6g
        6+9hjoNS4tEFGLnRm7uClvcM2KXqWlrSaiD8yM0=
X-Google-Smtp-Source: AGHT+IH5IPHwpyQIxBv0/wnKtCUDBbmeizAXwkzWBQ85O355IPda9Lwz2GfjkcMlIfbfUsn1nJyeF8GLBeR/pBpUXd4=
X-Received: by 2002:a05:6820:2a18:b0:590:9027:7ab0 with SMTP id
 dr24-20020a0568202a1800b0059090277ab0mr7616252oob.0.1702328844928; Mon, 11
 Dec 2023 13:07:24 -0800 (PST)
MIME-Version: 1.0
References: <20231027015533.25391-1-zeming@nfschina.com>
In-Reply-To: <20231027015533.25391-1-zeming@nfschina.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Dec 2023 22:07:14 +0100
Message-ID: <CAJZ5v0iUuYvfBHxrJzQsix=PS3NBCckokfsVizNy3miKM7yxYQ@mail.gmail.com>
Subject: Re: [PATCH] power: swap: Assign a value when removing the 'error' definition
To:     Li zeming <zeming@nfschina.com>
Cc:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 3:56 AM Li zeming <zeming@nfschina.com> wrote:
>
> 'error' first receives the function result before it is used, and it
> does not need to be assigned a value during definition.
>
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  kernel/power/swap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 74edbce2320ba..90bb583c57bf7 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -450,7 +450,7 @@ static int get_swap_writer(struct swap_map_handle *handle)
>  static int swap_write_page(struct swap_map_handle *handle, void *buf,
>                 struct hib_bio_batch *hb)
>  {
> -       int error = 0;
> +       int error;
>         sector_t offset;
>
>         if (!handle->cur)
> --

Applied as 6.8 material under a rewritten subject.

Thanks!
