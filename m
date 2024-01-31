Return-Path: <linux-kernel+bounces-45822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B988436A9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3087B1F28933
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D243EA67;
	Wed, 31 Jan 2024 06:26:05 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2663E47A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706682365; cv=none; b=IT+LZmAkdgqRNU3LRYn3wUqpzgiMUGFKKHAqYenEjbc+UeA5pKJEqxh/E07nnY8brkXQdK2HpuDSi1B+kt7+Xh/BQzZv2wRXmneX5W+2ERHLRJ0YXbiqZFEhN3eEpfYbWqby0Dff+k1Q2bhjUe3Q5A2akQPy1MhWVfUwT5wyjx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706682365; c=relaxed/simple;
	bh=JQ1K+MNxntxzlJ3HvG048dfjnQn1oAxwWi7aNakinjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MO29yGIkBVwi+XIUPonN7jDpU8f5j9sR/zLMECKJIhDHJpnzS1n7GdhLXjeRT+R7BFIu9DqSD8N4c9rpeumiR8sDEEPfkzo0Y2PsCDH/OuTkizJohRJQPSJDHT5Yi8r02AQzodIcdJ9VT7jzyzJGc46JNMlEoinoInD7MTtiwd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 661FE68B05; Wed, 31 Jan 2024 07:26:00 +0100 (CET)
Date: Wed, 31 Jan 2024 07:26:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/12] nvmet-fcloop: swap the list_add_tail arguments
Message-ID: <20240131062600.GA16225@lst.de>
References: <20240130094938.1575-1-dwagner@suse.de> <20240130094938.1575-3-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130094938.1575-3-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 30, 2024 at 10:49:28AM +0100, Daniel Wagner wrote:
> The first argument of list_add_tail function is the new element which
> should be added to the list which is the second argument. Swap the
> arguments to allow processing more than one element at a time.

Ooops.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

