Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D268077D6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378940AbjLFSod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjLFSob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:44:31 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53B1D53;
        Wed,  6 Dec 2023 10:44:37 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6cea2a38b48so126745b3a.3;
        Wed, 06 Dec 2023 10:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701888277; x=1702493077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnaxgfkiXgtg5q1WFZwHiIF9qvQwoLET9HzIgaLiLzA=;
        b=asrFyh/4eGYyB+evdbyP2KJM/NHCgclxneVme/rxO3DwvnkBKHy7J7L3nS6OcTRgae
         GeRZXLa+ySvXaPTzMWGCPbtfHKktQSJFnGy1xQxdL1+oMYOeewnYGc9oPeuo+uTgke5e
         iNrxeGxdcXSm4qGshIedKYXkuye+BVi2HUJTRafYHZ/0RchInhsQjyom3YFu0uWxn2kT
         48yJ81Z4HSw3Qq7rLPwz8c5Ywq6U/8CWOVD+RUevNXQSpXn7MaAIpfwfMV/heyfkBHlB
         7bgxJBm3zAAn+7i9DKtA/Xs+E5Tw2WVyaKNeCA9INFwPt7TFoNmgGPt9AylRI6F4Fr7O
         aHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701888277; x=1702493077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnaxgfkiXgtg5q1WFZwHiIF9qvQwoLET9HzIgaLiLzA=;
        b=t6qFprfX2QqinV9fqUzSnu0YLioy4xS6Cf2dJTFjvnV0wd5Eyjz2o6IH3o7PqndL8F
         2pUvuUAf5PoZSAiKsmji+1gXlfycfyT48yorJLS/tvOTvqBk9Xr0rqJIxfYWweLTpwmC
         snJmeMLlqgCKGEbC3W6KOIAGRh8xysmzzaRwu+9lgCOqb8bmbmv977eY9sSCQYKYIPXq
         pSlGwUUU5g9AsEgJUO5Rj9wA1VnJsBRGN0zclacUo42f8DWo3Pk196RktEquu7XUih5K
         6ZjB1nV77NgQ0bYdhFONo+NyU20FRJExKGY2kSpr1hscS7lFFBU4dKxjA59kpimLq6iY
         LZ4A==
X-Gm-Message-State: AOJu0YwJgzPoxHK7iqyJHNAFVGBiKjdk1mba5ysgBW4AZtUpsXwYaEuc
        7TZk7GR5zViAZkMuE7QNULI=
X-Google-Smtp-Source: AGHT+IFcCGSlNJ87ePdiNLXx2zvfxCBK7xJK64DOejojIosppVqLQqonHrsCF+h+LQVhkk2kSoqlJw==
X-Received: by 2002:aa7:9ed0:0:b0:6ce:2731:e871 with SMTP id r16-20020aa79ed0000000b006ce2731e871mr1163893pfq.56.1701888277214;
        Wed, 06 Dec 2023 10:44:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m7-20020aa78a07000000b006ce538550bbsm305874pfa.74.2023.12.06.10.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:44:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 6 Dec 2023 10:44:36 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 5.15 00/64] 5.15.142-rc2 review
Message-ID: <f400ca67-5c9f-4f22-b554-fa2af062fcca@roeck-us.net>
References: <20231205183238.954685317@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205183238.954685317@linuxfoundation.org>
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

On Wed, Dec 06, 2023 at 04:22:31AM +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.142 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 158 pass: 158 fail: 0
Qemu test results:
	total: 517 pass: 517 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
