Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3926A7FDDA8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjK2QxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjK2QxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:53:03 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A436B6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:53:07 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-59b5484fbe6so69677037b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701276786; x=1701881586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FPGbfDWwX47hn9c1TMZWvz82zmR4+7EsCG8Vv2EabG0=;
        b=SN4hC+FNTDurfIyFfIsHAfkfZ5mqCfFrrK7epLVqG2cuH+DzfdmN2xJIzzqPKbG2pF
         feq00LXuGCjMHsqd2S7Vz+0mZ7FI0pzllRkFRR3eoIDK0OpYq2jn0UwrGZQ5B2XF/gIJ
         XaUULQLHf7+Va4xixfPcGsXg/HLFr6NBXBhwhMDPUSnf+2DmubJl2JL4c34jClrZ1g3B
         VsVuWxdw7UfbRU5VXxiww1yWbQrZITj+vw5zUUr256LVGZNfMKeV+tvWxbDOMMygXaqS
         V6K6CkSeHN7XYxcjCjc0PkAdFje1zFdhbns/kppQLdmke0y+JWGSRso5UftegeuOdYoo
         95Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701276786; x=1701881586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPGbfDWwX47hn9c1TMZWvz82zmR4+7EsCG8Vv2EabG0=;
        b=ApxLRezcTWW7UNbdn9M4RHct8hhR6j5MwfbXR8Z4zGzmnsln+on0Wzy7ChIFFChXEz
         9+zK0QUHtdDlUhKHTlFADUJ7NyKaHYkk/+J9pEUG0z7uhEPx69CsBC4k4Iz0ee9xqXNO
         1fHNjO+8GmF/v/5PMQLnftVGW+UXaM7qUdhweI7ZusXvIcKMKvp3byqbouE8498NRy9l
         sHJG6HMYihzmoKFVx1T8HXq3vbHGMyv/t4NaBBQdpHjm2fDX2g9bKNBabZULrhvrt7gc
         kkvVfFIyU01I05WUIyzHnds/W7jMhLeRcSE+Ndb0rcvtMJiTSmBgyIaxqTt+7wGFp41j
         lg/Q==
X-Gm-Message-State: AOJu0Ywp9aAKhJTtw/P29/syd8XA/M7RG1++aIudR6WBtZwuzdMnygx5
        kbV2EOQcTZHYNl8txu9/4oPbMw==
X-Google-Smtp-Source: AGHT+IGmGSM5NJDfl50YO5yRCBQhZORbGm64vh+8LM76PvjgpggOwuowAv/8NruJzpZ7nIsrkCFYqA==
X-Received: by 2002:a05:690c:26c5:b0:5ce:2148:d4cf with SMTP id eb5-20020a05690c26c500b005ce2148d4cfmr17974677ywb.7.1701276786078;
        Wed, 29 Nov 2023 08:53:06 -0800 (PST)
Received: from aspen.lan ([209.120.180.235])
        by smtp.gmail.com with ESMTPSA id kd26-20020a05622a269a00b00421b14f7e7csm5700786qtb.48.2023.11.29.08.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 08:53:05 -0800 (PST)
Date:   Wed, 29 Nov 2023 11:53:02 -0500
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] backlight: mp3309c: fix uninitialized local variable
Message-ID: <20231129165302.GA18064@aspen.lan>
References: <20231129164514.2772719-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129164514.2772719-1-f.suligoi@asem.it>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 05:45:14PM +0100, Flavio Suligoi wrote:
> In the function "pm3309c_parse_dt_node", when the dimming analog control
> mode (by I2C messages) is enabled, the local variable "prop_levels" is
> tested without any initialization, as indicated by the following smatch
> warning:
>
> drivers/video/backlight/mp3309c.c:279 pm3309c_parse_dt_node() error: uninitialized symbol 'prop_levels'.
>
> To avoid any problem in case of undefined behavior, we need to initialize
> it to "NULL".
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/dri-devel/af0a1870-693b-442f-9b11-0503cfcd944a@moroto.mountain/
> Fixes: 2e914516a58c ("backlight: mp3309c: Add support for MPS MP3309C")
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
