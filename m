Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79E07BEC61
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378628AbjJIVKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378215AbjJIVKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:10:08 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3159B6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:10:05 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6969b391791so3360466b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 14:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696885805; x=1697490605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJOpUmBqlji2QAqs4FK3KdbooedgBE7y6YtkmC6dsyM=;
        b=Lcw70bfwSz8qgRt+ziIoUl3bz8NTrXSMKBGgir7RP0FEgbqT+vit4XputDdT9wI0yp
         cTeW/KBfzJeiZpiev6B+9/gozlWeU7XQeWr+sxRjYpZCZVeHHfjaoc9YJhO+O/eBllQV
         C5mvS47ihleTwu3X5z8hDNmrJnbAd+EoPMbTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696885805; x=1697490605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJOpUmBqlji2QAqs4FK3KdbooedgBE7y6YtkmC6dsyM=;
        b=v6L279xITnDrwmYk4tTUwK/U5224Q0wg0q12Gq8N51a6bIHcVcUg9/OKS3qn7YWa4H
         easYwd0s+d+nrdtS+7sRsGHtwK4VLARpWAf6oxvYBR7a65NNgveVrwhiylgpjAosQ8Dk
         wbTD/k6v9RP+BtkjamgZynddsolpg5z28h2gObq0sgL0kYiD/OANSKXkl2fWpBQz5I4B
         yVLGNmkSB06A2nn+OHGEs+QALQfmZbhjWvVgCqDlYcjsgmoGP6kyopsHLa0NQTayu6+5
         gODetLQZgW3CpV6dVAP73vml/Fiiz6QN9xTaYN8zBIX/yjBLqS3+32/JZ/4XS15rkL7n
         41zQ==
X-Gm-Message-State: AOJu0YzQ9tqtUxil03S0gswRYtDTIhz5g60PWDG1oGWWINPbIPF7M/H9
        VlWBsWw2SXQ85f9ytKiS9SNZbQ==
X-Google-Smtp-Source: AGHT+IFnTN0angGPv5fbuTlnpVzKaxjDgULBfyhCs/8OevVZtUFVnV/Kq3iMj6Ta3SNEAJ/cPTs+og==
X-Received: by 2002:a05:6a20:4423:b0:15e:71c9:7d47 with SMTP id ce35-20020a056a20442300b0015e71c97d47mr19179231pzb.26.1696885805208;
        Mon, 09 Oct 2023 14:10:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fm3-20020a056a002f8300b0068bbd43a6e2sm7060782pfb.10.2023.10.09.14.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 14:10:04 -0700 (PDT)
Date:   Mon, 9 Oct 2023 14:10:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] btrfs: Add __counted_by for struct
 btrfs_delayed_item and use struct_size()
Message-ID: <202310091409.6F3B10C@keescook>
References: <ZSRmRj7leOsdUmJm@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSRmRj7leOsdUmJm@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 02:44:54PM -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure, including of course, the flexible-array member.
> 
> This code was found with the help of Coccinelle, and audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks right to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
