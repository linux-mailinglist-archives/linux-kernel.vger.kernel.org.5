Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48B87E9A3C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 11:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjKMK0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 05:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKMK0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 05:26:18 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C50D78;
        Mon, 13 Nov 2023 02:26:15 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-544455a4b56so6552758a12.1;
        Mon, 13 Nov 2023 02:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699871173; x=1700475973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PCWL893/WA8glZkeLycvNct9u8/wkDSSjZw4ibjSloY=;
        b=XaweZldFp70Nqy0NJ0I1PhczdN6zGMUNOg+tyLKP9ilv4JDt14o9VXRJi4IkzPwJSl
         YLaIlPwJBGwDAU/B41WNjTBTGBB/3z1zmMHpZGpxKa3i1bKTUiNsdriBcSMRuHeIqQrE
         67zDmZinHlGOJfSn5w5odwBzAZ0H4wipVH4WgzKlDVmsRAXL3sp6rrcEq/wFBj0zBPkC
         DgFn21K49ze4Fmz7as8Q80/l1Mw6NhprZBoXVGE4mtBAlxKDV0px3ANAT+JLRaYCrJW7
         1/tUEsWfQ2mzuKbecZ/2Dq4DJea3zAigRV/2LoBDuXUGhPQKiH15WU+B8a4HFaV/C7tL
         WiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699871173; x=1700475973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PCWL893/WA8glZkeLycvNct9u8/wkDSSjZw4ibjSloY=;
        b=VmegFaHoHVdYaUVwvP+sWfPBP0z0v2Hfx0x7DN1NB4PZDUkR33cDbRsVYJnzL0m5TQ
         vofiMhr6eD+dDaR8eIy03MPBPDJUiMX1AQJ7m45RV0qhSEhVgAKfExuyuAbiGwRV/qml
         cpm7ksuS26Pssg17vqi5RboPwvKmATVUsRyYmtdS3AWgi2FqjQ9xDZ/RCuelThYjG3SB
         zKiIoxHp1t+urDm4dNZXXVYNBsurucwEAxnQ4TYo0yO5pRjE0EHuCbJItjkzX3mJ5P/0
         L9TZlfMKnvbaOBY9bPovj4mIgLR8tK1bQ1C2jH+dgbv2x1T3SlcbMZQhTHpulvmz+hxW
         q67Q==
X-Gm-Message-State: AOJu0YxeX1UBNOMg95Jk5iaBv0ah03x8mQoWV5p/3WJPHpsXpDGLzdhp
        E1X7p55vsILMWBx/zibWbNk=
X-Google-Smtp-Source: AGHT+IFybFEqXMAVVGpXAbHOXDBXgGb29HHmZhRdMU5+W4p9ssmnLmNuY/XS2mItgs0e3tnBKDteUQ==
X-Received: by 2002:aa7:d413:0:b0:53d:b1ca:293c with SMTP id z19-20020aa7d413000000b0053db1ca293cmr3684774edq.22.1699871173066;
        Mon, 13 Nov 2023 02:26:13 -0800 (PST)
Received: from ubuntu.. ([188.24.51.27])
        by smtp.gmail.com with ESMTPSA id r20-20020aa7cfd4000000b005435c317fedsm3464940edy.80.2023.11.13.02.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:26:12 -0800 (PST)
From:   Ana-Maria Cusco <anamaria.cuscoo@gmail.com>
To:     Ana-Maria Cusco <ana-maria.cusco@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Add ADRF5740 driver
Date:   Mon, 13 Nov 2023 12:25:33 +0200
Message-Id: <20231113102535.51074-1-anamaria.cuscoo@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

From: Ana-Maria Cusco <ana-maria.cusco@analog.com>

This patch series adds support for the ADRF5740 Attenuator within the existing 
HMC425A driver.

The ADRF5740 is a silicon, 4-bit digital attenuator with 22 dB
attenuation control range in 2 dB steps.
It offers parallel control mode through four digitally controlled inputs.

V2 -> V3:
* hmc425a.c: edit commit message to clarify the change related to default 
attenuation setting.

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

