Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7308011F4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378972AbjLARnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLARnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:43:32 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74970F3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:43:38 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ce0d3aff81so368260b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701452618; x=1702057418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owVCh6YYqr7z4S5sGKUp6ONDt91jAW/AQRpQ3Hht2rE=;
        b=YI7/Kak+M0keC5LYFWRieAtFQwy88AELhJqtqjF8I5j+6QrHbQpLMUnvFnZKVQV6lp
         3ZUbVgw4uMqpEMhQ8ckfpqiQGK8GiarJOHOey9exg//I7YW5GUJJTLcnpt/6+nL7CiqB
         Dmi5ArKy3TJFVeZkMM+4Rls/a701Y4Q8E1kHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701452618; x=1702057418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owVCh6YYqr7z4S5sGKUp6ONDt91jAW/AQRpQ3Hht2rE=;
        b=dSMthvA7CeiCR/fAS+0lsQa7oTGqJY9Oo6wHurj4tE6QdB2cbPphV3JPidWVGviAZ6
         8FCpSkGOrsye//RlxRI79AESEIMua2olZDHKewaGgFSjFftJoyEasmi5rRQuyTMxyAMX
         lXrAamXbxNbNaUde/KXiWzh41gabC7Mbug2AhPq513A/skRbeSEy9CGjZEZ7ZcD69rbn
         nCrDC5tcFHslb7TQ9INtHlUgYwHWwQhXsABCYRfx0lTzk5YSBg8egKIlW7tluT/donBN
         nKwyPUcUXTNRb6gs5/YqAFVGFfKao1Tjhi7sRsaw9ZWppbWBJfViEPbq42xMT3jK/uDE
         XmuA==
X-Gm-Message-State: AOJu0Yy8gPvSrwrgMHqey0gzqscXf6o+fHF0Xh5+VpfGxYQZ1waSpG2J
        KZYr0ta1fQ6544hUZtvdQ+kAjQ==
X-Google-Smtp-Source: AGHT+IGOuYgE89zGxitBsGpS1stcNDAWH4UYrJxRMm1q2nWCOET/iHUVMET1zt+ZzAFlo3U8nzhDkQ==
X-Received: by 2002:a05:6a00:8d87:b0:6cd:e65f:f6c9 with SMTP id im7-20020a056a008d8700b006cde65ff6c9mr6448864pfb.2.1701452617964;
        Fri, 01 Dec 2023 09:43:37 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n23-20020a056a000d5700b006cdd406e784sm3262884pfv.136.2023.12.01.09.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 09:43:37 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 0/5] params: harden string ops and allocatio ops
Date:   Fri,  1 Dec 2023 09:43:34 -0800
Message-Id: <170145261350.53238.3359968215284616685.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120151419.1661807-1-andriy.shevchenko@linux.intel.com>
References: <20231120151419.1661807-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 17:11:41 +0200, Andy Shevchenko wrote:
> A couple of patches are for get the string ops, used in the module,
> slightly harden. On top a few cleanups.
> 
> Since the main part is rather hardening, I think the Kees' tree is
> the best fit for the series. It also possible to route via Greg's
> sysfs (driver core?), but I'm open for another option(s).
> 
> [...]

Applied to for-next/hardening, thanks!

[1/5] params: Introduce the param_unknown_fn type
      https://git.kernel.org/kees/c/aa61d651412a
[2/5] params: Do not go over the limit when getting the string length
      https://git.kernel.org/kees/c/e6c5b15619a2
[3/5] params: Use size_add() for kmalloc()
      https://git.kernel.org/kees/c/9a4a4b528bff
[4/5] params: Sort headers
      https://git.kernel.org/kees/c/18bdb5a032e8
[5/5] params: Fix multi-line comment style
      https://git.kernel.org/kees/c/c62c9771b7d6

Take care,

-- 
Kees Cook

