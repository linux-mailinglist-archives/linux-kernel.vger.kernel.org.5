Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941957C6FD4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378887AbjJLN4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbjJLN4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:56:08 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE3391;
        Thu, 12 Oct 2023 06:56:07 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so1777059a12.3;
        Thu, 12 Oct 2023 06:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697118965; x=1697723765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDFEI3nYAirengcI4N5OpFrbbd++2Qb7hP1jI+R2F+w=;
        b=kCYw5Lb2yNjCVyHIPg64nys9A6yqgx/RxyH+yPMqUfIA8Sbg7Xk/zH/HArqXtxznI7
         l3RdEYBNEgMg3KVQN8KCpTlxT5CXYVM6AzfCGocQhwocwXwNMeF3U+SOapPRTJL8tvKU
         H6puYYO7d971OVedXvUAOms0weSanc2DoXlL2AJ7KXc8t2FE8XMxVmXMxYND7Hwb36K3
         t9LugPtObkmjJOaNDHC5SQ3vuqNieQuhytJy596wrldqLkVq/P9Sev1fCQz96F8YmmiP
         P/DPOLOnjGgK7zbY3+6lhGOXUr5hSEfsNh+xyasjFF8eqkO0ZZYgDC8S8hpzLsqTRdJ9
         gQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697118965; x=1697723765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDFEI3nYAirengcI4N5OpFrbbd++2Qb7hP1jI+R2F+w=;
        b=LgjxAD5ClO4dobJWUabwH/tlQYQz9HL8p6IkH7NeZPxXEXKF4MRvxH/0J42eysxLbu
         V+boLPUaEAa8oueY8Z5kcXTwzFEh8Hzu+RVCEh0/QMoeIbJiMfi3hTsxFCC0zlAsyJxW
         DvIElpVoLA4NFFSlfb0p2vUUUBifv7XWygWvcFc4KAO69d9GbA86sXtBCXZOnlMMiTlX
         I9k5u5d99noDtbh8IiMIrKXG7JWoOgX5rn7KzjAJmttcWK3Pi/hPIRiEdjJOVZ/9MIyE
         KKLF/JfJOe2+UaQwmWp16EKZtktVH+lkCQerkmRCoXQvLdlCqF7xziove0utcjGgZa4z
         /gzQ==
X-Gm-Message-State: AOJu0Yx+iQOwtiVUrNzAjGG9PdacOW3l2o1/cmqS6lyHWh+4tUJJeu3+
        ryLKZVg7gvufLBNt66tIPaCREcGWifU=
X-Google-Smtp-Source: AGHT+IFExEzAwnAN2q/JHJnZccw5YCVhUDLIHTXaum63Wq3RKLNkOfHfRDG9DcahL0GDClJqz3ioFg==
X-Received: by 2002:a17:906:da8c:b0:9a2:139:f45d with SMTP id xh12-20020a170906da8c00b009a20139f45dmr26399033ejb.43.1697118965445;
        Thu, 12 Oct 2023 06:56:05 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id kt13-20020a170906aacd00b009a5f1d15644sm10966513ejb.119.2023.10.12.06.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 06:56:05 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     linux-pwm@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: brcmstb: Utilize appropriate clock APIs in suspend/resume
Date:   Thu, 12 Oct 2023 15:55:58 +0200
Message-ID: <169711894378.3084011.13476769649466212978.b4-ty@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175414.1738475-1-florian.fainelli@broadcom.com>
References: <20231004175414.1738475-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 04 Oct 2023 10:54:14 -0700, Florian Fainelli wrote:
> The suspend/resume functions currently utilize
> clk_disable()/clk_enable() respectively which may be no-ops with certain
> clock providers such as SCMI. Fix this to use clk_disable_unprepare()
> and clk_prepare_enable() respectively as we should.
> 
> 

Applied, thanks!

[1/1] pwm: brcmstb: Utilize appropriate clock APIs in suspend/resume
      commit: 4da07e8a22919fde057b554716e4c5a640d4d805

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
