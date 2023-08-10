Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AD47775D4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjHJKaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbjHJKaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:30:35 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDD310E6;
        Thu, 10 Aug 2023 03:30:34 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37A9okiN000824;
        Thu, 10 Aug 2023 05:30:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=3KCNIBufXXllmQe
        LmIyy9VlEgEQbQ4OwfXT0XBS63n8=; b=aOVRczioHpoW7nuu7wmHcoR10bTaYCp
        L6IfX2v2yxwX0SS3vA1VJk78NrN/kX0DablD4dvxCRZBHdGPBN9rx4unBXW8rZrg
        CRITaoDOCB5E2EpdCNBnHF8S1oCuimExZyWsEe1ylpDIYJ6Nt8pkkytJB2/I6rf7
        GR/WKKRoUgF1bcKfOHkD2dROPvxkILEPPNMgY/BXpvkbUAqeVm6qOEV3q8KdxkZw
        UDV5l0x776aQOluEWoinX9vmj/bKbwoySzFqYRSR2SueBlEkVGeriu0oNtsqm/Td
        wJWpvsDPk2YLPWsUmWCLqB92ELHPGpjwpsjK3qynCpSlv9TGvFV2ZOg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s9juhvnxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 05:30:06 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 10 Aug
 2023 11:30:05 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Thu, 10 Aug 2023 11:30:05 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 08F67357C;
        Thu, 10 Aug 2023 10:30:05 +0000 (UTC)
Date:   Thu, 10 Aug 2023 10:30:05 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     James Ogletree <james.ogletree@cirrus.com>
CC:     <dmitry.torokhov@gmail.com>, Fred Treven <fred.treven@cirrus.com>,
        "Ben Bright" <ben.bright@cirrus.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Jeff LaBundy <jeff@labundy.com>, Joel Stanley <joel@jms.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Jacky Bai <ping.bai@nxp.com>,
        Jean Delvare <jdelvare@suse.de>,
        Eddie James <eajames@linux.ibm.com>,
        "Markus Schneider-Pargmann" <msp@baylibre.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        <patches@cirrus.com>, <linux-input@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] Input: cs40l50 - Initial support for Cirrus Logic
 CS40L50
Message-ID: <20230810103005.GZ103419@ediswmail.ad.cirrus.com>
References: <20230809191032.820271-1-james.ogletree@cirrus.com>
 <20230809191032.820271-3-james.ogletree@cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230809191032.820271-3-james.ogletree@cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 2SYQ1YWorCAFRW1KB-DvS-shu20JoDbM
X-Proofpoint-ORIG-GUID: 2SYQ1YWorCAFRW1KB-DvS-shu20JoDbM
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 07:10:28PM +0000, James Ogletree wrote:
> Introduce support for Cirrus Logic Device CS40L50: a
> haptics driver with waveform memory DSP and closed-loop
> algorithms.
> 
> Signed-off-by: James Ogletree <james.ogletree@cirrus.com>
> ---
>  MAINTAINERS                      |    2 +
>  drivers/input/misc/Kconfig       |   33 +
>  drivers/input/misc/Makefile      |    3 +
>  drivers/input/misc/cs40l50-i2c.c |   67 ++
>  drivers/input/misc/cs40l50-spi.c |   67 ++
>  drivers/input/misc/cs40l50.c     | 1008 ++++++++++++++++++++++++++++++
>  include/linux/input/cs40l50.h    |  321 ++++++++++

Is this part not going to support streaming at some point? Fine
if not, but it seems likely to me and as such we should probably
follow the l26 stuff and make this an MFD from the start, even if
we haven't implemented the audio bits.

> +
> +static int cs40l50_pseq_write(struct cs40l50_private *cs40l50, u32 addr, u32 data)
> +{
> +
> +static int cs40l50_owt_upload(struct cs40l50_private *cs40l50, s16 *in_data, u32 in_data_nibbles)
> +{

These pseq and OWT bits, could they be shared with l26?
Definitely worth syncing with those guys, my assumption is the
wavetable/pseq won't have changed much and it might be nice to
factor these bits out into some library code that both drivers
can use.

> +err_free:
> +	if (is_new)
> +		error ? kfree(new_effect) : list_add(&new_effect->list, &cs40l50->effect_head);

This is a bit of an excessive use for a ternary, just make it an
if.

> +static int cs40l50_erase_effect(struct input_dev *dev, int effect_id)
> +{
> +	int error = 0;
> +	struct cs40l50_private *cs40l50 = input_get_drvdata(dev);
> +	struct cs40l50_effect *effect, *effect_owt;
> +
> +	mutex_lock(&cs40l50->lock);
> +
> +	effect = cs40l50_find_effect(cs40l50, dev->ff->effects[effect_id].id);
> +	if (!effect) {
> +		error = -EINVAL;
> +		goto err_mutex;
> +	}
> +
> +	if (effect->mapping != CS40L50_GPIO_MAPPING_INVALID) {
> +		error = cs40l50_dsp_write(cs40l50, effect->mapping, CS40L50_GPI_DISABLE);
> +		if (error)
> +			goto err_mutex;
> +	}
> +
> +	if (effect->wvfrm_bank == CS40L50_WVFRM_BANK_OWT) {
> +		error = cs40l50_dsp_write(cs40l50, CS40L50_DSP_VIRTUAL1_MBOX_1,
> +				CS40L50_MBOX_CMD_OWT_DELETE | effect->trigger_index);
> +		if (error)
> +			goto err_mutex;
> +
> +		list_for_each_entry(effect_owt, &cs40l50->effect_head, list) {
> +			if (effect_owt->wvfrm_bank == CS40L50_WVFRM_BANK_OWT &&
> +					effect_owt->trigger_index > effect->trigger_index)
> +				effect_owt->trigger_index--;
> +		}
> +	}
> +
> +	list_del(&effect->list);
> +	kfree(effect);
> +err_mutex:
> +	mutex_unlock(&cs40l50->lock);
> +
> +	return error;
> +}

I seem to remember add/erase needed to get pushed to the work
queue too, not because the framework might call it in atomic
context, but in order to ensure ordering with the start/stops.

> +int cs40l50_probe(struct cs40l50_private *cs40l50)
> +{
> +	int error, i, irq;
> +	u32 val;
> +
> +	mutex_init(&cs40l50->lock);
> +
> +	error = devm_regulator_bulk_get(cs40l50->dev, ARRAY_SIZE(cs40l50_supplies),
> +			cs40l50_supplies);
> +	if (error)
> +		return dev_err_probe(cs40l50->dev, error, "Failed to request supplies\n");
> +
> +	error = regulator_bulk_enable(ARRAY_SIZE(cs40l50_supplies), cs40l50_supplies);
> +	if (error)
> +		return dev_err_probe(cs40l50->dev, error, "Failed to enable supplies\n");
> +
> +	cs40l50->reset_gpio = devm_gpiod_get_optional(cs40l50->dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(cs40l50->reset_gpio)) {
> +		error = PTR_ERR(cs40l50->reset_gpio);
> +		goto err;
> +	}
> +
> +	usleep_range(CS40L50_MIN_RESET_PULSE_WIDTH_US, CS40L50_MIN_RESET_PULSE_WIDTH_US + 100);
> +
> +	gpiod_set_value_cansleep(cs40l50->reset_gpio, 0);
> +
> +	usleep_range(CS40L50_CP_READY_DELAY_US, CS40L50_CP_READY_DELAY_US + 1000);
> +
> +	for (i = 0; i < CS40L50_DSP_TIMEOUT_COUNT; i++) {
> +		error = cs40l50_dsp_read(cs40l50, CS40L50_DSP1_HALO_STATE, &val);
> +		if (!error && val < 0xFFFF && val >= CS40L50_HALO_STATE_BOOT_DONE)
> +			break;
> +
> +		usleep_range(CS40L50_DSP_POLL_US, CS40L50_DSP_POLL_US + 100);
> +	}
> +
> +	if (i == CS40L50_DSP_TIMEOUT_COUNT) {
> +		dev_err(cs40l50->dev, "Firmware boot failed: %d, halo state = %#x\n", error, val);
> +		goto err;
> +	}
> +
> +	cs40l50->vibe_workqueue = alloc_ordered_workqueue("cs40l50_workqueue", WQ_HIGHPRI);
> +	if (!cs40l50->vibe_workqueue) {
> +		error = -ENOMEM;
> +		goto err;
> +	}
> +
> +	INIT_WORK(&cs40l50->vibe_start_work, cs40l50_vibe_start_worker);
> +	INIT_WORK(&cs40l50->vibe_stop_work, cs40l50_vibe_stop_worker);
> +
> +	error = cs40l50_cs_dsp_init(cs40l50);
> +	if (error)
> +		goto err;
> +
> +	error = cs40l50_input_init(cs40l50);
> +	if (error)
> +		goto err;
> +
> +	error = cs40l50_patch_firmware(cs40l50);
> +	if (error)
> +		goto err;
> +

Doing this from probe, with a sync firmware load, can be a
little problematic as the firmware is often not available if
the driver is builtin rather than a module.

Fairly quick review as I am on holiday at the moment, but will
check back next week.

Thanks,
Charles
