Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196F87B26D9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 22:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjI1Uvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 16:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjI1Uvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:51:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEE7180;
        Thu, 28 Sep 2023 13:51:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA49C433C9;
        Thu, 28 Sep 2023 20:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695934303;
        bh=+cexd9xmPLNbQCGnjBv9HJvEF+QQ1Nd1d5VSzHVzH18=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A809uqZtFChSXtY0mrvblI9e56lh7EgcS/8DcHrR/960mCdscUPNE2FqO5VuwPnGs
         PtjDtCDBGTI8NC5q944brmyVDbDxTJwoeR0j2fNQ7ipy2jR9tsXZgnLn7GtaQj0jD0
         V3Us1JN08pAjwlxjxeUyoEtuD8e52Q/E7fhaODLpj5pf+UNpEnKOCnOXKq5+LDjYVA
         YGX0ejDXUhE7CEn7sjNz47r1DcYO+r1vYNqCEBjGE1LzzH0Xz19u0irX7sjx9TCTPL
         VOOuCrQiZ9l+BmdHkRjSS+VgrQv4bKjd3ffzWls/O0ryQilFpISeB2WEvlfyFodOT6
         nAMBXO3Fx0zOA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-503065c4b25so21142088e87.1;
        Thu, 28 Sep 2023 13:51:43 -0700 (PDT)
X-Gm-Message-State: AOJu0YzfltNRp1MjCuPtYhsJMqCH3cfAxvQJ8xo7+cXLqu6zdaiQSP4N
        MA4SNldPkqu4SouR1/caU8R0qEmFGYT9BU+D6A==
X-Google-Smtp-Source: AGHT+IHQjuWrzI/HJv/GQJ62u9AtMtab4xl4POez9pkIVKXQVDmkWjOO+IdPZzcbrwWIwZANLwwNhMl4ZrVYdeEIVfk=
X-Received: by 2002:a05:6512:ba7:b0:4fe:db6:cb41 with SMTP id
 b39-20020a0565120ba700b004fe0db6cb41mr2673606lfv.39.1695934302090; Thu, 28
 Sep 2023 13:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230926164513.101958-1-robh@kernel.org> <ZRXUhSqHPt9R5Zd8@p14s>
In-Reply-To: <ZRXUhSqHPt9R5Zd8@p14s>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 28 Sep 2023 15:51:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ=rR07tQ8PgdcVRTFkbx=y5Qh1ok0JY+WPeBi7hF7E1Q@mail.gmail.com>
Message-ID: <CAL_JsqJ=rR07tQ8PgdcVRTFkbx=y5Qh1ok0JY+WPeBi7hF7E1Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: remoteproc: mtk,scp: Add missing
 additionalProperties on child node schemas
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
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

On Thu, Sep 28, 2023 at 2:31=E2=80=AFPM Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> Hi Rob,
>
> On Tue, Sep 26, 2023 at 11:45:08AM -0500, Rob Herring wrote:
> > Just as unevaluatedProperties or additionalProperties are required at
> > the top level of schemas, they should (and will) also be required for
> > child node schemas. That ensures only documented properties are
> > present for any node.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml =
b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> > index 895415772d1d..24422fd56e83 100644
> > --- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> > +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> > @@ -91,6 +91,7 @@ allOf:
> >
> >  additionalProperties:
> >    type: object
> > +  additionalProperties: false
>
> Things have changed in the remoteproc tree [1] and this patch doesn't app=
ly.
> Please see if it is still needed.

It is not needed any more.

Thanks,
Rob
