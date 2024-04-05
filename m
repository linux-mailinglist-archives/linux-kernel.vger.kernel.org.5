Return-Path: <linux-kernel+bounces-132463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2AE899526
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B5D28A5EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240E81CFA9;
	Fri,  5 Apr 2024 06:15:19 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F266B224F6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 06:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297718; cv=none; b=aDbkFfcoWbC1FZ0/s13hDUPYPnQ6HGDNuAoGJF+AJLdaEAREBX7RouLv0vfwrmAAaJJMnXORIvKVQRLzcuj4y2el5Ew8zVlT8QuqT0bK8rYteLqleAap2WhdFTRx3qssHCAMA48f9D3fWAaQ/iyJQcM2Erstjnm7U6lAktH1Wh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297718; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTRvW5EKZV8Tfyi9HpYViwBCxtyp0M9oUhar0Qbf+QIA/QXzMAgdRA1xDTFU7tlY/KVpAIvX9GK5TlFKf6ytpSju1p4HBIZE3Fk/uPzhnqPZZtvtyFCW7oQlEqr0lq8jLJsXvrtdPJvus+Nvr3LhO5J2ViBYOchuHkcDk92k14w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 80F4268D07; Fri,  5 Apr 2024 08:15:05 +0200 (CEST)
Date: Fri, 5 Apr 2024 08:15:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nvmet-fc: move RCU read lock to
 nvmet_fc_assoc_exists
Message-ID: <20240405061504.GA3056@lst.de>
References: <20240404144131.17988-1-dwagner@suse.de> <20240404144131.17988-2-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404144131.17988-2-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

