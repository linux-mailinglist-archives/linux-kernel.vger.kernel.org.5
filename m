Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37987AA058
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjIUUgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjIUUfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:35:03 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BFA720F0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=k1; bh=+7fr
        VW/EA2FucdgctrPyCcxInO39RMXQVCUCGqYahyw=; b=fi6wRJyXpfSTopRjlN8A
        /re6PvcuVA8q5slJ8xEOuW+YEvbHgkJXAbybT2PfvMzRrUPeE68ytSc9JKTCi2Bg
        fpnBTp3sEUQezwyze9kkDvaCoyuUVvt0glbAwn4B5wR19D+QwbUq8JAuQdcxI6FO
        yyzpUz3iJ+EdFZlathsKPNCaxfkVfxa64cFMDLkERetxdUXJwpkiw7sie4Fq74fh
        cy1aCDS5BWHMso1VNIgeszYNOjO5ismyXLzNxzsfQ++DBvoqRu8BmRv1iRehO7AQ
        lmMCenyhDylpiqOEWnOV+lTeDtham3+SQxfEZ80Ef9/Z6cQDwfcaRrad8Kgs1jhW
        tQ==
Received: (qmail 940443 invoked from network); 21 Sep 2023 14:04:51 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Sep 2023 14:04:51 +0200
X-UD-Smtp-Session: l3s3148p1@Y6CTTN0FzVEuciJ+
Date:   Thu, 21 Sep 2023 14:04:50 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/6] serial: 8250: remove AR7 support
Message-ID: <ZQwxYgMmiSB4snWV@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
 <20230920201035.3445-2-wsa+renesas@sang-engineering.com>
 <a86483c4-9ec2-3435-198b-9773379c67be@linaro.org>
 <ZQwl+OXvhA6/x6f1@smile.fi.intel.com>
 <1165e159-62d1-4abd-88d7-b8eaeaf797df@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zJod+rvIGEhws/tS"
Content-Disposition: inline
In-Reply-To: <1165e159-62d1-4abd-88d7-b8eaeaf797df@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zJod+rvIGEhws/tS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I don't mind either way. But likely we should reserve the field if we go and
> remove it (setserial has a number->string mapping in busybox). Hm, then
> reserving it or keep it? Perhaps keep it is better... So ack the NACK :).

Okay. I will resend with this number kept.

Thanks everyone for the input!


--zJod+rvIGEhws/tS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmUMMV4ACgkQFA3kzBSg
Kba6vA/+PbZ12dycNI4z16sTpu+RYeA2+TirlxorwkHZSMps0Bii5DcNNgVFsObd
WwtzMeOPw3pcKOPil8DdFTnetXqVwfrELQkyX4CI/v6ncCcG1uCjL5ap2IqaJuYu
CVEHCDaeJdWvsHrpbXDYkCmLoOdJAl2IfQNXwso55jR8K3GwN+jmQsUprZRC+An1
OxE4Bghyz3izoKPNL1xCxgL4LTTImXVkrrN86Yac0yRCdeJTMwoAJ5N8oRnaK6Z3
D41ndagstgt6FSQEB3VmeQ6KcpUKU7flZ4fWER7PPND2sM8kskArfdpQ+q+jKAg8
4vuuCSxb6XrO/hZV1pDKw61fKTlhvJxF58V4Hm9OZTDX7kOA/t25zMqXW44SfMeK
gU8KnFkIjTIu7mf6ieS14+fwzFL6gA8vsveUleT1/1f6CY4VlpwKEPA0q3zE1ATV
r6XoV+AaHUm5usMj+yo8KLaoEnRfWJ3AoDegsYVRVnYjT0mxTfB8Ma8NzD9nZUuI
I55JmrZUiMMYLIH7VEvuh3CIk2KPBm4qpkA+izVANdjeDE2Ho6PzJ3FvdhksB2X9
eNHtiChGu87DkfhpC8j1GCOQb8QN2hMDAGtyxhanqUIxxBVJk0blO7jnqUqkvaMe
G6/EPEMOuJpxYDwVj01hCS4kmLQ7reDzR98YwmkQDBSJm1L+d7Q=
=Vav2
-----END PGP SIGNATURE-----

--zJod+rvIGEhws/tS--
