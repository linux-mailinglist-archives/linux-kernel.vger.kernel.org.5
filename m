Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0037FFE58
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377116AbjK3WLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjK3WLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:11:50 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B24510DC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:11:56 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cc9b626a96so14093185ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701382316; x=1701987116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2FXLPRPiS6Mdb77R0ffuo1PuZkNG018RX2vgY/WJ7uk=;
        b=Czp1nVZUn4izanux1WF8hlUDFrLG8GWEzougKdN6CsSMH2ZOWJDLWhpgCcSReeLZwE
         ax67c7Lcu4+e4GKcwB77m/p82KEECNynK1mgCVpzCvIkZx/ugiwEsxAjxAot0nhWoviq
         y6xZCkj30bvLXOVbcnguW/fjSkRWC/Vn+WOLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701382316; x=1701987116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FXLPRPiS6Mdb77R0ffuo1PuZkNG018RX2vgY/WJ7uk=;
        b=pSeIAWqOFbDFRAZ0E0dXeMkPaJvp3V4qNYTyouw5oe/YTsxCOQ0ovD6ptJfeZeA5OB
         Xem7Wgx7ZT9eNHiEfdzCRHBnaPQjdSmiRiet2VWfqsCaz1uI203ekn+AiW+a7HMve4+S
         MWga/NgWghktXpMe/Q7nWXdoG1z5flXMILBAF5SSrOqP80TBhTuAao0dpC4oEOgdbJnL
         26ILRp9ivJD8FGqHAZEEVKPH8b6fbYT9OJmk1n8zH4ScQvJVI2eJSvUP0BNMhEUqdis9
         KczfHWEp/4o44J6h2DQch+lmc5K5tpq+U+ej2LdcM3QQaFNt+fAmH/CTAeUvWl4SGzuc
         kLww==
X-Gm-Message-State: AOJu0YzqfdRSXuMeSRMY7mJARSMxlXP+gXsfFfMptAbq8lyjsP6GCw4s
        vPNWcK+Zi5rilhk2DiMku+lhYNnrZx+knXPYxO8=
X-Google-Smtp-Source: AGHT+IH4tWRlUmskQclyK5FkszhjF8DT/WshIkLupA/qFqfEahEkWVLTEwfG04uaDmt3JTd8zTHaxA==
X-Received: by 2002:a17:902:ce84:b0:1cf:c4d3:6db1 with SMTP id f4-20020a170902ce8400b001cfc4d36db1mr18661789plg.8.1701382316117;
        Thu, 30 Nov 2023 14:11:56 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o5-20020a170902d4c500b001cf66056a1bsm1900106plg.97.2023.11.30.14.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:11:55 -0800 (PST)
Date:   Thu, 30 Nov 2023 14:11:54 -0800
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: include/linux/fortify-string.h:52:29: warning:
 '__builtin_strcpy' source argument is the same as destination
Message-ID: <202311301409.F2AFF5DA1@keescook>
References: <202311301039.7i51bZCz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202311301039.7i51bZCz-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 12:02:50PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3b47bc037bd44f142ac09848e8d3ecccc726be99
> commit: ba38961a069b0d8d03b53218a6c29d737577d448 um: Enable FORTIFY_SOURCE
> date:   1 year, 3 months ago
> config: um-randconfig-r034-20230830 (https://download.01.org/0day-ci/archive/20231130/202311301039.7i51bZCz-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231130/202311301039.7i51bZCz-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311301039.7i51bZCz-lkp@intel.com/
> 
> [...]
>    kernel/kallsyms.c: In function '__sprint_symbol.isra.0':
> >> include/linux/fortify-string.h:52:29: warning: '__builtin_strcpy' source argument is the same as destination [-Wrestrict]
>       52 | #define __underlying_strcpy __builtin_strcpy
>          |                             ^
>    include/linux/fortify-string.h:567:10: note: in expansion of macro '__underlying_strcpy'
>      567 |   return __underlying_strcpy(p, q);
>          |          ^~~~~~~~~~~~~~~~~~~

The only strcpy() in __sprint_symbol() is:

	if (name != buffer)
		strcpy(buffer, name);

Which is explicitly not the same address...

This appears to be a GCC 9 false positive, maybe?

-- 
Kees Cook
