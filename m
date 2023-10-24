Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9767D43E6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjJXAZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjJXAZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:25:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EFE10C;
        Mon, 23 Oct 2023 17:25:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76672C433C8;
        Tue, 24 Oct 2023 00:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698107124;
        bh=/g7m0LnslOGK1YzQuPsBQeTkjUC7xa8Yb26dMeliAP0=;
        h=From:To:Cc:Subject:Date:From;
        b=i/esd8X91dHBM/21aleiKjjPwTy3DRsBsSEm3PWvHDRHE5Wj1/yclV3EkC05s1xX6
         4xFYyI/gRgyPlgj2PX0XD7iDcKd5oGmcxgdTDF1wyCUSZU6BhLKqwHA9PstRYJXyjZ
         1x4csmHgFmUhpYOdXWvolPXFbfKNsCAZxoVPIpo+QTgccHjlMK9/UbplPzxzMlokaH
         DTcdiY+1awxICKujKllRo2Oh4BpQDJk5ILd8YwlFosaw8sN2laP8CvLsaPVXNZol3t
         qqt8h+s5XOrUbQj5+F0W54444GpCTRqz94fLqUqdc8aRGKEeHTxcrzKIE3WefY1ZaH
         UERJ3wrVgTgJg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: [GIT PULL] tpmdd changes for v6.7
Date:   Tue, 24 Oct 2023 03:25:14 +0300
Message-ID: <20231024002514.433180-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Merge tag 'for-6.6-rc7-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux (2023-10-23 07:59:13 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.7

for you to fetch changes up to 03acb9ccec3f8cbcc0ed93c188b7a119ef30ef64:

  keys: Remove unused extern declarations (2023-10-24 03:16:52 +0300)

----------------------------------------------------------------
Hi,

This is a small sized pull request. One commit I would like to pinpoint
is my fix for init_trusted() rollback, as for actual patch I did not
receive any feedback. I think it is a no-brainer but can also send a
new pull request if required.

BR, Jarkko

----------------------------------------------------------------
Jarkko Sakkinen (1):
      KEYS: trusted: Rollback init_trusted() consistently

Michal Suchanek (1):
      integrity: powerpc: Do not select CA_MACHINE_KEYRING

Sumit Garg (1):
      KEYS: trusted: tee: Refactor register SHM usage

YueHaibing (1):
      keys: Remove unused extern declarations

 security/integrity/Kconfig                |  2 -
 security/keys/internal.h                  |  7 ----
 security/keys/trusted-keys/trusted_core.c | 20 +++++-----
 security/keys/trusted-keys/trusted_tee.c  | 64 ++++++++++---------------------
 4 files changed, 30 insertions(+), 63 deletions(-)
