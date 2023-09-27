Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C097B04A7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbjI0MtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjI0MtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:49:01 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C573E6;
        Wed, 27 Sep 2023 05:49:00 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79fa416b7ffso334246339f.2;
        Wed, 27 Sep 2023 05:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695818940; x=1696423740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hEv5gTzCBSNWos/XoZhX+HMntbjZFYSz9lEJ4TMjS+0=;
        b=T8R+UQ/+RXlETDER3JBxyVIu7CU75u/gBW6s1FYuWgZ5K9zag9VicAp/SYEx7T1lLM
         /NkgbyI0qs3PE/MT0kwAhgOxLB/PC2sAXQkyxc2LDFIUQP4Z4G/QaDKTWoEk1ARNv8nr
         PiS1r6nlVqkE/2K1uoY5V3DMYHhtnEOohl+fkLczeIp6cY5CyIO+Q/GwRRSl+Oh6emCk
         lh6HRyp/XfcZ4yA9lS9gx/2BuVrZU7j2EsdLk1wUOTtABkI5XYj6tw62aUS4NvtHzB+A
         5AQu2C0wDT6K6e6N93xaBQGrABdQvM+fxbYJ4OZ4vPdBD299AeTYi7vQB5ufbZOUauDn
         A/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695818940; x=1696423740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEv5gTzCBSNWos/XoZhX+HMntbjZFYSz9lEJ4TMjS+0=;
        b=Rxzr8lyK5SlvjOJGQdjNrJN/Oiapx7HjM1GhDwQ28nmYUIljPrsZTlaV+Pc79WbBVo
         uwDsASCRjHd3LM91B/yRqzirI+aejrFKgZGoEDQs6DjLvx+Z8TOhrNxqY7sGjm0hZP/0
         03gyIdLQ5COZajUoNh+TGjyvhwc4mTJ4rpxRGtXpWzW4w1RJyFhfqNi0lf3GaARmAlBL
         Yn+Cz2Zjju1oLoLqnHqf5ZIE/EmRFbJwFf4jNY17DOrVTHZcGZ5tEHQhhWpAXGq8u4BZ
         xtjvg+6i4u8Jl+YVPKANOaolK38hfZ5xjy0Zd/zgxHd/ofVUZZHvD9a4NFBU6ASpkcHx
         5jVA==
X-Gm-Message-State: AOJu0YyriwZ/dJyGDbqGmbBqA85+whVVNzjueaCduRBOs+4A6/Ie/DUh
        IThcn8+6QxVAhpaXDeYBY/o=
X-Google-Smtp-Source: AGHT+IGBWI9TSRFdCwoD10pgG78eddGuSS6x0I2f47WdbCulTSWC+kijzDLc/jUMknyMOxBPbLj1Ig==
X-Received: by 2002:a05:6602:3355:b0:79f:cdb4:3f87 with SMTP id c21-20020a056602335500b0079fcdb43f87mr1877939ioz.4.1695818939692;
        Wed, 27 Sep 2023 05:48:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j19-20020a6bf913000000b007836252a084sm3895077iog.48.2023.09.27.05.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 05:48:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 27 Sep 2023 05:48:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: refactor deprecated strncpy
Message-ID: <9837d8dd-d802-4d5d-bca7-6e029658ba76@roeck-us.net>
References: <20230921-strncpy-drivers-hwmon-acpi_power_meter-c-v3-1-307552c6ec3f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921-strncpy-drivers-hwmon-acpi_power_meter-c-v3-1-307552c6ec3f@google.com>
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

On Thu, Sep 21, 2023 at 05:41:46AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> Let's refactor this kcalloc() + strncpy() into a kmemdup_nul() which has
> more obvious behavior and is less error prone.
> 
> To avoid truncating the last byte supply `...length + 1` to
> kmemdup_nul() as `element->string.length` does not account for the
> trailing null as made obvious from it's definition (and associated
> comment):
> |       u32 length;	/* # of bytes in string, excluding trailing null */
> 
> ... this is precisely what the original kcalloc invocation did as well.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

I have multiple patches with the hwmon: prefix but no driver,
like this one, suggesting the change is in the hwmon core,
when in reality it is in some hwmon driver.
I am not going to apply any of those, and I am not even going to
look into them.

Guenter
