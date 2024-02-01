Return-Path: <linux-kernel+bounces-47936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2798454D4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4B63B292F8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2DA15B119;
	Thu,  1 Feb 2024 10:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6WLngXY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B30315AAB9;
	Thu,  1 Feb 2024 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781972; cv=none; b=eW7+BfKWWJ3ImHlAPk1T/fpl9/wcQ1H39mQcDAvNu9t5rTCKdMcjBXSn9ZLqHR+AqKQYNPEv7q+v7V7h/Ih9YzpuO56owXo5HOrVSZbsFdat2GLCI6r4Ss0ZET1bQ0e6RhRPl3FknDydrlVamvXaQw1zFvf/C+Bf42zylyVsyFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781972; c=relaxed/simple;
	bh=X+CKtvTbbLk6luseks2U7/JYjJq9xPQPysG0gwURc4c=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=dxop9vIzDuz1MBvhwsAls09J0F0oLhQLiphO8yM/Xa1CJmzjinJeTMTi1EHqTuFwUUcjFeEF/UAC4Fqw1N2WMg/IDar7wTv7Us4tXXIhrNg1LVZFAXcbxOFio19SlorT4ohewR13+tL4jV18UP8a7rM0VA945PrsztmqWelOO+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6WLngXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE54C433C7;
	Thu,  1 Feb 2024 10:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706781971;
	bh=X+CKtvTbbLk6luseks2U7/JYjJq9xPQPysG0gwURc4c=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=X6WLngXYb4n/kV4qVbVCcA6FeuVrTBpzTcnTx2mKCHO+oaZZoog2YuDiXFFAl/Gwq
	 ewrKlMAdfEeXxoSLtt5bhLKd/6mR9qDru6zQ2rFUnsYXRbfU/N0xok9oi+OQh6P3QH
	 AXwCDCAWOlMkmDLDY/wQepLVyMxjJEOIjMiF/793t/1ZXT1X4mMrkTJlUESrrCzu06
	 iGlcA28jER7eU7Xxp1+cqquzfGuvWUaIFlfzIQ7gRMi1PUG9TSdd0THR+94BLtb6YG
	 Vh4toLaOW9eCxfgSgZiF2mZjjXI8dLBaBpO2YnW2Yq7ZiuxEfEkr3c/LJBpX87eH+u
	 G4RCVr6EvCdZQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: wilc1000: remove setting msg.spi
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240123212135.2607178-1-dlechner@baylibre.com>
References: <20240123212135.2607178-1-dlechner@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>,
 Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170678196828.2736043.11019687394930194957.kvalo@kernel.org>
Date: Thu,  1 Feb 2024 10:06:10 +0000 (UTC)

David Lechner <dlechner@baylibre.com> wrote:

> (spi_message_add_tail() does not access this field.)
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Yes, please send with the correct commit message.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240123212135.2607178-1-dlechner@baylibre.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


