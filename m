Return-Path: <linux-kernel+bounces-151178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CCD8AAAAC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D5F28174B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1A260263;
	Fri, 19 Apr 2024 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b="n1FXLGFC"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E99E6FB0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515898; cv=none; b=l6eOya3HvRMM/8Z0YiZsb3pBOqkMAkgS72ifUQ4Now8cuTd4at7M8FRX1FAYCLmVCamSQZM3rlyVbg0+Z/fMGbnHaXfsan1QIqGZ2XtpvJFqEDJialCbHGUCN+B82KyA2+GLQaTUSo+aCFOEjK5VobzF3K/Yvv9FALVBkM1ZDSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515898; c=relaxed/simple;
	bh=eVZBx4h141+zjU08UlUkEhXS9nGW3nLC5M5uQEi7F5s=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=epYKDa9yQesXa+O1swm5yeeZvTUUXEK2lhizrdL8+tcOdwcxw8PEhwLVHaz5Tm5DR2rgXiteNJ+Dn7oXlJiZ7U4ulDSujNar/9giyQ0b0FhmzL40hFr9BQXsJ3P3Ne2xGOvGp+3/8P8PiY8KFFd8J7yCxHyre8IIiaeN6+IvVUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net; spf=pass smtp.mailfrom=malaika-12.net; dkim=pass (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b=n1FXLGFC; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malaika-12.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=malaika-12.net; s=ds202404; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yOoxuQ+VIpS6XDeyHx/0IQjOzGO1bVkR60VGLRlmgbU=; b=n1FXLGFC7skG/L6T7zc+CSbKQP
	N7VWnXOjD6EYzaIcFk6en6t9ZGQFbJs9ntFmf0Xq5iTUjbCkjCEE21Vyix9CEe8CTaRr66HArbrSi
	45nvWEAtPUBuTTVeBgT9lX4QYgbcMQOdHKT7T6Scyevg0M+JWkoi6q8CY+c7BZ0YeP+gy2U83WtFe
	BeHITN2gkgtUgXGMvaE7UrPjZc9sgQP8WzAMGzlkIEdBHeNlxQ1RkBBFLwoLIulZq+sjJzm3eIjNk
	nWqAcgpXdw7zZW9OEYEfumrTOd6jMaECDGkDtN6/ks7EGb2hvP4wO0ddejGcj16lcEc6p+K7eSAoG
	uLkJzWmQ==;
Received: from [2a02:fe1:7001:f100:3536:9f4c:2e82:13a7] (port=55839)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <muslim-bit@malaika-12.net>)
	id 1rxjl2-001Mxk-1A
	for linux-kernel@vger.kernel.org;
	Fri, 19 Apr 2024 10:38:08 +0200
Message-ID: <6cb0eea6-7467-4482-ac7f-287794a42d6c@malaika-12.net>
Date: Fri, 19 Apr 2024 10:38:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <muslim-bit@malaika-12.net>
Subject: Refined Summary, Previous Mails Phase Out.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Yes, I have moved domain, and refined my summary in my project Muslim Bit.

Which is the Muslim Bit in stream culture. (Being a macro for this aswell.)

Particulary on this list, and related people, I think one subconsciously 
has been with Haq, a name of The Divine for this, and it has become a 
more conscious thing.

Everything here can be designed according to Haq, and it is an instant 
association to intelligence, that many prefer here, including myself.

Interested, please see https://www.youtube.com/@Ywe_C4rlyn

Peace.

