Return-Path: <linux-kernel+bounces-45830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC628436B6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D44E1C20A7E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6AF3E49D;
	Wed, 31 Jan 2024 06:28:29 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC433E48C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706682509; cv=none; b=bE1vZH7mjyu+AjPfyUVOdAHsZu/4t6XKDAHzPv7ntxlAzk7sSwZ8Ydj2Nt42hrnA1o+Gofx5HFcDWe+2l5uHdnbd8xc5fIVm1Qtnd5s5ZQQMq7Fv0GkCodlAhiT9nBgE4/Jht0bikD2sJGQk4AB2NtB0cQQzJphGCZwWhib2xI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706682509; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9jR4zv4pzsqzLwS9t5HHMrSQwAAfbMV4xE6GnIBL6avWxy2IjKFbdNrQivNvYEjUjE3AbvOt8MZNWqdYHL/f7mpft2mIHz187WGpu1azUapWQ4B8lYnwUWFePzJCS0FPzPLqM5o9gGgyKgbyzlG84YOGseWursKpE4ol2rEfkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 80DC768B05; Wed, 31 Jan 2024 07:28:24 +0100 (CET)
Date: Wed, 31 Jan 2024 07:28:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/12] nvmet-fc: abort command when there is no
 binding
Message-ID: <20240131062824.GH16225@lst.de>
References: <20240130094938.1575-1-dwagner@suse.de> <20240130094938.1575-10-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130094938.1575-10-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


