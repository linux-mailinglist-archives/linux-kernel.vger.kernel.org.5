Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB23F7F01AF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 18:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjKRRrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 12:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjKRRrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 12:47:13 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90801C0;
        Sat, 18 Nov 2023 09:47:10 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b6cb515917so2073080b6e.1;
        Sat, 18 Nov 2023 09:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700329630; x=1700934430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P30+Kv0c4M/aWEZcvHpbxaznwhV8703el60qOTrqHQk=;
        b=Po+Xmb2tOjLwAQYQzbZD6G8k+1zdlRsj4dVQCf2YhWV7V+MbT7pheGH7dAzdobGTl6
         e9Spry+MJMT6pDVoUG7brS1xLLfY7rVZSnNsv0fsVDT0tikb2IvBZZojt5zMFpDykuhC
         WJhvhHS9iy2KLuYS+ZI3GEaKl+loCLdbnCzyCGimq0++dLLLO0ganioh1IcGpjVMPJyP
         XaxbpYGXJuC1xIcJmdT4oggVUIhcJCyLh5ob6HZTZlckcf8lvh4ZN+5drODrdl5bCuNw
         H7kxJDFYd4/7Yf8J2A8mNXp3RadHi67aypuF7RThby5ppDmkR9k2yQZezWjaCx436/Ly
         j+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700329630; x=1700934430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P30+Kv0c4M/aWEZcvHpbxaznwhV8703el60qOTrqHQk=;
        b=F1YmoParctc8QAtoQLlql8mFHAqKPOT6tl8SW+QDZcAk7Nji7GFSqzjwNs6+aCWCdr
         G5/eNuUvPT9KZayc6Oxal5SIiuD+HE7Alh+YgfptJSGo87ZthVmwkp8oqAS4THrjA5kb
         nnxmou8Em+7dzdG/ajwCdYrzwurPyl+YJz74hsl/13ztGxQeNn/lhW8xDbm4toSnL3Dr
         TxVx4cjjmG2mWjqSoDlA2Gf7aA/sOY+LCtN89jmgDNav75a9leEk5PMl5HEa83F1m4GL
         urNrBJ/AHxLakdBL0JR2xtJxPX0PDUVMqjv5zK5fBgO2Klb4ZDoDHHZwpZZsH0vLW7LW
         8ftQ==
X-Gm-Message-State: AOJu0YxQS4a+L9+eLWi36hZR33awOMI9zdUatxKzLcK9Yu1cYCkD1PCW
        jb8m88Qv2BKpTgzjqG0S2vw=
X-Google-Smtp-Source: AGHT+IEtEpmL7hAwXCPhqrDUpRXzfF3ufJ11BJP9ERHwvrpR7ZSjVy+bzjsQkXZlILfLNb6KmWC/iA==
X-Received: by 2002:a05:6808:16aa:b0:3ad:c497:1336 with SMTP id bb42-20020a05680816aa00b003adc4971336mr4407581oib.16.1700329629861;
        Sat, 18 Nov 2023 09:47:09 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r3-20020a544883000000b003a40b3fce01sm711729oic.10.2023.11.18.09.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 09:47:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 18 Nov 2023 09:47:08 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] ABI: sysfs-class-hwmon: fix tempY_crit_alarm access
 rights
Message-ID: <1346aeac-ccda-43fd-8a63-0c843bfe33b9@roeck-us.net>
References: <20231116-hwmon_abi-v1-0-8bfb7f51145a@gmail.com>
 <20231116-hwmon_abi-v1-3-8bfb7f51145a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116-hwmon_abi-v1-3-8bfb7f51145a@gmail.com>
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

On Fri, Nov 17, 2023 at 07:40:36AM +0100, Javier Carrasco wrote:
> This attribute is defined as read-only by all drivers that support it.
> 
> It seems that the access rights and description for this attribute were
> copied from the intrusionY_alarm, which has indeed RW rights and must be
> cleared by the user.
> 
> These are the modules that currently use this attribute:
> - adt7x10
> - i5500_temp
> - jc42
> - lm83
> - lm90
> - lm95245
> - max31760
> - max6621
> - mc34vr500
> - tmp401
> - tmp464
> - tmp513
> 
> Fix the attribute description and make it read-only.
> 
> Fixes: 365b5d63a505 ("ABI: sysfs-class-hwmon: add a description for tempY_crit_alarm")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied.

Thanks,
Guenter
