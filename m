Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56E47803C1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 04:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357221AbjHRCTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 22:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357217AbjHRCT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 22:19:27 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBFB2135;
        Thu, 17 Aug 2023 19:19:25 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe11652b64so559587e87.0;
        Thu, 17 Aug 2023 19:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1692325163; x=1692929963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HjNzq7FJ4TMSXlaO3D7wGBsSbWo2DWrfMQ7q17pgNfg=;
        b=SWKJAFXg8ols3ygcSe0e2xRhjgl7FXD4OE3gUVDQwpqYLsQWP3qyoMGrwIkY4sm+fj
         CTNKdel3oY5/k3EuRt/druAbqy1W52qIldtFhf/CdEadJPvutIqlGBTPdKix/1gLBezz
         G2L8u8h1RYtT/ZZcHsiMcuX/KmgWA/68wZJkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692325163; x=1692929963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HjNzq7FJ4TMSXlaO3D7wGBsSbWo2DWrfMQ7q17pgNfg=;
        b=BJfu6J9Li9bAZ+q6aDn/P1W8SyNbpWbPdtlI4MQwYL78r8tOtVN4qCbS0dzGOVuIVI
         Nd+F8h//BZKXy3RZ9t5CgUfevRY/9DsmhjrNJT0UVyMtyFs1ILDNiKrYzhEwGJNfKcLU
         RhlDIirQYmkzKomAfV0mXOyoJR6ghIWPMeNjkJeSfzB3nRZBp86WGkpUJc+wuBTp601+
         quXM3FQpTM07fvHAe+BpdLefq3IqWQRbOD+XFDZGT0hPvpZMoUWtWytQ5l4sStC5cr8/
         J/6mpA/Py5x7/pTd6xpf0NSm6WiDjIzrbCF9yFzH4iMPbAQHsmGT9EDnS+XQk1Gff/RY
         dQ3g==
X-Gm-Message-State: AOJu0Ywf/PfzcoRmDrJQnU89flC2MzhumbChXbFamofG9sVdfwdfBg78
        oHxs5KLaLJ+N1xV6/hn/YDgqFOuLMZolMJ5/Eko9192g
X-Google-Smtp-Source: AGHT+IFq05kCkY6jAXXIga2YcS9lOlnZa+kbK7MlzDGyJE0XXj5B3+LAJIYKkrF+0PYKHCdlXOW0LpVabsvXb214Thg=
X-Received: by 2002:a05:6512:32b3:b0:4fb:8c52:611 with SMTP id
 q19-20020a05651232b300b004fb8c520611mr577592lfe.38.1692325163408; Thu, 17 Aug
 2023 19:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230815114143.23e4b2ff@canb.auug.org.au>
In-Reply-To: <20230815114143.23e4b2ff@canb.auug.org.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 18 Aug 2023 02:19:11 +0000
Message-ID: <CACPK8Xez-xQDEAG_JuN5VqMVBreLWO_Qhu+3Vq3EA1PiebR5hw@mail.gmail.com>
Subject: Re: linux-next: duplicate patches in the aspeed tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED,URIBL_CSS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023 at 01:41, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> The following commits are also in the arm-soc-fixes tree as different
> commits (but the same patches):
>
>   0955e3867b54 ("soc: aspeed: socinfo: Add kfree for kstrdup")
>   c5835b6e7aff ("soc: aspeed: uart-routing: Use __sysfs_match_string")
>
> These are commits
>
>   6e6d847a8ce1 ("soc: aspeed: socinfo: Add kfree for kstrdup")
>   e4ad279ae345 ("soc: aspeed: uart-routing: Use __sysfs_match_string")
>
> in the arm-soc-fixes tree.

This is expected as I sent the changes as patches for Arnd to merge
via the soc tree.

What would you like to see when this happens? Should I rebase them out
of the aspeed tree?

Cheers,

Joel
