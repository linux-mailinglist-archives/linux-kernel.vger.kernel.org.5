Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D9E772B15
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjHGQgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjHGQgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:36:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BE7210A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691426112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8RzhR0Defsn9yPdyrBq2FgdXanmnGOPFDzct4NabJUc=;
        b=Kk7OMiSNQ01vyKFbIh+dKZSDv+ThLyYAvfxaxzKPkL/K2+gSJ7LiFNkAYMMO2PW/mWOtL7
        gi5vFLyMeB4NlSADvPHDOE9J9cEnTZMg/6NwKDH7VSqo45B+83kX7+6QQjq3aOTwybLh2I
        +3xL7MCXgr/vj5Lv1OlNbdJGKVVFA94=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-bvvzrSmKOb6WHSqrpbL1LA-1; Mon, 07 Aug 2023 12:29:04 -0400
X-MC-Unique: bvvzrSmKOb6WHSqrpbL1LA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99bfe3dd009so756392166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425743; x=1692030543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8RzhR0Defsn9yPdyrBq2FgdXanmnGOPFDzct4NabJUc=;
        b=ECHTgepxVjlKuRtXQeGF9zLA3XW1B+M5/K2EtwElkz5oeJrvnp2NNsPv3Q//evT6hc
         quvqWPy5V8iYoQZMQ8mE0loO/46wSH/X52LL9qrm/cy9TqQ64ucnjFSHUdX9SsLeXQYj
         Fbg6fO1XU1STb5hzXqtHFEZCpQXQ7seqD9BNzw2bUW85BW4ZG574CHNfeZC73lX3rbc+
         7vF95VWTcG/OHJPD+jNGL2zbd5SIAfOMlLgVD2sjFoK32XdGoGNOvdcbP3Q16hVVGkYg
         dim3JCegtizjDMBvME4WDtiV6rKTNGGAYcypadinnuDaYz4T7aMrQ297puw6cWoZqm5P
         6o6g==
X-Gm-Message-State: AOJu0Yz8kVhYjncyAcPs66ohAZC3yZ7VRT7I+mSHlmilUUQOy/5gEpod
        sMo9YItSd+5RWeciVBfn19hf+zT3a8nzkFZp7jlMa5oUVOkuBxawnpv4Hp+va9g7lKBjHWZ8mcz
        Of/I16Ms9kLTAxBjwRHXDHMbu
X-Received: by 2002:a17:907:3f93:b0:99b:cadd:c2ee with SMTP id hr19-20020a1709073f9300b0099bcaddc2eemr9291173ejc.29.1691425743723;
        Mon, 07 Aug 2023 09:29:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw6akvBExQRKLRcc48yHKLdyy5YgC26FFwO36Jpq7vnN3NYThd0gduelCV3L44tmqlcvtGLg==
X-Received: by 2002:a17:907:3f93:b0:99b:cadd:c2ee with SMTP id hr19-20020a1709073f9300b0099bcaddc2eemr9291145ejc.29.1691425743314;
        Mon, 07 Aug 2023 09:29:03 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id m8-20020a1709066d0800b0099cadcf13cesm4504419ejr.66.2023.08.07.09.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 09:29:02 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, bskeggs@redhat.com,
        kherbst@redhat.com, lyude@redhat.com, sfr@canb.auug.org.au
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 0/5] Nouveau VM_BIND uAPI Fixes
Date:   Mon,  7 Aug 2023 18:28:44 +0200
Message-ID: <20230807162859.68905-1-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series provides a few fixes for the recently merged VM_BIND uAPI
mostly addressing a couple of warnings.

It also contains one patch to slightly reduce the memory footprint of
struct nouveau_uvma.

Danilo Krummrich (5):
  nouveau/dmem: fix copy-paste error in nouveau_dmem_migrate_chunk()
  drm/nouveau: nvkm: vmm: silence warning from cast
  drm/nouveau: remove incorrect __user annotations
  drm/nouveau: uvmm: remove incorrect calls to mas_unlock()
  drm/nouveau: uvmm: remove dedicated VM pointer from VMAs

 drivers/gpu/drm/nouveau/nouveau_dmem.c        |  2 +-
 drivers/gpu/drm/nouveau/nouveau_exec.c        |  6 ++---
 drivers/gpu/drm/nouveau/nouveau_exec.h        |  2 +-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c        | 23 ++++++++-----------
 drivers/gpu/drm/nouveau/nouveau_uvmm.h        | 14 +++++------
 .../gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c    |  5 ++--
 6 files changed, 24 insertions(+), 28 deletions(-)


base-commit: 82d750e9d2f5d0594c8f7057ce59127e701af781
-- 
2.41.0

