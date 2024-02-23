Return-Path: <linux-kernel+bounces-78588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB86861568
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A772284337
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640F8823AC;
	Fri, 23 Feb 2024 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vc7r6UhM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40C881AC6;
	Fri, 23 Feb 2024 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701602; cv=none; b=GbIHosWtYkcVaarDhG05Jf+58RJnG8f8oVRpgjkD+yZEogo0HSRRXBL2rXfIRn0ePZJYUPs9LGnEmRYHvNwmSnhYKBypjJwR6l622zcyGvYNBwngoZ/6uGs8HTFFHvSNZ+GG3bnZ80iLjRCcdVs0L008OmBRvB5CLNq57dAAXFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701602; c=relaxed/simple;
	bh=LTGuP5mwgDes1iDc674SKmGbovpo1+4tFu8cnR0ZZFg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=awSj1ZUAmDP0y10VS1wJiX7Y+URMvQkP+2A3WCGfbJSKQYtaME8JXOVfO1E8rr6AwojXjZ4xi8AiaOA7uldn8z0Cn0eI2Q7JWSHt5Qe63NkP0mtNHAo0lMmY+zGzlf2Z1QiEdh53X19wIxQ2OH6T7HXz3IfDeo261YlC8gjDwmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vc7r6UhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C901AC43390;
	Fri, 23 Feb 2024 15:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708701602;
	bh=LTGuP5mwgDes1iDc674SKmGbovpo1+4tFu8cnR0ZZFg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Vc7r6UhMjw6tOffkYu/nSuOneuQKW3B34b0TZdfdc3TTLoU9rHgTbTi4ahBzCyAs+
	 LWGx9Qm/T6lhL6dH5bpphrtEJEOu+5WpxLVdggwgfACcZuYraP48QKr9r12h5pfPaE
	 cplw6LDQEmTB5lgWia4mJcYaThHX9xYL/ajxYOz6U7zaNQH594QFqUNlLYWCvxLm+V
	 7vro2yg5hlcO8FBJrGIUnRoY/+D9syFqIp853hPqQnLjkV3eHdCuf7CeudLSf8xl5o
	 t63WHI05Z6+99MAW9RjcCqBAUAwiDIgGrzKU//tfYXxPpZ46EsqzJK3W1YXLsQhSLH
	 A3fStTR3JMGxQ==
From: Lee Jones <lee@kernel.org>
To: linux-renesas-soc@vger.kernel.org, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-sh@vger.kernel.org
In-Reply-To: <20240213220221.2380-8-wsa+renesas@sang-engineering.com>
References: <20240213220221.2380-8-wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v2 0/6] mfd: tmio: simplify header and move to
 platform_data
Message-Id: <170870160052.1698319.4712751560931025638.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 15:20:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Tue, 13 Feb 2024 23:02:19 +0100, Wolfram Sang wrote:
> Changes since v1:
> 
> * rebased to rc4
> * collected all needed acks (Thanks!)
> * capitalized first letter in commit subject
> 
> The MFD parts of the TMIO have been removed by Arnd, so that only the
> SD/MMC related functionality is left. Remove the outdated remains in the
> public header file and then move it to platform_data as the data is now
> specific for the SD/MMC part.
> 
> [...]

Applied, thanks!

[1/6] mfd: tmio: Remove obsolete platform_data
      commit: 58d6d15662e4039fab7d786f0426843befa77ad4
[2/6] mfd: tmio: Remove obsolete io accessors
      commit: e927d7bac109d8ca1729dda47a8dbc220efdb50e
[3/6] mmc: tmio/sdhi: Fix includes
      commit: bed05c68aa8f078206143700cd37e42a0084155f
[4/6] mfd: tmio: Update include files
      commit: 3ef94c41db82573dc1e1dd6c259aec8ef6caaaf3
[5/6] mfd: tmio: Sanitize comments
      commit: 2d417dda59123b9523a19ce75fea3fd1056c3b4c
[6/6] mfd: tmio: Move header to platform_data
      commit: 858b29729c9d319b9cd1441646cc3af246d3c3f9

--
Lee Jones [李琼斯]


