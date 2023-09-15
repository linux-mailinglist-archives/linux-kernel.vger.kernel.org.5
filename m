Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AB17A1C72
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbjIOKig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjIOKid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:38:33 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7B410C3;
        Fri, 15 Sep 2023 03:38:09 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c3bd829b86so17009405ad.0;
        Fri, 15 Sep 2023 03:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694774289; x=1695379089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h06fZUjwiGo48JTYiY1T+teTox9j5L/0X7RHl5iTRsE=;
        b=WJyRksGm8iaF1dUuiYGwkNGcUPl4WUYtaKT4oHt7eP18mjKLED96hw6fcHs7iAoKa1
         faU4z9zoiwgpbI5zlHj81tm0hSBsMAzI05L96+TZKdb23emeWeyI85AEmP8oh+UUHm/F
         G30WJpiPbXcnluY5ze9b1vtThmmmuG3DHeHyclfOmkNGGxw5/PDGHpNJWRPzKcqtKihx
         SGoguaXGkOazBt8oMIt9oLPNjto6YAEbpeWAlauY7M57xzV5AodJMM8oT3pM8kyMDi3j
         GDBE9hjUpWA4izeQH1/JdFswURJ5DUEYUYCEOIOua8uIjHU7SQ2NrR5wqMYbZo/8s6Y1
         x2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694774289; x=1695379089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h06fZUjwiGo48JTYiY1T+teTox9j5L/0X7RHl5iTRsE=;
        b=xNdzZHcFCy1+IppvRQqe+n7rgoHABx7nc1afGR/5RObLmxTH0F3KitiaDwrpUCS27l
         0UhBxynQl0RNZ3Zv32S3WzK4Ly5glitsBMaqEtGxLuDgBD6IdrVm6Vvx5FJSCLIHGR8Y
         HXLI4OyQrhjr5gIFTPwkSPj934bpDz+Eec9Qw76gE/J+4SN4oEI1pIJwAxdIdF33yob2
         KcpMYvmIiQ9/CErG+OQMlUvQfLD+juHD7oI+UBNm4rtC95IJK00KZAjKl+wUCwYXqSmN
         s5LS6eEq75zGrKB3SNWd/34Vl47oU4Hqh8NdA5Z5aNYS3/B9s3Ie8GFAG3ev+sKr3ux/
         +Jjw==
X-Gm-Message-State: AOJu0YwgQvUXIcIU/gVcENiafA4fGlGKz7ORNvyD8PzvGWrKwKqA5NAo
        CyJ7xd+8h46AB6hF3euCtBo=
X-Google-Smtp-Source: AGHT+IGF2MKTWUpSvo+l5EEmTKLrM/EOxGpA52GVPYRF0w+eP+hN1+VeQDG1wYgBDOGBQFPPLodc8Q==
X-Received: by 2002:a17:903:2345:b0:1b2:5d5b:e871 with SMTP id c5-20020a170903234500b001b25d5be871mr1249171plh.59.1694774288629;
        Fri, 15 Sep 2023 03:38:08 -0700 (PDT)
Received: from gondor.apana.org.au ([2404:c804:1b2a:5507:c00a:8aff:fe00:b003])
        by smtp.gmail.com with ESMTPSA id z3-20020a170902ee0300b001b88da737c6sm3178198plb.54.2023.09.15.03.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 03:38:08 -0700 (PDT)
Sender: Herbert Xu <herbertx@gmail.com>
Date:   Fri, 15 Sep 2023 18:38:07 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-riscv@lists.infradead.org, alex@shruggie.ro,
        olivia@selenic.com, daire.mcnamara@microchip.com,
        conor.dooley@microchip.com
Subject: Re: [PATCH] char: hw_random: mpfs-rng: removed unneeded call to
 platform_set_drvdata()
Message-ID: <ZQQ0D25jsa49+jkx@gondor.apana.org.au>
References: <20230828101757.9724-1-aboutphysycs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828101757.9724-1-aboutphysycs@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 01:17:57PM +0300, Andrei Coardos wrote:
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Also,
> the private data is defined in this driver, so there is no risk of it being
> accessed outside of this driver file.
> 
> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---
>  drivers/char/hw_random/mpfs-rng.c | 2 --
>  1 file changed, 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
