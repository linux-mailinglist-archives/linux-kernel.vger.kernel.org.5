Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584897A293D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237508AbjIOVUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237845AbjIOVUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:20:03 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6130186;
        Fri, 15 Sep 2023 14:19:55 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c1e3a4a06fso21909105ad.3;
        Fri, 15 Sep 2023 14:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694812795; x=1695417595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iw52vl+Z+yGr72ggsy+mqPbqGnewTwN16MWm8ruh5F0=;
        b=jkeTzA8dFgV5aBQIFDSnd1B/G8ZaoBz3z8S6nqhosfzWZsy00eOuNnn+DVR0BytN4O
         3MoIKGW5Vc7bZ3TmFEJbJ4FuaEfHV8nQa1m1g2K44Qmvpbb3kwX/JHv2vRHotaoMmkuj
         6E6bcmOIdzJ/VkaCdQM3fih+vNAglNWAlPoYWYMmPsJbrWipswtB6F4EdsHnJYF6Hf71
         CWr896VIUsrzhCWl3MedHN5wjzJLcjF0nzJOZK6tOq5mEc9+lWSoUXDubhFy04FXYJSp
         rbM+aP9Llj/K/ftx9cX24QvD0WdgvQTr3dZqPiT3trltSNzje4fQklqgTD9om177JYDE
         JfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694812795; x=1695417595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iw52vl+Z+yGr72ggsy+mqPbqGnewTwN16MWm8ruh5F0=;
        b=HdcSXb+kC2diM++ViQ0gp/+kH6QSzHpKxx23DRFTPrAIhogaLV7Q9WFxdS2Y6Mq3Cf
         CEAa88B0MtNc6A4fMOIh+yn/UJjtWMlFI4DcS2DnuD3WEmBpEDHA1KCqhvG8Zlk8g2uA
         bcJDnhDmUQVDnY7ntLU609jS0kZ4INdRpV5p3wtnL49+mtm6FVEkpAmCeHz3RJG5isKn
         SYh3smOMp5xR6i8W0KF+CHI1L1XNsR/sXTTonZRCyoPPAfmMo8s0eOepSfI1IjWyc2h+
         SNZKdnllgnEDoibu/htKZc5MjqJvSrnqY6v+rL933cv442fRT6LM71gVitSaYqBo0oIP
         DHsA==
X-Gm-Message-State: AOJu0YwbKdhbK2K7EqxhuLo3NtSMYDb/I5uYqgTaH79rzsg/RZovthgv
        ugZBvvr2qrgmqPFZTWF6pGw=
X-Google-Smtp-Source: AGHT+IGJEvixLhBQnqBK5nGDCqIx0gyypqZITE/hp4lvlRPtD6bVQk4UKPJ6k/vTcWGQ4lNzcV9GhA==
X-Received: by 2002:a17:903:120f:b0:1bc:e6a:205f with SMTP id l15-20020a170903120f00b001bc0e6a205fmr3131079plh.20.1694812795125;
        Fri, 15 Sep 2023 14:19:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902ab8400b001c0af36dd64sm3918112plr.162.2023.09.15.14.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 14:19:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 15 Sep 2023 14:19:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     David Ober <dober6023@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com, corbet@lwn.net,
        dober@lenovo.com, mpearson@lenovo.com
Subject: Re: [PATCH] hwmon:Add MEC172x Micro Chip driver for Lenovo
 motherboards
Message-ID: <8a566102-5ea6-4449-9083-8feebe711065@roeck-us.net>
References: <20230915150340.301067-1-dober6023@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915150340.301067-1-dober6023@gmail.com>
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

On Fri, Sep 15, 2023 at 11:03:40AM -0400, David Ober wrote:
> This addition adds in the ability for the system to scan the
> MEC172x EC chip in Lenovo ThinkStation systems to get the
> current fan RPM speeds and the Maximum speed value for each
> fan also provides the current CPU and DIMM thermal status
> 
> Signed-off-by: David Ober <dober6023@gmail.com>
> 
> Written by David Ober from Lenovo using this gmail address since
> my corporate email address does not comply with git email

FWIW, this needs to be after '---'

Anyway, thinking about this submission makes me even more concerned.

This isn't really a driver for MEC172x; it is simply a driver
accessing an EC on a set of PCs and/or laptops from Lenovo
which uses a vertain API for communication between EC and main
CPU.

Such ECs are typically accessed through ACPI. Yet, in this driver
there is no mention of ACPI, much less any protection against
parallel use by ACPI code (that access lock in get_ec_reg() doesn't
even protect against parallel access from userspace, much less
against parallel access from other drivers or ACPI, for example
by using request_region() to reserve the used memory ranges).

There needs to be explanations and clarifications 
- Why this driver will only be used for communication with MEC172X
  based chips, and why the exact EC chip is relevant in the first place
  to be mentioned as much as it is.
- How it is guaranteed that the EC is not and will never be accessed
  through ACPI.
- How it is guaranteed that there will never be any other kernel drivers
  accessing the chip.

> ---
>  drivers/hwmon/Kconfig             |  10 +
>  drivers/hwmon/Makefile            |   1 +
>  drivers/hwmon/lenovo-ec-sensors.c | 471 ++++++++++++++++++++++++++++++

Documentation missing.

Guenter
