Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC83D7DB8B0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 12:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjJ3LGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 07:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjJ3LGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 07:06:45 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50561B3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 04:06:43 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c6b30acacdso23482841fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 04:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698664001; x=1699268801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RPDLogMX2Okl0yWKKv3brKmDR3BK6A6t8hBL6zMzTPM=;
        b=ZqEKQOmnxUMMQIMHczCPqIFQYtD1i6rCDD9eI4pyX77D6LMP8ON9Cm2UDhHp81grRh
         FStLIjUklpSxd7dyrw5p8Xz+gfR6paxRNSaAJZOfuHY+91CIc6nvLl20KbW/abmSvG+0
         7IeNqhw79CEBQZCkXW0R0aBmsbetHVSpuCjxGKax2Cm+roIHCmdj5GuTHXEhXVEiikwl
         FnH8GDdq58fbkfogKaIRU598L3tqENVv1Y1ryoK6E+aQE1dXdz/3ZOTXN9Ri5985pu30
         C03EHTVRNPkGMa+P0yHSLi42/+oEAgMk+yYd92mpQrpOpKvWE0O2dpRYNCUr7Jhv9+7e
         VzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698664001; x=1699268801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPDLogMX2Okl0yWKKv3brKmDR3BK6A6t8hBL6zMzTPM=;
        b=JXBKOL5yxoNaBFF2SCI8oIT4lIn5PnLFEXYODs6LdNcOG7AxUv6sPVL8LESZA0gHfV
         HGWl2jZG75qtJpMoQFGE+47oiKIPRJM+m7XPjyox7KTLw83JlzvYzmOkc73ksP6DzA2B
         JakpGeMnxD/YvXWXMkgl801Fx3hazqxyBA67owvv8AgvUdOW1fzOjQucffKrbyD8cr7h
         LJ9u2PiCXrzr1Q39CzXR2mWP3nH8lgbewnzRxRTZHy4H8KJ3nUKV8YgA2EICFhrBvvZQ
         jLP7Usuu0XBt88rG5+2XubkLNdJw1YylhrGUT7Si4LLKOcy578nNg/AXgNXOGwsMa9dq
         k+0Q==
X-Gm-Message-State: AOJu0YyxnS30gpJHvRDaISRWqruLp5ZGCa916sX4Hi+dxKLE345yYLIZ
        iHyr/o3P927K+Z3iMrq57f5NJvolPcvKNWFonXI=
X-Google-Smtp-Source: AGHT+IEUF8qSE8BtR3dxKojdv94s9eYZmdvIVxNuat/ryX9vyqJd2oVzRTWo37qXTG/xd6BKZkoX4A==
X-Received: by 2002:a05:651c:2122:b0:2c5:a1b0:d95a with SMTP id a34-20020a05651c212200b002c5a1b0d95amr8130145ljq.14.1698664001170;
        Mon, 30 Oct 2023 04:06:41 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n35-20020a05600c3ba300b004068de50c64sm8934726wms.46.2023.10.30.04.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 04:06:40 -0700 (PDT)
Date:   Mon, 30 Oct 2023 14:06:38 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Tero Kristo <t-kristo@ti.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] firmware: ti_sci: Fix an off-by-one in
 ti_sci_debugfs_create()
Message-ID: <cd8ab7d2-d59b-4973-9180-0389b29fad0e@kadam.mountain>
References: <7158db0a4d7b19855ddd542ec61b666973aad8dc.1698660720.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7158db0a4d7b19855ddd542ec61b666973aad8dc.1698660720.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 11:12:26AM +0100, Christophe JAILLET wrote:
> The ending NULL is not taken into account by strncat(), so switch to
> snprintf() to correctly build 'debug_name'.
> 
> Using snprintf() also makes the code more readable.
> 
> Fixes: aa276781a64a ("firmware: Add basic support for TI System Control Interface (TI-SCI) protocol")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2:
>    - use snprintf() to simplify code   [Dan Carpenter]
> 

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

