Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2209179A0E2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 02:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjIKAyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 20:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjIKAyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 20:54:37 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005F3180;
        Sun, 10 Sep 2023 17:54:33 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68fbb10dec7so396745b3a.3;
        Sun, 10 Sep 2023 17:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694393673; x=1694998473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gVOqgHK2ezKb67maSfo1jCAtAIQQF0mALfe2uCVklzU=;
        b=OqxjT0RIJ5qb0m90jKKcDYkzkJITWP9fuNUGyD6QFgpIzoaUIFSHVKZpNUe5d6NFPL
         RyEy36WXJ6kNS4haS981WMDvN5fiFzOwUstlroiOllr3s6usjzHewmnhjTMAYj7Sgynr
         0W0gd/ErQLEsceRYqrFCd25cPcDLH6v2K2mPY5/AY3BG0oXdIh3jUNT/nqAgQqEwaXUA
         BHPuxxkzUzJGDwzKj/ViBJiyDL+C2lHs9f6x/zVDfnGCmI3EsYPwc7EV0IcK3PlIq4wQ
         gl5+AXQaGoZRy1xL/GBMWe74kvSipPHVhq1F6uHqK46Oy14GDcnqU7bsWPpFbw8BRsLz
         K1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694393673; x=1694998473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVOqgHK2ezKb67maSfo1jCAtAIQQF0mALfe2uCVklzU=;
        b=Wg14JrdSNshPeZuA6oKp9v7WcX/2CqacXfz7EcMqi/61D4Bh7S7SV44A5W+N34aEOm
         b4eEeQyj8lw1vn91g9mlKdpJrwUMxv7Q0U1lNbQuVBTeytGdfgJs+O/tY24qapF4eGtl
         wi9Lg/j9aC5gvByjj5rL+H3iAwIbUkYBHW7kyJfWsFjiIPNkBWXdddZnynbqBKxaAT8+
         mnghIxJsiO+aUMrtZJJDCX9twSMEJPyFo9gKmR8dUAp5MUdW2Do2tHya3UTzXEbQYtXz
         dw23XgO4TuGLXTL3dciCmakoDEIsqECxoPG4oWWBhs1xa1axnZvfYXps1tvxmYxtjN27
         Ibog==
X-Gm-Message-State: AOJu0YymzeCVMW2nGGOEj/FZegUzJuiv/8E6r6idVEGeANwezBK7UsRh
        kQsITJMsOSboIA0XSOg6+EE=
X-Google-Smtp-Source: AGHT+IFTXOBU6Y2AWmCw/MVK/rcBQVrEGmh8Bj8WjtNrZRW+Jsn+8MtB4eRwyHWVy3R01F/zEf93TA==
X-Received: by 2002:a05:6a21:778b:b0:14d:7130:ce5f with SMTP id bd11-20020a056a21778b00b0014d7130ce5fmr7720114pzc.32.1694393673414;
        Sun, 10 Sep 2023 17:54:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f12-20020a17090274cc00b001bbb22652a4sm5087476plt.226.2023.09.10.17.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 17:54:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 10 Sep 2023 17:54:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     hdegoede@redhat.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] hwmon: (sch5627) Document behaviour of limit
 registers
Message-ID: <582706d2-c74e-4700-943e-a9ba909e7df1@roeck-us.net>
References: <20230907052639.16491-1-W_Armin@gmx.de>
 <20230907052639.16491-6-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907052639.16491-6-W_Armin@gmx.de>
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

On Thu, Sep 07, 2023 at 07:26:39AM +0200, Armin Wolf wrote:
> The values of the limit registers affect the fan speed in a
> particular way. Document this behaviour so that future users
> can exploit it if required.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied.

Thanks,
Guenter
