Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19507C4401
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbjJJW1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbjJJW1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:27:11 -0400
Received: from mail-oa1-x4a.google.com (mail-oa1-x4a.google.com [IPv6:2001:4860:4864:20::4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14DB109
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:27:08 -0700 (PDT)
Received: by mail-oa1-x4a.google.com with SMTP id 586e51a60fabf-1dd51b98342so9239359fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696976828; x=1697581628; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pa7deZDH3/y1FuC+NXYPP7L7Yz4eW2ecVvy54MDyytM=;
        b=dNtSoZG14IAbsxG+bS1SasW0twm/JezTe1SxCulaRIoCL7PfsbgwPfV1ZcT+Uwc5gB
         fZ9DJf0tnuni4fFF1TI+EOZcopc9nBjpGpwdEFb4rZ/n9UkL9qjp0sl+dRA3haXjuUZ5
         +w8EOorgTHr0Gzyojdkrf1JbRHoWKtt0sQ58YPliIHwzZIhGecNutR6SF+NgbjPhqCkq
         qNAoDCCQtpVVRXx3nGnAJEffH7f6xf0aYbTyotbXE3m8jfeWWYWLUf8y8d0Kga60gTnO
         tPWK68jU23eRmgsavQ9SKSpTMslsMCN+37MQrefGA4QDRM9oX026F3eDwjXeoSvYzrHb
         SfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696976828; x=1697581628;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pa7deZDH3/y1FuC+NXYPP7L7Yz4eW2ecVvy54MDyytM=;
        b=Zx/FtSaAEmuqp0uU/ml1Qjh5vW71xut/YN5cOn6EqwRqSm2nZJTgxUG7AIrBHhV2tX
         KGXrO/YZ65dhtt/oaoKj3nLx2dKqz6uOqsUKR56g23NGN5Wq3qxcBZ2LQb2d/5P4hw81
         R9DlP89nzguD1DAWHKTy3Z3lqLzrhpc8e6Cy/6LqaBiKgYdRd7ibRlkpppan8u21TjeS
         C1iDiB7ciFYORL6uAyrl1HrNHowFgBjn8xYqJAxgPuSFDm0GfPfwBPRKY7ovUHWYbfdF
         2q/NHbG1tlMVIYVD0YSHTs4yZQ6fTbjVQ/bTmWKCzcCRbByzmn2lZLxZ/qiI+GkJUCqn
         Kmpg==
X-Gm-Message-State: AOJu0YxIzKKLiE0TaAec1IZ1PeT7q1fly/uHS0g7EXqHpy5cXCNHCgm0
        y5ZTZAmnvThkshGxnBhvNEC91OiPp2BdaNLLWQ==
X-Google-Smtp-Source: AGHT+IEadZBbjvmTPKL6ZoF9E9/8NzOm+22mrGAZMVtdJWKWPzsgKk+C0ltQCmzXV0c0zTmFQFZqIhheM6Siw0DEMQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6870:b7b5:b0:1dd:7381:e05 with
 SMTP id ed53-20020a056870b7b500b001dd73810e05mr8328180oab.3.1696976828369;
 Tue, 10 Oct 2023 15:27:08 -0700 (PDT)
Date:   Tue, 10 Oct 2023 22:26:55 +0000
In-Reply-To: <20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com>
Mime-Version: 1.0
References: <20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696976824; l=1965;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=rxi6aLNd8v6Nf40hnmQomEOrEb/86fYL7CHbZkLYeOc=; b=j6JQnwbowPf3dzuBaUDjGqeCKA2qyFTP3KIo3eNBNMZczwWVdcd3sWaiujAjoY1XHmfpZr4MB
 wYA0z04z+jOBph3+HO6oqCmF+03nCsxlBi/fNo6z+SwJCX6k5QcwpK9
X-Mailer: b4 0.12.3
Message-ID: <20231010-netdev-replace-strncpy-resend-as-series-v1-2-caf9f0f2f021@google.com>
Subject: [PATCH v1 net-next 2/7] e1000: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-hardening@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We can see that netdev->name is expected to be NUL-terminated based on
it's usage with format strings:
|       pr_info("%s NIC Link is Down\n",
|               netdev->name);

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

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
 drivers/net/ethernet/intel/e1000/e1000_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index da6e303ad99b..1d1e93686af2 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1014,7 +1014,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->watchdog_timeo = 5 * HZ;
 	netif_napi_add(netdev, &adapter->napi, e1000_clean);
 
-	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
+	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
 
 	adapter->bd_number = cards_found;
 

-- 
2.42.0.609.gbb76f46606-goog

