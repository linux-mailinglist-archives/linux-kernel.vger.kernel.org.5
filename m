Return-Path: <linux-kernel+bounces-153616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EEC8AD06B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D1128956C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C6A152531;
	Mon, 22 Apr 2024 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enGF0Iz9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D259B1514E2;
	Mon, 22 Apr 2024 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713798969; cv=none; b=pJIT4NVafNW0FZ4aLDiGBb72jmQ9D+f0n2Em4ukhZ86HBxEAIyK1QHKtiShaZ5CxqBLLPTXGQRWC7PHXHRZuYF6x3F+2yHiSq0dAg+WxbQN04l7o857k85M8tss0IWEgEIj6J+3Z8/JKZfkXv1/SA1rLRUbz64uvanwYFuW9MY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713798969; c=relaxed/simple;
	bh=oWN+0l+LEe/3h6Zg53QjSZjOcE/lb11ML3Q3pZFIQO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugH9M8+wFeCt0unlBhJJJ/gBV9S6WMtEuWvhSmU8tx1MDxvt2L2TVSki0BynFnop4aloo7HnDCpSgiTPCIo18UZxeAYnO0hJtpzRYfpxyZN0KWYqHASl/cZQIS7d9qEgfkxv7LI6X20iL+1AJR87uS59+Pf4mguLlDF9h+89o88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enGF0Iz9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEB5C113CC;
	Mon, 22 Apr 2024 15:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713798969;
	bh=oWN+0l+LEe/3h6Zg53QjSZjOcE/lb11ML3Q3pZFIQO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=enGF0Iz9HE1C83Y3grLgXU2NPX2wxn0mVkwplwWYhK8cJ24odwWSmBDwRG/3V+Isy
	 by11fSso2EUDP7CCfxSgeVKNlid1joON1Sq6FCjtXwF6bdrcEBo5FJMz3/MbwIjqJf
	 h+jny/CxbHG35d2B2DUE32xwXNkmBk0XYixF2ewz5QINZlNBpLuw6fylGvW7Ct1oiW
	 G955ZWI1eARiDKCWdkEedl2f6d2SboDZmn1c4PtqTcQqejKy+iJSWmaviB5Xkccfbk
	 OQkb/Eravs+V+hMome5F4k1ZmbQEmhYL/J0pqg+ecOrWoy7aYTe9K9fPghQpY/60dQ
	 1nGsHaYmSz97w==
Date: Mon, 22 Apr 2024 10:16:07 -0500
From: Rob Herring <robh@kernel.org>
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
	dianders@chromium.org, linus.walleij@linaro.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	airlied@gmail.com, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	xuxinxiong@huaqin.corp-partner.google.com
Subject: Re: [PATCH v2 4/7] dt-bindings: display: panel: Add compatible for
 BOE nv110wum-l60
Message-ID: <20240422151607.GA1277508-robh@kernel.org>
References: <20240422090310.3311429-1-yangcong5@huaqin.corp-partner.google.com>
 <20240422090310.3311429-5-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422090310.3311429-5-yangcong5@huaqin.corp-partner.google.com>

On Mon, Apr 22, 2024 at 05:03:07PM +0800, Cong Yang wrote:
> The BOE nv110wum-l60 is a 11.0" WUXGA TFT LCD panel, which fits in nicely
> with the existing himax-hx83102 driver. 

From a h/w perspective, the reason to share the binding is the same 
underlying controller, himax hx83102, is used, not that it is the same 
driver.

Rob

