Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FC57B6D88
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjJCP5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbjJCP5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:57:21 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE50A7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 08:57:16 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ae75ece209so196961966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696348635; x=1696953435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=umZ+8oKDYfik3oT0i9Ef96i8g6lg2rgWnjuQEEXA5OA=;
        b=Tp4LPHbeK/QU8dPsAEEC3MHuSqwJ/fiTrDHLB8rIz12KdqEjlt+hDPspjOW8q20knU
         oukz2q6uVkypXsvF702PtXhdPDzuGDVFD69lNjOUXhpk9KzuOi4b/NB4p1Gws3fWbMFL
         DNMEgHKAwA4YiCdTxt8V69g9O9eKDL+0y/IzwqEad6uxhi0LT0XUrrVqC0phg4w8znAO
         Ky43OpYKhQJMyUETIVJGQrO0YvKY5gVU7JBa+74TqGG7xc1Z9FVReJNr8+DTYH/U5+OV
         Jf/WyhlBDic466FNbg0VWrLj8dePTZKDDd3ve1SYEyOhICSj5kivvO7IzbxJGToTXPLb
         9IFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696348635; x=1696953435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=umZ+8oKDYfik3oT0i9Ef96i8g6lg2rgWnjuQEEXA5OA=;
        b=PjXXjHdjzkf9NY9uwv8826QOztJ5PSEHuHTvDzyRlGGGxQzvFl2JjBmWr8R/1rwahg
         nBrNGHMIhcxbb/yqs4cIw+JKLqQiGJ+TciAsK6qzRMA5H20l+aICiSLCxkqv8TMpHXeW
         y7K3ZBKb0wJlyVncw4kIHZ2MebGWjkTDN26Wwb0AaRBH5cShHXqrrnN/XBOSo+CMi0pG
         NsD3EndzszAwbcmXsbaHesbxBuz9wFev6HiR3zQZ2HRSt2QOe0fTR+Uswrh7q+CM7/hn
         s9GKcAJOi1ExVrRUzcaZG9yDo16YkO6GvegXQxVJScW6j45wY8M7Q1OxgpHMIzn46f3j
         scAw==
X-Gm-Message-State: AOJu0Yz0+UWSo2YNww0Dvcjl3oz7+7KUVinI1jiKmQ3Dyx5LRhvQgGfm
        hxCfUEDoqXLniQqqnTctF9hGkg==
X-Google-Smtp-Source: AGHT+IHdJHFnpnjzifSM5/sGMF/eTk/Jh1MeVpKW1pBhyHkKe/pZiH+yTfo51m2c9cQjrpdYVAyiRQ==
X-Received: by 2002:a17:906:13:b0:9ae:588e:142 with SMTP id 19-20020a170906001300b009ae588e0142mr14014095eja.67.1696348634904;
        Tue, 03 Oct 2023 08:57:14 -0700 (PDT)
Received: from krzk-bin.. (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id w25-20020a170906481900b0099bc2d1429csm1288088ejq.72.2023.10.03.08.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 08:57:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/2] ASoC: codecs: fix widget name comparisons
Date:   Tue,  3 Oct 2023 17:57:08 +0200
Message-Id: <20231003155710.821315-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some codec drivers compare widget names with strcmp, ignoring the component
name prefix.  If prefix is used, the comparisons start failing.
Add a helper to fix the issue.

If the approach looks good, I will fix other codec drivers.

Best regards,
Krzysztof

Krzysztof Kozlowski (2):
  ASoC: soc-dapm: Add helper for comparing widget name
  ASoC: codecs: wsa-macro: handle component name prefix

 include/sound/soc-dapm.h           |  1 +
 sound/soc/codecs/lpass-wsa-macro.c |  4 ++--
 sound/soc/soc-component.c          |  1 +
 sound/soc/soc-dapm.c               | 12 ++++++++++++
 4 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.34.1

