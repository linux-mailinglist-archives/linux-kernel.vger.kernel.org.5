Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9547B9FA8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjJEO0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbjJEOYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:24:19 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03A120E5C;
        Thu,  5 Oct 2023 03:29:07 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c3c8adb27so144559066b.1;
        Thu, 05 Oct 2023 03:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696501744; x=1697106544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jj5jafkJ0zIFP34snoPmFPYTg/PYDWh3uWvMOXmNhu8=;
        b=KuA5gHnjgLh2WZyL+/uJF8GoN8lGooBYfdTywPTE1XQytWbqWxIWW/yGUvXymJFr5a
         d6Fo7FueCYHEywo7K3xl0Mrt0kduPMMDJNrq9CbbJV0p7cinULZPlt2uwRmyvG0x435l
         J6pQWrdKtnzqsnSNpahdjjD432MEX6a5V/lv5fmcFw6AJL/BzDcKPz0KmU+C6VK6W4zm
         hEksRKG/JRgVxd2K1ZhMsEHJtYiW4cs9Vd5tM9g5PCXFE+e8Tv0diWQzPLDB+FhNvevv
         87qv384rIhKr7pz9GQSdpTZPMObGbmVovXgVtnOSAQEnnyRYt+62WvwfkCxJf8f92Vxk
         xKnw==
X-Gm-Message-State: AOJu0YwFQTb/jEyBJIjUH/8hGviATDhetUDhXkBK0Dkq+HVVxwNL/tN8
        ykecOEv/nxVqHB8bgsItEnA=
X-Google-Smtp-Source: AGHT+IHydoezWpZnKJkj/HxjmRp/jJVxzTNzko/BbjcgxBRaXK5KRLbXhnAIexulQV8Y7S8zD1ac/g==
X-Received: by 2002:a17:907:7603:b0:9b2:b633:ada2 with SMTP id jx3-20020a170907760300b009b2b633ada2mr4423288ejc.36.1696501744259;
        Thu, 05 Oct 2023 03:29:04 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-006.fbsv.net. [2a03:2880:31ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id a11-20020a17090640cb00b00977eec7b7e8sm963021ejk.68.2023.10.05.03.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 03:29:03 -0700 (PDT)
Date:   Thu, 5 Oct 2023 03:29:02 -0700
From:   Breno Leitao <leitao@debian.org>
To:     kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        Eric Dumazet <edumazet@google.com>,
        Jonathan Corbet <corbet@lwn.net>, hch@lst.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 3/3] Documentation: netconsole: add support for cmdline
 targets
Message-ID: <ZR6P7isP8eEy9vdF@gmail.com>
References: <20231002155349.2032826-1-leitao@debian.org>
 <20231002155349.2032826-4-leitao@debian.org>
 <ZR3GbHOyxx+J4FUn@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR3GbHOyxx+J4FUn@google.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 01:09:16PM -0700, Joel Becker wrote:
> On Mon, Oct 02, 2023 at 08:53:49AM -0700, Breno Leitao wrote:
> > @@ -155,6 +152,24 @@ You can also update the local interface dynamically. This is especially
> >  useful if you want to use interfaces that have newly come up (and may not
> >  have existed when netconsole was loaded / initialized).
> >  
> > +You can control and modify the targets defined at boot time (or module load
> > +time) by creating special targets names. These special targets are named
> > +`cmdline` concatenated to an integer, example: `cmdline0`.
> 
> The special names are already "created", so perhaps it's a little
> clearer to say something like:
> 
> ```
> +Netconsole targets defined at boot time (or module load time) with the
> +`netconsole=` param are assigned the name `cmdline<index>`.  For
> +example, the first target in the parameter is named `cmdline0`.  You
> +can control and modify these targets by creating configfs directories
> +with the matching name.
> ```

That is way better. Thanks for the review.
I will send an updated version soon.
