Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DD580DB1E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344908AbjLKTwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344903AbjLKTwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:52:06 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3745D8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:52:12 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6d9dcb2cb45so674871a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702324332; x=1702929132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNw0BusrwKrlo9GGK5hacebZDq8UXclz0dZqKDQCG44=;
        b=fxoZr5GSJ0pBhPOhqWsaS8/kEyltM8kdsP7hq6xKyY8yFlpVLeTUdvN3aL0ZQuhD7b
         XWBn3N1om42K/JIrULiQ000bX1WwlOjR0kwLz5T123kKShVwcoPztlNNb2LR5o70KGFS
         H88w3D0LKekVsbokkvmCKrSLqfipSa/dvNb20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702324332; x=1702929132;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNw0BusrwKrlo9GGK5hacebZDq8UXclz0dZqKDQCG44=;
        b=R4/BMCViPRSAf2FczvmmaJX5FiEZn47xFQkog6uQEnY/lGD0uRMZyrDuwOVOQVeC8c
         TZUAr5TLdyRq9IkOnnLn1q9rW1/gC34htaVD5Ford9HJwlsfPpDzy1Go2Q6/0Xe1NByJ
         LxudbSe3FAsKbRQrIC295RLbFdx5NaF93xgjdKRmfqIGQq4YpUZeZJq2mFwbtP6sn+Zq
         6p8W0ThzH6v/wpd+HpDScgSSSQglt6FdMmjlYcddvepyZtZbxGNoOULOBwjMKd6zHYAb
         4HWny1jRnxXWnzh5XkHwhSglphm5P+/e6u8gHpUA5ij4yomD1e+1pVIq7qajpu9DW7z5
         gy6A==
X-Gm-Message-State: AOJu0Yzp0dlzJ4crwr+MMrTu5oe/BUkyDTCwq8hdsUCZaM+LE+3AoWMV
        gN4UYKLxObLO2Q6WjFyDG5UOlsP7pxaW1DR+8yQ=
X-Google-Smtp-Source: AGHT+IFztSJZaqgNDIycbBd/5v9onraVjBCYkUV3Y+176XHIqc/OenAwmwPiASNYdiiR/6pMFmu4HQ==
X-Received: by 2002:a05:6830:4428:b0:6d9:e192:569d with SMTP id q40-20020a056830442800b006d9e192569dmr11620214otv.1.1702324331886;
        Mon, 11 Dec 2023 11:52:11 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id h16-20020a9d7990000000b006d9d8abcdeesm1871829otm.40.2023.12.11.11.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 11:52:11 -0800 (PST)
Message-ID: <4074b0bc-e89b-4b2e-ad11-cb3a9517b725@linuxfoundation.org>
Date:   Mon, 11 Dec 2023 12:52:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nolibc changes for 6.8
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, WillyTarreauw@lwt.eu,
        Shuah Khan <skhan@linuxfoundation.org>
References: <4208adae-d185-44a6-a564-ec9bc4c6eb2a@t-8ch.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <4208adae-d185-44a6-a564-ec9bc4c6eb2a@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/23 10:09, Thomas Weißschuh wrote:
> Hi Paul,
> 
> The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:
> 
>    Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git/ next
> 
> for you to fetch changes up to b99c3b15310e7c7cd5f2d843289fe115ab3f8043:
> 
>    selftests/nolibc: disable coredump via setrlimit (2023-11-26 11:39:52 +0100)
> 
> ----------------------------------------------------------------
> Summary:
> 
> * Support for PIC mode on MIPS.
> * Support for getrlimit()/setrlimit().
> * Replace some custom declarations with UAPI includes.
> * A new script "run-tests.sh" to run the testsuite over different architectures
>    and configurations.
> * A few non-functional code cleanups.
> * Minor improvements to nolibc-test, primarily to support the test script.
> 
> There are no urgent fixes available at this time.
> 
> ----------------------------------------------------------------
> Mark Brown (1):
>        tools/nolibc: Use linux/wait.h rather than duplicating it


I am seeing the following problem when I run my verify_signedoff.sh

verify_signedoff.sh HEAD~22...HEAD /linux/linux_kselftest/
Commit a0fa60e42bbe ("tools/nolibc: Use linux/wait.h rather than duplicating it")
	committer Signed-off-by missing
	author email:    broonie@kernel.org
	committer email: linux@weissschuh.net
	Signed-off-by: Mark Brown <broonie@kernel.org>
	Signed-off-by: Willy Tarreau <w@1wt.eu>

Errors in  with Signed-off-by, please fix!

Is it possible to fix this? It appears commiter signed-off is missing.

thanks,
-- Shuah

