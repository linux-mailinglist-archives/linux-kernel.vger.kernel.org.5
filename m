Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4227BEAB2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378413AbjJITgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346671AbjJITgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:36:42 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4556494;
        Mon,  9 Oct 2023 12:36:41 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-692eed30152so3581550b3a.1;
        Mon, 09 Oct 2023 12:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696880201; x=1697485001; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QT4Br2eZjQ80RdnoaYqMr7Yf+2xA1VhGldDuZohGZNE=;
        b=NzK3afOu1XyJOBumcOQyx6oAGIXDuJu8Vea35C/SHNYvhzV92/5GcFNzmxDZUvDHws
         OVCunG31OSVY1FAC05sdhe7oU0U/i1H9DwV7Q8aFvY35/graTaHoTnLFV9nO5iU0BVRO
         4C8ecKEATx3K+z0KBw68tGqw1hk3oZa/5b/1mg6mu9+waDfx3o8pxsWYUdWph8/CCQLx
         vMKF0piSkc7Mstf1bqEJ0/Nwqpr3RUamDcNoYG7eLJmp15XBiLVBgWs61UifteZb9O1H
         5+AOVqml7gjXkshuKlePSblQxvuvgbmeyXJjmSNaEaJ5OIxlwMHM3Cxsqev7h/TdTDMf
         q6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696880201; x=1697485001;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QT4Br2eZjQ80RdnoaYqMr7Yf+2xA1VhGldDuZohGZNE=;
        b=Y1YT3KjS4/1gXHCOqB7Lj5/wIQNLUiCf02RuJADET4QCMaaiw8qaj7a7uh8iLEkZ9Q
         qzlL0v57mf/nHl/jCgftZu1YK5gw1yL5pH5L7Dc5TXYDHBNeH+EDUY+wpvNZqAZfJXHu
         d3oTfj5VlJ+PDC8EbJYhlB1hGiuzUvPjjuIivqeMnJJ4W5qYwEsIkYR8KZSXZZao2eK3
         1j6s6ENI0Jz9+xjKR7J5sbS52TJne9s1gMbC1FM3G6I9CVAN3Qx/BzhlFIaBCTBU0Lkl
         F7i4YmRrQAPZ3TNArtZmH4wPhHDLnC5I2NnDfSmnleVs83JQqsClgrL8ZUoI7sZKhCrA
         X3rQ==
X-Gm-Message-State: AOJu0YwWkbgK1XNaSgQUAyXcs3ZP5gPlBXnIoQpdR95w/Z8T6xTfU2QP
        bRhkj4prQrgNoBM5G7l/e5TbrGg2AMI=
X-Google-Smtp-Source: AGHT+IFJlgJoKtZAh6NKf/UOPOuUMtnnktunZmGdr7yx9EDHm1bLUu8RTTOdX3L2QYwoJXuvbEvlMw==
X-Received: by 2002:a05:6a00:cc1:b0:68b:bf33:2957 with SMTP id b1-20020a056a000cc100b0068bbf332957mr14799799pfv.22.1696880200538;
        Mon, 09 Oct 2023 12:36:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a21-20020a62bd15000000b00693498a846esm6737528pff.80.2023.10.09.12.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 12:36:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 9 Oct 2023 12:36:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] drivers/hwmon: add local variable for newly
 allocated attribute_group**
Message-ID: <61bd7bfd-5054-4578-bcb5-0b855706b6d7@roeck-us.net>
References: <20231009165741.746184-1-max.kellermann@ionos.com>
 <20231009165741.746184-2-max.kellermann@ionos.com>
 <bab3c83c-2ba8-4d23-b3cb-2f233898f7f2@roeck-us.net>
 <CAKPOu+8Uk4GNpZ3DfWhNWXR1bQ60LxcaK9nKs+kRKuq3BOJtmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+8Uk4GNpZ3DfWhNWXR1bQ60LxcaK9nKs+kRKuq3BOJtmA@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 07:28:03PM +0200, Max Kellermann wrote:
> On Mon, Oct 9, 2023 at 7:19 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > I have no idea what this is about, and I don't see how that would
> > improve anything, but ...
> 
> Later, we can make lots of global variables "const", which puts them
> in ".rodata" (write-protected at runtime). This is some
> micro-hardening.
> 
> > CHECK: multiple assignments should be avoided
> > #101: FILE: drivers/hwmon/hwmon.c:794:
> > +               hwdev->groups = new_groups = kcalloc(ngroups, sizeof(*new_groups), GFP_KERNEL);
> 
> What program emitted this warning? checkpatch.pl had no error. I'll
> change it in all patches.

I doubt that you ran checkpatch --strict. That check has existed in checkpatch
at least since 2007.

Also, process/coding-style.rst says:

    Don't put multiple assignments on a single line either.  Kernel coding style
    is super simple.  Avoid tricky expressions.

As far as I know that guildeline has not changed.

Now, you might argue something like "who cares about checkpatch --strict",
but in Documentation/hwmon/submitting-patches.rst we specifically say

* Please run your patch through 'checkpatch --strict'. There should be no
  errors, no warnings, and few if any check messages. If there are any
  messages, please be prepared to explain.

So, please explain why this message and with it the coding style violation
should be ignored.

> 
> > either case, this change is not acceptable.
> 
> Because of the multi-assignment, or is there something else?

I don't really see the benefit of this code, and I am not sure if the
explanation about compiler optimization is really valid. It makes me
want to run some test compliations to see if the claim is really true,
and I really don't have time for that.

Also, as Greg points out, this is not in a hot code path but executed
exactly once for each hwmon device, so making such a change with a reason
like that just invites lots of follow-up patches with similar reasons,
and then the submitters of those can point to this patch and argue
"but you accepted that one". You say "micro-hardening" above, but for
me it is time consuming micro-optimization.

Guenter
