Return-Path: <linux-kernel+bounces-86627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5AB86C805
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23AC1F23493
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91B37BAEA;
	Thu, 29 Feb 2024 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="VdY0hEny"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E4E7AE63
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 11:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709205994; cv=none; b=GAIEJm8LMefz4RNuZ+ahkXQC7LOjzc+zW3V/+Fb3y5rIaDAwebEL13K0qv+wVgZ8Cn/0PflQQ0lw7tJYw+8zedCF6S4PQv1WhibM8yVBxvWDRA5yv6hiFFgecyLuBBG0NqFALw5WNNoBzcJG0Mkc9geX93nbi7Vn9xuv1gZlYKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709205994; c=relaxed/simple;
	bh=QbPev4NpA+UyASPR8c76fWnkTWj3dRHCaIXhZPy9ViM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=YIcPSQnwCYl+lji5lVFQWIJWgDIYaxkrGhjtUeHvAF+6z1mbB/4WREq/n0z4eMlsNMjTXuNl/zUMaBlXRFIVuEpwaVm4/j+ASLRYkqEl5C8U8KU/5eX26pBk8yYb0Xg3STNwUBmQ1i2RiVjBbphRx1xK7ghZaw096fVUQiXuRgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=VdY0hEny; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/Kjhg7goXYzXyeeiaq1mJdQilZuUsIWAWV41uRXY/qM=; b=VdY0hEnyyP128lkpCFuS4i4rnl
	FVVoL8S1Z2rzqi+YnGoDYsUoVFRh5n6yLe2pNSnC191S96H2n6oLjYTwgf2sGNKV7nBpo32v53GZg
	avt5UG14P3Bc6rQ9/rDmPPez6/WSw/ylBokHM7p3MBvv+MeGO4MdoSTS4SeglIJJtUj/DyRNdeP6d
	7HPWvYVAd6u+iXT94FHFprcfrZoF2Ezm5SMHqUIX+TG1YulntxmMx4ZLg0E2aBGYQeQjMIevPyJ3x
	f3PCUgt2nMj2YNDatTp8GezkIDFLGnmx1kqfPfsmEUPEQSEraK9STnlpIBeB7l5QV+0s1yL4gjiWZ
	ccSDP3Mw==;
Received: from [2a02:fe1:7001:f100:9560:66c3:aa0:e529] (port=54906)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rfeYY-007s3s-OL
	for linux-kernel@vger.kernel.org;
	Thu, 29 Feb 2024 12:26:30 +0100
Message-ID: <6c633677-bdad-431b-8203-d723e468743f@cu-phil.org>
Date: Thu, 29 Feb 2024 12:26:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: Philosophy Update: We X (Was San OS, Fair Source, Low Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

We in this context actually is the same as San.

Updating to We X, which is the network everybody wanted here, with full 
Fair Source basis in The Kuran.

Serenity,
Ywe Cærlyn AKA Saint Bit.


