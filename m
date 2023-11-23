Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A622E7F614E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345746AbjKWOXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345745AbjKWOXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:23:37 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D023FB9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1700749424; x=1732285424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ohvzPpwHho+Wozsk3IfdLQvS5IQE5RYHnNIM727nKM4=;
  b=gozhZLPibear2vrxc7S13lu7noHGKbKac+/bfsu5nRuOoe6VI1qOgq+Y
   5KF1nNhAOnn2r3jbextY9IwQ2WahWl/7lvvZyDusibxpPeLwj5QeS2qgt
   q5cgKhkvzOQQ/z4cHhnUhsxvVXCxA55blzx1i9zgXt1zLLMlbxNWGXiXs
   1p+Mx8idKPtRsQKXdoFSmYsOwfawmlRe8714KZOW3S9lrZDTXY46GjO48
   1vS49phXyrYWRJqLJH3fm92z0LybvQSwe3VjfgSeQ/Hmu4mwwFdJzc9UY
   2j2ET7thAQLsVhRBsbr6z5aaEDYQHn9h/6Ks2hMPk3MLe6nueYEUwit7f
   g==;
X-CSE-ConnectionGUID: PGZ2z8fJRMa+agPdtt+bKw==
X-CSE-MsgGUID: EwqpIQk1Qom2mh0R2QGlFQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="asc'?scan'208";a="12194934"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2023 07:23:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Nov 2023 07:23:32 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 23 Nov 2023 07:23:29 -0700
Date:   Thu, 23 Nov 2023 14:23:01 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Samuel Holland <samuel.holland@sifive.com>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@gmail.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        <amd-gfx@lists.freedesktop.org>, <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>, <arnd@arndb.de>
Subject: Re: [PATCH 3/3] drm/amd/display: Support DRM_AMD_DC_FP on RISC-V
Message-ID: <20231123-headdress-mold-0dd7a74477f7@wendy>
References: <20231122030621.3759313-1-samuel.holland@sifive.com>
 <20231122030621.3759313-4-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PT94HBO7SSDOZxaP"
Content-Disposition: inline
In-Reply-To: <20231122030621.3759313-4-samuel.holland@sifive.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--PT94HBO7SSDOZxaP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 21, 2023 at 07:05:15PM -0800, Samuel Holland wrote:
> RISC-V uses kernel_fpu_begin()/kernel_fpu_end() like several other
> architectures. Enabling hardware FP requires overriding the ISA string
> for the relevant compilation units.

Ah yes, bringing the joy of frame-larger-than warnings to RISC-V:
../drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:58:13: warning: stack frame size (2416) exceeds limit (2048) in 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation' [-Wframe-larger-than]

Nathan, have you given up on these being sorted out?

Also, what on earth is that function name, it exceeds 80 characters
before even considering anything else? Actually, I don't think I want
to know.

--PT94HBO7SSDOZxaP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV9gRQAKCRB4tDGHoIJi
0jEnAP9OKVgfXZxGyPpXzUcsNSne5N1ezJDKqBB32TBdrtW7vQD/Sd98JmdWJ4g8
Labru0YLH7jrvDUwLAIAnldCPJQbfAw=
=HKiT
-----END PGP SIGNATURE-----

--PT94HBO7SSDOZxaP--
