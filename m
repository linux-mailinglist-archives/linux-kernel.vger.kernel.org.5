Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94D27E8060
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344968AbjKJSJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345984AbjKJSHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:07:04 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6783DA5DD;
        Fri, 10 Nov 2023 01:27:25 -0800 (PST)
Received: from [100.116.125.19] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 439A666073E2;
        Fri, 10 Nov 2023 09:27:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699608444;
        bh=jgC/HX0DCivudpq7G6ihAYUdFIx19Q8cGDVDSrd4fH4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ep3Y5wWKvqdYWq0GuLTK8Omn+oRHjIKlHMyuX6zi3I/dppgmWNgnn3sadX198vWE0
         paBGvRYX5NIaY9ihOnNcLvhYDOo88sIE0zi4YSg3buLmuhzRKFC/l3hcMMVPzR+0DG
         Wa0IfBuWlvuKGUdAAtxyMmV1rGjySZCIh/U0b/xVSSer2H7xPodA+3SCjbV4/O+tM3
         Ss0mjgtPPSrT1Uhfux9iAFd/q+s+FvSD7K8Vn18Z8PoXMBi5QRehJ66YnK6k0xD1uU
         02xvFLEtdA9RKd3gH6lXIIzDCQ8/LY62h60za2nIkdGdRcaJqbpYz7cfYeJ0tkDjZ5
         w4CVFCMnh+8dw==
Message-ID: <abd4fcc2-a450-4027-abef-98a689f502c6@collabora.com>
Date:   Fri, 10 Nov 2023 10:27:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 26/56] media: i2c: video-i2c: Stop direct calls to
 queue num_buffers field
Content-Language: en-US
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com, Matt Ranostay <matt.ranostay@konsulko.com>
References: <20231109163512.179524-14-benjamin.gaignard@collabora.com>
 <20231109163512.179524-27-benjamin.gaignard@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20231109163512.179524-27-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 9.11.2023 o 17:34, Benjamin Gaignard pisze:
> Use vb2_get_num_buffers() to avoid using queue num_buffers field directly.
> This allows us to change how the number of buffers is computed in the
> future.
> Fix the number of buffers computation at the same time.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

> CC: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>   drivers/media/i2c/video-i2c.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/i2c/video-i2c.c b/drivers/media/i2c/video-i2c.c
> index 178bd06cc2ed..ebf2ac98a068 100644
> --- a/drivers/media/i2c/video-i2c.c
> +++ b/drivers/media/i2c/video-i2c.c
> @@ -405,9 +405,10 @@ static int queue_setup(struct vb2_queue *vq,
>   {
>   	struct video_i2c_data *data = vb2_get_drv_priv(vq);
>   	unsigned int size = data->chip->buffer_size;
> +	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
>   
> -	if (vq->num_buffers + *nbuffers < 2)
> -		*nbuffers = 2;
> +	if (q_num_bufs + *nbuffers < 2)
> +		*nbuffers = 2 - q_num_bufs;
>   
>   	if (*nplanes)
>   		return sizes[0] < size ? -EINVAL : 0;

