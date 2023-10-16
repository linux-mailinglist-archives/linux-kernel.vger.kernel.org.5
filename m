Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BF37CA1C4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjJPIiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJPIiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:38:14 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4946A9B;
        Mon, 16 Oct 2023 01:38:13 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-503056c8195so5437044e87.1;
        Mon, 16 Oct 2023 01:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697445491; x=1698050291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+dDc+JFvPQYziTivdJAsBuiK7HtHQ+wh1mq0WyZIQh0=;
        b=m/NjqnuNAEzOk7KTTt7lv3a+Vx387UE20lFYr0I9gO8o4hG81L759C783dAbf6FLIC
         XbcLluNJmTR+JBci8Y1zKZ1JTwp53hXsLYSC4eBGoe1XlD4MqXaLHEjs3TtggKpxAoz1
         Wb10SB0blYs3j4xkQkdWM0RY2P8TUU8KxYVkdtkqW8nxz7ml7/+pL7bBCknSL3y/dj20
         fmUxsT2SAu3yEzX0o6i5wZTcncjejfS0dX/fR2f3Wk+a0rp/q/UfMw9se5JPjHe1nIVD
         grDkm/m0tuOIv/rQ1XBz2gzu4vDF0crLYJxGzJAqqJfdRJCt0yjJzED2bek3+ute/LU7
         jcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697445491; x=1698050291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+dDc+JFvPQYziTivdJAsBuiK7HtHQ+wh1mq0WyZIQh0=;
        b=OAyGE4uZ2MgrjRi12hY0AHYJQxn/PY9EkNZMqwb7q+KB0C7weA3NiW+qUm+F8U+fsF
         c35keFbv3hONbtHtHqHx3JDye/SgarjY8pZfeargzY8a60qV7JKRO9U+/wMJYdV2vDYc
         Kz1zTI0VKKDdI2ujmXTqh93yw/GZYqFpk+Vgs0n2BlME0/jDDFGW7VlVsz2i3i+GEgSQ
         VECwNM+1FQ6bvZ5rH85h08tE+YLT35yO6KmrMLa1yNozuV/xHcF8EPfiJXDI2CM7Ku3V
         6SFfPLCSpuKwhQ2IAUzpZF0MvzElu0u9k0EpM4nMaMxK+BQZ9CaCKocrkXSaETgATGLU
         kuwA==
X-Gm-Message-State: AOJu0YxTusldAKy1tzkzvtHSZxzsGux5B8+Zhee8Z0jQ8e8ORFTmTBoF
        vXRrmD4FdATl2b2823oS66MgpKQnV9XN3A==
X-Google-Smtp-Source: AGHT+IH8A30u+xx+03D3mNWaz5CAvR1/9OE5fZD6rbVHKLpFi1d3QjcYt1lrivMwUC8J80K7/4ilhQ==
X-Received: by 2002:a05:6512:1307:b0:500:7f71:e46b with SMTP id x7-20020a056512130700b005007f71e46bmr29896857lfu.1.1697445491007;
        Mon, 16 Oct 2023 01:38:11 -0700 (PDT)
Received: from fedora.. (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id p20-20020a05600c469400b004067e905f44sm6633554wmo.9.2023.10.16.01.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 01:38:10 -0700 (PDT)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     leonard.anderweit@gmail.com,
        Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] hwmon: (aquacomputer_d5next) Add support for Aquacomputer High Flow USB and MPS Flow
Date:   Mon, 16 Oct 2023 10:35:56 +0200
Message-ID: <20231016083559.139341-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the Aquacomputer High Flow USB and MPS Flow
flow sensor devices, which communicate through a proprietary USB protocol.

Patch 1 resolves the case when devices that communicate through the legacy
way (such as these) don't contain a reading for a sensor, in which case
-ENODATA is now returned.

Patch 2 adds support for the devices and implements reading their
temperature and flow sensors.

Aleksa Savic (2):
  hwmon: (aquacomputer_d5next) Check if temp sensors of legacy devices
    are connected
  hwmon: (aquacomputer_d5next) Add support for Aquacomputer High Flow
    USB and MPS Flow

 Documentation/hwmon/aquacomputer_d5next.rst |  7 ++
 drivers/hwmon/aquacomputer_d5next.c         | 72 +++++++++++++++++++--
 2 files changed, 74 insertions(+), 5 deletions(-)

-- 
2.41.0

