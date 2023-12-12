Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45B080F4A6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjLLRdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjLLRde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:33:34 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BE78E;
        Tue, 12 Dec 2023 09:33:40 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d076ebf79cso34752855ad.1;
        Tue, 12 Dec 2023 09:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702402420; x=1703007220; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMS4HUj98gmEXET3bMrTA2D/KN0j+hyjWzbKO4NEc+g=;
        b=OXhjn/OCRINmjh0IOBAGAXSCqZAvYql7y0+BTWJhb6OuwaL2Pe3b3jgrKzLcYAoFd9
         p6VA0vnzAryR5rWDAYi/tDR+5hGrV0RvaDBvXJKa+krNYurPXkQszAojE+cmpmP4tDMI
         6NLeFy3tnnfsFNG7Mf/NzeH842uIKKFWZyBQFTvrq0Q80uJuPw9cFC6YnX4rnMldZwiD
         hjwYMnbycpUpYkUlPogXpq1vw508I3whLx4wH4ZtJfeIcx6T2NLrd6L5dg8KR7XQbQeX
         E2nIPYvWR7BaIzDUh1I4EIefZpxNuCVGq/Z68v5VRTKrVbvRclomlaut0QOutfVW92EN
         wYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702402420; x=1703007220;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMS4HUj98gmEXET3bMrTA2D/KN0j+hyjWzbKO4NEc+g=;
        b=EE0fkUAyrpNHiXA6PmtvN1SqGerJ1ypmrk773u914sisTW+osRItUcbOsCB07abQuX
         u+qzHsJDSg8a5GKFkIJaEihf5IftC04JFuoJW2YCaYf5b3i+1mDnyqhfRDG1rqV8SdHM
         CsIgn7dzjdGA1HKejXfqXFXgAaq3ePJpbwnSGmR35NBbN1VwJDOFtYCsLAtzOIRz2ugt
         drk1yA0GtpjLxoQoZTJu6wdh0KU4m2I6LBLfciRVbZIcMt0iitsuUenbpx06aU3wTc3V
         qPaxB6Jkmj2GBpqxNzlOSUunTtTs+Lrp+H62WDDYPrTCU2y8Qvxf1/7f0k/SUit5+19r
         cKZA==
X-Gm-Message-State: AOJu0YzgCHc/WZSvr6KukZ5jk6UD5sJbpqw6Eb6PW0QyRJJnl5kEolih
        wbUKXneMagLLhPqpg/IBkh3qxVPYRiZqJzE7
X-Google-Smtp-Source: AGHT+IENYkXloNENM1w7WWp7L32HPjiYDdSSIM4TXmvnOl6GfxrK8YnfM/7vdEV35ASrUrl7czkx/w==
X-Received: by 2002:a17:902:db12:b0:1d3:45b7:bc25 with SMTP id m18-20020a170902db1200b001d345b7bc25mr667555plx.47.1702402419556;
        Tue, 12 Dec 2023 09:33:39 -0800 (PST)
Received: from neeraj.linux ([101.0.63.152])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f54400b001cc20dd8825sm8894548plf.213.2023.12.12.09.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:33:39 -0800 (PST)
Date:   Tue, 12 Dec 2023 23:03:34 +0530
From:   "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, paulmck@kernel.org, Neeraj.Upadhyay@amd.com
Subject: [PATCH rcu 0/4] RCU/lock torture updates for v6.8
Message-ID: <20231212173334.GA11572@neeraj.linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series contains torture-test updates:

1.      Increase Hamming distance between call_rcu_chain and
        rcu_call_chains.

2.      add nolibc init support for mips, ppc and rv64, courtesy of
        Thomas Weiﬂschuh.

3.      Add mid-sized stall to TREE07.

4.      Add fqs_holdoff check before fqs_task is created, courtesy
        of Zqiang.


Thanks
Neeraj

------------------------------------------------------------------------

 kernel/locking/locktorture.c                               |   18 +++++++++---------
 kernel/rcu/rcutorture.c                                    |    4 +++-
 tools/testing/selftests/rcutorture/bin/mkinitrd.sh         |    5 ++++-
 tools/testing/selftests/rcutorture/configs/rcu/TREE07.boot |    3 +++
 4 files changed, 19 insertions(+), 11 deletions(-)
