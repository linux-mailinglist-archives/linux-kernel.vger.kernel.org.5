Return-Path: <linux-kernel+bounces-8922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DC681BE34
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A54E1F23366
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DA063516;
	Thu, 21 Dec 2023 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0wdOol3n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59DF64AB2;
	Thu, 21 Dec 2023 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3sFuxos3oBr0zNH2sCa/nhgb/CzikC8gebG/g8guKn4=; b=0wdOol3nQtp3YM0d5pl61KAaPs
	WyRGtiQws8YcXcD/r+ECzzSt4LiQz6RRwKFprTN+wnS6ovcGByN6Amh2uDH4EDPq6s/dKzBzX5Iuq
	lV2McFiMCtS5ChPCZ0AZAxzTKtO/VHO9XjTGHCXo/RLwTlCbnU3KgxXOyVBH0u3chXD8C7O2m94zs
	+tOiapezwtkvtItSTR3JAKeZ0ohkbywvHC1WDx9/+OmSheSiHL3R3godXdz+MHJwv+PpHQo+2LEL2
	M5tHvJ2H54bkV836wl19XI1uhui3eXlG3XA77VhQRVJ5DucFU4ZSgRp08amK7Z9909GW07MJnTC59
	QNlF0FGg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rGNkg-003nNk-2b;
	Thu, 21 Dec 2023 18:26:34 +0000
Date: Thu, 21 Dec 2023 10:26:34 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Marco Pagani <marpagan@redhat.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module: improve documentation for try_module_get()
Message-ID: <ZYSDWn18KsMyJunl@bombadil.infradead.org>
References: <20231221165848.150041-1-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221165848.150041-1-marpagan@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Dec 21, 2023 at 05:58:47PM +0100, Marco Pagani wrote:
> The sentence "this call will fail if the module is already being
> removed" is potentially confusing and may contradict the rest of the
> documentation. If one tries to get a module that has already been
> removed using a stale pointer, the kernel will crash.
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>

Thanks, patch applied!

  Luis

