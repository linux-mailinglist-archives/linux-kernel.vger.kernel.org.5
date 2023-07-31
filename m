Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1187769420
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjGaLDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjGaLDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:03:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210B711B;
        Mon, 31 Jul 2023 04:03:03 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe3c7f16bbso494188e87.0;
        Mon, 31 Jul 2023 04:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690801381; x=1691406181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n83TuKNtAFb4aHweh9x4amkqhUIBkeAPvKSvQukr0II=;
        b=VhKLvpLPA5Zm/laVXQYsAT2V/s1BvK0P63FQcvyabqU8qIVvb4BxJ/Be+ekTsa216S
         P/kc3Li6gESqr88cwaEUOv/RfauYZ+Zd7stFQYsk0Uvv/8IcQE5PYM6woEnmynHlP9/x
         M8IobLcsNE3rhRVlSbLo5ETKJefrPatR1z9GgZMKHLrNj42gzW/q2ErkafFsLwbmYDkw
         A0n//i2hEBSoOqceBqgAHmqvO19I47AybccBWOj3mKo7HXkn3eIre/2S+NAWTKzebjmo
         qRGgrHPjv8xhb0kIjqW9RxdbAvIK0Zk0HW4RTBmMVHBL21ujuUpNvwUuGxzMBE6h+NYP
         kXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690801381; x=1691406181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n83TuKNtAFb4aHweh9x4amkqhUIBkeAPvKSvQukr0II=;
        b=coeqb6KnJBFByVfQxRd6nDCiKnAK/P8YEA90axKXZgrB3K9Xz/oCKKYlUdLNKBr0dr
         pDvMPppho6bkrPjGmHHspXBQo8VwriEKweY6e92qtzqlHufJ+IQz3BZc0+gerECjcYR6
         4dFTjtgjhyIk+/zYRuGpNVBKfZy8/illNhroDFBM9nHz8+iANtUSdthjPNdk5wXb0JI3
         78f2MnK6L75qZsqKU6FoMsnRQ97aLtnnCxKW+paXdTscGURhsxgiyRLegAH9yvJcJBjj
         13X+QsRgQpFr7lQBnuobpfVIEFnTZ/DPNSPXWvMmq0XRWArhNPDQ8toawxmNcA9MwUQV
         RTmQ==
X-Gm-Message-State: ABy/qLYt2lHRIVRiIfjDk9+Ps1A9pU7oDKMJP2MVb8oDH18IfLkPxOgq
        xVIJVcb7S46ZCsDSL54Vf7g=
X-Google-Smtp-Source: APBJJlEbxEAKXUayKCuAJsDfWgXRuTJubylT872rt3beMbpU/qcyUHt+etqHbu/iyb6MUQkX058PqQ==
X-Received: by 2002:a05:651c:120a:b0:2b7:33b9:8809 with SMTP id i10-20020a05651c120a00b002b733b98809mr6243104lja.16.1690801381028;
        Mon, 31 Jul 2023 04:03:01 -0700 (PDT)
Received: from xeon.. ([188.163.112.48])
        by smtp.gmail.com with ESMTPSA id p2-20020a2e8042000000b002b9bf5b071bsm74607ljg.20.2023.07.31.04.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 04:03:00 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Samu Onkalo <samu.p.onkalo@nokia.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Update APDS990x ALS to support device trees
Date:   Mon, 31 Jul 2023 14:02:37 +0300
Message-Id: <20230731110239.107086-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is the successor of a wider patch called
'Update APDS990x ALS to support IIO'. I have decided to divide it into
two separate patches to ease review and submitting. All suggestions
from the previous patchset were applied.

This part is dedicated to including device tree support into APDS990x.
APDS990x is a combined ambient light and proximity sensor. ALS and
proximity functionality are highly connected. From mandatory properties
required by device (apart of compatible and address on i2c line) are
two supplies, interrupt, pdrive (LED drive current) and ppcount (the
number of IR calibration pulses).

These patches are oriented ONLY on bringing support of device tree into
driver, pdrive and ppcount are mandatory and datasheet nor driver does
not provide any reference values.

Namings and compatible properties derive from the original driver name.

Svyatoslav Ryhel (2):
  dt-bindings: iio: light: add apds990x binding
  misc: adps990x: convert to OF

 .../bindings/iio/light/avago,apds990x.yaml    | 87 +++++++++++++++++++
 drivers/misc/apds990x.c                       | 55 ++++++++++--
 2 files changed, 135 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds990x.yaml

-- 
2.39.2

