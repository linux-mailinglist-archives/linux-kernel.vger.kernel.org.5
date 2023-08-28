Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0369678BB13
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 00:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbjH1Wje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 18:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbjH1WjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 18:39:14 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5D1189
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 15:39:11 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-34bbc394fa0so2676685ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 15:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693262351; x=1693867151;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vBmVIkqWHQEa837GVRmryXEmyC96Ro8XfMG9WRXh9FQ=;
        b=GdSEPouEjpzqLVTjSXKzN3n79A+2lZFWBJQZsSspboz1zKsENZpnlVnBmGLUd6m8X6
         oUG28FouGokC0MOSrPd/QuYdBhCj3Gt8zDHh3js0mspw+yAIJ+q7pkFJU+refVDfI3H9
         DBC57MEVOBfaKV/6mfX+HijIp8iuZKKctVHFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693262351; x=1693867151;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBmVIkqWHQEa837GVRmryXEmyC96Ro8XfMG9WRXh9FQ=;
        b=QA5ivCcG6sxJ52Iz3Mvh0Lua8Yt2ctoJkesTz2L9bo+VbOpTbQxjTFrRGPmUi0/P6u
         By27JK6jjVRz2ouDZFelkbbtwHWPZqofe5pz2aPC0g0BvlG/ZfYGVzkaPqHhOai8rmHs
         cCoBah32khWc9n3DgcPEOEdN3O4DyNRDFbK6GSx3tQaxyfyn5tNjfYZyzfxZF2+TkSwy
         zEMMcVX30cUGZy0LpwbSTolXu7fKglR1luFIJbOYaibHtOMIGmJijNEf+KL1MjD0DrvB
         pb+ZgOXJsV57zTnxcpJYdRCpSj0mwkLd+GNocko5QYoTpErWnTMrhbGe5J25Z6Yf3oFr
         TaYQ==
X-Gm-Message-State: AOJu0YzedbCVKVrNXvbwt1DdpJMfIvQSafbZ90KPL6zngAUcXMh91L4Y
        5qocvUBdccOMfiRTP0xU/bEqiA==
X-Google-Smtp-Source: AGHT+IHA9MxCJtNG6yfDLCJ6N950f4emH+svW+A2yETCyvgmVJhx+eLpUz04hZsvoSuf4aLUY7GNLw==
X-Received: by 2002:a92:da88:0:b0:349:4e1f:e9a0 with SMTP id u8-20020a92da88000000b003494e1fe9a0mr27738984iln.2.1693262351216;
        Mon, 28 Aug 2023 15:39:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c1-20020a92cf41000000b0034ca3b29c5asm2709408ilr.57.2023.08.28.15.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 15:39:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------FwGEhnp4yGGfwEPLEBIGjuQn"
Message-ID: <7f3f12a8-fb4e-fa6a-aeb6-5ebcdfddbee0@linuxfoundation.org>
Date:   Mon, 28 Aug 2023 16:39:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     shuah@kernel.org, skhan@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 6.6-rc2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------FwGEhnp4yGGfwEPLEBIGjuQn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower update for Linux 6.6-rc2

This cpupower update for Linux 6.6-rc2 consists of a single fix to
add Georgian translation to Makefile LANGUAGES.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 99481d2195bfd13a663904e6014887abf46b57c7:

   cpupower: Fix cpuidle_set to accept only numeric values for idle-set operation. (2023-07-18 16:07:08 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.6-rc2

for you to fetch changes up to af75504c38960d5331b8c6c83ea9981e26d659e6:

   cpupower: Add Georgian translation to Makefile LANGUAGES (2023-08-17 14:28:16 -0600)

----------------------------------------------------------------
linux-cpupower-6.6-rc2

This cpupower update for Linux 6.6-rc2 consists of a single fix to
add Georgian translation to Makefile LANGUAGES.

----------------------------------------------------------------
Shuah Khan (1):
       cpupower: Add Georgian translation to Makefile LANGUAGES

  tools/power/cpupower/Makefile | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

----------------------------------------------------------------
--------------FwGEhnp4yGGfwEPLEBIGjuQn
Content-Type: text/x-patch; charset=UTF-8; name="linux-cpupower-6.6-rc2.diff"
Content-Disposition: attachment; filename="linux-cpupower-6.6-rc2.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlIGIvdG9vbHMvcG93
ZXIvY3B1cG93ZXIvTWFrZWZpbGUKaW5kZXggZGM1MzE4MDVhNTcwLi5iNTM3NTNkZWUwMmYg
MTAwNjQ0Ci0tLSBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlCisrKyBiL3Rvb2xz
L3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlCkBAIC01Nyw3ICs1Nyw3IEBAIExJQl9NSU49CQkJ
MQogCiBQQUNLQUdFID0JCQljcHVwb3dlcgogUEFDS0FHRV9CVUdSRVBPUlQgPQkJbGludXgt
cG1Admdlci5rZXJuZWwub3JnCi1MQU5HVUFHRVMgPSAJCQlkZSBmciBpdCBjcyBwdAorTEFO
R1VBR0VTID0gCQkJZGUgZnIgaXQgY3MgcHQga2EKIAogCiAjIERpcmVjdG9yeSBkZWZpbml0
aW9ucy4gVGhlc2UgYXJlIGRlZmF1bHQgYW5kIG1vc3QgcHJvYmFibHkK

--------------FwGEhnp4yGGfwEPLEBIGjuQn--
