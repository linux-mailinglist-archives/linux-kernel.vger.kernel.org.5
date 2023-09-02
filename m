Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D1E790835
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 16:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjIBOOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 10:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjIBOOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 10:14:12 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B688510F0;
        Sat,  2 Sep 2023 07:14:09 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68c3ec0578bso1681b3a.2;
        Sat, 02 Sep 2023 07:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693664049; x=1694268849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1IX6WzDvdx1LIWJsmRsgXrzLegcud4XKgsWDAoEC24=;
        b=HhtZJ/BcnqW3Bwg9opjpAn6IkB5hc7jvblYQs4uzip/OKJ46ikMkvyI9KQF85fHzRm
         JOyG3BcId45EdrVgop6FE+Cb9tPUnPztP9qQ+nL0GuIpyaMF50I/J+R5tG1bCD0pSkH2
         tBpWjvAn5mH9FKmxHja8swryHs3QXY90QTz4CGLOhSI057/TMn/Hycp0tu+B7kiafsE4
         9R+DdNz9QWN8d07xpgcYCEiC5X4PB3FHFMIUHXvUefu1nWZzDTam5pG03fMzgyIrVuKp
         /LVeWpA8bwGvXHvy5udvANtvkgNFpu43pbcmrMvAThdWC2fvTP4b/s/E6EPQVqZrEf5H
         0erA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693664049; x=1694268849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1IX6WzDvdx1LIWJsmRsgXrzLegcud4XKgsWDAoEC24=;
        b=bDcza2RPDtIB2tG2ZwAJlwSsT4jQaxa/ONkie+WifqOpXH3MAM1RL9FJngVi7s663E
         OJESr1vCr5EmfaIsmFI4IwRb0z1ghH33LFuw6JYvOwLD1so3kOvg0ekZebhBQwwU2D8p
         b1Sxguo+9Gnvn+TpTzcMnRUd8YM8WSHgGVLmSIxf8dwgzUuAQnPcHe3N1totueYt+R50
         P++ajac9bhtfCZ1rFGEg22Cf8yFqGmFkai3//oURW7evow4CKi8qyWb5HzOn0/nRZ+Eo
         qw/MngIrPk50envf1OGq56dIrH3J8TmFLErCrfxZnKCjhKpTM8B10ItLzcfnvvm/tR7m
         O5MQ==
X-Gm-Message-State: AOJu0YwsigGcVRNVEiXng2EL9DTWR1T9IfHNzghkOrNl948pUOzgIZUL
        /5FfVYmMhCu+kJ+IKOb+bVI=
X-Google-Smtp-Source: AGHT+IEy78imCHfOknHd75OwsPOoxUjkbc6uB4H7TgPtKUd8X9nn69PVvBmAVylA8YROed/su15O0Q==
X-Received: by 2002:a05:6a21:6d9f:b0:13a:43e8:3fa6 with SMTP id wl31-20020a056a216d9f00b0013a43e83fa6mr6192467pzb.23.1693664049173;
        Sat, 02 Sep 2023 07:14:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q15-20020a62ae0f000000b006829969e3b0sm4618518pff.85.2023.09.02.07.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 07:14:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 2 Sep 2023 07:14:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] hwmon: (pmbus) Add ON_OFF_CONFIG register bits
Message-ID: <1f4efaa9-d0ae-4269-8d83-f25db974e8b2@roeck-us.net>
References: <20230831190731.265099-1-Naresh.Solanki@9elements.com>
 <20230831190731.265099-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831190731.265099-2-Naresh.Solanki@9elements.com>
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

On Thu, Aug 31, 2023 at 09:07:28PM +0200, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add bits found in the ON_OFF_CONFIG register.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Applied to hwmon-next.

Thanks,
Guenter
