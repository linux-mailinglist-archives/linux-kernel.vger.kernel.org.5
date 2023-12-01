Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149D9801207
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379017AbjLARrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjLARrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:47:39 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1733FE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:47:44 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5c5fb06b131so606777a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701452864; x=1702057664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCNVYgwpLFteuDrNzIDZLAqe84pArYWACQkufwvTL5U=;
        b=nwsRLZKkP99RPhIfEYEerx8QGFGX/dV8yw1rcpqkf07xvSX7rg9r5qpm93GoUV82ur
         Rqx1WLl2pDZjBo+yIz1rHOSO92Q4sFnaW5U4+Vp+1qwnWtniXn1KaOKpgnCRTrUEPEqz
         497ADQZaglfAg/OOPhw94biQ25f+eLFcEzx4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701452864; x=1702057664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCNVYgwpLFteuDrNzIDZLAqe84pArYWACQkufwvTL5U=;
        b=V/IQTUo5NXjmjXVxAHNYMrT0OPU8DVPBf1N8t0UPDEBgTGzTF326BdRTJfAjTHYOox
         FFrmPm+Gz+A+i5Vki9BGonxhQmPW/+QEUBu4ov6byQUhn3WO+xDNeNVNpkGsT/WPdh9Q
         bUlum8+wBDGlyyeOJRWbVGMghWgP/ns3EveT4oHyppG+BofAsysVOZiGUMz/V+iZlDsE
         IPJxBFrkdOSR4kIpsMi10TwAR9o/QPuRzZGNXo8U7Wh8wtRxOL584lV2+oJdHfHb+KR2
         YyvZxLtsQV87Fel9NNb5FQ8Byehlr6aFZ3Cz/sxzKzXu6Leb6CkaLnTCEs64dRdG+ywl
         LJrA==
X-Gm-Message-State: AOJu0Yy0YBmHd9kDmy0DuJZgm7hbvakCvPOjIdsJxlKVocB8f60mBJHC
        sNljE+wU6KD3J6Z09pnSyg789Q==
X-Google-Smtp-Source: AGHT+IHsxxKzBrAkmN72uyMXEJDAqDR+ulUeRgl6PfoYNKg3RuRmpeIq7Urzdpn3+Vl7k98IzwGuOw==
X-Received: by 2002:a17:90a:1a5d:b0:281:da1:4b96 with SMTP id 29-20020a17090a1a5d00b002810da14b96mr22934593pjl.22.1701452864074;
        Fri, 01 Dec 2023 09:47:44 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 21-20020a17090a01d500b002802a080d1dsm1661658pjd.16.2023.12.01.09.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 09:47:43 -0800 (PST)
Date:   Fri, 1 Dec 2023 09:47:42 -0800
From:   Kees Cook <keescook@chromium.org>
To:     sxwjean@me.com
Cc:     vbabka@suse.cz, 42.hyeyoo@gmail.com, cl@linux.com,
        linux-mm@kvack.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev, corbet@lwn.net,
        arnd@arndb.de, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiongwei Song <xiongwei.song@windriver.com>
Subject: Re: [RFC PATCH 2/3] mm/slub: unify all sl[au]b parameters with
 "slab_$param"
Message-ID: <202312010945.7C5DB1FBB@keescook>
References: <20231201031505.286117-1-sxwjean@me.com>
 <20231201031505.286117-3-sxwjean@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201031505.286117-3-sxwjean@me.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 11:15:04AM +0800, sxwjean@me.com wrote:
> From: Xiongwei Song <xiongwei.song@windriver.com>
> 
> Since the SLAB allocator has been removed, so we need to clean up the
> sl[au]b_$params. However, the "slab/SLAB" terms should be keep for
> long-term rather than "slub/SLUB". Hence, we should use "slab_$param"
> as the primary prefix, which is pointed out by Vlastimil Babka. For more
> information please see [1].
> 
> This patch is changing the following slab parameters
> - slub_max_order
> - slub_min_order
> - slub_min_objects
> - slub_debug
> to
> - slab_max_order
> - slab_min_order
> - slab_min_objects
> - slab_debug
> as the primary slab parameters in
> Documentation/admin-guide/kernel-parameters.txt and source, and rename all
> setup functions of them too. Meanwhile, "slub_$params" can also be passed
> by command line, which is to keep backward compatibility. Also mark all
> "slub_$params" as legacy.

*If* we do this, I think the old names need to be recognized, perhaps
with a boot pr_warn() about their deprecation/renaming for several
releases (likely across LTSes). I think it's not a good idea to
wholesale rename these with no warning. That's going to cause a lot of
surprises and broken userspace...

-- 
Kees Cook
