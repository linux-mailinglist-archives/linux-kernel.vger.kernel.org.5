Return-Path: <linux-kernel+bounces-85387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA3A86B548
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40496B27398
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9330200D6;
	Wed, 28 Feb 2024 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlOPyPJH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323FD1CAAB;
	Wed, 28 Feb 2024 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709138867; cv=none; b=D3+FEFbc6V4DqSwz5u+SdW9qr83w18OrJSZn8M776O00tpBFzwllAj5ffLhNKh/QR9LbXFTHREbjMQPHOiYEic4qAAoSWGYrws7KzYnszfatanJhGk/MAKmVuKwTuQ4pprGpctAeCDHyQH4o7puwRRawKZRxjm+Idq8Tw46dXaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709138867; c=relaxed/simple;
	bh=b2TpBXK1sp4wEplxo/EQpyW1+4g2o5H3qAMXu1AYNxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEq/WMVdCXycEG8GDq3P+mZNuLlp3uRcl3uFdEPNMwK0uL5uT25cZL+/MQWhM7sVZ6qKC1JXUgZc0/10QrI9L3B1oqHptpp9UJCqW2dBqNbZpFCDpi6t4OqE3xk+aa9i8rZWRTGHqNvPZAw8Ogrdgtvu8Egj5O6L1x+kXWewA/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlOPyPJH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AECBC433F1;
	Wed, 28 Feb 2024 16:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709138866;
	bh=b2TpBXK1sp4wEplxo/EQpyW1+4g2o5H3qAMXu1AYNxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SlOPyPJH0Q3n61zNPv2CtaRLZsu835s9RCoOxB9tccvh+YmK0bCXszPguvmSj3UQ+
	 7j9ciw0uyFiQBW2mvwgha4eVr8icKqtkhD6hY8LTc6nXsw07bfIWOmrDH8ETs5Ism7
	 IMuNBMeg8Wr4l6eQyvlp8bDAho2r3MNzRiXAK4CPNsu/hAN1aZil9mNvazQznu1Hqq
	 PI8KJ7AmfmfEbB/9jw/l7j4Vmy9h4nLKCO8P1rcK5GoL7WDAV8zS0DNHS171jsy0C6
	 NEqVkAMkmjq8MCinLk9RkD0cJLjrrbZyi6nh6+dGNr8ueLGIWwnzbHMjrY3hH30qXt
	 EraAI9g4b+0pw==
Date: Wed, 28 Feb 2024 08:47:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mateusz Pacuszka
 <mateuszx.pacuszka@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Lukasz Plachno <lukasz.plachno@intel.com>, Jakub Buchocki
 <jakubx.buchocki@intel.com>, Pawel Kaminski <pawel.kaminski@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Mateusz Polchlopek
 <mateusz.polchlopek@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Pawel
 Chmielewski <pawel.chmielewski@intel.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>
Subject: Re: [PATCH iwl-net 0/5] ice: LLDP support for VFs
Message-ID: <20240228084745.2c0fef0e@kernel.org>
In-Reply-To: <20240228155957.408036-1-larysa.zaremba@intel.com>
References: <20240228155957.408036-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 16:59:44 +0100 Larysa Zaremba wrote:
> Allow to:
> * receive LLDP packets on a VF
> * transmit LLDP from a VF
> 
> Only a single VF per port can transmit LLDP packets,
> all trusted VFs can transmit LLDP packets.
> 
> For both functionalities to work, private flag
> fw-lldp-agent must be off.
> 
> I am aware that implemented way of configuration (through sysfs) can be
> potentially controversial and would like some feedback from outside.

Why is the device not in switchdev mode? You can put your lldp-agent
priv flag on repr netdevs.

