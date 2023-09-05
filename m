Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80270792BC8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjIERAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354209AbjIEKJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:09:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545DF90;
        Tue,  5 Sep 2023 03:09:44 -0700 (PDT)
Received: from [192.168.1.23] (unknown [171.76.82.102])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vignesh)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 73F02660716C;
        Tue,  5 Sep 2023 11:09:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693908581;
        bh=PHDlogbWriNpSInDU6bgIDQgv8X9PfNf4xdH4kqZ9Sk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eQ77jxssWPUan9oBzIXWOuFcqRHIwZgu5AUK/namoH9kzlCuPUDvKCAxDWPHn9Q5+
         D3xfI2I2zg48ZwcE0p2Wsd5JJZxOMmajFxZWcv20Yr30f3EnUFO4kBnlZT5bmmzfj+
         PhthVN+NmbADogATjEMdgnWBQRZqoHZe4Tj6lbn1MeGwDArJ3AYlR2+cvQmpNkdOTs
         puY18CIyqzWoC6EBwxfSYDzW7Uaf77Oa0ft/WGm49VfAF5Q1u5VH8dddlrrssR6y0f
         0OJ7ZlIC7Xy2wvhqv1j0HR0o04z78w+PPS1skuLvbBuoP4mYovi4K88GhE+E6XJ81Q
         /0azjpFaYmK8Q==
Message-ID: <2c812fe4-04ba-0243-5330-c7b7e695cff9@collabora.com>
Date:   Tue, 5 Sep 2023 15:39:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/7] drm: ci: Force db410c to host mode
Content-Language: en-US
To:     Maxime Ripard <mripard@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, helen.koike@collabora.com,
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
From:   Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <ueznsu2dlvq5zp3ls262fww54bnlqa3e2ssr6f65vrrionloms@ir2ywgeajj4w>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry, Maxime,

On 05/09/23 14:13, Maxime Ripard wrote:
> Hi,
> 
> On Mon, Sep 04, 2023 at 07:59:26PM +0300, Dmitry Baryshkov wrote:
>> On Mon, 4 Sept 2023 at 19:16, Vignesh Raman <vignesh.raman@collabora.com> wrote:
>>>
>>> Force db410c to host mode to fix network issue which results in failure
>>> to mount root fs via NFS.
>>> See https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/cb72a629b8c15c80a54dda510743cefd1c4b65b8
>>>
>>> Use fdtoverlay command to merge base device tree with an overlay
>>> which contains the fix for USB controllers to work in host mode.
>>>
>>> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
>>> ---
>>>
>>> v2:
>>>    - Use fdtoverlay command to merge overlay dtbo with the base dtb instead of modifying the kernel sources
>>>
>>> ---
>>>   drivers/gpu/drm/ci/build.sh                         |  5 +++++
>>>   .../gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts  | 13 +++++++++++++
>>>   2 files changed, 18 insertions(+)
>>>   create mode 100644 drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts
>>>
>>> diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
>>> index 7b014287a041..92ffd98cd09e 100644
>>> --- a/drivers/gpu/drm/ci/build.sh
>>> +++ b/drivers/gpu/drm/ci/build.sh
>>> @@ -92,6 +92,11 @@ done
>>>
>>>   if [[ -n ${DEVICE_TREES} ]]; then
>>>       make dtbs
>>> +    if [[ -e arch/arm64/boot/dts/qcom/apq8016-sbc.dtb ]]; then
>>> +        dtc -@ -I dts -O dtb -o drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dtbo drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts
>>> +        fdtoverlay -i arch/arm64/boot/dts/qcom/apq8016-sbc.dtb -o arch/arm64/boot/dts/qcom/apq8016-sbc-overlay.dtb drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dtbo
>>> +        mv arch/arm64/boot/dts/qcom/apq8016-sbc-overlay.dtb arch/arm64/boot/dts/qcom/apq8016-sbc.dtb
>>> +    fi
>>>       cp ${DEVICE_TREES} /lava-files/.
>>>   fi
>>>
>>> diff --git a/drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts b/drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts
>>> new file mode 100644
>>> index 000000000000..57b7604f1c23
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts
>>> @@ -0,0 +1,13 @@
>>> +/dts-v1/;
>>> +/plugin/;
>>> +
>>> +/ {
>>> +    fragment@0 {
>>> +        target-path = "/soc@0";
>>> +        __overlay__ {
>>> +            usb@78d9000 {
>>> +                dr_mode = "host";
>>> +            };
>>> +        };
>>> +    };
>>> +};
>>> --
>>> 2.40.1
>>
>> Can we use normal dtso syntax here instead of defining fragments manually?
> 
> What Dmitry is hinting about is to use the "Sugar Syntax". There a good documentation here:
> https://source.android.com/docs/core/architecture/dto/syntax


With the below DTO syntax,
/dts-v1/;
/plugin/;

&usb {
   usb@78d9000 {
     dr_mode = "host";
   };
};

Decoded dtbo file is,
/dts-v1/;

/ {

	fragment@0 {
		target = <0xffffffff>;

		__overlay__ {

			usb@78d9000 {
				dr_mode = "host";
			};
		};
	};

	__fixups__ {
		usb = "/fragment@0:target:0";
	};
};

With the previous fix using fragment we get,
/ {

	fragment@0 {
		target-path	 = "/soc@0";

		__overlay__ {

			usb@78d9000 {
				dr_mode = "host";
			};
		};
	};
};

Decoded apq8016-sbc.dtb file with the fix (setting dr_mode to host) is,
/dts-v1/;
/ {	
	soc@0 {
		usb@78d9000 {
			dr_mode = "host";
		};	
	};
};

How can set the target to "soc@0" using the DTO syntax? Otherwise 
fdtoverlay fails to apply the dtbo file with the base dtb.

Regards,
Vignesh
