Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641EF7A029A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbjINL2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbjINL20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:28:26 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B8E2109;
        Thu, 14 Sep 2023 04:28:18 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401da71b83cso9083515e9.2;
        Thu, 14 Sep 2023 04:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694690896; x=1695295696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xQ4JSvALWwFERJLvgTZEaGF4FKSCIvpNYYc8CXH5D3Q=;
        b=aWHFjFUmu7LSGmcs1LejzkoRXO/xS3DmcN8e+ZcMY2QmpE5NiegdkFudCexMadWZf2
         D/qLMXeOVpuQ28d6meaAp/iu3r6dt2x7jDbTgAca6Gr4YTtvvedMz/7JWZg0ym8hBNvP
         xD02SwF9eNK0F2aM01su00WUlnwoIIVFE0g/sZhk8Dr3jGXk/5MmfYPieG5Xv2HTQI5z
         hFxQpcBWd0F1R8dtd3eEIUQsQVO74AgwSh0CN+fC4cTt0hxGKUAb1wRzNgD79tXJAho4
         t+lkMh8zZwBh8gMH96lTE/r/cz7TjZTV2r6TNgv4jNIiTJKWbsLXwLJ5ATzRXM0DL5Ie
         FFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694690896; x=1695295696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQ4JSvALWwFERJLvgTZEaGF4FKSCIvpNYYc8CXH5D3Q=;
        b=WiIPoNeTZv0uUPFYl1LFoakNXYQKf3efb7Kc7XCwcGpy4TfXqBacY0FBby1+oVj0Q9
         wHcpF/qaAYKV0gghaoWfE48S5Y0aJNRu0nTqnCfYHfI0CutsSnk76WmuXRhWglp/xgtF
         9E4GIoasMCG9ATlCfiRK/g6o/jvXwHU+PUq3BSCJQsFBUptZj2IStK5X8Tl32rKo501b
         G4kjC/jSDSyJ4gb4VM0lwyrjrdiwJynlTOjfPy1sfsiPv8cMj9wv7D8vvyB14ePsYWQr
         4LKNnbcGGwWEhbYuK8hmh4rV2KKXsn44HQTJjF9Dg6vokSCDl2eUARclm/bYzy3JuiNs
         0/BA==
X-Gm-Message-State: AOJu0YzjtcXgfokzV/znam+Hah89/elzWZbiMpBVaa74QbX6weLf9Dtd
        eS4S64fO6iHISisN+prk4iMw6Aes7frh9Q==
X-Google-Smtp-Source: AGHT+IEIs8UsiLCX8vS2k4dyGrRuq4U/UPnsQZYK+q3aG92sLgM/+ZObI42HG8W2u9lkURI+y8OtUg==
X-Received: by 2002:a1c:7912:0:b0:3fe:2b60:b24e with SMTP id l18-20020a1c7912000000b003fe2b60b24emr4484855wme.29.1694690896217;
        Thu, 14 Sep 2023 04:28:16 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
        by smtp.googlemail.com with ESMTPSA id l36-20020a05600c1d2400b003fef5402d2dsm4786764wms.8.2023.09.14.04.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:28:15 -0700 (PDT)
From:   "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Alessandro Carminati <alessandro.carminati@gmail.com>
Subject: [RFC PATCH 0/2] Enhancing Boot Speed and Security with Delayed Module Signature Verification
Date:   Thu, 14 Sep 2023 11:27:37 +0000
Message-Id: <20230914112739.112729-1-alessandro.carminati@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch sets up a new feature to the Linux kernel to have the ability,
while module signature checking is enabled, to delay the moment where
these signatures are effectively checked. The feature is structure into
two main key points, the feature can be enabled by a new command line
kernel argument, while in delay mode, the kernel waits until the
userspace communicates to start checking signature modules.
This operation can be done by writing a value in a securityfs file,
which works the same as /sys/kernel/security/lockdown.

Patch 1/2: Modules: Introduce boot-time module signature flexibility
The first patch in this set fundamentally alters the kernel's behavior
at boot time by implementing a delayed module signature verification
mechanism. It introduces a new boot-time kernel argument that allows
users to request this delay. By doing so, we aim to capitalize on the
cryptographic checks already performed on the kernel and initrd images
during the secure boot process. As a result, we can significantly
improve the boot speed without compromising system security.

Patch 2/2: docs: Update kernel-parameters.txt for signature verification
enhancement
The second patch is just to update the kernel parameters list
documentation.

Background and Motivation
In certain contexts, boot speed becomes crucial. This patch follows the
recognition that security checks can at times be redundant. Therefore,
it proves valuable to skip those checks that have already been validated.

In a typical Secure Boot startup with an initrd, the bootloader is
responsible for verifying artifacts before relinquishing control. In a
verified initrd image, it is reasonable to assume that its content is
also secure. Consequently, verifying module signatures may be deemed
unnecessary.
This patch introduces a feature to skip signature verification during
the initrd boot phase.

Alessandro Carminati (Red Hat) (2):
  Modules: Introduce boot-time module signature flexibility
  docs: Update kernel-parameters.txt for signature verification
    enhancement

 .../admin-guide/kernel-parameters.txt         |  9 +++
 include/linux/module.h                        |  4 ++
 kernel/module/main.c                          | 14 +++--
 kernel/module/signing.c                       | 56 +++++++++++++++++++
 4 files changed, 77 insertions(+), 6 deletions(-)

-- 
2.34.1

