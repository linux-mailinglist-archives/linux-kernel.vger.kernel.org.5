Return-Path: <linux-kernel+bounces-86158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFB386C090
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B7D1C2254E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D293CF63;
	Thu, 29 Feb 2024 06:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YANiuQsg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA3B3E47F;
	Thu, 29 Feb 2024 06:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709187004; cv=none; b=lH717FnCpm8Z/mwIk4RDDhn00tSW23HBnq1zXdhZgy67JCMR2gxM+ePzEBbT2VAFb9IKspqnvUVDathoLO2ZEZ3HNhe1JoXHkZooeTlqhnNB9Urt3eVz7+JK59/hsjUsJIluI5656oxPkwyVKnRl79mcuvQrzf3AHjgYeut2Ljw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709187004; c=relaxed/simple;
	bh=3QrK1rnnkNEmAS8nSX/MDwigd9KwuYAh6n/cDlr0kgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbz1yrle+x2sXsb65HHz03WoPmRQnrkpZ4BhGnOXK2STyxMEfdu/usGwO5MOwoi6H5tfvramqxUU+73BVfJDz7YKhF1QCPBywFoyy1Jet2FQj7H7YmnWR6uq6brBj2MOsPYMai1JbJ1jlxGMcz5PhvNWVwc2lnwYjhxBKOgcS38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YANiuQsg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFABC433C7;
	Thu, 29 Feb 2024 06:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709187003;
	bh=3QrK1rnnkNEmAS8nSX/MDwigd9KwuYAh6n/cDlr0kgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YANiuQsg525U9AgJQw6C08UBFQ3WMNbf3EeQ+T//LTU3lHNAesPy0x91hQIa87e2u
	 DPkNFbVbj63KHQTSEujZ5iv4ipbbu2w26pYA/+u+7iuqtoED8mlrYi6pagVitxBTpm
	 OmhTb30iFYXPkSB2TMCkFNv/vb98J1HLAoKJJhpE=
Date: Thu, 29 Feb 2024 07:10:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lee Duncan <lduncan@suse.com>
Cc: Chris Leech <cleech@redhat.com>, Nilesh Javali <njavali@marvell.com>,
	Christoph Hellwig <hch@lst.de>,
	John Meneghini <jmeneghi@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v5 0/4] UIO_MEM_DMA_COHERENT for cnic/bnx2/bnx2x
Message-ID: <2024022946-urging-thumb-4408@gregkh>
References: <20240201233400.3394996-1-cleech@redhat.com>
 <CAPj3X_Ve4WgwCdzXiNSC+3ejsD9yc=586=g9kY_zGZXBREx7fA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPj3X_Ve4WgwCdzXiNSC+3ejsD9yc=586=g9kY_zGZXBREx7fA@mail.gmail.com>

On Wed, Feb 28, 2024 at 10:20:58AM -0800, Lee Duncan wrote:
> Is this series stalled?
> 
> I believe the main objections came from Greg earlier in the series,
> but I'd gotten the impression Greg accepted the latest version.

I'm behind in patch review, should get to it in the next few days...

thanks,

greg k-h

