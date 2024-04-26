Return-Path: <linux-kernel+bounces-160116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEAD8B3953
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC39C285463
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4641487E1;
	Fri, 26 Apr 2024 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Zv7jBhfr"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34767148315;
	Fri, 26 Apr 2024 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139940; cv=none; b=TJHumAECdUJhHokjVBvcUMQ73jK+nhTZ29oJcC9oDM32op8KY0DP6FeHz2pJhPTKcwZl2eW6jXAgtJx73EXa++oTf7ZzjpOaPvXQrjZB3/DRVDfXGbvx3N133H7U/IfDxbOtEo0R57jGqHRDCRHy4AA2Gev/UBU33Aaurru27kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139940; c=relaxed/simple;
	bh=U5JTEg76JRGgJ+uh8sUvqUM1psjGTvG9LX9g2tsLyiM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YGK3Mvkk1sOPcklQR7XH/qgdjjKvjeuKFwREX++XbyfGaiwOoX1Jck0x8Y4luCf6F2BjeMnpWi3kwxIcuBaoZANmMi9t7G1klSTcHTiuzdtdGyHKVUH/aKD/w6IEIp3L5CPz4LpcFPXQYzQ5JDqqYoNp7pwwPJMKWDEIkfJJWCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Zv7jBhfr; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 256C047C3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1714139938; bh=hSBvj3AMfluHMQLCfI6sXscWndkjq2Oc1zVGNVHaAZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Zv7jBhfrgwe7figF3E72J77HJnPmUu8/KI3zawxW+uinuKU0qOnmvGvYewxknKHCo
	 RYQC/3A5+9ghTC32PyYlROyGlnoySexk7YkmK5UTcJcQQ6j3iKuy0HEHcsJWkcHbg5
	 UDMkKyQq1ypURRRtcvHT5khobqCLZHclmH1bVOtVr+RU90GVUwePZcOMTzyudjApyn
	 kQAlcIDxatc5XrPXV7f4mrAV9jKJ0YwlrjALlfigdbr0/bWzpsoE7iLrwY6zu/znfm
	 fCzBfHp7t9kBLLqI7YkO1uRl9WPHzeOSuxESHDj0MNK2IJe8QDTWM4vcflL77PwEH1
	 fPlceTybTPH6Q==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 256C047C3A;
	Fri, 26 Apr 2024 13:58:58 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>, Yanteng
 Si <siyanteng@loongson.cn>, Dongliang Mu <dzm91@hust.edu.cn>, Konstantin
 Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] docs/zh_CN: add process/cve Chinese translation
In-Reply-To: <20240422041115.2439166-1-dzm91@hust.edu.cn>
References: <20240422041115.2439166-1-dzm91@hust.edu.cn>
Date: Fri, 26 Apr 2024 07:58:57 -0600
Message-ID: <87r0esns2m.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dongliang Mu <dzm91@hust.edu.cn> writes:

> Translate process/cve.rst into Chinese and add it to
> Documentation/translations/zh_CN directory.
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> v3->v4: revise sentences suggested by Alex Shi
> v2->v3: remove a trailing space
> v1->v2: add a newline at then end of cve.rst.
>  .../translations/zh_CN/process/cve.rst        | 89 +++++++++++++++++++
>  .../translations/zh_CN/process/index.rst      |  1 +
>  2 files changed, 90 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/process/cve.rst

Applied, thanks.

jon

