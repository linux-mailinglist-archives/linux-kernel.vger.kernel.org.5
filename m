Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C027710FF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjHERmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjHERmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:42:05 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60252106
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 10:42:04 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686b643df5dso2171207b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 10:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691257324; x=1691862124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2LjEphxbAcNmk9OuIlZ94EZVoNAFsXVDLzgtQBZgFFQ=;
        b=iM/QsUsabggE7YohYddy8BZqv8PLiVjz/B2omd5Oi/syBuKENzIZccFSX8Mjnidn70
         1enPhOhCh/CojRhMib5LOMGvwq5NLU/p9hDixVbtNizzVTt2Of69z9JMzgw/f2mXbHzA
         nE5m8eCYtYMvNvoBzjaNapuAXqRl47upLJuLpJR5g/Yfro+yoYd54xnitlMMyLuyY2ww
         0gDGKgkBck2LwllXc4rdBCsp8i7uEpHKTVIu557vPIWnnBCS/bH5HL0HsnkeFpiT/R+L
         sel1yLhqlX53djhwSIoLADLg7HQbRjYN9kjq8wNgY1Z6nfwv8KWklyuhECC/x049WJuO
         jo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691257324; x=1691862124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2LjEphxbAcNmk9OuIlZ94EZVoNAFsXVDLzgtQBZgFFQ=;
        b=F5saVOOP3L6Ev/9B/+L+suLrkbV+kgvjE9gAu/9/hLYwI4One1ObtC3eIj9iRYgN2P
         cLdnZPsRNZqtXiwLjqq6S6lFC+T2g9Wi2Tpd1k9hkt75mgMiKpDAmYSjGDk3KKIh7TQj
         buxXHbs9CmaXAT4Q6j6v1y/Ug2+xV60a/KynP95KfoE3JqltBCDGUAky42fSYuixW4zX
         BVZVzYxLZ+Uok/giasSIhSAyQe+tifdaiGoUsOtr9MJoJ78P/tYj6ERxk1qb1pXeByvW
         9S6XkITcUqTcHtaKbQATUnhg+bzZJKNqUPNm5XVxuIoFpstaUz/5hbfgt3HgQ7GYroEb
         IUMA==
X-Gm-Message-State: AOJu0Yy++SUm0oQpJAKOcDi3t3UiygRd4qQ+dei4OnduLfanIbCkdc8e
        FKydebYaZ94vzWLOC1VWGGFS
X-Google-Smtp-Source: AGHT+IFJfhm/Y/G4uZNTHP5zy/WL24vliQ/xJ5ECsmWh2A3VOvzdhfvM/1qcfzd0Ndh8NGCNvJHvAw==
X-Received: by 2002:a05:6a00:1743:b0:66a:365c:a0e6 with SMTP id j3-20020a056a00174300b0066a365ca0e6mr4617174pfc.13.1691257323649;
        Sat, 05 Aug 2023 10:42:03 -0700 (PDT)
Received: from localhost.localdomain ([103.28.246.21])
        by smtp.gmail.com with ESMTPSA id i14-20020aa78b4e000000b006874a6850e9sm3363160pfd.215.2023.08.05.10.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 10:42:03 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_mdalam@quicinc.com, quic_srichara@quicinc.com,
        dan.carpenter@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 00/10] mtd: rawnand: qcom: Bunch of fixes and cleanups
Date:   Sat,  5 Aug 2023 23:11:36 +0530
Message-Id: <20230805174146.57006-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

This series has fixes for the smatch warnings reported by Kbuild bot [1]
and also several cleanup patches based on my code observation.

I've only compile tested this series. So let's wait for Sadre/Sricharan to
give a tested-by tag to make sure I didn't mess up anything.

- Mani

[1] https://lore.kernel.org/all/202308040141.gUjtZ32J-lkp@intel.com/

Manivannan Sadhasivam (10):
  mtd: rawnand: qcom: Remove superfluous initialization of "ret"
  mtd: rawnand: qcom: Rename variables in qcom_op_cmd_mapping()
  mtd: rawnand: qcom: Handle unsupported opcode in qcom_op_cmd_mapping()
  mtd: rawnand: qcom: Fix the opcode check in qcom_check_op()
  mtd: rawnand: qcom: Use EOPNOTSUPP instead of ENOTSUPP
  mtd: rawnand: qcom: Wrap qcom_nand_exec_op() to 80 columns
  mtd: rawnand: qcom: Unmap sg_list and free desc within submic_descs()
  mtd: rawnand: qcom: Simplify the call to nand_prog_page_end_op()
  mtd: rawnand: qcom: Do not override the error no of submit_descs()
  mtd: rawnand: qcom: Sort includes alphabetically

 drivers/mtd/nand/raw/qcom_nandc.c | 192 ++++++++++++++----------------
 1 file changed, 91 insertions(+), 101 deletions(-)

-- 
2.25.1

