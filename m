Return-Path: <linux-kernel+bounces-29741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA44E8312C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B100283013
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 06:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEC19444;
	Thu, 18 Jan 2024 06:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dg7dBuXc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25495CB0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 06:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705559907; cv=none; b=c0RHBXEsm+gJXKgnsFigTKFnUAO9BVJ2fD93P+RY8TPv0+rvT/hDsQmAEnnKbcDKy4qkt976bC+SBAEafqNH5S0CTsFay5JbigKLiEe7VSMIgl1HCU4hUZLO8ii08IoVWXOQkDR5mEUS6LmM09h7lLiJsf2n0vzrOZ7VeixwLA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705559907; c=relaxed/simple;
	bh=p67CEYcyggyG+hmKy5k+oikjf/hKPzn1NhLdKMIAku0=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition; b=MeLb3JKGYRrMaZmCj58u9VoBnKujcFwcrJhp+GeJK9c/+ge707lOG4+dkJwplUNWYuqtUyUOmWeujkNLdDyR9JDZELTzGHAR9TEtanSuS9WEc5PlSoaxkYJ7KGa2aMmUWqvK3EhDY6L6IczcSohTbb2M/dMx1jdB2MzbPjEBTBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dg7dBuXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB638C433C7;
	Thu, 18 Jan 2024 06:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705559906;
	bh=p67CEYcyggyG+hmKy5k+oikjf/hKPzn1NhLdKMIAku0=;
	h=Date:From:To:Cc:Subject:From;
	b=dg7dBuXc26XYJcD0rPkvEqELCNulvSGWaBZwjft3AaE80lcM9joUEeTGTU62RuJh+
	 zHMWu6EuaG6chSw0KwM+hARoISCbUXF4fpuKg3ZIjMocNU6hEWIgySzSAk3dro/C1E
	 5AfBdblxBlsBZz/Ys87X9OS2PnGirT5ZrejCPvvJ0AAG1DAwj5XKad27ACl3EMoC98
	 gMnhZFREEx9g0ueMicSrV2uuIfjfs40GlJuAjcnhLWFCakMcAieXqJNgDRPkA7MlxM
	 MjIG8hPH+oOaACdOJmY0XmskWWhdf1KqSMkHYiV3c9uTFiqszFp4c/khuzcaU6eJ1P
	 wZgO7QjUPYF7Q==
Date: Thu, 18 Jan 2024 08:38:11 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>, Yuntao Wang <ytcoode@gmail.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] memblock: small update for 6.8
Message-ID: <ZajHU5m3WWbcHWV1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 33cc938e65a98f1d29d0a18403dbbee050dcad9a:

  Linux 6.7-rc4 (2023-12-03 18:52:56 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock memblock-v6.8-rc1

for you to fetch changes up to 2159bd4e905704b1765b6b883ea15e51ad986a6a:

  memblock: Return NUMA_NO_NODE instead of -1 to improve code readability (2023-12-08 10:31:00 +0200)

----------------------------------------------------------------
memblock: code readability improvement

Use NUMA_NO_NODE instead of -1 as return value of memblock_search_pfn_nid()
to improve code readability and consistency with the callers of that
function.

----------------------------------------------------------------
Yuntao Wang (1):
      memblock: Return NUMA_NO_NODE instead of -1 to improve code readability

 mm/memblock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

