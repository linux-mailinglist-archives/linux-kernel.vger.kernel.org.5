Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74F88114A5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441951AbjLMObF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441953AbjLMObD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:31:03 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C053AB9;
        Wed, 13 Dec 2023 06:31:09 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5c629a9fe79so3739448a12.3;
        Wed, 13 Dec 2023 06:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702477869; x=1703082669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V7cxGDpyTU0G2lgbj2ZNrA+U3QoFsrWoQUXlkBO5j1M=;
        b=DQLHYVMjnITLvo78sTGFS0gBD9sOpa5SS+Hoiv9n0cZYYNFx7A4pkWb069p6I5+9SA
         YCVp5IimB2lY5vIqnvk6i3xOqsPOyo1cV78Aa0KgNbLWLJf55QjSX0hfKr1g/G9Q8SQt
         Yqi6Xl2UKyoC5bGLzI/wjjX690FUmDcrhN+NNnohXUd7FBFJwzHa9+vI3zgf5B5we7lD
         4A04xVAwXtc0pb3d+L7/K0pgnrmzUeoRgiFokO2lYRHZijObPBTf4qZ4mWmgHj1oy1+0
         ImCxOyeTIS9jg42FJxVl6z71xVBd8mvtNQzWpXtQAeQbDrrHkU0FcqIhHBpyHIkIzu8V
         VJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702477869; x=1703082669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7cxGDpyTU0G2lgbj2ZNrA+U3QoFsrWoQUXlkBO5j1M=;
        b=DD7BzBesC/ZsUxyraGEZEXGlR7jEJx/3v4YJf9Iqhx4qF1hm1ohLeM9/Xc/nZXTk39
         qqsJPhzEytsQbEu79+8zbtq3W1UUSVFbgHk2QmNYzJEohAhyGiwMeW6iuELwzbljxvIX
         rJqUyvsTq8krQzU3WNGWm6d8P5Nr8ORqBpURA/gk89H77Wwf5WuvQUZsUIJiPipJ5rTL
         8xsSo5fWKRvVIMA2Ds8wwDr2NghJ56f8bBYGEr3ImETvanLPRb8kIX2lyCDBmq+YR4y6
         YlUJwL7u6JYJ8CZkUXt618VZtZZaOyvzRRMklueHP4Wu3QuzDhfQ46xvYgL77n109QSx
         yjsg==
X-Gm-Message-State: AOJu0YzCDt1X+4H6kSO1sfQd2GkY+/mbkYthrodgnNjqw9u/E0n3jW23
        tztogQegaMpNwHfEES+8Vblwy0ba/xILHQ==
X-Google-Smtp-Source: AGHT+IGSQmA9WJzh0JjBuy+h+XO1/qpBe/PJbDadqbdnMqnIBKqgHDtrPiXZp8yg5oxNLJD6dWtauQ==
X-Received: by 2002:a17:90a:d242:b0:28a:f301:be16 with SMTP id o2-20020a17090ad24200b0028af301be16mr210730pjw.56.1702477868922;
        Wed, 13 Dec 2023 06:31:08 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ft22-20020a17090b0f9600b0028ad9d801e3sm1418395pjb.46.2023.12.13.06.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:31:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 13 Dec 2023 06:31:07 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 5.15 000/139] 5.15.143-rc2 review
Message-ID: <a798a295-9e44-4d30-9069-59fcc57c33c9@roeck-us.net>
References: <20231212120210.556388977@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212120210.556388977@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 01:04:56PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.143 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Dec 2023 12:01:32 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 158 pass: 158 fail: 0
Qemu test results:
	total: 525 pass: 525 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
