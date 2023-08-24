Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5B9787547
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242525AbjHXQZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242557AbjHXQZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:25:24 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901E31BE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4WCvUtoFCzfEaXTzDHEDx1Go5TnHh8xSA7VOtwux7Hc=; b=Z/P7jfA+3uYmzGkm9ZCk+mf5tN
        ZlqdaVcNcElZXD5ffqCKLbgyl6WSJWmPIW2v6G4CHAtsaBh/JDb5VwpDGqsTIZHW9p5Ga59cx592i
        /yvF+m1utkowhKBIbk+Yr/2Cl+CMcNW/VALJA5Nid9LicPCUHCf6KdRIM6Ge8B2CABeThr0I8773g
        TPNvDKg/1GuEGKDL+plOKVx7h8yFOLCEVESFeNat8Cwpf3S2hpB99hC2BOjVMZuYi3v0CA+ToowZ4
        jbJezR5GtJ9dO2T1Fosuwzd+HX/iwVAjVDkFt2vcllwu7n93NL8Tytn1CV6/XPtvRtvF52HPvBpmq
        dTI/GVJg==;
Received: from [187.35.42.59] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qZD94-00F0DK-Ra; Thu, 24 Aug 2023 18:25:19 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 0/2] drm/amdgpu: Merge all debug module parameters
Date:   Thu, 24 Aug 2023 13:25:03 -0300
Message-ID: <20230824162505.173399-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.41.0
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

André Almeida (2):
  drm/amdgpu: Merge debug module parameters
  drm/amdgpu: Create an option to disable soft recovery

 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 30 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  6 ++++-
 drivers/gpu/drm/amd/include/amd_shared.h | 10 ++++++++
 4 files changed, 46 insertions(+), 1 deletion(-)

-- 
2.41.0

