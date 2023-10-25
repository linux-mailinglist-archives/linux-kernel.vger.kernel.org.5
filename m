Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA677D73B7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjJYS6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbjJYS6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:58:17 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8451E1A7;
        Wed, 25 Oct 2023 11:58:15 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c9fa869a63so179505ad.0;
        Wed, 25 Oct 2023 11:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698260295; x=1698865095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=USz6/9s71w0sLfPe0tPsO9rm/oa0H0AMSu7wCJkzwrk=;
        b=mDAhm5cZqbU+ir+E5s7LtUD1Rk+1qafown1uf0FM0ZsYMq9K4TbWKKZ6BQojUabe4w
         nOqIPJr1avIioxhvcKOYgcZbsjRITPf/ceQ934nOPZGOulBTQEsyc77CquJP88c5rXSB
         K7bFzfdxsPU4quLBAENokg7sXfToCx95WqnNhRWjmOIq0tcMTjTAIBs0SazKJhgnOota
         xJpyYBs0dbVB0SEz9fMo5sbV9Vl4Ph5CPmFVO/vQLqx6jEEmwrf9W8y5npbZcWb5hwJH
         DcQLWsfgK7O5GITHRUKdkexQ9WRH/XhfATAd/mNObrcKbl66yJxZEPkP3YZYhfVFCSf1
         S+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698260295; x=1698865095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USz6/9s71w0sLfPe0tPsO9rm/oa0H0AMSu7wCJkzwrk=;
        b=giF3/p37JXJTXX1DhLirl4BrQFXZqFfxtq77Y3vTXxwQiOrCinEHoM3SFav9Jc6Bnf
         w+shc88BVy8aqSK+F3r5SnILJ1chNV/R4obP5sY6M0Pp6NyefvsJ8SxVHV8OKDV85TaM
         2szNbz40bKh4E4twwoVWAKPzlcNa52LhbTG+4kllFUHcBswhVCFARhPFIgt5Ak52SLnU
         MCPuMD76KmltqmMFkgqsGuJYE1LW7VyEt8yseJGnYI+g6iPun+5UFuCbHeB0kOX74+SI
         NHN+WX4lZotUdGgYJps1A/LPhnuCF19d2oZq1jf02S5QZGxQr9vjM8FuKwtEMppTa3AE
         bM9A==
X-Gm-Message-State: AOJu0YwYvksmzau8J4fJmsTL0pt82QmXo+4JTJDk2k7jTgBrlgRkiHSX
        g6j6Xoc1YQPnMrC4Iyf6yFU=
X-Google-Smtp-Source: AGHT+IHQLq6txzQqOERaBYLD9jpZkK03lGzJoWlAfq34fiGSic3OdT/9uldu9Ab2DOD465RDLe7vcw==
X-Received: by 2002:a17:903:2342:b0:1b8:8b72:fa28 with SMTP id c2-20020a170903234200b001b88b72fa28mr13880277plh.58.1698260294863;
        Wed, 25 Oct 2023 11:58:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id iw22-20020a170903045600b001bc930d4517sm9558792plb.42.2023.10.25.11.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 11:58:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 25 Oct 2023 11:58:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     jdelvare@suse.com, fenghua.yu@intel.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkp@intel.com, dave.hansen@linux.intel.com, len.brown@intel.com
Subject: Re: [PATCH] hwmon: (coretemp) Fix potentially truncated sysfs
 attribute name
Message-ID: <c5c1fb9a-2569-487f-9e16-9c637ba0db04@roeck-us.net>
References: <20231025122316.836400-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025122316.836400-1-rui.zhang@intel.com>
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

On Wed, Oct 25, 2023 at 08:23:16PM +0800, Zhang Rui wrote:
> When build with W=1 and "-Werror=format-truncation", below error is
> observed in coretemp driver,
> 
>    drivers/hwmon/coretemp.c: In function 'create_core_data':
> >> drivers/hwmon/coretemp.c:393:34: error: '%s' directive output may be truncated writing likely 5 or more bytes into a region of size between 3 and 13 [-Werror=format-truncation=]
>      393 |                          "temp%d_%s", attr_no, suffixes[i]);
>          |                                  ^~
>    drivers/hwmon/coretemp.c:393:26: note: assuming directive output of 5 bytes
>      393 |                          "temp%d_%s", attr_no, suffixes[i]);
>          |                          ^~~~~~~~~~~
>    drivers/hwmon/coretemp.c:392:17: note: 'snprintf' output 7 or more bytes (assuming 22) into a destination of size 19
>      392 |                 snprintf(tdata->attr_name[i], CORETEMP_NAME_LENGTH,
>          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      393 |                          "temp%d_%s", attr_no, suffixes[i]);
>          |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors
> 
> Given that
> 1. '%d' could take 10 charactors,
> 2. '%s' could take 10 charactors ("crit_alarm"),
> 3. "temp", "_" and the NULL terminator take 6 charactors,
> fix the problem by increasing CORETEMP_NAME_LENGTH to 28.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Fixes: 7108b80a542b ("hwmon/coretemp: Handle large core ID value")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310200443.iD3tUbbK-lkp@intel.com/

Applied.

Thanks,
Guenter
