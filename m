Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CA97DD590
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376566AbjJaRyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376698AbjJaRyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:54:06 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F06592;
        Tue, 31 Oct 2023 10:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=o2E3veqHg9OrVeSCRKWiZ1+wEoUp/PDuBKg96qAOXiQ=; b=my5RucsTfxH7smQjbgy0UExDk0
        KN+aCl13wjSI9aT0Tie5qmQfcbIO2vf5BOXKw1/2yzVvXgrKxgoaFm8YFmSc7q9eufSyoIH+kLtRP
        5LfjmHw1GEDlyvePW2/AcDGYMevNEvpibcrNlThdGMB1WL8lMvmakxqx1iMNnNMAIls/uj8iTcLsq
        OWMmS+l3iR2knBy1tLc4PJUvaMvoHQzRIKqjBJF5CeCRkUVfyu9qjaXARnt5jbAaVG01lq3sg0gOr
        N0Z4s8ZiWLmKoPt9NbW+v3ygX3qwn/ylyRPQGH5i7cuaUwjn9JoM3QZo+QZrpcpsces7BiZ5FMlER
        BeJrcKHQ==;
Received: from gwsc.sc.usp.br ([143.107.225.16] helo=[172.20.12.146])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qxsvv-00FU3i-Et; Tue, 31 Oct 2023 18:53:43 +0100
Message-ID: <d3ed80e5-b3a1-e9ba-48eb-7c6fc58ef3f9@igalia.com>
Date:   Tue, 31 Oct 2023 14:53:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 3/4] dt-bindings: gpu: v3d: Add BCM2712's compatible
To:     Iago Toral Quiroga <itoral@igalia.com>,
        dri-devel@lists.freedesktop.org
Cc:     Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20231031073859.25298-1-itoral@igalia.com>
 <20231031073859.25298-4-itoral@igalia.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20231031073859.25298-4-itoral@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to ask the device tree maintainers if you are willing
to take this through your tree or should I push the entire series
through drm-misc/drm-misc-next.

Best Regards,
- Maíra

On 10/31/23 04:38, Iago Toral Quiroga wrote:
> BCM2712, Raspberry Pi 5's SoC, contains a V3D core. So add its specific
> compatible to the bindings.
> 
> Signed-off-by: Iago Toral Quiroga <itoral@igalia.com>
> Reviewed-by: Maíra Canal <mcanal@igalia.com>
> ---
>   Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.yaml b/Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.yaml
> index dae55b8a267b..dc078ceeca9a 100644
> --- a/Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.yaml
> +++ b/Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.yaml
> @@ -17,6 +17,7 @@ properties:
>     compatible:
>       enum:
>         - brcm,2711-v3d
> +      - brcm,2712-v3d
>         - brcm,7268-v3d
>         - brcm,7278-v3d
>   
