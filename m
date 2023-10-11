Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7217C57B9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjJKPFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjJKPFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:05:07 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E7092;
        Wed, 11 Oct 2023 08:05:06 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1e10507a4d6so5134112fac.1;
        Wed, 11 Oct 2023 08:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697036705; x=1697641505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kXDjoDbzwlWXfPA8MMIol0GtkAvJKfQiWOLtIt+2v7A=;
        b=UB6elFJDZgNOejRwqHpPK2cPsDa6X3GROQ6Qz3IQvAZsWjzPJcKXx/SDa1ifnVgyL8
         YjzdKM70wSnMmVkqJxNJzYETZCNqCfEGzTFmjjVQCKyRSTpc9wMRPdgRUqC0vpnmttM+
         Yie3eukZ6BpfGryp08JEZI2cmisMe8AY+whGDN303uN2X29OM5zr91uZd1NIJYUm/ObC
         hKWYUTrtLpks/vNpl2/RT27rT1ap7mCxYqrTY1AxOQN5hV4kM4YnJnVNxKRktGsaWdwp
         NZ6WvxM/JuItLd0ObV9TFGyO9Tdwst6OPpqFK0wDM/YSuinh5n4ObhjC5JVfTK7NIwA4
         B+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697036705; x=1697641505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXDjoDbzwlWXfPA8MMIol0GtkAvJKfQiWOLtIt+2v7A=;
        b=wsxnfZoAk0JgbP1o7kmuUz+3efCtWZjnTGV8cvwNDOeqppGFW7h857LjFIOQ2t9YP6
         H7uVM33xi2OmDPcfpSBDKbxtBsqQleqVFb1VpPjCzoxweGgYMQ7D1lHMPkHs/baoQAp9
         W/juYhiAM38t+W+mgl/GdltWpSgZAAzQptcOMqo/6tBdyKCsndcvJq7Fz5Qo1vaJobrl
         ll8orzSgoRzLbVV+BgG+XvsNy45q3t86GKzVkecleDyGRolio+1qwdduVSKXvFBeLgmc
         PzqDerUPNvRWYoTw9HFNd4LP3XneaqC0B295u5BEil5h0xp97QAoWgu0dKK1wT2FRynm
         85eQ==
X-Gm-Message-State: AOJu0YzoITdWB2iMGHa9W+MWTam5y7MFn919KX8HKm32LOKz1y+VzoTQ
        gPF7sdDqoZ2gyrKvTu1yN73+ESrwi/o=
X-Google-Smtp-Source: AGHT+IEWAfUTXKko2dJOn1AyhJ3fD1Rnv1Dh69yzNg8LaTiMgSS12SATQz9JBFiqPAcgoJmJqiYq+Q==
X-Received: by 2002:a05:6870:898c:b0:1d7:1533:6869 with SMTP id f12-20020a056870898c00b001d715336869mr25351025oaq.31.1697036705519;
        Wed, 11 Oct 2023 08:05:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g4-20020ab016c4000000b007aba00406a4sm2740773uaf.7.2023.10.11.08.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:05:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 11 Oct 2023 08:05:03 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wenkai <advantech.susiteam@gmail.com>
Cc:     wenkai.chung@advantech.com.tw, Susi.Driver@advantech.com,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 0/5] watchdog: eiois200_wdt: Add EIO-IS200 Watchdog Driver
Message-ID: <655945a4-fc45-4d01-954b-88aa6fb7231f@roeck-us.net>
References: <cover.1696495372.git.advantech.susiteam@gmail.com>
 <d7df3c7b-730a-4d09-8f15-3cc8591c8092@roeck-us.net>
 <b08d6cf6-cd48-86d7-a959-290fc4de092c@gmail.com>
 <ce810ce8-f93c-4a9c-9d14-1e8f8f8c3e2b@roeck-us.net>
 <88ffe7b3-fa62-e879-b9d6-6e229cfdab7d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88ffe7b3-fa62-e879-b9d6-6e229cfdab7d@gmail.com>
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

On Wed, Oct 11, 2023 at 12:08:57PM +0800, Wenkai wrote:
> 
> I understand that the patches don't meet the expected quality standards.
> The compile issue is due to my MFD core driver, which is currently under
> review and has not been merged yet.
> 
> I would also like to seek your advice on how to best proceed with the
> sub-drivers like the watchdog driver. Should I wait for my core MFD
> driver to be successfully merged before submitting the sub-drivers, or
> let Jones Lee review my core MFD driver and all its sub-drivers, or is
> there another approach that you recommend?

If the sub-drivers depend on the mfd driver, at least provide a reference
to the patch or patch series introducing that driver. Either case, a direct
include from "../mfd" is simply unacceptable. include/linux/mfd/ does exist
for a reason, after all.

I don't know the best solution for reviewing all the drivers. I didn't
(and do not plan to) look into the driver-driver API. If the interface
is regmap, reviewing sub-drivers on their own should be straightforward.
If the API is with function calls, things get more complicated because
the API needs the sub-drivers to be tested and everything needs to be
reviewed together.

Guenter
