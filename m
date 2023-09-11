Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4F679B1D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357926AbjIKWG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242523AbjIKPp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:45:59 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311AD121
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:45:54 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-401d6f6b2e0so35852945e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1694447152; x=1695051952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YQpv/geSYQKf7XeeyrDQqaFj1lXBOylufuiB6Ca2YJ8=;
        b=1zT67G5jGbkr1B7nOvrVP/0TfuRBa1KxYwnINbWHmxhSbPHl/6n2kK1XYzg6mx0pt6
         Try+yscJfy5Xv51VrK3FhA+zB5ClBXtL49MuYcN7x5PG/fokV8y8oIHMtQwEEqdhTHqg
         oNmDv851NccBQFwaHXHZ8nGt3qf3K8aB4nkgWU5sV6hNeOAjyjcLuGcBfMEjDZ+13x3R
         Yo3Ol+TzyPLUOzO9SGjGXB1a8v0RX2N7oQ/TqrWMLk5qiWmx81Fq7sie2YYmtT3Yo06w
         NVc8n/B9+zMTKhkKy7nULE+KKfDzDgIZ+Njj1A9gmmemnLVUUSs39IF4UMiZsfbjJ4Yv
         yrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694447152; x=1695051952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQpv/geSYQKf7XeeyrDQqaFj1lXBOylufuiB6Ca2YJ8=;
        b=m+bqBac2swswqIQNGFSswtOY7XwfzmZ4P6hT2GTnsz12cBAd3EECcsp6uaaPKytflN
         9icdGmiwKcoCn4EP+nv6Qgwo5YlY2W//4s6cGGv+XCvzwdiea0knQkyheS2+AKyDxG9f
         fppQL5pakIyspC6j6NpLEgw3KQ2dogzY8i8WU/Pgeb5A1NWwlT/LL6CCGh6zQTpDw7B/
         SFsH/CtSZGipopmOViquwxam3pX710xenmnhoslpq/lcUX+ddJC5+TB8gHrhwih5FJnm
         4hsaACKZyMCqvp1/kfwCuP5yfnF5YPxH1G2ivxmBXQodiZkZ07vlf+caPsI089KNbuDe
         atOw==
X-Gm-Message-State: AOJu0Yya3krPsC6jpRm3CdT2iv44LRSNoPSOBNRX98ILGFGG1f/Ve0pL
        fhxyTL73Q/esx0ZqBTU2s5r9Ig==
X-Google-Smtp-Source: AGHT+IGhd6VN30qru22xohgORcKjQlbzDL2sOujgcrLX5rl/SyWB1cmbpOW7R7S5HN8frK635LwDEw==
X-Received: by 2002:a5d:6585:0:b0:314:3369:df57 with SMTP id q5-20020a5d6585000000b003143369df57mr8967091wru.5.1694447152305;
        Mon, 11 Sep 2023 08:45:52 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:55be:8f7e:5f59:7ed1])
        by smtp.googlemail.com with ESMTPSA id q12-20020a05600c040c00b003fe539b83f2sm13616255wmb.42.2023.09.11.08.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:45:51 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 0/5] arm64: dts: meson: u200 audio clean up
Date:   Mon, 11 Sep 2023 17:45:36 +0200
Message-Id: <20230911154541.471484-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes the recently merged audio support for u200 and adds the
missing onboard audio devices

Jerome Brunet (5):
  arm64: dts: meson: u200: fix spdif output pin
  arm64: dts: meson: u200: add missing audio clock controller
  arm64: dts: meson: u200: add spdifout b routes
  arm64: dts: meson: u200: use TDM C for HDMI
  arm64: dts: meson: u200: add onboard devices

 .../boot/dts/amlogic/meson-g12a-u200.dts      | 237 +++++++++++++++++-
 1 file changed, 226 insertions(+), 11 deletions(-)

-- 
2.40.1

