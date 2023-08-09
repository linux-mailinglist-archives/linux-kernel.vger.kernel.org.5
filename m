Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BD877548F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjHIH6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjHIH6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:58:14 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7225D1736;
        Wed,  9 Aug 2023 00:58:13 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bf1f632b8so964921766b.1;
        Wed, 09 Aug 2023 00:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1691567892; x=1692172692;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mCzvBzTrlHkzgB4rDNOHs5YbdPnAQiQODASU6t0JpQM=;
        b=SPx2/fgd4dW/YAodUdHVo5RtkIuOhPu7PXdOaQG62Hkgh6QDYvbteGRhDVz7LnuK7n
         Dj4as5jPGshBDpZ6hVV9nR3760vx6ScAxjr3QEtFMU7C+ZFuqRedD09NU1Izp9bgst3J
         USrIyjshdw7vLDdRfpSJ5ELTp3y+wXGnrutsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691567892; x=1692172692;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCzvBzTrlHkzgB4rDNOHs5YbdPnAQiQODASU6t0JpQM=;
        b=B6B/ckBjeelPIa8BwK2W+2Zr+Cqc7HO4v+AyG9I/jSxNeonVryJrge0+nDKbG7HLiZ
         m6clZklYo1oNQl0CpG1ItlRChBxoOMEwyijDRKWDQo57OGb32IHTLtWs+KOKOdYds8f3
         e/vVFhCYQ4+ttACqyYFGCrP0UqnEFvZpQL9HakD0XzL4cV+ZvdE3M0xlYCpJMBtsnYNs
         li1q5kwn4sulgQb89yvmh9vhfyBS3xxuN88zH0/OvKhb9M2G+dOb6WBfGFMuYEzHISlf
         TsEcdf0T2GM0eBIShINZ7hS8Gktz/xGtpWrIudsPcOA0nMg84s4NXLNWRwKDAKwCvNb0
         rKlg==
X-Gm-Message-State: AOJu0YwTOUbO6NFdwrN/k0jY3UpJAFTOsCorrLv3/LQsyy8/QVUzX0RB
        4UC7gAZMINoaFFnzE16ilVuVh8xcCBJcCyT0LPY=
X-Google-Smtp-Source: AGHT+IEGiWmAGIEV0ge92ajbx7vskLhUypRVof27X3UwEts3AgW0zvsQIP6XXcL4dDeSC6NmymrtLNvgxDSgz5vuYY0=
X-Received: by 2002:a17:906:5a49:b0:99c:281:9987 with SMTP id
 my9-20020a1709065a4900b0099c02819987mr1474418ejc.36.1691567891675; Wed, 09
 Aug 2023 00:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230711095101.6277674b@canb.auug.org.au> <20230720104019.11dee2b2@canb.auug.org.au>
 <20230802100618.3cbf4712@canb.auug.org.au>
In-Reply-To: <20230802100618.3cbf4712@canb.auug.org.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 9 Aug 2023 07:57:58 +0000
Message-ID: <CACPK8XfsVMQEXz3fCFnbii1EbJ_Ev99qjKjXbuLR6nY1BHh4mA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the aspeed tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Eddie James <eajames@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED,URIBL_CSS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2023 at 00:06, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > Presumably introduced by commit
> > >
> > >   267c95dc9f80 ("ARM: dts: aspeed: bonnell: Add DIMM SPD")
> >
> > I am still getting those warnings.
>
> Any progress with this?

I've pushed some changes that should resolve this.

Cheers,

Joel
