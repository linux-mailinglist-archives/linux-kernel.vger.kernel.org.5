Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A430980AAAA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbjLHRXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbjLHRW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:22:57 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F7C199B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:23:02 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ce93552cb5so1606266b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 09:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702056182; x=1702660982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WNXDom1pGgFzD7z60+nX5wKE72JYAG4paS5sk2JCKg8=;
        b=GiY1k/0deCp31KIS/rscp6m71yTNYUEL+kB1zQ9qcDADBj76CBBvx96QLXr4UQf3Nf
         OYdJGf3XPP7YZoJg1Y2dC9/qVCN1IkX0g2Hy5/Ly98HxRGmVzHiV8Jv+CrND1k4IBlBo
         +AGAJa6nLkIv8JFMTzIl0elnYLMdooCku0EdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702056182; x=1702660982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNXDom1pGgFzD7z60+nX5wKE72JYAG4paS5sk2JCKg8=;
        b=BTZAaTUrk6GcbguC4sQPBmTF/8ytyMLOl3lnRc+SugFyU/7NOfBOs7b6si4Vwn18sW
         O6M2u8RUNj6Sh8geJxuLKcpo2UxpYRvaJTdJIvKYEw8MyU0c3Pf9OZB3967Z/61eUz1n
         MQIZ6HgCAj42vQKGME2wjWEKDwRyk7MGcTyvbbuyMgbic6l9DI6FTvbyCj8Snf42NKqw
         WJ+puop4NJLhkpuZap36s3TG42Eo3JJBOzwWtYILktq2lZkAgOkxP9X7BistYxYBJKF0
         tWCZWKorSurw/JHZU4Xn9lrDwRRcyhgwszhalz7Ub/gCNrEHH42OVy9QTieQlbVtdZjS
         gdGA==
X-Gm-Message-State: AOJu0Ywq19TwDVIkPO3n1aXh8DwaM5lYJ2E37n5ad2dB9bRanWtzkkbA
        ieq7z6dQY45EQtNAur9EEowjOg==
X-Google-Smtp-Source: AGHT+IF0odaLvAeilH7K2WI0rkMDi0C9smclmU3oIrDkxldyXyKpbjGkUJWAwcvrZUO929m23SwWqw==
X-Received: by 2002:a05:6a00:1a8f:b0:6ce:50b4:a21 with SMTP id e15-20020a056a001a8f00b006ce50b40a21mr321026pfv.27.1702056181771;
        Fri, 08 Dec 2023 09:23:01 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u3-20020a056a00098300b006ce7fb8f59csm1837731pfg.32.2023.12.08.09.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:23:00 -0800 (PST)
Date:   Fri, 8 Dec 2023 09:22:55 -0800
From:   Kees Cook <keescook@chromium.org>
To:     justinstitt@google.com
Cc:     Shay Agroskin <shayagr@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        David Arinzon <darinzon@amazon.com>,
        Noam Dagan <ndagan@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] net: ena: replace deprecated strncpy with strscpy
Message-ID: <202312080922.881A1515F3@keescook>
References: <20231207-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v2-1-a1f2893d1b70@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v2-1-a1f2893d1b70@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 09:34:42PM +0000, justinstitt@google.com wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> host_info allocation is done in ena_com_allocate_host_info() via
> dma_alloc_coherent() and is not zero initialized by alloc_etherdev_mq().
> 
> However zero initialization of the destination doesn't matter in this case,
> because strscpy() guarantees a NULL termination.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yeah, this reads much better.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
