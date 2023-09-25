Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB487ACD9B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 03:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjIYBgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 21:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIYBgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 21:36:44 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5DEE8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 18:36:38 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bf6ea270b2so38182905ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 18:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695605797; x=1696210597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qeR5XrVQCInkFvx4VClyLg8dKxcBVpTRgwbskRCliSE=;
        b=G943H23MYQ6LXiY0kjYoGISQ003X57VSvAfDkG6KJ/iI0Fdew7u/SXx5CINHeGhkZP
         imI3UaP+sHq/KJcMAdnPQw9s0nLrI+U9IpQKiy7RcNXVwYfpoAqzvUzLynA7Lkr/23+f
         s/YhfLm/wvd4U6a/RH73TyJVPuEfd9W6M72Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695605797; x=1696210597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeR5XrVQCInkFvx4VClyLg8dKxcBVpTRgwbskRCliSE=;
        b=O7wcp8osYDWnAuH49Nsk1MmVWxbh2A9RxiOMgK0bdN2ARUSiaWeThZYImePj+cx3Lk
         3S1rOpIEsiHNQ573Se96F5mTXKy5NASXCJ5RKJNJSzlDGzxessiaNt8wWE3Ki58CKvmn
         ATqoVb8wz+VDLB7ZVkUwtYEwS+Ydccyc/IgwhzNj7jTgE9lw1rrBN0ZbeuNCpEAUB27Z
         Cz32mP1UI/bn6q8rKbX92fNtCSKC5b6Ob+GWdzNN3IfJbeCf5yvK9KqZ3PnfCVZ2Id5j
         iUbu2/mpsIsYso/8UdvC9MYALEavhPcwZNoHYRQvItySbU1z4KO1jadOJw4XgyWxFnIf
         Nn8Q==
X-Gm-Message-State: AOJu0Yz0o3SRfTk1OGDMLMqCeee8baqpNwk/d3wN6bps5xSQ0USo4yL4
        zEigFjn+VtCnk8vcZ2fp0S+DYw==
X-Google-Smtp-Source: AGHT+IFgP8xAPt84G1p21QIiajeTaaTzy7k0n+4+919AGIdahFuIEHSLkgXwzzsCd+zrFF4P/7jCvw==
X-Received: by 2002:a17:903:187:b0:1c3:3347:996e with SMTP id z7-20020a170903018700b001c33347996emr4573484plg.23.1695605797563;
        Sun, 24 Sep 2023 18:36:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jk13-20020a170903330d00b001b9da8b4eb7sm2045534plb.35.2023.09.24.18.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 18:36:36 -0700 (PDT)
Date:   Sun, 24 Sep 2023 18:36:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add include/linux/module*.h to modules
Message-ID: <202309241836.22B5359@keescook>
References: <20230920211009.1009150-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920211009.1009150-1-mcgrof@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 02:10:09PM -0700, Luis Chamberlain wrote:
> Use glob include/linux/module*.h to capture all module changes.
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
