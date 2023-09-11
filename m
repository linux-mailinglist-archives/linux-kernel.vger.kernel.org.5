Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4315779B7C8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350515AbjIKViy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243460AbjIKRNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:13:11 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526C8121
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XQmsfW2vrC08QS1Vi9h0FMvKZyiAQtWCUkIB7h1LPl4=; b=HuS9WzqHX3yHfr4DgHzlrYQIk0
        LQbWL67GHJB5H8I5A64++kWPMl+NMLiQY1o5wWWfoPCRZAHGd8lvBL1DkPP3EwY70Zg9mewQSHYN4
        av/YRjDFnyna7mrHoV4AKW3r73H4A3ajqMjVS2bf+m3RrhwvtXHY8ECQdrnaF19Fo5PJ5AmAhyDN/
        hKrwHz3yRKZPvdVltAnheaSnbV1i4E1y8wyors5SCWxmhBynX6UUXTt6nd5QsDOPG7kX2e39FMKQ/
        iYS+UPuIVD4+U7gP7448HfD3sTIZwYAh7MF1fkWlHC2PHn1xliPRe0VASw2jOZcKKc1Hmyqh53Dyl
        RDvDzpeA==;
Received: from [187.10.203.89] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qfkT7-002OoM-02; Mon, 11 Sep 2023 19:13:01 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        Shashank Sharma <shashank.sharma@amd.com>,
        hamza.mahfooz@amd.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v4 0/2] Merge all debug module parameters
Date:   Mon, 11 Sep 2023 14:12:53 -0300
Message-ID: <20230911171255.143992-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Christian at [0], this patchset merges all debug modules
parameters and creates a new one for disabling soft recovery:

> Maybe we can overload the amdgpu_gpu_recovery module option with this. 
> Or even better merge all the developer module parameter into a 
> amdgpu_debug option. This way it should be pretty obvious that this 
> isn't meant to be used by someone who doesn't know how to use it.

[0] https://lore.kernel.org/dri-devel/55f69184-1aa2-55d6-4a10-1560d75c7324@amd.com/

Changelog:
- rebased on top of current amd-staging-drm-next 
v3: https://lore.kernel.org/lkml/20230831152903.521404-1-andrealmeid@igalia.com

- move enum from include/amd_shared.h to amdgpu/amdgpu_drv.c
v2: https://lore.kernel.org/lkml/20230830220808.421935-1-andrealmeid@igalia.com/

- drop old module params
- use BIT() macros
- replace global var with adev-> vars
v1: https://lore.kernel.org/lkml/20230824162505.173399-1-andrealmeid@igalia.com/

André Almeida (2):
  drm/amdgpu: Merge debug module parameters
  drm/amdgpu: Create an option to disable soft recovery

 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  5 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 63 ++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  7 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c    |  2 +-
 8 files changed, 59 insertions(+), 26 deletions(-)

-- 
2.42.0

