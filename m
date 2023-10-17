Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D14A7CCD94
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbjJQULe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJQULb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:11:31 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E1A6FAA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:11:29 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7b9e83b70so46359407b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697573489; x=1698178289; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=46uGEBVZYP60+QlvEII0CTGZBlglU94CwFi36yzEJK0=;
        b=AeVtC2BSNpT8MtYUSkZrW8w/3ODWpmPxbbm5cApqPOQSvPO7gpWubgFc7NY0L3fe+9
         5vLqEngKLXZHvJ7u+ZfDE3jKt/Z19nQKMaLQHmgoNwPChNVCWtDELGtkrkS0kLAhk+ho
         tMti36yuHPrk9yCcbfgcOUOVqlaLATBWM6H/orinkDfqQLl72QEanTne7tjBgV+BxYiZ
         0dxKlAbBum/K6cBAdc3+QtCJkXOOo1x4yGOCUjgRnfSbupkj+BNLxpcEWKrZoG/UHg6J
         jq70bBYizPgNKFEvzj0Mb6X5jPvnFN8JLmuTRPMDQ+cUwgtppx+LN048rBK96bmQ6f5W
         x41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697573489; x=1698178289;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=46uGEBVZYP60+QlvEII0CTGZBlglU94CwFi36yzEJK0=;
        b=RsY6DlKWXJw3uGGWOTFeLV7h5LTmMdlepEkxxEqvJM/YQBRwNwumZ8JhMEIX5Wi9mE
         3JngzjAhSyccmJ735o3iKcB5SswP/LLOeI1ncsaaR8BVqAcSs3pEubw3tPz6n82cQlVq
         S2dL9pVW+QnleftUl7aYRg6zBs/VSPv4CfLXkT3bxpoVj4rSGB+BuvBy+kBy7hPghI+S
         h8whhh2l1pYze5YqylAvlepsVGND4nsYddTC6fYoHJNc63ECWt7yBl9lg7DGvEarA4ax
         CALU7xqKV/WVdwM9r9IMDM5qjkgJpiWvw9wR3I/zR3fooOyFiBYzyOIl5E6Sq1EUcFbR
         Qbtw==
X-Gm-Message-State: AOJu0YxQ8uFLt61DZLKqU6eyTe+FAWANSiJOAt+EIb98fxMLpP8vgeiq
        Dnuhtyr7K4+qudjvoKZcnCqSgGbipT5SLeJN/g==
X-Google-Smtp-Source: AGHT+IEfJLWMLoOm4C5rtgg3wHRXpdPuCDymBXGKzRp1SsYn6OfhPJ/L9Vc3+vwyzmjrpHdHSKS0VUjS83Q/Y+1Wlw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:2e87:b0:5a7:b95c:a58f with
 SMTP id eu7-20020a05690c2e8700b005a7b95ca58fmr71164ywb.1.1697573488855; Tue,
 17 Oct 2023 13:11:28 -0700 (PDT)
Date:   Tue, 17 Oct 2023 20:11:27 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAG/qLmUC/7WOwQ6CMBBEf8X07JpuQWg8+R/GQ10WaALUbEnVG
 P7diifveps3yeTNU0UWz1EdNk8lnHz0YcpQbDeKejd1DL7JrIw2BWqsIM4y0fUBjfjEEmHiGW5
 eeOAY4SLBNRTGHGi02iCuqR0dAbXdpyFwRqO2pcHK7lU2XYVbf19fnM6Zex/nII/1VMJ3+1t/Q kAoTVFaXZPTNR+7ELqBd3mq3geS+YPUZGlF9b6qGZviYr+ky7K8AFHQlQeMAQAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697573487; l=2149;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=IYHa4GmWLvGCvatbI5bBzz5yNCmTjMuR/IQRybWbAVA=; b=92S9SAvX+VpKkETDSsphUKuxpQoOMQ38sXOjPqap5XFBJDgU6idJpjDTsAT6xQE5WhuPekvyN
 ZGd3Vn32yiOB+ntaW9DlkyRHaWbxMNkQ7hltpgq0KkZV8Pz03ozInsQ
X-Mailer: b4 0.12.3
Message-ID: <20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-0-af780d74ae38@google.com>
Subject: [PATCH v3 0/2] wifi: brcm80211: replace deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series used to be just one patch in [v2] but I've split it into two
separate patches.

The motivation behind this series is that strncpy() is deprecated for
use on NUL-terminated destination strings [1] and as such we should
prefer more robust and less ambiguous string interfaces.

In cases where we expect the destination buffer to be NUL-terminated
let's opt for strscpy() as this guarantees NUL-termination. Other cases
are just simple byte copies with pre-determined bounds; for these let's
use plain-ol' memcpy().

Each change is detailed in its accompanying patch message.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v3:
- split up into two separate patches (thanks Franky)
- use better subject line (thanks Franky + Kalle)
- Link to v2: https://lore.kernel.org/r/20231016-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v2-1-6c7567e1d3b8@google.com

Changes in v2:
- add other strncpy replacements
- Link to v1: https://lore.kernel.org/r/20231016-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v1-1-4234807ca07e@google.com

---
Justin Stitt (2):
      wifi: brcm80211: replace deprecated strncpy with strscpy
      wifi: brcmsmac: replace deprecated strncpy with memcpy

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c      | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c  | 6 +++---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c      | 3 +--
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c     | 4 ++--
 5 files changed, 8 insertions(+), 9 deletions(-)
---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231016-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-a20108421685

Best regards,
--
Justin Stitt <justinstitt@google.com>

