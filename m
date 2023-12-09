Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1ECF80B394
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 11:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjLIKQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 05:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLIKQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 05:16:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F6C12E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 02:16:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B24C433C7;
        Sat,  9 Dec 2023 10:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702116986;
        bh=6lAtUj0w6cfsqWJL+DsezEwY42RXIvFrsgiRpaPq1Po=;
        h=From:To:Cc:Subject:Date:From;
        b=LuBC5uFECTdiFavsl4AnVB/3EkhvXih8ZKxdb2Qc2oDic8U4tbikFjcrx9fyc4ZHo
         mcvXY0jCAVx3xjSc5vQASmX2DmASAPZQ35PUr41/BOfRh8NWEar+zDcbZm7zi8F2sP
         dBLpAQ91tOzMMlL9W/4f2kyMeE3sny2L9Nox/1G8dH9toX26L+QjqY2pV2UcuAlYhh
         DRlsIvJ/YfbhiRTs3XJI0LWQIYYL1lR9mCWyrTX2ixBDUgyH02hyxXVAl9ZGqw1L3K
         1HjM23bpoS4+HWjcywKFmPs2fgk/JJFap3sMTnvqHiAdB7cDS33t24xyFLpjDz6QN/
         y4cn8iaOPd3AA==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [GIT PULL] interconnect fixes for 6.7-rc
Date:   Sat,  9 Dec 2023 12:15:48 +0200
Message-Id: <20231209101548.1240700-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This pull request contains a few tiny fixes for the current cycle. The
details are in the signed tag. All patches have been in linux-next
during the last few days. Please pull into char-misc-linus when possible.

Thanks,
Georgi


The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.7-rc5

for you to fetch changes up to 9085b23b668ad5aca62df4f071b306a47152e6b3:

  interconnect: qcom: icc-rpm: Fix peak rate calculation (2023-12-06 17:00:42 +0200)

----------------------------------------------------------------
interconnect fixes for v6.7-rc

This contains fixes for reported issues. One fix is in framework code to
explicitly treat returned NULL nodes as error when the device-tree data
is translated into endpoint nodes.
The other two fixes are in driver code. One is expected to improve the
power consumption on the sm8250 platforms and the other one is fixing a
bandwidth calculation formula that was introduced during this cycle.

- interconnect: Treat xlate() returning NULL node as an error
- interconnect: qcom: sm8250: Enable sync_state
- interconnect: qcom: icc-rpm: Fix peak rate calculation

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Bjorn Andersson (1):
      interconnect: qcom: icc-rpm: Fix peak rate calculation

Konrad Dybcio (1):
      interconnect: qcom: sm8250: Enable sync_state

Mike Tipton (1):
      interconnect: Treat xlate() returning NULL node as an error

 drivers/interconnect/core.c         | 3 +++
 drivers/interconnect/qcom/icc-rpm.c | 2 +-
 drivers/interconnect/qcom/sm8250.c  | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)
