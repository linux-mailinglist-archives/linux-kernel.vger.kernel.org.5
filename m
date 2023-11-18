Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE887EFC9D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 01:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346391AbjKRAhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 19:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346382AbjKRAhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 19:37:33 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACB5B0;
        Fri, 17 Nov 2023 16:37:29 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50a6ff9881fso3755792e87.1;
        Fri, 17 Nov 2023 16:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700267848; x=1700872648; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CxtVFoV3G/MmorB/F0YD8MQFUJsJvmktt5r+tHpZpZ8=;
        b=LB5pso34cv04SMV6nGtIjeTrlbF0sg+zwZ+GWScf0a+ms1WuM9RmVGpvodok80hosC
         87l0NYFPxMDHBuD46eznhlq9KH18vSjzJVO0VdFPPmIZjQH6gG6M2rYR4OpWIO8olym7
         qXHvWW52aM6OdBVs9w3INjJzIRF0NdhQom82hQTvDh1GKcOXHYdu0t9v43t/8iRvVL2l
         Wbe1AiMKxEdXrLnyhmOakawMewidfZwScluN2QnzMSKvrzECJbFFSPAmUrHG5uzMEOgk
         O2NQl1IWQo+pl8QdAyhFLog0D//5MqpWNWwjhSCuXKe7uNhYMUiEL7FaGcqpxfsyAWyv
         uCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700267848; x=1700872648;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CxtVFoV3G/MmorB/F0YD8MQFUJsJvmktt5r+tHpZpZ8=;
        b=WZLgcbdNQrC4fg6zeniGb7LKToyBTBt2pQPTzWWF5hHmMCZfptqvNJ8CfpVGN2QCWg
         gRa1YkYKwXJpLfNU2DWwu3gI6yoXnm9Q6yy7xQCYRGpi1F5nswobINmwFPHYEZGL6XOt
         ZtpzoYl4Fz+qUiCGjVqZn6m+jbOuNxbS8H2L9h5ARZFgGoj+aHe2ujqm/tGZouNj2O9+
         qQbZhfba5X+RqwlyoxhCnsHI0TF0eVdpt3Ib8TawrvgtMJyYaHziQJ89Juo9BmbsxYKl
         v9ns0X8TDskcHHk2GxKwkbOcsj6cc0DSw5urh6iTDU82X3P4GOTIyTNjtq96mviKQPjQ
         zyXQ==
X-Gm-Message-State: AOJu0Yw5vxvI9/7KGRGIwvmA7hSUqQQ8otaEqJ2wDVnPWZ44j2ObLsZz
        2M+xoEMTpdsGMhVSyNBWQATWwFmV0umitwGGYs1Jvggeiv4=
X-Google-Smtp-Source: AGHT+IHMVCa5N6+PbZh3LRTxQsaEaet4ICSjDflQIYHwg/nDji7SsWKQUqLoH9Mydml6avg9Xnfgw57zQTUiD5X3N2M=
X-Received: by 2002:ac2:4203:0:b0:500:acf1:b432 with SMTP id
 y3-20020ac24203000000b00500acf1b432mr720823lfh.63.1700267847640; Fri, 17 Nov
 2023 16:37:27 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 17 Nov 2023 18:37:16 -0600
Message-ID: <CAH2r5msETjR-mEd6PUkE-E=OTMFKh-jD2ucuHP=uGyLScZQCLA@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.7-rc1-smb3-client-fixes

for you to fetch changes up to 5eef12c4e3230f2025dc46ad8c4a3bc19978e5d7:

  cifs: fix lock ordering while disabling multichannel (2023-11-14
11:39:35 -0600)

----------------------------------------------------------------
Four cifs/smb3 client fixes
- three multichannel fixes (including a lock ordering fix and an
important refcounting fix)
- spnego fix

----------------------------------------------------------------
Anastasia Belova (1):
      cifs: spnego: add ';' in HOST_KEY_LEN

Ekaterina Esina (1):
      cifs: fix check of rc in function generate_smb3signingkey

Shyam Prasad N (2):
      cifs: fix leak of iface for primary channel
      cifs: fix lock ordering while disabling multichannel

 fs/smb/client/cifs_spnego.c   |  4 ++--
 fs/smb/client/connect.c       |  6 ++++++
 fs/smb/client/sess.c          | 22 +++++++++++++---------
 fs/smb/client/smb2transport.c |  5 ++---
 4 files changed, 23 insertions(+), 14 deletions(-)


--
Thanks,

Steve
