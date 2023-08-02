Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FAC76DB65
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 01:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjHBXRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 19:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjHBXRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 19:17:18 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA6D35A8;
        Wed,  2 Aug 2023 16:16:47 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bbf8cb61aeso3114025ad.2;
        Wed, 02 Aug 2023 16:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691018206; x=1691623006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AmQD1D91D22XtFsCLqKfkymZHSPkp3/JUyiD0yuHCPY=;
        b=R/tnLvngHv+w0bDFSVAreY7Y9/Oj3UosPTDbtA6wO3Xz7HZoNlilvUIslFvphTDWm+
         IkRilwqgsRGOGDhT8F/a9mVILTU4LUmY/mDOTVB0D9ueSeESkwlu4VpTkf/r/erfojoO
         owMRSfG9O/fm/c4Kk84nqzOdzC6xwynNcKVjpljla1n/2N2pIkMFOTLhzPVkoynuTIVO
         /7AVM+CHwKFK8tTGSHY2Tx7rPITf1PpwiisQ6Xw4MK3EqLhcwmJlznIAcR7L4VdoPCpB
         ZVRQY2LTFg2lpyw66s46st5Jcx3DVkiTepKcRBPWpB7FPTOv8nXN1RIiu366AsP+zhuR
         SjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691018206; x=1691623006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AmQD1D91D22XtFsCLqKfkymZHSPkp3/JUyiD0yuHCPY=;
        b=VS2QZbZWt0WVynvv2D45tItB/dW0lvA98cU9r77Fne7H4v2XJbPK/Yd4aiIWUTWo4S
         VA4JRlL8wBdsRAw5GDW85AVQgAhmsJUBFjHmJXK5YdLqX/UE9wVTeHG1NIP9QsDqkEXw
         CWU0CxY7KmLxgOevxdD3DDyqLEPZ3mJ3t0nPaTPz4oX5HDEosMR7B5Bj+EMlt5zDKCEi
         /46oP/+l83mbuRKE53ZigtPXvK50Uy7P8UeC33F4XDMG05vvSD/RP8rSlARJLGvWAb0u
         4vXp6WHfYksQD4BVbzD93bgXM5YB1jQJ3NR6y7yU14Z4JnTZQieZZvBLQX3skqzJJx8g
         ycXw==
X-Gm-Message-State: ABy/qLbswBJe5en+hjSQtD1rl9kfLSrf4VDr4fmFwE1Zg1S99/ckZLgB
        NhbsnQAgUIIGGhzcxKF6z8w=
X-Google-Smtp-Source: APBJJlEZBN7jU+66uj5yt+B/dTz9pCaagOEqh1KOdzAgmdHqr40K1yOSyZ+Z5OR+cgg6dic63xH75w==
X-Received: by 2002:a17:902:c94e:b0:1bb:32de:95c5 with SMTP id i14-20020a170902c94e00b001bb32de95c5mr16394723pla.65.1691018206393;
        Wed, 02 Aug 2023 16:16:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm12663686pli.217.2023.08.02.16.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 16:16:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 2 Aug 2023 16:16:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 000/153] 5.15.124-rc2 review
Message-ID: <c9a82590-9263-4c02-adee-e116a8f1af7e@roeck-us.net>
References: <20230802065452.161574662@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802065452.161574662@linuxfoundation.org>
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

On Wed, Aug 02, 2023 at 09:41:43AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.124 release.
> There are 153 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 04 Aug 2023 06:54:22 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 160 pass: 160 fail: 0
Qemu test results:
	total: 501 pass: 501 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
