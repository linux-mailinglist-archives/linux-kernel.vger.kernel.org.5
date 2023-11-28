Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E7A7FAF17
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 01:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbjK1AeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 19:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjK1AeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 19:34:12 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC9A1B1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:34:18 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5bd099e3d3cso2904739a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701131658; x=1701736458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYiTIXqRTDarNbi0aa1f81qxroNRuY69MIWNnPKjAyY=;
        b=Zj/s9vWMze0CQMyIflVTK3B3dxSeRg1P9NPpAdamgEcVQzPB+/KC5Bg0UH6DBrYjz+
         Cw9uwhTWfRln18EmUt4Rro0DET7kc4CoKcieM+nxU5Ge9irWUlRC8c10o2ffkuyspse5
         6qMsjsR0wydgD20oX3OOAvpvvrDhBusbtvndQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701131658; x=1701736458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYiTIXqRTDarNbi0aa1f81qxroNRuY69MIWNnPKjAyY=;
        b=btLmKdugEPs1NM3Y4u8noHlqAtbZVrf+U32+RBwuzfL5Bo/gI1xGLAltRpzH6Xn4LA
         Gu2lTWDrQP2eDXlRxF27SPWHBgRK3LeLc4KQz2LJHkCc4jWwRPGerrq3X7WpCCZxFR7c
         30DF+se2yJKijdmxsj19FD56lpWRcAyvWVImbo+sGvRuABULbKHry0i6iWE7ZbFl76+h
         esEJEKUNZ1mAFjf2ZY9COwCdKTwHT8GRMIB4Om/kGYPvBG5lUaEzSkwuXr4AwfT3gvCw
         bGwEaJFCecM74Rvuc7cxVVsXqT/qKlxUtTOq4bJurQ46vFTNjuL+DNusio3nKYFC/cib
         jMfg==
X-Gm-Message-State: AOJu0YyS04z5jjx3v0nDX2fKgF3u/G1DzKdROsYC3++flug/spn6Lo8x
        aPVfoicE6+GIDe2NX9OnGDCm3Q==
X-Google-Smtp-Source: AGHT+IE1qopXbd9oTJotAIwAhuzGIfmugcli9ua2BkHYosf3Vb/rPrjdoH2dQ3EIE9Fwv7Aw8jhVSA==
X-Received: by 2002:a05:6a20:144b:b0:18c:382e:48fe with SMTP id a11-20020a056a20144b00b0018c382e48femr11176362pzi.15.1701131658027;
        Mon, 27 Nov 2023 16:34:18 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 102-20020a17090a09ef00b002800e0b4852sm9214040pjo.22.2023.11.27.16.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 16:34:17 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     ndesaulniers@google.com
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: refresh LLVM support
Date:   Mon, 27 Nov 2023 16:34:11 -0800
Message-Id: <170113164796.1670732.18133777682518787773.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117-maintainers-v1-1-85f2a7422ed9@google.com>
References: <20231117-maintainers-v1-1-85f2a7422ed9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023 11:24:02 -0800, ndesaulniers@google.com wrote:
> As discussed at the ClangBuiltLinux '23 meetup (co-located with Linux Plumbers
> Conf '23), I'll be taking a step back from kernel work to focus on my growing
> family and helping Google figure out its libc story. So I think it's time to
> formally hand over the reigns to my co-maintainer Nathan.
> 
> As such, remove myself from reviewer for:
> - CLANG CONTROL FLOW INTEGRITY SUPPORT
> - COMPILER ATTRIBUTES
> - KERNEL BUILD
> 
> [...]

Applied to for-linus/hardening, thanks!

[1/1] MAINTAINERS: refresh LLVM support
      https://git.kernel.org/kees/c/9099184dec26

Take care,

-- 
Kees Cook

