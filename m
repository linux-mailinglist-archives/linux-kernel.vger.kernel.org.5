Return-Path: <linux-kernel+bounces-155393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 083698AE9C5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CFF51F237EA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E9486252;
	Tue, 23 Apr 2024 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="meaQqK4b"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0141B8F5E;
	Tue, 23 Apr 2024 14:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713883476; cv=none; b=Ng+MkzttRR9o9sc54BqJo6hUA5iTjSYEo2O01Kvi5sG9zByMEQXV7Gw24WOdDUTE3H9SuZLWS3gbRBqaVUhZbJ5uDg7YezU8V2/bg6nmwK1htYoBUfn7WJ08eGl8zX5jiZhKEGCsRLJXsG7roHLoni9CMGPDoH6DzSL739QAnsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713883476; c=relaxed/simple;
	bh=pLbxaU0AKdPvsF6TD0ECcoKEmob8RZhh6JpyucudSCE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rC2oNe3n3SBsgW8vJ1/MkVG/LAk+lAPxrNkyeCZsz0T3eJk/DND8oLf4sTCAAeNPFWyLygvsrrXrjuLy/52AWNbRsYXzYh2ggIPT4imM4oBbHO1qremB8rhuwjOybY3ayUx3b2gU6brwM0g6i6Pz4uiMkcTKGKhEFTjcESUN2BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=meaQqK4b; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E98B147C41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1713883466; bh=pLbxaU0AKdPvsF6TD0ECcoKEmob8RZhh6JpyucudSCE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=meaQqK4bg5NDlvMOio4WWPgkLTkcdI3yQoQBi3hF84WFoUXUOxDoeyMgD8PE6AN6o
	 97nmneXBxp5I94Vb5tAjHU4/fesP8IyRKhWWHRzoSu4NcI1ZhgTzuBh3yF70M2r67l
	 aSyBf4V1l85Z+bss8RrFD+pnWZ9bP2/hDxKwmbk10phqBGqjTBHYzqC4UBO4TBAvdJ
	 isOZBtyZwaoAaVLsaZ1D1cIRcr4Q34EnyerQNPwiSCyt5Lu4Cb1nE1/1hmm8x3oPXJ
	 ogXtLAY0BsK0ib9+ydGSZyJ63BM0kkONRln89KCCC7ahERv+dfA6cLisxd7T9xzx4V
	 kypCvw0HoeJ0g==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E98B147C41;
	Tue, 23 Apr 2024 14:44:25 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jani Nikula
 <jani.nikula@intel.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] Documentation: process: Recommend to put Cc:
 tags after cutter '---' line
In-Reply-To: <ZifHnw1cxgP77MKx@smile.fi.intel.com>
References: <20240423132024.2368662-1-andriy.shevchenko@linux.intel.com>
 <20240423132024.2368662-3-andriy.shevchenko@linux.intel.com>
 <871q6wrw12.fsf@intel.com> <ZifHnw1cxgP77MKx@smile.fi.intel.com>
Date: Tue, 23 Apr 2024 08:44:24 -0600
Message-ID: <878r14yw8n.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

>> A lot of patches get sent with
>> more Cc's in the mail message than in the commit message.
>
> Note, this is the recommendation as it's stated. You can continue polluting
> the environment on your wish.

The environmental case here is ... not strong.

I, too, have my doubts about this recommendation; responding this way is
not going to change a lot of minds, IMO.

Thanks,

jon

