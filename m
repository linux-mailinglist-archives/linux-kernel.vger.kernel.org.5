Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1F476BEAD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjHAUpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjHAUpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:45:34 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B1C1FFD;
        Tue,  1 Aug 2023 13:45:31 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bca3588edbso1707193a34.0;
        Tue, 01 Aug 2023 13:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690922731; x=1691527531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/xrXCgNmimlEpmVkNg4fSgJT+KBh0CxQ02eEsxeKYQ=;
        b=Ws51JG5I962Sbaups3cMKyFw6upggCIv+X59gK+bvSLCAGU9+bU+oUtxacuAM7/js7
         bVl/zr7Gk7Z+EXoA8z1cbZykGpxFjTniScZFXRgkx9p3Uoxau93I23VtCmWcd9yFTCUN
         LpHbpkxza2qLhZ+YHmMRxVVJ4VkYHWux2LX7nsRZJ8wH938yhQFOsrqmUE1gL4SRJk1M
         Wm549nUmBKndLk0bPJS5HEGH+S0Q0nUQiX+V+cu7p/q23arChbRfM+jOhXe1f87LCNdU
         06j1VJ1Zj+PyxUI1oG0XciWyJ47LNo9wIumX2HaNj6Z+tb0QQb1tNVaRgX1cXe6CJjmU
         zn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690922731; x=1691527531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/xrXCgNmimlEpmVkNg4fSgJT+KBh0CxQ02eEsxeKYQ=;
        b=NK6LpDzHma2sVu0dvo3e9pEnm+K3vyjevAe3d9XPbqgoPLjOjA9cIVhKj0iXS+7fiL
         VRChGxZXjDA81dBbP9DBZl250WqW64FbfofBSvPcsQg2WxFsV7ZDw3NOfo6L7vrRXrnx
         V+rh7IWCBPB02ZH5rbgdi+LpuaPSGNNnBnJKc6KSgzdTCE1FSblzVOgWwjcW5cxnd0Oc
         LgIeTa1TDfVw0wj8AMQNhOq/Ac0HWTpVjVxigx2L/imC7IDAaRIFqcYm39jCt6Kcg+gA
         j0gPPDnJM/hcVc0/xF3Wio6bilBvDIcyN+AA2+AW/wJpXPsTYxOvUMTfpHicThCKioDK
         n0Fw==
X-Gm-Message-State: ABy/qLY7xB19+HIKOSGd8z32X+UyfERKyqnOc1nmIgs9840pt+a43hL1
        blRuH5dc/MamqgwtY6C1eG4fraODPGTMIelPdqti1s+tm6o=
X-Google-Smtp-Source: APBJJlFzBEQC3TrhJx2zTifZ4sowarcwSXKlWWCG7BdQw3U0fpzTFc+9s1SdDEGnZTy2Bh8PXbSpXrGNvXWXeMITvKw=
X-Received: by 2002:a05:6870:392c:b0:1b0:454b:1c3d with SMTP id
 b44-20020a056870392c00b001b0454b1c3dmr14486952oap.36.1690922730528; Tue, 01
 Aug 2023 13:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230801203839.9502-1-aboutphysycs@gmail.com>
In-Reply-To: <20230801203839.9502-1-aboutphysycs@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 1 Aug 2023 23:44:54 +0300
Message-ID: <CAHp75VcnTNAs3=-LduYrV6JJXOm2fLU0c0tovoWAJ+mPZXHF-g@mail.gmail.com>
Subject: Re: [PATCH] gpio: tqmx86: remove unneeded call to platform_set_drvdata()
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        andy@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
        Alexandru Ardelean <alex@shruggie.ro>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 11:43=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail.=
com> wrote:
>
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Als=
o,
> the private data is defined in this driver, so there is no risk of it bei=
ng
> accessed outside of this driver file.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko
