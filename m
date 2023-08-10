Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDE5777D1F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbjHJQCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236508AbjHJQCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:02:06 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B442728;
        Thu, 10 Aug 2023 09:01:27 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bb7b8390e8so8377685ad.2;
        Thu, 10 Aug 2023 09:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691683286; x=1692288086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCfWx3vFJ83mA2KZ0trVS84UlW4Ht+rf9HMJonRkhK8=;
        b=Pw0qghx/IUvl8RjVtfj1jkxgtwFx1jIJSJWi0ylXipW1SrhFqZoHbSlgUfVZZZ3lBp
         zUeo319gawOMYitBuu3FvynPaBD4df68XAhTBL5d6A4c8eTu11A/sXYQ1laEy6Nsv948
         Bp+231u8iPsDZL8SgOmV7V5Rlu3EGIh/9INP61M5VyoX056rJvP57F7P0y3O3Fmke+5p
         9gnfKmnHsT9dqwRRaKgqe3lJyH6jEI+gsts2VrOr6Q0+/RO+cr3x1v50bvv3J0as06YP
         8P5LIQnMp2FEz+4Lnigkmt3/6kxvSblHVmsOg0DCeL72hStLqSNYFjN2UFKgwx1X2zM8
         HVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691683286; x=1692288086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCfWx3vFJ83mA2KZ0trVS84UlW4Ht+rf9HMJonRkhK8=;
        b=MEys2vgBLGdzkLjAZh1lTqfCj8Nk/JllvvqHBXuOLyOuQQJp5WF8ZPpll8q7t/GZta
         h2M5zbaQ3JFY4EyzONtbWRHd4sfhBgRiVflsA4O5RH/Jzd2o89wA9K5ObACKFNkvNq6I
         l/2CwC7x13rkwJwk3aMziJCszbne1kXjcLG7JOSgSJdbnkuk+C4ev6EaIbnCvRwnvyzK
         mPcqTK+WSIXmogltrZimYDz7aP27vEAiYnId59FsM/i/8xjZ564GhherhJZ2ILdFRweC
         2IL/A/pZgVMGfqYBWGYxBqopzDSv63vet8gFasewRd/TcwmGrF0K7+soq4MYfNiWFe7G
         SRfA==
X-Gm-Message-State: AOJu0YzsuBgUQ6afTgJHKvCSjonfBIc/xjm7o1a2XTFQoOsK5zOkgZVG
        C2RYM55hxY3qFeghNnAOrp4=
X-Google-Smtp-Source: AGHT+IFzPJh6ZXg/SGfsGGVshu/4ERE5mmrJboBsvd1OozFBY7TNudilX6BZfO6Pty1CgVu/A1zpMQ==
X-Received: by 2002:a17:902:aa05:b0:1bb:c5b5:8353 with SMTP id be5-20020a170902aa0500b001bbc5b58353mr2302926plb.4.1691683286127;
        Thu, 10 Aug 2023 09:01:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c11-20020a170902724b00b001b246dcffb7sm1943744pll.300.2023.08.10.09.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:01:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 10 Aug 2023 09:01:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.4 000/154] 5.4.253-rc1 review
Message-ID: <56aba1eb-ea51-4c9c-adf2-a4b8aa8f8814@roeck-us.net>
References: <20230809103636.887175326@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
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

On Wed, Aug 09, 2023 at 12:40:31PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.253 release.
> There are 154 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 154 pass: 154 fail: 0
Qemu test results:
	total: 455 pass: 455 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
