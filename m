Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3B57C915E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 01:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjJMXgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 19:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMXgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 19:36:22 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B75BE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 16:36:19 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so1183207b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 16:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697240179; x=1697844979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eU5US6Z43Fpk15t1FRvCwKJCGNcrOXN88pFkszR8ZSo=;
        b=TjXqErfq6q2N0enCv5Lu7dIUMAIQGbdT0wTQCbpdLMDX+tA4kYQulyyek4VJWEOK0Q
         caQs1giAWkKS281vJIlbtvmb1GIu8N4f/Ho0GFTxpZeXiTf7Xc5kgs/Krb2kWDMa76Ms
         ylENQwASk+3fc1jdkOJVhvntIAFcFKIQ8IIy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697240179; x=1697844979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eU5US6Z43Fpk15t1FRvCwKJCGNcrOXN88pFkszR8ZSo=;
        b=dPhGYWBHfXTapRdjYl22kZHWwRdMDrBDXxsQihER0qJAn70ajhR9wdolaPtgcqx9Fa
         lg3NsBLKqJJVcaxMSoSKv6jHpFwsX/pjKnwaN9ek+vH+M7mMdYSSD1AWmcKMqL5qmq9X
         +MAMlOXHo6MONoZhbUFL8ZnIeDzo17Tzhp1jePkKmUlDAyk+ZDh5tgZ+xIqeexXaKth5
         +atiw8OWF4CfILk3F539HwlCHNgNiRHdgLxc9g1nDcQav/Udi3Z7feDe+D6JrGMyZ1eQ
         Vv30U5LsqXy4NqzbpurQdsarUum2wnnve+PxGTIzZh8x0E3MqQDosFerYLkOmjvlrQvg
         dkxA==
X-Gm-Message-State: AOJu0YyJbzWMDTE8q8JgwmkQDEHHCzrCEcPV/AJMHXbRhzPBsY1P/lNv
        dKtDj9BkQU8Ght0YEwq08uHNTA==
X-Google-Smtp-Source: AGHT+IFrZlHZduKxMXjAv6EpezsvycC+MNFw6aPwzsg/Lk+kbNoyNy4OSDWARcNuO0IvhrlmdM40Vw==
X-Received: by 2002:a05:6a20:1596:b0:137:74f8:62ee with SMTP id h22-20020a056a20159600b0013774f862eemr34789684pzj.18.1697240179386;
        Fri, 13 Oct 2023 16:36:19 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a190900b0027d05817fcdsm730180pjg.0.2023.10.13.16.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 16:36:18 -0700 (PDT)
Date:   Fri, 13 Oct 2023 16:36:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: phy: tja11xx: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <202310131636.535E720383@keescook>
References: <20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-v1-1-5ad6c9dff5c4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-v1-1-5ad6c9dff5c4@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 10:25:12PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this dedicated helper function.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yay for readability. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
