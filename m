Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435C681249B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 02:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbjLNBcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 20:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLNBcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 20:32:41 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802A9E4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:32:47 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6ceb93fb381so116459b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702517567; x=1703122367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I/u5xPLWvkIaRrhFnI+H4oirck7C5zzyjkMINIlx0no=;
        b=hknRTgIul0DPU+MYp7Xv55KyKUt+Pdr/k6CHm2nwMPAKnGnYv1+UCSYKj3vXvzlaZJ
         x3cMRPivxpdL3cTmRuxfNndSzueJSBhpx8iAl8tOV7J32kMNjnSFi0o9KX5VKkC3Zva6
         zKFiwXPnm5aCqFg1CY8Z8UtrlaEeqrssiPTto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702517567; x=1703122367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/u5xPLWvkIaRrhFnI+H4oirck7C5zzyjkMINIlx0no=;
        b=nyMpVnPgry1kzzRc9lQvwUw60kUKFMk2oufsFBRgg1CQEJOPLpzwt6MoqPh3DfljgE
         WcnIBQ2MWTmfkFLRXgGFWRrx9ZJJU2kFAGulAQZ7VFOe5xF6PSqr2upIY6hg7LEBTwFn
         jpJ4wWb2YxCI3hvuWFWewZGeFaPCxEtJ3e8wWivq6Gmsm4+xRAx6XvsRC6441GW8IQ0g
         7S5Z4pMqA/MqXiJV6Jhul4YiNNY49F6aRaUmAl4js4Uf4EO4vLqPgfbtQ5tHpW4ldh6y
         g7jcLBcmEtu5P8zyrc9aJ5Rp1+t9ZpsecCbOfl6QNu77GzWd5SIwtIgQtXHDwDdwPwDU
         mPpQ==
X-Gm-Message-State: AOJu0YwJhO2a9BZhDXtkf6mk8NEt3eflwnYP6bwaCA2n20QsmJI9YgxZ
        fNo0W5BXzXK+Wv6tbH5xZ+0r4Q==
X-Google-Smtp-Source: AGHT+IHnO4D8I+58arYWW137uvBUVvhl9xXiLGPY/CsbGcLzUXflPD8J354RvBdlqMAU+/bcP/gmew==
X-Received: by 2002:a05:6a00:4613:b0:6cd:dc48:1fff with SMTP id ko19-20020a056a00461300b006cddc481fffmr13032446pfb.0.1702517566997;
        Wed, 13 Dec 2023 17:32:46 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:17f:673b:ab18:3603])
        by smtp.gmail.com with UTF8SMTPSA id r26-20020aa78b9a000000b006cbed878df6sm10590515pfd.7.2023.12.13.17.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 17:32:46 -0800 (PST)
Date:   Wed, 13 Dec 2023 17:32:45 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     David Lin <yu-hao.lin@nxp.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] wifi: mwifiex: add extra delay for firmware ready
Message-ID: <ZXpbPYWsMvntaICv@google.com>
References: <20231208234029.2197-1-yu-hao.lin@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208234029.2197-1-yu-hao.lin@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2023 at 07:40:29AM +0800, David Lin wrote:
> For SDIO IW416, due to a bug, FW may return ready before complete
> full initialization.
> Command timeout may occur at driver load after reboot.
> Workaround by adding 100ms delay at checking FW status.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> Cc: stable@vger.kernel.org

Acked-by: Brian Norris <briannorris@chromium.org>
