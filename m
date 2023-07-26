Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA64762A83
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjGZE66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjGZE6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:58:54 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD2B211C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 21:58:48 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742eso62829615e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 21:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690347527; x=1690952327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8VSCNiqtjM63gyIxgjIBJEUZn4+F4fATzLK2EYdkNIY=;
        b=KAne/S+rw2HDnpOYoq0XxAAGGDmFqVEL+4b4QaJcz22Motczt/sEQi9P3+LqtencG5
         gffk18N2un8Un3gVDBbLDRJCSvj/U8kQRXbeQ3sQi+huU3lOUDhkEacR32UfE0BX4PXh
         R5/AZ6BiObX/u6qK7p5VAxfARPx+dYhRpdGh8YMNmi7dfD3cWvKAT9kHjYSnEJ5f8VY9
         O4DK8ND7BY98sdM+l45wVaQtDojEafUaGFQgGsLdy7qT7doz5fcB77x8RhaQWCvIVbYf
         16flgyVtRYvWqtls+t8zRp/16OIRitE9lb7iBK7d3/SPlHxDXZmPwzdX6fReubLyHpoC
         4YXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690347527; x=1690952327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VSCNiqtjM63gyIxgjIBJEUZn4+F4fATzLK2EYdkNIY=;
        b=GfkOKehzXZwThofUOfVEhdJo+D2N+jhzFfjXSewVeDAcukDdrZVyXVY1CxflDFrvvf
         qndWBNU+LIKQ+xEm7evkGEVkKba24KVU0xS5fKve4lXgDa8DITK4/yQ5A5c/xZqjoOSQ
         kboMVM9Vi8doKTfbzPTa+khqza6XBk93PZp0t6v1pckW3SIIcWsAIEI/b7Lz55Qmapzm
         UIT6LvcFM66kTorVpf0gUOVhZc4XakVKDBqgt4ba2QjFz+b1R1+2rJxpz+LD+3knH38v
         fyNjun3+vy1EmRK5TKmS5zKFTgxwpwKX+6eOEMXqm/5wQ/MZudC3xbC6jv33wY3CWKyl
         yuyA==
X-Gm-Message-State: ABy/qLYOMHt6eG7hcVPij9SZcyJwMvJAvWvg36n0HvEbMri77yU/WeWt
        tjAL1lS0Gnmt+kTNKIK/bY4vBg==
X-Google-Smtp-Source: APBJJlGmyTCKXK1KhdP6dWBqtNLQ81LaRl/lodbuRe1N53MLle/JLuh+e2iJ/WFJxYTYet9lHw3Lew==
X-Received: by 2002:adf:e3c5:0:b0:317:5d1c:9719 with SMTP id k5-20020adfe3c5000000b003175d1c9719mr515001wrm.9.1690347527148;
        Tue, 25 Jul 2023 21:58:47 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d6e0a000000b003141e9e2f81sm18453128wrz.4.2023.07.25.21.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 21:58:46 -0700 (PDT)
Date:   Wed, 26 Jul 2023 07:58:44 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     Andi Shyti <andi.shyti@linux.intel.com>,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, andrzej.hajda@intel.com,
        intel-gfx@lists.freedesktop.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mripard@kernel.org
Subject: Re: [Intel-gfx] [PATCH v2] drm/i915/tv: avoid possible division by
 zero
Message-ID: <a4350cec-4ed6-40bc-b68b-3a3a89aa08ac@kadam.mountain>
References: <5d096bcf-c394-4dad-b307-3d7e33ab6e6f@kadam.mountain>
 <630b9f2e-00e8-5b54-ad1c-3e4d404454a1@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <630b9f2e-00e8-5b54-ad1c-3e4d404454a1@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 09:21:50AM +0800, Su Hui wrote:
> On 2023/7/25 13:51, Dan Carpenter wrote:
> > The reason why the first five attempts had bugs is because we are
> > trying to write it in the most complicated way possible, shifting by
> > logical not what?
> Wonderful! Should I add your name as signed-of-by?

Sure.  Or you can put it as a Suggested-by.

regards,
dan carpenter

