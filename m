Return-Path: <linux-kernel+bounces-137042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2270589DB84
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E231C2274E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A8012FF60;
	Tue,  9 Apr 2024 14:00:59 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3B112F58C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671259; cv=none; b=D7D3/hgt0V6+aXk/h3zVtsndh0Lp1btkD3wadp4YgiV+TQ4N6PY1eLIj1xkRtAqZD+ZdRULL6eepLpKBYW7uhwXvRZ3mP51h0s8IgM7TuqUpDNS4mLfd3qJAqpBkIzONi6YL2fpODCeKlWW3FjmYGP3dceKI+I4aAw3xl+BofJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671259; c=relaxed/simple;
	bh=ronNM7eHHbMgozldHtmyQ8+LOdltNvBq/DzQX5wuWgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aG/zB21JMZlabfSMl0XjtTEchBuZoFl5cJXKXTN+GAKYqDJIiy79jRHxxwR2CFmFhuvn/HnqTfBCLF76ia8/WYtUwtJkPlSw8Fp+j2jyqd/m1CGtlkIzDnBzKXQJkCLF/AUv8KFP3gRJKC/CT13KwuvwAKhJsyBkbFp1VX4hwsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9CE6468B05; Tue,  9 Apr 2024 16:00:54 +0200 (CEST)
Date: Tue, 9 Apr 2024 16:00:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v5 4/6] nvme-rdma: short-circuit reconnect retries
Message-ID: <20240409140054.GC20883@lst.de>
References: <20240409093510.12321-1-dwagner@suse.de> <20240409093510.12321-5-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409093510.12321-5-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 09, 2024 at 11:35:08AM +0200, Daniel Wagner wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Returning an nvme status from nvme_rdma_setup_ctrl() indicates that the

Shouldn't this an be an a based on my highschool english.  Or does
Eeenvme count as a vowel?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

