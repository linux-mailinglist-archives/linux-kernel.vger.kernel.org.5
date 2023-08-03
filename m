Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B7F76E0A1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjHCHAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjHCHAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:00:39 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1E9194
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 00:00:38 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe2de785e7so1066654e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 00:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691046036; x=1691650836;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7erNa/7gWtMsQuK3CJdRoDAQ+93nPpJWVI3LSRtGRa4=;
        b=mQnkfRlqHe6IyazSlgxiWMaDI8tkKvV4o3s97esAhHN6+uKLBZyWn8+1shPF0JFWU1
         /tTejz8jz4Tkvk3FxbgISZgrGAAs9qCsKlkl94LB8wJjdwJ+RWh6M1RfwjucgtNVxWds
         4wga04tS1n78Uvf9CGES8yMMfi19gdIbLJcCFCZwMsJt7Npee+kxwT8+P5XskoVnSM75
         jbvPcSteb5/HjD0yvrc5wYFEDcsXsQL0YYqsx2oiifjgTdcD23qolqZXhK6K2mSGvfve
         +VltL4q008xON7RjJYck+sko4uv45AeKVTWR1b4O58Ye5T02RcsGS7mj42OhpzdmVULy
         IoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691046036; x=1691650836;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7erNa/7gWtMsQuK3CJdRoDAQ+93nPpJWVI3LSRtGRa4=;
        b=F9c3HBQRvG9lW1Ec36n45hB4iEl3jEy0M66htF+zpVTm6awR6FupWti3d1asu+PfFa
         MK9nrFIB1llyJZDE04wPNIWHGWuezvYFULplFH3L68pEVfHkFPMq9FHWN9eKedozDtkG
         LWUj3bTvPpyJYHLMbn3MwI8fEwTMXH7i03xhR9T0jl7RDb3+5Dk2DVxrTiuU0FrWFYKi
         xPip0bEAaMhEMKQ7h5BOcvuG+isEEodTb0OxZMuPS9e2T/lfAARKYSy9DFe6wDw+6MNi
         TxhtkCRupOX7pxjZu8tlY9Rp+xU1XaoQ4nfDumkG8en+DaeWTmr4NdlJ2AEZPWjZUxi4
         HvBg==
X-Gm-Message-State: ABy/qLb8OCA7zZl4bPytfl22WMy47j6FU7zrsnfZpjDoRoj9dbOUHJU5
        gMNvRsXIdqQK4cwtKggSh32Edw==
X-Google-Smtp-Source: APBJJlHkEdhjr1rVmo/7mHQtWOp7mJcWbscH3LtniA47Nc5HyRJ36KbKTp6DFwTebvBO3SHtiVqULQ==
X-Received: by 2002:a19:e048:0:b0:4fe:5fc:9c4b with SMTP id g8-20020a19e048000000b004fe05fc9c4bmr5460612lfj.15.1691046036329;
        Thu, 03 Aug 2023 00:00:36 -0700 (PDT)
Received: from mutt (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id 16-20020ac24850000000b004fbdba4b075sm3261049lfy.57.2023.08.03.00.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 00:00:35 -0700 (PDT)
Date:   Thu, 3 Aug 2023 09:00:33 +0200
From:   Anders Roxell <anders.roxell@linaro.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] serial: core: Fix serial_base_match() after fixing
 controller port name
Message-ID: <20230803070033.GD411@mutt>
References: <20230802114846.21899-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230802114846.21899-1-tony@atomide.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-02 14:48, Tony Lindgren wrote:
> While fixing DEVNAME to be more usable, I broke serial_base_match() as
> the ctrl and port prefix for device seemed unnecessary.
> 
> Let's fix the issue by checking against dev->type and drv->name.
> 
> Fixes: 1ef2c2df1199 ("serial: core: Fix serial core controller port name to show controller id")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

This fixes boot on e850-96.

Tested-by: Anders Roxell <anders.roxell@linaro.org>
