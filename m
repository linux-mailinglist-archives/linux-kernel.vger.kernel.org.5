Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924F8788C95
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243153AbjHYPi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244082AbjHYPiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:38:10 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D282680;
        Fri, 25 Aug 2023 08:38:06 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-34cacab5e33so3574165ab.2;
        Fri, 25 Aug 2023 08:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692977886; x=1693582686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dz5ahBOHl2bbH2qK+Exj0zAbZ4Se97M3FlA5URgWaWQ=;
        b=PFeIrxX6lC1CZNlZRPYzPA8H8WikGo6NOR92KOyC8ISsgCx1gLa8P3JtOzzXj/7HQK
         VPAoQU1oDb/2h37vOP/pfK7dgA0v7hyyLUgSouksbgodARIlEpVH2/eEzUgN+k22ZZD8
         NMt2VM03otD+iUTzL0WYlyaf3bbcB5D0nYPKlgZTnAZV5cES8SXPluh8eryEDywkgxgN
         f7lLhyIyQxUCKDbkEOQ7vz4wRWqvX9BmDYIWEZMaKjs6/NpiSM6tbud4XeU7BFN9psz8
         K15IeH2DHDrenBPztdECLbE6RyHVb42DZEmpfJKbuq2Mt4FIkosuq++MU1unCOK6y7UO
         myow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692977886; x=1693582686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dz5ahBOHl2bbH2qK+Exj0zAbZ4Se97M3FlA5URgWaWQ=;
        b=LKNaoYVQ/wwqhgRo+Zv6OnYuv4Uz/7Q/oes538UHlljE8z9yRC4dRi+NJ9FZYDyMzI
         7TbZ4AG6Gc3MsfOoS72rKHY8rWYQ+Bmn26ej3v0Z2tgLzfjVJuQl6Olq19rgdMH27o38
         fdnPKTmAUudQJGF4YEFhDhceoDCXDh95Acz3U9ilRxqEWzX7kCd6UBGWRxemmwszSPpW
         X3DMze3hunjarjxFmG3rG9Bgt38TabPDgaTPaQL4aK3eKKuBzY+v3Dn8oYoDzVgEKu8Q
         cQmdfc/BZyWlHYMJGjpZl+wkzpinc8ri617MEa+0F22wu9tQnHgFMcUm2md/EPP+vgRz
         c7sw==
X-Gm-Message-State: AOJu0YxKcRxQ+y9rWsGhvF9eqghMWv+GziIscVECGzf5C5kPXgzdLk9N
        6ZIpQYXmREhm9mqujS2cd9Y=
X-Google-Smtp-Source: AGHT+IGXcm8HRPfPMUqpBveB7Dyn+UNV4oOmGWBgciWYubpLSZkygzhaFoSxMtXN2p+Smqoe4+UTfg==
X-Received: by 2002:a92:c201:0:b0:348:ffdb:78 with SMTP id j1-20020a92c201000000b00348ffdb0078mr8283901ilo.9.1692977885897;
        Fri, 25 Aug 2023 08:38:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t7-20020a63b707000000b00553d42a7cb5sm1573917pgf.68.2023.08.25.08.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 08:38:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 25 Aug 2023 08:38:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 000/139] 5.15.128-rc1 review
Message-ID: <e2dc2283-65d3-4160-967a-b758a14fdde3@roeck-us.net>
References: <20230824145023.559380953@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
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

On Thu, Aug 24, 2023 at 04:48:43PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.128 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 26 Aug 2023 14:49:55 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 160 pass: 160 fail: 0
Qemu test results:
	total: 501 pass: 501 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
