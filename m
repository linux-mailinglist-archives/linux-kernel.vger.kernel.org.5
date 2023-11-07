Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4E97E46A1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbjKGRPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKGRP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:15:29 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA42810A;
        Tue,  7 Nov 2023 09:15:27 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a7dd65052aso72626177b3.0;
        Tue, 07 Nov 2023 09:15:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699377327; x=1699982127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2g8jDPpSWd4rfNQp4XblzxoeaX9SXaeroV6LJ5acpaw=;
        b=uqnAtCc2dofFYuzfZqCFm6PzMhbxL7ud151y7lVaXpERgdHs2bpN5D9Krtu/rU8KX6
         uwc4ZLozJKVXG6pdg2nhbG52TCpyB+IE1IikeFBpPCs9tVFSx2zZzewMeWcvccLpPbZs
         8+kMJakhHtTwVOAvXcAv31qPyFcbQev1saFHaaJBu4ViJ0bYZsEX/SZBvMK3sgo39C4L
         n+rn2cpPqCPMzh/PEKf9udRjj0h+Nlit3Ivur7Yg/Wiw0on+I8mg8d184oQjh80xHb/x
         +9hbjOweZWcjjPpdLPROj+1cWavpMOAh/lvsz2rYLqN/neAubNPJwmzwpg7Pl4f68lPd
         LSNw==
X-Gm-Message-State: AOJu0Ywxm04hRlk9FMmFyK4MfLK54T/2l1LzHk8AZUugEDKw7XaUI0V1
        oIGVjohWSoTLTdsrhGsGiME=
X-Google-Smtp-Source: AGHT+IF8FH2D09mlKrobTjV9en1jfV6JBlPNLYCJarJIEd4EX45IgVWo9/2skiohK66dVdl6t426AQ==
X-Received: by 2002:a0d:e2d0:0:b0:5a8:1d0e:ca6 with SMTP id l199-20020a0de2d0000000b005a81d0e0ca6mr13910596ywe.32.1699377326769;
        Tue, 07 Nov 2023 09:15:26 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id u36-20020a81b624000000b005a7ba08b2acsm5806277ywh.0.2023.11.07.09.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 09:15:26 -0800 (PST)
Date:   Tue, 7 Nov 2023 14:15:27 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
        s=2023; t=1699377325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2g8jDPpSWd4rfNQp4XblzxoeaX9SXaeroV6LJ5acpaw=;
        b=FClUayP9yArLPiqzXLPPJUFkq6e2VjsEem+wp1NqnkzDvy76VDEPh11+IUKSV6uNdsC0i3
        5bLycnT2leBd7EqC77mwA9FsHsLDm2OmB4N6oEzMTXxLiPSL9jHi1Y7QesI2An+Ww4Koop
        rLIJO1seKgi/ivNBqH6FXSLXlyOuLPL28Z/b6mkb63qbStwwpmAaI9eIH60ej6PNPY5h+r
        1SQv3yOBOI0uAHCYxbio5Qt1un1AeMg1SbiFRVHpjaZXDMBe+xk/J/TArljStla+364MJR
        KKUytLi56v8CrjFXa2/OFM5TCHs5isODOWhqtZ+GopU+8dKL2cG15BvaCJePig==
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From:   "Ricardo B. Marliere" <ricardo@marliere.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.5 00/88] 6.5.11-rc1 review
Message-ID: <4cfshixe7klz632hrculpkkz4opdz7bpkvxtvt5v6w4ul6wja2@66l5mo5shjgt>
References: <20231106130305.772449722@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/06 02:02PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.11 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

No regressions on my system.

Tested-by: Ricardo B. Marliere <ricardo@marliere.net>

Thank you.

