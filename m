Return-Path: <linux-kernel+bounces-21830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AC78294F1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D5742870A5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CB63DB85;
	Wed, 10 Jan 2024 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q87NB7Nr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BC83C461;
	Wed, 10 Jan 2024 08:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28E7C433F1;
	Wed, 10 Jan 2024 08:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704874882;
	bh=AoyiDQNyGKArSyTegD9rbvPIsc9ycTG3LPn2hasix6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q87NB7Nrwsd3zdRdDPzk2XuMg3YDfbviR8DKaYuxX/JB1gMJLkuMj+hve4nb6I6/R
	 4oRRv9q1A5hVO8UjjjoVJ0gJiYu/qeXvuiGbvMDWKBXL/o+tqTiPEOQN4JEMY5coNQ
	 Pe0fiOo9vZ+rDhxVY4BplEridHW82vyzE1eh8ZUM=
Date: Wed, 10 Jan 2024 09:21:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: chenguohua@jari.cn
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] vt: Clean up errors in vt_kern.h
Message-ID: <2024011050-reviver-monologue-f7e1@gregkh>
References: <32f27893.e2a.18cf263f008.Coremail.chenguohua@jari.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32f27893.e2a.18cf263f008.Coremail.chenguohua@jari.cn>

On Wed, Jan 10, 2024 at 04:01:25PM +0800, chenguohua@jari.cn wrote:
> Fix the following errors reported by checkpatch:
> 
> ERROR: "foo * bar" should be "foo *bar"
> 
> Signed-off-by: GuoHua Chen <chenguohua@jari.cn>

The subject line should say "checkpatch" as this is not a "real" error,
but rather just a coding style issue.

thanks,

greg k-h

