Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756927FAF18
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 01:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbjK1Ae0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 19:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjK1AeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 19:34:25 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EE31B6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:34:31 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2858ae35246so2505268a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701131671; x=1701736471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GcVqTQw8m82AWs/bM0FSCPyGHvrEjXN+2g9CIkLzcQ=;
        b=GNluDj37zVD74g3JJOgPYd9rlpNSH7h+hKQOozL1J0TQaVqoD+kNBgdWiV/YNosUm1
         GzMdFn3eobA83BvJJXL6Zg2h09SIbY68byaxgp0GfVVZgCXscg4kaYoJXLaeQ5fgFd9D
         UgO/Gc6ZcKwTkdv6LOo8oFu4VStkK/TH+GVE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701131671; x=1701736471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GcVqTQw8m82AWs/bM0FSCPyGHvrEjXN+2g9CIkLzcQ=;
        b=MfisO1LO4mKIB/i1ma/m55CRcZD5x/3xaHKxWVcHFws2BDzzpKxkKFgh4uUH3cDLkG
         0RwYAg5x3rlABb658MU9su93x8bZZsT8qRqtRWsZcGR905bwS30Id9+0bnPEDfyjpfj2
         kwTCjZiNPqtVYsTdewAxKXrZKfx7yMUk1SdylP+53B44uwFOLmC63iiZ0Y3m/nj4pt0K
         iVce+jzL2OoPrHd8WATHWa10Nu7+OuYLRevL4EmOPK9EfzjrrYN4j6fwo3mvDr59IQ1S
         DjbT2aXUhRY8fLJxTVqROyHu/SDE3Sn2SxVvM/xPvSf124exGUjENiHtk4jz6qM8VA1x
         yUAw==
X-Gm-Message-State: AOJu0YxDfAO73j4XFrXtWHVMP6hzm47SBENsuuVvsgtOb24Ihv1VvLYy
        m+TE7C6YZQc0nbBIbVbTDidEEQ==
X-Google-Smtp-Source: AGHT+IEg9YpgUHIsAkHdMiZvyAgRVEYWc790jPMLYF5li9yRb7+pLe8zebCBHBpg3vbwButtn+Zb/Q==
X-Received: by 2002:a17:90b:4ad0:b0:27c:f80a:2c8a with SMTP id mh16-20020a17090b4ad000b0027cf80a2c8amr13008909pjb.0.1701131671211;
        Mon, 27 Nov 2023 16:34:31 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jk8-20020a170903330800b001cc31dcec49sm8903085plb.146.2023.11.27.16.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 16:34:30 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Will Deacon <will@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] uapi: propagate __struct_group() attributes to the container union
Date:   Mon, 27 Nov 2023 16:34:27 -0800
Message-Id: <170113166294.1670814.14494797449586768583.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120110607.98956-1-dmantipov@yandex.ru>
References: <20231120110607.98956-1-dmantipov@yandex.ru>
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

On Mon, 20 Nov 2023 14:05:08 +0300, Dmitry Antipov wrote:
> Recently the kernel test robot has reported an ARM-specific BUILD_BUG_ON()
> in an old and unmaintained wil6210 wireless driver. The problem comes from
> the structure packing rules of old ARM ABI ('-mabi=apcs-gnu'). For example,
> the following structure is packed to 18 bytes instead of 16:
> 
> struct poorly_packed {
>         unsigned int a;
>         unsigned int b;
>         unsigned short c;
>         union {
>                 struct {
>                         unsigned short d;
>                         unsigned int e;
>                 } __attribute__((packed));
>                 struct {
>                         unsigned short d;
>                         unsigned int e;
>                 } __attribute__((packed)) inner;
>         };
> } __attribute__((packed));
> 
> [...]

Applied to for-linus/hardening, thanks!

[1/1] uapi: propagate __struct_group() attributes to the container union
      https://git.kernel.org/kees/c/4e86f32a13af

Take care,

-- 
Kees Cook

