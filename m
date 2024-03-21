Return-Path: <linux-kernel+bounces-110343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C38885D7B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D7128489D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A558C0A;
	Thu, 21 Mar 2024 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AD1x6DeK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71772B66F;
	Thu, 21 Mar 2024 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038747; cv=none; b=QffborjNYGNCExVUjBz5V397y3AV63+2I1HP7RR7MHi8NfvZNl1VYwLis/XNJIn5XsspoD6t7QYVKx/YCeUsCrHpmQy+omxrCdrxE1hDifvDWR7ke3ejNHx4dPz8wIi8wqt2koTJwvrrna6SYvqnxodRn4JPaJYu8rUvgdE7JA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038747; c=relaxed/simple;
	bh=mK+3Pvs62TU5G1Vri5+8hmlP64mKLMFLa7J9BiXWipM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V9FXY/087AZX6hW44quYz84b0ZR6CK/VvKeGEcvD0EbBAQo9INKScWMEE1gSKqPB3dpx9Xg9xcwO1PdXjlClgv0co7Hs+Ku8LiOTCSDQIkCsigQAJ8hYDq19cCZO1+b5B42C16epsmPMB3/Oq9OCrnw1ZI68yOc5T1J3mGRhzP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AD1x6DeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F098AC43390;
	Thu, 21 Mar 2024 16:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711038747;
	bh=mK+3Pvs62TU5G1Vri5+8hmlP64mKLMFLa7J9BiXWipM=;
	h=Date:From:To:Cc:Subject:From;
	b=AD1x6DeK+wvIqOV7aU107c0kLovKJZpGbxpA0WpuaxGsxCxWgjJKNlYiGLJYqh+ww
	 BP61BUvDH6RlHesKUdxMrqcM6velZAq2rS6Jr8pv4hAxo6Hax555ACf6L+xl7BKr8a
	 Nrz67AGCghzEE8Z/zw1Fd6PZ2ihkqu0VONOlBniLPGhZidddA13azoQwLKFlU1teCl
	 kt7S5EIqHbLt4FE78cGOEcEYHS2BNmjA+CIsPR/OTRC1t1+JxmU8+i8C3CWD2VDALP
	 sl48zkG4lvBGBsFBEiFdeZXYS6LEZwp5Ued9UI6hvqnNq2a0rX+mRenrcR1e3PGMjd
	 7HIATVgXbsjZQ==
Date: Thu, 21 Mar 2024 12:32:16 -0400
From: William Breathitt Gray <wbg@kernel.org>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Julien Panis <jpanis@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, syednwaris@gmail.com
Subject: [PATCH] counter: ti-ecap-capture: Utilize COUNTER_COMP_FREQUENCY
 macro
Message-ID: <ZfxhEKdSi1amfcJC@ishi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w2HDcFP2klNv51j4"
Content-Disposition: inline


--w2HDcFP2klNv51j4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Reduce boilerplate by leveraging the COUNTER_COMP_FREQUENCY() macro to
define the "frequency" extension.

Signed-off-by: William Breathitt Gray <wbg@kernel.org>
---
 drivers/counter/ti-ecap-capture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/ti-ecap-capture.c b/drivers/counter/ti-ecap-ca=
pture.c
index d33d35055b91..675447315caf 100644
--- a/drivers/counter/ti-ecap-capture.c
+++ b/drivers/counter/ti-ecap-capture.c
@@ -369,7 +369,7 @@ static const enum counter_synapse_action ecap_cnt_input=
_actions[] =3D {
 };
=20
 static struct counter_comp ecap_cnt_clock_ext[] =3D {
-	COUNTER_COMP_SIGNAL_U64("frequency", ecap_cnt_clk_get_freq, NULL),
+	COUNTER_COMP_FREQUENCY(ecap_cnt_clk_get_freq),
 };
=20
 static const enum counter_signal_polarity ecap_cnt_pol_avail[] =3D {

base-commit: eca588187f9129300c6e44d64b819545cede463d
--=20
2.44.0


--w2HDcFP2klNv51j4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZfxhCAAKCRC1SFbKvhIj
K5xwAPkBjIwCWKw+ZwItGL27bZ6jmnPofDeQZ7m786/wI0cPxgD/etpNvdOgOKrs
BiWtA9nhamXG6oAEq7hAjp2chz5WgQA=
=UG2X
-----END PGP SIGNATURE-----

--w2HDcFP2klNv51j4--

