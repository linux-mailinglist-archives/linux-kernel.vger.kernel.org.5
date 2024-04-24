Return-Path: <linux-kernel+bounces-157357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4538B1053
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC3728213A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B4D16D30C;
	Wed, 24 Apr 2024 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="lkJPaNyX"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6998716C450
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713977724; cv=none; b=IL1o0O/TBrmC+7EzqnpxRUBbV+imDMyCTUNOqUFmFjkLxdssImGtyIZcYNQzoqxxaCsZv4YOkx7KVPC/+zNl5sfBsmkXH1I6E+QAJ5Akk5KTtlSMa2lALKEU5p+N9BUPP9mdtk1xPZjvDl33hanIbScj/Fi5OxTosgsY0/LBkMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713977724; c=relaxed/simple;
	bh=i4dM2qbPlpSMNxbHI8hm9y+pMYx7Zm/mB9A46LHI0Yo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=W7Xsef9wbMNlC8/4enl5IrWuFztK9sr1/xi7emVgLuC6djR6WQnzKLXOB9xyaF5+0KkvurUoaOVdZX0knurnhYwfXWXgfnTdVsEXQRnSjcfn2mIuq7L2eIHQU5UHWHL0Y1TxaKps3Nqicpq8++aph6WJgFpDd1NqS2/5blZfbLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=lkJPaNyX; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713977720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ogBBso8nor4u8LQLxTzG+t+K0wGeTpPjTgVKmH2TARY=;
	b=lkJPaNyXhIHCKrzHRCjWdvqgSYsbyp5MAAwj1U/Us9VRUItvTeuvKYQ7HivCjbojxeN2uL
	yKjl5r5vZoPby5YaRgzkjsWxGyVCtIBB+iSWSGLxnygYE+NGqmWQgAAunlEQ0YQXdXNMyc
	hwmNDtfc6oap71Dd9SN48h6deRstTu6rMYwmmmGqv03+3zMZ+HZdUpUskb2b3rQKZPIftW
	HJPCYrnPPkfJmGZRZGlLaxcRFsz0fgI1JCmkF+zNHBSI7HUzq8WSMkW3H/zWIv7RMY9eRo
	ATEVf2X/IpYsIBJaB5Faeeg3KRZ/rZsZebn83psZmiXLb2mu9uzQc5qX4KNSVw==
Date: Wed, 24 Apr 2024 18:55:20 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, Heiko
 Stuebner <heiko.stuebner@cherry.de>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: rockchip: add PCIe3 support on
 rk3588-jaguar
In-Reply-To: <9baa0835-9cac-4bb8-b172-9e1351ffa6c9@theobroma-systems.com>
References: <20240422133502.2592975-1-heiko@sntech.de>
 <f33c0c0b-979b-4f50-89f7-976832968494@kwiboo.se>
 <9baa0835-9cac-4bb8-b172-9e1351ffa6c9@theobroma-systems.com>
Message-ID: <148523703cd2dc2e03c102894ebb9870@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Quentin,

On 2024-04-23 11:10, Quentin Schulz wrote:
> Wondering if we couldn't have some kind of constant to make it more
> readable in DTSes? E.g.
> 
> #define 1K	1000
> #define 1Ki	1024
> #define 1M	1000000
> #define 1Mi	1048576
> 
> And in the DT we could simply have <(100 * 1M)> wherever appropriate?

Hmm...  Perhaps "<(100M)>" would be even better?  It would require
more thorough changes, though.

