Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E030A80147D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379577AbjLAUbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAUbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:31:00 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D9C10EA;
        Fri,  1 Dec 2023 12:31:06 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b843b61d8aso632691b6e.0;
        Fri, 01 Dec 2023 12:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701462665; x=1702067465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SmWwVjROmEBWXhhUWxe/J66BmaEO8046zm5J7gWNdho=;
        b=lyXp9MunLkFCfmueDIEHSzGToDquCL7NYal6vY3kROy3yjjcjTwwXg03oSvdlqgQn6
         kXflRabl3yQ5g4+7LYNb5Rn1/QG1JdSo/ITN4GWJI5YRd8t4kpKD6NTjcFoSN/ddlbSw
         hM/xn8gpMS8DiYhPN8Spq8ICafKZ10sp/GyCNrE7a212KJszNvb9FiOOzkjNvdEHdkb0
         6jTN8sQm0hbLOh3YIaKmWcEspv7uN53EFof/aHxhk/ca2cSawaJpwMnTO0NavTmManLk
         OA+RImrup/hUjPec9kGNmspNlkCrF0RqgfKtJ362zUzV0Ot08jmco2fE1XYy2//ASi2Z
         7C8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701462665; x=1702067465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmWwVjROmEBWXhhUWxe/J66BmaEO8046zm5J7gWNdho=;
        b=j5AFPrHwT3OUOIq3gKMk8gLnFZ7czr+iWLklccLMUU3vriKzu7NqSc59f220oZ9FQq
         7rvHp1WwZ0bjr0ba/M2x0IiPNDHhXQEVpgfbzYmaOckows8jddi2UYWg9HgnEAxfEsf0
         daF5+6Nw1iuhYiBD6OjZkRFR6SD0CEsy+xsVV4c7yIr19N5OIfqDWQBf0k3FGeHbWzgf
         OjhJrdWLGDQVb67HQEjqjf3mkmIAt1XA5oa8LsJjzoZa2vTwEg28y4/CDmzgJwttqNh3
         x4HAXLeZLSISl08oVu3QdGr1e1NsBOAXUU2uObxna+og3dTnWQHqsJYD7rs6Yy+WwHbq
         x4Ng==
X-Gm-Message-State: AOJu0Yybh9mczb7ENHU4Bt7bUbBCf8Id8e6vEtYCA6tOYyIAJCo3bb3e
        oNXppmCtBB+cFHVWYEFMvkQ=
X-Google-Smtp-Source: AGHT+IG+dEZfs+IGd7jRnQ5/CQJAH9M+/2aYZ3NM/KmOzK0+5/6Vy/bcyc5NKgAXg7njXm49LmCZYw==
X-Received: by 2002:a05:6808:14cb:b0:3b8:b063:5d69 with SMTP id f11-20020a05680814cb00b003b8b0635d69mr86605oiw.80.1701462665697;
        Fri, 01 Dec 2023 12:31:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z26-20020a54459a000000b003b845ba61c8sm671265oib.12.2023.12.01.12.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 12:31:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 1 Dec 2023 12:31:04 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/112] 6.6.4-rc1 review
Message-ID: <34b46642-7834-4fcf-9112-954688faf0c2@roeck-us.net>
References: <20231130162140.298098091@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
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

On Thu, Nov 30, 2023 at 04:20:47PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.4 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 530 pass: 530 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
