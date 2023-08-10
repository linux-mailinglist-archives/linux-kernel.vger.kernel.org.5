Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4E7777919
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbjHJNGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbjHJNGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:06:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4711B2698;
        Thu, 10 Aug 2023 06:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691672796; x=1723208796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YhVLeHe7hIFvREZYFRzYBtmlRfE8xXBsnawNuJxDi3c=;
  b=c+bnVuPN+by49YNRYOn1T8Md9RlZTBZHQv3dRfiqiWWsGaBmIgpofygK
   UtA6AGWphckknv7eS6kat4CBpgORgxLx7rJJC3MezxXBjpCC5ZJolojgx
   nu5LuRNXLTT6DIXmmVMG+021k6JX/XjH25ECLKjzp0InK2BZM7taqBcHz
   n6+8yxtQuW2euYpXIz6jmQiRviWyCHKSiCaK83jKKavXSVugr9gIBJiA1
   lZGZhrPt6E0NpHt88js6tSb0C+6GWBOrgFD9vwGsOsWaFD4lF4J0g4FEy
   vSOHXHMvWC6TXNnaE7dYS8ed/RJdjegvjT8z+jvgyFp97h4AQhvj0jhgq
   A==;
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="asc'?scan'208";a="224802819"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Aug 2023 06:06:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 10 Aug 2023 06:06:34 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 10 Aug 2023 06:06:30 -0700
Date:   Thu, 10 Aug 2023 14:05:52 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Md Danish Anwar <a0501179@ti.com>
CC:     Conor Dooley <conor@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: net: Add ICSS IEP
Message-ID: <20230810-wise-mousy-8841c8880353@wendy>
References: <20230809114906.21866-1-danishanwar@ti.com>
 <20230809114906.21866-2-danishanwar@ti.com>
 <20230809-cardboard-falsify-6cc9c09d8577@spud>
 <0b619ec5-9a86-a449-e8db-b12cca115b93@ti.com>
 <20230810-drippy-draw-8e8a63164e46@wendy>
 <593b3505-9c1e-47e6-e856-f299fc257fa8@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lQFFhBRnHv9kDzPj"
Content-Disposition: inline
In-Reply-To: <593b3505-9c1e-47e6-e856-f299fc257fa8@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--lQFFhBRnHv9kDzPj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 06:27:22PM +0530, Md Danish Anwar wrote:
>=20
> Sure Conor, I will remove items from the last one and make it just const =
like
> below. Please let me know if this is ok.

Yeah, that looks okay to me, thanks.

--lQFFhBRnHv9kDzPj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNTgsAAKCRB4tDGHoIJi
0qKdAP9zF9maVrY4ug5wrMq10xgDfH9HIUNUkVyNZtsiVQAJ8gEA02aF5QxHHj/S
/GpcJBK9yWb+MPymVq1kN8VFnt1SNgQ=
=fNDU
-----END PGP SIGNATURE-----

--lQFFhBRnHv9kDzPj--
