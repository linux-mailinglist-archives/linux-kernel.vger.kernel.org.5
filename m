Return-Path: <linux-kernel+bounces-63744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 514DD8533E4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059C41F2CE50
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6635B672;
	Tue, 13 Feb 2024 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qIO4gYTF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE8B58105;
	Tue, 13 Feb 2024 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836238; cv=none; b=cqeO1m1ntMyDZ7yDpcbrjS/0xMP8paNs3hpEkaYyEdoxmZplLcUMRKinchBoQZEX2AdLe6lUu1cxaIan0d1G4Sgb8MIEh8ernOr7NUn6JZY3xmgGj6PZbh/g1RyPTrHZjzZVRcAToEllKy8sUaldPwvQdswpK3/VEyoXO5Q/L/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836238; c=relaxed/simple;
	bh=I3cgIB4It1MqQprbSzFE4+Lf/lqV5JUhGmN4TYaSTuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3NTxCRUSnAFaU7hHgWTKuIY+U52ygTdchAgTac+2r9vC5l+y1rjyHzxjr55zjacIlWlyUbPyXdIfWUkyqUhRsiCrpSYeDKuWmsn3Js5l/zcxSD1voeMX4Wyi0Ud7nNtt6O2Mbyh+82zsMZnJMtYt3f4q42KS4ZH6pwZ6vYDiMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qIO4gYTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8E3C433C7;
	Tue, 13 Feb 2024 14:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707836237;
	bh=I3cgIB4It1MqQprbSzFE4+Lf/lqV5JUhGmN4TYaSTuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qIO4gYTFZgRqso784204fbBphcuVdCKXzKeTaUw9zhIwXpP+8rf5uNOSkkZ1pU+Kq
	 U4us3gpMK5/3C+h8kaUQaxNUIhra11KD3mqYaSAk3MKjzLvljLnUOBGWGmQRRax3hN
	 Ftnk8Qs1POrxTk6Jm/TXI3j4X4ttWdj7oI1AdxDg=
Date: Tue, 13 Feb 2024 15:57:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chao Yu <chao@kernel.org>
Cc: stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Sheng Yong <shengyong@oppo.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 6.1] f2fs: add helper to check compression level
Message-ID: <2024021307-clumsily-worrier-10d7@gregkh>
References: <20240212160530.1017205-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212160530.1017205-1-chao@kernel.org>

On Tue, Feb 13, 2024 at 12:05:30AM +0800, Chao Yu wrote:
> From: Sheng Yong <shengyong@oppo.com>
> 
> commit c571fbb5b59a3741e48014faa92c2f14bc59fe50 upstream.
> 
> This patch adds a helper function to check if compression level is
> valid.

Now queued up, thanks.

greg k-h

