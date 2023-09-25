Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186C97AD6B4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjIYLJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 07:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjIYLIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:08:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78906D3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 04:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695640124; x=1727176124;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=9p+XqtzXvIJ3hJIh/2hgy3YcmayjqQFoFDHhEcEBbDk=;
  b=KmHHfcb5g91IPuWi6XO94KkeSowm8yY0aWCV8q3zLwsfYAEF5K8UPCkv
   n9mNbrkuu92qHjzGQPkPUMnk9wOtgQS5h+6WWJN+1kG92rwMk6uvPJ8C4
   3itvL9SGHVbhGDADYffqVCFxfiuCofCHIUpmOMgKKJeC65asKJrXStVYV
   wZ8efo6QVHSlvB9ARotFZzeu5lkrawehWsca6wJm42cO8wxTAtSQca5n9
   vidopMgvxU8lk/YlUm4sIjh2SHNOz5Wk91kEzIKWYw4IsW9ligtoOO+/v
   WXwmTxfEgxxvxAe/8kAcpaI4ssN+IuL/Jj8++d1wr2COXCRZCU0cp6iaS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="467510679"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="467510679"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 04:08:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="838536484"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="838536484"
Received: from smgotth-mobl.ger.corp.intel.com (HELO localhost) ([10.252.40.46])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 04:08:27 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Robert Foss <rfoss@kernel.org>,
        Yang Li <yang.lee@linux.alibaba.com>
Cc:     neil.armstrong@linaro.org, jonas@kwiboo.se,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        jernej.skrabec@gmail.com, Laurent.pinchart@ideasonboard.com,
        andrzej.hajda@intel.com
Subject: Re: [PATCH -next] drm/bridge: clean up some inconsistent indentings
In-Reply-To: <CAN6tsi44s3h3Ox3mK2pi+Mw8pGCB9fgMcoWmJhCenHoK9=t=-w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230920004400.81091-1-yang.lee@linux.alibaba.com>
 <CAN6tsi44s3h3Ox3mK2pi+Mw8pGCB9fgMcoWmJhCenHoK9=t=-w@mail.gmail.com>
Date:   Mon, 25 Sep 2023 14:08:25 +0300
Message-ID: <87a5tao6hi.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023, Robert Foss <rfoss@kernel.org> wrote:
> NAK

Feels a bit harsh.

> Personally I value maintaining a simple to follow `git blame` history
> over correcting indentation.
>
> Ideally bad indentation should never be committed in the first place.

Agreed, but when that inevitably happens, do you really want it to be
cast in stone? To me leaving bad indent (or style, or whatever) in place
indicates we don't care, while the opposite is true.

Maybe look into tooling that lets you easily git blame the parent commit
of a line in git blame? (For example, in emacs vc-annotate, it's just a
matter of hitting 'a'.)


BR,
Jani.


>
> On Wed, Sep 20, 2023 at 2:44=E2=80=AFAM Yang Li <yang.lee@linux.alibaba.c=
om> wrote:
>>
>> drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c:336 dw_hdmi_cec_suspend() =
warn: inconsistent indenting
>>
>> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>> ---
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c b/drivers/gpu=
/drm/bridge/synopsys/dw-hdmi-cec.c
>> index 673661160e54..fe2ff4984fc5 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
>> @@ -333,9 +333,9 @@ static int __maybe_unused dw_hdmi_cec_suspend(struct=
 device *dev)
>>         struct dw_hdmi_cec *cec =3D dev_get_drvdata(dev);
>>
>>         /* store interrupt status/mask registers */
>> -        cec->regs_polarity =3D dw_hdmi_read(cec, HDMI_CEC_POLARITY);
>> -        cec->regs_mask =3D dw_hdmi_read(cec, HDMI_CEC_MASK);
>> -        cec->regs_mute_stat0 =3D dw_hdmi_read(cec, HDMI_IH_MUTE_CEC_STA=
T0);
>> +       cec->regs_polarity =3D dw_hdmi_read(cec, HDMI_CEC_POLARITY);
>> +       cec->regs_mask =3D dw_hdmi_read(cec, HDMI_CEC_MASK);
>> +       cec->regs_mute_stat0 =3D dw_hdmi_read(cec, HDMI_IH_MUTE_CEC_STAT=
0);
>>
>>         return 0;
>>  }
>> --
>> 2.20.1.7.g153144c
>>

--=20
Jani Nikula, Intel
