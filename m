Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32E87B548D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbjJBOA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237619AbjJBOAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:00:21 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3533CAD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:00:16 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50305abe5f0so25237961e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 07:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1696255214; x=1696860014; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zpZhytU+mtyOMS/VgBxlj3+c2Lys7k0tYKY4H/RoMIc=;
        b=Ginm017MxEquRCV2mk7/P7g0EIxBqpgdlFFc7ndlsIl0p+gcF9qLJTWQWnOrjtC/b7
         aTYss4JN0kgNO9ldJWcgiv41quD7dWNbfmocFwf8rm/goUZ+ZkYk/seUIdx/X+jHqoMc
         4d0wef2VcqqhDtfQQrz6czzeY9EwwIBdjekyFsGWeSh9DISW0V0Qz0La+qAK0PP5/5ZF
         QXHYAJoL4a14hN3P7q/+MYhQiG3osQQYAhpv7aFCWDNfy422wW5K98XXcNRD9sgU5Q59
         h/tumQsNbAcPtEEADbrGhMwUqiSDmZ0svwYhKzJK2sCPWoFyMosh0z7W5ZgmRkCyz740
         h24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696255214; x=1696860014;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zpZhytU+mtyOMS/VgBxlj3+c2Lys7k0tYKY4H/RoMIc=;
        b=HPGVn+WffqXfCT2saJaFgcnbc4MhdG0lmTS48+mcAsy8NW1nguh7xYHuxcpTYGYP0I
         Z+xsenEO3uHLdz0JD8msz+bXLA/5spdRcoDIKqOwlZCFRjLMDfyeO+GReD/OU9RJLZVa
         sOX1aq4iRxE6CzuLHqf4dBlsdvcpQzVRuGxhJETkD/WFBq61JIaE5QznYunwb/vh5LyG
         xNxCCnRDzBCPzc7nj0Ixi4xpOI09YbAOb86T2tEX3QJ1oDbTFNTuqIiKOk0ALtc19aBI
         LWQlAQ2V3lgZTs2zpESh7RcuGMlETf7naDr9/WfSZEjf9dvCjKeyBwY6JOXjNaTkSVg0
         W44A==
X-Gm-Message-State: AOJu0YylNE3gx6ddb5ioDGvBI38779hjEfbA51+WIb7cWWnn70DNJmHh
        sYcXTJXGazrYSFEgAIXlrp244A==
X-Google-Smtp-Source: AGHT+IGso9r5zHTjq+JheuE+Q/cqqFcdJ//IYpcalgTIQ1LdA5XgDbH9CA6sx9n8hYQEZLx5OnqiXA==
X-Received: by 2002:a05:6512:ba7:b0:4fe:db6:cb41 with SMTP id b39-20020a0565120ba700b004fe0db6cb41mr12425999lfv.39.1696255213950;
        Mon, 02 Oct 2023 07:00:13 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id q13-20020a056402518d00b005346925a474sm9350377edd.43.2023.10.02.07.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 07:00:13 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v2 0/2] Remove reset GPIO for AW88261
Date:   Mon, 02 Oct 2023 16:00:10 +0200
Message-Id: <20231002-aw88261-reset-v2-0-837cb1e7b95c@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOrMGmUC/3XMQQ6CMBCF4auQWTumHUQpK+9hWNQyyCykpCVVQ
 3p3K3uX/0vet0HkIByhqzYInCSKn0vQoQI32fnBKENpIEW1MmTQvtqWzhoDR17xwkoNhqkxDUH
 5LIFHee/erS89SVx9+Ox80r/1n5Q0ahzd3bE2J9tSfR2thGXyMx+df0Kfc/4C3Prpf64AAAA=
To:     Weidong Wang <wangweidong.a@awinic.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AW88261 chip doesn't have a reset gpio, so remove it from the
bindings and from the driver.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
- Include dt-bindings change
- Link to v1: https://lore.kernel.org/r/20230929-aw88261-reset-v1-1-fcbce194a823@fairphone.com

---
Luca Weiss (2):
      ASoC: dt-bindings: awinic,aw88395: Remove reset-gpios from AW88261
      ASoC: codecs: aw88261: Remove non-existing reset gpio

 .../devicetree/bindings/sound/awinic,aw88395.yaml        | 16 ++++++++++++----
 sound/soc/codecs/aw88261.c                               | 15 ---------------
 2 files changed, 12 insertions(+), 19 deletions(-)
---
base-commit: df964ce9ef9fea10cf131bf6bad8658fde7956f6
change-id: 20230929-aw88261-reset-7e00d9e25952

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

