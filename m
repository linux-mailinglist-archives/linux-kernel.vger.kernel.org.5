Return-Path: <linux-kernel+bounces-118977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7696588C226
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141121F33DA2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F87C5810D;
	Tue, 26 Mar 2024 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYa4Vslj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED47139E;
	Tue, 26 Mar 2024 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456334; cv=none; b=bjQqqlMaH33ygEG09LVaMrf3GOv3VZixQmLZm2fqo/vCp/X41xZeyr6UgA8mxImelGKSPoBv6G9FOx9JIsy8Liu6NMsFXZCph3oNrpeyvCnirDFh3FTf/FAX/rRNgFHWP7R/ynSRrGj/o8n+HruEqTh/AXf7z/MXVyGwMy6R9Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456334; c=relaxed/simple;
	bh=stZGntb/EkNeA0sqMpP34JEU8CoCxYM+VpStBeNimXs=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=MnnGdSuPOc9Crts2+bjrRcN7jBWmHoW8/29i7qlAWY92y0NS7n9GIXqyjzQIlfQyfSwTUXBJmYkPvwahBOUNhtKSP2p6P2xD1k6pvznK/r0OV5qxrVjyVSine/iLm9eFxqyoS7ez15gP6NgfBj9yujNxlUZGq2sUWTx1xrxv5To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYa4Vslj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E862C433F1;
	Tue, 26 Mar 2024 12:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711456334;
	bh=stZGntb/EkNeA0sqMpP34JEU8CoCxYM+VpStBeNimXs=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=MYa4VsljBaJVaFlcjYOqG/IB0rQoPFMfI5n9pY+wKkVCQwebMktMr2z9688Q7utHF
	 AAj1pJYfRMoGKOiz2prC5lrG+Xeq0o9XXYyDoICcM3jAqiH7TG/ZwFazKrK1FXPmI5
	 3HhCT6oAQgFifs8Zd9CWYs1J8gXpbkwMd4wTigBzE5LQre+r9ES+ESgHZKmL7r0apm
	 jUj5dfF0rPEgDYjR4vScx8AQ44TxWRbiJnhZSE/MbrdTYwNJwC/XIeRBZFPNYesRye
	 F6tkg4Y3l+rhcr4Y+LXPz23bVC/FX3imJC7iiMR2a7XBhJG+OUQXA9LFIcSlWW8/c0
	 F9331sL4rG9TA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: MAINTAINERS: wifi: mwifiex: add Francesco as reviewer
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240321163420.11158-1-francesco@dolcini.it>
References: <20240321163420.11158-1-francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Brian Norris <briannorris@chromium.org>,
 Francesco Dolcini <francesco@dolcini.it>, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171145633125.3037799.11730170138730953666.kvalo@kernel.org>
Date: Tue, 26 Mar 2024 12:32:13 +0000 (UTC)

Francesco Dolcini <francesco@dolcini.it> wrote:

> As discussed on the mailing list, add myself as mwifiex driver reviewer.
> 
> Link: https://lore.kernel.org/all/20240318112830.GA9565@francesco-nb/
> Signed-off-by: Francesco Dolcini <francesco@dolcini.it>
> Acked-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless.git, thanks.

8ea3f4f1a1b4 MAINTAINERS: wifi: mwifiex: add Francesco as reviewer

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240321163420.11158-1-francesco@dolcini.it/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


