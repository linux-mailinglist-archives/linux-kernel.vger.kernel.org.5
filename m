Return-Path: <linux-kernel+bounces-82498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F1B868563
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC391F22C19
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC184A29;
	Tue, 27 Feb 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABy4x6rB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906FF1FBB;
	Tue, 27 Feb 2024 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995628; cv=none; b=YQSLEjSzH1Tr8pTRB1Jgq0jri6R0mec21lTm3+nqIlyikoi5K2INNCzpqbQnrXGTyFj1bFYuVujZ9/WqyK85naFKJIYXcDfC5tVWom+YLcxawTYBUfy2K32dWIUi7zeWiplD8iBb6s2hFy3LBe+DoqtT8FT4cI0opMjsbketJkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995628; c=relaxed/simple;
	bh=WUHMokbLfgIQlKeQ/UYNE/AJllDQMsUUuSpCB2Q9IUs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=igUA7Bll+vJVyybPQwmQWwgjFyM2VOOZkwEDOd7P2qFDRteo/CItFSByDx6YGJi3SMZ802k+5ab2CJcuCnZyidV1XCKv4qwFAn2kW+Y1lQS1NjaOZc9XqGDZkAy19BvSzlQrRSu5ZQDiBQNdjbn6oTMMzsX/f8w1JlhTvsNxtgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABy4x6rB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F74C433C7;
	Tue, 27 Feb 2024 01:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708995628;
	bh=WUHMokbLfgIQlKeQ/UYNE/AJllDQMsUUuSpCB2Q9IUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ABy4x6rBL7/NK/oOYPprxXAegn58ROo7DErl6FKueMFUsbONkuaAlACsY+Wq0aZr4
	 fDh3f9hdpTOPo6yCXzEBoNeJQcch3qPRhohv1Su5fuWD81xQVKzxA03wg+imlao6hW
	 CBRvjLnD5darj9sXA76ChbBBqFojPMESVZ74Oj01aDNI/THE9StvjvMuEeehQMKMpE
	 UXWi4tki0cLFnfR5ZTkN4IY37gFR6KhoF7B+20ADvk9j2Y9naxJ5/LpzqxiaNjZZHt
	 Oq2QSZmh8gcVISnq1JGnbUE8eWymzB/8jM27cZfdyBr9QDdGwRue/iu8N8iO8hz7ic
	 NJZ9HcxXgmFYA==
Date: Mon, 26 Feb 2024 17:00:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
 <sbhatta@marvell.com>, <gakula@marvell.com>, <sgoutham@marvell.com>
Subject: Re: [net-next PatchV2] octeontx2-pf: Add support to read eeprom
 information
Message-ID: <20240226170027.6a43f196@kernel.org>
In-Reply-To: <20240222171542.12995-1-hkelam@marvell.com>
References: <20240222171542.12995-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 22:45:42 +0530 Hariprasad Kelam wrote:
> +	if (!ee->len || ((ee->len + ee->offset) > SFP_EEPROM_SIZE))
> +		return -EINVAL;

Are you sure there's a path thru the core to the driver which would
allow len == 0 or the size being larger than when info put in
eeprom_len?
-- 
pw-bot: cr

