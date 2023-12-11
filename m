Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5981780CE6E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343741AbjLKOcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343710AbjLKOcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:32:23 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B679DC3;
        Mon, 11 Dec 2023 06:32:30 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-28aabe4a728so220606a91.3;
        Mon, 11 Dec 2023 06:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702305150; x=1702909950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4T42pMM+lOegJCe1HFIlB1ZP3arDImtXfzEjv6FDZc=;
        b=hadUpPsk75xdo1BdTPC6mh1dbht08J5g49dL0r71RVXc0p45dy+3/Kgf8ydTXsFXcC
         QXbml0a27k4/yc3wG1/14BxJp50XM/QrtNGJmd5MCNiqm/Ul/S2alFwk/455QTCfJ9NZ
         m0aTUgZt92Aa/odjWU+zENx6h47xku+lJypPLxoTr2BZa+fQFIWmase/Q3bzjbB4q1hU
         xGab5LJMmdReWkdS0plFkCkcb56ptH7h7/JVEgJx4uWDfzpqQk5kN7IKoBlXR80GC+Wh
         I31/JB0sgHDgR37mjFOBzXn7MSzq4gcdkBTqhKYTEac+oTSqcRZaqvfd+PWnrAQvsw6Y
         Iwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702305150; x=1702909950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4T42pMM+lOegJCe1HFIlB1ZP3arDImtXfzEjv6FDZc=;
        b=SZvUtZ7VmytkmJT8gjR/uCIZoMHBSQ2cSVtlGVoXxuV+1UQsn6tXO8cA0lMkgUD4rz
         bUw4oeMFS8idZFSvyO4YW0MB+w6qqgs4rFo4kOHPC8MwtroqhyQOlUZMvstb04rGKqY6
         uCHoFopNGMqnMvSnGmrx2qT/DNXDJDlEvogh6KmDLutwzFpa1sXdTbTCdTdluV54pqra
         Hy3S78r+BpSKXoc4/ZDVMStSurs9v/XTudq9fb3UyBwyREi6cwsImc9XKjoGQ+/skqZY
         spAupVkMiQebReWxgM+vTc2CTyTWZFaD0K8pQ5Y4tRXF/2SCrxAqjDi1vOvwNZEVozV1
         l/8Q==
X-Gm-Message-State: AOJu0YzbON625sXbFBiqMeVA7e6HpSBz7LNw3QwSzOOK2PeBaEbSiNbk
        mOAJkiSOHabuLYFirqr33xo=
X-Google-Smtp-Source: AGHT+IEQkYkTZC+r8SjpiBendOi3zHCvQ4uKeqztoZtzBJofctThTRrwnsZ9xq6Ag8OLvBeGRoQaUQ==
X-Received: by 2002:a17:90a:f487:b0:286:6cc0:884c with SMTP id bx7-20020a17090af48700b002866cc0884cmr1817096pjb.57.1702305150102;
        Mon, 11 Dec 2023 06:32:30 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id st8-20020a17090b1fc800b0028656e226efsm7051238pjb.1.2023.12.11.06.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 06:32:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 11 Dec 2023 06:32:28 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-hwmon@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] MAINTAINERS: Add maintainer for Baikal-T1 PVT hwmon
 driver
Message-ID: <1ab63238-5411-4e31-9248-b494c29f2182@roeck-us.net>
References: <20231122170506.27267-1-Sergey.Semin@baikalelectronics.ru>
 <20231122170506.27267-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122170506.27267-2-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 08:04:50PM +0300, Serge Semin wrote:
> Add myself as a maintainer of the Baikal-T1 PVT sensors driver.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Applied.

Guenter
