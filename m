Return-Path: <linux-kernel+bounces-31067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B86832841
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35D5BB227F0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7924C602;
	Fri, 19 Jan 2024 11:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="gXOAHKO6"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662303C464
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705662074; cv=none; b=ibR7xj8Z4gxenIWjeX769ISr1rsRaTexFw4UFaXMuRUCRIdFTcOdnubW3nbIqJ+9w25b4YUMKnRsDPw22Lk6PKiGHMag/rCujvjfhbaa5E4G95Wp/uQXEPmKqv80/CnJAocr5vLYDbZ6reRfZRdQh55KDym0ZIBJmmTYm2xaTxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705662074; c=relaxed/simple;
	bh=w5wBDo8jUiYzz+5J3il+LC9xZdfbGnzBJXcrQQHkLzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UGQlAG0rmwrU2Yr8oWdIWkIoSCJ4FC9zc4vulG4yAvgn0jdVQ6SRDPkaKOSC5ZngUEi9KP1GCK5lt+ntFCAdGo6nYSAujLE8oUMa9MyBC+YTB9u9IvxI6vESrTwWPRCV25D513J5SyGjksNt3mZEVF9oFGrWbeDN8LFz4xdyOMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=gXOAHKO6; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=b6VkcU727MKQow5IhybOt1tkD+yKTAqrwjsZRcJZP2g=; b=gXOAHKO6FRDplvXdFDNzwxNJq9
	wV9oO87QjA1bRFiSyF7PoiyDi5SzWl6/MXdYXELlQdi38HCotn8doggvAhM9vGd2eUXrD5kd7/rMf
	4fy7ZbixepusSp6G6pX8ub5p0h+R/vTdA/mrh0lxAV/oLGDXQusdFO1lDjtcem4Q14sxNv/KuhNhd
	4WzE3cBVS9Xx8ZbX/gwuz7MZib++AXQIzjMUxwx1KWNhspb2fPf35gx9e816cGF1um9q8F1R933zC
	Fa1cSXFziq/JTUwqQ05iiU3hKWMy48YfETi3oaOT1FTQHYJ05SIDmtRWh2y8Bb+jq8smwr49ny+Ca
	iQk2akEQ==;
Received: from [84.215.119.50] (port=58153 helo=[192.168.0.2])
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rQlGr-000OQt-F9
	for linux-kernel@vger.kernel.org;
	Fri, 19 Jan 2024 10:34:41 +0100
Message-ID: <e25d240b-67f1-44fe-97f1-02fbdd76c721@cu-phil.org>
Date: Fri, 19 Jan 2024 10:34:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Bit X (was Fair Source etc)
To: linux-kernel@vger.kernel.org
References: <92a99f69-3c6d-4c9b-b16c-19da17943eae@cu-phil.org>
 <E1rPzsA-003sTD-Lh@smtp.domeneshop.no>
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
In-Reply-To: <E1rPzsA-003sTD-Lh@smtp.domeneshop.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I have gotten an apology for the Apple Faux Pa.

Project is generalized to Bit X.

Channels: TBL Preacher - https://www.youtube.com/@I_T_San/  (will be 
updated to TBL Pracher)

Muclim: https://www.youtube.com/@Ywe_Caerlyn_Norway/videos

-Peace.

