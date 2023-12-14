Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A22F8135EF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjLNQPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjLNQO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:14:59 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4827B115
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:15:05 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d351cb8b82so10267965ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702570505; x=1703175305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z1Ou2BN/NSSGCNvRe4VvolyrUm7oUAf2oh76V3K9T9M=;
        b=ZkSvzWFe4GfrTmBb8iUOsSMZShHZoC/6pFizlZJfB9ONOgN3UTUwkKgX7kuJyqDJbT
         kavajsdaTI6rnXuGy85d33h+u8VKloOrALanp91z+RAAw++psw1KGHgu8zFL0gR5oymo
         S2PjEMBmoHCB52+2P6XENFdmySM51D5bZWxYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570505; x=1703175305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1Ou2BN/NSSGCNvRe4VvolyrUm7oUAf2oh76V3K9T9M=;
        b=dPMI5SJNVpqLxGVB+pFTPqalGG2meZ1D9yfk5MiAuT0miTOGGIZk95c4rx9AbcKD+G
         FJasHksMUf3FGSm3dVJJedat57ZxYZsjMWMzvjKJlRS5E2RXFoR0rDWhzNv4vvFrqUHx
         5xdQjrkkdwFGWecTGwxp9kfM1MGHrwU2gJ3adwckskEk6XOUeL1f/HIt1ovGrNoTLFHD
         Qm0EhXJoeofYKX26TapuHlVkaqvfHA0LDK3coaIA/zQ3SpOyk62ZQGhfJmbhEcFB2RnX
         F/w2SfPNg5T/J8+dRqTd4ED1+1kzGFazCpZ2bsbNjt9MazI7N8Xv9yokdMl24W/uzzHU
         a5qw==
X-Gm-Message-State: AOJu0Yw7XQqNuN/FxtM1oWwYqWgBVSGv61Gk2xGQugyV3/XVYZPc8ZVU
        jWzdfeZeMQ26HAKk5Jrsk5JBSw==
X-Google-Smtp-Source: AGHT+IH+ytQj5wa72LYKC5YIjqTselzMKodTANBeg8JotZhzXxmhWvXBDTQzTxLBsP0QwKZwCFxenA==
X-Received: by 2002:a17:902:eb82:b0:1d3:4c35:17a0 with SMTP id q2-20020a170902eb8200b001d34c3517a0mr1926746plg.120.1702570504783;
        Thu, 14 Dec 2023 08:15:04 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b001d1cd7e4ad2sm12549781plf.125.2023.12.14.08.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:15:04 -0800 (PST)
Date:   Thu, 14 Dec 2023 08:15:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     davidgow@google.com
Cc:     Rae Moar <rmoar@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v3 3/5] overflow: Replace fake root_device with
 kunit_device
Message-ID: <202312140814.314B59CD@keescook>
References: <20231214-kunit_bus-v3-0-7e9a287d3048@google.com>
 <20231214-kunit_bus-v3-3-7e9a287d3048@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214-kunit_bus-v3-3-7e9a287d3048@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 04:49:17PM +0800, davidgow@google.com wrote:
> Using struct root_device to create fake devices for tests is something
> of a hack. The new struct kunit_device is meant for this purpose, so use
> it instead.
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
