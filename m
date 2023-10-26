Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AFA7D8627
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345473AbjJZPrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjJZPrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:47:22 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4621A6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:47:19 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-27e0c1222d1so857469a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698335239; x=1698940039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xlBcWVOwKivgAn0UMjWC0U1b/ad+4cMpTB3lolYhGNU=;
        b=YTLOXLcJyFyr5vU+nhB/v0MyiIeUegIRMB0yjXlK3hclQb8HGnkdsvHGZd7MHCqBL3
         bC1RAG+f9mf2o4HcHKv7jeaISlqhUlayDQx5EgSSxT6s6FFAjUukRAjDEMDCn37HvzOe
         zxm7MbFTo3wuRvkK4B/VhjNUxAWl+dO/EU+KA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698335239; x=1698940039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlBcWVOwKivgAn0UMjWC0U1b/ad+4cMpTB3lolYhGNU=;
        b=i62k7McCIKDhtG3VGvK1Ej+CyFmmcTRhwFjZ/AbxOvgDR+VsXgIUpUUbBZcDncG5SG
         HjCEWe8u0RS1fCTHvSiJYPCwF3st6FjQqgWQwNyTR5I9KkZPRMuUtCCb+4Z81ZbsJ4DK
         DT0wqO10z0BiOpOW2JGf1deyIyFqVxvWVkABy2m8ydAlgzoYupMs3glRTApiXjxSrlwD
         /+cIsFtLTtfjH0A6ghCaGMrK2w8U3BQhuXQHcQkmTWUqkEo8OQgTCdO9ADtO1B0NmHPZ
         mD4ahIoICQ77rm9wOb/qnV2WiNHA09M1hjp8zC3Giohf5RHKbDILEMft9CmabrcEeuuS
         ISEA==
X-Gm-Message-State: AOJu0YyP9ZwTYMUgwKjEElwRyGLwGmXH5WL/7aFUonBR/iR+ZaVD9Tqr
        1+R4h+vTFlyXtL0TDRlv5hH46Q==
X-Google-Smtp-Source: AGHT+IE+QPVJnhPXypHjhY8uvISBKpa7dbbm+rvilNnSdebvclKGppTYd6ACyZS9wBGFhF/d0zryLA==
X-Received: by 2002:a17:90a:e38a:b0:27d:36df:8472 with SMTP id b10-20020a17090ae38a00b0027d36df8472mr15374711pjz.27.1698335239138;
        Thu, 26 Oct 2023 08:47:19 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a195e00b0027cfd582b51sm2008331pjh.3.2023.10.26.08.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 08:47:18 -0700 (PDT)
Date:   Thu, 26 Oct 2023 08:47:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
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
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 0/3] ethtool: Add ethtool_puts()
Message-ID: <202310260845.B2AEF3166@keescook>
References: <20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 11:40:31PM +0000, Justin Stitt wrote:
> @replace_2_args@
> identifier BUF;
> expression VAR;
> @@
> 
> -       ethtool_sprintf
> +       ethtool_puts
>         (&BUF, VAR)

I think cocci will do a better job at line folding if we adjust this
rule like I had to adjust the next rule: completely remove and re-add
the arguments:

-       ethtool_sprintf(&BUF, VAR)
+       ethtool_puts(&BUF, VAR)

Then I think the handful of weird line wraps in the treewide patch will
go away.

-- 
Kees Cook
