Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4308278209E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 00:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjHTWaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 18:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjHTWaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 18:30:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CA99F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 15:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692570568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YPhQSl7EkHeXJaVSqjtUG2Pb7auEbNHbcpRSgSMEH1A=;
        b=dOpqBMMRVvRQ2yVEAoRO8wvnoxaONLi0+69r1ZXlP5bnYZXI4ZRrpOg2JY59FMGCHI7P15
        d92C5bPvC4Vz6CsF0w8PKTpar500Zl6LdaCo3pVNAK8qT3W1l0VCNrGW71v6U6wD+OaJb8
        G6gwJZ3/NZ056A4j2c+HqYRNLCUsaDM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-5wpzmgFaOpWSijBL0BLTog-1; Sun, 20 Aug 2023 18:29:26 -0400
X-MC-Unique: 5wpzmgFaOpWSijBL0BLTog-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a34d3e5ebso160368266b.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 15:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692570565; x=1693175365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPhQSl7EkHeXJaVSqjtUG2Pb7auEbNHbcpRSgSMEH1A=;
        b=ASP43dzAENSmeRCuRi1Bs97E7cITvP2dvpuJFGZ+palImXPv5UhTwl8YaWLiwoAqUg
         Kx+9uLlnH7BLmyhSLUO3QuAcZs4ry3EtoHsLUScNT/TEa13yS2nPs/yvP5X4h7UdwH0d
         GtTLY6aMF+SAVgY/JQCtPAyNrjKYQ9Jek7fK6WGfCBNd5+KRBtWnwPOxtz6hGDRlpL/d
         OoZ6rptdkznV0ImzOpKsHjr81Z52F9Qnuwf0cq+tCGR16M60rwv2Xeo1zCVEKpGUrsDR
         gfEgAyriwxPcjezWE/AcX2rMq2Et3TmdVSaJAgLCl0OMEZwEOn83pOeM9QxVPITvNRW9
         fwoQ==
X-Gm-Message-State: AOJu0Yz6pnACNcbt3D2OMc3Z7V9AeFRiqCfW/op4wVOtNX/MCojF57mL
        syBVzcPHYupbk04eZzFKPr/skj03wivYRtVHaR0GW//scOw7d1gaLtkXQn4IormlwRR+uxBRy89
        fC4d+5Q2e7i+XQCOk5I3uZxQ0
X-Received: by 2002:a17:907:77c4:b0:993:d536:3cb7 with SMTP id kz4-20020a17090777c400b00993d5363cb7mr4188738ejc.11.1692570565800;
        Sun, 20 Aug 2023 15:29:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3E66CloZzC5H6aCpbP5SgT88XUYTNuLaQ2K+qLz0CTNXQrDXDaUTKDGZiMqAUR3LIjhbRIw==
X-Received: by 2002:a17:907:77c4:b0:993:d536:3cb7 with SMTP id kz4-20020a17090777c400b00993d5363cb7mr4188726ejc.11.1692570565517;
        Sun, 20 Aug 2023 15:29:25 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id t3-20020a170906a10300b00993860a6d37sm5324078ejy.40.2023.08.20.15.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 15:29:24 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, bskeggs@redhat.com,
        kherbst@redhat.com, lyude@redhat.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next] drm/nouveau: uvmm: fix unset region pointer on remap
Date:   Mon, 21 Aug 2023 00:29:16 +0200
Message-ID: <20230820222920.2344-1-dakr@redhat.com>
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

Transfer the region pointer of a uvma to the new uvma(s) on re-map to
prevent potential shader faults when the re-mapped uvma(s) are unmapped.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 3a1e8538f205..aae780e4a4aa 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -639,6 +639,7 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
 			struct drm_gpuva *va = r->unmap->va;
 			struct uvmm_map_args remap_args = {
 				.kind = uvma_from_va(va)->kind,
+				.region = uvma_from_va(va)->region,
 			};
 			u64 ustart = va->va.addr;
 			u64 urange = va->va.range;

base-commit: 25205087df1ffe06ccea9302944ed1f77dc68c6f
-- 
2.41.0

