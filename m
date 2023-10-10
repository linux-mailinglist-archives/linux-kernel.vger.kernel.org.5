Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2CB7C0347
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjJJSTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbjJJSTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:19:21 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E54DC4;
        Tue, 10 Oct 2023 11:19:13 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9b1e3a809so8104055ad.2;
        Tue, 10 Oct 2023 11:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696961952; x=1697566752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7gQb8404J6lWgFy3ohXNTgpCeEXU82HEXR0Rg9JNexQ=;
        b=HQtGjz8m7+/mUU5GFNJo+9vvWOv1KkFMRq4RBcjxTuYcKFuC5XU4z4aJLl2as3Q51Q
         mWTOMifgJGrDzZshLkpDKsvT8KbcVmcYnXaamtSm0Oz/O2eMP/jg9snKlQSQdeqUI4sh
         Iv6sWxQPSU99cDPgJVguXT1C+kPtgnYp8VhgZKrmR3jgY0Zurfh7W+bSqebVHZYdeg+2
         dIiV8DAMDfQ23KbT105N8RjUjtk0AyOIomluq/1fI3+bvMIGFZO+ZN0sUC3BGC0xKqD4
         p8XmewsNgNAgJewJy7m5KOMDaCq9D9WKSSSIC2Eu5GsTcXIn7SwXnWSLmxgGGTbkJei8
         RKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696961952; x=1697566752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gQb8404J6lWgFy3ohXNTgpCeEXU82HEXR0Rg9JNexQ=;
        b=Yl65Taf9eRob68lpPVObNNBGemvSLAie8MFiLAkZ7MnUDE8f7eDFPGQGhlQE2UoUWN
         UgDBHmAw55eHGpSQaZdgXc5bD+DkywpXnLIUqErKeRpOpa4ILPGhgkTzdBWtdKOKpAiD
         OMeS0yiEQiXy2tQkfHlssUr/A3DwJtc9t9Tqwh+PYrO2jamg8jT285lbYXocxBxjwpFk
         +KamNJjQNpVdWvlRWJZh8P0zlVI+9poLi48fMUj3N6AgMjzr0+Zdx1+u6VPfL49TxBK/
         WTskcR1mirOoY5cXIxvucvQlT2gwa8Wtk3gi6IvMrFR0IO7YYSISaS3mS6m1ASvs1Llq
         TVEw==
X-Gm-Message-State: AOJu0Yz6tUTYSxQiRTW8zzE5sLMNDZAC/sTCM0fSjOGvHgVmBcmAuq7G
        wCWThFRVJRJuhFjLpxIlplAQclhr7JE=
X-Google-Smtp-Source: AGHT+IHvf+r5B3JiSJqEQuunama4l2ZFEyMx2/gHPwZS9pHkMtKfH+0SxmLtDE8nV5ngNEwXiy5vfQ==
X-Received: by 2002:a17:903:22c8:b0:1c3:845d:a4 with SMTP id y8-20020a17090322c800b001c3845d00a4mr16881354plg.51.1696961952556;
        Tue, 10 Oct 2023 11:19:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902704600b001aaf2e8b1eesm2000429plt.248.2023.10.10.11.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 11:19:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 10 Oct 2023 11:19:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 00/75] 5.15.135-rc1 review
Message-ID: <484a39a8-161a-4c41-862e-f268174b98b7@roeck-us.net>
References: <20231009130111.200710898@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009130111.200710898@linuxfoundation.org>
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

On Mon, Oct 09, 2023 at 03:01:22PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.135 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 160 pass: 160 fail: 0
Qemu test results:
	total: 509 pass: 509 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
