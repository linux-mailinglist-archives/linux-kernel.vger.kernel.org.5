Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDB575CE1E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjGUQSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjGUQR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:17:57 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F8D4C09
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:16:53 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7866189cff1so92737539f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689956208; x=1690561008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RkGS0Aio2ruXQJzFNMuw71y4Q4sy6vm123ijO5QNmbQ=;
        b=C33YvWHyG8SAvKmoWo8GzkqXeJSwpkpeyWOJKIGf43PG1lLHa91EXKWJIQlow4MIU2
         /C+IKGzvkRfCQGURBhF/dhbHZg+/gRzLtNOvNf/oNrIEjPDCfk5q2EvhjkHzR9eex3qa
         opN2d+b7syed0gNIOKQRTC4xinE425LlTHUDqY54McGj7U3LjfsQjhVdu9RRygRx7SMI
         gPqGPKJv6fzMytGqRsj5/lB934739KM8HUf6gf/BounQ87L9vMayqvoEGwsyyfbkGj/S
         ij1CYjMMFIpDFKh4sYrIdV3RJKeEai/KWeaX86Jdnqv4auRNeT8p/KNXyGrOt0ZBdANz
         FCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689956208; x=1690561008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkGS0Aio2ruXQJzFNMuw71y4Q4sy6vm123ijO5QNmbQ=;
        b=YyvAIdaF0fPGxy+BmhR7asSJEb26t7IVZkfiEckcdal/HKdQ8y6Fq2f4RFYpNtkkWj
         qeSFayIuiLzd963WmAAFF65jqNsiz4VbvWYEjbT8fycNaB/wZzcj0QwN+QuC3G3/6/JG
         UWpM98knPEhZhKdRVkYjfXUxDHIV85+plSjsIW0DbBg53245n8r4EJMdqY47p+TpnB+j
         +tJA4FBbxel6VvZtn1mgOht9D4aKWzxkCeNPeeAlrSnM9I+0mbSXX/LEc47IbNCM0gxi
         RZZdIRGDSZCC0wDFmKXA0ejkQgFSW2uR6bg9BJEWDYU73GF3sya9If9lPy2Ya0S9BN0t
         EiOQ==
X-Gm-Message-State: ABy/qLaUlCCwfVLGtQ+emArd007HARxhxhPLT2KOmKNkyx3pW2wMmp6T
        cjv647NOZbxRfGtOp3jXViU=
X-Google-Smtp-Source: APBJJlEGBZEHrqyHJs8rsnrFMZjKXrMKYJ0uB+NZVasno9sqLRIVqTiKQsRYqZ1qCE3lDegYoij5KQ==
X-Received: by 2002:a05:6602:38a:b0:787:1990:d2e2 with SMTP id f10-20020a056602038a00b007871990d2e2mr507146iov.10.1689956207948;
        Fri, 21 Jul 2023 09:16:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v10-20020a02cbaa000000b0042036f06b24sm1111818jap.163.2023.07.21.09.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 09:16:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 21 Jul 2023 09:16:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [RFC PATCH 2/2] regmap: Reject fast_io regmap configurations
 with RBTREE and MAPLE caches
Message-ID: <7e50d739-fffe-48e7-9da1-baa761419820@roeck-us.net>
References: <20230720032848.1306349-1-linux@roeck-us.net>
 <20230720032848.1306349-2-linux@roeck-us.net>
 <CGME20230721145342eucas1p12e658a54d36d985b2811e2c21f7810ee@eucas1p1.samsung.com>
 <c2bba4df-da1f-5666-89aa-28c6700575ca@samsung.com>
 <fe31bb86-40ec-4b77-9edd-eeaa61bb5e08@sirena.org.uk>
 <c9614ffb-7840-6a84-883d-ed4371d75c11@roeck-us.net>
 <205a83df-c67b-457f-a9bf-a9c6def4bb3e@sirena.org.uk>
 <1c90db79-4a1a-d3cb-5250-f30cf6b5a90c@roeck-us.net>
 <52f21f66-96e3-4ff9-b1bf-625bdc535b42@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52f21f66-96e3-4ff9-b1bf-625bdc535b42@sirena.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 05:14:42PM +0100, Mark Brown wrote:
> On Fri, Jul 21, 2023 at 09:01:03AM -0700, Guenter Roeck wrote:
> > On 7/21/23 08:13, Mark Brown wrote:
> 
> > > Yeah.  You *can* use the dynamically allocating caches safely if you
> > > ensure that no new cache nodes are allocated during I/O.  I'd not
> > > realised people were actually doing this.
> 
> > Ok.
> 
> > Dan, let me know if you don't have time to send a proper patch.
> > I have one based on your suggestion prepared that I could send out
> > if needed.
> 
> Dan sent the patch already, assuming my CI doesn't blow up unexpectedly
> it should be applied tonight.

Excellent.

Thanks,
Guenter
