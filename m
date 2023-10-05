Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726547BAEB9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjJEWQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjJEWQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:16:53 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D821C9E;
        Thu,  5 Oct 2023 15:16:52 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-351367c940cso6348175ab.2;
        Thu, 05 Oct 2023 15:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696544212; x=1697149012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6xdUKLPOqUuE2xOAqvscJ4AB6qNam9+2x2WqgjeUiEU=;
        b=cjafcYSDwzOqZC/RLQMtIsJRXLAVIjtlZxBUN7Ar8DBDps17B4sHYYQazwUtcH9FsV
         ytCFNmaiBkEfAnjopp/G3S0c+5I2f+zeD+S3hgrFMhMBBhrVnd/LzfRkb1KYbPbCh5BT
         lTrFXNyoSK2O1fvC682aOqUaV6W1p31t+QaOYiz9LhQQ7BLu48sItqmkepGa2yb9P9Ze
         WwFMZF3fAdKZf8l2yi3qMlXC0qGMY0faerjajSjg1e8wL11XfJNEAxfQQ0rDBo/W5fVf
         zbfxv45yGUhNSzTB+XK8W+ggKbiW4Hn2bWosrqlL/6qF6YHLeElrIQaOnHG6TCHnVPc9
         1tng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696544212; x=1697149012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xdUKLPOqUuE2xOAqvscJ4AB6qNam9+2x2WqgjeUiEU=;
        b=mMaJ+iwxLl7sC0j0nY9YOqGHU7r6QfjZspNvmeXQR0BqsR5jXjI352jXDE3gHH/UyD
         xFAkJESmSp+Qr1cuaNkIawg5nAfYoDnJ7vMswjM+zRD6ygIUAlgsW6keVWNuaC3AfnxP
         93sL2I8ZGWdb3l+7VXIL47ps8ySmphy0EeoxNPxCnoJw/2TZiFZrI2Hq1wicveWQyDTf
         zzQWzp+P1nfJIM79UIplecShUHEjbXLJfo1lkAkxHRB8vrIkCbKInREbS5OTwRAv2y4s
         /TbGa0LYl8gTAle4eFkzqvPeJdiWBm8Cwm9Xwv1P7sOr1fU0HG9QRAYk++x2rMpbvbq1
         pfbw==
X-Gm-Message-State: AOJu0YwwEWyIAUfrBshJiqolMf90jTG2/vYMzbnmHgVLGhHBgackFr3C
        LyhnD/2N+9/3u4pzhS7GyHRgWjmWYFA=
X-Google-Smtp-Source: AGHT+IETd2PYHBWusTq64RYlc8DdrHmJoAoReprpnKGOC870mvvtLHRJYwLh87EM3yYncQLWiq+7vw==
X-Received: by 2002:a05:6e02:1be4:b0:352:749b:7210 with SMTP id y4-20020a056e021be400b00352749b7210mr7665099ilv.18.1696544212159;
        Thu, 05 Oct 2023 15:16:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v10-20020a02b90a000000b0043167542398sm39135jan.141.2023.10.05.15.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 15:16:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 5 Oct 2023 15:16:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.5 000/321] 6.5.6-rc1 review
Message-ID: <f8ea806b-87b4-4eaa-b6c8-1b518fc202d2@roeck-us.net>
References: <20231004175229.211487444@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
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

On Wed, Oct 04, 2023 at 07:52:25PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.6 release.
> There are 321 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 530 pass: 530 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
