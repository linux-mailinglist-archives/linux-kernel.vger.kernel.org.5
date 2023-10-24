Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753B77D5A33
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343881AbjJXSL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjJXSL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:11:26 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9931210D3;
        Tue, 24 Oct 2023 11:11:24 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7ac4c3666so47643657b3.3;
        Tue, 24 Oct 2023 11:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698171084; x=1698775884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0rsW/EgRuVA5grGUYgdsjE0Nu8wETyCyvWRl/VLfipY=;
        b=I/q3e5gQZPgCV5ID3xvpaui6kJKcbqNum4sIv7pZdwU/Vo/rDi673VfNapuzKbbKli
         em8o0gPXxUvs4VBN+VLooX7P1GJREGyRlQULAEN+H3TjgZPdXSiK1uqi5GW4TjJ7ARDc
         Z82MYlcv6YtnINeNKUvSLVhJYO3B0l87067KlxS3YGrTV4HYji2FeJHGVZvLf5Q5/rGa
         MRZmut4PMLj5u2jG923MlUgxuA5HEOWQ9Qww6Owv5TFSRrvKAdXPPLsIUPthDCUtcjv4
         GaxZRbYSu5NeAwHlfMlAw7so2UP7pm1bpoh/Gp48nJOeseDGr564npB97yhgRSbFUzeI
         xAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698171084; x=1698775884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rsW/EgRuVA5grGUYgdsjE0Nu8wETyCyvWRl/VLfipY=;
        b=N5kMKwFbe9LQknJX7SjJ5vjcwM8PFyHKgQLMbnOT80Y/UApQNJ1kDPrsYXJYZyFdw7
         USyA2BOnFggHBQODQ3yJ85eQ9GIABh6SwH9uFu5lT57HWZg/ia/hiJ1xp4w3T6ddJ+hM
         JLdx3UVqWhBM7hZ28P9/7hkRWLhK8CGJI2JJAKrrf1hInEwpDFOHrrkfzH6dnaj8h9rT
         iMN0vz+pqqZ7brgzYof+PImNsZaWjc7ag2zS/uxlze5OzR8h1fwRsyJFMqeQROgsDPrD
         C+2kpmxJ2uftyLyxwd4MGf4e82Imji2plCOe4cD7gyJUjb3l95LhBIH/aPxeGAYJxsMU
         LKPw==
X-Gm-Message-State: AOJu0YwaUyDdl5eVUaX+TF0IoSwc/ur3OElu0LanPR6m4ss+TyWT1EQ6
        +n30M0YEGjyN+mKN62g1smcYayvKHnY=
X-Google-Smtp-Source: AGHT+IEMCXpLO3cmz/C+HN7t8nzF5mpaQehzEgqMLJUU55Sz/ZBNdZqE/d0csOZtg4bavdFaETuCuA==
X-Received: by 2002:a81:784f:0:b0:5a7:b900:a373 with SMTP id t76-20020a81784f000000b005a7b900a373mr13518269ywc.0.1698171083553;
        Tue, 24 Oct 2023 11:11:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d5-20020a0ddb05000000b005a80102fe3bsm4289491ywe.13.2023.10.24.11.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 11:11:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 24 Oct 2023 11:11:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.19 00/98] 4.19.297-rc1 review
Message-ID: <fa45af33-46c4-4b15-bab7-e319410bbe7c@roeck-us.net>
References: <20231023104813.580375891@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023104813.580375891@linuxfoundation.org>
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

On Mon, Oct 23, 2023 at 12:55:49PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.297 release.
> There are 98 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 149 pass: 149 fail: 0
Qemu test results:
	total: 441 pass: 441 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
