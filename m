Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0F57D08AD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 08:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346919AbjJTGn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 02:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376356AbjJTGns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 02:43:48 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE84D1703
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 23:43:40 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b5af4662b7so455867b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 23:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697784218; x=1698389018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pEwVus5XvQXwUGCOydC4RAlcfZ2CojyENWsg8dWDU3s=;
        b=F5uTJgTsFd5Acm5svVRhh9mj9M5tTCgpja2N9TmumMjRHIqTrc+52J6gyhYwp5ZotQ
         D5r/Jwwy1krSbI62l9nxPMGNs8VmisJAtOJ2UVKdXrgAd/nWsXMoXrdcUBhHJvaZqSre
         EDiZV4fVbSuAAS09QsJtnT8GfyQaNeUCS6+y3O5yoTrxWr13neZg1VcPZb/IFuI4Athe
         6mYYj2dz/pMpz11dM2SpSXJ4yOJmQqmL4Eb0FVMC90lSCBJZwZXu76gdl/aPi7o3CcWV
         jUyI54RwTK/6T03wuziXpaw4yQMI2Ov6Z2Mj1qaZ4Wa8gjz7O1VJM6xQpHCj7PJOFxvY
         LW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697784218; x=1698389018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pEwVus5XvQXwUGCOydC4RAlcfZ2CojyENWsg8dWDU3s=;
        b=XqjfvGgUtrnoOhDG76jsOPsQ3TMYgnS9BdEFjGLmCfaNhk/gTlduw35qHwLWVWn1vQ
         IpOGOahxGzf9IpuSzaa7uxfiJ7VUQJHAQBXopTeCXRDvbaBXvuObaNy7p8PthVpftd3v
         l075i7y6v63PmoO/wzVNg4U3y4ffsuDu1EpNw4mnvCOe91zM+QMmLIfYa8yl2QXTPcRA
         f627WXNVSM+CL9NEXVbaSX0iRJ8pmifIliZAMXaJ3nm27j2h7Lx/iH8d/uMjAV6smt5Y
         jCCKDykX5RN8CO+pr71+OzAby4OPaV+DRt/k/o/zoabGLQ/J9QLlWy8GKeL5sVzlCJXG
         kyqw==
X-Gm-Message-State: AOJu0YyYfhR7Lr1IZ+JOZql1wu7ca3I5OHBOnSMi/Vbey5osrfla2exF
        ZstsvVjQz5EnUh/2lhCSiuft
X-Google-Smtp-Source: AGHT+IFeo3A6P9pO1D1HESH/wOEvj79dotcoIf0X4u1+13wKZ/c92Vv0AIBsdq41wuFk9DlchgeWFw==
X-Received: by 2002:a05:6a20:258b:b0:15e:bb88:b771 with SMTP id k11-20020a056a20258b00b0015ebb88b771mr777794pzd.37.1697784218229;
        Thu, 19 Oct 2023 23:43:38 -0700 (PDT)
Received: from localhost.localdomain ([117.202.186.40])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902bc4300b001c60ba709b7sm760951plz.125.2023.10.19.23.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 23:43:37 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vidyas@nvidia.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 0/3] PCI: designware-ep: Fix DBI access before core init
Date:   Fri, 20 Oct 2023 12:13:17 +0530
Message-Id: <20231020064320.5302-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series is the continuation of previous work by Vidya Sagar [1] to fix the
issues related to accessing DBI register space before completing the core
initialization in some EP platforms like Tegra194/234 and Qcom SM8450.

Since Vidya is busy with other work and didn't respond to my queries [2], I took
the previous series, rebased it on top of pci/next (6e2fca71e187), removed
ep_init_late() callback as it is no longer necessary and posted v6.

I've also kept the Ack given by Jingoo Han for patch 1/3 as there is no drastic
change.

Testing
=======

I've tested the series on Qcom SM8450 based dev board. I also expect it to work
on Tegra platforms as well but it'd be good if Vidya or someone could test it.

- Mani

[1] https://lore.kernel.org/linux-pci/20221013175712.7539-1-vidyas@nvidia.com/
[2] https://lore.kernel.org/linux-pci/20230825123843.GD6005@thinkpad/

Changes in v6:

- Rebased on top of pci/next (6e2fca71e187)
- removed ep_init_late() callback as it is no longer necessary

For previous changelog, please refer [1].

Vidya Sagar (3):
  PCI: designware-ep: Fix DBI access before core init
  PCI: qcom-ep: Refactor EP initialization completion
  PCI: tegra194: Refactor EP initialization completion

 .../pci/controller/dwc/pcie-designware-ep.c   | 142 +++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.h  |   9 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |   4 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |   4 +-
 4 files changed, 89 insertions(+), 70 deletions(-)


base-commit: 6e2fca71e187932281c7bf4faed1b40e6d9627d6
-- 
2.25.1

