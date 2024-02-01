Return-Path: <linux-kernel+bounces-48911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFD684631E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2549B23CBF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E543FB2D;
	Thu,  1 Feb 2024 22:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UomVBqi0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BD53F8DB;
	Thu,  1 Feb 2024 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706825164; cv=none; b=YH0QNELIu1VvHfoFsLZrS8qulXgJLvc4O09RFhomOYBZ4YfF8i8oAt8frKr2Jq1B+vHObX0kYIbImVvlWWc6+mFovS2/e8m5Q3xiexRdiyKSUXZ2Qe6Toj+idzBFNvD/C20FxQ0ANmmeeGha2Tgf9cbfA3d5PvMnXlCLNxt9Q5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706825164; c=relaxed/simple;
	bh=gm39k00fXSJe5GlQK5AeCq4vRl3BvQqkpLTuncjtNyE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=eRpPcozx98BDJoR/n0KJ9eWvO8wNyJa8h33vF6EhD6POEb5DrMjRMjz6LgUQ6Y1S1C2uj/P9tUtN6EkDUl++OR/0qqtPpUXcfzAyASPOt2e6UrNdDyio/KJDpXLcSdbezWSr+1b+vgjeHGzpwxBJewUYPiSubZKsqRSMheKIruc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UomVBqi0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBB9C433F1;
	Thu,  1 Feb 2024 22:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706825163;
	bh=gm39k00fXSJe5GlQK5AeCq4vRl3BvQqkpLTuncjtNyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UomVBqi0EGzJV6yaG7J923dM9+hNpVQN1BWkCkA4WcWuUz2at+hH0i96TKF9woxct
	 fqA37JLy5PeGJAR4C1W+7n3prCC+ZDfmqyS1iiFl57ihoM8h7gcV6s00l7foLPZv4P
	 dA8gI4KIHDCkS9YH3/39+Bs3f/QkbgDPYlVPr8ocgxRESn6wYkXIL0uyni/EjXXH7j
	 uYi17hnKmhzTRkyE8jsd1/iK6RjofrafqRpOQa51K7p0cStv3gvOMZMLf+9mDfETU9
	 uq+zqKR1C0SQ9kuCQUEk6Gl25dkW+zIdKaVQQPLqUicLjpeHkr6QeEc1NYGKcm2Dvm
	 MKppWHKy3FR+Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Feb 2024 00:05:59 +0200
Message-Id: <CYU30TPVVC1Y.1ZN3LHF3O70QC@suppilovahvero>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Samuel Ortiz" <sameo@rivosinc.com>, "Dan Williams"
 <dan.j.williams@intel.com>
Cc: "Kuppuswamy Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>, "Qinkun Bao"
 <qinkun@google.com>, "Yao, Jiewen" <jiewen.yao@intel.com>, "Xing, Cedric"
 <cedric.xing@intel.com>, "Dionna Amalie Glaze" <dionnaglaze@google.com>,
 <biao.lu@intel.com>, <linux-coco@lists.linux.dev>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 2/4] tsm: Add RTMRs to the configfs-tsm hierarchy
X-Mailer: aerc 0.15.2
References: <20240128212532.2754325-1-sameo@rivosinc.com>
 <20240128212532.2754325-3-sameo@rivosinc.com>
In-Reply-To: <20240128212532.2754325-3-sameo@rivosinc.com>

On Sun Jan 28, 2024 at 11:25 PM EET, Samuel Ortiz wrote:
> RTMRs are defined and managed by their corresponding TSM provider. As
> such, they can be configured through the TSM configfs root.
>
> An additional `rtmrs` directory is added by default under the `tsm` one,
> where each supported RTMR can be configured:
>
> mkdir /sys/kernel/config/tsm/rtmrs/rtmr0
> echo 0 > /sys/kernel/config/tsm/rtmrs/rtmr0/index

/sys/kernel/config/tsm/registers/0

Does not mean that I agree with "tsm" sub-path as I don't know what
TSM is by definition.

BR, Jarkko

