Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10C37C7B41
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 03:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjJMBkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 21:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJMBkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 21:40:41 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D67BB;
        Thu, 12 Oct 2023 18:40:39 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-565334377d0so1226807a12.2;
        Thu, 12 Oct 2023 18:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697161239; x=1697766039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WXJtzjrDK0QuxdyEgkcfNsHYO+tmzm5+bMHpoE/cTZY=;
        b=QwDAVj5X0ID1krlOLYYqRqgZlA5p5y0Jd3w5LOfOCCDoMB+8fYECJaZZ5uNnVPqPr+
         /4OKH47virTru/s2XvfNDbkxkdnFdBP/WVJtX4/zg66mjqw8nKnnRejqbFGVHIkQyZMA
         c5O9y17a1K4nzVfw+nIpJAjWaPzo6dJDDakJhERux2gX46OYgRXIDbW+qoaRdq9R9Evd
         RSxcj5ebbIKbjNWkUrx3zxDje4t1snXebin6Qke1lirRvfY77hSMux3UK0xaz63ZmvYF
         LtIcBYh6h65yVpzXuCNvCV5yJw/KI9+ftsoOHCtrwbHN/6RVE5rUrdXtKHbCnEGs5PVE
         WAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697161239; x=1697766039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXJtzjrDK0QuxdyEgkcfNsHYO+tmzm5+bMHpoE/cTZY=;
        b=ADeGYE297HPrukjS1ToCgeOqHOPCmMNGqypR048d74Yoh7biP1P3yIzpjCiZm+R1xP
         CZX9dx3SZBauLQ0Ld7CeJTck4kap6T35Tbu45kUWVPEaoCwbyxV1tnhhi9a3lw0S82FO
         3N+12k+xFzqIVMQMJ0a7CIxOCXbZfL5ClRHSlXlicSjkStYh3i7KB9m6E2FuZXsFMED7
         YMGKNlyewYkdDKUKQsIXjiIQWbMyloI+8gA7mQa/Nn/6JCJUJJbi4A2qjL9mCPotpzxJ
         E14FJyVN/LpNkCrzfiQhGU4BKVGzQBxmLArw9lyUWPgVhWPyo0BhBesgWnwie2vCaneE
         E+ig==
X-Gm-Message-State: AOJu0Yy8w/0yrqqQOkE4y9MbzWOtsW0J5x7EDwgukJwU+cV1WsSzID4a
        /qo2SqosXUk7PYMXZN8RYkQ=
X-Google-Smtp-Source: AGHT+IH8OhApaSYFukD3cb3L4q1Ugsvgcm4OSq9qVwD4sRWG1JQBfyqC0iM5zCT1qiJnk/0GkOZK3A==
X-Received: by 2002:a05:6a20:100d:b0:16b:ce7d:874d with SMTP id gs13-20020a056a20100d00b0016bce7d874dmr17232911pzc.6.1697161238676;
        Thu, 12 Oct 2023 18:40:38 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id jd14-20020a170903260e00b001bdd7579b5dsm2626011plb.240.2023.10.12.18.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 18:40:37 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E5EBB9AF595B; Fri, 13 Oct 2023 08:40:34 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Mat Martineau <martineau@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jesper Juhl <jesperjuhl76@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net 0/2] MAINTAINERS: WWAN subsystem changes
Date:   Fri, 13 Oct 2023 08:40:07 +0700
Message-ID: <20231013014010.18338-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=666; i=bagasdotme@gmail.com; h=from:subject; bh=4BIlufaUi8EVDUvMQIbGP5RGyBoKq2WaoSM101fdBtA=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKkac0tk+0I+H2DQ6ux4x/NVYYqdvfdVOwnD5z7i0Tdkv Df+/tbXUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgInEsTAybGeKWXJR3lNdtz50 mkjG4pTPt++8lL/ls/xvi/5ir2rj6YwM/35mV3e92sfIU/N856e2pqO2EZMK07LZvzNOY39aFFT KCgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have to make this little MAINTAINERS patch series when I was dealing
with a regression involving Intel WWAN IOSM driver [1]. The culprit
author was (AFAIK) MIA as well as its subsystem mailing list down.
So here is the series.

[1]: https://lore.kernel.org/lkml/267abf02-4b60-4a2e-92cd-709e3da6f7d3@gmail.com/

Bagas Sanjaya (2):
  MAINTAINERS: Move M Chetan Kumar to CREDITS
  MAINTAINERS: Remove linuxwwan@intel.com mailing list

 CREDITS     | 6 ++++++
 MAINTAINERS | 7 +------
 2 files changed, 7 insertions(+), 6 deletions(-)


base-commit: e8c127b0576660da9195504fe8393fe9da3de9ce
-- 
An old man doll... just what I always wanted! - Clara

