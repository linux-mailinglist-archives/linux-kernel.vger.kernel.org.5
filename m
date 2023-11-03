Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32D77E0507
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjKCOwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjKCOwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:52:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9BED57;
        Fri,  3 Nov 2023 07:52:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2EBC433C8;
        Fri,  3 Nov 2023 14:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699023124;
        bh=4bHaoYOS4B9eXzOUxbBMi4UFw6BQf47ZMRIEzv/wmGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H/hhCnHgvk0wtt4RmBnnVGvhZ2iYuOefHbOYtZ+3xY+pocEj9jM8jbswuiz4f8sM9
         0HpfMQTmAc18HxjUgLduXc3eSh7JTVyDL1OvR7m/gSsWcI2VdJUd7EdVNY4w/SdgLj
         GAyk3x6O9spbV+q0EdkVG7HU8Md5a4TgMxTYZ7MarmdUQmXPBxm8+jImSh6AonzGMn
         4MsH7LHsUTi5khe9KkkYyD8bu2yOw2XyR+3sF++K6rtGxMJRAjFzqsVGsVNKziZXmj
         OSlSVhk5fIYKWMwLhKU6rnq5mlo/WWtRlBHpylWmme/Fx8/at520Z2eKx8T9a7Irla
         EnxIPPzaFifxg==
Date:   Fri, 3 Nov 2023 14:51:59 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Erwan Leray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH v2 3/5] dt-bindings: spi: add stm32f7-spi compatible
Message-ID: <20231103-appendix-emission-952777ef7c4f@spud>
References: <20231102193722.3042245-1-ben.wolsieffer@hefring.com>
 <20231102193722.3042245-4-ben.wolsieffer@hefring.com>
 <20231103-recognize-unwashed-b8f1a83fe851@spud>
 <ZUT1qFieeCby9ALg@dell-precision-5540>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tTMlnMyASVIYvi+Q"
Content-Disposition: inline
In-Reply-To: <ZUT1qFieeCby9ALg@dell-precision-5540>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tTMlnMyASVIYvi+Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2023 at 09:29:12AM -0400, Ben Wolsieffer wrote:
> Hi Conor,
>=20
> On Fri, Nov 03, 2023 at 12:50:53PM +0000, Conor Dooley wrote:
> > On Thu, Nov 02, 2023 at 03:37:20PM -0400, Ben Wolsieffer wrote:
> > A wider range of supported word sizes and some additional buffers,
> > implies that the F4 could be used as a fallback compatible. Does the
> > register map change incompatibly in the process of widening the FIFOs or
> > something like that?
>=20
> Yes, the F4 has a single bit to select 8 or 16 bit word size, while the
> F7 uses four bits to select an arbitrary word size from 4 to 16 bits.
> This series supports the packing mode, to allow sending two <=3D8 bit
> words with a single write to the FIFO, but even if we didn't want to
> support this feature, the F7 would require setting the FRXTH bit (not
> present in the F4) when using <=3D8 bit word sizes.

Oke.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--tTMlnMyASVIYvi+Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUUJCwAKCRB4tDGHoIJi
0uZNAQDaM89wVrUomad2qB/scux1aTsV0078OLOhPo1oBRJU6QEAreeGymSr+62N
2wgkvW+8zNqVcQ2CZILtHMikzYCVbwI=
=lzfn
-----END PGP SIGNATURE-----

--tTMlnMyASVIYvi+Q--
