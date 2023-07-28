Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7647675EB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjG1S6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjG1S6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:58:17 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E6730FC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:58:17 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bbc2e1c6b2so16488345ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690570696; x=1691175496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MRu9xgGnnKvTga8mQ0gCn0FsFMxzoget4tYnN1J1xew=;
        b=Z91cglUfIrf8ob9zCEdA7W8HRPubyzVXm9Ewl5MgC6pR010pqkMIJ4656mQ7TtGXhu
         5oHq/ZYX2Nl7Sh30OhV+skJjCSEvUqdKqFoGBItsgwZVP04lT6XGuCfjzmshNI0aYiZN
         QRn31HXO75Sl1MdBUpGXcFl158iQzY4zmjudo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690570696; x=1691175496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRu9xgGnnKvTga8mQ0gCn0FsFMxzoget4tYnN1J1xew=;
        b=WVH87nEk/4EcFmmfiNBkiYLcQbtZGjWc/onCeMZuIS52+KdfgfrtiblpSQ1syR3H+y
         fuYctesgjcO5ynkNSXIrsmeLktVrYKIXJdzmEDhORgk2zP/Ep6cmmOOvfp6Ph5nki/NK
         us+iWeqEeNqfDj4w4PBMSXT2LYxgk3GVjV1xv+bToLrEBJQ2quUz8pC/kNx3vATDm63L
         5dZirD/AYSt9ESPJk/r5Y6eBKo70rWA3iJktEliah44m7HTH2vmf9P+DCNwv1sCB5r5k
         w0GJbmo+lSi86MKM9TmD+vRB6xR/egm+rNbHItaBnsQI24Cv163U5yvbcIR96GTG0COy
         mUAg==
X-Gm-Message-State: ABy/qLZrvxhL/2pieQJqiXw0SFDXEFqT+q1e6sgvuaL6Ae+8zYkpcoZo
        LcGV+LmCkuesCqqQkqdeKy2Xow==
X-Google-Smtp-Source: APBJJlG900h32fIeodQCrN6pUaNehSSwvUfQMQ6ivtLVjRwRom8xzOk8E8avzyyed+zEa3U4TTtQVg==
X-Received: by 2002:a17:903:44e:b0:1b9:d362:426f with SMTP id iw14-20020a170903044e00b001b9d362426fmr1805280plb.3.1690570696561;
        Fri, 28 Jul 2023 11:58:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l4-20020a63be04000000b0055386b1415dsm3556156pgf.51.2023.07.28.11.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 11:58:16 -0700 (PDT)
Date:   Fri, 28 Jul 2023 11:58:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nathan Chancellor <nathan@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: Intel: Skylake: replace deprecated strncpy with
 strscpy
Message-ID: <202307281156.59CC304@keescook>
References: <20230726-asoc-intel-skylake-remove-deprecated-strncpy-v1-1-020e04184c7d@google.com>
 <20230727-asoc-intel-skylake-remove-deprecated-strncpy-v2-1-152830093921@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727-asoc-intel-skylake-remove-deprecated-strncpy-v2-1-152830093921@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 08:30:18PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ the case for `strncpy`!
> 
> It was pretty difficult, in this case, to try and figure out whether or
> not the destination buffer was zero-initialized. If it is and this
> behavior is relied on then perhaps `strscpy_pad` is the preferred
> option here.
> 
> Kees was able to help me out and identify the following code snippet
> which seems to show that the destination buffer is zero-initialized.
> 
> |       skl = devm_kzalloc(&pci->dev, sizeof(*skl), GFP_KERNEL);
> 
> With this information, I opted for `strscpy` since padding is seemingly
> not required.
> 
> [1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
> [2]: manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
> 
> Link: https://github.com/KSPP/linux/issues/90
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks for the updates! And based on the details from Amadeusz, it
looks safe.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
