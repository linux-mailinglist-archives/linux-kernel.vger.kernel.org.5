Return-Path: <linux-kernel+bounces-21646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D313829248
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D42C2890A7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368CA1871;
	Wed, 10 Jan 2024 02:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3A6QFWT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCE717C6;
	Wed, 10 Jan 2024 02:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D0DC433C7;
	Wed, 10 Jan 2024 02:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704852198;
	bh=FQtc/I0eA1ah0uKL/FsnBl/tf4MyK0Hm9UMLc2w9s4k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B3A6QFWTfx+wTKZZYUwu2q+HCZSXWReQFq10mMtVDd7AaMdmEF1YV28zwi4w0pxSD
	 5A/T5lZZrYay+Sxy4Jj5DzqONi8MxrZmvWBKAw1+j9Oy+0nqmUG5GDxc1nf4yOLam0
	 e/90y5MRzKkwOfSz5FqLROmUz7xqMLL9ZXx68FcTNkvtKmd3gOHdBBhLZfi8vNN98H
	 oU9c1O99LpU2VtE/aWsGgQF/4IPkqjp7D/2SEpUSdmgQGu7dUo8AhqjlqtyX614NiU
	 d8iTWdtRC6sMCM7A4yX9vz3jnQ4SqitCurEK+KqietGQyNSskAUMmSpyD11cYPzczf
	 lqyJPH3/oofkg==
Date: Tue, 9 Jan 2024 18:03:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, "Christian
 =?UTF-8?B?S8O2bmln?=" <christian.koenig@amd.com>, Shakeel Butt
 <shakeelb@google.com>, Yunsheng Lin <linyunsheng@huawei.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [RFC PATCH net-next v5 0/2] Abstract page from net stack
Message-ID: <20240109180316.3a52764c@kernel.org>
In-Reply-To: <20240109011455.1061529-1-almasrymina@google.com>
References: <20240109011455.1061529-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Jan 2024 17:14:50 -0800 Mina Almasry wrote:
> Changes in RFC v5:
> - RFC due to merge window
> - Changed netmem to __bitwise unsigned long.


LGTM, thanks!

