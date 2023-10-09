Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE6B7BEF45
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 01:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378944AbjJIXlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 19:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbjJIXlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 19:41:08 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA7EA6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 16:41:02 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59e8ebc0376so76143217b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 16:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696894861; x=1697499661; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A6Z4evA91RaB6pmH2A/2rhvKNwl4+C0QTWWpQbLxwWQ=;
        b=pPS45aZWuCpT+9Vxvmefh1MC6ASGGp2VC21qWmQj9/NFN9nNymBl308rBS+uUQFQjz
         7yuC/YuBQ6zKGtKi0ShV3ZrL29M9gJqvSLT/FsFcQa9lotH0oS8io+MlGD7lNlP8Rnv5
         hZ4dMOUK6H3Sh3S5X01KeFELb5QLg/lg/8k0Z3jr5+HgeBopmsWNIKb2p3R32HdZiMpk
         5f4Jw+dvRtizWqoKybrHukV1wOWfEQq0v+N0nwPccy5CdePS8v6YDAQNv1255bk8I+L6
         +qYgCGGclp7dBTmRejrn4ZErrqvS4p+3a7/thmaBLwcWgYOBCjnlfo6tDJF5M1SISco7
         yLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696894861; x=1697499661;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A6Z4evA91RaB6pmH2A/2rhvKNwl4+C0QTWWpQbLxwWQ=;
        b=slN/Lkv65N4T+7NIfcb1tQrtXEJpf1u9c8LJ5T+T+/bplDD4rq2esve1QzzoMm98aa
         SxTE312rh+67Ms/Ldh0G0dE9XIf40DDO9sHF2VyNtdLZVNxhzYXQgtm6w9lprDNCaDBp
         U3xqujGWkKt/bI7WYJjss2RmmI0JjUkKznszv1PPHp5FOvjQ37Tt2vsKXyszG5PzpfXD
         GCTcK/h8rOYp4RrHtDvAj1kRs3pI8Ll7TWIs997Mh0xUxulhaw3DXI0tA7KtaHlBG3jg
         uO37ThXmFO8AiPPdHMfM6aToPWSQtLDfN4rM4LxlP0i5LHoc4S0DQ3APJmDY8JRATSh6
         tTWg==
X-Gm-Message-State: AOJu0Yx2fDIQufoaEt3Q7i9tmH8yQyVv/34/6QGo32/4v3IRzpz/Nx3Q
        7KHkp0sj5urJdwowZ5KMQ97e/Tlq/8r46L8LOg==
X-Google-Smtp-Source: AGHT+IGx5bzH8i9gi0scN1ZcZer1Nz83kHCbQMDLy4zOwOK19tSyG5kJ8Zj40xQk1LSh/8UqMGwUUOHA3V/a7HBHtg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:2c8c:b0:5a7:afd5:1cb1 with
 SMTP id ep12-20020a05690c2c8c00b005a7afd51cb1mr31543ywb.1.1696894861758; Mon,
 09 Oct 2023 16:41:01 -0700 (PDT)
Date:   Mon, 09 Oct 2023 23:41:01 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIyPJGUC/x2N0QqDMBAEf0XuuQdJtEj6K6UPJVnrQUnlLohF/
 HfTvs3AsLuTQQVGt24nxSomn9LEXzpK87O8wJKbU3Ch985FtqolLV/OKivUuKAy6gz9gZSKN6O FnHi4DqMfY45TSNT2FsUk2//r/jiOExbB7zl7AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696894860; l=2207;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=XvVTVgj9L3pc35eYMTZ+RVyQ6ZuyIqHrJFw3fZ6pxVo=; b=fGuGaHWljs9MXvOhbcaaNDiRGNceZqYhpBDPSUvVWleANuYMUnmCNkLdx8nZcCsE77WqOQfIg
 p/9Sahdrv55DWIKFkxJFDo8Y7ZNIJJkS44FJROIsdggDIJ5wbfN7Rmv
X-Mailer: b4 0.12.3
Message-ID: <20231009-strncpy-drivers-net-ethernet-intel-e100-c-v1-1-ca0ff96868a3@google.com>
Subject: [PATCH] e100: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

The "...-1" pattern makes it evident that netdev->name is expected to be
NUL-terminated.

Meanwhile, it seems NUL-padding is not required due to alloc_etherdev
zero-allocating the buffer.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

This is in line with other uses of strscpy on netdev->name:
$ rg "strscpy\(netdev\->name.*pci.*"

drivers/net/ethernet/intel/e1000e/netdev.c
7455:   strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
10839:  strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/ethernet/intel/e100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index d3fdc290937f..01f0f12035ca 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -2841,7 +2841,7 @@ static int e100_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->netdev_ops = &e100_netdev_ops;
 	netdev->ethtool_ops = &e100_ethtool_ops;
 	netdev->watchdog_timeo = E100_WATCHDOG_PERIOD;
-	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
+	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
 
 	nic = netdev_priv(netdev);
 	netif_napi_add_weight(netdev, &nic->napi, e100_poll, E100_NAPI_WEIGHT);

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231009-strncpy-drivers-net-ethernet-intel-e100-c-4547179d9f2c

Best regards,
--
Justin Stitt <justinstitt@google.com>

