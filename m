Return-Path: <linux-kernel+bounces-147028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128FF8A6E64
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9919B2825D3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DEB130AC7;
	Tue, 16 Apr 2024 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMaLeZDQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A5612FF9E;
	Tue, 16 Apr 2024 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278018; cv=none; b=A2AMr7DhRhPh78EIrMAoaHWJoKkqcU6M2VTmqczQ876r0LsfZYex6qWzZ7CfYbaoGnQZGHyi6SVXU7zneY5gWrE/kKCnWD9U/Mj1SvC41WeuOMFFYr/LWgyNYcxBmPhat6vCdZd9oUYZCFNBGXeah2TlYY98tS8E0ec3wovAkrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278018; c=relaxed/simple;
	bh=73evdPQiOOApw7QL8q9vw0HzZUfbwzxdzB9xRg+enm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggEWYLts7lWj3jrl400St4VT84urN1bLF0BQAGteB4bjO8NeN2l07Q4Ejvl8toQ8FX3hiVQrpy2K9y1C/fGkIs4MMVPKN8HLMueL0HDI5lJNSqKBtEU2ZtZdTEm9oQ5eRlh/Jf8zHeJhlkvJRlWAvJD0r2tQT9esfkGQmbnNDqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMaLeZDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C0BC2BD10;
	Tue, 16 Apr 2024 14:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713278017;
	bh=73evdPQiOOApw7QL8q9vw0HzZUfbwzxdzB9xRg+enm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kMaLeZDQhQpMslb1F6+zzVI9LpFJlfaRtVT0etbL1ozTHk+OEaAbtDH8SUroPagj2
	 pFt3vQxye/JfnqgEm2K9174tUV/EWQIjTyYY02OlXF9kMXeDyuQXWnkuGARqpzDLr9
	 NvHGku+xwLNgHFFLt+8CIPnVVtapvo10UzHaPFHmHa6YhaVlh3V7JdXjSjeaW7wtoM
	 9fouxB5ReL9yW0J6QlzRK1D2hn3emDi8aawc3Yv5ib0/UTqttNWIyVcEAWUrADmoCs
	 aaUU5+uXmWwKyza0drl4rZosaSLP4w+pgeuVpWOVPPxWYHEqQX4LJY1gohbO3cEXB7
	 mTtjr4oBRTuhQ==
Date: Tue, 16 Apr 2024 09:33:35 -0500
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: renesas,cmt: Add R-Car V4M support
Message-ID: <171327801307.2257481.3238910701067194343.robh@kernel.org>
References: <3e8a7a93261d8ad264dec2fa2784fe1bbfc4a23c.1712068536.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e8a7a93261d8ad264dec2fa2784fe1bbfc4a23c.1712068536.git.geert+renesas@glider.be>


On Tue, 02 Apr 2024 16:36:05 +0200, Geert Uytterhoeven wrote:
> Document support for the Compare Match Timer Type0 (CMT0) and Type1
> (CMT1) in the Renesas R-Car V4M (R8A779H0) SoC.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/timer/renesas,cmt.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!


