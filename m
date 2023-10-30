Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AE17DB8AA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 12:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjJ3LCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 07:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjJ3LCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 07:02:41 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F99CA2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 04:02:39 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32df66c691dso2726633f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 04:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698663757; x=1699268557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U1lhozIxyHBL/jN8zh4HAqe7ydkGHNrsZdasWYJCoeU=;
        b=W+BsgdVCzLJpggy305uNJ15t7N9UoM309TKjRSFgMrE111Oe09PI/ILUaGQ0CEqN9d
         ZvWQKghzRgD6cv5bqTFDDX3Wi41nXcXF6mrtjr+VM5u0NLBz6SDhSP2MCNFT/yao5NK/
         JSQPERJBsIceWo5m0YyoNCriv6luHV8/pEpxRjQU9d3LrS/VsZy1mz7lP2pflOQfNFCt
         P7cbl2TYKRIM4xdfhPewUHlCVMVADU8GuBG6H/bxFSBWeOj8cnlgeloUnWozfNZnbBkf
         9AVfMIGzP2zaKob7Ko57ajXG3PbDPGvtUbprPyNg9iEUTdaTLRJWsplSWZh+62+W3C+b
         vrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698663757; x=1699268557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1lhozIxyHBL/jN8zh4HAqe7ydkGHNrsZdasWYJCoeU=;
        b=qEPfHgWBKCW+i63zdhWKBV1fZDRSvTIYIHQwDmccTAI4LMEGi9yn3suc8AvlnP5Htj
         1IZp7Ua5Rvalw9fFOn3Ns+DY3HUSjLw3jh7O6hPM9//r0P79a1VxvYObyYzuaWMOuG8W
         PlqFrWa4ZTzHVyypa37nwCv1ihi51prnF71jEMeiM5kcpUt2l323E9LxL+wZxpElG5ZS
         /Hc5olUAToZ/VAvGOs5mwhEeMbzrf0Fk7Dw1e8UG/Iru5zou6ptrsbXZZjLoaQhVXHUD
         NLx4LpUmjZMIIPEahewNLdS59Q13TAyxjRz+4A31l3epNbEIAjcm37LCrd2jIBA8kiiH
         /PSw==
X-Gm-Message-State: AOJu0YwAZcY/iAe5WfmRhHYHMz554gDHSUQar/ZqOooYTQAPsbTjlwRO
        V6Xh9/a/tptoXLqVl2gN8K5f3g==
X-Google-Smtp-Source: AGHT+IHacRR+tU2esAAKHMXuWVCgDRo+jroaDmCpDRW5vjNxUTBKgis0G7GPkFz/oA7wycrVWfSGfw==
X-Received: by 2002:adf:f24a:0:b0:32d:a476:527a with SMTP id b10-20020adff24a000000b0032da476527amr7320948wrp.50.1698663757422;
        Mon, 30 Oct 2023 04:02:37 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o12-20020a056000010c00b003232f167df5sm7963731wrx.108.2023.10.30.04.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 04:02:37 -0700 (PDT)
Date:   Mon, 30 Oct 2023 14:02:34 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Oliver Crumrine <ozlinux@hotmail.com>, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v5 2/6] staging: octeon: remove typedef in enum
 cvmx_helper_interface_mode_t
Message-ID: <50cb7891-44ed-4229-b0df-088a701beef5@kadam.mountain>
References: <cover.1693236450.git.ozlinux@hotmail.com>
 <PH7PR11MB7643DEB4401AA83A0578087CBCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
 <32e9ad3c-191e-4dd1-b1cc-07f7b93c3f28@roeck-us.net>
 <2023103049-daybed-abstain-bad9@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023103049-daybed-abstain-bad9@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 07:24:37AM +0100, Greg KH wrote:
> On Sun, Oct 29, 2023 at 10:17:21AM -0700, Guenter Roeck wrote:
> > On Mon, Aug 28, 2023 at 11:39:07AM -0400, Oliver Crumrine wrote:
> > > Remove typedef in enum cvmx_helper_interface_mode_t, and rename all instances
> > > to cvmx_helper_interface_mode
> > > 
> > > Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>
> > 
> > In linux-next:
> > 
> > Building mips:cavium_octeon_defconfig ... failed
> > --------------
> > Error log:
> > drivers/staging/octeon/ethernet.c: In function 'cvm_oct_common_get_stats':
> > drivers/staging/octeon/ethernet.c:204:37: error: storage size of 'rx_status' isn't known
> >   204 |         struct cvmx_pip_port_status rx_status;
> >       |                                     ^~~~~~~~~
> > drivers/staging/octeon/ethernet.c:205:37: error: storage size of 'tx_status' isn't known
> >   205 |         struct cvmx_pko_port_status tx_status;
> >       |                                     ^~~~~~~~~
> > drivers/staging/octeon/ethernet.c:205:37: warning: unused variable 'tx_status' [-Wunused-variable]
> > drivers/staging/octeon/ethernet.c:204:37: warning: unused variable 'rx_status' [-Wunused-variable]
> >   204 |         struct cvmx_pip_port_status rx_status;
> >       |                                     ^~~~~~~~~
> > drivers/staging/octeon/ethernet.c: In function 'cvm_oct_probe':
> > drivers/staging/octeon/ethernet.c:801:22: error: variable 'imode' has initializer but incomplete type
> >   801 |                 enum cvmx_helper_interface_mode imode =
> >       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/staging/octeon/ethernet.c:801:49: error: storage size of 'imode' isn't known
> >   801 |                 enum cvmx_helper_interface_mode imode =
> >       |                                                 ^~~~~
> > drivers/staging/octeon/ethernet.c:801:49: warning: unused variable 'imode' [-Wunused-variable]
> > 
> > Bisect points to this patch. Bisect log attached.
> > 
> > As usual, my apologies for the noise if this has already been reported
> > and/or fixed.
> 
> It has not been reported, thanks for it, I'll go revert the offending
> commits.  And I need to figure out how to build this driver better, I
> get no build-failures from anyone for it when stuff like this happens,
> odd...

We did report it.

https://lore.kernel.org/all/CA+G9fYvVETLEtiZ=MFRrxgXpmgirVHz-tDOxhU=7_9dtmx7o5g@mail.gmail.com/

It only fails for Octeon def_configs.  Just cross compiling on ARM
isn't enough.  All the stub code is just for compile testing and doesn't
work...

regards,
dan carpenter
