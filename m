Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11EE7BEEF6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 01:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379122AbjJIXLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 19:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379018AbjJIXLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 19:11:50 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DB419D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 16:08:57 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c5c91bece9so36563145ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 16:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696892937; x=1697497737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xZEAbTE1jnX14hR8pCQlTibWlz5S6mt8A6dPfKwpsV8=;
        b=HQo1KMnFcNeDA8euGVYYMlvfqf5rjj/fmlwOEekOJc6WM9oRn2Aq6E9sKJWaAa8zrW
         XT1S3fhQQ8GLutCvzjCg6RDeFju2TS8OTg1zEGZWeN3O2jbFxvdpU7KmeVHaB2mcD4WN
         UCHuNDY0xtNAHbk9LKFL05VaHZ5auMzr89n3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696892937; x=1697497737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZEAbTE1jnX14hR8pCQlTibWlz5S6mt8A6dPfKwpsV8=;
        b=kEr5vPLVDaYBGmHOEvNhvZsRbUCvk8BZSEvg+K02IT3OFM2zyJQ9ojMCvmAA00IFj7
         g7SYEJUXtkpKJEcAjvlX0yoTFP3zYzyeQn42SSQijTtyHsAv8D3M3GjhS+BHK7wl5YPx
         j6mfH9UvHNwYQbzeqUJJB1ACtbWBzmllQoO8Gqn4fZunU0tGL+NgGLAP5UEAhY6oBibI
         NZyAN/AlCfAIW4YJ7Kq5mvkIvmz//StyYnyPA6MKc6Dw/bRP+Vr7hl/sDC9Nr//64QBP
         0MC2p4mgQuPyozHA8zXxvJ60yKwgE0qs0EjwOD6VFK07utAMgCUMcmn/Is0o81Q+I5uv
         RTWg==
X-Gm-Message-State: AOJu0YyKed9d32ImwoRHPynIQ/nvQ1pqWq5D5wmZ1vBMeiS/5Yo5Zw5Q
        rizU5brcAUILjYuKow2MXQeTz6PeH8P2NR9xkQo=
X-Google-Smtp-Source: AGHT+IE4bNEi4bN0RSOpbI1oO6kddrnbOzEwTunUzAyAEf4FA+FbGaK82D5lHzRVV9vr+ORb3iYMug==
X-Received: by 2002:a17:902:ec84:b0:1c5:d063:b72a with SMTP id x4-20020a170902ec8400b001c5d063b72amr16810663plg.27.1696892936571;
        Mon, 09 Oct 2023 16:08:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bh2-20020a170902a98200b001c43307f87asm10162365plb.91.2023.10.09.16.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 16:08:56 -0700 (PDT)
Date:   Mon, 9 Oct 2023 16:08:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] staging: greybus: Add __counted_by for struct
 apr_rx_buf and use struct_size()
Message-ID: <202310091608.C892CFA@keescook>
References: <ZSR2O6zGyT/VX6ve@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSR2O6zGyT/VX6ve@work>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 03:52:59PM -0600, Gustavo A. R. Silva wrote:
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

Looks right, "len" is updated before accessing "data[]".

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
