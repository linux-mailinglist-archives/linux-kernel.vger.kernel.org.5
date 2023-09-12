Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C83879D13D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbjILMjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbjILMix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:38:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6FD26BF;
        Tue, 12 Sep 2023 05:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694522297; x=1726058297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E11vL+vKmGmqTBrCBKI+lUMsWSxGJAYLgvxq7xVynqw=;
  b=lFuxVYj1VbNorc6GEwaVTXBgoYDWVr6OK58LjfuqOn3yPqrqMsdHWzpf
   j57lcNAKykA2ajsW5kcXAb938Orvypv8qONmxhCJgaGOwA65Jr4nMqo8A
   8zo5D+/MEDrllQ/SztzutE/GqdvJVgro/QqSBO3fMrp5rlACXtMR5Ojmf
   PLdGYhN9ADk/1nTOQtQrggnGueY3tQlZtv6szvlOFCxxi7PZW53birhyR
   JXd+LgEXpUtAVQ+YC5carO/um7IhvRQuiRpsKZXceow7bE0aygYIXkoKP
   5QidexIxQy/fjMoix5J4JnUZ10m/fljAJRtyIE3NFQW/yb//ap31zflcR
   g==;
X-CSE-ConnectionGUID: EyUWy97gRbWOmegeCIWtEQ==
X-CSE-MsgGUID: vb0JJ17+QVOUK2cdjaCGKA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="asc'?scan'208";a="171179712"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Sep 2023 05:37:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 12 Sep 2023 05:37:32 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 12 Sep 2023 05:37:29 -0700
Date:   Tue, 12 Sep 2023 13:37:13 +0100
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
Subject: Re: [PATCH 6.1 000/600] 6.1.53-rc1 review
Message-ID: <20230912-boots-hatchery-d41b78c06dc4@wendy>
References: <20230911134633.619970489@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+hIUuOqW4OReJAQc"
Content-Disposition: inline
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--+hIUuOqW4OReJAQc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 11, 2023 at 03:40:33PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.53 release.
> There are 600 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Other than the already reported ufs inode build failure,
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--+hIUuOqW4OReJAQc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQBbeQAKCRB4tDGHoIJi
0jwTAPoCVRMBIUky80V20IOzliDT6PEJBg3Ox3SCcuKmY1qZ+QD+JWvwR2nlzF6e
P5yvvrU27M9zU72J+mdl9adxKaKcAwE=
=DpZK
-----END PGP SIGNATURE-----

--+hIUuOqW4OReJAQc--
