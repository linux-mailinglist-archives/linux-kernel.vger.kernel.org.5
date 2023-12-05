Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0510B8057D0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345701AbjLEOpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345579AbjLEOpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:45:18 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8547FCA;
        Tue,  5 Dec 2023 06:45:21 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d04c097e34so32497955ad.0;
        Tue, 05 Dec 2023 06:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701787521; x=1702392321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jL35IHN53r+yIpqXLtr4T8Q6V/zjPn7x24AFOh/NSio=;
        b=k1gQpW/nHX4iMMsMMKZi8sh9WD9Fv5us17y6GqrTJE7kLaEnGxwS88itX6ETW93oaU
         aeXW+uU+ZzOYqiwbf51L2mmewTXCiLj8UUpa44qlgZbi5aWcNmbdHVVueS3me4AUHcNR
         rIkbB3Q2rkXe2kCkUYoaOm/BlW2IZaFn0EXUhMnz9fXF1lwru47/mywQpbj/IAZITXEk
         LhDY6PwoNedauDgXyft6VW7ngj4JFZA7/mOWQZb3SgBiT8LbKBmWu7L5+eXSWj3Bgn/S
         Yg/QyXAR0Gz02xaaLJ+SmP7lttWPiPJMiYfXBmNZ56wReIOGbg690uxiZ2AUbyWzEWwV
         w2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701787521; x=1702392321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jL35IHN53r+yIpqXLtr4T8Q6V/zjPn7x24AFOh/NSio=;
        b=Hh0aeEO04oVFkEGvDtbatcDR63f8wRL2befdgjEh/IJ9t/TpPvDmLxN2NS8rFMQPQZ
         +gz6K4ikgpzRUBgzkp4eJ3LG64kYIuAhEFrxKgiWQrKrZdZYMlvFPaBQpdlnwMqlRSTg
         agEkmDAcbZC8gQzQuSLMqJDEGA/AOPsFjSgsvMgr4y6uNGcd2VP2bYo91FyUMuPQj619
         Hh/ZtyCE7ODrGKQE9JJWpXbtx32TeHQTVzHuK1H6JiP43MoDh75dpOHagAvOtADCwcvz
         CZstBKZ10dyp9sQco3kqlt9k7TBLlGSXQ3ge7SUAP3ADhtQ9j8yCqurtCTiZhxZs5rRq
         FOQQ==
X-Gm-Message-State: AOJu0YyD2w5AUuMao3UuKSlDGhxvwz18pLkishDfK2WItEq778LVGAUD
        L5tuM9+c2kqkH5BnIzapm8U=
X-Google-Smtp-Source: AGHT+IHi73NcFPEehZyVYhe4vLmBqNqcGqTBJqX4RGqVyorXx9NoZtlNxFyM6o1tF/FI64lhMduWyg==
X-Received: by 2002:a17:903:41cf:b0:1cf:59ad:9637 with SMTP id u15-20020a17090341cf00b001cf59ad9637mr2125975ple.22.1701787520951;
        Tue, 05 Dec 2023 06:45:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jm1-20020a17090304c100b001c5fc11c085sm5797913plb.264.2023.12.05.06.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 06:45:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 5 Dec 2023 06:45:19 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Cosmo Chou <chou.cosmo@gmail.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, heiko@sntech.de, jernej.skrabec@gmail.com,
        macromorgan@hotmail.com, linus.walleij@linaro.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        cosmo.chou@quantatw.com
Subject: Re: [PATCH 0/3] hwmon: Add driver for Astera Labs PT516XX retimer
Message-ID: <2a6beed6-c530-473c-8c4d-c29f7a4f5822@roeck-us.net>
References: <20231205074723.3546295-1-chou.cosmo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205074723.3546295-1-chou.cosmo@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 03:47:20PM +0800, Cosmo Chou wrote:
> This driver implements support for temperature monitoring of Astera Labs
> PT5161L series PCIe retimer chips.
> 
> Cosmo Chou (3):
>   dt-bindings: vendor-prefixes: add asteralabs
>   dt-bindings: hwmon: pt516xx: add bindings
>   hwmon: Add driver for Astera Labs PT516XX retimer

Please refrain from using wildcards in file, variable, or
function names.

Guenter
