Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208247FD848
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbjK2NZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbjK2NZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:25:31 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E75AA3;
        Wed, 29 Nov 2023 05:25:38 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cc9b626a96so51964065ad.2;
        Wed, 29 Nov 2023 05:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701264337; x=1701869137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s+ZIlO4sg/cP7zZFMR0rAT4hiXFZZBZjMQhwTCp44A4=;
        b=Vn/UUsYFa/vtxTlQyo2fh93u4tFOTG5TqrtwjLebIkfx7VNyF3zq7m8QQ02S+MRsVB
         JmspCM/CuiKCtqkQQNuPjR/xLsc5fl2UdvSHrJH+6GsuYFLP3oH6ACnaVrTYOgxkQzPd
         n6bQtyc30pCPd61f2N1T52GBTreIWhIogSsHwwPh67301Hd6bRjdqau7OKqo4saJq1Fz
         YKkKGEpTeEJiGpfwFuKPlKxsmlHKsG9GlEYzdHVHLZr2o810lna3U/SM8huxivOK7lQi
         KAEtqU6XwreoA+8Ny/fjb66X8k4ATlRoiHYc3kpS2zU0HlUWpHIiivBpkeLNzWXK1On5
         Q8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701264337; x=1701869137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+ZIlO4sg/cP7zZFMR0rAT4hiXFZZBZjMQhwTCp44A4=;
        b=Z++asUhYpBxQ2CyatXoEG/bF34YFRb4pwWy7y1S7SvsStJWKEfRd1HfS71nsd/3Y7b
         ZGqEewpgC/4iRgOUSv6G718D5GvFAtTerfcT8gBOIok/Vwj3g58A7FPPz0xHfF4mspsd
         u+/2Op9DG8ll/2k4jEdE4Wz8DwwTvawb6kBcQKNUqf7611kaXyhIHLMu4cEA56bzIcXy
         1x43jRDd9QoCNZTF9XwpovBmJGe+8N+MnG+BewZEnok7uMrPRQlI+TlGbYz5ki0euDQX
         E0EQWznb2Y8L+Dwoj2+doPAhMdrtObDY0KzZPK+3AKp/X4YwJqDGZl8z0M/DSZHnI5NU
         EaHA==
X-Gm-Message-State: AOJu0YztrlP9PX0yB2HJBEZVozRdHOx9NY39pZ6O2+Ak4jaBnRg9W5JQ
        dkWr5bthN9P/VRW1MBCszPA=
X-Google-Smtp-Source: AGHT+IEbsFuMGe2f9WoNKNKVLwvzz6h3eC7ARvS/r+5SojZiyj1DRk/Ol14MDcz8mvHmLeEdkNH/KQ==
X-Received: by 2002:a17:902:b608:b0:1cf:8cca:4f62 with SMTP id b8-20020a170902b60800b001cf8cca4f62mr16041606pls.46.1701264337664;
        Wed, 29 Nov 2023 05:25:37 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id e13-20020a170902d38d00b001cf5c99f031sm10220343pld.283.2023.11.29.05.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 05:25:35 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 09B1310205C79; Wed, 29 Nov 2023 20:25:29 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Livepatching <live-patching@vger.kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Attreyee Mukherjee <tintinm2017@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/2] Minor grammatical fixup for livepatch docs
Date:   Wed, 29 Nov 2023 20:25:25 +0700
Message-ID: <20231129132527.8078-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=717; i=bagasdotme@gmail.com; h=from:subject; bh=gsdJWBuTmbS/IXxeLqNBKuw152ChX0KZJGcFrysa+Aw=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKnp1ocE/nG4mD8rDm1iiIhuPL52icCSvVs2S2xpqz+6p /T5gv9xHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjIBlWGf+rTzte3fcvlzYu0 8P1x8+zeoOTKs78v971VCVf+8fPKSX6gCr+U+/cF88xa1kcdELmjN+GgnffeLGYtqUdVV3as8TF jBQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was prompted to write this little grammar fix series when reading
the fix from Attreyee [1], with review comments requesting changes
to that fix. So here's my version of the fix, with reviews from [1]
addressed (and distinct grammar fixes splitted).

[1]: https://lore.kernel.org/lkml/20231127155758.33070-1-tintinm2017@gmail.com/

Bagas Sanjaya (2):
  Documentation: livepatch: Correct "step on each other's toes" idiom
  Documentation: livepatch: Correct opposite of releasing locks

 Documentation/livepatch/livepatch.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
-- 
An old man doll... just what I always wanted! - Clara

