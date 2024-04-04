Return-Path: <linux-kernel+bounces-131669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FEC898A9D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B79372917BD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CC312BEB7;
	Thu,  4 Apr 2024 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaVIpo7K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5411D551;
	Thu,  4 Apr 2024 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712242919; cv=none; b=CNgwtdJYgSWk/6HCzfKI5PtHheMhPDt1V5N2Ec9sVxNtgK8sBXYw95dxhgxagGgjLmsGBt0fXScCxlW2AClr1uxgq2P7yjT62PrHPs86JzQx54qDTsU2uQfrEcmOO9AkITaXfcISHbZ+Wol4VdUHI06eJkV599ZjzsP1S2DhRWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712242919; c=relaxed/simple;
	bh=m37CGWgGDzDmqqe0wk4eeU3R+P2kwq9EU6P+HBudePA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VOAfbJGO5BUgzB3qSD/o1HLUVN24QIMCpvD+jBGS9p/DlZyr8ruVzX1dz3LlPk218+wxqwTg/cXzKgQcHZiObEfDYgEoyIzs2/kCOYBY930KBwX6LtJRQoQHFG/MFrnrNBOrL1v4zvERcpfViEpFG53aHsi/9tqAMb56H/mFh90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaVIpo7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D121C433C7;
	Thu,  4 Apr 2024 15:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712242918;
	bh=m37CGWgGDzDmqqe0wk4eeU3R+P2kwq9EU6P+HBudePA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=qaVIpo7KcwdH/2KGDFx1mUZTuMagPUnp8++R3YOCdX87zDybHhWnCcJC3PyNi2bW9
	 BI7jfEPRj8JzPlIooc9+HkzESGwDGV6Y9ij240rM/UHWhO20Q+XTXJCTPeNzihyEbG
	 TYRbqil/VAwNNwbUzFisJ6vOTzjsdxiX39pCHfqNImY5YpMsM3zV3vGydohSsx0veC
	 Kik4rPAp1JZYjLXiu55enmnEQ6MnLLMfpUpbPN/UwffcReqM68sIBC+paK/A+EYTL6
	 AeJMDxRdfWiHbkDTbZANN2Rsvjl38dw5kKQ5XVqVo4cDL+4hxI+lFqFr95RcUZOJCs
	 dLhuGXRiUHz0g==
From: Kalle Valo <kvalo@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: aleksander.lobakin@intel.com,  kuba@kernel.org,  davem@davemloft.net,
  pabeni@redhat.com,  edumazet@google.com,  elder@kernel.org,
  linux-arm-kernel@lists.infradead.org,
  linux-mediatek@lists.infradead.org,  nbd@nbd.name,
  sean.wang@mediatek.com,  Mark-MC.Lee@mediatek.com,  lorenzo@kernel.org,
  taras.chornyi@plvision.eu,  Matthias Brugger <matthias.bgg@gmail.com>,
  AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
  quic_jjohnson@quicinc.com,  leon@kernel.org,
  dennis.dalessandro@cornelisnetworks.com,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/5] allocate dummy device dynamically
References: <20240404114854.2498663-1-leitao@debian.org>
	<87plv549ts.fsf@kernel.org> <Zg63iwvtTMlZSGcd@gmail.com>
Date: Thu, 04 Apr 2024 18:01:52 +0300
In-Reply-To: <Zg63iwvtTMlZSGcd@gmail.com> (Breno Leitao's message of "Thu, 4
	Apr 2024 07:22:03 -0700")
Message-ID: <87le5t41en.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Breno Leitao <leitao@debian.org> writes:

> Hello Kalle,
>
> On Thu, Apr 04, 2024 at 02:59:59PM +0300, Kalle Valo wrote:
>> Breno Leitao <leitao@debian.org> writes:
>> 
>> > struct net_device shouldn't be embedded into any structure, instead,
>> > the owner should use the private space to embed their state into
>> > net_device.
>> >
>> > But, in some cases the net_device is embedded inside the private
>> > structure, which blocks the usage of zero-length arrays inside
>> > net_device.
>> >
>> > Create a helper to allocate a dummy device at dynamically runtime, and
>> > move the Ethernet devices to use it, instead of embedding the dummy
>> > device inside the private structure.
>> >
>> > This fixes all the network cases except for wireless drivers.
>> >
>> > PS: Due to lack of hardware, unfortunately all these patches are
>> > compiled tested only.
>> 
>> BTW if it helps, and if you have an ath10k or ath11k patch already, I
>> can run a quick test on real hardware.
>
> That would be very much appreciated! Thanks!
>
> I don't have them ready yet, but, I will work on them soon and I will
> send it to you probably tomorrow.
>
> Should I send them as RFC, or as a regular patch, and we iterate over?
> What would you prefer?

A regular patch, like you did last time with ath11k, is fine for me. But
please do add a lore or patchwork link to the depency patchset so that
I'm testing with correct patches.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

