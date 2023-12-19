Return-Path: <linux-kernel+bounces-4677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D55818085
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94091283306
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C9418040;
	Tue, 19 Dec 2023 04:27:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACEB18022
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7CAE068AFE; Tue, 19 Dec 2023 05:27:17 +0100 (CET)
Date: Tue, 19 Dec 2023 05:27:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 01/16] nvmet: report ioccsz and iorcsz for disc ctrl
Message-ID: <20231219042717.GB30580@lst.de>
References: <20231218153105.12717-1-dwagner@suse.de> <20231218153105.12717-2-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153105.12717-2-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 18, 2023 at 04:30:49PM +0100, Daniel Wagner wrote:
> +	/*
> +	 * Max command capsule size is sqe + in-capsule data size.
> +	 * Disable in-capsule data for Metadata capable controllers.

A why on the disable would be useful here - the fact that it is disabled
is pretty obvious from the code.

