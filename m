Return-Path: <linux-kernel+bounces-45086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E43842B8B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4135528B23D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33B8155A4D;
	Tue, 30 Jan 2024 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tY8zLPKR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371928612D;
	Tue, 30 Jan 2024 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706638601; cv=none; b=doMZmZHgGazXLMm3wGDHdj54VUbcS3weHesVFO3NcRdK5hLAwyD6JXBdbYgK9z5CbX/tczgSXUsXHG4Wy9v5VpvRWk4hCTCkwQKB5MVYbfO7cbIgTpLtzu3CBYCWcCqdza5EQU5sf65Iwf+WDB/HCGme8KEQoFC7HTc0EMqIZHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706638601; c=relaxed/simple;
	bh=LpEp13sjWndJKXUQDKaQ9fVxVGcPE52nhZRtN4BAINY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgBQDBwaURPU44qi8Vk3A5xyS+USylEZRhM7OgUokzdIN083dKNa+8+uDBN/ydQx9CmqmvHf1lSlpg3hKX2ELXbAvArjKx50EVi9af9EFh8WDwMq5+R5lvUsN/DpnZT0p3SIWPFU5o3YGSNFCkFOh6lAXu0XersKCkQ/QPAdgVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tY8zLPKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605FEC433C7;
	Tue, 30 Jan 2024 18:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706638600;
	bh=LpEp13sjWndJKXUQDKaQ9fVxVGcPE52nhZRtN4BAINY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tY8zLPKRyo//fJtNkz9jfrzfcGT1jNNzldzd336pGMaw7XlDhajnOn+1Qx22JhBN2
	 FxQsDe6jMoMn/EH13xDvJAbJXIw+BswKS639JVzl4l4vJ8Y4a21FLj4XjDgc2nffQL
	 fnjeA+3k3nLvk0TgfcndeCCjxA9ziw+2hSUOmdrah3ew68ZANNHu9r2DKzg4sn4sy/
	 RLiFll6YWMg2z27IYkral5H8hTR4Q7eYeGFh5UaBOLRAmqKJo6ybILa3mFYDAVw05R
	 nGJSki5K/yghVCy//9jrfd2OabdypbTdor2kSfz3DFmxwLvqNVDSnNKovgDwFdTBTT
	 ZZzhVEUjmNARQ==
Date: Tue, 30 Jan 2024 12:16:38 -0600
From: Rob Herring <robh@kernel.org>
To: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
Cc: Henrik Rydberg <rydberg@bitmath.org>,
	~postmarketos/upstreaming@lists.sr.ht,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	linux-input@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	phone-devel@vger.kernel.org,
	Markuss Broks <markuss.broks@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/5] dt-bindings: input/touchscreen: imagis: add
 compatible for IST3032C
Message-ID: <170663859769.2091769.5804775030839032520.robh@kernel.org>
References: <20240120191940.3631-1-karelb@gimli.ms.mff.cuni.cz>
 <20240120191940.3631-5-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240120191940.3631-5-karelb@gimli.ms.mff.cuni.cz>


On Sat, 20 Jan 2024 20:11:15 +0100, Karel Balej wrote:
> From: Karel Balej <balejk@matfyz.cz>
> 
> IST3032C is a touchscreen IC which seems mostly compatible with IST3038C
> except that it reports a different chip ID value.
> 
> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> ---
> 
> Notes:
>     v4:
>     * Reword commit description to mention how this IC differs from the
>       already supported.
> 
>  .../devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml   | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


