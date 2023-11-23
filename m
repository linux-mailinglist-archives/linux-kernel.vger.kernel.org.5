Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6627F6216
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345933AbjKWOxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345818AbjKWOxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:53:49 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393E9D50
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:53:56 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5cc636d8a21so8366987b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700751235; x=1701356035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hng7atoCf6aq1nFffZNGfN/YBOYveUc0TKmABRfWrB0=;
        b=xDS2D+5TICLhxq2ynKnVCUuGzMKUTwm58I8eQ2uHsASwJ55sOQfBZ+8ZydSyq0++Iz
         VTXmY3TAbrq8MPKcr5rGW0gqwTt8PVeh1JS7zY07WMuOvIW2bTlZ9dCXVGXA7EveHg9+
         j5kvLj6W9vYdDj9byFfQfN+GvmBdT/dpKqEIzOo35pAJTtf3rMkn2AaVsojmsh/PxiSG
         Evkd0dzMMeg53BG1lkmawaoNB9eUA38zsO0PcDTSFxzm78h8FPKNl4Z3nxHbKb3U2BQ9
         RuVRRf2xvAa5mERi90bfn1ihsMrYLX3I0h9xxuAgFtf2jkPG05438oCkXYP5lOur/vVP
         6rNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700751235; x=1701356035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hng7atoCf6aq1nFffZNGfN/YBOYveUc0TKmABRfWrB0=;
        b=B6/FAa51i5ffkFT4qTJBQYLLzZEw+ZiIVXNge82Q9ycGNAzjnxQ5QiCMKW/SpiENPs
         0rfG5wa2nl5RIJ3FQlHXkLbC0kU4AnEhtfwmcFTWiogDaRTuzJSR18KBGlMNygqHVWNL
         udJczcq3e5V2MHS3Ll8XEwFHgu71dPKRgAFrBujXcKfTa6u2UvOYcsejQbIAoar20s4V
         OsdKpqb2PJViDPSAhnX2jl+nkcjprWiQPxeuOauKiZxNoSEXTY0s9LIdqrO4VaBeK4b2
         51ux0yz3MYJU0FrrPrRLiHg1crC6i3jam0uZEpHg1uw7yoIO63kU68pDtGQROsFEbIvC
         yHlA==
X-Gm-Message-State: AOJu0YwaZfPUBpNviRRUKkGCi6NIPzXYzheNXtYaksmsrQBzid7IdbMb
        fmjqvlBzW2FuW+Ei24DvqIr+uSYEXaz7du10o/XKPQ==
X-Google-Smtp-Source: AGHT+IGURWX4SQN9Qat66MW6pT/slPHMNeNkf7JUZYLrhKJ4LBXbN1slma6cln+C5UcPVSm4twoIuLVS7OgepAKwVKI=
X-Received: by 2002:a81:6dce:0:b0:5cc:475d:ce0a with SMTP id
 i197-20020a816dce000000b005cc475dce0amr5492125ywc.9.1700751235427; Thu, 23
 Nov 2023 06:53:55 -0800 (PST)
MIME-Version: 1.0
References: <20231122175039.2289945-1-andriy.shevchenko@linux.intel.com> <20231122175039.2289945-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231122175039.2289945-2-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Nov 2023 15:53:44 +0100
Message-ID: <CACRpkdbXjixVG+g7Yiqm6ki-xzgKUPQ7tUG4VuLH5gBGpwD=TQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] pinctrl: baytrail: Factor out byt_gpio_force_input_mode()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 6:51=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> There is a piece of code that it being used at least twice.
> Factor it out.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
