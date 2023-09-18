Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C5E7A5233
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjIRSln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjIRSlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:41:40 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617F310E;
        Mon, 18 Sep 2023 11:41:34 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34fcd36c86eso8716695ab.0;
        Mon, 18 Sep 2023 11:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695062493; x=1695667293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s4pMJlcBx7Iv5N3R0L03IsAsqiIz37MeRVBUdijoEyo=;
        b=aNtbAW5ZhdL/VgSeA1n+UU/S3Id4Mi/uKKuJ0mRXqG7QmSelChxlcR8KUHRUM/No4R
         Sweb5hLWL/cFS9IzPwp4BQmtB9f2O9Cbpy+gwmRKDo1owh4SOLdxnHtN7MG6Voixbm8Z
         cUkTVlZLG032zbH9Zz11MESMyuEBkAHDY90PhrK2k/D81F8Xj6KdWTMJ2HjdqPDeJk/s
         BmuD6ORlX9wIIUl3xwlvf2J3IMOglZgCgwHEh+iUUeYTwTsJ+dp1g+/aa1nV9Hv4UeV+
         zevQg80KsQ1VUBO1LRRY8WIByKC3mal8pRxRpAA+zO94CfU2BNleVZp7fK1C/vEDkXHb
         aj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695062493; x=1695667293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4pMJlcBx7Iv5N3R0L03IsAsqiIz37MeRVBUdijoEyo=;
        b=tkYpJi3z4C5jyOzSzmN7gRsQXQOlijjZvlPXZ5cQdxhjnn+jvvFb5y/41vjuKPNUFd
         +va7qt1JcQWdIM7PNdE4w42O8FxYEasW36bBuG3fMeDJQ0eVlqT1Y62F+TJkmWEhmaWb
         mit8Fk57HifeymvEnIT/Kb9iWOsSRT9TRWRuSetCSLHQzwjx9MXbu21o1mIYkeOaU1qv
         bKbqKMzCHDd0CFeF/5ERA+Vur6aOViTaF8P9l9N6JCLNzFF/oClWvBhqku4my6LWwBey
         35uzWDzPYSqia5fqyncjnYWYhyjW3GkI0fmQr7v++ilaPedxi2I3ss2yPeKCAJEEeqkx
         A5jw==
X-Gm-Message-State: AOJu0Yy/68kn17CYkn9vKYfJLLOuWE8YHp+uxAp5KHTFd+Np7ZhhM9LW
        fPq+IRmZf+4xrbkEU707wlHC52glRwk=
X-Google-Smtp-Source: AGHT+IEtS4MnfBIjLj4uPjcgSvARC/uLLok3Ub1KvS+X+c0NM7hmAeuYY8ScgDBA4ydgOkc8dypTJg==
X-Received: by 2002:a05:6e02:12e4:b0:34f:203c:2432 with SMTP id l4-20020a056e0212e400b0034f203c2432mr14553894iln.12.1695062493686;
        Mon, 18 Sep 2023 11:41:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b11-20020a92c56b000000b0034fb49fe2dcsm2786559ilj.58.2023.09.18.11.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 11:41:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 18 Sep 2023 11:41:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.5 000/285] 6.5.4-rc1 review
Message-ID: <1463f73a-b9a4-43c3-a02d-11af57a838ea@roeck-us.net>
References: <20230917191051.639202302@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
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

On Sun, Sep 17, 2023 at 09:10:00PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.4 release.
> There are 285 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 530 pass: 530 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
