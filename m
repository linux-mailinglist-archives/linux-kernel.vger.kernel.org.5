Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E6A7F0440
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 04:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjKSDqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 22:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKSDqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 22:46:31 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D415196
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 19:46:27 -0800 (PST)
Received: from [10.3.2.161] (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4BA0C6605638;
        Sun, 19 Nov 2023 03:46:24 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700365585;
        bh=86PLapbNm9s+HCVP0s7mDF8f5f5LtrYgQuCF1ZMWpMU=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=injQIhPSREuwYia7T7G65tdzinr0ssccyJ+PM9XcvHBcrNp+9bg3C+tLPgrzK9i8Y
         crmHJhLVD8w5z3Xk2KEAtJ7ibvV6h30J8qBMITLcwuqfnpen/ETPjp6uorjkK6rarm
         Q1lyIBB66SdSFWQJaBrVxj/7osUPqC+3KapKGZC4WgZUT6mSWMoF5ekxPhLcdjIWmv
         UwsQ18h2Lqp5PlipIUWCXYPZj35ISc7MYbwK0At2jRyQ/YeXdo2iSbCEGPGzo7c7iP
         pohfLiF0znWvf2GOXrI2pF8nzzUqbYZSViHdaLGED+KzcXCYnnz4It5+BBM9/Ptum/
         Ci4c3DwsaNT/A==
Message-ID: <68470997-bb4c-3c11-98b5-aa75c52cbaea@collabora.com>
Date:   Sun, 19 Nov 2023 06:46:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/virtio: add definition for venus capset
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Alex Deucher <alexander.deucher@amd.com>
References: <20230915105918.3763061-1-ray.huang@amd.com>
 <a7b783c8-b1c8-90e3-b6c7-7fa8c6d24d21@collabora.com>
In-Reply-To: <a7b783c8-b1c8-90e3-b6c7-7fa8c6d24d21@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/23 00:16, Dmitry Osipenko wrote:
> On 9/15/23 13:59, Huang Rui wrote:
>> This definition is used fro qemu, and qemu imports this marco in the
>> headers to enable venus for virtio gpu. So it should add it even kernel
>> doesn't use this.
>>
>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>> ---
>>
>> Hi all,
>>
>> We would like to add a new definition for venus capset, it will be used for
>> qemu. Please see details on below discussion:
>>
>> https://lore.kernel.org/qemu-devel/b82982aa-5b9e-481e-9491-b9313877bcaa@daynix.com/
>>
>> Thanks,
>> Ray
>>
>>  include/uapi/linux/virtio_gpu.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
>> index f556fde07b76..0e21f3998108 100644
>> --- a/include/uapi/linux/virtio_gpu.h
>> +++ b/include/uapi/linux/virtio_gpu.h
>> @@ -309,6 +309,8 @@ struct virtio_gpu_cmd_submit {
>>  
>>  #define VIRTIO_GPU_CAPSET_VIRGL 1
>>  #define VIRTIO_GPU_CAPSET_VIRGL2 2
>> +/* 3 is reserved for gfxstream */
>> +#define VIRTIO_GPU_CAPSET_VENUS 4
> 
> Could you please add all other capsets, so we won't needed to do it
> again in the future

I've opened request to update virtio-spec with the corrected/updated
capsets https://github.com/oasis-tcs/virtio-spec/issues/182. I'm
expecting that it will take some time until spec change will be merged
and now leaning to apply this v1 patch to not hold the Venus work.

Gerd, do you have objections? R-b/ack?

-- 
Best regards,
Dmitry

