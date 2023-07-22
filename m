Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AA875DE95
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 22:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjGVUkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 16:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjGVUkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 16:40:43 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54662118;
        Sat, 22 Jul 2023 13:40:42 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-786f25bcb40so169975139f.3;
        Sat, 22 Jul 2023 13:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690058442; x=1690663242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4jiZ9yoW3nECNjmz012PrnX3Wx+24JFZES9eeuORWI=;
        b=Kxoi6EkGhWxRwbYrfkf1yveF7rmC3iKrY15+WMk7IDcxN1mr7DXVltUadCHYAQapCu
         KofhL7QNm/hWAdyMK0qty7FieDTtQ87F+yY7nLgGBLoYpdMI0xm77cg1huQq8PRrtRaK
         Mrp9oKna4dCb78fcwg8atpG/xmD0f7qT4VEaCxzwg0Dy2I+lZAAtuQZd2f4ZU+1SHkao
         y0/WSz7MLkBd3dznFVvmAy+5X+DS2x7ptmR0PBx75zzWsKvmSviajeC96qIzZKq8yDiN
         zKib4Nrab9pG4SYKpxtDP3PQQAlOZ8vkHFXnECHRevUrk6OmPJII1b8vbbP6HZcXZAly
         CzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690058442; x=1690663242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4jiZ9yoW3nECNjmz012PrnX3Wx+24JFZES9eeuORWI=;
        b=C7vELNxZRntk9nRTH34Ez4W5GdJAFzquXE0HatMk4mvKFqmdA6xSMPya4paPNN3RqF
         RRrGFW8dRCZGCqEESE3CDY1T7oAjSUNyXRU00Bo6h1QYPI53jQYGwdS2u7fuRIpxz5Fb
         W1TxDhsHTp8K3Tly5GrwYqja8/giN5aLHQrlLwKHyCd+BqR/5j7A3Dc2w2x7mDhq3ODB
         bV3fGMXPpwwhhnGPoz1NiuCDypJqVKSTZvWo3I29aa90Dx7aN01QN/IMSjKg1ScErnKy
         uFOK2f/Cyf7/xVm/Fsoxx4stNk3T3CIDWNSyYI9aP+0dVHkFfNadyEIsE2iKLZQsk/xk
         jFGQ==
X-Gm-Message-State: ABy/qLZUtGdl1nXtwQAiou6lwbGCoEJANtNEE1uL/SoCdfpR5i3SWBs3
        WuBqajLPgRr8BpRFOFxGi1E=
X-Google-Smtp-Source: APBJJlGWIX+Iz1P6gV2gbY8VEivFKVBjLhA0QbnZ4oheIoaoBLxznL42H4lz+aqrTw5s+M8zeWfb/w==
X-Received: by 2002:a05:6e02:1090:b0:348:8b32:7ca3 with SMTP id r16-20020a056e02109000b003488b327ca3mr3642134ilj.5.1690058442087;
        Sat, 22 Jul 2023 13:40:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s25-20020a02cf39000000b0042b3bf0baacsm1849286jar.138.2023.07.22.13.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 13:40:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 22 Jul 2023 13:40:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 000/292] 6.4.5-rc1 review
Message-ID: <d1bcf006-3d4a-40cb-b0bc-fb499a37c5df@roeck-us.net>
References: <20230721160528.800311148@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
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

On Fri, Jul 21, 2023 at 06:01:49PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.5 release.
> There are 292 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 23 Jul 2023 16:04:29 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 523 pass: 523 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
