Return-Path: <linux-kernel+bounces-63170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13234852BDB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4DC1F24970
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3E22231C;
	Tue, 13 Feb 2024 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="uLsLAA3G"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1912208B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814962; cv=none; b=DqtVy0ZYqTQqkqHw0jBGgvVea/Yvn60tZMO/i4rQ3MYdSXCQdny50TmCHQfsxAOOqdUzcj5xFjaKRnWnGWULHWBoyS3mGt02LOcS+p7Ysk/lnJIqj8UjEXUjkWOjFhP2I+ohGylvkaBD1drEPagdBYfgTC/mKiuE7bzlFSkUF3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814962; c=relaxed/simple;
	bh=orVYcdyRcnQknojR9Yg0q6K/Wu6t21i//3w7lBTQji0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=lL19Kqpj8WVO6/60FG9ABJN+pXT7iTWyyjfgerDViEepcM7TGnAJ/cvzVagkqF0XrkuX0rhPJTpDxJ1J56PTjGsDOGJMQvphvCeE0jlFPI63q52U6Sp3BiMSbgjVhjb8LXD9lLfo1DVxGdYSN+PXGrvZj7f14HeTrMq6DWH2Mmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=uLsLAA3G; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wo2SR45CpD8NZvzrgfJadquhdZjSh4U+1xLtXcWk4yU=; b=uLsLAA3Gxnws62O3FlSTTlcTLG
	jgvWYUDo9V6qZ6HANxcy1t1KTDSnMi4pB07bjwfrjySj6LVvEz3m3OGCIbbYeNltN7sH2tV3SPm4i
	Jk2LQfALoUGfn50VpDbSsadzLA25KjbNoO1RXTT4mrJPpnc9qK222Sq16TJWp+Y+/n8+Sa2kIemtS
	YfXjiDechgOTfZs6/5Uc7SAuNzJyhKOMJZbIoxbcPugtswZh35V/Y551xBA5xbaCYjQXb+mUbTyBD
	4Hmw1dwDhHV72y91JTRGkriHdHBqZH03jtglPp/R5fBIcx0UCvJX25f0jWgHU5yl4BXCl+e3tezL6
	UbqnMhsQ==;
Received: from [2a02:fe1:7001:f100:30e7:15af:f3dc:72b5] (port=60182)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rZogY-00CepF-N8
	for linux-kernel@vger.kernel.org;
	Tue, 13 Feb 2024 10:02:38 +0100
Message-ID: <30287a8a-e2fe-4c40-987f-f47f32ccf8ca@cu-phil.org>
Date: Tue, 13 Feb 2024 10:02:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: @ X (Referance Unix derivative) vs Fathers O S (Temple O S)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Yes, I thought some more about this, and have an example polarization 
aswell.

While @ X, has Iclam as background for Fair Pay philosophy, and @ 
basically represents the quranic deity for this, the other side 
typically would be christian and Fathers O S (was TempleOS).

This seems to be the theoretical polarization coming.

Terry Davis himself walked in front of a train, a few years back. Could 
it be a crucifictional allegory?

PEACE.
Ywe Cærlyn
https://www.youtube.com/@Ywe_Caerlyn_Norway (Saint Bit)
https://www.youtube.com/@Martian_Elw (Ban Bukhari)




