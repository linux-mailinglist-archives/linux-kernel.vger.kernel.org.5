Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163BE790838
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 16:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjIBOQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 10:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjIBOQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 10:16:27 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F047710F0;
        Sat,  2 Sep 2023 07:16:23 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-564b6276941so2053098a12.3;
        Sat, 02 Sep 2023 07:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693664183; x=1694268983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILnvJJT9+fmVmqH5xN+Xd9akiVGGKHTUTZaVtrSV1L0=;
        b=XwFujQadO91dcKFkU+1DMhU+E23ZMgEwR6qen9OeNa4mh5Yq6LqLFN9s6SzL7GA7AN
         fWkXVxHFji0NmTxeEygMk7tam/Qnf3bLhpMGfL8HGAhjXj0mIaYKOKPIk7E/r3kZTKE5
         mQwLZAItkC7ZnSwzEdNyL7OP2GQ7fQ7CdS2KQgE6ITMZG+a+Te8D1I0AeeAqKaeRS/5R
         96OVcBLqufhC7W3Lic1O9wzAkJH7GOsv+xchoC6Auu4YpUkjqyDjuON929TK9Ti+c0yh
         8zYI8RYymkIEPvBwUQjsLJJeaL6PaDt0Wrf+T2BjqQDOJ4IsttSHe+rzGDI8XNwv1N2v
         qc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693664183; x=1694268983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILnvJJT9+fmVmqH5xN+Xd9akiVGGKHTUTZaVtrSV1L0=;
        b=YIIEptqc3qZAFJWo9rl1t0iiUZ1YPTT84PurrhruvjLzHNLG7dBt/E7NYPJQp8Mo9x
         m3sNJuE+DS2QomiqqwAPQIi+FHfAmVMB6BHYFo+0qj6WpLD10d5WH0tRxx3Hgtn9Z4JK
         yDQXSBhjoAe15Ph3RGBxBSbpVGwpJG0NIuLctufG/j32XpzSgMsliiSyCo3/nbjHpLUv
         r5o3I/70NDh6NWRoXI9EPehdvxQIccTxb7bAoQfMBydM9GlXcxY5GaUhMukEFiPURI/9
         xnp7gWXMIZDA0bLDJJFdnuRjA5lQG8V2xT8qrVBsiASPfDlp3eeZxs41+8tGYIprbXHx
         ei9g==
X-Gm-Message-State: AOJu0Yy6ns6Cf6x/SFVfWLZBoAHwOFe31E8z6TnPoEFaWujxHI4mPb2B
        9X4z3vMpj8/SJFbKsl9ZN/jZclzscKI=
X-Google-Smtp-Source: AGHT+IHlQkZe04iRQtj1KxqZ1PSL3uHEtInXdNJanNVsUZMk/cDnFk0lrzBWAs50KwVWVqmR1g1/+A==
X-Received: by 2002:a05:6a21:3d83:b0:14c:b58e:6d6 with SMTP id bj3-20020a056a213d8300b0014cb58e06d6mr5108196pzc.32.1693664183300;
        Sat, 02 Sep 2023 07:16:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 4-20020aa79204000000b00687f845f41fsm4614853pfo.119.2023.09.02.07.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 07:16:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 2 Sep 2023 07:16:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] hwmon: (pmbus/tda38640) Add workaround for SVID
 mode
Message-ID: <833a4908-6bc2-4b66-9ace-4beab186e634@roeck-us.net>
References: <20230831190731.265099-1-Naresh.Solanki@9elements.com>
 <20230831190731.265099-3-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831190731.265099-3-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 09:07:29PM +0200, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> TDA38640 can operate in either PMBus mode or SVID mode.
> 
> In SVID mode, by design ENABLE pin is the only option for controlling
> the output rail i.e., ENABLE pin is chained to power good of another
> reglator & FPGA.
> 
> In cases where the chip is configured for SVID mode, and the ENABLE pin
> is set at a fixed level or is left unconnected (with an internal
> pull-down), while requiring software control, the following
> workaround is necessary.
> 
> The workaround utilizes ENABLE pin polarity flipping to control
> output rail.
> 
> If property 'infineon,en-pin-fixed-level' is specified then
> determine if chip is in SVID mode by checking BIT15 of MTP memory offset
> 0x44 as described in the datasheet.
> 
> If chip is in SVID mode then apply the workaround by
> 1. Determine EN pin level
> 2. Maps BIT7 of OPERATION(01h) to EN_PIN_POLARITY(BIT1) of
>    PB_ON_OFF_CONFIG.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ----

Applied to hwmon-next.

Thanks,
Guenter
