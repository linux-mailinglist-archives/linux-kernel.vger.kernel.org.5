Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28177776FB4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbjHJFnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjHJFnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:43:18 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA3BDA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 22:43:17 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-790aeee9928so17665439f.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 22:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691646197; x=1692250997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sP2WNJmHGIojwtQNcqjJWegFiViuW7cigU9WfO1EE3Q=;
        b=J9GRbINtJZ1U7q1Z8bNomXairU+CRVjznqa7I/Rwr41NQ6ZhIEHW6cmx9dJK7gm6FI
         ZU6KLdv1FVl0QOz3tTXoBkf417djpOYMvuGlrxD42RT6aNiOtCUOsXfFEdt0tDxMuE1b
         fVEuh6ds+gNjdJcMFmDVy2UmO5N/gdhxyqJ/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691646197; x=1692250997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sP2WNJmHGIojwtQNcqjJWegFiViuW7cigU9WfO1EE3Q=;
        b=Jjm/+PCQWdbrJg2B2cHGVeC5Gd6w8nmNwr9r5locVbDwLG7WgHj0vcr70UNMhefTLl
         qZ2aPuIrne8bBdOIYmS6X4oe8wjOgVykbtlIDuI/jGZXVvZr3ElF3L/ZmiHSa2J/ymyF
         0kSTGj5veD0cwRtc3tP5ndpaI2yIg/Y7VMmqcOX5egxCADGSu8oseUAa1vJnyqDJWfE7
         4e7JgSzUbzI5D/fMkFk2e+r5W1MfPqGDEvh8Z3SP1JVY3ZJOxrZ6RONeqtIb9YEmrynI
         FAhHU99MCnW5VdI80OK7StJbV9h8r8Yzd76N/OW7eKv7Kdhn0ex5CQriwMWFganJqWo/
         a32g==
X-Gm-Message-State: AOJu0Yx3wHvj+lqwUsgaCixVNHqN+vnptfaH8wAjA/ktbjmqxPF22qKH
        GBS97hDZhSrTOorZsEyDbmEgpvNkIrPXXShZjVc=
X-Google-Smtp-Source: AGHT+IH+hSutA9oftsKYMyCDGZM1Ixn0C1FQyGHOxN4XHnGc0ZIwD98TI4v8y82ZKBXyET6EkYT4zQ==
X-Received: by 2002:a5e:a713:0:b0:791:1951:1df0 with SMTP id b19-20020a5ea713000000b0079119511df0mr2199872iod.18.1691646197038;
        Wed, 09 Aug 2023 22:43:17 -0700 (PDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com. [209.85.166.41])
        by smtp.gmail.com with ESMTPSA id b15-20020a056602218f00b00777b94e8efasm251911iob.18.2023.08.09.22.43.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 22:43:16 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-790cadee81bso18015339f.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 22:43:16 -0700 (PDT)
X-Received: by 2002:a05:6602:20c2:b0:787:1c51:ff99 with SMTP id
 2-20020a05660220c200b007871c51ff99mr2004510ioz.11.1691646196046; Wed, 09 Aug
 2023 22:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230809181525.7561-1-jason-jh.lin@mediatek.com> <20230809181525.7561-5-jason-jh.lin@mediatek.com>
In-Reply-To: <20230809181525.7561-5-jason-jh.lin@mediatek.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Thu, 10 Aug 2023 13:42:39 +0800
X-Gmail-Original-Message-ID: <CAC=S1ngxyACUvMXTu5ZDwiLJ=ZzDXMMiVVhNr_Kjv3rxsX5gGQ@mail.gmail.com>
Message-ID: <CAC=S1ngxyACUvMXTu5ZDwiLJ=ZzDXMMiVVhNr_Kjv3rxsX5gGQ@mail.gmail.com>
Subject: Re: [PATCH v9 4/7] drm/mediatek: Add encoder_index function to
 mtk_ddp_comp_funcs for dpi
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

On Thu, Aug 10, 2023 at 2:15=E2=80=AFAM Jason-JH.Lin <jason-jh.lin@mediatek=
.com> wrote:
>
> To support dynamic connector selection function, each ddp_comp need to
> get their encoder_index to identify which connector should be selected.
>
> Add encoder_index function to mtk_ddp_comp_funcs and the implementation
> of mtk_dpi_encoder_index to get its encoder_index.
>
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Reviewed-by: Fei Shao <fshao@chromium.org>
Tested-by: Fei Shao <fshao@chromium.org>
