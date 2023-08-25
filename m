Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA677788C81
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241379AbjHYPeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbjHYPeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:34:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4EB2134;
        Fri, 25 Aug 2023 08:34:20 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:2dee:15f0:cfc3:3cd5] (unknown [IPv6:2a01:e0a:120:3210:2dee:15f0:cfc3:3cd5])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7FDCE660725E;
        Fri, 25 Aug 2023 16:34:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692977659;
        bh=CBKe/NVdZbzitVrTSsyh2xKdG8S8gYJrAaysQDniztE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YlnB7ll7pJGfXX++LNsPl6V43qmCwf0p3rjW0MUYZy5/x+id10SMY7HQFDJfPWJdp
         OVnwwh8BoN4p+r9sAnfjGIY1MQOe0SKxuI19lrf/bYnmoF/9IzNCDHDt/Vj9Jfa7Qn
         qUJvbG4tD3L2ZEHygCL+QAu5abf5nk1uGsfkbndYzxL2wN6BcyVXOdXp1xgMQYUGIq
         9rON2LnbBv8pQSc5rI7vUwVJu2gZX/J1BepAAvhxVN6fgZ/d3mdmS/Z9zVljRa/5gE
         al+qg8yGstW6qyTxtQ9oVOj0yqd0FqELCVx0k3+fTqAsH2R83FRcs/2Fae39CrVd6/
         1ZcrTqNEmmE8Q==
Message-ID: <d4121940-e19f-8ed9-663b-01a4bbab0df1@collabora.com>
Date:   Fri, 25 Aug 2023 17:34:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 10/10] media: v4l2: Add mem2mem helpers for DELETE_BUFS
 ioctl
To:     kernel test robot <lkp@intel.com>, mchehab@kernel.org,
        tfiga@chromium.org, m.szyprowski@samsung.com, ming.qian@nxp.com,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20230824092133.39510-11-benjamin.gaignard@collabora.com>
 <202308251828.fSyIXACx-lkp@intel.com>
Content-Language: en-US
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <202308251828.fSyIXACx-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 25/08/2023 à 12:29, kernel test robot a écrit :
> Hi Benjamin,

Damned I have forgot this configuration flag when rebasing my code after 
holidays...

It will be fixed for v6 but I will wait for more comments before send it.

Regards,

Benjamin

>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on next-20230824]
> [also build test ERROR on v6.5-rc7]
> [cannot apply to linus/master v6.5-rc7 v6.5-rc6 v6.5-rc5]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Gaignard/media-videobuf2-Rework-offset-cookie-encoding-pattern/20230824-172416
> base:   next-20230824
> patch link:    https://lore.kernel.org/r/20230824092133.39510-11-benjamin.gaignard%40collabora.com
> patch subject: [PATCH v5 10/10] media: v4l2: Add mem2mem helpers for DELETE_BUFS ioctl
> config: alpha-randconfig-r005-20230825 (https://download.01.org/0day-ci/archive/20230825/202308251828.fSyIXACx-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20230825/202308251828.fSyIXACx-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308251828.fSyIXACx-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>>> drivers/media/test-drivers/vim2m.c:963:10: error: 'const struct v4l2_ioctl_ops' has no member named 'vidioc_delete_buf'; did you mean 'vidioc_delete_bufs'?
>       963 |         .vidioc_delete_buf      = v4l2_m2m_ioctl_delete_buf,
>           |          ^~~~~~~~~~~~~~~~~
>           |          vidioc_delete_bufs
>>> drivers/media/test-drivers/vim2m.c:963:35: error: 'v4l2_m2m_ioctl_delete_buf' undeclared here (not in a function); did you mean 'v4l2_m2m_ioctl_delete_bufs'?
>       963 |         .vidioc_delete_buf      = v4l2_m2m_ioctl_delete_buf,
>           |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~
>           |                                   v4l2_m2m_ioctl_delete_bufs
>
>
> vim +963 drivers/media/test-drivers/vim2m.c
>
>     942	
>     943	static const struct v4l2_ioctl_ops vim2m_ioctl_ops = {
>     944		.vidioc_querycap	= vidioc_querycap,
>     945	
>     946		.vidioc_enum_fmt_vid_cap = vidioc_enum_fmt_vid_cap,
>     947		.vidioc_enum_framesizes = vidioc_enum_framesizes,
>     948		.vidioc_g_fmt_vid_cap	= vidioc_g_fmt_vid_cap,
>     949		.vidioc_try_fmt_vid_cap	= vidioc_try_fmt_vid_cap,
>     950		.vidioc_s_fmt_vid_cap	= vidioc_s_fmt_vid_cap,
>     951	
>     952		.vidioc_enum_fmt_vid_out = vidioc_enum_fmt_vid_out,
>     953		.vidioc_g_fmt_vid_out	= vidioc_g_fmt_vid_out,
>     954		.vidioc_try_fmt_vid_out	= vidioc_try_fmt_vid_out,
>     955		.vidioc_s_fmt_vid_out	= vidioc_s_fmt_vid_out,
>     956	
>     957		.vidioc_reqbufs		= v4l2_m2m_ioctl_reqbufs,
>     958		.vidioc_querybuf	= v4l2_m2m_ioctl_querybuf,
>     959		.vidioc_qbuf		= v4l2_m2m_ioctl_qbuf,
>     960		.vidioc_dqbuf		= v4l2_m2m_ioctl_dqbuf,
>     961		.vidioc_prepare_buf	= v4l2_m2m_ioctl_prepare_buf,
>     962		.vidioc_create_bufs	= v4l2_m2m_ioctl_create_bufs,
>   > 963		.vidioc_delete_buf	= v4l2_m2m_ioctl_delete_buf,
>     964		.vidioc_expbuf		= v4l2_m2m_ioctl_expbuf,
>     965	
>     966		.vidioc_streamon	= v4l2_m2m_ioctl_streamon,
>     967		.vidioc_streamoff	= v4l2_m2m_ioctl_streamoff,
>     968	
>     969		.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
>     970		.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
>     971	};
>     972	
>
