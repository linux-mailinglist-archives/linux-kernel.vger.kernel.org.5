Return-Path: <linux-kernel+bounces-102113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E03B087AE85
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DE891C237AD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B863F69D16;
	Wed, 13 Mar 2024 16:55:55 +0000 (UTC)
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5544B69D0E;
	Wed, 13 Mar 2024 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348955; cv=none; b=AwKVix2iU7uOD0ohXs4NdIbhE014ABJGqJI1VCpjciDbMWFXADEmT5e/uLaYIOqvoRKBnUJ1IqlRhkyQWOc5OGRvyK0TonseVUqj/FBOT1Cs/FctdbMemunwQLJXY0EGpspEbwWkKHGOE/OpP9Kb2H+6M40vT6GQgD22Vx+Qs98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348955; c=relaxed/simple;
	bh=uQ27L82IN+pO3gKw7fNot9AAXBlmK7vhd2zvZSNftMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzF+2RjwebVBhjcBB1iST+Rt7TLrIf999m76cghYDLQEx2AAOphdDcG/NHaK2qTyRRp50F/C+wDxlRxZ5Bu7VbtI0Jtpo2Hmk3XF1uMOf9HxTAgR7WrpTBlfUUIrgxDhu3+h9aMNKJOkTaUV2OHzMVFiiLhL2VlBO41zi7rWiWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id F36B5A025E;
	Wed, 13 Mar 2024 17:55:50 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4jaCCMw4pp_3; Wed, 13 Mar 2024 17:55:50 +0100 (CET)
Received: from begin (nat-inria-interne-52-gw-01-bso.bordeaux.inria.fr [194.199.1.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id CBC1DA022C;
	Wed, 13 Mar 2024 17:55:50 +0100 (CET)
Received: from samy by begin with local (Exim 4.97)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1rkRtO-00000002Kq8-2CXV;
	Wed, 13 Mar 2024 17:55:50 +0100
Date: Wed, 13 Mar 2024 17:55:50 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
	Alexey Gladkov <legion@kernel.org>,
	Jiry Slaby <jirislaby@kernel.org>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbcon: Increase maximum font width x height to 64 x 64
Message-ID: <20240313165550.g66jo2y4ciozxlil@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
	Alexey Gladkov <legion@kernel.org>,
	Jiry Slaby <jirislaby@kernel.org>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240312213902.3zvqaghlopjusv6m@begin>
 <20240313174531.2579df0f@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313174531.2579df0f@booty>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)

Luca Ceresoli, le mer. 13 mars 2024 17:45:31 +0100, a ecrit:
> Using 'git format-patch' and 'git send-email' is *very* recommended as
> it will take care of all the formatting for you.

It's quite a pitty that git cannot simply consume the output of diff.

Now I'll have to download 8GB of linux tree only for a simple patch...

Samuel

