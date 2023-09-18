Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6F57A522E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjIRSkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjIRSkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:40:45 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF35D112;
        Mon, 18 Sep 2023 11:40:39 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3ab3aceaf2aso3365377b6e.2;
        Mon, 18 Sep 2023 11:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695062439; x=1695667239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FscpY3xTC9ICVoNkL3BbrpYTdLnfoHmR+kw2SpUpWvw=;
        b=SoFdaOpX3BIIlFJ/FDOls2ZVFP+eFB1fLgvAkroT1iPjYZrgpXyJPt0XtjSy611cLt
         hh1HVFkgpRgOD2yPu0e/4wlQ/dwPabbZ8B8el+6V4YtXsHUgC9TpWIi0cISiSszcO7qB
         S/5Q5S4BpEcyTr2UmiJYGk/1MEHtWfjjzE2g/Nb6gnqnz4NNRXxjZcn9xxWs5fDr9NDu
         HfRWJvO/jC8JSIRl5pqMAHyjF4lPTZHdNG/gdNnKUK005LB5BEoZRBEkgc3lulcg8Zt5
         AADLF0P+L8vdd1L6kpS3ML1xGbJ6/jQNQgCCdwnLd6I4pULESfWoWBNJ6kDGBjSSQ89F
         TTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695062439; x=1695667239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FscpY3xTC9ICVoNkL3BbrpYTdLnfoHmR+kw2SpUpWvw=;
        b=YcIZ0UxD+PwGGseZ27iqhCILdEc/jW8oeKC2ForomHBDlDy35geMVNrSHa8wvxvLE+
         d4njerEX/W5qpvfvjn031Agv/3qnsJ4fMFY2QgyTWHNIXRbbJGySgorucXRx6QaXR5C1
         +x4hBSUQazhWIuhvogw0//eCQfBWi4PoP8B7Fk85lAdvdw2tzGWAjIxcMJ4K4S0tsbj6
         215vx23V/JSY4FqO+hy9O8VnrWRePLijvcSRnio+FTiKraiWR5QY4qMEzJp+sWgwUdlF
         O9EVuzcJ5BJAA5syvM8XfNEA5yMOnmkJYbYXDgi9b/IthI3QRDLc1FuVTfxnbacpu0r8
         aieA==
X-Gm-Message-State: AOJu0Yw7XzKKGWlHqM4XwLPZskAwnQw4Zj0fYm51SN6ZDvDpGZCASnV4
        EJO7Okmt5sTGSe8jT/1BdxU=
X-Google-Smtp-Source: AGHT+IFSfcF+Y0rWXSYJZYLkg2/5WLf/M2X0h66+gaIoVGOKpcPT50Hbi8lKYP8di/g1NknGYFjgBg==
X-Received: by 2002:a05:6870:391f:b0:1d5:5d44:7404 with SMTP id b31-20020a056870391f00b001d55d447404mr13120346oap.43.1695062438706;
        Mon, 18 Sep 2023 11:40:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gk1-20020a0566386a8100b004302370a169sm2870493jab.157.2023.09.18.11.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 11:40:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 18 Sep 2023 11:40:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 000/511] 5.15.132-rc1 review
Message-ID: <d51e5236-54b5-40fd-86b8-c19a16f56904@roeck-us.net>
References: <20230917191113.831992765@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
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

On Sun, Sep 17, 2023 at 09:07:07PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.132 release.
> There are 511 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
> 

My tests say

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 509 pass: 509 fail: 0

However, trying to build with clang (as done by ChromeOS) does report

fs/ksmbd/smb2pdu.c:6256:6: error: variable 'fp' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
        if (work->next_smb2_rcv_hdr_off) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/ksmbd/smb2pdu.c:6367:21: note: uninitialized use occurs here
        ksmbd_fd_put(work, fp);
                           ^~
fs/ksmbd/smb2pdu.c:6256:2: note: remove the 'if' if its condition is always false
        if (work->next_smb2_rcv_hdr_off) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/ksmbd/smb2pdu.c:6248:23: note: initialize the variable 'fp' to silence this warning
        struct ksmbd_file *fp;
                             ^
                              = NULL

I guess I should try to add clang build tests.

Anyway, smb2_write() already initializes fp with NULL, presumably to handle a
similar problem, so maybe doing the same for the read function would be the
easiest solution. Note that the initialization was added upstream with commit
2fd5dcb1c8ef9 ("ksmbd: smbd: fix missing client's memory region invalidation").

Guenter
