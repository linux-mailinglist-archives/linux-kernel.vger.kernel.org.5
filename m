Return-Path: <linux-kernel+bounces-144727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8883F8A49C7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16B42B22198
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C853613E;
	Mon, 15 Apr 2024 08:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DcB72NoZ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44BC374C6;
	Mon, 15 Apr 2024 08:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168465; cv=none; b=n0dxWJBeHvHkCAi7h5y+XbRhsqssdx+VQp9txShzRklSXjDUSqa2keMR6rHHL5RRhegl/UlMMiktQY6SHWcZU1NNOn1L92uOoSnvYpYbWtUd5NfYr79+oOPPR+/RLWb/RrQkrP97IFR9vtWzcvMM6scvQxb8h63+EF9eETYdVDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168465; c=relaxed/simple;
	bh=b/gb7TE4JCQGCOWe+8RSOr2CPQxX6Nb3RPFg97uJimQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rz4i2aoAqmOUiSgbIgKlYvWu5aKHxAVVGVIjsn5ni4rlH1J6AHrunBbAPv0PVw3iHYHb13KZjQZoSjEJwsQ2zDP7el2S/mkEwLI6swwrA2OprwClO7uR/In6amQUeAzqgOCksedY73KNjQMe6MHxc+VLytBowHnjFFkc5hmPRkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DcB72NoZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qTCFXHHPU/sMq7W8ckJhAOhCPBA+AR7EG5Qw7oWKLKI=; b=DcB72NoZjH9qclFl7EXp8QcSKI
	FR7pRT8ouslVQY7qdOsCD5QrQnTTgdBIdff3muBs5ckw+hQMSpA1Dq6FxePuvRJxkoB0wCY0I8HGt
	y8KZiWeEca4H5XpyU+fVflTT+qNjTmAWtzcg+LRenVsB/NiDyLECMKoEX4gdKNTK9oJvh5dMmZ0lh
	a19wFXA5vsn8X6k20aIVPKq2VkDU9jJpiZ9BdS04Umfyf6ApRDB1MvyaPgnQNNpeycxelg+9+/33A
	ZpYUEq09hSBO/ndGTCO/O9L4Gt4FoX2XIK1LfRzo/pYjbDogVGqIL/YLlzb6Iu5S6l+YS+KBM3NMZ
	2jkGHutg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwHNN-00000007TEb-0Ak6;
	Mon, 15 Apr 2024 08:07:41 +0000
Date: Mon, 15 Apr 2024 01:07:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alex Elder <elder@linaro.org>
Cc: corbet@lwn.net, gregkh@linuxfoundation.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: coding-style: don't encourage WARN*()
Message-ID: <ZhzgTeEHFF19N3UZ@infradead.org>
References: <20240414170850.148122-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414170850.148122-1-elder@linaro.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

No, this advice is wronger than wrong.  If you set panic_on_warn you
get to keep the pieces.  


