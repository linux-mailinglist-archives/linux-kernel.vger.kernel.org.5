Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5FA7D3FDF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjJWTKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjJWTK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:10:29 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC3D100
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:10:24 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6ce2fc858feso2190880a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1698088224; x=1698693024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5dCh8qscABtOqwm1BbzDvVj8ruCpus/OdmtCpZWjQ0=;
        b=cqhIjagiX2tC0yLiW7SyUdNjTIfbHWPvOxaxvDi9EpAJPnsQjTCKhT3cMFYn+P5m5Z
         PSUFW8HevEbVqWrh4bOGH4yYDOI/QhglRGsXOKffjh8LEwLkiKq3aVnm2whLfpPAa8kN
         ZwDHKC6FsQs4xOSuHK/PElJsSKbqdBYoT4F+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698088224; x=1698693024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5dCh8qscABtOqwm1BbzDvVj8ruCpus/OdmtCpZWjQ0=;
        b=HQo11VZ4eqeb/kSUJV0tD/7Wugq1iLY/pTWvJ3GDQX45Rba/Ij3eYfdKcEjnsyBh33
         B8olKReiz6mGRSKm17XWcmMMDGukCNo++vOWEAc0sTLgByXkSjGzkMTpc32yR+4R9wrb
         iU/SAIiYhonUZqCLvXeDyJodv6/9hrJwKitti5occ1LWcxQB7c3IB65rdh7lXjo661z4
         iTpJ24qqbFnbnwWDx9gJ6vWMK6R3TOzTx28rk5tx9QIEo/RsYLPNyi11s3Obr3917jsl
         rBRsYHUeYx6Hpq11UePaGPSUAz7iRBnXlsYKgmbacj0wb+qXdmOr3fZp+Qo4DGClit1h
         0r8w==
X-Gm-Message-State: AOJu0YxSHVhLyJxJ1TyM2+FY04RjN28nHLFQU/Che1KYEfcrqX5Y8J+C
        D/y4vEPGlL838KgdFIDbbVfEZTxoPt0x72SUQZMSjbp5
X-Google-Smtp-Source: AGHT+IHCpcHou3BX6f5py1fK64rYTiaV6rKcRtQ6XKHVdySmwQAxFZ6RHax21NBS+y02N6pwIh0adA==
X-Received: by 2002:a9d:7483:0:b0:6c0:79ed:be35 with SMTP id t3-20020a9d7483000000b006c079edbe35mr8435872otk.24.1698088223968;
        Mon, 23 Oct 2023 12:10:23 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id m26-20020a4add1a000000b0057bcbc23738sm1612572oou.17.2023.10.23.12.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 12:10:23 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Mon, 23 Oct 2023 14:10:20 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.5 000/241] 6.5.9-rc1 review
Message-ID: <ZTbFHKxuwhf2LccC@fedora64.linuxtx.org>
References: <20231023104833.832874523@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 12:53:06PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.9 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
