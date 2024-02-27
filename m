Return-Path: <linux-kernel+bounces-83714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F27C7869D96
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920C01F21623
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03FC14A4C9;
	Tue, 27 Feb 2024 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="cn/V1410"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD704D9F3
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054665; cv=none; b=c2IAlHn6L4K/tqx2AFFxM7W2XD4DOJBET9xw2J5Fpfr52dsSvDT4A3b+vXe0sOkeRH9V8204MfB0LT+jkjayn44AN4N3zfoWRVcREaHSG9UnK+RBPny0V11hbVIzIKmaBPlmvf6oubOVwsgoPV7bqenQtESSbeEZlcOSkv+Rpi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054665; c=relaxed/simple;
	bh=s7rWb9ewT6r71vg3f17Bp4dJLsN63LLZxPbiXrseDfY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=cREHqpZUAI8nrizmBNfp57cdMORL+Sp4z/Zg8g/3CFdp0CojuCX+QDkiw6XUy+QMDqZPDVIiKCv6/NfT+H94qmjapwqu4xsqXTeq0I/8GuqKnP7K9jMU0gnfmVy2XCU9oO23liMkBTYTARLqFU6xqNIGlMdrCcRN30sitOi0fSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=cn/V1410; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/Hb5fvthHxvxBNkb2IehPGHOkaB4KWsis4jtjChw5DY=; b=cn/V1410z5NoEnqPNwof/6ZuJe
	nG1iRUWthyqPKjw3jqG2J+zQqUAqgVu5LOoIp1s+UfLaDRzNtiZC0m8/Unr8NHmqiTqf0y8qQYeki
	2fDC+/PIZ/bYhduVtrQQPUjOFJ6jfy4RwEduZ0MRHnc0JGwUdOdTTs4rXR/UDDqrBQk6CWNlhZpKW
	5ZsxDC+PY7momRoq4tUFUCdDX2CwDvTzqHRFnT2FRPkk2Qmp05zuQRysfb7fwqpLQrE43T1vWVZAS
	MuD3DrJak4eGczCs2IJpC1hH1mV2VYMahjqd00KJdVf7Uouy4zImMXZkt/rLe5r0utPBn92jIh5nN
	GcYp9k7A==;
Received: from [2a02:fe1:7001:f100:ad88:f8c4:2b9c:9d8] (port=50433)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rf1Bf-00DpDt-QJ
	for linux-kernel@vger.kernel.org;
	Tue, 27 Feb 2024 18:24:15 +0100
Message-ID: <c6c064b4-7b34-44f2-83d2-ab2ea6c18744@cu-phil.org>
Date: Tue, 27 Feb 2024 18:24:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: San OS (Fair Source Philosophy, was low jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Yes, I´ve been trying San (concept of The Deity) some more. It seems 
very good, and I encourage to use it for OS and computer design. It 
emphasises Fair Source philosophical background in the tight Kuran.

Serenity,
Ywe Cærlyn
Halal-Nerd and Computer Philosopher.

