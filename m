Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81A4785492
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjHWJtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236146AbjHWJsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:48:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7070010DA;
        Wed, 23 Aug 2023 02:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692783656; x=1724319656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oFCFuVDKxNca05E5fCXqRQ9kJDwM/9xD9jy6ThOYG54=;
  b=meMqM65sHkXk13h5vQuoRBgnD5m2bYjcmxEY55m8ofg3CeoAIXPrwAN+
   1vmYH1JOUek4aikxY2slupTLrKSIPE6igAnHHLJzoxgeN1Wl4MnMkYXbR
   YEe549+WAbpevPbr6m2HU2ostt1yHRfvsNMzShQaNWuiDPb9kllInNI6y
   KI/8+/Rvuz2Jav6ROP8nLNoC86tB0t/pZk3M4BPzHUhW3p+0xOsbef3T+
   X8weoa8j4kVCoHmsqp++Dnu8e8eMT5PsNuZEkD6q62u1yKwTfYM1mbHT8
   ymBWFrQOsT9RzCOIcOsDITBndtfLwDMKBDX5YQjDp8l5+0yVuXmLpp0r3
   g==;
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="asc'?scan'208";a="862761"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2023 02:40:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 23 Aug 2023 02:40:44 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 23 Aug 2023 02:40:41 -0700
Date:   Wed, 23 Aug 2023 10:40:00 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <stable@vger.kernel.org>, <patches@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <akpm@linux-foundation.org>, <linux@roeck-us.net>,
        <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>
Subject: Re: [PATCH 6.4 000/234] 6.4.12-rc1 review
Message-ID: <20230823-raft-cupcake-08b8629de8ef@wendy>
References: <20230821194128.754601642@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Zd6sdzXlo28Qd3yK"
Content-Disposition: inline
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Zd6sdzXlo28Qd3yK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 21, 2023 at 09:39:23PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.12 release.
> There are 234 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

> Mingzheng Xing <xingmingzheng@iscas.ac.cn>
>     riscv: Handle zicsr/zifencei issue between gcc and binutils

Fails to build w/ gcc-11 & binutils 2.37. Can you drop this please?
I'll go try to fix this in mainline because it is probably broken there
too.

--Zd6sdzXlo28Qd3yK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOXT8AAKCRB4tDGHoIJi
0q5TAP9wonJfGHAO4QB04iFwvbmbLDeiZyrQ9jtTc7T/AcejeQEA08j9E4v1wjcz
fNTUuWFH8slRszJvbiG8TeyY0LvDEA8=
=1KH7
-----END PGP SIGNATURE-----

--Zd6sdzXlo28Qd3yK--
