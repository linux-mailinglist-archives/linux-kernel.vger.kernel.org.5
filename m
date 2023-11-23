Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C537F6272
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346044AbjKWPOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjKWPOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:14:23 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5798BD53
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:14:26 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b34563987so5755775e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700752465; x=1701357265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tjyPqzCzon3lA2/wGIkgy85tEm0FY1v7eXqgEj2Jgbw=;
        b=WiA/xWosHCbpnM5PANQs4pRib25WvssyrHNjC/PZ5UYAixdrxh0ty+x849nZEKesyK
         bVUCUuosxZeY1uscujwmZosMBgFtHnCTHPK7ixeWAR1vjrbRVt/Jqlw9GE4iNVJ0zkWM
         iW9DdRzs8JmI80u8DdxwTkITqu6cC7AuLWvycEt21+33wh7bo/7WoS9ntxvSOvjUFSsX
         kWgJOa7OV/n+alDI5kkJZfG0nxZ7G+gfd1sluvmJmXC6miQtbalmxW00jCE1Htk7Ovyk
         jER4t0Y9L/L3og9z0Qw9E6DXFPkWDim3emXaxP9cH7qC69Em5qOKIr7TZA7UIWZtMnOW
         Fs9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700752465; x=1701357265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjyPqzCzon3lA2/wGIkgy85tEm0FY1v7eXqgEj2Jgbw=;
        b=I0eEpUy/ohHo1/k4+RA0QOug9IBurGn4SMBo0vFKKzUNbQdGbDmkdrY31vbE3SM84L
         Rv/Vnk+I9pkg0KwMHHFPc0UfVjPt2PZ04BgNE8TTsjr7bsL5FpfUxeihuFE3TT3tXJi1
         XImCtwlUpscLcIAOpb1mVSBdas3gC72q6ONPMxKwh+bcgD53cAd1Yj2NVsfkvNlV621F
         CI9I6/itJuV2Xx32Feb3V9uErmpNFaxmmiHkY2eaevnLotTTczrcNqjg2lLGv+P3OlSb
         Mxwsup8f7yfadQ2mRt4XOYLdJ4lGQpFW9DtNu5QnzcE25ExHBiPMwnsfXEJotHe9XPwB
         xSbg==
X-Gm-Message-State: AOJu0YxL6CnPf2eLGTW006zXQHR4Bn9V7LQea5a6DyNtaR2ZsLOQ/PJs
        +Ev8ybsKcM/KlUCMeIQvH5WzmQ==
X-Google-Smtp-Source: AGHT+IHf4X9kOPNLBvb+cQF0eU1GVLECoR0p7qeQBdJlVd8Ofw73ikXA6WgImA4gKazzoRDSK4jg8Q==
X-Received: by 2002:a05:600c:32af:b0:408:36bb:5b0c with SMTP id t47-20020a05600c32af00b0040836bb5b0cmr2567488wmp.7.1700752464653;
        Thu, 23 Nov 2023 07:14:24 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d8-20020adfef88000000b003258934a4bcsm1953036wro.42.2023.11.23.07.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 07:14:23 -0800 (PST)
Date:   Thu, 23 Nov 2023 18:14:18 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Laura Nao <laura.nao@collabora.com>
Cc:     broonie@kernel.org, groeck@chromium.org, kernel@collabora.com,
        kernelci@lists.linux.dev, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, rafael@kernel.org,
        robh+dt@kernel.org, shuah@kernel.org
Subject: Re: [RFC PATCH 0/2] Add a test to verify device probing on ACPI
 platforms
Message-ID: <431009f0-56e7-46e8-a3a0-a8070554b727@suswa.mountain>
References: <4f1283d4-1c50-4aba-ba54-b9ea975bf61d@moroto.mountain>
 <20231123120942.33222-1-laura.nao@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123120942.33222-1-laura.nao@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 01:09:42PM +0100, Laura Nao wrote:
> > Your talk was interesting at Linux Plumbers.
> > 
> > https://www.youtube.com/watch?v=oE73eVSyFXQ [time +2:35]
> > 
> > This is probably a stupid question, but why not just add something to
> > call_driver_probe() which creates a sysfs directory tree with all the
> > driver information?
> > 
> 
> Thanks for the feedback! 
> 
> Improving the device driver model to publish driver and devices info
> was indeed another option we considered. We could have a debugfs entry
> storing this kind of information, similar to what devices_deferred
> does and in a standardized format. This would provide an interface
> that is easier to query at runtime for getting a list of devices that
> were probed correctly.
> This would cover devices with a driver that's built into the kernel or
> as a module; in view of catching also those cases where a device is
> not probed because the relevant config is not enabled, I think we'd
> still need another way of building a list of devices present on the
> platform to be used as reference.

Yeah.  So we'd still need patch #1 as-is and but patch #2 would probably
be simpler if we had this information in sysfs.  Or a different solution
would be to do what someone said in the LPC talk and just save the
output of the previous boot and complain if there was a regression where
something didn't probe.

> 
> The solution proposed in this RFC follows the same approach used for
> dt based platforms for simplicity. But if adding a new sysfs entry
> storing devices and driver info proves to be a viable option for
> upstream, we can surely explore it and improve the probe test to
> leverage that.

You're saying "simplicity" but I think you mean easiest from a political
point of view.  It's not the most simple format at all.  It's like
massive detective work to find the information and then you'll have to
redo it for DT and for USB.  Are there other kinds of devices which can
be probed?

I feel like you're not valuing your stuff at the right level.  This
shouldn't be in debugfs.  It should be a first class citizen in sysfs.

The exact format for this information is slightly tricky and people will
probably debate that.  But I think most people will agree that it's
super useful.

regards,
dan carpenter
