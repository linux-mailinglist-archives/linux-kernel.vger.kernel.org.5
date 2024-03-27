Return-Path: <linux-kernel+bounces-121354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA77488E6A1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E5C1C2E17B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F8013A898;
	Wed, 27 Mar 2024 13:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="DXzdLnNc"
Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9190412F5A5
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545291; cv=none; b=JVtbhIC6YIMrZHvSlsD3Xe6TOHLNtOnj7HWkOOGQHTEyY5cePOpaDaRFwdEHQm5ogO/tWFOsArtwupTeWHg1Ur8s15Zn6K+fJ7OFaQR/tQujCkuGMuu+NbBKNZ45TAdMq9be2IuFpm2QQfyyI0WCosUusaer3thiMCEdEqSe/yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545291; c=relaxed/simple;
	bh=TOEt7NDlOzbhp3OWTMYMxE+SKIS6GLlRHFrW95kBiQI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=MTZTRfXu1sjzKH5IvKUtpYDwgH1nuFEUu6/9NpbTDHmiuLzRO4IkNTarUg/d79AZuAmDKS6RkUZ/ZEEJU8DDswJqiWjmWK1U+Xrt0jpr8KJmTdMN1QkMN8fHsT1pg8ZgX5sSDPma/wAcssK1m05Ntzq3evE1bIDa7mi3T8K4J+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=DXzdLnNc; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 86A40429E5C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:14:39 +0100 (CET)
Received: from [IPV6:2a01:cb08:8dcf:1a00:16f6:d8ff:fe12:3306] (unknown [IPv6:2a01:cb08:8dcf:1a00:16f6:d8ff:fe12:3306])
	(Authenticated sender: eric.valette@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 4EA9C2003C1;
	Wed, 27 Mar 2024 14:14:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1711545271;
	bh=TOEt7NDlOzbhp3OWTMYMxE+SKIS6GLlRHFrW95kBiQI=;
	h=Date:Reply-To:To:Cc:From:Subject:From;
	b=DXzdLnNc/InZx1K70Nvu4qe3UaNT6mzy/8ZbrObKbF7ofRtdyvplJPS9kiU8/hJS2
	 3NDfgy/wU4dUtt/ln2mSrg8gwKmugic08BmqB5u+3v3SHMWqZTQEhFY8nFDU29cMLb
	 bFx4qzojgH0CKpAlZMKlqM2fLuSzaQUSAKbl8DBY68MUF77u0+aOiBJrskkwFvDpug
	 c6k1LauUJwxZhhLuytmvwKYJJwoiFFVD+Mhsi66PGbaVv0RvW7XCkRbL0Hqux9Zwo7
	 tqMPdE3tH+J71exlaT+0A44MA3rgDe8kmaq6xF70ga4L961ghzTh10f5+oaA78VzPx
	 18aToafv9pWGg==
Message-ID: <878ae145-ad1f-4b48-abe3-2966a1c9a0da@free.fr>
Date: Wed, 27 Mar 2024 14:14:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.valette@free.fr
Content-Language: fr
To: luiz.von.dentz@intel.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Eric Valette <eric.valette@free.fr>
Subject: your recently submitted patch to fix BT RIP error shall be applied to
 6.6 stable (I have a systematic crash on reboot in 6.6.23)
Autocrypt: addr=eric.valette@free.fr; keydata=
 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
 wycNoa755G2xgOMORgXEMg==
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

hci_cmd_sync_cancel_sync shall check the error passed to it since it
will be propagated using req_result which is __u32 it needs to be
properly set to a positive value if it was passed as negative othertise
IS_ERR will not trigger as -(errno) would be converted to a positive
value.

https://patchwork.kernel.org/project/bluetooth/patch/20240326164317.1460864-1-luiz.dentz@gmail.com/

On my MSI laptop, on coldboot I have no bt errors but when I restart I 
alway get qeveral (firmware download error, ...). Without your proposed 
patch, I get a systematic RIP when rebooting, and after the laptop does 
not properly shutdown.

Your patch applies with offsets.

-- eric

