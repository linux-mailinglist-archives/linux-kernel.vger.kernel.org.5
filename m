Return-Path: <linux-kernel+bounces-104324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE2E87CC31
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A522810DE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D4D1B7F9;
	Fri, 15 Mar 2024 11:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+pLQ5aY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D2D1B7E1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710501567; cv=none; b=KCR4VjBVdSP90R9fHObN5gTKcxDipE2NCiBWJjOiGF0ItNtLFpcofVfmE4bfiPOvTBI9tC3b+WjQ+9OsELFFIdYyi6ANjD73/Yj4p4DtWzFLx5B/7PrhGwU0YoAIuJznnpySurE1Oy4969DFtKwtne008+uhVei1Obp+sjqnr4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710501567; c=relaxed/simple;
	bh=Y/BQv7bz1TuPZ2XSnLradRyziOsAUzK0nrATY2jo7EY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lW1gwz0i1skOmeF02rulejURlWqixfdYXckZ6ukVc/RidlxNI58y+aEiThW+B48ZzFJVhvmrWEW8vwr0ZjQ13B62d1uQ3k4q19d90Q/YzyaqUdqO+oPRA5ttkJz10+tIPAt1ZAA6Nwqk8+ZlrRDoYDs704G+AYgKMBhsYpQN2R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+pLQ5aY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BAAC433F1;
	Fri, 15 Mar 2024 11:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710501567;
	bh=Y/BQv7bz1TuPZ2XSnLradRyziOsAUzK0nrATY2jo7EY=;
	h=Date:From:To:Cc:Subject:From;
	b=o+pLQ5aYxZ0b9jyEeIAes48zOFg+N/UY+9nl6l71skWBNLViPm5iPoKqdGXoT1DJ8
	 EML/CEWWMRygwJJEJ+KiRSwswf356H86FEHXfRTJEBcHx5LbNdMZiWY3rqNYVBqoz1
	 JQsQLXGk9vi12h5ZuPTX6MU80gZ/xXsknpLA6in7C8AzA+aYInRqjj4a4HmqJKfLgW
	 UwgnbSLKgqI00IulljqNLmgtz22ZrRimYdWI3vT/LRgfREoMbC1t2XJFnXhHtAXfxn
	 nR3UaNkTl31i5WlPPivis4kE9Xe9s+HtfyGEneWcHlQq7XIM2NDCR1P2pJzjOpJD6K
	 7zII9ZGb+hTZA==
Date: Fri, 15 Mar 2024 16:49:20 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Soundwire updates for v6.9
Message-ID: <ZfQuuDU8DDxdU9y8@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G97PEePqAOkNECFV"
Content-Disposition: inline


--G97PEePqAOkNECFV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive this quite small update for soundwire subsystem.

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-6.9-rc1

for you to fetch changes up to e17aae16acf53938deb4b7702aa4f6cee2c4a073:

  soundwire: Use snd_soc_substream_to_rtd() to obtain rtd (2024-03-03 19:29=
:28 +0530)

----------------------------------------------------------------
soundwire updates for 6.9

 - Constify sdw_bus and sdw_master_type objects
 - use of rtd helper for better code
 - intel aux device remove redundant assignment

----------------------------------------------------------------
Cezary Rojewski (1):
      soundwire: Use snd_soc_substream_to_rtd() to obtain rtd

Colin Ian King (1):
      soundwire: intel_auxdevice: remove redundant assignment to variable l=
ink_flags

Krzysztof Kozlowski (1):
      soundwire: stream: add missing const to Documentation

Ricardo B. Marliere (2):
      soundwire: bus_type: make sdw_bus_type const
      soundwire: constify the struct device_type usage

 Documentation/driver-api/soundwire/stream.rst | 4 ++--
 drivers/soundwire/bus_type.c                  | 2 +-
 drivers/soundwire/intel_auxdevice.c           | 2 --
 drivers/soundwire/master.c                    | 2 +-
 drivers/soundwire/slave.c                     | 2 +-
 drivers/soundwire/stream.c                    | 6 +++---
 include/linux/soundwire/sdw_type.h            | 6 +++---
 7 files changed, 11 insertions(+), 13 deletions(-)

--=20
~Vinod

--G97PEePqAOkNECFV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmX0LrgACgkQfBQHDyUj
g0e/eRAAxKxtlMyM1Do8CmR6QX4PAZr1t7Nz/+V5atIQq0LH2yKPYCBq6TbYJSyU
2/PRuD3Or4UWsrmHm42Q8pqCnPB9LrDVAeJx8dqW3TFGs4x9nmF0bZwmb0oKghSW
uwWXJ66/AhQ6jTV6Z46ysWB9/nQDkcPKroJRIYEHgFVpDCwCM4ZgVzlTnZteMzCx
NPQVRm6s2kfHqCp75ltpTxrupVXPNtCP8jBcL0uS9LxRfkh+B/BA0XHqTKw3lYz2
j1NmRTgzMVgN5YPy5e+71GSZakJaQ6+5r/jBrLjYjGJuMZK6hB2gweX+5pZvjMdY
9fQnJS2eagOOfiFrVYQrbZvvf6Zf+2uw6dYKuJFa9UeJXsG7enxmkel9xP+WSq5S
s4Emyh2lSSsd4QWfT8u+KOnlcfg9zGYdgJ1YNH74sVhSVW25cziQ8ddn1XA1yg8k
dWMqCt24H6apNtDxG6QVBue/QYTtVx+A5IQPSfInVVRFhTgp0/+d74uyD+6V/oAb
TkMrnSixG3TXmb4isHd1ewg5pbot1Ji8L2yLgjf03FjDMMWL3AQSUv6AuLopbQpx
0r7VJf8hmZd86Sy5Ph3f7FbdpTvjNxnew3P+wi6MZMakaKpdNjKX095x/EI8HnuR
0ZRx6SoVecsKJ1ZOZIERIcVtfo5hEbTik9aGwZgzAACAwptpKUM=
=QzSU
-----END PGP SIGNATURE-----

--G97PEePqAOkNECFV--

