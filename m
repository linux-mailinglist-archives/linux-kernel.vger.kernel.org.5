Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992BE776F9A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjHJFcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbjHJFcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:32:02 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDC61704
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 22:32:01 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7918997ad9fso844639f.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 22:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691645521; x=1692250321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90vuit1vtETcc7ICm483dG4LoGioHBxHspT621cfQB0=;
        b=KuYG1+N7tuG+LkqMrMRwdAfQzdTMFt8fFQhT5R3APM6rsSSctIS/ZS47z4X+qjEz0l
         VIEsRBMvoYFrtT7KcDzT5jki+2EDrJhSszDVJzVuplp0q5eTVoNLqMvjkm2sPJ2K9FcH
         PzOHDTlMmTHj3XSY4Uqjtqh6dqmVCh6/IbZI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691645521; x=1692250321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90vuit1vtETcc7ICm483dG4LoGioHBxHspT621cfQB0=;
        b=AkEceZlUlPzL1T9hpWCLZvGNix4Raba9yrMQOA3BZJSR1kwub2dh6KIVHQmUt9OgNC
         rigoICz0vsFdf9GvWFCb+1PmoPBcoPEA0R4yjbDdC1dvjzlJiaOXt25MTyAstA/+UyEK
         zltQlvG7zycPTlVbyh9ITm1fdChe+9SgPz6jjqgONYKQyAK9ER52XB7E5MUnpGl2eeG6
         bC96ie1zVG7cjl07ycMBigWDF+1UD3c8MlYTl+92o0I5VAOK4q+bplzCpwzGhR6xvuiq
         ndFORAbImHgm+GMe2H6RJ+lM2/IXnTNFoRSDDXy/uxbo8KmfsZkfknMVbGD9GTGEj7rh
         0/lA==
X-Gm-Message-State: AOJu0YxwUv3SLSxbDRCMukt+94dequMWoeC3zhi9Yw7X3YUSlGgId05i
        8tuNygzyGdbqI004L906btJJ16dRYYvV6+WXe/M=
X-Google-Smtp-Source: AGHT+IH8luAg6XolJYHqTr0DETGc/sGgkzrSbxfH2HRBeWdr4hhUrkxRQaxjhOkuDZz8GA3DPHnyEA==
X-Received: by 2002:a05:6602:2552:b0:790:aed5:d0b0 with SMTP id cg18-20020a056602255200b00790aed5d0b0mr1722579iob.0.1691645521009;
        Wed, 09 Aug 2023 22:32:01 -0700 (PDT)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id w8-20020a056602034800b0078647b08ab0sm260066iou.6.2023.08.09.22.32.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 22:32:00 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-790fc019c62so14387339f.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 22:32:00 -0700 (PDT)
X-Received: by 2002:a05:6602:2552:b0:790:aed5:d0b0 with SMTP id
 cg18-20020a056602255200b00790aed5d0b0mr1722545iob.0.1691645520345; Wed, 09
 Aug 2023 22:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230809181525.7561-1-jason-jh.lin@mediatek.com> <20230809181525.7561-2-jason-jh.lin@mediatek.com>
In-Reply-To: <20230809181525.7561-2-jason-jh.lin@mediatek.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Thu, 10 Aug 2023 13:31:23 +0800
X-Gmail-Original-Message-ID: <CAC=S1ng4UKNy2ZtJr1YUAtZ5M+A5DgRWt68ibKaW3ohwV6foTw@mail.gmail.com>
Message-ID: <CAC=S1ng4UKNy2ZtJr1YUAtZ5M+A5DgRWt68ibKaW3ohwV6foTw@mail.gmail.com>
Subject: Re: [PATCH v9 1/7] drm/mediatek: Add mmsys_dev_num to mt8188 vdosys0
 driver data
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 2:35=E2=80=AFAM Jason-JH.Lin <jason-jh.lin@mediatek=
.com> wrote:
>
> Add missing mmsys_dev_num to mt8188 vdosys0 driver data.
>
> Fixes: 54b48080278a ("drm/mediatek: Add mediatek-drm of vdosys0 support f=
or mt8188")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

Tested with MT8188 and the internal display is up and functioning.

Reviewed-by: Fei Shao <fshao@chromium.org>
Tested-by: Fei Shao <fshao@chromium.org>
