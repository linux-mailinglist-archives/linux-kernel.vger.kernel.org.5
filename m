Return-Path: <linux-kernel+bounces-45833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 812E38436BE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225091F22F39
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DA93FB17;
	Wed, 31 Jan 2024 06:29:04 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D0C3FB06
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706682544; cv=none; b=Gvhh8MdYATkMpIOiU27cp1QKlQXUcMcKETwfBxeBZy1uY9S2iPchr8JIcutAEpY/iX4LbRIh4yV9XOYJX7GYY0lyvg/UaZawLcbv7k3tuzA5J8BQSMf8tZNBcgu1vhfNG4fVrVIN/hy8G2OaW21JArEgi8DoCG2JZG68e/NHz8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706682544; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUKgh6/1RvuzbLyJztbJTLK6NZLik23789jsfGJUfkmmq8CQcGsPeVisV6kNQ0h5i50UgfXkoxX0ZIhQ3aDN82DVELV2UvSEXh48OecSVFZVjCqj6BeaF7Fr8tRxnksVys1Tn/rgbwrkUOf3THHBNqNOMBVMfAA+/j9oXxeUeT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0647668B05; Wed, 31 Jan 2024 07:29:00 +0100 (CET)
Date: Wed, 31 Jan 2024 07:28:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/12] nvmet-fc: take ref count on tgtport before
 delete assoc
Message-ID: <20240131062859.GJ16225@lst.de>
References: <20240130094938.1575-1-dwagner@suse.de> <20240130094938.1575-12-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130094938.1575-12-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

