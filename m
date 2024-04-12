Return-Path: <linux-kernel+bounces-142321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA858A2A26
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9211C209E9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4153E56B7B;
	Fri, 12 Apr 2024 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hob7zJgv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865475102F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911773; cv=none; b=MT/omeOO89TIGSMikU4U4LO38btaD7MNs5fJKET0sVqsTpw+m7s08/FV4pKN0pR8/Mf43IUJuW/9o+fnb6tLVfVDr6ov4N2LMtfmFL2LVf7UhPfhSi71zFfPGWYLGokef46Ls5dZY0GOft5YkLXHu0OhpjTSFy6aLjv5FOYxofE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911773; c=relaxed/simple;
	bh=vckyitQ4Hj++2tnyft/GkS7Q8CWxgJuWmJ4pH7dgGNc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DqpHNEycoo8wuGhQqQWPw3FZmyZ8m3NmJyNViNDQHROuGIeGMyCb3VhAi6UE7kDQP5J8RsZKAicNrP6C0sfGbzjCwkrkouynkjxHU2ktRexLzqN91ISbJdBzRMEQdp/ZCuDG/UJnj7dkeUfgx3n9kXUyoKl0I7ZrvyRxXscTEM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hob7zJgv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3921DC113CD;
	Fri, 12 Apr 2024 08:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712911771;
	bh=vckyitQ4Hj++2tnyft/GkS7Q8CWxgJuWmJ4pH7dgGNc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hob7zJgvmG/aT8tLR/PIGmH2u33sH4Lmw6vd0Xo+oPBiJEzlS7wxmLNrYYU7xNCjo
	 d9/Z7oXt/N5bNbV/OHm/58nutoEqpoQQU734VHbOTb6rsOCRqBCGNwxtou9Ocj9dj+
	 CK5+Rh/H3xzbua3zVlB7n8TicirgoE8WDa3aop+hQ0MWV6LkuNie4GS7uFLDFv52Fy
	 gf0qEnagXQIYRt1yBkF5LPZJxhcSm4kjU8+XJEQLSjw+aT0HFAGu7hwLZqMQ8c+ket
	 ocayXJj5RMPmq3lnohXrq9nM+U+GutpTrhbJwnZbfM1CXSnGgh2n+QQjRz6KccWlsM
	 9Lj99653kw5gw==
From: Lee Jones <lee@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <ZhjOj_4AUgC4Iwh_@drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi>
References: <ZhjOj_4AUgC4Iwh_@drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi>
Subject: Re: (subset) [PATCH] mfd: bd71828: Remove commented code lines
Message-Id: <171291176994.2961423.7661997536361021464.b4-ty@kernel.org>
Date: Fri, 12 Apr 2024 09:49:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Fri, 12 Apr 2024 09:02:55 +0300, Matti Vaittinen wrote:
> Some commented out code was accidentally left in the header.
> 
> Clean up commented out macros.
> 
> 

Applied, thanks!

[1/1] mfd: bd71828: Remove commented code lines
      commit: b13a46be702a9ab9e0ec646cfbb617dd17e1dd39

--
Lee Jones [李琼斯]


