Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D357E1E01
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjKFKMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjKFKMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:12:20 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0541DB;
        Mon,  6 Nov 2023 02:12:17 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6bf03b98b9bso4035346b3a.1;
        Mon, 06 Nov 2023 02:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699265537; x=1699870337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xum/W7MJuOqob9sUjPMH2NvW74OGFL5uRCJzlfRnFqQ=;
        b=LW03H6sgHkyfpHjAcahw2n3R9t66SsDMV775Kq5wJeNvccD7zee71za9UI47VE6mvD
         orl0slm6CrCeslY+qy2AiNWyQDLwa6HWOqK6G0oDTbANWqRtqro224hELfVjZhVlPpLx
         LOvZ7os9K9TxALmvkHH7PJBzpEkbs3wJF5u4q3xV3cQq2ix2+jS8AqMxULZVOZJ0sBku
         wSMeo7Pe5Cgb3migCRuwbEZi8G3mi5Rpo4sqSVSKm8sBzHUdI434AjAZ0Gje17UGZ9XE
         wdUDAqTdOUkfsfcz4PXY6FSyqUY5BGHLbtuymmK1SBF34ou1vckp1oZ1pm5fF5k/xoHC
         9j3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699265537; x=1699870337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xum/W7MJuOqob9sUjPMH2NvW74OGFL5uRCJzlfRnFqQ=;
        b=bU2nwtLvjukhLgOseHhjHLAjWVCEnqPGGnkENSarbFCfYzjmiayRV67GKH5WpW+0aZ
         25G0vlG1jMSBks5hVoOwA+tWHLlvSFmU3HKxGyi+LIMW8ePTpPTDagi1Sj8eX6iBXuzI
         HHbloofTOhLLL1jgXMCeo8oX/MD5Uwe54lQQPsfb6nCx5diGxf8OP/yiDfOoq9b2do8S
         +hfhvaFczpLvuhatUDVBIIWgPq5UGoYZ1V5I1bilC6jkHrrr+kxMvzsq7WAj5G0be2jg
         NuAlGqu9oXAFWnVnHTrxW17TYlngTXn498A5JCeiLmtc/wvr3tMXbp1MqxlEHLt/2hdd
         C0xQ==
X-Gm-Message-State: AOJu0YwQhE272Qv+PHowKdTOILpB4Aufsdp1fNuiul+wmLH8A01qSdhW
        6UXVt/yEscgXRrE/TiCjVRE=
X-Google-Smtp-Source: AGHT+IELufpf/afAfT2Z7Touti4YQrWwKv1deBMsWqtCBLnXQXbzuPzjEsbciqxS97VmWcBRlb27pA==
X-Received: by 2002:a05:6a20:9390:b0:159:e4ab:15ce with SMTP id x16-20020a056a20939000b00159e4ab15cemr15313432pzh.15.1699265537393;
        Mon, 06 Nov 2023 02:12:17 -0800 (PST)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id q4-20020a056a0002a400b006be4bb0d2dcsm5529216pfs.149.2023.11.06.02.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 02:12:16 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 8B301803540B; Mon,  6 Nov 2023 17:12:10 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Ross Philipson <ross.philipson@oracle.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 1/2] Documentation: x86: Indent note directive for protocol version number note
Date:   Mon,  6 Nov 2023 17:12:04 +0700
Message-ID: <20231106101206.76487-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106101206.76487-1-bagasdotme@gmail.com>
References: <20231106101206.76487-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245; i=bagasdotme@gmail.com; h=from:subject; bh=0AsYoOImK8yW9QMJSvMT7LCOsE3kSASqZ9Au0ZMrQ+I=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKkeu/tMQgvmiRbX31xtvJnR69a8J8wL+p2d772ZJldqJ xI55cPNjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzk1k5GhgkWZya78SyT2Tth xs4iN+3gJd7xlk45q8Mrpvud3hq9KJWRYcN78dxVl7LvnZS7EC2v6mQZwXtQz8tz0wOpTfMZLzl N5wAA
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

The protocol version number note is between protocol version table and
memory layout section. As such, Sphinx renders the note directive not
only on the actual note, but until the end of doc.

Indent the directive so that only the actual protocol version number
note is rendered as such.

Fixes: 2c33c27fd603 ("x86/boot: Introduce kernel_info")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/arch/x86/boot.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
index f5d2f2414de8b6..22cc7a040dae05 100644
--- a/Documentation/arch/x86/boot.rst
+++ b/Documentation/arch/x86/boot.rst
@@ -77,7 +77,7 @@ Protocol 2.14	BURNT BY INCORRECT COMMIT
 Protocol 2.15	(Kernel 5.5) Added the kernel_info and kernel_info.setup_type_max.
 =============	============================================================
 
-.. note::
+  .. note::
      The protocol version number should be changed only if the setup header
      is changed. There is no need to update the version number if boot_params
      or kernel_info are changed. Additionally, it is recommended to use
-- 
An old man doll... just what I always wanted! - Clara

