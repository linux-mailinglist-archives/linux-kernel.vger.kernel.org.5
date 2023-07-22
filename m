Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103B275DE93
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 22:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjGVUkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 16:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjGVUkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 16:40:19 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFEA1708;
        Sat, 22 Jul 2023 13:40:17 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7866189cff1so155464539f.0;
        Sat, 22 Jul 2023 13:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690058417; x=1690663217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9H3uw0EOnTJ8iMmkSKfrYY1FPNkknriiVrgl+OIU28=;
        b=dLDTkeGsb/APQZ5bdUhjrFaVuzyyUehfcxeYrCKuy41ZWM1jeJsTrNOj3IBCETrzUn
         P7A2IZX9/Yo+eFcRLaUYFzL28u9obmZLGY3enLjudC79DATTdZi7jJ1kz63vgTtDvCy/
         9HQGhEbRexiroIYqeb+5paEvUONO4Bc5qEnfSawzm63ySTRvK9MbBE3M+nk5dJDAGc83
         H4zYMqKQP1oe9Hl5anBDh7wQiqmGoCD0TKHDfCsl9F6ZT0lsI3h7wKhmR9/2qjrwvmeF
         bF0HRFg5ghqztPxDVreBfzlprqHiUkpZRF/WMyXONSvtgVktiZt99ut4pP1NC1iE4Sve
         SQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690058417; x=1690663217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9H3uw0EOnTJ8iMmkSKfrYY1FPNkknriiVrgl+OIU28=;
        b=ZEEtitE4lQFMzcFATqqIkcTsOhivnMK47g0DFyJjlczl4D7s/kH2h2leanDvpEw0Wo
         mOo06XzbXsfvmkswbT1FiQQ3XZ2b/WZ148Xd3tOTO1fAyzSmLsdT/FNzJb5J7jOmUanG
         9bcIZmeVO2Uks5K+orbQainL9O4QYKhYRGv9aGok2RdO+9PC/n8QcJEJHvrahuup8YGU
         B3DjgRKtpHDry8hCoFoAjjDJYTSTocYSVuf+hMENI5NRJvM5gR7EqUqAHITUTg+yjYP/
         h7FkKQdVPWWTgPltDi5/nDavmQ7P5XDu4sHcVDnidMvE9oGaKAHyzTsiaWEnOyI6TDhb
         7xkQ==
X-Gm-Message-State: ABy/qLZL6jXf4wWfA8fe00l06M9RImoClJUNktH1dXJ6hNgjIae1shYp
        iJhldVrt7GkZbZ51RTTVjRc=
X-Google-Smtp-Source: APBJJlE5XTp+6t/iubgJZCjIA6Ox2qTnyX744SBU1EluGjeSG8ePwfh//Tp8cZKMdazcGJ+lWR2KhA==
X-Received: by 2002:a6b:6103:0:b0:774:94e1:3aee with SMTP id v3-20020a6b6103000000b0077494e13aeemr4289594iob.6.1690058416944;
        Sat, 22 Jul 2023 13:40:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u4-20020a02cb84000000b0042afd174c62sm1862347jap.99.2023.07.22.13.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 13:40:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 22 Jul 2023 13:40:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/223] 6.1.40-rc1 review
Message-ID: <7795ad72-d651-4720-b6b5-e7dc92fdbcf9@roeck-us.net>
References: <20230721160520.865493356@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
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

On Fri, Jul 21, 2023 at 06:04:13PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.40 release.
> There are 223 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 23 Jul 2023 16:04:33 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 522 pass: 522 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
