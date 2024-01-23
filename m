Return-Path: <linux-kernel+bounces-34842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0358583882F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E83BB23400
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2B352F78;
	Tue, 23 Jan 2024 07:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="04PJ60Q4"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490F73611E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705995872; cv=none; b=FbRYe7eeS7iG1j1MnP+lgS1FnDhIxugMOj3DtDI0YTfmaeESBGRaZbcaTNenujVu989nBQhpdBaEIiClLm0kfyvlft3DeLJ0q7f5Xl4C6LwziA03IPSEpMos8/jZyiIfZcFnQXsrpki6RPO0Nb/vnDiJ3i1fo5pW2DvdPonyPOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705995872; c=relaxed/simple;
	bh=g/srj6jn3K/tdUS3c1QRgkBmADbAAqPbbpwE0SoAzLE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=XkpGwrmyHlvXbJrfSdb2C2Me7mksrusS2uJa+Z+ABVb4ZYYMpVtFiYtUWmI7ke9pj7rzofSrcskF0kI+N+DtXEr9Ws5fuDObL8jBKqNYmncxKMEQifxXJEtAT+xvRSC8JL1WGqqF/H4eqwrxcloSSbKY/QZHxZ5tiI10uhqf0Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=04PJ60Q4; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1wz/nVmuAhBhUlkJO/EV9XyX4sbyzcaSjJ1CTeCMeLY=; b=04PJ60Q4CazmZS+h3NFXbqeooe
	nqtR58YU6xl3SYoMuJsxV3l0o12EvNDTlBHRGkR/nPOe13f597XythPFGLt729xDLClQJUDPPbJrl
	KvF1sc9n8Sr2foy7vo/re2wZeFdxT/Zmq+V++l+kaiA3ihhYcLZpATaMcZ5dsasl1MlXB11Yk72mv
	+iemvTyRzNQZt3dE4bPJJtT8+XM9PEq4euP6txKw++ZMXCr+lxiH2x+dnHrmURfeli0N3c0cZqdiY
	XpgG6CBkKTFiyv6vt8KARC25MiG9prn70akh7fF5j4zlNVdkg6+obYctQ0L+1s94yh6VNoEJxgfm8
	ooZO+giw==;
Received: from [84.215.119.50] (port=54185 helo=[192.168.0.2])
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rSBSO-00324a-3o
	for linux-kernel@vger.kernel.org;
	Tue, 23 Jan 2024 08:44:28 +0100
Message-ID: <7bb397c6-115d-46ae-8de0-dec1a1334e77@cu-phil.org>
Date: Tue, 23 Jan 2024 08:44:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: Xo (a last development in design concept, was fair pay philosophy,
 low jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I iterated the last post to Xo. It is now a self contained concept for 
all things involved.

-Peace.

https://www.youtube.com/@Ywe_Caerlyn_Norway/ (muclim)

https://www.youtube.com/channel/UCR6KAPt98kGaXbfa7enQ_KA (lucifer)

https://cu-phil.org/



