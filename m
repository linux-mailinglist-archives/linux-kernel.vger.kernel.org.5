Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574E978E016
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244088AbjH3TN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343757AbjH3Qoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:44:38 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7891319A;
        Wed, 30 Aug 2023 09:44:36 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-79289fefdbeso164877839f.3;
        Wed, 30 Aug 2023 09:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693413876; x=1694018676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VB9BcG9DBx3YBgNtAp765xJQP9YYe+QOzLCI45b7TjA=;
        b=bqgHe3b+c2HIfT8Snf/P5PEu9PtTi+7GwResDismUCljPPApYs8ENhvkfSofh09RmJ
         0Z+twB8V393/VtWri99gDyApfq0ytwyBhZkSVINUHlxcY1DZBUBgYMPyU7DBrEWq2AeW
         i6ncwpB9uMw+p1yT71QbS2+RLO0lEIUPzTZd8bo2RfdaWma4fIpzoaVOeHL6zlB51sN5
         suXP8z6FWOcIkALlbRB3Z6VrQgR5wB3CGyF3rWjpGH6SdwmD8yTpPvAZo7KBqWBDjL1e
         aEtmjMFAExz8B0NRTxR5S2uxRMSDTSJxn+Zj4qGqipGC4kwhsPuU4+DiyTdjhORmbURo
         37/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693413876; x=1694018676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VB9BcG9DBx3YBgNtAp765xJQP9YYe+QOzLCI45b7TjA=;
        b=cey6DlaNOcUSV2kgTd6zNlaaZm9sR41q+E7qR8DtAmjm3Ef4Qx3cfK2SHJo0SehfXW
         cQynOY8H81cjoQGXHKDbQPJhKsiBYXKigs2FbNo1GdreBd/qkxkY6OD3ev5mq41d6rwx
         qwGMoBJydSKPcXyZ1HdqaDrZUCcUm058m8QthukAnCbiSpYrHPxfbM683axGVzUIcvF4
         bmprS09GlE4qgGRRrNIZdGiklDYB2oknnV3C76yGe7z0gErWlbtfUdc6du/l2BmxF7I1
         zI2IJMubwAgXh01RafyStMbzX0PciF16BmtqMfR+/MksB+zmdYQAYDl6tLvGRhz3cAhc
         qNLQ==
X-Gm-Message-State: AOJu0YxTjwdXVWeH8dtbf/IU8FRO9QqY0yfZeScqEiywW2GVB0WOBohz
        Wjj2Uxi+e0aEOE2DmsDEZUo=
X-Google-Smtp-Source: AGHT+IGUv20sbwduwPaQIjZ7MnGXmaLgkBIZ4HLZXUWF8gBJHgLANXduERX1A/QiIRbKuOhDZRDqkg==
X-Received: by 2002:a6b:7006:0:b0:795:c6f:59ff with SMTP id l6-20020a6b7006000000b007950c6f59ffmr3192682ioc.17.1693413875851;
        Wed, 30 Aug 2023 09:44:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g7-20020a6b6b07000000b00786f5990435sm4001523ioc.7.2023.08.30.09.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 09:44:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 30 Aug 2023 09:44:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 000/135] 5.10.192-rc1 review
Message-ID: <27d08b24-3581-4451-b8db-5df144784d6a@roeck-us.net>
References: <20230824170617.074557800@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
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

Hi,

On Thu, Aug 24, 2023 at 07:07:52PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.192 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 26 Aug 2023 17:05:50 +0000.
> Anything received after that time might be too late.
> 
[ ... ]

> Lang Yu <Lang.Yu@amd.com>
>     drm/amdgpu: install stub fence into potential unused fence pointers
> 

This patch is causing continuous log spam in chromeos-5.10, so we are
going to revert it.

WARNING: CPU: 1 PID: 13383 at include/linux/dma-fence.h:478 amdgpu_sync_keep_later+0x95/0xbd

This is just a note to let others know that this may be the cause
if they see the same problem.

Thanks,
Guenter
