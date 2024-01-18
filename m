Return-Path: <linux-kernel+bounces-30378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69152831DF0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF731C215AD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D4F2C6B2;
	Thu, 18 Jan 2024 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBv+6YGS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7CE2C6A9
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705597011; cv=none; b=saN3LiYEmzn6pI70GICdZKnoBqle+LaTdhGcCCEVq2VCj+Ed9wJgX5fAWv/9AkJk0MXNB0MwmZaioQNt6bURmPQzyP6xyZGflBvmhiVEvfnKa1IC2sKiX/aMgDNPdQVGq9IF4Th0GOE9PKmD4gEi0zQ2+r6Ioz/B7lfBRhYJm9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705597011; c=relaxed/simple;
	bh=i0+PO05nxzYB+FMpafx1EvTj35bmTeJoY9f8afOs9mc=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition; b=MQAZAlzQ8l4zlCqMxS0ePFxv3gteDVZetuBI70vn+jDAz+Iz5v9APSO9wyKS4j4KVBgDhgECVwpw7dJBjiDdr42VF+5GVisTEEQA9pQ+A3jn+7pWRzmAvORRQpgKdoLXIsxZCa2GIyzUQhnElClXcs2cxeRVdAwKpRAcAv684fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBv+6YGS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17BDC433C7;
	Thu, 18 Jan 2024 16:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705597011;
	bh=i0+PO05nxzYB+FMpafx1EvTj35bmTeJoY9f8afOs9mc=;
	h=Date:From:To:Cc:Subject:From;
	b=mBv+6YGShdVCrIwAqjja455ngKl7aQcHbR0eeofIMOtRVzxWcYDfknCtzeLj2V9L5
	 5MwZcFuARoKynAADDzbAfB96yw5Viy0jbUZpXlO7U75Nde0rkuTvlDl8rf+Uwjg5eB
	 Q9us0pDBq8SoWut1HlfGXf39vnsf4Jbdb2xuyg24U9A82qcdpUN7jVS9NYeyYJEKw6
	 DydiGurQ/+it2tzjo0wRiy3vr8CsLmJtqrcRqnxlO8p1M8OwM+QGvi9JHL8J93zXhF
	 VWnfjRteVBntLbTPNNh+BzZscP80rsdEO6du7lMuVQqJrKoSZnRcXSSJYZMM+r/0vW
	 X0hsoigKkcPNw==
Date: Thu, 18 Jan 2024 22:26:46 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Soundwire subsystem updates for v6.8-rc1
Message-ID: <ZalYTgul-JeuE9sX@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bGG/5xay50qMGxi9"
Content-Disposition: inline


--bGG/5xay50qMGxi9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Heya Linus,

Hope your network gets restored soon. Here is the pull request for
Soundwire subsystem. Please pull to recieve one core update and couple of
qcom driver updates.

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-6.8-rc1

for you to fetch changes up to becfce5233a78956654f36555f1b9187f8d11d56:

  soundwire: amd: drop bus freq calculation and set 'max_clk_freq' (2023-12=
-18 18:02:10 +0530)

----------------------------------------------------------------
soundwire updates for 6.7

 - Core: add concept of controller_id to deal with clear Controller/Manager
    hierarchy
 - bunch of qcom driver refactoring for qcom_swrm_stream_alloc_ports(),
   qcom_swrm_stream_alloc_ports() and setting controller id to hw master id

----------------------------------------------------------------
Bard Liao (1):
      soundwire: generic_bandwidth_allocation use bus->params.max_dr_freq

Krzysztof Kozlowski (4):
      soundwire: qcom: drop unneeded qcom_swrm_stream_alloc_ports() cleanup
      soundwire: qcom: move sconfig in qcom_swrm_stream_alloc_ports() out o=
f critical section
      soundwire: stream: constify sdw_port_config when adding devices
      soundwire: fix initializing sysfs for same devices on different buses

Pierre-Louis Bossart (1):
      soundwire: bus: introduce controller_id

Srinivas Kandagatla (1):
      soundwire: qcom: set controller id to hw master id

Vinod Koul (1):
      soundwire: amd: drop bus freq calculation and set 'max_clk_freq'

 drivers/soundwire/amd_manager.c                  | 12 ++++++--
 drivers/soundwire/bus.c                          |  4 +++
 drivers/soundwire/debugfs.c                      |  2 +-
 drivers/soundwire/generic_bandwidth_allocation.c |  8 ++---
 drivers/soundwire/intel_auxdevice.c              |  3 ++
 drivers/soundwire/master.c                       |  2 +-
 drivers/soundwire/qcom.c                         | 39 +++++++++++++-------=
----
 drivers/soundwire/slave.c                        | 12 ++++----
 drivers/soundwire/stream.c                       | 10 +++---
 include/linux/soundwire/sdw.h                    | 10 +++---
 sound/soc/intel/boards/sof_sdw.c                 |  4 +--
 11 files changed, 62 insertions(+), 44 deletions(-)

Thanks
--=20
~Vinod

--bGG/5xay50qMGxi9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmWpWE4ACgkQfBQHDyUj
g0fE8g//TqqMf/ZCmJ9T4PX1RrHTlWkHSSP8oDM0a3zUxDj+liJGo506hFenApa4
t71VBBjdUusr26fSisok/tlQAuhf7OdPYSz/yd0STJSC4/ayh+lg//hDMqqlhKi1
h+DQqnHKTPctYlozOjS9aY7jfbUv3X8wh1hvCgou/vCDLqqxydhsh/GytkSn+uYK
Hwb3JgnohZNWinNK/1/RQcbPmpbf1zTdzO2IShEXsMKSUk2YHz+xm5jcgW8CuJN4
VYyJMbBcLfaki0ez3xHKD4R0FxoJKdUMutwkqEzJGr5H5k1zDR2n6ofoR+rg8Spj
kaHKVeKUBE4n8zzB+gfRGJCY0jsBFSdfCp/cI+ox5EfTqKy/kvXkotlteeM9iygE
gGW/I+kldzpm0tvp7N4CGZp8sipurT/wfuOJ+PgPYy+39gaeRT/BIrFENLhR0dRX
ZJGPWw6wF9HVn/EjM7Tfp8VV7Hmg+wdoTAckcx0V+L+zBZIMtZZ3jrnnIDz7WSUF
aJ0mHKS+H6UR11u1T16YsEiEgpSeeQF4wfUGjQsV67RhSBS+t7Z+GpeL4QaZ8ysT
eCZOccmFBAuoS6MitnN09EMHtGqkSchfn5NcFW8vNSrOpXH0mT1zXTwEkb94IFjL
GyWmJeFQmfjH2X/pfHjqvgseHnsQ2+95EM1mHHDz+4IjxneQlVY=
=5FNp
-----END PGP SIGNATURE-----

--bGG/5xay50qMGxi9--

