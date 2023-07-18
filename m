Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043AD7580E4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjGRP3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjGRP3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:29:43 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEA892;
        Tue, 18 Jul 2023 08:29:42 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-57045429f76so57279257b3.0;
        Tue, 18 Jul 2023 08:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689694181; x=1692286181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qylrI5TVxU4cjjQW7fNvxJOIHj9MYnraRBa50qVPFyU=;
        b=pV8EZ+o+R4DDtyzjL1tW2pf9JAE46kSrFekAdm7F94LK3aTvu2h3WE6Ll0ioFcfloy
         VOsRl81VvhyO73TtpIOTtwQV8FqiLmmQpESRIt4nswjirGZROjBdOkOrvrx3KOagX0aR
         QOshAYkCDSmkl7CrVwlTjXoG0OxsBbcWpHBXiXYKUQXW8ZGKyfJ6z6CVS7dJwp3IyKR+
         Jz+67+1JLjJoVf0nmaQMcgxHGZhRcWcugY2DxOBy0yQ6LRUx+gIC5t/6DEpqYCV37jhq
         e/wys9JzECOw9u/kQP+gNc8qoJnSHL+JfL50eZcMyVYDbJEaFd+azoVBIWMvlRnXbTL3
         +FdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689694181; x=1692286181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qylrI5TVxU4cjjQW7fNvxJOIHj9MYnraRBa50qVPFyU=;
        b=GRyZFwH7r6s4bUXuagSQkg0jTfw4IkeWZ/TQH3YRYp4SBUmQSuBp7t7V20NSER60G3
         sj3u4geYEVX4NDRAwd2H/GA+PvRWeVydUEe4x7lPz2STO2UKxic9iy1886qcGyJchHWf
         d/cQBVKOfsvv+Zhn/tzRaL6qir1Lt5K/5BAghRcAI21HW6Nq3/gn2i+dcq0mn857WolW
         RzQ7SZDBvSpd6DxfSY7+zbOwQZXy+Krg0PmS40WHP6LpISCzETX6vOO6zACAsHaa+Hcy
         T8HXBJHakTOGX+4/qb+fJXRByWkYRA6vaeohVf3OyXmQ4CvM3uBVksmz9tZgMwHAA240
         kvkA==
X-Gm-Message-State: ABy/qLb7Tr5EYY9snJfxYFh4yj1EN22n4rvGLRtHfeKxyaLfKJgsEr1a
        xCfWRDzrq+Ojjns2/DSRI1M=
X-Google-Smtp-Source: APBJJlFeVMHJEtLwJn3T5TqvKGlyTvt33hQh2T67a7plN4OTVLB/h0F3UrVYdbxGwbIqHs8H2BdMGQ==
X-Received: by 2002:a0d:d647:0:b0:573:2e7a:1733 with SMTP id y68-20020a0dd647000000b005732e7a1733mr16851699ywd.45.1689694181332;
        Tue, 18 Jul 2023 08:29:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z80-20020a0dd753000000b00583414320d2sm508081ywd.111.2023.07.18.08.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 08:29:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 18 Jul 2023 08:29:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 000/801] 6.4.4-rc3 review
Message-ID: <971fab95-7839-48cb-b3af-3ca18113ef4f@roeck-us.net>
References: <20230717201608.814406187@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717201608.814406187@linuxfoundation.org>
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

On Mon, Jul 17, 2023 at 10:34:36PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.4 release.
> There are 801 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Jul 2023 20:14:44 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 522 pass: 522 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
