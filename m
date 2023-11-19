Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1917F0788
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 17:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjKSQa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 11:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjKSQa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 11:30:58 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C3CC4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 08:30:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1700411270; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=g62MVC0Jh8G1BA0V1hTxRJIfCqe6NF2qwyQNpL8i4i+tooxcNWk8mUGkJOh/c3PjZy
    4Km5tQtCf4AIo424lfXMOs1tIA4K/qtrFEyBClfxITI+LUCPMFAWhHGiIOzEvPDLFwGV
    QDK5H3HlbgVETp0uQA2ltVkOMtiRXRm7+10bWCQY+Xd5CU2XYkUsSnJbZZe5mFtzIh65
    SCy7HVPS0AQTwxKY86OR7y5rDeJDv4L7UevvWBkhutabZmZm2tktEWr0P3ZjgXuVsnv0
    MImGQE5IfxIOLeDL+T1TGNbtUwlXo5AxVzVRjoENfEVP2hWXBfUluIvHmCwkwhRcXp5m
    pXug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1700411270;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=9e4OV8vET8pL9QsaX1Uk5dAJCWcAgTeKF08zFu/UPPs=;
    b=SmssSD3qyt+U8SqvsBxCiOERW3xIYN3rmhcBJtRs+pJChutfgxFiLPnKt965GANSM/
    makhgdzERRZT/65rnAenMOOA6K1Rqyf28wUrXdHN7C63+VNJxuegreG2WjCBow1kW/6A
    Hnps7KFtey0xOZpqHbDpI7da3uskzNXM3sthNTXO2V/9RmF/xXBNB29Bsu9fi+8pMYzK
    6eKVq6HEKnepfsfToSUXEjwl8O3Ehta+UT4hsWMaILTxhUGaoolK5SwLXqMwYJyJ+jcl
    wsw20wUrL5VzGdHJa4VX6arc/Ml3OnVhqbzFgWE+o0apQhACwOiHaPHfeDvgtM4UMcQq
    UZOg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1700411270;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=9e4OV8vET8pL9QsaX1Uk5dAJCWcAgTeKF08zFu/UPPs=;
    b=Bquf3SmPxr/ttZ0ohplg27BU4Z7CbGGun/gKLUFpwknb56kYWrMexjRojrdkU/dFKR
    /uq+exvwYOkWNiLEmvZ/Yc/rtjLRA4nO1A5w1VeUX8pz89BxAMf7XgYZsljzYbj+uccc
    ey0drsHqJxjFS9qDRl7IwNJPUdsG+g2t/GCbgfQvAUCtkTsbQevdSc3Cfqt7MzreonyR
    xMdK4OFBj+S5DpAaNaSH0ChdmjWzTbNuTrloZPjSmY0tOph1c9WaXaam0dTy9K0LV7ZC
    EGOezxd3LJtCeivvwD3m0B1SAoR1ajr3qV4sWy/G3HFBy4CI4dRrMEWyQ7dmiBe0rERp
    PuUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1700411270;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=9e4OV8vET8pL9QsaX1Uk5dAJCWcAgTeKF08zFu/UPPs=;
    b=EkaLml/k47CnYEjiCbwowCEzN/4nbm59WGkAhlmcIeQIJ+WBkurIyGfEQorvxTeK2V
    5TONuypzksKAoLGB7mBg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBfi4XXBswJY0gmAktx3ttlYVUFI0ea++ZcGg82g=="
Received: from [IPV6:2a02:8109:8984:5d00:c1eb:ec37:8228:567a]
    by smtp.strato.de (RZmta 49.9.1 AUTH)
    with ESMTPSA id U060a4zAJGRnJIM
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 19 Nov 2023 17:27:49 +0100 (CET)
Message-ID: <a9ade305-f90e-4250-a795-49ef4e29e0ac@xenosoft.de>
Date:   Sun, 19 Nov 2023 17:27:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/virtio: Add suppport for non-native buffer formats
To:     Gerd Hoffmann <kraxel@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Laurent Vivier <lvivier@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        linux-m68k@lists.linux-m68k.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>,
        Darren Stevens <darren@stevens-zone.net>,
        Christian Zigotzky <info@xenosoft.de>
References: <47a81d2e0e47b1715718779b6978a8b595cc7c5d.1700140609.git.geert@linux-m68k.org>
 <77c6gkquzq4sdtmrlko3lkxvcnipm2zfjem3kvhgslcellkefh@man7pbbzud47>
Content-Language: de-DE
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <77c6gkquzq4sdtmrlko3lkxvcnipm2zfjem3kvhgslcellkefh@man7pbbzud47>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 November 2023 at 03:44 pm, Gerd Hoffmann wrote:
> On Thu, Nov 16, 2023 at 02:16:54PM +0100, Geert Uytterhoeven wrote:
>> When using virtgpu on a big-endian machine, e.g. powerpc QEMU:
>>
>>      virtio-pci 0000:00:02.0: [drm] *ERROR* fbdev: Failed to setup generic emulation (ret=-2)
>>
>> or m68k/virt:
>>
>>      virtio-mmio virtio-mmio.125: [drm] *ERROR* fbdev: Failed to setup generic emulation (ret=-2)
>>
>> and the graphical display fails to come up.
>>
>> Before, the call to drm_mode_addfb() caused a translation from a fourcc
>> format (XR24) to a bpp/depth pair (32/24) to a potentially different fourcc
>> format (BX24 on big-endian), due to the quirk processing in
>> drm_driver_legacy_fb_format().  After, the original fourcc format (XR24)
>> is passed unmodified.
>>
>> However, the virtgpu DRM driver supports only a single format for its
>> main plane: DRM_FORMAT_HOST_XRGB8888, which is XR24 on little-endian,
>> and BX24 on big-endian.  I.e. on big-endian, virtgpu does not support
>> XR24, which is the default DRM format, and must be supported by all
>> drivers.  Before, this was reported, but didn't lead to a failure:
>>
>>      virtio-mmio virtio-mmio.125: [drm] bpp/depth value of 32/24 not supported
>>      virtio-mmio virtio-mmio.125: [drm] No compatible format found
>>
>> As the core virtgpu driver and device support both XR24 and BX24 on both
>> little-endian and big-endian just fine, fix this extending the list of
>> supported formats for main plane and cursor plane to XR24/BX24 resp.
>> AR24/BA24.
>>
>> Fixes: 6ae2ff23aa43a0c4 ("drm/client: Convert drm_client_buffer_addfb() to drm_mode_addfb2()")
>> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>> Closes: https://lore.kernel.org/r/c47fba21-3ae9-4021-9f4a-09c2670ebdbc@xenosoft.de
>> Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
>
Hi All,

The new patch works but I don't see the virtio-mouse-pci pointer 
anymore. I see the pointer with -device usb-tablet. Please check the 
second patch. I will use the first patch for the RC2 of kernel 6.7.

Thanks,
Christian
