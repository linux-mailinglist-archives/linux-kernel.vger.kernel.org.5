Return-Path: <linux-kernel+bounces-110080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4AB8859D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 909ED1F228EA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2E584A59;
	Thu, 21 Mar 2024 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtG6PS56"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668527C6DF;
	Thu, 21 Mar 2024 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026809; cv=none; b=SNcMcO+2BteV+9XasQJpZ6wTsGQZ2ug3uoUBeXpiHRohkuNm5VIF21i0fuvlzhEMIlCy5JpsFXmHWlmRHCFaEedfY6Oxx/KwgXIaYallefp4w4wzbpxl2H3bFjqc9cd5/x16VuKYnty3Wl04Io1JZug+wxC6KwMiVDDEi8dVMK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026809; c=relaxed/simple;
	bh=wM7dULtUyZv/B/ii8vtIVtiiq8Ch3qqzcIVz2KP55DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C766G/uBuDiOwXit8OPTADvyD321ta2M0uT5pxueeeSEyd8+UGiXi6AnuzPSEcEF1KdhiFxuFXkvV4zIr9QvqiuT7UHYEjW9NLORUWhC831E8z3qWITnqEn2p+ViH2x/JtMyFwwvQUcx5seD6A2oFja3bmfQsEbxxDU3aL0qmCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtG6PS56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A846BC43390;
	Thu, 21 Mar 2024 13:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711026808;
	bh=wM7dULtUyZv/B/ii8vtIVtiiq8Ch3qqzcIVz2KP55DM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YtG6PS56bQ71xd/TLXqxc26Z8ZM8GilyQNwoEIcqayzSv9W07frvL09xdo7njPY7b
	 m9eTL/A6k2dmlHJF4PGryebXrdAM+TNwVNv9V0HMbEC3I0t2EQfhDoVDZ0nfhT7lq+
	 Zubma6NXLySBG7SPn9McGb50M3htZFl/oNuawbzMIhSClyZVBdB/OBpk1yuunTRTfX
	 qRUxCm9c04TlBTxEkF3FypLTbf9XEyM2XU7wIKwxaf823KIBOaTVL01l6kUxBiw64I
	 X2X53mORgWtjxXr60Vp0ypIzqyjJvYY/Bp5aWknYgRS/HeFlbJ2h3Kr30pMrdozsxb
	 WkqQxc6LHzY8w==
Date: Thu, 21 Mar 2024 08:13:26 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Conor Dooley <conor@kernel.org>, Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: display: samsung,exynos5-dp: convert to
 DT Schema
Message-ID: <20240321131326.GA1593587-robh@kernel.org>
References: <20240313182855.14140-1-krzysztof.kozlowski@linaro.org>
 <20240320-reanalyze-koala-4c086a24fee0@spud>
 <90f0c8e5-01ec-4cb9-88a0-fe36d8d20443@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90f0c8e5-01ec-4cb9-88a0-fe36d8d20443@linaro.org>

On Thu, Mar 21, 2024 at 08:37:15AM +0100, Krzysztof Kozlowski wrote:
> On 20/03/2024 18:04, Conor Dooley wrote:
> > On Wed, Mar 13, 2024 at 07:28:55PM +0100, Krzysztof Kozlowski wrote:
> > 
> >> +  clock-names:
> >> +    items:
> >> +      - const: dp
> > 
> >> +  phy-names:
> >> +    items:
> >> +      - const: dp
> > 
> > The items lists here are redundant when you only have a single item, no?
> > Isnt it just
> > phy-names:
> >   const: dp
> 
> Somehow the convention for properties was to define the list. Unlike for
> compatible where we use shorter syntax like you propose. Shall we change
> the approach and use shorter syntax in general?

I guess the difference is -names is usually more than 1 whereas 
compatible is frequently only 1. Either way is fine I think.

Rob

