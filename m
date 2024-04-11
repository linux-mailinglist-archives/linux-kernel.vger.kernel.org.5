Return-Path: <linux-kernel+bounces-141230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F068A1B1D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2352286EC0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3534A17BD5;
	Thu, 11 Apr 2024 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9iZ8IxS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9B71758E;
	Thu, 11 Apr 2024 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850602; cv=none; b=u///ULlJ6VuHFFPcJqL9p8ZjDj3Mdvq+MCL7s6d7ndH8pG5zfHMurcdBsByYQbNrnloHjS/NEQB0VZzkjxNpV4+0977uPszbxvngQTTvyloY10i1WHraerpIBxl3GxH6CPozC4EXDJk+iBwJFsNeIcdZmrtx39CNJh/l5xw/K24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850602; c=relaxed/simple;
	bh=saAr95qwLl/VVq4r7QoO3CStQ+s/DJFXve0Mzafnytk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtiPG1WL33LMd5cAJTSJPZyECy1XtnkHdL2CNtX/Bw3nyLbG7ScyoGjoxCTtXQ+uZBQ07MFsGxn4WX+S47yVWJmNmDGWlJDoESKtPWr41aFCtlg5lyA4a3D8YAG3E2urlM4jm48fY9JI07FBxS8qxQ/kKrkuAqQuZgCt0R24eC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9iZ8IxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97400C072AA;
	Thu, 11 Apr 2024 15:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712850602;
	bh=saAr95qwLl/VVq4r7QoO3CStQ+s/DJFXve0Mzafnytk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k9iZ8IxSEpgtHdoqwv9wP9tOWTzmciz1LtF+WAxXu8twLOg6gia8hCSjxZqVX+t4t
	 hIl+GJsa/+oM0URZ2gNrfPo+HsbYAv10KAxWBTI7JyXuLz9ZlLzHV9comUIv68aN2J
	 6cqOe5nL5uAzrdJxo72v0hzZjvn5jE6UnNQ2Qfe9kLf+CcWDQ1Xzw+ldHRl1c//sn/
	 QjKp206xXBTntpenbAexONomDg+KrEJl9OCf++q7aCvIi/7Aq+QLdg3ujweI2K352K
	 wBhTXdcSpu1OleulZIicoNrOWyvofa0AjyUwN5wDT+JNxrFwncNadtWlRd4mgCEKzH
	 pua4+kPHETEyw==
Date: Thu, 11 Apr 2024 16:49:56 +0100
From: Lee Jones <lee@kernel.org>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v2] mfd: intel-m10-bmc: Change staging size to a variable
Message-ID: <20240411154956.GH2399047@google.com>
References: <20240402184925.1065932-1-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240402184925.1065932-1-peter.colberg@intel.com>

On Tue, 02 Apr 2024, Peter Colberg wrote:

> From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> The secure update driver does a sanity-check of the image size in
> comparison to the size of the staging area in FLASH. Instead of
> hard-wiring M10BMC_STAGING_SIZE, move the staging size to the
> m10bmc_csr_map structure to make the size assignment more flexible.
> 
> Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>

Xu Yilun, Peter,

Do you require a pull-request from an immutable branch for this?

-- 
Lee Jones [李琼斯]

