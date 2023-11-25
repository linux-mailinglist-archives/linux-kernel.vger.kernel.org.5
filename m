Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280937F8AD3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 13:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjKYMix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 07:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKYMiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 07:38:51 -0500
X-Greylist: delayed 172 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 25 Nov 2023 04:38:57 PST
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27BE8E
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 04:38:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1700915755; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SFKxXYcw0DY3Pria634pawBeRWKRRXxfi3Y+vZy3WNv45FpWK/MWewg+Q9uDwBgqzI
    /enXQtyu8P0uCilVQzhbepudj37ZOQqPVn4cO1RFUpLOCKBnO1zvmQejji715ys188zj
    AjVvUpMyLetKI4UTsvbfe/i5IhLivgg44eJ674X2trdM8yjSHYYeoaBbZ4JxltAyqwKN
    r+erA/DaoJU1phKMA7mPq5RTonRAsnyHYtbte+vU+bpUqgfEPye1b7oMqioGbMC8ywii
    SRId6NU0uC0/5ZcBHzZ7eC0ZvWya/G8vErIwBg5aFCLZ3WUiMkvDkHdAVq7nN//76cet
    +IEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1700915755;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=p56uFgR+2L+joFqVsz4BnJljMfmRwlsgQch0B8qQcmg=;
    b=eFC0fcFKW3P+unvRT3QqxSRGvpZ9SH9UOuwCV+Rc6Va4K9TWHT20eVhsawLbSlIpbg
    hBl06jmhofsu3QD+zymhTfFk5BCj2v5yoN8COAmOMHILpObKwO6wpJX6Oi84LBxFiv4E
    91PHUaCKTdb69jrcuNI5M1DWfdQlDMqMezqT3NAfDH6iObt2ucLfwxDDlhvNwC5SUPOI
    ZaO79AQoYxorZMyW4umhQXXlGKDlrMRcL4p9gm0oRo3j0zI1rHX7V+eev/HEASrWF/2T
    0RqNQmiFPoxEG4xIKHiNMUCpwz1sK84/6Kie651p5gNJr5yzvypj8icmhQcQ4u0l++hr
    AUHg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1700915755;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=p56uFgR+2L+joFqVsz4BnJljMfmRwlsgQch0B8qQcmg=;
    b=dLAAAh8H4MwhFrYhPbikzmad1Zr2xapLpe8gQGIyVsZ2Arj6oelgy6usS7zAe05GZN
    q3HQNoQz4rkHUlz4EmW6Fi7VfzTLxqpdQ4LFXgnZ7CqaTVhNv2d6Ph22UaAYyy6PHxkQ
    A4AN9TrM5CmVA/Gk0xG2zPqmTKCJJDm9C2oAkUNJuL/KzARBwAiCpwRNbZzY+YT36TbQ
    IDqJj95yYaFVoz1nImVmbBZR0hFt5qY3N1BDtxjrZZweP+HU6NSO/KakLn0WRJ/I1Dd3
    FrtMN2b4VQ8x7cvU7SjvPh4cI3J1wAEZxPVps2bA3pk1hFJt+becOQHIytMRrxyDdIi3
    JTNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1700915755;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=p56uFgR+2L+joFqVsz4BnJljMfmRwlsgQch0B8qQcmg=;
    b=k/xUVoLQGPkzgFFsbDRKOt43eEzMiKXYPTVTsswpE0W9NOsGK5/u1O1OaIFSJBcsdH
    iNvaDZ/6UeVxT6krLgCg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBfi4XXBswJY0hynIKqjaeYiGT1rE/QhtjOKJAIg=="
Received: from [IPV6:2a02:8109:8984:5d00:bc44:680c:952a:1673]
    by smtp.strato.de (RZmta 49.9.1 AUTH)
    with ESMTPSA id U060a4zAPCZsnsU
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 25 Nov 2023 13:35:54 +0100 (CET)
Message-ID: <1bd6d2c8-007b-46f7-85b4-9793ec650f94@xenosoft.de>
Date:   Sat, 25 Nov 2023 13:35:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/virtio: Add suppport for non-native buffer formats
Content-Language: de-DE
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@redhat.com>,
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
        Christian Zigotzky <info@xenosoft.de>
References: <47a81d2e0e47b1715718779b6978a8b595cc7c5d.1700140609.git.geert@linux-m68k.org>
 <77c6gkquzq4sdtmrlko3lkxvcnipm2zfjem3kvhgslcellkefh@man7pbbzud47>
 <a9ade305-f90e-4250-a795-49ef4e29e0ac@xenosoft.de>
 <CAMuHMdXtUYJmEharJhBXx7D=fA3mQxg6uMP2=4Qgi==2a+kVQw@mail.gmail.com>
 <37b9e5ab-e170-4071-a912-f3fec0d59d5c@xenosoft.de>
 <ee75377ad22a3d07f272e17f53cabead7b43afcb.camel@physik.fu-berlin.de>
 <9e8d2abd-94a1-4fb6-b30a-c6e4c52af011@xenosoft.de>
In-Reply-To: <9e8d2abd-94a1-4fb6-b30a-c6e4c52af011@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 November 2023 at 01:22 pm, Christian Zigotzky wrote:
> On 25 November 2023 at 12:09 pm, John Paul Adrian Glaubitz wrote:
>> On Sat, 2023-11-25 at 11:06 +0100, Christian Zigotzky wrote:
>>> Could you please revert the v2 patch because of the issue with the
>>> virtio-mouse-pci cursor? I will try to use the v1 patch for the RC3 of
>>> kernel 6.7.
>> I don't understand why the v2 patch should yield any different 
>> results as
>> the only change compared to v1 is the fixed patch subject. There are no
>> functional differences, I just diffed the patches against each other:
>>
>> --- geert-patch-v1.patch        2023-11-25 12:09:19.122936658 +0100
>> +++ geert-patch-v2.patch        2023-11-25 12:09:36.313039085 +0100
>> @@ -34,6 +34,9 @@
>>   Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
>>   Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>   ---
>> +v2:
>> +  - Fix truncated one-line summary.
>> +---
>>    drivers/gpu/drm/virtio/virtgpu_display.c | 11 +++++++++--
>>    drivers/gpu/drm/virtio/virtgpu_plane.c   |  6 ++++--
>>    2 files changed, 13 insertions(+), 4 deletions(-)
>>
>> Adrian
>>
> Hi Adrian,
>
> Thank you for the hint. I think you are right. I use the following patch.
>
> --- a/drivers/gpu/drm/drm_client.c    2023-11-13 01:19:07.000000000 +0100
> +++ b/drivers/gpu/drm/drm_client.c    2023-11-14 09:45:44.964199272 +0100
> @@ -400,6 +400,16 @@ static int drm_client_buffer_addfb(struc
>
>      fb_req.width = width;
>      fb_req.height = height;
> +           if 
> (client->dev->mode_config.quirk_addfb_prefer_host_byte_order) {
> +               if (format == DRM_FORMAT_XRGB8888)
> +                       format = DRM_FORMAT_HOST_XRGB8888;
> +               if (format == DRM_FORMAT_ARGB8888)
> +                       format = DRM_FORMAT_HOST_ARGB8888;
> +               if (format == DRM_FORMAT_RGB565)
> +                       format = DRM_FORMAT_HOST_RGB565;
> +               if (format == DRM_FORMAT_XRGB1555)
> +                       format = DRM_FORMAT_HOST_XRGB1555;
> +        }
>      fb_req.pixel_format = format;
>      fb_req.handles[0] = handle;
>      fb_req.pitches[0] = buffer->pitch;
>
> This patch solved the issue.
>
> Christian
This was the first solution and it works without any problems.

Christian
