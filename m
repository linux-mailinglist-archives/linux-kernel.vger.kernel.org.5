Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2077AE68E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjIZHQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 03:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjIZHQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:16:17 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF36FEB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 00:16:07 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c60f1a2652so28715055ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 00:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695712567; x=1696317367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AxN91ZtW8jLaX/UOOowUUIWGzrSleiAiGKIAhbg+1vo=;
        b=AGVA71JhXscg19c1gR6vafc2pQ8I6YfnZ/tV8lbrM2TGSYyLn1QHXWwyEfSLaLW2an
         YW1ZSBp2cIIRTyV2PGe0Wljg9+KmwVanbLExu19ubuyfqxMUsuhpxnN22PhG31RYYyhg
         1O+uMTLmc80gN9qM9yzkhiIeDjxZZ7GkQYdXz+j2gbcLMh0WxrBG0z5KgKCY+3dj80ae
         YyJEfBgknpM2CqbgpXO16cD/MszO5fGXJOi7A26vj2oZrhtIa8HygnpGqRtNOszL/GFg
         ANtARFVuoVphJGcjQjtc83JTFB8oCPvwoGbUOwFMx490p3NHVPCkQJq5PVCqGrLmkr7R
         xs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695712567; x=1696317367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxN91ZtW8jLaX/UOOowUUIWGzrSleiAiGKIAhbg+1vo=;
        b=mjGdGNCcT3oWzNn0+1eteX4ZpNsIJwm9QyOL/yWFHDjVZLxMYNBESHwnxNV0Fs1yKN
         SGMmBV+bhQjxW3pS9wGZJf7NKwu1hcOPFu0I9Zs04E1kPbRd+pdGOsC0LqOaWgRemkqR
         gANvS0pQ0fmQt9reTPdBNY0mcZmUb9Y6dsoFFwtoix2ECIFNxfG27Dd8WOQsW70GC7d3
         sFNcfK5SYukn3sIQJdxKyd4G//rKbox/uea0+hFBEjV3fVqGVid8hjglQQ8I4rluYl3Q
         A1goNUQKc5drFlEhmtaPIVpX1UEx34UkcRmj2kE4LLiAuyTZ9f1ihT/YgBJRKS8zOuAX
         yZwQ==
X-Gm-Message-State: AOJu0YwDYSKqCh1XGy1Fe39Uwb+wGr89/jndorJ69JPH2k2LwmhaR2rj
        NrwYv9tYSTHFETguF2SHHq/KZg==
X-Google-Smtp-Source: AGHT+IG1mTIUQ0wJLd2lPyUrwgHzq8jfM2cuuoePUp8wHpqga4QOjofY/6V2yztIVZLuGMzESpOI0w==
X-Received: by 2002:a17:903:2344:b0:1bc:2fe1:1821 with SMTP id c4-20020a170903234400b001bc2fe11821mr2991411plh.17.1695712567328;
        Tue, 26 Sep 2023 00:16:07 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id y3-20020a170902864300b001bdc8a5e96csm10153416plt.169.2023.09.26.00.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 00:16:06 -0700 (PDT)
Date:   Tue, 26 Sep 2023 12:46:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 0/2] xen: privcmd: Add ioeventfd support
Message-ID: <20230926071603.yckfk7wbzejtmqdk@vireshk-i7>
References: <cover.1693311370.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1693311370.git.viresh.kumar@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-08-23, 17:59, Viresh Kumar wrote:
> Hello,
> 
> Now that irqfd support (backend to guest interrupt) is already merged, this
> series solves the other part of the problem, i.e. ioeventfd (guest to backend
> interrupt).
> 
> More details inside the commits.

Can someone help review this please ?

-- 
viresh
