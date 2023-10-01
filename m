Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFE07B49A5
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 23:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbjJAVF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 17:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbjJAVF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 17:05:56 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94C8BF
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 14:05:50 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso1698486b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 14:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696194350; x=1696799150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oPET9w0ktAjq+TgFKzzsSU899+RQr2NesK2FVmHe4kw=;
        b=hfQm/i2c3iIU6NuDvBvdAwDcI2x6tSxTZDkToKU5jkDdjFSSCOstKg0ihGXLm7fTzQ
         VdLnCATCoPwOsnDceiE4gi0zT4yc7hTroxnRJS/k2TBqjc6+h5xMhJraaDGR8dIkzLr7
         Kd82n8lq/zAIiV/3VGo+BrjoXUMGW8O+w+Fb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696194350; x=1696799150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPET9w0ktAjq+TgFKzzsSU899+RQr2NesK2FVmHe4kw=;
        b=RbX4LR82Dnq35UbLe0sbGIRu6/1RrRnIFy2nZ9hjdmcKcqXYm21Rqe2wua04v1zjQs
         nchJehcz2kXOnVkBiUrvE5At8eLL68qtUuni6OA443UFWK3XzujGkRcSlMD1b7PeeOSj
         pNt7Bw7GCpPgLmiltunOREsmJPVoDAZy/ftwH9FSOCmhFkd5VfJm+0nL/rRK2I2eKnQQ
         HqnnEBKFMBlzO6wEFJ9E72G/7Fn24MD1+SqCkozaurx7y9yHrY3S4+zQpcXadRCzUhRC
         DVu3CNAw/jtFegNASHwhrMKJMM8FNuyrlybj2cNXuCye9K+IUu88HLw1CcMwERLMW8V0
         +0OQ==
X-Gm-Message-State: AOJu0YxNbXE/0+Kc6qXTFBB1EGswVbS4AGzLUBfcT1TduwDqAlYzl/Gw
        kgI7jBkBaTaJZmgluUYdZhgG8g==
X-Google-Smtp-Source: AGHT+IH3XCX1bFhdggGosLrTWDSZbda+DgRtjDOd4Jr02++pIlTQr7eU8vyMgOL14EARFIWEhjY/yg==
X-Received: by 2002:a05:6a00:1886:b0:68f:cc67:e709 with SMTP id x6-20020a056a00188600b0068fcc67e709mr18341051pfh.16.1696194350427;
        Sun, 01 Oct 2023 14:05:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u7-20020a637907000000b00584b293d157sm9552553pgc.80.2023.10.01.14.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 14:05:49 -0700 (PDT)
Date:   Sun, 1 Oct 2023 14:05:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Kees Cook <kees@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] comedi: Annotate struct comedi_lrange with __counted_by
Message-ID: <202310011405.7599BA9@keescook>
References: <5c3b7459b820e22e2ac6ce892d4aadcc119cc919.1696065263.git.christophe.jaillet@wanadoo.fr>
 <202309301342.5B5BED40A1@keescook>
 <alpine.DEB.2.22.394.2310010945130.3166@hadrien>
 <90E2BBA5-8A2D-42DE-B36A-CD37BABBB433@kernel.org>
 <alpine.DEB.2.22.394.2310012112560.3166@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2310012112560.3166@hadrien>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 09:14:02PM +0200, Julia Lawall wrote:
> Kees,
> 
> You can try the following.

Cool! Yeah, this finds the example:

drivers/comedi/drivers/rti800.c:74: struct comedi_lrange: field at offset 0 is the counter for the flex array
drivers/comedi/drivers/rti800.c:83: struct comedi_lrange: field at offset 0 is the counter for the flex array
drivers/comedi/drivers/rti800.c:92: struct comedi_lrange: field at offset 0 is the counter for the flex array

I'll run it on the whole codebase...

-- 
Kees Cook
