Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B7D7A1F78
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbjIONDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbjIONDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:03:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E8C10E;
        Fri, 15 Sep 2023 06:02:58 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:7735:5996:cf40:bca6] (unknown [IPv6:2a01:e0a:120:3210:7735:5996:cf40:bca6])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1D60B66072ED;
        Fri, 15 Sep 2023 14:02:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694782976;
        bh=p3dIJk432sgjwEaG99pDgDD1HBalYst4ezbAkgYJyz4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jqb6/GyVg5IuUKgGjzBkcnNg1wXFDJFiSi6o2rQe5WYoXkRfqvzt8Zinleucikwy+
         hRA2+5AaN16cDBPUxAABqKfK854lwKRdJYLH8RyKWUWiXqEzYHGLPF9Ys9CeeeBeLt
         P5ikdtNdI08HzbDRZarbCfotl/dnWAQV31r2PuTklWR/YoAVfZUlHMP4VIrQXpyl1e
         nK+EOUaUt0FpTB3XBAIdy3He2cwufeUhtmXD+wwrne81yOtRh+7LA8r6ziwG6U/0tg
         5kKbsqRIMxeBTLzXkSWnJ9ADpe9KeV6QS8W7ybOhnSMEcatthVpy6JUQDM/efEajFH
         JtGFEwcByqq1A==
Message-ID: <b048719a-9397-7490-0651-7c1470ef61e0@collabora.com>
Date:   Fri, 15 Sep 2023 15:02:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 45/49] media: core: Add bitmap manage bufs array
 entries
Content-Language: en-US
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
References: <20230914133323.198857-46-benjamin.gaignard@collabora.com>
 <202309150835.kxjWQyEU-lkp@intel.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <202309150835.kxjWQyEU-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 15/09/2023 à 02:47, kernel test robot a écrit :
> Hi Benjamin,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.6-rc1]
> [cannot apply to next-20230914]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Gaignard/media-videobuf2-Rework-offset-cookie-encoding-pattern/20230914-221757
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20230914133323.198857-46-benjamin.gaignard%40collabora.com
> patch subject: [PATCH v7 45/49] media: core: Add bitmap manage bufs array entries
> config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230915/202309150835.kxjWQyEU-lkp@intel.com/config)
> compiler: sparc64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230915/202309150835.kxjWQyEU-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309150835.kxjWQyEU-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>     samples/v4l/v4l2-pci-skeleton.c: In function 'queue_setup':
>>> samples/v4l/v4l2-pci-skeleton.c:170:15: error: 'struct vb2_queue' has no member named 'num_buffers'
>       170 |         if (vq->num_buffers + *nbuffers < 3)
>           |               ^~
>     samples/v4l/v4l2-pci-skeleton.c:171:35: error: 'struct vb2_queue' has no member named 'num_buffers'
>       171 |                 *nbuffers = 3 - vq->num_buffers;
>           |                                   ^~
> --
>     drivers/input/touchscreen/sur40.c: In function 'sur40_queue_setup':
>>> drivers/input/touchscreen/sur40.c:851:14: error: 'struct vb2_queue' has no member named 'num_buffers'
>       851 |         if (q->num_buffers + *nbuffers < 3)
>           |              ^~
>     drivers/input/touchscreen/sur40.c:852:34: error: 'struct vb2_queue' has no member named 'num_buffers'
>       852 |                 *nbuffers = 3 - q->num_buffers;
>           |                                  ^~
>
>
> vim +170 samples/v4l/v4l2-pci-skeleton.c

v4l2 drivers outside drivers/media or drivers/staging/media direct directories.
I have miss them. I will fix that in v8.

Regards,
Benjamin

>
> 926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  145
> 926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  146  /*
> 926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  147   * Setup the constraints of the queue: besides setting the number of planes
> 926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  148   * per buffer and the size and allocation context of each plane, it also
> 926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  149   * checks if sufficient buffers have been allocated. Usually 3 is a good
> 926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  150   * minimum number: many DMA engines need a minimum of 2 buffers in the
> 926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  151   * queue and you need to have another available for userspace processing.
> 926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  152   */
> df9ecb0cad14b9 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2015-10-28  153  static int queue_setup(struct vb2_queue *vq,
> 926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  154  		       unsigned int *nbuffers, unsigned int *nplanes,
> 36c0f8b32c4bd4 samples/v4l/v4l2-pci-skeleton.c               Hans Verkuil 2016-04-15  155  		       unsigned int sizes[], struct device *alloc_devs[])
> 926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  156  {
> 926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  157  	struct skeleton *skel = vb2_get_drv_priv(vq);
> 926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  158
> 5f26f2501b8119 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-04-11  159  	skel->field = skel->format.field;
> 5f26f2501b8119 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-04-11  160  	if (skel->field == V4L2_FIELD_ALTERNATE) {
> 5f26f2501b8119 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-04-11  161  		/*
> 5f26f2501b8119 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-04-11  162  		 * You cannot use read() with FIELD_ALTERNATE since the field
> 5f26f2501b8119 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-04-11  163  		 * information (TOP/BOTTOM) cannot be passed back to the user.
> 5f26f2501b8119 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-04-11  164  		 */
> 3130a28a1568b1 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-04-23  165  		if (vb2_fileio_is_active(vq))
> 5f26f2501b8119 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-04-11  166  			return -EINVAL;
> 5f26f2501b8119 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-04-11  167  		skel->field = V4L2_FIELD_TOP;
> 5f26f2501b8119 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-04-11  168  	}
> 5f26f2501b8119 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-04-11  169
> 926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14 @170  	if (vq->num_buffers + *nbuffers < 3)
> 926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  171  		*nbuffers = 3 - vq->num_buffers;
> 926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  172
> df9ecb0cad14b9 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2015-10-28  173  	if (*nplanes)
> df9ecb0cad14b9 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2015-10-28  174  		return sizes[0] < skel->format.sizeimage ? -EINVAL : 0;
> 926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  175  	*nplanes = 1;
> df9ecb0cad14b9 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2015-10-28  176  	sizes[0] = skel->format.sizeimage;
> 926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  177  	return 0;
> 926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  178  }
> 926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  179
>
