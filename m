Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F577B3A90
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjI2TVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbjI2TVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:21:17 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E001B2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:21:15 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c1ff5b741cso130915505ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696015275; x=1696620075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzGyz2MPegojcnBn3+M4x1lpZordUMqcBYgQWes42EI=;
        b=cjEDcDkx7oozzvxWRNlkQwz4XXgaEPYGcMt4O9l7/dyXVt5/lMn84w51s8BcHGwfCP
         4/hZ33IJIk1y4HqztKbCfTjouU+fzycpP+I07j4DyGyBqCHodemrAhdNjhviwQewvge1
         xFX8GKBbvxxpTYVb/uQkCorPtuPATJYlDu5c4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015275; x=1696620075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzGyz2MPegojcnBn3+M4x1lpZordUMqcBYgQWes42EI=;
        b=vuqpX6Rz7RqNbIAuPgn1UglSwX19xBj8+kSt8yLjczqPE18wbJIYGe11TTUUrbZcc7
         MWijhvZuEpKLlXKrPjjsTrMJjiicjI5MNWu0EQTmUXg67/Pq69MqjZRXzj/E+U8pDzcE
         EQdGEVQpdu5lm3NXmo0JdbH1vrDl0r1cVQgI6uxHqWrQMcazuql+dyvuAztK9bTEmQaT
         6Jetqql/yORI26kn3vAdy5Lgefnq0uZStr8BYvXnQuKcDZgu9hv5Hp+riETXdqPfNTtD
         ffgND/heX4nX1xbpeqS5njEf3KGyhARsruTzpEg8492zZFN5BFIO0sdJMJPEw1HKSKJP
         SDkg==
X-Gm-Message-State: AOJu0YzdugSZ2T4jOCoyAQKBFDLL2eHhOtpt+QyQIPUxNakWgPBsg4Ay
        xEGjJjkxBGog3469WHKGWdjCEQ==
X-Google-Smtp-Source: AGHT+IFjwoljz7qSuEmgrS2IYGOuTuCN7jnbI2kAUszFu5hBRn1FsFvHLdskqcLbQYPnmal7cixZdg==
X-Received: by 2002:a17:902:d30d:b0:1c3:3b5c:1fbf with SMTP id b13-20020a170902d30d00b001c33b5c1fbfmr4888238plc.10.1696015274991;
        Fri, 29 Sep 2023 12:21:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902744a00b001bc59cd718asm11031537plt.278.2023.09.29.12.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:21:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>, Kees Cook <keescook@chromium.org>
Cc:     Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] dm raid: Annotate struct raid_set with __counted_by
Date:   Fri, 29 Sep 2023 12:21:07 -0700
Message-Id: <169601526974.3013632.14322525126930729466.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915200335.never.098-kees@kernel.org>
References: <20230915200335.never.098-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023 13:03:36 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct raid_set.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] dm raid: Annotate struct raid_set with __counted_by
      https://git.kernel.org/kees/c/588cd9b20862

Take care,

-- 
Kees Cook

