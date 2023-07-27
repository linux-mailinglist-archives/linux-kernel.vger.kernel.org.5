Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6C17642CB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 02:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjG0ACb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 20:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjG0AC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 20:02:27 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED55F187;
        Wed, 26 Jul 2023 17:02:26 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686ed1d2594so398922b3a.2;
        Wed, 26 Jul 2023 17:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690416146; x=1691020946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5wWjdrwKhVRVEE6nQr8L88YliKH3+1GB9KWcwTuWbs=;
        b=a9hgsVAdwLsCgAg/5xgi5IAvJPBN48C1EUx+SCnSxz85ekjTrxZkaZp9R42tJMgSjO
         oJDap7cN22A9WEhQUWDBIf5RlLB6sTvkq+nAenxcHhIe9PQQYb+RXsbVExiQdToH5PIQ
         JOarIyjZqtoKV1WW8GHYoSn+d6YYn1snZ7IEopqjgbL9fK0USH/pokwXoFC2YugGbCP/
         F4Jk33mnuVA9XwkNCYJ9BZKrjbeZVVthpZ4z5bSnSVcU7SwpWxB3Rc6kab+i5mrSyewY
         zNuepNNv6DgUYedWUnAQb29WrlLtkgIoEJa2lefMdat87wC1oNvXA8IeKE/02UkK9Iya
         IqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690416146; x=1691020946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5wWjdrwKhVRVEE6nQr8L88YliKH3+1GB9KWcwTuWbs=;
        b=CwCB57TyEubSzwVfdFK/78HWyzLJzR1MjfrUsusfYEK4VZcKUaPLb//VDAOU5Jvjj9
         DG5canl4WruKglDA9xkR+pRB/l8LDSFzRY5BKJXiIShKd0ARlJQepYwTFI33hPlCTCoa
         MJqU5llXZzjhEa2OFA5smUjE4BU/E7SU2TTXO2j7TOLvaZa5mh4w713wb023hjWDHbxW
         ypF/k9ZFGMAL/oOQyYQRZQiaPqP2bHeZ1xa8/l5SEBw76JZbz/iii3NnU2n/hQYaLmyq
         wGAQCJQCGYaDcSp6yYw03Q90Y1LWLHYCgLE8kqNO366ANUC+nsOKDvmRRQmKjUSSgihL
         Vl5w==
X-Gm-Message-State: ABy/qLZTLcY5iandwRyCa04UFn5fMhgpefoRWq3xQEcGSWt4rx43pC3f
        0LTUyrkAJ+ZkAL7M9gIQVmhsSWGIOeQ=
X-Google-Smtp-Source: APBJJlEX3tbTv3XuSjbLHFzzYqV6bEk5Pdr+SjNgG6iRnw2HQyDwehAtTdwxG2+SmSUMACmnGiNDpg==
X-Received: by 2002:a05:6a20:3d10:b0:133:71e4:c172 with SMTP id y16-20020a056a203d1000b0013371e4c172mr4484438pzi.15.1690416146378;
        Wed, 26 Jul 2023 17:02:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79211000000b0066a31111cc5sm154771pfo.152.2023.07.26.17.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 17:02:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 26 Jul 2023 17:02:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 00/78] 5.15.123-rc1 review
Message-ID: <5f0df923-d2c7-4e0e-8715-fff8d6b52aeb@roeck-us.net>
References: <20230725104451.275227789@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725104451.275227789@linuxfoundation.org>
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

On Tue, Jul 25, 2023 at 12:45:51PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.123 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 160 pass: 160 fail: 0
Qemu test results:
	total: 501 pass: 501 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
