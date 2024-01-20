Return-Path: <linux-kernel+bounces-31741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E53833338
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 09:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64ED1C21395
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 08:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926B453A0;
	Sat, 20 Jan 2024 08:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="tZqtANBS";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="+RjBsCXc"
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A263A2108;
	Sat, 20 Jan 2024 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705738767; cv=pass; b=DQGVw0QZF2lbJ3Rb3LnkvKFkbH9o9sCwO2xHSBJnyFijbOdqC8B/xjU9Ht5SvKyy9JW3pWwDMu2BRqi2nPRw/pdmHkogHI4MReAPbff2m4ERK/8aP8eSVIWODoHYdc/RpVv5R50tcASmsopKuXcC0IwB03GjgiaKaijvEMjQv+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705738767; c=relaxed/simple;
	bh=g1DEhiUzUT8hQJuyvX7nFIRBR5dtm4ILy3mBqIcTL5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tyjfWL7FPkjF2FEK0nLhcaC27MrM0XntSNopBWy2FtzN7+pbZggDqGBW/i+mFPetRmvVvQ+WjwkpnSQgcMQhEjZllfXAGzhEgJKN7hUsf20VDcS108JlB4NcsqyH0Hi6zk3X/hv4TMhVY3FrNEzS1zqxeOsYCtV0AC9X2lSunAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=tZqtANBS; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=+RjBsCXc; arc=pass smtp.client-ip=81.169.146.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1705738737; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Wh449kVKll+g3dR60kHtxLxSRNSnk80Av/kxU1m0RSJRL5oHI2iJKv5zfouyCUE0Ti
    t/ofXZGxL1avQKbCYL6lFBHeAQE+OnJeSxYCMUDhU38HjUxjbVgPs7gjpY/W/fH0xhej
    rMPdx5obVSV4C6YupxlraKs0sDCCR3F3KPTcfLo0s4gUe6c/zKogMFXrdI+xYquepIrR
    0lOAz91Ee/AMlEz2Rg6eAi1EKo/Z3/dLjBG7trv6hVo7Xrzs7xiyqOA3E8FDopFzriwf
    anABZNKKghfZyDWlEmiMP5max3tNBR5JQROXUe0/gcqKKpPSIzuRfLGY84UL29iEMXOn
    J7sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1705738737;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=e8DAgnOLVfoyEsrKQQgwAc1q1FFLrMJ1P57T5soyOEw=;
    b=rWPi8d3+Zd2W+uuXOgHEB9u4PdCZtv5LeFv2aj3gvhapIjIofzTW0mHM0XsDN/HLNq
    CADPAUK100J2bgRJkUvWsv0K5LBn2STEJ0NKX1bnpMCtBHhHFCUTT8eX94t+/Ct3fqq0
    AsyTLUgls9sKjKsJsKCHuY2uMVCCmaQBiMOmx0hQB8v1U206qwIKL/n+bJLZGQNpKIxS
    bglFLc3691DqVq3hFt8f5LF7Y7Q4uPvIC2AqN6vEkNhLDP9mgP6zppVVwqHnvxZstjPI
    wPiPoB/5Kt1L1+it8pek3S8I51LqsXi+w9rS26lsF3HiZw7s0I+Z+Zjl6Mjlwqsavogi
    4h2w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1705738737;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=e8DAgnOLVfoyEsrKQQgwAc1q1FFLrMJ1P57T5soyOEw=;
    b=tZqtANBSVPwsMYRMq7+bdMleVBrsyXz7J8e4nIp/HVGkAdvdfxHoSnE7vqA87jKC5S
    fEplQVm+ZMVoLKwIWWL3s9j5V3TCJWbF5XyLopZ9z/au9M8Gx5DwdE15/w1KgbHZao4C
    quxGfVizri+IotQJXXjbA3HkDHTXNcy9JvWUGtbWOG5vcG7bP6SUBSR1XQ5UAWDSiUjc
    rWvhOsLOo4UXOzEEjyDWHO88DX0euWd9VjolSduoeBnmdE45InLDDLygWHFHDdhoTXWU
    9U/rXHRHg9Od5s8LSoIt/KjD5bZc1/CU8MaXm4CaM34z6vcXd2B/CcpMSOV/9Ogte+33
    eiUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1705738737;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=e8DAgnOLVfoyEsrKQQgwAc1q1FFLrMJ1P57T5soyOEw=;
    b=+RjBsCXc0lTpUGPMMYJVkHb0cIWfsBtk+pjmDzMzF7ppirqx53yPW9sr4DTgfmHH1R
    CkaHr97YfYZWl5fHaYAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDdAnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::90c]
    by smtp.strato.de (RZmta 49.10.2 AUTH)
    with ESMTPSA id K7b2c200K8IvbRX
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 20 Jan 2024 09:18:57 +0100 (CET)
Message-ID: <c3b29cc0-f352-468d-8030-00ed6de3e319@hartkopp.net>
Date: Sat, 20 Jan 2024 09:18:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: bcm: add recvmsg flags for own, local and remote
 traffic
To: Nicolas Maier <nicolas.maier.dev@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <4f433c14-94d5-493d-96b1-8a0180026ad5@gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <4f433c14-94d5-493d-96b1-8a0180026ad5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Nicolas,

On 2024-01-14 15:08, Nicolas Maier wrote:
> v2:
> * add 'traffic_flags' parameter to bcm_rx_update_and_send and
>    bcm_rx_cmp_to_index, to put the flags in the can frame after its data
>    has been copied

That looks great now!

> @@ -344,8 +360,16 @@ static void bcm_send_to_user(struct bcm_op *op, struct bcm_msg_head *head,
>   		 * relevant for updates that are generated by the
>   		 * BCM, where nframes is 1
>   		 */
> -		if (head->nframes == 1)
> +		if (head->nframes == 1) {
> +			pflags = bcm_flags(skb);
> +			*pflags = 0;

This initialization of the msg flags always has to be done.

I've sent a 'v3' patch that also simplifies the sock_skb_cb_check_size() 
usage:

https://lore.kernel.org/linux-can/20240120081018.2319-1-socketcan@hartkopp.net/

Please check if the changes fit for you.

I also created some user space testing code in my can-tests repo to 
prove the correct msg flags implementation:

https://github.com/hartkopp/can-tests/commit/67957def0b0035d79000f5baad93f8764ec11fc4

Works fine ;-)

Best regards,
Oliver

