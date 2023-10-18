Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6387CD975
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbjJRKmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbjJRKmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:42:31 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCA395
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:42:29 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4083f61322fso2495165e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697625748; x=1698230548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=448I85XwNoqixMRXF1Oandk2osuw1e0W186O+rEwgcI=;
        b=YRlVNlYfD0A9PevIjNVkiFvq/JEkKdxFFTDe2nE3W4wADlG0cD7Kwj0uqUAsF14359
         Ec1RZzAg9zy++/9jSHimGWbVLirZP6jgK8OFCitgbmX9NlZIQ7s4T1tmTH4N6jahH/+u
         YfG4Wh2nRx7IP7WwNg/kDLEx9Z8dXd514Lg2oC7BX4QYcaHqwI/80TQD8p83aRn8wWBp
         zwvTw5ffSMjU3b1Iilih0LjIm2pnRMAPdDTZRGv5EVUUaCxKzxnGojdU8wb/CqxZ7S0T
         smyIZP6uz8i89Vmd+xPVB8AiUoGbj33Nrinw0Pph0EbaIai1ZgTGDaN8+H65ei4zdz87
         ttzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697625748; x=1698230548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=448I85XwNoqixMRXF1Oandk2osuw1e0W186O+rEwgcI=;
        b=Xjds6VF/7ogDoqr0X3QyJyKrf4UN5ol0aZkIVChRs1oUY4bUsu8RETuCCLmZ7+Ajw/
         JfllJRpkAv2/7IrlEH/UZ7cglDQUNJAC6+cjXDkBr8vcx7xv32RQ3Gh/fV9o7bhhOR1R
         2OMRObUqkpAnSueT+jWIYfxuVPML6CPcib5qgmUxYlGwMVwHN1wGuUcYP6QlCZI/3Yuf
         rrjpE5edkMK9f54xBgYSiGtaSB9EE4Yy5w+RkAOYJNX2t4tYT8naeY38QTpNKNncBc3Y
         uReVzi2tdPdZaDDnJAfTEDjXPAvWz6Ct6wJpmYUsUyAedZGGDSWzmjytHBBAlDz+uIoD
         yNbA==
X-Gm-Message-State: AOJu0YzfLXYibVyt1VKKQKch8elF0fQUY+LGePjloH0Rvkjp3lWAYC95
        cqx3vqjts24HX3UI5QkOoLxhbw==
X-Google-Smtp-Source: AGHT+IFHcjEQiixwI2g9jmynGtr+82+q7ej2ryHl7K5UYNYMB4Yw28x6O0HkMBHmjb2SFwF+QW365w==
X-Received: by 2002:a05:600c:350a:b0:406:517f:ac85 with SMTP id h10-20020a05600c350a00b00406517fac85mr4034957wmq.18.1697625748092;
        Wed, 18 Oct 2023 03:42:28 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id w13-20020a05600c474d00b004067e905f44sm1376117wmo.9.2023.10.18.03.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 03:42:27 -0700 (PDT)
Date:   Wed, 18 Oct 2023 13:42:23 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Karolina Stolarek <karolina.stolarek@intel.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        kenechukwu maduechesi <maduechesik@gmail.com>,
        outreachy@lists.linux.dev, shreeya.patel23498@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Replace delay function.
Message-ID: <e5c482ab-0342-43f5-a62f-c0c176e2e094@kadam.mountain>
References: <20231018004300.GA3189@ubuntu>
 <7bc719c4-459f-3d8-7ed-b1e1adf158@inria.fr>
 <1118ec6d-e1e7-79f3-08e4-9a79c996eed1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118ec6d-e1e7-79f3-08e4-9a79c996eed1@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 09:32:46AM +0200, Karolina Stolarek wrote:
> On 18.10.2023 09:03, Julia Lawall wrote:
> > 
> > 
> > On Tue, 17 Oct 2023, kenechukwu maduechesi wrote:
> > 
> > > Replace udelay() with usleep_range() for more precise delay handling.
> > > 
> > > Reported by checkpatch:
> > > 
> > > CHECK: usleep_range is preferred over udelay
> > 
> > This message is typically not a good candidate for outreachy patches,
> > because you need access to the device to be sure that any change is
> > correct.
> 
> Could we add a paragraph on how to pick good checkpatch.pl error to fix to
> the Outreachyfirstpatch docs? This could go to "Find a driver to clean up"
> section, for example.

I think you should put a note about usleep_range() and the extra
parentheses one.

Also say something about looking up stuff on lore.
https://lore.kernel.org/all/?q=sd_change_phase%20usleep_range
In this case someone tried to update this before.  The patch wasn't
merged but it wasn't clearly explained to the developer why the patch
wasn't merged.  Ah well.

Generally fresh warnings are better than old warnings because we fix the
simple stuff where checkpatch is obviously correct.

The other thing is that people really need to look at the wider context.
Look at the surrounding code.  Look at when the checkpatch warning was
introduced and try to put yourself in the developer's head to figure out
what they were thinking.  Are there other opportunities for cleanups
nearby.

regards,
dan carpenter

