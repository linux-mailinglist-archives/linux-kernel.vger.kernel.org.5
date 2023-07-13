Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F10C752B32
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 21:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjGMTuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 15:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjGMTux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 15:50:53 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07376272A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 12:50:49 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666eec46206so1104421b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 12:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689277848; x=1691869848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s2JM/EzDwlh12gbSnIGAGM8cnnn4IWqIg/peWDFrv7s=;
        b=YUL95pI3km3fwnvv7kNwmsbRDkUdneUImADyIzt+0yWGk+TZbRsNG84pjivoQWiP3S
         ccyqC2zA3poZ1G0eqSswCCyBjZWBEcu+xb/zaK/plW4LVJr5g7Bt6WZVp51nOXDaWQiH
         CS8AdapqzNvH3lYCRNdE/L38tzJB4/rjqGmElz1VirRgxgWq3uiZ1QgUbvbL57Vomz6H
         D6YUPWgnOp9prOuDj4SCYqvziHHgKjymeQg+YGVDtnIZ83SPB9+llVvn6Vc7UNgGhkIp
         5M5/M2fQ1Gr8nVXeQb5TCLrvNSXRQDwPUdpQKn+K0vuvq0JrweHkuOcBf/YOw34eY2uo
         9j0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689277848; x=1691869848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2JM/EzDwlh12gbSnIGAGM8cnnn4IWqIg/peWDFrv7s=;
        b=iEOTFB1eRxPF18Dj1iRL1Lt9r3pNi+3uFzUpcHh9a3AM41kZqu8FNlPebgpU1VIHmg
         SMI2fKZ/bjs21wVF/udOkTaLRR4Mrgz8zC0Cy+bfjl6Q+ZEfc4puyHz9CYrRUBG9CvkI
         UTXxfbBzIkgA2W3aP12M6QcQVlShDDG8PC6BBKjixBLCKa/OXHK1RPULF1Gv4kbJyTwv
         76juFJpOy+98FZLwYg6+sjIWE8T7DmM4mw3cCKjlPqgBZXwa5X1LfrGS23ljFuGw2ijK
         pjlDJRsdeFG4bMoiyXyoCL0jSypmKU2teDih7b0QwCey+ckLceeWrUe19TZpCFzZvmK1
         Q32A==
X-Gm-Message-State: ABy/qLbG195edOlTFKcglplVT43aBXlfZMxCiHoap85QdbASzWGnzb3D
        vXSIDV09tkQIyEOLNeuWbiPwOJlWpOv4vg==
X-Google-Smtp-Source: APBJJlEJVZ9W8nS3QOvlVHsYuPz05H3wqnC9t/lb5kj6S/RJ4VAF8IKhmkLp44gKUwvGK7Uo/PUDig==
X-Received: by 2002:a05:6a20:1004:b0:129:bf86:6ebb with SMTP id gs4-20020a056a20100400b00129bf866ebbmr2387858pzc.59.1689277848395;
        Thu, 13 Jul 2023 12:50:48 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id k10-20020a633d0a000000b0054fe6bae952sm6080759pga.4.2023.07.13.12.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 12:50:47 -0700 (PDT)
Date:   Thu, 13 Jul 2023 12:50:46 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] cpumask: eliminate kernel-doc warnings
Message-ID: <ZLBVlhC+3QHe13De@yury-ThinkPad>
References: <20230713030832.17900-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713030832.17900-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 08:08:32PM -0700, Randy Dunlap wrote:
> Update lib/cpumask.c and <linux/cpumask.h> to fix all kernel-doc
> warnings:
> 
> include/linux/cpumask.h:185: warning: Function parameter or member 'srcp1' not described in 'cpumask_first_and'
> include/linux/cpumask.h:185: warning: Function parameter or member 'srcp2' not described in 'cpumask_first_and'
> include/linux/cpumask.h:185: warning: Excess function parameter 'src1p' description in 'cpumask_first_and'
> include/linux/cpumask.h:185: warning: Excess function parameter 'src2p' description in 'cpumask_first_and'
> 
> lib/cpumask.c:59: warning: Function parameter or member 'node' not described in 'alloc_cpumask_var_node'
> lib/cpumask.c:169: warning: Function parameter or member 'src1p' not described in 'cpumask_any_and_distribute'
> lib/cpumask.c:169: warning: Function parameter or member 'src2p' not described in 'cpumask_any_and_distribute'
> 
> Fixes: 7b4967c53204 ("cpumask: Add alloc_cpumask_var_node()")
> Fixes: 839cad5fa54b ("cpumask: fix function description kernel-doc notation")
> Fixes: 93ba139ba819 ("cpumask: use find_first_and_bit()")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks, Randy! Applied.
