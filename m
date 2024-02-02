Return-Path: <linux-kernel+bounces-49310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E957846888
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A335283D97
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13C017996;
	Fri,  2 Feb 2024 06:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="E4nh1c5M"
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3894182A0;
	Fri,  2 Feb 2024 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856586; cv=pass; b=FcbSkga1dfpBbPAMto9zL3fdzx7Rl6ci1T0j+xYA7FfPXreqMo8IlXEMFhzfOoESRS/a9oP4+8t6YStZcVt/09MchNaRsghq/XdSMeBU9pkftQ1hYpyjijqdi7Z18Xi0OoZnCQvo7g14WRXTLgQw71Pmd6G3HsLesoeWu6+nqbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856586; c=relaxed/simple;
	bh=cI4t2m1K4N4nI9kr6LJY7dfRYR18tBAIKGW+bSIN52c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0DwTOgi2IT5kLJqY4CYEdqT+GREeQ7KuqW/7puV2a1SSymHKIvL6oCzGGhMxPc1SQZt0RBp1BhSDaTUFS1AwmGxEH5cKVC/TsZDBN8goR1Oc2RBDXGJRFoem5FbB1b2fiBZ2YMf+kYwqqOXPcVk/VcVeLDKhu1dthDcOyw6+kI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=E4nh1c5M; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from hillosipuli.retiisi.eu (2a00-1190-d1dd-0-c641-1eff-feae-163c.v6.cust.suomicom.net [IPv6:2a00:1190:d1dd:0:c641:1eff:feae:163c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TR5wy73RVz49Q05;
	Fri,  2 Feb 2024 08:49:38 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1706856580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8LePBLWdUkHfkTJ/OCvJo4ZmKQvMph9R1nxnUHE5gms=;
	b=E4nh1c5MoZj5NYLeS+pqPp3W/IIw3lhf+LpH78+ySLvM9Fca8IIBUhu0qiOdGGGCxW5uYL
	pdIEMWx0++bigZO3DYrTAEdW+xF3UMwgGB6r34jkGtFOL2UIRKXK4uXE++BdcVFM6QaEpZ
	HD7Bd/3MQhS/rAI76MTqvKhrofDEmCIUFSeVn4epXN5vjvE6zVZ4VvywsL8SeyC/aQifuj
	g9Euk2WOgzoVxe1/Y4qDXIkhCr8xigNkaZUeWCfIEggK1YEUYFBkDjvZP7Trv9aJ+HmhLu
	DWx3qrraMOz0P/AfHjibHcQnWRZT0q4nvUyfN/awWOIye88DZhISXkx8MT0VxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1706856580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8LePBLWdUkHfkTJ/OCvJo4ZmKQvMph9R1nxnUHE5gms=;
	b=gSynK9xwvaBlxIEci7rjQVyhNSPrtww6XkfAHBLfYCwfEm/2Pl9nFpdtTgoUwIs3XUi/SL
	dFL1QJDBDhGVR8FUaIkXF/tpg2gV1Et7p8mRPebh6nYraoR/YVQwLf1XbjCHKr7lhfVNLJ
	cpeO8epmlAVnOu0lE/rJQZ5uXQL2AbiFCNDGNqUVQFS3YUYsK7K2i1JJHR5K+VYul+0aVU
	wr7T+E5W4YLFI+M7ZbtNivE800Iwz1eJz+rgqcazX6PieGBXHzq5PWf4it2Cmkc7Zri7Pd
	AgXa7l57lsnR2gdXF4j9iQawsXzAZzF8bHyYGQl7kJo1ixG3+20KeRV8+RiEwQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1706856580; a=rsa-sha256;
	cv=none;
	b=Me6OJuBNa5iWFctTEljFkVa0gOOu1RkesBTrVGd74CebFvh1tes3yRtrQIdbT8fOb8aWtA
	iiGLvxnHTFgCFCaAQXD2GOG3hlLzcwins1fHvCvve/xUx5LzqC0inYv4eSGrqJW3VjQeEf
	pwZ0znUALTN4HGnfiVSsru+2WDuXzpgNzkZ9j8fOFCKsjMWkQ6/aZYIDNiBbKIGo9ne1w2
	HVA/l/oa/5o0JMkgk3y3QTRm3Ih57IhiLRbDR7r9qfBKpzdkbj98K5vslOtoZVh7Wst4Iz
	m36+Y0JqREGT9HkK6P2TrbYHhPUOZTn/iZxcauyaVMKV6LcLnqEyUYs4p9NSgw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 87F0E634C93;
	Fri,  2 Feb 2024 08:49:38 +0200 (EET)
Date: Fri, 2 Feb 2024 06:49:38 +0000
From: Sakari Ailus <sakari.ailus@iki.fi>
To: yuji2.ishikawa@toshiba.co.jp
Cc: hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
	mchehab@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nobuhiro1.iwamatsu@toshiba.co.jp, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 4/5] documentation: media: add documentation for
 Toshiba Visconti Video Input Interface driver
Message-ID: <ZbyQgkGicrnP-XZL@valkosipuli.retiisi.eu>
References: <20231012071329.2542003-1-yuji2.ishikawa@toshiba.co.jp>
 <20231012071329.2542003-5-yuji2.ishikawa@toshiba.co.jp>
 <ZV3oq0szH8JjSNsc@valkosipuli.retiisi.eu>
 <TYAPR01MB620180FF82B8993B45FF6E0A9286A@TYAPR01MB6201.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAPR01MB620180FF82B8993B45FF6E0A9286A@TYAPR01MB6201.jpnprd01.prod.outlook.com>

Hi Yuji,

On Mon, Dec 04, 2023 at 04:32:40AM +0000, yuji2.ishikawa@toshiba.co.jp wrote:
> > > +Vendor specific v4l2 controls
> > > +=============================
> > > +
> > > +.. _V4L2_CID_VISCONTI_VIIF_MAIN_SET_RAWPACK_MODE:
> > > +
> > > +V4L2_CID_VISCONTI_VIIF_MAIN_SET_RAWPACK_MODE
> > > +--------------------------------------------
> > > +
> > > +This control sets the format to pack multiple RAW pixel values into a word.
> > > +
> > > +This control accepts a __u32 value defined as `enum viif_rawpack_mode`.
> > > +
> > > +This control should be set before ioctl(S_FMT) and should not be changed
> > after that.
> > 
> > Why do you need this? Doesn't the V4L2 pixelformat already explicitly define
> > the format, including packing?
> > 
> 
> This control value affects the unpacker between CSI2 receiver and ISP.
> The rawpack mode is an option to receive from Wide-Dynamic-Range image
> sensors, whose output bit width is larger than standard format (RAW20,
> RAW24). For example, some WDR image sensors split 20 bit value into
> upper/lower 10bit values, then put them into consective pixels to make a
> double-width RAW10 format image.

Do you have a sensor that really does this? Which one is it?

> 
> This option is only related to the interpretation of CSI2 input data.
> Therefore, I think V4L2 pixel format (for resulting image) is not related
> to it. The media bus format seems more relevant, but there is no
> corresponding definition to this case.

-- 
Regards,

Sakari Ailus

