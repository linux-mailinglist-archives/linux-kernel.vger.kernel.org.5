Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78F175647D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjGQNWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjGQNVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:21:46 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7831C1728
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:21:36 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fc02a92dcfso41089375e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689600095; x=1692192095;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kZ9t5dj6g2mn/10ISraEtvtL1bOiFOBSVrIZ4houIx0=;
        b=fAh55B3H+QlRLeSufxO4qMrv9sAkGm5AziEPE9FHMmBjucGJmcJHxIp09l6OmIVrre
         Sg13g3ToocKyg3AIUJ9IZyDoQAsL4MNA64PtSXqPQu6Aw+OJ2IvUcZd4+VWnkZBq7Vgc
         tIXGwIKGs4uHMlwcLtNKdTTFi9nQ5FQ9kXyykZ/aRLa/BCmwnL/4y1z/xDYEuFTmZs4V
         k2omQVSiOwWhrwGEoYvQIloesymgHi9krkz6zlRD0CpDoggURE+d1Fg4depIh33L9d6+
         Abe9vVC2xUux2L8+yW0jsfP6YCI73AMl+0aCztV8jLyyGiFPAKO281MgIwfdc16SEQ7p
         SKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689600095; x=1692192095;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZ9t5dj6g2mn/10ISraEtvtL1bOiFOBSVrIZ4houIx0=;
        b=jhFQE4V0I0TG2KUUm1rZhQLznK/KCCWuw4tysXZxJ1/J+EW3inqfBeO+X6bZAUbHoJ
         etzHOMCmrySjhNesQOmqWdsJ6cqbVejS2TCzTJfuq46qOHN3pr5q7rlzxYrP9nxeAu8A
         XNgl3sLB13CM+A1CoNHWGcOKSNxwtp+6bNrut7WBS+L2MBducZiv9e/5H/oQjxRvCsm2
         gTtuowxnhvf2PUCxXIAC6dG/r+sdVkslnIfj/REZSMUQkmcWqPsIkuiJ19HUQ7psEH7K
         OLJr1yfPFpuzaBKbYfbQXkEc7Uyyw7qMrfbNG56x6Hw5NTEoIq2zWoN7MujsBY4su2h4
         DUzw==
X-Gm-Message-State: ABy/qLZwsW/h9UI+BccIpTVaQ/soQE69pvmifmqVR9uGivgaFa7DvZjD
        BA1vjsZKm4ninLM+B5puPU2NyA==
X-Google-Smtp-Source: APBJJlF1llxOyD+510ui5rEJu6KdcyF3JC253dsvNJLLHen8XU94+OzQva+9xR4jdmqSEFYSNQvqRQ==
X-Received: by 2002:a05:6000:1112:b0:314:2735:dc13 with SMTP id z18-20020a056000111200b003142735dc13mr9691654wrw.47.1689600094897;
        Mon, 17 Jul 2023 06:21:34 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b0030fa3567541sm19249836wrx.48.2023.07.17.06.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 06:21:34 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH net-next 00/13] selftests: mptcp: format subtests results
 in TAP
Date:   Mon, 17 Jul 2023 15:21:20 +0200
Message-Id: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-0-695127e0ad83@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFBAtWQC/z2NQQqDQAxFryJZNzBG7EivUrpQJ7aBOh0mUQTx7
 h1a2sVfPD68t4NyFla4VDtkXkXlFQvUpwrGRx/vjBIKAzlqnK8Jl6SWuZ8xspVthv9L+TkZqyn
 OycaEugxfpDZQ64L3XXeGYk6ZJ9k+1Sv8PHA7jjccbTZ9jwAAAA==
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3252;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=YEIkMWY8UBsDvJPwG2p8rvciIBMppk1AeFtr41cYIqI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBktUBcoNfPcTm9PUpx/4zV3hhZzoLL3BV7EdlfH
 I7ffws/zWGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZLVAXAAKCRD2t4JPQmmg
 c5eEEAC9Chq9qFAhmcN2pfs9lPVHogOnDHKz2CaQx7mIteDWk+pnHx3/1GYIFrj3YLMNg1VYKxD
 SC5IpKMEBBYBAr2M+dJqh5tE3Uty1Oh4xYThAreGuFU2qOHoByLTnU+kJnJ9vHYUjvZ5Jp12V5R
 /vFO6eL6VKz4YAkGfIyzFg9ylq8403PIXh404uqolUYlDONLwaIsugwWlkgqjzab3XAHqzAmUPU
 ZBuWKAnAL3DPlra2LjzRI6ebBAbvUQ9lhZbA6u3aDi5ZGVDvFRbm+bGm0O5CFj7C4TXTIFO4W87
 mp0bikLveP2wFvredGREm+t3nqFlBYdtCMOcMaW+axs7wBURn0WxKh6A0W1d/DUPP0hvXhfM1JL
 DVMRkOtE4/h4mPdj3P0iEJ/ge/K4XVKo1A3k5vpSydlfT/8Wj1p0bXAsI5gCVER5tg2UqaJvX3b
 W+0j+DSCAitMpKygMUM9gpcOvUI8BirTzaYy1WjXRLWdDQ1umBMNEL1Wp9EZJMS6s0kbz1zc0Ir
 dl1mvSiKBiOiXZXu+dyPIxHmXxwWPCGzXSikRMbCrJKyHEUPtdgzZsIKSzkpU8v3eoP/3lIEvoz
 0UWUYhoqemgQmSGGGEAgln70W+UvomCpW5P35IzAxkN+JcySIeB1hvpygxKXko6WXxrPvNOHsyh
 tJsbKhZT3kNM3mg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current selftests infrastructure formats the results in TAP 13. This
version doesn't support subtests and only the end result of each
selftest is taken into account. It means that a single issue in a
subtest of a selftest containing multiple subtests forces the whole
selftest to be marked as failed. It also means that subtests results are
not tracked by CI executing selftests.

MPTCP selftests run hundreds of various subtests. It is then important
to track each of them and not one result per selftest.

It is particularly interesting to do that when validating stable kernels
with the last version of the test suite: tests might fail because a
feature is not supported but the test didn't skip that part. In this
case, if subtests are not tracked, the whole selftest will be marked as
failed making the other subtests useless because their results are
ignored.

Regarding this patch set:

 - The two first patches modify connect and userspace_pm selftests to
   continue executing other tests if there is an error before the end.
   This is what is done in the other MPTCP selftests.

 - Patches 3-5 are refactoring the code in userspace_pm selftest to
   reduce duplicated code, suppress some shellcheck warnings and prepare
   subtests' support by using new helpers.

 - Patch 6 adds new helpers in mptcp_lib.sh to easily support printing
   the subtests results in the different MPTCP selftests.

 - Patch 7-13 format subtests results in TAP 13 in the different MPTCP
   selftests.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Matthieu Baerts (13):
      selftests: mptcp: connect: don't stop if error
      selftests: mptcp: userspace pm: don't stop if error
      selftests: mptcp: userspace_pm: fix shellcheck warnings
      selftests: mptcp: userspace_pm: uniform results printing
      selftests: mptcp: userspace_pm: reduce dup code around printf
      selftests: mptcp: lib: format subtests results in TAP
      selftests: mptcp: connect: format subtests results in TAP
      selftests: mptcp: pm_netlink: format subtests results in TAP
      selftests: mptcp: join: format subtests results in TAP
      selftests: mptcp: diag: format subtests results in TAP
      selftests: mptcp: simult flows: format subtests results in TAP
      selftests: mptcp: sockopt: format subtests results in TAP
      selftests: mptcp: userspace_pm: format subtests results in TAP

 tools/testing/selftests/net/mptcp/diag.sh          |   7 +
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  66 ++++++--
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  37 ++++-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  66 ++++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  20 ++-
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |   6 +-
 tools/testing/selftests/net/mptcp/simult_flows.sh  |   4 +
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 181 +++++++++++++--------
 8 files changed, 298 insertions(+), 89 deletions(-)
---
base-commit: 60cc1f7d0605598b47ee3c0c2b4b6fbd4da50a06
change-id: 20230712-upstream-net-next-20230712-selftests-mptcp-subtests-25d250d77886

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

