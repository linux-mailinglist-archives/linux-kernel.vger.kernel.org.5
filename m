Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB8B7A0B07
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbjINQwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjINQwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:52:44 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3308A1BCB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 09:52:40 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bf6ea270b2so9153625ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 09:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694710359; x=1695315159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r0PIFkgAKbrMcVoY24lLipEKJInCl7seVpo3l//wznQ=;
        b=BJ461dA1fUKAUWLqaFfkW0wq1mkuVcAUOnYtQPQKpOIwfQu8JJaxnj1TQkL0q5OzKm
         iME5BxFhF3vXxnarUfr+Bnvih7Y66Sw1N0m4rUPLtKaO+C+jYtSTP9+8cwoHgEsexlSq
         4xnkP3phPTDF+rLbES56cGhdm5Iuq7ubd4Kqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694710359; x=1695315159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0PIFkgAKbrMcVoY24lLipEKJInCl7seVpo3l//wznQ=;
        b=WSrDPF+bC2568rTXchcHRlxX5Ze5VAdHCyQ9FyEdw8pSTAwV0qNqyRz/CoKMUcmAAq
         YIxZZAvkR+urncVdnqfb/PH2++kWS99XizfcC+EgS1Ahts2TFs7ZaDJfD/yTFzRsq0uF
         rP0wWaNZCWoRYtRyKpRrbs3huKwvF754fpc4kyhjhqjMxGpgm9ZSAb9MeQQxV28RgBWw
         0EF8PEj8PKEP29DKTiAF2dCJo2QJs97St2qkof6nuEuFR+Oi6LSKyQosoDq3exKOdArp
         umSs1QVHam0MQ7WS6ilxCb+kHerpYfaB75ta4UdFZFO+cpEilD6V5ariXHmdohpUaXz5
         ppng==
X-Gm-Message-State: AOJu0Yzh2GEs48dBiSVG69tIWYZa30hXxu7ua9IIohj0v91y4JwPSmMD
        zha9SeJUQ45M/AcpgDyJARRHwQ==
X-Google-Smtp-Source: AGHT+IH334ra+z6TaPT2K2le+CKl26jjaRaWR5gBvgujVzunOvDx1yIYuftdJvAeTfi6FAe4UebEgQ==
X-Received: by 2002:a17:902:b281:b0:1b8:7fd7:e022 with SMTP id u1-20020a170902b28100b001b87fd7e022mr6178845plr.28.1694710359638;
        Thu, 14 Sep 2023 09:52:39 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f24-20020a170902ab9800b001bb3beb2bc6sm1820038plr.65.2023.09.14.09.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 09:52:38 -0700 (PDT)
Date:   Thu, 14 Sep 2023 09:52:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     SHA-cyfmac-dev-list@infineon.com, aspriel@gmail.com,
        brcm80211-dev-list.pdl@broadcom.com, franky.lin@broadcom.com,
        gustavoars@kernel.org, hante.meuleman@broadcom.com,
        hdegoede@redhat.com, kvalo@kernel.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        marcan@marcan.st, ryohei.kondo@cypress.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] wifi: brcmfmac: Replace 1-element arrays with
 flexible arrays
Message-ID: <202309140952.98489A964@keescook>
References: <20230913065421.12615-1-juerg.haefliger@canonical.com>
 <20230914070227.12028-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914070227.12028-1-juerg.haefliger@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 09:02:27AM +0200, Juerg Haefliger wrote:
> Since commit 2d47c6956ab3 ("ubsan: Tighten UBSAN_BOUNDS on GCC"),
> UBSAN_BOUNDS no longer pretends 1-element arrays are unbounded. Walking
> 'element' and 'channel_list' will trigger warnings, so make them proper
> flexible arrays.
> 
> False positive warnings were:
> 
>   UBSAN: array-index-out-of-bounds in drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:6984:20
>   index 1 is out of range for type '__le32 [1]'
> 
>   UBSAN: array-index-out-of-bounds in drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1126:27
>   index 1 is out of range for type '__le16 [1]'
> 
> for these lines of code:
> 
>   6884  ch.chspec = (u16)le32_to_cpu(list->element[i]);
> 
>   1126  params_le->channel_list[i] = cpu_to_le16(chanspec);
> 
> Cc: stable@vger.kernel.org # 6.5+
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
