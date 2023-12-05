Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E6C805C69
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjLEQsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLEQsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:48:12 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7237188;
        Tue,  5 Dec 2023 08:48:18 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6d8d28e4bbeso1951222a34.3;
        Tue, 05 Dec 2023 08:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701794898; x=1702399698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4F+cl8bqviYCfWVifl1IWgKB6oJF4gmJXAutfvfQxKQ=;
        b=bX8dLM53NfObCqscJ88i7M36eOBIHvyQRF/HP9rB1G5gFqvfvCxPtMFlA9DytfTolE
         1yrNdxqKl5gCxgCxmKQYRDkbAkGmGR3bVT12GLNCRyME0nf2j3GP6CdGYPtd1Qopfct2
         8rP3iAVHPbGqMf5BXGx5oCh5cfRbILMHq0OPoCezNYkVCFnMcFqeG/TfDga0LvPlHV1V
         dje7nZ7aiJIn7+6AWS+WM5oBej7e4/qxDFNKzka78V+qN/a1lVXUq5L8WEc+hcDeD1Ez
         1K9t778E0a2xJvvlpcsXYIKPGUjo2XVhipJDl9u1wKVsoAMgwy3mGnNC3X0C7BS8p08H
         dSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701794898; x=1702399698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4F+cl8bqviYCfWVifl1IWgKB6oJF4gmJXAutfvfQxKQ=;
        b=BDZRAq0MNRgaevpxm9mfUg7hdFpn6ONeUdLBUhyM7WzEWzU81eWeUp+j09ovz/SvG2
         /jimqjc9NjdDkQ7WfXeCLHeKUGuDFHLgbSfEinbZ9Pc0/7up21VaV2s3Q7tUQQxRTnXh
         h1ZGy90l45naH6rXsOUMB9JRSWYxIyPIOAYY06QXUIBfUdU26ugB8+YxYwNzuXAAfCu4
         ZbqtJcquDj2TpwAyM8Dgc9e0O1sACEC6Tcimu0lSxJNyWxRTHNSlfGBZvzZiHH4cQHeT
         g0W/9C5XMheuhzQXL56i+jQfx5aU78ZYKiS4ZLRPHgUl1hW8lzI+xMHAcvqDCobpATfF
         6Y3w==
X-Gm-Message-State: AOJu0Yyk18ISsHg554TVk4hzWDUjTdZqDITZR6zkfpiuQ3t7/OByt9PI
        UBf7AllOirlaWTfdXUS5Abg=
X-Google-Smtp-Source: AGHT+IFNL+2khA0N/44s+bMmXXd2EwayAYlVrA3MCsA66rjsp9s7dopeeGCPN5NT2LI09aTlvlRh5Q==
X-Received: by 2002:a05:6870:e242:b0:1fb:17ff:2a71 with SMTP id d2-20020a056870e24200b001fb17ff2a71mr6434826oac.50.1701794898014;
        Tue, 05 Dec 2023 08:48:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id nl18-20020a056871459200b001fb31d5c733sm1674470oab.52.2023.12.05.08.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 08:48:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 5 Dec 2023 08:48:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 5.10 000/134] 5.10.203-rc2 review
Message-ID: <d128c8cb-52a5-461b-aee0-6e8159ab91d2@roeck-us.net>
References: <20231205043610.004070706@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205043610.004070706@linuxfoundation.org>
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

On Tue, Dec 05, 2023 at 01:36:53PM +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.203 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 04:35:38 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 493 pass: 493 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
