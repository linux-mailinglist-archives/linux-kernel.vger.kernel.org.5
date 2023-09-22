Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E71F7AB118
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjIVLmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjIVLmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:42:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CBEFB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 04:42:39 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:d3ea:1c7:41fd:3038])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AC2806607298;
        Fri, 22 Sep 2023 12:42:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695382958;
        bh=KnnpNkUp6NVHJrWtb6K3OPWOlfStBlM0EGcGjz+X0PM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hzpJfo/vLjeT6mw4pwOylse0e+3cGZMrTaRUkFyxnU9v3S0lTBpYkt5lfpB71W+iD
         6kyhoERwt/rLTBvy17mwtCt4lNHHTdAjUF+Hfkkjf5N4TNnmwowv2pIET/olWly201
         vlDrPDEnHHS0nviGXyMfnz77KW8zxDYxGRvZLqrTatid/2Lvv/1hFyftD3TfEbPVma
         2wfo+U98OKbxtFHCAUhn+K9HeQn0vmGDUkpvlQP3TmqmHjHB8KG5uKik3UKkRxGq19
         MDfPOjd1I1fuEmNDysmEC8BbzS3q6OdfkLc7mgqBfCDHBjVmr5JCuaSgX90XAGEp09
         RhDucKoaWP5OA==
Date:   Fri, 22 Sep 2023 13:42:34 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, christian.koenig@amd.com,
        faith.ekstrand@collabora.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-misc-next v4 6/8] drm/gpuvm: add drm_gpuvm_flags to
 drm_gpuvm
Message-ID: <20230922134234.4aa8634d@collabora.com>
In-Reply-To: <20230920144343.64830-7-dakr@redhat.com>
References: <20230920144343.64830-1-dakr@redhat.com>
        <20230920144343.64830-7-dakr@redhat.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2023 16:42:39 +0200
Danilo Krummrich <dakr@redhat.com> wrote:

>  void drm_gpuvm_init(struct drm_gpuvm *gpuvm, struct drm_device *drm,
> -		    const char *name,
> +		    const char *name, enum drm_gpuva_flags flags,

s/drm_gpuva_flags/drm_gpuvm_flags/gc
