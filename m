Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985D97ED71F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 23:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbjKOWXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 17:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjKOWXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 17:23:30 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC36C192;
        Wed, 15 Nov 2023 14:23:27 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-586ad15f9aaso84549eaf.2;
        Wed, 15 Nov 2023 14:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700087007; x=1700691807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zj8kRfNUogWaVW2Nbf21N+NiPzH0NEKBCgCHTXITBSU=;
        b=c49XPiTvAL4xdkYC1oM0QA3aK6PkISrPv4YP3q8H5tksz1Ws3jIODYq22KDgvKfVhf
         KVK5AST75Pm5Q+d2NGvSo99VxkeQw1uLJNifidwHwDQLVrDNNOM224OP1KVrgUjPaA//
         Pj4rRI8LjFFW3EzrQ7rQ0ZMYRRgHNo2qtfmZCTHZiC8iV5789p5J55Md83NZbDqVzVue
         ZWlkROY/MWQhwj/rjknEe5jL+U1sguke8b5fGIjy6+xJQ8KMwoz09wlKKidZWHJ+r2vl
         sHNx4wVAdt4UQBMUMHSNYkHJSVSgQVUHrzthbuNZ10R7c4OGHAjtqWIFrvITTzvGwwOz
         q4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700087007; x=1700691807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zj8kRfNUogWaVW2Nbf21N+NiPzH0NEKBCgCHTXITBSU=;
        b=Ew6fw4rEjcGxRh8tt7ydUAAt1luZRE1Tk8iqRpnrU0xjuCXA/2HhVGEn106I9nOpDG
         q1MwHkuVdXLfbMMPapNBMkf0XRWuy9IEUAbGvIcA4O+vepDW2cAid5XcbXd37wWkomqt
         TNEEZI6bDrJ/RfSPCtmlWQGnlEfDRWTysMDrLbppqAHociggkKoGj5q8zhM+u0S5MgCk
         y4zXyCMpkHgfgnWFUtPezepWYenEvdMhkB329vqDYz3MmMLx7wteEqAvwnmmjFiNA/2R
         WmHMLXF0LvNkmm+WvwodqF1oq1glxu2X8S6jXrnyAb3HYJKifrXVvIgzV8pLQcThXgjB
         E6Vg==
X-Gm-Message-State: AOJu0YzK+urD7tQOwm/5atObOoqAbkV76Xy6Exhtm7wGjRA8/vAfueto
        B4eH4p2utEOcChzcdandH2YtlxkqVss=
X-Google-Smtp-Source: AGHT+IEz38H0loKzeJtBOFX9LovIU0xhGSPzZzPwdZ4TW9iwoC2JymoE9dAk7QueSbFD/uNqk8InaA==
X-Received: by 2002:a4a:9241:0:b0:582:99ae:ca4c with SMTP id g1-20020a4a9241000000b0058299aeca4cmr14413814ooh.8.1700087006949;
        Wed, 15 Nov 2023 14:23:26 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h6-20020a4ab446000000b0058a784d6ff2sm621681ooo.12.2023.11.15.14.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 14:23:26 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 15 Nov 2023 14:23:25 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Zev Weiss <zev@bewilderbeest.net>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] hwmon: nct6775-i2c: Use i2c_get_match_data()
Message-ID: <d143a5a3-73f7-4c54-94c6-92d1ce8bbf76@roeck-us.net>
References: <20231115205703.3730448-1-robh@kernel.org>
 <20231115205703.3730448-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115205703.3730448-2-robh@kernel.org>
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

On Wed, Nov 15, 2023 at 02:57:01PM -0600, Rob Herring wrote:
> Use preferred i2c_get_match_data() instead of of_match_device() and
> i2c_match_id() to get the driver match data. With this, adjust the
> includes to explicitly include the correct headers.
> 
> Adjust the 'kinds' enum to not use 0, so that no match data can be
> distinguished from a valid enum value.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied.

Guenter
