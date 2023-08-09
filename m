Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7A5775739
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 12:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjHIKm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 06:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjHIKm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:42:56 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773AB10F3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 03:42:55 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso63135865e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 03:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691577774; x=1692182574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NuNy8g9v0XZLJnfH4Zk2WUp3xF2RINxa9KJil3UC/Bo=;
        b=qIN7uy//9FCYHPPoZ3x7PzQL1tihFLzKJlhr+wXS1AvgxdhrwU37O8BmJm3G/f3lq7
         Nv4TE288fgflxk8n8tNaFGHl5R7kUmSAdTv9KTd4Dbn2NtVcUOUVp0gc2hMWxW3atcfT
         ew3PH4Y3OWVP5pTm0zCUJK4D/psuV361aK0vZZtdZswcWGIssOdbnJdnFI+XCy4mWFyc
         3XMK2bKlE7mSUPV0E537ASiAOWSYBKeR2OAea/bnL8J1MYvWgUszn564FHwqHov1IRzt
         1i9l0so4Z27BvYBM7NJdT/oIfiSIMI8+nfM35H5OUgm92BykSnkfujyp+/ce0ZpFNnxM
         wq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691577774; x=1692182574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuNy8g9v0XZLJnfH4Zk2WUp3xF2RINxa9KJil3UC/Bo=;
        b=jrEojXFNZfed02v8cSwuw9D6Opf12iFiBS5RooKOA1FZYFiiQUqm5j6ZROVspx4uIs
         Pnrcxu3K8QgZs+Sv4NEJiwqhi/Y6UIVX/PzwWnWAa0EGMzkVb+Zy3T5ivr4mA9BGrzAB
         L9JJtzlaBZeaoHEcl5uljW2ROCon5AFqmyxwadOrkLPmyBH/3gEXPfyIc5QsuBlpHSpT
         N+5J1g0OIk7AM62A/B1+or/mCurmgytxlxHbPEFu6+9LQ9+rVL9NrSUbCSefqnWIjrtJ
         nQl46GBoFEqlaYEfREHG6w6KpL6AeucSDvCKkNKN/pN4zspqJZIbZsvb7tYrwn9mQ4bR
         /rfA==
X-Gm-Message-State: AOJu0Yz2U8qZh7cXvbUGYDLsdATKteva3JeXlXWb0iCWNiWrbJjOguGF
        P98CDtjL9nhb+qj+uGVUu1yiRA==
X-Google-Smtp-Source: AGHT+IE2p1Bk+C5vt6M9KxyfM0nYfTWopDI7PLc5yJE+1vsBtyC4zU3p7uMr2RygHc9Q9YF/zvZoCA==
X-Received: by 2002:a5d:4ac5:0:b0:317:5168:c21f with SMTP id y5-20020a5d4ac5000000b003175168c21fmr1397789wrs.31.1691577773976;
        Wed, 09 Aug 2023 03:42:53 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h6-20020adff4c6000000b003176eab8868sm16450196wrp.82.2023.08.09.03.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 03:42:53 -0700 (PDT)
Date:   Wed, 9 Aug 2023 13:42:50 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Diogo Silva <diogompaissilva@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: cfg80211.c: removed unnecessary
 parenthesis to match coding style
Message-ID: <f651cab8-d6ff-4bef-931a-ca7d666f515b@kadam.mountain>
References: <2023080951-escalate-unnamed-e6d4@gregkh>
 <20230808231424.3270-1-diogompaissilva@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808231424.3270-1-diogompaissilva@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please, don't resend this patch.  Greg likes the parentheses for
readability.
https://lore.kernel.org/all/?q=prism2_get_station

But also you re-sent it in the wrong format.
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter

