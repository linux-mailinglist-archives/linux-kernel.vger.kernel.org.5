Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9896B7C033B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbjJJSRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjJJSRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:17:31 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F169194;
        Tue, 10 Oct 2023 11:17:29 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690bd59322dso4462943b3a.3;
        Tue, 10 Oct 2023 11:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696961849; x=1697566649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNqHJZlLp2DlYv05rHCGAAH563+Pb/c+Yyrz4TDUeMU=;
        b=DzxVzLt+kxGsQYJ+XG0HI9JeEgUEN32v01EzNykObVX2WGA4YkEsktg1Az3ehDGNKy
         NAb+QFcr3r2gMOiK3ZHef7/93tHkR/4X70QacLM02E+jg942cXxlcnumn5fXbkKf/neI
         SSDCBnbcAKK+srLNCI3SL+XaWnjXFEKLftxMd1aLNZdcDiSaZheE7mhQ7KkZOyS5t+eA
         aE8OaicKYROfApDjuA8BOzRAfMwShTJBTxXd3LssGZJrVPyfJkgDtvSaA28jxRW7dZLV
         G5l2+M24ro6gqxWZixNfBCOBcj67a/slh+O9oCBhrI9w3KHNfYokI7DfOo1mO0s8tmpC
         HKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696961849; x=1697566649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNqHJZlLp2DlYv05rHCGAAH563+Pb/c+Yyrz4TDUeMU=;
        b=AXQxMyX36NFKZyDiwJNioqUlT3XDGyzBSg/iuFlupth8wRwgvzWo57lKYHPKJr+MWH
         wtCzUGX825Uk4d5TBHzmQAHzOqZxzXhpHqCKIbWOT2st5O4IJQYr26RUkEbWatqsSrFe
         WA+GkYunFLd9Lu/RydLMpikC2yggBJwW9qvSzxw0XlJ9I8myST6e5nTzWlSHkuG3jYcd
         fIAmdd3tnMwq/1Htv6/RYxV0io0XG48lPUghrU2ZnvtbjE4XDqNN6h5bPBlQSqam/Cdb
         /7zwQyYUlkL9owIf+sl/2nv+sL0w2GbdCFlukIGhHrWXVBLigrSzkuoDnr6qVsl72gqA
         9ywQ==
X-Gm-Message-State: AOJu0Yyn3IyHwQNPwHdYJh2N2nPOdflY+7iGSwzLw2D7p/5D1zvprnmV
        MHwfIyHxscoVuzoTrEr1Ck0=
X-Google-Smtp-Source: AGHT+IHrEjxq6/EpCricAhgVsA+f32HbTd1xvqgooxheYAq85G/opDhU56POYroDxWaoKRBqGO9Gng==
X-Received: by 2002:a05:6a21:181:b0:165:186:1560 with SMTP id le1-20020a056a21018100b0016501861560mr21206963pzb.53.1696961849279;
        Tue, 10 Oct 2023 11:17:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fk3-20020a056a003a8300b00690ca4356f1sm8573946pfb.198.2023.10.10.11.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 11:17:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 10 Oct 2023 11:17:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.14 00/55] 4.14.327-rc1 review
Message-ID: <19c85171-e189-48e0-a9b2-28d718380422@roeck-us.net>
References: <20231009130107.717692466@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009130107.717692466@linuxfoundation.org>
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

On Mon, Oct 09, 2023 at 03:05:59PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.327 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 139 pass: 139 fail: 0
Qemu test results:
	total: 440 pass: 440 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
