Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA147891B1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 00:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjHYWXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 18:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjHYWXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 18:23:32 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2B62110
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:23:30 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68a6f6a66e1so1154148b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693002210; x=1693607010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j72VvYLLcjO0q0TwaVgKma/+8ZFKhoi9lPXW4ZD9kEI=;
        b=QgR7lk9EB9hOlN74mwjquJDA1za5oYjasjQNgU0G/GLDqfUn7VTJtcLC0c31qxM7q0
         Utd1ldmmEgdFK86bLWiWObh7iHPj+Al4/NtzNE6guHdOoCen5WJhClt1HhI53vQMlczU
         v9u9Q3PhCLz/oECKrfXnCby0JPUO/3RDF7zdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693002210; x=1693607010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j72VvYLLcjO0q0TwaVgKma/+8ZFKhoi9lPXW4ZD9kEI=;
        b=VpB3JNQ3a6RBuYpHYk/fd/xGlgNVloK1T0sKTkeItOYbF9okDAc+nFoCacAGtKhFd6
         IcH4zDdQK7OO5OOJUUm1BwB8UtYg5uRreOzYLqdJ8GV7NYSEztR8SY7hCVGysgEb/KD0
         Soi3vQkOTNJzA5S9xfuo9/ZUqfxGlYmMnOjNODEJas6ATbRX+LPNrJsmv0Vh2v1dvBYo
         1vDDrBIZBc612KglRHhHDeY5M6MVrhFH68B5IzELaAWz0aJusTKcJuZSbfZXRp8xj++j
         B5NZowtRYCs2xWX6RfTV3feq6+WKCbXdPoPCMghN+ZTgIhl4KLVkBp+ZW/LtEy1nwfv5
         vK5A==
X-Gm-Message-State: AOJu0Yx4vHJtdyg5TbV6teLEy1/3DVqeOIb5K2tXF9Z1J/6IV3FE1Ksm
        0IPystkJNHrbOqnOS8Y2giaRWA==
X-Google-Smtp-Source: AGHT+IHybvZuzO2a4OYgpsz8/eivtoS599NTcOKKsxc3NmvGpQxvRQOtarZrSQYWVfnKX0BGsTUFOQ==
X-Received: by 2002:a05:6a00:1a88:b0:686:2b60:3348 with SMTP id e8-20020a056a001a8800b006862b603348mr18918994pfv.21.1693002210136;
        Fri, 25 Aug 2023 15:23:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a14-20020aa7864e000000b006888f6e8978sm2124792pfo.179.2023.08.25.15.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 15:23:29 -0700 (PDT)
Date:   Fri, 25 Aug 2023 15:23:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        david@redhat.com, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com
Subject: Re: [PATCH v3 1/5] kselftest: vm: Fix tabs/spaces inconsistency in
 the mdwe test
Message-ID: <202308251523.E66A8D88E@keescook>
References: <20230704153630.1591122-1-revest@chromium.org>
 <20230704153630.1591122-2-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704153630.1591122-2-revest@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 05:36:25PM +0200, Florent Revest wrote:
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Florent Revest <revest@chromium.org>

I love a good trivial patch review! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
