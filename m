Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF8E7D5D1A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbjJXVTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbjJXVTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:19:16 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB60F10E7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:19:11 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c9daca2b85so1636845ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698182351; x=1698787151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+cZiVId6MMrE0VNYNpV7bLYZrEWEZQeY5gw9zkpQIc=;
        b=TK6KIaPk3kelv3Tf5tWtx4WGjOBwy5AthpB3IIGdV/cHAkbO2JdenbHmCUmED/FlYZ
         nAbHS2reyJzkkf1roTmiMyjgnxzVUtvthmuvdtW79Lc1CjiRYyweoyhYzrePggxxT6ql
         yayGsFDMampYkm1xfTjkhSE1rbqMKBR18ELTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182351; x=1698787151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+cZiVId6MMrE0VNYNpV7bLYZrEWEZQeY5gw9zkpQIc=;
        b=KwXi1b6Uv8Q06yMo1Mu65dEE4Oenky6Q8mukNOKoeTM/xDctX9SWIcJUj6YZ9x4Gz1
         7ygmjr99pH8+1fVYakSs6G7CJlZSltDMJR441CvM66AIy34VW5FWI0sgThaqNUjKbYXR
         2Q/hsc9XRfx3BUog9d2eEDEIHgYaTIWjMK+EZX9qD+lRUODCRMZD29n8HeFwDsB+xYJ8
         XTrg1WJVKdVcNVyXZ8hQlkfLjIYEvbNdCP0koLXoGnjEFFg7bRS8H3tyU9ZCXhKdm2ys
         dNOHgAzqzn06NQo/caQU1BIOqlzskaK4vvUwcpFci5VToPKl6U6pKJYHkuqOO+aVRD0V
         5vuw==
X-Gm-Message-State: AOJu0YzOS5JXMZ1MJ9JgkXSILDWYZtuEbm/u6kV5I45WcsPG18Wysm3F
        pvv6CjIrZdkdNPXX3sgj282bnA9lXFRmmUwTEqU=
X-Google-Smtp-Source: AGHT+IGjL3fm2X2hvJcIZ8vhkMxJoeoI99wJ8vtRUXaY4HddAxAKijf1XivLedwDrIyKkSWlkqxCEg==
X-Received: by 2002:a17:902:dac5:b0:1c0:cbaf:6954 with SMTP id q5-20020a170902dac500b001c0cbaf6954mr19334024plx.25.1698182351138;
        Tue, 24 Oct 2023 14:19:11 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b001bb892a7a67sm7860951plf.1.2023.10.24.14.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:19:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Amit Shah <amit@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux-foundation.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] virtio_console: Annotate struct port_buffer with __counted_by
Date:   Tue, 24 Oct 2023 14:18:56 -0700
Message-Id: <169818232963.2100071.8744701530771099437.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922175115.work.059-kees@kernel.org>
References: <20230922175115.work.059-kees@kernel.org>
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

On Fri, 22 Sep 2023 10:51:15 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct port_buffer.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] virtio_console: Annotate struct port_buffer with __counted_by
      https://git.kernel.org/kees/c/bf5abc17bc43

Take care,

-- 
Kees Cook

