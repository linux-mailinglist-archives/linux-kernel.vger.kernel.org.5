Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29567BB070
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 05:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjJFDOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 23:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjJFDOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 23:14:46 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190F3D6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 20:14:44 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50308217223so2049172e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 20:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696562082; x=1697166882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9d8YucWYRdks50PJ3AO/4iP8wds+F1vsf/WqvVgXf9A=;
        b=NbqoW4n48cqMIiQu3L1yIoecjoZnwYeF3GL76ak5UvaCIfuSsKSy4fyENbsrujdhyp
         eNgoFQRuI3SWSLvFQtk9NDwlvupyYFUKHXBxSF21q2SPu0hhde8IUssYqhTPVG6PwLIN
         tELrkW8StDYGoSrB9g7BwSc8x9hkfkUedrYJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696562082; x=1697166882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9d8YucWYRdks50PJ3AO/4iP8wds+F1vsf/WqvVgXf9A=;
        b=KGOsbCV548mz0izd9YU2JrkQdSBzb6yUG+wluSSxmtWCjSR6JSboQ7kyTcdh67VSbc
         tEaxMcOJ9kkPHtWyEVPmiZcrwrggmQXx5pey9H1yKSNZ59Hfm94vDCg8L5GNs3O6bXAm
         TbQOs/b1Tyydm6jrBOl0IrC1PUnrPeawD7d2t4HNJ8AKlVAAT4ULogNflre1srDNwmUN
         K+dnileiyf2YvVG0qwCwGNM//X7iz4rMuI3YKOPCRpq7XLoPhK9QLM3uLNh2QB5YyNi4
         Bc9j/fEsdARa+Ttp7VkFS6CNWB3yyVzIpLAICCezBsPE/2dCLK9xjfQaOo7GHz1n/mbZ
         xQhA==
X-Gm-Message-State: AOJu0Yy8NgE4Z7vBOOD4lhUfaLKYu1hwaGFvNYs94PNilXwAVMtFUkG4
        No+8mmeuMrkmEv9JbzB9YzOx3sYLjlh8uU+0akuIw7Yub5iKQ6Bu
X-Google-Smtp-Source: AGHT+IG6oEIiSjqmR75Y19FZq4C58Sj+ydK0AHtmfB75JNsgXpugv208s8JaBxDrcniI2I80JC+hyLHWlK9z6LIrmQc=
X-Received: by 2002:ac2:4a65:0:b0:500:c2d7:3ab4 with SMTP id
 q5-20020ac24a65000000b00500c2d73ab4mr5754286lfp.8.1696562082174; Thu, 05 Oct
 2023 20:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231005151150.355536-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231005151150.355536-1-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 6 Oct 2023 11:14:31 +0800
Message-ID: <CAGXv+5Ehu6XiFQQhLaaO91N7Xse_ANxLCAwqVAMvy7UST-Q=7Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186: Change gpu speedbin nvmem
 cell name
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 11:12=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> MT8186's GPU speedbin value must be interpreted, or the value will not
> be meaningful.
> Use the correct "gpu-speedbin" nvmem cell name for the GPU speedbin to
> allow triggering the cell info fixup handler, hence feeding the right
> speedbin number to the users.
>
> Fixes: 263d2fd02afc ("arm64: dts: mediatek: mt8186: Add GPU speed bin NVM=
EM cells")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
