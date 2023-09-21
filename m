Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF997AA0EC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjIUUuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjIUUtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:49:10 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB83445625
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:51:40 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98377c5d53eso150643966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695318699; x=1695923499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yoJ9BAqIakkIRBck4+c6D512CvwPivJvBbrFNArEblQ=;
        b=iOTG4EUpRwJyLsZSAp0/U0366gkT0yJK5N7OpyXc2SX81HVRJ7hHCBUr1vPDdiHH+j
         NV4sccEnr8qIQUnaO6Tm3Hj11hODEYyYuar5Ro1wVGm+3+otLgUWA/qRMTH2akwW3rdL
         wwTlsFLs0Hew9/bFHpQg5qve+sOaAdULr20Nmg1FnnlonhQruw5JuTnd1WBMIe0u/liW
         yF4ep3xKiA3LYJ3onwG0rpUKwv2A9xb4vYa3w52HlCaIUj1lkleUg5jLXLP0QffOWEVe
         Y+7b4o0WLZ/fy6EdgQNpQzB3mbDu4kLmGsj9TzUA0Hqswp295U5GHluxykw2X35Y1RNN
         dXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318699; x=1695923499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoJ9BAqIakkIRBck4+c6D512CvwPivJvBbrFNArEblQ=;
        b=Lfue1sZYSZjWjUGb/lgyBCfhwZk1X8Pn9tkmVpRzMED8EZW9WTm2mkiS9Raz3ZpOD2
         nmvSFl8n5ZW/CWSyLY+ehN72/vjyYzYwt9d2sCUyK/qNabkswA1JYm5qTZUeyigfbfkq
         yioBC3fKCMXvRT+lo97TJwHKN3N3oVyf3uPFQBNey/SlZBtdB0n++YTncoK1Nsag1By/
         CdJK2uw4SUeoZfZCadi5FRGkY2NHwM3/kBJcJ2HbM9t3ikfLYexUbneu2g+OCwJR8+np
         i3Ii0ajnJDLuLd5Elu3hbFYUefFkvYsXdHua3FmbgRCb/4ZLiOTxlZAmJtgqqi4XNKHB
         FNRw==
X-Gm-Message-State: AOJu0YxeD1V1cqIkA/a9cHy/YQQFptJgxTdZuWLQRUg43S2nslHYQaT0
        VUeeA+LSKl7d5b2NYHgGQW1GDh32COLIxVxWCLj7Tg==
X-Google-Smtp-Source: AGHT+IG9uHccNQRNfWrPU8ZX/D7XdOZck/6xT2lynqeRJ6EkLfvPB7KBcTTCDBPgEMaA+RDkpFh+bw==
X-Received: by 2002:a17:906:2cc:b0:99e:f3b:2f78 with SMTP id 12-20020a17090602cc00b0099e0f3b2f78mr4284625ejk.67.1695289173321;
        Thu, 21 Sep 2023 02:39:33 -0700 (PDT)
Received: from linaro.org ([86.120.16.169])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906168400b009ad829ed144sm751272ejd.130.2023.09.21.02.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 02:39:32 -0700 (PDT)
Date:   Thu, 21 Sep 2023 12:39:31 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, dl-linux-imx <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: linux-next: Tree for Sep 12 (drivers/clk/imx/clk-imx8-acm.o)
Message-ID: <ZQwPU23VTdkLVHDR@linaro.org>
References: <20230912152645.0868a96a@canb.auug.org.au>
 <8b77219e-b59e-40f1-96f1-980a0b2debcf@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b77219e-b59e-40f1-96f1-980a0b2debcf@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-09-12 15:28:29, Randy Dunlap wrote:
> 
> 
> On 9/11/23 22:26, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20230911:
> > 
> > New tree: bcachefs
> > 
> > The bcachefs tree gained a semantic conflict against Linus' tree for
> > which I applied a patch.
> > 
> > The wireless-next tree gaind a conflict against the wireless tree.
> > 
> > Non-merge commits (relative to Linus' tree): 4095
> >  1552 files changed, 346893 insertions(+), 22945 deletions(-)
> > 
> > ----------------------------------------------------------------------------
> 
> on arm64:
> 
> aarch64-linux-ld: drivers/clk/imx/clk-imx8-acm.o: in function `imx8_acm_clk_probe':
> clk-imx8-acm.c:(.text+0x3d0): undefined reference to `imx_check_clk_hws'
> 
> when
> CONFIG_CLK_IMX8QXP=y
> CONFIG_MXC_CLK=m
> 
> Should CLK_IMX8QXP select MXC_CLK?
> I'll leave that patch up to the maintainers.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>

Thanks for reporting this.

Sent a patch for it:
https://lore.kernel.org/all/20230921093647.3901752-1-abel.vesa@linaro.org/

> -- 
> ~Randy
