Return-Path: <linux-kernel+bounces-123358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BA7890712
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842981C26B27
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642D67F49E;
	Thu, 28 Mar 2024 17:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4I3A/48"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A320F5A780;
	Thu, 28 Mar 2024 17:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711646564; cv=none; b=sGS3BfPr3kwLG5ugmzPRoTlXO9zepV309apmA2dzx5ivf9zeI1C4DJopEXJPsrBGLKfc4oP9btRpa5Nh08vsDhwG0WgG+339tPH2fJRN2VpWMima1id2ecF6ScMm0TGpEukpdN/0GrndWA2T5q9XdmYtJBluxNj7TZlxAmNxXTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711646564; c=relaxed/simple;
	bh=zvaTfL5i0i12k1PkvRyuQpdi6paxqsJzTnBVoQrSthA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzQZCpzBVMwx1U5/PeIwLDU4yJxbmP2M8D/OvDSMKvR9ZlPNtGIq5yNa/UmO4ZJB+PRK6+0c3ZXA3CQBvvytxjpDGomfdzDYIJ17REIovKY9O9hhJMdm7jk+Sq8pBU/Aq6xW6ifir+6MtBMR63rq/EEAr0hARbKsQhRDCoZH7l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4I3A/48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC3FC433C7;
	Thu, 28 Mar 2024 17:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711646564;
	bh=zvaTfL5i0i12k1PkvRyuQpdi6paxqsJzTnBVoQrSthA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t4I3A/48nhIb+L1iaJu5fwn1VAQusll0dPaugv+hKN7sjAQkljRIPiUqP5lSUd/yi
	 Ta/Sy95JRaawTvdMkFdyHR8n1la7mVSEtFHpZWB/DDCjkQ6PRa3+Bkl28a5E9LX+30
	 6r9vdgnnGXKsgJuddSVGo3+JkoqBT42A84nAkYZ/DP54F1/pE5lzvew/Lld6PqO/a3
	 lmLuanHA+4EUqZ7FKx/8A2ed3REAma5J8+ytAdYllHGir+mOzpXHnY1s5eb/FAxO49
	 zFOaqyyiZ3rOA++2e59cWssHVrkhA4iul4UbGTgUKieYInytY/e73XzG0lIYuySS0C
	 WZr5vBSFqrQxQ==
Date: Thu, 28 Mar 2024 17:22:39 +0000
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, mschmidt@redhat.com,
	aleksandr.loktionov@intel.com, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH iwl-next v2 2/7] i40e: Refactor argument of several
 client notification functions
Message-ID: <20240328172239.GA651713@kernel.org>
References: <20240327075733.8967-1-ivecera@redhat.com>
 <20240327075733.8967-3-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327075733.8967-3-ivecera@redhat.com>

On Wed, Mar 27, 2024 at 08:57:28AM +0100, Ivan Vecera wrote:
> Commit 0ef2d5afb12d ("i40e: KISS the client interface") simplified
> the client interface so in practice it supports only one client
> per i40e netdev. But we have still 2 notification functions that
> uses as parameter a pointer to VSI of netdevice associated with
> the client. After the mentioned commit only possible and used
> VSI is the main (LAN) VSI.
> So refactor these functions so they are called with PF pointer argument
> and the associated VSI (LAN) is taken inside them.
> 
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


