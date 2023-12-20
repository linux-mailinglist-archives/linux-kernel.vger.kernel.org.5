Return-Path: <linux-kernel+bounces-6983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AD281A017
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62261283389
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDD436AFC;
	Wed, 20 Dec 2023 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="SdJP7RPx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5D6358B2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK4mAWI007661;
	Wed, 20 Dec 2023 07:43:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=/1zZp2T9SCFVazsLTZinSc7wiio2ryvn9pz9Ao5CZIk=; b=
	SdJP7RPx++fX2gXunIkfrGpeRB5yYQvNPlnmBsR3OZbwZaaZB0W8jk7NfWP6xjot
	sGxggMbl2iH+awYK9e65qce9hLPSt4Y5AHzUMNGTbelM9UNxufqS9M0PskshJ3eX
	kvc/hqo+iX1wuwD67vAw1mrszNJqf8TVwoYHahTr4kiUJkHVQ0b5BYfIx/t9rVD2
	ZeaFetYIoxVJS7d/vrCX1qoMzrPUB7qJX9eZYbHGldbbr0QrrSVo2X3//nTrp8rK
	7RKH9zeDBMDs/L6DP2K8Cww2Z0d8nMm0w5Zy+cXgIXk/AbMqLo+0NhLrXJW/Hd/V
	c0PQToEqTEmq/fUHVodlcQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3v1a625fta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 07:43:58 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 13:43:56 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.40 via Frontend
 Transport; Wed, 20 Dec 2023 13:43:56 +0000
Received: from [198.61.64.132] (LONN2DGDQ73.ad.cirrus.com [198.61.64.132])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2E5FD468;
	Wed, 20 Dec 2023 13:43:56 +0000 (UTC)
Message-ID: <8170413d-07a8-4e77-b43d-78cd9e4ea76f@opensource.cirrus.com>
Date: Wed, 20 Dec 2023 13:43:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ALSA: hda: cs35l41: Safety-guard against capped
 SPI speed
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>, <tiwai@suse.de>
CC: <alsa-devel@alsa-project.org>, <david.rhodes@cirrus.com>,
        <james.schulman@cirrus.com>, <josbeir@gmail.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <perex@perex.cz>, <stuarth@opensource.cirrus.com>, <tiwai@suse.com>
References: <87ttokpyws.wl-tiwai@suse.de>
 <20231220073809.22027-1-alex.vinarskis@gmail.com>
 <20231220073809.22027-2-alex.vinarskis@gmail.com>
Content-Language: en-GB
From: Stefan Binding <sbinding@opensource.cirrus.com>
In-Reply-To: <20231220073809.22027-2-alex.vinarskis@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fHR91hkR7HjeDRkq3aT_8gm0mahY-tp6
X-Proofpoint-ORIG-GUID: fHR91hkR7HjeDRkq3aT_8gm0mahY-tp6
X-Proofpoint-Spam-Reason: safe

Hi,

On 20/12/2023 07:38, Aleksandrs Vinarskis wrote:
> Some devices with intel-lpss based SPI controllers may have misconfigured
> clock divider due to firmware bug. This would result in capped SPI speeds,
> which leads to longer DSP firmware loading times.
> This safety guards against possible hangs during wake-up by not
> initializing the device if lpss was not patched/fixed UEFI was not
> installed
>
> Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> ---
>   sound/pci/hda/cs35l41_hda_property.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
> index c9eb70290973..cb305b093311 100644
> --- a/sound/pci/hda/cs35l41_hda_property.c
> +++ b/sound/pci/hda/cs35l41_hda_property.c
> @@ -210,6 +210,19 @@ static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physde
>   
>   	if (cfg->bus == SPI) {
>   		cs35l41->index = id;
> +		/*
> +		 * Some devices with intel-lpss based SPI controllers may have misconfigured
> +		 * clock divider due to firmware bug. This would result in capped SPI speeds,
> +		 * which leads to longer DSP firmware loading times.
> +		 * Avoid initializing device if lpss was not patched/fixed UEFI was not installed
> +		 */
> +		spi = to_spi_device(cs35l41->dev);
> +		if (spi->max_speed_hz < CS35L41_SPI_MAX_FREQ/2) {
> +			dev_err(cs35l41->dev,
> +				"SPI's max_speed_hz is capped at %u Hz, will not continue to avoid hanging\n",
> +				spi->max_speed_hz);
> +			return -EINVAL;
> +		}

Not sure I agree with completely disabling the CS35L41 Speaker Driver if 
the SPI speed is low (for laptops without _DSD).
With a slow speed the driver does not hang - it just takes a long time 
(~80s per amp) to load the firmware.
Instead I would prefer that we instead disable the loading of the 
firmware in this case.
Without loading firmware, the volume is much lower, but at least you 
still have audio.
I have a patch to do that, which I was planning on pushing up 
(hopefully) today.

Thanks,

Stefan

>   		/*
>   		 * Manually set the Chip Select for the second amp <cs_gpio_index> in the node.
>   		 * This is only supported for systems with 2 amps, since we cannot expand the
> @@ -219,8 +232,6 @@ static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physde
>   		 * first.
>   		 */
>   		if (cfg->cs_gpio_index >= 0) {
> -			spi = to_spi_device(cs35l41->dev);
> -
>   			if (cfg->num_amps != 2) {
>   				dev_warn(cs35l41->dev,
>   					 "Cannot update SPI CS, Number of Amps (%d) != 2\n",

