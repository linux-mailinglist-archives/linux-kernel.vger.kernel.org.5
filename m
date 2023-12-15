Return-Path: <linux-kernel+bounces-453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAB781414F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C3528439E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066ECCA6F;
	Fri, 15 Dec 2023 05:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f2g2AoDk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B427CA64
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 05:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=VnY4Tj+dtmGl0GZ86xgXqce9hVbPF6aFLFaJDWM1z5c=; b=f2g2AoDkFOSn4ODIYzp6usCO/c
	p/dTqw5KkTy804NeQS/yjH0CKgDND1/LSaYSDDCx/WXSWgN+5ca8D4/hZd/iueGqodGbaHw9dhAI7
	VQrmCMJFmfJUzweXuoJswO+G10XyQ3qzw7vtyUxcU+wy9aVD2ZfIYC/9CTkgFWhSnPA7Swqz4GHKJ
	083nsx+B5dzYGScAema8/Fgjs2OP2T5rJBy0VP0u3dHzkVsk6cpxyErcyMxwQDmPda8KkaKEh+fB1
	3lCJwiLTJ2yJmtSQ0P8V2prcDK0B3WTb+JLH43HE89VQ6xIAqsQeHC2f7FGwvcvdniYDBe8UYDvI2
	JEzHEMQA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rE0rR-00252W-0R;
	Fri, 15 Dec 2023 05:35:45 +0000
Message-ID: <346d12b2-a78e-4372-880a-e522fdca7169@infradead.org>
Date: Thu, 14 Dec 2023 21:35:43 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: gpu: drm: vmwgfx: fixed typos
Content-Language: en-US
To: Ghanshyam Agrawal <ghanshyam1898@gmail.com>, zackr@vmware.com,
 linux-graphics-maintainer@vmware.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20231215053016.552019-1-ghanshyam1898@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231215053016.552019-1-ghanshyam1898@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/14/23 21:30, Ghanshyam Agrawal wrote:
> Fixed some typos in vmwgfx_execbuf.c
> 
> Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> index 36987ef3fc30..272141b6164c 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> @@ -621,10 +621,10 @@ static int vmw_resources_reserve(struct vmw_sw_context *sw_context)
>   * @sw_context: Pointer to the software context.
>   * @res_type: Resource type.
>   * @dirty: Whether to change dirty status.
> - * @converter: User-space visisble type specific information.
> + * @converter: User-space visible type specific information.

ack.

>   * @id_loc: Pointer to the location in the command buffer currently being parsed
>   * from where the user-space resource id handle is located.
> - * @p_res: Pointer to pointer to resource validalidation node. Populated on
> + * @p_res: Pointer to pointer to resource validation node. Populated on
>   * exit.

ack.

>   */
>  static int

Please also fix this one:
vmwgfx_execbuf.c:1072: asynchronus ==> asynchronous

I suggest that you try codespell.

Thanks.
-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

