Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8F08077C9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjLFSnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjLFSnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:43:49 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC36211F;
        Wed,  6 Dec 2023 10:43:55 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5c6734e0c22so54156a12.0;
        Wed, 06 Dec 2023 10:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701888235; x=1702493035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cdXuM+3RECR9wpuVAjDzqo7lDiVL4BbUYlfdHlVoYqY=;
        b=F7ygcFhD4nEKjUOkXedBPXIHiiG2Gu6/2OpFRL37M+MMG1utaqbyCOnNdq7oODQFCC
         W3V97zNA3YfgHo4AVGYoS6F13Ny0ZCsM41zAmBqz0riSbOcTOYW6NzgjjtFbiCgAvBtC
         EdAtdU5VRwC2SICJiL0rmVzmr64NWd0zL1seH9d/wyjj39cB+jaFQhogBGnLA4lO97v7
         WZMaCvSWWPje1yTgXoamUaH8B1JYT0w8T19MsrwiEf1UHkTze125LnnYuEFSl/HrRt/K
         kwZ89J0jLxKonW6OOd4771bCHPhFiXRbhqErtAsloIEbtXUeNgekFq9vDzz/jHERyykk
         gYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701888235; x=1702493035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdXuM+3RECR9wpuVAjDzqo7lDiVL4BbUYlfdHlVoYqY=;
        b=RJl7vB4hxvkdXw6Wwwa4r/xzvnXsE3MBuHoTA58nJXqqR/UUnNSyioh7N1ET35/Gzp
         HiPlw7xGRV5Ml8GGKTuYRmkQjyRxCev2NQF2z1fAGi2g2r20+ivmWsaGo4z7wqqsC9Ra
         UNxzp5dY5sjA4OPUA7Z54gLJgTSVDXTpyRtNVYTBnE0nKNruP2wd0Qf0mMKOAU/IcIED
         u90tVeu/6RZiiaa50n3tfj/YHlDUY2SxZrJ2gQzfHycIA/mN11hKp3XmLuBbKIOeR9UZ
         eldz52J2NSX1b2dRvTlW7PFxVyTxV0+Pg4IoKJFvxRZ1KlZnAZHu5lSAkUoccAcyf7/7
         FNxg==
X-Gm-Message-State: AOJu0YxWiRVrkZr6JHcUaUuxR2GiGIhZ108LIyXgaH8/Z54ZpKbXlfcd
        Ctk+P2RBzI6M5uPP9jQ/MLg=
X-Google-Smtp-Source: AGHT+IEjS9sKWvSWp7drnooUQRHsOvfMPGWzpn2021pxsyVo0PWXKeAjMhgAXaxuCrjmy/j9BtuBTA==
X-Received: by 2002:a17:902:d642:b0:1d0:bb51:d780 with SMTP id y2-20020a170902d64200b001d0bb51d780mr994443plh.15.1701888234587;
        Wed, 06 Dec 2023 10:43:54 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902e89200b001d0969c5b68sm140760plg.139.2023.12.06.10.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:43:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 6 Dec 2023 10:43:52 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 4.19 00/63] 4.19.301-rc2 review
Message-ID: <b396fc77-c541-4596-a48c-fcdbdfd79a61@roeck-us.net>
References: <20231205183236.587197010@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205183236.587197010@linuxfoundation.org>
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

On Wed, Dec 06, 2023 at 04:22:09AM +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.301 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 147 pass: 147 fail: 0
Qemu test results:
	total: 439 pass: 439 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
