Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95A0804D7C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbjLEJUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbjLEJUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:20:43 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8308EC6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:20:49 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:f143:dd2b:2cfe:eb7c])
        by xavier.telenet-ops.be with bizsmtp
        id JZLk2B00X5Tnyl201ZLk4P; Tue, 05 Dec 2023 10:20:46 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1rARbg-00B2oN-N4;
        Tue, 05 Dec 2023 10:20:44 +0100
Date:   Tue, 5 Dec 2023 10:20:44 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        Xinhui Pan <Xinhui.Pan@amd.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        amd-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: amdgpu header files (was: Re: [git pull] drm for 6.7-rc1)
In-Reply-To: <CAPM=9txd+1FtqU-R_8Zr_UePUzu7QUWsDBV1syKBo16v_gx2XQ@mail.gmail.com>
Message-ID: <45db1e4b-afbe-8bf5-6c4-945bdacb11f3@linux-m68k.org>
References: <CAPM=9txd+1FtqU-R_8Zr_UePUzu7QUWsDBV1syKBo16v_gx2XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023, Dave Airlie wrote:
> This is the main drm pull request for 6.7.

> Highlights:
> - AMD adds some more upcoming HW platforms

> Alex Deucher (24):
>      drm/amdgpu: update to the latest GC 11.5 headers

> Candice Li (8):
>      drm/amd: Add umc v12_0_0 ip headers

> Lang Yu (57):
>      drm/amdgpu: add gc headers for gc 11.5.0
>      drm/amdgpu: add mmhub 3.3.0 headers
>      drm/amdgpu: add VPE 6.1.0 header files
>      drm/amdgpu: add UMSCH 4.0 register headers

> Li Ma (11):
>      drm/amdgpu: add header files for MP 14.0.0
>      drm/amdgpu: fix missing stuff in NBIO v7.11

> Qingqing Zhuo (38):
>      drm/amd/display: Add dcn35 register header files

> Saleemkhan Jamadar (9):
>      drm/amdgpu: add vcn 4_0_5 header files

> Yang Wang (16):
>      drm/amd/pm: add smu_13_0_6 mca dump support

> benl (3):
>      drm/amdgpu: add nbio 7.11 registers

> .../amd/include/asic_reg/dcn/dcn_3_5_0_offset.h    | 15255 +++++
> .../amd/include/asic_reg/dcn/dcn_3_5_0_sh_mask.h   | 53412 +++++++++++++++++
> .../drm/amd/include/asic_reg/gc/gc_11_5_0_offset.h | 10000 ++++
> .../amd/include/asic_reg/gc/gc_11_5_0_sh_mask.h    | 36579 ++++++++++++
> .../include/asic_reg/mmhub/mmhub_3_3_0_offset.h    |  1395 +
> .../include/asic_reg/mmhub/mmhub_3_3_0_sh_mask.h   |  6722 +++
> .../amd/include/asic_reg/mp/mp_13_0_6_sh_mask.h    |    28 +
> .../drm/amd/include/asic_reg/mp/mp_14_0_0_offset.h |   359 +
> .../amd/include/asic_reg/mp/mp_14_0_0_sh_mask.h    |   534 +
> .../amd/include/asic_reg/nbio/nbio_7_11_0_offset.h |  9400 +++
> .../include/asic_reg/nbio/nbio_7_11_0_sh_mask.h    | 57857 +++++++++++++++++++
> .../amd/include/asic_reg/umc/umc_12_0_0_offset.h   |    33 +
> .../amd/include/asic_reg/umc/umc_12_0_0_sh_mask.h  |    95 +
> .../amd/include/asic_reg/vcn/vcn_4_0_0_offset.h    |   422 +
> .../amd/include/asic_reg/vcn/vcn_4_0_0_sh_mask.h   |   882 +
> .../amd/include/asic_reg/vcn/vcn_4_0_5_offset.h    |  1797 +
> .../amd/include/asic_reg/vcn/vcn_4_0_5_sh_mask.h   |  8614 +++
> .../amd/include/asic_reg/vpe/vpe_6_1_0_offset.h    |  1553 +
> .../amd/include/asic_reg/vpe/vpe_6_1_0_sh_mask.h   |  4393 ++

These huge files can be reduced by 50%: all the *_SHIFT definitions are
redundant, as they can be derived from the corresponding *_MASK
definitions at compile-time, cfr. <linux/bitfield.h>.

E.g.:

#define AZCONTROLLER0_CORB_READ_POINTER__CORB_READ_POINTER__SHIFT        0x0
#define AZCONTROLLER0_CORB_READ_POINTER__CORB_READ_POINTER_RESET__SHIFT  0xf
#define AZCONTROLLER0_CORB_READ_POINTER__CORB_READ_POINTER_MASK          0x00FFL
#define AZCONTROLLER0_CORB_READ_POINTER__CORB_READ_POINTER_RESET_MASK    0x8000L

AZCONTROLLER0_CORB_READ_POINTER__CORB_READ_POINTER__SHIFT =
 	__bf_shf(AZCONTROLLER0_CORB_READ_POINTER__CORB_READ_POINTER_MASK)
AZCONTROLLER0_CORB_READ_POINTER__CORB_READ_POINTER_RESET__SHIFT =
 	__bf_shf(AZCONTROLLER0_CORB_READ_POINTER__CORB_READ_POINTER_RESET_MASK)

set_reg_field_value_masks() takes a shift and a mask, while it
could calculate the shift at run-time.
set_reg_field_values() takes pairs of shifts and masks, but the shifts
are not needed; lots of tables can be halved, etc...

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
