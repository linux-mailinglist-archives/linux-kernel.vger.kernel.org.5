Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B582C78B251
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjH1Nzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjH1NzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:55:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990D3CE;
        Mon, 28 Aug 2023 06:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693230913; x=1724766913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zP+aR1qLi8yYPI0boF+W89QBgdXfE3+6S0i6OY6bCxA=;
  b=oa6iYjE1x/Y6/hpqI+Wk4O2jaacbquptomDggpYU4HxQV9FNsiHhrDrO
   YIcUwAg3reJIviGi5tlDJ3C2NJLiDdWAy+I+nB56LE1fONbIbB4V8rpQ7
   HaYOS6ktFIvH/Ehz1ZClHCe1EfLg057wLQWW3cX+6Rqt480G3KiRXBLNz
   A/0d+yJf30T9pdssfgaYQhajiIUPJGRFe0oS0VMYw+w3zfKixudpziZmo
   Dh+W6xALtlQkuaOSAzdH/GX0nk/O+GAoygKL8ii0z6JFPvsCtoAwO8Ijm
   XxTZ9jag5qtq7qd6h8SaPC+v1wkbJyaEAxVKwTbxbivp349Nr3nLahjCr
   w==;
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="asc'?scan'208";a="168669658"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Aug 2023 06:55:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 28 Aug 2023 06:54:36 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 28 Aug 2023 06:54:33 -0700
Date:   Mon, 28 Aug 2023 14:53:51 +0100
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
Subject: Re: [PATCH 6.1 000/122] 6.1.50-rc1 review
Message-ID: <20230828-clasp-reformat-1d6c70a835dd@wendy>
References: <20230828101156.480754469@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+9/25Ag1w0lpe2Cj"
Content-Disposition: inline
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--+9/25Ag1w0lpe2Cj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 28, 2023 at 12:11:55PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.50 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--+9/25Ag1w0lpe2Cj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOym7wAKCRB4tDGHoIJi
0t/CAP99hGJt04bJe6pBAhOYBVGxtUChtUyQtPDCVKdfwkviMgD8CGUrKV+uSPhg
NnrpBgREctlIF3C+aiyuJUHcsSEMCww=
=mRPi
-----END PGP SIGNATURE-----

--+9/25Ag1w0lpe2Cj--
