Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C264772CCF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjHGRZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjHGRZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:25:40 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50685E74
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:25:39 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-56ca4d7079aso3254486eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691429138; x=1692033938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MT9ZoHa3QBN38VFI/biOZ0hMRuiUyTubHzewye4P1RM=;
        b=O1DRxAZ9GLVObJ/SVqp8h21UA2WiTQVFbdv1s7zTImPe9UdtKOemT2dTQX4Fnr3o8D
         IvCL0WHX1McghjNJkOYXZ/7lO9mJsg6ekXsGtakDRfzXkjvJsaLa6JfFGj29h4iGmkBI
         kjpsf42afYnlmz9egv4knpqvkRU5F8LLqw7nRfjby6PfxhF78u6J4gzZAk7CSC5h9pn7
         RgePyDz6lzMvjTLR8erI6HYN/nSlF8qRCt+N3jriURPzvJtF7TGpBS8wxMh2b1QlXbOc
         r7LnBmbtLbHT6oxk8OCGuazwSEXrbAvJTty0EnFmZB0dQDIK2zQvJsFpk4oS3V08nu/B
         d8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691429138; x=1692033938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MT9ZoHa3QBN38VFI/biOZ0hMRuiUyTubHzewye4P1RM=;
        b=OAoLIHEJ+UgPo4TAflu3T0hvYRXpLiK9oaYM+aUO+uLhMe7g0J7buH1c7MrEgMwZ6R
         +Wo4RAN2eUeLHINrKfZL1FwR8fyQfkEh/gl3skcRO3cnY9DWT5j266YBP55+OsoSQCEu
         j+xy82cocL9lFpcnIzQJiwJMcs8FW7wibiyM/ZDq1vyTGwtig9iLFXG0gQQ7Jmab12Q0
         SetGqC0lPFm1M0S+AqCyUb52YangniJ00KZNEDXdR+6gwu7W768tzZMhAfELrjVB2Dj6
         4jL80QSurC/VAq15jqn2eum77f1Tt2wuDoLGFaBEm+NqENzqznEW4au2JPbRzJoN1P5N
         L62Q==
X-Gm-Message-State: AOJu0YwzWmaPYFUKy98MfNvYbMhIKy2i10uv5JI731IAC1/sl4jlRUkl
        sgvAcee0eijqK4Hu9Ugpu/y5YKPpoPuwk2zZ0h0=
X-Google-Smtp-Source: AGHT+IHKdYJhOzFLz7sRPBkKw8b9SIdR/Y65ZOVU8mGmwuV/MU3nCqvJ7FNIUlZ07bZFuuONi/WLIqWFKqq1TdTS0R4=
X-Received: by 2002:a4a:3c5e:0:b0:56d:55b7:e99c with SMTP id
 p30-20020a4a3c5e000000b0056d55b7e99cmr9158977oof.1.1691429138564; Mon, 07 Aug
 2023 10:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230802071805.12808-1-sunran001@208suo.com>
In-Reply-To: <20230802071805.12808-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:25:27 -0400
Message-ID: <CADnq5_Oj_+k3E4Njhw-W4_YvSLb9LL9RfGsrQb6a085Dpc5iFQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up errors in dce_v8_0.c
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Wed, Aug 2, 2023 at 3:18=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: that open brace { should be on the previous line
> ERROR: code indent should use tabs where possible
> ERROR: space required before the open brace '{'
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 37 ++++++++++-----------------
>  1 file changed, 14 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v8_0.c
> index d421a268c9ff..f2b3cb5ed6be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -53,8 +53,7 @@
>  static void dce_v8_0_set_display_funcs(struct amdgpu_device *adev);
>  static void dce_v8_0_set_irq_funcs(struct amdgpu_device *adev);
>
> -static const u32 crtc_offsets[6] =3D
> -{
> +static const u32 crtc_offsets[6] =3D {
>         CRTC0_REGISTER_OFFSET,
>         CRTC1_REGISTER_OFFSET,
>         CRTC2_REGISTER_OFFSET,
> @@ -63,8 +62,7 @@ static const u32 crtc_offsets[6] =3D
>         CRTC5_REGISTER_OFFSET
>  };
>
> -static const u32 hpd_offsets[] =3D
> -{
> +static const u32 hpd_offsets[] =3D {
>         HPD0_REGISTER_OFFSET,
>         HPD1_REGISTER_OFFSET,
>         HPD2_REGISTER_OFFSET,
> @@ -1345,9 +1343,9 @@ static void dce_v8_0_audio_write_sad_regs(struct dr=
m_encoder *encoder)
>                                 if (sad->channels > max_channels) {
>                                         value =3D (sad->channels <<
>                                                  AZALIA_F0_CODEC_PIN_CONT=
ROL_AUDIO_DESCRIPTOR0__MAX_CHANNELS__SHIFT) |
> -                                               (sad->byte2 <<
> +                                               (sad->byte2 <<
>                                                  AZALIA_F0_CODEC_PIN_CONT=
ROL_AUDIO_DESCRIPTOR0__DESCRIPTOR_BYTE_2__SHIFT) |
> -                                               (sad->freq <<
> +                                               (sad->freq <<
>                                                  AZALIA_F0_CODEC_PIN_CONT=
ROL_AUDIO_DESCRIPTOR0__SUPPORTED_FREQUENCIES__SHIFT);
>                                         max_channels =3D sad->channels;
>                                 }
> @@ -1379,8 +1377,7 @@ static void dce_v8_0_audio_enable(struct amdgpu_dev=
ice *adev,
>                 enable ? AZALIA_F0_CODEC_PIN_CONTROL_HOT_PLUG_CONTROL__AU=
DIO_ENABLED_MASK : 0);
>  }
>
> -static const u32 pin_offsets[7] =3D
> -{
> +static const u32 pin_offsets[7] =3D {
>         (0x1780 - 0x1780),
>         (0x1786 - 0x1780),
>         (0x178c - 0x1780),
> @@ -1740,8 +1737,7 @@ static void dce_v8_0_afmt_fini(struct amdgpu_device=
 *adev)
>         }
>  }
>
> -static const u32 vga_control_regs[6] =3D
> -{
> +static const u32 vga_control_regs[6] =3D {
>         mmD1VGA_CONTROL,
>         mmD2VGA_CONTROL,
>         mmD3VGA_CONTROL,
> @@ -1895,9 +1891,9 @@ static int dce_v8_0_crtc_do_set_base(struct drm_crt=
c *crtc,
>         case DRM_FORMAT_XBGR8888:
>         case DRM_FORMAT_ABGR8888:
>                 fb_format =3D ((GRPH_DEPTH_32BPP << GRPH_CONTROL__GRPH_DE=
PTH__SHIFT) |
> -                            (GRPH_FORMAT_ARGB8888 << GRPH_CONTROL__GRPH_=
FORMAT__SHIFT));
> +                               (GRPH_FORMAT_ARGB8888 << GRPH_CONTROL__GR=
PH_FORMAT__SHIFT));
>                 fb_swap =3D ((GRPH_RED_SEL_B << GRPH_SWAP_CNTL__GRPH_RED_=
CROSSBAR__SHIFT) |
> -                          (GRPH_BLUE_SEL_R << GRPH_SWAP_CNTL__GRPH_BLUE_=
CROSSBAR__SHIFT));
> +                       (GRPH_BLUE_SEL_R << GRPH_SWAP_CNTL__GRPH_BLUE_CRO=
SSBAR__SHIFT));
>  #ifdef __BIG_ENDIAN
>                 fb_swap |=3D (GRPH_ENDIAN_8IN32 << GRPH_SWAP_CNTL__GRPH_E=
NDIAN_SWAP__SHIFT);
>  #endif
> @@ -3151,7 +3147,7 @@ static int dce_v8_0_pageflip_irq(struct amdgpu_devi=
ce *adev,
>
>         spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
>         works =3D amdgpu_crtc->pflip_works;
> -       if (amdgpu_crtc->pflip_status !=3D AMDGPU_FLIP_SUBMITTED){
> +       if (amdgpu_crtc->pflip_status !=3D AMDGPU_FLIP_SUBMITTED) {
>                 DRM_DEBUG_DRIVER("amdgpu_crtc->pflip_status =3D %d !=3D "
>                                                 "AMDGPU_FLIP_SUBMITTED(%d=
)\n",
>                                                 amdgpu_crtc->pflip_status=
,
> @@ -3544,8 +3540,7 @@ static void dce_v8_0_set_irq_funcs(struct amdgpu_de=
vice *adev)
>         adev->hpd_irq.funcs =3D &dce_v8_0_hpd_irq_funcs;
>  }
>
> -const struct amdgpu_ip_block_version dce_v8_0_ip_block =3D
> -{
> +const struct amdgpu_ip_block_version dce_v8_0_ip_block =3D {
>         .type =3D AMD_IP_BLOCK_TYPE_DCE,
>         .major =3D 8,
>         .minor =3D 0,
> @@ -3553,8 +3548,7 @@ const struct amdgpu_ip_block_version dce_v8_0_ip_bl=
ock =3D
>         .funcs =3D &dce_v8_0_ip_funcs,
>  };
>
> -const struct amdgpu_ip_block_version dce_v8_1_ip_block =3D
> -{
> +const struct amdgpu_ip_block_version dce_v8_1_ip_block =3D {
>         .type =3D AMD_IP_BLOCK_TYPE_DCE,
>         .major =3D 8,
>         .minor =3D 1,
> @@ -3562,8 +3556,7 @@ const struct amdgpu_ip_block_version dce_v8_1_ip_bl=
ock =3D
>         .funcs =3D &dce_v8_0_ip_funcs,
>  };
>
> -const struct amdgpu_ip_block_version dce_v8_2_ip_block =3D
> -{
> +const struct amdgpu_ip_block_version dce_v8_2_ip_block =3D {
>         .type =3D AMD_IP_BLOCK_TYPE_DCE,
>         .major =3D 8,
>         .minor =3D 2,
> @@ -3571,8 +3564,7 @@ const struct amdgpu_ip_block_version dce_v8_2_ip_bl=
ock =3D
>         .funcs =3D &dce_v8_0_ip_funcs,
>  };
>
> -const struct amdgpu_ip_block_version dce_v8_3_ip_block =3D
> -{
> +const struct amdgpu_ip_block_version dce_v8_3_ip_block =3D {
>         .type =3D AMD_IP_BLOCK_TYPE_DCE,
>         .major =3D 8,
>         .minor =3D 3,
> @@ -3580,8 +3572,7 @@ const struct amdgpu_ip_block_version dce_v8_3_ip_bl=
ock =3D
>         .funcs =3D &dce_v8_0_ip_funcs,
>  };
>
> -const struct amdgpu_ip_block_version dce_v8_5_ip_block =3D
> -{
> +const struct amdgpu_ip_block_version dce_v8_5_ip_block =3D {
>         .type =3D AMD_IP_BLOCK_TYPE_DCE,
>         .major =3D 8,
>         .minor =3D 5,
> --
> 2.17.1
>
