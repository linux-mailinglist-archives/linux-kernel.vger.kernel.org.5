Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB4F7BB1A1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 08:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjJFGmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 02:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjJFGms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 02:42:48 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C9AE8
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 23:42:46 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50337b43ee6so2319552e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 23:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696574565; x=1697179365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W48qcl+qVVYwRgZC9dzFeOYmfNEtgKzD22rI+wL+TnY=;
        b=W3776beY1WhbnwkPTXU43k1YN3bvA4HlOBqBgtXAJzQprzX/UGxajTumHDGQWNKiKm
         /1t0l/pO3krDhIBHQ3XxXDVbArB99i2ZUh3oZY4SPbIb8YXPAszCWNYcHvHou3oE3HSB
         QSohK1xz+5hgMrNeV9sWOQy4R2JEhL6cXNk/MDq3ta2/xSwcLVQLdSCgt5Lwonn/VKv+
         TqccQKyo2IfiWDGqqjrC6vfv1TR9o27kSf/Tr+j/wOI8z1YC5f4AV07jnTEN14AZBlDV
         V/t1IVApB6pmJRcgwoWp7Erq46w0NLVOKO/gHgc7qkcazCMOqgMtIfwAQmTxjEmFuuWs
         c/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696574565; x=1697179365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W48qcl+qVVYwRgZC9dzFeOYmfNEtgKzD22rI+wL+TnY=;
        b=wFPF2QZe72KM+nGBmPD3Pyi6bd/ajtXhoybQfniqHqDAlajGEBdRYpPJED6AA1EMFW
         5fmUya4gq0/DZimnEYfmLJm3M3l+o54l+6TDRTUkdMrFtA67VtL+gGwJl3P2Y3CxAKNc
         UOlKDIs/RmP5qjs1eJmyknpoluKPYJrpw8puahxpV5Lq8T4PYCb7QFFVMC+AjBC16WrJ
         1cbPaWu3cC7tTj8p6R5kSZtoUbukK5JsYnmzf+Og183hgGdd704JlJ+yVlVuDU/q6MYB
         BtbS22MiVEfVOEgSXAR/njmpcyoBXdCknmXe2PAMxSaz1oD7mpvQDDMIB5ZSNYTJyAY6
         hteQ==
X-Gm-Message-State: AOJu0Yz/au8ohe8n5SziLkd7fMjEF7SIZOkFJwzXeE4nLR5+BME5+5g0
        zEPmI7EYecm4cfiNK4SYGbFRehfGgo8wPfOagn8=
X-Google-Smtp-Source: AGHT+IFIWdwm8yYcilcNJBfYGLjSxm5s+ZR2i1auLhHaCiDm+4VaFO3iNGZddB32L6PiCOJ5HAbcYw==
X-Received: by 2002:ac2:5f5b:0:b0:4fd:cae7:2393 with SMTP id 27-20020ac25f5b000000b004fdcae72393mr5162245lfz.2.1696574564680;
        Thu, 05 Oct 2023 23:42:44 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f17-20020a1c6a11000000b004063ea92492sm3019275wmc.22.2023.10.05.23.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 23:42:44 -0700 (PDT)
Date:   Fri, 6 Oct 2023 09:42:41 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Ricardo Lopes <ricardoapl.dev@gmail.com>
Cc:     manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
        coiby.xu@gmail.com, gregkh@linuxfoundation.org,
        netdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: qlge: Replace strncpy with strscpy
Message-ID: <0b78b29f-2a84-487c-a43b-f8d3fa20d935@kadam.mountain>
References: <20231005191459.10698-1-ricardoapl.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005191459.10698-1-ricardoapl.dev@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 08:14:55PM +0100, Ricardo Lopes wrote:
> Avoid read overflows and other misbehavior due to missing termination.
> 

There aren't any read overflows in the current code.

> Reported by checkpatch:
> 
> WARNING: Prefer strscpy, strscpy_pad, or __nonstring over strncpy

But making checkpatch happy is good and the patch is fine.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

