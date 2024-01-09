Return-Path: <linux-kernel+bounces-20599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3658828235
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44C01C24ABD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34106328DF;
	Tue,  9 Jan 2024 08:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bYEmRngf"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A674E32187;
	Tue,  9 Jan 2024 08:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4B523922;
	Tue,  9 Jan 2024 09:37:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1704789446;
	bh=An17x/TosDCNv/2qZzVjPa+OEHjTqymUr94pBBedJzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bYEmRngfPqsRR8BSOfq4pWwu/WzaNWtiKQrilIkHwmWcMYm01YLh6c2UejushhwGH
	 KyAuFQl4WYbSg8oL6uTbLKdQUakm9eeHEDSKgoKOHBFVKLC00T8FzN2mfk0F5dKtKL
	 hdu+GS/dyv/NSWkpUxVcGyIL2FrX6qqw07qKswvY=
Date: Tue, 9 Jan 2024 10:38:39 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Zhi Mao =?utf-8?B?KOavm+aZuik=?= <zhi.mao@mediatek.com>
Cc: "mchehab@kernel.org" <mchehab@kernel.org>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"heiko@sntech.de" <heiko@sntech.de>,
	"gerald.loacker@wolfvision.net" <gerald.loacker@wolfvision.net>,
	"tomi.valkeinen@ideasonboard.com" <tomi.valkeinen@ideasonboard.com>,
	"yunkec@chromium.org" <yunkec@chromium.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dan.scally@ideasonboard.com" <dan.scally@ideasonboard.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	Shengnan Wang =?utf-8?B?KOeOi+Wco+eUtyk=?= <shengnan.wang@mediatek.com>,
	"hdegoede@redhat.com" <hdegoede@redhat.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	Yaya Chang =?utf-8?B?KOW8tembhea4hSk=?= <Yaya.Chang@mediatek.com>,
	"bingbu.cao@intel.com" <bingbu.cao@intel.com>,
	"jacopo.mondi@ideasonboard.com" <jacopo.mondi@ideasonboard.com>,
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"10572168@qq.com" <10572168@qq.com>,
	"sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>,
	"macromorgan@hotmail.com" <macromorgan@hotmail.com>
Subject: Re: [PATCH 1/2] media: i2c: Add GC08A3 image sensor driver
Message-ID: <20240109083839.GH20868@pendragon.ideasonboard.com>
References: <20231207052016.25954-1-zhi.mao@mediatek.com>
 <20231207052016.25954-2-zhi.mao@mediatek.com>
 <1d58c2b9-4206-409c-b312-87f4fb649512@linaro.org>
 <e709beb2acaf0cb68c6922f3b48431644e9a0246.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e709beb2acaf0cb68c6922f3b48431644e9a0246.camel@mediatek.com>

Hello Zhi,

HTML e-mails are not allowed on the Linux kernel mailing list. Please
use plain text only.

[snip]

> ************* MEDIATEK Confidentiality Notice
>  ********************
> The information contained in this e-mail message (including any
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be
> conveyed only to the designated recipient(s). Any use, dissemination,
> distribution, printing, retaining or copying of this e-mail (including its
> attachments) by unintended recipient(s) is strictly prohibited and may
> be unlawful. If you are not an intended recipient of this e-mail, or believe
> 
> that you have received this e-mail in error, please notify the sender
> immediately (by replying to this e-mail), delete any and all copies of
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!

This is also not appropriate for mailing lists. Please ensure that
future replies will not contain such footers. You may need to contact
your IT department if they are added automatically by the Mediatek mail
servers.

-- 
Regards,

Laurent Pinchart

