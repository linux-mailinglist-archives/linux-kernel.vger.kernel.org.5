Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDA875EBC5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjGXGjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjGXGjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:39:43 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34BCE5C;
        Sun, 23 Jul 2023 23:39:17 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3175f17a7baso329005f8f.0;
        Sun, 23 Jul 2023 23:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690180734; x=1690785534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBFPtNUr5zfQpCgu0uRJ8hgMdYMycg/Xxc747XVGWkA=;
        b=I2he+yw5UCaSK16Llg2Jj1ZS2y6/MuCAluMR/qE3darHFx1fIM4dwcaXcCPK4ipCwc
         ehmgEv4TbLzUma2B0bwh+29VuYBRNojZbmdYAixXc3mha3Xj0BPKdnGPitbdn5DzGP3w
         7++BUWkJ1v+7KYLUx/YTqGXS3h2Oleb9ONJNdDKuwtYTN0zoKnwSEPHstP/AKwWE4DgC
         PJCoJBM174n5c51mLa8FKR+OCfdiKdY7Hc/DuyvoDqcP0tNqHzqH5DXrtXAiFuJrVCpq
         9GwXiN0TxWnsSFV2cDbMm955CUbBxVQOnL/8orpBh2YKnCQQo0rJM48FLlQLOK8mGTAP
         CLoQ==
X-Gm-Message-State: ABy/qLYyUKvKFyA/q6eF1w2n5wtcWkRB0e+vAO162yfkB7riIF6f5EI8
        vGzcbSchgGl+z0Bw2ZDFms0=
X-Google-Smtp-Source: APBJJlGSUmRKzqjC/Uqd0tfK/mlDP8ww9QDg5376q0LqdGrJd79508IrFYaOBR6hTASFTeZL5KjIpw==
X-Received: by 2002:adf:f8ca:0:b0:314:1d7b:5b86 with SMTP id f10-20020adff8ca000000b003141d7b5b86mr5433796wrq.21.1690180733790;
        Sun, 23 Jul 2023 23:38:53 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id a15-20020adfeecf000000b00311d8c2561bsm11722892wrp.60.2023.07.23.23.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jul 2023 23:38:53 -0700 (PDT)
Message-ID: <c1f2f55e-bd1b-957e-c4d9-6a326f7e19fd@kernel.org>
Date:   Mon, 24 Jul 2023 08:38:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/1] drm/i915: Move abs_diff() to math.h
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Helge Deller <deller@gmx.de>, Stephen Boyd <sboyd@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
References: <20230721135318.17603-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230721135318.17603-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 07. 23, 15:53, Andy Shevchenko wrote:
> abs_diff() belongs to math.h. Move it there.
> This will allow others to use it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org> # tty/serial

-- 
-- 
js
suse labs

