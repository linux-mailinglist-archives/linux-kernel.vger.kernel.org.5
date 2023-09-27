Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520247B0923
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjI0PqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjI0PqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:46:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E45272A8;
        Wed, 27 Sep 2023 08:46:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BF3C4339A;
        Wed, 27 Sep 2023 15:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695829572;
        bh=3FrmzdhTjw5LrzQOkp7joeY5gnZ08aQFmDto0Xk2RDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jdg7Mxy7D4jA3i/D43lRGIJqPBosdIidu+hvsXP+OFbf9RJUra9kj9VAaMLtfVDvi
         TuqLRrSNTNOxsuIqgQEGQ5UTKdkx+hQ1wfba6lvehEnem1vjSaVZWhwhxCct6RgvZT
         Q+mAjxijzvfVYio8cGhCNgDjKCPl6uDErTNJjvxE=
Date:   Wed, 27 Sep 2023 17:46:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Wesley Cheng <quic_wcheng@quicinc.com>, mathias.nyman@intel.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, srinivas.kandagatla@linaro.org,
        bgoswami@quicinc.com, Thinh.Nguyen@synopsys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 00/33] Introduce QC USB SND audio offloading support
Message-ID: <2023092752-hardcover-surviving-b9d1@gregkh>
References: <20230921214843.18450-1-quic_wcheng@quicinc.com>
 <ZRREZl6XLzyY4K95@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRREZl6XLzyY4K95@finisterre.sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 05:04:06PM +0200, Mark Brown wrote:
> On Thu, Sep 21, 2023 at 02:48:10PM -0700, Wesley Cheng wrote:
> > Several Qualcomm based chipsets can support USB audio offloading to a
> > dedicated audio DSP, which can take over issuing transfers to the USB
> > host controller.  The intention is to reduce the load on the main
> > processors in the SoC, and allow them to be placed into lower power modes.
> 
> I had a few small comments in reply to some of the patches but overall
> the ASoC sides of this look fine to me.  I didn't really look at the USB
> side at all, I'm not sure I understand it enough to have any useful
> thoughts anyway.

Thanks for reviewing those portions, I'll look at the USB bits next week
when I get back from traveling.

greg k-h
