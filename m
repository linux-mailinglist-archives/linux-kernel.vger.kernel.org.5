Return-Path: <linux-kernel+bounces-137055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E2A89DBB2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7781F245C2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C874912FF73;
	Tue,  9 Apr 2024 14:03:30 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D58B12FB24
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671410; cv=none; b=cdQexhLIHKgHQGxyRgPn0zU0+6QyyCJ2DC1Z1SF8Tl0MADmAsEtrVQFw/iyih9f69jMOB6Lyqx/0zvMZ8Bb/1HGmJ6GqwxYgtsPEIzT9/E5dJAQs1/UAopmGkm29+TyE8RBpKAEAK7GSbLNLHyWqpUvWx6a7R6ghlQdN+gC40l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671410; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4o8h8O74w8iyNEO2Pgse6cjqlFykj6Bj7pyTVEF1IIIYx512cH9d3ODmotDxnQotc30ffnU3GR+3NQgUv/nZL4JGollubai/Li+Qvm2iUE5RQGnyEEz8+QEXeY2I0Mv/JKb3D5UvEtIzwcWQGmbHxbtFPvNUcp0wv63Pi5qrOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5F53768BEB; Tue,  9 Apr 2024 16:03:23 +0200 (CEST)
Date: Tue, 9 Apr 2024 16:03:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH v5 6/6] nvmet: return DHCHAP status codes from
 nvmet_setup_auth()
Message-ID: <20240409140322.GA21256@lst.de>
References: <20240409093510.12321-1-dwagner@suse.de> <20240409093510.12321-7-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409093510.12321-7-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

