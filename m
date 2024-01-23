Return-Path: <linux-kernel+bounces-35519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EC5839261
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE611C22A27
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887B45FF08;
	Tue, 23 Jan 2024 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TCd0pyWC"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB535FEF9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022915; cv=none; b=FtAzbxaZ5VeaaNBgo0w0tBdkMJVNbRXU2UqWyQ0sSodSyd11LBw0h5s8LnN501ks3ZYT8emNhmWSE2gUPLEnNBE4u6sz8zSv8vMEGMeZ0hpvS2IPyFrcrBv67nq1NRf5LLt3xuTeSzRtRWwhUN6blDprt/mbmLPqGdgVlEik6VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022915; c=relaxed/simple;
	bh=KH0LvkdbK92DKVq5Xs21pvP2sw0RoJdUkpHOytWRwAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5Pf/dWojGkMc6+WqufUZuzVtER9Drn3AXCGCQ+6Ze0/X3HHBK4ZJEolUSQeHWBknSO6J22l3KGEikYoTKLq87vEZPNxo43foHVUnb6+2E0ELQ6JeGamuT1oWW5mOSEPw6gwNQHdrzC2uIzwwSJSySRm4bxaRbzuS8NvuPSpz7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=TCd0pyWC; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 971F51B9A;
	Tue, 23 Jan 2024 16:13:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1706022838;
	bh=KH0LvkdbK92DKVq5Xs21pvP2sw0RoJdUkpHOytWRwAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TCd0pyWC9KqbqCI5zJb9AcehuYWsPviIQ8dVRw9+8vhPizbH1jRsgimEWeZwSEkIx
	 Yo9P7jjIu/RQ1gb7JFZZs3yKMP8sY/IG2W6SJU8gcUorMxJLJLhXB6C+LOVLUKhGf8
	 /Hne88ti6bYq09pwpFMqJLe4kl/FqEZ96PiiD5q8=
Date: Tue, 23 Jan 2024 17:15:10 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: David Airlie <airlied@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] drm/bridge: Add drm_bridge_find_by_fwnode() helper
Message-ID: <20240123151510.GM10679@pendragon.ideasonboard.com>
References: <20240122163220.110788-1-sui.jingfeng@linux.dev>
 <20240122163220.110788-2-sui.jingfeng@linux.dev>
 <20240123011710.GA22880@pendragon.ideasonboard.com>
 <c999fed3-b6bd-4499-b508-cf524372fbdb@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c999fed3-b6bd-4499-b508-cf524372fbdb@linux.dev>

Hi Sui,

On Tue, Jan 23, 2024 at 04:01:28PM +0800, Sui Jingfeng wrote:
> On 2024/1/23 09:17, Laurent Pinchart wrote:
> > On Tue, Jan 23, 2024 at 12:32:16AM +0800, Sui Jingfeng wrote:
> >> Because ACPI based systems only has the fwnode associated, the of_node
> >> member of struct device is NULL. To order to move things forward, we add
> >> drm_bridge_find_by_fwnode() to extend the support.
> >>
> >> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> >
> > Could we switch completely to fwnode, instead of maintaining the fwnode
> > and OF options side-by-side ?
> 
> The side-by-side approach allow us to migrate smoothly,

But it increases the maintenance burden for the duration of the
migration. I fear the migration would span years, with nobody really
taking active care of it, and the OF and non-OF API will have a risk to
diverge.

> the main consideration is that the OF approach has been
> works very well, it is flexible and very successful in
> the embedded world.

fwnode is a superset of OF, so I don't expect issues switching from OF
to fwnode. For the non-OF, non-fwnode users, that's possibly a different
question.

> It seems that the fwnode API could NOT replace the OF
> options completely. For example, the'of_device_id' and 'of_match_table' related things are always there, there

Yes, and that's not a problem. OF drivers still use of_device_id and
of_match_table, even if they use the fwnode API. No issue there.

> are large well-established helpers and subroutines and
> already formed as a standard. Some part of it may suffer
> from backward compatibility problems.

fwnode has been designed to offer the same API as OF for drivers. If
something is missing, it can be raised with the maintainers.

> So I want to leave some space to other programmers.
> Maybe there are other programmers who feel that using
> OF alone is enough for a specific problem(domain).

-- 
Regards,

Laurent Pinchart

