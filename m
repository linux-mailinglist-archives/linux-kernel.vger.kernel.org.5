Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC053801755
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441870AbjLAXMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAXMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:12:24 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C6E1AD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 15:12:30 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77d8c38ea78so146893785a.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 15:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1701472349; x=1702077149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a50PSVMEXWIrlF9Tli8fOmbsqWneSFikUwGhyJPwIGY=;
        b=H09RgJzrrBqhAt31MmnFbmpKmhKJL0F8hdDUk45C93jprX7WmLW41GFJNM8B+kQrqd
         V95SZf6Z8HHSdhtJvwUoV+Zp/8PZTXo4oc5Js8ns+EBMXNkpgrfdgrUBbFW//QLqdBHM
         BuCSLKOA2IdUnwXYfeH6rPI/91qOXrdmC/R8QyZy0jP2mCzCUKGVpZlh7WJ6/aXlXC9c
         YpPJ05AsMr5EypoBRCgO0Cm1dwbed749W9cuORCdq7c62Vys39XcacM9DxMSu/YzIydD
         haZIz4gVYnQx5XlmkpkTYU1W+kj/swgxTE5blBVfbUPpObUs8N79XLpdWzdq/UQru585
         MYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701472349; x=1702077149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a50PSVMEXWIrlF9Tli8fOmbsqWneSFikUwGhyJPwIGY=;
        b=vUToFvYtEMbk+lJj+8B5LF1Pe023OINfcgzqPtWB/yIqjxOVmyTgm8mcBHkh3Qj1EQ
         D7qdhRHEvCjtvI7GESz5a94ietwhsfLsDsgHyxzZmFMGxW/69KUu9jfD7s/A+cqhpQBp
         1BKMX0gN0CvVLBhhCQJUZlRa9kvzY6QBVmVbtbfWbfnDav8cbiw1sdAicxP6gNFD08S0
         cWOugz4p5T8Ws+RAN9zbc1qCoKs+009ulEWQIVuiKT93GfPAfJvhRBKegqKzc1bZNY2C
         TAIOt/jPAskQ2DsLtDYUA35jjnZM1VG3KeL9py2zngQTNYgg/TfCY2egUsp3Lhu7X5qE
         ORVQ==
X-Gm-Message-State: AOJu0YzO2H63558BLRDI8xgjrHp2G/pICW8Wd9Xg7Ih2ewQtPk/RP8eg
        6baC5ZhViPsBhs/e7A3yH4I4gw==
X-Google-Smtp-Source: AGHT+IF3Z3/RzfTwbCTpw0iP7Wf8/w6zwvmRXwU6DVH7OKN9elzjeew+laW1/G83KjRpnw/aIrbT5g==
X-Received: by 2002:a05:620a:8209:b0:77d:9fde:23e2 with SMTP id ow9-20020a05620a820900b0077d9fde23e2mr343467qkn.20.1701472349734;
        Fri, 01 Dec 2023 15:12:29 -0800 (PST)
Received: from dell-precision-5540 ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id bq42-20020a05620a46aa00b0077d6443ae82sm1910778qkb.83.2023.12.01.15.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 15:12:29 -0800 (PST)
Date:   Fri, 1 Dec 2023 18:11:36 -0500
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>
Subject: Re: [PATCH] spi: stm32: enable controller before asserting CS
Message-ID: <ZWpoKEcM0ZeYAsBa@dell-precision-5540>
References: <20231201214014.2539031-1-ben.wolsieffer@hefring.com>
 <b070eb2a-05d7-4e6a-8de9-15179045d192@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b070eb2a-05d7-4e6a-8de9-15179045d192@sirena.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 09:50:33PM +0000, Mark Brown wrote:
> On Fri, Dec 01, 2023 at 04:40:14PM -0500, Ben Wolsieffer wrote:
> 
> This feels like it'd be a good fit for moving to runtime PM - that way
> we avoid bouncing the controller on and off between messages which is
> probably better anyway.  The driver already does pinctrl management for
> the device there.

Yes, that probably makes sense. There are a few bits that can only be
configured while the controller is disabled, but it doesn't look like
that applies to any of the ones set in stm32_spi_prepare_msg().

I'm a little hesitant to make big changes to the driver since I can only
test them on an STM32F7 though.

> It also occurs to me that this isn't going to work for devices which
> chip select inverted - for them we can't stop driving chip select at all
> since they need it held high when idle.  There aren't that many such
> devices and it'd loose us the PM which is rather awkward...  I guess
> that's an incremental issue with a more invasive fix though.

The driver only supports GPIO chip select rather than native, so I don't
think this is a problem. Also, I don't think there's any difference
between inverted or uninverted here. They both either need to be driven
all the time or have pull-up/downs.

Ben
