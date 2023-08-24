Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777A4786E18
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238145AbjHXLiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241089AbjHXLhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:37:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED2D1989;
        Thu, 24 Aug 2023 04:37:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5638864CE8;
        Thu, 24 Aug 2023 11:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37845C433C8;
        Thu, 24 Aug 2023 11:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692877052;
        bh=gQQO8+W0iPNHyhHVuXHhRpBxxoXJMSUX9SaWcgjfdDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n0M56WddNEdpzp4NnpU7uDhm5ba/lb5zmiJ+WMFaWc9Y4KbBLHk3hldlK+ATVL0UY
         ea8JlBQq9n8FuKKLieH2AzQMAD5zTKalztLC7k0B0lydK/Njtl6X8zCJvghs5t9T5a
         7fM2iIvLLodqifcRTO7fYr77wAdoV4vAOZsSyEDE=
Date:   Thu, 24 Aug 2023 13:37:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jack Zhu <jack.zhu@starfivetech.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, bryan.odonoghue@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-staging@lists.linux.dev,
        changhuang.liang@starfivetech.com
Subject: Re: [PATCH v8 0/8] Add StarFive Camera Subsystem driver
Message-ID: <2023082436-spendable-reshuffle-878d@gregkh>
References: <20230824080109.89613-1-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824080109.89613-1-jack.zhu@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 04:01:01PM +0800, Jack Zhu wrote:
> Hi,
> 
> This series is the v8 series that attempts to support the Camera Subsystem
> found on StarFive JH7110 SoC.

I don't see anything here about why this is in drivers/staging/media/
now and not just in drivers/media/.  What is preventing this to be put
into the correct place to start with?  What needs to be done to the code
to get it out of drivers/staging/media/ and who is going to do that
work?

thanks,

greg k-h
