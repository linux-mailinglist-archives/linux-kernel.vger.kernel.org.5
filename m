Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45617ACD3A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 02:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjIYAmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 20:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjIYAlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 20:41:52 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60920E41;
        Sun, 24 Sep 2023 17:41:32 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99357737980so646134966b.2;
        Sun, 24 Sep 2023 17:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695602490; x=1696207290; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4ileczhTo59jSLKKhIFJHNq8m7EKn5gFshxEeqYf+g8=;
        b=Jsatf7/Ht+7bXDBpCDbaTtQSd15Bjtq/OMeLaYCGSObiHgO5gGjj4M02VuyWK9HgJ5
         lNaHbTIxLVT9JHY7CFAH9wK41t587DoeXbLSL3EF9wLAzsYXsW1DvGsje6E4Nxx2YaUx
         OhvJW1cDxPAIpMW/XB9sqAZkrSoRRqCSL9HaacjmibJSjUXVVR1rtVAd2fbhQNYA//YW
         BUK1IKTzwfWWV/Gu+h+2i3RzYvXlppXc135YXtqco8g+cYkOwZAsi2AirVywIHCoyt4T
         +b/c0ge4miImjDFAIQpFTWsIf2ntVzeaUzdSZb/xRtAJXZ93w9lj7nuVh2eVZVYl/Bdr
         x9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695602490; x=1696207290;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ileczhTo59jSLKKhIFJHNq8m7EKn5gFshxEeqYf+g8=;
        b=kRkMxXPviG3CdGgYdlQ+DN6BhK54J2Q3gUAcqJUPyGHkfcx4FcE8FoWE/BODN50BKU
         x8GAj0JrDtrbfwwKr+XTREQ8A0mBUrDYzzvGeiHmpUbxH6IVGhhe3oH6gMQ3inpmnO1J
         hc2S4q1sczJ1bwbgY7KhS967/clCqoI4cWWoP5IPwx14SawMxBlrYJYHbKSaEsZhcKeB
         oaMMoQZ/HjjJkg3AwvS2RnzP+BVdFOkcVyKiqhyiZdpnhdtS4Y2AnYn40w15vGfM2fTg
         hZXJ3DZ5g8J1bd1ZDda08ZRwFOImvEenXHQ3LyKWJhv4KZTLtU3nfrH6md8EMfhDCkL9
         ws9A==
X-Gm-Message-State: AOJu0YwQJ0mIxvWKP2orWMzvNpFLBOF+0XXsUENgMmW9zx5OOYvwCLFx
        jVZXQiSqk2KP3bJr+iDerRNmTKzbgYKKNCV1WSQ=
X-Google-Smtp-Source: AGHT+IGFjEMVeNFrkLJYHamatWrMaHQ1gzKqElZWX+oPSiWwW/r2LvYGho6VeMP5MixDo8P7RVqpzjEqVBXiLu4U1bg=
X-Received: by 2002:a17:907:7610:b0:9ae:7d2d:f2b0 with SMTP id
 jx16-20020a170907761000b009ae7d2df2b0mr4859432ejc.63.1695602490251; Sun, 24
 Sep 2023 17:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230906095542.3280699-1-sarah.walker@imgtec.com> <20230906095542.3280699-5-sarah.walker@imgtec.com>
In-Reply-To: <20230906095542.3280699-5-sarah.walker@imgtec.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 25 Sep 2023 10:41:18 +1000
Message-ID: <CAPM=9twSNbXEttteT=NBqn3baxVPHcSHfJ-aUmneKuhO4yDiEg@mail.gmail.com>
Subject: Re: [PATCH v6 04/20] drm/imagination/uapi: Add PowerVR driver UAPI
To:     Sarah Walker <sarah.walker@imgtec.com>
Cc:     dri-devel@lists.freedesktop.org, frank.binns@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, corbet@lwn.net, christian.koenig@amd.com,
        linus.walleij@linaro.org, matt.coster@imgtec.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, faith.ekstrand@collabora.com,
        afd@ti.com, hns@goldelico.com, matthew.brost@intel.com,
        luben.tuikov@amd.com, dakr@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +struct drm_pvr_dev_query_gpu_info {
> +       /**
> +        * @gpu_id: GPU identifier.
> +        *
> +        * For all currently supported GPUs this is the BVNC encoded as a 64-bit
> +        * value as follows:
> +        *
> +        *    +--------+--------+--------+-------+
> +        *    | 63..48 | 47..32 | 31..16 | 15..0 |
> +        *    +========+========+========+=======+
> +        *    | B      | V      | N      | C     |
> +        *    +--------+--------+--------+-------+
> +        */
> +       __u64 gpu_id;
> +
> +       /**
> +        * @num_phantoms: Number of Phantoms present.
> +        */
> +       __u32 num_phantoms;
> +};

I think this one needs __u32 padding; of some sort.

Dave.
