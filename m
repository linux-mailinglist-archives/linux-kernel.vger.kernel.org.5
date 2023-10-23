Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4273D7D3979
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjJWOin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbjJWOil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:38:41 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F789C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:38:39 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4083dbc43cfso24788915e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698071918; x=1698676718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNn1aaJeu1yyg5wO46KFtgTpMoh9VTl9ulxPnt4sQ9c=;
        b=moNkBUJ85A6jdin9FqcwrNsX2D2QzQ+Jr8+vtQ/2FkQ1FZp6eUUKzEobQ4HTcVlcZg
         ozfD9evv/zhXrYbD4M0OhjJ8ZOnPJl8FQGBmu1iCENzhEusd95QQEA5Tmk3DPs8kKzOh
         4BmDA8zN46BTob2mCmqC7LNaFBrADAisph2Zl0BTeO+wb37azvYPuz1ArXCejaFOELXu
         Rn7XJWDZV3CKcfF2sey2x9JqOIiaK+uJn5O0lP7WKgy4XCbl4INoSDNKPdXZg4k1ToCE
         0pKIJc+VKUNnqu+k5Pszr/mgf5rRSVfNaHG/A/a1oXC/dxepJiY7JRE9GNWb4qJmCzwJ
         2jAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698071918; x=1698676718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNn1aaJeu1yyg5wO46KFtgTpMoh9VTl9ulxPnt4sQ9c=;
        b=gb+QXBW/0ND4KwSjqPZu33V50hwqeW/VQYZpZRc5W09/Gl6AjvOsDi923KKllhG3/0
         xUC4zje3WyBrSy8vUxbjVVFmAwMxG/x6A8qi42124g1sEBj4Jd/f6IWJ0J17iuqf9YtS
         AwdhAFKDTLce+8oadWp0n/0p0T92hLoNaLJ54XAH/tLzEOoIDSuoEr9ZMSOKA4HuyaoS
         PcSYx4x3AwQiWmlI7GEcFEzUcbtNbTF8dqrNn8uselMd+aYTlqLJXhHLCcPXEfLQVwdB
         bhmXctcEjN5pal677mb2VM0VO/eAMdE4KPE7N/gJm2+EsBunSTKqb0oiFGPOFUxIHwzS
         QAQg==
X-Gm-Message-State: AOJu0Yym9QW+b9iTWHP5+uXGqVK4MeLOV5+3X16Gd+jYcYeG/iXZHx7a
        F+BJ0pYHPPWgBbyGg5AfRAuL4w==
X-Google-Smtp-Source: AGHT+IHgNA5GjnmfwcE23ZTiMz6DgKpkB0flr2r5pzEKcf+VOXnYdbZdl7B4dn0ZsPakyM77WN9j2A==
X-Received: by 2002:a05:600c:1c9a:b0:408:492a:8f3 with SMTP id k26-20020a05600c1c9a00b00408492a08f3mr7321814wms.5.1698071918367;
        Mon, 23 Oct 2023 07:38:38 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600c2e4c00b0040648217f4fsm14272293wmf.39.2023.10.23.07.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:38:38 -0700 (PDT)
Date:   Mon, 23 Oct 2023 17:38:34 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Jonathan Bergh <bergh.jonathan@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: octeon: Fix warnings due to introduction of
 new typedefs
Message-ID: <2c27380b-03c2-40e2-928a-21f28376b8bc@kadam.mountain>
References: <20231021000340.56889-1-bergh.jonathan@gmail.com>
 <20231021000340.56889-2-bergh.jonathan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021000340.56889-2-bergh.jonathan@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 02:03:39AM +0200, Jonathan Bergh wrote:
> Removed typedefs for various structs and enums and then make the
> requisite changes in the inline functions defined later in the same
> file.
> 
> Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
> ---
>  drivers/staging/octeon/octeon-stubs.h | 48 +++++++++++++--------------

These octeon stubs are just so that it can be compile tested on x86.

The real code is in arch/ somewhere.  It's Cavium stuff.  If you change
this without changing the arch/ code you're going to break the actual
user.

regards,
dan carpenter

