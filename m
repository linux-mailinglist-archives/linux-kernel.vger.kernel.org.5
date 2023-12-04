Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB71803354
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjLDMrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjLDMrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:47:36 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7A2A8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:47:42 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54cde11d0f4so856931a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701694061; x=1702298861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/S3g4FV/iGDfW3ps7M4rheJELxKDhQrVaKwMBGZuxiY=;
        b=iho0R8V4dHCjwJmpDKGNd5AnLXsuvWNnn7+xJ3iFTKtPHQA0wSzH3ruu6r3tza5vA0
         wRhZEx9cRYqWrkECLQP4JOpCBe4z4YaqaJUs+Z+/w7AQ6nOk5JcR6xBAKuR9F8Zsbw9B
         MU7M1fyjqrvTjMSoaXz34oxsIlLo7nMapygMfAN4C95khaSvjAjBDxlwm8ylfWSF6tZJ
         oW/GQ3Qmj2MixJKgBXGweRL5Bmqtj7+T3aWIoehcfzF0OU2rK0Ow51cfCl9+SAiz7P5K
         SAopvEq//xEOhNg/o6QxQDxqwhb99N+TIUcg1SzXACP0Q8Rzz6XaC/Ok/0Ye/lhSmcOu
         8A9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701694061; x=1702298861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/S3g4FV/iGDfW3ps7M4rheJELxKDhQrVaKwMBGZuxiY=;
        b=AQzoKUo2ySRa95PPkvL0rTdyS5t1JQnPiPYBLT1Dy5AO/u+kGCBWujXmZuzY+/qgiR
         8A/0/KWe9p0J62Cw9KQBWmbpuXnFTHohfNRPlwuPJG8sTgKHMel6YVIipTw90ABDkAf8
         DEwCcUxjqGSzbOPV+XPb45Fk+0seZyxgj6vEsAI5BiHlanfDv0RoejRmRNT2TPeSjuGL
         DsuDJOkt2/qJxKsZTu0kbR2OUDfTUG31ZkHbilRGgWwjlGvISqyZsP1Ue2Wihu9/66GM
         0d2mY9o7ohf2S8SZvJzFeg4b4O64b1LNOfLGqggOMk4dp2Wn6EJm2iQbtdbGlSWIcHEM
         IYVg==
X-Gm-Message-State: AOJu0Yzbe3jtK5JbWW5hZXlVufplIgdHJS7srfeJTMCK0XXQE4IzyUjm
        bknARELP7CZyqVXzfrEjX82jbQ==
X-Google-Smtp-Source: AGHT+IF7lYKcq8TAJsw65A/PZFXqqONqGeNcKTt6yJrGmPFcJBo/4G1hXhQpgMC4aF1Y++2UOozUiA==
X-Received: by 2002:a50:d799:0:b0:54c:4837:a665 with SMTP id w25-20020a50d799000000b0054c4837a665mr2965090edi.82.1701694060814;
        Mon, 04 Dec 2023 04:47:40 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id dc15-20020a056402310f00b0054ced65bd26sm457017edb.41.2023.12.04.04.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 04:47:40 -0800 (PST)
From:   srinivas.kandagatla@linaro.org
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] ASoC: qcom: Limit Digital gains on speaker
Date:   Mon,  4 Dec 2023 12:47:34 +0000
Message-Id: <20231204124736.132185-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Limit the speaker digital gains to 0dB so that the users will not damage them.
Currently there is a limit in UCM, but this does not stop the user form
changing the digital gains from command line. So limit this in driver
which makes the speakers more safer without active speaker protection in
place.

Apart from this there is also a range check fix in snd_soc_limit_volume
to allow setting this limit correctly.

Tested on Lenovo X13s.

Srinivas Kandagatla (2):
  ASoC: ops: add correct range check for limiting volume
  ASoC: qcom: sc8280xp: Limit speaker digital volumes

 sound/soc/qcom/sc8280xp.c | 17 +++++++++++++++++
 sound/soc/soc-ops.c       |  2 +-
 2 files changed, 18 insertions(+), 1 deletion(-)

-- 
2.25.1

