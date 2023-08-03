Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E4676E507
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbjHCJxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbjHCJxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:53:39 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E6C30F9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:53:37 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso8135265e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 02:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691056416; x=1691661216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o/B0ToLExP+DiR9D97raY/1J2KSwUj5aVQTHcLopPW4=;
        b=hnii72+lRfd3fIj8r+WNkTKXqcHLxpE84fpR4zovZr6d4FRi/cSQ8Df191YVGBlsiC
         IPFvADsBsCMlNrZJpT+HaTU6fxodvjHbwmFhyc/GefTUYpyhqMwD6dfR9zehmjFhwrmw
         msdRDz9+zNRfViEUhW0t8UmAfACzDQ506jBsy7sNzGDXVMXQKpxQ5+AdQ2vDOvMnavNh
         Hjfoe/NerLWkfc4mvnQCJTDqil9W4pPKxArj8d+xZfnhMotyOtFHcJICur+WCDMpuvi9
         i5TI2AB2rTgc0HsXoYOABVfqAd4JlCS6zbRPUuVrdVHBC2/06xza3GFHWBz36B4uSC1B
         lzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691056416; x=1691661216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/B0ToLExP+DiR9D97raY/1J2KSwUj5aVQTHcLopPW4=;
        b=U8U6wU4Sr9ivuVopEBhy+YCqrf7gMd4jexJawhofBXH6eRxY1FZ9H/LvjJYF63OBBA
         1L4MrZJPHkqDrHRIF0kvW833BNcmMsiGMIn4YnhvLf6b73dajJh45qkkIRjEVzTeodtk
         ZTy67avqqR7gf+l1A9kXsAC4hGk7ciALUXa2mQFrgRVbMu3J1JAH1Lej9t1ww/48o2ao
         uhJuyFNCnr86UZKTLobMxZkODj13tdyzpUmoFFEXvcvfI2WZIedanBKuXgfo5QvCfpN1
         uF93JBeKdGd7BZNJ3PvUW6q03f7YyKxNspkkvNNREFucBmRPl2BtrPy9bmCW1dHBzNQs
         v2aw==
X-Gm-Message-State: ABy/qLYNMvl/Bwwe0YujJ8iMll5Tn3GXpi/4IZy1Ppz/tJHkefCSvhFk
        LnFK4i+T4EHG2pmoENHYqvsqGA==
X-Google-Smtp-Source: APBJJlEypDBS9JVFp+B8z1U3CVh5JzhVEqfWbu5Fxsi6niCNxUT0RBG20ys8Q2wWkY0Xe2Z09A8w2A==
X-Received: by 2002:a1c:7c0e:0:b0:3fe:2b69:fc6c with SMTP id x14-20020a1c7c0e000000b003fe2b69fc6cmr5373711wmc.39.1691056416186;
        Thu, 03 Aug 2023 02:53:36 -0700 (PDT)
Received: from localhost ([2a01:e0a:55f:21e0:9e19:4376:dea6:dbfa])
        by smtp.gmail.com with ESMTPSA id t12-20020a7bc3cc000000b003fbc30825fbsm3800361wmj.39.2023.08.03.02.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 02:53:35 -0700 (PDT)
Date:   Thu, 3 Aug 2023 11:53:35 +0200
From:   Julien Stephan <jstephan@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Phi-bang Nguyen <pnguyen@baylibre.com>,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        devicetree@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        Louis Kuo <louis.kuo@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2 4/4] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 camsv
Message-ID: <iq7jffjeaejdfb26a4ysjgjzuopov4ji2ecgzmv4563tdveaep@hh2gzgzkbdzj>
References: <20230630100321.1951138-1-jstephan@baylibre.com>
 <20230630100321.1951138-5-jstephan@baylibre.com>
 <0430ddab-6a6c-9fa3-95bd-05ce8ac5b94f@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0430ddab-6a6c-9fa3-95bd-05ce8ac5b94f@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 02:21:17PM +0200, AngeloGioacchino Del Regno wrote:
..snip..
> > +
> > +	mtk_cam_init_cfg(&cam->subdev, NULL);
>
> mtk_cam_init_cfg() returns an integer, and this is probably because you expect
> it to get logic to fail: in that case, check the result of that call here,
> otherwise, make that function void.
>

Hi Angelo,

mtk_cam_init_cfg returns an int because it should match v4l2_subdev_pad_ops->init_cfg prototype..

mtk_cam_init does not fail, always return 0, so I though it would be ok
to discard the return value here. What do you think?

> > +

..snip..

> > +	unsigned int bpp;
>
> Can we get any format that uses a billion bits per pixel? :-P
>
> u8 bpp;
>

I am preparing the driver for futur upgrades.. in a billion years ;)

Cheers
Julien
