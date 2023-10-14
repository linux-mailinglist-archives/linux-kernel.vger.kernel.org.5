Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4E07C93B9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 11:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjJNJXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 05:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjJNJXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 05:23:02 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E2CAD
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 02:23:00 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ba1eb73c27so468580966b.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 02:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697275379; x=1697880179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1OiLKGl/521du+G5SUflqLbUSPuMIQ1XfH6bxubrILA=;
        b=MaNXedSkWIYZWAU2KEdeZzx+PNg2qWLRuBR31Xt4mlAi6U5llanjzLffaaRkWjwubo
         pah2B6rdwolY1pdp8hEvG8bpULr8xYtc8w1rEFsVrhKqiqFZYUGZiIchCWwK5CcDnoNN
         LJUoaQ3mNetbWtQPBk8a1Zeqa0B7lmniTaMGpDa8rOE9tL9l9eN6hNqdjMd3oTQ8QMT1
         tFVzNbwunqgNeoJwcDsIgUq8/VyIQ2ztZ1KBK6nwlyZkKnzKyZahz34AroTdaLBYOD+7
         BiUig+nfpCv/aQ8evzFeGyGqSp2Ps/kYGYKAhyYVaqNKa1t3/VkSVtlVAzlXjKuB6fcX
         Nd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697275379; x=1697880179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OiLKGl/521du+G5SUflqLbUSPuMIQ1XfH6bxubrILA=;
        b=N54F0gRmLaQ3DkirXizrrsEyaSdLiwJfNtK0avrYh8Z3wkusacWDfa1Mbeo7oE9Lrt
         a3Bo1LdHM7/MV/m7nt1WFCKs1eCPxQOVCGnf3MoP4ZM+HjywpYf0yBQs0y1KLym9zSp0
         C3vzqaPA7ki61gHRay5STLd3b1vcoL4H83wimOY3PZzmsdeooBetZaweJHZy7OKc1q6P
         +B7S46qERCo2SPP6yIx5o7DLuvh7p4PqnI4wGog9HWgrEBiuvLV7ZbOtfaUUoiewWWAr
         yTMevtkdfaRtaFI3ZxlFoMidY/vH6jQ8Fqbt+a68zm1aLqpm7dSpG1QRixwdk2CQzJyR
         ll/g==
X-Gm-Message-State: AOJu0Yxg45rYhHJO0gYK5Kv1sw33Gksl1mkl/wlbkf+a7bmOWHH3k2sw
        ioHWXCJvgr+3dNtwuX3FEg==
X-Google-Smtp-Source: AGHT+IGh6VL6ES5dYuYNXUyM8F38XB5kTyC4ReuDxwmKeQ3aeaUlO4KD7e3F0sZ1ezvKO4L4ODGVeg==
X-Received: by 2002:a17:906:3288:b0:9a1:fb4c:3b6c with SMTP id 8-20020a170906328800b009a1fb4c3b6cmr25664790ejw.59.1697275378686;
        Sat, 14 Oct 2023 02:22:58 -0700 (PDT)
Received: from p183 ([46.53.253.206])
        by smtp.gmail.com with ESMTPSA id gw11-20020a170906f14b00b0098669cc16b2sm678248ejb.83.2023.10.14.02.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 02:22:57 -0700 (PDT)
Date:   Sat, 14 Oct 2023 12:22:56 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: move and constify sysctl_nr_open_min,
 sysctl_nr_open_max
Message-ID: <261b7728-a9f3-4ceb-8325-b8ad1fae993c@p183>
References: <02591c1e-936b-46bf-ad2b-402b33338eee@p183>
 <9b23bb6bcabe4f419cb8510e99275085@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b23bb6bcabe4f419cb8510e99275085@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 01:54:06PM +0000, David Laight wrote:
> From: Alexey Dobriyan
> > Sent: 11 October 2023 19:24

> > +/* our min() is unusable in constant expressions ;-/ */
> > +#define __const_min(x, y) ((x) < (y) ? (x) : (y))
> > +static const unsigned int sysctl_nr_open_max =
> > +	__const_min(INT_MAX, ~(size_t)0/sizeof(void *)) & -BITS_PER_LONG;
> 
> I think you'll find that min() is fine.

Mainline min() still can't do

	static const x = min(1, 2);
