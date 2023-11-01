Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E1B7DDBC4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 05:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjKAED1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 00:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjKAEDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 00:03:25 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7CEC1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 21:03:23 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6bf03b98b9bso361558b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 21:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698811403; x=1699416203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NnMb6+VyJPA3A0rpO2QIfgR9bU2yeP3mMFNmvX5wlvI=;
        b=dZUgDamZAjKuKNwgh9rC7/V7VoxudveKDj3nCG2H7pS6MSHtKEnBMGxe/HGi/iwK28
         qLI/jVCDg7Y6IqI6ScLnOlUbcrXR2h4IFCLzqMPLouu1MiSPF27PiWPetHSRWfSIvuf/
         lS89Bm/ibwYqPKXBMfSDzbVIbw2gzDnxOuTYQje6knPDSFGck/qzzDRT6XPixNquqjEX
         JZNIh5T/pbricGtXf5Ho+bRl0++9hZvTJQiYei5JYSBJGCcJb+yt6w39dYN7Vy15BZtT
         cxKV7LjRb0JgRECQYjx5KicUN8PFx8r/LoYDOBVbfTmAjFcdAS15AjoDWUHkcumtDBpI
         YQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698811403; x=1699416203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnMb6+VyJPA3A0rpO2QIfgR9bU2yeP3mMFNmvX5wlvI=;
        b=LRN0+ydhqwey9bCtdXpPH1ohCJcVKsYhPznl+ik1WLE1xW0Dneih2FBJPK9sZHmtQk
         j89qICTwleM1XzLOGh+DBeaohMXBGXZGLVvx2E7AhXhFGTiSo33GR84yrgcVsS7VPdvw
         lkmDEjTEQj2+q/qdto9uQGVg+iBpRUoMYYWH1Uz/UkmudHhlpunsWlyLRgqwYINYtkPe
         lI2f5VK3h3bv4uU/63VMZXODssbjwwszWQlDxUiW7F6MvmyZh7mlGCwt085Qs+BVsLAR
         l/4MUHVLX1mbh2FhAwfss5LvoC/v71X6ZPK9sbbYldG9kcf22HElKlxwLhM5YrEGMR04
         EVag==
X-Gm-Message-State: AOJu0YxKnw/qe1iGQx6uSKRhwEfH+kzm8IV5GwU4/F5k7Uy1wbFY2jEJ
        bSfCebEBuFiiTPHyXOdTBn+PEfiViMQ=
X-Google-Smtp-Source: AGHT+IFJV4DrN5I2ZCm7U/tQz+n3KIvZHavrDqKe3B/FXxIf2VCztT7TUDRH2JXNUCwFZCjwy2tnFQ==
X-Received: by 2002:a05:6a21:7897:b0:151:35ad:f331 with SMTP id bf23-20020a056a21789700b0015135adf331mr6146183pzc.14.1698811402841;
        Tue, 31 Oct 2023 21:03:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n2-20020aa78a42000000b006c107a9e8f0sm348552pfa.128.2023.10.31.21.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 21:03:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 31 Oct 2023 21:03:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Li zeming <zeming@nfschina.com>, gor@linux.ibm.com,
        hca@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stackleak: Remove unnecessary '0' values from ret
Message-ID: <fe84bc23-03a3-4783-86c7-bd2323269b8b@roeck-us.net>
References: <20231017060824.10434-1-zeming@nfschina.com>
 <ZS5ek5RrW3XaBph9@FVFF77S0Q05N>
 <202310181704.F1089D5B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310181704.F1089D5B@keescook>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 05:39:21PM -0700, Kees Cook wrote:
> On Tue, Oct 17, 2023 at 11:14:43AM +0100, Mark Rutland wrote:
> > On Tue, Oct 17, 2023 at 02:08:24PM +0800, Li zeming wrote:
> > > ret is assigned first, so it does not need to initialize the assignment.
> > > 
> > > Signed-off-by: Li zeming <zeming@nfschina.com>
> > 
> > Does this actually need to change? It's not harmful, and deleting the
> > assignment doesn't save any lines of code.
> 
> I prefer explicit initialization. Any unused initialization will be
> optimized away by the compiler during Dead Store Elimination, so all
> removing the initialization does is make the code more fragile in the
> future.
> 

Also, be careful with those submissions, and do not take the claim
in the commit message at face value. Several of them introduce
uninitialize variable errors. I had two submissions for the watchdog
subsystem, and both of them were wrong.

Guenter
