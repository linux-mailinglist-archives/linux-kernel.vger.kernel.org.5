Return-Path: <linux-kernel+bounces-105558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6515487E02C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 22:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC451C20FB2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CCE208B0;
	Sun, 17 Mar 2024 21:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZrjPyvCY"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774D41862A;
	Sun, 17 Mar 2024 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710709936; cv=none; b=Yw9TjEj8ThGuAyFf7TvS4YSUctyIeej/m8UaVeuolMY4J0mzaPUYhWNGXVEdNBhbJbJSGgv9NGBsqDvk5/y2B+G4C79nD5ed5Cu0w4unzBObKMNuwfXe70DytjZ6GRDV05kZN1H8TzUF6I4ZxpT6nvMHvonog35y3zUubtt1jlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710709936; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9LpguGRSD77J+v0peU0Clb7ixrBv5J8R0EPzfejzKVuMz7AWgFcM3bU+hNWIiXvrDQwTMhCQDkWMnNZlxcXdHnITjJNWhg9sLw1yacFNP4sakYzQq6nvA6+bOWE5CPX26V/kftxw5EySqu3mm7U1tt9SGk94i1q7SczHnenTf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZrjPyvCY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ZrjPyvCY2qHpEMJv7gG+c/stYa
	7NeQn2xaE+KfnA/DLy4aHX63emZlO3KtO+4JM7K2mCOYc5tsfV9MGlmt8n5ltgCUwEb2R1X1iYXmZ
	LatRqa5D034VN51mNnuXIEgpYNWcwovYpDXEgtiNwzTTHu6BoKbi70VF85txauvA96jERX915dG/y
	5rIxy5G7SqyOguiDcwK8Ltv5LKp5YrPqWHKXjuIAX1nU6Mt8jO4xYDLRKIus8kHQaJAOthEnrK9rA
	4hdY6atNJalkn/H0jb24j+voS2398SN9HVu2Ox/hci+TqoW2MVP6qMwyPqWbXUgoKNFk/BIWv3DPh
	6E92Jt3w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlxni-00000006SeZ-3iNU;
	Sun, 17 Mar 2024 21:12:14 +0000
Date: Sun, 17 Mar 2024 14:12:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: Fix typo in comment
Message-ID: <Zfdcrtk3b6UfgQRF@infradead.org>
References: <20240317154731.2801-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240317154731.2801-2-thorsten.blum@toblux.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

