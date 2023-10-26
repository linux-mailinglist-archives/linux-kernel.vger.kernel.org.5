Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980377D87CB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjJZRt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjJZRt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:49:57 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85D2AC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:49:54 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b709048f32so1148332b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698342594; x=1698947394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XCBnAelfrExSVbW+xUZ57lPgMmCuRd7/6v3ahFmt0UQ=;
        b=eFjrFq1w4XMwQ0pGrT9SjS1/cJTmRZf1KchALMHH2vja37ybo9yBGD8g3b109KUjGR
         5YFSKf1WbYD9dATk29VqmsiIxHKDdbIVX5E54Fm9tRikbDz0DJUDfrNiYzW0H5M4h0Yl
         GTX6n8D01O0Bo7d6wxuvomBsZGGN2MctMj1jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698342594; x=1698947394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCBnAelfrExSVbW+xUZ57lPgMmCuRd7/6v3ahFmt0UQ=;
        b=Z1fRiteI8VaQeXj/aksArW+j6TVTOm83AqB4ujWPFOJgOvf9TzVasy8BcYh59W0prZ
         QuUpcPiGiLD2/nKZubnPGp1h6Bxqki+6n9MakJGGNkvXuZ8JaF5LPazzC4uYo9ERZF9u
         9nAOSpvme2xitUqyYCLDZdaI6r8Q/u9xj1jx2bGL+qeDB2+AF5Cym6ecMdYFDdANl5HK
         AEe76FQxOM3ZbYiCln8Ihe96EWYtmShcm+4aEA2eYfEAazVl+huJKIoEkhnzGsfIDrii
         r5KCUFeVC5F8Fk1fklArt2Yz3Xd+eg5kcohf6Y4FL5YuskEqw4QtPJUoyLx+x3tkoe7d
         fa7Q==
X-Gm-Message-State: AOJu0YylE8rtLUUuSloasLZbbK3QnUdF0RvAoZhNxgTH4RMP0gai0D1s
        89w+L2BZuoOqCSVEfssl61reAg==
X-Google-Smtp-Source: AGHT+IG87R8BwwTXzaOKmt0xY+aN41MPhqHb5ClUMx1ejA2Lx369UqLmh7RXbmhIojMj+YrG8hOxiw==
X-Received: by 2002:a05:6a00:194c:b0:6bd:f224:c79e with SMTP id s12-20020a056a00194c00b006bdf224c79emr255124pfk.11.1698342594396;
        Thu, 26 Oct 2023 10:49:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k17-20020aa79d11000000b006933866f49dsm11781901pfp.19.2023.10.26.10.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:49:54 -0700 (PDT)
Date:   Thu, 26 Oct 2023 10:49:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Justin Stitt <justinstitt@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shay Agroskin <shayagr@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        David Arinzon <darinzon@amazon.com>,
        Noam Dagan <ndagan@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        Rasesh Mody <rmody@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com,
        Dimitris Michailidis <dmichail@fungible.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Louis Peens <louis.peens@corigine.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Ronak Doshi <doshir@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 0/3] ethtool: Add ethtool_puts()
Message-ID: <202310261049.92A3FB31@keescook>
References: <20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com>
 <202310260845.B2AEF3166@keescook>
 <39ca00132597c0cc4aac4ea11ab4b571f3981bcb.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39ca00132597c0cc4aac4ea11ab4b571f3981bcb.camel@perches.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 09:33:17AM -0700, Joe Perches wrote:
> On Thu, 2023-10-26 at 08:47 -0700, Kees Cook wrote:
> > On Wed, Oct 25, 2023 at 11:40:31PM +0000, Justin Stitt wrote:
> > > @replace_2_args@
> > > identifier BUF;
> > > expression VAR;
> > > @@
> > > 
> > > -       ethtool_sprintf
> > > +       ethtool_puts
> > >         (&BUF, VAR)
> > 
> > I think cocci will do a better job at line folding if we adjust this
> > rule like I had to adjust the next rule: completely remove and re-add
> > the arguments:
> > 
> > -       ethtool_sprintf(&BUF, VAR)
> > +       ethtool_puts(&BUF, VAR)
> > 
> > Then I think the handful of weird line wraps in the treewide patch will
> > go away.
> > 
> 
> Perhaps this, but i believe spatch needs
> 	 --max-width=80
> to fill all 80 columns

Ah, yeah. Default is 78. Current coding style max is 100... I'll adjust
my local wrappers.

-- 
Kees Cook
