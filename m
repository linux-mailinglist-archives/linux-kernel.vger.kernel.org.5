Return-Path: <linux-kernel+bounces-104825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CE687D434
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF2A1F223E5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6B2446BA;
	Fri, 15 Mar 2024 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goldx2yJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E248350A6D;
	Fri, 15 Mar 2024 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710529044; cv=none; b=EE/jls1K6wrk+/ELqD57MVgCLutdYrAxNhLuSOFsyi+U4worbs3Mhd6oIC+c7Tg3KE7ny9KTXrA9RgrPXqOrb5UNkYm7FuD/aqPEWG8D3i6kD8Y8K067+fFr+PSMvwdZagmGPzohD+PgqqOIC76QvuID+mcche0+vgiQ+xt4j4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710529044; c=relaxed/simple;
	bh=MQsyypS81JO76TfEPPZx9mOuORO7zteKR/F9MRkApbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pjXmKLUWguPZm8WfWoB19fPQDwxTUgvrKhWP2HLrrAyIOs/M0nal2OYqF0WTykxSRJDVFhABg92nYmhwnpKl0GtSBrD7b+0TWm/cNqJUG2dBk/lKuoiR9sKNd5tAX1FzSNQaM5FWHXD75q2VuUYj964gg+w24GRA1r2+e4IcOfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goldx2yJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FDEC433C7;
	Fri, 15 Mar 2024 18:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710529043;
	bh=MQsyypS81JO76TfEPPZx9mOuORO7zteKR/F9MRkApbg=;
	h=From:To:Cc:Subject:Date:From;
	b=goldx2yJFjCUs/tDH4ECoNUJmkjO2nceZWOQXLpByToYgd8WxWDWTMvFxxyCN+pUt
	 /0dNRNQZ5y9gh4ttjUB9R+4KwLHghUc0M42NH3NiDzspPJmqI3PDABthrQtaFOdqrZ
	 kyEVsm9WzgW2IUpAgHHgFHlUH8YEIhlLWLdHN8acKIVhr3BDu0EKGzbc3GwaeBfM2/
	 NhO/sDGAA6GsJ1TT6Z/DhiZpNBpeI5avctj+BhMFR9Eas+jW7VR+L/KKr/+/CTdhKO
	 ja5/+adYMLXaMOdC2Z+Cv7UdY2NKm4+CfDCV41gs0CqNBhSDkY3c7eAMnpShwOEJiY
	 74O3zZd3cmKVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Linux 6.1.82
Date: Fri, 15 Mar 2024 14:57:20 -0400
Message-ID: <20240315185721.1842266-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I'm announcing the release of the 6.1.82 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
        https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary


Thanks,
Sasha

- ------------



-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAmX0mg8ACgkQ3qZv95d3
LNzr0xAAsq7KbI+iOpJ1QUuNbFVKuk5d4BrzhtVTe0GwwriKWPO1Hz8/7OuKyORr
OmiWYs3rT6daI0n2lAhlF9o4u8A30n8Vu6EVcUklNOjZULH1kzLjwHFg48moKc9c
Dieio0QAkkjkF3SfSghUI3/CjhLhmQqAcvXawkYEEG+SUIpXLWnJ5iSf4Gf88SvK
GV9Kr4Y0fdZZ+5hCxo8BurIsnDCjewu6PLaMSfUbkMEsH8YQkjjo4Owvidx2UwJZ
AohRB3/xjpZd3kzEeWo/l+GkQyxBSV0BpDvyTHl/vEepm1G1469Fw+movBFFGOgX
lo6Mac387PpJAsTZfuG8w/HUBd/Qsqr3Ypr3K6bEvD7I0zJXwRZLfpedaoKz43yQ
nAGDJ/RXJdqhW+N95sEtvJm5HSCErZqup6qHUx7pht1Z+QQrgSt7GjPFGSV6w90v
ZAW77AZND3xlt746hbz2sXBxlMB7N9yy6rMN0ON6QDzj9RZhQUCBePqdOPXgZkU4
ics5pqXbFtK6mAXgHWK97IXaFEcxjgjJiaKiNNcPrUq0wveANzfYB/5oaXhNph+c
cmcL+/OpekamoA4MB90BQ3l/PfzaBofuYBLMjhGBBi/da18H0KdRbR7pWqDwI2iY
tF0FuT9EsirSITxXu5LCcQJYPY8FmQXeVs1CjlrRd7m7Ev0nRSo=
=0dE0
-----END PGP SIGNATURE-----

