Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA57978D204
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 04:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241697AbjH3CZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 22:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239290AbjH3CYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 22:24:50 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE637CC9;
        Tue, 29 Aug 2023 19:24:47 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-792965813e7so124220339f.2;
        Tue, 29 Aug 2023 19:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693362287; x=1693967087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lIPqgFvDaI9bwZtognGowvWWbSTHbXBUdbdWIzJhIjY=;
        b=eB662TuLRe1aBIf9WUVIgRzeRkHtSnAthd5h5h1wT8pbyZZl4nFmrWg9UzIGDfrXjL
         RIalzUstqytmSi19Mdaxtf2fngAk05BNyQI46SNJoR8l2k6Xx0xhCQlVR2WBHa/YaLjQ
         9iDbtc2qkgsBgwBxbEEQxeY6ykAClAcCD8KWaEDYLad0uJLioxoeE6PnpVTXpngKal5X
         1k4t7KhP/GCj1xOjZiTRYvbVW4FFqIohe7WsGOQfBHtFCdy0KI1yccqKAdeOKPU9RfqN
         A9QOU1m+NqH6k6FTv5+Y1c6PtwuGuvQhkh170+8vzqI9sJHPq6LXufFP+sBWt+2u29q0
         rAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693362287; x=1693967087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIPqgFvDaI9bwZtognGowvWWbSTHbXBUdbdWIzJhIjY=;
        b=SIU1TM0vXe94vSSy7YTPA3B4/TLZ+fwVKCnbBBooxAl/IrQwxujh40Z9HRlzyUBRjB
         HV3XGiRuhoOfQemoXqllyryBLQy4eHAuMZqTcqV8zGCzlL6+SHROp8n/X+4oMp6FVm9C
         6/dfNB9cGZfQQtUPBHfh75XTWRVQB/FgYiL2fr/bFEHixNFNY4rejnID/MF9U6CJ0l/t
         MggyuMAGBqXWCIcvv4VmeBil6w1Kfuf68MdIgxnsoFy2ZQJTxu7Pu2LDuqZIBfC/9kcn
         E+p06vJhRHOS9a5Zwk0UKPzsBiRnWDXmf0mD1svZI+MgCw8QUuA8XQRwCXwvawSIUz4w
         unCg==
X-Gm-Message-State: AOJu0YxiJrFM/Anh7Bg7GMl8LavTqOYBPQExzvCsi6sKxqL88Zyqs2oY
        R6VlWyB6XEVXC0VOIZyx8Mk=
X-Google-Smtp-Source: AGHT+IHqfFMD5BTfKENln/kG2oDw8tsQJmbAo9w8IHgr0LcdjC8+0MpqVAkynVn2NOAHHvxjv40C/g==
X-Received: by 2002:a92:de08:0:b0:34b:b16d:aa38 with SMTP id x8-20020a92de08000000b0034bb16daa38mr1206283ilm.29.1693362287171;
        Tue, 29 Aug 2023 19:24:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v2-20020a92c6c2000000b0034ab6f53e23sm3492402ilm.28.2023.08.29.19.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 19:24:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 29 Aug 2023 19:24:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 00/89] 5.15.129-rc1 review
Message-ID: <f2b014ac-707e-4c78-836d-b0ccf46a4de6@roeck-us.net>
References: <20230828101150.163430842@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828101150.163430842@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 12:13:01PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.129 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 501 pass: 501 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
