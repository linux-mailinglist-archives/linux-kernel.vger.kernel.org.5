Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBD47E3FEE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbjKGNV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjKGNV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:21:26 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE95193;
        Tue,  7 Nov 2023 05:21:23 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c54c8934abso80117591fa.0;
        Tue, 07 Nov 2023 05:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699363282; x=1699968082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MUi45uotdvyO5SvA8WtxVVI3cIS2ABVk7+gmYyea7NQ=;
        b=JvfhQHWg1CG4NkDiaRvbKJ3TktRJ1GXgTc0jUfTfP2ALISYfXokcsTXDWw/OyawdfP
         y72+U0Be/htGIINoqbCwsQ5emLLcVj0XVKpP749c6UJYHrU4KY6ELI2QD8uQZoAHXQNU
         EOlRG2gj99S1UfDdrakMym3nOTLv8FiRBM8hNjogA6aNrhBb7EW9BTcxhV3g3xKgHH9t
         ufvkrz0e13HYsj6SpJduPcB/7NSyExVV2IMdfIA43SvB1dMLMGPQWxugjpkZxhn0STfM
         0HIrSSubm2IpdGHYGmYeAIbDOxmbPV7WOBl9ItrX9MwpslA+kwXqVVFaTkuo0gsqVb0J
         eKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699363282; x=1699968082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MUi45uotdvyO5SvA8WtxVVI3cIS2ABVk7+gmYyea7NQ=;
        b=AZ0jJoTJ/kmcCkUBXzZqUGujVsgWl1BbsqaUns3Mg/6c/0C/u9cLj9MhA5MZUl16/j
         b0laZZ1FPTYIbKrMQyVmwXmScwtxeSgX5cuUtcoRb75gT63xc7Y/DuEHHMbGcQ7OOSZr
         sDUd1iXtK5SBg7fCeo40mxgWYr9Y4N4h2rdoUy/OGuxwGF+FQ9XVOknauX/9q1uuh/8W
         dMZvHZJmaGcRVhZ4gpy3TdrQsbRH1lly4w6Re2u6KCvdth3hZqsrp25Nm4pYkPVz9mFn
         4lHmFvEp5ngnyavmloOARvkZOe9EyWtvLjqkA4euarRiSHZwGZXwgHZJiMme+pPk5f5f
         PpQA==
X-Gm-Message-State: AOJu0Yz+jrwyj+P57R7C4dYcXE6/DbFhW6GoeYoGg6j7pBMhOWc69iq/
        uwfUZBpEjfnJ6wWGEGYxgRsbUarv4WhHUw==
X-Google-Smtp-Source: AGHT+IFjmb8+t40a3B6RdTpZwfkF+fKs31Rm+fImNN7KFuFw04Vq8jI/nM8jWSmRpWOUyJOhVCk1hw==
X-Received: by 2002:a05:651c:2203:b0:2c5:128c:fae8 with SMTP id y3-20020a05651c220300b002c5128cfae8mr30885000ljq.30.1699363281912;
        Tue, 07 Nov 2023 05:21:21 -0800 (PST)
Received: from ubuntu.. ([188.24.51.27])
        by smtp.gmail.com with ESMTPSA id w7-20020a5d5447000000b0031980294e9fsm2356297wrv.116.2023.11.07.05.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 05:21:21 -0800 (PST)
From:   Ana-Maria Cusco <anamaria.cuscoo@gmail.com>
To:     Ana-Maria Cusco <ana-maria.cusco@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add ADRF5740 driver
Date:   Tue,  7 Nov 2023 15:21:15 +0200
Message-Id: <20231107132118.1165494-1-anamaria.cuscoo@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ana-Maria Cusco <ana-maria.cusco@analog.com>

This patch series adds support for the ADRF5740 Attenuator within the existing 
HMC425A driver.

The ADRF5740 is a silicon, 4-bit digital attenuator with 22 dB
attenuation control range in 2 dB steps.
It offers parallel control mode through four digitally controlled inputs.

V1 -> V2:
* dt-bindings: arrange entry in alphabetical order
* improve title clarity

Ana-Maria Cusco (2):
  iio: amplifiers: hmc425a: add support for ADRF5740 Attenuator
  dt-bindings: iio: hmc425a: add entry for ADRF5740 Attenuator

 .../bindings/iio/amplifiers/adi,hmc425a.yaml  |  4 ++++
 drivers/iio/amplifiers/hmc425a.c              | 23 +++++++++++++++++++
 2 files changed, 27 insertions(+)

-- 
2.34.1

