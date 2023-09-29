Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B837B3ABB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbjI2Thf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbjI2Thd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:37:33 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3161B6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:37:29 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690ce3c55f1so11531053b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696016249; x=1696621049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ss65P0lXSqzHkUmO/JhleEGBdIvRYTwXfMVQ4cN1Xig=;
        b=SngaIz63KZSwTBz1gy47JDDQ/JlewmYlswaoebnTmTf5q73Clm2NlEt2ujQtjP+xEl
         Ofvef51+mQ9FVixNVtvM5kPw9r2rcQ7kH+cfgBxFCITdTjp9sLaO1EHqMtbl24Ur+Bo4
         Rskg7gVEU5sYBsJ+h0ovuRzSHoP3clJPHUSfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696016249; x=1696621049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ss65P0lXSqzHkUmO/JhleEGBdIvRYTwXfMVQ4cN1Xig=;
        b=uqnIcEqKxhl6M4Q4ZpoTBiTSOOzfpH5hVeqG6xNHzJG43GDcGeaU2QSq0huc1NTy1Z
         D8KSFplHdzCu5YZNBsEnutvxtDTvjTTjc+poeYnq2LqeP+HtVF0/VakDNQKqtn6nhp7x
         /OMVAqoesJv8Ao+o8Cbfxj8QT1GS998sao8MQ4mhKemeuv3gpLxmVu+HQD2hFvfJJagL
         bB7G4U1gcCRmDjL+bx+nWFQ79CugiQPoKKCxDVxqBVSHuJzGMEALYPDHde6/fbbCJB5K
         yFxRyfE05AclVOzH87qUW8SClBnz1pfYY1leq0P4zNyMjRPxfaKiDiMJzEdxlxWE3gjB
         +GBQ==
X-Gm-Message-State: AOJu0Yxcqx+BrsebSE0jQXPOwJhnvD3iTtHmn24u+i78I5PAcEM3StCb
        2EJOe96l1zDc6Z4YS456jy3n6PIkUE9d3A4sGRk=
X-Google-Smtp-Source: AGHT+IGFvyTd654VGOEd4QzTk2oJA1lmcFCtL++Z/vAMyBSOR1XO2UHlo8aZw97smjkuf4IZUfFNjA==
X-Received: by 2002:a05:6a00:189b:b0:690:422f:4f17 with SMTP id x27-20020a056a00189b00b00690422f4f17mr5453667pfh.4.1696016249046;
        Fri, 29 Sep 2023 12:37:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p5-20020aa78605000000b0068ff0a633fdsm1326147pfn.131.2023.09.29.12.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:37:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Karsten Keil <isdn@linux-pingi.de>,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] isdn: replace deprecated strncpy with strscpy
Date:   Fri, 29 Sep 2023 12:37:26 -0700
Message-Id: <169601624548.3016093.1290854393358505827.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922-strncpy-drivers-isdn-misdn-clock-c-v1-1-3ba2a5ae627a@google.com>
References: <20230922-strncpy-drivers-isdn-misdn-clock-c-v1-1-3ba2a5ae627a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 11:58:06 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect `iclock->name` to be NUL-terminated based on its use within
> printk:
> |	printk(KERN_DEBUG "%s: %s %d\n", __func__, iclock->name,
> |	       iclock->pri);
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] isdn: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/a9b065a6751b

Take care,

-- 
Kees Cook

