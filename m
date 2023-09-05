Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847FF7929D9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353895AbjIEQ3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354703AbjIENhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:37:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6957D191;
        Tue,  5 Sep 2023 06:36:56 -0700 (PDT)
Received: from [192.168.1.23] (unknown [171.76.82.102])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vignesh)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8925A66028F5;
        Tue,  5 Sep 2023 14:36:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693921014;
        bh=Jrym+Ky16xApwfLUAeFb6AP634wzyVW+sZXlItpUeVA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C8/+a4DuIQRb0J3o7lNrwSoVRG1+YurJ+S/AWRRmeXMd6FpAVrzaW+mkXBemfTWOM
         Vz+5vKLJX8hhwhW1eJ4xEUo4DFoVXahuSO1Xf5IC09U2tNkWsHKNys/6IDUCdSUgCV
         +VxNygTXoEfwohPaZqbsGtSw7MECBECFl2Eo962KXal/5SaLmx5SUCNIeWdyMDgE0V
         LMh++CG+U3jtZ7OPTRHukHPMyyocraqM7ScRkm7BsXzIugmxRFezrxObEIBt4oE1G0
         FZi3cUJVFHx9tcJhULppHUI0VyUqFcx8+HjU3XQH2edua5LgoE81hSBjyuUnMTaUEo
         zcujGn0lBtVAQ==
Message-ID: <427ceb32-054f-41ff-df95-446b18aa178f@collabora.com>
Date:   Tue, 5 Sep 2023 19:06:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/7] drm: ci: Force db410c to host mode
Content-Language: en-US
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        dri-devel@lists.freedesktop.org, helen.koike@collabora.com,
        guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
        david.heidelberg@collabora.com, daniels@collabora.com,
        gustavo.padovan@collabora.com, emma@anholt.net,
        robclark@freedesktop.org, robdclark@google.com, anholt@google.com,
        robdclark@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org
References: <20230904161516.66751-1-vignesh.raman@collabora.com>
 <20230904161516.66751-3-vignesh.raman@collabora.com>
 <CAA8EJpq_cmFQ6TGy1xELh3ButWKLfSkQcp5ix049s_iqKw6DvQ@mail.gmail.com>
 <ueznsu2dlvq5zp3ls262fww54bnlqa3e2ssr6f65vrrionloms@ir2ywgeajj4w>
 <2c812fe4-04ba-0243-5330-c7b7e695cff9@collabora.com>
 <2jz6wurh6ejbaejwtb5r5gukjuw4zs7ujk5hbwfpsn26o6esqe@g2nnb2gjpnjp>
 <CAA8EJpoGoopP64T1nm1ye1ukTwT=u+LYY1ubQG-9dQ-j41iHiA@mail.gmail.com>
 <6be5f5d8-8940-c79b-4a01-3f3d73641e4e@collabora.com>
 <ktikqf5hu2dmqb4p7dvrqv2tjm565qn3qu2gggrvncfu47l23j@o6t2rnpbya3x>
From:   Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <ktikqf5hu2dmqb4p7dvrqv2tjm565qn3qu2gggrvncfu47l23j@o6t2rnpbya3x>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On 05/09/23 17:27, Maxime Ripard wrote:
> On Tue, Sep 05, 2023 at 05:11:43PM +0530, Vignesh Raman wrote:
>>>> Also, that node actually has a label ("usb"), defined here:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/msm8916.dtsi#n2322
>>>>
>>>> So you can end up with
>>>>
>>>> &usb {
>>>>           dr_mode = "host";
>>>> };
>>>
>>> ... which is the simplest and thus more robust one.
>>>
>>
>> Should it be,
>> &{/soc@0/usb} {
>> 	dr_mode = "host";
>> };
> 
> No. The &{/...} syntax refers to a path. &... refers to a label. They
> are not equivalent.

Sorry I was not clear before.

With,
&usb {
	dr_mode = "host";
};

The target is <0xffffffff> and fdtoverlay fails to apply the dtbo.

With,
&{/soc@0/usb} {
          dr_mode = "host";
};

The target-path is "/soc@0/usb" (usb: usb@78d9000)

/ {

	fragment@0 {
		target-path = "/soc@0/usb";

		__overlay__ {
			dr_mode = "host";
		};
	};
};

So will use  &{/...} syntax in this case.

Regards,
Vignesh
