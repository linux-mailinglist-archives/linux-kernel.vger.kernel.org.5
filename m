Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5867CEF55
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 07:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjJSFvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 01:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjJSFvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 01:51:05 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E63C113
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 22:51:03 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3226cc3e324so6686325f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 22:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697694662; x=1698299462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q4KPSAVtKqgOLeDR7mdK9Is2A/SYRmO80toMUaOj5BI=;
        b=EONVw+xEoTrNNKBLLf10lTvfQJbMc1Nq9dnKiKvXMxdeWmCfwoevVy9oQQX/0PZCsz
         A1W2UUURLUECwpoMDuNN9dsSpZLHv/QzCCzlTEzDUyD7PJcXs9PXBVxajHlu0dJNkiCi
         2KYHD4I9y6W2S2fgVlMuKH1nttxKHX0hAfJ43j6PZbBiGQEz8et68QLbqDXehzWSfsMY
         1b1DfBln1uCWrfl2W5c0erOCZwEu1dTzMI2S/wFYyHLhX2TlvVlElqJh3gMsHRZ18Jih
         oFsBRYoktxiGPYCq70e13J+m6b0c3ftn85SWkoevlij1QOpxv48mORAzUUIWYBIwKgBC
         QShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697694662; x=1698299462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4KPSAVtKqgOLeDR7mdK9Is2A/SYRmO80toMUaOj5BI=;
        b=IPsEr61l9ZnfdEatPNY4Bdq8Hx8UedZvHQEev6qYjDDzDu6qf+VrRlmO8DIpfvCUrG
         tQP4AAq0QXT/VIIdtkatC6Q5txaQ0INfuncNCxStskD6I1lFjQ3x3XjM/8JVO0yZIkBh
         iYu5urdCeIpJ/6C/IGr6RpImG9wzDOvh75OBAmhHqcNYuKrjHFGB1mdpGoer0pA/QY5C
         oqrGpKJDRjYY5s5FbkTPwXVNcdhMvjhsuG0RotPGDW6MjqQSV7ycHV+sJQZhL4E7Iogk
         XUvLtly0KP5VhjqT8i4/d4pS0OdV/MaFlQa9xs9NllbQ0jp5Afi9Y9KghHB2NgiylPiW
         gk7w==
X-Gm-Message-State: AOJu0YwDI6J/XtrA6kbTyYNpQxleMJ65hbCQ0WgYZIRwg6It6G6dSBEF
        i8tqzSsYyWoU5EJBOEeXA5gHznpe8BjH0DKKn8c=
X-Google-Smtp-Source: AGHT+IE/RcENarL/9duTp5rLL5MNGs6qDvtMuwpOiCBtPhCt0mgkH/IaJ1WfWVJPheD6IGLXsKBOOg==
X-Received: by 2002:a05:6000:18c:b0:32d:9daf:3f94 with SMTP id p12-20020a056000018c00b0032d9daf3f94mr659746wrx.53.1697694662034;
        Wed, 18 Oct 2023 22:51:02 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m5-20020a056000180500b0031c6581d55esm3634725wrh.91.2023.10.18.22.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 22:51:01 -0700 (PDT)
Date:   Thu, 19 Oct 2023 08:50:58 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Calvince Otieno <calvncce@gmail.com>
Cc:     gustavo@embeddedor.com, outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>
Subject: Re: [PATCH v3] staging: vme_user: replace strcpy with strscpy
Message-ID: <7baab878-ab15-4e8f-a1bd-6c028a6dbf2d@kadam.mountain>
References: <ZTDC7N6GLXZqaevN@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTDC7N6GLXZqaevN@lab-ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 08:47:24AM +0300, Calvince Otieno wrote:
> Checkpatch suggests using strscpy() instead of strcpy().
> 
> The advantages of strscpy() are that it always adds a NUL terminator
> and prevents read/write overflows if the source string is not properly
> terminated.
> 
> strcpy() lacks built-in bounds checking for the destination buffer,
> making it susceptible to buffer overflows. These overflows can lead
> to various unpredictable behaviors.
> 
> In this specific context, both strscpy and strcpy performs the same
> operation without any functional difference.
> 
> The reason for this equivalence is that the driver_name string "vme_fake"
> is shorter than the size of the fake_bridge->name array which is defined
> as 16 characters (struct vme_bridge {char name[VMENAMSIZ];...}). Thus,
> there is no risk of buffer overflow in either case. VMENAMSIZ variable
> holds a constant value of 16 (#define VMENAMSIZ 16)
> 
> The null-terminated "vme_fake" string
> (static const char driver_name[] = "vme_fake";) can be safely copied into
> fake_bridge->name using either strscpy or strcpy.
> 
> While using strscpy() does not address any bugs, it is considered a better
> practice and aligns with checkpatch recommendations.
> 
> Signed-off-by: Calvince Otieno <calvncce@gmail.com>
> ---

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

