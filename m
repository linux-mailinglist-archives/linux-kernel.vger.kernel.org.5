Return-Path: <linux-kernel+bounces-123364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501C3890725
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E44F3B213C2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654517EF00;
	Thu, 28 Mar 2024 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pi15a5lR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6E080024;
	Thu, 28 Mar 2024 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711646684; cv=none; b=D45goNVVZCtI6eXwxTJRAxB+E8SPszqbPl3/EwBc0sNaUTcrhrDnsDGRuWR14P7gKl7FaO7MC8NcgalHVqz44yE1O+hkfFSVEbPWGBT3+HFHH7dEPWB35NZ45dauD+3L3Q7sGatEUGsenJ172cd6MB7BQDN5ohho8Pksj3L3EJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711646684; c=relaxed/simple;
	bh=QuRME2SHSSiGxluzScQO3eZiPChiSo+ltKYJW5/wGWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1Z9AtQ+YbYBemm8SOfXwRujvuMTpGSFbmWcEbDXe7XSJrXURyYaAygZ26w3YpLcrKBy7KJkiuBxHA+cIg8IV+s4eZomWGSgGVPVnPtKb/eBpZLMtoYMwMrHWQnjYXV64GwB+vhyt18eiIEVmD058Kt3tmabPlS3OOjoC0H6SBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pi15a5lR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3E7C433C7;
	Thu, 28 Mar 2024 17:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711646684;
	bh=QuRME2SHSSiGxluzScQO3eZiPChiSo+ltKYJW5/wGWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pi15a5lRtURzs96e6W60z49YqRCJbeCq4i6hUv2LKaMNFS/Dg4qpYivjq0jwOWJpo
	 tb7VBfPKZ0gthpwl9hJJ0KM6eP+TCx9RgCQFxMUKgAxZ9dhQARgbf8dEiYqrfCYBPr
	 5+KOW9GT9nAlKGQq4vd1rYyzzR686V0AMvWkMqH305OV1t1Xo6Wa7fCFcRc0XwYlY+
	 HZzN9kNcKTI8/S38SqSJIvtTu6/TulhhNcnrVWbp+jUgDS0+2ezHO3BeL2MrqEy9JF
	 r74f0mwtAf3xwrnovs2w6HAloY0SCpWc39NjLk5qwl3Vax/KrtO4NuKkwWGLTNYlaB
	 WRFPCIHo+P/xg==
Date: Thu, 28 Mar 2024 17:24:39 +0000
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, mschmidt@redhat.com,
	aleksandr.loktionov@intel.com, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH iwl-next v2 6/7] i40e: Add helper to access main VEB
Message-ID: <20240328172439.GF651713@kernel.org>
References: <20240327075733.8967-1-ivecera@redhat.com>
 <20240327075733.8967-7-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327075733.8967-7-ivecera@redhat.com>

On Wed, Mar 27, 2024 at 08:57:32AM +0100, Ivan Vecera wrote:
> Add a helper to access main VEB:
> 
> i40e_pf_get_main_veb(pf) replaces 'pf->veb[pf->lan_veb]'
> 
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


