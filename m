Return-Path: <linux-kernel+bounces-68361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E67985793E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F325A28651A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66461CA9F;
	Fri, 16 Feb 2024 09:49:35 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC4B1BDCE
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708076975; cv=none; b=CXDl8ecT7xjabd98gf2y5vZI3YNbTKyXckuHV2FVu6iZIPJwlwm2+7MNg15cC3j9HLgilpojrnstfcXXyU26tZQo/kp0CJdKMpC8lJhnTZJzKrnogyDH4jaiIaZrPSXL4BfQJGDtiDbt31Up0Nvp155+UMAq12k43YxvTeNntS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708076975; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBqYXN3x45dpPcVmcEMXlbTp3osfUPcWZRqhgFCs05gB35Q5tPJ4Ryx1Z/Z8LepeB3il75JAQci91u+iJRd5iIGWM5kVNYLcZQ0adWJF0kr8aRE2yMG+xAHIFmqp0zBlJn5RXjof9oi+SkeEqTP/uVT8r9AuNMQ0Jh0WVGtzL90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 707FA68BFE; Fri, 16 Feb 2024 10:49:29 +0100 (CET)
Date: Fri, 16 Feb 2024 10:49:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v0 2/6] nvme-fc: rename free_ctrl callback to match
 name pattern
Message-ID: <20240216094929.GB19961@lst.de>
References: <20240216084526.14133-1-dwagner@suse.de> <20240216084526.14133-3-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216084526.14133-3-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

