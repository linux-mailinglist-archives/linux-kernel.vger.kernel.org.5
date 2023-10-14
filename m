Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581F67C94A9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 14:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbjJNMzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 08:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbjJNMzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 08:55:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC99BC9;
        Sat, 14 Oct 2023 05:55:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE83CC433C8;
        Sat, 14 Oct 2023 12:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697288149;
        bh=/lc79HEJR074zhVDTlVtO5LTAdeKCDnQSo7gS31fcjI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qqlHHKcZdLhDWJxm1NuBxTdlUHaRSnSFIQ9q9zq2ruckPGylkmaqyiwGCrABL8ZDD
         wG28TjhOuHnmxpxA/zVViVAUEszi7bowEF7Cv+/uMb/CeX058kWlP/IoAKVey1sPMw
         f8LCbxOA87yEDB3oG+OCXrFqHX0t/czr8Ped69mOc6KVFwBDyoOkZZMbrFX+3/dsyD
         5hm70g5fwMKqfu3Oi6MHL2byDyzyBlgced5vuCRWzEawk5zGpn6WpgXKfqiUu0fI0G
         zcg0rNOw3/jXf+mKheaNjICNCZtVy+65YstJJgQpwxEhwWN5Pabp9KXzCurLqLdg6Y
         XQThwD9L6oYUw==
Date:   Sat, 14 Oct 2023 13:56:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Martin Kepplinger <martink@posteo.de>, lorenzo@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        kernel@puri.sm, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: imu: st,lsm6dsx: add mount-matrix
 property
Message-ID: <20231014135603.4f4a632c@jic23-huawei>
In-Reply-To: <20231013-violin-craziness-f63d75ce0116@spud>
References: <20231012142041.253332-1-martink@posteo.de>
        <20231013-violin-craziness-f63d75ce0116@spud>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 16:19:54 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Thu, Oct 12, 2023 at 02:20:41PM +0000, Martin Kepplinger wrote:
> > Add the mount-matrix optional property to the binding since it's supported
> > and very useful when using the chip on a board.
> > 
> > Signed-off-by: Martin Kepplinger <martink@posteo.de>  
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Thanks,
> Cnor.
> 
> > ---
> > 
> > revision history
> > ----------------
> > v2: (thanks Jonathan)
> > * remove the addition to the example to avoid unrelated discussions :)
:)

Applied

> > 
> > v1:
> > https://lore.kernel.org/linux-devicetree/20230721103410.575555-1-martink@posteo.de/
> > 
> > 
> >  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > index ee8724ad33ab..28b667a9cb76 100644
> > --- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > +++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > @@ -93,6 +93,9 @@ properties:
> >    wakeup-source:
> >      $ref: /schemas/types.yaml#/definitions/flag
> >  
> > +  mount-matrix:
> > +    description: an optional 3x3 mounting rotation matrix
> > +
> >  required:
> >    - compatible
> >    - reg
> > -- 
> > 2.39.2
> >   

