Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988F9803301
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjLDMiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjLDMiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:38:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751FFC3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:38:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30EFC433C9;
        Mon,  4 Dec 2023 12:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701693502;
        bh=yqaR6ErWHcshvm8N6QI3ct1mVUW7AZz/LWvjQ4StwVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fNDZesLDtBLB2L1RV/aHfUQjfHfL4TVTLkgiDAJCuUT/8/odnkovPAHHSudBFPJ2c
         Cc5WI3rpUcAhe9RZXTngZR8E6Tu64WSzuASNeEqMRQAqRUNquXNdfRWnP67md/QWhk
         dIsplNbK5pioHaVQVzH2zV90KfGZ/wq+++awwYCFUwFNLkZnzK5fiBTyf6LJq+KmTy
         qJR/94hvBpFEbyg4R6ydXqNOQ93QiAD29Ipbe34GoVij7Tgl0gLI4H6CnznFFSwhIu
         jzEMCEUJ12DVEEqEyHEXY78rjIgAExBR3PHvkUzP16G9yGOcDARkipIckP5JjLlMgJ
         cVeere0t9pmwQ==
Date:   Mon, 4 Dec 2023 12:38:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kunwu Chan <chentao@kylinos.cn>
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com,
        kai.vehmanen@linux.intel.com, perex@perex.cz, tiwai@suse.com,
        chao.song@intel.com, kunwu.chan@hotmail.com,
        sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: SOF: Fix null pointer dereference in sof_pci_probe
Message-ID: <7ddeea58-f5d8-415c-8c07-c34be04d6a9c@sirena.org.uk>
References: <20231123155424.1275919-1-chentao@kylinos.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d0eSK/GLwNSV2WiC"
Content-Disposition: inline
In-Reply-To: <20231123155424.1275919-1-chentao@kylinos.cn>
X-Cookie: no maintenance:
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d0eSK/GLwNSV2WiC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 23, 2023 at 11:54:24PM +0800, Kunwu Chan wrote:
> devm_kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.

In addition to the issues others mentioned this doesn't apply against
current code, please check and resend.

--d0eSK/GLwNSV2WiC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVtyDcACgkQJNaLcl1U
h9AkMgf+L+6WbJTiUIc2x5NzzC90SYhe4VZkSX5nDk0tim8631mq3u/Aw5PYWYlQ
J/9yRTpDiNAhPHYBNBQPFPw5h+OtXs+9kvhmsOZUim018b7sohjzXr9Y0p8C4yAB
zWL72CrBEGjPyw/jZlUQYsPl2Jfeuudj/MQwVKbtuXeLgbJbAdpmjTV3dOqaELXw
SHENzHmSVx4GZlvNVVi4u2IO24v09WrjM+HpJRW/amFmSwq+jV2A1cnt/LZpDbrO
p2rAlxXqOnjy1ciPBhHFhZ63js4ciuvpKYZa6bSBkyH6+zNzT+WViYnrKqwLLqYD
QFByAyqvfoNzyEqIPZcRtevmf+5QMA==
=8sV2
-----END PGP SIGNATURE-----

--d0eSK/GLwNSV2WiC--
