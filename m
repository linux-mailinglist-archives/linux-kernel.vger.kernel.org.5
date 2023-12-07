Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E138C808A90
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443181AbjLGO25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbjLGO2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:28:43 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7E919A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:28:48 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3332ad5b3e3so1007806f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 06:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701959327; x=1702564127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=siQf2yGcuKbINax/017dn/aIzi9vyOaDmow1c81WvIo=;
        b=dppiFzHNRvBHRoMiYi5jk2GzYB6GsoLQTdKJ8dCLkQgVj5pm/StwLPvc/nnYv0d/EL
         w/CqYxrhNHT45sm5pI0Dm/V897m0gXFbtA5BOW79lq6gbaOprwMMNr+ZpiUlyxBA1epf
         enfAioD9O8sUIfX93D/6n/laxLPhhvImvznstwJ4f+1iUe4+AuKA4TSAbzLq45CH40mc
         AFX/k46CP6opKA9vGgt9DiAfkW0B/rfu3o2wffoPa1k9s8cveQczvLfzTv/zQaM3xh9u
         4b8Ls4AmS+Ge9WEVnBz+YD2SZ7u3BHCAuzXu9aSoqCrxTNavD5Ol20q4+KgUcbvWRbIt
         G81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701959327; x=1702564127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siQf2yGcuKbINax/017dn/aIzi9vyOaDmow1c81WvIo=;
        b=undPFg1ldS51nE4apR6xj5AkAyx3ubr9m7NvDz2VYw7x7Hy1acQenHL+zhUnokr1LZ
         9i0uYy2v1bJYUUWePziVLyBrUVne780iM5H2ArKtGADTVqVHIPjRmnXfg3jyMRCfg05B
         6hPZaWm9w9My8jAod5IOpMYacIqnoNUaawzMPkNYSJJMzhPihfoQW191eGUTkraC/1+6
         HXmHBOfNuytJAMoWV344I0/B7D6+Um39Q7tEMQrtX1hKecuR9SYdZNFDb6QY2cFNA9Ag
         cvCzC1Su77rgdDkwt8naerHOLQCKW5sU6L87zacpDphQa5oluLrVUb7l/rF1MxjTPQXe
         RMog==
X-Gm-Message-State: AOJu0YzfhHMtWTgaoT9VzfgnpIa4h/dGSz19UsGwPD1oEx30yNmIp4RK
        CF4whextk3wY9n06bkzVCpPZMA==
X-Google-Smtp-Source: AGHT+IG3fjLcVnbgN/JM62HKhQ/CpsfIghOkkqs4Bf6SrVZBPi1Z/DUH73yzVRZSk42YeYyrPH8xFg==
X-Received: by 2002:a05:600c:a43:b0:40b:5e59:c58c with SMTP id c3-20020a05600c0a4300b0040b5e59c58cmr1686676wmq.182.1701959327359;
        Thu, 07 Dec 2023 06:28:47 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id b16-20020a05600c4e1000b0040c310abc4bsm216659wmq.43.2023.12.07.06.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:28:46 -0800 (PST)
Date:   Thu, 7 Dec 2023 14:28:44 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] backlight: ili922x: add an error code check in
 ili922x_write
Message-ID: <20231207142844.GA151182@aspen.lan>
References: <20231130051155.1235972-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130051155.1235972-1-suhui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 01:11:56PM +0800, Su Hui wrote:
> Clang static analyzer complains that value stored to 'ret' is never read.
> Return the error code when spi_sync() failed.
>
> Signed-off-by: Su Hui <suhui@nfschina.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
