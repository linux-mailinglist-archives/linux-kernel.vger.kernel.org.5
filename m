Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104B2774A8D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjHHUbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjHHUbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:31:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725B044F40;
        Tue,  8 Aug 2023 09:46:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D341623E7;
        Tue,  8 Aug 2023 04:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393F5C433C8;
        Tue,  8 Aug 2023 04:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691470569;
        bh=ELUfEuvS0j0li9IwceiGdgjft+KJVK1MZXLiEqWDXgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tOLjsR8EoLIrFIkrhqY+hMx2irKxdw3xXoiBl8ZTHwejVBTh13wWBuAFxjtCiOxkv
         NyzK3gV6wML/xQAxvyzP3pAI14lV13JPbBVPR4kxFBhhf1GFadlSkNvgEdZ4vKVhvX
         fxYOlrCsxgQnHQwDJuVu2nocarwz6dSOgVR6FCNg=
Date:   Tue, 8 Aug 2023 06:56:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Luke Lu <luke.lu@libre.computer>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Da Xue <da@libre.computer>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: meson-g12a: do post init to fix broken usb
 after resumption
Message-ID: <2023080851-duh-scroll-09bf@gregkh>
References: <20230808032510.31754-1-luke.lu@libre.computer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808032510.31754-1-luke.lu@libre.computer>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 03:25:10AM +0000, Luke Lu wrote:
> Device connected to usb otg port of GXL-based boards can not be
> recognised after resumption, doesn't recover even if disconnect and
> reconnect the device. dmesg shows it disconnects during resumption.
> 
> [   41.492911] usb 1-2: USB disconnect, device number 3
> [   41.499346] usb 1-2: unregistering device
> [   41.511939] usb 1-2: unregistering interface 1-2:1.0
> 
> Calling usb_post_init() will fix this issue, and it's tested and
> verified on libretech's aml-s905x-cc board.
> 
> Signed-off-by: Luke Lu <luke.lu@libre.computer>

What commit id does this fix?  Should it also go to stable kernels?

thanks,

greg k-h
