Return-Path: <linux-kernel+bounces-159443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3353C8B2EAD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5171C22203
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45433D72;
	Fri, 26 Apr 2024 02:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7SC2CJ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F351852;
	Fri, 26 Apr 2024 02:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714098458; cv=none; b=kAAjToE3cGi/gxtTLOdF8NG87YEEXvRBsG3YvT57rvtMnoIuGq99aPoC4KgyWq99p5bhVi/lAG5Im7B9K+H7nW2iqRa9jdtckmEVqQoPRAbbfSFkf+OQRwwZK7lMiuVAVBEWWQRtNvCf+8VIvwsaIWOwePaWjhPmAHX3mGczKxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714098458; c=relaxed/simple;
	bh=BJf8IoTWPKKp8pZCLq+Aw61YGrZL+pSOoH/ELqROhOk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RTy0yjxKrB+zFZ1/vuDBxBXelw39ujMvw5frWyBs1lZuTH7WRaSMlwDbpg5lLLUvT3ZXv4FBWkYK/xdRibYxvHDBKrxM1C+5ZbrCp8sPE5W1SYKFspnL4tYbx0JAiJ7t2xROFriTpSNcNN0sXJ+cbAwW0p9PAKQyCwNlKCXhHYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7SC2CJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046B6C113CC;
	Fri, 26 Apr 2024 02:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714098457;
	bh=BJf8IoTWPKKp8pZCLq+Aw61YGrZL+pSOoH/ELqROhOk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r7SC2CJ5l5tLUinzhNo/acGM8DSG71Iah5g3rze7ipQv5k/EDubJHir1aLnalrLWC
	 ut7Ll5eA698wYXM5Il+zEjrugBwGC7p0LhwrW0Htj3b2Rbrw3S9qtSjrThkqCmiv8n
	 OpRPWaSsTBRTUM2QggZ4EfkO2KvMtDaQUg3XxIswsr0UrcMzfdPbnKAtWCHABqXDnM
	 mM6KAe72fK/3hc8LqrMeMViguKwH1+SYL8dTXOFmW2Hf3ozAlZspUnw0C+nJgFGPtH
	 W5MScgs60/RlkB9wpZMjHOYT8J4tfXN43iwdkVrqw6vuxP1R4zJaeiqGH1CsoiuU1L
	 gpZgJbkbcm/bA==
Date: Thu, 25 Apr 2024 19:27:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next 0/2] net: dsa: adjust_link removal
Message-ID: <20240425192735.029eba34@kernel.org>
In-Reply-To: <20240425185336.2084871-1-florian.fainelli@broadcom.com>
References: <20240425185336.2084871-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 11:53:34 -0700 Florian Fainelli wrote:
> Now that the last in-tree driver (b53) has been converted to PHYLINK, we
> can get rid of all of code that catered to working with drivers
> implementing only PHYLIB's adjust_link callback.

more to delete:

net/dsa/port.c:1600:21: warning: variable 'phydev' set but not used [-Wunused-but-set-variable]
 1600 |         struct phy_device *phydev = NULL;
      |                            ^
-- 
pw-bot: cr

