Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0C67C6D80
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378741AbjJLL5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378954AbjJLL5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:57:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46724480
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 04:53:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA60C433CA;
        Thu, 12 Oct 2023 11:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697111606;
        bh=XfvMmvJdTaMZMG3N1c9TZP8HCU2GkB8oEwA4gts662M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N++DBattEnKEgH4U30y7XWUjy9uwbhsnZjUHqSmoNch7aCC5k2R8GEkUT8DcofRSy
         PoLYxz6KXYe2M2TAlUDRdcIap1w0y02RIiJQXTLzxFb5HGDiivpoa2mAaZKl012GPh
         kob3hqVON1E5X115gmKekeO2RKT4MCpzU/HiJBTnlRE8M8JPevYFlpxO7IGmGPRSZb
         3N40Akdj9Nz5dDIFzwhW7HP8MBk1rFJdb4a7cdiehLH+QLYOc9XLD0D4e6EWJs91p/
         ywNU4/yYAVywLVLDJUQ/fVEYCUnpWXS9ZHZRnhcMD9UWKSRTGeBzrGtlj7JuhB8rAF
         9wwKvHzltImdQ==
Received: (nullmailer pid 286509 invoked by uid 1000);
        Thu, 12 Oct 2023 11:53:24 -0000
Date:   Thu, 12 Oct 2023 06:53:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Conor Dooley <conor@kernel.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 6/6] dt-bindings: display: Add SSD132x OLED controllers
Message-ID: <20231012115324.GB266951-robh@kernel.org>
References: <20231012065822.1007930-1-javierm@redhat.com>
 <20231012065822.1007930-7-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012065822.1007930-7-javierm@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 08:58:15AM +0200, Javier Martinez Canillas wrote:
> Add a Device Tree binding schema for the OLED panels based on the Solomon
> SSD132x family of controllers.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
> Changes in v2:
> - Remove unnecessary 'oneOf' in the SSD132x DT binding schema (Conor Dooley).
> - Remove unused DT nodes labels in the binding schema examples (Conor Dooley).
> - Split out common Solomon properties into a separate schema (Rob Herring).
> 
>  .../bindings/display/solomon,ssd132x.yaml     | 89 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  2 files changed, 90 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd132x.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
