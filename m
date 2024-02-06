Return-Path: <linux-kernel+bounces-54360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE4784AE2E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FBAB1C23C8C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E031B7F474;
	Tue,  6 Feb 2024 05:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yWtPDNoN"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC64077F00;
	Tue,  6 Feb 2024 05:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707198790; cv=none; b=K+/vuUfxQOAVKc852TWQewxAhTts12lh8DKXMFO03/tZ0UA0AzW6xsFYZcPxhyGj4AEhpWB00XZmwxOOUdNxzZ8a6AOcpuoZNtGlOaN97Uv/FcvgsE7vYOd3Fs+9j20GsAkDn3kSc3Kg3twJhEtO0Ig4jkExwnJ5Oz4Sm1cELUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707198790; c=relaxed/simple;
	bh=z3pnyMy6CWb5booVEHbYu24GXOgyrWVlLFTfAlV0gmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DaoI84aeUGPrpRhg83jT3cyqHtCrA2/7+/9vtuA2bDrHRutIC1tHO9MvuIIPs14zd5BKbWRCqLCIJVTNaPtjlljtT+G7Y8v0hzUA5GUMlffUCwm08Y2M0BaoMPqNwkdX2aDqTMxXC6fBzlMyh4TsDFtcE4ccWIdC69BdHP1TqxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yWtPDNoN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=w3Q42N/e2eCew/j8uEMfyElkzHhqrTXgEIBh4kRIFbk=; b=yWtPDNoN5tJ5DYCV9E0cJbndTg
	SwomS3W/+jZdg3CoGSYr41fxanlYFkt7NXd0Z/Hq5DFyn9lyKxXS/hUtEBTi6fXb28L3NZ5XKHhGM
	BJRUc9RzGxK0qnMI5LXW2p0CKXmY6q8M390rtXsbYyGsNWQasIF+BkCPIzDZzvpeEIbOlspQYLaI1
	wnUvTVgu87H6eE475HMRPxEMjsa9B+AhT3UKtDABS9zzCSQJGBYB3C0MB2epLIEu1oIn4Cyrbs75o
	6P3mm5BNXqlr7HOQDeGZb0P4r2xN7bckWmlAMPQmZ29/yHOBG7HfWe3IxgWTqIaCXHIbPqQNT7BJZ
	7OZ7v/Pw==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXEOI-000000069rh-2Xul;
	Tue, 06 Feb 2024 05:53:06 +0000
Message-ID: <1b36c0aa-8a41-48e1-b21b-65f0ad521bcb@infradead.org>
Date: Mon, 5 Feb 2024 21:53:05 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Feb 6 (gpu/drm/amd/display/ kernel-doc
 warnings)
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20240206154329.6a8464fd@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240206154329.6a8464fd@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/5/24 20:43, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20240205:
> 

Hi Rodrigo,

Are you aware of these kernel-doc warnings?
I think they are due to

commit b8c1c3a82e75
Author: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Date:   Mon Jan 22 14:24:57 2024 -0700
    Documentation/gpu: Add kernel doc entry for MPC



./drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h:1: warning: no structured comments found
./drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h:1: warning: no structured comments found
./drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h:1: warning: no structured comments found
./drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h:1: warning: no structured comments found
./drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h:1: warning: no structured comments found
./drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h:1: warning: no structured comments found
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:1: warning: no structured comments found
./drivers/gpu/drm/amd/display/dc/inc/hw/opp.h:1: warning: no structured comments found
./drivers/gpu/drm/amd/display/dc/inc/hw/opp.h:1: warning: no structured comments found
./drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h:1: warning: no structured comments found
./drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h:1: warning: no structured comments found

./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:132: warning: Incorrect use of kernel-doc format:          * @@overlap_only: Whether overlapping of different planes is allowed.
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:132: warning: Incorrect use of kernel-doc format:          * @@overlap_only: Whether overlapping of different planes is allowed.
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:132: warning: Incorrect use of kernel-doc format:          * @@overlap_only: Whether overlapping of different planes is allowed.
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:162: warning: Function parameter or struct member 'pre_multiplied_alpha' not described in 'mpcc_blnd_cfg'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:162: warning: Function parameter or struct member 'overlap_only' not described in 'mpcc_blnd_cfg'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parameter or struct member 'read_mpcc_state' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parameter or struct member 'mpc_init_single_inst' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parameter or struct member 'get_mpcc_for_dpp_from_secondary' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parameter or struct member 'get_mpcc_for_dpp' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parameter or struct member 'wait_for_idle' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parameter or struct member 'assert_mpcc_idle_before_connect' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parameter or struct member 'init_mpcc_list_from_hw' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parameter or struct member 'set_denorm' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parameter or struct member 'set_denorm_clamp' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parameter or struct member 'set_output_csc' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parameter or struct member 'set_ocsc_default' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parameter or struct member 'set_output_gamma' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parameter or struct member 'power_on_mpc_mem_pwr' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parameter or struct member 'set_dwb_mux' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parameter or struct member 'disable_dwb_mux' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parameter or struct member 'is_dwb_idle' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parameter or struct member 'set_out_rate_control' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parameter or struct member 'set_gamut_remap' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parameter or struct member 'program_1dlut' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parameter or struct member 'program_shaper' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parameter or struct member 'acquire_rmu' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parameter or struct member 'program_3dlut' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parameter or struct member 'release_rmu' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parameter or struct member 'get_mpc_out_mux' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parameter or struct member 'set_bg_color' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parameter or struct member 'set_mpc_mem_lp_mode' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:132: warning: Incorrect use of kernel-doc format:          * @@overlap_only: Whether overlapping of different planes is allowed.
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:162: warning: Function parameter or struct member 'pre_multiplied_alpha' not described in 'mpcc_blnd_cfg'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:162: warning: Function parameter or struct member 'overlap_only' not described in 'mpcc_blnd_cfg'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:132: warning: Incorrect use of kernel-doc format:          * @@overlap_only: Whether overlapping of different planes is allowed.



Can you address these, please?

Thanks.

-- 
#Randy

