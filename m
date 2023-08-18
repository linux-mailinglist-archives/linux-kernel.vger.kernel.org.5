Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3894D781222
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379139AbjHRRiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379132AbjHRRhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:37:40 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DFF3C23
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 10:37:38 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-564b8e60ce9so896430a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692380258; x=1692985058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3LKfiXOUv4Y78GYwccbn9eLRl2BI7RjZ4/fZETpGexM=;
        b=AwtNaCfH+hxlFLkfnuSI87gwp+VrGSgjnV1+zyCVrSwmJJC4EGOeaIRRhY9RTx6MYP
         FgApMLQbcYGXFIUxmq7WRH1DlieMuCOArB0NAHYwn8eFVczWDLMlggXkB/l7FmumT4gH
         p8dBl4LTXYAJn2srL2qSVGJh9kAj2+MdjgNnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692380258; x=1692985058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LKfiXOUv4Y78GYwccbn9eLRl2BI7RjZ4/fZETpGexM=;
        b=AUh3hmAwO3mZVo3bcBQ/FfJy94CdKtdgFs4qdD53IIEqLnOTlRMQRU64mkLImBpMoN
         IpwqYZz6PY9hFB5dan71mcD/OsxI9tp310kYMhHI4eAn3jOnBP+Dw4DNDZkoamNDs+GN
         P3L5saaG/qEaq/YdyrriOZHbIx13msWKa64O9bZ+Gb6OlGdP9MEntMIqY8kg0G58UlvD
         v4nJFyza9NQcraxYiOEvF+u8AELGPPhwG6OLefBbwjcJRu6jMrmOSc6paqbzxk6l5qOl
         LeHC88XNvL7O0/U0l5k5UoBAST3O/wIkuORyNvl4d45C2taQihfNCce2ljm6Du5ac+LE
         GDRg==
X-Gm-Message-State: AOJu0YxTiwGyDeUOXygEOWWURZgtsfDH92CQrDve1nFfBjl4yPDC1a6J
        1RFMYQ4eAzNGYcJFlwHh1UZpRw==
X-Google-Smtp-Source: AGHT+IGJ++HaMEe6fHz/+u8LhwdAhyc4KdGymaYjDc60SFpqfaa9p36TY5f9p3+CAiEcdKVw+eWCoA==
X-Received: by 2002:a17:90b:438d:b0:26d:4346:6eb2 with SMTP id in13-20020a17090b438d00b0026d43466eb2mr2675522pjb.46.1692380258263;
        Fri, 18 Aug 2023 10:37:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ci13-20020a17090afc8d00b002684b837d88sm1828910pjb.14.2023.08.18.10.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 10:37:37 -0700 (PDT)
Date:   Fri, 18 Aug 2023 10:37:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Fiona Ebner <f.ebner@proxmox.com>, linux-kernel@vger.kernel.org,
        siva.kallam@broadcom.com, prashant@broadcom.com,
        mchan@broadcom.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        jdelvare@suse.com, Guenter Roeck <linux@roeck-us.net>,
        netdev@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: "Use slab_build_skb() instead" deprecation warning triggered by
 tg3
Message-ID: <202308181036.8F79E77@keescook>
References: <1bd4cb9c-4eb8-3bdb-3e05-8689817242d1@proxmox.com>
 <ZN9SId_KNgI3dfVI@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN9SId_KNgI3dfVI@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 06:12:33PM +0700, Bagas Sanjaya wrote:
> On Fri, Aug 18, 2023 at 10:05:11AM +0200, Fiona Ebner wrote:
> > Hi,
> > we've got a user report about the WARN_ONCE introduced by ce098da1497c
> > ("skbuff: Introduce slab_build_skb()") [0]. The stack trace indicates
> > that the call comes from the tg3 module. While this is still kernel 6.2
> > and I can't verify that the issue is still there with newer kernels, I
> > don't see related changes in drivers/net/ethernet/broadcom/tg3.* after
> > ce098da1497c, so I thought I should let you know.
> > 
> 
> Thanks for the regression report. I'm adding it to regzbot:
> 
> #regzbot ^introduced: ce098da1497c6d
> #regzbot link: https://forum.proxmox.com/threads/132338/
> 
> PS: The proxmox forum link (except full dmesg log pasted there) is in
> German, so someone fluent in the language can be helpful here.

Since this doesn't cause a behavioral regression, should it be tracked
by regzbot? The WARN is serving as a reminder to the maintainer to
adjust the allocation method.

-- 
Kees Cook
