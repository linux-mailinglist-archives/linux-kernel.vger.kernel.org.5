Return-Path: <linux-kernel+bounces-127620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2940894E7C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71AEAB23F6E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B5C57874;
	Tue,  2 Apr 2024 09:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxedo.de header.i=@tuxedo.de header.b="GcHIsoiF"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFE156766;
	Tue,  2 Apr 2024 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712049478; cv=none; b=ZAJz/oTAxzs/pS7OYWU1og8pqeVrs63LjyN5yD8yNhdpm40jp0dMO3LnoFgdv79TbfjiyTPZ6TCkPXzCaKa0zblgw2ubOIHeTcoMqu97PbHMVzQLZFzsmLkfM5SWAVS+gGFCmGkiRM0V3r6ALT42tqnvrVy3qhP2138lIQJZbus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712049478; c=relaxed/simple;
	bh=kLCMaKI7+BrwnnoGSoIuNn+cbwCpoIeucymr6iUKRhE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=eZ45YYyh8LXPzS/aVjgRCHx4f7gMCXqIgY5L7LzNjUjhznSu7wVCb5OlcxKarBQNnLtpIub5L/MR6vmFbuJghcLl1ppBYroCOe/BgwIcH9pHAvHizsY9P4kRquS5Qv+u88d0VBAefYF6NpkEnz4Oi1c6ITszbD/Sf9C7PAEnAl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tuxedo.de; spf=pass smtp.mailfrom=tuxedo.de; dkim=pass (2048-bit key) header.d=tuxedo.de header.i=@tuxedo.de header.b=GcHIsoiF; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tuxedo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedo.de
Received: from mail.tuxedocomputers.com (localhost [IPv6:::1])
	(Authenticated sender: cs@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 22F882FC0063;
	Tue,  2 Apr 2024 11:17:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedo.de; s=default;
	t=1712049465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5tY6k0ZLmkz6XkazdkXb7L0Y1vhdIIAYIiiPQmk3pw=;
	b=GcHIsoiFc+ZblluRqBR8ChHfyO3RZRLyzX3G8s695s/pz+iG7JVOzGRxXK7g/2TvJbgZ90
	IqXvzCP+0j4GO1HDKw7OWTYTTWC+DDxdkxLdi5c1qOA4xoNOzfCIXzaNqVv1oDAr8gb7nW
	LOVaBBRhYIEGH/ZIJYvlCVgA27IwR6MukiulNo1yc2obtLJsa+Bj0RtYcVMu49JKsXxAeT
	evVpf2Hgls7lBkjmuE4KFEgeHTDBtrewnz5dh6rcze4jBP8+Fedt15l785cE+Tt1nG9WDd
	H3ZvDx1arQOYQoD7RYIgU7Ptr3L/gbqzGN2q5vvCIlXNiFF1yNBHd2AxCHk0/A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 02 Apr 2024 11:17:45 +0200
From: Christoffer Sandberg <cs@tuxedo.de>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Werner Sembach <wse@tuxedocomputers.com>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Christoffer Sandberg <cs@tuxedo.de>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btintel: Add devices to
 HCI_QUIRK_BROKEN_LE_CODED
In-Reply-To: <ee6259a2-05c3-4d6d-9dda-7a7b8f55fbfe@molgen.mpg.de>
References: <20240328131800.63328-1-wse@tuxedocomputers.com>
 <ee6259a2-05c3-4d6d-9dda-7a7b8f55fbfe@molgen.mpg.de>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <bda6baa41b6b4511830603138d896add@tuxedocomputers.com>
X-Sender: cs@tuxedo.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Dear Paul,

On 28.3.2024 14:23, Paul Menzel wrote:
> On what hardware with what clients do you experience this exactly?
> 

The wifi/bluetooth modules AX201, AX210 and AX211 (cases 0x18, 0x17 and 
0x19 respectively) used in various notebook devices started having 
issues as of the patch that enabled le coded phy in the driver. (We also 
use AX200, however without issue.)

Noted behaviour as of the issues: Device scan took longer and when it 
did find a device connection often failed or timed out.

I do not know if a special type of bluetooth client is affected. It was 
partially tested by looking at the difference in enumeration of the 
current mix of bluetooth clients in the area (where you could clearly 
see the difference at a glance) and with one specific device.  A 
bluetooth connected watercooling system (TUXEDO Aquaris or 
LCT21001/LCT22002) where a test case showed the mentioned issues.

Best regards,

Christoffer

