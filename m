Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A620776FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjHJFh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbjHJFh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:37:56 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7BC211E;
        Wed,  9 Aug 2023 22:37:55 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bc512526cso77203566b.1;
        Wed, 09 Aug 2023 22:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1691645874; x=1692250674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lJU5YQvAO9o1YPXgG3GEfP38+VAVljddeHXmD0s3+To=;
        b=SmRBM0pHqxhUxDkuJubeJKc32WakenwHjlOXpgLfV7QrkdP9nlNcb9MPkm9Ct2hU4o
         gjZHPaEt9qN24qQqfNg3451ij21yeDL04zZ31VYVo6PtKVt+Fa4DkDPBJgDHLU+Ci6ZP
         R9XMCuqz6zPwfA3MfKP/SeJmtGPcS27uVuvV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691645874; x=1692250674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJU5YQvAO9o1YPXgG3GEfP38+VAVljddeHXmD0s3+To=;
        b=B4TWsPw2sQ8FQOxU1aBadoWGFqYgYIItGlsXOvPD1alYzWCKJQjkGdJQ0MtwePX7W3
         FCOutYd/t3CNhB2uuO8xI6glgr4RdjFwtngbID2YdGZiEuMcWNj11amQjS1yJBBAHvrT
         UrxfPqeyM8o+j1JctFcmzh/5m6nlPNcoSfAINz8VrHufuOgwkMeC7VIB102GJPyIuOBi
         7QvsiuioHEZ2/GqzzRKo246eFNptia/gJYsVcmdMm6PCNI05RcRuOGoOy3JuydtY6I6Z
         yl2HCeKGWmPwH8kdxKl0yNiqMycTDCFlsay/A8t16LERhixjikh8PcOWbmns/tKsRH8Q
         Ny8A==
X-Gm-Message-State: AOJu0YxR0z4a2xUEzewhNibVGI0ZA4NwtiZZxHxBSFxryeFcbd4t1a2g
        caXqdf6oJzflQZc7VF4AZW0BiIFiKybWo7TdC8JBr/lH
X-Google-Smtp-Source: AGHT+IGrfL4fOH5vFONn/79nJI0W1AWuAqGCJbUK3J56DaMcGhdU/Nz5GNJsgwxztB1ohi2x1a8/HmAZijuqz5dhH/o=
X-Received: by 2002:a17:907:2c59:b0:99c:c6b7:65e4 with SMTP id
 hf25-20020a1709072c5900b0099cc6b765e4mr886404ejc.77.1691645873918; Wed, 09
 Aug 2023 22:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230803230324.731268-1-rentao.bupt@gmail.com>
 <CACPK8XcFL7kM1yaA0+ZRSt27a0yreO+AH5cXtSk1TyjqyjH1WA@mail.gmail.com> <ZNR21UVdfxlvpZAt@taoren-fedora-PC23YAB4>
In-Reply-To: <ZNR21UVdfxlvpZAt@taoren-fedora-PC23YAB4>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 10 Aug 2023 05:37:41 +0000
Message-ID: <CACPK8Xd7LpMuVC63PSfcLmXf4wRThMNRYr9vRxZh246+-DUFFA@mail.gmail.com>
Subject: Re: [PATCH 0/3] ARM: dts: aspeed: Fixup Wedge400 dts
To:     Tao Ren <rentao.bupt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        taoren@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_CSS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 at 05:34, Tao Ren <rentao.bupt@gmail.com> wrote:
>
> Hi Joel,
>
> On Wed, Aug 09, 2023 at 08:08:12AM +0000, Joel Stanley wrote:
> > On Thu, 3 Aug 2023 at 23:03, <rentao.bupt@gmail.com> wrote:
> > >
> > > From: Tao Ren <rentao.bupt@gmail.com>
> > >
> > > The patch series fixes a few entries in wedge400 device tree.
> > >
> > > Patch #1 sets spi alias in ast2500-facebook-netbmc-common.dtsi (included
> > > by wedge400 dts) to make sure spi bus is consistent with flash labels in
> > > flash layout.
> > >
> > > Patch #2 enables more ADC channels in wedge400 dts.
> > >
> > > Patch #3 sets eMMC max frequency to 25MHz in wedge400 dts.
> > >
> > > Tao Ren (3):
> > >   ARM: dts: aspeed: Update spi alias in Facebook AST2500 Common dtsi
> >
> > I wondered if we should do this in the aspeed-g5.dtsi.
>
> I also hesitated if I should do it in aspeed-g5.dtsi, but I didn't do it
> because I was not sure if others care about the spi aliases.. Should I
> send out v2 to move the alias to aspeed-g5.dtsi?

I wasn't sure either. Lets leave it as-is, but if we see other systems
wanting similar numbering then we can put it in the common dtsi.

I've applied this to the aspeed tree now.

Cheers,

Joel
