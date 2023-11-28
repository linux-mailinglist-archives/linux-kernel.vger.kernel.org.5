Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6617FB08B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbjK1CxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjK1CxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:53:12 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428AD191;
        Mon, 27 Nov 2023 18:53:19 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6d812988394so1720192a34.3;
        Mon, 27 Nov 2023 18:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701139998; x=1701744798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F2ex07nmMjEWp2BjNQtRG363aSbn2cAhcrhyQytjQ5s=;
        b=EOaE7dX+YJENtPsTjFcEF40BQElWL3OtLayzjiaqBqJQbvfJ6HUPWCxjOJDmVTr/TW
         gLMmue3l0BlzE09acZZL0es9audEiIEUhQzha33U+jq85/UPYJ5ahct02s4TOucaaMGb
         QbW3xnCPrBmaDGD5uXKspCpy27psVv8zxY711ie6nKdJUYDMjUCicxED3SxasOBU8iPj
         Zd0XPWA8m6QB9Q+MmfdUsINpHRMuF7W8WXzpjaTZa506OyrMLU0v8SeBVWdqXwKvnriH
         nQDUgjNXl828EajsiQxOwS4fSve1qfdC9m0gvMPzJjOdfi3zyt+Fpx4QP/q6/9iqr3++
         suZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701139998; x=1701744798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2ex07nmMjEWp2BjNQtRG363aSbn2cAhcrhyQytjQ5s=;
        b=hnfgtvPRGIy5OfM6Xg3ww9q0qasSinUI+NXCEOZYBgB/VB1Si7cYiGzw31kJdGXmxm
         7yiUhuSIEOES+6zcsVYxU5PJfpV7dG+Tc3hroN6hs6SnVC931K4BYfbT6XHTRM7jh9To
         ZIEtR+8MQqfw7d5t3+vZn54Ykqyvp+F8Q/zZtlS0IJbeiM7ijnLWHOXt67NAMjDPSldF
         Q2o7Gu5lzRjfSdZUXNNqXKn99e1HtFFK4PN1ExLGxypWGiL8hEEV+P1R4r+YgAPV5Vu8
         KGtqo/+13Qh2YnLrZVKx+k/WnEPkl5pLSw4U4koECgk563Yocg2Wu1rzfO6D47e/Zdtj
         lB2A==
X-Gm-Message-State: AOJu0YwzXzxnzWK25ZzXRb04V4VH53cDmKQt9zeqLFyhVd1WjsY9hnSi
        uUvzO9kArZwUSFv9EomHO9s=
X-Google-Smtp-Source: AGHT+IFUHJO9Gq4zHuXz6o3de4wZBdfUK2vNxGSjqTwOLYyg6bhTxlqSjFrho3mTVlrq9LaH1mmTGQ==
X-Received: by 2002:a05:6870:5587:b0:1fa:3699:3bbc with SMTP id qj7-20020a056870558700b001fa36993bbcmr10100189oac.41.1701139998266;
        Mon, 27 Nov 2023 18:53:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id py22-20020a056871e41600b001fa39dfef88sm1198357oac.37.2023.11.27.18.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 18:53:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 27 Nov 2023 18:53:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 5.15 000/292] 5.15.140-rc3 review
Message-ID: <0b9a7fdc-907e-4233-90be-ef36e8b2c3d6@roeck-us.net>
References: <20231126154348.824037389@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126154348.824037389@linuxfoundation.org>
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

On Sun, Nov 26, 2023 at 03:46:45PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.140 release.  There
> are 292 patches in this series, all will be posted as a response to this one.
> If anyone has any issues with these being applied, please let me know.
> 
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.  Anything
> received after that time might be too late.
> 

For v5.15.139-292-g659e62181100:

Build results:
	total: 158 pass: 158 fail: 0
Qemu test results:
	total: 509 pass: 509 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
