Return-Path: <linux-kernel+bounces-149658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D8D8A9421
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540001F2277A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B737867D;
	Thu, 18 Apr 2024 07:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s05+T8s6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4548A745FD;
	Thu, 18 Apr 2024 07:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425665; cv=none; b=nkRRsvk3UH5wz/OxQ6Iqf/+Lb6aehH4uPmGt4qFLi4/4afAXomNMUQsgqUoVCBYAjEieZy/kK6WtjGHOEa5aZJqGAQ455iSFutqODJ69pJBZZgCzsDi18wRf3LrNL42xwvd37DKfWd+afU7KsrdTR7T1/3YtlGzc1Jof0CNb/l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425665; c=relaxed/simple;
	bh=7zuHkDeTHRnat3t3KT7kYt5NR4cdy0BqUrIrBj82y6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkyJid0F3TsmBfw6uwWfFGHWnxH2yEeyH7v2HJ3fksMCPxda2wSZblQUvbLTVtpmTeTyOU3GP6rCXPHhtRHYDXJezYNnVjOcxrC9BakPVK0i5eKQjYWAay6VZYm6FcUS2Oydi5g0vF7AxhdskKqi0+8dEJu45ct23EuNmBmRjY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s05+T8s6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9833C113CC;
	Thu, 18 Apr 2024 07:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713425664;
	bh=7zuHkDeTHRnat3t3KT7kYt5NR4cdy0BqUrIrBj82y6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s05+T8s6k5hqHtS+J1a6UqmMuHvtiuI8tSyLA+yvsvzHNa85k8U0g94r8u6VzXfvS
	 nj0Meva4E8zt5q31eTIJnPYj1qnKxuXfRVe46LDNkaYT/brC+YDKTiDSTv1DQrl39s
	 boc2pVrwdNtgAN8VYTZH7gil+pBf7WRCjcyMGifZrsvDIwGmSiozloXo7uMlRESGHx
	 gimNhZHtqLVxki6YgK4Ni9dV08VgZ4MwPK6AbrMGUhr4S/4U8BolEXYl5nL+TrWj9R
	 PhWR9ELhIOTqYgYGxTvp2Jo3fQwwAq9y5nJhoosin1QrRjdK1lmCpWUN4H4QORtNXL
	 5UGYbGrx4zBCw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rxMHq-000000004Wu-1UnY;
	Thu, 18 Apr 2024 09:34:27 +0200
Date: Thu, 18 Apr 2024 09:34:26 +0200
From: Johan Hovold <johan@kernel.org>
To: Vanillan Wang <vanillanwang@163.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB:serial:option: add Rolling moudles support
Message-ID: <ZiDNAokf_jwUDzH9@hovoldconsulting.com>
References: <20240416100255.22911-1-vanillanwang@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416100255.22911-1-vanillanwang@163.com>

On Tue, Apr 16, 2024 at 06:02:55PM +0800, Vanillan Wang wrote:
> Update the USB serial option driver support for the Rolling
> LTE modules.

Now applied, thanks.

Johan

