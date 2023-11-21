Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6413C7F3195
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbjKUOuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbjKUOuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:50:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EEFA4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:49:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A6BC433C7;
        Tue, 21 Nov 2023 14:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700578197;
        bh=Shfyuu0LFsaf0x/cFRvoygir7hUWkkISScjKC4pM99A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MYHPBhcHtJuX25LjmDot7pPB+yBE2zIPDpiRlDCMhEyllkk8ozP5QcOG1AQlpPI2t
         9NS3Q8m7Go7FgJkh8Fc4wkzatxFVLaGV2Tdg8R6DGhwinsqEqb7UNC0x3LEWSa6mE1
         +4GQyEO2UbAzb+HrFZuIM/CEeDRbUCQkqlF9fSlI=
Date:   Tue, 21 Nov 2023 14:58:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Akash Kumar <quic_akakum@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jing Leng <jleng@ambarella.com>,
        Felipe Balbi <balbi@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pratham =?iso-8859-1?Q?Pratap=A0?= <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: uvc: Add framebased frame format support
Message-ID: <2023112123-setting-waking-7896@gregkh>
References: <20231114112516.2723-1-quic_akakum@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114112516.2723-1-quic_akakum@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 04:55:16PM +0530, Akash Kumar wrote:
> Add support for framebased frame format which can be used to support
> multiple formats like H264 or H265 other than mjpeg and YUV frames.
> 
> Framebased format is set to H264 by default, which can be updated to
> other formats by updating the GUID through guid configfs attribute.
> 
> Also,add UVC 1.5 extension to support H264 format and different camera
> controls, adding support for Exposure, Zoom, Pan, tilt.

When you say "also" or list different things that are done in a single
change, that's a huge hint to divide this up into smaller patches and
make it a patch series.

Please do that here.

thanks,

greg k-h
