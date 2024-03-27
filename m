Return-Path: <linux-kernel+bounces-121845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB55B88EE6E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECDF11C3255C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEF71514CC;
	Wed, 27 Mar 2024 18:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="B8ZYBetV"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F991514C0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565046; cv=none; b=U/4A76s1v6C1ol7IHbW1UDf77ZParCWgZmXVI1s//0EHl1fY3qmWpUmzXlnyWKQ8SOpf2uYOdUoKZ0tWWzyuGX3ZJZQI0pa0ICqKi3JQ796hLdaYnQ4MxtykcfZuRkT2SXGwtc3pe5jy2kYeCNh6q5boiq4qxxKJhNFxJ2PXc9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565046; c=relaxed/simple;
	bh=3TmtQ735r7WgWfIIqB776WPFmt6m+85NN50GBGx1noo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=MDhYUJ9ZJw1WT0aoLPzGtY0El97RLPvFt4x7JgjGyxGb18BTyD0L7uhj8jQN3vdQUCvIVOnrEAgxZ0koFH2WBUX9MD99gDFmsHy63aDiFoLGelPAK8hZzyCx1tlTl3zZ7ZN9YfahtS2q1+x8LSWvQN2CxtUJBIBXztJPSYPcWCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=B8ZYBetV; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DKN9t5aaMid79XIt87Veb/1lDxP9ceGWOEpKJiBzlbM=; b=B8ZYBetV+GGT6eQRWFU5z+zcDn
	R+6e+pyIe5P//gytX6QNxHsA3RKgY8+mdE5ySHkgFaljx+5CJtG9qFIx59+TweF8c8eGe8I8EuDGW
	JlIlDdtitVRfIfeQ5AACuIxKSrGFxxC6rwE1fHP9ldxdUch/BlAxcfP5i9lm0MAjM//6RT8Rc5fdz
	0QuUsgEv7QTIgfaxhQ1iWp2UnZywPjmRhUd6S24P14jCb64uTxoYiBapQwBCMeJ/uKuq+Nivsi8zD
	XdaRkbNoLJH/RhrLirNr7WVg/bb95rD8jUTOLrKvno+YIFywCjaJas9XMELi3te9U1wINfSCv/Drn
	0lv8y3AQ==;
Received: from [2a02:fe1:7001:f100:10e3:2d8e:35a4:48d4] (port=64658)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rpYFm-00Gtxb-1A
	for linux-kernel@vger.kernel.org;
	Wed, 27 Mar 2024 19:44:02 +0100
Message-ID: <772aaafe-264b-4284-86d5-e840f4bd4fd4@cu-phil.org>
Date: Wed, 27 Mar 2024 19:44:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: Was Fair Source
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

In the advent that I am now a Rabbi, I have updated my youtube channel 
to IT Rabbi.

Everything should be there, of what I have talked about.

-Peace!
https://www.youtube.com/@IT_Rabbi

