Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060887D95C9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345549AbjJ0K6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjJ0K6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:58:09 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7921B9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:58:06 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40839652b97so14064765e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698404285; x=1699009085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RBxCYwkgwqvXS64i1/f9pn1wIDxm2mMEk8PWmVP+ZkI=;
        b=ESk76z3aRdfQ1M+sCjjVozYVOqLMZPqTYmxOnhsHSlZo0wHCH9N6yO+zIsX41QOrht
         SBQKreNjo49ke/fAa9dkn7I5ra5HLbGaL0pRdyMzmdVyrljQE6I3Tinn6s4JKwEj4tl1
         0xjbUbxu5zuGM6JPqkmWZU2RhZiXCEbPiwjSpPctRLz0jlm454ZQkkDPVcuMjDP0a6jP
         Yl1WPegLIziSMUcahfMV0C3wIgN53dn1g1LFm/z4OZEkWyQs5zQX/MXSaT0WrlJB0aoH
         M04DE27lVYU2va3VdouofLWNBBfFptrNWNyQh4Jg55Rmn93kQvof9Mm1xF5jgtTErHU6
         bo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698404285; x=1699009085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RBxCYwkgwqvXS64i1/f9pn1wIDxm2mMEk8PWmVP+ZkI=;
        b=lKbRkFkOyZrytYZWXdeeUqUeSOZ0O8BtLgqYeiYVVnlcl0LWvQlvfHyDQpndMoLRnb
         KviAuhSITIWXzR4mtBbwTbXvAZSRHcYESQm3nMcuV+Wj9ftJD5t2K3f1GpjMqrMA5R7R
         ZBtvDCZRbTS7TuAAkSje2doIhBr3V61owRFeQ0rpxLjUWPomB21STwZZrpPxJuKcViuQ
         tz+u8q9r4Qr4j7WF6dzA9x7X+vaiy6QT9yqL0e0PZOBNC5A3Vpa39AQNMEVWAcbdatFa
         OIcPhu5hLAijhlEFNVAKTloYFZpUP7c0KYKNpG70X14/BL52Nobg7FWUmwZ8qGfUCUmH
         KYGg==
X-Gm-Message-State: AOJu0Yyf5zceAIF0FabuHK2vjcC3TmutDiYksyAsTfAmRlKA4JXWDjbN
        udsEHpLMjPY9mVcrQHB+qeSCrw==
X-Google-Smtp-Source: AGHT+IGZYEf8c+/lua8h+SnSoJB5LjGPN4HkF+8ldxt9U7atl2DIxT1TcVgudaTiKc5lMJP/26iErg==
X-Received: by 2002:a05:600c:1546:b0:3fe:4cbc:c345 with SMTP id f6-20020a05600c154600b003fe4cbcc345mr2034089wmg.41.1698404285012;
        Fri, 27 Oct 2023 03:58:05 -0700 (PDT)
Received: from srini-hackbox.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ay32-20020a05600c1e2000b004065daba6casm4819626wmb.46.2023.10.27.03.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 03:58:04 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     johan@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 0/2] ASoC: soc-dai: add flag to mute and unmute stream during trigger.
Date:   Fri, 27 Oct 2023 11:57:45 +0100
Message-Id: <20231027105747.32450-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Click/Pop Noise was a long pending issue with WSA Codecs which are prone
to accumlate DC when ports are active but without any data streams.
There are multiple places in the current setup, where this could happen
in both startup as well as shutdown path.

This patchset adds a new flag mute_unmute_on_trigger to dai_ops to let
generic code do the mute/unmute on trigger.

This patches help fix those issues by making sure the PA is Muted/Unmuted
inline with the stream start/stop events.


Srinivas Kandagatla (2):
  ASoC: soc-dai: add flag to mute and unmute stream during trigger
  ASoC: codecs: wsa883x: make use of new mute_unmute_on_trigger flag

 include/sound/soc-dai.h    |  1 +
 sound/soc/codecs/wsa883x.c |  7 +------
 sound/soc/soc-dai.c        |  7 +++++++
 sound/soc/soc-pcm.c        | 12 ++++++++----
 4 files changed, 17 insertions(+), 10 deletions(-)

-- 
2.21.0

