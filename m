Return-Path: <linux-kernel+bounces-7502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AECE681A8FD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE3428D38E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB39F4B5B0;
	Wed, 20 Dec 2023 22:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XLjtep/4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7249C4A9A3
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 874465C0889;
	Wed, 20 Dec 2023 17:17:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 20 Dec 2023 17:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703110669; x=1703197069; bh=OZRcAdL4EQ+8sSj6ubSGPK48MTy5
	E2DQIyh6YCxr9S0=; b=XLjtep/4NmK0SclOZydu+yJDTtTDQwxCTXQKQzTxBqAu
	CMbfpzE5X4GOygiu0cJW0XDz58L9jyx0AQLj33nDNvm+6m58rJO/Q/t8fs564Le6
	nzBWv+4LoNg0chc6f7IlwU4N8XPR0EYdIydx03v9jsMN8iRP00cHGqZtfZxoUbBg
	S9Sqzh1ducFentSuC18DjT7IYy3mPd00Y8iFOK/agtFlQe23WwXIz0QVN4jGbG7O
	qIVdrBn1Q8Z+zd2+SD/AJatFB9NPczsCR/v01vY7Om3+N+2DM+KeUYHCRPuSHWUy
	w6698URHm8OL2NsEbvRQpW9C0woVyh9jlN1QCWk2Xg==
X-ME-Sender: <xms:DGiDZazJvIXPi_GohPSX8i02ceUZiWW_uNuezbgG3lHDH3H9zhKAfQ>
    <xme:DGiDZWSCGOkO77iV-kUgjZSyazbbWvg7QKW4TdEKQllB6fFa-AKts_nmtMFH8hz_J
    EKRx5b6aiMhuUNm_uE>
X-ME-Received: <xmr:DGiDZcW0JSgWif7GHXBseiVWrQy_9LnikjwIYR72iLPvSZpl9hAlh39JfFvPrC-rXq6Y4BvEK50st8WAy1Fm28PtAPfZX3fLE5I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhn
    ucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrf
    grthhtvghrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedv
    ueehueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:DGiDZQhi9rgfc-DMN0Ru5-5iFBZ_mL0fYDy2-7cuYIxwdX3Cg_ETgA>
    <xmx:DGiDZcCxnqjsT8Z7tWzOhlUXfbBqkjWffDGRT_2mzOn0WxSuhQVOQw>
    <xmx:DGiDZRLLKj3jnNpn3oyv9ou-avzfVrYHTuTwZceUncly4Zi_UH5N6g>
    <xmx:DWiDZXrF6DspBFtBbO_pM4h3FN9BDAj_LhyjrkwRfaw7hgJXIfDo9w>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Dec 2023 17:17:46 -0500 (EST)
Date: Thu, 21 Dec 2023 09:18:10 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH] nubus: make nubus_bus_type static and constant
In-Reply-To: <2023121940-enlarged-editor-c9a8@gregkh>
Message-ID: <af81751a-f562-a7d5-b754-ff6ac02082c2@linux-m68k.org>
References: <2023121940-enlarged-editor-c9a8@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Tue, 19 Dec 2023, Greg Kroah-Hartman wrote:

> Now that the driver core can properly handle constant struct bus_type,
> move the nubus_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> It's also never used outside of drivers/nubus/bus.c so make it static
> and don't export it as no one is using it.
> 
> Cc: Finn Thain <fthain@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Finn Thain <fthain@linux-m68k.org>

Thanks, Greg.

> ---
>  drivers/nubus/bus.c   | 3 +--
>  include/linux/nubus.h | 2 --
>  2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/nubus/bus.c b/drivers/nubus/bus.c
> index 72921e4f35f6..12df4d88970c 100644
> --- a/drivers/nubus/bus.c
> +++ b/drivers/nubus/bus.c
> @@ -32,12 +32,11 @@ static void nubus_device_remove(struct device *dev)
>  		ndrv->remove(to_nubus_board(dev));
>  }
>  
> -struct bus_type nubus_bus_type = {
> +static const struct bus_type nubus_bus_type = {
>  	.name		= "nubus",
>  	.probe		= nubus_device_probe,
>  	.remove		= nubus_device_remove,
>  };
> -EXPORT_SYMBOL(nubus_bus_type);
>  
>  int nubus_driver_register(struct nubus_driver *ndrv)
>  {
> diff --git a/include/linux/nubus.h b/include/linux/nubus.h
> index bdcd85e622d8..4d103ac8f5c7 100644
> --- a/include/linux/nubus.h
> +++ b/include/linux/nubus.h
> @@ -89,8 +89,6 @@ struct nubus_driver {
>  	void (*remove)(struct nubus_board *board);
>  };
>  
> -extern struct bus_type nubus_bus_type;
> -
>  /* Generic NuBus interface functions, modelled after the PCI interface */
>  #ifdef CONFIG_PROC_FS
>  extern bool nubus_populate_procfs;
> 

