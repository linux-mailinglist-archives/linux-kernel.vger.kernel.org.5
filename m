Return-Path: <linux-kernel+bounces-45627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A87C843331
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4728C289C3A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20853566B;
	Wed, 31 Jan 2024 02:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxTFmKVB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF8BE544;
	Wed, 31 Jan 2024 02:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667194; cv=none; b=S+ebWCaxKIMAbqZe52Rh5vcwWh5fP5H4cikpGouBLvNdUFvyzLFND34ScGk0RPYv084FtvYk8FDPWLVEJkiN3k8BsnkQOq9Z9WIaULy8kntXXboEuRwXWlBip0+OqutBmfnSFLlQYC+7JlNoZNl5IUqCtaZqjEcI1RVq9FaTXRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667194; c=relaxed/simple;
	bh=fr8MKqKq5VzL01ZNYfbnakgkkzMKoMPmD0i9DFGHfcY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=buyHmjyG3IAs3AMr/X+QVcQFA7T+tfhWnTThyTBWbQeMVRJ0JEf/DDdTYHvGVEsa666hm2YOsf6n+ijhilgqQp65k0ykWCAfPVU48m/g7EI2FzxTF8Mjkuf5E+K+fmwUSChh6RiOGDrW8yddrbqhfZi1gm22u5H8KQnW32PmTTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxTFmKVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24510C433C7;
	Wed, 31 Jan 2024 02:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706667193;
	bh=fr8MKqKq5VzL01ZNYfbnakgkkzMKoMPmD0i9DFGHfcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DxTFmKVBeT7KFppHLnfC8CaWPZ2KCRM/1A7b6DHU/6a34j/Ne30UEaTD57dJhA31b
	 iYi153eWBMjkPov9fXbgW2oLo4EgudGSHZjs9kWoAwkLrn42OnMsoCeWwtXsdZM61H
	 JL/sMg1ApL7dr1AOUHM3tubG6d2An+6jwkiwg2x/3IwZiMdHjznk7LzE8ZdaIG3vOt
	 RPuDfG4JFSl8Xs0qrkA1J0D3XICL7LMPGK3mjsXVWt1Of1oI1CnLJ8hkBta1r61CLu
	 tT9d0a++urhIzDYx+VmNF0Ye4hN3MWzZtIuvqNtnt/0Y7aSZcpbS9li61Ta1IxunMm
	 fmDnD3q0GQprg==
Date: Tue, 30 Jan 2024 18:13:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
 <conor+dt@kernel.org>, <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: Re: [PATCH net-next 0/3] net: macb: WOL enhancements
Message-ID: <20240130181308.3e5bfa36@kernel.org>
In-Reply-To: <20240130104845.3995341-1-vineeth.karumanchi@amd.com>
References: <20240130104845.3995341-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 16:18:42 +0530 Vineeth Karumanchi wrote:
> - Add provisioning for queue tie-off and queue disable during suspend.
> - Add ARP packet support to WOL.

Try to build the driver with sparse enabled:

make C=1 drivers/net/ethernet/cadence/

Looks like you're adding new warnings.
-- 
pw-bot: cr

