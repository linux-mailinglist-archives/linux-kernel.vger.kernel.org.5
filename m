Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F7080268F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 20:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjLCTG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 14:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCTGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 14:06:25 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A817A1;
        Sun,  3 Dec 2023 11:06:31 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-67a9cba087aso21787596d6.3;
        Sun, 03 Dec 2023 11:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701630390; x=1702235190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ps6r7g84dej2iXkt9eKsvqXbWsrUKi3Q/Yryr1CTCAU=;
        b=F6wyskXGMMBePCsoWEYdvji8gix/8LxHALFr6sAa5QLW5b41HVvvH3txALkh5WenjR
         SxI9WISliAIdbbLsvKHjGXYpKdMzglZ0AGVgImQ8vcO9271d4aYqvT8zcfPty4dpz7PC
         qB1et7FKzepjiFCejt8c/HL9cbv2CjeRnwyNJAALGpiFCQsgM6BFKmY77+bluzYjhEKz
         r2oRvYXv+UqylQf9r8gmcDCyxIAqkth3jJR1Ur43jPt81AupovfzQfAMJNKaaYaCpvUM
         /eLe3aTj/0tqBLWzr2IiOyTkN5WR6VLvo/ibdxGXH9eKMAOZB5oh3yRoIaSKDxQbro4j
         tkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701630390; x=1702235190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ps6r7g84dej2iXkt9eKsvqXbWsrUKi3Q/Yryr1CTCAU=;
        b=D7RyxVkuYFhdYNhp5Z+aeQ8TxMBRjAAepIDOJQaifLeCs3USvT7PASrp/zVN924I/C
         +GEdE7lGPG9te0X3CtxYIORG2f/+LrMkhu2kj02gEe+h7gozwBL2xDXgdpU5q80zdp2U
         gmn3jbP67JPk5qUE3Xy7ImFB32dqapPEfJNBdufhbZkAuYeILY1lMoVTmXR0bkjbKrHf
         M4gekVvs/HJGkPcsCr7VA4sj5HKUfizUAynoXABfVk8iYGnI2RRou8L2uZ0hqbNqScPJ
         6aAIH4sHK3OW3+BhfyyuWTac3z9iiVldcwKKvoF3E7gDyRvym4jmBIDmSD74syKjjrcX
         BUbA==
X-Gm-Message-State: AOJu0YynQ5c5rC0P5EalzbnhLHMrCnQ4I3H83v1SK295QGFvWSv3clNj
        NZvvUhfeRoMCUcPxN7zH56trSZQUvjw=
X-Google-Smtp-Source: AGHT+IHSZbpgjuAE4pTErekVoiDs5F/pXk9m/mmWeM7SZhBaFZUCgVuf3SVJEUjW6pLgtj5I5fn6jQ==
X-Received: by 2002:ad4:4e4b:0:b0:67a:c636:179c with SMTP id eb11-20020ad44e4b000000b0067ac636179cmr859020qvb.37.1701630390150;
        Sun, 03 Dec 2023 11:06:30 -0800 (PST)
Received: from google.com ([205.220.129.26])
        by smtp.gmail.com with ESMTPSA id g9-20020a0cf849000000b0067a9e2d26easm2418097qvo.112.2023.12.03.11.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:06:29 -0800 (PST)
Date:   Sun, 3 Dec 2023 19:06:15 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Haoran Liu <liuhaoran14@163.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipaq-micro-keys: Add error handling for devm_kmemdup
Message-ID: <ZWzRp9xP66plWt1Z@google.com>
References: <20231203164653.38983-1-liuhaoran14@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231203164653.38983-1-liuhaoran14@163.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2023 at 08:46:53AM -0800, Haoran Liu wrote:
> Check the return value of i2c_add_adapter. Static analysis revealed that
> the function did not properly handle potential failures of
> i2c_add_adapter, which could lead to partial initialization of the I2C
> adapter and unstable operation.
> 
> Signed-off-by: Haoran Liu <liuhaoran14@163.com>

Applied, thank you.

-- 
Dmitry
