Return-Path: <linux-kernel+bounces-54650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FE084B1F8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4392D1C22E4F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD5E12DD86;
	Tue,  6 Feb 2024 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfJoUFmO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4571112D749;
	Tue,  6 Feb 2024 10:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214109; cv=none; b=jzqLXvrAYZKXmKJWodIJuipj9MwRMeMION7eaUaTUVuBVbrD0KHm4WIfkI5fg3zc7csGkNauANDEFQq79v5YC8Dzzu89nxc/6dIEErLettZTuP9opsp83lb99HKkHDW78xxSmT9+4ADn3WA6DqhVC6T0JdacwQbOJeIhVGVe3fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214109; c=relaxed/simple;
	bh=DgHtCUiW6ZsBt2sAYyOKbE+8rBUgi6bTVLDkiRHKlUg=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=dWQoHchpGb+fDdZz6HIQ2fniNnC21mUFhxlDLHBx1xVm+ofiQ4wtTROaPrXNeV/udxj3+ELWPCwkkfnNXVIvsMilCcnddKn3+V7oBcqk1PVXz8Vdi5qUSrnnyGU+7txzuk58xsj17EH5tGQxLX5W0AJFM4Y4/GKBGJd3UtPpQ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfJoUFmO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AEDC43390;
	Tue,  6 Feb 2024 10:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707214108;
	bh=DgHtCUiW6ZsBt2sAYyOKbE+8rBUgi6bTVLDkiRHKlUg=;
	h=Date:From:To:Cc:Subject:From;
	b=MfJoUFmOXFeaOhUTa7247CzftLkeWIE46aHpDWfK7f7Vh7JFfyuDlSg01fd/SFIek
	 JuR3oEioLyJmjzXH4UyFHSHqn2CBmEzyyQ8JH3gjYLUoKaL1eBll9K6M62KuWZa1TJ
	 0JX6R3YAifNFB9p/ZebuT8XyghdJjGmBNt9PjC2HkcxoyiL/Mtjcd59B2n1BXo6jO2
	 e8n4cuCwJFGS5y9c2QUmvlfiyHBXIG0w6u7kRC5EFlA55InxuCWSygbxKcZk0R3qSZ
	 UKzy8LrxYtZiRA8oCHw9MRK4ZPWjvaftE8ld1KDgAJFTPuO+bFeg2vMCb6p4l/J4Wb
	 Pv/KGtp48mV+g==
Message-ID: <00a81be6-7dd7-4959-b1dc-eb94022bf0e5@kernel.org>
Date: Tue, 6 Feb 2024 11:08:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@kernel.org>
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Subject: MediaTek for-next: Replace matthias.bgg tree with mediatek
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Stephen,

A while ago we migrated the MediaTek SoC trees from Matthias' GIT repo to the new
MediaTek collaborative one. I just noticed that the linux-next branch didn't get
replaced (we didn't tell you anything about it, so that's our bad!).

Can you please replace the tracked for-next branch?

..The old one, to remove, is:
git://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git#for-next

..the new one, to add, is:
git://git.kernel.org/pub/scm/linux/kernel/git/mediatek/linux.git#for-next

Thanks!
Angelo

