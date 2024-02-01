Return-Path: <linux-kernel+bounces-47431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A6C844DD2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82566B22B50
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1ABA47;
	Thu,  1 Feb 2024 00:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAxVDBKB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1637F4
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 00:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706747318; cv=none; b=N+d0ucNUIWAmJr0hS/+rfIoc1+hMWoeD31D37Cm8r629DxWDxLmBKKz9HQ1C3cVJotWet6M22CKvIvfmNXE40c758CtDd33HysjTvX3KEY/m/Z1tdS/7aQT+Bo3narhs+Wwra0aRsh9nOlIrFhvNXVYLAI2D7svlExp8VPgKfWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706747318; c=relaxed/simple;
	bh=gz+nsKjWk8Nf+ei6d5uAUW8VaFlVj2RhKbdd6i4rq2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyS/RLBdTDMZJhHzlfb9CvNMOGPVSATdZS5yr3aJXvJNlEb85ec0TrICxR9wpwXSv5JLr8QFmWLvK7h/gbL0IjIkDs/IE+enL4rXN/WeJ1V6g3dqcDuqcnstcMdm34TKVUCYc1jJEujs438eSPr8DlgvarlaMtaTE1kQ0CMlYAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAxVDBKB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7279DC43390;
	Thu,  1 Feb 2024 00:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706747317;
	bh=gz+nsKjWk8Nf+ei6d5uAUW8VaFlVj2RhKbdd6i4rq2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qAxVDBKBF87mjYyyaOuCCvHBK+3tut7ZtDKTLMVGmWHj4oyZWHjGmamsf+aLoTqlp
	 YJ+nG/AqsfzIRWUIrN7oVnlDjEAK8+S5J3KrPfGZJE5qCs5e/x1Ybg4zecYeWe7wUz
	 6dE35ETX8VWK7gXKkukty7Nibln148L5ke0oIqbCD7i+yzXexUJbkDcvfEG0VlTvcm
	 pZYHsgyOsUHSz3USG4HzqiumYTX6xua6tO+Ci/1LKtdzGSx1zIlsWx6a/3qd9Muie9
	 hvgyxZhOkuoJJpJxwj9A8NiYAUyFRY7nA/RerNCuljpOYjFMB8tl1FK9miFmKwaRAC
	 Ijgcu4jjjU37w==
Date: Wed, 31 Jan 2024 17:28:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/12] enable nvmet-fc for blktests
Message-ID: <Zbrls9IEaPe2PHmE@kbusch-mbp.dhcp.thefacebook.com>
References: <20240131085112.21668-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131085112.21668-1-dwagner@suse.de>

Thanks, applied to nvme-6.8.

