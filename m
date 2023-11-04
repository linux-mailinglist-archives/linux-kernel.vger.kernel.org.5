Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D607E0FB2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 14:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjKDNTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 09:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKDNTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 09:19:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE3FE3
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 06:19:28 -0700 (PDT)
Received: from [100.116.205.35] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: koike)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C3773660741E;
        Sat,  4 Nov 2023 13:19:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699103966;
        bh=1dBKOCU2op7HA41h9kKU4lIb1sXgfhlNw7dDoYMGmGs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UQk4F+bsfvQ9WNm/y0l2nCk4XVq4T3jE2qV70rZH0vK5SRUM3mCxX+dlYOvnVWt7K
         U0qVuJkbSARRj1XJE3/vv6epFmbMAJSp/ppb8n53GY95Eb17Kt51BqN1B3oGdB6YTn
         R7320wWhxsDirvgRJtNm/2JlQvoAtrx9wCi4N8PgKJvjz64orYF+HVjE7C2Fs39nkq
         FCeTjVnsDNEaxX7JlEUkNQtI7hx3rw1ASCIRTd0eaBBBNm3F782qBn9jMfkEFR6yx6
         5tmhIrafeQSi0yCt3XaPvA4M++sY10X7p7YX85+mfKBq2lEsMDKZV12eBYZg3t+uQz
         mIZWFaTAaNTRQ==
Message-ID: <836c7166-0a42-4fdc-acf4-65e0a096c41f@collabora.com>
Date:   Sat, 4 Nov 2023 10:19:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/ci: Add skips, fails and flakes for SM8250
Content-Language: en-US
To:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     robdclark@chromium.org, quic_abhinavk@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20231010-rb5-runner-v1-0-aba1fcc6e3aa@quicinc.com>
 <20231010-rb5-runner-v1-3-aba1fcc6e3aa@quicinc.com>
From:   Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20231010-rb5-runner-v1-3-aba1fcc6e3aa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/2023 19:25, Jessica Zhang wrote:
> Add skips, fails and flakes for the SM8250 test.
> 
> Generated using update-xfails.py [1]
> 
> [1] https://patchwork.freedesktop.org/patch/561453/?series=124793&rev=1
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>   drivers/gpu/drm/ci/xfails/msm-sm8250-fails.txt  | 29 +++++++++++++++++++++++++
>   drivers/gpu/drm/ci/xfails/msm-sm8250-flakes.txt |  3 +++
>   drivers/gpu/drm/ci/xfails/msm-sm8250-skips.txt  |  8 +++++++
>   3 files changed, 40 insertions(+)
> 
> diff --git a/drivers/gpu/drm/ci/xfails/msm-sm8250-fails.txt b/drivers/gpu/drm/ci/xfails/msm-sm8250-fails.txt
> new file mode 100644
> index 000000000000..cc8ae32e90e7
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/xfails/msm-sm8250-fails.txt
> @@ -0,0 +1,29 @@
> +kms_3d,Fail
> +kms_atomic_transition@plane-all-modeset-transition,Timeout
> +kms_color@ctm-0-25,Fail
> +kms_color@ctm-0-50,Fail
> +kms_color@ctm-0-75,Fail
> +kms_color@ctm-blue-to-red,Fail
> +kms_color@ctm-negative,Fail
> +kms_color@ctm-red-to-blue,Fail
> +kms_color@ctm-signed,Fail
> +kms_cursor_legacy@basic-flip-after-cursor-varying-size,Fail
> +kms_cursor_legacy@basic-flip-before-cursor-varying-size,Fail
> +kms_cursor_legacy@cursor-vs-flip-atomic-transitions-varying-size,Fail
> +kms_cursor_legacy@cursor-vs-flip-toggle,Fail
> +kms_cursor_legacy@cursor-vs-flip-varying-size,Fail
> +kms_cursor_legacy@short-flip-after-cursor-atomic-transitions-varying-size,Fail
> +kms_cursor_legacy@short-flip-before-cursor-atomic-transitions-varying-size,Fail
> +kms_cursor_legacy@short-flip-before-cursor-toggle,Fail
> +kms_hdmi_inject@inject-4k,Fail
> +kms_pipe_crc_basic@compare-crc-sanitycheck-nv12,Fail
> +kms_plane@pixel-format,Fail
> +kms_plane@pixel-format-source-clamping,Fail
> +kms_plane@plane-position-covered,Fail
> +kms_plane@plane-position-hole,Fail
> +kms_plane@plane-position-hole-dpms,Fail
> +kms_plane_alpha_blend@alpha-7efc,Fail
> +kms_plane_alpha_blend@coverage-7efc,Fail
> +kms_plane_alpha_blend@coverage-vs-premult-vs-constant,Fail
> +kms_plane_cursor@overlay,Fail
> +kms_rmfb@close-fd,Fail
> diff --git a/drivers/gpu/drm/ci/xfails/msm-sm8250-flakes.txt b/drivers/gpu/drm/ci/xfails/msm-sm8250-flakes.txt
> new file mode 100644
> index 000000000000..0b55665184c1
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/xfails/msm-sm8250-flakes.txt
> @@ -0,0 +1,3 @@
> +kms_cursor_legacy@flip-vs-cursor-atomic-transitions-varying-size
> +kms_cursor_legacy@flip-vs-cursor-varying-size
> +kms_plane_cursor@viewport

We are trying to add some docs, specially to the flakes, please check: 
https://lists.freedesktop.org/archives/dri-devel/2023-October/427982.html

Could you add it for those? (I'm glad to see there are just a few flakes).

Thanks
Helen

> diff --git a/drivers/gpu/drm/ci/xfails/msm-sm8250-skips.txt b/drivers/gpu/drm/ci/xfails/msm-sm8250-skips.txt
> new file mode 100644
> index 000000000000..c20422c58e4d
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/xfails/msm-sm8250-skips.txt
> @@ -0,0 +1,8 @@
> +# Suspend to RAM seems to be broken on this machine
> +.*suspend.*
> +
> +# reboots device
> +kms_plane_scaling.*
> +
> +# long execution time
> +kms_flip.*
> 
