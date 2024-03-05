Return-Path: <linux-kernel+bounces-92741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C4E87255C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC837B276BF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B1314A90;
	Tue,  5 Mar 2024 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+6vrw1G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18868DDA0;
	Tue,  5 Mar 2024 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709658628; cv=none; b=iC3Pb055h4Yhox2i4FcvY0eR8zXnr8OSmOXuzkJkhR9XijbPZh3KnmhnjbnbSKnUICJ4l7AGKdGtNK3nFY9pWgNzcDe91xhek6SowU1imChDZgO9h+7pXn6mLljtIGoNq3kTU38yogMf75UZkeSHLl+Q0FrUZq7gJwtHQ81Hb2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709658628; c=relaxed/simple;
	bh=pIdQm7zAKFtcIPONl6+fNNpS399eUnrjMwrdEDgruSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LpeJWaNTn3uJY6UoAo2eGSXleX7RTEY/KXVz1nv/kFUS4tpJwfGrIr+PM1/vmjjlvuxxY+7q+fpBeB0W5SKvdbIaRV4PbAVfa32JMqQLOzYZYIBQQoDKVBR+tt+maNScZknHJ2/zRUTXZU2dmMdUtEQ/d4nj8zMz1lMxI1PDyQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+6vrw1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F9EC433C7;
	Tue,  5 Mar 2024 17:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709658627;
	bh=pIdQm7zAKFtcIPONl6+fNNpS399eUnrjMwrdEDgruSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C+6vrw1GLd+dxAlMQtRdyylL1fM3z7MV4HuGQEs9UhlLzb+FS1xbNgkpnJ92VVTo0
	 8nkyvklcZb5st9j8t4LQWNHDM/snzE35WWmo6k9rtG+wfNOFxZQegqnG1WOz3LzTs/
	 fY40qF5KUIDmq650Gtt2WXUT3xFrm3/n+ecQ64lHClU+0AxJR8iRjtvn8DYMiFf1sD
	 mpAW74xhcOGOr/FozaCH6/K31S+2kEk5Qvbr+aktcniD4GmmeZEzW1kdHD/He4CsNp
	 T92czomb34VQFDIL0BVnY9m3H9rm7+GoM7wxZ9ZtSZpthhtXjRo9QgTBIG9Q450DsL
	 Ti/fJl7ZBZOvg==
From: Will Deacon <will@kernel.org>
To: sfr@canb.auug.org.au,
	linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org,
	Yicong Yang <yangyicong@huawei.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	hejunhao3@huawei.com,
	yangyicong@hisilicon.com
Subject: Re: [PATCH -next v2] docs: perf: Fix build warning of hisi-pcie-pmu.rst
Date: Tue,  5 Mar 2024 17:10:20 +0000
Message-Id: <170964615106.2486967.12243064113209079072.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240305122517.12179-1-yangyicong@huawei.com>
References: <20240305122517.12179-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 05 Mar 2024 20:25:17 +0800, Yicong Yang wrote:
> `make htmldocs SPHINXDIRS="admin-guide"` shows below warnings:
> Documentation/admin-guide/perf/hisi-pcie-pmu.rst:48: ERROR: Unexpected indentation.
> Documentation/admin-guide/perf/hisi-pcie-pmu.rst:49: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Fix this.
> 
> 
> [...]

Thank you, this is much better than the kludge I had put together myself.

Applied to will (for-next/perf), thanks!

[1/1] docs: perf: Fix build warning of hisi-pcie-pmu.rst
      https://git.kernel.org/will/c/b037e40a6af2

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

