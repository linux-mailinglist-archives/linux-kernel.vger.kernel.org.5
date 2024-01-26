Return-Path: <linux-kernel+bounces-40178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E668E83DBD3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518BC2842C8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E761CD20;
	Fri, 26 Jan 2024 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rAngwDjN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B87F1CD11;
	Fri, 26 Jan 2024 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279151; cv=none; b=FGmV7nLdLz2idfVSFJyaEAXsDNriRgkHMcs+nlF9tVPJy1sbvQrSRfpFvIDUnVCSfA080Fw7vYm4ROHmXnqiGt8+4eSP0kMfUs34LfLBt9BPaGHkn2ecmUYC4VBH+0a1uQ6mR1JGz6qt9j3/S8E+ShxIfSDp1PlbnfvOFcaI1cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279151; c=relaxed/simple;
	bh=G9UWeEu2Mt5sY8I+msdhUg6UDBFIjXplzptsVgTucNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+A9ZS4CieUxuz7slVbFpav3bVV/O2BVNC9f3GIi/11mdwXn631zCwbXh99mcIQUj6y4kN9HfJwHCbEk+vL87X/JwVH5aOsLyPylckwQFw42nOk7ElFKpN/5gbgz+HjWkWP9lC/lk/dMzqNYYSa55aaTh0AybeLWjfXZiEb8E1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rAngwDjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76234C43390;
	Fri, 26 Jan 2024 14:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706279150;
	bh=G9UWeEu2Mt5sY8I+msdhUg6UDBFIjXplzptsVgTucNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rAngwDjNu3mx6fw/gElMNmYO7owmXonORD5wW2R4krHZNzTvA/CRYOmwit035qnaL
	 3hfVAFl5iTLigu+72x86QG3dKFshLt2BNafHy1KZEkEB2nS2gC2Jac5Tctz6v54ZIr
	 JYyPNDFNOZnszl1mTTSeYhudZafGMPpcFtdtsqfc=
Date: Fri, 26 Jan 2024 06:25:49 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?KO2VmeyDnSkg7J6l7J246recICjsu7Ttk6jthLDqs7XtlZnqs7wp?= <ingyujang25@unist.ac.kr>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	ysjeon@unist.ac.kr
Subject: Re: Recall: [PATCH] Remove redundant check for
 usb_generic_driver_probe
Message-ID: <2024012641-sustained-ascent-efd4@gregkh>
References: <3RI8B60J4MU4.B8HML3SKIYJ31@se1p216mb1336>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3RI8B60J4MU4.B8HML3SKIYJ31@se1p216mb1336>

On Fri, Jan 26, 2024 at 11:42:15AM +0000, (학생) 장인규 (컴퓨터공학과) wrote:
> ingyujang25@unist.ac.kr would like to recall the message, "[PATCH] Remove redundant check for usb_generic_driver_probe".
> 

That's not how email works :(

