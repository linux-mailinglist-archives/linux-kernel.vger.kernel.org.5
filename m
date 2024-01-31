Return-Path: <linux-kernel+bounces-45601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182D28432E1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA7328448A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EADD2103;
	Wed, 31 Jan 2024 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6SfNR83"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D4715C8;
	Wed, 31 Jan 2024 01:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706665247; cv=none; b=gZIyog1lI7R+0DxmYXAG0DwRXwFQDsY+IchuyZ5MviiuVI7J0wF5XfcPJiUatgjRrJr91b4Ve7TTslc3R5zqO+paXXswOk3QJEjxm2UnxMUv8kXL6vAl5b+U1ch0/94PMI/l4q1Hiu14fAtzcOQNIud8HCr4dw0wuhntzChAIGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706665247; c=relaxed/simple;
	bh=Ss7DsBzWtZruF+UV+7K4oX0BP7YaiFXQ2hyOcSDELHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUxOlEvARzly6w1wimLyTRh8NGWAJv2Vao8Ae5y7aQzJJw113jsGLmcm+sxNr+qBQVSt+2mUNsoAjtTRQV9O6/BL+P56wHL++UF4UA04Qkpma5ew1HDO+I0RP8UN2wOFK09KnfXYEKiCbzm5b1Wz/3lyctIO6odNz80NevY1I8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6SfNR83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856BAC433C7;
	Wed, 31 Jan 2024 01:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706665246;
	bh=Ss7DsBzWtZruF+UV+7K4oX0BP7YaiFXQ2hyOcSDELHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m6SfNR83wl6VyZZWViIm7+zILq8AYtAaEHXCkgsbmi9LmkVk6uzEDeTCJ75OcmGWi
	 oUX6Rv4HXVfFhJY8pd+Q6CSLAAz8JAtKAwu+n0F+WnUb+5Gux2OVIgqhxPA86an8m3
	 MSBrgJK4IWIWqryQgbt8Ycqfd8QPLhOZ4vt6w0ko9S3rXO5fl910Um94uu/e4N2KOh
	 FUUSUwaZpJQ/ld9baWx+DuG4IcCEe+KpeE4st504urXPvU1GEKGXB+HQjUaiZG0alf
	 VeZS+aiWs94UCBCpMV735LbxJtMBfA7q9sMOENTQKMsmYHe3rpMm2KBDUcJt3aIp9q
	 p345k1QLDGwvQ==
Date: Tue, 30 Jan 2024 17:40:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andy Gross <agross@kernel.org>, Bjorn
 Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Robert Marko <robert.marko@sartura.hr>,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jie Luo
 <quic_luoj@quicinc.com>
Subject: Re: [net-next PATCH v2 3/3] arm64: dts: qcom: ipq8074: add
 clock-frequency to MDIO node
Message-ID: <20240130174041.74341188@kernel.org>
In-Reply-To: <65b84983.050a0220.e1700.35fd@mx.google.com>
References: <20240130003546.1546-1-ansuelsmth@gmail.com>
	<20240130003546.1546-4-ansuelsmth@gmail.com>
	<b1ff77bc-0833-493a-b099-884c727f0341@lunn.ch>
	<65b84983.050a0220.e1700.35fd@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 01:57:36 +0100 Christian Marangi wrote:
> > If we merge this via netdev, is a merge conflict likely? Any other
> > changes expected in this area, given the changes which might happen to
> > GCC soon, etc?
> > 
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> Honestly I don't expect much to change here in the mdio node.
> 
> If it's a problem I can submit in a separate patch in linux-msm.

The arch maintainers usually prefer to take the DTS patches,
so if there isn't anything special here we should probably
default to that.

