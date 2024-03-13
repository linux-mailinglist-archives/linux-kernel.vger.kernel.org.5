Return-Path: <linux-kernel+bounces-102229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E94787AF9A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D603AB25740
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6111A38EB;
	Wed, 13 Mar 2024 17:06:53 +0000 (UTC)
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A861A38E0;
	Wed, 13 Mar 2024 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349612; cv=none; b=ipiw4LEFh/4HFUFboF51xlATSmVR1VF1lXyG+V0MYL4vXKfwPYYtrLGsNrRVEkrFRy1QhuGKtfXA+gm+XjQxC8rubSesyi2ZyE7XDLUnroCWIqxoT6z4BUV4p3e1dTA9773VMzF/H3spwOuL9ir4CoMcH8qUZkLmUYEBY9LaY5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349612; c=relaxed/simple;
	bh=vueGNMyytchqF71hPCkZ+FNJqZV9AJGrYNvpOvPjaM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZiFdJ8iGeHSp+TuqHAS1C1q3fxCjlkV9aX//MfJqeryKwSQGuxWqCpFa0XMeG67bkg5jUv6D9FdG0kT1/KXnc0EzJ/1XeiKG1OHDjPQy84qTNr+iN8/92/J5Zswn1oUP0x/RRMtY7fH61CQWd75Gu2FD1iDkjA3EaJOwhjGdmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id E61A4A025E;
	Wed, 13 Mar 2024 18:06:49 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MUxiADeTrGeV; Wed, 13 Mar 2024 18:06:49 +0100 (CET)
Received: from begin (nat-inria-interne-52-gw-01-bso.bordeaux.inria.fr [194.199.1.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id CBD95A022C;
	Wed, 13 Mar 2024 18:06:49 +0100 (CET)
Received: from samy by begin with local (Exim 4.97)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1rkS41-00000002LOV-2Jzo;
	Wed, 13 Mar 2024 18:06:49 +0100
Date: Wed, 13 Mar 2024 18:06:49 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
	Alexey Gladkov <legion@kernel.org>,
	Jiry Slaby <jirislaby@kernel.org>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbcon: Increase maximum font width x height to 64 x 64
Message-ID: <20240313170649.bl45jv3r3qxzymfh@begin>
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
> This patch is clearly not formatted according to the standard format
> and it does not apply with 'git am'.

(Note: the failure of application was not related to the formatting at
all, but just a little fuzz for the static word in

static struct fb_info *fbcon_registered_fb[FB_MAX];

that git doesn't seem to be able to just cope with)

Samuel

