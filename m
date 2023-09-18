Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE2D7A4A32
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241316AbjIRMyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240541AbjIRMxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:53:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E691894
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695041613; x=1726577613;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AgeuhM5mFwcMMECK8wJlIRxhS3GYSuQUFHTrOyyDThM=;
  b=MiB+QoKMAqbyYfEqvvB0ZhzVCxBdtQezuYKl19PFnVKZb1z9pkZ1gRn/
   y9pUZWeIrdTUeP93jz2fa12YiPTqw3AZOaIa9b3TB+DTctNWRqxKP0DaM
   Bzop6Z+gqEoY1LZ6ghx6AMOjTawtK9B7LHsd8sKRC5dCLethNkxThKle9
   2iRmOdhCpfILW2URFd0BiXzpo4MO07UaR3e9NrZLgUoRnms7uyQi2vGXe
   eBfSr9nAYDaTCyLQ+2GTDlU8nYUPEDulryiNfzwaGd6szT5Q3fhwuQyZE
   /xyUqcobwnPZ2PEU7r8VMylJhKgylafjZ0P/GR+AeK9AF3AtCdacdZ9xn
   A==;
X-CSE-ConnectionGUID: jK+nVR2nQ4WzZmMpcAzzfw==
X-CSE-MsgGUID: IsmlXUQvT1iYP6FIUritTQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="asc'?scan'208";a="172211731"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2023 05:53:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 18 Sep 2023 05:53:32 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 18 Sep 2023 05:53:30 -0700
Date:   Mon, 18 Sep 2023 13:53:13 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Yu Chien Peter Lin <peterlin@andestech.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <david@redhat.com>,
        <akpm@linux-foundation.org>, <alexghiti@rivosinc.com>,
        <bjorn@rivosinc.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ycliang@andestech.com>
Subject: Re: [PATCH v2 1/3] riscv: Improve PTDUMP to show RSW with non-zero
 value
Message-ID: <20230918-cassette-exclusion-b2ce53745a5c@wendy>
References: <20230914014027.273002-1-peterlin@andestech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KvF02Mytm4H6tWzO"
Content-Disposition: inline
In-Reply-To: <20230914014027.273002-1-peterlin@andestech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--KvF02Mytm4H6tWzO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 14, 2023 at 09:40:25AM +0800, Yu Chien Peter Lin wrote:

> +		val = st->current_prot & pte_bits[i].mask;
> +		if (val) {
> +			if (pte_bits[i].mask == _PAGE_SOFT)
> +				sprintf(s, pte_bits[i].set, val >> 8);
> +			else
> +				sprintf(s, "%s", pte_bits[i].set);
> +		} else
> +			sprintf(s, "%s", pte_bits[i].clear);
> +

just a nit, but checkpatch in the automation is whinging that you have
forgotten to add {} around both branches if this if statement.

--KvF02Mytm4H6tWzO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQhIOQAKCRB4tDGHoIJi
0tKoAP48Ts2kKoZnvEilgWMNNrGpn0bLVHjbJMaW8cCYEiYjUwEAo0VTnfi6Wo9O
wMNL4/Pv5uXtN6D5qqiXcogp6SzxIg0=
=xIw+
-----END PGP SIGNATURE-----

--KvF02Mytm4H6tWzO--
