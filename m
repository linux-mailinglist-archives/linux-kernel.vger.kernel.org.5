Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341928005D8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377906AbjLAIh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377890AbjLAIhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:37:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFA81721
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 00:37:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37415C433CA;
        Fri,  1 Dec 2023 08:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701419877;
        bh=rWGsZEZIR1EQpORLK+Bl7woMovPPcwnfUDDgud9gyiA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KT5LQD3Q8kgWWWRfyE38tdXGgiMfqQ+WNTDm9b+APrpt7/+D4Ok7xTlDWjwUvKj4n
         6yMT4UutwPHwW7EXughSVMOz/B4xpc+RElRGj24khVA1E5t3MrsWLlCuBCaR9NJK5q
         D+qooPaTU7oxWvuTBnbsCZEIfUIU/Ii3KPECGqpsrNTsmh+P6lAV0P+rAl0sHAEuC3
         QHD9Up8rgEjrIzz2nb39T+whTo1Hv0MtbumRVge1qpb8ocdq+6lbD7II4YwUiwZ54R
         jkPDqDiX0w7QzXdgEgrBfPjipwOaeDelE7x4W90aiucECQ8i7GQARjKSXFRM6ZNd3u
         f1Gav4Vae6kZw==
From:   Maxime Ripard <mripard@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Donald Robson <donald.robson@imgtec.com>
Cc:     matt.coster@imgtec.com, frank.binns@imgtec.com,
        boris.brezillon@collabora.com, maarten.lankhorst@linux.intel.com,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20231130160017.259902-5-donald.robson@imgtec.com>
References: <20231130160017.259902-1-donald.robson@imgtec.com>
 <20231130160017.259902-5-donald.robson@imgtec.com>
Subject: Re: (subset) [PATCH v2 5/5] drm/imagination: Removed unused
 function to_pvr_vm_gpuva()
Message-Id: <170141987488.3198881.129685975104737563.b4-ty@kernel.org>
Date:   Fri, 01 Dec 2023 09:37:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 16:00:17 +0000, Donald Robson wrote:
> This function is now unused, hence it causes a compiler warning.
> 
>    drivers/gpu/drm/imagination/pvr_vm.c:112:22: warning: unused function 'to_pvr_vm_gpuva' [-Wunused-function]
>      112 | struct pvr_vm_gpuva *to_pvr_vm_gpuva(struct drm_gpuva *gpuva)
>          |                      ^
> 
> Remove the function for now.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

