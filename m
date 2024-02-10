Return-Path: <linux-kernel+bounces-60352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE27F850392
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 09:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0C41C221F1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D14833CF1;
	Sat, 10 Feb 2024 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWQg/qlq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FE463B3;
	Sat, 10 Feb 2024 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707555132; cv=none; b=GDzTLcY0xgQdOy66BibMp599gO92TErUgMC8dyXDqqTN/AyYCGrb0cnQU/TTvFmT7wyFLvppmaSXX2tWhBuH9xgIpD6aofRMyYokVZWfKTQ8qyTKlU5ZlTSadEbaQr185iz6oLyj77q0IJNBe2XrQrQmWVEfQw5qTdObFe4J4FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707555132; c=relaxed/simple;
	bh=kdhHsq65YW84FvCmUAr3DxI8JAgxxou2IvlOBsl65Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEqPEmEI0DwFc5lGjSys+f/sxSt19MZB7uFrH9UF9U5ufk5CmuTZC9WtimBRSICFb9QzJy+DNc4CQsCQoaB0czgaZd2HS7fl6r4diB5m7wxCLx9VK6jshTlzMgjmTfgFiBtZ5DVL92nJuEYRoj23Yc4XHvDX1k5nVgrwA5w4R/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWQg/qlq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32D6C433C7;
	Sat, 10 Feb 2024 08:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707555132;
	bh=kdhHsq65YW84FvCmUAr3DxI8JAgxxou2IvlOBsl65Rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aWQg/qlqWqcmW5BHRtDUvx5hgHCmdFa2XfNmuJ5Ze3dwKeyp3h4zbX0MJuws9aa0P
	 6sWGf3azzeNKwzMJWGpEp9nXVN0Uy6B0fvjMQJDpgCvbW0uFj071P0GeNEkNI1jGJK
	 eAth1oz7LgKr3SrWSgcao/DqxB/ChcwEUn/pqAf4l2HFkNlJG+7QVpyeuDyCTJzLou
	 pTu2+jLlN0xFH5WclUbMTCXYmyywgV1NLyXqYpIs5pVxRyPJ8cqm8dABfKcpAhlQiK
	 bFIuZiARYHaA9m6jKubpW1WBcTIrdQQKeAG65DbGhwlg7bCuOO85do3k3/s24NaGOx
	 EUrEn0rNg45Sw==
Date: Sat, 10 Feb 2024 09:52:07 +0100
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+96f61f1ad84e33cee93e@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] WARNING in bdev_file_open_by_dev
Message-ID: <20240210-bekunden-glasvitrine-9c43d2672a55@brauner>
References: <20240209-notdienst-watscheln-4ca4930cb089@brauner>
 <000000000000d2f71f0610fbf6d3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000d2f71f0610fbf6d3@google.com>

On Fri, Feb 09, 2024 at 04:17:04PM -0800, syzbot wrote:
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:
> 
> failed to checkout kernel repo git@gitlab.com:brauner/linux.git/vfs.super: failed to run ["git" "fetch" "--force" "81e322358ba96b4e95306c1d79b01e0c61095de5" "vfs.super"]: exit status 128
> Host key verification failed.
> fatal: Could not read from remote repository.
> 
> Please make sure you have the correct access rights
> and the repository exists.

#syz test: https://gitlab.com/brauner/linux vfs.super

