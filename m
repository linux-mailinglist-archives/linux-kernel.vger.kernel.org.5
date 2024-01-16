Return-Path: <linux-kernel+bounces-28374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B832682FDB9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 00:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528EE2933FE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A827A1D526;
	Tue, 16 Jan 2024 23:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="OrkzfHxm"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978851BF25
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 23:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705447162; cv=none; b=fdFvAGm2VxfX2SB9bLnPY7AxWKjFiimIAhl2MBs8Yko331lIIVcoaprEBtYyZ4rW6rIvtla+hZrd8fJBPxMxiWfck8ZSHMEe98MaTUloYn9aC17P2Px0mqTJ+uAb9iqphozFmd8x1XmXUNVUZdEDMOIf/5/wj3/VrAhw7y7USX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705447162; c=relaxed/simple;
	bh=f61yTArnZb+nFtlOTO6rgvVxaYCJzUt/4hApF6yDLFc=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 To:From:Subject:Content-Type:Content-Transfer-Encoding; b=XbGnnlcuMcwbl1csdQqNU/bdZlYjs8oXe1Atj1pZbW+Hvugm6cn+uCpvu5oTrUz7sIiA0EdfOS118PRqLs16u3k81XEB7BSjDBdRgGVJ6CyTUx1kyJrdvydrmpecBs7YNVanrTngXLux9NmI+6QI78XDWzyZv+oPZxMKbAtdM+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=OrkzfHxm; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=40Wsj2ZEQ7JWfWYichK13LSJb23DRyouOF7OUSYPSzM=; b=OrkzfHxmeTcmJ8jUYhr76kbagf
	33VZ2Z9sI4RoyPPAPrfWyxTJ+wdXqlLqH0e4DmziBqmkir8n+P6c25Gt31yt4kxKAzuJHQHeujoDQ
	DjPSXJF7R7vHbfvHOa2BsL/nNdAKWKSucdg3B6h8vtclgyatDCpdS8R8J6P0MUL2YYPMFSLq6VGSg
	QFo/hBVgqwDvNAHQ8oP5cjuOKiRzGZHiC34kLH/tI2hgJ+bb6rvVOg0+uvy8GA4i6KwM9mWby7/y9
	yY+NzaAj6HsTP8a3k88IeSF6uZQEEtUsMHUY36qtz0j47WeiXAY9xo+7kASddq8W+E+L0KfvIKOni
	e5wwKBag==;
Received: from [84.215.119.50] (port=58267 helo=[192.168.0.2])
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rPsiE-002xxO-HV
	for linux-kernel@vger.kernel.org;
	Wed, 17 Jan 2024 00:19:18 +0100
Message-ID: <3b3fa3e2-74a5-426d-a973-a92dea95b94b@cu-phil.org>
Date: Wed, 17 Jan 2024 00:19:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: Lumix, Fair Source O S with Iclamic basis (was low-jitter,
 philosophy, design concept etc)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Ultimately it seem we find the concept Lumi here. A common problem in 
the west, and after hippie culture is the association of hashish with 
Light (Lum). Lumi means follower of The Light, and actually is a very 
correct concept for this. Lumix means a system based on a follower of 
The Light.

Then the other pary takes the responsibility for that association, and 
all the wrongs associated.

This gives us max fair source angle, and the other a major disadvantage 
if they continue idolatry and association of hashsh with Lum. (Such as 
typical "Forbidden Apple" culture.

This should be completely fair.

Ywe,
Philosophy,
https://cu-phil.org/

