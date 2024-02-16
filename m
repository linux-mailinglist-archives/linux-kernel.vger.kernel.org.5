Return-Path: <linux-kernel+bounces-68376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6623185796A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CBE6281B93
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D31122EFD;
	Fri, 16 Feb 2024 09:51:40 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B91722EF9
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077099; cv=none; b=j4pGiofSwXUIp94BwxC/s9I5k/o9FE0D3kPfupbEePXvuNyyDYeBxe5bj6BAImZ8HrXBA6w3OHSUxTmd0ZB0hc97/gAIsi7aFtMN88h9DrugyNb+wrGej29pKeT4n4P+H00nGjaWdx+k8C5MUg9REzm/hwHY/Tx1qqHyWLKVPfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077099; c=relaxed/simple;
	bh=Byc/pEoOr+0338wCSDrouBDlqgbu0HUtq1mAFDh16m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUYzXNU8EaGT5cvpxQ+gzNUa+WWbmQeDLOh3Ep5VwauhKW5ICnHbJKRWFioYh9n7c46IHTGFWfj2w9z8Ny2vqlG9JLsr1HhvIQsUc3uyKfIPA8zxzAtoNE3l9n/7k3SJLkO1/jIFH3dhJqSLDiAnxVvBtGoD/Hy9hYOy1GnIgiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4BA7F68BFE; Fri, 16 Feb 2024 10:51:35 +0100 (CET)
Date: Fri, 16 Feb 2024 10:51:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v0 5/6] nvme-fc: redesign locking and refcounting
Message-ID: <20240216095134.GE19961@lst.de>
References: <20240216084526.14133-1-dwagner@suse.de> <20240216084526.14133-6-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216084526.14133-6-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

This looks reasonable to me.  Without much further reading I don't
really feel qualified to comment on nvme-fc locking and refcounting,
though.

