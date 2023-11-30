Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6307FEE3D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345120AbjK3Lrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjK3Lr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:47:29 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C296210E2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:47:34 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b5155e154so6303465e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701344853; x=1701949653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4qE9p0d5IS1QGooVoX1UZocF/TK6F/IxVLC2dxwb4cs=;
        b=u+Zo1NeETZ7EZ2puMKwFMAlxQvKTvzwSfLm/LQzq/RFZf4P6WRDMFmE+DwVom7nmZk
         B35dIq+hefMlX3JM1p3H3KX9iy92KGffgBA7X4AEZRROfHL18ZTn1HKYxugex++SryK4
         fcrCNa/nlZYkxSEB9m2bc/zPUwp4IIAn5D9/Jnd9liP5IHt5k9TDoKpjB+6zYvPMs3pF
         jNIWH98iAHu4WEDVREjGxsuYzaWB+G5lGUOxIgn4aL1a+0cGhJ5Pc54G15i1Dx5GRVsk
         OZglHggKLMTL1xHuLGX3v1f1Lhj5jjLxDqrE2ouqS9L8ix9RqX4+TW3TXzniH9msjm9b
         XbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701344853; x=1701949653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qE9p0d5IS1QGooVoX1UZocF/TK6F/IxVLC2dxwb4cs=;
        b=KHo0bjbScW+fSXrNDMhXv8+sO3lWuMf0D/JwWMCz0AOWZ9VgjTMPqIgdX3jZStNxuu
         gcZ4Ial25JxxF/72nKrwcEZMrk1G0vIc4HyLaC4j1WK6mnXvKfmdvsHJ6ABKtFsgQStQ
         PfIoYmgaJIMLfWEqRI2sTXOG9nCRZw+TSN+Z8yo710fo8eyKGVOe4muRhI9TQ3IP2Y+V
         Fw+EUpOQ8tXog6iTM4nUvRzo12m+hvaeyqi1G3aXgP/1wYgJcq+VQhrMARwwD3jywE0c
         eOYgYNsTI88V5GcGCc/7oIZHd1JyPEl0ObAutfBWLMPwImV+ZX/5BrEFyTZRa8yzGPfW
         jfxA==
X-Gm-Message-State: AOJu0YywI3l6npuX5EOiloW1CIkb+5aA6mNLPKFm4S34HakPml4airrt
        gsAJ34WHsUTjT+uFJy3ThXTRaA==
X-Google-Smtp-Source: AGHT+IFfd5GkwBFfDxer1BiHey3pw6auUs/8FmtHUohGoDyz1N8+Z9MKKOOLxzx4tcgmvNfzM8/xZg==
X-Received: by 2002:adf:ec06:0:b0:333:86d:c292 with SMTP id x6-20020adfec06000000b00333086dc292mr7586092wrn.50.1701344853028;
        Thu, 30 Nov 2023 03:47:33 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b13-20020a5d40cd000000b00332f6ad2ca8sm1324909wrq.36.2023.11.30.03.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 03:47:32 -0800 (PST)
Date:   Thu, 30 Nov 2023 14:47:28 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Yu Sun <u202112062@hust.edu.cn>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Dan Carpenter <error27@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/mellanox: mlxreg-lc: Check before variable
 dereferenced
Message-ID: <4109f017-f07c-4755-bc1b-ec4cb30b0760@suswa.mountain>
References: <20231130094409.3963-1-u202112062@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130094409.3963-1-u202112062@hust.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 05:44:07PM +0800, Yu Sun wrote:
> there is a warning saying variable dereferenced before
> check 'data->notifier' in line 828.
> add "for(data->notifier)" before variable deferenced.
       ^^^
Should have been "if (data->notifier)".

> 
> Signed-off-by: Yu Sun <u202112062@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> Reviewed-by: Dan Carpenter <error27@gmail.com>

I didn't really explicitly give a Reviewed-by tag for this patch.
https://groups.google.com/g/hust-os-kernel-patches/c/c5hUaYIDcII/m/h4aFS7PkCQAJ
I also said that I thought it looked correct but that it needed a Fixes:
tag however the Fixes tag I suggested was wrong.

Looking at it now, the correct Fixes tag would be:
Fixes: 1c8ee06b637f ("platform/mellanox: Remove unnecessary code")

That commit says that the NULL check is not required.  So now I'm
confused.  On the one hand, the impulse is to trust the maintainer, but
on the other hand my review suggested that the NULL check might be
required.

regards,
dan carpenter


