Return-Path: <linux-kernel+bounces-100444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DB78797AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED83287E39
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E267C6E5;
	Tue, 12 Mar 2024 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgibTgEH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD147C0B1;
	Tue, 12 Mar 2024 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257641; cv=none; b=ZHZ/zAEJ2kr61IVKj0NIdEd/EXrYUyltBRr5QXI4GOYJfZTFvMbuGHYhXTYYpPusvquJ1ER/ailv+/4Zr1MVo5SQsSvVmq9SY2ViQeMYhiocTAidICOyrkNnQsM5vNF/Mg9JQMeUsd21q8uBHD0qU1GX09oY8ErYMTGKuJxcTXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257641; c=relaxed/simple;
	bh=rgJFicWGuAD+58RekAshrq73+gXkO7k3uUiV6GVq4Q8=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=YKve46TZWIq6MyXX8T52KsBt2eX4J/AhCPd5WZbD7iZ397+jdPoqnRGRzH4Jo216Pfy+rAm7VVon0MB/nT9Vw7AfYNsO2GFuB8C6r5lpsJc3KSaUjf+azFhxDSAT/rHAoYVrO/b00dPBMpEO79n97vF7kmnQEew2nKWlNWNez2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgibTgEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBD7C433C7;
	Tue, 12 Mar 2024 15:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710257640;
	bh=rgJFicWGuAD+58RekAshrq73+gXkO7k3uUiV6GVq4Q8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=XgibTgEHr0X64GTePVLXyX5FlMuNJYIIVeXRr3qC7vYsTeU0Hozo/S/S9H0NOmXkC
	 2NM85MUNjIYSM+t4IHP0WnKgt03AeoSNMaQUIU3JGh960cdBvHeASTncjUgk3MhT/S
	 UoPfPPEymrdqEufGYVOhALoa/uTUUrBRYySFu3Q1qPcO7TPmx50HKuCVoH2kgIjUMm
	 LreZYVCrYgUQn2bOGonAS4G8cBDKhaR+J+L58BboF/m99oS96bfbTCHHORpqO8m5CI
	 hM9AGIRXXjCPT8vHJWv0/fRlccp9ILw/beX6OZZeXquJqm9CA5IkozCdglMNSjKBik
	 Y0qCRCFUq1r5Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ssb: drop use of non-existing CONFIG_SSB_DEBUG symbol
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240309224540.22682-1-rdunlap@infradead.org>
References: <20240309224540.22682-1-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Ying Sun <sunying@isrc.iscas.ac.cn>,
 =?utf-8?q?Michael_B=C3=BCsch?= <m@bues.ch>, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171025763733.1969294.5448324722767212154.kvalo@kernel.org>
Date: Tue, 12 Mar 2024 15:33:59 +0000 (UTC)

Randy Dunlap <rdunlap@infradead.org> wrote:

> CONFIG_SSB_DEBUG is used in one header file and nowhere else, so
> remove it and the now-empty inline function that contained it. Also
> remove the call to the empty inline function. The empty "default:"
> case is kept to prevent 2 compiler warnings:
> 
>   drivers/ssb/main.c:1133:9: warning: enumeration value 'SSB_BUSTYPE_PCMCIA' not handled in switch [-Wswitch]
>   drivers/ssb/main.c:1133:9: warning: enumeration value 'SSB_BUSTYPE_SDIO' not handled in switch [-Wswitch]
> 
> Reported-by: Ying Sun <sunying@isrc.iscas.ac.cn>
> Link: https://lore.kernel.org/lkml/4e8525fe.607e2.18a8ddfdce8.Coremail.sunying@isrc.iscas.ac.cn/
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Michael Büsch <m@bues.ch>
> Cc: linux-wireless@vger.kernel.org
> Cc: Kalle Valo <kvalo@kernel.org>
> Acked-by: Michael Büsch <m@bues.ch>

Patch applied to wireless-next.git, thanks.

e27b02e23a70 ssb: drop use of non-existing CONFIG_SSB_DEBUG symbol

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240309224540.22682-1-rdunlap@infradead.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


