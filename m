Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC0A7E48D6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbjKGSzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjKGSzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:55:03 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71B099;
        Tue,  7 Nov 2023 10:55:01 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b44befac59so5350309b3a.0;
        Tue, 07 Nov 2023 10:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699383301; x=1699988101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j6B6JLdfl6l4VJ5lkNq4tSmakFCzROL7yqBshx8+Yn8=;
        b=A7tbWbHdYOLI6JVeEoWx75Za1igo0GvHCXHhpU0ZDKyhjIl83s95QvNmoqLrBFkGjn
         6PrBAAnuNQarOmSvmlzP3c6FyBYmd9pU3VOiAQsuFvapVcWiJMzbn2cOWRuJdcDcuC6m
         7BohgbdKLkzMCKARdsFgl5DGtP3otFy3Y9drrI6L7MTF6FVKgt1xEr6jMYoKHDwbjMPg
         aAk4dqBVxdfhGZBA+95emjc5/axf50qZJOsfLKfIvH4sk1+t6ZdCcdZbCPTz66eNAcJX
         ZGw+PJBs8V5x3VStkwIQSSngDiGrX59Ht6mQ8NkK2qnIskbjfKbAyALwAn/7xWuZIQz7
         O5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699383301; x=1699988101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6B6JLdfl6l4VJ5lkNq4tSmakFCzROL7yqBshx8+Yn8=;
        b=qG0srRX5QiHY8cwDSHepr8coip8Uzn+x9Sb70qpI6XfH+LCI+GSg9lIpZKDHU//8DA
         flTlFpsHu6/H/1yqlimP2tMFHbc1RyzOpqZZc7JkOQVy83qoJZ9FmBAFrSbuTV4NQ4L5
         n5NvroIcIM7vWVXxK4mIC47kDRWIpbr9Kv3lniBpwPv5uf2SjRErrVBEAsXswfd6Ik4p
         Y45U57lNUGoJvp5fdAd6qUb3Qx3s4PDVZ9pDs+ufmepYuaTNqLsOBNEKLlxQgyWWQosc
         bFIcuLa5zV6Z6qP8cEBYwEJrS9lZq44GKoQdiWwn81j0aFdVzVzZFw4OvbKebKngX23N
         NQOA==
X-Gm-Message-State: AOJu0YwfoDb+DxugrCl5BAfDgEY7rJ4cJ9uLxWpNMUWgPaL8DXJEifu6
        wDpflgbf6WoMH+8k9gOmILQ=
X-Google-Smtp-Source: AGHT+IG6EIFgSTu36U+FR1dL3hvD0MeCUG5WtfvBSteJO83b8B6JvflXyTGd6zQxzoe4WwvwMMCs+Q==
X-Received: by 2002:a05:6a20:7f81:b0:15d:8366:65be with SMTP id d1-20020a056a207f8100b0015d836665bemr6297962pzj.9.1699383301270;
        Tue, 07 Nov 2023 10:55:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fa5-20020a056a002d0500b0068fece22469sm5539431pfb.4.2023.11.07.10.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:55:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 7 Nov 2023 10:55:00 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.6 00/30] 6.6.1-rc1 review
Message-ID: <f10342e7-c341-4ff9-b58c-4d3ecc1beeff@roeck-us.net>
References: <20231106130257.903265688@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106130257.903265688@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 02:03:18PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.1 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 530 pass: 530 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
