Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D147BEB22
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378517AbjJIUAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378482AbjJIUAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:00:09 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A48EA4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 13:00:04 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6c646b5028dso3264064a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 13:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696881603; x=1697486403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XnnNZrfQHu6U702fU9qv9YujuMNy/CqVElyAPuDlNS8=;
        b=C774o6WSf/gt2YrkMRsHjeigz24wLn36GDvorNU0gUCxqUjrVcUsHb/F5XpmpaHRb9
         GI4v6CFdNJAWydxM1Gsft3erUrCeOjIn9yvdVpi8Cuvfd8MlGlVGiChGLhiq1yCUoicR
         pxLEmdRAdkdSZtOe55jC1HQc3RShNIEZNQI/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696881603; x=1697486403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnnNZrfQHu6U702fU9qv9YujuMNy/CqVElyAPuDlNS8=;
        b=a3FRSg9wR4OC2cFZ3jdsKIchjzi68kD7RGuGfLx1wlA6XfPysAxJLwWzLvIhH6NeYt
         bL9JVmYtnx5HwVj1yPzRqOvZgQyiMmpBevyYYaFoa+U+aHYcVtZVx4QtpGxcwJmEw+u2
         VeHi/ku5u8kjTUGiNZoqEYT8CrdNvcumAZXc6/NLWAfiPJoMa5q1DhDUM62SRiaTxCqv
         5ZBUzR+OUnSl6z/mNQ2ppI5kx2XKXmz/i79PEu7K8aRYC5gluqFNsMVclNcLrcrnANDj
         m6f1T7QvYCfIqbcdKlIxnz+H5jbQ/1Bqr8WRv8H66DV+rwZdbSiL9aGoBRCoNdbJdsGv
         al5Q==
X-Gm-Message-State: AOJu0YxqppeYNGAEc7x9CiAAg63CWHgyK0T7wV3uKoZqCavd65FoIM5v
        AM6Ti5NC8NbM05kSaGUSW06xFA==
X-Google-Smtp-Source: AGHT+IFr2diKV0FUnPCKvbVJgM9zVEQvrx9lAF5Q6PUGXjcm/39HFBRDZ6m3k4XI8U3B8QraX/ZFbw==
X-Received: by 2002:a05:6358:42a6:b0:143:321:f36b with SMTP id s38-20020a05635842a600b001430321f36bmr14035556rwc.18.1696881603565;
        Mon, 09 Oct 2023 13:00:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902d31500b001bdc8a5e96csm10053257plc.169.2023.10.09.13.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 13:00:03 -0700 (PDT)
Date:   Mon, 9 Oct 2023 12:59:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] mtd: rawnand: rockchip: Use struct_size()
Message-ID: <202310091259.1D9E73DAE@keescook>
References: <481721c2c7fe570b4027dbe231d523961c953d5a.1696146232.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <481721c2c7fe570b4027dbe231d523961c953d5a.1696146232.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 09:44:04AM +0200, Christophe JAILLET wrote:
> Use struct_size() instead of hand writing it.
> This is less verbose and more robust.
> 
> While at it, prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute. Flexible array members annotated with __counted_by
> can have their accesses bounds-checked at run-time checking via
> CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
> strcpy/memcpy-family functions).
> 
> Also remove a useless comment about the position of a flex-array in a
> structure.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

It seems the consensus is to keep the struct_size() changes together
with the __counted_by annotation, so yes, this looks correct to me:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
