Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7967EEA12
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 00:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345589AbjKPXpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 18:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKPXo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 18:44:58 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1708E;
        Thu, 16 Nov 2023 15:44:55 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5bd099e3d3cso1038255a12.1;
        Thu, 16 Nov 2023 15:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700178295; x=1700783095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzRF8uHq6PjJBxbhxhi0V10xOOQOgpxlbEBlX7hXGSU=;
        b=SB5FjUIdMr2mRBji5nHD9onhiQi+4PCtNnuoGQVedDUuKEFuSKMQzRLmvG6pVybiaL
         i4Vvs3X85SizHspkiNEvUvABJbD3Ris6fHr1ehsM9kgV4dtl3AMzOLYbCxWuVjTtujhi
         nnfPf2mvDS9g8kcQiLng5m/RM+Q5lhmby7mbPcb0Rb4U+PSJuVjWqVvYHUPeEw/xB7js
         X7PEkDYL/Nb6U24lZqr9F6O838MTUPGPN3W1vR6FcP0LnezaY+xZvXncglaSguXBhmGU
         5ARsMvOgD02V7A8ZZ+GJ7EZbmiHLnhjhdzpyHweXdP/fcAyKAYg1zptH3rjNT/cneQMA
         CmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700178295; x=1700783095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzRF8uHq6PjJBxbhxhi0V10xOOQOgpxlbEBlX7hXGSU=;
        b=jJLav6IAHIb+bnwuscxXXY+lDac1tFQYRoHh512GeaXwUMXzK6oYl9d56KWWl489UH
         KrroZ5QgJTEOlGZRuVSvCtC+wcwsKMcad0xujaMJjTJ8ur60r7Gjmx+VxSWArHynyU3G
         g1Nf80ahCH4pGi8sWzyUlPfzSPnh28xCqoHpm4cVKtjS4seTXGf1tk7ujMs7PGOti8Wb
         ik/mREDFkcX+0U5HBsrZ6f2XtyVBdexHOiFl7AW/UlFl8e2HAgfQF7QZvHoJa2uwJdMh
         AMk+BEFdofrPQFAp6Zm2JnH0GhZcetj6fMe2BKAw+I8Bauh3HlTVCXJguLn3pEhLQf2J
         qLGQ==
X-Gm-Message-State: AOJu0YxtMe8/lwhLK+IoKIl5bOyIqVSC1YaKHb1j2tWOD2uK3DE2cCpM
        cWyYgXnAH6uZhOOL+YYcws0=
X-Google-Smtp-Source: AGHT+IFYAXnKf+Mqzf4eTA54yG1aQFbfDgf3fpmvkk8Vo+h1M85WnXVJcWXq3Sm/iRTBr/QF2Xm7kw==
X-Received: by 2002:a05:6a20:3d93:b0:182:119d:2d0e with SMTP id s19-20020a056a203d9300b00182119d2d0emr17452371pzi.20.1700178295271;
        Thu, 16 Nov 2023 15:44:55 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a8-20020a62bd08000000b006c2d5a31ab9sm284858pff.81.2023.11.16.15.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 15:44:54 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 16 Nov 2023 15:44:53 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.6 000/603] 6.6.2-rc1 review
Message-ID: <7585d234-ec25-4a75-8283-0c6452e97ca4@roeck-us.net>
References: <20231115191613.097702445@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
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

On Wed, Nov 15, 2023 at 02:09:05PM -0500, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.2 release.
> There are 603 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Nov 2023 19:14:03 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 530 pass: 530 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
