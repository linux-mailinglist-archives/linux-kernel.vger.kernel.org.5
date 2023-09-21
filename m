Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FD57AA0DC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjIUUs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbjIUUs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:48:26 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2030914C3;
        Thu, 21 Sep 2023 10:47:31 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59eb8ec5e20so15210167b3.3;
        Thu, 21 Sep 2023 10:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695318451; x=1695923251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HOWTj9FP0vaaz3q49p+fKdClapweM+Ed4jAzEAA9yno=;
        b=ZF8ynQoyzpUvoaF3gnzpAixA0AB0YnJHLrzWTPZXvqaLmSVwV5E815yK+gNg9XhyRR
         FCSmtWhkhUyML0k9zfZkhpH614O7sxlUFtw7edf/ot8FmJ5WMUecGJbSPoVfmaAKW0LH
         30ZPmrSSq00J5Nx+TzTgD7ZNadSwX+3FAkQoPbmNVSvCB2mUWykfRN4ANixxyJpunPdB
         smohF2kQwSyp7qpBbqRmOHdfxU8nglhlXP9dab4SzJkHsIAoRJ1svDGUTpEmSr4+ZsPJ
         z3qSXM+h3OrRtygriksVvQoapRtUy6XF1dmAb/55EPMB29/4ypA36t0KB/rteWXzbfFv
         ZGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318451; x=1695923251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOWTj9FP0vaaz3q49p+fKdClapweM+Ed4jAzEAA9yno=;
        b=KU7SRhd9KTqf0XOrye382dUG/XIEXSyGwP8aJ4zNMs9e791BFwlHDme4nS2fWF+zHG
         NbPvxhqmBuTKL/fJvgBL1WVkyGmM00oloyuEHxHnldakMTsqy03Sp3qg2kdN9sSp2VXq
         wifZ4WcOfv/E523Z65xGrUg3JgKLCSYB13FrHL37PBWdlvATf2HIhroB7FNaF+h9aXTv
         8tAmyhNEPECQQNBfxD5RoUWVxRt+4pKp0wicLoR/uOYyqB+Sn75XAWJ0wwB369rBFJNV
         5y9+Bvz4nVri0/6hcrMHXSOzI+wzwvnFJh9oBGaaCoYmOMVzGkU6oFlf7rzSUsn9i7dS
         QYXw==
X-Gm-Message-State: AOJu0Yz38/sUIoKBL6tma8PUgNqJVMo+6uAPz/qqAE4vYYN7yWKoOpzC
        jarA+PooipfkLt+/3EHE5uetsBavYww=
X-Google-Smtp-Source: AGHT+IE9zcw1DS9VmayNJucKFF84Njj6B5FeeIlhqZa34RI2TxAsXoEH16utjF2kucRF4hs8Dc6uRg==
X-Received: by 2002:a05:6602:22c2:b0:794:d833:4a8a with SMTP id e2-20020a05660222c200b00794d8334a8amr6096222ioe.0.1695311516461;
        Thu, 21 Sep 2023 08:51:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id eh3-20020a056638298300b0039deb26853csm430538jab.10.2023.09.21.08.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 08:51:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 21 Sep 2023 08:51:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.14 000/186] 4.14.326-rc1 review
Message-ID: <d68ca4b4-9c5a-4ca8-9205-4159bf75f2ff@roeck-us.net>
References: <20230920112836.799946261@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
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

On Wed, Sep 20, 2023 at 01:28:23PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.326 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 139 pass: 139 fail: 0
Qemu test results:
	total: 440 pass: 440 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
