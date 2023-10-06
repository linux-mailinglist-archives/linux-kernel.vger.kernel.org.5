Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075427BBA0F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjJFOQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjJFOQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:16:49 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68656C5;
        Fri,  6 Oct 2023 07:16:48 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-352a1d77fa4so9253175ab.3;
        Fri, 06 Oct 2023 07:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696601808; x=1697206608; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rlFqNr400oUmo86LhhjzRRwWWVe1as4xD/8YyVt9kKk=;
        b=NzY80zchDbXkuq0StA/l1IyqjhY6DJSunIGGSmG7XsV7FjPk/76ATuEdinl+QSagUg
         1+naWDgEGhRFfSPGBjB6LkaGKGK6ACWLk6gTBrwv92bPX3tCqJ/q1aoeckeQTdiRtk4P
         UU+wOWXP6ARydfxmlQtdOOisedqUBk6VXX5tbmqWTZOND1xVlImCbmhqu//VBtABhoxj
         GfzJXbAL9tb3yDrqezZLTTLdwU/zK6yp46TEtdgPXZhKd++TE0mVQkd9h0Z/ayjTvdIk
         wQkGszI5wkpo51PDj+nX4XncHIS4fRi8Vh2LRIQDFHoPRabm9H4JSdDBblveNnB2T06w
         bIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696601808; x=1697206608;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rlFqNr400oUmo86LhhjzRRwWWVe1as4xD/8YyVt9kKk=;
        b=o3NvR4KaWqP1srOWkohFBm4Y0yk47FLiUX/V/mY99JPWNnPB8xDL/J2ekGaMQbuHSJ
         JZZiUsb1fjQELY2LnrmS0dqDMoYOpCLUwxGRyY6Lhw2teJhQ+WqRv3XcnO/Gd3BM5Mm0
         AlNrBI+1nNlxkHJlvZTPKcTJhNb0QYhczOgKDJxGdNNFpJDliKfpiZ89YuoLWX2EbN8N
         6pW0lq/6VOVPsvYZuJyy0/jVcIOwqorAXl0iaQzis5P9/0RVyWPtCI1exKIqsWHUpTu5
         M9nm8WR0eiYI2nRvB1XdVevQ51S13TfiGgjbShEud1+rQRz8c96lpis1J3HGV/+k/imB
         4Aqg==
X-Gm-Message-State: AOJu0YyH5woM27PAvJUFE6PBY9i45fZrIM0c9nGOqlm/hHghE1qJdLuk
        ObdiCy+9u0KCmmEWv+Lf7fiUds1270k=
X-Google-Smtp-Source: AGHT+IFr8XQMKMskr7PRnKb9gzN64Tp+/S3W0BqldLDGTmi01DtlauD/kgzrG+/reT6ocmMO70tINA==
X-Received: by 2002:a6b:f319:0:b0:783:63d6:4c5 with SMTP id m25-20020a6bf319000000b0078363d604c5mr9701877ioh.12.1696601807648;
        Fri, 06 Oct 2023 07:16:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h1-20020a02b601000000b0043978165d54sm435756jam.104.2023.10.06.07.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 07:16:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 6 Oct 2023 07:16:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wenkai <advantech.susiteam@gmail.com>
Cc:     wenkai.chung@advantech.com.tw, Susi.Driver@advantech.com,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 0/5] watchdog: eiois200_wdt: Add EIO-IS200 Watchdog Driver
Message-ID: <ce810ce8-f93c-4a9c-9d14-1e8f8f8c3e2b@roeck-us.net>
References: <cover.1696495372.git.advantech.susiteam@gmail.com>
 <d7df3c7b-730a-4d09-8f15-3cc8591c8092@roeck-us.net>
 <b08d6cf6-cd48-86d7-a959-290fc4de092c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b08d6cf6-cd48-86d7-a959-290fc4de092c@gmail.com>
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

On Fri, Oct 06, 2023 at 05:27:48PM +0800, Wenkai wrote:
> 
> 
> Guenter Roeck 於 10/6/2023 11:02 AM 寫道:
> > On Thu, Oct 05, 2023 at 04:51:18PM +0800, advantech.susiteam@gmail.com wrote:
> > > From: Wenkai <advantech.susiteam@gmail.com>
> > > 
> > > This patch series aims to add support for the Advantech EIO-IS200
> > > Embedded Controller's watchdog timer to the Linux kernel. The EIO-IS200
> > > is a widely used embedded controller, and this series introduces a
> > > native driver for its watchdog timer functionality within the Linux
> > > ecosystem.
> > > 
> > I am not going to review this patch series. This is just ne watchdog driver.
> > One patch is sufficient.
> > 
> > Guenter
> Hi Guenter,
> 
> Advantech's EIO-IS200 watchdog supports 5 output pins: RESET, Power
> Button, SCI, IRQ, and GPIO. The most traditional scenario is that the
> Pretimeout triggers IRQ, and the timeout triggers RESET.
> 
> However, unfortunately, for industrial usages, there are various use
> cases, which require certain mechanisms and logic to manage which signal
> is output when Pretimeout and timeout expire. I am concerned that
> consolidating all these features into a single patch for upstream may
> lead to confusion and make the source code less readable and
> understandable.
> 

The 1st patch in your series doesn't even compile. I don't call that
understandable.

Oh, it fails to compile because you include a non-existing file from
../mfd directly and because you select a non-existing configuration option
instead of depending on it.

None of those is even remotely acceptable. Are you seriously sending me
a series of patches that don't even build to review ?

> Therefore, I have divided the implementation into 5 separate patches,
> aiming to make the code more comprehensible and acceptable. If it's
> acceptable to you, I am more than willing to provide a single patch as
> per your preference.
> 
Frankly, your series is one more nail in the coffin. I am now seriously
considering to resign as co-maintainer of the watchdog subsystem.

Guenter
