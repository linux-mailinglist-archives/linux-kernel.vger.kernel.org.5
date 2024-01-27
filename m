Return-Path: <linux-kernel+bounces-41155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8613F83ECB6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8DB284EB1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264871EB3C;
	Sat, 27 Jan 2024 10:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="ebm1eu0k"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43048D51B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706351536; cv=none; b=HtOFMc9+gKX4T6Ky7XmyFPsfW8nWTvbIGQGxRfnG4x8UQF8ULqvp5eKeCDVI7C19GDzP1Uud1XjfdFOGc6ueX9BvC80cxOUtHoRwsHnD5zQImhwtdfby6o06UbG/NpY6AANN0c326E0Qck/to+TSSv2Zq9gRoEFpf2cOhmb6SN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706351536; c=relaxed/simple;
	bh=9QK0Q7SpJNR8tm+Av1rRqAzJ0TA+XkMfzTAYI3Snby0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=BRq8a/NrZbBMZ9Bbl7qvH57cikyzznUWE3ClJrS62I53szBNIpZkZEvW9SiX4wn4In5CZxbcbZfG7Dz9UdK7hZW+JqZaWyt1coRbXPXcrZeU86BfybFh9yKA80bpnb14So4WX6h5Um7CSDkY44Ef9rOFCj4EAIe4LFTxPDxpwRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=ebm1eu0k; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3b1+IhDrNtrODWDnuDZCtfjsEbG4QILA9A9p4AmKWRA=; b=ebm1eu0kqgiGGQjKuYMHP5/hZN
	tfU7wKPGSggpMU64XgNOAiZFZ/gmNj3wddv9l8CsQv20T58dZlxP6W8fkeU5PkzxXl1RsP5VDR4UJ
	65FL8OD2fJqy232I71Z5Yj301uZGk9AOwhVTCmXh3IXfoGbb6UuJ3EyoAuS1MxyKLqOD2ZSJb0Blg
	3fLfAp+OicBI+85OR4AOEZsSkmNm+8iZLSpcP77vQezmkL5cHkNfRq3OmjyGL9ufKxalumB1Za5t6
	omg3+wXyibY/Rpd7jCEMAv5tMI3jD9ARx0kH8je972npYKCEPyzXQtNkkE8CY/AaQPp09FOgf2Jw3
	6awEpgjg==;
Received: from [84.215.119.50] (port=63601 helo=[192.168.0.2])
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rTfyo-00EvjX-7k
	for linux-kernel@vger.kernel.org;
	Sat, 27 Jan 2024 11:32:06 +0100
Message-ID: <3de1c088-115a-4290-aa5c-39fb441e5ef6@cu-phil.org>
Date: Sat, 27 Jan 2024 11:32:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: RS X (Fair Source, @Labour Party Digital Politics)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I also suggest supporting Fair Source, through @Labour Party Digital 
Politics.

The @ is similar to their symbol, and is commonly used in computers, and 
is effective for world wide Fair Source politics.

-Peace!
Ywe.

