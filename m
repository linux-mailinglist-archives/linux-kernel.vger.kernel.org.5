Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6D97A1C62
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjIOKhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjIOKhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:37:15 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B9598;
        Fri, 15 Sep 2023 03:37:10 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68fc9e0e22eso1620273b3a.1;
        Fri, 15 Sep 2023 03:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694774229; x=1695379029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P4ds4tKoxDi1WpvGio9GUdU3sq3b3qDljaVA0FHFc8M=;
        b=kewJKZUwKpad8jGWOOzF/JfgAQhPaNhFPXiwnmtMNfbIrP7VDgG1fvxLlH9idVSRiC
         Bx+UmtgzxgJPDXUuIgf4LAO59f+RilQWqqWbkLGP/pDm3OpQhALXGT5x1yu/uugfFRaY
         ET7n1PjZOkHRuQl9xmjsmw1GSQgfyTGzHhUAoGPU+6DlSo/vQ6E69LuozfVywI5LpU1i
         O+jT17QyC773iZRCnyi0Ig3k53uBcisrgbgePimMG9S3m461VK+3EErM1ANoWYCeiVMh
         aEIUtH3YPVXNWlFLqa2lSxPupMPqJZoDnJFjy5eekW3PBS8pJD5Albxrzz/sjjt81Vrd
         wBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694774229; x=1695379029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4ds4tKoxDi1WpvGio9GUdU3sq3b3qDljaVA0FHFc8M=;
        b=Nff4jUgQ7zqdAgdtTiCDqkJvVK8MAq0tFe+YHllC3Jb4FIoWYsCUAghRa8pRy/FSXI
         OxLD7ab9L61+3fppYBrKCa5IdCurHt/1WGHG6CtYLmxmrO0xGFLv4thoZEijMoazNWPe
         IEDih41ghuP5o4YhFDtNEJ5Zv+qdGjYwiryh6W9Cw/grx4kALMLL++kdqa49IT5AaGQw
         vVnEo1zTIT0+cmFNhD/Ou+PLlmPV7O1/vBTVYgdCNDEFypjXXXmmSs4eAAp9/2yYqepa
         4IY5cSZF0HbpZTiaD3OxuEwEl6RNeJyhFE3MR+z4EreHWOoB69SNJg8xDG66B+2IKKB5
         cfAg==
X-Gm-Message-State: AOJu0YzqWE7Ba0YRibyunC8MDj6uaXi1kqezlC1On8C9FWmPAfeJyRMj
        nYFck1Q87U6ezI7bAuWlOvg=
X-Google-Smtp-Source: AGHT+IG61pm+/mU18Ba0gOwzZK6k/3C3Eu2EnyFnfGOpxg+NhXyJjBWOytdYUwdFf2an/DLNG6Kkiw==
X-Received: by 2002:a05:6a00:22c6:b0:68e:4587:3da9 with SMTP id f6-20020a056a0022c600b0068e45873da9mr1158961pfj.17.1694774229408;
        Fri, 15 Sep 2023 03:37:09 -0700 (PDT)
Received: from gondor.apana.org.au ([2404:c804:1b2a:5507:c00a:8aff:fe00:b003])
        by smtp.gmail.com with ESMTPSA id m30-20020a63711e000000b00573db18bca2sm2539650pgc.33.2023.09.15.03.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 03:37:08 -0700 (PDT)
Sender: Herbert Xu <herbertx@gmail.com>
Date:   Fri, 15 Sep 2023 18:37:07 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        alex@shruggie.ro, Jason@zx2c4.com,
        bcm-kernel-feedback-list@broadcom.com, sbranden@broadcom.com,
        rjui@broadcom.com, florian.fainelli@broadcom.com,
        olivia@selenic.com
Subject: Re: [PATCH] char: hw_random: bcm2835-rng: removed call to
 platform_set_drvdata()
Message-ID: <ZQQz0+KJlWvbs0jh@gondor.apana.org.au>
References: <20230823111555.3734-1-aboutphysycs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823111555.3734-1-aboutphysycs@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 02:15:55PM +0300, Andrei Coardos wrote:
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Also,
> the private data is defined in this driver, so there is no risk of it being
> accessed outside of this driver file.
> 
> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---
>  drivers/char/hw_random/bcm2835-rng.c | 2 --
>  1 file changed, 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
