Return-Path: <linux-kernel+bounces-140351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8208A132E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6921F23994
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADF714A0B5;
	Thu, 11 Apr 2024 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8YlLmF/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDD6149C75;
	Thu, 11 Apr 2024 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835550; cv=none; b=C4ftis54p3WK5HFFdIidtBjBwLg7QT5z3hY1c3Ymcx/mz4DGmHzdBYAL8B6Kc0H6gOs4hdp5sp/A/pXyJovz/tsOZgQMmeGU4bzx9P2Pue2MbwzwFKz76981GKMdhvLeYl7wexJen4kPO6QFFJ7hEiQ/0C0c8COrvMkRYDhn4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835550; c=relaxed/simple;
	bh=I5nbEGakjINwOJ+jcSeqOF0hmIiKmK5YtjwNvKXbnt0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Tj9T9T74+YZmm/Scc0ytnTfWVJ7AKZWs96w97UfeHrjJ08MefWxuqgUUzMwERr8MRiVQBosbvMzZDXHz5TqpCep9j2Bs89+iFbzPsV3ObuN2mIqFVbCQj2SNOqy5wd1jrgohStNmm3Lx+GsYPTyELugsKAKbxM7sw7c/+qhRqe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8YlLmF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E588BC433F1;
	Thu, 11 Apr 2024 11:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712835549;
	bh=I5nbEGakjINwOJ+jcSeqOF0hmIiKmK5YtjwNvKXbnt0=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=e8YlLmF/k2ZQR/CLaHTpTEv8Z6qDsQ3oYwBFXf30TmSZ1bFezj9bziqeIjRL0CcdJ
	 543VoblwOOU/NhuZTzgqU8WiAq3zdZeKVbHy6M3DASSkSlN0nTet0lQoOI7ZZuA8J5
	 T/vMGZfXKfD9JbUwczG8q3ib7boGaaily3FbdgfbHdcMprGvyJqbCKJI3BplSC8BcY
	 QsS5CFHlEic0s8eXecI5MPr+Ois+V9d3HKLoS0t/a6da2Z/3pYrwYI8+a0W/U4GNdO
	 MGEBlNyJcUsQFTMGzaaemdh2vL5w9Kc/tYcqs5q+VDYL2gND550peIOCdWTq6mvj/a
	 clRQdY2ZXWdKw==
From: Lee Jones <lee@kernel.org>
To: dmitry.torokhov@gmail.com, robh@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, lee@kernel.org, 
 alexandre.belloni@bootlin.com, wim@linux-watchdog.org, linux@roeck-us.net, 
 linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, sre@kernel.org, 
 Andreas Kemnade <andreas@kemnade.info>
In-Reply-To: <20240401081831.456828-1-andreas@kemnade.info>
References: <20240401081831.456828-1-andreas@kemnade.info>
Subject: Re: (subset) [PATCH v3] dt-bindings: mfd: twl: Convert trivial
 subdevices to json-schema
Message-Id: <171283554667.2315734.12959228748358608379.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 12:39:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Mon, 01 Apr 2024 10:18:31 +0200, Andreas Kemnade wrote:
> Convert subdevices with just an interrupt and compatbile to
> json-schema and wire up already converted subdevices.
> RTC is available in all variants, so allow it unconditionally.
> GPADC binding for TWL603X uses two different compatibles, so
> specify just the compatible and do not include it.
> 
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: mfd: twl: Convert trivial subdevices to json-schema
      commit: f9463e7b73bbd3b6dee77c0387e2ebc9e61fe0e4

--
Lee Jones [李琼斯]


