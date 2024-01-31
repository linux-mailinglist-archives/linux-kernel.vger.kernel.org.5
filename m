Return-Path: <linux-kernel+bounces-45823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3641A8436AA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E880B2825D9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279F43FB26;
	Wed, 31 Jan 2024 06:26:25 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD393FB19
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706682384; cv=none; b=N9EEc80QmaeQnBtbJtt+khb8KppxupJvlhrEhvkNJsJAmHMK6q8TpYfUFgvI5mEKsRkS3AXiB/ZpZ3vyHWfnUBXwnF6dbv8o94pt7pbj0QvZ31WKmEt5oLDj+eq3lxR9hqT7VgK1kihEuqLT4mJUE9IgR8eq+DLnlGPSdC6odws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706682384; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDykOW9ox6p0+IUzLbXRo/cLpM32pc0b8OVaJrjf5NpLgWm0Z0M86TA3U1iLBipxQfVXcdOzp7f0IfF5OTHNwu7+IRM+9FZZu09mdxe8GBOFWsOlbJwub3K1C6NTO0Ekol/oQ1R+vKnQhiMm3+sWm2sG1ZiaHHhRRyYXlqRvgTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E4BC568B05; Wed, 31 Jan 2024 07:26:19 +0100 (CET)
Date: Wed, 31 Jan 2024 07:26:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/12] nvmet-fc: release reference on target port
Message-ID: <20240131062619.GB16225@lst.de>
References: <20240130094938.1575-1-dwagner@suse.de> <20240130094938.1575-4-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130094938.1575-4-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

