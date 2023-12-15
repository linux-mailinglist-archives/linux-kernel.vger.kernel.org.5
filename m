Return-Path: <linux-kernel+bounces-844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A203F8146FA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389401F23076
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B540224B53;
	Fri, 15 Dec 2023 11:32:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4AC24B37
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6C65668B05; Fri, 15 Dec 2023 12:32:27 +0100 (CET)
Date: Fri, 15 Dec 2023 12:32:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: joakim.zhang@cixtech.com
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com
Subject: Re: [PATCH V2] dma-mapping: Set dma_mem pointer as NULL after it's
 freed
Message-ID: <20231215113226.GC6479@lst.de>
References: <20231214082526.1212264-1-joakim.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214082526.1212264-1-joakim.zhang@cixtech.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

I've applied this after fixing the whitespace errors.

But we really need to get remoteporc off messing with the reserved
regions itself and retire this API entirely.

