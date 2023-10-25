Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDAB7D73BE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjJYTAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYTAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:00:23 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1169F10E;
        Wed, 25 Oct 2023 12:00:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c9e95aa02dso569465ad.0;
        Wed, 25 Oct 2023 12:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698260421; x=1698865221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzAfQ6yYZLyhx2cAwtxAGCA0+tOzhnyj4YuE87FGQU4=;
        b=bIsGHb7WaVBQ74oLBGji5cEIrgoN6P9fvH2alJukwyw8Uh34w2+o96pbJ9G66cStNL
         O8wkG4nsPp3C+xj7jC6ug9A5vGQzgOtW5UdgbkEKmYhfaRtUb9wUA9q3ehy23PiEd9k1
         jDqVPgVtOAnkk+mqjnYbaFZIGsdER14TPRthHpIV5cjznvB1l4V6ahFubjXTtueIIAC9
         ihr+lyuXZaG0bJYIBgT6HAEgalzYK3+/zrMpYT168UdRB2IqiRDDod07Ogh82I8ToIqA
         WvmziC3JhNCvwaIsnTY/6tnQE1HgQRU+PchxNA9rkxJPO1Y+8b/+Qfs0njyPjdWGKfwF
         JNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698260421; x=1698865221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzAfQ6yYZLyhx2cAwtxAGCA0+tOzhnyj4YuE87FGQU4=;
        b=f6j5EuLS21jBkiygUhYLUfZe1K7QEyTKOKFj75QWzWbUdfnJ+NHp381G7Q7gCLaUgf
         jmhcAfE8OlJic/RIhptZOC2I2gh86wHtpgUf34naerS/S5bAX2+Goz5wg1UCt+87LXOR
         ZBb1s4Y+Z5ltc9fJSNMI5MBYqpV5fPbh8dtlR0VAcHuVBwxEdQ8eQleIQ7TEzj9n2UCb
         c1tipL9aT2uVWCcVaUpmDJZhg0CYXL+ECFug8z/F4c/x0b86x96mG5GYiQO8/cIhHVDg
         eFNhqXx54EJp8FfAR/Z18y53yjRSGEoK7mFAmBh9oim7KoelTqoXiXbtyGsFN8Z/gldB
         dhJw==
X-Gm-Message-State: AOJu0YyKcCgDkKe1CCub+Y2hSakt52iFp6EXK+px1Pj+7IetjAsR19Ve
        nqQU5YG2ajDYjTIJ0oUo3ytdX7fa7T4=
X-Google-Smtp-Source: AGHT+IH0f70yOL3Vogs/TZ3xF70f7ik/ljg1vfYB4+38oocqr+9dom1dGVftRe4bhCVo4zwwbojxUg==
X-Received: by 2002:a17:902:d50b:b0:1c8:75d9:f7dc with SMTP id b11-20020a170902d50b00b001c875d9f7dcmr626772plg.28.1698260421448;
        Wed, 25 Oct 2023 12:00:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jj11-20020a170903048b00b001c8a0879805sm9591444plb.206.2023.10.25.12.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 12:00:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 25 Oct 2023 12:00:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Andre Werner <andre.werner@systec-electronic.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: HS3001: remove redundant store on division
Message-ID: <6a943960-d283-44e5-b19c-0250d6f4bed8@roeck-us.net>
References: <20231023135828.667297-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023135828.667297-1-colin.i.king@gmail.com>
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

On Mon, Oct 23, 2023 at 02:58:28PM +0100, Colin Ian King wrote:
> Currently the local variable hum is being divided by a constant and
> the results is being re-assigned back to hum before the value is being
> returned to the caller. The assignment to hum is redundant and can
> be removed.
> 
> Cleans up clang scan build warning:
> drivers/hwmon/hs3001.c:65:9: warning: Although the value stored to 'hum'
> is used in the enclosing expression, the value is never actually read
> from 'hum' [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied.

Guenter
