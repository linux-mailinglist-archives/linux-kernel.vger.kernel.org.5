Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEA67C7BA2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 04:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjJMCdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 22:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJMCdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 22:33:14 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E186B83;
        Thu, 12 Oct 2023 19:33:12 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-4a13374a1e8so620048e0c.1;
        Thu, 12 Oct 2023 19:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697164392; x=1697769192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2qr7zuO96ufZPS1iOqXbjMEn0xmlzZcOIPVy4ltN2k=;
        b=cGM3yI7GhFtZlsYyBQ/b6hti2DP644X9bvXb4N1CvuS2IFL/v1Q4MXdTl6P7L9Zn8q
         92HorFATOhm6GTnwQ5K+7uVkxoT31ZGJIAQ4wAPxFtnjM5y4Yqe151VzsSBikKjmfVvb
         c91bvb34jhOypMsJyma97xdZRUZFlaBbhEkaXWcjiw0QmIfOaucETGdraqYNfXVAzkuL
         TT2YEhIZ+z2dgJkcCHo1t1PwOisROP9bvMIU3YcT8KrszxrKrwdXjk1P7dPkt4mYn7Vl
         kgw4wMmuyqaTAC74kWEy8PQopTDRlQqBXcdzR37HHAE+mmM/JUAqWxxk20Ey3dHEmwwK
         uTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697164392; x=1697769192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2qr7zuO96ufZPS1iOqXbjMEn0xmlzZcOIPVy4ltN2k=;
        b=Ohl2eX8OpoLqNkQ4m37A20QdxmNdbJHfe3Vw6T9MIBmh6cWBybBq2mBJKKF4lGfkZL
         koE07Z8peyhxGabvASwhRo6/vYsa77gAdNWXs5eZrQMP6i9ZoB/US+ONLcOqYeDNfXFZ
         UqQfsRPb7IpJzP8+ZsV4GR7eAfmk+63+IBnBvouI9GJ0UFcIbGGqGgLv2j9LgA8fyH1n
         7TCTIAi3SoBajGiM2yJZe1ti/2j/CJ/ejiawBLf4ZrhBLfOzydyg3LiGblc3l7anFdxE
         mJa3ue4AWUxXhjAzYFH3wTXU2B/NL1b3Md3/PJerO6WYTRALA5BBRrWMU1CI3xlCLKwh
         Yuog==
X-Gm-Message-State: AOJu0Yzrhwe2Gwa4eXpyTwCG8tAtCjN+mEPbDk6kfgUGKcDK37EcePX6
        mZ7VgedIElxA7cBmALyJbgCRAf18Jf4=
X-Google-Smtp-Source: AGHT+IHymc3LaF5qB1ZpGLtIIFMfjchPFLcMnp13ploIYnVn8zZlv1a1d40OypvMwY1xb0cOsRh97A==
X-Received: by 2002:a1f:c342:0:b0:49c:79f3:27a4 with SMTP id t63-20020a1fc342000000b0049c79f327a4mr23532551vkf.3.1697164391755;
        Thu, 12 Oct 2023 19:33:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i14-20020ac5cd8e000000b0049aa0209f49sm3170815vka.52.2023.10.12.19.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 19:33:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 12 Oct 2023 19:33:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 0/6] 6.1.58-rc1 review
Message-ID: <0d61d6c4-5e73-44c3-abbb-4a90b0a27acb@roeck-us.net>
References: <20231012180030.112560642@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012180030.112560642@linuxfoundation.org>
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

On Thu, Oct 12, 2023 at 08:00:42PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.58 release.
> There are 6 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 14 Oct 2023 18:00:23 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 529 pass: 529 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
