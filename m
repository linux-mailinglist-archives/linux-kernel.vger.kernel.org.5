Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787997E7562
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 00:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345427AbjKIX7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 18:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjKIX7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 18:59:49 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6506344A4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 15:59:47 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-41cb615c6fbso9293721cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 15:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699574386; x=1700179186; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36Y/5+f5ZseD7XIsxNKIqTBp4EbKQG/VB7Ps5YKHI8M=;
        b=D1tThWPmQy42PUSHS4R2PRg1sEi8QroS/GP0j8sNDl3E9RIaBmeii6XGkGXi209Te3
         ftk0s9Y1xdRmlPPvBCnDnzdFb8h30yxiDErUtfLM+6B+dhkfVuh+kIf1CpPzfnE8+4Iq
         HcXGZ0XjkcE64ixsCtPYG0CBeIZ6k1bdk14Ezk7cEk1pl+9HEzFfwSOaHb2NL4GQudA9
         X/xejMtXC3NEIxPswI8Ne1BGP61E7JVds+94qVROt4srscMk3Qmjn3pww4d9tyPuyQKj
         6rCWoo/VgGdI8KWDTNJCPRtZ/FVJWsRk96Xbgz6wKybZ4Q2ylnkp3Hmo4qlOGPOjnJPg
         qSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574386; x=1700179186;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36Y/5+f5ZseD7XIsxNKIqTBp4EbKQG/VB7Ps5YKHI8M=;
        b=ZHVjwEFrfHVsbS3ujl+/s4YArNNuT/+X9Mf3db7Uh4Ru4q6Y702o0Jzn4bzjGMKmrU
         D4ODrnS1SY/dkw2gjPRb3Mt/yeFce+zcNT/t1T+7OK88fUnszwMSxkrfiYGotTgfBUXo
         B5V2U/RBotSydMxiw6aJLX9kdSDntSk1FYJvZbfnnAAARHpgEz0e81zUqugGnlrFqwWD
         hqX8uv36K3ZvQ8Ez1z/RucIpR5T0MqGgq5oeLJ1Sy6YFq+DiJBIM/0gYA/BzDkASnaq+
         TCkVMTESIn6BAen0nF05MPJ2D82H1/K6MzuW1eKCZUxXUm2KGLZ37gn/3QrR9UD7S8/Z
         CtjA==
X-Gm-Message-State: AOJu0Yy2TNJQWxJ6hF32glTyHlrAt7TR6UEOMpQMkrCpBMUrO8X8Ad6M
        70bKReWoKHr81dfQDDm46/UK
X-Google-Smtp-Source: AGHT+IGBIxGfqmKYpnr3KMhhwjcJSEasLX3u3P2NoivgpvURxnnL44y08ZqllLXR45ZvgNTXz/Iumg==
X-Received: by 2002:ac8:5fd4:0:b0:421:ad5c:d742 with SMTP id k20-20020ac85fd4000000b00421ad5cd742mr956220qta.3.1699574386501;
        Thu, 09 Nov 2023 15:59:46 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id y17-20020ac87091000000b00419c40a0d70sm2388783qto.54.2023.11.09.15.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 15:59:46 -0800 (PST)
Date:   Thu, 09 Nov 2023 18:59:45 -0500
Message-ID: <9672faa215f6b6f1c17ccc622a633611.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20231109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Not much to say here beyond the commit descriptions, but we've got two
small patches to correct the default return value of two LSM hooks:
security_vm_enough_memory_mm() and security_inode_getsecctx().

Thanks,
-Paul

--
The following changes since commit e508560672890b2873c89258b88fade1356392ce:

  lsm: fix a spelling mistake (2023-10-04 16:19:29 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20231109

for you to fetch changes up to b36995b8609a5a8fe5cf259a1ee768fcaed919f8:

  lsm: fix default return value for inode_getsecctx
    (2023-11-08 15:39:42 -0500)

----------------------------------------------------------------
lsm/stable-6.7 PR 20231109

----------------------------------------------------------------
Ondrej Mosnacek (2):
      lsm: fix default return value for vm_enough_memory
      lsm: fix default return value for inode_getsecctx

 include/linux/lsm_hook_defs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--
paul-moore.com
