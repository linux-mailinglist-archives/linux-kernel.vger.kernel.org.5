Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843C77AB123
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbjIVLqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjIVLp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:45:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B06FB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 04:45:53 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:d3ea:1c7:41fd:3038])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B27F56607298;
        Fri, 22 Sep 2023 12:45:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695383152;
        bh=MoMkptljEz1wEeXfbVsyAz0hGh9sZ9dJCPGyUcLkgRM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gAbPPTK5nC9/gENoEpD7H/GLKGT/0Pcigwu/MkVfY0HfBH2bL8qQxy1nJlZnGBEF9
         uKKMPY9G/lHfxFLQYMWoIEJKAD0ws61WQazeiOjgwWdxgYcxMq1r6hZyi0F92SmVZM
         IRX4XA2QGGebm67C1Cozt8DurmVxShzeVzF3Zhw3BnJbmfNHAIMIUbXRtKL/xtcCrH
         8MVM0+BCGRax5aeXfo/ztZCLyPxarp1e+wIISHSK/h/Cc/TU+4IEt9AShp32sR4FWq
         oKmmtj9rx0LwnJHZPSN8CFbtfI4gykvk3fDs2Da65SCrY7OEtdLU8uXDHUh+qd4I6Q
         kv4XMgooNOXpA==
Date:   Fri, 22 Sep 2023 13:45:48 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, christian.koenig@amd.com,
        faith.ekstrand@collabora.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-misc-next v4 7/8] drm/gpuvm: generalize
 dma_resv/extobj handling and GEM validation
Message-ID: <20230922134548.7ede67c0@collabora.com>
In-Reply-To: <20230920144343.64830-8-dakr@redhat.com>
References: <20230920144343.64830-1-dakr@redhat.com>
        <20230920144343.64830-8-dakr@redhat.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2023 16:42:40 +0200
Danilo Krummrich <dakr@redhat.com> wrote:

> +	/**
> +	 * @DRM_GPUVM_RESV_PROTECTED: GPUVM is protected externally by the
> +	 * GPUVM's &dma_resv lock

I think we need to be more specific, and list the fields/operations
that need to be externally protected when DRM_GPUVM_RESV_PROTECTED is
set.

> +	 */
> +	DRM_GPUVM_RESV_PROTECTED = (1 << 0),
