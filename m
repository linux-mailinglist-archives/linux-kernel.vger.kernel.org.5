Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB48B77CD4E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 15:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237437AbjHONWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 09:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237436AbjHONWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 09:22:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179EB1999;
        Tue, 15 Aug 2023 06:22:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1FA061DE8;
        Tue, 15 Aug 2023 13:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06487C433C8;
        Tue, 15 Aug 2023 13:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692105720;
        bh=6gwrYMWXK3O5GI5wZp2ZWHJatKNKZm9nhN8zdC+j9DA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iQPQdEKdqIn5yY2ofQrGK/iYsG1+GoycFRHnGojiEkwq7VSjW3gQ8Ysghvnpva/+p
         gwPEfRDCa4y56ev6Y3u4M3COn2/PaCFbFcEkOBRGPdMsBLi/gJ3Bt8BwXblxfAFqCx
         F4LlxCQp6OSGRNvg9Qa6l8nmAasYQNp9p9jkCtKfxkqN0rdLudMi0eqXSQ87EjBODy
         J8qasvdXaKOkhBs9YcnrELT0lFdpKUCQzYxOd4Wi788qC46H6pgQneL3JcAc/LlN3O
         7rvKpSkQ3PKspNS64gxE2JdDxN95v2RwWUKl8YXUHtW3Yd3BceOdbrCQGGL1cNvPi9
         19SaGcSit9NVQ==
Date:   Tue, 15 Aug 2023 14:21:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jiansheng Wu <jiansheng.wu@unisoc.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yongzhi.chen@unisoc.com, xiaoqing.wu@unisoc.com,
        jianshengwu16@gmail.com
Subject: Re: [PATCH 1/8] Spi: sprd-adi: Getting panic reason before reboot
Message-ID: <f2052796-3eae-41de-b7bd-f3deea6daf4f@sirena.org.uk>
References: <20230815023426.15076-1-jiansheng.wu@unisoc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Eib48hxLPm8RPHzS"
Content-Disposition: inline
In-Reply-To: <20230815023426.15076-1-jiansheng.wu@unisoc.com>
X-Cookie: Darth Vader sleeps with a Teddywookie.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Eib48hxLPm8RPHzS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 15, 2023 at 10:34:19AM +0800, Jiansheng Wu wrote:

> +	if (strlen(reason) < PANIC_REASON_LEN_MAX)
> +		memcpy(panic_reason, reason, strlen(reason));
> +	else
> +		memcpy(panic_reason, reason, PANIC_REASON_LEN_MAX);

There's length limited strcpy() variants for this.

--Eib48hxLPm8RPHzS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTbe/IACgkQJNaLcl1U
h9Cxmwf/QqL+A9PeU9vxeHIhQsgEdTaaSgiUue1tUfzSxS/LqdyQuxixAX4DkDA0
mCEdtXFQqF7+r287ZURnKKL4mJDFl1IoIxD+JnAB2RS1MiVnrpynTOpsAcNjrVNy
cZ6gzjENM2yAclXUAjG92eAEoybeA2yCd/vS7Ir6tMSwHSFzI/WT8C4qMvPBL/ZL
zrocLzMZSpoTVJj7K8cIFoyHR9Znc9AGATM3Z38ttVXXfdJUeZrEeZ36ppUhUXlP
mSBqu/9ctprybUApePhJdHY71rsH7mg6SOgU85di861JIhIk0GrWzuhwB8/lxex8
7C1NuC+9eRRDf8Iwhv2dzOZJWbPAWA==
=cNpz
-----END PGP SIGNATURE-----

--Eib48hxLPm8RPHzS--
