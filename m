Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6007F41D3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbjKVJmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjKVJmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:42:08 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED4683;
        Wed, 22 Nov 2023 01:42:03 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-35b2144232bso4760405ab.3;
        Wed, 22 Nov 2023 01:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700646123; x=1701250923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TSVuHRUoWzjdRXUhlp3V8hbN4FBeW4gTj/Ub1P0syU=;
        b=SzZI1vuvtzke0G6rG7VWEgmeELYUkXXireeLQergaJffGK/KpkDqVgK3Ra5w/Mloqq
         AFMKaKIirhLTIL1TRWPeZIp7jOtU29dHfh5KXvrN78aO6I0OzH5U8FqKxI8W3hLFPw2i
         uweThaPlsW/v4vKC6ffQw7euPwuyZZHc1NpUNEnbbN1+5bXTXS+G6HjlW2vbecqbliKK
         CtKYYrtjo9WVbh07rnacFYOcJV1SIpgcB2os6rSkf42Fzj3C3Of323bqcejNpZBNJ0iA
         fva8sUlHU7hCODKRlkT9+92fyYeCQf7QMZaNO+lny+gp3dgZqdT7sh+kH8we5KNS4/W2
         kA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700646123; x=1701250923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TSVuHRUoWzjdRXUhlp3V8hbN4FBeW4gTj/Ub1P0syU=;
        b=WM7KHur5Hn7SRlN7aApaIxSO2Okht8n6UyBqT1xPK69T1nJw22n5Uy2/2bvs46+K9z
         vn+byDAJvYpcE8EzohZQ2gyrGtP/WZHP6oGmST/sk2WvDGPaVkAdD9SJIPQSR8shdUFo
         zSLhTV5k4p543mLB4kbRbsJ2q57LwOTq5P7Jfdwwrx0CnY1jnXf47BU8ecJ7o9cPUBkB
         /e+k8gbFS7ipceRkqrn3AqZJ0J80N7wZS3waSqztrlhc/w0E+eoNPM8+R9qUT5zf8sYH
         N7hvXoy6VinfDl0SltIEckotbGiLcVdMLbhkBv7bzO2vY8qAkUhKdBfeF9QmUYM3aW/d
         QUnw==
X-Gm-Message-State: AOJu0Yw9qQ1u26b1VNXhghB/Gyw1aF9guiTdixbz2UnymdAXdJK2ejEZ
        GpJLu9OnUZ81rhMhWtrAa7c=
X-Google-Smtp-Source: AGHT+IHUJ6C7ZhFk0PAdOH0FdpHDlKK8MnJuZg0xki+Wbbl3rjLNasi3Y1JHC37QlISKcXKhtcwNsA==
X-Received: by 2002:a05:6e02:1a2d:b0:35a:f02f:8df3 with SMTP id g13-20020a056e021a2d00b0035af02f8df3mr1908868ile.21.1700646122924;
        Wed, 22 Nov 2023 01:42:02 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id e11-20020a056a001a8b00b006cb955dc54csm5299950pfv.58.2023.11.22.01.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 01:42:02 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 97A8010210556; Wed, 22 Nov 2023 16:42:00 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Staging Drivers <linux-staging@lists.linux.dev>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Bruno Moreira-Guedes <codeagain@codeagain.dev>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 2/2] MAINTAINERS: Move Manohar Vanga to CREDITS
Date:   Wed, 22 Nov 2023 16:41:56 +0700
Message-ID: <20231122094156.30642-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231122094156.30642-1-bagasdotme@gmail.com>
References: <20231122094156.30642-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1247; i=bagasdotme@gmail.com; h=from:subject; bh=3NK9tFw+8nXcmJg2+lJAfw1zj337GJBvGpQPkzucrrU=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKmxpx8nOr5JnMsVPC+7oeXi3pyUZxpTFj7YdIOzcel6u 1zVjzl8HaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjI3iBGhs2K4ZL53OlVDFt9 uGKV+Wx2sqzP5FyxrHdj2jqDx58FWhkZWpcpm88p8FGYu4M5K7DdsCdk0upsPyN9dqe4szcLKv9 yAwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

His last email on LKML was from early January 2014 [1] and he has not
reviewed patches since he changed his address to personal gmail
one.

Move him to CREDITS.

[1]: https://lore.kernel.org/all/CAEktxaFL=3cmU4vZS2akiAR2vG-3d+9HwTZvBvf5JXuThHoOKg@mail.gmail.com/

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 CREDITS     | 4 ++++
 MAINTAINERS | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index f33a33fd237170..c337a91aed5836 100644
--- a/CREDITS
+++ b/CREDITS
@@ -4127,6 +4127,10 @@ D: Minix V2 file-system
 D: Misc fixes
 S: The Netherlands
 
+N: Manohar Vanga
+E: manohar.vanga@gmail.com
+D: VME staging drivers maintainer
+
 N: Lars Wirzenius
 E: liw@iki.fi
 D: Linux System Administrator's Guide, author, former maintainer
diff --git a/MAINTAINERS b/MAINTAINERS
index a02aa52fabe14b..179ec6a1d1c8b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23235,7 +23235,6 @@ F:	mm/vmalloc.c
 
 VME SUBSYSTEM
 M:	Martyn Welch <martyn.welch@collabora.com>
-M:	Manohar Vanga <manohar.vanga@gmail.com>
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 L:	linux-kernel@vger.kernel.org
 S:	Odd fixes
-- 
An old man doll... just what I always wanted! - Clara

