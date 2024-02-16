Return-Path: <linux-kernel+bounces-68659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B5D857DEF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191121C24C88
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C41212BEBB;
	Fri, 16 Feb 2024 13:45:34 +0000 (UTC)
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F6C12B158
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091133; cv=none; b=mbe0Bguq/761/M72HMzY+gdCMJwYP3NQLOqUqXQlvPztWemEJxVYgdhutMnSxQgpP8BTRJgBk0NUiyI/lmaBaPP7UVWO6FGHOSSNs4B3Ponv5lc4Ss91XGW9VbFyVeOyHWB12M36WO7zFTIJqh+xzyzN7uaaqa/roCf6ramE83o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091133; c=relaxed/simple;
	bh=HnKyETVuwfznkWP5RdU6qtJiw6e9+UYW2nYbDUD/+9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBXnCNnxlm2e5DDSeBY2jXTPiT2puAiHNNyKL3Axp9rc0OWi1Ouy38BRpF59k1EjlkYxllkEh1SzVcJv/m0rl4xL3dI7DWj52nUNjelv8J7myDmY9zr9VMpSK8yD0F2WnJ7OjfgqK1v6WaxqwRiMszSnMZKbUQG8dao93cV3PA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id AF25EA02CD;
	Fri, 16 Feb 2024 14:45:22 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9VEhNYFXxryf; Fri, 16 Feb 2024 14:45:22 +0100 (CET)
Received: from begin (nat-inria-interne-52-gw-01-bso.bordeaux.inria.fr [194.199.1.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id 83FFFA02B3;
	Fri, 16 Feb 2024 14:45:22 +0100 (CET)
Received: from samy by begin with local (Exim 4.97)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1rayWo-00000002MJH-0bJO;
	Fri, 16 Feb 2024 14:45:22 +0100
Date: Fri, 16 Feb 2024 14:45:22 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Alexey Gladkov <legion@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH v1 0/5] VT: Add ability to get font requirements
Message-ID: <20240216134522.s6d22mljxyfd3fsx@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Alexey Gladkov <legion@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <cover.1708011391.git.legion@kernel.org>
 <d7743747-1ec2-4557-9f2f-4cffd77284b3@kernel.org>
 <Zc9ijvUofv4PCLw_@example.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zc9ijvUofv4PCLw_@example.org>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)

Alexey Gladkov, le ven. 16 févr. 2024 14:26:38 +0100, a ecrit:
> On Fri, Feb 16, 2024 at 08:21:38AM +0100, Jiri Slaby wrote:
> > On 15. 02. 24, 16:37, Alexey Gladkov wrote:
> > > We now have KD_FONT_OP_SET_TALL, but in fact such large fonts cannot be
> > > loaded. No console driver supports tall fonts.
> > 
> > I thought fbcon can, no? If not, we should likely remove all the 
> > KD_FONT_OP_SET_TALL checks here and there.
> 
> I thought so too until kbd users started trying to use such fonts. A month
> after adding KD_FONT_OP_SET_TALL, support for large fonts was turned off
> in fbcon:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=2b09d5d364986f724f17001ccfe4126b9b43a0be
> 
> But I don't think we need to remove KD_FONT_OP_SET_TALL completely. Maybe
> support for large fonts can be fixed.

Some users *need* it to be fixed, because they need large fonts to be
able to read their screen.

Samuel

