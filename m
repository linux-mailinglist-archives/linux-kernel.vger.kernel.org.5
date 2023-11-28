Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C910D7FB850
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343865AbjK1KoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbjK1KoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:44:00 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5885E19AC;
        Tue, 28 Nov 2023 02:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701168246; x=1732704246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N/NUrzO2PErprF82qE85GTu43xecUWk7SuyD+T42OuY=;
  b=J/11Q00VdmK0ex2atBw/laB9ZhdatHpM09VJzIUq8gU1L/T79+zEn/Jm
   aTRVDfdLpOJEhr5f9hPeqqGiv4UzvE1yW8OyE4t+XEj5Wvz5RvUK30r/7
   qw9Mbc8WcAvUwFh5vgXDn8Fx8oCU8S/2AQCkqcsXXF/dYHlwm4IWPZorA
   nq645dGlUfhxWc6rRISVFP/pYG9WfQskowXM7VnbdQ9mFRV7jkh2ULsu0
   l5FDyOkv9dQSmXhUuzr09yoOcD578dRqkK0JmP967ma/pSS/s/lIN0s6A
   2SnABtM6MWphdbTeMCUVUGYTfXTHLC3VeYmT+nTxvs2lGzgX3tYtFlBwT
   g==;
X-CSE-ConnectionGUID: JUteezYWQAu/qC0geM9gZw==
X-CSE-MsgGUID: 6vH2AyD3Tp+taL/nW+9jDA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="asc'?scan'208";a="13171676"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Nov 2023 03:44:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Nov 2023 03:43:41 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 28 Nov 2023 03:43:38 -0700
Date:   Tue, 28 Nov 2023 10:43:09 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <stable@vger.kernel.org>, <patches@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <akpm@linux-foundation.org>, <linux@roeck-us.net>,
        <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>, <allen.lkml@gmail.com>
Subject: Re: [PATCH 6.5 000/483] 6.5.13-rc4 review
Message-ID: <20231128-lunchbox-zigzagged-2e660e15a34b@wendy>
References: <20231126154413.975493975@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dU+rk7O5SqGQQLzG"
Content-Disposition: inline
In-Reply-To: <20231126154413.975493975@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--dU+rk7O5SqGQQLzG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 26, 2023 at 03:47:04PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.13 release.
> There are 483 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--dU+rk7O5SqGQQLzG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWXEPQAKCRB4tDGHoIJi
0hQRAQC4DLmpg3eOiK+eybGDt8psf+xUpKETkKF40NgUCNWYGwD/ah5I7Ua5uI84
GXdFM7dgTNNWgZ/Tk7zXh3N8dGBFSgs=
=wkmM
-----END PGP SIGNATURE-----

--dU+rk7O5SqGQQLzG--
