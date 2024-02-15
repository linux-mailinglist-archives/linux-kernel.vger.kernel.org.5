Return-Path: <linux-kernel+bounces-67576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3018856DAE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 524F8B25698
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5726A13959B;
	Thu, 15 Feb 2024 19:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b71KY6Di"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0511369AD
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025248; cv=none; b=Z1EVEvuNk0di3oR+/CAkZq3FOQ21z++RGsT47gLd4ezeP3TLaGF1C+6pUUIwOODMFEJDTPg/s4gaXOUWhtRJbZyHJzTZh+twla2S0ZMrwI+3BlVK4DjkG387VgZ5luLc+l+eGysGtNlntmDGZitFgxQNgGGqxlxepUhYTiqIJ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025248; c=relaxed/simple;
	bh=bzSVDGnTJrBBGgFAcw6Lz9ywneKBDirXA2FGWeNItIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HunMw5tnf6x6af3nU5sKnC5jlY4RmiQV4DF62f2z0fK40GkrhFzzbdVb4bYxAqy/kyosghrX6O+oRLN5fvRUyRmctWJs2ET6cwaLEZszoP9MVR9wRCQeNzQXNT1AQPkdBJ5P4Rln6zYXbTA2XSaNeRS0INKKWGIdY2xbdAdrZ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b71KY6Di; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lzhNAgtFCrkZybBufTk43rRT97Z9ES/4vBm1B2BTIpY=; b=b71KY6Di1KhY9F7R1e6CaODfw7
	BIc6WjZ3fFt9d8sn6sW27j/xZIN4Is0qYaqs15baOCYT7TjglSYPN6j+9afOltvxSqx2RBhy8Z6zD
	Q6VZFHcdnQK0kMwK0zVRUsXuaUIgnBQl82+xhxrK751sSbsU9McrQ99t0hT69FcqXyb4mp6X1ahOx
	d5zMxM3qyGMVbZpjyhnVIrx2f9c+Epo67WPCREDu6QvEn0kbmEfSHE0b4eemwvMK1eIqdhUMD8oXp
	/0OSbz88ilMMMcl5KwI+eDy8arJ6GXVeRuYedaTdDSvFbEIFiwpoOSQvS2UxXzzI5CsTnEZseRcSu
	oLOSNtlg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rahOG-00000002fDv-0x6K;
	Thu, 15 Feb 2024 19:27:24 +0000
Date: Thu, 15 Feb 2024 19:27:24 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 07/14] linux/mm.h: move folio_next() to mm/folio_next.h
Message-ID: <Zc5lnHpYWmuX38_o@casper.infradead.org>
References: <20240215145602.1371274-1-max.kellermann@ionos.com>
 <20240215145602.1371274-8-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215145602.1371274-8-max.kellermann@ionos.com>

On Thu, Feb 15, 2024 at 03:55:55PM +0100, Max Kellermann wrote:
> Prepare to reduce dependencies in linux/mm.h.

I feel there's a lot more you could say here.  Like "There are N files
which only include mm.h in order to use folio_next()".  Otherwise ...
why is this more than churn?


