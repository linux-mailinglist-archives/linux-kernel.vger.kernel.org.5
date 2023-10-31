Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FE67DC45E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjJaCZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjJaCZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:25:31 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56056E6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 19:25:29 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-778ac9c898dso306766285a.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 19:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698719128; x=1699323928; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ek8q19kEOxNIpwo6vTqnPY4hIXGFUfhkcH54NLcWDlo=;
        b=GfMxnX7eYdukfoRR1ojQlhSLGdD1OpUnaNJjnZHS7nUO9qmFIydpG9vIKfn9U2v2Zk
         M26BRI/GWs1OnY+LT/p2XLptl6ZDnjirl6o6fEasyhgjck5AiznjTyR9BFSpH+MEnRzA
         XZukfzDCt98MfX0M0L8+dbsyytH425L0pPy1O+JmnhA1aQxrv1J94EUf7dIR1cGO8KKz
         oBMXDAqF/KXY+qbT5EZQ8isflIZXRBAQX/mm8Yu4tNt1cKyYpzFeCA1yJAeXgYKCp1fG
         Av6YmtZyUXQq3HcVv3fbAjd3NkBPxbvYJiKPRtGfVyRxrIItFRX/4uzZZffWw45boIW6
         +SyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698719128; x=1699323928;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ek8q19kEOxNIpwo6vTqnPY4hIXGFUfhkcH54NLcWDlo=;
        b=qwhQ+TnzKq4nv0Melw6Zz8fNEQUIkHstcyUBs1ZHeynOZE5XIVspdKN6bQq0gDPgnr
         8WPKVrmR3VZLZPbpBYh65uxR1yER1uxJ/t25YIWuq3QVpod2VsPrdtc/WJ1sCCCFWeg6
         nb25kHiuxKg8e0tzUTckaLAiWdCgSPdCBpB9BF6m7UtRNJUvV3McKh8y7rsaotB31Ekc
         CrAleCCI43+di5azqX+wzRIgmbRT2Towbje6fAZCM5Afwcn9DMPOom9qjzjDKuNohiLv
         Gh1P+FZYpW4pYMDMKJ4ZT0neXstCaM2gZy+DblJBmKJXvFNtx5FeNJ86GFVNJZJYEvo5
         hOGA==
X-Gm-Message-State: AOJu0Yz7Z0R1DUgEwPC6T9y14QFGrW1WEOLQUrz1WF9BW8UZY+ctT9ID
        vqb1Q+IiXeUSPeIP9mo9GuAHoGQjwuWQVbLssA==
X-Google-Smtp-Source: AGHT+IHH0Mm6Et5uv494epJnkqipQxZD4PXhL5jDQI3GhwHVgjDrr0CGvHrnrPOrKbQhVJ9gBn1eeg==
X-Received: by 2002:a05:620a:450b:b0:777:6c68:c5f0 with SMTP id t11-20020a05620a450b00b007776c68c5f0mr12512383qkp.0.1698719128437;
        Mon, 30 Oct 2023 19:25:28 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id g16-20020ae9e110000000b007756d233fbdsm130640qkm.37.2023.10.30.19.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 19:25:28 -0700 (PDT)
Date:   Mon, 30 Oct 2023 22:25:27 -0400
Message-ID: <1cf859668ed2841067c50ebcaf01908f.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20231030
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Seven LSM patches for v6.7, the highlights are below:

* Add new credential functions, get_cred_many() and put_cred_many() to
  save some atomic_t operations for a few operations.  While not strictly
  LSM related, this patchset had been rotting on the mailing lists for
  some time and since the LSMs do care a lot about credentials I thought
  it reasonable to give this patch a home.

* Five patches to constify different LSM hook parameters.

* Fix a spelling mistake.

Please merge for v6.7-rc1, thanks.
-Paul

--
The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20231030

for you to fetch changes up to e508560672890b2873c89258b88fade1356392ce:

  lsm: fix a spelling mistake (2023-10-04 16:19:29 -0400)

----------------------------------------------------------------
lsm/stable-6.7 PR 20231030

----------------------------------------------------------------
Khadija Kamran (5):
      lsm: constify 'sb' parameter in security_quotactl()
      lsm: constify 'file' parameter in security_bprm_creds_from_file()
      lsm: constify 'bprm' parameter in security_bprm_committing_creds()
      lsm: constify 'bprm' parameter in security_bprm_committed_creds()
      lsm: constify 'sb' parameter in security_sb_kern_mount()

Mateusz Guzik (1):
      cred: add get_cred_many and put_cred_many

Paul Moore (1):
      lsm: fix a spelling mistake

 include/linux/cred.h          | 59 ++++++++++++++++++++++++++++++++-----
 include/linux/fs.h            |  2 +-
 include/linux/lsm_hook_defs.h | 10 ++++----
 include/linux/security.h      | 20 +++++++--------
 kernel/cred.c                 | 26 +++++++++++--------
 security/apparmor/lsm.c       |  4 +--
 security/commoncap.c          |  4 +--
 security/security.c           | 12 ++++-----
 security/selinux/hooks.c      | 10 ++++----
 security/tomoyo/tomoyo.c      |  2 +-
 10 files changed, 97 insertions(+), 52 deletions(-)

--
paul-moore.com
